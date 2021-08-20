	.section .rodata

	.include "asm/macros/m4a.inc"
	.include "asm/macros/music_voice.inc"

gMPlay_song_00_Tone::
	.incbin "baserom.gba", 0x1D99C, 0x45c

	.include "sound/music_player_table.inc"
	.include "sound/song_table.inc"

_0201DE18::
	.incbin "baserom.gba", 0x1DE18, 0x904
