	.section .rodata

	.incbin "baserom.gba", 0x1E748, 0x24

	.global song_01
song_01:
	.incbin "baserom.gba", 0x1E76C, 0xC
