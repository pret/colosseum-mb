	.section .rodata

	.incbin "baserom.gba", 0x1DE18, 0x924

	.global song_00
song_00:
	.incbin "baserom.gba", 0x1E73C, 0xC
