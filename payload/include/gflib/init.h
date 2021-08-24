#ifndef GFLIB_INIT_H
#define GFLIB_INIT_H

// Expose to crt0.s
extern void (*gIntrTable[14u])(void);

#endif //GFLIB_INIT_H
