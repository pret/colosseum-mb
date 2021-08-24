#ifndef GFLIB_INIT_H
#define GFLIB_INIT_H

#define TEST_BUTTON(arr, flags) ({(arr) & (flags);})

typedef void (*IntrFunc)(void);

// Expose to crt0.s
void AgbMain(void);
extern IntrFunc gIntrTable[14u];

void SetIntrFunc(int i, IntrFunc func);
void SetVBlankCallback(IntrFunc cb);

#endif //GFLIB_INIT_H
