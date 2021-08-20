	.include "MPlayDef.s"
	.section .rodata

	.align 2, 0
song_01_part0:
	.byte KEYSH, 0
	.byte TEMPO, 120
	.byte VOICE, 92
	.byte BENDR, 12
	.byte VOL, 127
	.byte BEND, 64
	.byte N03, Cn2, v127
	.byte W03
	.byte Cn2, v020
	.byte W03
	.byte N18, Cn2, v127
	.byte W03
	.byte W03
	.byte W03
	.byte W03
	.byte W03
	.byte W03
	.byte N09, Cn2, v020
	.byte W03
	.byte W03
	.byte W03
	.byte FINE

	.align 2, 0
	.global song_01
song_01:
	.byte 1, 0, 10, 0
	.4byte voicegroup000
	.4byte song_01_part0
