	.section .rodata
	.align 2
gUnknown_0201D6C4::
	.4byte ply_fine
	.4byte ply_goto
	.4byte ply_patt
	.4byte ply_pend
	.4byte ply_rept
	.4byte ply_fine
	.4byte ply_fine
	.4byte ply_fine
	.4byte ply_fine
	.4byte ply_prio
	.4byte ply_tempo
	.4byte ply_keysh
	.4byte ply_voice
	.4byte ply_vol
	.4byte ply_pan
	.4byte ply_bend
	.4byte ply_bendr
	.4byte ply_lfos
	.4byte ply_lfodl
	.4byte ply_mod
	.4byte ply_modt
	.4byte ply_fine
	.4byte ply_fine
	.4byte ply_tune
	.4byte ply_fine
	.4byte ply_fine
	.4byte ply_fine
	.4byte ply_port
	.4byte ply_fine
	.4byte ply_endtie
	.4byte SampleFreqSet
	.4byte TrackStop
	.4byte FadeOutBody
	.4byte TrkVolPitSet
	.4byte RealClearChain
	.4byte SoundMainBTM

gScaleTable::
	.byte 0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7, 0xe8, 0xe9, 0xea, 0xeb, 0xd0, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7, 0xd8, 0xd9, 0xda, 0xdb, 0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7
	.byte 0xc8, 0xc9, 0xca, 0xcb, 0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7, 0xb8, 0xb9, 0xba, 0xbb, 0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7, 0xa8, 0xa9, 0xaa, 0xab, 0x90, 0x91, 0x92, 0x93
	.byte 0x94, 0x95, 0x96, 0x97, 0x98, 0x99, 0x9a, 0x9b, 0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8a, 0x8b, 0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7a, 0x7b
	.byte 0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6a, 0x6b, 0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5a, 0x5b, 0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47
	.byte 0x48, 0x49, 0x4a, 0x4b, 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3a, 0x3b, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b, 0x10, 0x11, 0x12, 0x13
	.byte 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1a, 0x1b, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b

gFreqTable::
	.4byte 0x80000000, 0x879c7c97, 0x8facd61e, 0x9837f052, 0xa14517cc, 0xaadc0848, 0xb504f334, 0xbfc886bb
	.4byte 0xcb2ff52a, 0xd744fccb, 0xe411f03a, 0xf1a1bf39

gPcmSamplesPerVBlankTable::
	.2byte 0x0060, 0x0084, 0x00b0, 0x00e0, 0x0108, 0x0130, 0x0160, 0x01c0, 0x0210, 0x0260, 0x02a0, 0x02c0

gCgbScaleTable::
	.byte 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1a, 0x1b, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27
	.byte 0x28, 0x29, 0x2a, 0x2b, 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3a, 0x3b, 0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4a, 0x4b, 0x50, 0x51, 0x52, 0x53
	.byte 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5a, 0x5b, 0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6a, 0x6b, 0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7a, 0x7b
	.byte 0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8a, 0x8b, 0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99, 0x9a, 0x9b, 0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7
	.byte 0xa8, 0xa9, 0xaa, 0xab

gCgbFreqTable::
	.2byte 0xf82c, 0xf89d, 0xf907, 0xf96b, 0xf9c9, 0xfa23, 0xfa77, 0xfac7, 0xfb12, 0xfb58, 0xfb9b, 0xfbda

gNoiseTable::
	.byte 0xd7, 0xd6, 0xd5, 0xd4, 0xc7, 0xc6, 0xc5, 0xc4, 0xb7, 0xb6, 0xb5, 0xb4, 0xa7, 0xa6, 0xa5, 0xa4, 0x97, 0x96, 0x95, 0x94, 0x87, 0x86, 0x85, 0x84, 0x77, 0x76, 0x75, 0x74, 0x67, 0x66, 0x65, 0x64
	.byte 0x57, 0x56, 0x55, 0x54, 0x47, 0x46, 0x45, 0x44, 0x37, 0x36, 0x35, 0x34, 0x27, 0x26, 0x25, 0x24, 0x17, 0x16, 0x15, 0x14, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01, 0x00

gCgb3Vol::
	.byte 0x00, 0x00, 0x60, 0x60, 0x60, 0x60, 0x40, 0x40, 0x40, 0x40, 0x80, 0x80, 0x80, 0x80, 0x20, 0x20

gClockTable::
	.byte 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x1c, 0x1e, 0x20, 0x24, 0x28, 0x2a, 0x2c
	.byte 0x30, 0x34, 0x36, 0x38, 0x3c, 0x40, 0x42, 0x44, 0x48, 0x4c, 0x4e, 0x50, 0x54, 0x58, 0x5a, 0x5c, 0x60, 0x00, 0x00, 0x00

gXcmdTable::
	.4byte ply_xxx
	.4byte ply_xwave
	.4byte ply_xtype
	.4byte ply_xxx
	.4byte ply_xatta
	.4byte ply_xdeca
	.4byte ply_xsust
	.4byte ply_xrele
	.4byte ply_xiecv
	.4byte ply_xiecl
	.4byte ply_xleng
	.4byte ply_xswee

	.incbin "baserom.gba", 0x1D99C, 0x45c
