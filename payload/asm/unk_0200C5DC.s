	.include "asm/macros/function.inc"
	.include "constants/gba_constants.inc"
	.text
	.syntax unified

	


	thumb_func_start sub_0200D924
sub_0200D924: @ 0x0200D924
	push {r4, r5, r6, lr}
	adds r4, r0, #0
	ldr r0, =0x04000208
	ldrh r1, [r0]
	adds r6, r1, #0
	movs r1, #0
	strh r1, [r0]
	movs r1, #0
	ldr r3, =gUnknown_020251F0
	movs r2, #0
_0200D938:
	adds r0, r1, r3
	strb r2, [r0]
	adds r1, #1
	cmp r1, #0x33
	bls _0200D938
	ldr r5, =gUnknown_020251F0
	ldrb r0, [r5, #0x12]
	movs r0, #1
	strb r0, [r5, #0x12]
	bl sub_0200D8A4
	ldr r2, =0x04000200
	ldrh r0, [r2]
	movs r1, #0x80
	orrs r0, r1
	strh r0, [r2]
	ldrb r0, [r4]
	cmp r0, #0x54
	bne _0200D988
	ldrb r1, [r4, #1]
	cmp r1, #0x45
	bne _0200D988
	ldrb r3, [r4, #2]
	cmp r3, #0x53
	bne _0200D988
	ldrb r0, [r4, #3]
	cmp r0, #0x54
	bne _0200D988
	ldrb r0, [r5, #0xe]
	movs r0, #0xfe
	strb r0, [r5, #0xe]
	adds r2, r5, #0
	b _0200D992
	.align 2, 0
	.pool
_0200D988:
	ldr r0, =gUnknown_020251F0
	ldrb r1, [r0, #0xe]
	movs r1, #0x28
	strb r1, [r0, #0xe]
	adds r2, r0, #0
_0200D992:
	ldrb r1, [r4, #3]
	lsls r0, r1, #0x18
	ldrb r3, [r4, #2]
	lsls r1, r3, #0x10
	orrs r0, r1
	ldrb r3, [r4, #1]
	lsls r1, r3, #8
	orrs r0, r1
	ldrb r1, [r4]
	orrs r0, r1
	str r0, [r2, #0x20]
	ldr r0, [r2, #0x20]
	str r0, [r2, #0x2c]
	ldr r0, [r2, #0x20]
	ldr r1, =0x20202020
	orrs r0, r1
	str r0, [r2, #0x28]
	ldrb r3, [r4, #4]
	lsls r0, r3, #0x18
	ldrb r3, [r4, #5]
	lsls r1, r3, #0x10
	orrs r0, r1
	ldrb r3, [r4, #6]
	lsls r1, r3, #8
	orrs r0, r1
	ldrb r4, [r4, #7]
	orrs r0, r4
	str r0, [r2, #0x30]
	ldr r1, =sub_0200D80C
	movs r0, #0
	bl SetIntrFunc
	ldr r0, =0x04000208
	strh r6, [r0]
	pop {r4, r5, r6}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_0200D9EC
sub_0200D9EC: @ 0x0200D9EC
	push {lr}
	ldr r0, =0x080000B2
	ldrb r0, [r0]
	cmp r0, #0x96
	beq _0200D9FC
	movs r0, #0
	bl SoftReset
_0200D9FC:
	ldr r3, =gUnknown_020251F0
	ldrb r1, [r3, #0xf]
	ldrb r0, [r3, #0xe]
	cmp r1, r0
	bhi _0200DA28
	ldr r1, =0x04000208
	movs r0, #0
	strh r0, [r1]
	ldrb r0, [r3, #0xf]
	adds r0, #1
	ldrb r2, [r3, #0xf]
	strb r0, [r3, #0xf]
	movs r0, #1
	strh r0, [r1]
	movs r0, #0
	b _0200DA34
	.align 2, 0
	.pool
_0200DA28:
	ldrb r0, [r3, #0x10]
	movs r0, #1
	strb r0, [r3, #0x10]
	movs r0, #0
	bl SoftReset
_0200DA34:
	pop {r1}
	bx r1

	thumb_func_start sub_0200DA38
sub_0200DA38: @ 0x0200DA38
	adds r3, r0, #0
	cmp r2, #0
	beq _0200DA4C
_0200DA3E:
	ldrb r0, [r1]
	strb r0, [r3]
	adds r1, #1
	adds r3, #1
	subs r2, #1
	cmp r2, #0
	bne _0200DA3E
_0200DA4C:
	bx lr
	.align 2, 0
