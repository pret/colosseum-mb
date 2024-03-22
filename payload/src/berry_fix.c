#include "global.h"
#include "siirtc.h"
#include "berry_fix.h"
#include "constants/vars.h"
#include "gflib/characters.h"

// States for the main BerryFix function
enum {
    STATE_INIT,
    STATE_CHECK_RTC,
    STATE_CHECK_FLASH,
    STATE_READ_SAVE,
    STATE_CHECK_TIME,
    STATE_FIX_DATE,
    STATE_NO_NEED_TO_FIX,
    STATE_ERROR_YEAR,
    STATE_FINISHED,
    STATE_CHECK_PACIFIDLOG_TM,
    STATE_FIX_PACIFIDLOG_TM,
    STATE_ERROR
};

// Return values for ValidateRomHeader
enum
{
    UPDATE_SAPPHIRE = 2,
    UPDATE_RUBY,
    NO_UPDATE_SAPPHIRE,
    NO_UPDATE_RUBY,
    INVALID
};

u32 gUpdateSuccessful;
u32 gGameVersion;
struct Time gTimeSinceBerryUpdate;
struct Time gRtcUTCTime;
u32 gUnusedWord;

static u32 sNeverRead; // sInitialWaitTimer in Berry Fix
static struct SiiRtcInfo sRtcInfoWork;
static u32 padding_2021394;
static u16 sErrorStatus;
static u32 padding_202139C;
static struct SiiRtcInfo sRtcInfoBuffer;
static u8 sRtcProbeCode;
static u16 sImeBak;

extern bool32 WriteSaveBlockChunks(void);

static bool32 BerryFix_TryInitRtc(void);
static bool32 BerryFix_CalcTimeDifference(u8 * year);
static void BerryFix_TryFixDate(void);
static bool32 BerryFix_IsPacifidlogTMCorrect(void);
static bool32 BerryFix_ResetPacifidlogTM(void);
static void RtcInit(void);
static u16 RtcGetErrorStatus(void);
static void RtcGetRawInfo(struct SiiRtcInfo * rtc);
static s32 ConvertBcdToBinary(u8 bcd);
static void RtcCalcTimeDifference(struct SiiRtcInfo * rtc, struct Time * result, struct Time * t);
static void CalcTimeDifference(struct Time * result, struct Time * t1, struct Time * t2);
static void RtcDisableInterrupts(void);
static void RtcRestoreInterrupts(void);
static bool8 IsLeapYear(u8 year);
static u16 RtcCheckInfo(struct SiiRtcInfo * rtc);

// Language character code, followed by version number
static const char sVersionData[][2] = {
    {'J', 1},
    {'E', 2},
    {'D', 1},
    {'F', 1},
    {'I', 1},
    {'S', 1}
};

static const u8 sRubyTitleAndCode[16] = "POKEMON RUBYAXV";
static const u8 sSapphireTitleAndCode[16] = "POKEMON SAPPAXP";

static bool32 CheckSameString(const u8 * data1, const u8 * data2, u32 size)
{
    u32 i;

    for (i = 0; i < size; i++)
    {
        if (data1[i] != data2[i])
        {
            return FALSE;
        }
    }

    return TRUE;
}

static u32 ValidateGameVersion(void)
{
    s32 i;
    s32 shouldUpdate;
    s32 languageCode;
    s32 version;

    languageCode = *(const u8 *)0x080000AF; // gRomHeader.gameCode[3]
    version = *(const u8 *)0x080000BC; // gRomHeader.revision
    shouldUpdate  = -1;

    for (i = 0; i < ARRAY_COUNT(sVersionData); i++)
    {
        if (languageCode != sVersionData[i][0])
        {
            continue;
        }

        if (version >= sVersionData[i][1])
        {
            shouldUpdate = FALSE;
        }
        else
        {
            shouldUpdate = TRUE;
        }

        break;
    }

    if (shouldUpdate == -1)
    {
        return INVALID;
    }

    // A valid language/revision was found, check game title
    // and code to see if it's Ruby or Sapphire

    if (CheckSameString((const u8 *)0x080000A0, sRubyTitleAndCode, 15) == TRUE) // gRomHeader.gameTitle
    {
        if (shouldUpdate == FALSE)
        {
            return NO_UPDATE_RUBY;
        }
        else
        {
            gGameVersion = VERSION_RUBY;
            return UPDATE_RUBY;
        }
    }

    if (CheckSameString((const u8 *)0x080000A0, sSapphireTitleAndCode, 15) == TRUE) // gRomHeader.gameTitle
    {
        if (shouldUpdate == FALSE)
        {
            return NO_UPDATE_SAPPHIRE;
        }
        else
        {
            gGameVersion = VERSION_SAPPHIRE;
            return UPDATE_SAPPHIRE;
        }
    }

    return INVALID;
}

s32 ValidateRomHeader(void)
{
    if (*(u8 *)0x080000B0 != '0') // gRomHeader.gameCode[4]
        return 6;

    if (*(u8 *)0x080000B1 != '1') // gRomHeader.gameCode[5]
        return 6;

    if (*(u8 *)0x080000B2 != 0x96) // gRomHeader.gameCode[6]
        return 6;

    return ValidateGameVersion();
}

void BerryFix(u32 * state, void * unused1, u32 unused2)
{
    u8 year;
    u32 validationResult;

    switch (*state)
    {
    case STATE_INIT:
        sNeverRead = 0;
        gUpdateSuccessful = 0;
        validationResult = ValidateRomHeader();

        switch (validationResult)
        {
        case INVALID:
            *state = STATE_ERROR;
            break;
        case NO_UPDATE_SAPPHIRE:
        case NO_UPDATE_RUBY:
            *state = STATE_NO_NEED_TO_FIX;
            break;
        case UPDATE_SAPPHIRE:
        case UPDATE_RUBY:
            (*state)++;
            break;
        }
        break;
    case STATE_CHECK_RTC:
        if (!BerryFix_TryInitRtc())
        {
            *state = STATE_ERROR;
        }
        else
        {
            (*state)++;
        }
        break;
    case STATE_CHECK_FLASH:
        (*state)++;
        break;
    case STATE_READ_SAVE:
        (*state)++;
        break;
    case STATE_CHECK_TIME:
        if (BerryFix_CalcTimeDifference(&year) == TRUE)
        {
            // Time difference is okay, only fix the date if
            // the Berry Glitch hasn't happened yet (if year is 2000)
            if (year == 0)
            {
                (*state)++;
            }
            else
            {
                *state = STATE_CHECK_PACIFIDLOG_TM;
            }
        }
        else
        {
            // Time difference is incorrect, if the year is 2001
            // then the Berry Glitch is occurring. If the year is
            // not 2001 then some error has occurred.
            if (year != 1)
            {
                *state = STATE_ERROR_YEAR;
            }
            else
            {
                (*state)++;
            }
        }
        break;
    case STATE_FIX_DATE:
        // Set the clock forward to fix the Berry Glitch
        // If the date is late enough that it is no
        // longer affected then this does nothing.
        BerryFix_TryFixDate();
        gUpdateSuccessful |= 1;
        *state = STATE_CHECK_PACIFIDLOG_TM;
        break;
    case STATE_CHECK_PACIFIDLOG_TM:
        if (BerryFix_IsPacifidlogTMCorrect() == TRUE)
        {
            *state = STATE_FINISHED;
        }
        else
        {
            *state = STATE_FIX_PACIFIDLOG_TM;
        }
        break;
    case STATE_FIX_PACIFIDLOG_TM:
        if (BerryFix_ResetPacifidlogTM() == TRUE)
        {
            gUpdateSuccessful |= 1;
            *state = STATE_FINISHED;
        }
        else
        {
            *state = STATE_ERROR;
        }
        break;
    case STATE_FINISHED:
        *state = STATE_NO_NEED_TO_FIX;
        break;
    case STATE_NO_NEED_TO_FIX:
        break;
    case STATE_ERROR_YEAR:
        break;
    case STATE_ERROR:
        break;
    }
}

static bool32 BerryFix_TryInitRtc(void)
{
    RtcInit();

    if (RtcGetErrorStatus() & RTC_ERR_FLAG_MASK)
        return FALSE;
    else
        return TRUE;
}

static void RtcSetDateTime(struct SiiRtcInfo *rtc)
{
    vu16 imeBak = REG_IME;
    REG_IME = 0;
    SiiRtcSetDateTime(rtc);
    REG_IME = imeBak;
}

static bool32 BerryFix_CalcTimeDifference(u8 * year)
{
    s32 minutes;

    RtcGetRawInfo(&sRtcInfoWork);
    *year = ConvertBcdToBinary(sRtcInfoWork.year);
    RtcCalcTimeDifference(&sRtcInfoWork, &gRtcUTCTime, &((struct SaveBlock2 *)gSaveBlock2Ptr)->localTimeOffset);
    CalcTimeDifference(&gTimeSinceBerryUpdate, &((struct SaveBlock2 *)gSaveBlock2Ptr)->lastBerryTreeUpdate, &gRtcUTCTime);
    minutes = gTimeSinceBerryUpdate.days * 1440 + gTimeSinceBerryUpdate.hours * 60 + gTimeSinceBerryUpdate.minutes;

    if (minutes >= 0)
        return TRUE;
    else
        return FALSE;
}

static u32 ConvertBinaryToBcd(u8 binary)
{
    u32 bcd = 0;

    if (binary > 99)
    {
        return 0xFF;
    }

    bcd  = Div(binary, 10) << 4;
    bcd |= Mod(binary, 10);

    return bcd;
}

static void RtcIncrement(u8 * val)
{
    *val = ConvertBinaryToBcd(ConvertBcdToBinary(*val) + 1);
}

static void RtcIncrementMonth(struct SiiRtcInfo * rtc)
{
    RtcIncrement(&rtc->month);

    if (ConvertBcdToBinary(rtc->month) <= MONTH_DEC)
    {
        return;
    }

    RtcIncrement(&rtc->year);
    rtc->month = MONTH_JAN;
}

const s32 sDaysPerMonth[];

static void RtcIncrementDay(struct SiiRtcInfo * rtc)
{
    RtcIncrement(&rtc->day);

    if (ConvertBcdToBinary(rtc->day) <= sDaysPerMonth[ConvertBcdToBinary(rtc->month) - 1])
    {
        return;
    }

    if (IsLeapYear(ConvertBcdToBinary(rtc->year)) && ConvertBcdToBinary(rtc->month) == MONTH_FEB && ConvertBcdToBinary(rtc->day) == 29)
    {
        return;
    }

    rtc->day = 1;
    RtcIncrementMonth(rtc);
}

static bool32 RtcNeedsLeapDayIncrement(struct SiiRtcInfo * rtc)
{
    if (ConvertBcdToBinary(rtc->year) == 0)
    {
        if (ConvertBcdToBinary(rtc->month) == MONTH_JAN)
            return FALSE;
        if (ConvertBcdToBinary(rtc->month) > MONTH_FEB)
            return TRUE;
        if (ConvertBcdToBinary(rtc->day) == 29)
            return TRUE;
        return FALSE;
    }

    if (ConvertBcdToBinary(rtc->year) == 1)
        return TRUE;

    // After 2001 (shouldn't occur)
    return FALSE;
}

static void BerryFix_TryFixDate(void)
{
    RtcGetRawInfo(&sRtcInfoWork);

    // If the year is anything but 2000 or 2001 then the Berry Glitch has already passed
    if (ConvertBcdToBinary(sRtcInfoWork.year) == 0 || ConvertBcdToBinary(sRtcInfoWork.year) == 1)
    {
        if (ConvertBcdToBinary(sRtcInfoWork.year) == 1)
        {
            // Year is 2001, the Berry Glitch is occurring
            // Set date forward to January 2, 2002
            sRtcInfoWork.year = 2;
            sRtcInfoWork.month = MONTH_JAN;
            sRtcInfoWork.day = 2;
            RtcSetDateTime(&sRtcInfoWork);
        }
        else
        {
            // Year is 2000, the Berry Glitch hasn't begun yet
            // Set the date forward 365/366 days to avoid the glitch
            if (RtcNeedsLeapDayIncrement(&sRtcInfoWork) == TRUE)
            {
                RtcIncrementDay(&sRtcInfoWork);
                RtcIncrement(&sRtcInfoWork.year);
            }
            else
            {
                RtcIncrement(&sRtcInfoWork.year);
            }
            RtcSetDateTime(&sRtcInfoWork);
        }
    }
}

static u8 * PrintBcd(u8 * dest, u8 bcd)
{
    *dest = '0' + ((bcd & 0xF0) >> 4);
    dest++;
    *dest = '0' + ((bcd & 0x0F) >> 0);
    dest++;
    *dest = 0;

    return dest;
}

static u8 * UNUSED PrintRtc(u8 * dest)
{
    if (gGameVersion != VERSION_SAPPHIRE && gGameVersion != VERSION_RUBY)
    {

    }
    else
    {
        RtcGetRawInfo(&sRtcInfoWork);
    }

    dest = PrintBcd(dest, sRtcInfoWork.year);
    *dest++ = ' ';
    dest = PrintBcd(dest, sRtcInfoWork.month);
    *dest++ = ' ';
    dest = PrintBcd(dest, sRtcInfoWork.day);
    *dest++ = ' ';
    dest = PrintBcd(dest, sRtcInfoWork.hour);
    *dest++ = ':';
    dest = PrintBcd(dest, sRtcInfoWork.minute);
    *dest++ = ':';
    dest = PrintBcd(dest, sRtcInfoWork.second);
    *dest++ = CHAR_SPACE;

    return dest;
}

const struct SiiRtcInfo sDefaultRTC = {
    .year = 0, // 2000
    .month = MONTH_JAN,
    .day = 1,
    .dayOfWeek = 0,
    .hour = 0,
    .minute = 0,
    .second = 0,
    .status = 0,
    .alarmHour = 0,
    .alarmMinute = 0
};

static void RtcDisableInterrupts(void)
{
    sImeBak = REG_IME;
    REG_IME = 0;
}

static void RtcRestoreInterrupts(void)
{
    REG_IME = sImeBak;
}

static s32 ConvertBcdToBinary(u8 bcd)
{
    if (bcd >= 0xa0 || (bcd & 0xF) >= 10)
        return 0xFF;

    return ((bcd >> 4) & 0xF) * 10 + (bcd & 0xF);
}

static bool8 IsLeapYear(u8 year)
{
    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0)
        return TRUE;
    else
        return FALSE;
}

const s32 sDaysPerMonth[] = {
    [MONTH_JAN - 1] = 31,
    [MONTH_FEB - 1] = 28,
    [MONTH_MAR - 1] = 31,
    [MONTH_APR - 1] = 30,
    [MONTH_MAY - 1] = 31,
    [MONTH_JUN - 1] = 30,
    [MONTH_JUL - 1] = 31,
    [MONTH_AUG - 1] = 31,
    [MONTH_SEP - 1] = 30,
    [MONTH_OCT - 1] = 31,
    [MONTH_NOV - 1] = 30,
    [MONTH_DEC - 1] = 31
};

static u16 ConvertDateToDayCount(u8 year, u8 month, u8 day)
{
    u16 numDays = 0;
    s32 i;

    for (i = year - 1; i > 0; i--)
    {
        numDays += 365;
        if (IsLeapYear(i) == TRUE)
            numDays++;
    }

    for (i = 0; i < month - 1; i++)
        numDays += sDaysPerMonth[i];

    if (month > MONTH_FEB && IsLeapYear(year) == TRUE)
    {
        numDays = numDays + 1;
    }

    numDays += day;

    return numDays;
}

static u16 RtcGetDayCount(struct SiiRtcInfo *info)
{
    return ConvertDateToDayCount(ConvertBcdToBinary(info->year), ConvertBcdToBinary(info->month), ConvertBcdToBinary(info->day));
}

static void RtcInit(void)
{
    sErrorStatus = 0;
    RtcDisableInterrupts();
    SiiRtcUnprotect();
    sRtcProbeCode = SiiRtcProbe();
    RtcRestoreInterrupts();

    if ((sRtcProbeCode & 0xF) != 1)
    {
        sErrorStatus = RTC_INIT_ERROR;
    }
    else
    {
        if (sRtcProbeCode & 0xF0)
            sErrorStatus = RTC_INIT_WARNING;
        else
            sErrorStatus = 0;

        RtcGetRawInfo(&sRtcInfoBuffer);
        sErrorStatus = RtcCheckInfo(&sRtcInfoBuffer);
    }
}

static u16 RtcGetErrorStatus(void)
{
    return sErrorStatus;
}

static void UNUSED RtcGetInfo(struct SiiRtcInfo * rtc)
{
    if (sErrorStatus & RTC_ERR_FLAG_MASK)
        *rtc = sDefaultRTC;
    else
        RtcGetRawInfo(rtc);
}

static void RtcGetDateTime(struct SiiRtcInfo * rtc)
{
    RtcDisableInterrupts();
    SiiRtcGetDateTime(rtc);
    RtcRestoreInterrupts();
}

static void RtcGetStatus(struct SiiRtcInfo * rtc)
{
    RtcDisableInterrupts();
    SiiRtcGetStatus(rtc);
    RtcRestoreInterrupts();
}

static void RtcGetRawInfo(struct SiiRtcInfo * rtc)
{
    RtcGetStatus(rtc);
    RtcGetDateTime(rtc);
}

static u16 RtcCheckInfo(struct SiiRtcInfo * rtc)
{
    u16 errorFlags;
    s32 year, month, day;

    errorFlags = 0;

    if (rtc->status & SIIRTCINFO_POWER)
        errorFlags |= RTC_ERR_POWER_FAILURE;

    if (!(rtc->status & SIIRTCINFO_24HOUR))
        errorFlags |= RTC_ERR_12HOUR_CLOCK;

    year = ConvertBcdToBinary(rtc->year);

    if (year == 0xFF)
        errorFlags |= RTC_ERR_INVALID_YEAR;

    month = ConvertBcdToBinary(rtc->month);

    if (month == 0xFF || month == 0 || month > MONTH_DEC)
        errorFlags |= RTC_ERR_INVALID_MONTH;

    day = ConvertBcdToBinary(rtc->day);

    if (day == 0xFF)
        errorFlags |= RTC_ERR_INVALID_DAY;

    if (month == MONTH_FEB)
    {
        if (day > IsLeapYear(year) + sDaysPerMonth[MONTH_FEB -1])
            errorFlags |= RTC_ERR_INVALID_DAY;
    }
    else
    {
        if (day > sDaysPerMonth[month - 1])
            errorFlags |= RTC_ERR_INVALID_DAY;
    }

    day = ConvertBcdToBinary(rtc->hour);

    if (day == 0xFF || day > 24)
        errorFlags |= RTC_ERR_INVALID_HOUR;

    day = ConvertBcdToBinary(rtc->minute);

    if (day == 0xFF || day > 60)
        errorFlags |= RTC_ERR_INVALID_MINUTE;

    day = ConvertBcdToBinary(rtc->second);

    if (day == 0xFF || day > 60)
        errorFlags |= RTC_ERR_INVALID_SECOND;

    return errorFlags;
}

static void UNUSED RtcReset(void)
{
    RtcDisableInterrupts();
    SiiRtcReset();
    RtcRestoreInterrupts();
}

static void RtcCalcTimeDifference(struct SiiRtcInfo * rtc, struct Time * result, struct Time * t)
{
    u16 r4 = RtcGetDayCount(rtc);

    result->seconds = ConvertBcdToBinary(rtc->second) - t->seconds;
    result->minutes = ConvertBcdToBinary(rtc->minute) - t->minutes;
    result->hours = ConvertBcdToBinary(rtc->hour) - t->hours;
    result->days = r4 - t->days;

    if (result->seconds < 0)
    {
        result->seconds += 60;
        result->minutes--;
    }

    if (result->minutes < 0)
    {
        result->minutes += 60;
        result->hours--;
    }

    if (result->hours < 0)
    {
        result->hours += 24;
        result->days--;
    }
}

static void CalcTimeDifference(struct Time * result, struct Time * t1, struct Time * t2)
{
    result->seconds = t2->seconds - t1->seconds;
    result->minutes = t2->minutes - t1->minutes;
    result->hours = t2->hours - t1->hours;
    result->days = t2->days - t1->days;

    if (result->seconds < 0)
    {
        result->seconds += 60;
        result->minutes--;
    }

    if (result->minutes < 0)
    {
        result->minutes += 60;
        result->hours--;
    }

    if (result->hours < 0)
    {
        result->hours += 24;
        result->days--;
    }
}

static void UNUSED EmptyFunc1(u8 unused)
{
    return;
}

static void UNUSED EmptyFunc2(void)
{
    return;
}

static void UNUSED EmptyFunc3(void)
{
    return;
}

static u16 * GetVarPointer(u16 id)
{
    if (id < VARS_START)
        return NULL;

    if (id < VAR_SPECIAL_0)
        return &gVarsPtr[id - VARS_START];

    return NULL;
}

static bool32 BerryFix_IsPacifidlogTMCorrect(void)
{
    u8 year;
    u16 * var = GetVarPointer(VAR_PACIFIDLOG_TM_RECEIVED_DAY);

    BerryFix_CalcTimeDifference(&year);

    if (*var <= gRtcUTCTime.days)
        return TRUE;
    else
        return FALSE;
}

static bool32 BerryFix_ResetPacifidlogTM(void)
{
    u16 * var;
    u8 year;

    if (BerryFix_IsPacifidlogTMCorrect() == TRUE)
        return TRUE;

    BerryFix_CalcTimeDifference(&year);

    if (gRtcUTCTime.days < 0)
        return FALSE;

    var = GetVarPointer(VAR_PACIFIDLOG_TM_RECEIVED_DAY);
    *var = 1;

    if (WriteSaveBlockChunks() != TRUE)
        return FALSE;

    return TRUE;
}
