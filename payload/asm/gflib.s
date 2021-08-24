	.include "asm/macros/function.inc"
	.include "constants/gba_constants.inc"
	.text
	.syntax unified

	thumb_func_start sub_02008D6C
sub_02008D6C: @ 0x02008D6C
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #4
	adds r4, r0, #0
	str r1, [sp]
	mov ip, r2
	ldrb r1, [r4, #0x1b]
	lsrs r0, r1, #3
	ldrb r2, [r4, #3]
	muls r0, r2, r0
	lsls r0, r0, #5
	ldr r1, [r4, #0xc]
	adds r1, r1, r0
	ldrb r2, [r4, #0x1a]
	lsrs r0, r2, #3
	lsls r0, r0, #5
	adds r3, r1, r0
	mov sl, r3
	movs r0, #7
	ands r0, r2
	movs r1, #8
	subs r0, r1, r0
	mov sb, r0
	ldrb r2, [r4, #9]
	ldr r0, [sp]
	adds r1, r0, #0
	muls r1, r2, r1
	ldr r0, [r4, #0x10]
	adds r7, r0, r1
	subs r3, #4
	movs r6, #0
	cmp r6, r2
	bge _02008E1E
	ldr r1, =gUnknown_0202135C
	mov r8, r1
_02008DB8:
	cmp r6, #8
	beq _02008DC4
	adds r3, #4
	b _02008DCC
	.align 2, 0
	.pool
_02008DC4:
	ldrb r2, [r4, #3]
	lsls r0, r2, #5
	mov r1, sl
	adds r3, r1, r0
_02008DCC:
	ldrb r0, [r7]
	mov r2, sb
	lsls r0, r2
	lsls r0, r0, #0x10
	lsrs r5, r0, #0x10
	adds r7, #1
	cmp r5, #0
	beq _02008E16
	lsrs r0, r0, #0x18
	mov r2, r8
	ldr r1, [r2]
	lsls r0, r0, #2
	adds r0, r0, r1
	ldr r2, [r0]
	lsls r1, r2, #4
	subs r1, r1, r2
	ldr r0, [r3]
	bics r0, r1
	mov r1, ip
	muls r1, r2, r1
	orrs r0, r1
	str r0, [r3]
	movs r0, #0xff
	ands r0, r5
	mov r2, r8
	ldr r1, [r2]
	lsls r0, r0, #2
	adds r0, r0, r1
	ldr r2, [r0]
	lsls r1, r2, #4
	subs r1, r1, r2
	ldr r0, [r3, #0x20]
	bics r0, r1
	mov r1, ip
	muls r1, r2, r1
	orrs r0, r1
	str r0, [r3, #0x20]
_02008E16:
	adds r6, #1
	ldrb r0, [r4, #9]
	cmp r6, r0
	blt _02008DB8
_02008E1E:
	ldrb r0, [r4, #0x1c]
	cmp r0, #0
	bne _02008E36
	ldrb r1, [r4, #0x1a]
	adds r1, #3
	ldr r0, [r4, #0x14]
	ldr r2, [sp]
	adds r0, r0, r2
	ldrb r0, [r0]
	adds r1, r0, r1
	strb r1, [r4, #0x1a]
	b _02008E3C
_02008E36:
	ldrb r1, [r4, #0x1a]
	adds r0, r0, r1
	strb r0, [r4, #0x1a]
_02008E3C:
	add sp, #4
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0

	thumb_func_start sub_02008E4C
sub_02008E4C: @ 0x02008E4C
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #0xc
	adds r4, r0, #0
	str r1, [sp]
	str r2, [sp, #4]
	mov sl, r3
	movs r0, #7
	ldrb r1, [r4, #0x1a]
	ands r0, r1
	movs r1, #8
	subs r0, r1, r0
	mov sb, r0
	ldrb r3, [r4, #9]
	ldr r2, [sp]
	adds r0, r2, #0
	muls r0, r3, r0
	lsls r0, r0, #1
	ldr r1, [r4, #0x10]
	adds r1, r1, r0
	mov ip, r1
	movs r5, #0
	mov r8, r5
	cmp r8, r3
	bge _02008F3C
_02008E84:
	ldrb r2, [r4, #0x1b]
	add r2, r8
	asrs r0, r2, #3
	ldrb r6, [r4, #3]
	muls r0, r6, r0
	lsls r0, r0, #5
	ldr r1, [r4, #0xc]
	adds r1, r1, r0
	ldrb r7, [r4, #0x1a]
	lsrs r0, r7, #3
	lsls r0, r0, #5
	adds r5, r1, r0
	movs r0, #7
	ands r2, r0
	lsls r2, r2, #2
	adds r5, r5, r2
	mov r1, ip
	ldrb r0, [r1]
	mov r1, sb
	lsls r0, r1
	lsls r1, r0, #0x10
	lsrs r6, r1, #0x10
	mov r2, ip
	adds r0, r2, r3
	ldrb r0, [r0]
	mov r3, sb
	lsls r0, r3
	lsls r3, r0, #0x10
	lsrs r7, r3, #0x10
	str r7, [sp, #8]
	movs r0, #1
	add ip, r0
	adds r0, r6, #0
	orrs r0, r7
	cmp r0, #0
	beq _02008F32
	lsrs r1, r1, #0x18
	ldr r7, =gUnknown_0202135C
	ldr r2, [r7]
	lsls r1, r1, #2
	adds r1, r1, r2
	lsrs r0, r3, #0x18
	lsls r0, r0, #2
	adds r0, r0, r2
	ldr r2, [r1]
	ldr r3, [r0]
	adds r0, r2, #0
	orrs r0, r3
	lsls r1, r0, #4
	subs r1, r1, r0
	ldr r0, [r5]
	bics r0, r1
	ldr r7, [sp, #4]
	adds r1, r2, #0
	muls r1, r7, r1
	orrs r0, r1
	mov r1, sl
	muls r1, r3, r1
	orrs r0, r1
	str r0, [r5]
	adds r1, r6, #0
	movs r0, #0xff
	ands r1, r0
	ldr r3, =gUnknown_0202135C
	ldr r2, [r3]
	lsls r1, r1, #2
	adds r1, r1, r2
	ldr r0, [sp, #8]
	movs r6, #0xff
	ands r0, r6
	lsls r0, r0, #2
	adds r0, r0, r2
	ldr r2, [r1]
	ldr r3, [r0]
	adds r0, r2, #0
	orrs r0, r3
	lsls r1, r0, #4
	subs r1, r1, r0
	ldr r0, [r5, #0x20]
	bics r0, r1
	adds r1, r2, #0
	muls r1, r7, r1
	orrs r0, r1
	mov r1, sl
	muls r1, r3, r1
	orrs r0, r1
	str r0, [r5, #0x20]
_02008F32:
	movs r7, #1
	add r8, r7
	ldrb r3, [r4, #9]
	cmp r8, r3
	blt _02008E84
_02008F3C:
	ldrb r0, [r4, #0x1c]
	cmp r0, #0
	bne _02008F54
	ldr r0, [r4, #0x14]
	ldr r1, [sp]
	adds r0, r0, r1
	ldrb r2, [r4, #0x1a]
	ldrb r0, [r0]
	adds r0, r2, r0
	b _02008F58
	.align 2, 0
	.pool
_02008F54:
	ldrb r3, [r4, #0x1a]
	adds r0, r0, r3
_02008F58:
	strb r0, [r4, #0x1a]
	add sp, #0xc
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start sub_02008F6C
sub_02008F6C: @ 0x02008F6C
	push {r4, r5, r6, r7, lr}
	mov r7, r8
	push {r7}
	lsls r0, r0, #5
	ldr r2, =gUnknown_02022C30
	adds r3, r0, r2
	ldrb r0, [r1]
	strb r0, [r3]
	ldrb r0, [r1, #9]
	strb r0, [r3, #9]
	ldrb r0, [r1, #1]
	strb r0, [r3, #1]
	ldrb r0, [r1, #2]
	strb r0, [r3, #2]
	ldrb r0, [r1, #3]
	strb r0, [r3, #3]
	ldrb r0, [r1, #4]
	strb r0, [r3, #4]
	ldrh r0, [r1, #6]
	movs r2, #0
	strh r0, [r3, #6]
	ldrb r0, [r1, #8]
	strb r0, [r3, #8]
	ldr r0, [r1, #0xc]
	str r0, [r3, #0xc]
	ldr r0, [r1, #0x10]
	str r0, [r3, #0x10]
	ldr r0, [r1, #0x14]
	str r0, [r3, #0x14]
	strb r2, [r3, #0x1b]
	strb r2, [r3, #0x1a]
	ldr r0, [r1, #0x10]
	str r0, [r3, #0x10]
	ldr r0, [r1, #0x14]
	str r0, [r3, #0x14]
	strb r2, [r3, #0x19]
	strb r2, [r3, #0x1c]
	strb r2, [r3, #0x1d]
	ldrb r1, [r3]
	lsls r0, r1, #0xc
	movs r2, #0xc0
	lsls r2, r2, #0x12
	adds r2, r2, r0
	mov r8, r2
	ldrh r5, [r3, #6]
	ldrb r4, [r3, #2]
	ldrb r7, [r3, #4]
	adds r0, r7, r4
	ldr r1, =gBgTilemapBufferTransferScheduled
	mov ip, r1
	cmp r4, r0
	bge _02009010
_02008FD4:
	ldrb r2, [r3, #1]
	ldrb r7, [r3, #3]
	adds r0, r7, r2
	adds r6, r4, #1
	cmp r2, r0
	bge _02009004
	lsls r1, r2, #1
	lsls r0, r4, #6
	add r0, r8
	adds r1, r1, r0
_02008FE8:
	ldrb r4, [r3, #8]
	lsls r0, r4, #0xc
	orrs r0, r5
	strh r0, [r1]
	adds r0, r5, #1
	lsls r0, r0, #0x10
	lsrs r5, r0, #0x10
	adds r1, #2
	adds r2, #1
	ldrb r7, [r3, #3]
	ldrb r4, [r3, #1]
	adds r0, r7, r4
	cmp r2, r0
	blt _02008FE8
_02009004:
	adds r4, r6, #0
	ldrb r7, [r3, #4]
	ldrb r1, [r3, #2]
	adds r0, r7, r1
	cmp r4, r0
	blt _02008FD4
_02009010:
	ldrb r1, [r3]
	add r1, ip
	movs r0, #1
	strb r0, [r1]
	adds r0, r3, #0
	pop {r3}
	mov r8, r3
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200902C
sub_0200902C: @ 0x0200902C
	push {r4, lr}
	adds r3, r0, #0
	ldr r0, =gUnknown_0202135C
	str r3, [r0]
	movs r2, #0
	movs r4, #0x10
_02009038:
	movs r0, #0x80
	ands r0, r2
	rsbs r0, r0, #0
	lsrs r1, r0, #0x1f
	movs r0, #0x40
	ands r0, r2
	cmp r0, #0
	beq _0200904A
	orrs r1, r4
_0200904A:
	movs r0, #0x20
	ands r0, r2
	cmp r0, #0
	beq _02009058
	movs r0, #0x80
	lsls r0, r0, #1
	orrs r1, r0
_02009058:
	adds r0, r2, #0
	ands r0, r4
	cmp r0, #0
	beq _02009066
	movs r0, #0x80
	lsls r0, r0, #5
	orrs r1, r0
_02009066:
	movs r0, #8
	ands r0, r2
	cmp r0, #0
	beq _02009074
	movs r0, #0x80
	lsls r0, r0, #9
	orrs r1, r0
_02009074:
	movs r0, #4
	ands r0, r2
	cmp r0, #0
	beq _02009082
	movs r0, #0x80
	lsls r0, r0, #0xd
	orrs r1, r0
_02009082:
	movs r0, #2
	ands r0, r2
	cmp r0, #0
	beq _02009090
	movs r0, #0x80
	lsls r0, r0, #0x11
	orrs r1, r0
_02009090:
	movs r0, #1
	ands r0, r2
	cmp r0, #0
	beq _0200909E
	movs r0, #0x80
	lsls r0, r0, #0x15
	orrs r1, r0
_0200909E:
	stm r3!, {r1}
	adds r2, #1
	cmp r2, #0xff
	ble _02009038
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_020090B0
sub_020090B0: @ 0x020090B0
	push {r4, lr}
	sub sp, #4
	adds r4, r0, #0
	mov r0, sp
	strh r1, [r0]
	ldr r1, [r4, #0xc]
	ldrb r0, [r4, #4]
	ldrb r3, [r4, #3]
	adds r2, r0, #0
	muls r2, r3, r2
	lsls r2, r2, #4
	movs r0, #0x80
	lsls r0, r0, #0x11
	orrs r2, r0
	mov r0, sp
	bl CpuSet
	adds r0, r4, #0
	movs r1, #0
	movs r2, #0
	bl sub_02009164
	add sp, #4
	pop {r4}
	pop {r0}
	bx r0

	thumb_func_start sub_020090E4
sub_020090E4: @ 0x020090E4
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #4
	adds r6, r0, #0
	mov sb, r1
	adds r7, r2, #0
	ldr r0, [sp, #0x24]
	mov r8, r0
	adds r4, r7, #0
	adds r0, r4, r0
	cmp r4, r0
	bge _02009136
	lsls r5, r3, #4
	ldr r0, =0x001FFFFF
	ands r5, r0
	movs r1, #0x80
	lsls r1, r1, #0x11
	mov sl, r1
_0200910E:
	mov r0, sp
	ldrh r2, [r0, #0x28]
	strh r2, [r0]
	ldrb r1, [r6, #3]
	adds r0, r1, #0
	muls r0, r4, r0
	add r0, sb
	lsls r0, r0, #5
	ldr r1, [r6, #0xc]
	adds r1, r1, r0
	mov r0, sp
	mov r2, sl
	orrs r2, r5
	bl CpuSet
	adds r4, #1
	mov r2, r8
	adds r0, r7, r2
	cmp r4, r0
	blt _0200910E
_02009136:
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

	thumb_func_start sub_0200914C
sub_0200914C: @ 0x0200914C
	strb r1, [r0, #0x18]
	strb r2, [r0, #0x19]
	bx lr
	.align 2, 0

	thumb_func_start sub_02009154
sub_02009154: @ 0x02009154
	ldrb r1, [r0, #0x1d]
	strb r1, [r0, #0x1a]
	ldrb r2, [r0, #0x1b]
	ldrb r3, [r0, #9]
	adds r1, r2, r3
	strb r1, [r0, #0x1b]
	bx lr
	.align 2, 0

	thumb_func_start sub_02009164
sub_02009164: @ 0x02009164
	strb r1, [r0, #0x1a]
	strb r2, [r0, #0x1b]
	bx lr
	.align 2, 0

	thumb_func_start sub_0200916C
sub_0200916C: @ 0x0200916C
	ldrb r3, [r0, #0x1a]
	adds r1, r3, r1
	strb r1, [r0, #0x1a]
	ldrb r1, [r0, #0x1b]
	adds r2, r1, r2
	strb r2, [r0, #0x1b]
	bx lr
	.align 2, 0

	thumb_func_start sub_0200917C
sub_0200917C: @ 0x0200917C
	push {r4, r5, lr}
	adds r4, r0, #0
	adds r5, r1, #0
	b _020091A4
_02009184:
	ldrb r0, [r4, #0x19]
	cmp r0, #0
	bne _02009196
	ldrb r1, [r5]
	ldrb r2, [r4, #0x18]
	adds r0, r4, #0
	bl sub_02008D6C
	b _020091A2
_02009196:
	ldrb r1, [r5]
	ldrb r2, [r4, #0x18]
	ldrb r3, [r4, #0x19]
	adds r0, r4, #0
	bl sub_02008E4C
_020091A2:
	adds r5, #1
_020091A4:
	ldrb r0, [r5]
	cmp r0, #0
	bne _02009184
	pop {r4, r5}
	pop {r0}
	bx r0

	thumb_func_start sub_020091B0
sub_020091B0: @ 0x020091B0
	push {r4, r5, r6, r7, lr}
	mov r7, sb
	mov r6, r8
	push {r6, r7}
	adds r4, r0, #0
	ldrb r0, [r4]
	lsls r1, r0, #0xc
	movs r0, #0xc0
	lsls r0, r0, #0x12
	adds r1, r1, r0
	mov ip, r1
	ldrh r5, [r4, #6]
	ldrb r3, [r4, #2]
	ldrb r1, [r4, #4]
	adds r0, r1, r3
	ldr r7, =gBgTilemapBufferTransferScheduled
	mov r8, r7
	cmp r3, r0
	bge _0200920E
	mov sb, r0
_020091D8:
	ldrb r2, [r4, #1]
	ldrb r1, [r4, #3]
	adds r0, r1, r2
	adds r6, r3, #1
	cmp r2, r0
	bge _02009208
	lsls r1, r2, #1
	lsls r0, r3, #6
	add r0, ip
	adds r1, r1, r0
_020091EC:
	ldrb r3, [r4, #8]
	lsls r0, r3, #0xc
	orrs r0, r5
	strh r0, [r1]
	adds r0, r5, #1
	lsls r0, r0, #0x10
	lsrs r5, r0, #0x10
	adds r1, #2
	adds r2, #1
	ldrb r7, [r4, #3]
	ldrb r3, [r4, #1]
	adds r0, r7, r3
	cmp r2, r0
	blt _020091EC
_02009208:
	adds r3, r6, #0
	cmp r3, sb
	blt _020091D8
_0200920E:
	ldrb r1, [r4]
	add r1, r8
	movs r0, #1
	strb r0, [r1]
	pop {r3, r4}
	mov r8, r3
	mov sb, r4
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
