	.include "asm/macros/function.inc"
	.text
	.syntax unified

	thumb_func_start CpuSet
CpuSet: @ 0x0200FD04
	svc #0xb
	bx lr

	thumb_func_start Div
Div: @ 0x0200FD08
	svc #6
	bx lr

	thumb_func_start Mod
Mod: @ 0x0200FD0C
	svc #6
	adds r0, r1, #0
	bx lr
	.align 2, 0

	thumb_func_start HuffUnComp
HuffUnComp: @ 0x0200FD14
	svc #0x13
	bx lr

	thumb_func_start LZ77UnCompVRAM
LZ77UnCompVRAM: @ 0x0200FD18
	svc #0x12
	bx lr

	thumb_func_start LZ77UnCompWRAM
LZ77UnCompWRAM: @ 0x0200FD1C
	svc #0x11
	bx lr

	thumb_func_start RLUnCompVRAM
RLUnCompVRAM: @ 0x0200FD20
	svc #0x15
	bx lr

	thumb_func_start RegisterRamReset
RegisterRamReset: @ 0x0200FD24
	svc #1
	bx lr

	thumb_func_start SoftReset
SoftReset: @ 0x0200FD28
	ldr r3, =0x04000208
	movs r2, #0
	strb r2, [r3]
	ldr r1, =0x03007F00
	mov sp, r1
	svc #1
	svc #0
	movs r0, r0
	.align 2, 0
	.pool

	thumb_func_start VBlankIntrWait
VBlankIntrWait: @ 0x0200FD40
	movs r2, #0
	svc #5
	bx lr
	.align 2, 0

	thumb_func_start SoftResetRom
SoftResetRom: @ 0x0200FD48
	ldr r3, =0x04000208
	movs r2, #0
	strb r2, [r3]
	ldr r3, =0x03007FFA
	movs r2, #1
	strb r2, [r3]
	subs r3, #0xfa
	mov sp, r3
	movs r2, #1
	bics r0, r2
	svc #1
	svc #0
	.align 2, 0
	.pool
