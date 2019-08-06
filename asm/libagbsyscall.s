	.include "asm/macros/function.inc"
	.text
	.syntax unified

	thumb_func_start RegisterRamReset
RegisterRamReset: @ 0x0200FD24
	svc #1
	bx lr
