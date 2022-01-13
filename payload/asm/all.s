	.include "asm/macros/function.inc"
	.text
	.syntax unified
	.equ SE_SELECT,  0
	.equ SE_FAILURE, 1

	thumb_func_start GF_Main
GF_Main: @ 0x020002B4
	push {r4, r5, r6, r7, lr}
	sub sp, #0x48
	bl DetectROM
	ldr r0, =gUnknown_0201F4AC
	ldr r1, [r0]
	movs r0, #2
	bl sub_020098D8
	bl SaveBlocksInit
	bl SetSaveSectorPtrs
	ldr r4, =gUnknown_020217B4
	bl ReadSaveBlockChunks
	strb r0, [r4]
	ldr r5, =gUnknown_020217B8
	movs r0, #0
	str r0, [sp, #0x44]
	movs r4, #0
	ldr r0, =gAgbPmRomParams
	ldr r0, [r0]
	ldr r0, [r0, #4]
	cmp r0, #2
	beq _02000304
	movs r0, #0
	ldr r6, =gRomHeader + 0xA8
	add r7, sp, #0x40
	b _0200032C
	.align 2, 0
	.pool
_02000304:
	ldr r6, =gRomHeader + 0xA8
	add r7, sp, #0x40
_02000308:
	add r0, sp, #0x44
	mov r1, sp
	movs r2, #0
	bl main_callback
	ldr r1, [sp, #0x44]
	cmp r1, #5
	bne _0200031A
	movs r4, #1
_0200031A:
	cmp r1, #0xb
	bne _02000320
	movs r4, #2
_02000320:
	subs r0, r1, #6
	cmp r0, #1
	bls _0200032A
	cmp r1, #0xb
	bne _02000308
_0200032A:
	adds r0, r4, #0
_0200032C:
	strb r0, [r5]
	bl InitSound
	bl sub_02002C44
	movs r0, #0x28
	movs r1, #5
	bl SetKeyRepeatTiming
	ldr r0, =0x04000200
	movs r3, #1
	strh r3, [r0]
	ldr r1, =0x04000004
	movs r0, #8
	strh r0, [r1]
	movs r2, #0x80
	lsls r2, r2, #0x13
	ldrh r1, [r2]
	ldr r0, =0x0000FF7F
	ands r0, r1
	strh r0, [r2]
	ldr r0, =0x04000208
	strh r3, [r0]
	ldr r0, =gSaveBlock2Ptr
	ldr r0, [r0]
	ldr r1, =gSaveBlock1Ptr
	ldr r1, [r1]
	ldr r2, =gUnknown_020217B4
	ldrb r2, [r2]
	bl sub_0200C9C0
	adds r0, r6, #0
	bl sub_0200D924
	ldr r0, =sub_0200D9EC
	bl SetVBlankCallback
	bl PauseSoundVSync
	ldr r0, =0x03004000
	bl GenerateFontHalfrowLookupTable
	bl FadeOut
_02000384:
	bl sub_020047D4
	cmp r0, #0
	bne _020003EA
	bl sub_02006344
	bl sub_02005BB8
	bl sub_020064B0
	cmp r0, #0
	bne _020003E4
	ldr r1, =gUnknown_02024960
	ldrb r0, [r1, #3]
	lsls r0, r0, #0x19
	cmp r0, #0
	beq _020003DC
	ldrb r0, [r1, #3]
	lsls r0, r0, #0x19
	lsrs r0, r0, #0x19
	subs r0, #1
	b _020003DE
	.align 2, 0
	.pool
_020003DC:
	movs r0, #0
_020003DE:
	bl sub_02005704
	b _02000384
_020003E4:
	bl sub_0200023C
	b _02000384
_020003EA:
	ldr r0, =gSaveBlock1BakPtr
	ldr r0, [r0]
	ldr r1, =gSaveBlock1Ptr
	ldr r1, [r1]
	ldr r2, =gAgbPmRomParams
	ldr r2, [r2]
	adds r2, #0x8c
	ldr r2, [r2]
	lsls r2, r2, #0xa
	lsrs r2, r2, #0xb
	bl CpuSet
	movs r0, #0
	strh r0, [r7]
	movs r5, #0
	ldr r6, =gPlayerPartyPtr
	movs r4, #0
_0200040C:
	ldr r0, [r6]
	adds r0, r0, r4
	movs r1, #0x37
	adds r2, r7, #0
	bl SetMonData
	adds r4, #0x64
	adds r5, #1
	cmp r5, #5
	ble _0200040C
	movs r0, #1
	movs r1, #0
	movs r2, #0
	bl sub_02002A9C
	b _02000384
	.align 2, 0
	.pool

	thumb_func_start sub_0200043C
sub_0200043C: @ 0x0200043C
	push {r4, lr}
	sub sp, #0x44
	movs r0, #0
	str r0, [sp, #0x40]
	movs r4, #0
	ldr r0, =gAgbPmRomParams
	ldr r0, [r0]
	ldr r0, [r0, #4]
	cmp r0, #2
	beq _02000458
	movs r0, #0
	b _0200047C
	.align 2, 0
	.pool
_02000458:
	add r0, sp, #0x40
	mov r1, sp
	movs r2, #0
	bl main_callback
	ldr r1, [sp, #0x40]
	cmp r1, #5
	bne _0200046A
	movs r4, #1
_0200046A:
	cmp r1, #0xb
	bne _02000470
	movs r4, #2
_02000470:
	subs r0, r1, #6
	cmp r0, #1
	bls _0200047A
	cmp r1, #0xb
	bne _02000458
_0200047A:
	adds r0, r4, #0
_0200047C:
	add sp, #0x44
	pop {r4}
	pop {r1}
	bx r1

	thumb_func_start RenderText
RenderText: @ 0x02000484
	push {r4, r5, r6, r7, lr}
	mov r7, sb
	mov r6, r8
	push {r6, r7}
	adds r4, r0, #0
	adds r5, r1, #0
	ldr r0, [r4, #0x10]
	mov r8, r0
	ldr r1, [r4, #0x14]
	mov sb, r1
	b _02000564
_0200049A:
	ldrb r1, [r5]
	cmp r1, #0xfc
	beq _020004EC
	cmp r1, #0xfc
	bgt _020004AA
	cmp r1, #0xfb
	beq _020004D0
	b _02000548
_020004AA:
	cmp r1, #0xfd
	beq _020004BA
	cmp r1, #0xfe
	bne _02000548
	adds r0, r4, #0
	bl TextWindowNextLine
	b _02000562
_020004BA:
	adds r5, #1
	ldrb r0, [r5]
	lsls r1, r0, #5
	ldr r0, =gStringBuffers
	adds r1, r1, r0
	adds r0, r4, #0
	bl RenderText
	b _02000562
	.align 2, 0
	.pool
_020004D0:
	ldr r6, =gNewKeys
	movs r7, #3
_020004D4:
	movs r0, #1
	bl DelayFrames
	adds r0, r7, #0
	ldrh r1, [r6]
	ands r0, r1
	cmp r0, #0
	beq _020004D4
	b _02000562
	.align 2, 0
	.pool
_020004EC:
	adds r5, #1
	adds r6, r5, #0
	ldrb r0, [r5]
	cmp r0, #0x14
	beq _02000506
	cmp r0, #0x14
	bgt _02000500
	cmp r0, #0xf
	beq _0200053C
	b _02000544
_02000500:
	cmp r0, #0x15
	beq _0200050E
	b _02000544
_02000506:
	ldrb r0, [r5, #1]
	strb r0, [r4, #0x1c]
	adds r6, r5, #2
	b _02000544
_0200050E:
	ldrb r0, [r4, #9]
	cmp r0, #8
	bne _02000528
	ldr r0, =gFont1JapanGfx
	str r0, [r4, #0x10]
	ldr r0, =gFont1JapanWidths
	str r0, [r4, #0x14]
	b _02000544
	.align 2, 0
	.pool
_02000528:
	ldr r0, =gFont0JapanGfx
	str r0, [r4, #0x10]
	ldr r0, =gFont0JapanWidths
	str r0, [r4, #0x14]
	b _02000544
	.align 2, 0
	.pool
_0200053C:
	adds r0, r4, #0
	movs r1, #0
	bl ClearWindowCharBuffer
_02000544:
	adds r5, r6, #0
	b _02000562
_02000548:
	ldrb r0, [r4, #0x19]
	cmp r0, #0
	bne _02000558
	ldrb r2, [r4, #0x18]
	adds r0, r4, #0
	bl DrawGlyphOnWindow_NoShadow
	b _02000562
_02000558:
	ldrb r2, [r4, #0x18]
	ldrb r3, [r4, #0x19]
	adds r0, r4, #0
	bl DrawGlyphOnWindow_WithShadow
_02000562:
	adds r5, #1
_02000564:
	ldrb r0, [r5]
	cmp r0, #0xff
	bne _0200049A
	movs r0, #0
	strb r0, [r4, #0x1c]
	mov r1, r8
	str r1, [r4, #0x10]
	mov r0, sb
	str r0, [r4, #0x14]
	pop {r3, r4}
	mov r8, r3
	mov sb, r4
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start RenderText_NoPlaceholders
RenderText_NoPlaceholders: @ 0x02000584
	push {r4, r5, r6, r7, lr}
	mov r7, r8
	push {r7}
	adds r4, r0, #0
	adds r5, r1, #0
	ldr r7, [r4, #0x10]
	ldr r0, [r4, #0x14]
	mov r8, r0
	b _02000638
_02000596:
	ldrb r1, [r5]
	cmp r1, #0xfc
	beq _020005D0
	cmp r1, #0xfc
	bgt _020005A6
	cmp r1, #0xf9
	beq _020005B2
	b _0200062C
_020005A6:
	cmp r1, #0xfe
	bne _0200062C
	adds r0, r4, #0
	bl TextWindowNextLine
	b _02000636
_020005B2:
	ldr r1, [r4, #0x14]
	ldr r0, =gFont1JapanWidths
	cmp r1, r0
	beq _020005C4
	adds r0, r4, #0
	movs r1, #5
	b _020005C8
	.align 2, 0
	.pool
_020005C4:
	adds r0, r4, #0
	movs r1, #8
_020005C8:
	movs r2, #0
	bl TextWindowShiftXY
	b _02000636
_020005D0:
	adds r5, #1
	adds r6, r5, #0
	ldrb r0, [r5]
	cmp r0, #0x14
	beq _020005EA
	cmp r0, #0x14
	bgt _020005E4
	cmp r0, #0xf
	beq _02000620
	b _02000628
_020005E4:
	cmp r0, #0x15
	beq _020005F2
	b _02000628
_020005EA:
	ldrb r0, [r5, #1]
	strb r0, [r4, #0x1c]
	adds r6, r5, #2
	b _02000628
_020005F2:
	ldrb r0, [r4, #9]
	cmp r0, #8
	bne _0200060C
	ldr r0, =gFont1JapanGfx
	str r0, [r4, #0x10]
	ldr r0, =gFont1JapanWidths
	str r0, [r4, #0x14]
	b _02000628
	.align 2, 0
	.pool
_0200060C:
	ldr r0, =gFont0JapanGfx
	str r0, [r4, #0x10]
	ldr r0, =gFont0JapanWidths
	str r0, [r4, #0x14]
	b _02000628
	.align 2, 0
	.pool
_02000620:
	adds r0, r4, #0
	movs r1, #0
	bl ClearWindowCharBuffer
_02000628:
	adds r5, r6, #0
	b _02000636
_0200062C:
	ldrb r2, [r4, #0x18]
	ldrb r3, [r4, #0x19]
	adds r0, r4, #0
	bl DrawGlyphOnWindow_WithShadow
_02000636:
	adds r5, #1
_02000638:
	ldrb r0, [r5]
	cmp r0, #0xff
	bne _02000596
	str r7, [r4, #0x10]
	mov r0, r8
	str r0, [r4, #0x14]
	pop {r3}
	mov r8, r3
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start BufferString
BufferString: @ 0x02000650
	push {lr}
	lsls r0, r0, #5
	ldr r2, =gStringBuffers
	adds r0, r0, r2
	bl StringCopy
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start GetStringWidth
GetStringWidth: @ 0x02000664
	push {r4, lr}
	adds r3, r0, #0
	movs r2, #0
	ldrb r0, [r1]
	cmp r0, #0xff
	beq _02000682
	ldr r3, [r3, #0x14]
_02000672:
	ldrb r4, [r1]
	adds r0, r4, r3
	ldrb r0, [r0]
	adds r2, r0, r2
	adds r1, #1
	ldrb r0, [r1]
	cmp r0, #0xff
	bne _02000672
_02000682:
	adds r0, r2, #0
	pop {r4}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start DrawPartyMonHealthBar
DrawPartyMonHealthBar: @ 0x0200068C
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	mov sb, r0
	adds r7, r1, #0
	mov r8, r2
	adds r4, r3, #0
	ldr r3, =0x0000300A
	bl SetBgTilemapBufferTileAt
	adds r1, r7, #1
	ldr r3, =0x0000300B
	mov r0, sb
	mov r2, r8
	bl SetBgTilemapBufferTileAt
	adds r1, r7, #0
	adds r1, #8
	ldr r3, =0x0000300C
	mov r0, sb
	mov r2, r8
	bl SetBgTilemapBufferTileAt
	ldr r5, =gPlayerPartyPtr
	movs r0, #0x64
	mov sl, r0
	mov r3, sl
	muls r3, r4, r3
	adds r4, r3, #0
	ldr r0, [r5]
	adds r0, r0, r4
	movs r1, #0x39
	movs r2, #0
	bl GetMonData
	adds r6, r0, #0
	ldr r0, [r5]
	adds r0, r0, r4
	movs r1, #0x3a
	movs r2, #0
	bl GetMonData
	adds r1, r0, #0
	cmp r6, r1
	ble _020006EC
	adds r6, r1, #0
_020006EC:
	lsls r0, r1, #2
	adds r0, r0, r1
	lsls r0, r0, #2
	mov r2, sl
	muls r2, r6, r2
	cmp r0, r2
	ble _02000714
	ldr r0, =0x00006001
	b _02000722
	.align 2, 0
	.pool
_02000714:
	movs r0, #0x32
	muls r0, r1, r0
	ldr r3, =0x00004001
	mov sl, r3
	cmp r0, r2
	ble _02000724
	ldr r0, =0x00005001
_02000722:
	mov sl, r0
_02000724:
	lsls r0, r6, #1
	adds r0, r0, r6
	lsls r0, r0, #4
	bl Div
	adds r4, r0, #0
	movs r5, #0
	adds r7, #2
	cmp r4, #8
	ble _02000752
	mov r0, sl
	adds r0, #8
	lsls r6, r0, #0x10
_0200073E:
	adds r1, r7, r5
	mov r0, sb
	mov r2, r8
	lsrs r3, r6, #0x10
	bl SetBgTilemapBufferTileAt
	adds r5, #1
	subs r4, #8
	cmp r4, #8
	bgt _0200073E
_02000752:
	cmp r4, #0
	beq _02000782
	adds r1, r7, r5
	adds r5, #1
	mov r0, sl
	adds r3, r0, r4
	lsls r3, r3, #0x10
	lsrs r3, r3, #0x10
	mov r0, sb
	mov r2, r8
	bl SetBgTilemapBufferTileAt
	b _02000782
	.align 2, 0
	.pool
_02000774:
	adds r1, r7, r5
	mov r0, sb
	mov r2, r8
	mov r3, sl
	bl SetBgTilemapBufferTileAt
	adds r5, #1
_02000782:
	cmp r5, #5
	ble _02000774
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0

	thumb_func_start IsScreenFadedOut
IsScreenFadedOut: @ 0x02000794
	ldr r0, =gScreenIsFadedOut
	ldrb r0, [r0]
	bx lr
	.align 2, 0
	.pool

	thumb_func_start OverrideScreenFadeState
OverrideScreenFadeState: @ 0x020007A0
	ldr r1, =gScreenIsFadedOut
	strb r0, [r1]
	bx lr
	.align 2, 0
	.pool

	thumb_func_start FadeIn
FadeIn: @ 0x020007AC
	push {r4, r5, lr}
	movs r0, #1
	bl DelayFrames
	ldr r2, =0x04000054
	movs r0, #0x1f
	strh r0, [r2]
	ldr r1, =0x04000050
	movs r0, #0xff
	strh r0, [r1]
	movs r4, #0x1d
	adds r5, r2, #0
_020007C4:
	movs r0, #1
	bl DelayFrames
	strh r4, [r5]
	subs r4, #2
	cmp r4, #0
	bgt _020007C4
	ldr r0, =0x04000050
	movs r1, #0
	strh r1, [r0]
	ldr r0, =gScreenIsFadedOut
	strb r1, [r0]
	pop {r4, r5}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start FadeOut
FadeOut: @ 0x020007F0
	push {r4, r5, lr}
	ldr r1, =gScreenIsFadedOut
	movs r0, #1
	strb r0, [r1]
	movs r0, #1
	bl DelayFrames
	ldr r2, =0x04000054
	movs r0, #0
	strh r0, [r2]
	ldr r1, =0x04000050
	movs r0, #0xff
	strh r0, [r1]
	movs r4, #1
	adds r5, r2, #0
_0200080E:
	movs r0, #1
	bl DelayFrames
	strh r4, [r5]
	adds r4, #2
	cmp r4, #0x1f
	ble _0200080E
	ldr r1, =0x04000054
	movs r0, #0x1f
	strh r0, [r1]
	bl ResetSprites
	pop {r4, r5}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start DrawTextWindowBorder
DrawTextWindowBorder: @ 0x02000838
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #4
	adds r5, r2, #0
	adds r7, r3, #0
	ldr r6, [sp, #0x24]
	lsls r1, r1, #6
	lsls r0, r0, #1
	ldr r2, =0x03002000
	adds r0, r0, r2
	adds r2, r1, r0
	strh r6, [r2]
	movs r0, #1
	subs r3, r5, #1
	cmp r0, r3
	bge _02000870
	adds r4, r6, #1
	adds r1, r2, #2
	subs r0, r5, #2
_02000864:
	strh r4, [r1]
	adds r1, #2
	subs r0, #1
	cmp r0, #0
	bne _02000864
	adds r0, r3, #0
_02000870:
	lsls r0, r0, #1
	adds r0, r0, r2
	adds r1, r6, #2
	strh r1, [r0]
	adds r2, #0x40
	movs r1, #1
	subs r3, r7, #1
	subs r5, #1
	adds r0, r6, #6
	mov sl, r0
	adds r0, #2
	str r0, [sp]
	cmp r1, r3
	bge _020008C4
	adds r0, r6, #3
	mov sb, r0
	mov r8, r5
	adds r0, r6, #5
	mov ip, r0
	adds r7, r3, #0
_02000898:
	mov r0, sb
	strh r0, [r2]
	movs r0, #1
	adds r4, r2, #0
	adds r4, #0x40
	adds r3, r1, #1
	cmp r0, r8
	bge _020008B4
	adds r1, r5, #0
	subs r0, r5, #1
_020008AC:
	subs r0, #1
	cmp r0, #0
	bne _020008AC
	adds r0, r1, #0
_020008B4:
	lsls r0, r0, #1
	adds r0, r0, r2
	mov r1, ip
	strh r1, [r0]
	adds r1, r3, #0
	adds r2, r4, #0
	cmp r1, r7
	blt _02000898
_020008C4:
	mov r0, sl
	strh r0, [r2]
	movs r0, #1
	adds r1, r5, #0
	cmp r0, r1
	bge _020008E2
	adds r4, r6, #7
	adds r3, r2, #2
	subs r0, r1, #1
_020008D6:
	strh r4, [r3]
	adds r3, #2
	subs r0, #1
	cmp r0, #0
	bne _020008D6
	adds r0, r1, #0
_020008E2:
	lsls r0, r0, #1
	adds r0, r0, r2
	mov r1, sp
	ldrh r1, [r1]
	strh r1, [r0]
	add sp, #4
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start NumToPmString3CustomZeroChar
NumToPmString3CustomZeroChar: @ 0x02000900
	push {r4, r5, r6, lr}
	adds r5, r0, #0
	adds r4, r1, #0
	adds r6, r2, #0
	movs r1, #0x64
	bl Div
	adds r0, r0, r6
	strb r0, [r4]
	adds r0, r5, #0
	movs r1, #0x64
	bl Mod
	adds r5, r0, #0
	movs r1, #0xa
	bl Div
	adds r0, r0, r6
	strb r0, [r4, #1]
	adds r0, r5, #0
	movs r1, #0xa
	bl Mod
	adds r0, r0, r6
	strb r0, [r4, #2]
	movs r0, #0xff
	strb r0, [r4, #3]
	adds r0, r4, #0
	pop {r4, r5, r6}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start ClearVram
ClearVram: @ 0x02000940
	push {lr}
	sub sp, #4
	movs r0, #0
	str r0, [sp]
	movs r1, #0xc0
	lsls r1, r1, #0x13
	ldr r2, =0x05006000
	mov r0, sp
	bl CpuSet
	bl ResetGpuBuffers
	add sp, #4
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start NumToPmString3RightAlign
NumToPmString3RightAlign: @ 0x02000964
	push {r4, r5, lr}
	adds r5, r0, #0
	adds r4, r1, #0
	adds r0, r4, #0
	movs r1, #0x64
	bl Div
	adds r0, #0xa1
	strb r0, [r5]
	adds r0, r4, #0
	movs r1, #0x64
	bl Mod
	adds r4, r0, #0
	movs r1, #0xa
	bl Div
	adds r0, #0xa1
	strb r0, [r5, #1]
	adds r0, r4, #0
	movs r1, #0xa
	bl Mod
	adds r0, #0xa1
	strb r0, [r5, #2]
	movs r0, #0xff
	strb r0, [r5, #3]
	ldrb r0, [r5, #1]
	cmp r0, #0xff
	beq _020009BA
	ldrb r0, [r5]
	cmp r0, #0xa1
	bne _020009BA
	movs r2, #0
	adds r1, r5, #0
_020009AA:
	strb r2, [r1]
	adds r1, #1
	ldrb r0, [r1, #1]
	cmp r0, #0xff
	beq _020009BA
	ldrb r0, [r1]
	cmp r0, #0xa1
	beq _020009AA
_020009BA:
	adds r0, r5, #0
	pop {r4, r5}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start RenderTextAt
RenderTextAt: @ 0x020009C4
	push {r4, r5, lr}
	adds r4, r0, #0
	adds r5, r3, #0
	bl TextWindowSetXY
	adds r0, r4, #0
	adds r1, r5, #0
	bl RenderText
	pop {r4, r5}
	pop {r0}
	bx r0

	thumb_func_start CreateSomeWindowParameterized
CreateSomeWindowParameterized: @ 0x020009DC
	@ struct Window * CreateSomeWindowParameterized(u32 windowId, u32 left, u32 top, u32 width, u32 height, u8 glyphSize);
	push {r4, r5, r6, r7, lr}
	sub sp, #0x20
	adds r6, r0, #0
	adds r5, r3, #0
	ldr r7, [sp, #0x34]
	ldr r4, [sp, #0x38]
	mov r3, sp
	movs r0, #0
	strb r0, [r3]
	mov r0, sp
	strb r1, [r0, #1]
	strb r2, [r0, #2]
	strb r5, [r0, #3]
	strb r7, [r0, #4]
	mov r1, sp
	ldr r0, =sSomeWindowBaseBlock
	ldrh r0, [r0]
	strh r0, [r1, #6]
	movs r0, #0xf
	strb r0, [r1, #8]
	mov r0, sp
	strb r4, [r0, #9]
	ldrh r0, [r0, #6]
	lsls r0, r0, #5
	ldr r1, =0x06004000
	adds r0, r0, r1
	str r0, [sp, #0xc]
	cmp r4, #8
	bne _02000A30
	ldr r0, =gFont1LatinGfx
	str r0, [sp, #0x10]
	ldr r0, =gFont1LatinWidths
	b _02000A36
	.align 2, 0
	.pool
_02000A30:
	ldr r0, =gFont0LatinGfx
	str r0, [sp, #0x10]
	ldr r0, =gFont0LatinWidths
_02000A36:
	str r0, [sp, #0x14]
	adds r0, r6, #0
	mov r1, sp
	bl AddWindow
	adds r4, r0, #0
	movs r1, #0xf
	movs r2, #1
	bl SetTextColor
	adds r0, r4, #0
	movs r1, #0
	bl ClearWindowCharBuffer
	ldr r1, =sSomeWindowBaseBlock
	adds r0, r5, #0
	muls r0, r7, r0
	ldrh r2, [r1]
	adds r0, r2, r0
	strh r0, [r1]
	adds r0, r4, #0
	add sp, #0x20
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start CreatePartyMonHPWindow
CreatePartyMonHPWindow: @ 0x02000A74
	push {r4, r5, r6, r7, lr}
	sub sp, #0x10
	adds r3, r0, #0
	adds r4, r1, #0
	adds r6, r2, #0
	movs r0, #1
	str r0, [sp]
	movs r0, #8
	str r0, [sp, #4]
	movs r0, #1
	adds r1, r3, #0
	adds r2, r4, #0
	movs r3, #7
	bl CreateSomeWindowParameterized
	adds r7, r0, #0
	movs r1, #0
	bl ClearWindowCharBuffer
	ldr r5, =gPlayerPartyPtr
	movs r0, #0x64
	adds r4, r6, #0
	muls r4, r0, r4
	ldr r0, [r5]
	adds r0, r0, r4
	movs r1, #0x39
	movs r2, #0
	bl GetMonData
	adds r6, r0, #0
	ldr r0, [r5]
	adds r0, r0, r4
	movs r1, #0x3a
	movs r2, #0
	bl GetMonData
	adds r5, r0, #0
	adds r0, r6, #0
	add r1, sp, #8
	movs r2, #0x76
	bl NumToPmString3CustomZeroChar
	add r0, sp, #8
	add r4, sp, #0xc
	ldrb r0, [r0]
	cmp r0, #0x76
	bne _02000AE0
	movs r1, #0xf9
	add r0, sp, #8
_02000AD6:
	strb r1, [r0]
	adds r0, #1
	ldrb r2, [r0]
	cmp r2, #0x76
	beq _02000AD6
_02000AE0:
	add r1, sp, #8
	movs r0, #0x73
	strb r0, [r1, #3]
	cmp r6, #0
	bne _02000AEE
	movs r0, #0x76
	strb r0, [r1, #2]
_02000AEE:
	adds r0, r5, #0
	adds r1, r4, #0
	movs r2, #0x76
	bl NumToPmString3CustomZeroChar
	ldrb r4, [r4]
	cmp r4, #0x76
	bne _02000B0C
	movs r1, #0xf9
	add r0, sp, #0xc
_02000B02:
	strb r1, [r0]
	adds r0, #1
	ldrb r2, [r0]
	cmp r2, #0x76
	beq _02000B02
_02000B0C:
	cmp r5, #0
	bne _02000B16
	add r1, sp, #8
	movs r0, #0x76
	strb r0, [r1, #6]
_02000B16:
	adds r0, r7, #0
	movs r1, #4
	movs r2, #0
	bl TextWindowSetXY
	adds r0, r7, #0
	add r1, sp, #8
	bl RenderText_NoPlaceholders
	adds r0, r7, #0
	add sp, #0x10
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start CreateMonIcon
CreateMonIcon: @ 0x02000B38
	push {r4, r5, lr}
	adds r4, r0, #0
	ldr r0, [r4, #0x18]
	cmp r0, #7
	beq _02000B46
	cmp r0, #0x14
	bne _02000BF0
_02000B46:
	ldr r5, [r4, #0x14]
	ldrb r1, [r5, #3]
	cmp r1, #7
	beq _02000B5A
	movs r0, #0
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x1c]
	adds r0, #1
	str r0, [r4, #0x1c]
	b _02000B66
_02000B5A:
	cmp r0, #7
	bne _02000B62
	movs r0, #8
	b _02000BF2
_02000B62:
	movs r0, #0
	str r0, [r4, #0x18]
_02000B66:
	ldr r1, [r4, #0x1c]
	movs r0, #1
	ands r1, r0
	ldr r0, =gAgbPmRomParams
	ldr r0, [r0]
	ldr r2, [r0, #0x38]
	ldrh r3, [r5, #6]
	lsls r0, r3, #2
	adds r0, r0, r2
	lsls r1, r1, #9
	ldr r0, [r0]
	adds r0, r0, r1
	ldrh r2, [r5, #8]
	lsls r1, r2, #5
	ldr r3, =0x06010000
	adds r1, r1, r3
	movs r2, #0x80
	lsls r2, r2, #1
	bl CpuSet
	ldrb r1, [r5, #1]
	ldrb r2, [r5, #2]
	adds r0, r4, #0
	bl SetSpritePos
	ldr r1, =gUnknown_02021860
	ldr r2, =0x0000011B
	adds r0, r1, r2
	ldrb r0, [r0]
	ldrb r3, [r5]
	cmp r0, r3
	bne _02000BF4
	adds r2, #6
	adds r0, r1, r2
	ldrb r3, [r0]
	cmp r3, #4
	bne _02000BCC
	rsbs r2, r3, #0
	adds r0, r4, #0
	movs r1, #0
	bl AddSpritePos
	b _02000BD6
	.align 2, 0
	.pool
_02000BCC:
	ldrb r1, [r5, #1]
	ldrb r2, [r5, #2]
	adds r0, r4, #0
	bl SetSpritePos
_02000BD6:
	ldr r0, =gUnknown_02021860
	ldr r2, =0x00000121
	adds r1, r0, r2
	movs r0, #4
	ldrb r3, [r1]
	eors r0, r3
	strb r0, [r1]
	b _02000BF4
	.align 2, 0
	.pool
_02000BF0:
	adds r0, #1
_02000BF2:
	str r0, [r4, #0x18]
_02000BF4:
	pop {r4, r5}
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start sub_02000BFC
sub_02000BFC: @ 0x02000BFC
	push {r4, r5, r6, r7, lr}
	mov r7, sb
	mov r6, r8
	push {r6, r7}
	sub sp, #4
	movs r7, #0
	ldr r2, =gUnknown_02021860
	movs r0, #0x92
	lsls r0, r0, #1
	adds r0, r0, r2
	mov r8, r0
	mov r6, sp
	ldr r1, =0x0000011B
	adds r1, r1, r2
	mov sb, r1
_02000C1A:
	movs r0, #0x2c
	muls r0, r7, r0
	adds r1, r0, r2
	adds r4, r1, #0
	adds r4, #0x22
	ldrb r5, [r4]
	mov r3, r8
	ldrb r3, [r3]
	cmp r5, r3
	bne _02000C90
	movs r0, #0
	strb r0, [r4]
	ldr r5, [r1, #0x24]
	adds r0, r5, #0
	movs r1, #0
	bl ClearWindowCharBuffer
	ldrb r0, [r4]
	cmp r0, #0
	bne _02000C5C
	adds r0, r5, #0
	movs r1, #0
	movs r2, #2
	ldr r3, =gText_Space
	bl RenderTextAt
	b _02000C7E
	.align 2, 0
	.pool
_02000C5C:
	adds r0, #0xa1
	strb r0, [r6]
	movs r0, #0xff
	strb r0, [r6, #1]
	movs r0, #0
	mov r1, sp
	bl BufferString
	adds r0, r5, #0
	movs r1, #0
	movs r2, #2
	bl TextWindowSetXY
	adds r0, r5, #0
	ldr r1, =gText_Number
	bl RenderText
_02000C7E:
	mov r5, r8
	ldrb r0, [r5]
	subs r0, #1
	strb r0, [r5]
	mov r0, sb
	strb r7, [r0]
	b _02000C96
	.align 2, 0
	.pool
_02000C90:
	adds r7, #1
	cmp r7, #5
	ble _02000C1A
_02000C96:
	add sp, #4
	pop {r3, r4}
	mov r8, r3
	mov sb, r4
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0

	thumb_func_start sub_02000CA4
sub_02000CA4: @ 0x02000CA4
	push {r4, r5, r6, r7, lr}
	mov r7, sb
	mov r6, r8
	push {r6, r7}
	adds r6, r0, #0
	adds r4, r1, #0
	adds r7, r2, #0
	mov r8, r3
	ldr r0, =gPlayerPartyPtr
	mov sb, r0
	movs r0, #0x64
	adds r5, r4, #0
	muls r5, r0, r5
	mov r1, sb
	ldr r0, [r1]
	adds r0, r0, r5
	movs r1, #0x41
	movs r2, #0
	bl GetMonData
	strh r0, [r6, #4]
	lsls r0, r0, #0x10
	cmp r0, #0
	beq _02000D64
	lsls r0, r4, #4
	adds r0, #0xc0
	strh r0, [r6, #8]
	strb r4, [r6]
	strb r7, [r6, #1]
	mov r2, r8
	strb r2, [r6, #2]
	mov r1, sb
	ldr r0, [r1]
	adds r0, r0, r5
	movs r1, #0
	movs r2, #0
	bl GetMonData
	adds r1, r0, #0
	ldrh r0, [r6, #4]
	bl FixUnownSpecies
	strh r0, [r6, #6]
	ldr r2, =gUnknown_0201F9F4
	adds r0, r7, #0
	mov r1, r8
	bl AddSprite
	adds r4, r0, #0
	str r6, [r4, #0x14]
	ldr r0, =CreateMonIcon
	str r0, [r4, #0x10]
	ldr r5, =gAgbPmRomParams
	ldr r0, [r5]
	ldr r0, [r0, #0x3c]
	ldrh r2, [r6, #4]
	adds r0, r2, r0
	ldrb r1, [r0]
	adds r0, r4, #0
	bl SetSpritePaletteNum
	ldrh r1, [r6, #8]
	adds r0, r4, #0
	bl SetSpriteTileOffset
	ldr r0, [r5]
	ldr r1, [r0, #0x38]
	ldrh r2, [r6, #6]
	lsls r0, r2, #2
	adds r0, r0, r1
	ldr r0, [r0]
	movs r1, #0x80
	lsls r1, r1, #2
	adds r0, r0, r1
	ldrh r2, [r6, #8]
	lsls r1, r2, #5
	ldr r2, =0x06010000
	adds r1, r1, r2
	movs r2, #0x80
	lsls r2, r2, #1
	bl CpuSet
	str r4, [r6, #0xc]
	ldrh r0, [r6, #4]
	b _02000D66
	.align 2, 0
	.pool
_02000D64:
	movs r0, #0
_02000D66:
	pop {r3, r4}
	mov r8, r3
	mov sb, r4
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_02000D74
sub_02000D74: @ 0x02000D74
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #0x5c
	adds r6, r0, #0
	mov r8, r1
	mov sl, r2
	ldrb r1, [r1, #2]
	lsls r0, r1, #2
	ldr r4, =gUnknown_0201F9B0
	adds r5, r0, r4
	movs r0, #0x2c
	mov r2, sl
	muls r2, r0, r2
	adds r0, r2, #0
	adds r0, r0, r6
	mov sb, r0
	mov r3, r8
	ldrb r3, [r3]
	lsls r2, r3, #3
	mov r0, r8
	ldrb r0, [r0, #1]
	lsls r3, r0, #3
	adds r3, #2
	mov r0, sb
	mov r1, sl
	bl sub_02000CA4
	str r0, [sp, #0x54]
	cmp r0, #0
	bne _02000DE0
	adds r5, r4, #0
	adds r5, #8
	mov r2, r8
	ldrb r1, [r2]
	ldrb r2, [r2, #1]
	ldrb r3, [r4, #8]
	ldrb r0, [r5, #1]
	str r0, [sp]
	ldrb r5, [r5, #2]
	lsls r0, r5, #1
	ldr r4, =0x06014000
	adds r0, r0, r4
	str r0, [sp, #4]
	movs r0, #3
	bl CopyToBgTilemapBufferRect
	b _02001236
	.align 2, 0
	.pool
_02000DE0:
	ldr r2, =gPlayerPartyPtr
	movs r0, #0x64
	mov r1, sl
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	bl GetMonStatus
	mov r3, sb
	strb r0, [r3, #3]
	mov r4, r8
	ldrb r1, [r4]
	ldrb r2, [r4, #1]
	ldrb r3, [r5]
	ldrb r0, [r5, #1]
	str r0, [sp]
	ldrb r4, [r5, #2]
	lsls r0, r4, #1
	ldr r4, =0x06014000
	adds r0, r0, r4
	str r0, [sp, #4]
	movs r0, #3
	bl CopyToBgTilemapBufferRect
	mov r0, sb
	ldrb r0, [r0, #3]
	cmp r0, #7
	beq _02000E40
	ldr r1, =0x0000011B
	adds r0, r6, r1
	ldrb r0, [r0]
	cmp r0, sl
	bne _02000E7E
	mov r2, r8
	ldrb r1, [r2]
	ldrb r2, [r2, #1]
	ldrb r3, [r5]
	ldrb r0, [r5, #1]
	str r0, [sp]
	movs r0, #7
	b _02000E58
	.align 2, 0
	.pool
_02000E40:
	ldr r3, =0x0000011B
	adds r0, r6, r3
	ldrb r0, [r0]
	cmp r0, sl
	bne _02000E68
	mov r4, r8
	ldrb r1, [r4]
	ldrb r2, [r4, #1]
	ldrb r3, [r5]
	ldrb r0, [r5, #1]
	str r0, [sp]
	movs r0, #9
_02000E58:
	str r0, [sp, #4]
	movs r0, #3
	bl SetBgTilemapBufferPaletteRect
	b _02000E7E
	.align 2, 0
	.pool
_02000E68:
	mov r0, r8
	ldrb r1, [r0]
	ldrb r2, [r0, #1]
	ldrb r3, [r5]
	ldrb r0, [r5, #1]
	str r0, [sp]
	movs r0, #5
	str r0, [sp, #4]
	movs r0, #3
	bl SetBgTilemapBufferPaletteRect
_02000E7E:
	mov r2, r8
	ldrb r1, [r2]
	adds r1, #4
	ldrb r2, [r2, #1]
	adds r2, #1
	ldr r0, =gAgbPmRomParams
	ldr r0, [r0]
	adds r0, #0x77
	ldrb r3, [r0]
	movs r0, #2
	str r0, [sp]
	movs r0, #8
	str r0, [sp, #4]
	movs r0, #1
	bl CreateSomeWindowParameterized
	mov r3, sb
	str r0, [r3, #0x14]
	ldr r4, =gPlayerPartyPtr
	movs r0, #0x64
	mov r1, sl
	muls r1, r0, r1
	ldr r0, [r4]
	adds r0, r0, r1
	movs r1, #2
	add r2, sp, #8
	bl GetMonData
	add r0, sp, #8
	bl GetStringSizeHandleExtCtrlCodes
	lsls r0, r0, #0x10
	add r3, sp, #8
	add r7, sp, #0x20
	lsrs r5, r0, #0x10
	ldrb r0, [r3]
	adds r1, r0, #0
	cmp r1, #0xfc
	beq _02000F18
	movs r6, #0
	mov r4, sp
	adds r4, r4, r5
	adds r4, #0x20
	mov ip, r4
	lsls r5, r5, #1
	str r5, [sp, #0x58]
	cmp r1, #0xff
	beq _02000EFC
	ldr r5, =gUnknown_0201F6B0
_02000EE0:
	ldrb r1, [r3]
	lsls r0, r1, #1
	adds r0, r0, r5
	ldrh r2, [r0]
	adds r1, r7, r6
	lsrs r0, r2, #8
	strb r0, [r1]
	strb r2, [r4, #1]
	adds r3, #1
	adds r4, #1
	adds r6, #1
	ldrb r0, [r3]
	cmp r0, #0xff
	bne _02000EE0
_02000EFC:
	movs r0, #0xfe
	mov r2, ip
	strb r0, [r2]
	ldr r3, [sp, #0x58]
	adds r1, r3, r7
	movs r0, #0xff
	strb r0, [r1, #1]
	b _02000F6A
	.align 2, 0
	.pool
_02000F18:
	add r1, sp, #0x20
	strb r0, [r1]
	mov r3, sp
	adds r3, #9
	ldrb r0, [r3]
	movs r2, #0x21
	add r2, sp
	strb r0, [r2]
	adds r3, #1
	subs r5, #2
	movs r6, #2
	ldrb r0, [r3]
	cmp r0, #0xff
	beq _02000F5C
	ldr r4, =gUnknown_0201F4B0
	mov ip, r4
	adds r0, r5, #0
	add r0, sp
	adds r0, #0x20
	adds r4, r0, #2
_02000F40:
	ldrb r1, [r3]
	lsls r0, r1, #1
	add r0, ip
	ldrh r2, [r0]
	adds r1, r7, r6
	lsrs r0, r2, #8
	strb r0, [r1]
	strb r2, [r4, #1]
	adds r3, #1
	adds r4, #1
	adds r6, #1
	ldrb r0, [r3]
	cmp r0, #0xff
	bne _02000F40
_02000F5C:
	adds r1, r5, r7
	movs r0, #0xfe
	strb r0, [r1, #2]
	lsls r0, r5, #1
	adds r0, r0, r7
	movs r1, #0xff
	strb r1, [r0, #3]
_02000F6A:
	movs r0, #0x64
	mov r1, sl
	muls r1, r0, r1
	ldr r2, =gPlayerPartyPtr
	ldr r0, [r2]
	adds r0, r0, r1
	movs r1, #3
	add r2, sp, #8
	bl GetMonData
	cmp r0, #1
	beq _02000F94
	mov r3, sb
	ldr r1, [r3, #0x14]
	movs r0, #1
	b _02000F9A
	.align 2, 0
	.pool
_02000F94:
	mov r4, sb
	ldr r1, [r4, #0x14]
	movs r0, #2
_02000F9A:
	strb r0, [r1, #0x1d]
	mov r1, sb
	ldr r0, [r1, #0x14]
	ldrb r1, [r0, #0x1d]
	movs r2, #0
	bl TextWindowSetXY
	mov r2, sb
	ldr r0, [r2, #0x14]
	add r1, sp, #0x20
	bl RenderText_NoPlaceholders
	mov r3, sb
	ldrb r0, [r3, #3]
	cmp r0, #0
	beq _02000FBE
	cmp r0, #6
	bne _02001048
_02000FBE:
	mov r4, r8
	ldrb r1, [r4]
	adds r1, #6
	ldrb r2, [r4, #1]
	adds r2, #3
	movs r0, #1
	str r0, [sp]
	movs r0, #8
	str r0, [sp, #4]
	movs r0, #1
	movs r3, #3
	bl CreateSomeWindowParameterized
	adds r6, r0, #0
	ldr r2, =gPlayerPartyPtr
	movs r0, #0x64
	mov r1, sl
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	movs r1, #0x38
	movs r2, #0
	bl GetMonData
	adds r5, r0, #0
	add r4, sp, #0x4c
	movs r0, #0x60
	strb r0, [r4]
	movs r0, #0xff
	strb r0, [r4, #1]
	adds r0, r6, #0
	movs r1, #0
	movs r2, #0
	bl TextWindowSetXY
	adds r0, r6, #0
	adds r1, r4, #0
	bl RenderText
	adds r0, r5, #0
	adds r1, r4, #0
	movs r2, #0x76
	bl NumToPmString3CustomZeroChar
	movs r1, #0
	ldrb r0, [r4]
	cmp r0, #0x76
	bne _0200102A
	adds r2, r4, #0
_02001020:
	adds r1, #1
	adds r0, r2, r1
	ldrb r0, [r0]
	cmp r0, #0x76
	beq _02001020
_0200102A:
	adds r0, r4, r1
	ldrb r0, [r0]
	cmp r0, #0xff
	bne _02001034
	subs r1, #1
_02001034:
	adds r1, r4, r1
	adds r0, r6, #0
	bl RenderText_NoPlaceholders
	mov r1, sb
	str r6, [r1, #0x18]
	b _0200107A
	.align 2, 0
	.pool
_02001048:
	movs r4, #0
_0200104A:
	mov r2, sb
	ldrb r2, [r2, #3]
	lsls r3, r2, #2
	ldr r0, =0x0000B05C
	adds r3, r3, r0
	adds r3, r4, r3
	adds r1, r4, #5
	mov r2, r8
	ldrb r2, [r2]
	adds r1, r2, r1
	mov r0, r8
	ldrb r2, [r0, #1]
	adds r2, #3
	lsls r3, r3, #0x10
	lsrs r3, r3, #0x10
	movs r0, #0
	bl SetBgTilemapBufferTileAt
	adds r4, #1
	cmp r4, #3
	ble _0200104A
	ldr r1, =gBgTilemapBufferTransferScheduled
	movs r0, #1
	strb r0, [r1]
_0200107A:
	ldr r1, [sp, #0x54]
	cmp r1, #0x20
	beq _020010CE
	cmp r1, #0x1d
	beq _020010CE
	mov r2, r8
	ldrb r4, [r2]
	adds r4, #9
	ldrb r5, [r2, #1]
	adds r5, #3
	ldr r2, =gPlayerPartyPtr
	movs r0, #0x64
	mov r1, sl
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	bl GetMonGender
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	cmp r0, #0
	beq _020010BC
	cmp r0, #0xfe
	beq _020010C0
	movs r3, #0
	b _020010C2
	.align 2, 0
	.pool
_020010BC:
	movs r3, #0xf
	b _020010C2
_020010C0:
	movs r3, #0x11
_020010C2:
	movs r0, #0
	adds r1, r4, #0
	adds r2, r5, #0
	bl SetBgTilemapBufferTileAt
	b _02001120
_020010CE:
	add r0, sp, #0x20
	ldr r1, [sp, #0x54]
	bl GetSpeciesName
	add r0, sp, #8
	add r1, sp, #0x20
	bl StringCompare
	cmp r0, #0
	beq _02001120
	mov r3, r8
	ldrb r4, [r3]
	adds r4, #9
	ldrb r5, [r3, #1]
	adds r5, #3
	ldr r2, =gPlayerPartyPtr
	movs r0, #0x64
	mov r1, sl
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	bl GetMonGender
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	cmp r0, #0
	beq _02001110
	cmp r0, #0xfe
	beq _02001114
	movs r3, #0
	b _02001116
	.align 2, 0
	.pool
_02001110:
	movs r3, #0xf
	b _02001116
_02001114:
	movs r3, #0x11
_02001116:
	movs r0, #0
	adds r1, r4, #0
	adds r2, r5, #0
	bl SetBgTilemapBufferTileAt
_02001120:
	ldr r4, =gUnknown_02021860
	movs r1, #0x8c
	lsls r1, r1, #1
	adds r0, r4, r1
	ldrb r0, [r0]
	cmp r0, #0
	bne _02001178
	mov r2, r8
	ldrb r0, [r2]
	adds r0, #5
	ldrb r1, [r2, #1]
	adds r1, #5
	mov r2, sl
	bl CreatePartyMonHPWindow
	mov r3, sb
	str r0, [r3, #0x1c]
	mov r0, r8
	ldrb r1, [r0]
	adds r1, #2
	ldrb r2, [r0, #1]
	adds r2, #4
	movs r0, #0
	mov r3, sl
	bl DrawPartyMonHealthBar
	movs r0, #0x2c
	mov r1, sl
	muls r1, r0, r1
	adds r0, r1, #0
	adds r0, r0, r4
	mov r3, r8
	ldrb r2, [r3]
	adds r2, #2
	adds r1, r0, #0
	adds r1, #0x20
	strb r2, [r1]
	ldrb r1, [r3, #1]
	adds r1, #4
	adds r0, #0x21
	strb r1, [r0]
	b _020011F2
	.align 2, 0
	.pool
_02001178:
	mov r4, r8
	ldrb r0, [r4]
	adds r0, #3
	mov r1, sb
	adds r1, #0x20
	strb r0, [r1]
	ldrb r0, [r4, #1]
	adds r0, #4
	mov r2, sb
	adds r2, #0x21
	strb r0, [r2]
	mov r0, sl
	adds r0, #5
	ldrb r1, [r1]
	ldrb r2, [r2]
	movs r3, #2
	str r3, [sp]
	movs r3, #0x10
	str r3, [sp, #4]
	movs r3, #6
	bl CreateSomeWindowParameterized
	adds r4, r0, #0
	mov r0, sb
	str r4, [r0, #0x24]
	adds r0, r4, #0
	movs r1, #0
	bl ClearWindowCharBuffer
	mov r0, sb
	adds r0, #0x22
	ldrb r0, [r0]
	cmp r0, #0
	bne _020011D0
	ldr r3, =gText_Space
	adds r0, r4, #0
	movs r1, #0
	movs r2, #2
	bl RenderTextAt
	b _020011F2
	.align 2, 0
	.pool
_020011D0:
	add r1, sp, #0x4c
	adds r0, #0xa1
	strb r0, [r1]
	movs r0, #0xff
	strb r0, [r1, #1]
	movs r0, #0
	bl BufferString
	adds r0, r4, #0
	movs r1, #0
	movs r2, #2
	bl TextWindowSetXY
	ldr r1, =gText_Number
	adds r0, r4, #0
	bl RenderText
_020011F2:
	ldr r2, =gPlayerPartyPtr
	movs r0, #0x64
	mov r1, sl
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	movs r1, #0xc
	movs r2, #0
	bl GetMonData
	cmp r0, #0
	beq _0200122A
	mov r1, r8
	ldrb r1, [r1]
	lsls r0, r1, #3
	adds r0, #0x18
	mov r2, r8
	ldrb r2, [r2, #1]
	lsls r1, r2, #3
	adds r1, #0x15
	ldr r2, =gUnknown_0201F958
	bl AddSprite
	mov r3, sb
	str r0, [r3, #0x28]
	movs r1, #0xc
	bl SetSpritePaletteNum
_0200122A:
	ldr r0, =gUnknown_02021860
	movs r4, #0x90
	lsls r4, r4, #1
	adds r0, r0, r4
	mov r1, sl
	strb r1, [r0]
_02001236:
	add sp, #0x5c
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02001258
sub_02001258: @ 0x02001258
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #0x5c
	adds r6, r0, #0
	mov r8, r1
	mov sl, r2
	ldrb r1, [r1, #2]
	lsls r0, r1, #2
	ldr r4, =gUnknown_0201F9B0
	adds r5, r0, r4
	movs r0, #0x2c
	mov r2, sl
	muls r2, r0, r2
	adds r0, r2, #0
	adds r0, r0, r6
	mov sb, r0
	mov r3, r8
	ldrb r3, [r3]
	lsls r2, r3, #3
	subs r2, #1
	mov r0, r8
	ldrb r3, [r0, #1]
	subs r3, #1
	lsls r3, r3, #3
	adds r3, #2
	mov r0, sb
	mov r1, sl
	bl sub_02000CA4
	str r0, [sp, #0x54]
	cmp r0, #0
	bne _020012C8
	adds r5, r4, #0
	adds r5, #8
	mov r2, r8
	ldrb r1, [r2]
	ldrb r2, [r2, #1]
	ldrb r3, [r4, #8]
	ldrb r0, [r5, #1]
	str r0, [sp]
	ldrb r5, [r5, #2]
	lsls r0, r5, #1
	ldr r4, =0x06014000
	adds r0, r0, r4
	str r0, [sp, #4]
	movs r0, #3
	bl CopyToBgTilemapBufferRect
	b _02001714
	.align 2, 0
	.pool
_020012C8:
	ldr r2, =gPlayerPartyPtr
	movs r0, #0x64
	mov r1, sl
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	bl GetMonStatus
	mov r3, sb
	strb r0, [r3, #3]
	mov r4, r8
	ldrb r1, [r4]
	ldrb r2, [r4, #1]
	ldrb r3, [r5]
	ldrb r0, [r5, #1]
	str r0, [sp]
	ldrb r4, [r5, #2]
	lsls r0, r4, #1
	ldr r4, =0x06014000
	adds r0, r0, r4
	str r0, [sp, #4]
	movs r0, #3
	bl CopyToBgTilemapBufferRect
	mov r0, sb
	ldrb r0, [r0, #3]
	cmp r0, #7
	beq _02001328
	ldr r1, =0x0000011B
	adds r0, r6, r1
	ldrb r0, [r0]
	cmp r0, sl
	bne _02001366
	mov r2, r8
	ldrb r1, [r2]
	ldrb r2, [r2, #1]
	ldrb r3, [r5]
	ldrb r0, [r5, #1]
	str r0, [sp]
	movs r0, #7
	b _02001340
	.align 2, 0
	.pool
_02001328:
	ldr r3, =0x0000011B
	adds r0, r6, r3
	ldrb r0, [r0]
	cmp r0, sl
	bne _02001350
	mov r4, r8
	ldrb r1, [r4]
	ldrb r2, [r4, #1]
	ldrb r3, [r5]
	ldrb r0, [r5, #1]
	str r0, [sp]
	movs r0, #9
_02001340:
	str r0, [sp, #4]
	movs r0, #3
	bl SetBgTilemapBufferPaletteRect
	b _02001366
	.align 2, 0
	.pool
_02001350:
	mov r0, r8
	ldrb r1, [r0]
	ldrb r2, [r0, #1]
	ldrb r3, [r5]
	ldrb r0, [r5, #1]
	str r0, [sp]
	movs r0, #5
	str r0, [sp, #4]
	movs r0, #3
	bl SetBgTilemapBufferPaletteRect
_02001366:
	mov r2, r8
	ldrb r1, [r2]
	adds r1, #3
	ldrb r2, [r2, #1]
	ldr r0, =gAgbPmRomParams
	ldr r0, [r0]
	adds r0, #0x77
	ldrb r3, [r0]
	movs r0, #2
	str r0, [sp]
	movs r0, #8
	str r0, [sp, #4]
	movs r0, #1
	bl CreateSomeWindowParameterized
	mov r3, sb
	str r0, [r3, #0x14]
	ldr r4, =gPlayerPartyPtr
	movs r0, #0x64
	mov r1, sl
	muls r1, r0, r1
	ldr r0, [r4]
	adds r0, r0, r1
	movs r1, #2
	add r2, sp, #8
	bl GetMonData
	add r0, sp, #8
	bl GetStringSizeHandleExtCtrlCodes
	lsls r0, r0, #0x10
	add r3, sp, #8
	add r7, sp, #0x20
	lsrs r5, r0, #0x10
	ldrb r0, [r3]
	adds r1, r0, #0
	cmp r1, #0xfc
	beq _02001400
	movs r6, #0
	mov r4, sp
	adds r4, r4, r5
	adds r4, #0x20
	mov ip, r4
	lsls r5, r5, #1
	str r5, [sp, #0x58]
	cmp r1, #0xff
	beq _020013E2
	ldr r5, =gUnknown_0201F6B0
_020013C6:
	ldrb r1, [r3]
	lsls r0, r1, #1
	adds r0, r0, r5
	ldrh r2, [r0]
	adds r1, r7, r6
	lsrs r0, r2, #8
	strb r0, [r1]
	strb r2, [r4, #1]
	adds r3, #1
	adds r4, #1
	adds r6, #1
	ldrb r0, [r3]
	cmp r0, #0xff
	bne _020013C6
_020013E2:
	movs r0, #0xfe
	mov r2, ip
	strb r0, [r2]
	ldr r3, [sp, #0x58]
	adds r1, r3, r7
	movs r0, #0xff
	strb r0, [r1, #1]
	b _02001452
	.align 2, 0
	.pool
_02001400:
	add r1, sp, #0x20
	strb r0, [r1]
	mov r3, sp
	adds r3, #9
	ldrb r0, [r3]
	movs r2, #0x21
	add r2, sp
	strb r0, [r2]
	adds r3, #1
	subs r5, #2
	movs r6, #2
	ldrb r0, [r3]
	cmp r0, #0xff
	beq _02001444
	ldr r4, =gUnknown_0201F4B0
	mov ip, r4
	adds r0, r5, #0
	add r0, sp
	adds r0, #0x20
	adds r4, r0, #2
_02001428:
	ldrb r1, [r3]
	lsls r0, r1, #1
	add r0, ip
	ldrh r2, [r0]
	adds r1, r7, r6
	lsrs r0, r2, #8
	strb r0, [r1]
	strb r2, [r4, #1]
	adds r3, #1
	adds r4, #1
	adds r6, #1
	ldrb r0, [r3]
	cmp r0, #0xff
	bne _02001428
_02001444:
	adds r1, r5, r7
	movs r0, #0xfe
	strb r0, [r1, #2]
	lsls r0, r5, #1
	adds r0, r0, r7
	movs r1, #0xff
	strb r1, [r0, #3]
_02001452:
	movs r0, #0x64
	mov r1, sl
	muls r1, r0, r1
	ldr r2, =gPlayerPartyPtr
	ldr r0, [r2]
	adds r0, r0, r1
	movs r1, #3
	add r2, sp, #8
	bl GetMonData
	cmp r0, #1
	beq _0200147C
	mov r3, sb
	ldr r1, [r3, #0x14]
	movs r0, #6
	b _02001482
	.align 2, 0
	.pool
_0200147C:
	mov r4, sb
	ldr r1, [r4, #0x14]
	movs r0, #8
_02001482:
	strb r0, [r1, #0x1d]
	mov r1, sb
	ldr r0, [r1, #0x14]
	ldrb r1, [r0, #0x1d]
	movs r2, #0
	bl TextWindowSetXY
	mov r2, sb
	ldr r0, [r2, #0x14]
	add r1, sp, #0x20
	bl RenderText_NoPlaceholders
	mov r3, sb
	ldrb r0, [r3, #3]
	cmp r0, #0
	beq _020014A6
	cmp r0, #6
	bne _02001530
_020014A6:
	mov r4, r8
	ldrb r1, [r4]
	adds r1, #6
	ldrb r2, [r4, #1]
	adds r2, #2
	movs r0, #1
	str r0, [sp]
	movs r0, #8
	str r0, [sp, #4]
	movs r0, #1
	movs r3, #3
	bl CreateSomeWindowParameterized
	adds r6, r0, #0
	ldr r2, =gPlayerPartyPtr
	movs r0, #0x64
	mov r1, sl
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	movs r1, #0x38
	movs r2, #0
	bl GetMonData
	adds r5, r0, #0
	add r4, sp, #0x4c
	movs r0, #0x60
	strb r0, [r4]
	movs r0, #0xff
	strb r0, [r4, #1]
	adds r0, r6, #0
	movs r1, #0
	movs r2, #0
	bl TextWindowSetXY
	adds r0, r6, #0
	adds r1, r4, #0
	bl RenderText
	adds r0, r5, #0
	adds r1, r4, #0
	movs r2, #0x76
	bl NumToPmString3CustomZeroChar
	movs r1, #0
	ldrb r0, [r4]
	cmp r0, #0x76
	bne _02001512
	adds r2, r4, #0
_02001508:
	adds r1, #1
	adds r0, r2, r1
	ldrb r0, [r0]
	cmp r0, #0x76
	beq _02001508
_02001512:
	adds r0, r4, r1
	ldrb r0, [r0]
	cmp r0, #0xff
	bne _0200151C
	subs r1, #1
_0200151C:
	adds r1, r4, r1
	adds r0, r6, #0
	bl RenderText_NoPlaceholders
	mov r1, sb
	str r6, [r1, #0x18]
	b _0200155C
	.align 2, 0
	.pool
_02001530:
	movs r4, #0
_02001532:
	mov r2, sb
	ldrb r2, [r2, #3]
	lsls r3, r2, #2
	ldr r0, =0x0000B05C
	adds r3, r3, r0
	adds r3, r4, r3
	adds r1, r4, #5
	mov r2, r8
	ldrb r2, [r2]
	adds r1, r2, r1
	mov r0, r8
	ldrb r2, [r0, #1]
	adds r2, #2
	lsls r3, r3, #0x10
	lsrs r3, r3, #0x10
	movs r0, #0
	bl SetBgTilemapBufferTileAt
	adds r4, #1
	cmp r4, #3
	ble _02001532
_0200155C:
	ldr r1, [sp, #0x54]
	cmp r1, #0x20
	beq _020015AA
	cmp r1, #0x1d
	beq _020015AA
	mov r2, r8
	ldrb r4, [r2]
	adds r4, #9
	ldrb r5, [r2, #1]
	adds r5, #2
	ldr r2, =gPlayerPartyPtr
	movs r0, #0x64
	mov r1, sl
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	bl GetMonGender
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	cmp r0, #0
	beq _02001598
	cmp r0, #0xfe
	beq _0200159C
	movs r3, #0
	b _0200159E
	.align 2, 0
	.pool
_02001598:
	movs r3, #0xf
	b _0200159E
_0200159C:
	movs r3, #0x11
_0200159E:
	movs r0, #0
	adds r1, r4, #0
	adds r2, r5, #0
	bl SetBgTilemapBufferTileAt
	b _020015FC
_020015AA:
	add r0, sp, #0x20
	ldr r1, [sp, #0x54]
	bl GetSpeciesName
	add r0, sp, #8
	add r1, sp, #0x20
	bl StringCompare
	cmp r0, #0
	beq _020015FC
	mov r3, r8
	ldrb r4, [r3]
	adds r4, #9
	ldrb r5, [r3, #1]
	adds r5, #2
	ldr r2, =gPlayerPartyPtr
	movs r0, #0x64
	mov r1, sl
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	bl GetMonGender
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	cmp r0, #0
	beq _020015EC
	cmp r0, #0xfe
	beq _020015F0
	movs r3, #0
	b _020015F2
	.align 2, 0
	.pool
_020015EC:
	movs r3, #0xf
	b _020015F2
_020015F0:
	movs r3, #0x11
_020015F2:
	movs r0, #0
	adds r1, r4, #0
	adds r2, r5, #0
	bl SetBgTilemapBufferTileAt
_020015FC:
	ldr r4, =gUnknown_02021860
	movs r1, #0x8c
	lsls r1, r1, #1
	adds r0, r4, r1
	ldrb r0, [r0]
	cmp r0, #0
	bne _02001654
	mov r2, r8
	ldrb r0, [r2]
	adds r0, #0xd
	ldrb r1, [r2, #1]
	adds r1, #2
	mov r2, sl
	bl CreatePartyMonHPWindow
	mov r3, sb
	str r0, [r3, #0x1c]
	mov r0, r8
	ldrb r1, [r0]
	adds r1, #0xa
	ldrb r2, [r0, #1]
	adds r2, #1
	movs r0, #0
	mov r3, sl
	bl DrawPartyMonHealthBar
	movs r0, #0x2c
	mov r1, sl
	muls r1, r0, r1
	adds r0, r1, #0
	adds r0, r0, r4
	mov r3, r8
	ldrb r2, [r3]
	adds r2, #0xa
	adds r1, r0, #0
	adds r1, #0x20
	strb r2, [r1]
	ldrb r1, [r3, #1]
	adds r1, #1
	adds r0, #0x21
	strb r1, [r0]
	b _020016CA
	.align 2, 0
	.pool
_02001654:
	mov r4, r8
	ldrb r0, [r4]
	adds r0, #0xb
	mov r1, sb
	adds r1, #0x20
	strb r0, [r1]
	ldrb r0, [r4, #1]
	mov r2, sb
	adds r2, #0x21
	strb r0, [r2]
	mov r0, sl
	adds r0, #5
	ldrb r1, [r1]
	ldrb r2, [r2]
	movs r3, #2
	str r3, [sp]
	movs r3, #0x10
	str r3, [sp, #4]
	movs r3, #6
	bl CreateSomeWindowParameterized
	adds r4, r0, #0
	mov r0, sb
	str r4, [r0, #0x24]
	adds r0, r4, #0
	movs r1, #0
	bl ClearWindowCharBuffer
	mov r0, sb
	adds r0, #0x22
	ldrb r0, [r0]
	cmp r0, #0
	bne _020016A8
	ldr r3, =gText_Space
	adds r0, r4, #0
	movs r1, #0
	movs r2, #2
	bl RenderTextAt
	b _020016CA
	.align 2, 0
	.pool
_020016A8:
	add r1, sp, #0x4c
	adds r0, #0xa1
	strb r0, [r1]
	movs r0, #0xff
	strb r0, [r1, #1]
	movs r0, #0
	bl BufferString
	adds r0, r4, #0
	movs r1, #0
	movs r2, #2
	bl TextWindowSetXY
	ldr r1, =gText_Number
	adds r0, r4, #0
	bl RenderText
_020016CA:
	ldr r2, =gPlayerPartyPtr
	movs r0, #0x64
	mov r1, sl
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	movs r1, #0xc
	movs r2, #0
	bl GetMonData
	cmp r0, #0
	beq _02001702
	mov r1, r8
	ldrb r1, [r1]
	lsls r0, r1, #3
	adds r0, #0x18
	mov r2, r8
	ldrb r2, [r2, #1]
	lsls r1, r2, #3
	adds r1, #0xf
	ldr r2, =gUnknown_0201F958
	bl AddSprite
	mov r3, sb
	str r0, [r3, #0x28]
	movs r1, #0xc
	bl SetSpritePaletteNum
_02001702:
	ldr r0, =gUnknown_02021860
	movs r4, #0x90
	lsls r4, r4, #1
	adds r0, r0, r4
	mov r1, sl
	strb r1, [r0]
	ldr r1, =gBgTilemapBufferTransferScheduled
	movs r0, #1
	strb r0, [r1]
_02001714:
	add sp, #0x5c
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02001738
sub_02001738: @ 0x02001738
	push {r4, r5, r6, lr}
	sub sp, #0xc
	adds r6, r0, #0
	ldr r0, =0x0000E001
	str r0, [sp]
	movs r0, #0
	movs r1, #0x10
	movs r2, #0x18
	movs r3, #4
	bl DrawTextWindowBorder
	ldr r1, =gBgTilemapBufferTransferScheduled
	movs r0, #1
	strb r0, [r1, #2]
	ldr r1, =gUnknown_0201F8B0
	movs r0, #0
	bl AddWindow
	ldr r4, =gUnknown_02021860
	movs r1, #0x84
	lsls r1, r1, #1
	adds r5, r4, r1
	str r0, [r5]
	movs r1, #1
	movs r2, #8
	bl SetTextColor
	ldr r0, [r5]
	ldr r1, =0x0000FFFF
	bl ClearWindowCharBuffer
	ldr r1, =0x00000123
	adds r0, r4, r1
	ldrb r0, [r0]
	cmp r0, #0
	beq _020017D4
	cmp r6, #0
	beq _020017A4
	cmp r6, #1
	beq _020017C4
	b _020017DC
	.align 2, 0
	.pool
_020017A4:
	add r1, sp, #4
	adds r0, #0xa1
	strb r0, [r1]
	movs r0, #0xff
	strb r0, [r1, #1]
	movs r0, #0
	bl BufferString
	ldr r0, [r5]
	ldr r1, =gText_SelectNumberPokemon
	bl RenderText
	b _020017DC
	.align 2, 0
	.pool
_020017C4:
	ldr r0, [r5]
	ldr r1, =gText_SelectAdditionalPokemon
	bl RenderText
	b _020017DC
	.align 2, 0
	.pool
_020017D4:
	ldr r0, [r5]
	ldr r1, =gText_SelectPokemon
	bl RenderText
_020017DC:
	add sp, #0xc
	pop {r4, r5, r6}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_020017E8
sub_020017E8: @ 0x020017E8
	push {r4, r5, r6, lr}
	sub sp, #0xc
	adds r6, r0, #0
	ldr r1, =sSomeWindowBaseBlock
	movs r0, #0x80
	strh r0, [r1]
	bl ClearVram
	movs r1, #0x80
	lsls r1, r1, #0x13
	movs r2, #0xfa
	lsls r2, r2, #5
	adds r0, r2, #0
	strh r0, [r1]
	adds r1, #8
	ldr r2, =0x00001C06
	adds r0, r2, #0
	strh r0, [r1]
	adds r1, #2
	adds r2, #0xfd
	adds r0, r2, #0
	strh r0, [r1]
	adds r1, #2
	ldr r2, =0x00001E08
	adds r0, r2, #0
	strh r0, [r1]
	adds r1, #2
	adds r2, #0xfa
	adds r0, r2, #0
	strh r0, [r1]
	movs r2, #1
	rsbs r2, r2, #0
	movs r0, #3
	movs r1, #0
	bl SetBgPos
	ldr r0, =gUnknown_0201B1A0
	movs r1, #0xa0
	lsls r1, r1, #0x13
	bl AutoUnCompVram
	ldr r0, =gMonInfoIcons_Gfx
	ldr r1, =0x06004000
	bl AutoUnCompVram
	ldr r0, =gPartyMenu_Gfx
	movs r1, #0xc0
	lsls r1, r1, #0x13
	bl AutoUnCompVram
	ldr r0, =gMessageBox_Gfx
	ldr r1, =0x06008000
	bl AutoUnCompVram
	ldr r0, =gPartyMenu_Tilemap
	ldr r1, =0x03001000
	bl AutoUnCompVram
	ldr r0, =gTypeStatusIcons_Pal
	ldr r1, =0x05000200
	bl AutoUnCompVram
	ldr r0, =gTypeStatusIcons_Gfx
	ldr r1, =0x06010000
	bl AutoUnCompVram
	ldr r0, =gUnknown_02021860
	movs r1, #0x8c
	lsls r1, r1, #1
	adds r0, r0, r1
	ldrb r0, [r0]
	adds r5, r0, #0
	cmp r0, #1
	beq _02001904
	cmp r0, #1
	bgt _020018C8
	cmp r0, #0
	beq _020018CE
	b _0200191C
	.align 2, 0
	.pool
_020018C8:
	cmp r0, #2
	beq _020018D8
	b _0200191C
_020018CE:
	movs r0, #2
	str r0, [sp]
	movs r0, #0x18
	str r0, [sp, #4]
	b _020018F2
_020018D8:
	str r5, [sp]
	movs r4, #0x18
	str r4, [sp, #4]
	movs r0, #0x10
	str r0, [sp, #8]
	movs r0, #1
	movs r1, #0xc
	movs r2, #0x14
	movs r3, #6
	bl CopyRectWithinBgTilemapBuffer
	str r5, [sp]
	str r4, [sp, #4]
_020018F2:
	movs r0, #0x12
	str r0, [sp, #8]
	movs r0, #1
	movs r1, #0
	movs r2, #0x14
	movs r3, #6
	bl CopyRectWithinBgTilemapBuffer
	b _0200191C
_02001904:
	movs r0, #2
	str r0, [sp]
	movs r0, #0x18
	str r0, [sp, #4]
	movs r0, #0x12
	str r0, [sp, #8]
	movs r0, #1
	movs r1, #0xc
	movs r2, #0x14
	movs r3, #6
	bl CopyRectWithinBgTilemapBuffer
_0200191C:
	ldr r1, =gBgTilemapBufferTransferScheduled
	movs r0, #1
	strb r0, [r1, #1]
	ldr r0, =gAgbPmRomParams
	ldr r0, [r0]
	ldr r0, [r0, #0x40]
	ldr r1, =0x040000D4
	ldr r0, [r0]
	str r0, [r1]
	ldr r0, =0x05000200
	str r0, [r1, #4]
	ldr r0, =0x80000030
	str r0, [r1, #8]
	ldr r0, [r1, #8]
	ldr r0, =gPartySlots_Tilemap
	ldr r1, =0x06014000
	bl AutoUnCompVram
	movs r2, #0x8d
	lsls r2, r2, #1
	adds r0, r6, r2
	ldrb r0, [r0]
	ldr r5, =gUnknown_0201F9D4
	cmp r0, #0
	bne _02001950
	ldr r5, =gUnknown_0201F9BC
_02001950:
	movs r4, #0
_02001952:
	ldrb r0, [r5, #2]
	cmp r0, #0
	bne _02001988
	adds r0, r6, #0
	adds r1, r5, #0
	adds r2, r4, #0
	bl sub_02000D74
	b _02001992
	.align 2, 0
	.pool
_02001988:
	adds r0, r6, #0
	adds r1, r5, #0
	adds r2, r4, #0
	bl sub_02001258
_02001992:
	adds r4, #1
	adds r5, #4
	cmp r4, #5
	ble _02001952
	ldr r1, =gBgTilemapBufferTransferScheduled
	movs r0, #1
	strb r0, [r1]
	strb r0, [r1, #3]
	movs r0, #0
	bl sub_02001738
	add sp, #0xc
	pop {r4, r5, r6}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_020019B4
sub_020019B4: @ 0x020019B4
	push {r4, r5, r6, r7, lr}
	mov r7, r8
	push {r7}
	sub sp, #0x20
	adds r7, r0, #0
	adds r5, r1, #0
	ldr r6, =gUnknown_02021860
	movs r0, #0x8a
	lsls r0, r0, #1
	adds r4, r6, r0
	ldr r0, [r4]
	cmp r0, #0
	beq _020019D6
	bl MoveSpriteToHead
	movs r0, #0
	str r0, [r4]
_020019D6:
	movs r0, #8
	str r0, [sp]
	movs r1, #0
	mov r8, r1
	str r1, [sp, #4]
	movs r0, #2
	movs r2, #0xc
	movs r3, #0x1e
	bl FillBgTilemapBufferRect
	ldr r0, =0x0000E001
	str r0, [sp]
	movs r0, #3
	movs r1, #0xe
	movs r2, #0x18
	movs r3, #6
	bl DrawTextWindowBorder
	ldr r1, =gUnknown_0201F8F0
	movs r0, #0
	bl AddWindow
	movs r1, #0x88
	lsls r1, r1, #1
	adds r4, r6, r1
	str r0, [r4]
	movs r1, #1
	movs r2, #8
	bl SetTextColor
	ldr r0, [r4]
	ldr r1, =0x0000FFFF
	bl ClearWindowCharBuffer
	ldr r1, =gBgTilemapBufferTransferScheduled
	movs r0, #1
	strb r0, [r1, #2]
	ldr r2, =gPlayerPartyPtr
	movs r0, #0x64
	adds r1, r7, #0
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	movs r1, #2
	add r2, sp, #8
	bl GetMonData
	movs r0, #4
	add r1, sp, #8
	bl BufferString
	movs r0, #SE_FAILURE
	bl PlaySE
	ldr r0, [r4]
	ldr r2, =gBattleStringsTable
	lsls r1, r5, #2
	adds r1, r1, r2
	ldr r1, [r1]
	bl RenderText
	movs r0, #6
	str r0, [sp]
	mov r0, r8
	str r0, [sp, #4]
	movs r0, #2
	movs r1, #3
	movs r2, #0xe
	movs r3, #0x18
	bl FillBgTilemapBufferRect
	add sp, #0x20
	pop {r3}
	mov r8, r3
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02001A8C
sub_02001A8C: @ 0x02001A8C
	push {r4, r5, r6, r7, lr}
	mov r7, sb
	mov r6, r8
	push {r6, r7}
	sub sp, #0x18
	mov r8, r0
	movs r5, #0
	movs r0, #1
	mov sb, r0
_02001A9E:
	cmp r5, #4
	bls _02001AA4
	b _02001EE6
_02001AA4:
	lsls r0, r5, #2
	ldr r1, =_02001AB4
	adds r0, r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
	.pool
_02001AB4: @ jump table
	.4byte _02001AC8 @ case 0
	.4byte _02001C14 @ case 1
	.4byte _02001CDC @ case 2
	.4byte _02001D18 @ case 3
	.4byte _02001E90 @ case 4
_02001AC8:
	ldr r7, =gUnknown_02021860
	movs r1, #0x84
	lsls r1, r1, #1
	adds r5, r7, r1
	ldr r0, [r5]
	ldr r6, =0x0000FFFF
	adds r1, r6, #0
	bl ClearWindowCharBuffer
	ldr r0, [r5]
	bl TextWindowFillTileBufferForText
	ldr r4, =0x0000E001
	str r4, [sp]
	movs r0, #0
	movs r1, #0x10
	movs r2, #0x14
	movs r3, #4
	bl DrawTextWindowBorder
	str r4, [sp]
	movs r0, #0x14
	movs r1, #0xc
	movs r2, #0xa
	movs r3, #8
	bl DrawTextWindowBorder
	ldr r2, =gPlayerPartyPtr
	movs r0, #0x64
	mov r1, r8
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	movs r1, #2
	add r2, sp, #8
	bl GetMonData
	movs r0, #4
	add r1, sp, #8
	bl BufferString
	ldr r0, [r5]
	movs r1, #0
	movs r2, #0
	bl TextWindowSetXY
	ldr r0, [r5]
	ldr r1, =gText_DoWhatWithMon
	bl RenderText
	ldr r1, =gUnknown_0201F8D0
	movs r0, #2
	bl AddWindow
	movs r2, #0x86
	lsls r2, r2, #1
	adds r4, r7, r2
	str r0, [r4]
	movs r1, #1
	movs r2, #8
	bl SetTextColor
	ldr r0, [r4]
	bl TextWindowFillTileBufferForText
	ldr r0, [r4]
	adds r1, r6, #0
	bl ClearWindowCharBuffer
	ldr r3, =0x00000125
	adds r0, r7, r3
	ldrb r0, [r0]
	cmp r0, #0
	bne _02001B8C
	ldr r0, [r4]
	ldr r3, =gText_Switch
	movs r1, #0
	movs r2, #0
	bl RenderTextAt
	b _02001B98
	.align 2, 0
	.pool
_02001B8C:
	ldr r0, [r4]
	ldr r3, =gText_SendOut
	movs r1, #0
	movs r2, #0
	bl RenderTextAt
_02001B98:
	ldr r5, =gUnknown_02021860
	movs r0, #0x86
	lsls r0, r0, #1
	adds r4, r5, r0
	ldr r0, [r4]
	ldr r3, =gText_Summary
	movs r1, #0
	movs r2, #0x10
	bl RenderTextAt
	ldr r0, [r4]
	ldr r3, =gText_Cancel
	movs r1, #0
	movs r2, #0x20
	bl RenderTextAt
	ldr r2, =gUnknown_0201F910
	movs r0, #0
	movs r1, #0
	bl AddSprite
	movs r1, #0x8a
	lsls r1, r1, #1
	adds r4, r5, r1
	str r0, [r4]
	movs r1, #5
	bl SetSpritePaletteNum
	ldr r2, =0x00000119
	adds r1, r5, r2
	movs r0, #0
	strb r0, [r1]
	ldr r0, [r4]
	movs r1, #0xa8
	movs r2, #0x68
	bl SetSpritePos
	ldr r1, =gBgTilemapBufferTransferScheduled
	movs r0, #1
	strb r0, [r1, #2]
	bl IsScreenFadedOut
	cmp r0, #0
	beq _02001BF4
	bl FadeIn
_02001BF4:
	movs r5, #1
	b _02001EE6
	.align 2, 0
	.pool
_02001C14:
	movs r0, #1
	bl DelayFrames
	ldr r0, =gNewKeys
	ldrh r4, [r0]
	movs r0, #2
	ands r0, r4
	cmp r0, #0
	beq _02001C28
	movs r5, #2
_02001C28:
	movs r2, #1
	ands r2, r4
	cmp r2, #0
	beq _02001C58
	ldr r0, =gUnknown_02021860
	ldr r3, =0x00000119
	adds r0, r0, r3
	ldrb r0, [r0]
	movs r5, #3
	cmp r0, #0
	bne _02001C40
	b _02001EE6
_02001C40:
	movs r5, #2
	cmp r0, #1
	beq _02001C48
	b _02001EE6
_02001C48:
	movs r5, #4
	b _02001EE6
	.align 2, 0
	.pool
_02001C58:
	ldr r0, =gNewAndRepeatedKeys
	ldrh r4, [r0]
	movs r0, #0x80
	ands r0, r4
	cmp r0, #0
	beq _02001C8C
	ldr r0, =gUnknown_02021860
	ldr r3, =0x00000119
	adds r1, r0, r3
	ldrb r0, [r1]
	cmp r0, #2
	beq _02001C84
	adds r0, #1
	strb r0, [r1]
	b _02001C86
	.align 2, 0
	.pool
_02001C84:
	strb r2, [r1]
_02001C86:
	movs r0, #SE_SELECT
	bl PlaySE
_02001C8C:
	movs r0, #0x40
	ands r4, r0
	cmp r4, #0
	beq _02001CB6
	ldr r0, =gUnknown_02021860
	ldr r2, =0x00000119
	adds r1, r0, r2
	ldrb r0, [r1]
	cmp r0, #0
	beq _02001CAC
	subs r0, #1
	b _02001CAE
	.align 2, 0
	.pool
_02001CAC:
	movs r0, #2
_02001CAE:
	strb r0, [r1]
	movs r0, #SE_SELECT
	bl PlaySE
_02001CB6:
	ldr r1, =gUnknown_02021860
	movs r3, #0x8a
	lsls r3, r3, #1
	adds r0, r1, r3
	ldr r0, [r0]
	ldr r2, =0x00000119
	adds r1, r1, r2
	ldrb r1, [r1]
	lsls r2, r1, #4
	adds r2, #0x68
	movs r1, #0xa8
	bl SetSpritePos
	b _02001EE6
	.align 2, 0
	.pool
_02001CDC:
	movs r0, #SE_SELECT
	bl PlaySE
	ldr r0, =gUnknown_02021860
	movs r3, #0x8a
	lsls r3, r3, #1
	adds r4, r0, r3
	ldr r0, [r4]
	cmp r0, #0
	beq _02001CF8
	bl MoveSpriteToHead
	movs r0, #0
	str r0, [r4]
_02001CF8:
	movs r0, #8
	str r0, [sp]
	movs r0, #0
	str r0, [sp, #4]
	movs r0, #2
	movs r1, #0x14
	movs r2, #0xc
	movs r3, #0xa
	bl FillBgTilemapBufferRect
	movs r0, #0
	bl sub_02001738
	b _02001EEE
	.align 2, 0
	.pool
_02001D18:
	bl sub_020063FC
	adds r4, r0, #0
	ldr r0, =0x0000FFFF
	ands r0, r4
	cmp r0, #1
	bne _02001D44
	movs r0, #SE_FAILURE
	bl PlaySE
	ldr r0, =gUnknown_02021860
	movs r1, #0x91
	lsls r1, r1, #1
	adds r0, r0, r1
	ldrb r0, [r0]
	movs r1, #0
	b _02001E1C
	.align 2, 0
	.pool
_02001D44:
	cmp r0, #2
	bne _02001D78
	movs r0, #SE_FAILURE
	bl PlaySE
	asrs r0, r4, #0x10
	lsls r1, r0, #1
	adds r1, r1, r0
	lsls r1, r1, #2
	ldr r0, =gUnknown_02024960 + 0x81C
	adds r1, r1, r0
	movs r0, #0
	bl BufferString
	ldr r0, =gUnknown_02021860
	movs r2, #0x91
	lsls r2, r2, #1
	adds r0, r0, r2
	ldrb r0, [r0]
	movs r1, #1
	b _02001E1C
	.align 2, 0
	.pool
_02001D78:
	cmp r0, #4
	bne _02001DAC
	movs r0, #SE_FAILURE
	bl PlaySE
	asrs r0, r4, #0x10
	lsls r1, r0, #1
	adds r1, r1, r0
	lsls r1, r1, #2
	ldr r0, =gUnknown_02024960 + 0x81C
	adds r1, r1, r0
	movs r0, #0
	bl BufferString
	ldr r0, =gUnknown_02021860
	movs r3, #0x91
	lsls r3, r3, #1
	adds r0, r0, r3
	ldrb r0, [r0]
	movs r1, #2
	b _02001E1C
	.align 2, 0
	.pool
_02001DAC:
	cmp r0, #3
	bne _02001DE0
	movs r0, #SE_FAILURE
	bl PlaySE
	asrs r0, r4, #0x10
	lsls r1, r0, #1
	adds r1, r1, r0
	lsls r1, r1, #2
	ldr r0, =gUnknown_02024960 + 0x81C
	adds r1, r1, r0
	movs r0, #0
	bl BufferString
	ldr r0, =gUnknown_02021860
	movs r1, #0x91
	lsls r1, r1, #1
	adds r0, r0, r1
	ldrb r0, [r0]
	movs r1, #3
	b _02001E1C
	.align 2, 0
	.pool
_02001DE0:
	ldr r4, =gUnknown_02021860
	ldr r2, =0x0000011B
	adds r5, r4, r2
	ldrb r0, [r5]
	bl sub_0200646C
	cmp r0, #1
	bne _02001E04
	movs r0, #SE_FAILURE
	bl PlaySE
	ldrb r0, [r5]
	movs r1, #0xa
	b _02001E1C
	.align 2, 0
	.pool
_02001E04:
	movs r3, #0x91
	lsls r3, r3, #1
	adds r0, r4, r3
	ldrb r0, [r0]
	ldrb r1, [r5]
	cmp r0, r1
	bne _02001E24
_02001E12:
	movs r0, #SE_FAILURE
	bl PlaySE
	ldrb r0, [r5]
	movs r1, #0xb
_02001E1C:
	bl sub_020019B4
_02001E20:
	movs r5, #2
	b _02001EE6
_02001E24:
	ldr r4, =gUnknown_02024960
	ldr r0, [r4, #4]
	lsls r0, r0, #8
	lsrs r0, r0, #8
	ldrb r1, [r5]
	bl sub_020064BC
	cmp r0, #1
	beq _02001E74
	cmp r0, #1
	bgt _02001E44
	cmp r0, #0
	beq _02001E4E
	b _02001E20
	.align 2, 0
	.pool
_02001E44:
	cmp r0, #2
	beq _02001E12
	cmp r0, #3
	beq _02001E80
	b _02001E20
_02001E4E:
	movs r0, #SE_SELECT
	bl PlaySE
	ldrb r2, [r5]
	ldr r3, =0x0000087E
	adds r0, r4, r3
	ldrb r1, [r0]
	strb r2, [r0]
	ldr r0, =0x0000087B
	adds r1, r4, r0
	ldrb r0, [r1]
	movs r0, #2
	strb r0, [r1]
	subs r0, #3
	b _02001EF0
	.align 2, 0
	.pool
_02001E74:
	movs r0, #SE_FAILURE
	bl PlaySE
	ldrb r0, [r5]
	movs r1, #0xd
	b _02001E1C
_02001E80:
	movs r0, #SE_FAILURE
	bl PlaySE
	ldrb r0, [r5]
	movs r1, #0xc
	bl sub_020019B4
	b _02001E20
_02001E90:
	movs r0, #SE_SELECT
	bl PlaySE
	bl FadeOut
	ldr r5, =gUnknown_02021860
	ldr r1, =0x0000011B
	adds r4, r5, r1
	ldrb r0, [r4]
	bl sub_020044F0
	strb r0, [r4]
	ldrb r4, [r4]
	mov r8, r4
	movs r2, #0x8d
	lsls r2, r2, #1
	adds r0, r5, r2
	ldrb r0, [r0]
	cmp r0, #1
	bne _02001EDE
	mov r0, r8
	cmp r0, #0
	bne _02001ED0
	movs r3, #0x8f
	lsls r3, r3, #1
	adds r1, r5, r3
	movs r0, #2
	b _02001EDC
	.align 2, 0
	.pool
_02001ED0:
	cmp r0, #1
	bne _02001EDE
	movs r0, #0x8f
	lsls r0, r0, #1
	adds r1, r5, r0
	movs r0, #4
_02001EDC:
	strb r0, [r1]
_02001EDE:
	ldr r0, =gUnknown_02021860
	bl sub_020017E8
	movs r5, #0
_02001EE6:
	mov r1, sb
	cmp r1, #0
	beq _02001EEE
	b _02001A9E
_02001EEE:
	movs r0, #0
_02001EF0:
	add sp, #0x18
	pop {r3, r4}
	mov r8, r3
	mov sb, r4
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_02001F04
sub_02001F04: @ 0x02001F04
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #0x24
	str r0, [sp, #0x1c]
	movs r0, #0x2c
	ldr r2, [sp, #0x1c]
	adds r1, r2, #0
	muls r1, r0, r1
	ldr r0, =gUnknown_02021860
	adds r1, r1, r0
	str r1, [sp, #0x20]
	movs r4, #0
_02001F22:
	cmp r4, #4
	bls _02001F28
	b _020023C6
_02001F28:
	lsls r0, r4, #2
	ldr r1, =_02001F3C
	adds r0, r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
	.pool
_02001F3C: @ jump table
	.4byte _02001F50 @ case 0
	.4byte _020020A0 @ case 1
	.4byte _02002164 @ case 2
	.4byte _020021A0 @ case 3
	.4byte _0200235C @ case 4
_02001F50:
	ldr r7, =gUnknown_02021860
	movs r3, #0x84
	lsls r3, r3, #1
	adds r5, r7, r3
	ldr r0, [r5]
	ldr r6, =0x0000FFFF
	adds r1, r6, #0
	bl ClearWindowCharBuffer
	ldr r0, [r5]
	bl TextWindowFillTileBufferForText
	ldr r4, =0x0000E001
	str r4, [sp]
	movs r0, #0
	movs r1, #0x10
	movs r2, #0x14
	movs r3, #4
	bl DrawTextWindowBorder
	str r4, [sp]
	movs r0, #0x14
	movs r1, #0xc
	movs r2, #0xa
	movs r3, #8
	bl DrawTextWindowBorder
	ldr r2, =gPlayerPartyPtr
	movs r0, #0x64
	ldr r3, [sp, #0x1c]
	adds r1, r3, #0
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	movs r1, #2
	add r2, sp, #8
	bl GetMonData
	movs r0, #4
	add r1, sp, #8
	bl BufferString
	ldr r0, [r5]
	movs r1, #0
	movs r2, #0
	bl TextWindowSetXY
	ldr r0, [r5]
	ldr r1, =gText_DoWhatWithMon
	bl RenderText
	ldr r1, =gUnknown_0201F8D0
	movs r0, #2
	bl AddWindow
	movs r1, #0x86
	lsls r1, r1, #1
	adds r5, r7, r1
	str r0, [r5]
	movs r1, #1
	movs r2, #8
	bl SetTextColor
	ldr r0, [r5]
	bl TextWindowFillTileBufferForText
	ldr r0, [r5]
	adds r1, r6, #0
	bl ClearWindowCharBuffer
	ldr r0, [sp, #0x20]
	adds r0, #0x22
	ldrb r0, [r0]
	cmp r0, #0
	bne _02002010
	ldr r0, [r5]
	ldr r3, =gText_Select
	movs r1, #0
	movs r2, #0
	bl RenderTextAt
	b _0200201C
	.align 2, 0
	.pool
_02002010:
	ldr r0, [r5]
	ldr r3, =gText_Deselect
	movs r1, #0
	movs r2, #0
	bl RenderTextAt
_0200201C:
	ldr r5, =gUnknown_02021860
	movs r2, #0x86
	lsls r2, r2, #1
	adds r4, r5, r2
	ldr r0, [r4]
	ldr r3, =gText_Summary
	movs r1, #0
	movs r2, #0x10
	bl RenderTextAt
	ldr r0, [r4]
	ldr r3, =gText_Cancel
	movs r1, #0
	movs r2, #0x20
	bl RenderTextAt
	ldr r2, =gUnknown_0201F910
	movs r0, #0
	movs r1, #0
	bl AddSprite
	movs r3, #0x8a
	lsls r3, r3, #1
	adds r4, r5, r3
	str r0, [r4]
	movs r1, #5
	bl SetSpritePaletteNum
	ldr r0, =0x00000119
	adds r1, r5, r0
	movs r0, #0
	strb r0, [r1]
	ldr r0, [r4]
	movs r1, #0xa8
	movs r2, #0x68
	bl SetSpritePos
	ldr r1, =gBgTilemapBufferTransferScheduled
	movs r0, #1
	strb r0, [r1, #2]
	bl IsScreenFadedOut
	cmp r0, #0
	beq _02002098
	bl FadeIn
	b _020021C6
	.align 2, 0
	.pool
_02002098:
	movs r0, #SE_SELECT
	bl PlaySE
	b _020021C6
_020020A0:
	movs r0, #1
	bl DelayFrames
	ldr r0, =gNewAndRepeatedKeys
	ldrh r1, [r0]
	movs r3, #2
	adds r0, r1, #0
	ands r0, r3
	cmp r0, #0
	beq _020020B6
	movs r4, #2
_020020B6:
	movs r2, #1
	ands r2, r1
	cmp r2, #0
	beq _020020E8
	ldr r0, =gUnknown_02021860
	ldr r1, =0x00000119
	adds r0, r0, r1
	ldrb r0, [r0]
	movs r4, #3
	cmp r0, #0
	bne _020020CE
	b _020023C6
_020020CE:
	movs r4, #2
	cmp r0, #1
	beq _020020D6
	b _020023C6
_020020D6:
	movs r4, #4
	b _020023C6
	.align 2, 0
	.pool
_020020E8:
	movs r0, #0x80
	ands r0, r1
	cmp r0, #0
	beq _02002110
	ldr r0, =gUnknown_02021860
	ldr r3, =0x00000119
	adds r1, r0, r3
	ldrb r0, [r1]
	cmp r0, #2
	beq _0200210C
	adds r0, #1
	strb r0, [r1]
	b _02002136
	.align 2, 0
	.pool
_0200210C:
	strb r2, [r1]
	b _02002136
_02002110:
	movs r0, #0x40
	ands r1, r0
	cmp r1, #0
	beq _0200213E
	ldr r0, =gUnknown_02021860
	ldr r2, =0x00000119
	adds r1, r0, r2
	ldrb r0, [r1]
	cmp r0, #0
	beq _02002134
	subs r0, #1
	strb r0, [r1]
	b _02002136
	.align 2, 0
	.pool
_02002134:
	strb r3, [r1]
_02002136:
	movs r0, #SE_SELECT
	bl PlaySE
	b _020023C6
_0200213E:
	ldr r1, =gUnknown_02021860
	movs r3, #0x8a
	lsls r3, r3, #1
	adds r0, r1, r3
	ldr r0, [r0]
	ldr r2, =0x00000119
	adds r1, r1, r2
	ldrb r1, [r1]
	lsls r2, r1, #4
	adds r2, #0x68
	movs r1, #0xa8
	bl SetSpritePos
	b _020023C6
	.align 2, 0
	.pool
_02002164:
	movs r0, #SE_SELECT
	bl PlaySE
	ldr r0, =gUnknown_02021860
	movs r3, #0x8a
	lsls r3, r3, #1
	adds r4, r0, r3
	ldr r0, [r4]
	cmp r0, #0
	beq _02002180
	bl MoveSpriteToHead
	movs r0, #0
	str r0, [r4]
_02002180:
	movs r0, #8
	str r0, [sp]
	movs r0, #0
	str r0, [sp, #4]
	movs r0, #2
	movs r1, #0x14
	movs r2, #0xc
	movs r3, #0xa
	bl FillBgTilemapBufferRect
	movs r0, #0
	bl sub_02001738
	b _020023CE
	.align 2, 0
	.pool
_020021A0:
	ldr r0, [sp, #0x20]
	adds r0, #0x22
	ldrb r1, [r0]
	adds r7, r0, #0
	cmp r1, #0
	bne _02002268
	ldr r0, =gUnknown_02021860
	movs r1, #0x92
	lsls r1, r1, #1
	adds r4, r0, r1
	ldr r2, =0x00000123
	adds r0, r0, r2
	ldrb r3, [r4]
	ldrb r0, [r0]
	cmp r3, r0
	bne _020021D4
	movs r0, #SE_FAILURE
	bl PlaySE
_020021C6:
	movs r4, #1
	b _020023C6
	.align 2, 0
	.pool
_020021D4:
	movs r0, #SE_SELECT
	bl PlaySE
	ldrb r0, [r4]
	adds r0, #1
	strb r0, [r4]
	movs r5, #0xff
	strb r0, [r7]
	ldr r0, [sp, #0x20]
	ldr r4, [r0, #0x24]
	adds r0, r4, #0
	movs r1, #0
	bl ClearWindowCharBuffer
	ldrb r0, [r7]
	cmp r0, #0
	bne _02002208
	ldr r3, =gText_Space
	adds r0, r4, #0
	movs r1, #0
	movs r2, #2
	bl RenderTextAt
	b _0200222C
	.align 2, 0
	.pool
_02002208:
	add r1, sp, #0x18
	adds r0, #0xa1
	strb r0, [r1]
	ldrb r0, [r1, #1]
	orrs r0, r5
	strb r0, [r1, #1]
	movs r0, #0
	bl BufferString
	adds r0, r4, #0
	movs r1, #0
	movs r2, #2
	bl TextWindowSetXY
	ldr r1, =gText_Number
	adds r0, r4, #0
	bl RenderText
_0200222C:
	ldr r0, =0x04000154
	movs r1, #0x80
	lsls r1, r1, #0x11
	str r1, [r0]
	ldr r1, =gUnknown_02021860
	movs r2, #0x92
	lsls r2, r2, #1
	adds r0, r1, r2
	ldr r3, =0x00000123
	adds r2, r1, r3
	ldrb r0, [r0]
	ldrb r2, [r2]
	cmp r0, r2
	beq _0200224A
	b _0200234C
_0200224A:
	ldr r0, =0x0000011B
	adds r1, r1, r0
	movs r0, #6
	strb r0, [r1]
	b _0200234C
	.align 2, 0
	.pool
_02002268:
	movs r1, #0
	mov r8, r1
	ldr r2, =gUnknown_02021860
	mov sb, r2
	movs r3, #0x24
	add r3, sb
	mov sl, r3
	add r6, sp, #0x18
_02002278:
	movs r0, #0x2c
	mov r1, r8
	muls r1, r0, r1
	mov r2, sb
	adds r0, r1, r2
	adds r4, r0, #0
	adds r4, #0x22
	ldrb r0, [r4]
	ldrb r3, [r7]
	cmp r0, r3
	bls _020022DE
	subs r0, #1
	strb r0, [r4]
	mov r2, sl
	adds r0, r1, r2
	ldr r5, [r0]
	adds r0, r5, #0
	movs r1, #0
	bl ClearWindowCharBuffer
	ldrb r0, [r4]
	cmp r0, #0
	bne _020022BC
	adds r0, r5, #0
	movs r1, #0
	movs r2, #2
	ldr r3, =gText_Space
	bl RenderTextAt
	b _020022DE
	.align 2, 0
	.pool
_020022BC:
	adds r0, #0xa1
	strb r0, [r6]
	movs r0, #0xff
	strb r0, [r6, #1]
	movs r0, #0
	adds r1, r6, #0
	bl BufferString
	adds r0, r5, #0
	movs r1, #0
	movs r2, #2
	bl TextWindowSetXY
	adds r0, r5, #0
	ldr r1, =gText_Number
	bl RenderText
_020022DE:
	movs r3, #1
	add r8, r3
	mov r0, r8
	cmp r0, #5
	ble _02002278
	movs r0, #0
	strb r0, [r7]
	ldr r1, [sp, #0x20]
	ldr r4, [r1, #0x24]
	adds r0, r4, #0
	movs r1, #0
	bl ClearWindowCharBuffer
	ldrb r0, [r7]
	cmp r0, #0
	bne _02002314
	ldr r3, =gText_Space
	adds r0, r4, #0
	movs r1, #0
	movs r2, #2
	bl RenderTextAt
	b _02002336
	.align 2, 0
	.pool
_02002314:
	add r1, sp, #0x18
	adds r0, #0xa1
	strb r0, [r1]
	movs r0, #0xff
	strb r0, [r1, #1]
	movs r0, #0
	bl BufferString
	adds r0, r4, #0
	movs r1, #0
	movs r2, #2
	bl TextWindowSetXY
	ldr r1, =gText_Number
	adds r0, r4, #0
	bl RenderText
_02002336:
	ldr r1, =0x04000154
	movs r0, #0xff
	lsls r0, r0, #0x18
	str r0, [r1]
	ldr r0, =gUnknown_02021860
	movs r2, #0x92
	lsls r2, r2, #1
	adds r0, r0, r2
	ldrb r1, [r0]
	subs r1, #1
	strb r1, [r0]
_0200234C:
	movs r4, #2
	b _020023C6
	.align 2, 0
	.pool
_0200235C:
	movs r0, #SE_SELECT
	bl PlaySE
	bl FadeOut
	ldr r4, =gUnknown_02021860
	ldr r3, =0x0000011B
	adds r5, r4, r3
	ldrb r0, [r5]
	bl sub_020044F0
	strb r0, [r5]
	movs r2, #0x8d
	lsls r2, r2, #1
	adds r1, r4, r2
	ldrb r1, [r1]
	cmp r1, #1
	bne _020023AA
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	cmp r0, #0
	bne _0200239C
	movs r3, #0x8f
	lsls r3, r3, #1
	adds r1, r4, r3
	movs r0, #2
	b _020023A8
	.align 2, 0
	.pool
_0200239C:
	cmp r0, #1
	bne _020023AA
	movs r0, #0x8f
	lsls r0, r0, #1
	adds r1, r4, r0
	movs r0, #4
_020023A8:
	strb r0, [r1]
_020023AA:
	ldr r4, =gUnknown_02021860
	adds r0, r4, #0
	bl sub_020017E8
	ldr r1, =0x0000011B
	adds r0, r4, r1
	ldrb r0, [r0]
	str r0, [sp, #0x1c]
	movs r0, #0x2c
	ldr r2, [sp, #0x1c]
	muls r0, r2, r0
	adds r0, r0, r4
	str r0, [sp, #0x20]
	movs r4, #0
_020023C6:
	movs r3, #1
	cmp r3, #0
	beq _020023CE
	b _02001F22
_020023CE:
	ldr r0, [sp, #0x1c]
	add sp, #0x24
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_020023E8
sub_020023E8: @ 0x020023E8
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #0xc
	ldr r0, =gUnknown_0201F9A8
	ldr r2, =gUnknown_02021860
	movs r3, #0x8d
	lsls r3, r3, #1
	adds r1, r2, r3
	ldrb r1, [r1]
	lsls r1, r1, #2
	adds r0, r1, r0
	ldr r0, [r0]
	mov sb, r0
	ldr r0, =gUnknown_0201F9EC
	adds r1, r1, r0
	ldr r1, [r1]
	str r1, [sp, #8]
	mov r8, r2
	movs r4, #0x8f
	lsls r4, r4, #1
	add r4, r8
	mov sl, r4
_0200241A:
	movs r0, #1
	bl DelayFrames
	ldr r0, =gNewAndRepeatedKeys
	ldrh r5, [r0]
	cmp r5, #0
	beq _0200241A
	movs r0, #2
	ands r0, r5
	cmp r0, #0
	beq _02002450
	ldr r1, =gUnknown_02021985
	ldrb r0, [r1]
	cmp r0, #0
	beq _0200246C
	b _02002484
	.align 2, 0
	.pool
_02002450:
	movs r0, #1
	ands r0, r5
	cmp r0, #0
	beq _020024A8
	ldr r0, =gUnknown_02021860
	ldr r3, =0x0000011B
	adds r4, r0, r3
	ldrb r0, [r4]
	cmp r0, #6
	bne _0200248C
	ldr r1, =gUnknown_02021985
	ldrb r0, [r1]
	cmp r0, #0
	bne _02002484
_0200246C:
	movs r0, #SE_SELECT
	bl PlaySE
	movs r0, #1
	rsbs r0, r0, #0
	b _020026E4
	.align 2, 0
	.pool
_02002484:
	movs r0, #SE_FAILURE
	bl PlaySE
	b _0200241A
_0200248C:
	movs r0, #SE_SELECT
	bl PlaySE
	ldrb r0, [r4]
	bl sub_02001A8C
	adds r1, r0, #0
	movs r0, #1
	rsbs r0, r0, #0
	cmp r1, r0
	bne _020024A8
	movs r0, #1
	rsbs r0, r0, #0
	b _020026E4
_020024A8:
	ldr r6, =gUnknown_02021860
	ldr r3, =0x0000011B
	adds r4, r6, r3
	ldrb r7, [r4]
	movs r0, #0x40
	ands r0, r5
	cmp r0, #0
	beq _020024F6
	movs r0, #SE_SELECT
	bl PlaySE
	ldrb r0, [r4]
	adds r1, r0, #0
	cmp r1, #0
	bne _020024D4
	movs r0, #6
	b _020024E4
	.align 2, 0
	.pool
_020024D4:
	cmp r1, #6
	bne _020024E2
	movs r1, #0x90
	lsls r1, r1, #1
	adds r0, r6, r1
	ldrb r0, [r0]
	b _020024E4
_020024E2:
	subs r0, #1
_020024E4:
	strb r0, [r4]
	ldr r0, =0x0000011B
	add r0, r8
	ldrb r0, [r0]
	lsls r0, r0, #2
	add r0, sb
	ldrb r0, [r0, #2]
	mov r3, sl
	strb r0, [r3]
_020024F6:
	movs r0, #0x80
	ands r0, r5
	cmp r0, #0
	beq _0200253C
	movs r0, #SE_SELECT
	bl PlaySE
	ldr r3, =0x0000011B
	add r3, r8
	movs r0, #0x90
	lsls r0, r0, #1
	add r0, r8
	ldrb r2, [r3]
	adds r1, r2, #0
	ldrb r0, [r0]
	cmp r1, r0
	bne _02002520
	movs r0, #6
	b _0200252A
	.align 2, 0
	.pool
_02002520:
	cmp r1, #6
	bne _02002528
	movs r0, #0
	b _0200252A
_02002528:
	adds r0, r2, #1
_0200252A:
	strb r0, [r3]
	ldr r0, =0x0000011B
	add r0, r8
	ldrb r0, [r0]
	lsls r0, r0, #2
	add r0, sb
	ldrb r0, [r0, #2]
	mov r4, sl
	strb r0, [r4]
_0200253C:
	movs r0, #0x20
	ands r0, r5
	cmp r0, #0
	beq _0200256A
	movs r0, #SE_SELECT
	bl PlaySE
	ldr r0, =gUnknown_02021860
	ldr r1, =0x0000011B
	adds r2, r0, r1
	ldrb r1, [r2]
	lsls r0, r1, #2
	add r0, sb
	ldrb r0, [r0, #1]
	cmp r0, #0xff
	beq _0200256A
	mov r3, sl
	strb r1, [r3]
	ldrb r4, [r2]
	lsls r0, r4, #2
	add r0, sb
	ldrb r0, [r0, #1]
	strb r0, [r2]
_0200256A:
	movs r0, #0x10
	ands r5, r0
	cmp r5, #0
	beq _020025C8
	movs r0, #SE_SELECT
	bl PlaySE
	ldr r2, =gUnknown_02021860
	ldr r0, =0x0000011B
	adds r3, r2, r0
	ldrb r1, [r3]
	lsls r0, r1, #2
	add r0, sb
	ldrb r0, [r0]
	cmp r0, #7
	beq _02002598
	cmp r0, #0xff
	bne _020025C6
	b _020025C8
	.align 2, 0
	.pool
_02002598:
	mov r4, sl
	ldrb r1, [r4]
	strb r1, [r3]
	movs r4, #0x90
	lsls r4, r4, #1
	adds r0, r2, r4
	ldrb r0, [r0]
	lsls r1, r1, #0x18
	lsrs r1, r1, #0x18
	cmp r1, r0
	bls _020025C8
	strb r0, [r3]
	movs r0, #0x8d
	lsls r0, r0, #1
	adds r1, r2, r0
	subs r0, #0x19
	ldrh r1, [r1]
	cmp r1, r0
	bne _020025C8
	cmp r7, #0
	bne _020025C8
	strb r7, [r3]
	b _020025C8
_020025C6:
	strb r0, [r3]
_020025C8:
	ldr r0, =0x0000011B
	add r0, r8
	ldrb r0, [r0]
	cmp r7, r0
	bne _020025D4
	b _0200241A
_020025D4:
	cmp r7, #6
	beq _02002632
	lsls r0, r7, #2
	ldr r1, [sp, #8]
	adds r4, r1, r0
	ldrb r3, [r4, #2]
	lsls r1, r3, #2
	ldr r0, =gUnknown_0201F9B0
	adds r5, r1, r0
	ldr r2, =gPlayerPartyPtr
	movs r0, #0x64
	adds r1, r7, #0
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	bl GetMonStatus
	cmp r0, #7
	beq _0200261C
	ldrb r1, [r4]
	ldrb r2, [r4, #1]
	ldrb r3, [r5]
	ldrb r0, [r5, #1]
	str r0, [sp]
	movs r0, #3
	str r0, [sp, #4]
	bl SetBgTilemapBufferPaletteRect
	b _02002644
	.align 2, 0
	.pool
_0200261C:
	ldrb r1, [r4]
	ldrb r2, [r4, #1]
	ldrb r3, [r5]
	ldrb r0, [r5, #1]
	str r0, [sp]
	movs r0, #5
	str r0, [sp, #4]
	movs r0, #3
	bl SetBgTilemapBufferPaletteRect
	b _02002644
_02002632:
	movs r0, #2
	str r0, [sp]
	movs r0, #1
	str r0, [sp, #4]
	movs r1, #0x18
	movs r2, #0x12
	movs r3, #6
	bl SetBgTilemapBufferPaletteRect
_02002644:
	ldr r5, =gUnknown_02021860
	ldr r4, =0x0000011B
	adds r0, r5, r4
	ldrb r1, [r0]
	cmp r1, #6
	beq _020026AA
	ldrb r3, [r0]
	lsls r0, r3, #2
	ldr r1, [sp, #8]
	adds r4, r1, r0
	ldrb r0, [r4, #2]
	lsls r1, r0, #2
	ldr r0, =gUnknown_0201F9B0
	adds r5, r1, r0
	ldr r2, =gPlayerPartyPtr
	movs r0, #0x64
	adds r1, r3, #0
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	bl GetMonStatus
	cmp r0, #7
	beq _02002694
	ldrb r1, [r4]
	ldrb r2, [r4, #1]
	ldrb r3, [r5]
	ldrb r0, [r5, #1]
	str r0, [sp]
	movs r0, #7
	b _020026A0
	.align 2, 0
	.pool
_02002694:
	ldrb r1, [r4]
	ldrb r2, [r4, #1]
	ldrb r3, [r5]
	ldrb r0, [r5, #1]
	str r0, [sp]
	movs r0, #9
_020026A0:
	str r0, [sp, #4]
	movs r0, #3
	bl SetBgTilemapBufferPaletteRect
	b _020026D4
_020026AA:
	movs r4, #2
	str r4, [sp]
	str r4, [sp, #4]
	movs r0, #1
	movs r1, #0x18
	movs r2, #0x12
	movs r3, #6
	bl SetBgTilemapBufferPaletteRect
	movs r1, #0x8d
	lsls r1, r1, #1
	adds r0, r5, r1
	ldrb r0, [r0]
	cmp r0, #0
	bne _020026D0
	movs r0, #1
	mov r3, sl
	strb r0, [r3]
	b _020026D4
_020026D0:
	mov r0, sl
	strb r4, [r0]
_020026D4:
	ldr r1, =gBgTilemapBufferTransferScheduled
	movs r0, #1
	strb r0, [r1, #3]
	strb r0, [r1, #1]
	b _0200241A
	.align 2, 0
	.pool
_020026E4:
	add sp, #0xc
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1

	thumb_func_start sub_020026F4
sub_020026F4: @ 0x020026F4
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #8
	ldr r0, =gUnknown_0201F9A8
	ldr r2, =gUnknown_02021860
	movs r3, #0x8d
	lsls r3, r3, #1
	adds r1, r2, r3
	ldrb r1, [r1]
	lsls r1, r1, #2
	adds r0, r1, r0
	ldr r0, [r0]
	mov r8, r0
	ldr r0, =gUnknown_0201F9EC
	adds r1, r1, r0
	ldr r1, [r1]
	mov sl, r1
	adds r7, r2, #0
	movs r4, #0x8f
	lsls r4, r4, #1
	adds r4, r4, r7
	mov sb, r4
_02002726:
	movs r0, #1
	bl DelayFrames
	ldr r0, =gNewAndRepeatedKeys
	ldrh r4, [r0]
	cmp r4, #0
	beq _02002726
	ldr r1, =gUnknown_02021860
	ldr r2, =0x0000011B
	adds r0, r1, r2
	ldrb r6, [r0]
	movs r0, #2
	ands r0, r4
	cmp r0, #0
	beq _02002788
	movs r3, #0x92
	lsls r3, r3, #1
	adds r0, r1, r3
	ldrb r0, [r0]
	cmp r0, #0
	beq _0200277C
	bl sub_02000BFC
	movs r0, #SE_SELECT
	bl PlaySE
	ldr r1, =0x04000154
	movs r0, #0xff
	lsls r0, r0, #0x18
	str r0, [r1]
	b _02002788
	.align 2, 0
	.pool
_0200277C:
	movs r0, #1
	bl sub_02001738
	movs r0, #SE_FAILURE
	bl PlaySE
_02002788:
	adds r0, r4, #0
	movs r1, #1
	ands r0, r1
	cmp r0, #0
	beq _02002854
	ldr r1, =gUnknown_02021860
	ldr r2, =0x0000011B
	adds r0, r1, r2
	ldrb r3, [r0]
	cmp r3, #6
	bne _02002838
	movs r4, #0x92
	lsls r4, r4, #1
	adds r2, r1, r4
	ldr r3, =0x00000123
	adds r0, r1, r3
	ldrb r4, [r2]
	ldrb r0, [r0]
	cmp r4, r0
	beq _020027CC
	movs r0, #SE_FAILURE
	bl PlaySE
	movs r0, #1
	bl sub_02001738
	b _02002726
	.align 2, 0
	.pool
_020027CC:
	movs r7, #0
	movs r6, #0
	movs r3, #1
	ldrb r0, [r2]
	adds r0, #1
	ldr r2, =gUnknown_02024960
	mov sl, r2
	cmp r3, r0
	bge _0200281C
	mov r8, r1
	mov ip, r0
	movs r4, #1
	rsbs r4, r4, #0
	mov sb, r4
_020027E8:
	movs r2, #0
	adds r5, r6, #4
	adds r4, r3, #1
	mov r1, r8
	adds r1, #0x22
_020027F2:
	ldrb r0, [r1]
	cmp r0, r3
	bne _02002800
	adds r0, r2, #0
	b _0200280C
	.align 2, 0
	.pool
_02002800:
	adds r1, #0x2c
	adds r2, #1
	cmp r2, #5
	ble _020027F2
	movs r0, #1
	rsbs r0, r0, #0
_0200280C:
	cmp r0, sb
	beq _02002814
	lsls r0, r6
	orrs r7, r0
_02002814:
	adds r6, r5, #0
	adds r3, r4, #0
	cmp r3, ip
	blt _020027E8
_0200281C:
	movs r0, #0x88
	lsls r0, r0, #4
	add r0, sl
	str r7, [r0]
	ldr r0, =0x0000087F
	add r0, sl
	ldrb r1, [r0]
	movs r1, #1
	strb r1, [r0]
	movs r0, #1
	rsbs r0, r0, #0
	b _02002A8C
	.align 2, 0
	.pool
_02002838:
	ldrb r0, [r0]
	bl sub_02001F04
	adds r1, r0, #0
	movs r0, #1
	rsbs r0, r0, #0
	cmp r1, r0
	bne _0200284E
	movs r0, #1
	rsbs r0, r0, #0
	b _02002A8C
_0200284E:
	cmp r1, r6
	beq _02002854
	adds r6, r1, #0
_02002854:
	movs r0, #0x40
	ands r0, r4
	cmp r0, #0
	beq _0200289E
	movs r0, #SE_SELECT
	bl PlaySE
	ldr r2, =gUnknown_02021860
	ldr r0, =0x0000011B
	adds r3, r2, r0
	ldrb r0, [r3]
	adds r1, r0, #0
	cmp r1, #0
	bne _0200287C
	movs r0, #6
	b _0200288C
	.align 2, 0
	.pool
_0200287C:
	cmp r1, #6
	bne _0200288A
	movs r1, #0x90
	lsls r1, r1, #1
	adds r0, r2, r1
	ldrb r0, [r0]
	b _0200288C
_0200288A:
	subs r0, #1
_0200288C:
	strb r0, [r3]
	ldr r2, =0x0000011B
	adds r0, r7, r2
	ldrb r0, [r0]
	lsls r0, r0, #2
	add r0, r8
	ldrb r0, [r0, #2]
	mov r3, sb
	strb r0, [r3]
_0200289E:
	movs r0, #0x80
	ands r0, r4
	cmp r0, #0
	beq _020028E4
	movs r0, #SE_SELECT
	bl PlaySE
	ldr r0, =0x0000011B
	adds r3, r7, r0
	movs r1, #0x90
	lsls r1, r1, #1
	adds r0, r7, r1
	ldrb r2, [r3]
	adds r1, r2, #0
	ldrb r0, [r0]
	cmp r1, r0
	bne _020028C8
	movs r0, #6
	b _020028D2
	.align 2, 0
	.pool
_020028C8:
	cmp r1, #6
	bne _020028D0
	movs r0, #0
	b _020028D2
_020028D0:
	adds r0, r2, #1
_020028D2:
	strb r0, [r3]
	ldr r2, =0x0000011B
	adds r0, r7, r2
	ldrb r0, [r0]
	lsls r0, r0, #2
	add r0, r8
	ldrb r0, [r0, #2]
	mov r3, sb
	strb r0, [r3]
_020028E4:
	movs r0, #0x20
	ands r0, r4
	cmp r0, #0
	beq _02002912
	movs r0, #SE_SELECT
	bl PlaySE
	ldr r0, =gUnknown_02021860
	ldr r1, =0x0000011B
	adds r2, r0, r1
	ldrb r1, [r2]
	lsls r0, r1, #2
	add r0, r8
	ldrb r0, [r0, #1]
	cmp r0, #0xff
	beq _02002912
	mov r3, sb
	strb r1, [r3]
	ldrb r1, [r2]
	lsls r0, r1, #2
	add r0, r8
	ldrb r0, [r0, #1]
	strb r0, [r2]
_02002912:
	movs r0, #0x10
	ands r4, r0
	cmp r4, #0
	beq _02002970
	movs r0, #SE_SELECT
	bl PlaySE
	ldr r2, =gUnknown_02021860
	ldr r4, =0x0000011B
	adds r3, r2, r4
	ldrb r1, [r3]
	lsls r0, r1, #2
	add r0, r8
	ldrb r0, [r0]
	cmp r0, #7
	beq _02002940
	cmp r0, #0xff
	bne _0200296E
	b _02002970
	.align 2, 0
	.pool
_02002940:
	mov r4, sb
	ldrb r1, [r4]
	strb r1, [r3]
	movs r4, #0x90
	lsls r4, r4, #1
	adds r0, r2, r4
	ldrb r0, [r0]
	lsls r1, r1, #0x18
	lsrs r1, r1, #0x18
	cmp r1, r0
	bls _02002970
	strb r0, [r3]
	movs r0, #0x8d
	lsls r0, r0, #1
	adds r1, r2, r0
	subs r0, #0x19
	ldrh r1, [r1]
	cmp r1, r0
	bne _02002970
	cmp r6, #0
	bne _02002970
	strb r6, [r3]
	b _02002970
_0200296E:
	strb r0, [r3]
_02002970:
	ldr r1, =0x0000011B
	adds r0, r7, r1
	ldrb r0, [r0]
	cmp r6, r0
	bne _0200297C
	b _02002726
_0200297C:
	cmp r6, #6
	beq _020029DA
	lsls r0, r6, #2
	mov r2, sl
	adds r4, r2, r0
	ldrb r3, [r4, #2]
	lsls r1, r3, #2
	ldr r0, =gUnknown_0201F9B0
	adds r5, r1, r0
	ldr r2, =gPlayerPartyPtr
	movs r0, #0x64
	adds r1, r6, #0
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	bl GetMonStatus
	cmp r0, #7
	beq _020029C4
	ldrb r1, [r4]
	ldrb r2, [r4, #1]
	ldrb r3, [r5]
	ldrb r0, [r5, #1]
	str r0, [sp]
	movs r0, #3
	str r0, [sp, #4]
	bl SetBgTilemapBufferPaletteRect
	b _020029EE
	.align 2, 0
	.pool
_020029C4:
	ldrb r1, [r4]
	ldrb r2, [r4, #1]
	ldrb r3, [r5]
	ldrb r0, [r5, #1]
	str r0, [sp]
	movs r0, #5
	str r0, [sp, #4]
	movs r0, #3
	bl SetBgTilemapBufferPaletteRect
	b _020029EE
_020029DA:
	movs r0, #2
	str r0, [sp]
	movs r4, #1
	str r4, [sp, #4]
	movs r0, #1
	movs r1, #0x18
	movs r2, #0x12
	movs r3, #6
	bl SetBgTilemapBufferPaletteRect
_020029EE:
	ldr r5, =gUnknown_02021860
	ldr r1, =0x0000011B
	adds r0, r5, r1
	ldrb r2, [r0]
	cmp r2, #6
	beq _02002A52
	ldrb r3, [r0]
	lsls r0, r3, #2
	mov r1, sl
	adds r4, r1, r0
	ldrb r2, [r4, #2]
	lsls r1, r2, #2
	ldr r0, =gUnknown_0201F9B0
	adds r5, r1, r0
	ldr r2, =gPlayerPartyPtr
	movs r0, #0x64
	adds r1, r3, #0
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	bl GetMonStatus
	cmp r0, #7
	beq _02002A3C
	ldrb r1, [r4]
	ldrb r2, [r4, #1]
	ldrb r3, [r5]
	ldrb r0, [r5, #1]
	str r0, [sp]
	movs r0, #7
	b _02002A48
	.align 2, 0
	.pool
_02002A3C:
	ldrb r1, [r4]
	ldrb r2, [r4, #1]
	ldrb r3, [r5]
	ldrb r0, [r5, #1]
	str r0, [sp]
	movs r0, #9
_02002A48:
	str r0, [sp, #4]
	movs r0, #3
	bl SetBgTilemapBufferPaletteRect
	b _02002A7C
_02002A52:
	movs r4, #2
	str r4, [sp]
	str r4, [sp, #4]
	movs r0, #1
	movs r1, #0x18
	movs r2, #0x12
	movs r3, #6
	bl SetBgTilemapBufferPaletteRect
	movs r3, #0x8d
	lsls r3, r3, #1
	adds r0, r5, r3
	ldrb r0, [r0]
	cmp r0, #0
	bne _02002A78
	movs r0, #1
	mov r4, sb
	strb r0, [r4]
	b _02002A7C
_02002A78:
	mov r1, sb
	strb r4, [r1]
_02002A7C:
	ldr r0, =gBgTilemapBufferTransferScheduled
	movs r2, #1
	strb r2, [r0, #3]
	strb r2, [r0, #1]
	b _02002726
	.align 2, 0
	.pool
_02002A8C:
	add sp, #8
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1

	thumb_func_start sub_02002A9C
sub_02002A9C: @ 0x02002A9C
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #0xc
	adds r4, r0, #0
	ldr r3, =gUnknown_02021860
	movs r5, #0x91
	lsls r5, r5, #1
	adds r0, r3, r5
	movs r5, #0
	strb r1, [r0]
	ldr r1, =0x0000011B
	adds r0, r3, r1
	strb r5, [r0]
	adds r1, #0xa
	adds r0, r3, r1
	strb r2, [r0]
	movs r0, #0x8d
	lsls r0, r0, #1
	adds r2, r3, r0
	strb r5, [r2]
	ldr r1, =gUnknown_02024960
	ldr r0, =0x00000858
	adds r6, r1, r0
	ldrb r0, [r6]
	adds r7, r1, #0
	cmp r0, #1
	bne _02002AF4
	movs r1, #0x8f
	lsls r1, r1, #1
	adds r2, r3, r1
	strb r0, [r2]
	b _02002B08
	.align 2, 0
	.pool
_02002AF4:
	ldrb r0, [r6]
	adds r1, r0, #0
	cmp r1, #2
	bne _02002B08
	movs r0, #1
	strb r0, [r2]
	movs r2, #0x8f
	lsls r2, r2, #1
	adds r0, r3, r2
	strb r1, [r0]
_02002B08:
	cmp r4, #0
	beq _02002B12
	cmp r4, #1
	beq _02002B38
	b _02002C1E
_02002B12:
	movs r5, #0x8c
	lsls r5, r5, #1
	adds r0, r3, r5
	strb r4, [r0]
	ldr r1, =0x00000123
	adds r0, r3, r1
	strb r4, [r0]
	adds r0, r3, #0
	bl sub_020017E8
	bl FadeIn
	bl sub_020023E8
	bl FadeOut
	b _02002C1E
	.align 2, 0
	.pool
_02002B38:
	movs r2, #0x8c
	lsls r2, r2, #1
	adds r0, r3, r2
	strb r4, [r0]
	ldr r5, =0x00000859
	adds r0, r7, r5
	ldrb r0, [r0]
	ldr r1, =0x00000123
	adds r4, r3, r1
	strb r0, [r4]
	lsls r0, r0, #0x18
	lsrs r1, r0, #0x18
	ldr r2, =gPlayerPartyCountPtr
	cmp r1, #0
	beq _02002B5E
	ldr r0, [r2]
	ldrb r0, [r0]
	cmp r1, r0
	bls _02002B64
_02002B5E:
	ldr r0, [r2]
	ldrb r0, [r0]
	strb r0, [r4]
_02002B64:
	movs r2, #0x92
	lsls r2, r2, #1
	adds r0, r3, r2
	movs r1, #0
	strb r1, [r0]
	movs r6, #0
	mov r5, sp
	adds r5, #4
	str r5, [sp, #8]
	mov r0, sp
	adds r0, #2
	mov sl, r6
	ldr r7, =gPlayerPartyPtr
	mov sb, r0
_02002B80:
	movs r0, #0x2c
	muls r0, r6, r0
	adds r0, r0, r3
	adds r0, #0x22
	mov r1, sl
	strb r1, [r0]
	movs r2, #0x64
	adds r4, r6, #0
	muls r4, r2, r4
	ldr r0, [r7]
	adds r0, r0, r4
	movs r1, #0x3a
	movs r2, #0
	bl GetMonData
	mov r1, sp
	strh r0, [r1]
	ldr r0, [r7]
	adds r0, r0, r4
	movs r1, #0x39
	mov r2, sp
	bl SetMonData
	mov r5, sl
	str r5, [sp, #4]
	ldr r0, [r7]
	adds r0, r0, r4
	movs r1, #0x37
	ldr r2, [sp, #8]
	bl SetMonData
	movs r5, #0
	adds r6, #1
	mov r8, r6
	adds r6, r4, #0
_02002BC6:
	ldr r0, [r7]
	adds r0, r0, r6
	adds r1, r5, #0
	bl GetBoxMonMoveBySlot
	adds r4, r0, #0
	lsls r4, r4, #0x10
	lsrs r4, r4, #0x10
	ldr r0, [r7]
	adds r0, r0, r6
	movs r1, #0x15
	movs r2, #0
	bl GetMonData
	adds r1, r0, #0
	adds r0, r4, #0
	adds r2, r5, #0
	bl CalculatePPWithBonus
	mov r1, sb
	strh r0, [r1]
	ldr r0, [r7]
	adds r0, r0, r6
	adds r1, r5, #0
	adds r1, #0x11
	mov r2, sb
	bl SetMonData
	adds r5, #1
	cmp r5, #3
	ble _02002BC6
	mov r6, r8
	ldr r3, =gUnknown_02021860
	cmp r6, #5
	ble _02002B80
	adds r0, r3, #0
	bl sub_020017E8
	bl FadeIn
	bl sub_020026F4
	bl FadeOut
_02002C1E:
	add sp, #0xc
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02002C44
sub_02002C44: @ 0x02002C44
	push {r4, r5, lr}
	sub sp, #4
	mov r0, sp
	movs r4, #0
	strh r4, [r0]
	ldr r5, =gUnknown_02021860
	ldr r2, =0x01000094
	adds r1, r5, #0
	bl CpuSet
	movs r1, #0x8d
	lsls r1, r1, #1
	adds r0, r5, r1
	strb r4, [r0]
	adds r1, #1
	adds r0, r5, r1
	strb r4, [r0]
	movs r0, #0x8f
	lsls r0, r0, #1
	adds r1, r5, r0
	movs r0, #1
	strb r0, [r1]
	add sp, #4
	pop {r4, r5}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02002C80
sub_02002C80: @ 0x02002C80
	ldr r1, =gUnknown_02021860
	ldr r0, =0x0000011B
	adds r2, r1, r0
	movs r0, #0
	strb r0, [r2]
	movs r2, #0x8d
	lsls r2, r2, #1
	adds r0, r1, r2
	ldrb r0, [r0]
	cmp r0, #0
	bne _02002CA8
	movs r0, #0x8f
	lsls r0, r0, #1
	adds r1, r1, r0
	movs r0, #1
	b _02002CB0
	.align 2, 0
	.pool
_02002CA8:
	movs r2, #0x8f
	lsls r2, r2, #1
	adds r1, r1, r2
	movs r0, #2
_02002CB0:
	strb r0, [r1]
	bx lr

	thumb_func_start sub_02002CB4
sub_02002CB4: @ 0x02002CB4
	push {r4, r5, r6, r7, lr}
	mov r7, r8
	push {r7}
	adds r4, r0, #0
	adds r6, r1, #0
	adds r5, r2, #0
	ldrb r0, [r4]
	adds r1, r0, #0
	cmp r1, #0xfc
	beq _02002D0C
	movs r7, #0
	adds r0, r6, r5
	mov ip, r0
	lsls r5, r5, #1
	mov r8, r5
	cmp r1, #0xff
	beq _02002CF6
	ldr r5, =gUnknown_0201F6B0
	mov r2, ip
_02002CDA:
	ldrb r1, [r4]
	lsls r0, r1, #1
	adds r0, r0, r5
	ldrh r3, [r0]
	adds r1, r6, r7
	lsrs r0, r3, #8
	strb r0, [r1]
	strb r3, [r2, #1]
	adds r4, #1
	adds r2, #1
	adds r7, #1
	ldrb r0, [r4]
	cmp r0, #0xff
	bne _02002CDA
_02002CF6:
	movs r0, #0xfe
	mov r1, ip
	strb r0, [r1]
	mov r0, r8
	adds r1, r0, r6
	movs r0, #0xff
	strb r0, [r1, #1]
	b _02002D52
	.align 2, 0
	.pool
_02002D0C:
	strb r0, [r6]
	adds r4, #1
	ldrb r0, [r4]
	strb r0, [r6, #1]
	adds r4, #1
	subs r5, #2
	movs r7, #2
	ldrb r0, [r4]
	cmp r0, #0xff
	beq _02002D44
	ldr r1, =gUnknown_0201F4B0
	mov r8, r1
	adds r0, r5, r6
	adds r2, r0, #2
_02002D28:
	ldrb r1, [r4]
	lsls r0, r1, #1
	add r0, r8
	ldrh r3, [r0]
	adds r1, r6, r7
	lsrs r0, r3, #8
	strb r0, [r1]
	strb r3, [r2, #1]
	adds r4, #1
	adds r2, #1
	adds r7, #1
	ldrb r0, [r4]
	cmp r0, #0xff
	bne _02002D28
_02002D44:
	adds r1, r5, r6
	movs r0, #0xfe
	strb r0, [r1, #2]
	lsls r0, r5, #1
	adds r0, r0, r6
	movs r1, #0xff
	strb r1, [r0, #3]
_02002D52:
	pop {r3}
	mov r8, r3
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02002D60
sub_02002D60: @ 0x02002D60
	push {r4, r5, r6, lr}
	sub sp, #0x10
	adds r3, r0, #0
	adds r4, r1, #0
	adds r5, r2, #0
	movs r0, #1
	str r0, [sp]
	movs r0, #8
	str r0, [sp, #4]
	movs r0, #1
	adds r1, r3, #0
	adds r2, r4, #0
	movs r3, #3
	bl CreateSomeWindowParameterized
	adds r6, r0, #0
	ldr r2, =gPlayerPartyPtr
	movs r0, #0x64
	adds r1, r5, #0
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	movs r1, #0x38
	movs r2, #0
	bl GetMonData
	adds r4, r0, #0
	add r1, sp, #8
	movs r0, #0x60
	strb r0, [r1]
	movs r0, #0xff
	strb r0, [r1, #1]
	adds r0, r6, #0
	movs r1, #0
	movs r2, #0
	bl TextWindowSetXY
	adds r0, r6, #0
	add r1, sp, #8
	bl RenderText
	adds r0, r4, #0
	add r1, sp, #8
	movs r2, #0x76
	bl NumToPmString3CustomZeroChar
	movs r1, #0
	add r0, sp, #8
	b _02002DD0
	.align 2, 0
	.pool
_02002DC8:
	adds r1, #1
	mov r0, sp
	adds r0, r0, r1
	adds r0, #8
_02002DD0:
	ldrb r0, [r0]
	cmp r0, #0x76
	beq _02002DC8
	mov r0, sp
	adds r0, r0, r1
	adds r0, #8
	ldrb r0, [r0]
	cmp r0, #0xff
	bne _02002DE4
	subs r1, #1
_02002DE4:
	add r1, sp
	adds r1, #8
	adds r0, r6, #0
	bl RenderText_NoPlaceholders
	adds r0, r6, #0
	add sp, #0x10
	pop {r4, r5, r6}
	pop {r1}
	bx r1

	thumb_func_start sub_02002DF8
sub_02002DF8: @ 0x02002DF8
	push {r4, r5, lr}
	adds r4, r0, #0
	adds r5, r1, #0
	ldr r3, =gPlayerPartyPtr
	movs r0, #0x64
	adds r1, r2, #0
	muls r1, r0, r1
	ldr r0, [r3]
	adds r0, r0, r1
	bl GetMonGender
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	cmp r0, #0
	beq _02002E24
	cmp r0, #0xfe
	beq _02002E28
	movs r3, #0
	b _02002E2A
	.align 2, 0
	.pool
_02002E24:
	movs r3, #0xf
	b _02002E2A
_02002E28:
	movs r3, #0x11
_02002E2A:
	movs r0, #0
	adds r1, r4, #0
	adds r2, r5, #0
	bl SetBgTilemapBufferTileAt
	pop {r4, r5}
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start sub_02002E3C
sub_02002E3C: @ 0x02002E3C
	push {r4, lr}
	adds r3, r0, #0
	ldr r0, =gAgbPmRomParams
	ldr r0, [r0]
	ldr r2, [r0, #0x38]
	ldrh r4, [r3, #6]
	lsls r0, r4, #2
	adds r0, r0, r2
	lsls r1, r1, #9
	ldr r0, [r0]
	adds r0, r0, r1
	ldrh r3, [r3, #8]
	lsls r1, r3, #5
	ldr r2, =0x06010000
	adds r1, r1, r2
	movs r2, #0x80
	lsls r2, r2, #1
	bl CpuSet
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02002E70
sub_02002E70: @ 0x02002E70
	push {r4, r5, lr}
	sub sp, #0xc
	adds r5, r0, #0
	cmp r5, #1
	beq _02002EC0
	cmp r5, #1
	bgt _02002E84
	cmp r5, #0
	beq _02002E8A
	b _02002ED8
_02002E84:
	cmp r5, #2
	beq _02002E94
	b _02002ED8
_02002E8A:
	movs r0, #2
	str r0, [sp]
	movs r0, #0x18
	str r0, [sp, #4]
	b _02002EAE
_02002E94:
	str r5, [sp]
	movs r4, #0x18
	str r4, [sp, #4]
	movs r0, #0x10
	str r0, [sp, #8]
	movs r0, #1
	movs r1, #0xc
	movs r2, #0x14
	movs r3, #6
	bl CopyRectWithinBgTilemapBuffer
	str r5, [sp]
	str r4, [sp, #4]
_02002EAE:
	movs r0, #0x12
	str r0, [sp, #8]
	movs r0, #1
	movs r1, #0
	movs r2, #0x14
	movs r3, #6
	bl CopyRectWithinBgTilemapBuffer
	b _02002ED8
_02002EC0:
	movs r0, #2
	str r0, [sp]
	movs r0, #0x18
	str r0, [sp, #4]
	movs r0, #0x12
	str r0, [sp, #8]
	movs r0, #1
	movs r1, #0xc
	movs r2, #0x14
	movs r3, #6
	bl CopyRectWithinBgTilemapBuffer
_02002ED8:
	add sp, #0xc
	pop {r4, r5}
	pop {r0}
	bx r0

	thumb_func_start sub_02002EE0
sub_02002EE0: @ 0x02002EE0
	push {r4, r5, lr}
	sub sp, #4
	adds r5, r0, #0
	adds r4, r1, #0
	movs r1, #0
	bl ClearWindowCharBuffer
	adds r4, #0x22
	ldrb r0, [r4]
	cmp r0, #0
	bne _02002F08
	ldr r3, =gText_Space
	adds r0, r5, #0
	movs r1, #0
	movs r2, #2
	bl RenderTextAt
	b _02002F2A
	.align 2, 0
	.pool
_02002F08:
	mov r1, sp
	adds r0, #0xa1
	strb r0, [r1]
	movs r0, #0xff
	strb r0, [r1, #1]
	movs r0, #0
	bl BufferString
	adds r0, r5, #0
	movs r1, #0
	movs r2, #2
	bl TextWindowSetXY
	ldr r1, =gText_Number
	adds r0, r5, #0
	bl RenderText
_02002F2A:
	add sp, #4
	pop {r4, r5}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02002F38
sub_02002F38: @ 0x02002F38
	adds r3, r0, #0
	movs r1, #0
	ldr r0, =gUnknown_02021860
	adds r2, r0, #0
	adds r2, #0x22
_02002F42:
	ldrb r0, [r2]
	cmp r0, r3
	bne _02002F50
	adds r0, r1, #0
	b _02002F5C
	.align 2, 0
	.pool
_02002F50:
	adds r2, #0x2c
	adds r1, #1
	cmp r1, #5
	ble _02002F42
	movs r0, #1
	rsbs r0, r0, #0
_02002F5C:
	bx lr
	.align 2, 0

	thumb_func_start sub_02002F60
sub_02002F60: @ 0x02002F60
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	movs r7, #0
	movs r6, #0
	movs r1, #1
	ldr r2, =gUnknown_02021860
	movs r3, #0x92
	lsls r3, r3, #1
	adds r0, r2, r3
	ldrb r0, [r0]
	adds r0, #1
	ldr r3, =gUnknown_02024960
	mov sl, r3
	cmp r1, r0
	bge _02002FC8
	mov r8, r2
	mov ip, r0
	movs r0, #1
	rsbs r0, r0, #0
	mov sb, r0
_02002F8E:
	movs r3, #0
	adds r4, r6, #4
	adds r5, r1, #1
	mov r2, r8
	adds r2, #0x22
_02002F98:
	ldrb r0, [r2]
	cmp r0, r1
	bne _02002FAC
	adds r0, r3, #0
	b _02002FB8
	.align 2, 0
	.pool
_02002FAC:
	adds r2, #0x2c
	adds r3, #1
	cmp r3, #5
	ble _02002F98
	movs r0, #1
	rsbs r0, r0, #0
_02002FB8:
	cmp r0, sb
	beq _02002FC0
	lsls r0, r6
	orrs r7, r0
_02002FC0:
	adds r6, r4, #0
	adds r1, r5, #0
	cmp r1, ip
	blt _02002F8E
_02002FC8:
	movs r0, #0x88
	lsls r0, r0, #4
	add r0, sl
	str r7, [r0]
	ldr r1, =0x0000087F
	add r1, sl
	ldrb r0, [r1]
	movs r0, #1
	strb r0, [r1]
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02002FEC
sub_02002FEC: @ 0x02002FEC
	push {r4, lr}
	sub sp, #4
	bl ClearVram
	movs r1, #0x80
	lsls r1, r1, #0x13
	movs r2, #0xfa
	lsls r2, r2, #5
	adds r0, r2, #0
	strh r0, [r1]
	adds r1, #8
	movs r2, #0xd8
	lsls r2, r2, #5
	adds r0, r2, #0
	strh r0, [r1]
	adds r1, #2
	ldr r2, =0x00001C09
	adds r0, r2, #0
	strh r0, [r1]
	adds r1, #2
	ldr r2, =0x00005E0A
	adds r0, r2, #0
	strh r0, [r1]
	adds r1, #2
	ldr r2, =0x00001D0B
	adds r0, r2, #0
	strh r0, [r1]
	ldr r0, =gSummaryScreen_Pal
	movs r1, #0xa0
	lsls r1, r1, #0x13
	bl AutoUnCompVram
	ldr r0, =gSummaryScreen_Gfx
	ldr r1, =0x06008000
	bl AutoUnCompVram
	ldr r0, =gSummaryIcons_Gfx
	movs r1, #0xc0
	lsls r1, r1, #0x13
	bl AutoUnCompVram
	ldr r0, =gSummaryScreen_Moves_Tilemap
	ldr r1, =0x03002000
	bl AutoUnCompVram
	ldr r0, =gSummaryScreen_Skills_Tilemap
	ldr r1, =0x03003000
	bl AutoUnCompVram
	ldr r1, =gBgTilemapBufferTransferScheduled
	movs r4, #0
	movs r0, #1
	strb r0, [r1, #2]
	strb r0, [r1, #3]
	ldr r0, =gTypeStatusIcons_Pal
	ldr r1, =0x05000200
	bl AutoUnCompVram
	ldr r0, =gTypeStatusIcons_Gfx
	ldr r1, =0x06010000
	bl AutoUnCompVram
	mov r0, sp
	strh r4, [r0]
	ldr r4, =gUnknown_02021990
	ldr r2, =0x0100002A
	adds r1, r4, #0
	bl CpuSet
	ldr r1, =gUnknown_0201FB50
	movs r0, #0
	bl AddWindow
	str r0, [r4, #0x24]
	ldr r1, =gUnknown_0201FB30
	movs r0, #3
	bl AddWindow
	str r0, [r4, #0x20]
	add sp, #4
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start CreatePartyMonFrontPic
CreatePartyMonFrontPic: @ 0x020030E4
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #8
	adds r6, r0, #0
	mov sb, r1
	str r2, [sp]
	str r3, [sp, #4]
	ldr r0, =gAgbPmRomParams
	mov sl, r0
	ldr r0, [r0]
	adds r0, #0xbc
	ldr r7, [r0]
	ldr r5, =gPlayerPartyPtr
	movs r0, #0x64
	mov r4, sb
	muls r4, r0, r4
	ldr r0, [r5]
	adds r0, r0, r4
	movs r1, #0xb
	movs r2, #0
	bl GetMonData
	strh r0, [r6, #0x14]
	lsls r0, r0, #0x10
	cmp r0, #0
	beq _020031DE
	ldr r0, [r5]
	adds r0, r0, r4
	movs r1, #0
	movs r2, #0
	bl GetMonData
	mov r8, r0
	ldrh r0, [r6, #0x14]
	mov r1, r8
	bl FixUnownSpecies
	strh r0, [r6, #0x16]
	ldr r0, [r6]
	cmp r0, #0
	beq _02003140
	bl MoveSpriteToHead
_02003140:
	ldrh r1, [r6, #0x14]
	lsls r0, r1, #3
	subs r0, r0, r1
	lsls r0, r0, #2
	adds r0, r0, r7
	ldrb r0, [r0, #0x19]
	lsrs r5, r0, #7
	movs r0, #1
	bl DelayFrames
	mov r2, sl
	ldr r0, [r2]
	ldrh r2, [r6, #0x16]
	lsls r1, r2, #3
	ldr r4, [r0, #0x28]
	adds r4, r4, r1
	bl GetPicUncompPtr
	adds r7, r0, #0
	ldr r0, [r4]
	adds r1, r7, #0
	bl LZ77UnCompVram
	ldrh r0, [r6, #0x14]
	mov r1, r8
	adds r2, r7, #0
	bl DrawSpindasSpots
	mov r0, sb
	bl GetBoxMonPalettePtr
	movs r1, #0x80
	lsls r1, r1, #6
	adds r4, r7, r1
	ldr r0, [r0]
	adds r1, r4, #0
	bl LZ77UnCompWram
	ldr r1, =gMonFrontPicSubspriteTable
	lsls r0, r5, #2
	adds r0, r0, r1
	ldr r2, [r0]
	ldr r0, [sp]
	ldr r1, [sp, #4]
	bl AddSprite
	str r0, [r6]
	movs r1, #4
	bl SetSpritePaletteNum
	cmp r5, #0
	bne _020031C8
	ldr r1, =0x06016000
	movs r2, #0x80
	lsls r2, r2, #3
	adds r0, r7, #0
	bl CpuSet
	b _020031D4
	.align 2, 0
	.pool
_020031C8:
	ldr r1, =0x06012000
	movs r2, #0x80
	lsls r2, r2, #3
	adds r0, r7, #0
	bl CpuSet
_020031D4:
	ldr r1, =0x05000280
	adds r0, r4, #0
	movs r2, #0x10
	bl CpuSet
_020031DE:
	add sp, #8
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_020031F8
sub_020031F8: @ 0x020031F8
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #0x24
	mov sb, r0
	movs r1, #0xa0
	rsbs r1, r1, #0
	movs r0, #2
	movs r2, #0
	bl SetBgPos
	ldr r7, =gUnknown_02021990
	ldr r0, [r7, #0x24]
	movs r1, #0
	movs r2, #0
	bl TextWindowSetXY
	ldr r0, [r7, #0x24]
	movs r1, #1
	movs r2, #8
	bl SetTextColor
	movs r5, #2
	str r5, [sp]
	movs r4, #0xf
	str r4, [sp, #4]
	movs r0, #0
	movs r1, #0xb
	movs r2, #8
	movs r3, #0x12
	bl SetBgTilemapBufferPaletteRect
	str r5, [sp]
	str r4, [sp, #4]
	movs r0, #0
	movs r1, #0x10
	movs r2, #0xb
	movs r3, #6
	bl SetBgTilemapBufferPaletteRect
	movs r0, #4
	str r0, [sp]
	str r4, [sp, #4]
	movs r0, #0
	movs r1, #0x11
	movs r2, #0xd
	movs r3, #5
	bl SetBgTilemapBufferPaletteRect
	movs r0, #6
	str r0, [sp]
	str r4, [sp, #4]
	movs r0, #0
	movs r1, #0x1b
	movs r2, #0xb
	movs r3, #3
	bl SetBgTilemapBufferPaletteRect
	str r5, [sp]
	str r4, [sp, #4]
	movs r0, #0
	movs r1, #0xb
	movs r2, #0x12
	movs r3, #0x12
	bl SetBgTilemapBufferPaletteRect
	ldr r0, [r7, #0x24]
	ldr r1, =gText_Type
	bl RenderText
	ldr r5, =gPlayerPartyPtr
	movs r0, #0x64
	mov r4, sb
	muls r4, r0, r4
	ldr r0, [r5]
	adds r0, r0, r4
	movs r1, #1
	bl GetMonType
	adds r6, r0, #0
	ldr r0, [r5]
	adds r0, r0, r4
	movs r1, #2
	bl GetMonType
	adds r5, r0, #0
	ldr r0, [r7, #4]
	cmp r0, #0
	bne _020032C8
	ldr r4, =gUnknown_0201FA44
	movs r0, #0x7a
	movs r1, #0x18
	adds r2, r4, #0
	bl AddSprite
	str r0, [r7, #4]
	movs r0, #0xa2
	movs r1, #0x18
	adds r2, r4, #0
	bl AddSprite
	str r0, [r7, #8]
_020032C8:
	ldr r0, [r7, #4]
	lsls r1, r6, #3
	bl SetSpriteTileOffset
	ldr r4, [r7, #4]
	adds r0, r6, #0
	bl GetMonSpritePaletteNumByBaseBlock
	adds r1, r0, #0
	adds r0, r4, #0
	bl SetSpritePaletteNum
	cmp r5, #0
	beq _0200331C
	cmp r6, r5
	beq _0200331C
	ldr r0, [r7, #8]
	lsls r1, r5, #3
	bl SetSpriteTileOffset
	ldr r4, [r7, #8]
	adds r0, r5, #0
	bl GetMonSpritePaletteNumByBaseBlock
	adds r1, r0, #0
	adds r0, r4, #0
	bl SetSpritePaletteNum
	ldr r0, [r7, #8]
	movs r1, #0
	bl SetSpriteInvisible
	b _02003326
	.align 2, 0
	.pool
_0200331C:
	ldr r0, =gUnknown_02021990
	ldr r0, [r0, #8]
	movs r1, #1
	bl SetSpriteInvisible
_02003326:
	ldr r0, =gPlayerPartyPtr
	mov sl, r0
	movs r0, #0x64
	mov r1, sb
	muls r1, r0, r1
	mov r8, r1
	mov r1, sl
	ldr r0, [r1]
	add r0, r8
	bl GetBoxMonAbility
	adds r5, r0, #0
	ldr r6, =gUnknown_02021990
	ldr r0, [r6, #0x24]
	movs r1, #4
	str r1, [sp]
	movs r7, #0
	str r7, [sp, #4]
	movs r1, #0
	movs r2, #3
	movs r3, #0x12
	bl FillWindowCharBufferRect
	ldr r0, [r6, #0x24]
	movs r1, #0
	movs r2, #0x18
	bl TextWindowSetXY
	ldr r4, [r6, #0x24]
	adds r0, r5, #0
	bl GetAbilityName
	adds r1, r0, #0
	adds r0, r4, #0
	bl RenderText
	ldr r0, [r6, #0x24]
	movs r1, #0
	movs r2, #0x28
	bl TextWindowSetXY
	ldr r4, [r6, #0x24]
	adds r0, r5, #0
	bl GetAbilityDescription
	adds r1, r0, #0
	adds r0, r4, #0
	bl RenderText
	ldrb r0, [r6, #0x18]
	cmp r0, #0
	bne _020033A0
	ldr r0, [r6, #0x24]
	movs r1, #0xf
	movs r2, #0x40
	bl TextWindowSetXY
	ldr r0, [r6, #0x24]
	ldr r1, =gText_HP
	bl RenderText
_020033A0:
	mov r1, sl
	ldr r0, [r1]
	add r0, r8
	movs r1, #0x39
	movs r2, #0
	bl GetMonData
	adds r1, r0, #0
	add r0, sp, #0xc
	bl NumToPmString3RightAlign
	add r1, sp, #0xc
	movs r0, #0xba
	strb r0, [r1, #3]
	mov r1, sl
	ldr r0, [r1]
	add r0, r8
	movs r1, #0x3a
	movs r2, #0
	bl GetMonData
	adds r1, r0, #0
	add r0, sp, #0x10
	bl NumToPmString3RightAlign
	ldr r0, [r6, #0x24]
	movs r1, #0x2d
	movs r2, #0x40
	bl TextWindowSetXY
	ldr r0, [r6, #0x24]
	movs r5, #6
	strb r5, [r0, #0x1c]
	ldr r0, [r6, #0x24]
	movs r4, #2
	str r4, [sp]
	str r7, [sp, #4]
	movs r1, #5
	movs r2, #8
	movs r3, #6
	bl FillWindowCharBufferRect
	ldr r0, [r6, #0x24]
	add r1, sp, #0xc
	bl RenderText
	ldrb r0, [r6, #0x18]
	cmp r0, #0
	bne _02003414
	ldr r0, [r6, #0x24]
	movs r1, #2
	movs r2, #0x50
	bl TextWindowSetXY
	ldr r0, [r6, #0x24]
	ldr r1, =gText_Attack
	bl RenderText
_02003414:
	ldr r0, [r6, #0x24]
	strb r5, [r0, #0x1c]
	ldr r0, [r6, #0x24]
	str r4, [sp]
	str r7, [sp, #4]
	movs r1, #5
	movs r2, #0xa
	movs r3, #6
	bl FillWindowCharBufferRect
	ldr r7, [r6, #0x24]
	movs r6, #0x2d
	mov r1, sl
	ldr r0, [r1]
	add r0, r8
	movs r1, #0x3b
	movs r2, #0
	bl GetMonData
	adds r4, r0, #0
	add r0, sp, #0x1c
	adds r1, r4, #0
	bl NumToPmString3RightAlign
	movs r5, #1
	cmp r4, #9
	ble _02003452
	movs r5, #3
	cmp r4, #0x63
	bgt _02003452
	movs r5, #2
_02003452:
	adds r1, r6, #0
	adds r1, #0x15
	lsls r0, r5, #1
	adds r0, r0, r5
	subs r6, r1, r0
	adds r0, r7, #0
	adds r1, r6, #0
	movs r2, #0x50
	bl TextWindowSetXY
	mov r4, sp
	adds r4, #0x1f
	subs r1, r4, r5
	adds r0, r7, #0
	bl RenderText
	ldr r5, =gUnknown_02021990
	ldrb r0, [r5, #0x18]
	mov r8, r4
	cmp r0, #0
	bne _0200348E
	ldr r0, [r5, #0x24]
	movs r1, #0
	movs r2, #0x60
	bl TextWindowSetXY
	ldr r0, [r5, #0x24]
	ldr r1, =gText_Defense
	bl RenderText
_0200348E:
	ldr r1, [r5, #0x24]
	movs r2, #0
	movs r0, #6
	strb r0, [r1, #0x1c]
	ldr r0, [r5, #0x24]
	movs r1, #2
	str r1, [sp]
	str r2, [sp, #4]
	movs r1, #6
	movs r2, #0xc
	movs r3, #5
	bl FillWindowCharBufferRect
	ldr r7, [r5, #0x24]
	movs r6, #0x2d
	ldr r2, =gPlayerPartyPtr
	movs r0, #0x64
	mov r1, sb
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	movs r1, #0x3c
	movs r2, #0
	bl GetMonData
	adds r5, r0, #0
	add r0, sp, #0x1c
	adds r1, r5, #0
	bl NumToPmString3RightAlign
	movs r4, #1
	cmp r5, #9
	ble _020034D8
	movs r4, #3
	cmp r5, #0x63
	bgt _020034D8
	movs r4, #2
_020034D8:
	adds r1, r6, #0
	adds r1, #0x15
	lsls r0, r4, #1
	adds r0, r0, r4
	subs r6, r1, r0
	adds r0, r7, #0
	adds r1, r6, #0
	movs r2, #0x60
	bl TextWindowSetXY
	mov r0, r8
	subs r1, r0, r4
	adds r0, r7, #0
	bl RenderText
	ldr r5, =gUnknown_02021990
	ldr r0, [r5, #0x24]
	movs r1, #6
	str r1, [sp]
	movs r1, #0
	str r1, [sp, #4]
	movs r1, #0x10
	movs r2, #8
	movs r3, #3
	bl FillWindowCharBufferRect
	ldrb r0, [r5, #0x18]
	cmp r0, #0
	bne _02003524
	ldr r0, [r5, #0x24]
	movs r1, #0x58
	movs r2, #0x40
	bl TextWindowSetXY
	ldr r0, [r5, #0x24]
	ldr r1, =gText_SpAtk
	bl RenderText
_02003524:
	ldr r7, [r5, #0x24]
	movs r6, #0x80
	ldr r2, =gPlayerPartyPtr
	movs r0, #0x64
	mov r1, sb
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	movs r1, #0x3e
	movs r2, #0
	bl GetMonData
	adds r5, r0, #0
	add r0, sp, #0x1c
	adds r1, r5, #0
	bl NumToPmString3RightAlign
	movs r4, #1
	cmp r5, #9
	ble _02003554
	movs r4, #3
	cmp r5, #0x63
	bgt _02003554
	movs r4, #2
_02003554:
	adds r1, r6, #0
	adds r1, #9
	lsls r0, r4, #1
	adds r0, r0, r4
	subs r6, r1, r0
	adds r0, r7, #0
	adds r1, r6, #0
	movs r2, #0x40
	bl TextWindowSetXY
	mov r0, r8
	subs r1, r0, r4
	adds r0, r7, #0
	bl RenderText
	ldr r5, =gUnknown_02021990
	ldrb r0, [r5, #0x18]
	cmp r0, #0
	bne _0200358C
	ldr r0, [r5, #0x24]
	movs r1, #0x58
	movs r2, #0x50
	bl TextWindowSetXY
	ldr r0, [r5, #0x24]
	ldr r1, =gText_SpDef
	bl RenderText
_0200358C:
	ldr r7, [r5, #0x24]
	movs r6, #0x80
	ldr r2, =gPlayerPartyPtr
	movs r0, #0x64
	mov r1, sb
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	movs r1, #0x3f
	movs r2, #0
	bl GetMonData
	adds r5, r0, #0
	add r0, sp, #0x1c
	adds r1, r5, #0
	bl NumToPmString3RightAlign
	movs r4, #1
	cmp r5, #9
	ble _020035BC
	movs r4, #3
	cmp r5, #0x63
	bgt _020035BC
	movs r4, #2
_020035BC:
	adds r1, r6, #0
	adds r1, #9
	lsls r0, r4, #1
	adds r0, r0, r4
	subs r6, r1, r0
	adds r0, r7, #0
	adds r1, r6, #0
	movs r2, #0x50
	bl TextWindowSetXY
	mov r0, r8
	subs r1, r0, r4
	adds r0, r7, #0
	bl RenderText
	ldr r5, =gUnknown_02021990
	ldrb r0, [r5, #0x18]
	cmp r0, #0
	bne _020035F4
	ldr r0, [r5, #0x24]
	movs r1, #0x58
	movs r2, #0x60
	bl TextWindowSetXY
	ldr r0, [r5, #0x24]
	ldr r1, =gText_Speed
	bl RenderText
_020035F4:
	ldr r7, [r5, #0x24]
	movs r6, #0x80
	ldr r2, =gPlayerPartyPtr
	movs r0, #0x64
	mov r1, sb
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	movs r1, #0x3d
	movs r2, #0
	bl GetMonData
	adds r5, r0, #0
	add r0, sp, #0x1c
	adds r1, r5, #0
	bl NumToPmString3RightAlign
	movs r4, #1
	cmp r5, #9
	ble _02003624
	movs r4, #3
	cmp r5, #0x63
	bgt _02003624
	movs r4, #2
_02003624:
	adds r1, r6, #0
	adds r1, #9
	lsls r0, r4, #1
	adds r0, r0, r4
	subs r6, r1, r0
	adds r0, r7, #0
	adds r1, r6, #0
	movs r2, #0x60
	bl TextWindowSetXY
	mov r0, r8
	subs r1, r0, r4
	adds r0, r7, #0
	bl RenderText
	ldr r4, =gUnknown_02021990
	ldr r0, [r4, #0x24]
	movs r1, #2
	str r1, [sp]
	movs r1, #0
	str r1, [sp, #4]
	movs r2, #0xf
	movs r3, #0x12
	bl FillWindowCharBufferRect
	ldr r0, [r4, #0x24]
	movs r1, #0
	movs r2, #0x78
	bl TextWindowSetXY
	ldr r2, =gPlayerPartyPtr
	movs r0, #0x64
	mov r1, sb
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	movs r1, #0xc
	movs r2, #0
	bl GetMonData
	adds r1, r0, #0
	cmp r1, #0
	bne _020036A8
	ldr r0, [r4, #0x24]
	ldr r1, =gText_None
	bl RenderText
	b _020036BA
	.align 2, 0
	.pool
_020036A8:
	ldr r2, =gText_Berry
	adds r0, r1, #0
	add r1, sp, #0xc
	bl CopyItemName
	ldr r0, [r4, #0x24]
	add r1, sp, #0xc
	bl RenderText
_020036BA:
	ldr r4, =gUnknown_02021990
	ldr r0, [r4, #0x28]
	cmp r0, #0
	bne _020036CC
	ldr r1, =gUnknown_0201FB70
	movs r0, #1
	bl AddWindow
	str r0, [r4, #0x28]
_020036CC:
	ldr r0, [r4, #0x28]
	movs r1, #0
	bl ClearWindowCharBuffer
	ldr r3, =0x0000F00B
	movs r0, #0
	movs r1, #0x17
	movs r2, #0
	bl SetBgTilemapBufferTileAt
	ldr r3, =0x0000F00D
	movs r0, #0
	movs r1, #0x18
	movs r2, #0
	bl SetBgTilemapBufferTileAt
	ldr r3, =0x0000F00C
	movs r0, #0
	movs r1, #0x17
	movs r2, #1
	bl SetBgTilemapBufferTileAt
	ldr r3, =0x0000F00E
	movs r0, #0
	movs r1, #0x18
	movs r2, #1
	bl SetBgTilemapBufferTileAt
	ldr r0, [r4, #0x28]
	movs r1, #1
	movs r2, #8
	bl SetTextColor
	ldr r0, [r4, #0x24]
	movs r1, #0
	movs r2, #0
	bl TextWindowSetXY
	ldr r0, [r4, #0x28]
	ldr r1, =gText_Cancel2
	bl RenderText
	movs r0, #2
	str r0, [sp]
	movs r0, #0xb
	str r0, [sp, #4]
	movs r0, #0
	str r0, [sp, #8]
	movs r0, #3
	movs r1, #0
	movs r2, #0x14
	movs r3, #4
	bl CopyRectWithinBgTilemapBuffer
	ldr r0, [r4, #0x1c]
	movs r1, #0
	bl ClearWindowCharBuffer
	ldr r0, [r4, #0x1c]
	ldr r1, =gText_PokemonSkills
	bl RenderText
	ldr r1, =gBgTilemapBufferTransferScheduled
	movs r0, #1
	strb r0, [r1]
	strb r0, [r1, #3]
	strb r0, [r4, #0x18]
	add sp, #0x24
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_0200378C
sub_0200378C: @ 0x0200378C
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #0x40
	ldr r2, =gPlayerPartyPtr
	movs r1, #0x64
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	str r0, [sp, #0x24]
	ldr r0, =gAgbPmRomParams
	ldr r0, [r0]
	adds r0, #0xcc
	ldr r0, [r0]
	str r0, [sp, #0x28]
	ldr r4, =gUnknown_02021990
	ldr r0, [r4, #0x24]
	movs r1, #1
	movs r2, #8
	bl SetTextColor
	movs r0, #8
	str r0, [sp]
	movs r0, #0xf
	str r0, [sp, #4]
	movs r0, #0
	movs r1, #0x18
	movs r2, #4
	movs r3, #5
	bl SetBgTilemapBufferPaletteRect
	adds r4, #0x4c
	ldr r0, =0x0000FFFF
	strh r0, [r4]
	movs r0, #0
	mov sb, r0
	add r1, sp, #0xc
	mov r8, r1
	movs r2, #5
	str r2, [sp, #0x2c]
	movs r0, #4
	str r0, [sp, #0x30]
	movs r1, #8
	mov sl, r1
	movs r2, #0
	str r2, [sp, #0x34]
	movs r0, #1
	str r0, [sp, #0x38]
	movs r1, #0
	str r1, [sp, #0x3c]
_020037F4:
	ldr r0, [sp, #0x24]
	mov r1, sb
	bl GetBoxMonMoveBySlot
	adds r6, r0, #0
	mov r2, sb
	lsls r1, r2, #0x18
	lsrs r1, r1, #0x18
	ldr r0, [sp, #0x24]
	bl GetBoxMonPPByMoveSlot
	str r0, [sp, #0x1c]
	ldr r0, [sp, #0x24]
	movs r1, #0x15
	movs r2, #0
	bl GetMonData
	adds r1, r0, #0
	adds r0, r6, #0
	mov r2, sb
	bl CalculatePPWithBonus
	str r0, [sp, #0x20]
	lsls r0, r6, #1
	adds r0, r0, r6
	lsls r0, r0, #2
	ldr r1, [sp, #0x28]
	adds r0, r0, r1
	ldrb r7, [r0, #2]
	ldr r1, =gUnknown_02021990
	adds r0, r1, #0
	adds r0, #0x44
	ldr r2, [sp, #0x3c]
	adds r0, r2, r0
	strh r6, [r0]
	mov r2, sb
	lsls r0, r2, #2
	adds r1, #0x2c
	adds r5, r0, r1
	ldr r0, [r5]
	cmp r0, #0
	bne _02003856
	ldr r1, [sp, #0x34]
	adds r1, #0x20
	movs r0, #0x57
	ldr r2, =gUnknown_0201FA44
	bl AddSprite
	str r0, [r5]
_02003856:
	cmp r6, #0
	beq _02003890
	ldr r0, [r5]
	lsls r1, r7, #3
	bl SetSpriteTileOffset
	ldr r4, [r5]
	adds r0, r7, #0
	bl GetMonSpritePaletteNumByBaseBlock
	adds r1, r0, #0
	adds r0, r4, #0
	bl SetSpritePaletteNum
	ldr r0, [r5]
	movs r1, #0
	bl SetSpriteInvisible
	b _02003898
	.align 2, 0
	.pool
_02003890:
	ldr r0, [r5]
	movs r1, #1
	bl SetSpriteInvisible
_02003898:
	ldr r4, =gUnknown_02021990
	ldr r0, [r4, #0x24]
	movs r1, #2
	str r1, [sp]
	movs r2, #0
	str r2, [sp, #4]
	movs r1, #4
	ldr r2, [sp, #0x38]
	movs r3, #9
	bl FillWindowCharBufferRect
	add r0, sp, #0xc
	adds r1, r6, #0
	bl CopyMoveName
	ldr r0, [r4, #0x24]
	movs r1, #0x20
	mov r2, sl
	bl TextWindowSetXY
	ldr r0, [r4, #0x24]
	add r1, sp, #0xc
	bl RenderText
	ldr r0, [r4, #0x24]
	movs r1, #2
	str r1, [sp]
	movs r2, #0
	str r2, [sp, #4]
	movs r1, #0xd
	ldr r2, [sp, #0x38]
	movs r3, #5
	bl FillWindowCharBufferRect
	cmp r6, #0
	beq _02003944
	add r0, sp, #0xc
	ldr r1, [sp, #0x1c]
	bl NumToPmString3RightAlign
	movs r0, #0xba
	mov r1, r8
	strb r0, [r1, #3]
	add r0, sp, #0x10
	ldr r1, [sp, #0x20]
	bl NumToPmString3RightAlign
	mov r2, r8
	ldrb r0, [r2, #5]
	strb r0, [r2, #4]
	ldrb r0, [r2, #6]
	strb r0, [r2, #5]
	ldrb r0, [r2, #7]
	strb r0, [r2, #6]
	ldr r1, [r4, #0x24]
	movs r0, #6
	strb r0, [r1, #0x1c]
	ldr r0, [r4, #0x24]
	movs r1, #0x6c
	mov r2, sl
	bl TextWindowSetXY
	ldr r0, [r4, #0x24]
	add r1, sp, #0xc
	bl RenderText
	movs r0, #0
	movs r1, #0x18
	ldr r2, [sp, #0x30]
	ldr r3, =0x0000F003
	bl SetBgTilemapBufferTileAt
	movs r0, #0
	movs r1, #0x18
	ldr r2, [sp, #0x2c]
	ldr r3, =0x0000F004
	bl SetBgTilemapBufferTileAt
	b _02003972
	.align 2, 0
	.pool
_02003944:
	ldr r0, [r4, #0x24]
	movs r1, #0x78
	mov r2, sl
	bl TextWindowSetXY
	ldr r0, [r4, #0x24]
	ldr r1, =gText_2Dashes
	bl RenderText
	movs r4, #0xf0
	lsls r4, r4, #8
	movs r0, #0
	movs r1, #0x18
	ldr r2, [sp, #0x30]
	adds r3, r4, #0
	bl SetBgTilemapBufferTileAt
	movs r0, #0
	movs r1, #0x18
	ldr r2, [sp, #0x2c]
	adds r3, r4, #0
	bl SetBgTilemapBufferTileAt
_02003972:
	ldr r0, [sp, #0x2c]
	adds r0, #2
	str r0, [sp, #0x2c]
	ldr r1, [sp, #0x30]
	adds r1, #2
	str r1, [sp, #0x30]
	movs r2, #0x10
	add sl, r2
	ldr r0, [sp, #0x34]
	adds r0, #0x10
	str r0, [sp, #0x34]
	ldr r1, [sp, #0x38]
	adds r1, #2
	str r1, [sp, #0x38]
	ldr r2, [sp, #0x3c]
	adds r2, #2
	str r2, [sp, #0x3c]
	movs r0, #1
	add sb, r0
	mov r1, sb
	cmp r1, #3
	bgt _020039A0
	b _020037F4
_020039A0:
	ldr r4, =gUnknown_02021990
	ldr r0, [r4, #0x28]
	cmp r0, #0
	bne _020039B2
	ldr r1, =gUnknown_0201FB70
	movs r0, #1
	bl AddWindow
	str r0, [r4, #0x28]
_020039B2:
	ldr r0, [r4, #0x28]
	movs r1, #0
	bl ClearWindowCharBuffer
	ldr r3, =0x0000F00B
	movs r0, #0
	movs r1, #0x17
	movs r2, #0
	bl SetBgTilemapBufferTileAt
	ldr r3, =0x0000F00D
	movs r0, #0
	movs r1, #0x18
	movs r2, #0
	bl SetBgTilemapBufferTileAt
	ldr r3, =0x0000F00C
	movs r0, #0
	movs r1, #0x17
	movs r2, #1
	bl SetBgTilemapBufferTileAt
	ldr r3, =0x0000F00E
	movs r0, #0
	movs r1, #0x18
	movs r2, #1
	bl SetBgTilemapBufferTileAt
	ldr r0, [r4, #0x28]
	movs r1, #1
	movs r2, #8
	bl SetTextColor
	ldr r0, [r4, #0x28]
	movs r1, #0
	movs r2, #0
	bl TextWindowSetXY
	ldr r0, [r4, #0x28]
	ldr r1, =gText_Info
	bl RenderText
	movs r0, #2
	str r0, [sp]
	movs r0, #0xb
	str r0, [sp, #4]
	movs r0, #0
	str r0, [sp, #8]
	movs r0, #3
	movs r1, #4
	movs r2, #0x14
	movs r3, #4
	bl CopyRectWithinBgTilemapBuffer
	ldr r0, [r4, #0x1c]
	movs r1, #0
	bl ClearWindowCharBuffer
	ldr r0, [r4, #0x1c]
	ldr r1, =gText_BattleMoves
	bl RenderText
	ldr r1, =gBgTilemapBufferTransferScheduled
	movs r0, #1
	strb r0, [r1]
	strb r0, [r1, #2]
	strb r0, [r1, #3]
	add sp, #0x40
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02003A70
sub_02003A70: @ 0x02003A70
	push {r4, r5, r6, r7, lr}
	mov r7, r8
	push {r7}
	sub sp, #0x10
	adds r6, r1, #0
	ldr r2, =gPlayerPartyPtr
	movs r1, #0x64
	muls r1, r0, r1
	ldr r0, [r2]
	adds r7, r0, r1
	ldr r0, =gAgbPmRomParams
	ldr r0, [r0]
	adds r0, #0xcc
	ldr r0, [r0]
	mov r8, r0
	ldr r5, =gUnknown_02021990
	ldr r0, [r5, #0x20]
	movs r4, #4
	str r4, [sp]
	movs r1, #0
	str r1, [sp, #4]
	movs r1, #6
	movs r2, #3
	movs r3, #3
	bl FillWindowCharBufferRect
	str r4, [sp]
	movs r0, #0xf
	str r0, [sp, #4]
	movs r0, #0
	movs r1, #7
	movs r2, #0xf
	movs r3, #3
	bl SetBgTilemapBufferPaletteRect
	cmp r6, #4
	bne _02003AF4
	ldr r0, [r5, #0x20]
	movs r1, #0x30
	movs r2, #0x18
	bl TextWindowSetXY
	ldr r0, [r5, #0x20]
	ldr r4, =gText_3Dashes
	adds r1, r4, #0
	bl RenderText
	ldr r0, [r5, #0x20]
	movs r1, #0x30
	movs r2, #0x28
	bl TextWindowSetXY
	ldr r0, [r5, #0x20]
	adds r1, r4, #0
	bl RenderText
	b _02003B92
	.align 2, 0
	.pool
_02003AF4:
	adds r0, r7, #0
	adds r1, r6, #0
	bl GetBoxMonMoveBySlot
	adds r6, r0, #0
	ldr r0, =0x0000FFFF
	cmp r6, r0
	beq _02003B8C
	ldr r0, [r5, #0x20]
	movs r1, #0x34
	movs r2, #0x18
	bl TextWindowSetXY
	ldr r1, [r5, #0x20]
	movs r0, #6
	strb r0, [r1, #0x1c]
	lsls r1, r6, #1
	adds r0, r1, r6
	lsls r0, r0, #2
	add r0, r8
	adds r7, r1, #0
	ldrb r1, [r0, #1]
	cmp r1, #1
	bhi _02003B38
	ldr r0, [r5, #0x20]
	ldr r1, =gText_3Dashes
	bl RenderText
	b _02003B48
	.align 2, 0
	.pool
_02003B38:
	ldrb r1, [r0, #1]
	add r0, sp, #8
	bl NumToPmString3RightAlign
	ldr r0, [r5, #0x20]
	add r1, sp, #8
	bl RenderText
_02003B48:
	ldr r4, =gUnknown_02021990
	ldr r0, [r4, #0x20]
	movs r1, #0x34
	movs r2, #0x28
	bl TextWindowSetXY
	ldr r1, [r4, #0x20]
	movs r0, #6
	strb r0, [r1, #0x1c]
	adds r0, r7, r6
	lsls r0, r0, #2
	mov r2, r8
	adds r1, r0, r2
	ldrb r0, [r1, #3]
	cmp r0, #0
	bne _02003B7C
	ldr r0, [r4, #0x20]
	ldr r1, =gText_3Dashes
	bl RenderText
	b _02003B8C
	.align 2, 0
	.pool
_02003B7C:
	ldrb r1, [r1, #3]
	add r0, sp, #8
	bl NumToPmString3RightAlign
	ldr r0, [r4, #0x20]
	add r1, sp, #8
	bl RenderText
_02003B8C:
	ldr r1, =gBgTilemapBufferTransferScheduled
	movs r0, #1
	strb r0, [r1]
_02003B92:
	add sp, #0x10
	pop {r3}
	mov r8, r3
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02003BA4
sub_02003BA4: @ 0x02003BA4
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #0x10
	str r0, [sp, #0xc]
	mov sb, r1
	ldr r7, =gUnknown_02021990
	ldr r0, =gUnknown_020219DF
	ldrb r6, [r0]
	cmp r6, #0
	bne _02003CB4
	ldr r0, [r7, #0x20]
	movs r1, #6
	str r1, [sp]
	str r6, [sp, #4]
	movs r1, #0
	movs r2, #2
	movs r3, #9
	bl FillWindowCharBufferRect
	ldr r0, [r7, #0x10]
	cmp r0, #0
	beq _02003BDC
	movs r1, #1
	bl SetSpriteInvisible
_02003BDC:
	ldr r0, [r7, #0x20]
	bl TextWindowFillTileBufferForText
	movs r0, #2
	str r0, [sp]
	movs r0, #0xf0
	lsls r0, r0, #8
	str r0, [sp, #4]
	movs r0, #3
	movs r1, #0
	movs r2, #0x12
	movs r3, #0xa
	bl FillBgTilemapBufferRect
	movs r1, #1
	mov r8, r1
	mov r1, r8
	ldr r0, =gBgTilemapBufferTransferScheduled
	strb r1, [r0, #3]
	movs r4, #7
	str r4, [sp]
	str r4, [sp, #4]
	movs r5, #0xd
	str r5, [sp, #8]
	movs r0, #2
	movs r1, #0x14
	movs r2, #0x14
	movs r3, #3
	bl CopyRectWithinBgTilemapBuffer
	mov r1, r8
	ldr r0, =gBgTilemapBufferTransferScheduled
	strb r1, [r0, #2]
	movs r0, #1
	bl DelayFrames
	str r4, [sp]
	movs r0, #4
	str r0, [sp, #4]
	str r5, [sp, #8]
	movs r0, #2
	movs r1, #0x14
	movs r2, #0x14
	movs r3, #6
	bl CopyRectWithinBgTilemapBuffer
	mov r1, r8
	ldr r0, =gBgTilemapBufferTransferScheduled
	strb r1, [r0, #2]
	movs r0, #1
	bl DelayFrames
	str r4, [sp]
	str r6, [sp, #4]
	str r5, [sp, #8]
	movs r0, #2
	movs r1, #0x14
	movs r2, #0x14
	movs r3, #0xa
	bl CopyRectWithinBgTilemapBuffer
	mov r1, r8
	ldr r0, =gBgTilemapBufferTransferScheduled
	strb r1, [r0, #2]
	ldr r0, [r7, #0xc]
	movs r1, #1
	bl SetSpriteInvisible
	ldr r0, [r7, #0x20]
	movs r1, #0
	movs r2, #0x18
	bl TextWindowSetXY
	ldr r0, [r7, #0x20]
	ldr r1, =gText_Power
	bl RenderText
	ldr r0, [r7, #0x20]
	movs r1, #0
	movs r2, #0x28
	bl TextWindowSetXY
	ldr r0, [r7, #0x20]
	ldr r1, =gText_Accuracy
	bl RenderText
	ldr r0, [sp, #0xc]
	mov r1, sb
	bl sub_02003A70
	movs r0, #1
	bl DelayFrames
	mov r1, r8
	ldr r0, =gUnknown_020219DF
	strb r1, [r0]
	b _02003D66
	.align 2, 0
	.pool
_02003CB4:
	ldr r0, [r7, #0x20]
	movs r1, #5
	str r1, [sp]
	movs r1, #0
	mov sb, r1
	str r1, [sp, #4]
	movs r2, #2
	movs r3, #9
	bl FillWindowCharBufferRect
	movs r5, #7
	str r5, [sp]
	mov r0, sb
	str r0, [sp, #4]
	movs r1, #0xd
	mov sl, r1
	str r1, [sp, #8]
	movs r0, #2
	movs r1, #0
	movs r2, #0
	movs r3, #0xa
	bl CopyRectWithinBgTilemapBuffer
	str r5, [sp]
	movs r0, #4
	str r0, [sp, #4]
	mov r0, sl
	str r0, [sp, #8]
	movs r0, #2
	movs r1, #0x14
	movs r2, #0x14
	movs r3, #6
	bl CopyRectWithinBgTilemapBuffer
	ldr r0, [r7, #0xc]
	movs r1, #0
	bl SetSpriteInvisible
	ldr r1, =gBgTilemapBufferTransferScheduled
	mov r8, r1
	movs r4, #1
	strb r4, [r1, #2]
	movs r0, #1
	bl DelayFrames
	str r5, [sp]
	str r4, [sp, #4]
	mov r0, sl
	str r0, [sp, #8]
	movs r0, #2
	movs r1, #0
	movs r2, #0
	movs r3, #9
	bl CopyRectWithinBgTilemapBuffer
	str r5, [sp]
	str r5, [sp, #4]
	mov r1, sl
	str r1, [sp, #8]
	movs r0, #2
	movs r1, #0x14
	movs r2, #0x14
	movs r3, #3
	bl CopyRectWithinBgTilemapBuffer
	mov r0, r8
	strb r4, [r0, #2]
	movs r0, #1
	bl DelayFrames
	str r5, [sp]
	str r4, [sp, #4]
	mov r1, sl
	str r1, [sp, #8]
	movs r0, #2
	movs r1, #0
	movs r2, #0
	movs r3, #9
	bl CopyRectWithinBgTilemapBuffer
	mov r0, r8
	strb r4, [r0, #2]
	ldr r0, [sp, #0xc]
	movs r1, #1
	bl sub_02003D80
	mov r0, sb
	ldr r1, =gUnknown_020219DF
	strb r0, [r1]
_02003D66:
	add sp, #0x10
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02003D80
sub_02003D80: @ 0x02003D80
	push {r4, r5, r6, r7, lr}
	mov r7, r8
	push {r7}
	sub sp, #0x2c
	adds r5, r0, #0
	ldr r3, =gPlayerPartyPtr
	movs r0, #0x64
	adds r2, r5, #0
	muls r2, r0, r2
	ldr r0, [r3]
	adds r6, r0, r2
	cmp r1, #0
	bne _02003DEE
	ldr r4, =gUnknown_02021990
	adds r0, r4, #0
	adds r1, r5, #0
	movs r2, #8
	movs r3, #0x20
	bl CreatePartyMonFrontPic
	ldr r0, [r4, #0x1c]
	cmp r0, #0
	bne _02003DC0
	ldr r1, =gUnknown_0201FB10
	movs r0, #2
	bl AddWindow
	str r0, [r4, #0x1c]
	movs r1, #1
	movs r2, #8
	bl SetTextColor
_02003DC0:
	ldr r0, [r4, #0x20]
	movs r1, #0
	bl ClearWindowCharBuffer
	ldr r0, [r4, #0x20]
	movs r1, #1
	movs r2, #8
	bl SetTextColor
	adds r0, r6, #0
	movs r1, #2
	add r2, sp, #0xc
	bl GetMonData
	ldr r0, [r4, #0x20]
	movs r1, #0
	movs r2, #0
	bl TextWindowSetXY
	ldr r0, [r4, #0x20]
	add r1, sp, #0xc
	bl RenderText
_02003DEE:
	add r1, sp, #0xc
	movs r0, #0x34
	strb r0, [r1]
	movs r0, #0xff
	strb r0, [r1, #1]
	ldr r4, =gUnknown_02021990
	ldr r0, [r4, #0x20]
	movs r1, #0x10
	movs r2, #0x20
	bl TextWindowSetXY
	ldr r0, [r4, #0x20]
	add r1, sp, #0xc
	bl RenderText
	adds r0, r6, #0
	movs r1, #0x38
	movs r2, #0
	bl GetMonData
	add r1, sp, #0xc
	movs r2, #0xa1
	bl NumToPmString3CustomZeroChar
	movs r5, #0
	add r0, sp, #0xc
	add r7, sp, #0x1c
	movs r1, #0x1d
	add r1, sp
	mov r8, r1
	b _02003E40
	.align 2, 0
	.pool
_02003E38:
	adds r5, #1
	mov r0, sp
	adds r0, r0, r5
	adds r0, #0xc
_02003E40:
	ldrb r0, [r0]
	cmp r0, #0xa1
	beq _02003E38
	mov r0, sp
	adds r0, r0, r5
	adds r0, #0xc
	ldrb r0, [r0]
	cmp r0, #0xff
	bne _02003E54
	subs r5, #1
_02003E54:
	ldr r4, =gUnknown_02021990
	ldr r0, [r4, #0x20]
	movs r1, #0x19
	movs r2, #0x20
	bl TextWindowSetXY
	ldr r1, [r4, #0x20]
	movs r0, #6
	strb r0, [r1, #0x1c]
	ldr r0, [r4, #0x20]
	mov r1, sp
	adds r1, r1, r5
	adds r1, #0xc
	bl RenderText
	movs r0, #2
	str r0, [sp]
	movs r0, #0xd
	str r0, [sp, #4]
	movs r0, #0
	movs r1, #1
	movs r2, #0xe
	movs r3, #9
	bl SetBgTilemapBufferPaletteRect
	adds r0, r6, #0
	movs r1, #0xb
	movs r2, #0
	bl GetMonData
	adds r5, r0, #0
	mov r0, r8
	adds r1, r5, #0
	bl GetSpeciesName
	movs r0, #0xba
	strb r0, [r7]
	ldr r0, [r4, #0x20]
	movs r1, #0
	movs r2, #0x10
	bl TextWindowSetXY
	ldr r0, [r4, #0x20]
	adds r1, r7, #0
	bl RenderText
	cmp r5, #0x20
	beq _02003F0C
	cmp r5, #0x1d
	beq _02003F0C
	adds r0, r6, #0
	bl GetMonGender
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	cmp r0, #0
	beq _02003ED8
	cmp r0, #0xfe
	bne _02003F0C
	add r1, sp, #0xc
	movs r0, #0xb6
	strb r0, [r1]
	movs r5, #0xc
	b _02003EE0
	.align 2, 0
	.pool
_02003ED8:
	add r1, sp, #0xc
	movs r0, #0xb5
	strb r0, [r1]
	movs r5, #0xb
_02003EE0:
	add r1, sp, #0xc
	movs r0, #0xff
	strb r0, [r1, #1]
	ldr r4, =gUnknown_02021990
	ldr r0, [r4, #0x20]
	movs r1, #0x30
	movs r2, #0x20
	bl TextWindowSetXY
	movs r0, #2
	str r0, [sp]
	str r5, [sp, #4]
	movs r0, #0
	movs r1, #7
	movs r2, #0x10
	movs r3, #1
	bl SetBgTilemapBufferPaletteRect
	ldr r0, [r4, #0x20]
	add r1, sp, #0xc
	bl RenderText
_02003F0C:
	ldr r5, =gUnknown_02021990
	ldr r0, [r5, #0xc]
	cmp r0, #0
	bne _02003F20
	ldr r2, =gUnknown_0201FA5C
	movs r0, #0
	movs r1, #0x80
	bl AddSprite
	str r0, [r5, #0xc]
_02003F20:
	ldr r0, [r5, #0xc]
	movs r1, #3
	bl SetSpritePaletteNum
	adds r0, r6, #0
	bl BoxMonCaughtBallToItemId
	ldr r1, =0x06012800
	bl LZ77UnCompVram
	adds r0, r6, #0
	bl BoxMonGetCaughtBallItemPalette
	ldr r1, =0x05000260
	bl LZ77UnCompVram
	adds r0, r6, #0
	bl GetMonStatus
	adds r4, r0, #0
	cmp r4, #0
	beq _02003FB0
	movs r0, #2
	str r0, [sp]
	movs r0, #0
	str r0, [sp, #4]
	movs r0, #0x12
	str r0, [sp, #8]
	movs r0, #3
	movs r1, #8
	movs r2, #0x14
	movs r3, #0xa
	bl CopyRectWithinBgTilemapBuffer
	ldr r0, [r5, #0x20]
	ldr r3, =gText_Status
	movs r1, #0
	movs r2, #0x30
	bl RenderTextAt
	ldr r0, [r5, #0x10]
	cmp r0, #0
	bne _02003F82
	ldr r2, =gUnknown_0201FAF8
	movs r0, #0x2f
	movs r1, #0x94
	bl AddSprite
	str r0, [r5, #0x10]
_02003F82:
	ldr r0, [r5, #0x10]
	movs r1, #0
	bl SetSpriteInvisible
	ldr r0, [r5, #0x10]
	subs r1, r4, #1
	lsls r1, r1, #2
	bl SetSpriteTileOffset
	b _02003FCE
	.align 2, 0
	.pool
_02003FB0:
	movs r0, #2
	str r0, [sp]
	str r4, [sp, #4]
	movs r0, #3
	movs r1, #0
	movs r2, #0x12
	movs r3, #0xa
	bl FillBgTilemapBufferRect
	ldr r0, [r5, #0x10]
	cmp r0, #0
	beq _02003FCE
	movs r1, #1
	bl SetSpriteInvisible
_02003FCE:
	adds r0, r6, #0
	movs r1, #0
	bl CheckPartyHasHadPokerus
	adds r4, r0, #0
	adds r0, r6, #0
	movs r1, #0
	bl CheckPartyPokerus
	cmp r0, #0
	bne _02003FFC
	cmp r4, #0
	beq _02003FFC
	ldr r3, =0x0000F013
	movs r0, #0
	movs r1, #2
	movs r2, #0x11
	bl SetBgTilemapBufferTileAt
	b _0200400A
	.align 2, 0
	.pool
_02003FFC:
	movs r3, #0xf0
	lsls r3, r3, #8
	movs r0, #0
	movs r1, #2
	movs r2, #0x11
	bl SetBgTilemapBufferTileAt
_0200400A:
	ldr r1, =gBgTilemapBufferTransferScheduled
	movs r0, #1
	strb r0, [r1]
	strb r0, [r1, #3]
	add sp, #0x2c
	pop {r3}
	mov r8, r3
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02004024
sub_02004024: @ 0x02004024
	push {r4, r5, lr}
	adds r5, r0, #0
	ldr r1, =gUnknown_02021990
	movs r0, #0
	strb r0, [r1, #0x18]
	adds r0, r5, #0
	bl sub_020031F8
_02004034:
	movs r0, #1
	bl DelayFrames
	ldr r0, =gNewKeys
	ldrh r4, [r0]
	movs r0, #0x40
	ands r0, r4
	cmp r0, #0
	beq _02004060
	cmp r5, #0
	beq _02004060
	movs r0, #SE_SELECT
	bl PlaySE
	subs r5, #1
	adds r0, r5, #0
	movs r1, #0
	bl sub_02003D80
	adds r0, r5, #0
	bl sub_020031F8
_02004060:
	movs r0, #0x80
	ands r0, r4
	cmp r0, #0
	beq _0200409C
	cmp r5, #5
	beq _0200409C
	ldr r2, =gPlayerPartyPtr
	movs r0, #0x64
	adds r1, r5, #0
	muls r1, r0, r1
	adds r1, #0x64
	ldr r0, [r2]
	adds r0, r0, r1
	movs r1, #0xb
	movs r2, #0
	bl GetMonData
	cmp r0, #0
	beq _0200409C
	movs r0, #SE_SELECT
	bl PlaySE
	adds r5, #1
	adds r0, r5, #0
	movs r1, #0
	bl sub_02003D80
	adds r0, r5, #0
	bl sub_020031F8
_0200409C:
	movs r0, #0x10
	ands r0, r4
	cmp r0, #0
	beq _020040B8
	movs r0, #SE_SELECT
	bl PlaySE
	b _020040D0
	.align 2, 0
	.pool
_020040B8:
	movs r0, #3
	ands r4, r0
	cmp r4, #0
	beq _02004034
	movs r0, #SE_SELECT
	bl PlaySE
	ldr r0, =gUnknown_02021990
	adds r0, #0x50
	strb r5, [r0]
	movs r5, #1
	rsbs r5, r5, #0
_020040D0:
	movs r0, #1
	rsbs r0, r0, #0
	cmp r5, r0
	beq _020040E6
	ldr r4, =gUnknown_02021990
	ldr r0, [r4, #4]
	bl MoveSpriteToHead
	ldr r0, [r4, #8]
	bl MoveSpriteToHead
_020040E6:
	ldr r1, =gUnknown_02021990
	movs r0, #0
	str r0, [r1, #4]
	str r0, [r1, #8]
	adds r0, r5, #0
	pop {r4, r5}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_020040FC
sub_020040FC: @ 0x020040FC
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #0x14
	mov r8, r0
	ldr r4, =gUnknown_02021990
	movs r0, #0
	strb r0, [r4, #0x18]
	movs r0, #2
	movs r1, #0
	movs r2, #0
	bl SetBgPos
	mov r0, r8
	bl sub_0200378C
	movs r0, #0
	str r0, [sp, #0xc]
	mov sb, r4
_02004126:
	movs r0, #1
	bl DelayFrames
	ldr r0, =gNewKeys
	ldrh r5, [r0]
	movs r0, #0x40
	ands r0, r5
	cmp r0, #0
	beq _02004158
	mov r1, r8
	cmp r1, #0
	beq _02004158
	movs r0, #SE_SELECT
	bl PlaySE
	movs r0, #1
	rsbs r0, r0, #0
	add r8, r0
	mov r0, r8
	movs r1, #0
	bl sub_02003D80
	mov r0, r8
	bl sub_0200378C
_02004158:
	movs r0, #0x80
	ands r0, r5
	cmp r0, #0
	beq _02004198
	mov r1, r8
	cmp r1, #5
	beq _02004198
	ldr r2, =gPlayerPartyPtr
	movs r0, #0x64
	mov r1, r8
	muls r1, r0, r1
	adds r1, #0x64
	ldr r0, [r2]
	adds r0, r0, r1
	movs r1, #0xb
	movs r2, #0
	bl GetMonData
	cmp r0, #0
	beq _02004198
	movs r0, #SE_SELECT
	bl PlaySE
	movs r0, #1
	add r8, r0
	mov r0, r8
	movs r1, #0
	bl sub_02003D80
	mov r0, r8
	bl sub_0200378C
_02004198:
	movs r0, #0x20
	ands r0, r5
	cmp r0, #0
	beq _020041B4
	movs r0, #SE_SELECT
	bl PlaySE
	b _020044AC
	.align 2, 0
	.pool
_020041B4:
	movs r4, #2
	adds r0, r5, #0
	ands r0, r4
	lsls r0, r0, #0x10
	lsrs r6, r0, #0x10
	cmp r6, #0
	beq _020041DC
	movs r0, #SE_SELECT
	bl PlaySE
	mov r0, r8
	ldr r1, =gUnknown_020219E0
	strb r0, [r1]
	movs r1, #1
	rsbs r1, r1, #0
	mov r8, r1
	b _020044AC
	.align 2, 0
	.pool
_020041DC:
	ldr r0, [sp, #0xc]
	cmp r0, #1
	beq _0200420E
	cmp r0, #1
	bgt _020041EC
	cmp r0, #0
	beq _020041FA
	b _02004126
_020041EC:
	ldr r1, [sp, #0xc]
	cmp r1, #2
	beq _020042D6
	cmp r1, #3
	bne _020041F8
	b _0200441C
_020041F8:
	b _02004126
_020041FA:
	movs r0, #1
	ands r5, r0
	cmp r5, #0
	beq _02004126
	movs r0, #SE_SELECT
	bl PlaySE
	movs r0, #1
	str r0, [sp, #0xc]
	b _02004126
_0200420E:
	mov r0, sb
	adds r0, #0x4e
	strb r6, [r0]
	movs r0, #0x50
	movs r1, #0x20
	ldr r2, =gUnknown_0201FA74
	bl AddSprite
	mov r1, sb
	str r0, [r1, #0x40]
	movs r1, #5
	bl SetSpritePaletteNum
	mov r0, sb
	ldr r1, [r0, #0x40]
	ldr r0, =sub_0200461C
	str r0, [r1, #0x10]
	movs r0, #3
	str r0, [sp]
	movs r0, #0xa
	str r0, [sp, #4]
	movs r0, #0xb
	str r0, [sp, #8]
	movs r0, #2
	movs r1, #0
	movs r2, #0x14
	movs r3, #0x14
	bl CopyRectWithinBgTilemapBuffer
	mov r1, sb
	ldr r0, [r1, #0x24]
	movs r1, #0x20
	movs r2, #0x48
	bl TextWindowSetXY
	mov r1, sb
	ldr r0, [r1, #0x24]
	ldr r4, =gText_Cancel3
	adds r1, r4, #0
	bl RenderText
	mov r1, sb
	ldr r0, [r1, #0x28]
	movs r1, #0
	bl ClearWindowCharBuffer
	mov r1, sb
	ldr r0, [r1, #0x28]
	adds r1, r4, #0
	bl RenderText
	mov r0, sp
	ldrb r1, [r0, #0xc]
	ldr r0, =gBgTilemapBufferTransferScheduled
	strb r1, [r0]
	mov r0, r8
	movs r1, #0
	bl sub_02003BA4
	mov r0, r8
	bl sub_0200CB34
	adds r4, r0, #0
	movs r0, #4
	str r0, [sp]
	movs r0, #0xf
	str r0, [sp, #4]
	movs r0, #0
	movs r1, #0xb
	movs r2, #0xf
	movs r3, #0x12
	bl SetBgTilemapBufferPaletteRect
	mov r1, sb
	ldr r0, [r1, #0x24]
	movs r1, #4
	str r1, [sp]
	str r6, [sp, #4]
	movs r1, #0
	movs r2, #0xc
	movs r3, #0x12
	bl FillWindowCharBufferRect
	mov r1, sb
	ldr r0, [r1, #0x24]
	movs r1, #0
	movs r2, #0x60
	bl TextWindowSetXY
	mov r1, sb
	ldr r0, [r1, #0x24]
	adds r1, r4, #0
	bl RenderText
	mov r0, sp
	ldrb r1, [r0, #0xc]
	ldr r0, =gBgTilemapBufferTransferScheduled
	strb r1, [r0]
	movs r0, #2
	str r0, [sp, #0xc]
_020042D6:
	movs r0, #1
	bl DelayFrames
	ldr r0, =gNewKeys
	ldrh r5, [r0]
	ldr r1, =gUnknown_020219DE
	ldrb r1, [r1]
	str r1, [sp, #0x10]
	movs r0, #0x80
	ands r0, r5
	cmp r0, #0
	beq _0200431E
	movs r0, #SE_SELECT
	bl PlaySE
	movs r2, #1
	rsbs r2, r2, #0
	ldr r0, =gUnknown_020219DE
	ldrb r1, [r0]
	adds r1, #1
	ldr r4, =gUnknown_020219D4
	adds r3, r2, #0
_02004302:
	cmp r1, #5
	bne _02004308
	movs r1, #0
_02004308:
	lsls r0, r1, #1
	adds r0, r0, r4
	ldrh r0, [r0]
	cmp r0, #0
	beq _02004314
	adds r2, r1, #0
_02004314:
	adds r1, #1
	cmp r2, r3
	beq _02004302
	ldr r1, =gUnknown_020219DE
	strb r2, [r1]
_0200431E:
	movs r0, #0x40
	ands r0, r5
	cmp r0, #0
	beq _02004356
	movs r0, #SE_SELECT
	bl PlaySE
	movs r2, #1
	rsbs r2, r2, #0
	ldr r0, =gUnknown_020219DE
	ldrb r1, [r0]
	subs r1, #1
	adds r3, r2, #0
	ldr r4, =gUnknown_020219D4
_0200433A:
	cmp r1, r3
	bne _02004340
	movs r1, #4
_02004340:
	lsls r0, r1, #1
	adds r0, r0, r4
	ldrh r0, [r0]
	cmp r0, #0
	beq _0200434C
	adds r2, r1, #0
_0200434C:
	subs r1, #1
	cmp r2, r3
	beq _0200433A
	ldr r1, =gUnknown_020219DE
	strb r2, [r1]
_02004356:
	ldr r6, =gUnknown_02021990
	adds r7, r6, #0
	adds r7, #0x4e
	ldrb r1, [r7]
	ldr r0, [sp, #0x10]
	cmp r0, r1
	beq _020043DE
	mov r0, r8
	bl sub_02003A70
	ldrb r4, [r7]
	mov r0, r8
	bl sub_0200CB34
	mov sl, r0
	movs r1, #4
	str r1, [sp]
	movs r0, #0xf
	str r0, [sp, #4]
	movs r0, #0
	movs r1, #0xb
	movs r2, #0xf
	movs r3, #0x12
	bl SetBgTilemapBufferPaletteRect
	ldr r0, [r6, #0x24]
	movs r1, #4
	str r1, [sp]
	movs r1, #0
	str r1, [sp, #4]
	movs r2, #0xc
	movs r3, #0x12
	bl FillWindowCharBufferRect
	cmp r4, #4
	beq _020043BC
	ldr r0, [r6, #0x24]
	movs r1, #0
	movs r2, #0x60
	bl TextWindowSetXY
	ldr r0, [r6, #0x24]
	lsls r1, r4, #2
	adds r1, r1, r4
	lsls r1, r1, #4
	add r1, sl
	bl RenderText
	movs r0, #1
	ldr r1, =gBgTilemapBufferTransferScheduled
	strb r0, [r1]
_020043BC:
	ldr r0, [r6, #0x40]
	ldrb r1, [r7]
	lsls r2, r1, #4
	adds r2, #0x20
	movs r1, #0x50
	bl SetSpritePos
	ldr r0, [sp, #0x10]
	cmp r0, #4
	beq _020043D6
	ldrb r1, [r7]
	cmp r1, #4
	bne _020043DE
_020043D6:
	ldrb r1, [r7]
	mov r0, r8
	bl sub_02003BA4
_020043DE:
	movs r0, #3
	ands r5, r0
	cmp r5, #0
	beq _020043F0
	movs r0, #SE_SELECT
	bl PlaySE
	movs r0, #3
	str r0, [sp, #0xc]
_020043F0:
	ldr r1, [sp, #0xc]
	cmp r1, #2
	bne _020043F8
	b _020042D6
_020043F8:
	b _02004126
	.align 2, 0
	.pool
_0200441C:
	mov r1, sb
	ldr r0, [r1, #0x40]
	bl MoveSpriteToHead
	ldr r0, [sp, #0xc]
	str r0, [sp]
	movs r0, #0xa
	str r0, [sp, #4]
	movs r0, #0xb
	str r0, [sp, #8]
	movs r0, #2
	movs r1, #0
	movs r2, #0x17
	movs r3, #0x14
	bl CopyRectWithinBgTilemapBuffer
	mov r1, sb
	ldr r0, [r1, #0x24]
	str r4, [sp]
	str r6, [sp, #4]
	movs r1, #4
	movs r2, #9
	movs r3, #5
	bl FillWindowCharBufferRect
	mov r1, sb
	ldr r0, [r1, #0x24]
	movs r1, #0x20
	movs r2, #0x48
	bl TextWindowSetXY
	mov r1, sb
	ldr r0, [r1, #0x24]
	movs r1, #4
	str r1, [sp]
	str r6, [sp, #4]
	movs r1, #0
	movs r2, #0xc
	movs r3, #0x12
	bl FillWindowCharBufferRect
	mov r1, sb
	ldr r0, [r1, #0x28]
	movs r1, #0
	bl ClearWindowCharBuffer
	mov r1, sb
	ldr r0, [r1, #0x28]
	ldr r1, =gText_Info
	bl RenderText
	movs r0, #1
	ldr r1, =gBgTilemapBufferTransferScheduled
	strb r0, [r1]
	strb r0, [r1, #2]
	mov r0, sb
	adds r0, #0x4e
	ldrb r0, [r0]
	cmp r0, #4
	beq _0200449C
	mov r0, r8
	movs r1, #0
	bl sub_02003BA4
_0200449C:
	movs r0, #0
	str r0, [sp, #0xc]
	b _02004126
	.align 2, 0
	.pool
_020044AC:
	movs r0, #1
	rsbs r0, r0, #0
	cmp r8, r0
	beq _020044C8
	ldr r0, =gUnknown_02021990
	adds r5, r0, #0
	adds r5, #0x2c
	movs r4, #3
_020044BC:
	ldm r5!, {r0}
	bl MoveSpriteToHead
	subs r4, #1
	cmp r4, #0
	bge _020044BC
_020044C8:
	ldr r0, =gUnknown_02021990
	movs r1, #0
	movs r4, #3
	adds r0, #0x38
_020044D0:
	str r1, [r0]
	subs r0, #4
	subs r4, #1
	cmp r4, #0
	bge _020044D0
	mov r0, r8
	add sp, #0x14
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_020044F0
sub_020044F0: @ 0x020044F0
	push {r4, r5, r6, r7, lr}
	mov r7, r8
	push {r7}
	adds r6, r0, #0
	bl sub_02002FEC
	adds r0, r6, #0
	movs r1, #0
	bl sub_02003D80
	ldr r4, =gUnknown_02021990
	movs r0, #0
	strb r0, [r4, #0x18]
	adds r0, r6, #0
	bl sub_020031F8
	bl FadeIn
	mov r8, r4
	b _0200458E
	.align 2, 0
	.pool
_0200451C:
	mov r1, r8
	ldr r0, [r1, #0x24]
	movs r1, #0
	bl ClearWindowCharBuffer
	mov r1, r8
	ldr r0, [r1, #0x24]
	bl TextWindowFillTileBufferForText
	movs r4, #4
	adds r7, r5, #0
	movs r5, #0x80
	rsbs r5, r5, #0
_02004536:
	movs r0, #1
	bl DelayFrames
	movs r0, #2
	adds r1, r5, #0
	movs r2, #0
	bl SetBgPos
	adds r5, #0x20
	subs r4, #1
	cmp r4, r7
	bne _02004536
	adds r0, r6, #0
	bl sub_020040FC
	adds r6, r0, #0
	movs r0, #1
	rsbs r0, r0, #0
	cmp r6, r0
	beq _0200459E
	mov r1, r8
	ldr r0, [r1, #0x24]
	movs r1, #0
	bl ClearWindowCharBuffer
	mov r1, r8
	ldr r0, [r1, #0x24]
	bl TextWindowFillTileBufferForText
	movs r5, #0x20
	rsbs r5, r5, #0
	movs r4, #4
_02004576:
	movs r0, #1
	bl DelayFrames
	movs r0, #2
	adds r1, r5, #0
	movs r2, #0
	bl SetBgPos
	subs r5, #0x20
	subs r4, #1
	cmp r4, #0
	bge _02004576
_0200458E:
	adds r0, r6, #0
	bl sub_02004024
	adds r6, r0, #0
	movs r5, #1
	rsbs r5, r5, #0
	cmp r6, r5
	bne _0200451C
_0200459E:
	bl FadeOut
	ldr r0, =gUnknown_02021990
	adds r0, #0x50
	ldrb r0, [r0]
	pop {r3}
	mov r8, r3
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_020045B8
sub_020045B8: @ 0x020045B8
	push {r4, r5, r6, r7, lr}
	sub sp, #8
	adds r5, r1, #0
	bl sub_0200CB34
	adds r7, r0, #0
	movs r4, #4
	str r4, [sp]
	movs r0, #0xf
	str r0, [sp, #4]
	movs r0, #0
	movs r1, #0xb
	movs r2, #0xf
	movs r3, #0x12
	bl SetBgTilemapBufferPaletteRect
	ldr r6, =gUnknown_02021990
	ldr r0, [r6, #0x24]
	str r4, [sp]
	movs r1, #0
	str r1, [sp, #4]
	movs r2, #0xc
	movs r3, #0x12
	bl FillWindowCharBufferRect
	cmp r5, #4
	beq _0200460C
	ldr r0, [r6, #0x24]
	movs r1, #0
	movs r2, #0x60
	bl TextWindowSetXY
	ldr r0, [r6, #0x24]
	lsls r1, r5, #2
	adds r1, r1, r5
	lsls r1, r1, #4
	adds r1, r7, r1
	bl RenderText
	ldr r1, =gBgTilemapBufferTransferScheduled
	movs r0, #1
	strb r0, [r1]
_0200460C:
	add sp, #8
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_0200461C
sub_0200461C: @ 0x0200461C
	push {r4, lr}
	adds r4, r0, #0
	ldr r0, [r4, #0x14]
	cmp r0, #0x24
	beq _02004640
	cmp r0, #0x24
	bhi _02004630
	cmp r0, #1
	beq _02004636
	b _0200464E
_02004630:
	cmp r0, #0x27
	beq _0200464A
	b _0200464E
_02004636:
	adds r0, r4, #0
	movs r1, #0
	bl SetSpriteInvisible
	b _0200464E
_02004640:
	adds r0, r4, #0
	movs r1, #1
	bl SetSpriteInvisible
	b _0200464E
_0200464A:
	movs r0, #0
	str r0, [r4, #0x14]
_0200464E:
	ldr r0, [r4, #0x14]
	adds r0, #1
	str r0, [r4, #0x14]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start sub_0200465C
sub_0200465C: @ 0x0200465C
	push {r4, lr}
	sub sp, #4
	bl ClearVram
	movs r1, #0x80
	lsls r1, r1, #0x13
	movs r2, #0xaa
	lsls r2, r2, #5
	adds r0, r2, #0
	strh r0, [r1]
	ldr r2, =0x04000008
	ldr r3, =0x00001F01
	adds r0, r3, #0
	strh r0, [r2]
	adds r1, #0xc
	subs r3, #0xf9
	adds r0, r3, #0
	strh r0, [r1]
	ldrh r0, [r2]
	movs r1, #0x80
	orrs r0, r1
	strh r0, [r2]
	ldr r0, =gUnknown_0201B1A0
	movs r4, #0xa0
	lsls r4, r4, #0x13
	adds r1, r4, #0
	bl AutoUnCompVram
	ldr r0, =gUnknown_0201A894
	ldr r1, =0x050001C0
	bl AutoUnCompVram
	ldr r0, =gMessageBox_Gfx
	ldr r1, =0x06008000
	bl AutoUnCompVram
	ldr r0, =gTitle_Pal
	adds r1, r4, #0
	bl AutoUnCompVram
	ldr r0, =gTitle_Gfx
	movs r1, #0xc0
	lsls r1, r1, #0x13
	bl AutoUnCompVram
	ldr r0, =gTitle_Tilemap
	movs r1, #0xc0
	lsls r1, r1, #0x12
	bl AutoUnCompVram
	ldr r0, =0x0000E001
	str r0, [sp]
	movs r0, #0
	movs r1, #0x10
	movs r2, #0x1e
	movs r3, #4
	bl DrawTextWindowBorder
	ldr r1, =gUnknown_0201FB90
	movs r0, #0
	bl AddWindow
	ldr r1, =gMessageWindowPtr
	str r0, [r1]
	movs r1, #1
	movs r2, #8
	bl SetTextColor
	ldr r1, =gBgTilemapBufferTransferScheduled
	movs r0, #1
	strb r0, [r1]
	strb r0, [r1, #2]
	add sp, #4
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_0200472C
sub_0200472C: @ 0x0200472C
	push {r4, lr}
	ldr r0, =gUnknown_020217B4
	ldrb r0, [r0]
	cmp r0, #2
	beq _0200474A
	cmp r0, #2
	bgt _02004744
	cmp r0, #0
	beq _02004788
	b _020047AC
	.align 2, 0
	.pool
_02004744:
	cmp r0, #0xff
	beq _02004768
	b _020047AC
_0200474A:
	ldr r0, =gMessageWindowPtr
	ldr r4, [r0]
	adds r0, r4, #0
	ldr r1, =0x0000FFFF
	bl ClearWindowCharBuffer
	ldr r0, =gErrorMessagePtrs
	ldr r1, [r0, #0x18]
	b _02004798
	.align 2, 0
	.pool
_02004768:
	ldr r0, =gMessageWindowPtr
	ldr r4, [r0]
	adds r0, r4, #0
	ldr r1, =0x0000FFFF
	bl ClearWindowCharBuffer
	ldr r0, =gErrorMessagePtrs
	ldr r1, [r0, #0x1c]
	b _02004798
	.align 2, 0
	.pool
_02004788:
	ldr r0, =gMessageWindowPtr
	ldr r4, [r0]
	adds r0, r4, #0
	ldr r1, =0x0000FFFF
	bl ClearWindowCharBuffer
	ldr r0, =gErrorMessagePtrs
	ldr r1, [r0, #0x20]
_02004798:
	adds r0, r4, #0
	bl RenderText
	b _020047C2
	.align 2, 0
	.pool
_020047AC:
	ldr r0, =gMessageWindowPtr
	ldr r4, [r0]
	adds r0, r4, #0
	ldr r1, =0x0000FFFF
	bl ClearWindowCharBuffer
	ldr r0, =gErrorMessagePtrs
	ldr r1, [r0, #4]
	adds r0, r4, #0
	bl RenderText
_020047C2:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_020047D4
sub_020047D4: @ 0x020047D4
	push {r4, r5, r6, lr}
	sub sp, #0x30
	ldr r0, =gUnknown_02024960
	ldr r1, =0x0000087B
	adds r0, r0, r1
	ldrb r1, [r0]
	movs r4, #4
	strb r4, [r0]
	bl sub_0200465C
	ldr r0, =gAgbPmRomParams
	ldr r0, [r0]
	adds r0, #0xb8
	ldrb r0, [r0]
	lsls r0, r0, #0x1e
	cmp r0, #0
	blt _020047FE
	ldr r0, =gRomDetection_IsEnglishROM
	ldrb r0, [r0]
	cmp r0, #0
	bne _02004898
_020047FE:
	movs r0, #1
	bl OverrideScreenFadeState
	add r1, sp, #0x10
	ldr r0, =gFont0LatinInfo
	ldm r0!, {r2, r3, r5}
	stm r1!, {r2, r3, r5}
	ldm r0!, {r2, r3, r5}
	stm r1!, {r2, r3, r5}
	ldm r0!, {r2, r3}
	stm r1!, {r2, r3}
	str r4, [sp]
	movs r0, #0
	str r0, [sp, #4]
	movs r0, #2
	movs r1, #0
	movs r2, #0x10
	movs r3, #0x1e
	bl FillBgTilemapBufferRect
	ldr r0, =0x0000E001
	str r0, [sp]
	movs r0, #3
	movs r1, #0xe
	movs r2, #0x18
	movs r3, #6
	bl DrawTextWindowBorder
	movs r0, #0
	add r1, sp, #0x10
	bl AddWindow
	adds r4, r0, #0
	movs r1, #1
	movs r2, #8
	bl SetTextColor
	adds r0, r4, #0
	ldr r1, =0x0000FFFF
	bl ClearWindowCharBuffer
	ldr r1, =gBgTilemapBufferTransferScheduled
	movs r0, #1
	strb r0, [r1, #2]
	bl IsScreenFadedOut
	cmp r0, #1
	bne _02004862
	bl FadeIn
_02004862:
	ldr r0, =gErrorMessagePtrs
	ldr r1, [r0, #0x24]
	adds r0, r4, #0
	bl RenderText
_0200486C:
	movs r0, #0x64
	bl DelayFrames
	b _0200486C
	.align 2, 0
	.pool
_02004898:
	ldr r0, =gUnknown_020217B8
	ldrb r0, [r0]
	cmp r0, #1
	beq _020048AC
	bl sub_0200472C
	b _020048B6
	.align 2, 0
	.pool
_020048AC:
	ldr r0, =gMessageWindowPtr
	ldr r0, [r0]
	ldr r1, =0x0000FFFF
	bl ClearWindowCharBuffer
_020048B6:
	ldr r1, =gUnknown_02024960
	ldr r4, =0x00000859
	adds r0, r1, r4
	ldrb r2, [r0]
	movs r4, #0
	strb r4, [r0]
	ldr r5, =0x0000084C
	adds r3, r1, r5
	ldrb r2, [r3]
	movs r0, #3
	rsbs r0, r0, #0
	ands r0, r2
	strb r0, [r3]
	ldr r0, =0x0000087A
	adds r1, r1, r0
	ldrb r0, [r1]
	strb r4, [r1]
	ldrb r1, [r3]
	movs r0, #2
	rsbs r0, r0, #0
	ands r0, r1
	strb r0, [r3]
	bl FadeIn
	ldr r0, =gUnknown_020217B4
	ldrb r0, [r0]
	cmp r0, #2
	beq _020048F6
	cmp r0, #0xff
	beq _020048F6
	cmp r0, #0
	bne _0200491C
_020048F6:
	movs r0, #0xff
	bl DelayFrames
	b _020048F6
	.align 2, 0
	.pool
_0200491C:
	ldr r0, =gUnknown_020217B8
	ldrb r0, [r0]
	cmp r0, #1
	bne _02004932
	ldr r0, =gMessageWindowPtr
	ldr r0, [r0]
	ldr r1, =gText_BerryProgramUpdated
	bl RenderText
	bl sub_0200472C
_02004932:
	ldr r3, =gUnknown_02024960
	ldr r1, =0x0000087F
	adds r2, r3, r1
	ldrb r0, [r2]
	cmp r0, #0
	beq _02004950
	ldr r1, =0x04000154
	movs r4, #0x88
	lsls r4, r4, #4
	adds r0, r3, r4
	ldr r0, [r0]
	str r0, [r1]
	ldrb r0, [r2]
	movs r0, #0
	strb r0, [r2]
_02004950:
	movs r5, #0
	ldr r0, =0x00000859
	adds r6, r3, r0
_02004956:
	movs r0, #1
	bl DelayFrames
	ldrb r0, [r6]
	cmp r0, #0
	beq _0200496C
	bl sub_0200CB54
	cmp r0, #1
	bne _0200496C
	movs r5, #2
_0200496C:
	ldr r4, =gUnknown_02024960
	ldr r1, =0x0000084C
	adds r2, r4, r1
	ldrb r1, [r2]
	movs r0, #1
	ands r0, r1
	cmp r0, #0
	beq _0200498C
	ldrb r0, [r2]
	movs r3, #2
	rsbs r3, r3, #0
	adds r1, r3, #0
	ands r0, r1
	strb r0, [r2]
	bl sub_02006058
_0200498C:
	ldr r1, =0x0000087A
	adds r0, r4, r1
	ldrb r0, [r0]
	cmp r0, #1
	bne _02004998
	movs r5, #1
_02004998:
	ldr r2, =0x0000085A
	adds r1, r4, r2
	ldrb r0, [r1]
	cmp r0, #1
	bne _020049C2
	ldrb r0, [r1]
	movs r0, #0
	strb r0, [r1]
	bl sub_02006264
	ldr r0, =gMessageWindowPtr
	ldr r4, [r0]
	adds r0, r4, #0
	ldr r1, =0x0000FFFF
	bl ClearWindowCharBuffer
	ldr r0, =gErrorMessagePtrs
	ldr r1, [r0, #4]
	adds r0, r4, #0
	bl RenderText
_020049C2:
	cmp r5, #0
	beq _02004956
	bl FadeOut
	subs r0, r5, #1
	add sp, #0x30
	pop {r4, r5, r6}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start WarningPrint
WarningPrint: @ 0x02004A04
	push {r4, r5, lr}
	adds r4, r0, #0
	ldr r0, =gMessageWindowPtr
	ldr r5, [r0]
	ldr r1, =0x0000FFFF
	adds r0, r5, #0
	bl ClearWindowCharBuffer
	ldr r0, =gErrorMessagePtrs
	lsls r4, r4, #2
	adds r4, r4, r0
	ldr r1, [r4]
	adds r0, r5, #0
	bl RenderText
	pop {r4, r5}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start ErrorPrint
ErrorPrint: @ 0x02004A34
	push {r4, r5, lr}
	sub sp, #0x28
	adds r5, r0, #0
	add r1, sp, #8
	ldr r0, =gFont0LatinInfo
	ldm r0!, {r2, r3, r4}
	stm r1!, {r2, r3, r4}
	ldm r0!, {r2, r3, r4}
	stm r1!, {r2, r3, r4}
	ldm r0!, {r2, r3}
	stm r1!, {r2, r3}
	movs r0, #4
	str r0, [sp]
	movs r0, #0
	str r0, [sp, #4]
	movs r0, #2
	movs r1, #0
	movs r2, #0x10
	movs r3, #0x1e
	bl FillBgTilemapBufferRect
	ldr r0, =0x0000E001
	str r0, [sp]
	movs r0, #3
	movs r1, #0xe
	movs r2, #0x18
	movs r3, #6
	bl DrawTextWindowBorder
	movs r0, #0
	add r1, sp, #8
	bl AddWindow
	adds r4, r0, #0
	movs r1, #1
	movs r2, #8
	bl SetTextColor
	ldr r1, =0x0000FFFF
	adds r0, r4, #0
	bl ClearWindowCharBuffer
	ldr r1, =gBgTilemapBufferTransferScheduled
	movs r0, #1
	strb r0, [r1, #2]
	bl IsScreenFadedOut
	cmp r0, #1
	bne _02004A9A
	bl FadeIn
_02004A9A:
	ldr r0, =gErrorMessagePtrs
	lsls r1, r5, #2
	adds r1, r1, r0
	ldr r1, [r1]
	adds r0, r4, #0
	bl RenderText
_02004AA8:
	movs r0, #0x64
	bl DelayFrames
	b _02004AA8
	.align 2, 0
	.pool

	thumb_func_start sub_02004AC4
sub_02004AC4: @ 0x02004AC4
	push {r4, r5, lr}
	sub sp, #4
	bl ClearVram
	movs r1, #0x80
	lsls r1, r1, #0x13
	movs r2, #0xfa
	lsls r2, r2, #5
	adds r0, r2, #0
	strh r0, [r1]
	adds r1, #8
	movs r2, #0xd8
	lsls r2, r2, #5
	adds r0, r2, #0
	strh r0, [r1]
	adds r1, #2
	ldr r2, =0x00000F01
	adds r0, r2, #0
	strh r0, [r1]
	adds r1, #2
	ldr r2, =0x00005C0A
	adds r0, r2, #0
	strh r0, [r1]
	adds r1, #2
	ldr r2, =0x00001E0B
	adds r0, r2, #0
	strh r0, [r1]
	ldr r0, =gUnknown_0201B1A0
	movs r5, #0xa0
	lsls r5, r5, #0x13
	adds r1, r5, #0
	bl AutoUnCompVram
	ldr r0, =gMonInfoIcons_Gfx
	movs r1, #0xc0
	lsls r1, r1, #0x13
	bl AutoUnCompVram
	ldr r0, =gBattleScreen_Gfx
	ldr r1, =0x06008000
	bl AutoUnCompVram
	ldr r0, =gBattleScreen_Pal
	ldr r1, =0x05000140
	bl AutoUnCompVram
	ldr r0, =gBattleScreen_Tilemap
	ldr r1, =0x03003000
	bl AutoUnCompVram
	ldr r0, =gBattleWindows_Tilemap
	ldr r1, =0x03002800
	bl AutoUnCompVram
	ldr r1, =gBgTilemapBufferTransferScheduled
	movs r4, #0
	movs r0, #1
	strb r0, [r1, #2]
	strb r0, [r1, #3]
	ldr r0, =gTypeStatusIcons_Pal
	ldr r1, =0x05000200
	bl AutoUnCompVram
	ldr r0, =gTypeStatusIcons_Gfx
	ldr r1, =0x06010000
	bl AutoUnCompVram
	ldr r1, =0x00005108
	adds r0, r1, #0
	strh r0, [r5]
	mov r0, sp
	strh r4, [r0]
	ldr r4, =gUnknown_02021A20
	ldr r2, =0x0100000E
	adds r1, r4, #0
	bl CpuSet
	ldr r1, =gUnknown_0201FE3C
	movs r0, #0
	bl AddWindow
	str r0, [r4, #0x14]
	ldr r1, =gUnknown_0201FE5C
	movs r0, #1
	bl AddWindow
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x14]
	movs r1, #1
	movs r2, #8
	bl SetTextColor
	ldr r0, [r4, #0x18]
	movs r1, #1
	movs r2, #8
	bl SetTextColor
	add sp, #4
	pop {r4, r5}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02004BEC
sub_02004BEC: @ 0x02004BEC
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	adds r6, r0, #0
	adds r5, r2, #0
	mov sb, r3
	ldr r0, =gAgbPmRomParams
	mov sl, r0
	ldr r0, [r0]
	adds r0, #0xbc
	ldr r4, [r0]
	ldr r1, =gUnknown_02024960
	mov r8, r1
	ldrh r0, [r1, #0x10]
	strh r0, [r6, #0xc]
	lsls r0, r0, #0x10
	cmp r0, #0
	beq _02004CBC
	ldr r7, [r1, #8]
	ldrh r0, [r6, #0xc]
	adds r1, r7, #0
	bl FixUnownSpecies
	strh r0, [r6, #0xe]
	ldr r0, [r6]
	cmp r0, #0
	beq _02004C2A
	bl MoveSpriteToHead
_02004C2A:
	ldr r1, =gUnknown_0201FC44
	ldrh r2, [r6, #0xc]
	lsls r0, r2, #3
	subs r0, r0, r2
	lsls r0, r0, #2
	adds r0, r0, r4
	ldrb r0, [r0, #0x19]
	lsrs r0, r0, #7
	lsls r0, r0, #2
	adds r0, r0, r1
	ldr r2, [r0]
	adds r0, r5, #0
	mov r1, sb
	bl AddSprite
	str r0, [r6]
	movs r1, #4
	bl SetSpritePaletteNum
	mov r1, sl
	ldr r0, [r1]
	ldrh r2, [r6, #0xe]
	lsls r1, r2, #3
	ldr r4, [r0, #0x28]
	adds r4, r4, r1
	bl GetPicUncompPtr
	adds r5, r0, #0
	ldr r0, [r4]
	adds r1, r5, #0
	bl LZ77UnCompVram
	ldr r4, =0x00000181
	ldrh r0, [r6, #0xc]
	cmp r0, r4
	bne _02004C7A
	mov r1, r8
	ldrh r0, [r1, #0x12]
	lsls r0, r0, #0xb
	adds r5, r5, r0
_02004C7A:
	ldrh r0, [r6, #0xc]
	adds r1, r7, #0
	adds r2, r5, #0
	bl DrawSpindasSpots
	ldr r1, =0x06012000
	movs r2, #0x80
	lsls r2, r2, #3
	adds r0, r5, #0
	bl CpuSet
	ldrh r0, [r6, #0xc]
	mov r2, r8
	ldr r1, [r2, #0xc]
	adds r2, r7, #0
	bl GetMonPalettePtrBySpeciesIdPersonality
	ldr r0, [r0]
	adds r1, r5, #0
	bl LZ77UnCompWram
	ldrh r6, [r6, #0xc]
	cmp r6, r4
	bne _02004CB2
	mov r1, r8
	ldrh r0, [r1, #0x12]
	lsls r0, r0, #5
	adds r5, r5, r0
_02004CB2:
	ldr r1, =0x05000280
	adds r0, r5, #0
	movs r2, #0x10
	bl CpuSet
_02004CBC:
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02004CE4
sub_02004CE4: @ 0x02004CE4
	push {r4, r5, lr}
	sub sp, #0x18
	bl GetMonGender
	lsls r0, r0, #0x18
	lsrs r4, r0, #0x18
	cmp r4, #0
	beq _02004CF8
	cmp r4, #0xfe
	bne _02004D5A
_02004CF8:
	add r0, sp, #8
	movs r1, #0xff
	strb r1, [r0, #1]
	ldr r5, =gUnknown_02021A20
	ldr r0, [r5, #0x14]
	movs r1, #0x48
	movs r2, #0x10
	bl TextWindowSetXY
	cmp r4, #0
	bne _02004D24
	add r0, sp, #8
	movs r1, #0xb5
	strb r1, [r0]
	ldr r0, [r5, #0x14]
	movs r1, #4
	movs r2, #5
	bl SetTextColor
	b _02004D34
	.align 2, 0
	.pool
_02004D24:
	add r0, sp, #8
	movs r1, #0xb6
	strb r1, [r0]
	ldr r0, [r5, #0x14]
	movs r1, #7
	movs r2, #8
	bl SetTextColor
_02004D34:
	ldr r4, =gUnknown_02021A20
	ldr r0, [r4, #0x14]
	add r1, sp, #8
	bl RenderText
	movs r0, #2
	str r0, [sp]
	movs r0, #0
	str r0, [sp, #4]
	movs r1, #0x14
	movs r2, #8
	movs r3, #1
	bl SetBgTilemapBufferPaletteRect
	ldr r0, [r4, #0x14]
	movs r1, #1
	movs r2, #8
	bl SetTextColor
_02004D5A:
	add sp, #0x18
	pop {r4, r5}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02004D68
sub_02004D68: @ 0x02004D68
	push {r4, r5, r6, r7, lr}
	mov r7, r8
	push {r7}
	sub sp, #0x20
	adds r6, r0, #0
	ldr r2, =gPlayerPartyPtr
	movs r0, #0x64
	adds r1, r6, #0
	muls r1, r0, r1
	ldr r0, [r2]
	adds r7, r0, r1
	ldr r4, =gUnknown_02021A20
	adds r0, r4, #0
	adds r1, r6, #0
	movs r2, #8
	movs r3, #0x20
	bl sub_02004BEC
	mov r1, sp
	movs r0, #0x34
	strb r0, [r1]
	movs r0, #0xff
	strb r0, [r1, #1]
	ldr r0, [r4, #0x14]
	movs r1, #8
	movs r2, #0
	bl TextWindowSetXY
	ldr r0, [r4, #0x14]
	mov r1, sp
	bl RenderText
	adds r0, r7, #0
	movs r1, #0x38
	movs r2, #0
	bl GetMonData
	mov r1, sp
	movs r2, #0xa1
	bl NumToPmString3CustomZeroChar
	movs r5, #0
	mov r0, sp
	add r1, sp, #4
	mov r8, r1
	b _02004DD2
	.align 2, 0
	.pool
_02004DCC:
	adds r5, #1
	mov r2, sp
	adds r0, r2, r5
_02004DD2:
	ldrb r0, [r0]
	cmp r0, #0xa1
	beq _02004DCC
	mov r1, sp
	adds r0, r1, r5
	ldrb r0, [r0]
	cmp r0, #0xff
	bne _02004DE4
	subs r5, #1
_02004DE4:
	ldr r4, =gUnknown_02021A20
	ldr r0, [r4, #0x14]
	movs r1, #0x11
	movs r2, #0
	bl TextWindowSetXY
	ldr r0, [r4, #0x14]
	mov r2, sp
	adds r1, r2, r5
	bl RenderText
	adds r0, r7, #0
	movs r1, #2
	mov r2, sp
	bl GetMonData
	movs r0, #4
	mov r1, sp
	bl BufferString
	ldr r0, [r4, #0x14]
	movs r1, #0x2c
	movs r2, #0
	bl TextWindowSetXY
	ldr r0, [r4, #0x14]
	mov r1, sp
	bl RenderText
	adds r0, r7, #0
	movs r1, #0xb
	movs r2, #0
	bl GetMonData
	adds r4, r0, #0
	cmp r4, #0x20
	beq _02004E38
	cmp r4, #0x1d
	beq _02004E38
	adds r0, r7, #0
	bl sub_02004CE4
_02004E38:
	mov r0, sp
	adds r1, r4, #0
	bl GetSpeciesName
	ldr r5, =gUnknown_02021A20
	ldr r0, [r5, #0x14]
	movs r1, #8
	movs r2, #0x10
	bl TextWindowSetXY
	ldr r0, [r5, #0x14]
	mov r1, sp
	bl RenderText
	adds r0, r7, #0
	bl GetMonStatus
	adds r4, r0, #0
	cmp r4, #0
	beq _02004E84
	ldr r0, [r5, #4]
	cmp r0, #0
	bne _02004E72
	ldr r2, =gUnknown_0201FC4C
	movs r0, #0xa6
	movs r1, #0x44
	bl AddSprite
	str r0, [r5, #4]
_02004E72:
	ldr r0, [r5, #4]
	movs r1, #0
	bl SetSpriteInvisible
	ldr r0, [r5, #4]
	subs r1, r4, #1
	lsls r1, r1, #2
	bl SetSpriteTileOffset
_02004E84:
	movs r0, #1
	movs r1, #0xc
	movs r2, #0xa
	adds r3, r6, #0
	bl DrawPartyMonHealthBar
	movs r2, #4
	rsbs r2, r2, #0
	movs r0, #1
	movs r1, #0
	bl SetBgPos
	ldr r6, =gBgTilemapBufferTransferScheduled
	movs r5, #1
	strb r5, [r6, #1]
	adds r0, r7, #0
	movs r1, #0x39
	movs r2, #0
	bl GetMonData
	adds r4, r0, #0
	mov r0, sp
	adds r1, r4, #0
	bl NumToPmString3RightAlign
	mov r1, sp
	movs r0, #0xba
	strb r0, [r1, #3]
	adds r0, r7, #0
	movs r1, #0x3a
	movs r2, #0
	bl GetMonData
	adds r4, r0, #0
	mov r0, r8
	adds r1, r4, #0
	bl NumToPmString3RightAlign
	ldr r4, =gUnknown_02021A20
	ldr r0, [r4, #0x14]
	movs r1, #0x50
	movs r2, #0x20
	bl TextWindowSetXY
	ldr r1, [r4, #0x14]
	movs r0, #6
	strb r0, [r1, #0x1c]
	ldr r0, [r4, #0x14]
	mov r1, sp
	bl RenderText
	strb r5, [r6]
	add sp, #0x20
	pop {r3}
	mov r8, r3
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02004F04
sub_02004F04: @ 0x02004F04
	push {r4, r5, r6, r7, lr}
	adds r6, r0, #0
	adds r7, r1, #0
	adds r4, r7, #0
	cmp r2, #0
	ble _02004F32
	adds r5, r2, #0
_02004F12:
	ldrb r0, [r6, #1]
	lsls r1, r0, #3
	ldrb r0, [r4]
	subs r1, r0, r1
	ldrb r0, [r6, #2]
	lsls r2, r0, #3
	ldrb r0, [r4, #1]
	subs r2, r0, r2
	ldr r3, [r4, #4]
	adds r0, r6, #0
	bl RenderTextAt
	subs r5, #1
	adds r4, #0xc
	cmp r5, #0
	bne _02004F12
_02004F32:
	ldr r4, =gUnknown_02021A20
	ldr r0, [r4, #8]
	cmp r0, #0
	beq _02004F42
	bl MoveSpriteToHead
	movs r0, #0
	str r0, [r4, #8]
_02004F42:
	ldr r0, =gText_BattleOptions
	cmp r7, r0
	bne _02004F58
	ldr r2, =gUnknown_0201FC64
	b _02004F88
	.align 2, 0
	.pool
_02004F58:
	ldr r0, =gUnknown_0201FDC4
	cmp r7, r0
	bne _02004F6C
	ldr r2, =gUnknown_0201FCA0
	b _02004F88
	.align 2, 0
	.pool
_02004F6C:
	ldr r0, =gUnknown_0201FDF4
	cmp r7, r0
	bne _02004F80
	ldr r2, =gUnknown_0201FCF4
	b _02004F88
	.align 2, 0
	.pool
_02004F80:
	ldr r0, =gUnknown_0201FE24
	cmp r7, r0
	bne _02004F92
	ldr r2, =gUnknown_0201FD60
_02004F88:
	movs r0, #0
	movs r1, #0
	bl AddSprite
	str r0, [r4, #8]
_02004F92:
	ldr r4, =gUnknown_02021A20
	ldr r0, [r4, #8]
	movs r1, #5
	bl SetSpritePaletteNum
	ldr r0, [r4, #8]
	ldrb r1, [r7]
	ldrb r2, [r7, #1]
	bl SetSpritePos
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02004FB8
sub_02004FB8: @ 0x02004FB8
	push {r4, r5, r6, r7, lr}
	mov r7, r8
	push {r7}
	adds r5, r0, #0
	mov r8, r1
	movs r6, #0
	ldr r0, [r5, #4]
	ldrb r0, [r0]
	ldr r2, =gUnknown_0201FDF4
	cmp r0, #0xff
	bne _02004FDC
	adds r1, r5, #0
_02004FD0:
	adds r1, #0xc
	adds r6, #1
	ldr r0, [r1, #4]
	ldrb r0, [r0]
	cmp r0, #0xff
	beq _02004FD0
_02004FDC:
	cmp r5, r2
	bne _02004FEE
	cmp r6, #1
	bne _02004FEE
	ldr r0, [r5, #0x1c]
	ldrb r0, [r0]
	cmp r0, #0xff
	beq _02004FEE
	movs r6, #2
_02004FEE:
	cmp r6, r8
	blt _02004FF4
	b _0200515A
_02004FF4:
	ldr r0, =gUnknown_02021A20
	ldr r0, [r0, #8]
	lsls r4, r6, #1
	adds r4, r4, r6
	lsls r4, r4, #2
	adds r4, r4, r5
	ldrb r1, [r4]
	ldrb r2, [r4, #1]
	bl SetSpritePos
_02005008:
	movs r0, #1
	bl DelayFrames
	ldr r0, =gNewKeys
	ldrh r7, [r0]
	adds r3, r6, #0
	movs r0, #0x10
	ands r0, r7
	cmp r0, #0
	beq _0200507C
	cmp r6, #0
	bne _02005052
	ldr r0, [r5, #0x10]
	ldrb r0, [r0]
	cmp r0, #0xff
	beq _02005040
	cmp r0, #0xae
	beq _02005040
	adds r4, r5, #0
	adds r4, #0xc
	movs r6, #1
	b _02005052
	.align 2, 0
	.pool
_02005040:
	ldr r0, [r5, #0x28]
	ldrb r0, [r0]
	cmp r0, #0xff
	beq _02005052
	cmp r0, #0xae
	beq _02005052
	adds r4, r5, #0
	adds r4, #0x24
	movs r6, #3
_02005052:
	cmp r6, #2
	bne _0200507C
	ldr r0, [r5, #0x28]
	ldrb r0, [r0]
	cmp r0, #0xff
	beq _0200506A
	cmp r0, #0xae
	beq _0200506A
	adds r4, r5, #0
	adds r4, #0x24
	movs r6, #3
	b _0200507C
_0200506A:
	ldr r0, [r5, #0x10]
	ldrb r0, [r0]
	cmp r0, #0xff
	beq _0200507C
	cmp r0, #0xae
	beq _0200507C
	adds r4, r5, #0
	adds r4, #0xc
	movs r6, #1
_0200507C:
	movs r0, #0x20
	ands r0, r7
	cmp r0, #0
	beq _020050D4
	cmp r6, #1
	bne _020050AC
	ldr r0, [r5, #4]
	ldrb r0, [r0]
	cmp r0, #0xff
	beq _0200509A
	cmp r0, #0xae
	beq _0200509A
	adds r4, r5, #0
	movs r6, #0
	b _020050AC
_0200509A:
	ldr r0, [r5, #0x1c]
	ldrb r0, [r0]
	cmp r0, #0xff
	beq _020050AC
	cmp r0, #0xae
	beq _020050AC
	adds r4, r5, #0
	adds r4, #0x18
	movs r6, #2
_020050AC:
	cmp r6, #3
	bne _020050D4
	ldr r0, [r5, #0x1c]
	ldrb r0, [r0]
	cmp r0, #0xff
	beq _020050C4
	cmp r0, #0xae
	beq _020050C4
	adds r4, r5, #0
	adds r4, #0x18
	movs r6, #2
	b _020050D4
_020050C4:
	ldr r0, [r5, #4]
	ldrb r0, [r0]
	cmp r0, #0xff
	beq _020050D4
	cmp r0, #0xae
	beq _020050D4
	adds r4, r5, #0
	movs r6, #0
_020050D4:
	movs r0, #0x80
	ands r0, r7
	cmp r0, #0
	beq _020050EE
	adds r1, r6, #2
	cmp r1, r8
	bge _020050EE
	ldr r0, [r4, #0x1c]
	ldrb r0, [r0]
	cmp r0, #0xff
	beq _020050EE
	adds r4, #0x18
	adds r6, r1, #0
_020050EE:
	movs r0, #0x40
	ands r0, r7
	cmp r0, #0
	beq _0200510C
	subs r2, r6, #2
	cmp r2, #0
	blt _0200510C
	adds r1, r4, #0
	subs r1, #0x18
	ldr r0, [r1, #4]
	ldrb r0, [r0]
	cmp r0, #0xff
	beq _0200510C
	adds r4, r1, #0
	adds r6, r2, #0
_0200510C:
	cmp r3, r6
	beq _0200512E
	movs r0, #SE_SELECT
	bl PlaySE
	ldr r0, =gUnknown_02021A20
	ldr r0, [r0, #8]
	ldrb r1, [r4]
	ldrb r2, [r4, #1]
	bl SetSpritePos
	ldr r1, [r4, #8]
	cmp r1, #0
	beq _0200512E
	adds r0, r6, #0
	bl _call_via_r1
_0200512E:
	movs r0, #2
	ands r0, r7
	cmp r0, #0
	bne _02005154
	movs r0, #1
	ands r7, r0
	cmp r7, #0
	bne _02005140
	b _02005008
_02005140:
	movs r0, #SE_SELECT
	bl PlaySE
	ldr r0, =gUnknown_02021A20
	strb r6, [r0, #0x10]
	ldrb r0, [r4, #2]
	b _0200515C
	.align 2, 0
	.pool
_02005154:
	movs r0, #SE_SELECT
	bl PlaySE
_0200515A:
	movs r0, #0
_0200515C:
	pop {r3}
	mov r8, r3
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_02005168
sub_02005168: @ 0x02005168
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #0x18
	mov sl, r0
	ldr r2, =gPlayerPartyPtr
	ldr r0, =gUnknown_02020A48
	ldr r1, [r0]
	movs r0, #0x64
	muls r0, r1, r0
	ldr r6, [r2]
	adds r6, r6, r0
	ldr r0, =gAgbPmRomParams
	ldr r0, [r0]
	adds r0, #0xcc
	ldr r7, [r0]
	ldr r4, =gUnknown_02024960
	mov r1, sl
	lsls r0, r1, #1
	adds r1, r4, #0
	adds r1, #0x14
	adds r0, r0, r1
	ldrh r5, [r0]
	ldr r2, =gUnknown_02021A20
	ldr r0, [r2, #0x18]
	movs r1, #2
	mov r8, r1
	str r1, [sp]
	movs r2, #0
	mov sb, r2
	str r2, [sp, #4]
	movs r1, #0x16
	movs r2, #2
	movs r3, #6
	bl FillWindowCharBufferRect
	lsls r1, r5, #1
	adds r1, r1, r5
	lsls r1, r1, #2
	adds r1, r1, r7
	ldr r2, =gUnknown_02021A20
	ldr r0, [r2, #0x18]
	ldr r2, =gTypeNames
	ldrb r1, [r1, #2]
	lsls r1, r1, #2
	adds r1, r1, r2
	ldr r3, [r1]
	movs r1, #0xb0
	movs r2, #0x10
	bl RenderTextAt
	ldr r1, =gUnknown_02021A20
	ldr r0, [r1, #0x18]
	mov r2, r8
	str r2, [sp]
	mov r1, sb
	str r1, [sp, #4]
	movs r1, #0x18
	movs r2, #0
	movs r3, #4
	bl FillWindowCharBufferRect
	adds r4, #0x1c
	add r4, sl
	ldrb r4, [r4]
	adds r0, r6, #0
	movs r1, #0x15
	movs r2, #0
	bl GetMonData
	adds r1, r0, #0
	adds r0, r5, #0
	mov r2, sl
	bl CalculatePPWithBonus
	adds r5, r0, #0
	add r0, sp, #8
	adds r1, r4, #0
	bl NumToPmString3RightAlign
	add r1, sp, #8
	movs r0, #0xba
	strb r0, [r1, #3]
	add r0, sp, #0xc
	adds r1, r5, #0
	bl NumToPmString3RightAlign
	add r1, sp, #8
	adds r0, r1, #0
	ldrb r0, [r0, #5]
	strb r0, [r1, #4]
	adds r0, r1, #0
	ldrb r0, [r0, #6]
	strb r0, [r1, #5]
	adds r0, r1, #0
	ldrb r0, [r0, #7]
	strb r0, [r1, #6]
	ldr r2, =gUnknown_02021A20
	ldr r0, [r2, #0x18]
	movs r1, #0xbf
	movs r2, #0
	add r3, sp, #8
	bl RenderTextAt
	add sp, #0x18
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02005264
sub_02005264: @ 0x02005264
	push {r4, r5, r6, lr}
	sub sp, #0x1c
	movs r5, #6
	str r5, [sp]
	movs r4, #0
	str r4, [sp, #4]
	movs r0, #0xe
	str r0, [sp, #8]
	movs r0, #2
	movs r1, #0
	movs r2, #0x26
	movs r3, #0x1e
	bl CopyRectWithinBgTilemapBuffer
	str r5, [sp]
	str r4, [sp, #4]
	movs r0, #3
	movs r1, #0
	movs r2, #0xe
	movs r3, #0x1e
	bl FillBgTilemapBufferRect
	ldr r4, =gUnknown_02021A20
	ldr r0, [r4, #0x18]
	movs r1, #0
	bl ClearWindowCharBuffer
	ldr r0, [r4, #0x18]
	ldr r3, =gText_PP
	movs r1, #0xb0
	movs r2, #0
	bl RenderTextAt
	movs r0, #0
	bl sub_02005168
	movs r6, #0
	movs r4, #0
	ldr r0, =gUnknown_02024960
	adds r5, r0, #0
	adds r5, #0x14
_020052B6:
	ldrh r0, [r5]
	adds r1, r0, #0
	cmp r1, #0
	beq _020052D4
	add r0, sp, #0xc
	bl CopyMoveName
	adds r6, #1
	b _020052DC
	.align 2, 0
	.pool
_020052D4:
	add r0, sp, #0xc
	ldr r1, =gText_1Dash
	bl StringCopy
_020052DC:
	adds r0, r4, #0
	add r1, sp, #0xc
	bl BufferString
	adds r5, #2
	adds r4, #1
	cmp r4, #3
	ble _020052B6
	ldr r0, =gUnknown_02021A20
	ldr r0, [r0, #0x18]
	ldr r1, =gUnknown_0201FDC4
	movs r2, #4
	bl sub_02004F04
	ldr r1, =gBgTilemapBufferTransferScheduled
	movs r0, #1
	strb r0, [r1, #2]
	strb r0, [r1, #3]
	adds r0, r6, #0
	add sp, #0x1c
	pop {r4, r5, r6}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200531C
sub_0200531C: @ 0x0200531C
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #0x18
	adds r4, r0, #0
	ldr r7, =gUnknown_02021A00
	add r0, sp, #0x14
	movs r5, #0
	strh r5, [r0]
	ldr r2, =0x01000010
	adds r1, r7, #0
	bl CpuSet
	ldr r0, =gUnknown_02024960
	mov sb, r0
	lsls r2, r4, #1
	adds r0, r2, r4
	lsls r0, r0, #2
	mov r8, r0
	mov r1, r8
	add r1, sb
	ldr r3, =0x0000081C
	mov sl, r3
	adds r0, r1, r3
	ldrb r0, [r0]
	cmp r0, #0xff
	bne _0200536C
	strb r0, [r7]
	b _02005454
	.align 2, 0
	.pool
_0200536C:
	ldr r0, =0x00000826
	adds r1, r1, r0
	ldrb r0, [r1]
	lsls r0, r0, #0x1d
	lsrs r0, r0, #0x1d
	adds r0, #0xa1
	strb r0, [r7]
	movs r0, #0xca
	strb r0, [r7, #1]
	movs r0, #0xf0
	strb r0, [r7, #2]
	strb r5, [r7, #3]
	movs r5, #4
	ldrb r0, [r1]
	lsls r0, r0, #0x1c
	cmp r0, #0
	bge _02005398
	movs r0, #0xfc
	strb r0, [r7, #4]
	movs r0, #0x15
	strb r0, [r7, #5]
	movs r5, #6
_02005398:
	movs r6, #0
	ldr r3, =gAgbPmRomParams
	ldr r0, [r3]
	adds r0, #0x77
	mov ip, r2
	ldrb r0, [r0]
	cmp r6, r0
	bge _020053D2
	mov r0, sl
	add r0, sb
	mov r2, r8
	adds r1, r2, r0
	ldrb r0, [r1]
	cmp r0, #0xff
	beq _020053D2
	adds r2, r5, r7
_020053B8:
	ldrb r0, [r1]
	strb r0, [r2]
	adds r1, #1
	adds r2, #1
	adds r6, #1
	ldr r0, [r3]
	adds r0, #0x77
	ldrb r0, [r0]
	cmp r6, r0
	bge _020053D2
	ldrb r0, [r1]
	cmp r0, #0xff
	bne _020053B8
_020053D2:
	adds r6, r6, r5
	mov r3, ip
	adds r0, r3, r4
	lsls r0, r0, #2
	mov r8, r0
	add r0, sb
	ldr r1, =0x00000826
	adds r5, r0, r1
	ldrb r0, [r5]
	lsls r0, r0, #0x1a
	cmp r0, #0
	blt _020053F2
	ldrb r0, [r5]
	lsls r0, r0, #0x1b
	cmp r0, #0
	bge _02005430
_020053F2:
	ldrb r0, [r5]
	lsls r0, r0, #0x1a
	movs r1, #0x1d
	cmp r0, #0
	bge _020053FE
	movs r1, #0x20
_020053FE:
	add r4, sp, #4
	adds r0, r4, #0
	bl GetSpeciesName
	ldr r0, =0x0000081C
	add r0, sb
	add r0, r8
	adds r1, r4, #0
	bl StringCompare
	cmp r0, #0
	bne _0200544E
	ldrb r0, [r5]
	lsrs r0, r0, #6
	cmp r0, #0
	bne _0200543E
	adds r1, r7, r6
	movs r0, #0xb5
	b _0200544A
	.align 2, 0
	.pool
_02005430:
	ldrb r0, [r5]
	lsrs r0, r0, #6
	cmp r0, #0
	bne _0200543E
	adds r1, r7, r6
	movs r0, #0xb5
	b _0200544A
_0200543E:
	ldrb r0, [r5]
	lsrs r0, r0, #6
	cmp r0, #1
	bne _0200544E
	adds r1, r7, r6
	movs r0, #0xb6
_0200544A:
	strb r0, [r1]
	adds r6, #1
_0200544E:
	adds r1, r7, r6
	movs r0, #0xff
	strb r0, [r1]
_02005454:
	adds r0, r7, #0
	add sp, #0x18
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_02005468
sub_02005468: @ 0x02005468
	push {r4, r5, lr}
	sub sp, #0x10
	movs r0, #1
	rsbs r0, r0, #0
	adds r1, r0, #0
	add r0, sp, #0xc
	strb r1, [r0]
	movs r5, #6
	str r5, [sp]
	movs r4, #0
	str r4, [sp, #4]
	movs r0, #0xe
	str r0, [sp, #8]
	movs r0, #3
	movs r1, #0
	movs r2, #0x14
	movs r3, #0x1e
	bl CopyRectWithinBgTilemapBuffer
	str r5, [sp]
	str r4, [sp, #4]
	movs r0, #2
	movs r1, #0
	movs r2, #0xe
	movs r3, #0x1e
	bl FillBgTilemapBufferRect
	ldr r0, =gUnknown_02021A20
	ldr r0, [r0, #0x18]
	ldr r1, =0x0000FFFF
	bl ClearWindowCharBuffer
	ldr r5, =gStringBuffers
	movs r0, #0
	bl sub_0200531C
	adds r1, r0, #0
	adds r0, r5, #0
	bl StringCopy
	adds r4, r5, #0
	adds r4, #0x20
	movs r0, #1
	bl sub_0200531C
	adds r1, r0, #0
	adds r0, r4, #0
	bl StringCopy
	ldr r0, =gUnknown_02024960
	ldrb r0, [r0, #7]
	cmp r0, #4
	bne _02005504
	adds r4, #0x20
	movs r0, #2
	bl sub_0200531C
	adds r1, r0, #0
	adds r0, r4, #0
	bl StringCopy
	adds r4, #0x20
	movs r0, #3
	bl sub_0200531C
	adds r1, r0, #0
	adds r0, r4, #0
	bl StringCopy
	b _02005518
	.align 2, 0
	.pool
_02005504:
	adds r0, r5, #0
	adds r0, #0x40
	add r1, sp, #0xc
	bl StringCopy
	adds r0, r5, #0
	adds r0, #0x60
	add r1, sp, #0xc
	bl StringCopy
_02005518:
	ldr r0, =gUnknown_02021A20
	ldr r0, [r0, #0x18]
	ldr r1, =gUnknown_0201FDF4
	movs r2, #4
	bl sub_02004F04
	ldr r1, =gBgTilemapBufferTransferScheduled
	movs r0, #1
	strb r0, [r1, #3]
	strb r0, [r1, #2]
	ldr r0, =gUnknown_02024960
	ldrb r0, [r0, #7]
	add sp, #0x10
	pop {r4, r5}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_02005548
sub_02005548: @ 0x02005548
	push {r4, r5, lr}
	sub sp, #0xc
	movs r5, #6
	str r5, [sp]
	movs r4, #0
	str r4, [sp, #4]
	movs r0, #0xe
	str r0, [sp, #8]
	movs r0, #3
	movs r1, #0
	movs r2, #0x14
	movs r3, #0x1e
	bl CopyRectWithinBgTilemapBuffer
	str r5, [sp]
	str r4, [sp, #4]
	movs r0, #2
	movs r1, #0
	movs r2, #0xe
	movs r3, #0x1e
	bl FillBgTilemapBufferRect
	ldr r5, =gUnknown_02021A20
	ldr r0, [r5, #0x18]
	ldr r1, =0x0000FFFF
	bl ClearWindowCharBuffer
	ldr r0, [r5, #0x18]
	ldr r3, =gText_WillYouGiveIn
	movs r1, #0
	movs r2, #0
	bl RenderTextAt
	ldr r0, [r5, #0x18]
	ldr r4, =gUnknown_0201FE24
	adds r1, r4, #0
	movs r2, #2
	bl sub_02004F04
	ldr r1, =gBgTilemapBufferTransferScheduled
	movs r0, #1
	strb r0, [r1, #3]
	strb r0, [r1, #2]
	adds r0, r4, #0
	movs r1, #2
	bl sub_02004FB8
	adds r4, r0, #0
	cmp r4, #1
	beq _020055B4
	ldr r0, [r5, #0x18]
	movs r1, #0
	bl ClearWindowCharBuffer
_020055B4:
	adds r0, r4, #0
	add sp, #0xc
	pop {r4, r5}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_020055D4
sub_020055D4: @ 0x020055D4
	push {r4, r5, r6, r7, lr}
	mov r7, sb
	mov r6, r8
	push {r6, r7}
	sub sp, #0x40
	mov r8, r0
	adds r6, r1, #0
	mov sb, r2
	adds r7, r3, #0
	movs r4, #6
	str r4, [sp]
	movs r5, #0
	str r5, [sp, #4]
	movs r0, #2
	movs r1, #0
	movs r2, #0xe
	movs r3, #0x1e
	bl FillBgTilemapBufferRect
	str r4, [sp]
	str r5, [sp, #4]
	movs r0, #0xe
	str r0, [sp, #8]
	movs r0, #3
	movs r1, #0
	movs r2, #0x14
	movs r3, #0x1e
	bl CopyRectWithinBgTilemapBuffer
	ldr r4, =gUnknown_02021A20
	ldr r0, [r4, #0x18]
	movs r1, #0
	bl ClearWindowCharBuffer
	ldr r0, [r4, #8]
	bl MoveSpriteToHead
	str r5, [r4, #8]
	cmp r6, #0
	beq _02005658
	subs r0, r6, #1
	ldr r1, =gUnknown_02024960
	lsls r0, r0, #1
	adds r1, #0x14
	adds r0, r0, r1
	ldrh r0, [r0]
	adds r1, r0, #0
	cmp r1, #0
	beq _02005648
	add r0, sp, #0x24
	bl CopyMoveName
	b _02005650
	.align 2, 0
	.pool
_02005648:
	ldr r1, =gText_1Dash
	add r0, sp, #0x24
	bl StringCopy
_02005650:
	movs r0, #0
	add r1, sp, #0x24
	bl BufferString
_02005658:
	ldr r2, =gPlayerPartyPtr
	movs r0, #0x64
	mov r1, r8
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	movs r1, #2
	add r2, sp, #0xc
	bl GetMonData
	movs r0, #4
	add r1, sp, #0xc
	bl BufferString
	ldr r6, =gBgTilemapBufferTransferScheduled
	movs r5, #1
	strb r5, [r6, #2]
	strb r5, [r6, #3]
	ldr r4, =gUnknown_02021A20
	ldr r0, [r4, #0x18]
	ldr r2, =gBattleStringsTable
	mov r3, sb
	lsls r1, r3, #2
	adds r1, r1, r2
	ldr r1, [r1]
	bl RenderText
	cmp r7, #0
	bne _020056DA
	ldr r0, [r4, #0x18]
	movs r1, #0
	bl ClearWindowCharBuffer
	movs r0, #6
	str r0, [sp]
	str r7, [sp, #4]
	movs r0, #0xe
	str r0, [sp, #8]
	movs r0, #2
	movs r1, #0
	movs r2, #0x20
	movs r3, #0x1e
	bl CopyRectWithinBgTilemapBuffer
	ldr r0, [r4, #0x18]
	movs r1, #4
	str r1, [sp]
	str r7, [sp, #4]
	movs r1, #0x12
	movs r2, #0
	movs r3, #0xa
	bl FillWindowCharBufferRect
	ldr r0, [r4, #0x18]
	ldr r3, =gText_WhatWillMonDo
	movs r1, #0
	movs r2, #0
	bl RenderTextAt
	ldr r0, [r4, #0x18]
	ldr r1, =gText_BattleOptions
	movs r2, #4
	bl sub_02004F04
	strb r5, [r6, #2]
_020056DA:
	add sp, #0x40
	pop {r3, r4}
	mov r8, r3
	mov sb, r4
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02005704
sub_02005704: @ 0x02005704
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #0xc
	mov sl, r0
	ldr r7, =gUnknown_020219F0
	ldr r0, =gUnknown_02020A48
	mov r1, sl
	str r1, [r0]
	bl sub_02004AC4
	mov r0, sl
	bl sub_02004D68
	movs r0, #6
	str r0, [sp]
	movs r5, #0
	str r5, [sp, #4]
	movs r0, #0xe
	str r0, [sp, #8]
	movs r0, #2
	movs r1, #0
	movs r2, #0x20
	movs r3, #0x1e
	bl CopyRectWithinBgTilemapBuffer
	ldr r4, =gUnknown_02021A20
	ldr r0, [r4, #0x18]
	movs r1, #4
	str r1, [sp]
	str r5, [sp, #4]
	movs r1, #0x12
	movs r2, #0
	movs r3, #0xa
	bl FillWindowCharBufferRect
	ldr r0, [r4, #0x18]
	ldr r3, =gText_WhatWillMonDo
	movs r1, #0
	movs r2, #0
	bl RenderTextAt
	ldr r0, [r4, #0x18]
	ldr r1, =gText_BattleOptions
	movs r2, #4
	bl sub_02004F04
	ldr r1, =gBgTilemapBufferTransferScheduled
	movs r0, #1
	strb r0, [r1, #2]
	bl FadeIn
	movs r2, #1
	mov r8, r2
_02005774:
	ldrb r0, [r7]
	cmp r0, #4
	bls _0200577C
	b _02005B1E
_0200577C:
	lsls r0, r0, #2
	ldr r1, =_020057A4
	adds r0, r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
	.pool
_020057A4: @ jump table
	.4byte _020057B8 @ case 0
	.4byte _02005848 @ case 1
	.4byte _02005978 @ case 2
	.4byte _020059A4 @ case 3
	.4byte _02005A64 @ case 4
_020057B8:
	movs r0, #6
	str r0, [sp]
	movs r5, #0
	str r5, [sp, #4]
	movs r0, #0xe
	str r0, [sp, #8]
	movs r0, #2
	movs r1, #0
	movs r2, #0x20
	movs r3, #0x1e
	bl CopyRectWithinBgTilemapBuffer
	ldr r4, =gUnknown_02021A20
	ldr r0, [r4, #0x18]
	movs r1, #4
	str r1, [sp]
	str r5, [sp, #4]
	movs r1, #0x12
	movs r2, #0
	movs r3, #0xa
	bl FillWindowCharBufferRect
	ldr r0, [r4, #0x18]
	ldr r3, =gText_WhatWillMonDo
	movs r1, #0
	movs r2, #0
	bl RenderTextAt
	ldr r0, [r4, #0x18]
	ldr r4, =gText_BattleOptions
	adds r1, r4, #0
	movs r2, #4
	bl sub_02004F04
	ldr r1, =gBgTilemapBufferTransferScheduled
	movs r0, #1
	strb r0, [r1, #2]
	adds r0, r4, #0
	movs r1, #4
	bl sub_02004FB8
	strb r0, [r7]
	lsls r0, r0, #0x18
	lsrs r2, r0, #0x18
	cmp r2, #0
	beq _02005816
	b _02005B1E
_02005816:
	ldr r1, =gUnknown_02024960
	ldrb r0, [r1, #3]
	lsls r0, r0, #0x19
	lsrs r0, r0, #0x19
	cmp r0, #2
	beq _02005824
	b _02005B1E
_02005824:
	ldr r3, =0x0000087B
	adds r0, r1, r3
	ldrb r1, [r0]
	strb r2, [r0]
	b _02005996
	.align 2, 0
	.pool
_02005848:
	bl sub_0200644C
	adds r4, r0, #0
	cmp r4, #1
	bne _02005888
	ldr r0, =gUnknown_02020A48
	ldr r0, [r0]
	movs r1, #0
	movs r2, #0xe
	movs r3, #1
	bl sub_020055D4
	ldr r0, =gUnknown_02024960
	ldr r2, =0x0000087C
	adds r1, r0, r2
	ldrb r2, [r1]
	movs r2, #0
	strb r2, [r1]
	ldr r3, =0x0000087B
	adds r0, r0, r3
	ldrb r1, [r0]
	strb r4, [r0]
	b _020058A6
	.align 2, 0
	.pool
_02005888:
	bl sub_0200644C
	cmp r0, #2
	bne _020058B8
	ldr r1, =gUnknown_02024960
	ldr r2, =0x0000087C
	adds r0, r1, r2
	ldrb r2, [r0]
	movs r2, #0
	strb r2, [r0]
	ldr r3, =0x0000087B
	adds r1, r1, r3
	ldrb r0, [r1]
	movs r0, #1
	strb r0, [r1]
_020058A6:
	strb r2, [r7]
	mov r8, r2
	b _02005B1E
	.align 2, 0
	.pool
_020058B8:
	mov r0, sl
	bl sub_02005264
	adds r1, r0, #0
	ldr r0, =gUnknown_0201FDC4
	bl sub_02004FB8
	strb r0, [r7, #2]
	lsls r0, r0, #0x18
	lsrs r1, r0, #0x18
	cmp r1, #0
	bne _02005908
	strb r1, [r7]
	movs r0, #6
	str r0, [sp]
	str r1, [sp, #4]
	movs r0, #0xe
	str r0, [sp, #8]
	movs r0, #3
	movs r1, #0
	movs r2, #0x14
	movs r3, #0x1e
	bl CopyRectWithinBgTilemapBuffer
	ldr r0, =gUnknown_02021A20
	ldr r0, [r0, #0x18]
	movs r1, #0
	bl ClearWindowCharBuffer
	ldr r1, =gBgTilemapBufferTransferScheduled
	movs r0, #1
	strb r0, [r1, #3]
	b _02005B1E
	.align 2, 0
	.pool
_02005908:
	ldrb r0, [r7, #2]
	subs r0, #1
	bl sub_02006430
	cmp r0, #0
	bne _02005974
	ldr r0, =gUnknown_02020A48
	ldr r4, [r0]
	ldrb r5, [r7, #2]
	subs r0, r5, #1
	bl sub_02006414
	cmp r0, #6
	bls _02005926
	b _02005B1A
_02005926:
	lsls r0, r0, #2
	ldr r1, =_02005938
	adds r0, r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
	.pool
_02005938: @ jump table
	.4byte _02005B00 @ case 0
	.4byte _02005954 @ case 1
	.4byte _0200595C @ case 2
	.4byte _02005964 @ case 3
	.4byte _0200596C @ case 4
	.4byte _02005AE0 @ case 5
	.4byte _02005AF2 @ case 6
_02005954:
	adds r0, r4, #0
	adds r1, r5, #0
	movs r2, #4
	b _02005AEA
_0200595C:
	adds r0, r4, #0
	adds r1, r5, #0
	movs r2, #5
	b _02005AEA
_02005964:
	adds r0, r4, #0
	adds r1, r5, #0
	movs r2, #6
	b _02005AEA
_0200596C:
	adds r0, r4, #0
	adds r1, r5, #0
	movs r2, #7
	b _02005AEA
_02005974:
	movs r0, #4
	b _02005B1C
_02005978:
	bl sub_02005548
	mov sb, r0
	movs r0, #0
	strb r0, [r7]
	mov r2, sb
	cmp r2, #1
	beq _0200598A
	b _02005B1E
_0200598A:
	ldr r0, =gUnknown_02024960
	ldr r3, =0x0000087B
	adds r0, r0, r3
	ldrb r1, [r0]
	movs r1, #3
	strb r1, [r0]
_02005996:
	movs r0, #0
	mov r8, r0
	b _02005B1E
	.align 2, 0
	.pool
_020059A4:
	bl FadeOut
	bl sub_02002C80
	ldr r1, =gUnknown_02024960
	ldrb r0, [r1, #3]
	lsls r0, r0, #0x19
	cmp r0, #0
	bne _020059C8
	ldr r2, =0x00000858
	adds r0, r1, r2
	ldrb r1, [r0]
	movs r1, #1
	b _020059D0
	.align 2, 0
	.pool
_020059C8:
	ldr r3, =0x00000858
	adds r0, r1, r3
	ldrb r1, [r0]
	movs r1, #2
_020059D0:
	strb r1, [r0]
	movs r0, #0
	mov r1, sl
	movs r2, #0
	bl sub_02002A9C
	movs r6, #0
	strb r6, [r7]
	ldr r0, =gUnknown_02024960
	ldr r1, =0x0000087B
	adds r0, r0, r1
	ldrb r0, [r0]
	adds r5, r0, #0
	cmp r5, #4
	beq _02005A00
	mov r8, r6
	b _02005B1E
	.align 2, 0
	.pool
_02005A00:
	bl sub_02004AC4
	mov r0, sl
	bl sub_02004D68
	movs r0, #6
	str r0, [sp]
	str r6, [sp, #4]
	movs r0, #0xe
	str r0, [sp, #8]
	movs r0, #2
	movs r1, #0
	movs r2, #0x20
	movs r3, #0x1e
	bl CopyRectWithinBgTilemapBuffer
	ldr r4, =gUnknown_02021A20
	ldr r0, [r4, #0x18]
	str r5, [sp]
	str r6, [sp, #4]
	movs r1, #0x12
	movs r2, #0
	movs r3, #0xa
	bl FillWindowCharBufferRect
	ldr r0, [r4, #0x18]
	ldr r3, =gText_WhatWillMonDo
	movs r1, #0
	movs r2, #0
	bl RenderTextAt
	ldr r0, [r4, #0x18]
	ldr r1, =gText_BattleOptions
	movs r2, #4
	bl sub_02004F04
	ldr r1, =gBgTilemapBufferTransferScheduled
	movs r0, #1
	strb r0, [r1, #2]
	bl FadeIn
	b _02005B1E
	.align 2, 0
	.pool
_02005A64:
	bl sub_02005468
	ldr r0, =gUnknown_0201FDF4
	movs r1, #4
	bl sub_02004FB8
	mov sb, r0
	cmp r0, #0
	bne _02005A80
	movs r0, #1
	b _02005B1C
	.align 2, 0
	.pool
_02005A80:
	ldr r0, =gUnknown_02020A48
	ldr r4, [r0]
	ldrb r5, [r7, #2]
	subs r0, r5, #1
	bl sub_02006414
	cmp r0, #6
	bhi _02005B1A
	lsls r0, r0, #2
	ldr r1, =_02005AA4
	adds r0, r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
	.pool
_02005AA4: @ jump table
	.4byte _02005B00 @ case 0
	.4byte _02005AC0 @ case 1
	.4byte _02005AC8 @ case 2
	.4byte _02005AD0 @ case 3
	.4byte _02005AD8 @ case 4
	.4byte _02005AE0 @ case 5
	.4byte _02005AF2 @ case 6
_02005AC0:
	adds r0, r4, #0
	adds r1, r5, #0
	movs r2, #4
	b _02005AEA
_02005AC8:
	adds r0, r4, #0
	adds r1, r5, #0
	movs r2, #5
	b _02005AEA
_02005AD0:
	adds r0, r4, #0
	adds r1, r5, #0
	movs r2, #6
	b _02005AEA
_02005AD8:
	adds r0, r4, #0
	adds r1, r5, #0
	movs r2, #7
	b _02005AEA
_02005AE0:
	bl sub_0200645C
	adds r1, r0, #0
	adds r0, r4, #0
	movs r2, #8
_02005AEA:
	movs r3, #0
	bl sub_020055D4
	b _02005B1A
_02005AF2:
	adds r0, r4, #0
	adds r1, r5, #0
	movs r2, #9
	movs r3, #0
	bl sub_020055D4
	b _02005B1A
_02005B00:
	ldr r1, =gUnknown_02024960
	ldr r2, =0x0000087C
	adds r0, r1, r2
	ldrb r2, [r0]
	mov r3, sb
	strb r3, [r0]
	ldr r0, =0x0000087B
	adds r1, r1, r0
	ldrb r0, [r1]
	movs r0, #1
	strb r0, [r1]
	movs r1, #0
	mov r8, r1
_02005B1A:
	movs r0, #0
_02005B1C:
	strb r0, [r7]
_02005B1E:
	movs r0, #1
	bl DelayFrames
	mov r2, r8
	cmp r2, #0
	beq _02005B2C
	b _02005774
_02005B2C:
	movs r2, #0
	ldr r0, =gUnknown_02024960
	ldr r3, =0x0000087B
	adds r1, r0, r3
	ldrb r1, [r1]
	adds r3, r0, #0
	cmp r1, #1
	beq _02005B50
	cmp r1, #2
	beq _02005B6C
	b _02005B74
	.align 2, 0
	.pool
_02005B50:
	ldrb r2, [r7, #2]
	subs r2, #1
	ldr r1, =0x0000087C
	adds r0, r3, r1
	ldrb r0, [r0]
	subs r0, #1
	lsls r0, r0, #8
	movs r1, #0xff
	lsls r1, r1, #8
	ands r0, r1
	orrs r2, r0
	b _02005B74
	.align 2, 0
	.pool
_02005B6C:
	ldr r2, =0x0000087E
	adds r0, r3, r2
	ldrb r0, [r0]
	adds r2, r0, #0
_02005B74:
	ldr r1, =0x0000087B
	adds r0, r3, r1
	ldrb r0, [r0]
	lsls r0, r0, #0x10
	orrs r2, r0
	adds r1, #5
	adds r0, r3, r1
	str r2, [r0]
	ldr r2, =0x0000087F
	adds r1, r3, r2
	ldrb r0, [r1]
	movs r0, #1
	strb r0, [r1]
	bl IsScreenFadedOut
	cmp r0, #0
	bne _02005B9A
	bl FadeOut
_02005B9A:
	movs r0, #0
	add sp, #0xc
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_02005BB8
sub_02005BB8: @ 0x02005BB8
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #0xc
	mov r1, sp
	movs r0, #0
	strh r0, [r1]
	ldr r0, =gPlayerPartyPtr
	ldr r1, [r0]
	ldr r2, =0x0100012C
	mov r0, sp
	bl CpuSet
	ldr r0, =gUnknown_02024960
	ldr r0, [r0]
	lsls r0, r0, #8
	lsrs r0, r0, #8
	str r0, [sp, #4]
	movs r0, #0
	mov sl, r0
	movs r1, #0
	str r1, [sp, #8]
_02005BE8:
	ldr r1, [sp, #4]
	movs r2, #0xf
	ands r1, r2
	cmp r1, #0xf
	bne _02005BF4
	b _02005D66
_02005BF4:
	ldr r0, =gPlayerPartyBakPtr
	movs r2, #0x64
	muls r1, r2, r1
	ldr r0, [r0]
	adds r0, r0, r1
	ldr r3, =gPlayerPartyPtr
	mov r8, r3
	mov r6, sl
	muls r6, r2, r6
	ldr r1, [r3]
	adds r1, r1, r6
	movs r2, #0x32
	bl CpuSet
	ldr r0, [sp, #8]
	ldr r1, =gUnknown_02024960
	adds r7, r0, r1
	ldrh r0, [r7, #0x24]
	mov r4, sp
	adds r4, #2
	strh r0, [r4]
	mov r2, r8
	ldr r0, [r2]
	adds r0, r0, r6
	movs r1, #0x39
	adds r2, r4, #0
	bl SetMonData
	ldrh r0, [r7, #0x26]
	lsls r0, r0, #0x14
	lsrs r0, r0, #0x14
	strh r0, [r4]
	mov r3, r8
	ldr r0, [r3]
	adds r0, r0, r6
	movs r1, #0x37
	adds r2, r4, #0
	bl SetMonData
	movs r0, #0
	mov sb, r0
	strh r0, [r4]
	adds r5, r7, #0
	adds r5, #0x27
	ldrb r0, [r5]
	lsls r0, r0, #0x1b
	cmp r0, #0
	bge _02005C58
	movs r1, #0xf
	strh r1, [r4]
_02005C58:
	ldrb r0, [r5]
	lsls r0, r0, #0x1a
	cmp r0, #0
	bge _02005C68
	movs r0, #0xf0
	ldrh r2, [r4]
	orrs r0, r2
	strh r0, [r4]
_02005C68:
	mov r3, r8
	ldr r0, [r3]
	adds r0, r0, r6
	movs r1, #0x22
	adds r2, r4, #0
	bl SetMonData
	ldrb r0, [r5]
	lsls r0, r0, #0x19
	cmp r0, #0
	bge _02005C90
	movs r0, #1
	strh r0, [r4]
	mov r1, r8
	ldr r0, [r1]
	adds r0, r0, r6
	movs r1, #0x40
	adds r2, r4, #0
	bl SetMonData
_02005C90:
	mov r2, sb
	strh r2, [r4]
	ldrb r0, [r5]
	lsrs r0, r0, #7
	cmp r0, #0
	beq _02005CA0
	ldrh r0, [r7, #0x28]
	strh r0, [r4]
_02005CA0:
	mov r3, r8
	ldr r0, [r3]
	adds r0, r0, r6
	movs r1, #0xc
	adds r2, r4, #0
	bl SetMonData
	ldrh r0, [r7, #0x2c]
	strh r0, [r4]
	mov r1, r8
	ldr r0, [r1]
	adds r0, r0, r6
	movs r1, #0xd
	adds r2, r4, #0
	bl SetMonData
	ldrh r0, [r7, #0x2e]
	strh r0, [r4]
	mov r2, r8
	ldr r0, [r2]
	adds r0, r0, r6
	movs r1, #0xe
	adds r2, r4, #0
	bl SetMonData
	ldrh r0, [r7, #0x30]
	strh r0, [r4]
	mov r3, r8
	ldr r0, [r3]
	adds r0, r0, r6
	movs r1, #0xf
	adds r2, r4, #0
	bl SetMonData
	ldrh r0, [r7, #0x32]
	strh r0, [r4]
	mov r1, r8
	ldr r0, [r1]
	adds r0, r0, r6
	movs r1, #0x10
	adds r2, r4, #0
	bl SetMonData
	adds r0, r7, #0
	adds r0, #0x34
	ldrb r0, [r0]
	strh r0, [r4]
	mov r2, r8
	ldr r0, [r2]
	adds r0, r0, r6
	movs r1, #0x11
	adds r2, r4, #0
	bl SetMonData
	adds r0, r7, #0
	adds r0, #0x35
	ldrb r0, [r0]
	strh r0, [r4]
	mov r3, r8
	ldr r0, [r3]
	adds r0, r0, r6
	movs r1, #0x12
	adds r2, r4, #0
	bl SetMonData
	adds r0, r7, #0
	adds r0, #0x36
	ldrb r0, [r0]
	strh r0, [r4]
	mov r1, r8
	ldr r0, [r1]
	adds r0, r0, r6
	movs r1, #0x13
	adds r2, r4, #0
	bl SetMonData
	adds r0, r7, #0
	adds r0, #0x37
	ldrb r0, [r0]
	strh r0, [r4]
	mov r2, r8
	ldr r0, [r2]
	adds r0, r0, r6
	movs r1, #0x14
	adds r2, r4, #0
	bl SetMonData
	ldr r4, =gUnknown_02024960
	adds r4, #0x38
	ldr r3, [sp, #8]
	adds r4, r3, r4
	mov r0, sl
	bl sub_0200CB34
	adds r1, r0, #0
	adds r0, r4, #0
	movs r2, #0xa0
	bl CpuSet
_02005D66:
	ldr r0, [sp, #8]
	movs r1, #0xaa
	lsls r1, r1, #1
	adds r0, r0, r1
	str r0, [sp, #8]
	movs r2, #1
	add sl, r2
	ldr r3, [sp, #4]
	lsrs r3, r3, #4
	str r3, [sp, #4]
	mov r0, sl
	cmp r0, #5
	bgt _02005D82
	b _02005BE8
_02005D82:
	ldr r1, =gUnknown_02024960
	ldrb r0, [r1, #3]
	lsls r0, r0, #0x19
	lsrs r2, r0, #0x19
	cmp r2, #0
	beq _02005DB0
	ldr r2, =0x00000858
	adds r0, r1, r2
	ldrb r1, [r0]
	movs r1, #1
	strb r1, [r0]
	b _02005DB8
	.align 2, 0
	.pool
_02005DB0:
	ldr r3, =0x00000858
	adds r0, r1, r3
	ldrb r1, [r0]
	strb r2, [r0]
_02005DB8:
	add sp, #0xc
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02005DCC
sub_02005DCC: @ 0x02005DCC
	push {r4, r5, r6, lr}
	mov r6, r8
	push {r6}
	sub sp, #0x24
	mov r8, r0
	adds r6, r1, #0
	ldr r0, =gUnknown_02020A48
	mov r1, r8
	str r1, [r0]
	bl sub_02004AC4
	mov r0, r8
	bl sub_02004D68
	movs r5, #6
	str r5, [sp]
	movs r4, #0
	str r4, [sp, #4]
	movs r0, #0xe
	str r0, [sp, #8]
	movs r0, #2
	movs r1, #0
	movs r2, #0x26
	movs r3, #0x1e
	bl CopyRectWithinBgTilemapBuffer
	str r5, [sp]
	str r4, [sp, #4]
	movs r0, #3
	movs r1, #0
	movs r2, #0xe
	movs r3, #0x1e
	bl FillBgTilemapBufferRect
	ldr r4, =gUnknown_02021A20
	ldr r0, [r4, #0x18]
	movs r1, #0
	bl ClearWindowCharBuffer
	ldr r2, =gPlayerPartyPtr
	movs r0, #0x64
	mov r1, r8
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	movs r1, #2
	add r2, sp, #0xc
	bl GetMonData
	movs r0, #4
	add r1, sp, #0xc
	bl BufferString
	bl FadeIn
	ldr r0, [r4, #0x18]
	ldr r1, =gBattleStringsTable
	lsls r6, r6, #2
	adds r6, r6, r1
	ldr r1, [r6]
	bl RenderText
	bl FadeOut
	add sp, #0x24
	pop {r3}
	mov r8, r3
	pop {r4, r5, r6}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_02005E68
sub_02005E68: @ 0x02005E68
	push {r4, r5, lr}
	sub sp, #0xc
	movs r0, #6
	str r0, [sp]
	movs r5, #0
	str r5, [sp, #4]
	movs r0, #0xe
	str r0, [sp, #8]
	movs r0, #2
	movs r1, #0
	movs r2, #0x20
	movs r3, #0x1e
	bl CopyRectWithinBgTilemapBuffer
	ldr r4, =gUnknown_02021A20
	ldr r0, [r4, #0x18]
	movs r1, #4
	str r1, [sp]
	str r5, [sp, #4]
	movs r1, #0x12
	movs r2, #0
	movs r3, #0xa
	bl FillWindowCharBufferRect
	ldr r0, [r4, #0x18]
	ldr r3, =gText_WhatWillMonDo
	movs r1, #0
	movs r2, #0
	bl RenderTextAt
	ldr r0, [r4, #0x18]
	ldr r1, =gText_BattleOptions
	movs r2, #4
	bl sub_02004F04
	ldr r1, =gBgTilemapBufferTransferScheduled
	movs r0, #1
	strb r0, [r1, #2]
	add sp, #0xc
	pop {r4, r5}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02005ECC
sub_02005ECC: @ 0x02005ECC
	push {lr}
	sub sp, #0xc
	movs r0, #6
	str r0, [sp]
	movs r0, #0
	str r0, [sp, #4]
	movs r0, #0xe
	str r0, [sp, #8]
	movs r0, #3
	movs r1, #0
	movs r2, #0x14
	movs r3, #0x1e
	bl CopyRectWithinBgTilemapBuffer
	ldr r0, =gUnknown_02021A20
	ldr r0, [r0, #0x18]
	movs r1, #0
	bl ClearWindowCharBuffer
	ldr r1, =gBgTilemapBufferTransferScheduled
	movs r0, #1
	strb r0, [r1, #3]
	add sp, #0xc
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02005F08
sub_02005F08: @ 0x02005F08
	push {lr}
	sub sp, #0x1c
	ldr r0, =gUnknown_02024960
	lsls r1, r1, #1
	adds r0, #0x14
	adds r1, r1, r0
	ldrh r0, [r1]
	adds r1, r0, #0
	cmp r1, #0
	beq _02005F28
	mov r0, sp
	bl CopyMoveName
	b _02005F30
	.align 2, 0
	.pool
_02005F28:
	ldr r1, =gText_1Dash
	mov r0, sp
	bl StringCopy
_02005F30:
	movs r0, #0
	mov r1, sp
	bl BufferString
	add sp, #0x1c
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02005F44
sub_02005F44: @ 0x02005F44
	push {r4, r5, lr}
	adds r4, r0, #0
	adds r5, r1, #0
	subs r0, r5, #1
	bl sub_02006414
	cmp r0, #6
	bhi _02005FC2
	lsls r0, r0, #2
	ldr r1, =_02005F64
	adds r0, r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
	.pool
_02005F64: @ jump table
	.4byte _02005F80 @ case 0
	.4byte _02005F84 @ case 1
	.4byte _02005F8C @ case 2
	.4byte _02005F94 @ case 3
	.4byte _02005F9C @ case 4
	.4byte _02005FA4 @ case 5
	.4byte _02005FB6 @ case 6
_02005F80:
	movs r0, #1
	b _02005FC4
_02005F84:
	adds r0, r4, #0
	adds r1, r5, #0
	movs r2, #4
	b _02005FAE
_02005F8C:
	adds r0, r4, #0
	adds r1, r5, #0
	movs r2, #5
	b _02005FAE
_02005F94:
	adds r0, r4, #0
	adds r1, r5, #0
	movs r2, #6
	b _02005FAE
_02005F9C:
	adds r0, r4, #0
	adds r1, r5, #0
	movs r2, #7
	b _02005FAE
_02005FA4:
	bl sub_0200645C
	adds r1, r0, #0
	adds r0, r4, #0
	movs r2, #8
_02005FAE:
	movs r3, #0
	bl sub_020055D4
	b _02005FC2
_02005FB6:
	adds r0, r4, #0
	adds r1, r5, #0
	movs r2, #9
	movs r3, #0
	bl sub_020055D4
_02005FC2:
	movs r0, #0
_02005FC4:
	pop {r4, r5}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_02005FCC
sub_02005FCC: @ 0x02005FCC
	push {r4, lr}
	movs r0, #0
	bl sub_0200A2C8
	adds r2, r0, #0
	ldr r0, =gUnknown_02024960
	ldr r1, =0x0000084C
	adds r3, r0, r1
	ldrb r1, [r3]
	movs r0, #5
	rsbs r0, r0, #0
	ands r0, r1
	strb r0, [r3]
	cmp r2, #0
	bne _02006044
	ldr r0, =0x04000154
	str r2, [r0]
	ldrb r1, [r3]
	movs r0, #4
	ands r0, r1
	cmp r0, #0
	bne _02006006
	adds r2, r3, #0
	movs r3, #4
_02005FFC:
	ldrb r1, [r2]
	adds r0, r3, #0
	ands r0, r1
	cmp r0, #0
	beq _02005FFC
_02006006:
	movs r0, #1
	bl sub_0200A2C8
	adds r2, r0, #0
	ldr r0, =gUnknown_02024960
	ldr r1, =0x0000084C
	adds r3, r0, r1
	ldrb r1, [r3]
	movs r0, #8
	ands r0, r1
	cmp r0, #0
	beq _0200602A
	movs r4, #8
_02006020:
	ldrb r1, [r3]
	adds r0, r4, #0
	ands r0, r1
	cmp r0, #0
	bne _02006020
_0200602A:
	cmp r2, #0
	bne _02006044
	ldr r0, =0x04000154
	str r2, [r0]
	movs r0, #0
	b _0200604E
	.align 2, 0
	.pool
_02006044:
	ldr r1, =0x04000154
	movs r0, #1
	rsbs r0, r0, #0
	str r0, [r1]
	movs r0, #1
_0200604E:
	pop {r4}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_02006058
sub_02006058: @ 0x02006058
	push {r4, r5, r6, lr}
	movs r0, #2
	bl WarningPrint
	ldr r0, =gUnknown_02024960
	ldr r1, =0x0000084C
	adds r2, r0, r1
	ldrb r1, [r2]
	movs r0, #2
	ands r0, r1
	cmp r0, #0
	bne _02006084
	ldr r4, =gUnknown_020251F0
	movs r3, #2
_02006074:
	ldrb r0, [r4, #0xc]
	cmp r0, #0
	beq _020060A6
	ldrb r1, [r2]
	adds r0, r3, #0
	ands r0, r1
	cmp r0, #0
	beq _02006074
_02006084:
	ldr r0, =gRomDetection_IsRubySapphire
	ldrb r0, [r0]
	cmp r0, #0
	beq _020060C0
	bl GetPlayerMapType
	movs r1, #2
	ands r1, r0
	cmp r1, #0
	bne _02006144
	ldr r1, =0x04000154
	movs r0, #1
	rsbs r0, r0, #0
	str r0, [r1]
	movs r0, #5
	bl WarningPrint
_020060A6:
	movs r0, #2
	b _02006256
	.align 2, 0
	.pool
_020060C0:
	ldr r6, =gAgbPmRomParams
	ldr r0, [r6]
	ldr r5, =gSaveBlock2Ptr
	ldr r1, [r5]
	adds r0, #0xd8
	ldr r0, [r0]
	adds r1, r1, r0
	ldrh r4, [r1]
	ldr r0, =0x0000FFFE
	ands r0, r4
	cmp r0, #0
	bne _020060E6
	ldr r1, =0x04000154
	movs r0, #1
	rsbs r0, r0, #0
	str r0, [r1]
	movs r0, #0xa
	bl ErrorPrint
_020060E6:
	ldr r0, [r6]
	ldr r1, [r5]
	adds r0, #0x98
	ldr r0, [r0]
	adds r1, r1, r0
	movs r0, #7
	ldrb r1, [r1]
	ands r0, r1
	cmp r0, #0
	bne _02006108
	ldr r1, =0x04000154
	movs r0, #1
	rsbs r0, r0, #0
	str r0, [r1]
	movs r0, #0xa
	bl ErrorPrint
_02006108:
	ldr r2, =gPlayerPartyPtr
	ldr r0, =gUnknown_02024960
	ldr r1, =0x0000084C
	adds r0, r0, r1
	ldrb r0, [r0]
	lsrs r0, r0, #4
	movs r1, #0x64
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	movs r1, #0x25
	movs r2, #0
	bl GetMonData
	lsls r0, r0, #0x10
	lsrs r0, r0, #0x10
	movs r1, #0x80
	lsls r1, r1, #9
	lsls r1, r0
	lsrs r1, r1, #0x10
	ands r4, r1
	cmp r4, #0
	bne _02006144
	ldr r1, =0x04000154
	movs r0, #1
	rsbs r0, r0, #0
	str r0, [r1]
	movs r0, #0xa
	bl ErrorPrint
_02006144:
	movs r0, #3
	bl WarningPrint
	ldr r5, =gUnknown_02024960
	ldr r0, =0x0000084C
	adds r1, r5, r0
	ldr r0, [r1]
	lsls r0, r0, #8
	lsrs r0, r0, #0x10
	ldr r6, =gPlayerPartyPtr
	ldr r1, [r1]
	lsls r1, r1, #8
	lsrs r1, r1, #0x10
	movs r4, #0x64
	adds r2, r1, #0
	muls r2, r4, r2
	ldr r1, [r6]
	adds r1, r1, r2
	bl SetSpeciesCaughtFlag
	ldr r1, =0x0000084F
	adds r2, r5, r1
	ldrb r1, [r2]
	movs r0, #0x85
	lsls r0, r0, #4
	adds r3, r5, r0
	ldrb r0, [r3]
	lsls r0, r0, #8
	orrs r0, r1
	cmp r0, #0
	beq _0200619E
	ldrb r1, [r2]
	ldrb r0, [r3]
	lsls r0, r0, #8
	orrs r0, r1
	ldrb r2, [r2]
	ldrb r1, [r3]
	lsls r1, r1, #8
	orrs r1, r2
	adds r2, r1, #0
	muls r2, r4, r2
	ldr r1, [r6]
	adds r1, r1, r2
	bl SetSpeciesCaughtFlag
_0200619E:
	movs r4, #0
	ldr r1, =0x0000085C
	adds r5, r5, r1
_020061A4:
	ldr r0, =gGiftRibbonsPtr
	ldr r0, [r0]
	adds r2, r0, r4
	ldrb r0, [r2]
	cmp r0, #0
	bne _020061C4
	adds r1, r4, r5
	ldrb r0, [r1]
	cmp r0, #0
	beq _020061C4
	ldrb r0, [r1]
	strb r0, [r2]
	ldrb r1, [r1]
	adds r0, r4, #0
	bl GiveGiftRibbonToParty
_020061C4:
	adds r4, #1
	cmp r4, #0xa
	ble _020061A4
	bl sub_02005FCC
	adds r4, r0, #0
	bl GetFrameTotal
	adds r1, r0, #0
	movs r0, #0x3f
	ands r0, r1
	bl DelayFrames
	cmp r4, #1
	beq _02006222
	cmp r4, #1
	bgt _02006214
	cmp r4, #0
	beq _0200621A
	b _02006230
	.align 2, 0
	.pool
_02006214:
	cmp r4, #2
	beq _0200622A
	b _02006230
_0200621A:
	movs r0, #1
	bl WarningPrint
	b _02006230
_02006222:
	movs r0, #4
	bl WarningPrint
	b _02006230
_0200622A:
	movs r0, #5
	bl WarningPrint
_02006230:
	ldr r1, =gUnknown_02024960
	ldr r0, =0x0000084C
	adds r1, r1, r0
	ldrb r2, [r1]
	movs r0, #2
	rsbs r0, r0, #0
	ands r0, r2
	strb r0, [r1]
	ldrb r2, [r1]
	movs r0, #3
	rsbs r0, r0, #0
	ands r0, r2
	strb r0, [r1]
	ldrb r2, [r1]
	movs r0, #5
	rsbs r0, r0, #0
	ands r0, r2
	strb r0, [r1]
	adds r0, r4, #0
_02006256:
	pop {r4, r5, r6}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_02006264
sub_02006264: @ 0x02006264
	push {r4, r5, lr}
	movs r0, #3
	bl WarningPrint
	ldr r5, =gUnknown_02024960
	ldr r0, =0x0000085B
	adds r4, r5, r0
	ldrb r0, [r4]
	cmp r0, #0
	beq _020062CA
	ldr r0, =gPlayerPartyCountPtr
	ldr r1, [r0]
	ldrb r0, [r1]
	adds r0, #1
	strb r0, [r1]
	ldrb r0, [r4]
	movs r1, #1
	bl GetSetPokedexFlag
	cmp r0, #0
	bne _0200629E
	ldrb r0, [r4]
	movs r1, #2
	bl GetSetPokedexFlag
	ldrb r0, [r4]
	movs r1, #3
	bl GetSetPokedexFlag
_0200629E:
	movs r4, #0
	ldr r0, =0x0000085C
	adds r5, r5, r0
_020062A4:
	ldr r0, =gGiftRibbonsPtr
	ldr r0, [r0]
	adds r2, r0, r4
	ldrb r0, [r2]
	cmp r0, #0
	bne _020062C4
	adds r1, r4, r5
	ldrb r0, [r1]
	cmp r0, #0
	beq _020062C4
	ldrb r0, [r1]
	strb r0, [r2]
	ldrb r1, [r1]
	adds r0, r4, #0
	bl GiveGiftRibbonToParty
_020062C4:
	adds r4, #1
	cmp r4, #0xa
	ble _020062A4
_020062CA:
	bl sub_02005FCC
	adds r4, r0, #0
	cmp r4, #1
	beq _02006302
	cmp r4, #1
	bgt _020062F4
	cmp r4, #0
	beq _020062FA
	b _02006310
	.align 2, 0
	.pool
_020062F4:
	cmp r4, #2
	beq _0200630A
	b _02006310
_020062FA:
	movs r0, #1
	bl WarningPrint
	b _02006310
_02006302:
	movs r0, #4
	bl WarningPrint
	b _02006310
_0200630A:
	movs r0, #5
	bl WarningPrint
_02006310:
	ldr r1, =gUnknown_02024960
	ldr r0, =0x0000084C
	adds r1, r1, r0
	ldrb r2, [r1]
	movs r0, #2
	rsbs r0, r0, #0
	ands r0, r2
	strb r0, [r1]
	ldrb r2, [r1]
	movs r0, #3
	rsbs r0, r0, #0
	ands r0, r2
	strb r0, [r1]
	ldrb r2, [r1]
	movs r0, #5
	rsbs r0, r0, #0
	ands r0, r2
	strb r0, [r1]
	adds r0, r4, #0
	pop {r4, r5}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_02006344
sub_02006344: @ 0x02006344
	push {r4, r5, r6, lr}
	ldr r5, =gUnknown_02024960
	ldrh r0, [r5, #0x10]
	adds r6, r0, #0
	cmp r6, #0
	bne _020063EA
	ldr r0, =0x00000858
	adds r1, r5, r0
	ldrb r0, [r1]
	movs r0, #2
	strb r0, [r1]
	ldr r4, =gPlayerPartyPtr
	ldr r0, [r4]
	movs r1, #0
	movs r2, #0
	bl GetMonData
	str r0, [r5, #8]
	ldr r0, [r4]
	movs r1, #1
	movs r2, #0
	bl GetMonData
	str r0, [r5, #0xc]
	ldr r0, [r4]
	movs r1, #0xb
	movs r2, #0
	bl GetMonData
	lsls r0, r0, #0x10
	lsrs r0, r0, #0x10
	ldrh r1, [r5, #0x10]
	strh r0, [r5, #0x10]
	ldrh r0, [r5, #0x12]
	strh r6, [r5, #0x12]
	ldr r0, [r4]
	movs r1, #0
	bl GetBoxMonMoveBySlot
	ldrh r1, [r5, #0x14]
	strh r0, [r5, #0x14]
	ldr r0, [r4]
	movs r1, #1
	bl GetBoxMonMoveBySlot
	ldrh r1, [r5, #0x16]
	strh r0, [r5, #0x16]
	ldr r0, [r4]
	movs r1, #2
	bl GetBoxMonMoveBySlot
	ldrh r1, [r5, #0x18]
	strh r0, [r5, #0x18]
	ldr r0, [r4]
	movs r1, #3
	bl GetBoxMonMoveBySlot
	ldrh r1, [r5, #0x1a]
	strh r0, [r5, #0x1a]
	ldr r0, [r4]
	movs r1, #0
	bl GetBoxMonPPByMoveSlot
	ldrb r1, [r5, #0x1c]
	strb r0, [r5, #0x1c]
	ldr r0, [r4]
	movs r1, #1
	bl GetBoxMonPPByMoveSlot
	ldrb r1, [r5, #0x1d]
	strb r0, [r5, #0x1d]
	ldr r0, [r4]
	movs r1, #2
	bl GetBoxMonPPByMoveSlot
	ldrb r1, [r5, #0x1e]
	strb r0, [r5, #0x1e]
	ldr r0, [r4]
	movs r1, #3
	bl GetBoxMonPPByMoveSlot
	ldrb r1, [r5, #0x1f]
	strb r0, [r5, #0x1f]
_020063EA:
	pop {r4, r5, r6}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_020063FC
sub_020063FC: @ 0x020063FC
	ldr r1, =gUnknown_02024960
	adds r1, #0x23
	ldrb r0, [r1]
	lsls r0, r0, #0x1c
	lsrs r0, r0, #0x1c
	ldrb r1, [r1]
	lsrs r1, r1, #4
	lsls r1, r1, #0x10
	orrs r0, r1
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_02006414
sub_02006414: @ 0x02006414
	push {lr}
	adds r1, r0, #0
	ldr r0, =gUnknown_02024960
	ldrh r0, [r0, #0x20]
	bl sub_020064BC
	adds r1, r0, #0
	movs r0, #7
	ands r0, r1
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_02006430
sub_02006430: @ 0x02006430
	push {lr}
	adds r1, r0, #0
	ldr r0, =gUnknown_02024960
	ldrh r0, [r0, #0x20]
	bl sub_020064BC
	lsrs r0, r0, #3
	movs r1, #1
	ands r0, r1
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200644C
sub_0200644C: @ 0x0200644C
	ldr r0, =gUnknown_02024960
	adds r0, #0x22
	ldrb r0, [r0]
	lsls r0, r0, #0x1c
	lsrs r0, r0, #0x1c
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_0200645C
sub_0200645C: @ 0x0200645C
	ldr r0, =gUnknown_02024960
	adds r0, #0x22
	ldrb r0, [r0]
	lsrs r0, r0, #4
	adds r0, #1
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_0200646C
sub_0200646C: @ 0x0200646C
	push {lr}
	ldr r2, =gPlayerPartyPtr
	movs r1, #0x64
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	bl GetMonStatus
	movs r1, #0
	cmp r0, #7
	bne _02006484
	movs r1, #1
_02006484:
	adds r0, r1, #0
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_02006490
sub_02006490: @ 0x02006490
	ldr r1, =gUnknown_02024960
	ldrb r0, [r1, #3]
	lsls r0, r0, #0x19
	cmp r0, #0
	bne _020064A4
	movs r0, #0
	b _020064AC
	.align 2, 0
	.pool
_020064A4:
	ldrb r0, [r1, #3]
	lsls r0, r0, #0x19
	lsrs r0, r0, #0x19
	subs r0, #1
_020064AC:
	bx lr
	.align 2, 0

	thumb_func_start sub_020064B0
sub_020064B0: @ 0x020064B0
	ldr r0, =gUnknown_02024960
	ldrb r0, [r0, #3]
	lsrs r0, r0, #7
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_020064BC
sub_020064BC: @ 0x020064BC
	adds r2, r0, #0
	cmp r1, #0
	ble _020064CA
_020064C2:
	lsrs r2, r2, #4
	subs r1, #1
	cmp r1, #0
	bne _020064C2
_020064CA:
	movs r0, #0xf
	ands r0, r2
	bx lr

	thumb_func_start sub_020064D0
sub_020064D0: @ 0x020064D0
	adds r2, r0, #0
	ldr r0, =gUnknown_02024960
	ldr r0, [r0]
	lsls r0, r0, #8
	lsrs r1, r0, #8
	cmp r2, #0
	ble _020064E8
	adds r0, r2, #0
_020064E0:
	lsrs r1, r1, #4
	subs r0, #1
	cmp r0, #0
	bne _020064E0
_020064E8:
	movs r0, #0xf
	ands r1, r0
	adds r0, r1, #0
	bx lr
	.align 2, 0
	.pool

	.lcomm gUnknown_02020A38, 8
	.lcomm gScreenIsFadedOut, 1
	.lcomm _padding_02020A41, 2
	.lcomm sSomeWindowBaseBlock, 2
	.lcomm _padding_02020A46, 2
	.lcomm gUnknown_02020A48, 4
