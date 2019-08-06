#include "gba/gba.h"

extern u8 arm_LZ77UnCompWRAM_Buffer[];
extern u8 arm_LZ77UnCompWRAM_BufferEnd[];
extern u8 arm_LZ77UnCompWRAM_FuncStart[];

typedef void (*IntrFunc)(void);

const IntrFunc gIntrTableTemplate[14] = {};

void arm_LZ77UnCompWRAM(void);

void sub_0200023C(void)
{

}

void AgbMain(void)
{
    void (*func)(void) = (void *)arm_LZ77UnCompWRAM_FuncStart;
    REG_IME = 0;
    RegisterRamReset(RESET_ALL & ~(RESET_EWRAM | RESET_IWRAM));
    REG_WAITCNT = WAITCNT_SRAM_4 | WAITCNT_WS0_N_3 | WAITCNT_WS0_S_1 | WAITCNT_WS1_N_3 | WAITCNT_WS1_S_1 | WAITCNT_WS2_N_3 | WAITCNT_WS2_S_1 | WAITCNT_PREFETCH_ENABLE;
    DmaCopy16(3, arm_LZ77UnCompWRAM, IWRAM_START, arm_LZ77UnCompWRAM_BufferEnd - arm_LZ77UnCompWRAM_Buffer);
    func();
    while (1);
}
