	.section .rodata
	.align 2, 0
gSpindaSpotGraphics::
	@ struct u8, u8, u16[16]
	.byte 0x10, 0x0e
	.2byte 0x0070, 0x01fc, 0x03fe, 0x07fe, 0x07ff, 0x0fff, 0x0fff, 0x0fff, 0x07fe, 0x07fe, 0x03fc, 0x01e0, 0x0000, 0x0000, 0x0000, 0x0000
	.align 2, 0
	.byte 0x28, 0x0f
	.2byte 0x01e0, 0x03f8, 0x07fc, 0x0ffe, 0x0ffe, 0x1fff, 0x1fff, 0x1fff, 0x0ffe, 0x0ffe, 0x07fc, 0x07f8, 0x00e0, 0x0000, 0x0000, 0x0000
	.align 2, 0
	.byte 0x16, 0x20
	.2byte 0x001c, 0x003e, 0x007f, 0x007f, 0x007f, 0x007f, 0x007f, 0x003e, 0x001c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000
	.align 2, 0
	.byte 0x22, 0x21
	.2byte 0x003c, 0x007e, 0x00ff, 0x00ff, 0x00ff, 0x00ff, 0x00ff, 0x007e, 0x003c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000
	.align 2, 0

gUnknown_0201E808::
	.string "EGG$"

gBerries::
	@ Berries, but Japanese
	.string "クラボ", 7, "$"
	.byte 0x02, 0x14, 0x00, 0x03, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x0a, 0x00, 0x00, 0x00, 0x00, 0x19, 0x00
	.string "カゴ", 7, "$"
	.byte 0x05, 0x50, 0x00, 0x03, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x0a, 0x00, 0x00, 0x00, 0x19, 0x00
	.string "モモン", 7, "$"
	.byte 0x01, 0x28, 0x00, 0x03, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x0a, 0x00, 0x00, 0x19, 0x00
	.string "チーゴ", 7, "$"
	.byte 0x03, 0x20, 0x00, 0x03, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x0a, 0x00, 0x19, 0x00
	.string "ナナシ", 7, "$"
	.byte 0x05, 0x32, 0x00, 0x03, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x0a, 0x19, 0x00
	.string "ヒメリ", 7, "$"
	.byte 0x04, 0x1c, 0x00, 0x03, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x0a, 0x00, 0x0a, 0x0a, 0x0a, 0x14, 0x00
	.string "オレン", 7, "$"
	.byte 0x05, 0x23, 0x00, 0x03, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x0a, 0x0a, 0x0a, 0x0a, 0x0a, 0x14, 0x00
	.string "キー", 7, "$"
	.byte 0x03, 0x2f, 0x00, 0x03, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x0a, 0x0a, 0x0a, 0x0a, 0x0a, 0x14, 0x00
	.string "ラム", 7, "$"
	.byte 0x05, 0x22, 0x00, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0c, 0x0a, 0x0a, 0x0a, 0x0a, 0x0a, 0x14, 0x00
	.string "オボン", 7, "$"
	.byte 0x04, 0x5f, 0x00, 0x03, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x06, 0x0a, 0x0a, 0x0a, 0x0a, 0x0a, 0x14, 0x00
	.string "フィラ", 7, "$"
	.byte 0x02, 0x64, 0x00, 0x03, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x06, 0x0a, 0x00, 0x00, 0x00, 0x00, 0x19, 0x00
	.string "ウイ", 7, "$"
	.byte 0x03, 0x73, 0x00, 0x03, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x06, 0x00, 0x0a, 0x00, 0x00, 0x00, 0x19, 0x00
	.string "マゴ", 7, "$"
	.byte 0x03, 0x7e, 0x00, 0x03, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x0a, 0x00, 0x00, 0x19, 0x00
	.string "バンジ", 7, "$"
	.byte 0x05, 0x40, 0x00, 0x03, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x0a, 0x00, 0x19, 0x00
	.string "イア", 7, "$"
	.byte 0x02, 0xdf, 0x00, 0x03, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00, 0x0a, 0x19, 0x00
	.string "ズリ", 7, "$"
	.byte 0x04, 0x78, 0x00, 0x06, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x0a, 0x0a, 0x00, 0x00, 0x00, 0x14, 0x00
	.string "ブリー", 7, "$"
	.byte 0x02, 0x6c, 0x00, 0x06, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x0a, 0x0a, 0x00, 0x00, 0x14, 0x00
	.string "ナナ", 7, "$"
	.byte 0x04, 0x4d, 0x00, 0x06, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x0a, 0x0a, 0x00, 0x14, 0x00
	.string "セシナ", 7, "$"
	.byte 0x05, 0x4a, 0x00, 0x06, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x0a, 0x0a, 0x14, 0x00
	.string "パイル", 7, "$"
	.byte 0x03, 0x50, 0x00, 0x06, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x0a, 0x00, 0x00, 0x00, 0x0a, 0x14, 0x00
	.string "ザロク", 7, "$"
	.byte 0x04, 0x87, 0x00, 0x06, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x0a, 0x00, 0x0a, 0x0a, 0x00, 0x14, 0x00
	.string "ネコブ", 7, "$"
	.byte 0x03, 0x96, 0x00, 0x06, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x0a, 0x00, 0x0a, 0x0a, 0x14, 0x00
	.string "タポル", 7, "$"
	.byte 0x03, 0x6e, 0x00, 0x06, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x0a, 0x00, 0x0a, 0x00, 0x0a, 0x14, 0x00
	.string "ロメ", 7, "$"
	.byte 0x03, 0xa2, 0x00, 0x06, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x0a, 0x0a, 0x00, 0x0a, 0x00, 0x14, 0x00
	.string "ウブ", 7, "$"
	.byte 0x02, 0x95, 0x00, 0x06, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x0a, 0x0a, 0x00, 0x0a, 0x14, 0x00
	.string "マトマ", 7, "$"
	.byte 0x02, 0xc8, 0x00, 0x04, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x06, 0x14, 0x0a, 0x00, 0x00, 0x00, 0x1e, 0x00
	.string "モコシ", 7, "$"
	.byte 0x03, 0x4b, 0x00, 0x04, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x06, 0x00, 0x14, 0x0a, 0x00, 0x00, 0x1e, 0x00
	.string "ゴス", 7, "$"
	.byte 0x03, 0x8c, 0x00, 0x04, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x14, 0x0a, 0x00, 0x1e, 0x00
	.string "ラブタ", 7, "$"
	.byte 0x02, 0xe2, 0x00, 0x04, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x14, 0x0a, 0x1e, 0x00
	.string "ノメル", 7, "$"
	.byte 0x05, 0x1d, 0x01, 0x04, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x06, 0x0a, 0x00, 0x00, 0x00, 0x14, 0x1e, 0x00
	.string "ノワキ", 7, "$"
	.byte 0x02, 0x85, 0x00, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x12, 0x28, 0x0a, 0x00, 0x00, 0x00, 0x46, 0x00
	.string "シーヤ", 7, "$"
	.byte 0x01, 0xf4, 0x00, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x12, 0x00, 0x28, 0x0a, 0x00, 0x00, 0x46, 0x00
	.string "カイス", 7, "$"
	.byte 0x02, 0xfa, 0x00, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x12, 0x00, 0x00, 0x28, 0x0a, 0x00, 0x46, 0x00
	.string "ドリ", 7, "$"
	.byte 0x03, 0x18, 0x01, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x12, 0x00, 0x00, 0x00, 0x28, 0x0a, 0x46, 0x00
	.string "ベリブ", 7, "$"
	.byte 0x01, 0x2c, 0x01, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x12, 0x0a, 0x00, 0x00, 0x00, 0x28, 0x46, 0x00
	.string "チイラ", 7, "$"
	.byte 0x04, 0x6f, 0x00, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x28, 0x00, 0x28, 0x00, 0x0a, 0x50, 0x00
	.string "リュガ", 7, "$"
	.byte 0x04, 0x21, 0x00, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x00, 0x28, 0x00, 0x28, 0x00, 0x50, 0x00
	.string "カムラ", 7, "$"
	.byte 0x04, 0x5f, 0x00, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x00, 0x00, 0x28, 0x00, 0x28, 0x50, 0x00
	.string "ヤタピ", 7, "$"
	.byte 0x04, 0xed, 0x00, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x28, 0x00, 0x00, 0x28, 0x00, 0x50, 0x00
	.string "ズア", 7, "$"
	.byte 0x03, 0x4b, 0x00, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x00, 0x28, 0x00, 0x00, 0x28, 0x50, 0x00
	.string "サン", 7, "$"
	.byte 0x02, 0x61, 0x00, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x0a, 0x0a, 0x0a, 0x0a, 0x0a, 0x1e, 0x00
	.string "スター", 7, "$"
	.byte 0x05, 0x99, 0x00, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x0a, 0x0a, 0x0a, 0x0a, 0x0a, 0x1e, 0x00
	.string "ナゾ", 7, "$"
	.byte 0x00, 0x00, 0x00, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x00

gBitTable:: @ 0x0201ECC0
	.4byte 0x00000001
	.4byte 0x00000002
	.4byte 0x00000004
	.4byte 0x00000008
	.4byte 0x00000010
	.4byte 0x00000020
	.4byte 0x00000040
	.4byte 0x00000080
	.4byte 0x00000100
	.4byte 0x00000200
	.4byte 0x00000400
	.4byte 0x00000800
	.4byte 0x00001000
	.4byte 0x00002000
	.4byte 0x00004000
	.4byte 0x00008000
	.4byte 0x00010000
	.4byte 0x00020000
	.4byte 0x00040000
	.4byte 0x00080000
	.4byte 0x00100000
	.4byte 0x00200000
	.4byte 0x00400000
	.4byte 0x00800000
	.4byte 0x01000000
	.4byte 0x02000000
	.4byte 0x04000000
	.4byte 0x08000000
	.4byte 0x10000000
	.4byte 0x20000000
	.4byte 0x40000000
	.4byte 0x80000000

gUnknown_0201ED40::
	.byte 0x0d, 0x0d, 0x0e, 0x0e, 0x0d, 0x0d, 0x0f, 0x0e, 0x0d, 0x0f, 0x0d, 0x0e, 0x0f, 0x0d, 0x0e, 0x0e, 0x0f, 0x0d, 0x0d, 0x0e, 0x0e, 0x0f, 0x0d

gPPUpReadMasks::
	.byte 0x03, 0x0c, 0x30, 0xc0

gUnknown_0201ED5B::
	.byte 0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e

	.align 2, 0
gSpeciesToNationalDexNumLUT::
	.2byte 0x0001, 0x0002, 0x0003, 0x0004, 0x0005, 0x0006, 0x0007, 0x0008, 0x0009, 0x000a, 0x000b, 0x000c, 0x000d, 0x000e, 0x000f, 0x0010
	.2byte 0x0011, 0x0012, 0x0013, 0x0014, 0x0015, 0x0016, 0x0017, 0x0018, 0x0019, 0x001a, 0x001b, 0x001c, 0x001d, 0x001e, 0x001f, 0x0020
	.2byte 0x0021, 0x0022, 0x0023, 0x0024, 0x0025, 0x0026, 0x0027, 0x0028, 0x0029, 0x002a, 0x002b, 0x002c, 0x002d, 0x002e, 0x002f, 0x0030
	.2byte 0x0031, 0x0032, 0x0033, 0x0034, 0x0035, 0x0036, 0x0037, 0x0038, 0x0039, 0x003a, 0x003b, 0x003c, 0x003d, 0x003e, 0x003f, 0x0040
	.2byte 0x0041, 0x0042, 0x0043, 0x0044, 0x0045, 0x0046, 0x0047, 0x0048, 0x0049, 0x004a, 0x004b, 0x004c, 0x004d, 0x004e, 0x004f, 0x0050
	.2byte 0x0051, 0x0052, 0x0053, 0x0054, 0x0055, 0x0056, 0x0057, 0x0058, 0x0059, 0x005a, 0x005b, 0x005c, 0x005d, 0x005e, 0x005f, 0x0060
	.2byte 0x0061, 0x0062, 0x0063, 0x0064, 0x0065, 0x0066, 0x0067, 0x0068, 0x0069, 0x006a, 0x006b, 0x006c, 0x006d, 0x006e, 0x006f, 0x0070
	.2byte 0x0071, 0x0072, 0x0073, 0x0074, 0x0075, 0x0076, 0x0077, 0x0078, 0x0079, 0x007a, 0x007b, 0x007c, 0x007d, 0x007e, 0x007f, 0x0080
	.2byte 0x0081, 0x0082, 0x0083, 0x0084, 0x0085, 0x0086, 0x0087, 0x0088, 0x0089, 0x008a, 0x008b, 0x008c, 0x008d, 0x008e, 0x008f, 0x0090
	.2byte 0x0091, 0x0092, 0x0093, 0x0094, 0x0095, 0x0096, 0x0097, 0x0098, 0x0099, 0x009a, 0x009b, 0x009c, 0x009d, 0x009e, 0x009f, 0x00a0
	.2byte 0x00a1, 0x00a2, 0x00a3, 0x00a4, 0x00a5, 0x00a6, 0x00a7, 0x00a8, 0x00a9, 0x00aa, 0x00ab, 0x00ac, 0x00ad, 0x00ae, 0x00af, 0x00b0
	.2byte 0x00b1, 0x00b2, 0x00b3, 0x00b4, 0x00b5, 0x00b6, 0x00b7, 0x00b8, 0x00b9, 0x00ba, 0x00bb, 0x00bc, 0x00bd, 0x00be, 0x00bf, 0x00c0
	.2byte 0x00c1, 0x00c2, 0x00c3, 0x00c4, 0x00c5, 0x00c6, 0x00c7, 0x00c8, 0x00c9, 0x00ca, 0x00cb, 0x00cc, 0x00cd, 0x00ce, 0x00cf, 0x00d0
	.2byte 0x00d1, 0x00d2, 0x00d3, 0x00d4, 0x00d5, 0x00d6, 0x00d7, 0x00d8, 0x00d9, 0x00da, 0x00db, 0x00dc, 0x00dd, 0x00de, 0x00df, 0x00e0
	.2byte 0x00e1, 0x00e2, 0x00e3, 0x00e4, 0x00e5, 0x00e6, 0x00e7, 0x00e8, 0x00e9, 0x00ea, 0x00eb, 0x00ec, 0x00ed, 0x00ee, 0x00ef, 0x00f0
	.2byte 0x00f1, 0x00f2, 0x00f3, 0x00f4, 0x00f5, 0x00f6, 0x00f7, 0x00f8, 0x00f9, 0x00fa, 0x00fb, 0x0183, 0x0184, 0x0185, 0x0186, 0x0187
	.2byte 0x0188, 0x0189, 0x018a, 0x018b, 0x018c, 0x018d, 0x018e, 0x018f, 0x0190, 0x0191, 0x0192, 0x0193, 0x0194, 0x0195, 0x0196, 0x0197
	.2byte 0x0198, 0x0199, 0x019a, 0x019b, 0x00fc, 0x00fd, 0x00fe, 0x00ff, 0x0100, 0x0101, 0x0102, 0x0103, 0x0104, 0x0105, 0x0106, 0x0107
	.2byte 0x0108, 0x0109, 0x010a, 0x010b, 0x010c, 0x010d, 0x010e, 0x010f, 0x0110, 0x0111, 0x0112, 0x0113, 0x0122, 0x0123, 0x0124, 0x0114
	.2byte 0x0115, 0x011d, 0x011e, 0x0147, 0x0116, 0x0117, 0x011b, 0x011c, 0x0140, 0x0141, 0x012c, 0x012d, 0x0160, 0x0157, 0x0158, 0x012b
	.2byte 0x0144, 0x012e, 0x0153, 0x0154, 0x0172, 0x0155, 0x0156, 0x015d, 0x015e, 0x013e, 0x013f, 0x0148, 0x0149, 0x014a, 0x0128, 0x0129
	.2byte 0x0135, 0x0136, 0x0142, 0x0143, 0x016b, 0x016c, 0x016d, 0x014b, 0x014c, 0x0169, 0x016a, 0x0151, 0x0152, 0x012a, 0x0145, 0x0146
	.2byte 0x0137, 0x0138, 0x012f, 0x0133, 0x0134, 0x014d, 0x014e, 0x0168, 0x0163, 0x0164, 0x013b, 0x011f, 0x0120, 0x0121, 0x013c, 0x013d
	.2byte 0x0165, 0x0125, 0x0126, 0x0127, 0x016e, 0x016f, 0x0170, 0x0167, 0x0161, 0x0162, 0x0150, 0x014f, 0x0171, 0x0130, 0x0131, 0x0132
	.2byte 0x015f, 0x0139, 0x013a, 0x0159, 0x015a, 0x015b, 0x015c, 0x0118, 0x0119, 0x011a, 0x0173, 0x0174, 0x0175, 0x0176, 0x0177, 0x0178
	.2byte 0x0179, 0x017a, 0x017b, 0x017e, 0x017f, 0x0180, 0x017c, 0x017d, 0x0181, 0x0182, 0x0166, 0x0000

gExtCtrlCodeLengths::
	.byte 0x01, 0x02, 0x02, 0x02, 0x04, 0x02, 0x02, 0x01, 0x02, 0x01, 0x01, 0x03, 0x02, 0x02, 0x02, 0x01, 0x03, 0x02, 0x02, 0x02, 0x02, 0x01, 0x01, 0x00

gRSPokemonCenterMaps::
	@ OLDALE
	.2byte 0x0202
	.2byte 0x0203
	@ DEWFORD
	.2byte 0x0301
	.2byte 0x0302
	@ LAVARIDGE
	.2byte 0x0405
	.2byte 0x0406
	@ FALLARBOR
	.2byte 0x0503
	.2byte 0x0504
	@ VERDANTURF
	.2byte 0x0603
	.2byte 0x0604
	@ PACIFIDLOG
	.2byte 0x0700
	.2byte 0x0701
	@ PETALBURG
	.2byte 0x0804
	.2byte 0x0805
	@ SLATEPORT
	.2byte 0x090a
	.2byte 0x090b
	@ MAUVILLE
	.2byte 0x0a05
	.2byte 0x0a06
	@ RUSTBORO
	.2byte 0x0b05
	.2byte 0x0b06
	@ FORTREE
	.2byte 0x0c02
	.2byte 0x0c03
	@ LILYCOVE
	.2byte 0x0d06
	.2byte 0x0d07
	@ MOSSDEEP
	.2byte 0x0e03
	.2byte 0x0e04
	@ SOOTOPOLIS
	.2byte 0x0f02
	.2byte 0x0f03
	@ EVER GRANDE
	.2byte 0x100c
	.2byte 0x100d
	@ POKEMON LEAGUE
	.2byte 0x100a
	@ LINK CORNER
	.2byte 0x1918
	.2byte 0x1919
	.2byte 0x191a
	.2byte 0x191b
	@ END OF ARRAY
	.2byte 0xffff

gRSSpecialAreaMaps::
	.2byte 0x1a05 @ MAP_BATTLE_TOWER_LOBBY
	.2byte 0xffff

	.data
	.align 2
gUnknown_0202062C::
	.string "Bad EGG$"
