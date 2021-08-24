#include "global.h"
#include "siirtc.h"
#include "constants/vars.h"

u32 gUnknown_0202524C;
u32 gUnknown_02025250;
struct Time gTimeSinceBerryUpdate;
struct Time gRtcUTCTime;
u32 padding_2025270;

static u32 gUnknown_02021380;
static struct SiiRtcInfo sRtcInfoWork;
static u32 padding_2021394;
static u16 sRtcProbeStatus;
static u32 padding_202139C;
static struct SiiRtcInfo sRtcInfoBuffer;
static u8 sRtcProbeCode;
static u16 sImeBak;

bool32 sub_02009EC8(void);

bool32 rtc_maincb_is_rtc_working(void);
bool32 rtc_maincb_is_time_since_last_berry_update_positive(u8 *);
void rtc_maincb_fix_date(void);
bool32 sub_0200F3A0(void);
bool32 sub_0200F3E4(void);
void rtc_probe_status(void);
u16 rtc_get_probe_status(void);
void rtc_get_status_and_datetime(struct SiiRtcInfo * rtc);
s32 bcd_to_hex(u8 year);
void rtc_sub_time_from_datetime(struct SiiRtcInfo * rtc, struct Time * work, struct Time * offset);
void rtc_sub_time_from_time(struct Time * work, struct Time * last, struct Time * result);
void rtc_intr_disable(void);
void rtc_intr_enable(void);
bool8 is_leap_year(u8 year);
u16 rtc_validate_datetime(struct SiiRtcInfo * info);

const u8 gUnknown_0201F298[6][2] = {
    {'J', 1},
    {'E', 2},
    {'D', 1},
    {'F', 1},
    {'I', 1},
    {'S', 1}
};

const char gUnknown_0201F2A4[16] = "POKEMON RUBYAXV";
const char gUnknown_0201F2B4[16] = "POKEMON SAPPAXP";

bool32 memcmp_u8(const char * a0, const char * a1, u32 a2)
{
    u32 i;

    for (i = 0; i < a2; i++)
    {
        if (a0[i] != a1[i])
        {
            return FALSE;
        }
    }

    return TRUE;
}

s32 validate_rom_header_internal(void)
{
    s32 i;
    s32 sp4;
    s32 languageCode;
    s32 version;

    languageCode = *(const u8 *)0x080000AF;
    version = *(const u8 *)0x080000BC;
    sp4 = -1;
    for (i = 0; i < NELEMS(gUnknown_0201F298); i++)
    {
        if (languageCode != gUnknown_0201F298[i][0])
        {
            continue;
        }
        if (version >= gUnknown_0201F298[i][1])
        {
            sp4 = 0;
        }
        else
        {
            sp4 = 1;
        }
        break;
    }
    if (sp4 == -1)
    {
        return 6;
    }
    if (memcmp_u8((const u8 *)0x080000A0, gUnknown_0201F2A4, 15) == TRUE)
    {
        if (sp4 == 0)
        {
            return 5;
        }
        else
        {
            gUnknown_02025250 = 2;
            return 3;
        }
    }
    if (memcmp_u8((const u8 *)0x080000A0, gUnknown_0201F2B4, 15) == TRUE)
    {
        if (sp4 == 0)
        {
            return 4;
        }
        else
        {
            gUnknown_02025250 = 1;
            return 2;
        }
    }

    return 6;
}

s32 validate_rom_header(void)
{
    if (*(u8 *)0x080000B0 != '0')
        return 6;
    
    if (*(u8 *)0x080000B1 != '1')
        return 6;
    
    if (*(u8 *)0x080000B2 != 0x96)
        return 6;
    
    return validate_rom_header_internal();
}

void main_callback(u32 * pstate, u8 * buffer, u32 unk2)
{
    u8 sp0C;
    int sp10;
    switch (*pstate)
    {
    case 0:
        gUnknown_02021380 = 0;
        gUnknown_0202524C = 0;
        sp10 = validate_rom_header();
        switch (sp10)
        {
        case 6:
            *pstate = 11;
            break;
        case 5:
        case 4:
            *pstate = 6;
            break;
        case 3:
        case 2:
            (*pstate)++;
            break;
        }
        break;
    case 1:
        if (rtc_maincb_is_rtc_working() == 0)
        {
            *pstate = 11;
        }
        else
        {
            (*pstate)++;
        }
        break;
    case 2:
        (*pstate)++;
        break;
    case 3:
        (*pstate)++;
        break;
    case 4:
        if (rtc_maincb_is_time_since_last_berry_update_positive(&sp0C) == 1)
        {
            if (sp0C == 0)
            {
                (*pstate)++;
            }
            else
            {
                *pstate = 9;
            }
        }
        else
        {
            if (sp0C != 1)
            {
                *pstate = 7;
            }
            else
            {
                (*pstate)++;
            }
        }
        break;
    case 5:
        rtc_maincb_fix_date();
        gUnknown_0202524C |= 1;
        *pstate = 9;
        break;
    case 9:
        if (sub_0200F3A0() == 1)
        {
            *pstate = 8;
        }
        else
        {
            *pstate = 10;
        }
        break;
    case 10:
        if (sub_0200F3E4() == 1)
        {
            gUnknown_0202524C |= 1;
            *pstate = 8;
        }
        else
        {
            *pstate = 11;
        }
        break;
    case 8:
        *pstate = 6;
        break;
    case 6:
        break;
    case 7:
        break;
    case 11:
        break;
    }
}

bool32 rtc_maincb_is_rtc_working(void)
{
    rtc_probe_status();
    if (rtc_get_probe_status() & 0xFF0)
        return FALSE;
    else
        return TRUE;
}

void rtc_set_datetime(struct SiiRtcInfo *rtc)
{
    vu16 imeBak;
    imeBak = REG_IME;
    REG_IME = 0;
    SiiRtcSetDateTime(rtc);
    REG_IME = imeBak;
}

bool32 rtc_maincb_is_time_since_last_berry_update_positive(u8 * a0)
{
    s32 sp04;
    rtc_get_status_and_datetime(&sRtcInfoWork);
    *a0 = bcd_to_hex(sRtcInfoWork.year);
    rtc_sub_time_from_datetime(&sRtcInfoWork, &gRtcUTCTime, &gSaveBlock2Ptr->localTimeOffset);
    rtc_sub_time_from_time(&gTimeSinceBerryUpdate, &gSaveBlock2Ptr->lastBerryTreeUpdate, &gRtcUTCTime);
    sp04 = gTimeSinceBerryUpdate.days * 1440 + gTimeSinceBerryUpdate.hours * 60 + gTimeSinceBerryUpdate.minutes;
    if (sp04 >= 0)
        return TRUE;
    else
        return FALSE;
}

s32 hex_to_bcd(u8 a0)
{
    s32 sp4 = 0;
    if (a0 > 99)
    {
        return 0xFF;
    }
    sp4  = Div(a0, 10) << 4;
    sp4 |= Mod(a0, 10);
    return sp4;
}

void sii_rtc_inc(u8 * a0)
{
    *a0 = hex_to_bcd(bcd_to_hex(*a0) + 1);
}

void sii_rtc_inc_month(struct SiiRtcInfo * a0)
{
    sii_rtc_inc(&a0->month);
    if (bcd_to_hex(a0->month) <= MONTH_DEC)
    {
        return;
    }
    sii_rtc_inc(&a0->year);
    a0->month = MONTH_JAN;
}

const s32 sDaysPerMonth[];

void sii_rtc_inc_day(struct SiiRtcInfo * a0)
{
    sii_rtc_inc(&a0->day);
    if (bcd_to_hex(a0->day) <= sDaysPerMonth[bcd_to_hex(a0->month) - 1])
    {
        return;
    }
    if (is_leap_year(bcd_to_hex(a0->year)) && bcd_to_hex(a0->month) == MONTH_FEB && bcd_to_hex(a0->day) == 29)
    {
        return;
    }
    a0->day = 1;
    sii_rtc_inc_month(a0);
}

bool32 rtc_is_past_feb_28_2000(struct SiiRtcInfo * a0)
{
    if (bcd_to_hex(a0->year) == 0)
    {
        if (bcd_to_hex(a0->month) == MONTH_JAN)
            return FALSE;
        if (bcd_to_hex(a0->month) > MONTH_FEB)
            return TRUE;
        if (bcd_to_hex(a0->day) == 29)
            return TRUE;
        return FALSE;
    }
    if (bcd_to_hex(a0->year) == 1)
        return TRUE;
    return FALSE;
}

void rtc_maincb_fix_date(void)
{
    rtc_get_status_and_datetime(&sRtcInfoWork);
    if (bcd_to_hex(sRtcInfoWork.year) == 0 || bcd_to_hex(sRtcInfoWork.year) == 1)
    {
        if (bcd_to_hex(sRtcInfoWork.year) == 1)
        {
            sRtcInfoWork.year = 2;
            sRtcInfoWork.month = MONTH_JAN;
            sRtcInfoWork.day = 2;
            rtc_set_datetime(&sRtcInfoWork);
        }
        else
        {
            if (rtc_is_past_feb_28_2000(&sRtcInfoWork) == TRUE)
            {
                sii_rtc_inc_day(&sRtcInfoWork);
                sii_rtc_inc(&sRtcInfoWork.year);
            }
            else
            {
                sii_rtc_inc(&sRtcInfoWork.year);
            }
            rtc_set_datetime(&sRtcInfoWork);
        }
    }
}

char * print_bcd(char * a0, u8 a1)
{
    *a0 = '0' + ((a1 & 0xF0) >> 4);
    a0++;
    *a0 = '0' + ((a1 & 0x0F) >> 0);
    a0++;
    *a0 = 0;
    return a0;
}

char * print_rtc(char * a0)
{
    if (gUnknown_02025250 != 1 && gUnknown_02025250 != 2)
    {
        
    }
    else
    {
        rtc_get_status_and_datetime(&sRtcInfoWork);
    }
    a0 = print_bcd(a0, sRtcInfoWork.year);
    *a0++ = ' ';
    a0 = print_bcd(a0, sRtcInfoWork.month);
    *a0++ = ' ';
    a0 = print_bcd(a0, sRtcInfoWork.day);
    *a0++ = ' ';
    a0 = print_bcd(a0, sRtcInfoWork.hour);
    *a0++ = ':';
    a0 = print_bcd(a0, sRtcInfoWork.minute);
    *a0++ = ':';
    a0 = print_bcd(a0, sRtcInfoWork.second);
    *a0++ = 0;
    return a0;
}

const struct SiiRtcInfo sDefaultRTC = {
    .year = 0, // 2000
    .month = 1, // January
    .day = 1, // 01
    .dayOfWeek = 0,
    .hour = 0,
    .minute = 0,
    .second = 0,
    .status = 0,
    .alarmHour = 0,
    .alarmMinute = 0
};

void rtc_intr_disable(void)
{
    sImeBak = REG_IME;
    REG_IME = 0;
}

void rtc_intr_enable(void)
{
    REG_IME = sImeBak;
}

s32 bcd_to_hex(u8 a0)
{
    if (a0 >= 0xa0 || (a0 & 0xF) >= 10)
        return 0xFF;
    return ((a0 >> 4) & 0xF) * 10 + (a0 & 0xF);
}

bool8 is_leap_year(u8 year)
{
    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0)
        return TRUE;
    else
        return FALSE;
}

const s32 sDaysPerMonth[] = {
    31,
    28,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31
};

u16 rtc_count_days_parameterized(u8 year, u8 month, u8 day)
{
    u16 numDays = 0;
    s32 i;
    for (i = year - 1; i > 0; i--)
    {
        numDays += 365;
        if (is_leap_year(i) == TRUE)
            numDays++;
    }
    for (i = 0; i < month - 1; i++)
        numDays += sDaysPerMonth[i];
    if (month > MONTH_FEB && is_leap_year(year) == TRUE)
    {
        numDays = numDays + 1;
    }
    numDays += day;
    return numDays;
}

u16 rtc_count_days_from_info(struct SiiRtcInfo *info)
{
    return rtc_count_days_parameterized(bcd_to_hex(info->year), bcd_to_hex(info->month), bcd_to_hex(info->day));
}

void rtc_probe_status(void)
{
    sRtcProbeStatus = 0;
    rtc_intr_disable();
    SiiRtcUnprotect();
    sRtcProbeCode = SiiRtcProbe();
    rtc_intr_enable();
    if ((sRtcProbeCode & 0xF) != 1)
        sRtcProbeStatus = 1;
    else
    {
        if (sRtcProbeCode & 0xF0)
            sRtcProbeStatus = 2;
        else
            sRtcProbeStatus = 0;
        rtc_get_status_and_datetime(&sRtcInfoBuffer);
        sRtcProbeStatus = rtc_validate_datetime(&sRtcInfoBuffer);
    }
}

u16 rtc_get_probe_status(void)
{
    return sRtcProbeStatus;
}

void sub_020106EC(struct SiiRtcInfo * info)
{
    if (sRtcProbeStatus & 0xFF0)
        *info = sDefaultRTC;
    else
        rtc_get_status_and_datetime(info);
}

void rtc_get_datetime(struct SiiRtcInfo * info)
{
    rtc_intr_disable();
    SiiRtcGetDateTime(info);
    rtc_intr_enable();
}

void rtc_get_status(struct SiiRtcInfo * info)
{
    rtc_intr_disable();
    SiiRtcGetStatus(info);
    rtc_intr_enable();
}

void rtc_get_status_and_datetime(struct SiiRtcInfo * info)
{
    rtc_get_status(info);
    rtc_get_datetime(info);
}

u16 rtc_validate_datetime(struct SiiRtcInfo * info)
{
    u16 r4;
    s32 year, month, day;
    r4 = 0;
    if (info->status & SIIRTCINFO_POWER)
        r4 |= 0x20;
    if (!(info->status & SIIRTCINFO_24HOUR))
        r4 |= 0x10;
    year = bcd_to_hex(info->year);
    if (year == 0xFF)
        r4 |= 0x40;
    month = bcd_to_hex(info->month);
    if (month == 0xFF || month == 0 || month > 12)
        r4 |= 0x80;
    day = bcd_to_hex(info->day);
    if (day == 0xFF)
        r4 |= 0x100;
    if (month == MONTH_FEB)
    {
        if (day > is_leap_year(year) + sDaysPerMonth[1])
            r4 |= 0x100;
    }
    else
    {
        if (day > sDaysPerMonth[month - 1])
            r4 |= 0x100;
    }
    day = bcd_to_hex(info->hour);
    if (day == 0xFF || day > 24)
        r4 |= 0x200;
    day = bcd_to_hex(info->minute);
    if (day == 0xFF || day > 60)
        r4 |= 0x400;
    day = bcd_to_hex(info->second);
    if (day == 0xFF || day > 60)
        r4 |= 0x800;
    return r4;
}

void rtc_reset(void)
{
    rtc_intr_disable();
    SiiRtcReset();
    rtc_intr_enable();
}

void rtc_sub_time_from_datetime(struct SiiRtcInfo * datetime, struct Time * dest, struct Time * timediff)
{
    u16 r4 = rtc_count_days_from_info(datetime);
    dest->seconds = bcd_to_hex(datetime->second) - timediff->seconds;
    dest->minutes = bcd_to_hex(datetime->minute) - timediff->minutes;
    dest->hours = bcd_to_hex(datetime->hour) - timediff->hours;
    dest->days = r4 - timediff->days;
    if (dest->seconds < 0)
    {
        dest->seconds += 60;
        dest->minutes--;
    }
    if (dest->minutes < 0)
    {
        dest->minutes += 60;
        dest->hours--;
    }
    if (dest->hours < 0)
    {
        dest->hours += 24;
        dest->days--;
    }
}

void rtc_sub_time_from_time(struct Time * dest, struct Time * diff, struct Time * src)
{
    dest->seconds = src->seconds - diff->seconds;
    dest->minutes = src->minutes - diff->minutes;
    dest->hours = src->hours - diff->hours;
    dest->days = src->days - diff->days;
    if (dest->seconds < 0)
    {
        dest->seconds += 60;
        dest->minutes--;
    }
    if (dest->minutes < 0)
    {
        dest->minutes += 60;
        dest->hours--;
    }
    if (dest->hours < 0)
    {
        dest->hours += 24;
        dest->days--;
    }
}

void sub_0200F324(u8 unused)
{
    return;
}

void sub_0200F338(void)
{
    return;
}

void sub_0200F344(void)
{
    return;
}

u16 * sub_0200F350(u16 a0)
{
    if (a0 < VARS_START)
        return NULL;
    if (a0 < VAR_SPECIAL_0)
        return &gUnknown_02022EE4[a0 - VARS_START];
    return NULL;
}

bool32 sub_0200F3A0(void)
{
    u8 sp0;
    u16 * data = sub_0200F350(VAR_PACIFIDLOG_TM_RECEIVED_DAY);
    rtc_maincb_is_time_since_last_berry_update_positive(&sp0);
    if (*data <= gRtcUTCTime.days)
        return TRUE;
    else
        return FALSE;
}

bool32 sub_0200F3E4(void)
{
    u16 * varAddr;
    u8 sp0;
    if (sub_0200F3A0() == TRUE)
        return TRUE;
    rtc_maincb_is_time_since_last_berry_update_positive(&sp0);
    if (gRtcUTCTime.days < 0)
        return FALSE;
    varAddr = sub_0200F350(VAR_PACIFIDLOG_TM_RECEIVED_DAY);
    *varAddr = 1;
    if (sub_02009EC8() != TRUE)
        return FALSE;
    return TRUE;
}
