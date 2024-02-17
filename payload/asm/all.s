	.include "asm/macros/function.inc"
	.text
	.syntax unified
	.equ SE_SELECT,  0
	.equ SE_FAILURE, 1


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
	ldr r0, =0x02020A48
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
	ldr r0, =0x02020A48
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
	ldr r0, =0x02020A48
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
	ldr r0, =0x02020A48
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
	ldr r0, =0x02020A48
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

	thumb_func_start IsMonFainted
IsMonFainted: @ 0x0200646C
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
