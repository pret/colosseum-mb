	.include "MPlayDef.s"
	.section .rodata

	.align 2, 0
song_00_part0:
	.byte KEYSH, 0
	.byte TEMPO, 150
	.byte VOICE, 87
	.byte VOL, 127
	.byte BEND, 77
	.byte N03, As5, v068
	.byte W03
	.byte Gn6, v127
	.byte W03
	.byte Gn6, v068
	.byte W03
	.byte Gn6, v127
	.byte W03
	.byte VOICE, 88
	.byte N06, Gn6, v068
	.byte W06
	.byte FINE

	.align 2, 0
	.global song_00
song_00:
	.byte 1, 0, 10, 0 @ trackCount, blockCount, priority, reverb
	.4byte gMPlay_song_00_Tone @ tone
	.4byte song_00_part0 @ part
