	.include "asm/macros/function.inc"
	.text
	.syntax unified

	thumb_func_start sub_0200F324
sub_0200F324: @ 0x0200F324
	push {r7, lr}
	sub sp, #4
	mov r7, sp
	adds r1, r7, #0
	strb r0, [r1]
	b _0200F330
_0200F330:
	add sp, #4
	pop {r7}
	pop {r0}
	bx r0

	thumb_func_start sub_0200F338
sub_0200F338: @ 0x0200F338
	push {r7, lr}
	mov r7, sp
	b _0200F33E
_0200F33E:
	pop {r7}
	pop {r0}
	bx r0

	thumb_func_start sub_0200F344
sub_0200F344: @ 0x0200F344
	push {r7, lr}
	mov r7, sp
	b _0200F34A
_0200F34A:
	pop {r7}
	pop {r0}
	bx r0

	thumb_func_start sub_0200F350
sub_0200F350: @ 0x0200F350
	push {r7, lr}
	sub sp, #4
	mov r7, sp
	adds r1, r7, #0
	strh r0, [r1]
	adds r0, r7, #0
	ldrh r1, [r0]
	ldr r0, =0x00003FFF
	cmp r1, r0
	bhi _0200F36C
	movs r0, #0
	b _0200F398
	.align 2, 0
	.pool
_0200F36C:
	adds r0, r7, #0
	movs r2, #0
	ldrsh r1, [r0, r2]
	cmp r1, #0
	blt _0200F394
	ldr r0, =gUnknown_02022EE4
	adds r1, r7, #0
	ldrh r2, [r1]
	adds r1, r2, #0
	lsls r2, r1, #1
	ldr r3, =0xFFFF8000
	adds r1, r2, r3
	ldr r0, [r0]
	adds r1, r1, r0
	adds r0, r1, #0
	b _0200F398
	.align 2, 0
	.pool
_0200F394:
	movs r0, #0
	b _0200F398
_0200F398:
	add sp, #4
	pop {r7}
	pop {r1}
	bx r1

	thumb_func_start sub_0200F3A0
sub_0200F3A0: @ 0x0200F3A0
	push {r7, lr}
	sub sp, #8
	mov r7, sp
	ldr r1, =0x000040C2
	adds r0, r1, #0
	bl sub_0200F350
	str r0, [r7, #4]
	adds r1, r7, #0
	adds r0, r1, #0
	bl rtc_maincb_is_time_since_last_berry_update_positive
	ldr r1, [r7, #4]
	ldrh r0, [r1]
	ldr r1, =gRtcUTCTime
	movs r3, #0
	ldrsh r2, [r1, r3]
	cmp r0, r2
	bgt _0200F3D6
	movs r0, #1
	b _0200F3DA
	.align 2, 0
	.pool
_0200F3D4: @ 0x0200F3D4
	b _0200F3DA
_0200F3D6:
	movs r0, #0
	b _0200F3DA
_0200F3DA:
	add sp, #8
	pop {r7}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_0200F3E4
sub_0200F3E4: @ 0x0200F3E4
	push {r7, lr}
	sub sp, #8
	mov r7, sp
	bl sub_0200F3A0
	cmp r0, #1
	bne _0200F3F6
	movs r0, #1
	b _0200F434
_0200F3F6:
	adds r1, r7, #4
	adds r0, r1, #0
	bl rtc_maincb_is_time_since_last_berry_update_positive
	ldr r0, =gRtcUTCTime
	movs r2, #0
	ldrsh r1, [r0, r2]
	cmp r1, #0
	bge _0200F410
	movs r0, #0
	b _0200F434
	.align 2, 0
	.pool
_0200F410:
	ldr r1, =0x000040C2
	adds r0, r1, #0
	bl sub_0200F350
	str r0, [r7]
	ldr r0, [r7]
	movs r1, #1
	strh r1, [r0]
	bl sub_02009EC8
	cmp r0, #1
	beq _0200F430
	movs r0, #0
	b _0200F434
	.align 2, 0
	.pool
_0200F430:
	movs r0, #1
	b _0200F434
_0200F434:
	add sp, #8
	pop {r7}
	pop {r1}
	bx r1
