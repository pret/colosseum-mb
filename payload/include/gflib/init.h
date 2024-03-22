#ifndef GFLIB_INIT_H
#define GFLIB_INIT_H

#include "gflib/types.h"

#define TEST_BUTTON(arr, flags) ({(arr) & (flags);})

// Expose to crt0.s
void AgbMain(void);
extern IntrFunc gIntrTable[14u];

void SetIntrFunc(u32 i, IntrFunc func);
void SetVBlankCallback(IntrFunc cb);
u32 GetFrameTotal(void);
void DelayFrames(u32 frames);

#endif //GFLIB_INIT_H
