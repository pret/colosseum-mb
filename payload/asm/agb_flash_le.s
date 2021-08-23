	.section .rodata
	.align 2, 0

leMaxTime:
	.2byte 0x000a, 0xffbd, 0x00c2
	.2byte 0x000a, 0xffbd, 0x00c2
	.2byte 0x07d0, 0xffbd, 0x00c2
	.2byte 0x07d0, 0xffbd, 0x00c2

	.global LE26FV10N1TS
LE26FV10N1TS:
	.4byte ProgramFlashByte_MX
	.4byte ProgramFlashSector_MX
	.4byte EraseFlashChip_MX
	.4byte EraseFlashSector_MX
	.4byte WaitForFlashWrite_Common
	.4byte leMaxTime
	.4byte 0x00020000
	.4byte 0x00001000
	.4byte 0x0020000c
	.4byte 0x00000000
	.4byte 0x00010003
	.4byte 0x00001362
