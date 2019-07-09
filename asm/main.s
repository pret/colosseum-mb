	.include "asm/macros/function.inc"
	.include "constants/gba_constants.inc"
	.text
	.syntax unified

	thumb_func_start sub_020088E8
sub_020088E8: @ 0x020088E8
	push {r4, lr}
	lsls r0, r0, #0xc
	lsls r2, r2, #6
	movs r4, #0xc0
	lsls r4, r4, #0x12
	adds r2, r2, r4
	adds r0, r0, r2
	lsls r1, r1, #1
	adds r0, r0, r1
	strh r3, [r0]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start sub_02008904
sub_02008904: @ 0x02008904
	push {r4, r5, r6, lr}
	adds r5, r3, #0
	ldr r4, [sp, #0x10]
	ldr r3, [sp, #0x14]
	lsls r3, r3, #0x10
	lsrs r3, r3, #0x10
	lsls r0, r0, #0xc
	lsls r2, r2, #6
	movs r6, #0xc0
	lsls r6, r6, #0x12
	adds r2, r2, r6
	adds r0, r0, r2
	lsls r1, r1, #1
	adds r0, r0, r1
	cmp r4, #0
	beq _02008940
_02008924:
	adds r2, r0, #0
	adds r2, #0x40
	subs r4, #1
	cmp r5, #0
	ble _0200893A
	adds r1, r5, #0
_02008930:
	strh r3, [r0]
	adds r0, #2
	subs r1, #1
	cmp r1, #0
	bne _02008930
_0200893A:
	adds r0, r2, #0
	cmp r4, #0
	bne _02008924
_02008940:
	pop {r4, r5, r6}
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start sub_02008948
sub_02008948: @ 0x02008948
	push {r4, r5, r6, r7, lr}
	mov ip, r3
	ldr r6, [sp, #0x14]
	ldr r4, [sp, #0x18]
	ldr r3, [sp, #0x1c]
	lsls r0, r0, #0xc
	lsls r2, r2, #6
	movs r5, #0xc0
	lsls r5, r5, #0x12
	adds r2, r2, r5
	adds r2, r0, r2
	lsls r1, r1, #1
	adds r2, r2, r1
	lsls r3, r3, #6
	adds r3, r3, r5
	adds r0, r0, r3
	lsls r4, r4, #1
	adds r0, r0, r4
	cmp r6, #0
	beq _0200899C
_02008970:
	adds r5, r2, #0
	adds r5, #0x40
	adds r7, r0, #0
	adds r7, #0x40
	subs r4, r6, #1
	mov r1, ip
	cmp r1, #0
	ble _02008992
	adds r1, r0, #0
	mov r3, ip
_02008984:
	ldrh r0, [r2]
	strh r0, [r1]
	adds r2, #2
	adds r1, #2
	subs r3, #1
	cmp r3, #0
	bne _02008984
_02008992:
	adds r2, r5, #0
	adds r0, r7, #0
	adds r6, r4, #0
	cmp r6, #0
	bne _02008970
_0200899C:
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start sub_020089A4
sub_020089A4: @ 0x020089A4
	ldr r3, =gUnknown_02022C10
	lsls r0, r0, #1
	adds r3, r0, r3
	strh r1, [r3]
	ldr r1, =gUnknown_02022C18
	adds r0, r0, r1
	strh r2, [r0]
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_020089BC
sub_020089BC: @ 0x020089BC
	push {r4, r5, lr}
	ldrb r2, [r0, #1]
	strb r2, [r1, #1]
	ldr r5, =gUnknown_02020CD0
	subs r4, r0, r5
	lsls r3, r4, #3
	subs r3, r3, r4
	lsls r2, r3, #6
	adds r3, r3, r2
	lsls r3, r3, #3
	adds r3, r3, r4
	lsls r2, r3, #0xf
	subs r2, r2, r3
	lsls r2, r2, #3
	adds r2, r2, r4
	asrs r2, r2, #2
	strb r2, [r1]
	ldrb r2, [r0, #1]
	lsls r4, r2, #3
	adds r4, r4, r2
	lsls r4, r4, #2
	adds r4, r4, r5
	subs r1, r1, r5
	lsls r3, r1, #3
	subs r3, r3, r1
	lsls r2, r3, #6
	adds r3, r3, r2
	lsls r3, r3, #3
	adds r3, r3, r1
	lsls r2, r3, #0xf
	subs r2, r2, r3
	lsls r2, r2, #3
	adds r2, r2, r1
	asrs r2, r2, #2
	strb r2, [r4]
	strb r2, [r0, #1]
	pop {r4, r5}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02008A10
sub_02008A10: @ 0x02008A10
	push {r4, r5, r6, r7, lr}
	mov r7, r8
	push {r7}
	adds r5, r0, #0
	adds r6, r1, #0
	mov r8, r2
	ldr r0, =gUnknown_02020CD0
	ldrb r2, [r0, #1]
	lsls r1, r2, #3
	adds r1, r1, r2
	lsls r1, r1, #2
	adds r7, r1, r0
	ldrb r2, [r7]
	lsls r1, r2, #3
	adds r1, r1, r2
	lsls r1, r1, #2
	adds r1, r1, r0
	ldrb r2, [r7, #1]
	movs r4, #0
	strb r2, [r1, #1]
	ldrb r2, [r7, #1]
	lsls r1, r2, #3
	adds r1, r1, r2
	lsls r1, r1, #2
	adds r1, r1, r0
	ldrb r2, [r7]
	strb r2, [r1]
	adds r0, #0x24
	adds r1, r7, #0
	bl sub_020089BC
	movs r0, #0
	strh r5, [r7, #8]
	strh r6, [r7, #0xa]
	mov r1, r8
	str r1, [r7, #0xc]
	strb r0, [r7, #2]
	strh r4, [r7, #4]
	strh r4, [r7, #6]
	str r4, [r7, #0x10]
	movs r2, #0
	movs r1, #3
	adds r0, r7, #0
	adds r0, #0x20
_02008A68:
	str r2, [r0]
	subs r0, #4
	subs r1, #1
	cmp r1, #0
	bge _02008A68
	adds r0, r7, #0
	pop {r3}
	mov r8, r3
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_02008A84
sub_02008A84: @ 0x02008A84
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	adds r6, r0, #0
	ldr r1, =gUnknown_02020F58
	movs r2, #0x80
	lsls r2, r2, #3
	adds r0, r1, r2
	ldrb r0, [r0]
	mov ip, r0
	lsls r0, r0, #3
	adds r7, r0, r1
	ldr r4, [r6, #0xc]
	ldr r2, [r4]
	ldr r0, =0x0000FFFF
	mov sl, r1
	cmp r2, r0
	bne _02008AAE
	b _02008BDC
_02008AAE:
	mov r0, ip
	cmp r0, #0x80
	bne _02008AB6
	b _02008BE6
_02008AB6:
	movs r2, #4
	ldrsh r1, [r4, r2]
	movs r2, #8
	ldrsh r0, [r6, r2]
	adds r5, r1, r0
	cmp r5, #0xef
	ble _02008AC6
	b _02008BD0
_02008AC6:
	movs r0, #6
	ldrsh r1, [r4, r0]
	movs r2, #0xa
	ldrsh r0, [r6, r2]
	adds r3, r1, r0
	cmp r3, #0x9f
	ble _02008AD6
	b _02008BD0
_02008AD6:
	ldr r0, [r4]
	movs r1, #0xc0
	lsls r1, r1, #8
	ands r1, r0
	lsrs r1, r1, #0xc
	lsrs r2, r0, #0x1e
	adds r2, r1, r2
	mov r8, r0
	cmp r2, #0xb
	bhi _02008B40
	lsls r0, r2, #2
	ldr r1, =_02008B00
	adds r0, r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
	.pool
_02008B00: @ jump table
	.4byte _02008B30 @ case 0
	.4byte _02008B34 @ case 1
	.4byte _02008B38 @ case 2
	.4byte _02008B3C @ case 3
	.4byte _02008B34 @ case 4
	.4byte _02008B38 @ case 5
	.4byte _02008B38 @ case 6
	.4byte _02008B3C @ case 7
	.4byte _02008B30 @ case 8
	.4byte _02008B30 @ case 9
	.4byte _02008B34 @ case 10
	.4byte _02008B38 @ case 11
_02008B30:
	movs r0, #8
	b _02008B42
_02008B34:
	movs r0, #0x10
	b _02008B42
_02008B38:
	movs r0, #0x20
	b _02008B42
_02008B3C:
	movs r0, #0x40
	b _02008B42
_02008B40:
	movs r0, #0
_02008B42:
	adds r0, r5, r0
	cmp r0, #0
	blt _02008BD0
	cmp r2, #0xb
	bhi _02008BA0
	lsls r0, r2, #2
	ldr r1, =_02008B5C
	adds r0, r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
	.pool
_02008B5C: @ jump table
	.4byte _02008B8C @ case 0
	.4byte _02008B90 @ case 1
	.4byte _02008B96 @ case 2
	.4byte _02008B9C @ case 3
	.4byte _02008B8C @ case 4
	.4byte _02008B8C @ case 5
	.4byte _02008B90 @ case 6
	.4byte _02008B96 @ case 7
	.4byte _02008B90 @ case 8
	.4byte _02008B96 @ case 9
	.4byte _02008B96 @ case 10
	.4byte _02008B9C @ case 11
_02008B8C:
	movs r0, #8
	b _02008B9E
_02008B90:
	movs r1, #0x10
	mov sb, r1
	b _02008BA0
_02008B96:
	movs r2, #0x20
	mov sb, r2
	b _02008BA0
_02008B9C:
	movs r0, #0x40
_02008B9E:
	mov sb, r0
_02008BA0:
	mov r1, sb
	adds r0, r3, r1
	cmp r0, #0
	blt _02008BD0
	ldr r0, =0x000001FF
	ands r5, r0
	movs r0, #0xff
	ands r3, r0
	lsls r0, r5, #0x10
	mov r2, r8
	orrs r0, r2
	orrs r3, r0
	str r3, [r7]
	ldr r0, =0x00000FFF
	ldrh r1, [r4, #8]
	ands r0, r1
	ldrh r2, [r6, #4]
	orrs r0, r2
	ldrh r1, [r6, #6]
	adds r0, r1, r0
	strh r0, [r7, #4]
	adds r7, #8
	movs r2, #1
	add ip, r2
_02008BD0:
	adds r4, #0xc
	ldr r1, [r4]
	ldr r0, =0x0000FFFF
	cmp r1, r0
	beq _02008BDC
	b _02008AAE
_02008BDC:
	movs r0, #0x80
	lsls r0, r0, #3
	add r0, sl
	mov r1, ip
	strb r1, [r0]
_02008BE6:
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02008C00
sub_02008C00: @ 0x02008C00
	push {r4, r5, lr}
	ldr r0, =gUnknown_02020CD0
	adds r0, #0x25
	ldrb r1, [r0]
	cmp r1, #1
	beq _02008C38
_02008C0C:
	lsls r0, r1, #3
	adds r0, r0, r1
	lsls r0, r0, #2
	ldr r1, =gUnknown_02020CD0
	adds r4, r0, r1
	ldr r1, [r4, #0x10]
	cmp r1, #0
	beq _02008C22
	adds r0, r4, #0
	bl _call_via_r1
_02008C22:
	movs r0, #1
	ldrb r1, [r4, #2]
	ands r0, r1
	cmp r0, #0
	bne _02008C32
	adds r0, r4, #0
	bl sub_02008A84
_02008C32:
	ldrb r1, [r4, #1]
	cmp r1, #1
	bne _02008C0C
_02008C38:
	ldr r1, =gUnknown_02020F58
	movs r2, #0x80
	lsls r2, r2, #3
	adds r0, r1, r2
	ldrb r2, [r0]
	lsls r0, r2, #3
	adds r0, r0, r1
	cmp r2, #0x7f
	bgt _02008C66
	movs r3, #0x80
	lsls r3, r3, #2
	ldrh r4, [r0]
	cmp r4, r3
	beq _02008C66
	adds r4, r3, #0
_02008C56:
	strh r4, [r0]
	adds r2, #1
	adds r0, #8
	cmp r2, #0x7f
	bgt _02008C66
	ldrh r5, [r0]
	cmp r5, r3
	bne _02008C56
_02008C66:
	movs r0, #0x80
	lsls r0, r0, #3
	adds r1, r1, r0
	movs r0, #0
	strb r0, [r1]
	pop {r4, r5}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02008C80
sub_02008C80: @ 0x02008C80
	push {r4, r5, r6, lr}
	sub sp, #4
	mov r0, sp
	movs r5, #0
	strh r5, [r0]
	ldr r4, =gUnknown_02020CD0
	ldr r2, =0x01000144
	adds r1, r4, #0
	bl CpuSet
	strb r5, [r4, #1]
	strb r5, [r4]
	adds r0, r4, #0
	adds r0, #0x25
	movs r1, #1
	strb r1, [r0]
	subs r0, #1
	strb r1, [r0]
	adds r6, r4, #0
	adds r4, #0x48
	movs r5, #0xf
_02008CAA:
	adds r0, r6, #0
	adds r1, r4, #0
	bl sub_020089BC
	adds r4, #0x24
	subs r5, #1
	cmp r5, #0
	bge _02008CAA
	ldr r2, =gUnknown_02020F58
	movs r0, #0x80
	lsls r0, r0, #3
	adds r1, r2, r0
	movs r0, #0
	strb r0, [r1]
	movs r1, #0x80
	lsls r1, r1, #2
	adds r0, r1, #0
	movs r5, #0x7f
_02008CCE:
	strh r0, [r2]
	subs r5, #1
	adds r2, #8
	cmp r5, #0
	bge _02008CCE
	add sp, #4
	pop {r4, r5, r6}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02008CEC
sub_02008CEC: @ 0x02008CEC
	push {lr}
	adds r1, r0, #0
	ldr r0, =gUnknown_02020CD0
	ldrb r3, [r1]
	lsls r2, r3, #3
	adds r2, r2, r3
	lsls r2, r2, #2
	adds r2, r2, r0
	ldrb r3, [r1, #1]
	strb r3, [r2, #1]
	ldrb r3, [r1, #1]
	lsls r2, r3, #3
	adds r2, r2, r3
	lsls r2, r2, #2
	adds r2, r2, r0
	ldrb r3, [r1]
	strb r3, [r2]
	bl sub_020089BC
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02008D1C
sub_02008D1C: @ 0x02008D1C
	ldr r1, =0x040000D4
	ldr r0, =gUnknown_02020F58
	str r0, [r1]
	movs r0, #0xe0
	lsls r0, r0, #0x13
	str r0, [r1, #4]
	ldr r0, =0x84000100
	str r0, [r1, #8]
	ldr r0, [r1, #8]
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_02008D3C
sub_02008D3C: @ 0x02008D3C
	strh r1, [r0, #8]
	strh r2, [r0, #0xa]
	bx lr
	.align 2, 0

	thumb_func_start sub_02008D44
sub_02008D44: @ 0x02008D44
	ldrh r3, [r0, #8]
	adds r1, r3, r1
	strh r1, [r0, #8]
	ldrh r1, [r0, #0xa]
	adds r2, r1, r2
	strh r2, [r0, #0xa]
	bx lr
	.align 2, 0

	thumb_func_start sub_02008D54
sub_02008D54: @ 0x02008D54
	lsls r1, r1, #0xc
	strh r1, [r0, #4]
	bx lr
	.align 2, 0

	thumb_func_start sub_02008D5C
sub_02008D5C: @ 0x02008D5C
	strh r1, [r0, #6]
	bx lr

	thumb_func_start sub_02008D60
sub_02008D60: @ 0x02008D60
	movs r2, #0xfe
	ldrb r3, [r0, #2]
	ands r2, r3
	orrs r2, r1
	strb r2, [r0, #2]
	bx lr

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
	ldr r1, =gUnknown_02022C20
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
	ldr r7, =gUnknown_02022C20
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

	thumb_func_start sub_02009228
sub_02009228: @ 0x02009228
	ldr r2, =gUnknown_02022EB8
	ldr r0, =0x04000130
	ldrh r1, [r0]
	ldr r3, =0x000003FF
	adds r0, r3, #0
	adds r3, r0, #0
	eors r3, r1
	adds r0, r3, #0
	ldrh r1, [r2]
	bics r0, r1
	ldr r1, =gUnknown_02022EB0
	strh r0, [r1]
	ldrh r0, [r2]
	cmp r0, r3
	beq _02009270
	ldr r0, =gUnknown_02022EB4
	strh r3, [r0]
	ldr r1, =gUnknown_02021364
	ldr r0, =gUnknown_02021360
	ldrh r0, [r0]
	b _02009298
	.align 2, 0
	.pool
_02009270:
	ldr r1, =gUnknown_02021364
	ldrh r0, [r1]
	subs r0, #1
	strh r0, [r1]
	lsls r0, r0, #0x10
	cmp r0, #0
	bne _02009294
	ldr r0, =gUnknown_02022EB4
	strh r3, [r0]
	ldr r0, =gUnknown_02021362
	ldrh r0, [r0]
	b _02009298
	.align 2, 0
	.pool
_02009294:
	ldr r1, =gUnknown_02022EB4
	movs r0, #0
_02009298:
	strh r0, [r1]
	strh r3, [r2]
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_020092A4
sub_020092A4: @ 0x020092A4
	ldr r2, =gUnknown_02021360
	strh r0, [r2]
	ldr r0, =gUnknown_02021362
	strh r1, [r0]
	ldr r1, =gUnknown_02021364
	movs r0, #1
	strh r0, [r1]
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_020092C0
sub_020092C0: @ 0x020092C0
	push {lr}
	movs r2, #0xf0
	ldrb r3, [r0]
	ands r2, r3
	cmp r2, #0x20
	beq _020092E2
	cmp r2, #0x20
	bgt _020092D6
	cmp r2, #0x10
	beq _020092DC
	b _020092EC
_020092D6:
	cmp r2, #0x30
	beq _020092E8
	b _020092EC
_020092DC:
	bl LZ77UnCompVRAM
	b _020092EC
_020092E2:
	bl HuffUnComp
	b _020092EC
_020092E8:
	bl RLUnCompVRAM
_020092EC:
	pop {r0}
	bx r0

	thumb_func_start sub_020092F0
sub_020092F0: @ 0x020092F0
	push {lr}
	ldr r0, =gUnknown_02021368
	movs r1, #0
	strb r1, [r0]
	ldr r0, =gUnknown_02021369
	strb r1, [r0]
	bl m4aSoundInit
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_0200930C
sub_0200930C: @ 0x0200930C
	ldr r1, =gUnknown_02021368
	movs r0, #1
	strb r0, [r1]
	ldr r1, =gUnknown_02021369
	movs r0, #0
	strb r0, [r1]
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_02009324
sub_02009324: @ 0x02009324
	ldr r1, =gUnknown_02021369
	cmp r0, #0
	beq _02009336
	ldr r0, =gUnknown_02021368
	ldrb r0, [r0]
	cmp r0, #0
	beq _02009336
	movs r0, #1
	strb r0, [r1]
_02009336:
	ldrb r0, [r1]
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_02009344
sub_02009344: @ 0x02009344
	push {r4, lr}
	lsls r0, r0, #0x10
	ldr r2, =gUnknown_0201DDF8
	ldr r1, =gUnknown_0201DE04
	lsrs r0, r0, #0xd
	adds r0, r0, r1
	ldrh r3, [r0, #4]
	lsls r1, r3, #1
	adds r1, r1, r3
	lsls r1, r1, #2
	adds r1, r1, r2
	ldr r4, [r1]
	ldr r1, [r0]
	adds r0, r4, #0
	bl MPlayStart
	adds r0, r4, #0
	bl m4aMPlayFadeOutTemporarily
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02009378
sub_02009378: @ 0x02009378
	push {lr}
	lsls r0, r0, #0x10
	ldr r2, =gUnknown_0201DDF8
	ldr r1, =gUnknown_0201DE04
	lsrs r0, r0, #0xd
	adds r0, r0, r1
	ldrh r3, [r0, #4]
	lsls r1, r3, #1
	adds r1, r1, r3
	lsls r1, r1, #2
	adds r1, r1, r2
	ldr r0, [r1]
	bl m4aMPlayStop
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_020093A0
sub_020093A0: @ 0x020093A0
	push {lr}
	bl m4aMPlayAllStop
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start sub_020093AC
sub_020093AC: @ 0x020093AC
	movs r0, #1
	bx lr

	thumb_func_start sub_020093B0
sub_020093B0: @ 0x020093B0
	push {r4, lr}
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
	lsls r1, r1, #0x10
	lsrs r3, r1, #0x14
	cmp r3, #0
	bne _020093C0
	movs r3, #1
_020093C0:
	ldr r2, =gUnknown_0201DDF8
	ldr r0, =gUnknown_0201DE04
	lsls r1, r4, #3
	adds r1, r1, r0
	ldrh r4, [r1, #4]
	lsls r0, r4, #1
	adds r0, r0, r4
	lsls r0, r0, #2
	adds r0, r0, r2
	ldr r0, [r0]
	adds r1, r3, #0
	bl m4aMPlayFadeOut
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_020093E8
sub_020093E8: @ 0x020093E8
	push {r4, lr}
	adds r2, r1, #0
	lsls r0, r0, #0x10
	lsls r2, r2, #0x10
	lsrs r2, r2, #0x10
	ldr r3, =gUnknown_0201DDF8
	ldr r1, =gUnknown_0201DE04
	lsrs r0, r0, #0xd
	adds r0, r0, r1
	ldrh r4, [r0, #4]
	lsls r1, r4, #1
	adds r1, r1, r4
	lsls r1, r1, #2
	adds r1, r1, r3
	ldr r0, [r1]
	movs r1, #0xff
	bl m4aMPlayVolumeControl
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_0200941C
sub_0200941C: @ 0x0200941C
	push {r4, lr}
	lsls r0, r0, #0x10
	lsls r1, r1, #0x10
	lsrs r1, r1, #0x10
	ldr r3, =gUnknown_0201DDF8
	ldr r2, =gUnknown_0201DE04
	lsrs r0, r0, #0xd
	adds r0, r0, r2
	ldrh r4, [r0, #4]
	lsls r2, r4, #1
	adds r2, r2, r4
	lsls r2, r2, #2
	adds r2, r2, r3
	ldr r0, [r2]
	bl m4aMPlayTempoControl
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_0200944C
sub_0200944C: @ 0x0200944C
	push {r4, lr}
	adds r2, r1, #0
	lsls r0, r0, #0x10
	ldr r3, =gUnknown_0201DDF8
	ldr r1, =gUnknown_0201DE04
	lsrs r0, r0, #0xd
	adds r0, r0, r1
	ldrh r4, [r0, #4]
	lsls r1, r4, #1
	adds r1, r1, r4
	lsls r1, r1, #2
	adds r1, r1, r3
	ldr r0, [r1]
	lsls r2, r2, #0x10
	asrs r2, r2, #0x10
	movs r1, #0xff
	bl m4aMPlayPitchControl
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02009480
sub_02009480: @ 0x02009480
	push {lr}
	ldr r1, =gUnknown_02021369
	movs r0, #0
	strb r0, [r1]
	bl m4aSoundVSyncOff
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02009494
sub_02009494: @ 0x02009494
	push {lr}
	bl m4aSoundVSyncOn
	ldr r1, =gUnknown_02021369
	movs r0, #1
	strb r0, [r1]
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_020094A8
sub_020094A8: @ 0x020094A8
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	bl sub_02009D48
	adds r1, r0, #0
	movs r5, #0
	movs r4, #0
	ldr r2, =0x00000FFF
_020094BE:
	adds r0, r1, r4
	ldrb r0, [r0]
	adds r5, r0, r5
	adds r4, #1
	cmp r4, r2
	ble _020094BE
	ldr r2, =gUnknown_02022EFC
	movs r3, #0xff
	ands r3, r5
	lsls r0, r3, #2
	ldr r1, =gUnknown_0202526C
	adds r0, r0, r1
	str r0, [r2]
	ldr r0, =gUnknown_02022ED0
	strh r5, [r0]
	cmp r3, #0
	beq _020094EC
	adds r4, r3, #0
_020094E2:
	bl sub_02009890
	subs r4, #1
	cmp r4, #0
	bne _020094E2
_020094EC:
	bl sub_02009890
	movs r1, #3
	ands r1, r0
	cmp r1, #1
	beq _020095D0
	cmp r1, #1
	bgt _02009514
	cmp r1, #0
	beq _02009522
	b _020097BE
	.align 2, 0
	.pool
_02009514:
	cmp r1, #2
	bne _0200951A
	b _02009680
_0200951A:
	cmp r1, #3
	bne _02009520
	b _0200972C
_02009520:
	b _020097BE
_02009522:
	ldr r7, =gUnknown_02022ECC
	ldr r0, =gUnknown_020251E8
	mov sl, r0
	ldr r0, [r0]
	adds r0, #0x8c
	ldr r4, [r0]
	ldr r1, =gUnknown_02022EFC
	mov r8, r1
	ldr r2, [r1]
	mov sb, r2
	bl sub_02009890
	mov r1, r8
	ldr r6, [r1]
	adds r6, r6, r4
	movs r5, #0xf
	adds r1, r5, #0
	ands r1, r0
	lsls r1, r1, #2
	adds r6, r6, r1
	mov r2, r8
	str r6, [r2]
	mov r0, sb
	str r0, [r7]
	ldr r7, =gSaveBlock2Ptr
	mov r1, sl
	ldr r0, [r1]
	adds r0, #0x88
	ldr r0, [r0]
	mov sb, r0
	bl sub_02009890
	mov r2, r8
	ldr r4, [r2]
	add r4, sb
	adds r1, r5, #0
	ands r1, r0
	lsls r1, r1, #2
	adds r4, r4, r1
	str r4, [r2]
	str r6, [r7]
	ldr r0, =gUnknown_02022EC0
	mov sb, r0
	bl sub_02009890
	mov r1, r8
	ldr r6, [r1]
	ldr r2, =0x000083D0
	adds r6, r6, r2
	adds r1, r5, #0
	ands r1, r0
	lsls r1, r1, #2
	adds r6, r6, r1
	mov r0, r8
	str r6, [r0]
	mov r1, sb
	str r4, [r1]
	ldr r2, =gUnknown_02022EC4
	mov sb, r2
	mov r1, sl
	ldr r0, [r1]
	adds r0, #0x8c
	ldr r4, [r0]
	bl sub_02009890
	mov r2, r8
	ldr r1, [r2]
	adds r1, r1, r4
	ands r5, r0
	lsls r5, r5, #2
	adds r1, r1, r5
	b _0200965C
	.align 2, 0
	.pool
_020095D0:
	ldr r1, =gUnknown_02022EC0
	mov sb, r1
	ldr r2, =gUnknown_02022EFC
	mov r8, r2
	ldr r5, [r2]
	bl sub_02009890
	mov r1, r8
	ldr r6, [r1]
	ldr r2, =0x000083D0
	adds r6, r6, r2
	movs r4, #0xf
	adds r1, r4, #0
	ands r1, r0
	lsls r1, r1, #2
	adds r6, r6, r1
	mov r0, r8
	str r6, [r0]
	mov r1, sb
	str r5, [r1]
	ldr r7, =gUnknown_02022EC4
	ldr r2, =gUnknown_020251E8
	mov sl, r2
	ldr r0, [r2]
	adds r0, #0x8c
	ldr r0, [r0]
	mov sb, r0
	bl sub_02009890
	mov r1, r8
	ldr r5, [r1]
	add r5, sb
	adds r1, r4, #0
	ands r1, r0
	lsls r1, r1, #2
	adds r5, r5, r1
	mov r2, r8
	str r5, [r2]
	str r6, [r7]
	ldr r7, =gUnknown_02022ECC
	mov r1, sl
	ldr r0, [r1]
	adds r0, #0x8c
	ldr r0, [r0]
	mov sb, r0
	bl sub_02009890
	mov r2, r8
	ldr r6, [r2]
	add r6, sb
	adds r1, r4, #0
	ands r1, r0
	lsls r1, r1, #2
	adds r6, r6, r1
	str r6, [r2]
	str r5, [r7]
	ldr r0, =gSaveBlock2Ptr
	mov sb, r0
	mov r1, sl
	ldr r0, [r1]
	adds r0, #0x88
	ldr r5, [r0]
	bl sub_02009890
	mov r2, r8
	ldr r1, [r2]
	adds r1, r1, r5
	ands r4, r0
	lsls r4, r4, #2
	adds r1, r1, r4
_0200965C:
	str r1, [r2]
	mov r0, sb
	str r6, [r0]
	b _020097BE
	.align 2, 0
	.pool
_02009680:
	ldr r1, =gSaveBlock2Ptr
	mov sb, r1
	ldr r2, =gUnknown_020251E8
	mov sl, r2
	ldr r0, [r2]
	adds r0, #0x88
	ldr r5, [r0]
	ldr r0, =gUnknown_02022EFC
	mov r8, r0
	ldr r6, [r0]
	bl sub_02009890
	mov r1, r8
	ldr r4, [r1]
	adds r4, r4, r5
	movs r5, #0xf
	adds r1, r5, #0
	ands r1, r0
	lsls r1, r1, #2
	adds r4, r4, r1
	mov r2, r8
	str r4, [r2]
	mov r0, sb
	str r6, [r0]
	ldr r7, =gUnknown_02022ECC
	mov r1, sl
	ldr r0, [r1]
	adds r0, #0x8c
	ldr r0, [r0]
	mov sb, r0
	bl sub_02009890
	mov r2, r8
	ldr r6, [r2]
	add r6, sb
	adds r1, r5, #0
	ands r1, r0
	lsls r1, r1, #2
	adds r6, r6, r1
	str r6, [r2]
	str r4, [r7]
	ldr r7, =gUnknown_02022EC4
	mov r1, sl
	ldr r0, [r1]
	adds r0, #0x8c
	ldr r0, [r0]
	mov sb, r0
	bl sub_02009890
	mov r2, r8
	ldr r4, [r2]
	add r4, sb
	adds r1, r5, #0
	ands r1, r0
	lsls r1, r1, #2
	adds r4, r4, r1
	str r4, [r2]
	str r6, [r7]
	ldr r6, =gUnknown_02022EC0
	bl sub_02009890
	mov r2, r8
	ldr r1, [r2]
	ldr r2, =0x000083D0
	adds r1, r1, r2
	ands r5, r0
	lsls r5, r5, #2
	adds r1, r1, r5
	mov r0, r8
	str r1, [r0]
	str r4, [r6]
	b _020097BE
	.align 2, 0
	.pool
_0200972C:
	ldr r1, =gUnknown_02022EC4
	mov sb, r1
	ldr r2, =gUnknown_020251E8
	mov sl, r2
	ldr r0, [r2]
	adds r0, #0x8c
	ldr r4, [r0]
	ldr r0, =gUnknown_02022EFC
	mov r8, r0
	ldr r6, [r0]
	bl sub_02009890
	mov r1, r8
	ldr r5, [r1]
	adds r5, r5, r4
	movs r4, #0xf
	adds r1, r4, #0
	ands r1, r0
	lsls r1, r1, #2
	adds r5, r5, r1
	mov r2, r8
	str r5, [r2]
	mov r0, sb
	str r6, [r0]
	ldr r1, =gUnknown_02022EC0
	mov sb, r1
	bl sub_02009890
	mov r2, r8
	ldr r6, [r2]
	ldr r1, =0x000083D0
	adds r6, r6, r1
	adds r1, r4, #0
	ands r1, r0
	lsls r1, r1, #2
	adds r6, r6, r1
	str r6, [r2]
	mov r2, sb
	str r5, [r2]
	ldr r7, =gSaveBlock2Ptr
	mov r1, sl
	ldr r0, [r1]
	adds r0, #0x88
	ldr r0, [r0]
	mov sb, r0
	bl sub_02009890
	mov r2, r8
	ldr r5, [r2]
	add r5, sb
	adds r1, r4, #0
	ands r1, r0
	lsls r1, r1, #2
	adds r5, r5, r1
	str r5, [r2]
	str r6, [r7]
	ldr r0, =gUnknown_02022ECC
	mov sb, r0
	mov r1, sl
	ldr r0, [r1]
	adds r0, #0x8c
	ldr r6, [r0]
	bl sub_02009890
	mov r2, r8
	ldr r1, [r2]
	adds r1, r1, r6
	ands r4, r0
	lsls r4, r4, #2
	adds r1, r1, r4
	str r1, [r2]
	mov r0, sb
	str r5, [r0]
_020097BE:
	ldr r3, =gUnknown_02022EF4
	ldr r1, =gUnknown_02022ECC
	ldr r0, =gUnknown_020251E8
	ldr r4, [r0]
	adds r0, r4, #0
	adds r0, #0x94
	ldr r2, [r1]
	ldr r1, [r0]
	adds r0, r2, r1
	str r0, [r3]
	ldr r3, =gUnknown_02022EEC
	ldr r0, =gUnknown_02022EC4
	ldr r0, [r0]
	adds r0, r0, r1
	str r0, [r3]
	ldr r1, =gUnknown_02022EF0
	adds r0, r4, #0
	adds r0, #0x90
	ldr r0, [r0]
	adds r0, r2, r0
	str r0, [r1]
	ldr r3, =gUnknown_02022EC8
	ldr r0, =gSaveBlock2Ptr
	ldr r0, [r0]
	ldr r1, [r4, #0x58]
	adds r0, r0, r1
	str r0, [r3]
	ldr r1, =gUnknown_02022EF8
	ldr r0, [r4, #0x5c]
	adds r0, r2, r0
	str r0, [r1]
	ldr r1, =gUnknown_02022EE0
	ldr r0, [r4, #0x60]
	adds r0, r2, r0
	str r0, [r1]
	ldr r1, =gUnknown_02022ED4
	ldr r0, [r4, #0x50]
	adds r0, r2, r0
	str r0, [r1]
	ldr r1, =gUnknown_02022EE4
	ldr r0, [r4, #0x54]
	adds r0, r2, r0
	str r0, [r1]
	ldr r1, =gUnknown_02022EDC
	adds r0, r4, #0
	adds r0, #0xf0
	ldr r0, [r0]
	adds r0, r2, r0
	str r0, [r1]
	ldr r1, =gUnknown_02022EE8
	adds r0, r4, #0
	adds r0, #0xf4
	ldr r0, [r0]
	adds r0, r2, r0
	str r0, [r1]
	ldr r1, =gUnknown_02022EBC
	adds r0, r4, #0
	adds r0, #0xec
	ldr r0, [r0]
	adds r2, r2, r0
	str r2, [r1]
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02009890
sub_02009890: @ 0x02009890
	ldr r1, =gUnknown_02022ED0
	ldr r0, =0x0000080D
	ldrh r2, [r1]
	muls r0, r2, r0
	adds r0, #7
	strh r0, [r1]
	ldrh r0, [r1]
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_020098A8
sub_020098A8: @ 0x020098A8
	push {r4, r5, r6, lr}
	adds r5, r0, #0
	ldr r4, =gUnknown_02022EFC
	ldr r6, [r4]
	bl sub_02009890
	ldr r2, [r4]
	adds r2, r2, r5
	movs r1, #0xf
	ands r1, r0
	lsls r1, r1, #2
	adds r2, r2, r1
	str r2, [r4]
	adds r0, r6, #0
	pop {r4, r5, r6}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_020098D0
sub_020098D0: @ 0x020098D0
	ldr r0, =gUnknown_03004400
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_020098D8
sub_020098D8: @ 0x020098D8
	push {r4, r5, r6, lr}
	adds r5, r0, #0
	adds r6, r1, #0
	ldr r4, =gUnknown_0202054C
	ldr r0, =gUnknown_020251E8
	ldr r0, [r0]
	adds r1, r0, #0
	adds r1, #0x88
	ldr r1, [r1]
	strh r1, [r4, #4]
	adds r0, #0x8c
	ldr r0, [r0]
	movs r1, #0xf8
	lsls r1, r1, #4
	bl __umodsi3
	strh r0, [r4, #0x24]
	adds r4, #0x6c
	movs r0, #0xfa
	lsls r0, r0, #3
	strh r0, [r4]
	bl sub_0200DF50
	lsls r0, r0, #0x10
	cmp r0, #0
	bne _0200994C
	lsls r0, r5, #0x18
	lsrs r0, r0, #0x18
	adds r1, r6, #0
	bl sub_0200DB38
	lsls r0, r0, #0x10
	lsrs r1, r0, #0x10
	cmp r1, #0
	bne _0200994C
	ldr r0, =gUnknown_02022F2C
	str r1, [r0]
	ldr r0, =gUnknown_02022F00
	strh r1, [r0]
	ldr r0, =gUnknown_02022F28
	str r1, [r0]
	ldr r1, =gUnknown_02021370
	movs r0, #0x80
	str r0, [r1]
	movs r0, #0
	b _02009950
	.align 2, 0
	.pool
_0200994C:
	movs r0, #1
	rsbs r0, r0, #0
_02009950:
	pop {r4, r5, r6}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_02009958
sub_02009958: @ 0x02009958
	push {r4, r5, lr}
	ldr r2, =gUnknown_0202054C
	ldr r0, =gSaveBlock2Ptr
	ldr r0, [r0]
	str r0, [r2]
	ldr r0, =gUnknown_02022ECC
	ldr r1, [r0]
	str r1, [r2, #8]
	movs r5, #0xf8
	lsls r5, r5, #4
	adds r0, r1, r5
	str r0, [r2, #0x10]
	movs r4, #0xf8
	lsls r4, r4, #5
	adds r0, r1, r4
	str r0, [r2, #0x18]
	movs r3, #0xba
	lsls r3, r3, #6
	adds r1, r1, r3
	str r1, [r2, #0x20]
	ldr r0, =gUnknown_02022EC0
	ldr r0, [r0]
	str r0, [r2, #0x28]
	adds r5, r0, r5
	str r5, [r2, #0x30]
	adds r4, r0, r4
	str r4, [r2, #0x38]
	adds r3, r0, r3
	str r3, [r2, #0x40]
	movs r3, #0xf8
	lsls r3, r3, #6
	adds r1, r0, r3
	str r1, [r2, #0x48]
	movs r3, #0x9b
	lsls r3, r3, #7
	adds r1, r0, r3
	str r1, [r2, #0x50]
	movs r3, #0xba
	lsls r3, r3, #7
	adds r1, r0, r3
	str r1, [r2, #0x58]
	movs r3, #0xd9
	lsls r3, r3, #7
	adds r1, r0, r3
	str r1, [r2, #0x60]
	movs r1, #0xf8
	lsls r1, r1, #7
	adds r0, r0, r1
	str r0, [r2, #0x68]
	pop {r4, r5}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_020099D0
sub_020099D0: @ 0x020099D0
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #8
	str r0, [sp]
	movs r0, #0
	mov sb, r0
	mov sl, r0
	movs r7, #0
	movs r1, #0
	mov r8, r1
	movs r5, #0
	ldr r6, =gUnknown_02022F30
_020099EE:
	lsls r0, r5, #0x18
	lsrs r0, r0, #0x18
	ldr r2, [r6]
	movs r1, #0
	movs r3, #0x80
	lsls r3, r3, #5
	bl sub_0200DCC8
	ldr r2, [r6]
	ldr r3, =0x00000FF8
	adds r0, r2, r3
	ldr r1, [r0]
	ldr r0, =0x08012025
	cmp r1, r0
	bne _02009A6E
	movs r0, #1
	mov r8, r0
	ldr r1, =0x00000FF4
	adds r0, r2, r1
	ldrh r0, [r0]
	lsls r0, r0, #3
	ldr r3, [sp]
	adds r0, r0, r3
	adds r4, r2, #0
	ldrh r3, [r0, #4]
	movs r2, #0
	movs r1, #0
	b _02009A3E
	.align 2, 0
	.pool
_02009A38:
	ldm r4!, {r0}
	adds r2, r2, r0
	adds r1, #1
_02009A3E:
	adds r0, r3, #0
	asrs r0, r0, #2
	cmp r1, r0
	blt _02009A38
	lsrs r0, r2, #0x10
	adds r0, r0, r2
	lsls r0, r0, #0x10
	lsrs r2, r0, #0x10
	ldr r1, [r6]
	ldr r3, =0x00000FF6
	adds r0, r1, r3
	ldrh r0, [r0]
	cmp r0, r2
	bne _02009A6E
	ldr r2, =0x00000FFC
	adds r0, r1, r2
	ldr r0, [r0]
	mov sb, r0
	subs r3, #2
	adds r1, r1, r3
	movs r0, #1
	ldrh r1, [r1]
	lsls r0, r1
	orrs r7, r0
_02009A6E:
	adds r0, r5, #1
	lsls r0, r0, #0x10
	lsrs r5, r0, #0x10
	cmp r5, #0xd
	bls _020099EE
	mov r0, r8
	cmp r0, #0
	beq _02009A9C
	ldr r0, =0x00003FFF
	movs r1, #0xff
	str r1, [sp, #4]
	cmp r7, r0
	bne _02009AA0
	movs r2, #1
	str r2, [sp, #4]
	b _02009AA0
	.align 2, 0
	.pool
_02009A9C:
	movs r3, #0
	str r3, [sp, #4]
_02009AA0:
	movs r7, #0
	movs r0, #0
	mov r8, r0
	movs r5, #0
_02009AA8:
	adds r0, r5, #0
	adds r0, #0xe
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	ldr r1, =gUnknown_02022F30
	ldr r2, [r1]
	movs r1, #0
	movs r3, #0x80
	lsls r3, r3, #5
	bl sub_0200DCC8
	ldr r3, =gUnknown_02022F30
	ldr r2, [r3]
	ldr r1, =0x00000FF8
	adds r0, r2, r1
	ldr r1, [r0]
	ldr r0, =0x08012025
	adds r6, r3, #0
	adds r5, #1
	cmp r1, r0
	bne _02009B32
	movs r3, #1
	mov r8, r3
	ldr r1, =0x00000FF4
	adds r0, r2, r1
	ldrh r0, [r0]
	lsls r0, r0, #3
	ldr r3, [sp]
	adds r0, r0, r3
	adds r4, r2, #0
	ldrh r3, [r0, #4]
	movs r2, #0
	movs r1, #0
	b _02009B02
	.align 2, 0
	.pool
_02009AFC:
	ldm r4!, {r0}
	adds r2, r2, r0
	adds r1, #1
_02009B02:
	adds r0, r3, #0
	asrs r0, r0, #2
	cmp r1, r0
	blt _02009AFC
	lsrs r0, r2, #0x10
	adds r0, r0, r2
	lsls r0, r0, #0x10
	lsrs r2, r0, #0x10
	ldr r1, [r6]
	ldr r3, =0x00000FF6
	adds r0, r1, r3
	ldrh r0, [r0]
	cmp r0, r2
	bne _02009B32
	ldr r2, =0x00000FFC
	adds r0, r1, r2
	ldr r0, [r0]
	mov sl, r0
	subs r3, #2
	adds r1, r1, r3
	movs r0, #1
	ldrh r1, [r1]
	lsls r0, r1
	orrs r7, r0
_02009B32:
	lsls r0, r5, #0x10
	lsrs r5, r0, #0x10
	cmp r5, #0xd
	bls _02009AA8
	mov r0, r8
	cmp r0, #0
	beq _02009B58
	ldr r0, =0x00003FFF
	movs r1, #0xff
	cmp r7, r0
	bne _02009B5A
	movs r1, #1
	b _02009B5A
	.align 2, 0
	.pool
_02009B58:
	movs r1, #0
_02009B5A:
	ldr r2, [sp, #4]
	cmp r2, #1
	bne _02009BCC
	cmp r1, #1
	bne _02009BBC
	movs r0, #1
	rsbs r0, r0, #0
	cmp sb, r0
	bne _02009B72
	mov r3, sl
	cmp r3, #0
	beq _02009B7C
_02009B72:
	mov r1, sb
	cmp r1, #0
	bne _02009BA0
	cmp sl, r0
	bne _02009BA0
_02009B7C:
	mov r1, sb
	adds r1, #1
	mov r0, sl
	adds r0, #1
	cmp r1, r0
	bhs _02009B94
	ldr r0, =gUnknown_02022F2C
	mov r2, sl
	b _02009BB4
	.align 2, 0
	.pool
_02009B94:
	ldr r0, =gUnknown_02022F2C
	mov r3, sb
	str r3, [r0]
	b _02009BE4
	.align 2, 0
	.pool
_02009BA0:
	cmp sb, sl
	bhs _02009BB0
	ldr r0, =gUnknown_02022F2C
	mov r1, sl
	str r1, [r0]
	b _02009BE4
	.align 2, 0
	.pool
_02009BB0:
	ldr r0, =gUnknown_02022F2C
	mov r2, sb
_02009BB4:
	str r2, [r0]
	b _02009BE4
	.align 2, 0
	.pool
_02009BBC:
	ldr r0, =gUnknown_02022F2C
	mov r3, sb
	str r3, [r0]
	cmp r1, #0xff
	beq _02009BDC
	b _02009BE4
	.align 2, 0
	.pool
_02009BCC:
	cmp r1, #1
	bne _02009BE8
	ldr r0, =gUnknown_02022F2C
	mov r1, sl
	str r1, [r0]
	ldr r2, [sp, #4]
	cmp r2, #0xff
	bne _02009BE4
_02009BDC:
	movs r0, #0xff
	b _02009C14
	.align 2, 0
	.pool
_02009BE4:
	movs r0, #1
	b _02009C14
_02009BE8:
	ldr r3, [sp, #4]
	cmp r3, #0
	bne _02009C08
	cmp r1, #0
	bne _02009C08
	ldr r0, =gUnknown_02022F2C
	str r1, [r0]
	ldr r0, =gUnknown_02022F00
	strh r1, [r0]
	movs r0, #0
	b _02009C14
	.align 2, 0
	.pool
_02009C08:
	ldr r0, =gUnknown_02022F2C
	movs r1, #0
	str r1, [r0]
	ldr r0, =gUnknown_02022F00
	strh r1, [r0]
	movs r0, #2
_02009C14:
	add sp, #8
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_02009C2C
sub_02009C2C: @ 0x02009C2C
	push {r4, r5, r6, r7, lr}
	adds r5, r1, #0
	adds r6, r2, #0
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	ldr r4, =gUnknown_02022F30
	ldr r2, [r4]
	movs r1, #0
	movs r3, #0x80
	lsls r3, r3, #5
	bl sub_0200DCC8
	ldr r0, [r4]
	ldr r1, =0x00000FF4
	adds r0, r0, r1
	ldrh r1, [r0]
	cmp r1, #0
	bne _02009C54
	ldr r0, =gUnknown_02022F00
	strh r5, [r0]
_02009C54:
	lsls r0, r1, #3
	adds r1, r0, r6
	ldr r5, [r4]
	ldrh r2, [r1, #4]
	movs r3, #0
	movs r1, #0
	adds r7, r4, #0
	mov ip, r0
	b _02009C7A
	.align 2, 0
	.pool
_02009C74:
	ldm r5!, {r0}
	adds r3, r3, r0
	adds r1, #1
_02009C7A:
	adds r0, r2, #0
	asrs r0, r0, #2
	cmp r1, r0
	blt _02009C74
	lsrs r0, r3, #0x10
	adds r0, r0, r3
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
	ldr r3, [r7]
	ldr r1, =0x00000FF8
	adds r0, r3, r1
	ldr r1, [r0]
	ldr r0, =0x08012025
	cmp r1, r0
	bne _02009CC6
	ldr r1, =0x00000FF6
	adds r0, r3, r1
	ldrh r0, [r0]
	cmp r0, r4
	bne _02009CC6
	movs r4, #0
	mov r3, ip
	adds r0, r3, r6
	ldrh r0, [r0, #4]
	cmp r4, r0
	bge _02009CC6
	adds r5, r7, #0
_02009CB0:
	adds r2, r3, r6
	ldr r1, [r2]
	adds r1, r1, r4
	ldr r0, [r5]
	adds r0, r0, r4
	ldrb r0, [r0]
	strb r0, [r1]
	adds r4, #1
	ldrh r2, [r2, #4]
	cmp r4, r2
	blt _02009CB0
_02009CC6:
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02009CD8
sub_02009CD8: @ 0x02009CD8
	push {r4, r5, r6, lr}
	ldr r6, =gUnknown_0202054C
	ldr r1, =gUnknown_02022F30
	ldr r0, =gUnknown_02022F40
	str r0, [r1]
	ldr r0, =gUnknown_02022F2C
	ldr r1, [r0]
	movs r0, #1
	ands r1, r0
	lsls r0, r1, #3
	subs r0, r0, r1
	lsls r5, r0, #1
	movs r4, #0
_02009CF2:
	adds r0, r4, r5
	adds r1, r4, #0
	adds r2, r6, #0
	bl sub_02009C2C
	adds r4, #1
	cmp r4, #0xd
	ble _02009CF2
	ldr r0, =gUnknown_02021370
	ldr r4, [r0]
	ldr r0, =gUnknown_02022ECC
	ldr r0, [r0]
	ldr r1, =gUnknown_02022EC4
	ldr r1, [r1]
	ldr r2, =gUnknown_020251E8
	ldr r2, [r2]
	adds r2, #0x8c
	ldr r2, [r2]
	lsls r2, r2, #0xa
	lsrs r2, r2, #0xb
	bl CpuSet
	adds r0, r4, #0
	pop {r4, r5, r6}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_02009D48
sub_02009D48: @ 0x02009D48
	push {r4, r5, r6, lr}
	ldr r5, =gUnknown_020205BC
	ldr r0, =gUnknown_02022F30
	ldr r6, =gUnknown_02022F40
	str r6, [r0]
	ldr r4, =gUnknown_02021370
	adds r0, r5, #0
	bl sub_020099D0
	lsls r0, r0, #0x10
	lsrs r0, r0, #0x10
	str r0, [r4]
	ldr r0, =gUnknown_02022F2C
	ldr r1, [r0]
	movs r0, #1
	ands r1, r0
	lsls r0, r1, #3
	subs r0, r0, r1
	lsls r0, r0, #1
	movs r1, #0
	adds r2, r5, #0
	bl sub_02009C2C
	adds r0, r6, #0
	pop {r4, r5, r6}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_02009D94
sub_02009D94: @ 0x02009D94
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	adds r4, r1, #0
	lsls r0, r0, #0x10
	lsrs r6, r0, #0x10
	ldr r0, =gUnknown_02022F00
	ldrh r0, [r0]
	adds r0, r0, r6
	lsls r0, r0, #0x10
	lsrs r5, r0, #0x10
	adds r0, r5, #0
	movs r1, #0xe
	bl __umodsi3
	lsls r0, r0, #0x10
	lsrs r5, r0, #0x10
	ldr r2, =gUnknown_02022F2C
	ldr r1, [r2]
	movs r0, #1
	ands r1, r0
	lsls r0, r1, #3
	subs r0, r0, r1
	lsls r0, r0, #1
	adds r0, r5, r0
	lsls r0, r0, #0x10
	lsrs r5, r0, #0x10
	lsls r0, r6, #3
	adds r0, r0, r4
	ldr r1, [r0]
	mov sl, r1
	ldrh r4, [r0, #4]
	movs r3, #0
	mov sb, r2
	ldr r2, =gUnknown_02022F30
	mov r8, r2
	mov ip, r8
	movs r2, #0
	ldr r1, =0x00000FFF
_02009DE6:
	mov r7, ip
	ldr r0, [r7]
	adds r0, r0, r3
	strb r2, [r0]
	adds r0, r3, #1
	lsls r0, r0, #0x10
	lsrs r3, r0, #0x10
	cmp r3, r1
	bls _02009DE6
	mov r0, r8
	ldr r1, [r0]
	ldr r2, =0x00000FF4
	adds r0, r1, r2
	strh r6, [r0]
	ldr r6, =0x00000FF8
	adds r2, r1, r6
	ldr r0, =0x08012025
	str r0, [r2]
	ldr r7, =0x00000FFC
	adds r1, r1, r7
	mov r2, sb
	ldr r0, [r2]
	str r0, [r1]
	movs r3, #0
	lsls r5, r5, #0x18
	cmp r3, r4
	bhs _02009E34
	mov r2, r8
_02009E1E:
	ldr r1, [r2]
	adds r1, r1, r3
	mov r6, sl
	adds r0, r6, r3
	ldrb r0, [r0]
	strb r0, [r1]
	adds r0, r3, #1
	lsls r0, r0, #0x10
	lsrs r3, r0, #0x10
	cmp r3, r4
	blo _02009E1E
_02009E34:
	mov r3, sl
	movs r2, #0
	movs r1, #0
	b _02009E62
	.align 2, 0
	.pool
_02009E5C:
	ldm r3!, {r0}
	adds r2, r2, r0
	adds r1, #1
_02009E62:
	adds r0, r4, #0
	asrs r0, r0, #2
	cmp r1, r0
	blt _02009E5C
	lsrs r0, r2, #0x10
	adds r0, r0, r2
	mov r7, r8
	ldr r4, [r7]
	ldr r2, =0x00000FF6
	adds r1, r4, r2
	strh r0, [r1]
	lsrs r5, r5, #0x18
	bl sub_02009480
	adds r0, r5, #0
	adds r1, r4, #0
	bl sub_0200DEC4
	adds r4, r0, #0
	bl sub_02009494
	cmp r4, #0
	beq _02009EA8
	ldr r2, =gUnknown_02022F28
	movs r1, #1
	lsls r1, r5
	ldr r0, [r2]
	orrs r0, r1
	str r0, [r2]
	movs r0, #0xff
	b _02009EB6
	.align 2, 0
	.pool
_02009EA8:
	ldr r2, =gUnknown_02022F28
	movs r1, #1
	lsls r1, r5
	ldr r0, [r2]
	bics r0, r1
	str r0, [r2]
	movs r0, #1
_02009EB6:
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_02009EC8
sub_02009EC8: @ 0x02009EC8
	push {r4, r5, r6, lr}
	ldr r6, =gUnknown_0202054C
	ldr r1, =gUnknown_02022F30
	ldr r0, =gUnknown_02022F40
	str r0, [r1]
	ldr r0, =gUnknown_02022F24
	ldr r4, =gUnknown_02022F00
	ldrh r1, [r4]
	strh r1, [r0]
	ldr r2, =gUnknown_02022F04
	ldr r5, =gUnknown_02022F2C
	ldr r0, [r5]
	str r0, [r2]
	adds r1, #1
	strh r1, [r4]
	ldrh r0, [r4]
	movs r1, #0xe
	bl __umodsi3
	strh r0, [r4]
	ldr r0, [r5]
	adds r0, #1
	str r0, [r5]
	movs r5, #1
	movs r4, #0
_02009EFA:
	lsls r0, r4, #0x10
	lsrs r0, r0, #0x10
	adds r1, r6, #0
	bl sub_02009D94
	adds r4, #1
	cmp r4, #0xd
	ble _02009EFA
	ldr r0, =gUnknown_02022F28
	ldr r0, [r0]
	cmp r0, #0
	beq _02009F24
	movs r5, #0xff
	ldr r1, =gUnknown_02022F00
	ldr r0, =gUnknown_02022F24
	ldrh r0, [r0]
	strh r0, [r1]
	ldr r1, =gUnknown_02022F2C
	ldr r0, =gUnknown_02022F04
	ldr r0, [r0]
	str r0, [r1]
_02009F24:
	adds r0, r5, #0
	pop {r4, r5, r6}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_02009F4C
sub_02009F4C: @ 0x02009F4C
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #4
	adds r4, r1, #0
	lsls r0, r0, #0x10
	lsrs r6, r0, #0x10
	ldr r0, =gUnknown_02022F00
	ldrh r0, [r0]
	adds r0, r0, r6
	lsls r0, r0, #0x10
	lsrs r5, r0, #0x10
	adds r0, r5, #0
	movs r1, #0xe
	bl __umodsi3
	lsls r0, r0, #0x10
	lsrs r5, r0, #0x10
	ldr r2, =gUnknown_02022F2C
	ldr r1, [r2]
	movs r0, #1
	ands r1, r0
	lsls r0, r1, #3
	subs r0, r0, r1
	lsls r0, r0, #1
	adds r0, r5, r0
	lsls r0, r0, #0x10
	lsrs r5, r0, #0x10
	lsls r0, r6, #3
	adds r0, r0, r4
	ldr r1, [r0]
	str r1, [sp]
	ldrh r3, [r0, #4]
	movs r4, #0
	mov sb, r2
	ldr r2, =gUnknown_02022F30
	mov r8, r2
	ldr r7, =gUnknown_02025244
	mov sl, r7
	mov ip, r8
	movs r2, #0
	ldr r1, =0x00000FFF
_02009FA4:
	mov r7, ip
	ldr r0, [r7]
	adds r0, r0, r4
	strb r2, [r0]
	adds r0, r4, #1
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
	cmp r4, r1
	bls _02009FA4
	mov r0, r8
	ldr r1, [r0]
	ldr r2, =0x00000FF4
	adds r0, r1, r2
	strh r6, [r0]
	ldr r6, =0x00000FF8
	adds r2, r1, r6
	ldr r0, =0x08012025
	str r0, [r2]
	ldr r7, =0x00000FFC
	adds r1, r1, r7
	mov r2, sb
	ldr r0, [r2]
	str r0, [r1]
	movs r4, #0
	lsls r6, r5, #0x18
	mov sb, r6
	cmp r4, r3
	bhs _02009FF4
	mov r2, r8
_02009FDE:
	ldr r1, [r2]
	adds r1, r1, r4
	ldr r7, [sp]
	adds r0, r7, r4
	ldrb r0, [r0]
	strb r0, [r1]
	adds r0, r4, #1
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
	cmp r4, r3
	blo _02009FDE
_02009FF4:
	ldr r4, [sp]
	movs r2, #0
	movs r1, #0
	b _0200A026
	.align 2, 0
	.pool
_0200A020:
	ldm r4!, {r0}
	adds r2, r2, r0
	adds r1, #1
_0200A026:
	adds r0, r3, #0
	asrs r0, r0, #2
	cmp r1, r0
	blt _0200A020
	lsrs r0, r2, #0x10
	adds r0, r0, r2
	mov r2, r8
	ldr r1, [r2]
	ldr r6, =0x00000FF6
	adds r1, r1, r6
	strh r0, [r1]
	mov r7, sl
	ldr r1, [r7]
	adds r0, r5, #0
	bl _call_via_r1
	movs r6, #1
	movs r4, #0
	ldr r0, =0x00000FF7
	mov r8, r0
	ldr r7, =gUnknown_02025238
	b _0200A066
	.align 2, 0
	.pool
_0200A060:
	adds r0, r4, #1
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
_0200A066:
	cmp r4, r8
	bhi _0200A084
	ldr r0, =gUnknown_02022F30
	ldr r0, [r0]
	adds r0, r0, r4
	ldrb r2, [r0]
	ldr r3, [r7]
	adds r0, r5, #0
	adds r1, r4, #0
	bl _call_via_r3
	lsls r0, r0, #0x10
	cmp r0, #0
	beq _0200A060
	movs r6, #0xff
_0200A084:
	cmp r6, #0xff
	bne _0200A094
	mov r1, sb
	lsrs r0, r1, #0x18
	b _0200A0F4
	.align 2, 0
	.pool
_0200A094:
	movs r6, #1
	movs r4, #0
	ldr r2, =gUnknown_02025238
	mov r8, r2
	ldr r7, =0x00000FF9
	b _0200A0AE
	.align 2, 0
	.pool
_0200A0A8:
	adds r0, r4, #1
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
_0200A0AE:
	cmp r4, #6
	bhi _0200A0D0
	adds r1, r4, r7
	ldr r0, =gUnknown_02022F30
	ldr r0, [r0]
	adds r0, r4, r0
	adds r0, r0, r7
	ldrb r2, [r0]
	mov r0, r8
	ldr r3, [r0]
	adds r0, r5, #0
	bl _call_via_r3
	lsls r0, r0, #0x10
	cmp r0, #0
	beq _0200A0A8
	movs r6, #0xff
_0200A0D0:
	cmp r6, #0xff
	beq _0200A0F0
	mov r1, sb
	lsrs r0, r1, #0x18
	ldr r2, =gUnknown_02022F28
	movs r1, #1
	lsls r1, r0
	ldr r0, [r2]
	bics r0, r1
	str r0, [r2]
	movs r0, #1
	b _0200A102
	.align 2, 0
	.pool
_0200A0F0:
	mov r2, sb
	lsrs r0, r2, #0x18
_0200A0F4:
	ldr r2, =gUnknown_02022F28
	movs r1, #1
	lsls r1, r0
	ldr r0, [r2]
	orrs r0, r1
	str r0, [r2]
	movs r0, #0xff
_0200A102:
	add sp, #4
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200A118
sub_0200A118: @ 0x0200A118
	push {r4, r5, lr}
	lsls r0, r0, #0x10
	lsrs r0, r0, #0x10
	ldr r1, =gUnknown_02022F00
	ldrh r1, [r1]
	adds r0, r1, r0
	subs r0, #1
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
	adds r0, r4, #0
	movs r1, #0xe
	bl __umodsi3
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
	ldr r0, =gUnknown_02022F2C
	ldr r1, [r0]
	movs r5, #1
	ands r1, r5
	lsls r0, r1, #3
	subs r0, r0, r1
	lsls r0, r0, #1
	adds r0, r4, r0
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
	bl sub_02009480
	ldr r3, =gUnknown_02025238
	ldr r1, =0x00000FF8
	ldr r0, =gUnknown_02022F30
	ldr r0, [r0]
	adds r0, r0, r1
	ldrb r2, [r0]
	ldr r3, [r3]
	adds r0, r4, #0
	bl _call_via_r3
	lsls r0, r0, #0x10
	cmp r0, #0
	bne _0200A198
	lsls r0, r4, #0x18
	lsrs r0, r0, #0x18
	ldr r2, =gUnknown_02022F28
	adds r1, r5, #0
	lsls r1, r0
	ldr r0, [r2]
	bics r0, r1
	str r0, [r2]
	bl sub_02009494
	movs r0, #1
	b _0200A1AE
	.align 2, 0
	.pool
_0200A198:
	lsls r0, r4, #0x18
	lsrs r0, r0, #0x18
	ldr r2, =gUnknown_02022F28
	adds r1, r5, #0
	lsls r1, r0
	ldr r0, [r2]
	orrs r0, r1
	str r0, [r2]
	bl sub_02009494
	movs r0, #0xff
_0200A1AE:
	pop {r4, r5}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200A1B8
sub_0200A1B8: @ 0x0200A1B8
	push {r4, r5, lr}
	lsls r0, r0, #0x10
	lsrs r0, r0, #0x10
	ldr r1, =gUnknown_02022F00
	ldrh r1, [r1]
	adds r0, r1, r0
	subs r0, #1
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
	adds r0, r4, #0
	movs r1, #0xe
	bl __umodsi3
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
	ldr r0, =gUnknown_02022F2C
	ldr r1, [r0]
	movs r5, #1
	ands r1, r5
	lsls r0, r1, #3
	subs r0, r0, r1
	lsls r0, r0, #1
	adds r0, r4, r0
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
	bl sub_02009480
	ldr r3, =gUnknown_02025238
	ldr r1, =0x00000FF8
	ldr r0, =gUnknown_02022F30
	ldr r0, [r0]
	adds r0, r0, r1
	ldrb r0, [r0]
	mvns r2, r0
	lsls r2, r2, #0x18
	lsrs r2, r2, #0x18
	ldr r3, [r3]
	adds r0, r4, #0
	bl _call_via_r3
	lsls r0, r0, #0x10
	cmp r0, #0
	bne _0200A240
	lsls r0, r4, #0x18
	lsrs r0, r0, #0x18
	ldr r2, =gUnknown_02022F28
	adds r1, r5, #0
	lsls r1, r0
	ldr r0, [r2]
	bics r0, r1
	str r0, [r2]
	bl sub_02009494
	movs r0, #1
	b _0200A256
	.align 2, 0
	.pool
_0200A240:
	lsls r0, r4, #0x18
	lsrs r0, r0, #0x18
	ldr r2, =gUnknown_02022F28
	adds r1, r5, #0
	lsls r1, r0
	ldr r0, [r2]
	orrs r0, r1
	str r0, [r2]
	bl sub_02009494
	movs r0, #0xff
_0200A256:
	pop {r4, r5}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200A260
sub_0200A260: @ 0x0200A260
	push {r4, lr}
_0200A262:
	ldr r1, =gUnknown_0202054C
	ldr r4, =gUnknown_02023F40
	ldrh r0, [r4]
	cmp r0, #0xd
	bge _0200A290
	bl sub_02009D94
	ldr r0, =gUnknown_02022F28
	ldr r0, [r0]
	movs r1, #0xff
	cmp r0, #0
	bne _0200A292
	movs r1, #1
	ldrh r0, [r4]
	adds r0, #1
	strh r0, [r4]
	b _0200A292
	.align 2, 0
	.pool
_0200A290:
	movs r1, #0xff
_0200A292:
	adds r4, r1, #0
	ldr r0, =gUnknown_02022F28
	ldr r0, [r0]
	cmp r0, #0
	beq _0200A2B0
	bl sub_0200A554
	lsls r0, r0, #0x18
	cmp r0, #0
	beq _0200A262
	ldr r0, =gUnknown_02022F10
	movs r1, #1
	ldrb r2, [r0, #4]
	orrs r1, r2
	strb r1, [r0, #4]
_0200A2B0:
	cmp r4, #0xff
	beq _0200A2C0
	movs r0, #0
	b _0200A2C2
	.align 2, 0
	.pool
_0200A2C0:
	movs r0, #1
_0200A2C2:
	pop {r4}
	pop {r1}
	bx r1

	thumb_func_start sub_0200A2C8
sub_0200A2C8: @ 0x0200A2C8
	push {r4, r5, lr}
	cmp r0, #1
	bne _0200A2D0
	b _0200A42C
_0200A2D0:
	cmp r0, #1
	bgt _0200A2DA
	cmp r0, #0
	beq _0200A2E2
	b _0200A4AE
_0200A2DA:
	cmp r0, #2
	bne _0200A2E0
	b _0200A478
_0200A2E0:
	b _0200A4AE
_0200A2E2:
	ldr r2, =gUnknown_02022F10
	ldr r1, [r2, #8]
	movs r0, #1
	orrs r1, r0
	movs r0, #0xfe
	ldrb r3, [r2, #4]
	ands r0, r3
	strb r0, [r2, #4]
	movs r0, #7
	rsbs r0, r0, #0
	ands r1, r0
	str r1, [r2, #8]
	ldr r0, =gSaveBlock2Ptr
	ldr r3, [r0]
	movs r1, #0
	ldr r0, =gUnknown_020251E8
	ldr r0, [r0]
	adds r0, #0x88
	ldr r0, [r0]
	cmp r1, r0
	bhs _0200A31C
	adds r2, r0, #0
_0200A30E:
	adds r0, r3, r1
	ldrb r0, [r0]
	cmp r0, #0
	bne _0200A354
	adds r1, #1
	cmp r1, r2
	blo _0200A30E
_0200A31C:
	movs r4, #0
	ldr r5, =gUnknown_02025244
_0200A320:
	lsls r0, r4, #0x10
	lsrs r0, r0, #0x10
	ldr r1, [r5]
	bl _call_via_r1
	adds r4, #1
	cmp r4, #0x1f
	ble _0200A320
	ldr r0, =gUnknown_02022F2C
	movs r3, #0
	str r3, [r0]
	ldr r0, =gUnknown_02022F00
	strh r3, [r0]
	ldr r0, =gUnknown_02022F28
	str r3, [r0]
	ldr r1, =gUnknown_02021370
	movs r0, #0x80
	str r0, [r1]
	ldr r2, =gUnknown_02022F10
	ldr r0, [r2, #8]
	movs r1, #8
	orrs r0, r1
	str r0, [r2, #8]
	movs r0, #4
	strb r0, [r2, #1]
	strh r3, [r2, #0x10]
_0200A354:
	ldr r1, =gUnknown_02022F30
	ldr r0, =gUnknown_02022F40
	str r0, [r1]
	ldr r0, =gUnknown_02022F24
	ldr r4, =gUnknown_02022F00
	ldrh r1, [r4]
	strh r1, [r0]
	ldr r2, =gUnknown_02022F04
	ldr r5, =gUnknown_02022F2C
	ldr r0, [r5]
	str r0, [r2]
	adds r1, #1
	strh r1, [r4]
	ldrh r0, [r4]
	movs r1, #0xe
	bl __umodsi3
	strh r0, [r4]
	ldr r0, [r5]
	adds r0, #1
	str r0, [r5]
	ldr r1, =gUnknown_02023F40
	movs r0, #0
	strh r0, [r1]
	ldr r0, =gUnknown_02022F28
	movs r1, #0
	str r1, [r0]
	ldr r4, =gUnknown_02022F10
	ldrb r0, [r4, #1]
	adds r0, #1
	strb r0, [r4, #1]
	strh r1, [r4, #0x10]
	movs r0, #5
	bl sub_02008600
	movs r5, #1
	b _0200A3DE
	.align 2, 0
	.pool
_0200A3D4:
	adds r0, r5, #0
	ldrb r1, [r4, #4]
	ands r0, r1
	cmp r0, #0
	bne _0200A46E
_0200A3DE:
	bl sub_0200A260
	cmp r0, #0
	beq _0200A3D4
	ldr r1, =gUnknown_0202136C
	movs r0, #0
	strb r0, [r1]
_0200A3EC:
	ldr r4, =gUnknown_0202054C
	bl sub_02009480
	movs r0, #0xd
	adds r1, r4, #0
	bl sub_02009F4C
	bl sub_02009494
	ldr r0, =gUnknown_02022F28
	ldr r0, [r0]
	cmp r0, #0
	beq _0200A462
	bl sub_0200A554
	lsls r0, r0, #0x18
	cmp r0, #0
	beq _0200A3EC
	ldr r0, =gUnknown_02022F10
	movs r1, #1
	ldrb r2, [r0, #4]
	orrs r1, r2
	b _0200A460
	.align 2, 0
	.pool
_0200A42C:
	movs r4, #0
_0200A42E:
	ldr r1, =gUnknown_0202054C
	movs r0, #0xe
	bl sub_0200A118
	ldr r1, =gUnknown_02022F28
	ldr r0, [r1]
	cmp r0, #0
	beq _0200A462
	adds r0, r4, #1
	lsls r0, r0, #0x18
	lsrs r4, r0, #0x18
	cmp r4, #3
	bhi _0200A458
	movs r0, #0
	str r0, [r1]
	b _0200A42E
	.align 2, 0
	.pool
_0200A458:
	ldr r0, =gUnknown_02022F10
	movs r1, #1
	ldrb r3, [r0, #4]
	orrs r1, r3
_0200A460:
	strb r1, [r0, #4]
_0200A462:
	ldr r1, =gUnknown_02022F10
	movs r0, #1
	ldrb r1, [r1, #4]
	ands r0, r1
	cmp r0, #0
	beq _0200A4AE
_0200A46E:
	movs r0, #1
	b _0200A4B0
	.align 2, 0
	.pool
_0200A478:
	movs r4, #0
_0200A47A:
	ldr r1, =gUnknown_0202054C
	movs r0, #0xe
	bl sub_0200A1B8
	ldr r1, =gUnknown_02022F28
	ldr r0, [r1]
	cmp r0, #0
	beq _0200A4AE
	adds r0, r4, #1
	lsls r0, r0, #0x18
	lsrs r4, r0, #0x18
	cmp r4, #3
	bhi _0200A4A4
	movs r0, #0
	str r0, [r1]
	b _0200A47A
	.align 2, 0
	.pool
_0200A4A4:
	ldr r0, =gUnknown_02022F10
	movs r1, #1
	ldrb r2, [r0, #4]
	orrs r1, r2
	strb r1, [r0, #4]
_0200A4AE:
	movs r0, #0
_0200A4B0:
	pop {r4, r5}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200A4BC
sub_0200A4BC: @ 0x0200A4BC
	push {r4, r5, r6, r7, lr}
	mov r7, sb
	mov r6, r8
	push {r6, r7}
	lsls r0, r0, #0x10
	lsrs r6, r0, #0x10
	movs r5, #0
	bl sub_02009480
	ldr r0, =0x00000FFF
	mov sb, r0
	ldr r0, =gUnknown_02025238
	mov r8, r0
	ldr r7, =gUnknown_02022F40
_0200A4D8:
	movs r4, #0
	adds r5, #1
_0200A4DC:
	mov r0, r8
	ldr r3, [r0]
	adds r0, r6, #0
	adds r1, r4, #0
	movs r2, #0
	bl _call_via_r3
	adds r0, r4, #1
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
	cmp r4, sb
	bls _0200A4DC
	adds r0, r6, #0
	movs r1, #0
	adds r2, r7, #0
	movs r3, #0x80
	lsls r3, r3, #5
	bl sub_0200DCC8
	adds r2, r7, #0
	movs r1, #0
	ldr r3, =0x000003FF
_0200A508:
	ldr r0, [r2]
	cmp r0, #0
	beq _0200A524
	movs r0, #1
	b _0200A532
	.align 2, 0
	.pool
_0200A524:
	adds r0, r1, #1
	lsls r0, r0, #0x10
	lsrs r1, r0, #0x10
	adds r2, #4
	cmp r1, r3
	bls _0200A508
	movs r0, #0
_0200A532:
	adds r4, r0, #0
	lsls r0, r5, #0x10
	lsrs r5, r0, #0x10
	cmp r4, #0
	beq _0200A540
	cmp r5, #0x81
	bls _0200A4D8
_0200A540:
	bl sub_02009494
	adds r0, r4, #0
	pop {r3, r4}
	mov r8, r3
	mov sb, r4
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_0200A554
sub_0200A554: @ 0x0200A554
	push {r4, r5, r6, lr}
	ldr r2, =gUnknown_02022F10
	ldr r0, [r2, #8]
	movs r1, #2
	orrs r0, r1
	str r0, [r2, #8]
	ldr r0, =gUnknown_02022F28
	ldr r1, [r0]
	cmp r1, #0
	beq _0200A5B8
	ldr r0, =gUnknown_0202136C
	ldrb r0, [r0]
	cmp r0, #2
	bhi _0200A5B8
	adds r6, r1, #0
	movs r4, #0
_0200A574:
	movs r5, #1
	lsls r5, r4
	adds r0, r6, #0
	ands r0, r5
	cmp r0, #0
	beq _0200A58E
	adds r0, r4, #0
	bl sub_0200A4BC
	lsls r0, r0, #0x18
	cmp r0, #0
	bne _0200A58E
	bics r6, r5
_0200A58E:
	adds r0, r4, #1
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
	cmp r4, #0x1f
	bls _0200A574
	ldr r0, =gUnknown_02022F28
	str r6, [r0]
	ldr r1, =gUnknown_0202136C
	ldrb r0, [r1]
	adds r0, #1
	strb r0, [r1]
	cmp r6, #0
	bne _0200A5B8
	movs r0, #0
	b _0200A5BA
	.align 2, 0
	.pool
_0200A5B8:
	movs r0, #1
_0200A5BA:
	pop {r4, r5, r6}
	pop {r1}
	bx r1

	thumb_func_start sub_0200A5C0
sub_0200A5C0: @ 0x0200A5C0
	ldr r0, =gUnknown_02022F40
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_0200A5C8
sub_0200A5C8: @ 0x0200A5C8
	ldr r0, =gUnknown_02022F2C
	movs r1, #0
	str r1, [r0]
	ldr r0, =gUnknown_02022F00
	strh r1, [r0]
	ldr r0, =gUnknown_02022F28
	str r1, [r0]
	ldr r1, =gUnknown_02021370
	movs r0, #0x80
	str r0, [r1]
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_0200A5F0
sub_0200A5F0: @ 0x0200A5F0
	push {r4, r5, lr}
	movs r4, #0
	ldr r5, =gUnknown_02025244
_0200A5F6:
	lsls r0, r4, #0x10
	lsrs r0, r0, #0x10
	ldr r1, [r5]
	bl _call_via_r1
	adds r4, #1
	cmp r4, #0x1f
	ble _0200A5F6
	ldr r0, =gUnknown_02022F2C
	movs r1, #0
	str r1, [r0]
	ldr r0, =gUnknown_02022F00
	strh r1, [r0]
	ldr r0, =gUnknown_02022F28
	str r1, [r0]
	ldr r1, =gUnknown_02021370
	movs r0, #0x80
	str r0, [r1]
	pop {r4, r5}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_0200A634
sub_0200A634: @ 0x0200A634
	push {r4, r5, r6, lr}
	adds r6, r0, #0
	ldr r0, =gUnknown_02022F2C
	ldr r1, [r0]
	movs r0, #1
	ands r1, r0
	lsls r0, r1, #3
	subs r0, r0, r1
	lsls r5, r0, #1
	movs r4, #0
_0200A648:
	adds r0, r4, r5
	adds r1, r4, #0
	adds r2, r6, #0
	bl sub_02009C2C
	adds r4, #1
	cmp r4, #0xd
	ble _0200A648
	movs r0, #1
	pop {r4, r5, r6}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200A664
sub_0200A664: @ 0x0200A664
	push {r4, r5, r6, lr}
	adds r2, r0, #0
	adds r6, r1, #0
	ldr r1, =gUnknown_02022F30
	ldr r0, =gUnknown_02022F40
	str r0, [r1]
	cmp r2, #0
	beq _0200A684
	cmp r2, #1
	beq _0200A6B4
	b _0200A6D6
	.align 2, 0
	.pool
_0200A684:
	ldr r4, =gUnknown_02021370
	adds r0, r6, #0
	bl sub_020099D0
	lsls r0, r0, #0x10
	lsrs r0, r0, #0x10
	str r0, [r4]
	ldr r0, =gUnknown_02022F2C
	ldr r1, [r0]
	movs r0, #1
	ands r1, r0
	lsls r0, r1, #3
	subs r0, r0, r1
	lsls r0, r0, #1
	movs r1, #0
	adds r2, r6, #0
	bl sub_02009C2C
	ldr r0, [r4]
	b _0200A6D6
	.align 2, 0
	.pool
_0200A6B4:
	ldr r0, =gUnknown_02022F2C
	ldr r1, [r0]
	ands r1, r2
	lsls r0, r1, #3
	subs r0, r0, r1
	lsls r5, r0, #1
	movs r4, #0
_0200A6C2:
	adds r0, r4, r5
	adds r1, r4, #0
	adds r2, r6, #0
	bl sub_02009C2C
	adds r4, #1
	cmp r4, #0xd
	ble _0200A6C2
	ldr r0, =gUnknown_02021370
	ldr r0, [r0]
_0200A6D6:
	pop {r4, r5, r6}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200A6E4
sub_0200A6E4: @ 0x0200A6E4
	push {r4, r5, r6, r7, lr}
	adds r7, r1, #0
	lsls r0, r0, #0x10
	lsrs r2, r0, #0x10
	ldr r1, =gUnknown_02022F30
	ldr r0, =gUnknown_02022F40
	str r0, [r1]
	ldr r0, =0x0000FFFF
	cmp r2, r0
	beq _0200A710
	adds r0, r2, #0
	adds r1, r7, #0
	bl sub_02009D94
	adds r5, r0, #0
	b _0200A760
	.align 2, 0
	.pool
_0200A710:
	ldr r1, =gUnknown_02022F24
	ldr r5, =gUnknown_02022F00
	ldrh r0, [r5]
	strh r0, [r1]
	ldr r1, =gUnknown_02022F04
	ldr r6, =gUnknown_02022F2C
	ldr r4, [r6]
	str r4, [r1]
	adds r0, #1
	strh r0, [r5]
	ldrh r0, [r5]
	movs r1, #0xe
	bl __umodsi3
	strh r0, [r5]
	adds r4, #1
	str r4, [r6]
	movs r5, #1
	movs r4, #0
_0200A736:
	lsls r0, r4, #0x10
	lsrs r0, r0, #0x10
	adds r1, r7, #0
	bl sub_02009D94
	adds r4, #1
	cmp r4, #0xd
	ble _0200A736
	ldr r0, =gUnknown_02022F28
	ldr r0, [r0]
	cmp r0, #0
	beq _0200A760
	movs r5, #0xff
	ldr r1, =gUnknown_02022F00
	ldr r0, =gUnknown_02022F24
	ldrh r0, [r0]
	strh r0, [r1]
	ldr r1, =gUnknown_02022F2C
	ldr r0, =gUnknown_02022F04
	ldr r0, [r0]
	str r0, [r1]
_0200A760:
	adds r0, r5, #0
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200A77C
sub_0200A77C: @ 0x0200A77C
	push {r4, r5, r6, lr}
	ldr r1, =gUnknown_02022F30
	ldr r0, =gUnknown_02022F40
	str r0, [r1]
	ldr r1, =gUnknown_02022F24
	ldr r5, =gUnknown_02022F00
	ldrh r0, [r5]
	strh r0, [r1]
	ldr r1, =gUnknown_02022F04
	ldr r6, =gUnknown_02022F2C
	ldr r4, [r6]
	str r4, [r1]
	adds r0, #1
	strh r0, [r5]
	ldrh r0, [r5]
	movs r1, #0xe
	bl __umodsi3
	strh r0, [r5]
	adds r4, #1
	str r4, [r6]
	ldr r1, =gUnknown_02023F40
	movs r0, #0
	strh r0, [r1]
	ldr r1, =gUnknown_02022F28
	movs r0, #0
	str r0, [r1]
	pop {r4, r5, r6}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200A7D8
sub_0200A7D8: @ 0x0200A7D8
	ldr r1, =gUnknown_02022F30
	ldr r0, =gUnknown_02022F40
	str r0, [r1]
	ldr r1, =gUnknown_02022F24
	ldr r0, =gUnknown_02022F00
	ldrh r0, [r0]
	strh r0, [r1]
	ldr r1, =gUnknown_02022F04
	ldr r0, =gUnknown_02022F2C
	ldr r0, [r0]
	str r0, [r1]
	ldr r1, =gUnknown_02023F40
	movs r0, #0
	strh r0, [r1]
	ldr r1, =gUnknown_02022F28
	movs r0, #0
	str r0, [r1]
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_0200A81C
sub_0200A81C: @ 0x0200A81C
	ldr r1, =gUnknown_02022F00
	ldr r0, =gUnknown_02022F24
	ldrh r0, [r0]
	strh r0, [r1]
	ldr r1, =gUnknown_02022F2C
	ldr r0, =gUnknown_02022F04
	ldr r0, [r0]
	str r0, [r1]
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_0200A840
sub_0200A840: @ 0x0200A840
	push {r4, lr}
	lsls r0, r0, #0x10
	lsrs r0, r0, #0x10
	ldr r4, =gUnknown_02023F40
	ldrh r2, [r4]
	subs r0, #1
	cmp r2, r0
	bge _0200A874
	adds r0, r2, #0
	bl sub_02009D94
	ldr r0, =gUnknown_02022F28
	ldr r0, [r0]
	movs r1, #0xff
	cmp r0, #0
	bne _0200A876
	movs r1, #1
	ldrh r0, [r4]
	adds r0, #1
	strh r0, [r4]
	b _0200A876
	.align 2, 0
	.pool
_0200A874:
	movs r1, #0xff
_0200A876:
	adds r0, r1, #0
	pop {r4}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_0200A880
sub_0200A880: @ 0x0200A880
	push {r4, r5, r6, lr}
	adds r4, r0, #0
	adds r5, r1, #0
	lsls r4, r4, #0x10
	lsrs r4, r4, #0x10
	movs r6, #1
	bl sub_02009480
	subs r4, #1
	lsls r4, r4, #0x10
	lsrs r4, r4, #0x10
	adds r0, r4, #0
	adds r1, r5, #0
	bl sub_02009F4C
	bl sub_02009494
	ldr r0, =gUnknown_02022F28
	ldr r0, [r0]
	cmp r0, #0
	beq _0200A8AC
	movs r6, #0xff
_0200A8AC:
	adds r0, r6, #0
	pop {r4, r5, r6}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200A8B8
sub_0200A8B8: @ 0x0200A8B8
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #0x4c
	lsls r2, r2, #0x18
	lsrs r4, r2, #0x18
	movs r5, #0
	adds r0, #0x20
	str r0, [sp, #4]
	str r0, [sp]
	str r0, [sp, #0xc]
	str r0, [sp, #8]
	str r0, [sp, #0x14]
	str r0, [sp, #0x10]
	str r0, [sp, #0x1c]
	str r0, [sp, #0x18]
	str r0, [sp, #0x24]
	str r0, [sp, #0x20]
	str r0, [sp, #0x2c]
	str r0, [sp, #0x28]
	mov sl, r0
	str r0, [sp, #0x30]
	mov r8, sl
	str r0, [sp, #0x34]
	mov r3, r8
	str r3, [sp, #0x38]
	adds r7, r3, #0
	str r7, [sp, #0x3c]
	adds r6, r7, #0
	str r6, [sp, #0x40]
	adds r2, r6, #0
	mov sb, r2
	adds r0, r1, #0
	movs r1, #0x18
	str r2, [sp, #0x44]
	str r3, [sp, #0x48]
	bl __umodsi3
	ldr r2, [sp, #0x44]
	ldr r3, [sp, #0x48]
	cmp r0, #0x17
	bls _0200A912
	b _0200ADCE
_0200A912:
	lsls r0, r0, #2
	ldr r1, =_0200A920
	adds r0, r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
	.pool
_0200A920: @ jump table
	.4byte _0200A980 @ case 0
	.4byte _0200A9AE @ case 1
	.4byte _0200A9DC @ case 2
	.4byte _0200AA0A @ case 3
	.4byte _0200AA38 @ case 4
	.4byte _0200AA66 @ case 5
	.4byte _0200AA94 @ case 6
	.4byte _0200AAC2 @ case 7
	.4byte _0200AAF0 @ case 8
	.4byte _0200AB1E @ case 9
	.4byte _0200AB4C @ case 10
	.4byte _0200AB7A @ case 11
	.4byte _0200ABA8 @ case 12
	.4byte _0200ABD6 @ case 13
	.4byte _0200AC04 @ case 14
	.4byte _0200AC32 @ case 15
	.4byte _0200AC60 @ case 16
	.4byte _0200AC8E @ case 17
	.4byte _0200ACBC @ case 18
	.4byte _0200ACEA @ case 19
	.4byte _0200AD18 @ case 20
	.4byte _0200AD46 @ case 21
	.4byte _0200AD74 @ case 22
	.4byte _0200ADA2 @ case 23
_0200A980:
	cmp r4, #1
	beq _0200A99C
	cmp r4, #1
	bgt _0200A98E
	cmp r4, #0
	beq _0200A998
	b _0200ADCE
_0200A98E:
	cmp r4, #2
	beq _0200A9A2
	cmp r4, #3
	beq _0200A9A8
	b _0200ADCE
_0200A998:
	ldr r5, [sp]
	b _0200ADCE
_0200A99C:
	ldr r5, [sp]
	adds r5, #0xc
	b _0200ADCE
_0200A9A2:
	ldr r5, [sp]
	adds r5, #0x18
	b _0200ADCE
_0200A9A8:
	ldr r5, [sp]
	adds r5, #0x24
	b _0200ADCE
_0200A9AE:
	cmp r4, #1
	beq _0200A9CA
	cmp r4, #1
	bgt _0200A9BC
	cmp r4, #0
	beq _0200A9C6
	b _0200ADCE
_0200A9BC:
	cmp r4, #2
	beq _0200A9D0
	cmp r4, #3
	beq _0200A9D6
	b _0200ADCE
_0200A9C6:
	ldr r5, [sp, #4]
	b _0200ADCE
_0200A9CA:
	ldr r5, [sp, #4]
	adds r5, #0xc
	b _0200ADCE
_0200A9D0:
	ldr r5, [sp, #4]
	adds r5, #0x24
	b _0200ADCE
_0200A9D6:
	ldr r5, [sp, #4]
	adds r5, #0x18
	b _0200ADCE
_0200A9DC:
	cmp r4, #1
	beq _0200A9F8
	cmp r4, #1
	bgt _0200A9EA
	cmp r4, #0
	beq _0200A9F4
	b _0200ADCE
_0200A9EA:
	cmp r4, #2
	beq _0200A9FE
	cmp r4, #3
	beq _0200AA04
	b _0200ADCE
_0200A9F4:
	ldr r5, [sp, #8]
	b _0200ADCE
_0200A9F8:
	ldr r5, [sp, #8]
	adds r5, #0x18
	b _0200ADCE
_0200A9FE:
	ldr r5, [sp, #8]
	adds r5, #0xc
	b _0200ADCE
_0200AA04:
	ldr r5, [sp, #8]
	adds r5, #0x24
	b _0200ADCE
_0200AA0A:
	cmp r4, #1
	beq _0200AA26
	cmp r4, #1
	bgt _0200AA18
	cmp r4, #0
	beq _0200AA22
	b _0200ADCE
_0200AA18:
	cmp r4, #2
	beq _0200AA2C
	cmp r4, #3
	beq _0200AA32
	b _0200ADCE
_0200AA22:
	ldr r5, [sp, #0xc]
	b _0200ADCE
_0200AA26:
	ldr r5, [sp, #0xc]
	adds r5, #0x24
	b _0200ADCE
_0200AA2C:
	ldr r5, [sp, #0xc]
	adds r5, #0xc
	b _0200ADCE
_0200AA32:
	ldr r5, [sp, #0xc]
	adds r5, #0x18
	b _0200ADCE
_0200AA38:
	cmp r4, #1
	beq _0200AA54
	cmp r4, #1
	bgt _0200AA46
	cmp r4, #0
	beq _0200AA50
	b _0200ADCE
_0200AA46:
	cmp r4, #2
	beq _0200AA5A
	cmp r4, #3
	beq _0200AA60
	b _0200ADCE
_0200AA50:
	ldr r5, [sp, #0x10]
	b _0200ADCE
_0200AA54:
	ldr r5, [sp, #0x10]
	adds r5, #0x18
	b _0200ADCE
_0200AA5A:
	ldr r5, [sp, #0x10]
	adds r5, #0x24
	b _0200ADCE
_0200AA60:
	ldr r5, [sp, #0x10]
	adds r5, #0xc
	b _0200ADCE
_0200AA66:
	cmp r4, #1
	beq _0200AA82
	cmp r4, #1
	bgt _0200AA74
	cmp r4, #0
	beq _0200AA7E
	b _0200ADCE
_0200AA74:
	cmp r4, #2
	beq _0200AA88
	cmp r4, #3
	beq _0200AA8E
	b _0200ADCE
_0200AA7E:
	ldr r5, [sp, #0x14]
	b _0200ADCE
_0200AA82:
	ldr r5, [sp, #0x14]
	adds r5, #0x24
	b _0200ADCE
_0200AA88:
	ldr r5, [sp, #0x14]
	adds r5, #0x18
	b _0200ADCE
_0200AA8E:
	ldr r5, [sp, #0x14]
	adds r5, #0xc
	b _0200ADCE
_0200AA94:
	cmp r4, #1
	beq _0200AAB2
	cmp r4, #1
	bgt _0200AAA2
	cmp r4, #0
	beq _0200AAAC
	b _0200ADCE
_0200AAA2:
	cmp r4, #2
	beq _0200AAB6
	cmp r4, #3
	beq _0200AABC
	b _0200ADCE
_0200AAAC:
	ldr r5, [sp, #0x18]
	adds r5, #0xc
	b _0200ADCE
_0200AAB2:
	ldr r5, [sp, #0x18]
	b _0200ADCE
_0200AAB6:
	ldr r5, [sp, #0x18]
	adds r5, #0x18
	b _0200ADCE
_0200AABC:
	ldr r5, [sp, #0x18]
	adds r5, #0x24
	b _0200ADCE
_0200AAC2:
	cmp r4, #1
	beq _0200AAE0
	cmp r4, #1
	bgt _0200AAD0
	cmp r4, #0
	beq _0200AADA
	b _0200ADCE
_0200AAD0:
	cmp r4, #2
	beq _0200AAE4
	cmp r4, #3
	beq _0200AAEA
	b _0200ADCE
_0200AADA:
	ldr r5, [sp, #0x1c]
	adds r5, #0xc
	b _0200ADCE
_0200AAE0:
	ldr r5, [sp, #0x1c]
	b _0200ADCE
_0200AAE4:
	ldr r5, [sp, #0x1c]
	adds r5, #0x24
	b _0200ADCE
_0200AAEA:
	ldr r5, [sp, #0x1c]
	adds r5, #0x18
	b _0200ADCE
_0200AAF0:
	cmp r4, #1
	beq _0200AB0E
	cmp r4, #1
	bgt _0200AAFE
	cmp r4, #0
	beq _0200AB08
	b _0200ADCE
_0200AAFE:
	cmp r4, #2
	beq _0200AB12
	cmp r4, #3
	beq _0200AB18
	b _0200ADCE
_0200AB08:
	ldr r5, [sp, #0x20]
	adds r5, #0x18
	b _0200ADCE
_0200AB0E:
	ldr r5, [sp, #0x20]
	b _0200ADCE
_0200AB12:
	ldr r5, [sp, #0x20]
	adds r5, #0xc
	b _0200ADCE
_0200AB18:
	ldr r5, [sp, #0x20]
	adds r5, #0x24
	b _0200ADCE
_0200AB1E:
	cmp r4, #1
	beq _0200AB3C
	cmp r4, #1
	bgt _0200AB2C
	cmp r4, #0
	beq _0200AB36
	b _0200ADCE
_0200AB2C:
	cmp r4, #2
	beq _0200AB40
	cmp r4, #3
	beq _0200AB46
	b _0200ADCE
_0200AB36:
	ldr r5, [sp, #0x24]
	adds r5, #0x24
	b _0200ADCE
_0200AB3C:
	ldr r5, [sp, #0x24]
	b _0200ADCE
_0200AB40:
	ldr r5, [sp, #0x24]
	adds r5, #0xc
	b _0200ADCE
_0200AB46:
	ldr r5, [sp, #0x24]
	adds r5, #0x18
	b _0200ADCE
_0200AB4C:
	cmp r4, #1
	beq _0200AB6A
	cmp r4, #1
	bgt _0200AB5A
	cmp r4, #0
	beq _0200AB64
	b _0200ADCE
_0200AB5A:
	cmp r4, #2
	beq _0200AB6E
	cmp r4, #3
	beq _0200AB74
	b _0200ADCE
_0200AB64:
	ldr r5, [sp, #0x28]
	adds r5, #0x18
	b _0200ADCE
_0200AB6A:
	ldr r5, [sp, #0x28]
	b _0200ADCE
_0200AB6E:
	ldr r5, [sp, #0x28]
	adds r5, #0x24
	b _0200ADCE
_0200AB74:
	ldr r5, [sp, #0x28]
	adds r5, #0xc
	b _0200ADCE
_0200AB7A:
	cmp r4, #1
	beq _0200AB98
	cmp r4, #1
	bgt _0200AB88
	cmp r4, #0
	beq _0200AB92
	b _0200ADCE
_0200AB88:
	cmp r4, #2
	beq _0200AB9C
	cmp r4, #3
	beq _0200ABA2
	b _0200ADCE
_0200AB92:
	ldr r5, [sp, #0x2c]
	adds r5, #0x24
	b _0200ADCE
_0200AB98:
	ldr r5, [sp, #0x2c]
	b _0200ADCE
_0200AB9C:
	ldr r5, [sp, #0x2c]
	adds r5, #0x18
	b _0200ADCE
_0200ABA2:
	ldr r5, [sp, #0x2c]
	adds r5, #0xc
	b _0200ADCE
_0200ABA8:
	cmp r4, #1
	beq _0200ABC6
	cmp r4, #1
	bgt _0200ABB6
	cmp r4, #0
	beq _0200ABC0
	b _0200ADCE
_0200ABB6:
	cmp r4, #2
	beq _0200ABCC
	cmp r4, #3
	beq _0200ABD0
	b _0200ADCE
_0200ABC0:
	ldr r5, [sp, #0x30]
	adds r5, #0xc
	b _0200ADCE
_0200ABC6:
	ldr r5, [sp, #0x30]
	adds r5, #0x18
	b _0200ADCE
_0200ABCC:
	ldr r5, [sp, #0x30]
	b _0200ADCE
_0200ABD0:
	ldr r5, [sp, #0x30]
	adds r5, #0x24
	b _0200ADCE
_0200ABD6:
	cmp r4, #1
	beq _0200ABF4
	cmp r4, #1
	bgt _0200ABE4
	cmp r4, #0
	beq _0200ABEE
	b _0200ADCE
_0200ABE4:
	cmp r4, #2
	beq _0200ABFA
	cmp r4, #3
	beq _0200ABFE
	b _0200ADCE
_0200ABEE:
	mov r5, sl
	adds r5, #0xc
	b _0200ADCE
_0200ABF4:
	mov r5, sl
	adds r5, #0x24
	b _0200ADCE
_0200ABFA:
	mov r5, sl
	b _0200ADCE
_0200ABFE:
	mov r5, sl
	adds r5, #0x18
	b _0200ADCE
_0200AC04:
	cmp r4, #1
	beq _0200AC22
	cmp r4, #1
	bgt _0200AC12
	cmp r4, #0
	beq _0200AC1C
	b _0200ADCE
_0200AC12:
	cmp r4, #2
	beq _0200AC28
	cmp r4, #3
	beq _0200AC2C
	b _0200ADCE
_0200AC1C:
	ldr r5, [sp, #0x34]
	adds r5, #0x18
	b _0200ADCE
_0200AC22:
	ldr r5, [sp, #0x34]
	adds r5, #0xc
	b _0200ADCE
_0200AC28:
	ldr r5, [sp, #0x34]
	b _0200ADCE
_0200AC2C:
	ldr r5, [sp, #0x34]
	adds r5, #0x24
	b _0200ADCE
_0200AC32:
	cmp r4, #1
	beq _0200AC50
	cmp r4, #1
	bgt _0200AC40
	cmp r4, #0
	beq _0200AC4A
	b _0200ADCE
_0200AC40:
	cmp r4, #2
	beq _0200AC56
	cmp r4, #3
	beq _0200AC5A
	b _0200ADCE
_0200AC4A:
	mov r5, r8
	adds r5, #0x24
	b _0200ADCE
_0200AC50:
	mov r5, r8
	adds r5, #0xc
	b _0200ADCE
_0200AC56:
	mov r5, r8
	b _0200ADCE
_0200AC5A:
	mov r5, r8
	adds r5, #0x18
	b _0200ADCE
_0200AC60:
	cmp r4, #1
	beq _0200AC7E
	cmp r4, #1
	bgt _0200AC6E
	cmp r4, #0
	beq _0200AC78
	b _0200ADCE
_0200AC6E:
	cmp r4, #2
	beq _0200AC84
	cmp r4, #3
	beq _0200AC88
	b _0200ADCE
_0200AC78:
	ldr r5, [sp, #0x38]
	adds r5, #0x18
	b _0200ADCE
_0200AC7E:
	ldr r5, [sp, #0x38]
	adds r5, #0x24
	b _0200ADCE
_0200AC84:
	ldr r5, [sp, #0x38]
	b _0200ADCE
_0200AC88:
	ldr r5, [sp, #0x38]
	adds r5, #0xc
	b _0200ADCE
_0200AC8E:
	cmp r4, #1
	beq _0200ACAC
	cmp r4, #1
	bgt _0200AC9C
	cmp r4, #0
	beq _0200ACA6
	b _0200ADCE
_0200AC9C:
	cmp r4, #2
	beq _0200ACB2
	cmp r4, #3
	beq _0200ACB6
	b _0200ADCE
_0200ACA6:
	adds r5, r3, #0
	adds r5, #0x24
	b _0200ADCE
_0200ACAC:
	adds r5, r3, #0
	adds r5, #0x18
	b _0200ADCE
_0200ACB2:
	adds r5, r3, #0
	b _0200ADCE
_0200ACB6:
	adds r5, r3, #0
	adds r5, #0xc
	b _0200ADCE
_0200ACBC:
	cmp r4, #1
	beq _0200ACDA
	cmp r4, #1
	bgt _0200ACCA
	cmp r4, #0
	beq _0200ACD4
	b _0200ADCE
_0200ACCA:
	cmp r4, #2
	beq _0200ACE0
	cmp r4, #3
	beq _0200ACE6
	b _0200ADCE
_0200ACD4:
	ldr r5, [sp, #0x3c]
	adds r5, #0xc
	b _0200ADCE
_0200ACDA:
	ldr r5, [sp, #0x3c]
	adds r5, #0x18
	b _0200ADCE
_0200ACE0:
	ldr r5, [sp, #0x3c]
	adds r5, #0x24
	b _0200ADCE
_0200ACE6:
	ldr r5, [sp, #0x3c]
	b _0200ADCE
_0200ACEA:
	cmp r4, #1
	beq _0200AD08
	cmp r4, #1
	bgt _0200ACF8
	cmp r4, #0
	beq _0200AD02
	b _0200ADCE
_0200ACF8:
	cmp r4, #2
	beq _0200AD0E
	cmp r4, #3
	beq _0200AD14
	b _0200ADCE
_0200AD02:
	adds r5, r7, #0
	adds r5, #0xc
	b _0200ADCE
_0200AD08:
	adds r5, r7, #0
	adds r5, #0x24
	b _0200ADCE
_0200AD0E:
	adds r5, r7, #0
	adds r5, #0x18
	b _0200ADCE
_0200AD14:
	adds r5, r7, #0
	b _0200ADCE
_0200AD18:
	cmp r4, #1
	beq _0200AD36
	cmp r4, #1
	bgt _0200AD26
	cmp r4, #0
	beq _0200AD30
	b _0200ADCE
_0200AD26:
	cmp r4, #2
	beq _0200AD3C
	cmp r4, #3
	beq _0200AD42
	b _0200ADCE
_0200AD30:
	ldr r5, [sp, #0x40]
	adds r5, #0x18
	b _0200ADCE
_0200AD36:
	ldr r5, [sp, #0x40]
	adds r5, #0xc
	b _0200ADCE
_0200AD3C:
	ldr r5, [sp, #0x40]
	adds r5, #0x24
	b _0200ADCE
_0200AD42:
	ldr r5, [sp, #0x40]
	b _0200ADCE
_0200AD46:
	cmp r4, #1
	beq _0200AD64
	cmp r4, #1
	bgt _0200AD54
	cmp r4, #0
	beq _0200AD5E
	b _0200ADCE
_0200AD54:
	cmp r4, #2
	beq _0200AD6A
	cmp r4, #3
	beq _0200AD70
	b _0200ADCE
_0200AD5E:
	adds r5, r6, #0
	adds r5, #0x24
	b _0200ADCE
_0200AD64:
	adds r5, r6, #0
	adds r5, #0xc
	b _0200ADCE
_0200AD6A:
	adds r5, r6, #0
	adds r5, #0x18
	b _0200ADCE
_0200AD70:
	adds r5, r6, #0
	b _0200ADCE
_0200AD74:
	cmp r4, #1
	beq _0200AD92
	cmp r4, #1
	bgt _0200AD82
	cmp r4, #0
	beq _0200AD8C
	b _0200ADCE
_0200AD82:
	cmp r4, #2
	beq _0200AD98
	cmp r4, #3
	beq _0200AD9E
	b _0200ADCE
_0200AD8C:
	mov r5, sb
	adds r5, #0x18
	b _0200ADCE
_0200AD92:
	mov r5, sb
	adds r5, #0x24
	b _0200ADCE
_0200AD98:
	mov r5, sb
	adds r5, #0xc
	b _0200ADCE
_0200AD9E:
	mov r5, sb
	b _0200ADCE
_0200ADA2:
	cmp r4, #1
	beq _0200ADC0
	cmp r4, #1
	bgt _0200ADB0
	cmp r4, #0
	beq _0200ADBA
	b _0200ADCE
_0200ADB0:
	cmp r4, #2
	beq _0200ADC6
	cmp r4, #3
	beq _0200ADCC
	b _0200ADCE
_0200ADBA:
	adds r5, r2, #0
	adds r5, #0x24
	b _0200ADCE
_0200ADC0:
	adds r5, r2, #0
	adds r5, #0x18
	b _0200ADCE
_0200ADC6:
	adds r5, r2, #0
	adds r5, #0xc
	b _0200ADCE
_0200ADCC:
	adds r5, r2, #0
_0200ADCE:
	adds r0, r5, #0
	add sp, #0x4c
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1

	thumb_func_start sub_0200ADE0
sub_0200ADE0: @ 0x0200ADE0
	push {r4, r5, r6, r7, lr}
	mov r7, r8
	push {r7}
	adds r4, r0, #0
	movs r6, #0
	ldr r1, [r4]
	movs r2, #0
	bl sub_0200A8B8
	adds r5, r0, #0
	ldr r1, [r4]
	adds r0, r4, #0
	movs r2, #1
	bl sub_0200A8B8
	adds r7, r0, #0
	ldr r1, [r4]
	adds r0, r4, #0
	movs r2, #2
	bl sub_0200A8B8
	mov r8, r0
	ldr r1, [r4]
	adds r0, r4, #0
	movs r2, #3
	bl sub_0200A8B8
	adds r3, r0, #0
	movs r1, #5
_0200AE1A:
	ldrh r2, [r5]
	adds r0, r2, r6
	lsls r0, r0, #0x10
	lsrs r6, r0, #0x10
	adds r5, #2
	subs r1, #1
	cmp r1, #0
	bge _0200AE1A
	adds r2, r7, #0
	movs r1, #5
_0200AE2E:
	ldrh r4, [r2]
	adds r0, r4, r6
	lsls r0, r0, #0x10
	lsrs r6, r0, #0x10
	adds r2, #2
	subs r1, #1
	cmp r1, #0
	bge _0200AE2E
	mov r2, r8
	movs r1, #5
_0200AE42:
	ldrh r4, [r2]
	adds r0, r4, r6
	lsls r0, r0, #0x10
	lsrs r6, r0, #0x10
	adds r2, #2
	subs r1, #1
	cmp r1, #0
	bge _0200AE42
	adds r2, r3, #0
	movs r1, #5
_0200AE56:
	ldrh r3, [r2]
	adds r0, r3, r6
	lsls r0, r0, #0x10
	lsrs r6, r0, #0x10
	adds r2, #2
	subs r1, #1
	cmp r1, #0
	bge _0200AE56
	adds r0, r6, #0
	pop {r3}
	mov r8, r3
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_0200AE74
sub_0200AE74: @ 0x0200AE74
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #0x18
	mov r8, r0
	str r1, [sp, #0x10]
	adds r6, r2, #0
	movs r4, #0
	mov sb, r4
	mov sl, r4
	movs r7, #0
	movs r5, #0
	cmp r1, #0xa
	ble _0200AF14
	ldr r1, [r0]
	movs r2, #0
	bl sub_0200A8B8
	mov sb, r0
	mov r0, r8
	ldr r1, [r0]
	movs r2, #1
	bl sub_0200A8B8
	mov sl, r0
	mov r2, r8
	ldr r1, [r2]
	mov r0, r8
	movs r2, #2
	bl sub_0200A8B8
	adds r7, r0, #0
	mov r3, r8
	ldr r1, [r3]
	mov r0, r8
	movs r2, #3
	bl sub_0200A8B8
	adds r5, r0, #0
	movs r0, #0
	str r0, [sp, #0x14]
	mov r2, r8
	adds r2, #0x20
_0200AECE:
	ldr r0, [r2]
	mov r1, r8
	ldr r1, [r1, #4]
	eors r0, r1
	str r0, [r2]
	mov r3, r8
	ldr r3, [r3]
	eors r0, r3
	stm r2!, {r0}
	ldr r0, [sp, #0x14]
	adds r0, #1
	str r0, [sp, #0x14]
	cmp r0, #0xb
	bls _0200AECE
	mov r0, r8
	bl sub_0200ADE0
	lsls r0, r0, #0x10
	lsrs r0, r0, #0x10
	mov r1, r8
	ldrh r1, [r1, #0x1c]
	cmp r0, r1
	beq _0200AF14
	movs r0, #1
	mov r2, r8
	ldrb r2, [r2, #0x13]
	orrs r0, r2
	movs r1, #4
	orrs r0, r1
	mov r3, r8
	strb r0, [r3, #0x13]
	movs r0, #0x40
	ldrb r1, [r5, #7]
	orrs r0, r1
	strb r0, [r5, #7]
_0200AF14:
	ldr r2, [sp, #0x10]
	cmp r2, #0x52
	bls _0200AF1C
	b _0200B4AC
_0200AF1C:
	lsls r0, r2, #2
	ldr r1, =_0200AF2C
	adds r0, r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
	.pool
_0200AF2C: @ jump table
	.4byte _0200B078 @ case 0
	.4byte _0200B07E @ case 1
	.4byte _0200B084 @ case 2
	.4byte _0200B108 @ case 3
	.4byte _0200B10E @ case 4
	.4byte _0200B114 @ case 5
	.4byte _0200B11E @ case 6
	.4byte _0200B128 @ case 7
	.4byte _0200B16C @ case 8
	.4byte _0200B172 @ case 9
	.4byte _0200B178 @ case 10
	.4byte _0200B17E @ case 11
	.4byte _0200B196 @ case 12
	.4byte _0200B1AE @ case 13
	.4byte _0200B1AE @ case 14
	.4byte _0200B1AE @ case 15
	.4byte _0200B1AE @ case 16
	.4byte _0200B1BA @ case 17
	.4byte _0200B1BA @ case 18
	.4byte _0200B1BA @ case 19
	.4byte _0200B1BA @ case 20
	.4byte _0200B1A2 @ case 21
	.4byte _0200B1DC @ case 22
	.4byte _0200B1E0 @ case 23
	.4byte _0200B1E4 @ case 24
	.4byte _0200B19C @ case 25
	.4byte _0200B1C4 @ case 26
	.4byte _0200B1C8 @ case 27
	.4byte _0200B1CC @ case 28
	.4byte _0200B1D0 @ case 29
	.4byte _0200B1D4 @ case 30
	.4byte _0200B1D8 @ case 31
	.4byte _0200B1A8 @ case 32
	.4byte _0200B1E8 @ case 33
	.4byte _0200B1F4 @ case 34
	.4byte _0200B1F8 @ case 35
	.4byte _0200B1FC @ case 36
	.4byte _0200B204 @ case 37
	.4byte _0200B20C @ case 38
	.4byte _0200B21A @ case 39
	.4byte _0200B222 @ case 40
	.4byte _0200B22A @ case 41
	.4byte _0200B232 @ case 42
	.4byte _0200B23A @ case 43
	.4byte _0200B242 @ case 44
	.4byte _0200B24A @ case 45
	.4byte _0200B24E @ case 46
	.4byte _0200B1EC @ case 47
	.4byte _0200B1F0 @ case 48
	.4byte _0200B214 @ case 49
	.4byte _0200B254 @ case 50
	.4byte _0200B25C @ case 51
	.4byte _0200B264 @ case 52
	.4byte _0200B26C @ case 53
	.4byte _0200B274 @ case 54
	.4byte _0200B4AC @ case 55
	.4byte _0200B4AC @ case 56
	.4byte _0200B4AC @ case 57
	.4byte _0200B4AC @ case 58
	.4byte _0200B4AC @ case 59
	.4byte _0200B4AC @ case 60
	.4byte _0200B4AC @ case 61
	.4byte _0200B4AC @ case 62
	.4byte _0200B4AC @ case 63
	.4byte _0200B4AC @ case 64
	.4byte _0200B2D2 @ case 65
	.4byte _0200B2F8 @ case 66
	.4byte _0200B27C @ case 67
	.4byte _0200B282 @ case 68
	.4byte _0200B286 @ case 69
	.4byte _0200B28A @ case 70
	.4byte _0200B28E @ case 71
	.4byte _0200B296 @ case 72
	.4byte _0200B29E @ case 73
	.4byte _0200B2A6 @ case 74
	.4byte _0200B2AE @ case 75
	.4byte _0200B2B4 @ case 76
	.4byte _0200B2BC @ case 77
	.4byte _0200B2C4 @ case 78
	.4byte _0200B2CC @ case 79
	.4byte _0200B332 @ case 80
	.4byte _0200B390 @ case 81
	.4byte _0200B412 @ case 82
_0200B078:
	mov r3, r8
	ldr r4, [r3]
	b _0200B4AC
_0200B07E:
	mov r5, r8
	ldr r4, [r5, #4]
	b _0200B4AC
_0200B084:
	mov r7, r8
	ldrb r1, [r7, #0x13]
	movs r0, #1
	ands r0, r1
	cmp r0, #0
	beq _0200B0A0
	ldr r1, =gUnknown_0202062C
_0200B092:
	adds r0, r6, #0
	bl StringCopy
	b _0200B0FC
	.align 2, 0
	.pool
_0200B0A0:
	movs r0, #4
	ands r0, r1
	cmp r0, #0
	beq _0200B0B0
	ldr r1, =gUnknown_0201E808
	b _0200B092
	.align 2, 0
	.pool
_0200B0B0:
	movs r4, #0
	mov r1, r8
	adds r1, #8
	mov r2, r8
	ldrb r0, [r2, #8]
	ldrb r3, [r2, #0x12]
	cmp r0, #0xff
	beq _0200B0D6
	adds r2, r1, #0
_0200B0C2:
	adds r1, r6, r4
	ldrb r0, [r2]
	strb r0, [r1]
	adds r2, #1
	adds r4, #1
	cmp r4, #9
	bhi _0200B0D6
	ldrb r0, [r2]
	cmp r0, #0xff
	bne _0200B0C2
_0200B0D6:
	adds r1, r6, r4
	movs r0, #0xff
	strb r0, [r1]
	cmp r3, #1
	bne _0200B0FC
	mov r1, sp
	movs r0, #0xfc
	strb r0, [r1]
	movs r0, #0x15
	strb r0, [r1, #1]
	mov r0, sp
	adds r0, #2
	adds r1, r6, #0
	bl StringCopy
	adds r0, r6, #0
	mov r1, sp
	bl StringCopy
_0200B0FC:
	adds r0, r6, #0
	bl sub_0200CE1C
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
	b _0200B4AC
_0200B108:
	mov r3, r8
	ldrb r4, [r3, #0x12]
	b _0200B4AC
_0200B10E:
	mov r5, r8
	ldrb r5, [r5, #0x13]
	b _0200B2B6
_0200B114:
	mov r6, r8
	ldrb r6, [r6, #0x13]
	lsls r0, r6, #0x1e
	lsrs r4, r0, #0x1f
	b _0200B4AC
_0200B11E:
	mov r7, r8
	ldrb r7, [r7, #0x13]
	lsls r0, r7, #0x1d
	lsrs r4, r0, #0x1f
	b _0200B4AC
_0200B128:
	movs r4, #0
	ldr r3, =gUnknown_020251E8
	ldr r0, [r3]
	adds r0, #0x74
	ldrb r0, [r0]
	cmp r4, r0
	bhs _0200B15E
	mov r1, r8
	adds r1, #0x14
	mov r2, r8
	ldrb r0, [r2, #0x14]
	cmp r0, #0xff
	beq _0200B15E
	adds r2, r1, #0
_0200B144:
	adds r1, r6, r4
	ldrb r0, [r2]
	strb r0, [r1]
	adds r2, #1
	adds r4, #1
	ldr r0, [r3]
	adds r0, #0x74
	ldrb r0, [r0]
	cmp r4, r0
	bhs _0200B15E
	ldrb r0, [r2]
	cmp r0, #0xff
	bne _0200B144
_0200B15E:
	adds r1, r6, r4
	movs r0, #0xff
	strb r0, [r1]
	b _0200B4AC
	.align 2, 0
	.pool
_0200B16C:
	mov r3, r8
	ldrb r4, [r3, #0x1b]
	b _0200B4AC
_0200B172:
	mov r5, r8
	ldrh r4, [r5, #0x1c]
	b _0200B4AC
_0200B178:
	mov r6, r8
	ldrh r4, [r6, #0x1e]
	b _0200B4AC
_0200B17E:
	movs r0, #1
	mov r7, r8
	ldrb r7, [r7, #0x13]
	ands r0, r7
	movs r4, #0xce
	lsls r4, r4, #1
	cmp r0, #0
	beq _0200B190
	b _0200B4AC
_0200B190:
	mov r0, sb
	ldrh r4, [r0]
	b _0200B4AC
_0200B196:
	mov r1, sb
	ldrh r4, [r1, #2]
	b _0200B4AC
_0200B19C:
	mov r2, sb
	ldr r4, [r2, #4]
	b _0200B4AC
_0200B1A2:
	mov r3, sb
	ldrb r4, [r3, #8]
	b _0200B4AC
_0200B1A8:
	mov r5, sb
	ldrb r4, [r5, #9]
	b _0200B4AC
_0200B1AE:
	ldr r0, [sp, #0x10]
	subs r0, #0xd
	lsls r0, r0, #1
	add r0, sl
	ldrh r4, [r0]
	b _0200B4AC
_0200B1BA:
	ldr r0, [sp, #0x10]
	add r0, sl
	subs r0, #9
	ldrb r4, [r0]
	b _0200B4AC
_0200B1C4:
	ldrb r4, [r7]
	b _0200B4AC
_0200B1C8:
	ldrb r4, [r7, #1]
	b _0200B4AC
_0200B1CC:
	ldrb r4, [r7, #2]
	b _0200B4AC
_0200B1D0:
	ldrb r4, [r7, #3]
	b _0200B4AC
_0200B1D4:
	ldrb r4, [r7, #4]
	b _0200B4AC
_0200B1D8:
	ldrb r4, [r7, #5]
	b _0200B4AC
_0200B1DC:
	ldrb r4, [r7, #6]
	b _0200B4AC
_0200B1E0:
	ldrb r4, [r7, #7]
	b _0200B4AC
_0200B1E4:
	ldrb r4, [r7, #8]
	b _0200B4AC
_0200B1E8:
	ldrb r4, [r7, #9]
	b _0200B4AC
_0200B1EC:
	ldrb r4, [r7, #0xa]
	b _0200B4AC
_0200B1F0:
	ldrb r4, [r7, #0xb]
	b _0200B4AC
_0200B1F4:
	ldrb r4, [r5]
	b _0200B4AC
_0200B1F8:
	ldrb r4, [r5, #1]
	b _0200B4AC
_0200B1FC:
	ldrb r5, [r5, #2]
	lsls r0, r5, #0x19
	lsrs r4, r0, #0x19
	b _0200B4AC
_0200B204:
	ldrh r5, [r5, #2]
	lsls r0, r5, #0x15
	lsrs r4, r0, #0x1c
	b _0200B4AC
_0200B20C:
	ldrb r5, [r5, #3]
	lsls r0, r5, #0x19
	lsrs r4, r0, #0x1c
	b _0200B4AC
_0200B214:
	ldrb r5, [r5, #3]
	lsrs r4, r5, #7
	b _0200B4AC
_0200B21A:
	ldrb r5, [r5, #4]
	lsls r0, r5, #0x1b
	lsrs r4, r0, #0x1b
	b _0200B4AC
_0200B222:
	ldrh r5, [r5, #4]
	lsls r0, r5, #0x16
	lsrs r4, r0, #0x1b
	b _0200B4AC
_0200B22A:
	ldrb r5, [r5, #5]
	lsls r0, r5, #0x19
	lsrs r4, r0, #0x1b
	b _0200B4AC
_0200B232:
	ldr r0, [r5, #4]
	lsls r0, r0, #0xc
	lsrs r4, r0, #0x1b
	b _0200B4AC
_0200B23A:
	ldrh r5, [r5, #6]
	lsls r0, r5, #0x17
	lsrs r4, r0, #0x1b
	b _0200B4AC
_0200B242:
	ldrb r5, [r5, #7]
	lsls r0, r5, #0x1a
	lsrs r4, r0, #0x1b
	b _0200B4AC
_0200B24A:
	ldrb r5, [r5, #7]
	b _0200B2A8
_0200B24E:
	ldrb r5, [r5, #7]
	lsrs r4, r5, #7
	b _0200B4AC
_0200B254:
	ldrb r5, [r5, #8]
	lsls r0, r5, #0x1d
	lsrs r4, r0, #0x1d
	b _0200B4AC
_0200B25C:
	ldrb r5, [r5, #8]
	lsls r0, r5, #0x1a
	lsrs r4, r0, #0x1d
	b _0200B4AC
_0200B264:
	ldrh r5, [r5, #8]
	lsls r0, r5, #0x17
	lsrs r4, r0, #0x1d
	b _0200B4AC
_0200B26C:
	ldrb r5, [r5, #9]
	lsls r0, r5, #0x1c
	lsrs r4, r0, #0x1d
	b _0200B4AC
_0200B274:
	ldrb r5, [r5, #9]
	lsls r0, r5, #0x19
	lsrs r4, r0, #0x1d
	b _0200B4AC
_0200B27C:
	ldrb r5, [r5, #9]
	lsrs r4, r5, #7
	b _0200B4AC
_0200B282:
	ldrb r5, [r5, #0xa]
	b _0200B2B6
_0200B286:
	ldrb r5, [r5, #0xa]
	b _0200B2BE
_0200B28A:
	ldrb r5, [r5, #0xa]
	b _0200B2C6
_0200B28E:
	ldrb r5, [r5, #0xa]
	lsls r0, r5, #0x1c
	lsrs r4, r0, #0x1f
	b _0200B4AC
_0200B296:
	ldrb r5, [r5, #0xa]
	lsls r0, r5, #0x1b
	lsrs r4, r0, #0x1f
	b _0200B4AC
_0200B29E:
	ldrb r5, [r5, #0xa]
	lsls r0, r5, #0x1a
	lsrs r4, r0, #0x1f
	b _0200B4AC
_0200B2A6:
	ldrb r5, [r5, #0xa]
_0200B2A8:
	lsls r0, r5, #0x19
	lsrs r4, r0, #0x1f
	b _0200B4AC
_0200B2AE:
	ldrb r5, [r5, #0xa]
	lsrs r4, r5, #7
	b _0200B4AC
_0200B2B4:
	ldrb r5, [r5, #0xb]
_0200B2B6:
	lsls r0, r5, #0x1f
	lsrs r4, r0, #0x1f
	b _0200B4AC
_0200B2BC:
	ldrb r5, [r5, #0xb]
_0200B2BE:
	lsls r0, r5, #0x1e
	lsrs r4, r0, #0x1f
	b _0200B4AC
_0200B2C4:
	ldrb r5, [r5, #0xb]
_0200B2C6:
	lsls r0, r5, #0x1d
	lsrs r4, r0, #0x1f
	b _0200B4AC
_0200B2CC:
	ldrb r5, [r5, #0xb]
	lsrs r4, r5, #3
	b _0200B4AC
_0200B2D2:
	mov r6, sb
	ldrh r4, [r6]
	cmp r4, #0
	bne _0200B2DC
	b _0200B4AC
_0200B2DC:
	ldrb r5, [r5, #7]
	lsls r0, r5, #0x19
	cmp r0, #0
	blt _0200B2F2
	movs r0, #1
	mov r7, r8
	ldrb r7, [r7, #0x13]
	ands r0, r7
	cmp r0, #0
	bne _0200B2F2
	b _0200B4AC
_0200B2F2:
	movs r4, #0xce
	lsls r4, r4, #1
	b _0200B4AC
_0200B2F8:
	ldrb r1, [r5, #4]
	lsls r0, r1, #0x1b
	lsrs r4, r0, #0x1b
	movs r0, #0xf8
	lsls r0, r0, #2
	ldrh r2, [r5, #4]
	ands r0, r2
	orrs r4, r0
	ldrb r3, [r5, #5]
	lsls r0, r3, #0x19
	lsrs r0, r0, #0x1b
	lsls r0, r0, #0xa
	orrs r4, r0
	ldr r0, [r5, #4]
	movs r1, #0xf8
	lsls r1, r1, #0xc
	ands r0, r1
	orrs r4, r0
	ldrh r6, [r5, #6]
	lsls r0, r6, #0x17
	lsrs r0, r0, #0x1b
	lsls r0, r0, #0x14
	orrs r4, r0
	ldrb r5, [r5, #7]
	lsls r0, r5, #0x1a
	lsrs r0, r0, #0x1b
	lsls r0, r0, #0x19
	orrs r4, r0
	b _0200B4AC
_0200B332:
	mov r7, sb
	ldrh r0, [r7]
	cmp r0, #0
	bne _0200B33C
	b _0200B4AC
_0200B33C:
	ldrb r5, [r5, #7]
	lsls r0, r5, #0x19
	cmp r0, #0
	bge _0200B346
	b _0200B4AC
_0200B346:
	ldr r0, =0x00000163
	ldrh r1, [r6]
	cmp r1, r0
	bne _0200B350
	b _0200B4AC
_0200B350:
	mov r2, sl
	ldrh r3, [r2]
	adds r5, r0, #0
	adds r1, r6, #0
	ldr r2, =gUnknown_0201ECC0
_0200B35A:
	ldrh r0, [r1]
	cmp r3, r0
	beq _0200B378
	mov r6, sl
	ldrh r6, [r6, #2]
	cmp r6, r0
	beq _0200B378
	mov r7, sl
	ldrh r7, [r7, #4]
	cmp r7, r0
	beq _0200B378
	mov r6, sl
	ldrh r6, [r6, #6]
	cmp r6, r0
	bne _0200B37C
_0200B378:
	ldr r0, [r2]
	orrs r4, r0
_0200B37C:
	adds r1, #2
	adds r2, #4
	ldrh r7, [r1]
	cmp r7, r5
	bne _0200B35A
	b _0200B4AC
	.align 2, 0
	.pool
_0200B390:
	movs r4, #0
	mov r1, sb
	ldrh r0, [r1]
	cmp r0, #0
	bne _0200B39C
	b _0200B4AC
_0200B39C:
	ldrb r2, [r5, #7]
	lsls r0, r2, #0x19
	cmp r0, #0
	bge _0200B3A6
	b _0200B4AC
_0200B3A6:
	ldrb r0, [r5, #8]
	lsls r1, r0, #0x1d
	lsrs r4, r1, #0x1d
	lsls r0, r0, #0x1a
	lsrs r0, r0, #0x1d
	adds r4, r4, r0
	ldrh r3, [r5, #8]
	lsls r0, r3, #0x17
	lsrs r0, r0, #0x1d
	adds r4, r4, r0
	ldrb r1, [r5, #9]
	lsls r0, r1, #0x1c
	lsrs r0, r0, #0x1d
	adds r4, r4, r0
	lsls r0, r1, #0x19
	lsrs r0, r0, #0x1d
	adds r4, r4, r0
	lsrs r1, r1, #7
	adds r4, r4, r1
	ldrb r1, [r5, #0xa]
	lsls r0, r1, #0x1f
	lsrs r0, r0, #0x1f
	adds r4, r4, r0
	lsls r0, r1, #0x1e
	lsrs r0, r0, #0x1f
	adds r4, r4, r0
	lsls r0, r1, #0x1d
	lsrs r0, r0, #0x1f
	adds r4, r4, r0
	lsls r0, r1, #0x1c
	lsrs r0, r0, #0x1f
	adds r4, r4, r0
	lsls r0, r1, #0x1b
	lsrs r0, r0, #0x1f
	adds r4, r4, r0
	lsls r0, r1, #0x1a
	lsrs r0, r0, #0x1f
	adds r4, r4, r0
	lsls r0, r1, #0x19
	lsrs r0, r0, #0x1f
	adds r4, r4, r0
	lsrs r1, r1, #7
	adds r4, r4, r1
	ldrb r1, [r5, #0xb]
	lsls r0, r1, #0x1f
	lsrs r0, r0, #0x1f
	adds r4, r4, r0
	lsls r0, r1, #0x1e
	lsrs r0, r0, #0x1f
	adds r4, r4, r0
	lsls r1, r1, #0x1d
	lsrs r1, r1, #0x1f
	adds r4, r4, r1
	b _0200B4AC
_0200B412:
	movs r4, #0
	mov r6, sb
	ldrh r0, [r6]
	cmp r0, #0
	beq _0200B4AC
	ldrb r7, [r5, #7]
	lsls r0, r7, #0x19
	cmp r0, #0
	blt _0200B4AC
	ldrb r2, [r5, #9]
	lsrs r4, r2, #7
	ldrb r1, [r5, #8]
	lsls r0, r1, #0x1d
	lsrs r0, r0, #0x1c
	orrs r4, r0
	lsls r1, r1, #0x1a
	lsrs r1, r1, #0x1d
	lsls r1, r1, #4
	orrs r4, r1
	ldrh r1, [r5, #8]
	lsls r0, r1, #0x17
	lsrs r0, r0, #0x1d
	lsls r0, r0, #7
	orrs r4, r0
	lsls r0, r2, #0x1c
	lsrs r0, r0, #0x1d
	lsls r0, r0, #0xa
	orrs r4, r0
	lsls r2, r2, #0x19
	lsrs r2, r2, #0x1d
	lsls r2, r2, #0xd
	orrs r4, r2
	ldrb r1, [r5, #0xa]
	lsls r0, r1, #0x1f
	lsrs r0, r0, #0x1f
	lsls r0, r0, #0x10
	orrs r4, r0
	lsls r0, r1, #0x1e
	lsrs r0, r0, #0x1f
	lsls r0, r0, #0x11
	orrs r4, r0
	lsls r0, r1, #0x1d
	lsrs r0, r0, #0x1f
	lsls r0, r0, #0x12
	orrs r4, r0
	lsls r0, r1, #0x1c
	lsrs r0, r0, #0x1f
	lsls r0, r0, #0x13
	orrs r4, r0
	lsls r0, r1, #0x1b
	lsrs r0, r0, #0x1f
	lsls r0, r0, #0x14
	orrs r4, r0
	lsls r0, r1, #0x1a
	lsrs r0, r0, #0x1f
	lsls r0, r0, #0x15
	orrs r4, r0
	lsls r0, r1, #0x19
	lsrs r0, r0, #0x1f
	lsls r0, r0, #0x16
	orrs r4, r0
	lsrs r1, r1, #7
	lsls r1, r1, #0x17
	orrs r4, r1
	ldrb r1, [r5, #0xb]
	lsls r0, r1, #0x1f
	lsrs r0, r0, #0x1f
	lsls r0, r0, #0x18
	orrs r4, r0
	lsls r0, r1, #0x1e
	lsrs r0, r0, #0x1f
	lsls r0, r0, #0x19
	orrs r4, r0
	lsls r1, r1, #0x1d
	lsrs r1, r1, #0x1f
	lsls r1, r1, #0x1a
	orrs r4, r1
_0200B4AC:
	ldr r2, [sp, #0x10]
	cmp r2, #0xa
	ble _0200B4CE
	movs r3, #0
	mov r2, r8
	adds r2, #0x20
_0200B4B8:
	ldr r0, [r2]
	mov r5, r8
	ldr r1, [r5]
	eors r0, r1
	str r0, [r2]
	ldr r1, [r5, #4]
	eors r0, r1
	stm r2!, {r0}
	adds r3, #1
	cmp r3, #0xb
	bls _0200B4B8
_0200B4CE:
	adds r0, r4, #0
	add sp, #0x18
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1

	thumb_func_start sub_0200B4E0
sub_0200B4E0: @ 0x0200B4E0
	push {r4, r5, r6, r7, lr}
	mov r7, r8
	push {r7}
	movs r1, #0x64
	adds r4, r0, #0
	muls r4, r1, r4
	ldr r5, =gUnknown_02022EF4
	ldr r0, [r5]
	adds r0, r4, r0
	movs r1, #0x41
	movs r2, #0
	bl sub_0200AE74
	lsls r0, r0, #0x10
	lsrs r7, r0, #0x10
	mov r8, r7
	ldr r0, [r5]
	adds r0, r4, r0
	movs r1, #1
	movs r2, #0
	bl sub_0200AE74
	adds r6, r0, #0
	ldr r0, [r5]
	adds r4, r4, r0
	adds r0, r4, #0
	movs r1, #0
	movs r2, #0
	bl sub_0200AE74
	adds r3, r0, #0
	movs r0, #0xce
	lsls r0, r0, #1
	cmp r7, r0
	bls _0200B538
	ldr r0, =gUnknown_020251E8
	ldr r0, [r0]
	ldr r0, [r0, #0x30]
	b _0200B56C
	.align 2, 0
	.pool
_0200B538:
	lsrs r0, r6, #0x10
	ldr r2, =0x0000FFFF
	ands r6, r2
	eors r0, r6
	lsrs r1, r3, #0x10
	eors r0, r1
	ands r3, r2
	eors r0, r3
	cmp r0, #7
	bhi _0200B560
	ldr r0, =gUnknown_020251E8
	ldr r0, [r0]
	lsls r1, r7, #3
	ldr r0, [r0, #0x34]
	b _0200B56A
	.align 2, 0
	.pool
_0200B560:
	ldr r0, =gUnknown_020251E8
	ldr r0, [r0]
	mov r2, r8
	lsls r1, r2, #3
	ldr r0, [r0, #0x30]
_0200B56A:
	adds r0, r0, r1
_0200B56C:
	pop {r3}
	mov r8, r3
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200B57C
sub_0200B57C: @ 0x0200B57C
	push {r4, r5, r6, lr}
	adds r4, r0, #0
	ldr r0, =gUnknown_020251E8
	ldr r0, [r0]
	adds r0, #0xbc
	ldr r6, [r0]
	adds r0, r4, #0
	movs r1, #0xb
	movs r2, #0
	bl sub_0200AE74
	adds r5, r0, #0
	adds r0, r4, #0
	movs r1, #0x2e
	movs r2, #0
	bl sub_0200AE74
	cmp r0, #0
	bne _0200B5B4
	lsls r0, r5, #3
	subs r0, r0, r5
	lsls r0, r0, #2
	adds r0, r0, r6
	ldrb r0, [r0, #0x16]
	b _0200B5BE
	.align 2, 0
	.pool
_0200B5B4:
	lsls r0, r5, #3
	subs r0, r0, r5
	lsls r0, r0, #2
	adds r0, r0, r6
	ldrb r0, [r0, #0x17]
_0200B5BE:
	pop {r4, r5, r6}
	pop {r1}
	bx r1

	thumb_func_start sub_0200B5C4
sub_0200B5C4: @ 0x0200B5C4
	push {lr}
	movs r1, #0x26
	movs r2, #0
	bl sub_0200AE74
	lsls r0, r0, #0x10
	lsrs r0, r0, #0x10
	subs r0, #1
	cmp r0, #0xb
	bhi _0200B644
	lsls r0, r0, #2
	ldr r1, =_0200B5E8
	adds r0, r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
	.pool
_0200B5E8: @ jump table
	.4byte _0200B618 @ case 0
	.4byte _0200B61C @ case 1
	.4byte _0200B620 @ case 2
	.4byte _0200B644 @ case 3
	.4byte _0200B624 @ case 4
	.4byte _0200B628 @ case 5
	.4byte _0200B62C @ case 6
	.4byte _0200B630 @ case 7
	.4byte _0200B634 @ case 8
	.4byte _0200B638 @ case 9
	.4byte _0200B63C @ case 10
	.4byte _0200B640 @ case 11
_0200B618:
	movs r2, #4
	b _0200B646
_0200B61C:
	movs r2, #3
	b _0200B646
_0200B620:
	movs r2, #1
	b _0200B646
_0200B624:
	movs r2, #2
	b _0200B646
_0200B628:
	movs r2, #5
	b _0200B646
_0200B62C:
	movs r2, #6
	b _0200B646
_0200B630:
	movs r2, #7
	b _0200B646
_0200B634:
	movs r2, #8
	b _0200B646
_0200B638:
	movs r2, #9
	b _0200B646
_0200B63C:
	movs r2, #0xa
	b _0200B646
_0200B640:
	movs r2, #0xb
	b _0200B646
_0200B644:
	movs r2, #0
_0200B646:
	ldr r0, =gUnknown_020251E8
	ldr r0, [r0]
	adds r0, #0xd0
	ldr r1, [r0]
	lsls r0, r2, #3
	adds r0, r0, r1
	ldr r0, [r0]
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200B65C
sub_0200B65C: @ 0x0200B65C
	push {lr}
	movs r1, #0x26
	movs r2, #0
	bl sub_0200AE74
	lsls r0, r0, #0x10
	lsrs r0, r0, #0x10
	subs r0, #1
	cmp r0, #0xb
	bhi _0200B6DC
	lsls r0, r0, #2
	ldr r1, =_0200B680
	adds r0, r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
	.pool
_0200B680: @ jump table
	.4byte _0200B6B0 @ case 0
	.4byte _0200B6B4 @ case 1
	.4byte _0200B6B8 @ case 2
	.4byte _0200B6DC @ case 3
	.4byte _0200B6BC @ case 4
	.4byte _0200B6C0 @ case 5
	.4byte _0200B6C4 @ case 6
	.4byte _0200B6C8 @ case 7
	.4byte _0200B6CC @ case 8
	.4byte _0200B6D0 @ case 9
	.4byte _0200B6D4 @ case 10
	.4byte _0200B6D8 @ case 11
_0200B6B0:
	movs r2, #4
	b _0200B6DE
_0200B6B4:
	movs r2, #3
	b _0200B6DE
_0200B6B8:
	movs r2, #1
	b _0200B6DE
_0200B6BC:
	movs r2, #2
	b _0200B6DE
_0200B6C0:
	movs r2, #5
	b _0200B6DE
_0200B6C4:
	movs r2, #6
	b _0200B6DE
_0200B6C8:
	movs r2, #7
	b _0200B6DE
_0200B6CC:
	movs r2, #8
	b _0200B6DE
_0200B6D0:
	movs r2, #9
	b _0200B6DE
_0200B6D4:
	movs r2, #0xa
	b _0200B6DE
_0200B6D8:
	movs r2, #0xb
	b _0200B6DE
_0200B6DC:
	movs r2, #0
_0200B6DE:
	ldr r0, =gUnknown_020251E8
	ldr r0, [r0]
	adds r0, #0xd4
	ldr r1, [r0]
	lsls r0, r2, #3
	adds r0, r0, r1
	ldr r0, [r0]
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200B6F4
sub_0200B6F4: @ 0x0200B6F4
	push {lr}
	cmp r1, #1
	beq _0200B70E
	cmp r1, #1
	bgt _0200B704
	cmp r1, #0
	beq _0200B70A
	b _0200B71C
_0200B704:
	cmp r1, #2
	beq _0200B712
	b _0200B71C
_0200B70A:
	movs r1, #0xd
	b _0200B714
_0200B70E:
	movs r1, #0xe
	b _0200B714
_0200B712:
	movs r1, #0xf
_0200B714:
	movs r2, #0
	bl sub_0200AE74
	b _0200B724
_0200B71C:
	movs r1, #0x10
	movs r2, #0
	bl sub_0200AE74
_0200B724:
	pop {r1}
	bx r1

	thumb_func_start sub_0200B728
sub_0200B728: @ 0x0200B728
	push {lr}
	lsls r1, r1, #0x18
	lsrs r1, r1, #0x18
	adds r2, r1, #0
	cmp r1, #1
	beq _0200B748
	cmp r1, #1
	bgt _0200B73E
	cmp r1, #0
	beq _0200B744
	b _0200B756
_0200B73E:
	cmp r2, #2
	beq _0200B74C
	b _0200B756
_0200B744:
	movs r1, #0x11
	b _0200B74E
_0200B748:
	movs r1, #0x12
	b _0200B74E
_0200B74C:
	movs r1, #0x13
_0200B74E:
	movs r2, #0
	bl sub_0200AE74
	b _0200B75E
_0200B756:
	movs r1, #0x14
	movs r2, #0
	bl sub_0200AE74
_0200B75E:
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_0200B764
sub_0200B764: @ 0x0200B764
	push {r4, r5, r6, r7, lr}
	mov r7, r8
	push {r7}
	adds r6, r0, #0
	lsls r1, r1, #0x18
	lsrs r4, r1, #0x18
	movs r7, #0
	movs r5, #1
	movs r0, #0
	mov r8, r0
	cmp r4, #0
	beq _0200B7AC
_0200B77C:
	movs r0, #1
	ands r0, r4
	cmp r0, #0
	beq _0200B7A0
	movs r0, #0x64
	muls r0, r7, r0
	adds r0, r0, r6
	movs r1, #0x22
	movs r2, #0
	bl sub_0200AE74
	movs r1, #0xf
	ands r1, r0
	cmp r1, #0
	beq _0200B7A0
	mov r0, r8
	orrs r0, r5
	mov r8, r0
_0200B7A0:
	adds r7, #1
	lsls r5, r5, #1
	lsrs r4, r4, #1
	cmp r4, #0
	bne _0200B77C
	b _0200B7C2
_0200B7AC:
	adds r0, r6, #0
	movs r1, #0x22
	movs r2, #0
	bl sub_0200AE74
	movs r1, #0xf
	ands r1, r0
	cmp r1, #0
	beq _0200B7C2
	movs r0, #1
	mov r8, r0
_0200B7C2:
	mov r0, r8
	pop {r3}
	mov r8, r3
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_0200B7D0
sub_0200B7D0: @ 0x0200B7D0
	push {lr}
	adds r2, r0, #0
	adds r0, #0x56
	ldrh r0, [r0]
	cmp r0, #0
	bne _0200B7E0
	movs r0, #7
	b _0200B834
_0200B7E0:
	ldr r1, [r2, #0x50]
	movs r0, #0x88
	ands r0, r1
	cmp r0, #0
	beq _0200B7EE
	movs r0, #1
	b _0200B834
_0200B7EE:
	movs r0, #0x40
	ands r0, r1
	cmp r0, #0
	beq _0200B7FA
	movs r0, #2
	b _0200B834
_0200B7FA:
	movs r0, #7
	ands r0, r1
	cmp r0, #0
	beq _0200B806
	movs r0, #3
	b _0200B834
_0200B806:
	movs r0, #0x20
	ands r0, r1
	cmp r0, #0
	beq _0200B812
	movs r0, #4
	b _0200B834
_0200B812:
	movs r0, #0x10
	ands r1, r0
	movs r0, #0
	cmp r1, #0
	beq _0200B81E
	movs r0, #5
_0200B81E:
	cmp r0, #0
	bne _0200B834
	adds r0, r2, #0
	movs r1, #0
	bl sub_0200B764
	cmp r0, #0
	bne _0200B832
	movs r0, #0
	b _0200B834
_0200B832:
	movs r0, #6
_0200B834:
	pop {r1}
	bx r1

	thumb_func_start sub_0200B838
sub_0200B838: @ 0x0200B838
	push {r4, r5, r6, r7, lr}
	mov r7, r8
	push {r7}
	adds r6, r0, #0
	lsls r1, r1, #0x18
	lsrs r4, r1, #0x18
	movs r7, #0
	movs r5, #1
	movs r0, #0
	mov r8, r0
	cmp r4, #0
	beq _0200B87C
_0200B850:
	movs r0, #1
	ands r0, r4
	cmp r0, #0
	beq _0200B870
	movs r0, #0x64
	muls r0, r7, r0
	adds r0, r0, r6
	movs r1, #0x22
	movs r2, #0
	bl sub_0200AE74
	cmp r0, #0
	beq _0200B870
	mov r0, r8
	orrs r0, r5
	mov r8, r0
_0200B870:
	adds r7, #1
	lsls r5, r5, #1
	lsrs r4, r4, #1
	cmp r4, #0
	bne _0200B850
	b _0200B88E
_0200B87C:
	adds r0, r6, #0
	movs r1, #0x22
	movs r2, #0
	bl sub_0200AE74
	cmp r0, #0
	beq _0200B88E
	movs r0, #1
	mov r8, r0
_0200B88E:
	mov r0, r8
	pop {r3}
	mov r8, r3
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_0200B89C
sub_0200B89C: @ 0x0200B89C
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #0xc
	adds r5, r1, #0
	str r2, [sp]
	lsls r0, r0, #0x10
	movs r1, #0x9a
	lsls r1, r1, #0x11
	cmp r0, r1
	bne _0200B9AE
	ldr r0, =gUnknown_020251EC
	ldrb r0, [r0]
	movs r1, #7
	str r1, [sp, #4]
	cmp r0, #0
	beq _0200B8C6
	movs r3, #0
	str r3, [sp, #4]
_0200B8C6:
	movs r6, #0
_0200B8C8:
	lsls r3, r6, #3
	adds r3, r3, r6
	lsls r3, r3, #2
	ldr r0, =gUnknown_0201E778
	adds r4, r3, r0
	ldrb r1, [r4]
	adds r1, #0xf8
	movs r2, #0xf
	adds r0, r5, #0
	ands r0, r2
	adds r1, r1, r0
	lsls r1, r1, #0x18
	lsrs r1, r1, #0x18
	mov ip, r1
	ldrb r1, [r4, #1]
	adds r1, #0xf8
	movs r0, #0xf0
	ands r0, r5
	lsrs r0, r0, #4
	adds r1, r1, r0
	ldr r0, [sp, #4]
	subs r1, r1, r0
	lsls r1, r1, #0x18
	lsrs r1, r1, #0x18
	movs r2, #0
	lsrs r5, r5, #8
	str r5, [sp, #8]
	adds r6, #1
	mov sl, r6
	mov sb, r3
_0200B904:
	lsls r0, r2, #1
	add r0, sb
	ldr r3, =gUnknown_0201E77A
	adds r0, r0, r3
	ldrh r3, [r0]
	mov r4, ip
	adds r0, r4, #0
	adds r0, #0x10
	adds r7, r1, #1
	adds r2, #1
	mov r8, r2
	cmp r4, r0
	bge _0200B99C
	lsrs r0, r1, #3
	lsls r6, r0, #8
	movs r0, #7
	ands r1, r0
	lsls r5, r1, #2
_0200B928:
	adds r0, r4, #0
	cmp r4, #0
	bge _0200B930
	adds r0, r4, #7
_0200B930:
	asrs r0, r0, #3
	lsls r2, r0, #5
	ldr r1, [sp]
	adds r2, r1, r2
	lsls r0, r0, #3
	subs r0, r4, r0
	lsrs r1, r0, #0x1f
	adds r0, r0, r1
	asrs r0, r0, #1
	adds r2, r2, r0
	adds r2, r2, r6
	adds r2, r2, r5
	movs r1, #1
	adds r0, r3, #0
	ands r0, r1
	cmp r0, #0
	beq _0200B990
	adds r0, r4, #0
	ands r0, r1
	cmp r0, #0
	beq _0200B97C
	ldrb r1, [r2]
	movs r0, #0xf0
	ands r0, r1
	subs r0, #0x10
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	cmp r0, #0x20
	bhi _0200B990
	adds r0, r1, #0
	adds r0, #0x40
	b _0200B98E
	.align 2, 0
	.pool
_0200B97C:
	ldrb r1, [r2]
	movs r0, #0xf
	ands r0, r1
	subs r0, #1
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	cmp r0, #2
	bhi _0200B990
	adds r0, r1, #4
_0200B98E:
	strb r0, [r2]
_0200B990:
	asrs r3, r3, #1
	adds r4, #1
	mov r0, ip
	adds r0, #0x10
	cmp r4, r0
	blt _0200B928
_0200B99C:
	lsls r0, r7, #0x18
	lsrs r1, r0, #0x18
	mov r2, r8
	cmp r2, #0xf
	ble _0200B904
	ldr r5, [sp, #8]
	mov r6, sl
	cmp r6, #3
	ble _0200B8C8
_0200B9AE:
	add sp, #0xc
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start sub_0200B9C0
sub_0200B9C0: @ 0x0200B9C0
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #4
	adds r6, r0, #0
	str r1, [sp]
	adds r4, r2, #0
	movs r0, #0
	mov sb, r0
	mov sl, r0
	movs r7, #0
	movs r5, #0
	cmp r1, #0xa
	ble _0200BA6C
	ldr r1, [r6]
	adds r0, r6, #0
	movs r2, #0
	bl sub_0200A8B8
	mov sb, r0
	ldr r1, [r6]
	adds r0, r6, #0
	movs r2, #1
	bl sub_0200A8B8
	mov sl, r0
	ldr r1, [r6]
	adds r0, r6, #0
	movs r2, #2
	bl sub_0200A8B8
	adds r7, r0, #0
	ldr r1, [r6]
	adds r0, r6, #0
	movs r2, #3
	bl sub_0200A8B8
	adds r5, r0, #0
	movs r3, #0
	movs r1, #0x20
	adds r1, r1, r6
	mov r8, r1
	mov r2, r8
_0200BA1A:
	ldr r0, [r2]
	ldr r1, [r6, #4]
	eors r0, r1
	str r0, [r2]
	ldr r1, [r6]
	eors r0, r1
	stm r2!, {r0}
	adds r3, #1
	cmp r3, #0xb
	bls _0200BA1A
	adds r0, r6, #0
	bl sub_0200ADE0
	lsls r0, r0, #0x10
	lsrs r0, r0, #0x10
	ldrh r2, [r6, #0x1c]
	cmp r0, r2
	beq _0200BA6C
	movs r0, #1
	ldrb r4, [r6, #0x13]
	orrs r0, r4
	movs r1, #4
	orrs r0, r1
	strb r0, [r6, #0x13]
	movs r0, #0x40
	ldrb r1, [r5, #7]
	orrs r0, r1
	strb r0, [r5, #7]
	movs r3, #0
	mov r2, r8
_0200BA56:
	ldr r0, [r2]
	ldr r1, [r6]
	eors r0, r1
	str r0, [r2]
	ldr r1, [r6, #4]
	eors r0, r1
	stm r2!, {r0}
	adds r3, #1
	cmp r3, #0xb
	bls _0200BA56
	b _0200C024
_0200BA6C:
	ldr r2, [sp]
	cmp r2, #0x4f
	bls _0200BA74
	b _0200BFFC
_0200BA74:
	lsls r0, r2, #2
	ldr r1, =_0200BA84
	adds r0, r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
	.pool
_0200BA84: @ jump table
	.4byte _0200BBC4 @ case 0
	.4byte _0200BBDC @ case 1
	.4byte _0200BBF4 @ case 2
	.4byte _0200BC24 @ case 3
	.4byte _0200BC2A @ case 4
	.4byte _0200BC36 @ case 5
	.4byte _0200BC48 @ case 6
	.4byte _0200BC5E @ case 7
	.4byte _0200BC8C @ case 8
	.4byte _0200BC92 @ case 9
	.4byte _0200BC9E @ case 10
	.4byte _0200BCAA @ case 11
	.4byte _0200BCC4 @ case 12
	.4byte _0200BCFC @ case 13
	.4byte _0200BCFC @ case 14
	.4byte _0200BCFC @ case 15
	.4byte _0200BCFC @ case 16
	.4byte _0200BD10 @ case 17
	.4byte _0200BD10 @ case 18
	.4byte _0200BD10 @ case 19
	.4byte _0200BD10 @ case 20
	.4byte _0200BCEC @ case 21
	.4byte _0200BD40 @ case 22
	.4byte _0200BD46 @ case 23
	.4byte _0200BD4C @ case 24
	.4byte _0200BCD2 @ case 25
	.4byte _0200BD1C @ case 26
	.4byte _0200BD22 @ case 27
	.4byte _0200BD28 @ case 28
	.4byte _0200BD2E @ case 29
	.4byte _0200BD34 @ case 30
	.4byte _0200BD3A @ case 31
	.4byte _0200BCF4 @ case 32
	.4byte _0200BD52 @ case 33
	.4byte _0200BD64 @ case 34
	.4byte _0200BD6A @ case 35
	.4byte _0200BD70 @ case 36
	.4byte _0200BD84 @ case 37
	.4byte _0200BD9C @ case 38
	.4byte _0200BDBE @ case 39
	.4byte _0200BDD2 @ case 40
	.4byte _0200BDEC @ case 41
	.4byte _0200BE02 @ case 42
	.4byte _0200BE1C @ case 43
	.4byte _0200BE34 @ case 44
	.4byte _0200BE48 @ case 45
	.4byte _0200BE78 @ case 46
	.4byte _0200BD58 @ case 47
	.4byte _0200BD5E @ case 48
	.4byte _0200BDAE @ case 49
	.4byte _0200BE86 @ case 50
	.4byte _0200BE96 @ case 51
	.4byte _0200BEAC @ case 52
	.4byte _0200BEC4 @ case 53
	.4byte _0200BED2 @ case 54
	.4byte _0200BFFC @ case 55
	.4byte _0200BFFC @ case 56
	.4byte _0200BFFC @ case 57
	.4byte _0200BFFC @ case 58
	.4byte _0200BFFC @ case 59
	.4byte _0200BFFC @ case 60
	.4byte _0200BFFC @ case 61
	.4byte _0200BFFC @ case 62
	.4byte _0200BFFC @ case 63
	.4byte _0200BFFC @ case 64
	.4byte _0200BFFC @ case 65
	.4byte _0200BFB4 @ case 66
	.4byte _0200BEE4 @ case 67
	.4byte _0200BEF4 @ case 68
	.4byte _0200BF04 @ case 69
	.4byte _0200BF12 @ case 70
	.4byte _0200BF24 @ case 71
	.4byte _0200BF32 @ case 72
	.4byte _0200BF44 @ case 73
	.4byte _0200BF52 @ case 74
	.4byte _0200BF64 @ case 75
	.4byte _0200BF74 @ case 76
	.4byte _0200BF84 @ case 77
	.4byte _0200BF92 @ case 78
	.4byte _0200BFA4 @ case 79
_0200BBC4:
	ldrb r1, [r4, #1]
	lsls r0, r1, #8
	ldrb r2, [r4]
	orrs r0, r2
	ldrb r2, [r4, #2]
	lsls r1, r2, #0x10
	adds r0, r0, r1
	ldrb r4, [r4, #3]
	lsls r1, r4, #0x18
	adds r0, r0, r1
	str r0, [r6]
	b _0200BFFC
_0200BBDC:
	ldrb r1, [r4, #1]
	lsls r0, r1, #8
	ldrb r2, [r4]
	orrs r0, r2
	ldrb r2, [r4, #2]
	lsls r1, r2, #0x10
	adds r0, r0, r1
	ldrb r4, [r4, #3]
	lsls r1, r4, #0x18
	adds r0, r0, r1
	str r0, [r6, #4]
	b _0200BFFC
_0200BBF4:
	movs r2, #0
	ldr r5, =gUnknown_020251E8
	ldr r0, [r5]
	adds r0, #0x76
	ldrb r0, [r0]
	cmp r2, r0
	blt _0200BC04
	b _0200BFFC
_0200BC04:
	adds r3, r6, #0
	adds r3, #8
_0200BC08:
	adds r1, r3, r2
	adds r0, r4, r2
	ldrb r0, [r0]
	strb r0, [r1]
	adds r2, #1
	ldr r0, [r5]
	adds r0, #0x76
	ldrb r0, [r0]
	cmp r2, r0
	blt _0200BC08
	b _0200BFFC
	.align 2, 0
	.pool
_0200BC24:
	ldrb r0, [r4]
	strb r0, [r6, #0x12]
	b _0200BFFC
_0200BC2A:
	movs r1, #1
	ldrb r4, [r4]
	ands r1, r4
	movs r0, #2
	rsbs r0, r0, #0
	b _0200BC54
_0200BC36:
	movs r1, #1
	ldrb r4, [r4]
	ands r1, r4
	lsls r1, r1, #1
	movs r0, #3
	rsbs r0, r0, #0
	ldrb r2, [r6, #0x13]
	ands r0, r2
	b _0200BC58
_0200BC48:
	movs r1, #1
	ldrb r4, [r4]
	ands r1, r4
	lsls r1, r1, #2
	movs r0, #5
	rsbs r0, r0, #0
_0200BC54:
	ldrb r4, [r6, #0x13]
	ands r0, r4
_0200BC58:
	orrs r0, r1
	strb r0, [r6, #0x13]
	b _0200BFFC
_0200BC5E:
	movs r2, #0
	ldr r5, =gUnknown_020251E8
	ldr r0, [r5]
	adds r0, #0x74
	ldrb r0, [r0]
	cmp r2, r0
	blt _0200BC6E
	b _0200BFFC
_0200BC6E:
	adds r3, r6, #0
	adds r3, #0x14
_0200BC72:
	adds r1, r3, r2
	adds r0, r4, r2
	ldrb r0, [r0]
	strb r0, [r1]
	adds r2, #1
	ldr r0, [r5]
	adds r0, #0x74
	ldrb r0, [r0]
	cmp r2, r0
	blt _0200BC72
	b _0200BFFC
	.align 2, 0
	.pool
_0200BC8C:
	ldrb r0, [r4]
	strb r0, [r6, #0x1b]
	b _0200BFFC
_0200BC92:
	ldrb r1, [r4, #1]
	lsls r0, r1, #8
	ldrb r4, [r4]
	orrs r0, r4
	strh r0, [r6, #0x1c]
	b _0200BFFC
_0200BC9E:
	ldrb r2, [r4, #1]
	lsls r0, r2, #8
	ldrb r4, [r4]
	orrs r0, r4
	strh r0, [r6, #0x1e]
	b _0200BFFC
_0200BCAA:
	ldrb r1, [r4, #1]
	lsls r0, r1, #8
	ldrb r4, [r4]
	orrs r0, r4
	mov r2, sb
	strh r0, [r2]
	cmp r0, #0
	beq _0200BCBE
	movs r0, #2
	b _0200BE64
_0200BCBE:
	movs r0, #3
	rsbs r0, r0, #0
	b _0200BE70
_0200BCC4:
	ldrb r2, [r4, #1]
	lsls r0, r2, #8
	ldrb r4, [r4]
	orrs r0, r4
	mov r4, sb
	strh r0, [r4, #2]
	b _0200BFFC
_0200BCD2:
	ldrb r1, [r4, #1]
	lsls r0, r1, #8
	ldrb r2, [r4]
	orrs r0, r2
	ldrb r2, [r4, #2]
	lsls r1, r2, #0x10
	adds r0, r0, r1
	ldrb r4, [r4, #3]
	lsls r1, r4, #0x18
	adds r0, r0, r1
	mov r4, sb
	str r0, [r4, #4]
	b _0200BFFC
_0200BCEC:
	ldrb r0, [r4]
	mov r1, sb
	strb r0, [r1, #8]
	b _0200BFFC
_0200BCF4:
	ldrb r0, [r4]
	mov r2, sb
	strb r0, [r2, #9]
	b _0200BFFC
_0200BCFC:
	ldr r1, [sp]
	subs r1, #0xd
	lsls r1, r1, #1
	add r1, sl
	ldrb r2, [r4, #1]
	lsls r0, r2, #8
	ldrb r4, [r4]
	orrs r0, r4
	strh r0, [r1]
	b _0200BFFC
_0200BD10:
	ldr r0, [sp]
	add r0, sl
	subs r0, #9
	ldrb r1, [r4]
	strb r1, [r0]
	b _0200BFFC
_0200BD1C:
	ldrb r0, [r4]
	strb r0, [r7]
	b _0200BFFC
_0200BD22:
	ldrb r0, [r4]
	strb r0, [r7, #1]
	b _0200BFFC
_0200BD28:
	ldrb r0, [r4]
	strb r0, [r7, #2]
	b _0200BFFC
_0200BD2E:
	ldrb r0, [r4]
	strb r0, [r7, #3]
	b _0200BFFC
_0200BD34:
	ldrb r0, [r4]
	strb r0, [r7, #4]
	b _0200BFFC
_0200BD3A:
	ldrb r0, [r4]
	strb r0, [r7, #5]
	b _0200BFFC
_0200BD40:
	ldrb r0, [r4]
	strb r0, [r7, #6]
	b _0200BFFC
_0200BD46:
	ldrb r0, [r4]
	strb r0, [r7, #7]
	b _0200BFFC
_0200BD4C:
	ldrb r0, [r4]
	strb r0, [r7, #8]
	b _0200BFFC
_0200BD52:
	ldrb r0, [r4]
	strb r0, [r7, #9]
	b _0200BFFC
_0200BD58:
	ldrb r0, [r4]
	strb r0, [r7, #0xa]
	b _0200BFFC
_0200BD5E:
	ldrb r0, [r4]
	strb r0, [r7, #0xb]
	b _0200BFFC
_0200BD64:
	ldrb r0, [r4]
	strb r0, [r5]
	b _0200BFFC
_0200BD6A:
	ldrb r0, [r4]
	strb r0, [r5, #1]
	b _0200BFFC
_0200BD70:
	movs r1, #0x7f
	ldrb r4, [r4]
	ands r1, r4
	movs r0, #0x80
	rsbs r0, r0, #0
	ldrb r4, [r5, #2]
	ands r0, r4
	orrs r0, r1
	strb r0, [r5, #2]
	b _0200BFFC
_0200BD84:
	movs r1, #0xf
	ldrb r4, [r4]
	ands r1, r4
	lsls r1, r1, #7
	ldr r0, =0xFFFFF87F
	ldrh r2, [r5, #2]
	ands r0, r2
	orrs r0, r1
	strh r0, [r5, #2]
	b _0200BFFC
	.align 2, 0
	.pool
_0200BD9C:
	movs r1, #0xf
	ldrb r4, [r4]
	ands r1, r4
	lsls r1, r1, #3
	movs r0, #0x79
	rsbs r0, r0, #0
	ldrb r4, [r5, #3]
	ands r0, r4
	b _0200BDB8
_0200BDAE:
	ldrb r4, [r4]
	lsls r1, r4, #7
	movs r0, #0x7f
	ldrb r2, [r5, #3]
	ands r0, r2
_0200BDB8:
	orrs r0, r1
	strb r0, [r5, #3]
	b _0200BFFC
_0200BDBE:
	movs r1, #0x1f
	ldrb r4, [r4]
	ands r1, r4
	movs r0, #0x20
	rsbs r0, r0, #0
	ldrb r4, [r5, #4]
	ands r0, r4
	orrs r0, r1
	strb r0, [r5, #4]
	b _0200BFFC
_0200BDD2:
	movs r1, #0x1f
	ldrb r4, [r4]
	ands r1, r4
	lsls r1, r1, #5
	ldr r0, =0xFFFFFC1F
	ldrh r2, [r5, #4]
	ands r0, r2
	orrs r0, r1
	strh r0, [r5, #4]
	b _0200BFFC
	.align 2, 0
	.pool
_0200BDEC:
	movs r1, #0x1f
	ldrb r4, [r4]
	ands r1, r4
	lsls r1, r1, #2
	movs r0, #0x7d
	rsbs r0, r0, #0
	ldrb r4, [r5, #5]
	ands r0, r4
	orrs r0, r1
	strb r0, [r5, #5]
	b _0200BFFC
_0200BE02:
	movs r0, #0x1f
	ldrb r4, [r4]
	ands r0, r4
	lsls r0, r0, #0xf
	ldr r1, [r5, #4]
	ldr r2, =0xFFF07FFF
	ands r1, r2
	orrs r1, r0
	str r1, [r5, #4]
	b _0200BFFC
	.align 2, 0
	.pool
_0200BE1C:
	movs r1, #0x1f
	ldrb r4, [r4]
	ands r1, r4
	lsls r1, r1, #4
	ldr r0, =0xFFFFFE0F
	ldrh r2, [r5, #6]
	ands r0, r2
	orrs r0, r1
	strh r0, [r5, #6]
	b _0200BFFC
	.align 2, 0
	.pool
_0200BE34:
	movs r1, #0x1f
	ldrb r4, [r4]
	ands r1, r4
	lsls r1, r1, #1
	movs r0, #0x3f
	rsbs r0, r0, #0
	ldrb r4, [r5, #7]
	ands r0, r4
	orrs r0, r1
	b _0200BFFA
_0200BE48:
	movs r1, #1
	ldrb r4, [r4]
	ands r1, r4
	lsls r1, r1, #6
	movs r0, #0x41
	rsbs r0, r0, #0
	ldrb r2, [r5, #7]
	ands r0, r2
	orrs r0, r1
	strb r0, [r5, #7]
	lsls r0, r0, #0x19
	cmp r0, #0
	bge _0200BE6C
	movs r0, #4
_0200BE64:
	ldrb r4, [r6, #0x13]
	orrs r0, r4
	strb r0, [r6, #0x13]
	b _0200BFFC
_0200BE6C:
	movs r0, #5
	rsbs r0, r0, #0
_0200BE70:
	ldrb r1, [r6, #0x13]
	ands r0, r1
	strb r0, [r6, #0x13]
	b _0200BFFC
_0200BE78:
	ldrb r4, [r4]
	lsls r1, r4, #7
	movs r0, #0x7f
	ldrb r2, [r5, #7]
	ands r0, r2
	orrs r0, r1
	b _0200BFFA
_0200BE86:
	movs r1, #7
	ldrb r4, [r4]
	ands r1, r4
	movs r0, #8
	rsbs r0, r0, #0
	ldrb r4, [r5, #8]
	ands r0, r4
	b _0200BEA6
_0200BE96:
	movs r1, #7
	ldrb r4, [r4]
	ands r1, r4
	lsls r1, r1, #3
	movs r0, #0x39
	rsbs r0, r0, #0
	ldrb r2, [r5, #8]
	ands r0, r2
_0200BEA6:
	orrs r0, r1
	strb r0, [r5, #8]
	b _0200BFFC
_0200BEAC:
	movs r1, #7
	ldrb r4, [r4]
	ands r1, r4
	lsls r1, r1, #6
	ldr r0, =0xFFFFFE3F
	ldrh r4, [r5, #8]
	ands r0, r4
	orrs r0, r1
	strh r0, [r5, #8]
	b _0200BFFC
	.align 2, 0
	.pool
_0200BEC4:
	movs r1, #7
	ldrb r4, [r4]
	ands r1, r4
	lsls r1, r1, #1
	movs r0, #0xf
	rsbs r0, r0, #0
	b _0200BEEA
_0200BED2:
	movs r1, #7
	ldrb r4, [r4]
	ands r1, r4
	lsls r1, r1, #4
	movs r0, #0x71
	rsbs r0, r0, #0
	ldrb r4, [r5, #9]
	ands r0, r4
	b _0200BEEE
_0200BEE4:
	ldrb r4, [r4]
	lsls r1, r4, #7
	movs r0, #0x7f
_0200BEEA:
	ldrb r2, [r5, #9]
	ands r0, r2
_0200BEEE:
	orrs r0, r1
	strb r0, [r5, #9]
	b _0200BFFC
_0200BEF4:
	movs r1, #1
	ldrb r4, [r4]
	ands r1, r4
	movs r0, #2
	rsbs r0, r0, #0
	ldrb r4, [r5, #0xa]
	ands r0, r4
	b _0200BF6E
_0200BF04:
	movs r1, #1
	ldrb r4, [r4]
	ands r1, r4
	lsls r1, r1, #1
	movs r0, #3
	rsbs r0, r0, #0
	b _0200BF6A
_0200BF12:
	movs r1, #1
	ldrb r4, [r4]
	ands r1, r4
	lsls r1, r1, #2
	movs r0, #5
	rsbs r0, r0, #0
	ldrb r4, [r5, #0xa]
	ands r0, r4
	b _0200BF6E
_0200BF24:
	movs r1, #1
	ldrb r4, [r4]
	ands r1, r4
	lsls r1, r1, #3
	movs r0, #9
	rsbs r0, r0, #0
	b _0200BF6A
_0200BF32:
	movs r1, #1
	ldrb r4, [r4]
	ands r1, r4
	lsls r1, r1, #4
	movs r0, #0x11
	rsbs r0, r0, #0
	ldrb r4, [r5, #0xa]
	ands r0, r4
	b _0200BF6E
_0200BF44:
	movs r1, #1
	ldrb r4, [r4]
	ands r1, r4
	lsls r1, r1, #5
	movs r0, #0x21
	rsbs r0, r0, #0
	b _0200BF6A
_0200BF52:
	movs r1, #1
	ldrb r4, [r4]
	ands r1, r4
	lsls r1, r1, #6
	movs r0, #0x41
	rsbs r0, r0, #0
	ldrb r4, [r5, #0xa]
	ands r0, r4
	b _0200BF6E
_0200BF64:
	ldrb r4, [r4]
	lsls r1, r4, #7
	movs r0, #0x7f
_0200BF6A:
	ldrb r2, [r5, #0xa]
	ands r0, r2
_0200BF6E:
	orrs r0, r1
	strb r0, [r5, #0xa]
	b _0200BFFC
_0200BF74:
	movs r1, #1
	ldrb r4, [r4]
	ands r1, r4
	movs r0, #2
	rsbs r0, r0, #0
	ldrb r4, [r5, #0xb]
	ands r0, r4
	b _0200BFAE
_0200BF84:
	movs r1, #1
	ldrb r4, [r4]
	ands r1, r4
	lsls r1, r1, #1
	movs r0, #3
	rsbs r0, r0, #0
	b _0200BFAA
_0200BF92:
	movs r1, #1
	ldrb r4, [r4]
	ands r1, r4
	lsls r1, r1, #2
	movs r0, #5
	rsbs r0, r0, #0
	ldrb r4, [r5, #0xb]
	ands r0, r4
	b _0200BFAE
_0200BFA4:
	ldrb r4, [r4]
	lsls r1, r4, #3
	movs r0, #7
_0200BFAA:
	ldrb r2, [r5, #0xb]
	ands r0, r2
_0200BFAE:
	orrs r0, r1
	strb r0, [r5, #0xb]
	b _0200BFFC
_0200BFB4:
	ldrb r1, [r4]
	movs r3, #0x1f
	adds r2, r1, #0
	ands r2, r3
	movs r0, #0x20
	rsbs r0, r0, #0
	ldrb r4, [r5, #4]
	ands r0, r4
	orrs r0, r2
	strb r0, [r5, #4]
	lsrs r1, r1, #5
	ands r1, r3
	lsls r1, r1, #5
	ldr r0, =0xFFFFFC1F
	ldrh r2, [r5, #4]
	ands r0, r2
	orrs r0, r1
	strh r0, [r5, #4]
	movs r0, #0x7d
	rsbs r0, r0, #0
	ldrb r4, [r5, #5]
	ands r0, r4
	strb r0, [r5, #5]
	ldr r0, [r5, #4]
	ldr r1, =0xFFF07FFF
	ands r0, r1
	str r0, [r5, #4]
	ldr r0, =0xFFFFFE0F
	ldrh r1, [r5, #6]
	ands r0, r1
	strh r0, [r5, #6]
	movs r0, #0x3f
	rsbs r0, r0, #0
	ldrb r2, [r5, #7]
	ands r0, r2
_0200BFFA:
	strb r0, [r5, #7]
_0200BFFC:
	ldr r4, [sp]
	cmp r4, #0xa
	ble _0200C024
	adds r0, r6, #0
	bl sub_0200ADE0
	strh r0, [r6, #0x1c]
	movs r3, #0
	adds r2, r6, #0
	adds r2, #0x20
_0200C010:
	ldr r0, [r2]
	ldr r1, [r6]
	eors r0, r1
	str r0, [r2]
	ldr r1, [r6, #4]
	eors r0, r1
	stm r2!, {r0}
	adds r3, #1
	cmp r3, #0xb
	bls _0200C010
_0200C024:
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

	thumb_func_start sub_0200C040
sub_0200C040: @ 0x0200C040
	push {r4, lr}
	adds r3, r0, #0
	adds r0, r1, #0
	subs r0, #0x37
	cmp r0, #0xa
	bhi _0200C124
	lsls r0, r0, #2
	ldr r1, =_0200C05C
	adds r0, r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
	.pool
_0200C05C: @ jump table
	.4byte _0200C088 @ case 0
	.4byte _0200C0A0 @ case 1
	.4byte _0200C0AA @ case 2
	.4byte _0200C0BA @ case 3
	.4byte _0200C0CA @ case 4
	.4byte _0200C0DA @ case 5
	.4byte _0200C0EA @ case 6
	.4byte _0200C0FA @ case 7
	.4byte _0200C10A @ case 8
	.4byte _0200C11A @ case 9
	.4byte _0200C12A @ case 10
_0200C088:
	ldrb r1, [r2, #1]
	lsls r0, r1, #8
	ldrb r4, [r2]
	orrs r0, r4
	ldrb r4, [r2, #2]
	lsls r1, r4, #0x10
	adds r0, r0, r1
	ldrb r2, [r2, #3]
	lsls r1, r2, #0x18
	adds r0, r0, r1
	str r0, [r3, #0x50]
	b _0200C12A
_0200C0A0:
	ldrb r1, [r2]
	adds r0, r3, #0
	adds r0, #0x54
	strb r1, [r0]
	b _0200C12A
_0200C0AA:
	ldrb r1, [r2, #1]
	lsls r0, r1, #8
	ldrb r2, [r2]
	orrs r0, r2
	adds r1, r3, #0
	adds r1, #0x56
	strh r0, [r1]
	b _0200C12A
_0200C0BA:
	ldrb r4, [r2, #1]
	lsls r0, r4, #8
	ldrb r2, [r2]
	orrs r0, r2
	adds r1, r3, #0
	adds r1, #0x58
	strh r0, [r1]
	b _0200C12A
_0200C0CA:
	ldrb r1, [r2, #1]
	lsls r0, r1, #8
	ldrb r2, [r2]
	orrs r0, r2
	adds r1, r3, #0
	adds r1, #0x5a
	strh r0, [r1]
	b _0200C12A
_0200C0DA:
	ldrb r4, [r2, #1]
	lsls r0, r4, #8
	ldrb r2, [r2]
	orrs r0, r2
	adds r1, r3, #0
	adds r1, #0x5c
	strh r0, [r1]
	b _0200C12A
_0200C0EA:
	ldrb r1, [r2, #1]
	lsls r0, r1, #8
	ldrb r2, [r2]
	orrs r0, r2
	adds r1, r3, #0
	adds r1, #0x5e
	strh r0, [r1]
	b _0200C12A
_0200C0FA:
	ldrb r4, [r2, #1]
	lsls r0, r4, #8
	ldrb r2, [r2]
	orrs r0, r2
	adds r1, r3, #0
	adds r1, #0x60
	strh r0, [r1]
	b _0200C12A
_0200C10A:
	ldrb r1, [r2, #1]
	lsls r0, r1, #8
	ldrb r2, [r2]
	orrs r0, r2
	adds r1, r3, #0
	adds r1, #0x62
	strh r0, [r1]
	b _0200C12A
_0200C11A:
	ldrb r1, [r2]
	adds r0, r3, #0
	adds r0, #0x55
	strb r1, [r0]
	b _0200C12A
_0200C124:
	adds r0, r3, #0
	bl sub_0200B9C0
_0200C12A:
	pop {r4}
	pop {r0}
	bx r0

	thumb_func_start sub_0200C130
sub_0200C130: @ 0x0200C130
	push {r4, r5, r6, r7, lr}
	sub sp, #8
	lsls r0, r0, #0x18
	lsrs r4, r0, #0x18
	lsls r1, r1, #0x18
	lsrs r5, r1, #0x18
	movs r7, #0
	ldr r1, =gUnknown_0201ED5B
	mov r0, sp
	movs r2, #7
	bl memcpy
	cmp r4, #0xa
	bhi _0200C19E
	cmp r5, #0x40
	bhi _0200C19E
	cmp r4, #6
	bhi _0200C19E
	ldr r0, =gUnknown_02022EDC
	ldr r0, [r0]
	adds r0, r0, r4
	strb r5, [r0]
	movs r5, #0
	ldr r6, =gUnknown_02022EF4
_0200C160:
	movs r0, #0x64
	adds r4, r5, #0
	muls r4, r0, r4
	ldr r0, [r6]
	adds r0, r4, r0
	movs r1, #0xb
	movs r2, #0
	bl sub_0200AE74
	cmp r0, #0
	beq _0200C188
	ldr r0, [r6]
	adds r0, r4, r0
	movs r1, #6
	movs r2, #0
	bl sub_0200AE74
	cmp r0, #0
	bne _0200C188
	movs r7, #1
_0200C188:
	adds r5, #1
	cmp r5, #5
	ble _0200C160
	cmp r7, #0
	beq _0200C19E
	ldr r0, =gUnknown_020251E8
	ldr r0, [r0]
	adds r0, #0xf0
	ldr r0, [r0]
	bl sub_0200CB60
_0200C19E:
	add sp, #8
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_0200C1B8
sub_0200C1B8: @ 0x0200C1B8
	push {lr}
	adds r3, r0, #0
	adds r0, r1, #0
	subs r0, #0x37
	cmp r0, #9
	bhi _0200C248
	lsls r0, r0, #2
	ldr r1, =_0200C1D4
	adds r0, r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
	.pool
_0200C1D4: @ jump table
	.4byte _0200C1FC @ case 0
	.4byte _0200C200 @ case 1
	.4byte _0200C208 @ case 2
	.4byte _0200C210 @ case 3
	.4byte _0200C218 @ case 4
	.4byte _0200C220 @ case 5
	.4byte _0200C228 @ case 6
	.4byte _0200C230 @ case 7
	.4byte _0200C238 @ case 8
	.4byte _0200C240 @ case 9
_0200C1FC:
	ldr r0, [r3, #0x50]
	b _0200C24E
_0200C200:
	adds r0, r3, #0
	adds r0, #0x54
	ldrb r0, [r0]
	b _0200C24E
_0200C208:
	adds r0, r3, #0
	adds r0, #0x56
	ldrh r0, [r0]
	b _0200C24E
_0200C210:
	adds r0, r3, #0
	adds r0, #0x58
	ldrh r0, [r0]
	b _0200C24E
_0200C218:
	adds r0, r3, #0
	adds r0, #0x5a
	ldrh r0, [r0]
	b _0200C24E
_0200C220:
	adds r0, r3, #0
	adds r0, #0x5c
	ldrh r0, [r0]
	b _0200C24E
_0200C228:
	adds r0, r3, #0
	adds r0, #0x5e
	ldrh r0, [r0]
	b _0200C24E
_0200C230:
	adds r0, r3, #0
	adds r0, #0x60
	ldrh r0, [r0]
	b _0200C24E
_0200C238:
	adds r0, r3, #0
	adds r0, #0x62
	ldrh r0, [r0]
	b _0200C24E
_0200C240:
	adds r0, r3, #0
	adds r0, #0x55
	ldrb r0, [r0]
	b _0200C24E
_0200C248:
	adds r0, r3, #0
	bl sub_0200AE74
_0200C24E:
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_0200C254
sub_0200C254: @ 0x0200C254
	push {r4, r5, r6, lr}
	adds r4, r0, #0
	ldr r0, =gUnknown_020251E8
	ldr r0, [r0]
	adds r0, #0xbc
	ldr r6, [r0]
	adds r0, r4, #0
	movs r1, #0xb
	movs r2, #0
	bl sub_0200AE74
	lsls r0, r0, #0x10
	lsrs r5, r0, #0x10
	adds r0, r4, #0
	movs r1, #0
	movs r2, #0
	bl sub_0200AE74
	adds r2, r0, #0
	lsls r0, r5, #3
	subs r0, r0, r5
	lsls r0, r0, #2
	adds r0, r0, r6
	ldrb r0, [r0, #0x10]
	cmp r0, #0
	beq _0200C2B2
	cmp r0, #0
	blt _0200C294
	cmp r0, #0xff
	bgt _0200C294
	cmp r0, #0xfe
	bge _0200C2B2
_0200C294:
	lsls r0, r5, #3
	subs r0, r0, r5
	lsls r0, r0, #2
	adds r0, r0, r6
	movs r1, #0xff
	ands r1, r2
	ldrb r0, [r0, #0x10]
	cmp r0, r1
	bls _0200C2B0
	movs r0, #0xfe
	b _0200C2B2
	.align 2, 0
	.pool
_0200C2B0:
	movs r0, #0
_0200C2B2:
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	pop {r4, r5, r6}
	pop {r1}
	bx r1

	thumb_func_start sub_0200C2BC
sub_0200C2BC: @ 0x0200C2BC
	push {r4, r5, lr}
	adds r3, r2, #0
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
	adds r5, r4, #0
	movs r0, #0xce
	lsls r0, r0, #1
	cmp r4, r0
	bls _0200C2DC
	ldr r0, =gUnknown_020251E8
	ldr r0, [r0]
	ldr r0, [r0, #0x30]
	b _0200C30E
	.align 2, 0
	.pool
_0200C2DC:
	lsrs r0, r1, #0x10
	ldr r2, =0x0000FFFF
	ands r1, r2
	eors r0, r1
	lsrs r1, r3, #0x10
	eors r0, r1
	ands r3, r2
	eors r0, r3
	cmp r0, #7
	bls _0200C304
	ldr r0, =gUnknown_020251E8
	ldr r0, [r0]
	lsls r1, r4, #3
	ldr r0, [r0, #0x30]
	b _0200C30C
	.align 2, 0
	.pool
_0200C304:
	ldr r0, =gUnknown_020251E8
	ldr r0, [r0]
	lsls r1, r5, #3
	ldr r0, [r0, #0x34]
_0200C30C:
	adds r0, r0, r1
_0200C30E:
	pop {r4, r5}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200C318
sub_0200C318: @ 0x0200C318
	push {lr}
	adds r2, r1, #0
	lsls r0, r0, #0x10
	lsrs r1, r0, #0x10
	cmp r1, #0xc9
	bne _0200C366
	movs r0, #0xc0
	lsls r0, r0, #0x12
	ands r0, r2
	lsrs r0, r0, #0x12
	movs r1, #0xc0
	lsls r1, r1, #0xa
	ands r1, r2
	lsrs r1, r1, #0xc
	orrs r0, r1
	movs r1, #0xc0
	lsls r1, r1, #2
	ands r1, r2
	lsrs r1, r1, #6
	orrs r0, r1
	movs r1, #3
	ands r1, r2
	orrs r0, r1
	movs r1, #0x1c
	bl __umodsi3
	lsls r0, r0, #0x10
	lsrs r0, r0, #0x10
	cmp r0, #0
	bne _0200C358
	movs r0, #0xc9
	b _0200C362
_0200C358:
	movs r1, #0xce
	lsls r1, r1, #1
	adds r0, r0, r1
	lsls r0, r0, #0x10
	lsrs r0, r0, #0x10
_0200C362:
	adds r1, r0, #0
	b _0200C372
_0200C366:
	movs r0, #0xce
	lsls r0, r0, #1
	cmp r1, r0
	bls _0200C372
	movs r1, #0x82
	lsls r1, r1, #1
_0200C372:
	adds r0, r1, #0
	pop {r1}
	bx r1

	thumb_func_start sub_0200C378
sub_0200C378: @ 0x0200C378
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #4
	mov ip, r0
	adds r5, r1, #0
	ldr r0, =gUnknown_020251E8
	ldr r0, [r0]
	ldr r3, [r0, #0x44]
	movs r1, #0
	adds r4, r0, #0
	adds r4, #0x76
	adds r2, r0, #0
	adds r2, #0x82
	ldrb r6, [r2]
	ldrb r7, [r4]
	adds r0, r6, r7
	cmp r1, r0
	bge _0200C3E4
	movs r0, #0xb
	muls r0, r5, r0
	adds r0, r0, r3
	mov sl, r0
	mov sb, r2
	mov r2, ip
	movs r0, #0xce
	lsls r0, r0, #1
	mov r8, r0
	str r4, [sp]
_0200C3B6:
	cmp r5, r8
	ble _0200C3C4
	adds r0, r3, r1
	b _0200C3C8
	.align 2, 0
	.pool
_0200C3C4:
	mov r4, sl
	adds r0, r4, r1
_0200C3C8:
	ldrb r0, [r0]
	strb r0, [r2]
	ldrb r0, [r2]
	cmp r0, #0xff
	beq _0200C3E4
	adds r2, #1
	adds r1, #1
	mov r6, sb
	ldrb r7, [r6]
	ldr r6, [sp]
	ldrb r6, [r6]
	adds r0, r7, r6
	cmp r1, r0
	blt _0200C3B6
_0200C3E4:
	add r1, ip
	movs r0, #0xff
	strb r0, [r1]
	add sp, #4
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start sub_0200C3FC
sub_0200C3FC: @ 0x0200C3FC
	push {r4, r5, lr}
	adds r4, r1, #0
	ldr r1, =gUnknown_020251E8
	ldr r1, [r1]
	adds r1, #0xbc
	ldr r5, [r1]
	movs r1, #0xb
	movs r2, #0
	bl sub_0200AE74
	adds r1, r0, #0
	cmp r4, #1
	beq _0200C424
	cmp r4, #2
	beq _0200C430
	movs r0, #0
	b _0200C43A
	.align 2, 0
	.pool
_0200C424:
	lsls r0, r1, #3
	subs r0, r0, r1
	lsls r0, r0, #2
	adds r0, r0, r5
	ldrb r0, [r0, #6]
	b _0200C43A
_0200C430:
	lsls r0, r1, #3
	subs r0, r0, r1
	lsls r0, r0, #2
	adds r0, r0, r5
	ldrb r0, [r0, #7]
_0200C43A:
	pop {r4, r5}
	pop {r1}
	bx r1

	thumb_func_start sub_0200C440
sub_0200C440: @ 0x0200C440
	ldr r1, =gUnknown_0201ED40
	adds r0, r0, r1
	ldrb r0, [r0]
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_0200C44C
sub_0200C44C: @ 0x0200C44C
	adds r2, r0, #0
	ldr r0, =gUnknown_020251E8
	ldr r0, [r0]
	adds r0, #0xc0
	ldr r0, [r0]
	movs r1, #0xd
	muls r1, r2, r1
	adds r0, r0, r1
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_0200C464
sub_0200C464: @ 0x0200C464
	ldr r1, =gUnknown_020251E8
	ldr r1, [r1]
	adds r1, #0xc4
	ldr r1, [r1]
	lsls r0, r0, #2
	adds r0, r0, r1
	ldr r0, [r0]
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_0200C478
sub_0200C478: @ 0x0200C478
	push {r4, lr}
	ldr r3, =gUnknown_020251E8
	ldr r3, [r3]
	adds r3, #0xcc
	ldr r4, [r3]
	lsls r3, r0, #1
	adds r3, r3, r0
	lsls r3, r3, #2
	adds r3, r3, r4
	ldrb r4, [r3, #4]
	ldr r0, =gUnknown_0201ED57
	adds r0, r2, r0
	ldrb r0, [r0]
	ands r1, r0
	lsls r2, r2, #1
	asrs r1, r2
	lsls r0, r1, #2
	adds r0, r0, r1
	lsls r0, r0, #2
	muls r0, r4, r0
	movs r1, #0x64
	bl __divsi3
	adds r4, r4, r0
	adds r0, r4, #0
	pop {r4}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200C4B8
sub_0200C4B8: @ 0x0200C4B8
	push {r4, r5, r6, r7, lr}
	adds r3, r0, #0
	mov ip, r1
	ldr r0, =gUnknown_020251E8
	ldr r0, [r0]
	ldr r1, [r0, #0x48]
	movs r2, #0
	adds r7, r0, #0
	adds r7, #0x78
	adds r4, r0, #0
	adds r4, #0x82
	ldrb r5, [r4]
	ldrb r6, [r7]
	adds r0, r5, r6
	cmp r2, r0
	bge _0200C510
	movs r0, #0xd
	mov r5, ip
	muls r5, r0, r5
	adds r0, r5, #0
	adds r1, r0, r1
	ldrb r0, [r1]
	strb r0, [r3]
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	cmp r0, #0xff
	beq _0200C510
	adds r6, r4, #0
	adds r5, r1, #0
	adds r4, r7, #0
_0200C4F4:
	adds r2, #1
	ldrb r7, [r6]
	ldrb r1, [r4]
	adds r0, r7, r1
	cmp r2, r0
	bge _0200C510
	adds r1, r3, r2
	adds r0, r5, r2
	ldrb r0, [r0]
	strb r0, [r1]
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	cmp r0, #0xff
	bne _0200C4F4
_0200C510:
	adds r1, r3, r2
	movs r0, #0xff
	strb r0, [r1]
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_0200C520
sub_0200C520: @ 0x0200C520
	ldr r0, =gUnknown_02022EF0
	ldr r1, [r0]
	ldrb r0, [r1]
	cmp r0, #6
	beq _0200C540
	ldr r2, =gUnknown_02022EF4
	movs r0, #0x64
	ldrb r1, [r1]
	muls r1, r0, r1
	ldr r0, [r2]
	adds r0, r0, r1
	b _0200C542
	.align 2, 0
	.pool
_0200C540:
	movs r0, #0
_0200C542:
	bx lr

	thumb_func_start sub_0200C544
sub_0200C544: @ 0x0200C544
	push {r4, r5, r6, lr}
	adds r4, r0, #0
	ldr r0, =gUnknown_020251E8
	ldr r0, [r0]
	adds r0, #0xbc
	ldr r6, [r0]
	adds r0, r4, #0
	movs r1, #0xb
	movs r2, #0
	bl sub_0200AE74
	lsls r0, r0, #0x10
	lsrs r5, r0, #0x10
	adds r0, r4, #0
	movs r1, #0
	movs r2, #0
	bl sub_0200AE74
	adds r2, r0, #0
	lsls r0, r5, #3
	subs r0, r0, r5
	lsls r0, r0, #2
	adds r0, r0, r6
	ldrb r0, [r0, #0x10]
	cmp r0, #0
	beq _0200C5A2
	cmp r0, #0
	blt _0200C584
	cmp r0, #0xff
	bgt _0200C584
	cmp r0, #0xfe
	bge _0200C5A2
_0200C584:
	lsls r0, r5, #3
	subs r0, r0, r5
	lsls r0, r0, #2
	adds r0, r0, r6
	movs r1, #0xff
	ands r1, r2
	ldrb r0, [r0, #0x10]
	cmp r0, r1
	bhi _0200C5A0
	movs r0, #0
	b _0200C5A2
	.align 2, 0
	.pool
_0200C5A0:
	movs r0, #0xfe
_0200C5A2:
	pop {r4, r5, r6}
	pop {r1}
	bx r1

	thumb_func_start sub_0200C5A8
sub_0200C5A8: @ 0x0200C5A8
	push {lr}
	adds r2, r0, #0
	movs r0, #0xc0
	lsls r0, r0, #0x12
	ands r0, r2
	lsrs r0, r0, #0x12
	movs r1, #0xc0
	lsls r1, r1, #0xa
	ands r1, r2
	lsrs r1, r1, #0xc
	orrs r0, r1
	movs r1, #0xc0
	lsls r1, r1, #2
	ands r1, r2
	lsrs r1, r1, #6
	orrs r0, r1
	movs r1, #3
	ands r1, r2
	orrs r0, r1
	movs r1, #0x1c
	bl __umodsi3
	lsls r0, r0, #0x10
	lsrs r0, r0, #0x10
	pop {r1}
	bx r1

	thumb_func_start sub_0200C5DC
sub_0200C5DC: @ 0x0200C5DC
	push {r4, r5, r6, r7, lr}
	ldr r3, =gUnknown_02022EE8
	ldr r1, [r3]
	ldr r6, [r1, #0xc]
	ldr r7, [r1, #0x10]
	movs r2, #0
	str r2, [r1, #0xc]
	str r2, [r1, #0x10]
	adds r5, r0, #0
	movs r4, #0
	movs r1, #0
	ldr r0, =gUnknown_020251E8
	ldr r0, [r0]
	adds r0, #0xf8
	ldr r0, [r0]
	subs r0, #4
	cmp r4, r0
	bhs _0200C60E
	adds r2, r0, #0
_0200C602:
	adds r0, r5, r1
	ldrb r0, [r0]
	adds r4, r0, r4
	adds r1, #1
	cmp r1, r2
	blo _0200C602
_0200C60E:
	ldr r0, [r3]
	str r6, [r0, #0xc]
	str r7, [r0, #0x10]
	adds r0, r4, #0
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200C624
sub_0200C624: @ 0x0200C624
	ldr r0, =gUnknown_02022EE8
	ldr r1, [r0]
	ldrb r0, [r1, #0x14]
	cmp r0, #0
	beq _0200C63C
	ldrb r0, [r1, #0xa]
	cmp r0, #0
	beq _0200C63C
	movs r0, #1
	b _0200C63E
	.align 2, 0
	.pool
_0200C63C:
	movs r0, #0
_0200C63E:
	bx lr

	thumb_func_start sub_0200C640
sub_0200C640: @ 0x0200C640
	lsls r0, r0, #0x18
	lsrs r2, r0, #0x18
	cmp r2, #0x2b
	bne _0200C664
	ldr r0, =gUnknown_02022EE8
	ldr r1, [r0]
	ldrb r0, [r1, #0x14]
	cmp r0, #0
	beq _0200C664
	ldrb r3, [r1, #0xa]
	rsbs r0, r3, #0
	cmp r0, #0
	bge _0200C664
	adds r0, r1, #0
	b _0200C67A
	.align 2, 0
	.pool
_0200C664:
	subs r0, r2, #1
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	cmp r0, #0x2a
	bls _0200C670
	movs r2, #1
_0200C670:
	lsls r0, r2, #3
	subs r0, r0, r2
	lsls r0, r0, #2
	ldr r1, =gUnknown_0201E7F0
	adds r0, r0, r1
_0200C67A:
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_0200C680
sub_0200C680: @ 0x0200C680
	lsls r0, r0, #0x10
	lsrs r1, r0, #0x10
	ldr r0, =gUnknown_020251E8
	ldr r0, [r0]
	adds r0, #0xc8
	ldr r2, [r0]
	movs r0, #0xae
	lsls r0, r0, #1
	cmp r1, r0
	bls _0200C696
	movs r1, #0
_0200C696:
	movs r0, #0x2c
	muls r0, r1, r0
	adds r0, r2, r0
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_0200C6A4
sub_0200C6A4: @ 0x0200C6A4
	push {r4, r5, lr}
	adds r4, r1, #0
	adds r5, r2, #0
	lsls r0, r0, #0x10
	lsrs r1, r0, #0x10
	adds r2, r1, #0
	cmp r1, #0xaf
	bne _0200C6F8
	movs r2, #0x2b
	ldr r0, =gUnknown_02022EE8
	ldr r1, [r0]
	ldrb r0, [r1, #0x14]
	cmp r0, #0
	beq _0200C6C8
	ldrb r3, [r1, #0xa]
	rsbs r0, r3, #0
	cmp r0, #0
	blt _0200C6DE
_0200C6C8:
	subs r0, r2, #1
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	cmp r0, #0x2a
	bls _0200C6D4
	movs r2, #1
_0200C6D4:
	lsls r0, r2, #3
	subs r0, r0, r2
	lsls r0, r0, #2
	ldr r1, =gUnknown_0201E7F0
	adds r1, r0, r1
_0200C6DE:
	adds r0, r4, #0
	bl StringCopy
	adds r0, r4, #0
	adds r1, r5, #0
	bl StringAppend
	b _0200C722
	.align 2, 0
	.pool
_0200C6F8:
	ldr r0, =gUnknown_020251E8
	ldr r0, [r0]
	adds r0, #0xc8
	ldr r3, [r0]
	movs r0, #0xae
	lsls r0, r0, #1
	cmp r1, r0
	bls _0200C710
	movs r1, #0
	b _0200C712
	.align 2, 0
	.pool
_0200C710:
	adds r1, r2, #0
_0200C712:
	movs r0, #0x2c
	adds r2, r1, #0
	muls r2, r0, r2
	adds r1, r2, #0
	adds r1, r3, r1
	adds r0, r4, #0
	bl StringCopy
_0200C722:
	pop {r4, r5}
	pop {r0}
	bx r0

	thumb_func_start sub_0200C728
sub_0200C728: @ 0x0200C728
	lsls r0, r0, #0x10
	lsrs r0, r0, #0x10
	subs r0, #1
	cmp r0, #0xb
	bhi _0200C79C
	lsls r0, r0, #2
	ldr r1, =_0200C740
	adds r0, r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
	.pool
_0200C740: @ jump table
	.4byte _0200C770 @ case 0
	.4byte _0200C774 @ case 1
	.4byte _0200C778 @ case 2
	.4byte _0200C79C @ case 3
	.4byte _0200C77C @ case 4
	.4byte _0200C780 @ case 5
	.4byte _0200C784 @ case 6
	.4byte _0200C788 @ case 7
	.4byte _0200C78C @ case 8
	.4byte _0200C790 @ case 9
	.4byte _0200C794 @ case 10
	.4byte _0200C798 @ case 11
_0200C770:
	movs r0, #4
	b _0200C79E
_0200C774:
	movs r0, #3
	b _0200C79E
_0200C778:
	movs r0, #1
	b _0200C79E
_0200C77C:
	movs r0, #2
	b _0200C79E
_0200C780:
	movs r0, #5
	b _0200C79E
_0200C784:
	movs r0, #6
	b _0200C79E
_0200C788:
	movs r0, #7
	b _0200C79E
_0200C78C:
	movs r0, #8
	b _0200C79E
_0200C790:
	movs r0, #9
	b _0200C79E
_0200C794:
	movs r0, #0xa
	b _0200C79E
_0200C798:
	movs r0, #0xb
	b _0200C79E
_0200C79C:
	movs r0, #0
_0200C79E:
	bx lr

	thumb_func_start sub_0200C7A0
sub_0200C7A0: @ 0x0200C7A0
	push {r4, r5, r6, r7, lr}
	lsls r0, r0, #0x10
	lsls r1, r1, #0x18
	lsrs r2, r1, #0x18
	adds r4, r2, #0
	ldr r1, =0xFFFF0000
	adds r0, r0, r1
	lsrs r1, r0, #0x10
	lsrs r0, r0, #0x13
	lsls r0, r0, #0x18
	lsrs r3, r0, #0x18
	movs r0, #7
	ands r1, r0
	movs r0, #0x80
	lsls r0, r0, #0x11
	lsls r0, r1
	lsrs r5, r0, #0x18
	movs r6, #0
	cmp r2, #1
	beq _0200C834
	cmp r2, #1
	bgt _0200C7D8
	cmp r2, #0
	beq _0200C7E4
	b _0200C914
	.align 2, 0
	.pool
_0200C7D8:
	cmp r4, #2
	beq _0200C8CA
	cmp r4, #3
	bne _0200C7E2
	b _0200C904
_0200C7E2:
	b _0200C914
_0200C7E4:
	ldr r1, =gUnknown_02022EC8
	ldr r0, [r1]
	adds r0, #0x44
	adds r0, r0, r3
	adds r4, r5, #0
	ldrb r0, [r0]
	ands r4, r0
	adds r7, r1, #0
	cmp r4, #0
	bne _0200C7FA
	b _0200C914
_0200C7FA:
	ldr r0, =gUnknown_02022EF8
	ldr r1, [r0]
	adds r1, r1, r3
	adds r2, r5, #0
	ldrb r1, [r1]
	ands r2, r1
	adds r6, r0, #0
	ldr r0, =gUnknown_02022EE0
	mov ip, r0
	cmp r4, r2
	bne _0200C81E
	ldr r0, [r0]
	adds r0, r0, r3
	adds r1, r5, #0
	ldrb r0, [r0]
	ands r1, r0
	cmp r4, r1
	beq _0200C87E
_0200C81E:
	ldr r1, [r7]
	adds r1, #0x44
	adds r1, r1, r3
	mvns r2, r5
	b _0200C8A6
	.align 2, 0
	.pool
_0200C834:
	ldr r1, =gUnknown_02022EC8
	ldr r4, [r1]
	adds r0, r4, #0
	adds r0, #0x10
	adds r0, r0, r3
	adds r2, r5, #0
	ldrb r0, [r0]
	ands r2, r0
	adds r7, r1, #0
	cmp r2, #0
	beq _0200C914
	adds r0, r4, #0
	adds r0, #0x44
	adds r0, r0, r3
	adds r1, r5, #0
	ldrb r0, [r0]
	ands r1, r0
	ldr r6, =gUnknown_02022EF8
	ldr r0, =gUnknown_02022EE0
	mov ip, r0
	cmp r2, r1
	bne _0200C890
	ldr r0, [r6]
	adds r0, r0, r3
	adds r1, r5, #0
	ldrb r0, [r0]
	ands r1, r0
	cmp r2, r1
	bne _0200C890
	mov r1, ip
	ldr r0, [r1]
	adds r0, r0, r3
	adds r1, r5, #0
	ldrb r0, [r0]
	ands r1, r0
	cmp r2, r1
	bne _0200C890
_0200C87E:
	movs r6, #1
	b _0200C914
	.align 2, 0
	.pool
_0200C890:
	ldr r1, [r7]
	adds r1, #0x10
	adds r1, r1, r3
	mvns r2, r5
	adds r0, r2, #0
	ldrb r4, [r1]
	ands r0, r4
	strb r0, [r1]
	ldr r1, [r7]
	adds r1, #0x44
	adds r1, r1, r3
_0200C8A6:
	adds r0, r2, #0
	ldrb r4, [r1]
	ands r0, r4
	strb r0, [r1]
	ldr r1, [r6]
	adds r1, r1, r3
	adds r0, r2, #0
	ldrb r4, [r1]
	ands r0, r4
	strb r0, [r1]
	mov r1, ip
	ldr r0, [r1]
	adds r0, r0, r3
	ldrb r4, [r0]
	ands r2, r4
	strb r2, [r0]
	movs r6, #0
	b _0200C914
_0200C8CA:
	ldr r0, =gUnknown_02022EC8
	ldr r1, [r0]
	adds r1, #0x44
	adds r1, r1, r3
	adds r0, r5, #0
	ldrb r2, [r1]
	orrs r0, r2
	strb r0, [r1]
	ldr r0, =gUnknown_02022EF8
	ldr r1, [r0]
	adds r1, r1, r3
	adds r0, r5, #0
	ldrb r4, [r1]
	orrs r0, r4
	strb r0, [r1]
	ldr r0, =gUnknown_02022EE0
	ldr r1, [r0]
	adds r1, r1, r3
	adds r0, r5, #0
	ldrb r2, [r1]
	orrs r0, r2
	b _0200C912
	.align 2, 0
	.pool
_0200C904:
	ldr r0, =gUnknown_02022EC8
	ldr r1, [r0]
	adds r1, #0x10
	adds r1, r1, r3
	adds r0, r5, #0
	ldrb r4, [r1]
	orrs r0, r4
_0200C912:
	strb r0, [r1]
_0200C914:
	adds r0, r6, #0
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200C920
sub_0200C920: @ 0x0200C920
	lsls r0, r0, #0x10
	lsrs r0, r0, #0x10
	adds r2, r0, #0
	cmp r2, #0
	bne _0200C92E
	movs r0, #0
	b _0200C944
_0200C92E:
	subs r1, r2, #1
	movs r0, #0xcd
	lsls r0, r0, #1
	cmp r1, r0
	bls _0200C93C
	adds r0, r2, #0
	b _0200C944
_0200C93C:
	ldr r0, =gUnknown_0201ED64
	lsls r1, r1, #1
	adds r1, r1, r0
	ldrh r0, [r1]
_0200C944:
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_0200C94C
sub_0200C94C: @ 0x0200C94C
	push {r4, r5, r6, lr}
	adds r4, r0, #0
	adds r6, r1, #0
	lsls r0, r4, #0x10
	lsrs r0, r0, #0x10
	adds r1, r0, #0
	cmp r0, #0
	bne _0200C960
	movs r0, #0
	b _0200C97A
_0200C960:
	subs r2, r0, #1
	movs r0, #0xcd
	lsls r0, r0, #1
	cmp r2, r0
	bhi _0200C978
	ldr r1, =gUnknown_0201ED64
	lsls r0, r2, #1
	adds r0, r0, r1
	ldrh r0, [r0]
	b _0200C97A
	.align 2, 0
	.pool
_0200C978:
	adds r0, r1, #0
_0200C97A:
	adds r5, r0, #0
	movs r1, #1
	bl sub_0200C7A0
	cmp r0, #0
	bne _0200C9A2
	cmp r4, #0xc9
	bne _0200C992
	ldr r0, =gUnknown_02022EC8
	ldr r1, [r0]
	ldr r0, [r6]
	str r0, [r1, #4]
_0200C992:
	movs r0, #0x9a
	lsls r0, r0, #1
	cmp r4, r0
	bne _0200C9A2
	ldr r0, =gUnknown_02022EC8
	ldr r1, [r0]
	ldr r0, [r6]
	str r0, [r1, #8]
_0200C9A2:
	adds r4, r5, #0
	adds r0, r4, #0
	movs r1, #2
	bl sub_0200C7A0
	adds r0, r4, #0
	movs r1, #3
	bl sub_0200C7A0
	pop {r4, r5, r6}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_0200C9C0
sub_0200C9C0: @ 0x0200C9C0
	push {r4, r5, r6, r7, lr}
	mov r7, r8
	push {r7}
	sub sp, #4
	adds r6, r0, #0
	adds r5, r2, #0
	ldr r7, =gUnknown_02023F50
	mov r0, sp
	movs r1, #0
	strh r1, [r0]
	ldr r2, =0x0100013C
	adds r1, r7, #0
	bl CpuSet
	cmp r5, #1
	beq _0200C9E2
	b _0200CAF0
_0200C9E2:
	ldr r0, =gUnknown_020251E8
	mov r8, r0
	ldr r0, [r0]
	adds r0, #0xb8
	ldrb r0, [r0]
	lsls r0, r0, #0x1e
	cmp r0, #0
	blt _0200CA60
	bl sub_0200CD88
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	movs r4, #1
	ands r0, r4
	movs r1, #2
	rsbs r1, r1, #0
	ldrb r2, [r7]
	ands r1, r2
	orrs r1, r0
	strb r1, [r7]
	bl sub_0200CD38
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x19
	ands r0, r5
	ands r0, r4
	lsls r0, r0, #1
	movs r1, #3
	rsbs r1, r1, #0
	ldrb r2, [r7]
	ands r1, r2
	orrs r1, r0
	strb r1, [r7]
	bl sub_0200CDD0
	ands r0, r4
	lsls r0, r0, #2
	movs r1, #5
	rsbs r1, r1, #0
	ldrb r2, [r7]
	ands r1, r2
	orrs r1, r0
	strb r1, [r7]
	bl sub_0200CD38
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x1f
	ands r0, r4
	lsls r0, r0, #3
	movs r1, #9
	rsbs r1, r1, #0
	ldrb r2, [r7]
	ands r1, r2
	orrs r1, r0
	strb r1, [r7]
	mov r2, r8
	ldr r0, [r2]
	ldr r0, [r0, #4]
	lsls r0, r0, #4
	movs r2, #0xf
	ands r1, r2
	orrs r1, r0
	strb r1, [r7]
_0200CA60:
	mov r1, r8
	ldr r0, [r1]
	adds r0, #0xa0
	ldr r0, [r0]
	adds r2, r6, r0
	adds r0, r7, #4
	adds r1, r2, #0
	bl StringCopy
	mov r2, r8
	ldr r1, [r2]
	adds r0, r1, #0
	adds r0, #0xa4
	ldr r0, [r0]
	adds r2, r6, r0
	ldrb r0, [r2]
	str r0, [r7, #0xc]
	adds r1, #0x9c
	ldr r0, [r1]
	adds r2, r6, r0
	movs r4, #0
	adds r3, r7, #0
	adds r3, #0x10
_0200CA8E:
	adds r0, r3, r4
	adds r1, r2, r4
	ldrb r1, [r1]
	strb r1, [r0]
	adds r4, #1
	cmp r4, #3
	ble _0200CA8E
	movs r4, #0
	ldr r0, =gUnknown_02022EF4
	mov r8, r0
	adds r5, r7, #0
	adds r5, #0x14
	movs r6, #0
_0200CAA8:
	mov r1, r8
	ldr r0, [r1]
	adds r0, r0, r6
	adds r1, r5, #0
	movs r2, #0x32
	bl CpuSet
	adds r5, #0x64
	adds r6, #0x64
	adds r4, #1
	cmp r4, #5
	ble _0200CAA8
	movs r4, #0
	movs r0, #0x9b
	lsls r0, r0, #2
	adds r2, r7, r0
	ldr r3, =gUnknown_02022EDC
_0200CACA:
	adds r0, r2, r4
	ldr r1, [r3]
	adds r1, r1, r4
	ldrb r1, [r1]
	strb r1, [r0]
	adds r4, #1
	cmp r4, #0xa
	ble _0200CACA
	b _0200CB1C
	.align 2, 0
	.pool
_0200CAF0:
	cmp r5, #2
	bne _0200CB00
	movs r0, #4
	rsbs r0, r0, #0
	ldrb r1, [r7, #1]
	ands r0, r1
	movs r1, #1
	b _0200CB18
_0200CB00:
	cmp r5, #0xff
	bne _0200CB10
	movs r0, #4
	rsbs r0, r0, #0
	ldrb r2, [r7, #1]
	ands r0, r2
	movs r1, #2
	b _0200CB18
_0200CB10:
	cmp r5, #0
	bne _0200CB1C
	movs r0, #3
	ldrb r1, [r7, #1]
_0200CB18:
	orrs r0, r1
	strb r0, [r7, #1]
_0200CB1C:
	adds r0, r7, #0
	add sp, #4
	pop {r3}
	mov r8, r3
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_0200CB2C
sub_0200CB2C: @ 0x0200CB2C
	ldr r0, =gUnknown_02023F50
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_0200CB34
sub_0200CB34: @ 0x0200CB34
	adds r1, r0, #0
	lsls r0, r1, #2
	adds r0, r0, r1
	lsls r0, r0, #6
	ldr r1, =gUnknown_020241D0
	adds r0, r0, r1
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_0200CB48
sub_0200CB48: @ 0x0200CB48
	ldr r1, =gUnknown_02024950
	strb r0, [r1]
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_0200CB54
sub_0200CB54: @ 0x0200CB54
	ldr r0, =gUnknown_02024950
	ldrb r0, [r0]
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_0200CB60
sub_0200CB60: @ 0x0200CB60
	adds r2, r0, #0
	cmp r2, #0
	beq _0200CB88
	ldr r0, =gUnknown_02022ED4
	adds r1, r2, #0
	cmp r2, #0
	bge _0200CB70
	adds r1, r2, #7
_0200CB70:
	asrs r1, r1, #3
	ldr r0, [r0]
	adds r3, r0, r1
	cmp r3, #0
	beq _0200CB88
	lsls r1, r1, #3
	subs r1, r2, r1
	movs r0, #1
	lsls r0, r1
	ldrb r1, [r3]
	orrs r0, r1
	strb r0, [r3]
_0200CB88:
	movs r0, #0
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_0200CB90
sub_0200CB90: @ 0x0200CB90
	adds r1, r0, #0
	cmp r1, #0
	beq _0200CBB8
	ldr r2, =gUnknown_02022ED4
	adds r0, r1, #0
	cmp r1, #0
	bge _0200CBA0
	adds r0, r1, #7
_0200CBA0:
	asrs r3, r0, #3
	ldr r0, [r2]
	adds r2, r0, r3
	cmp r2, #0
	beq _0200CBB8
	lsls r0, r3, #3
	subs r0, r1, r0
	movs r1, #1
	lsls r1, r0
	ldrb r0, [r2]
	bics r0, r1
	strb r0, [r2]
_0200CBB8:
	movs r0, #0
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_0200CBC0
sub_0200CBC0: @ 0x0200CBC0
	adds r1, r0, #0
	cmp r1, #0
	beq _0200CBF4
	ldr r2, =gUnknown_02022ED4
	adds r0, r1, #0
	cmp r1, #0
	bge _0200CBD0
	adds r0, r1, #7
_0200CBD0:
	asrs r3, r0, #3
	ldr r0, [r2]
	adds r2, r0, r3
	cmp r2, #0
	beq _0200CBF4
	lsls r0, r3, #3
	subs r0, r1, r0
	ldrb r2, [r2]
	asrs r2, r0
	adds r0, r2, #0
	movs r1, #1
	ands r0, r1
	cmp r0, #0
	beq _0200CBF4
	movs r0, #1
	b _0200CBF6
	.align 2, 0
	.pool
_0200CBF4:
	movs r0, #0
_0200CBF6:
	bx lr

	thumb_func_start sub_0200CBF8
sub_0200CBF8: @ 0x0200CBF8
	push {r4, r5, lr}
	ldr r2, =gUnknown_020251EC
	movs r0, #0
	strb r0, [r2]
	ldr r1, =gUnknown_020251E4
	strb r0, [r1]
	movs r4, #0
	ldr r0, =0x080000AC
	ldr r3, [r0]
	ldr r0, =0x46505841
	adds r5, r1, #0
	cmp r3, r0
	beq _0200CCA8
	cmp r3, r0
	bhi _0200CC54
	ldr r0, =0x44565841
	cmp r3, r0
	beq _0200CCA8
	cmp r3, r0
	bhi _0200CC3C
	ldr r0, =0x44505841
	b _0200CC7C
	.align 2, 0
	.pool
_0200CC3C:
	ldr r0, =0x45505841
	cmp r3, r0
	beq _0200CC9C
	ldr r0, =0x45565841
	cmp r3, r0
	beq _0200CC90
	b _0200CC80
	.align 2, 0
	.pool
_0200CC54:
	ldr r0, =0x49565841
	cmp r3, r0
	beq _0200CCA8
	cmp r3, r0
	bhi _0200CC74
	ldr r0, =0x46565841
	cmp r3, r0
	beq _0200CCA8
	ldr r0, =0x49505841
	b _0200CC7C
	.align 2, 0
	.pool
_0200CC74:
	ldr r0, =0x53505841
	cmp r3, r0
	beq _0200CCA8
	ldr r0, =0x53565841
_0200CC7C:
	cmp r3, r0
	beq _0200CCA8
_0200CC80:
	movs r3, #1
	strb r3, [r5]
	b _0200CCAC
	.align 2, 0
	.pool
_0200CC90:
	movs r0, #1
	strb r0, [r5]
	movs r4, #2
	movs r3, #0
	strb r0, [r2]
	b _0200CCAC
_0200CC9C:
	movs r0, #1
	strb r0, [r5]
	movs r4, #1
	movs r3, #0
	strb r4, [r2]
	b _0200CCAC
_0200CCA8:
	movs r3, #1
	strb r3, [r2]
_0200CCAC:
	cmp r3, #0
	beq _0200CCC0
	ldr r1, =gUnknown_020251E8
	ldr r0, =0x08000100
	b _0200CD10
	.align 2, 0
	.pool
_0200CCC0:
	cmp r4, #2
	bne _0200CCF0
	ldr r0, =0x080000BC
	ldrb r0, [r0]
	cmp r0, #0
	bne _0200CCE0
	ldr r1, =gUnknown_020251E8
	ldr r0, =gUnknown_02020634
	b _0200CD10
	.align 2, 0
	.pool
_0200CCE0:
	ldr r1, =gUnknown_020251E8
	ldr r0, =gUnknown_02020734
	b _0200CD10
	.align 2, 0
	.pool
_0200CCF0:
	ldr r0, =0x080000BC
	ldrb r0, [r0]
	cmp r0, #0
	bne _0200CD0C
	ldr r1, =gUnknown_020251E8
	ldr r0, =gUnknown_02020834
	b _0200CD10
	.align 2, 0
	.pool
_0200CD0C:
	ldr r1, =gUnknown_020251E8
	ldr r0, =gUnknown_02020934
_0200CD10:
	str r0, [r1]
	cmp r3, #1
	bne _0200CD30
	ldr r0, [r1]
	ldr r0, [r0, #4]
	cmp r0, #2
	bne _0200CD2C
	strb r3, [r5]
	b _0200CD30
	.align 2, 0
	.pool
_0200CD2C:
	movs r0, #0
	strb r0, [r5]
_0200CD30:
	pop {r4, r5}
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start sub_0200CD38
sub_0200CD38: @ 0x0200CD38
	push {lr}
	ldr r0, =gUnknown_020251EC
	ldrb r0, [r0]
	cmp r0, #0
	bne _0200CD60
	ldr r0, =gUnknown_020251E8
	ldr r0, [r0]
	ldr r1, =gSaveBlock2Ptr
	ldr r1, [r1]
	adds r0, #0x98
	ldr r0, [r0]
	adds r1, r1, r0
	ldrb r1, [r1]
	b _0200CD78
	.align 2, 0
	.pool
_0200CD60:
	ldr r0, =gUnknown_02022ECC
	ldr r0, [r0]
	bl sub_0200CED8
	lsls r0, r0, #0x18
	lsrs r1, r0, #0x18
	movs r0, #1
	ands r0, r1
	cmp r0, #0
	beq _0200CD78
	movs r0, #0x80
	orrs r1, r0
_0200CD78:
	adds r0, r1, #0
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200CD84
sub_0200CD84: @ 0x0200CD84
	bx lr
	.align 2, 0

	thumb_func_start sub_0200CD88
sub_0200CD88: @ 0x0200CD88
	push {lr}
	ldr r0, =gUnknown_020251EC
	ldrb r0, [r0]
	cmp r0, #0
	bne _0200CDB4
	ldr r0, =gUnknown_020251E8
	ldr r0, [r0]
	ldr r1, =gSaveBlock2Ptr
	ldr r1, [r1]
	adds r0, #0xd8
	ldr r0, [r0]
	adds r1, r1, r0
	movs r0, #1
	ldrb r1, [r1]
	ands r0, r1
	b _0200CDBA
	.align 2, 0
	.pool
_0200CDB4:
	ldr r0, =0x00000801
	bl sub_0200CBC0
_0200CDBA:
	cmp r0, #0
	beq _0200CDC8
	movs r0, #1
	b _0200CDCA
	.align 2, 0
	.pool
_0200CDC8:
	movs r0, #0
_0200CDCA:
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_0200CDD0
sub_0200CDD0: @ 0x0200CDD0
	ldr r0, =gUnknown_020251E8
	ldr r0, [r0]
	ldr r0, [r0]
	subs r0, #4
	cmp r0, #1
	bls _0200CDE4
	movs r0, #0
	b _0200CDE6
	.align 2, 0
	.pool
_0200CDE4:
	movs r0, #1
_0200CDE6:
	bx lr

	thumb_func_start sub_0200CDE8
sub_0200CDE8: @ 0x0200CDE8
	ldr r1, =gUnknown_02022ECC
	ldr r0, =gUnknown_020251E8
	ldr r0, [r0]
	ldr r2, [r1]
	ldr r1, [r0, #0x50]
	adds r1, r2, r1
	adds r0, #0xdc
	ldr r3, [r0]
	adds r0, r3, #0
	cmp r3, #0
	bge _0200CE00
	adds r0, r3, #7
_0200CE00:
	asrs r0, r0, #3
	adds r1, r1, r0
	lsls r0, r0, #3
	subs r0, r3, r0
	ldrb r1, [r1]
	asrs r1, r0
	adds r0, r1, #0
	movs r1, #1
	ands r0, r1
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_0200CE1C
sub_0200CE1C: @ 0x0200CE1C
	push {r4, r5, lr}
	adds r4, r0, #0
	movs r5, #0
	ldrb r0, [r4]
	cmp r0, #0xff
	beq _0200CE52
_0200CE28:
	adds r1, r5, #0
	adds r0, r1, #1
	lsls r0, r0, #0x10
	lsrs r5, r0, #0x10
	adds r1, r4, r1
	ldrb r1, [r1]
	cmp r1, #0xfc
	bne _0200CE4A
	adds r0, r4, r5
	ldrb r0, [r0]
	bl sub_0200CEC0
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	adds r0, r5, r0
	lsls r0, r0, #0x10
	lsrs r5, r0, #0x10
_0200CE4A:
	adds r0, r4, r5
	ldrb r0, [r0]
	cmp r0, #0xff
	bne _0200CE28
_0200CE52:
	adds r0, r5, #0
	pop {r4, r5}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start StringCopy
StringCopy: @ 0x0200CE5C
	adds r3, r0, #0
	b _0200CE66
_0200CE60:
	strb r2, [r3]
	adds r3, #1
	adds r1, #1
_0200CE66:
	ldrb r2, [r1]
	adds r0, r2, #0
	cmp r0, #0xff
	bne _0200CE60
	movs r0, #0xff
	strb r0, [r3]
	adds r0, r3, #0
	bx lr
	.align 2, 0

	thumb_func_start StringAppend
StringAppend: @ 0x0200CE78
	adds r2, r0, #0
	b _0200CE7E
_0200CE7C:
	adds r2, #1
_0200CE7E:
	ldrb r0, [r2]
	cmp r0, #0xff
	bne _0200CE7C
	adds r3, r2, #0
	b _0200CE8E
_0200CE88:
	strb r2, [r3]
	adds r3, #1
	adds r1, #1
_0200CE8E:
	ldrb r2, [r1]
	adds r0, r2, #0
	cmp r0, #0xff
	bne _0200CE88
	movs r0, #0xff
	strb r0, [r3]
	adds r0, r3, #0
	bx lr
	.align 2, 0

	thumb_func_start StringCompare
StringCompare: @ 0x0200CEA0
	adds r2, r0, #0
	b _0200CEB0
_0200CEA4:
	cmp r0, #0xff
	bne _0200CEAC
	movs r0, #0
	b _0200CEBE
_0200CEAC:
	adds r2, #1
	adds r1, #1
_0200CEB0:
	ldrb r0, [r2]
	ldrb r3, [r1]
	cmp r0, r3
	beq _0200CEA4
	ldrb r2, [r2]
	ldrb r1, [r1]
	subs r0, r2, r1
_0200CEBE:
	bx lr

	thumb_func_start sub_0200CEC0
sub_0200CEC0: @ 0x0200CEC0
	lsls r0, r0, #0x18
	lsrs r1, r0, #0x18
	movs r0, #0
	cmp r1, #0x16
	bhi _0200CED0
	ldr r0, =gUnknown_0201F09C
	adds r0, r1, r0
	ldrb r0, [r0]
_0200CED0:
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_0200CED8
sub_0200CED8: @ 0x0200CED8
	push {r4, lr}
	movs r1, #4
	ldrsb r1, [r0, r1]
	lsls r1, r1, #0x10
	lsrs r1, r1, #8
	ldrb r0, [r0, #5]
	lsls r0, r0, #0x18
	asrs r0, r0, #0x18
	adds r0, r0, r1
	lsls r0, r0, #0x10
	lsrs r0, r0, #0x10
	ldr r2, =gUnknown_0201F0B4
	ldr r1, =0x0000FFFF
	ldrh r3, [r2]
	cmp r3, r1
	beq _0200CF1A
	adds r3, r1, #0
	adds r1, r2, #0
_0200CEFC:
	ldrh r4, [r2]
	cmp r4, r0
	bne _0200CF10
	movs r0, #2
	b _0200CF48
	.align 2, 0
	.pool
_0200CF10:
	adds r1, #2
	adds r2, #2
	ldrh r4, [r1]
	cmp r4, r3
	bne _0200CEFC
_0200CF1A:
	ldr r2, =gUnknown_0201F0FC
	ldr r1, =0x0000FFFF
	ldrh r3, [r2]
	cmp r3, r1
	beq _0200CF46
	adds r3, r1, #0
	adds r1, r2, #0
_0200CF28:
	ldrh r4, [r2]
	cmp r4, r0
	bne _0200CF3C
	movs r0, #4
	b _0200CF48
	.align 2, 0
	.pool
_0200CF3C:
	adds r1, #2
	adds r2, #2
	ldrh r4, [r1]
	cmp r4, r3
	bne _0200CF28
_0200CF46:
	movs r0, #0
_0200CF48:
	pop {r4}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_0200CF50
sub_0200CF50: @ 0x0200CF50
	push {r4, r5, r6, r7, lr}
	adds r6, r0, #0
	ldr r7, =gUnknown_020251F0
	ldrb r0, [r7, #0xa]
	cmp r0, #1
	beq _0200CF98
	cmp r0, #1
	bgt _0200CF6C
	cmp r0, #0
	beq _0200CF76
	b _0200D07E
	.align 2, 0
	.pool
_0200CF6C:
	cmp r0, #2
	beq _0200D00C
	cmp r0, #3
	beq _0200D050
	b _0200D07E
_0200CF76:
	ldr r1, =gUnknown_02024960
	movs r0, #7
	ands r6, r0
	ldr r0, =0x0000084C
	adds r1, r1, r0
	lsls r3, r6, #4
	ldrb r2, [r1]
	movs r0, #0xf
	ands r0, r2
	orrs r0, r3
	strb r0, [r1]
	b _0200D03A
	.align 2, 0
	.pool
_0200CF98:
	ldr r3, =gUnknown_02024960
	ldr r4, =0x0000FFFF
	ldr r1, =0x0000084C
	adds r5, r3, r1
	adds r1, r6, #0
	ands r1, r4
	lsls r1, r1, #8
	ldr r0, [r5]
	ldr r2, =0xFF0000FF
	ands r0, r2
	orrs r0, r1
	str r0, [r5]
	lsrs r0, r6, #0x10
	ands r0, r4
	movs r4, #0xff
	adds r1, r0, #0
	ands r1, r4
	ldr r6, =0x0000084F
	adds r2, r3, r6
	ldrb r6, [r2]
	movs r6, #0
	strb r1, [r2]
	lsrs r0, r0, #8
	ands r0, r4
	movs r2, #0x85
	lsls r2, r2, #4
	adds r1, r3, r2
	ldrb r2, [r1]
	strb r0, [r1]
	ldr r0, =0x00000854
	adds r3, r3, r0
	ldr r4, =gUnknown_02022EF4
	ldrb r0, [r5]
	lsrs r0, r0, #4
	movs r2, #0x64
	adds r1, r0, #0
	muls r1, r2, r1
	ldr r0, [r4]
	adds r0, r0, r1
	str r0, [r3]
	str r2, [r7, #4]
	str r6, [r7, #0x1c]
	b _0200D03A
	.align 2, 0
	.pool
_0200D00C:
	ldr r2, =gUnknown_02024960
	ldr r0, [r7, #0x1c]
	lsrs r0, r0, #2
	ldr r3, =0x00000854
	adds r1, r2, r3
	ldr r1, [r1]
	lsls r0, r0, #2
	adds r0, r0, r1
	str r6, [r0]
	ldr r0, [r7, #0x1c]
	adds r0, #4
	str r0, [r7, #0x1c]
	ldr r1, [r7, #0x1c]
	ldr r0, [r7, #4]
	cmp r1, r0
	blo _0200D07E
	ldr r6, =0x0000085C
	adds r0, r2, r6
	str r0, [r7]
	movs r0, #0xc
	str r0, [r7, #4]
	movs r0, #0
	str r0, [r7, #0x1c]
_0200D03A:
	ldrb r0, [r7, #0xa]
	adds r0, #1
	ldrb r1, [r7, #0xa]
	strb r0, [r7, #0xa]
	b _0200D07E
	.align 2, 0
	.pool
_0200D050:
	ldr r0, [r7, #0x1c]
	lsrs r0, r0, #2
	ldr r1, [r7]
	lsls r0, r0, #2
	adds r0, r0, r1
	str r6, [r0]
	ldr r0, [r7, #0x1c]
	adds r0, #4
	str r0, [r7, #0x1c]
	ldr r1, [r7, #0x1c]
	ldr r0, [r7, #4]
	cmp r1, r0
	blo _0200D07E
	ldr r1, =gUnknown_02024960
	ldr r0, =0x0000084C
	adds r1, r1, r0
	ldrb r0, [r1]
	movs r2, #2
	orrs r0, r2
	strb r0, [r1]
	ldrb r0, [r7, #0x11]
	movs r0, #0
	strb r0, [r7, #0x11]
_0200D07E:
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_0200D08C
sub_0200D08C: @ 0x0200D08C
	push {r4, r5, r6, r7, lr}
	adds r3, r0, #0
	ldr r2, =gUnknown_020251F0
	ldrb r0, [r2, #0xa]
	adds r4, r0, #0
	adds r5, r2, #0
	cmp r4, #1
	beq _0200D12C
	cmp r4, #1
	bgt _0200D0AC
	cmp r4, #0
	beq _0200D0B2
	b _0200D19C
	.align 2, 0
	.pool
_0200D0AC:
	cmp r4, #2
	beq _0200D170
	b _0200D19C
_0200D0B2:
	ldr r0, [r2, #0x1c]
	lsrs r0, r0, #2
	ldr r1, [r2]
	lsls r0, r0, #2
	adds r0, r0, r1
	str r3, [r0]
	ldr r0, [r2, #0x1c]
	adds r0, #4
	str r0, [r2, #0x1c]
	ldr r1, [r2, #0x1c]
	ldr r0, [r2, #4]
	cmp r1, r0
	blo _0200D19C
	ldr r1, =gUnknown_02024960
	ldr r0, [r1]
	lsls r0, r0, #8
	lsrs r3, r0, #8
	ldr r2, =0x00000879
	adds r0, r1, r2
	ldrb r2, [r0]
	strb r4, [r0]
	adds r7, r1, #0
	adds r7, #0x24
	movs r6, #0xf
	adds r4, r0, #0
	movs r2, #5
_0200D0E6:
	adds r0, r3, #0
	ands r0, r6
	cmp r0, #0xf
	beq _0200D0F6
	ldrb r0, [r4]
	adds r0, #1
	ldrb r1, [r4]
	strb r0, [r4]
_0200D0F6:
	lsrs r3, r3, #4
	subs r2, #1
	cmp r2, #0
	bge _0200D0E6
	movs r0, #0
	str r0, [r5, #0x1c]
	str r7, [r5]
	ldr r1, =0x00000855
	adds r0, r7, r1
	ldrb r1, [r0]
	lsls r0, r1, #2
	adds r0, r0, r1
	lsls r1, r0, #4
	adds r0, r0, r1
	lsls r0, r0, #2
	str r0, [r5, #4]
	ldrb r0, [r5, #0xa]
	adds r0, #1
	ldrb r1, [r5, #0xa]
	strb r0, [r5, #0xa]
	b _0200D19C
	.align 2, 0
	.pool
_0200D12C:
	ldr r0, [r2, #0x1c]
	lsrs r0, r0, #2
	ldr r1, [r2]
	lsls r0, r0, #2
	adds r0, r0, r1
	str r3, [r0]
	ldr r0, [r2, #0x1c]
	adds r0, #4
	str r0, [r2, #0x1c]
	ldr r1, [r2, #0x1c]
	ldr r0, [r2, #4]
	cmp r1, r0
	blo _0200D19C
	movs r0, #0
	str r0, [r2, #0x1c]
	ldr r0, =gUnknown_0202517C
	str r0, [r2]
	ldr r1, =0xFFFFF7E4
	adds r0, r0, r1
	ldrb r1, [r0, #7]
	lsls r0, r1, #1
	adds r0, r0, r1
	lsls r0, r0, #2
	str r0, [r2, #4]
	ldrb r0, [r2, #0xa]
	adds r0, #1
	ldrb r1, [r2, #0xa]
	strb r0, [r2, #0xa]
	b _0200D19C
	.align 2, 0
	.pool
_0200D170:
	ldr r0, [r2, #0x1c]
	lsrs r0, r0, #2
	ldr r1, [r2]
	lsls r0, r0, #2
	adds r0, r0, r1
	str r3, [r0]
	ldr r0, [r2, #0x1c]
	adds r0, #4
	str r0, [r2, #0x1c]
	ldr r1, [r2, #0x1c]
	ldr r0, [r2, #4]
	cmp r1, r0
	blo _0200D19C
	ldrb r0, [r2, #0x11]
	movs r0, #0
	strb r0, [r2, #0x11]
	ldr r0, =gUnknown_02024960
	ldr r2, =0x0000087A
	adds r0, r0, r2
	ldrb r1, [r0]
	movs r1, #1
	strb r1, [r0]
_0200D19C:
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_0200D1AC
sub_0200D1AC: @ 0x0200D1AC
	push {r4, r5, r6, lr}
	adds r3, r0, #0
	ldr r1, =gUnknown_02022ECC
	ldr r0, =gUnknown_020251E8
	ldr r0, [r0]
	adds r0, #0xb4
	ldr r1, [r1]
	ldr r0, [r0]
	adds r6, r1, r0
	ldr r5, =gUnknown_020251C8
	ldr r1, =gUnknown_020251F0
	ldrb r0, [r1, #0xa]
	adds r4, r1, #0
	cmp r0, #6
	bls _0200D1CC
	b _0200D384
_0200D1CC:
	lsls r0, r0, #2
	ldr r1, =_0200D1EC
	adds r0, r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
	.pool
_0200D1EC: @ jump table
	.4byte _0200D208 @ case 0
	.4byte _0200D220 @ case 1
	.4byte _0200D238 @ case 2
	.4byte _0200D2A6 @ case 3
	.4byte _0200D2D4 @ case 4
	.4byte _0200D322 @ case 5
	.4byte _0200D358 @ case 6
_0200D208:
	ldr r2, =0x00FFFFFF
	ands r2, r3
	ldr r0, [r5, #8]
	movs r1, #0xff
	lsls r1, r1, #0x18
	ands r0, r1
	orrs r0, r2
	str r0, [r5, #8]
	b _0200D348
	.align 2, 0
	.pool
_0200D220:
	ldr r2, =0x00FFFFFF
	ands r2, r3
	ldr r0, [r5, #0xc]
	movs r1, #0xff
	lsls r1, r1, #0x18
	ands r0, r1
	orrs r0, r2
	str r0, [r5, #0xc]
	b _0200D348
	.align 2, 0
	.pool
_0200D238:
	movs r2, #9
	rsbs r2, r2, #0
	ldrb r0, [r5, #0xb]
	ands r2, r0
	movs r0, #5
	rsbs r0, r0, #0
	ands r2, r0
	adds r0, #2
	ands r2, r0
	adds r0, #1
	ands r2, r0
	strb r2, [r5, #0xb]
	movs r0, #1
	ands r0, r3
	cmp r0, #0
	beq _0200D260
	movs r1, #1
	adds r0, r2, #0
	orrs r0, r1
	strb r0, [r5, #0xb]
_0200D260:
	movs r0, #2
	ands r0, r3
	cmp r0, #0
	beq _0200D270
	movs r0, #2
	ldrb r1, [r5, #0xb]
	orrs r0, r1
	strb r0, [r5, #0xb]
_0200D270:
	movs r0, #4
	ands r0, r3
	cmp r0, #0
	beq _0200D280
	movs r0, #4
	ldrb r2, [r5, #0xb]
	orrs r0, r2
	strb r0, [r5, #0xb]
_0200D280:
	movs r0, #8
	ands r0, r3
	cmp r0, #0
	beq _0200D290
	movs r0, #8
	ldrb r1, [r5, #0xb]
	orrs r0, r1
	strb r0, [r5, #0xb]
_0200D290:
	movs r3, #0x10
	adds r1, r6, #0
	adds r2, r5, #0
_0200D296:
	ldrb r0, [r2]
	strb r0, [r1]
	adds r2, #1
	adds r1, #1
	subs r3, #1
	cmp r3, #0
	bne _0200D296
	b _0200D348
_0200D2A6:
	ldr r0, =gUnknown_02024960
	lsrs r1, r3, #0x10
	ldr r2, =0x0000085B
	adds r0, r0, r2
	ldrb r2, [r0]
	movs r2, #0
	strb r1, [r0]
	ldr r0, =0x0000FFFF
	ands r0, r3
	str r0, [r4, #4]
	str r2, [r4, #0x1c]
	ldr r0, =gUnknown_02022EBC
	ldr r0, [r0]
	b _0200D346
	.align 2, 0
	.pool
_0200D2D4:
	ldr r1, [r4, #0x1c]
	ldr r2, [r4]
	lsls r0, r1, #2
	adds r0, r0, r2
	str r3, [r0]
	adds r1, #1
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x1c]
	ldr r0, [r4, #4]
	cmp r1, r0
	blo _0200D384
	ldr r1, =gUnknown_02024960
	ldr r2, =0x0000085B
	adds r0, r1, r2
	ldrb r0, [r0]
	adds r2, r0, #0
	cmp r2, #0
	bne _0200D314
	ldrb r0, [r4, #0x11]
	strb r2, [r4, #0x11]
	ldr r0, =0x0000085A
	adds r1, r1, r0
	ldrb r0, [r1]
	movs r0, #1
	strb r0, [r1]
	b _0200D384
	.align 2, 0
	.pool
_0200D314:
	movs r0, #0x64
	str r0, [r4, #4]
	movs r0, #0
	str r0, [r4, #0x1c]
	bl sub_0200C520
	b _0200D346
_0200D322:
	ldr r0, [r4, #0x1c]
	lsrs r0, r0, #2
	ldr r1, [r4]
	lsls r0, r0, #2
	adds r0, r0, r1
	str r3, [r0]
	ldr r0, [r4, #0x1c]
	adds r0, #4
	str r0, [r4, #0x1c]
	ldr r1, [r4, #0x1c]
	ldr r0, [r4, #4]
	cmp r1, r0
	blo _0200D384
	movs r0, #0xc
	str r0, [r4, #4]
	movs r0, #0
	str r0, [r4, #0x1c]
	ldr r0, =gUnknown_020251BC
_0200D346:
	str r0, [r4]
_0200D348:
	ldrb r0, [r4, #0xa]
	adds r0, #1
	ldrb r1, [r4, #0xa]
	strb r0, [r4, #0xa]
	b _0200D384
	.align 2, 0
	.pool
_0200D358:
	ldr r0, [r4, #0x1c]
	lsrs r0, r0, #2
	ldr r1, [r4]
	lsls r0, r0, #2
	adds r0, r0, r1
	str r3, [r0]
	ldr r0, [r4, #0x1c]
	adds r0, #4
	str r0, [r4, #0x1c]
	ldr r1, [r4, #0x1c]
	ldr r0, [r4, #4]
	cmp r1, r0
	blo _0200D384
	ldr r0, =gUnknown_02024960
	ldr r1, =0x0000085A
	adds r0, r0, r1
	ldrb r1, [r0]
	movs r2, #0
	movs r1, #1
	strb r1, [r0]
	ldrb r0, [r4, #0x11]
	strb r2, [r4, #0x11]
_0200D384:
	pop {r4, r5, r6}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_0200D394
sub_0200D394: @ 0x0200D394
	push {r4, r5, r6, lr}
	adds r4, r0, #0
	ldr r5, =gUnknown_020251F0
	ldrb r0, [r5, #0xc]
	adds r3, r0, #0
	adds r2, r5, #0
	cmp r3, #0
	bne _0200D3F8
	ldrb r0, [r5, #0xd]
	cmp r0, #2
	bne _0200D3D2
	ldr r0, [r5, #0x28]
	cmp r4, r0
	bne _0200D3CC
	ldr r1, =0x04000158
	movs r0, #0x10
	strh r0, [r1]
	str r4, [r5, #0x24]
	ldrb r0, [r5, #0xc]
	movs r0, #1
	strb r0, [r5, #0xc]
	ldrb r1, [r5, #0x11]
	strb r0, [r5, #0x11]
	b _0200D3E8
	.align 2, 0
	.pool
_0200D3CC:
	ldr r0, [r5, #0x2c]
	cmp r4, r0
	beq _0200D3D6
_0200D3D2:
	movs r0, #0
	b _0200D61C
_0200D3D6:
	ldr r0, =0x04000158
	movs r1, #0
	strh r3, [r0]
	str r4, [r5, #0x24]
	ldrb r0, [r5, #0xc]
	movs r0, #1
	strb r0, [r5, #0xc]
	ldrb r0, [r5, #0x11]
	strb r1, [r5, #0x11]
_0200D3E8:
	ldrb r0, [r2, #0xd]
	movs r0, #0
	strb r0, [r2, #0xd]
	ldrb r1, [r2, #0x10]
	strb r0, [r2, #0x10]
	b _0200D61A
	.align 2, 0
	.pool
_0200D3F8:
	ldrb r0, [r5, #0x11]
	adds r6, r0, #0
	cmp r6, #0x55
	bne _0200D402
	b _0200D60C
_0200D402:
	cmp r6, #0x55
	bgt _0200D412
	cmp r6, #0
	beq _0200D42C
	cmp r6, #0x22
	bne _0200D410
	b _0200D614
_0200D410:
	b _0200D3D2
_0200D412:
	cmp r6, #0x77
	bne _0200D418
	b _0200D5CC
_0200D418:
	cmp r6, #0x77
	bgt _0200D424
	cmp r6, #0x66
	bne _0200D422
	b _0200D604
_0200D422:
	b _0200D3D2
_0200D424:
	cmp r6, #0x88
	bne _0200D42A
	b _0200D598
_0200D42A:
	b _0200D3D2
_0200D42C:
	lsrs r4, r4, #0x18
	cmp r4, #0xaa
	bne _0200D448
	ldr r1, =0x04000154
	ldr r0, =gUnknown_02022EB8
	ldrh r0, [r0]
	lsls r0, r0, #0x10
	orrs r0, r4
	str r0, [r1]
	b _0200D61A
	.align 2, 0
	.pool
_0200D448:
	cmp r4, #0x99
	bne _0200D46C
	bl sub_0200CB2C
	str r0, [r5]
	ldr r0, =0x04000154
	str r4, [r0]
	movs r0, #0x9e
	lsls r0, r0, #2
	str r0, [r5, #4]
	str r6, [r5, #0x1c]
	ldrb r0, [r5, #0x11]
	movs r0, #4
	strb r0, [r5, #0x11]
	b _0200D61A
	.align 2, 0
	.pool
_0200D46C:
	cmp r4, #0x88
	bne _0200D490
	movs r0, #0
	bl sub_0200CB34
	str r0, [r5]
	movs r0, #0
	bl sub_0200CB48
	ldr r0, =0x04000154
	str r4, [r0]
	movs r0, #0xf0
	lsls r0, r0, #3
	str r0, [r5, #4]
	str r6, [r5, #0x1c]
	b _0200D498
	.align 2, 0
	.pool
_0200D490:
	cmp r4, #0x77
	bne _0200D4A4
	ldr r0, =0x04000154
	str r4, [r0]
_0200D498:
	ldrb r0, [r5, #0x11]
	strb r4, [r5, #0x11]
	b _0200D61A
	.align 2, 0
	.pool
_0200D4A4:
	cmp r4, #0x66
	bne _0200D4D4
	ldr r0, =0x04000154
	str r4, [r0]
	ldrb r0, [r5, #0x11]
	strb r4, [r5, #0x11]
	ldr r1, =gUnknown_02024960
	str r1, [r5]
	movs r0, #0x24
	str r0, [r5, #4]
	str r6, [r5, #0x1c]
	ldrb r0, [r5, #0xa]
	strb r6, [r5, #0xa]
	ldr r0, =0x0000087A
	adds r1, r1, r0
	ldrb r0, [r1]
	strb r6, [r1]
	b _0200D61A
	.align 2, 0
	.pool
_0200D4D4:
	cmp r4, #0x55
	bne _0200D50C
	ldr r2, =gUnknown_02024960
	ldr r3, =0x0000084C
	adds r2, r2, r3
	ldrb r0, [r2]
	movs r1, #1
	orrs r0, r1
	strb r0, [r2]
	ldrb r1, [r2]
	movs r0, #3
	rsbs r0, r0, #0
	ands r0, r1
	strb r0, [r2]
	ldr r0, =0x04000154
	str r4, [r0]
	ldrb r0, [r5, #0x11]
	strb r4, [r5, #0x11]
	ldrb r0, [r5, #0xa]
	strb r6, [r5, #0xa]
	b _0200D61A
	.align 2, 0
	.pool
_0200D50C:
	cmp r4, #0x44
	bne _0200D53C
	ldr r0, =0x04000154
	str r4, [r0]
	ldrb r0, [r5, #0x11]
	strb r4, [r5, #0x11]
	ldr r2, =gUnknown_02024960
	ldr r0, =0x0000084C
	adds r2, r2, r0
	ldrb r0, [r2]
	movs r1, #4
	orrs r0, r1
	strb r0, [r2]
	ldrb r0, [r2]
	movs r1, #8
	orrs r0, r1
	strb r0, [r2]
	b _0200D61A
	.align 2, 0
	.pool
_0200D53C:
	cmp r4, #0x33
	beq _0200D544
	cmp r4, #0x22
	bne _0200D558
_0200D544:
	ldr r0, =0x04000154
	str r4, [r0]
	ldrb r0, [r2, #0x11]
	movs r0, #0
	strb r4, [r2, #0x11]
	ldrb r1, [r2, #0xa]
	strb r0, [r2, #0xa]
	b _0200D61A
	.align 2, 0
	.pool
_0200D558:
	cmp r4, #0x60
	bne _0200D578
	ldr r0, =0x04000154
	str r4, [r0]
	ldr r1, =0x04000208
	movs r0, #0
	strh r0, [r1]
	movs r0, #0
	bl SoftResetRom
	b _0200D61A
	.align 2, 0
	.pool
_0200D578:
	cmp r4, #0x61
	bne _0200D61A
	ldr r0, =0x04000154
	str r4, [r0]
	ldr r1, =0x04000208
	movs r0, #0
	strh r0, [r1]
	movs r0, #0
	bl SoftReset
	b _0200D61A
	.align 2, 0
	.pool
_0200D598:
	ldr r0, [r5, #0x1c]
	lsrs r0, r0, #2
	ldr r1, [r5]
	lsls r0, r0, #2
	adds r0, r0, r1
	str r4, [r0]
	ldr r0, [r5, #0x1c]
	adds r0, #4
	str r0, [r5, #0x1c]
	ldr r1, [r5, #0x1c]
	ldr r0, [r5, #4]
	cmp r1, r0
	blo _0200D61A
	ldr r1, =0x04000158
	movs r0, #0
	strh r0, [r1]
	ldrb r1, [r5, #0x11]
	strb r0, [r5, #0x11]
	ldrb r1, [r5, #0xc]
	strb r0, [r5, #0xc]
	movs r0, #1
	bl sub_0200CB48
	b _0200D61A
	.align 2, 0
	.pool
_0200D5CC:
	ldr r1, =gUnknown_02024960
	lsrs r2, r4, #0x18
	ldr r3, =0x00000858
	adds r0, r1, r3
	ldrb r3, [r0]
	movs r3, #0
	strb r2, [r0]
	ldr r2, =0x00000859
	adds r0, r1, r2
	ldrb r2, [r0]
	strb r4, [r0]
	ldr r0, =0x00000878
	adds r1, r1, r0
	ldrb r0, [r1]
	movs r0, #1
	strb r0, [r1]
	ldrb r0, [r5, #0x11]
	strb r3, [r5, #0x11]
	b _0200D61A
	.align 2, 0
	.pool
_0200D604:
	adds r0, r4, #0
	bl sub_0200D08C
	b _0200D61A
_0200D60C:
	adds r0, r4, #0
	bl sub_0200CF50
	b _0200D61A
_0200D614:
	adds r0, r4, #0
	bl sub_0200D1AC
_0200D61A:
	movs r0, #1
_0200D61C:
	pop {r4, r5, r6}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_0200D624
sub_0200D624: @ 0x0200D624
	push {r4, r5, r6, lr}
	ldr r1, =gUnknown_02022ECC
	ldr r2, =gUnknown_020251E8
	ldr r0, [r2]
	adds r0, #0xb4
	ldr r1, [r1]
	ldr r0, [r0]
	adds r6, r1, r0
	ldr r5, =gUnknown_020251C8
	ldr r1, =gUnknown_020251F0
	ldrb r0, [r1, #0xa]
	adds r4, r1, #0
	cmp r0, #4
	bls _0200D642
	b _0200D73C
_0200D642:
	lsls r0, r0, #2
	ldr r1, =_0200D660
	adds r0, r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
	.pool
_0200D660: @ jump table
	.4byte _0200D674 @ case 0
	.4byte _0200D698 @ case 1
	.4byte _0200D6A8 @ case 2
	.4byte _0200D6E0 @ case 3
	.4byte _0200D718 @ case 4
_0200D674:
	movs r3, #0x10
	adds r2, r5, #0
	adds r1, r6, #0
_0200D67A:
	ldrb r0, [r1]
	strb r0, [r2]
	adds r1, #1
	adds r2, #1
	subs r3, #1
	cmp r3, #0
	bne _0200D67A
	ldr r1, =0x04000154
	ldr r0, [r5, #8]
	lsls r0, r0, #8
	lsrs r0, r0, #8
	str r0, [r1]
	b _0200D702
	.align 2, 0
	.pool
_0200D698:
	ldr r1, =0x04000154
	ldr r0, [r5, #0xc]
	lsls r0, r0, #8
	lsrs r0, r0, #8
	str r0, [r1]
	b _0200D702
	.align 2, 0
	.pool
_0200D6A8:
	bl sub_0200CDE8
	ldrb r3, [r5, #0xb]
	lsls r2, r3, #0x1f
	lsrs r2, r2, #0x1f
	movs r1, #2
	ands r1, r3
	orrs r2, r1
	movs r1, #4
	ands r1, r3
	orrs r2, r1
	movs r1, #8
	ands r1, r3
	orrs r2, r1
	lsls r0, r0, #4
	orrs r2, r0
	ldr r0, =0x04000154
	str r2, [r0]
	ldr r1, =gUnknown_020251F0
	ldrb r0, [r1, #0xa]
	adds r0, #1
	ldrb r2, [r1, #0xa]
	strb r0, [r1, #0xa]
	b _0200D73C
	.align 2, 0
	.pool
_0200D6E0:
	ldr r0, [r2]
	adds r0, #0xe9
	ldrb r0, [r0]
	str r0, [r4, #4]
	movs r0, #0
	str r0, [r4, #0x1c]
	ldr r0, =gUnknown_02022EF0
	ldr r0, [r0]
	ldrb r0, [r0]
	lsls r1, r0, #0x10
	ldr r0, [r4, #4]
	orrs r1, r0
	ldr r0, =0x04000154
	str r1, [r0]
	ldr r0, =gUnknown_02022EBC
	ldr r0, [r0]
	str r0, [r4]
_0200D702:
	ldrb r0, [r4, #0xa]
	adds r0, #1
	ldrb r1, [r4, #0xa]
	strb r0, [r4, #0xa]
	b _0200D73C
	.align 2, 0
	.pool
_0200D718:
	ldr r3, =0x04000154
	ldr r1, [r4, #0x1c]
	ldr r2, [r4]
	lsls r0, r1, #2
	adds r0, r0, r2
	ldr r0, [r0]
	str r0, [r3]
	adds r1, #1
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x1c]
	ldr r0, [r4, #4]
	cmp r1, r0
	bne _0200D73C
	ldrb r0, [r4, #0x11]
	movs r0, #0
	strb r0, [r4, #0x11]
	ldrb r1, [r4, #0xc]
	strb r0, [r4, #0xc]
_0200D73C:
	pop {r4, r5, r6}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_0200D748
sub_0200D748: @ 0x0200D748
	push {lr}
	ldr r3, =gUnknown_020251F0
	ldrb r0, [r3, #0xc]
	cmp r0, #0
	bne _0200D764
	ldrb r0, [r3, #0xd]
	cmp r0, #1
	bne _0200D800
	ldrb r0, [r3, #0xd]
	movs r0, #2
	strb r0, [r3, #0xd]
	b _0200D804
	.align 2, 0
	.pool
_0200D764:
	ldrb r0, [r3, #0x11]
	cmp r0, #0x55
	beq _0200D804
	cmp r0, #0x55
	bgt _0200D786
	cmp r0, #0x22
	beq _0200D804
	cmp r0, #0x22
	bgt _0200D77C
	cmp r0, #4
	beq _0200D79E
	b _0200D800
_0200D77C:
	cmp r0, #0x33
	beq _0200D7D8
	cmp r0, #0x44
	beq _0200D7DE
	b _0200D800
_0200D786:
	cmp r0, #0x66
	beq _0200D804
	cmp r0, #0x66
	bgt _0200D794
	cmp r0, #0x60
	beq _0200D804
	b _0200D800
_0200D794:
	cmp r0, #0x77
	beq _0200D804
	cmp r0, #0x88
	beq _0200D804
	b _0200D800
_0200D79E:
	ldr r1, [r3, #0x1c]
	ldr r0, [r3, #4]
	cmp r1, r0
	bhs _0200D7C4
	ldr r2, =0x04000154
	ldr r0, [r3, #0x1c]
	lsrs r0, r0, #2
	ldr r1, [r3]
	lsls r0, r0, #2
	adds r0, r0, r1
	ldr r0, [r0]
	str r0, [r2]
	ldr r0, [r3, #0x1c]
	adds r0, #4
	str r0, [r3, #0x1c]
	b _0200D804
	.align 2, 0
	.pool
_0200D7C4:
	ldr r1, =0x04000158
	movs r0, #0
	strh r0, [r1]
	ldrb r1, [r3, #0x11]
	strb r0, [r3, #0x11]
	ldrb r1, [r3, #0xc]
	strb r0, [r3, #0xc]
	b _0200D804
	.align 2, 0
	.pool
_0200D7D8:
	bl sub_0200D624
	b _0200D804
_0200D7DE:
	ldr r1, =gUnknown_02024960
	ldr r0, =0x0000084C
	adds r1, r1, r0
	ldrb r2, [r1]
	movs r0, #9
	rsbs r0, r0, #0
	ands r0, r2
	strb r0, [r1]
	ldrb r0, [r3, #0x11]
	movs r0, #0
	strb r0, [r3, #0x11]
	b _0200D804
	.align 2, 0
	.pool
_0200D800:
	movs r0, #0
	b _0200D806
_0200D804:
	movs r0, #1
_0200D806:
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_0200D80C
sub_0200D80C: @ 0x0200D80C
	push {r4, lr}
	ldr r0, =0x04000140
	ldrh r0, [r0]
	adds r4, r0, #0
	movs r0, #4
	ands r0, r4
	cmp r0, #0
	beq _0200D824
	bl sub_0200D748
	cmp r0, #0
	beq _0200D840
_0200D824:
	movs r0, #2
	ands r0, r4
	cmp r0, #0
	beq _0200D850
	ldr r1, =gUnknown_020251F0
	ldrb r0, [r1, #0xb]
	movs r0, #1
	strb r0, [r1, #0xb]
	ldr r0, =0x04000150
	ldr r0, [r0]
	bl sub_0200D394
	cmp r0, #0
	bne _0200D850
_0200D840:
	ldr r0, =0x04000158
	movs r1, #0
	strh r1, [r0]
	ldr r0, =gUnknown_020251F0
	ldrb r2, [r0, #0xc]
	strb r1, [r0, #0xc]
	ldrb r2, [r0, #0xd]
	strb r1, [r0, #0xd]
_0200D850:
	movs r3, #1
	adds r0, r4, #0
	ands r0, r3
	ldr r2, =gUnknown_020251F0
	cmp r0, #0
	beq _0200D87C
	ldr r0, =0x04000150
	ldr r0, [r0]
	ldr r1, =0x04000154
	ldr r0, [r2, #0x20]
	str r0, [r1]
	ldr r0, =0x04000158
	movs r1, #0
	strh r1, [r0]
	ldrb r0, [r2, #0xc]
	strb r1, [r2, #0xc]
	ldrb r0, [r2, #0xd]
	strb r3, [r2, #0xd]
	ldr r0, =0x04000006
	ldrh r0, [r0]
	ldrb r1, [r2, #0x14]
	strb r0, [r2, #0x14]
_0200D87C:
	ldr r0, =0x04000140
	strh r4, [r0]
	ldrb r0, [r2, #0xf]
	movs r0, #0
	strb r0, [r2, #0xf]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_0200D8A4
sub_0200D8A4: @ 0x0200D8A4
	push {r4, r5, r6, lr}
	ldr r5, =0x04000208
	ldrh r0, [r5]
	adds r6, r0, #0
	movs r4, #0
	strh r4, [r5]
	ldr r3, =gUnknown_020251F0
	ldrb r0, [r3, #0x12]
	cmp r0, #0
	bne _0200D8C2
	ldr r1, =0x04000134
	movs r2, #0x80
	lsls r2, r2, #8
	adds r0, r2, #0
	strh r0, [r1]
_0200D8C2:
	ldr r1, =0x04000134
	movs r2, #0xc0
	lsls r2, r2, #8
	adds r0, r2, #0
	strh r0, [r1]
	ldr r0, =0x04000158
	strh r4, [r0]
	subs r0, #8
	ldr r0, [r0]
	adds r1, #0x20
	movs r0, #0
	str r0, [r1]
	subs r1, #0x14
	movs r0, #0x47
	strh r0, [r1]
	ldr r0, =0x04000202
	movs r2, #0x80
	strh r2, [r0]
	adds r1, #0xc0
	ldrh r0, [r1]
	orrs r0, r2
	strh r0, [r1]
	ldrb r0, [r3, #0xf]
	strb r4, [r3, #0xf]
	ldrb r0, [r3, #0xc]
	strb r4, [r3, #0xc]
	ldrb r0, [r3, #0xd]
	strb r4, [r3, #0xd]
	ldrb r0, [r3, #0x12]
	strb r4, [r3, #0x12]
	ldrb r0, [r3, #0x11]
	strb r4, [r3, #0x11]
	ldrb r0, [r3, #0xb]
	strb r4, [r3, #0xb]
	strh r6, [r5]
	pop {r4, r5, r6}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

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
	bl sub_02008674
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

	thumb_func_start sub_0200DA50
sub_0200DA50: @ 0x0200DA50
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	ldr r3, =0x0E005555
	movs r1, #0xaa
	strb r1, [r3]
	ldr r2, =0x0E002AAA
	movs r1, #0x55
	strb r1, [r2]
	movs r1, #0xb0
	strb r1, [r3]
	movs r1, #0xe0
	lsls r1, r1, #0x14
	strb r0, [r1]
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_0200DA74
sub_0200DA74: @ 0x0200DA74
	push {r4, r5, lr}
	sub sp, #0x44
	mov r0, sp
	bl sub_0200DC64
	mov r5, sp
	adds r5, #1
	ldr r2, =0x0E005555
	movs r0, #0xaa
	strb r0, [r2]
	ldr r1, =0x0E002AAA
	movs r0, #0x55
	strb r0, [r1]
	movs r0, #0x90
	strb r0, [r2]
	add r1, sp, #0x40
	ldr r2, =0x00004E20
	adds r0, r2, #0
	b _0200DAAC
	.align 2, 0
	.pool
_0200DAA8:
	ldrh r0, [r1]
	subs r0, #1
_0200DAAC:
	strh r0, [r1]
	ldrh r0, [r1]
	cmp r0, #0
	bne _0200DAA8
	ldr r0, =0x0E000001
	bl _call_via_r5
	lsls r0, r0, #0x18
	lsrs r4, r0, #0x10
	movs r0, #0xe0
	lsls r0, r0, #0x14
	bl _call_via_r5
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	orrs r4, r0
	ldr r1, =0x0E005555
	movs r0, #0xaa
	strb r0, [r1]
	ldr r2, =0x0E002AAA
	movs r0, #0x55
	strb r0, [r2]
	movs r0, #0xf0
	strb r0, [r1]
	strb r0, [r1]
	add r1, sp, #0x40
	ldr r2, =0x00004E20
	adds r0, r2, #0
	b _0200DAFC
	.align 2, 0
	.pool
_0200DAF8:
	ldrh r0, [r1]
	subs r0, #1
_0200DAFC:
	strh r0, [r1]
	ldrh r0, [r1]
	cmp r0, #0
	bne _0200DAF8
	adds r0, r4, #0
	add sp, #0x44
	pop {r4, r5}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_0200DB10
sub_0200DB10: @ 0x0200DB10
	push {lr}
	ldr r1, =gUnknown_02021376
	ldrh r0, [r1]
	cmp r0, #0
	beq _0200DB2C
	ldrh r0, [r1]
	subs r0, #1
	strh r0, [r1]
	lsls r0, r0, #0x10
	cmp r0, #0
	bne _0200DB2C
	ldr r1, =gUnknown_02025224
	movs r0, #1
	strb r0, [r1]
_0200DB2C:
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_0200DB38
sub_0200DB38: @ 0x0200DB38
	push {lr}
	adds r2, r1, #0
	lsls r0, r0, #0x18
	lsrs r1, r0, #0x18
	cmp r1, #3
	bhi _0200DB6C
	ldr r0, =gUnknown_02021374
	strb r1, [r0]
	ldr r1, =gUnknown_02021378
	ldrb r0, [r0]
	lsls r0, r0, #2
	ldr r3, =0x04000100
	adds r0, r0, r3
	str r0, [r1]
	ldr r0, =sub_0200DB10
	str r0, [r2]
	movs r0, #0
	b _0200DB6E
	.align 2, 0
	.pool
_0200DB6C:
	movs r0, #1
_0200DB6E:
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_0200DB74
sub_0200DB74: @ 0x0200DB74
	push {r4, r5, r6, lr}
	mov r6, sl
	mov r5, sb
	mov r4, r8
	push {r4, r5, r6}
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	ldr r1, =gUnknown_02025248
	lsls r2, r0, #1
	adds r2, r2, r0
	lsls r2, r2, #1
	ldr r0, [r1]
	adds r2, r2, r0
	ldr r1, =gUnknown_0202137C
	ldr r0, =0x04000208
	mov sb, r0
	ldrh r0, [r0]
	strh r0, [r1]
	movs r3, #0
	mov r1, sb
	strh r3, [r1]
	ldr r0, =gUnknown_02021378
	mov r8, r0
	ldr r4, [r0]
	strh r3, [r4, #2]
	ldr r6, =0x04000200
	ldr r1, =gUnknown_02021374
	mov sl, r1
	ldrb r1, [r1]
	movs r5, #8
	adds r0, r5, #0
	lsls r0, r1
	adds r1, r0, #0
	ldrh r0, [r6]
	orrs r0, r1
	strh r0, [r6]
	ldr r0, =gUnknown_02025224
	strb r3, [r0]
	ldr r1, =gUnknown_02021376
	ldrh r0, [r2]
	strh r0, [r1]
	adds r2, #2
	ldrh r0, [r2]
	strh r0, [r4]
	adds r0, r4, #2
	mov r1, r8
	str r0, [r1]
	ldrh r0, [r2, #2]
	strh r0, [r4, #2]
	str r4, [r1]
	ldr r1, =0x04000202
	mov r2, sl
	ldrb r0, [r2]
	lsls r5, r0
	strh r5, [r1]
	movs r0, #1
	mov r3, sb
	strh r0, [r3]
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_0200DC1C
sub_0200DC1C: @ 0x0200DC1C
	ldr r3, =0x04000208
	movs r1, #0
	strh r1, [r3]
	ldr r2, =gUnknown_02021378
	ldr r0, [r2]
	strh r1, [r0]
	adds r0, #2
	str r0, [r2]
	strh r1, [r0]
	subs r0, #2
	str r0, [r2]
	ldr r2, =0x04000200
	ldr r0, =gUnknown_02021374
	ldrb r0, [r0]
	movs r1, #8
	lsls r1, r0
	ldrh r0, [r2]
	bics r0, r1
	strh r0, [r2]
	ldr r0, =gUnknown_0202137C
	ldrh r0, [r0]
	strh r0, [r3]
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_0200DC60
sub_0200DC60: @ 0x0200DC60
	ldrb r0, [r0]
	bx lr

	thumb_func_start sub_0200DC64
sub_0200DC64: @ 0x0200DC64
	push {lr}
	adds r2, r0, #0
	ldr r1, =gUnknown_02025228
	adds r0, r2, #1
	str r0, [r1]
	ldr r3, =sub_0200DC60
	movs r0, #1
	eors r3, r0
	ldr r0, =sub_0200DC64
	ldr r1, =sub_0200DC60
	subs r0, r0, r1
	lsls r0, r0, #0xf
	b _0200DC98
	.align 2, 0
	.pool
_0200DC8C:
	ldrh r0, [r3]
	strh r0, [r2]
	adds r3, #2
	adds r2, #2
	subs r0, r1, #1
	lsls r0, r0, #0x10
_0200DC98:
	lsrs r1, r0, #0x10
	cmp r1, #0
	bne _0200DC8C
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start sub_0200DCA4
sub_0200DCA4: @ 0x0200DCA4
	push {r4, lr}
	adds r4, r0, #0
	subs r3, r2, #1
	cmp r2, #0
	beq _0200DCC0
	movs r2, #1
	rsbs r2, r2, #0
_0200DCB2:
	ldrb r0, [r4]
	strb r0, [r1]
	adds r4, #1
	adds r1, #1
	subs r3, #1
	cmp r3, r2
	bne _0200DCB2
_0200DCC0:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start sub_0200DCC8
sub_0200DCC8: @ 0x0200DCC8
	push {r4, r5, r6, r7, lr}
	sub sp, #0x80
	adds r5, r1, #0
	adds r6, r2, #0
	adds r7, r3, #0
	lsls r3, r0, #0x10
	lsrs r4, r3, #0x10
	ldr r2, =0x04000204
	ldrh r0, [r2]
	ldr r1, =0x0000FFFC
	ands r0, r1
	movs r1, #3
	orrs r0, r1
	strh r0, [r2]
	ldr r0, =gUnknown_02025234
	ldr r0, [r0]
	ldr r1, [r0]
	movs r0, #0x80
	lsls r0, r0, #0xa
	cmp r1, r0
	bne _0200DD00
	lsrs r0, r3, #0x14
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	bl sub_0200DA50
	movs r0, #0xf
	ands r4, r0
_0200DD00:
	ldr r3, =sub_0200DCA4
	movs r0, #1
	eors r3, r0
	mov r2, sp
	ldr r0, =sub_0200DCC8
	ldr r1, =sub_0200DCA4
	subs r0, r0, r1
	lsls r0, r0, #0xf
	b _0200DD34
	.align 2, 0
	.pool
_0200DD28:
	ldrh r0, [r3]
	strh r0, [r2]
	adds r3, #2
	adds r2, #2
	subs r0, r1, #1
	lsls r0, r0, #0x10
_0200DD34:
	lsrs r1, r0, #0x10
	cmp r1, #0
	bne _0200DD28
	mov r3, sp
	adds r3, #1
	ldr r0, =gUnknown_02025234
	ldr r0, [r0]
	ldrb r0, [r0, #8]
	lsls r4, r0
	adds r0, r4, #0
	movs r2, #0xe0
	lsls r2, r2, #0x14
	adds r1, r5, r2
	adds r0, r0, r1
	adds r1, r6, #0
	adds r2, r7, #0
	bl _call_via_r3
	add sp, #0x80
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_0200DD64
sub_0200DD64: @ 0x0200DD64
	push {r4, r5, lr}
	adds r5, r0, #0
	adds r3, r1, #0
	subs r4, r2, #1
	cmp r2, #0
	beq _0200DD8A
	movs r2, #1
	rsbs r2, r2, #0
_0200DD74:
	ldrb r1, [r3]
	ldrb r0, [r5]
	adds r5, #1
	adds r3, #1
	cmp r1, r0
	beq _0200DD84
	subs r0, r3, #1
	b _0200DD8C
_0200DD84:
	subs r4, #1
	cmp r4, r2
	bne _0200DD74
_0200DD8A:
	movs r0, #0
_0200DD8C:
	pop {r4, r5}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_0200DD94
sub_0200DD94: @ 0x0200DD94
	push {r4, r5, lr}
	sub sp, #0x100
	adds r5, r1, #0
	lsls r3, r0, #0x10
	lsrs r4, r3, #0x10
	ldr r2, =0x04000204
	ldrh r0, [r2]
	ldr r1, =0x0000FFFC
	ands r0, r1
	movs r1, #3
	orrs r0, r1
	strh r0, [r2]
	ldr r0, =gUnknown_02025234
	ldr r0, [r0]
	ldr r1, [r0]
	movs r0, #0x80
	lsls r0, r0, #0xa
	cmp r1, r0
	bne _0200DDC8
	lsrs r0, r3, #0x14
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	bl sub_0200DA50
	movs r0, #0xf
	ands r4, r0
_0200DDC8:
	ldr r3, =sub_0200DD64
	movs r0, #1
	eors r3, r0
	mov r2, sp
	ldr r0, =sub_0200DD94
	ldr r1, =sub_0200DD64
	subs r0, r0, r1
	lsls r0, r0, #0xf
	b _0200DDFC
	.align 2, 0
	.pool
_0200DDF0:
	ldrh r0, [r3]
	strh r0, [r2]
	adds r3, #2
	adds r2, #2
	subs r0, r1, #1
	lsls r0, r0, #0x10
_0200DDFC:
	lsrs r1, r0, #0x10
	cmp r1, #0
	bne _0200DDF0
	mov r3, sp
	adds r3, #1
	ldr r0, =gUnknown_02025234
	ldr r0, [r0]
	ldrb r1, [r0, #8]
	lsls r4, r1
	adds r1, r4, #0
	movs r2, #0xe0
	lsls r2, r2, #0x14
	adds r1, r1, r2
	ldrh r2, [r0, #4]
	adds r0, r5, #0
	bl _call_via_r3
	add sp, #0x100
	pop {r4, r5}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200DE2C
sub_0200DE2C: @ 0x0200DE2C
	push {r4, r5, r6, lr}
	sub sp, #0x100
	adds r5, r1, #0
	adds r6, r2, #0
	lsls r2, r0, #0x10
	lsrs r4, r2, #0x10
	ldr r0, =gUnknown_02025234
	ldr r0, [r0]
	ldr r1, [r0]
	movs r0, #0x80
	lsls r0, r0, #0xa
	cmp r1, r0
	bne _0200DE54
	lsrs r0, r2, #0x14
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	bl sub_0200DA50
	movs r0, #0xf
	ands r4, r0
_0200DE54:
	ldr r2, =0x04000204
	ldrh r0, [r2]
	ldr r1, =0x0000FFFC
	ands r0, r1
	movs r1, #3
	orrs r0, r1
	strh r0, [r2]
	ldr r3, =sub_0200DD64
	movs r0, #1
	eors r3, r0
	mov r2, sp
	ldr r0, =sub_0200DD94
	ldr r1, =sub_0200DD64
	subs r0, r0, r1
	lsls r0, r0, #0xf
	b _0200DE94
	.align 2, 0
	.pool
_0200DE88:
	ldrh r0, [r3]
	strh r0, [r2]
	adds r3, #2
	adds r2, #2
	subs r0, r1, #1
	lsls r0, r0, #0x10
_0200DE94:
	lsrs r1, r0, #0x10
	cmp r1, #0
	bne _0200DE88
	mov r3, sp
	adds r3, #1
	ldr r0, =gUnknown_02025234
	ldr r0, [r0]
	ldrb r1, [r0, #8]
	lsls r4, r1
	adds r1, r4, #0
	movs r0, #0xe0
	lsls r0, r0, #0x14
	adds r1, r1, r0
	adds r0, r5, #0
	adds r2, r6, #0
	bl _call_via_r3
	add sp, #0x100
	pop {r4, r5, r6}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200DEC4
sub_0200DEC4: @ 0x0200DEC4
	push {r4, r5, r6, lr}
	adds r5, r1, #0
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
	movs r6, #0
	b _0200DED6
_0200DED0:
	adds r0, r6, #1
	lsls r0, r0, #0x18
	lsrs r6, r0, #0x18
_0200DED6:
	cmp r6, #2
	bhi _0200DEFC
	ldr r0, =gUnknown_02025230
	ldr r2, [r0]
	adds r0, r4, #0
	adds r1, r5, #0
	bl _call_via_r2
	lsls r0, r0, #0x10
	lsrs r2, r0, #0x10
	cmp r2, #0
	bne _0200DED0
	adds r0, r4, #0
	adds r1, r5, #0
	bl sub_0200DD94
	adds r2, r0, #0
	cmp r2, #0
	bne _0200DED0
_0200DEFC:
	adds r0, r2, #0
	pop {r4, r5, r6}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200DF08
sub_0200DF08: @ 0x0200DF08
	push {r4, r5, r6, r7, lr}
	adds r5, r1, #0
	adds r7, r2, #0
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
	movs r6, #0
	b _0200DF1C
_0200DF16:
	adds r0, r6, #1
	lsls r0, r0, #0x18
	lsrs r6, r0, #0x18
_0200DF1C:
	cmp r6, #2
	bhi _0200DF44
	ldr r0, =gUnknown_02025230
	ldr r2, [r0]
	adds r0, r4, #0
	adds r1, r5, #0
	bl _call_via_r2
	lsls r0, r0, #0x10
	lsrs r3, r0, #0x10
	cmp r3, #0
	bne _0200DF16
	adds r0, r4, #0
	adds r1, r5, #0
	adds r2, r7, #0
	bl sub_0200DE2C
	adds r3, r0, #0
	cmp r3, #0
	bne _0200DF16
_0200DF44:
	adds r0, r3, #0
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200DF50
sub_0200DF50: @ 0x0200DF50
	push {r4, lr}
	ldr r2, =0x04000204
	ldrh r0, [r2]
	ldr r1, =0x0000FFFC
	ands r0, r1
	movs r1, #3
	orrs r0, r1
	strh r0, [r2]
	bl sub_0200DA74
	lsls r0, r0, #0x10
	lsrs r3, r0, #0x10
	ldr r2, =gUnknown_0201F180
	movs r4, #1
	b _0200DF7E
	.align 2, 0
	.pool
_0200DF7C:
	adds r2, #4
_0200DF7E:
	ldr r1, [r2]
	adds r0, r1, #0
	adds r0, #0x2c
	ldrb r0, [r0]
	cmp r0, #0
	beq _0200DF92
	ldrh r0, [r1, #0x2c]
	cmp r3, r0
	bne _0200DF7C
	movs r4, #0
_0200DF92:
	ldr r1, =gUnknown_02025238
	ldr r0, [r2]
	ldr r0, [r0]
	str r0, [r1]
	ldr r1, =gUnknown_02025230
	ldr r0, [r2]
	ldr r0, [r0, #4]
	str r0, [r1]
	ldr r1, =gUnknown_02025240
	ldr r0, [r2]
	ldr r0, [r0, #8]
	str r0, [r1]
	ldr r1, =gUnknown_02025244
	ldr r0, [r2]
	ldr r0, [r0, #0xc]
	str r0, [r1]
	ldr r1, =gUnknown_0202522C
	ldr r0, [r2]
	ldr r0, [r0, #0x10]
	str r0, [r1]
	ldr r1, =gUnknown_02025248
	ldr r0, [r2]
	ldr r0, [r0, #0x14]
	str r0, [r1]
	ldr r1, =gUnknown_02025234
	ldr r0, [r2]
	adds r0, #0x18
	str r0, [r1]
	adds r0, r4, #0
	pop {r4}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200DFF0
sub_0200DFF0: @ 0x0200DFF0
	push {r4, r5, r6, r7, lr}
	mov r7, sb
	mov r6, r8
	push {r6, r7}
	adds r4, r1, #0
	lsls r0, r0, #0x18
	lsrs r7, r0, #0x18
	lsls r2, r2, #0x18
	lsrs r5, r2, #0x18
	movs r0, #0
	mov r8, r0
	adds r0, r7, #0
	bl sub_0200DB74
	ldr r6, =gUnknown_02025228
	ldr r1, =0x0E005555
	mov sb, r1
	b _0200E054
	.align 2, 0
	.pool
_0200E01C:
	movs r0, #0xf0
	mov r1, sb
	strb r0, [r1]
	movs r0, #0xa0
	lsls r0, r0, #8
	b _0200E04A
_0200E028:
	ldr r0, =gUnknown_02025224
	ldrb r0, [r0]
	cmp r0, #0
	beq _0200E054
	ldr r1, [r6]
	adds r0, r4, #0
	bl _call_via_r1
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	cmp r0, r5
	beq _0200E07C
	movs r0, #0xf0
	mov r1, sb
	strb r0, [r1]
	movs r0, #0xc0
	lsls r0, r0, #8
_0200E04A:
	orrs r7, r0
	mov r8, r7
	b _0200E07C
	.align 2, 0
	.pool
_0200E054:
	ldr r1, [r6]
	adds r0, r4, #0
	bl _call_via_r1
	lsls r0, r0, #0x18
	lsrs r1, r0, #0x18
	cmp r1, r5
	beq _0200E07C
	movs r0, #0x20
	ands r0, r1
	cmp r0, #0
	beq _0200E028
	ldr r1, [r6]
	adds r0, r4, #0
	bl _call_via_r1
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	cmp r0, r5
	bne _0200E01C
_0200E07C:
	bl sub_0200DC1C
	mov r0, r8
	pop {r3, r4}
	mov r8, r3
	mov sb, r4
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_0200E090
sub_0200E090: @ 0x0200E090
	push {r4, r5, r6, lr}
	sub sp, #0x40
	ldr r5, =0x04000204
	ldrh r1, [r5]
	ldr r6, =0x0000FFFC
	ands r1, r6
	ldr r0, =gUnknown_02025234
	ldr r0, [r0]
	ldrh r0, [r0, #0x10]
	orrs r1, r0
	strh r1, [r5]
	ldr r1, =0x0E005555
	movs r4, #0xaa
	strb r4, [r1]
	ldr r3, =0x0E002AAA
	movs r2, #0x55
	strb r2, [r3]
	movs r0, #0x80
	strb r0, [r1]
	strb r4, [r1]
	strb r2, [r3]
	movs r0, #0x10
	strb r0, [r1]
	mov r0, sp
	bl sub_0200DC64
	ldr r0, =gUnknown_0202522C
	movs r1, #0xe0
	lsls r1, r1, #0x14
	ldr r3, [r0]
	movs r0, #3
	movs r2, #0xff
	bl _call_via_r3
	lsls r0, r0, #0x10
	lsrs r0, r0, #0x10
	ldrh r1, [r5]
	ands r1, r6
	movs r2, #3
	orrs r1, r2
	strh r1, [r5]
	add sp, #0x40
	pop {r4, r5, r6}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200E104
sub_0200E104: @ 0x0200E104
	push {r4, r5, r6, r7, lr}
	sub sp, #0x40
	lsls r0, r0, #0x10
	lsrs r6, r0, #0x10
	ldr r0, =gUnknown_02025234
	ldr r0, [r0]
	ldrh r0, [r0, #0xa]
	cmp r6, r0
	blo _0200E124
	ldr r0, =0x000080FF
	b _0200E1C4
	.align 2, 0
	.pool
_0200E124:
	lsrs r0, r6, #4
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	bl sub_0200DA50
	movs r0, #0xf
	ands r6, r0
	movs r7, #0
_0200E134:
	ldr r3, =0x04000204
	ldrh r1, [r3]
	ldr r0, =0x0000FFFC
	ands r1, r0
	ldr r0, =gUnknown_02025234
	ldr r2, [r0]
	ldrh r0, [r2, #0x10]
	orrs r1, r0
	strh r1, [r3]
	ldrb r4, [r2, #8]
	adds r0, r6, #0
	lsls r0, r4
	adds r4, r0, #0
	movs r0, #0xe0
	lsls r0, r0, #0x14
	adds r4, r4, r0
	ldr r1, =0x0E005555
	movs r5, #0xaa
	strb r5, [r1]
	ldr r3, =0x0E002AAA
	movs r2, #0x55
	strb r2, [r3]
	movs r0, #0x80
	strb r0, [r1]
	strb r5, [r1]
	strb r2, [r3]
	movs r0, #0x30
	strb r0, [r4]
	mov r0, sp
	bl sub_0200DC64
	ldr r0, =gUnknown_0202522C
	ldr r3, [r0]
	movs r0, #2
	adds r1, r4, #0
	movs r2, #0xff
	bl _call_via_r3
	lsls r0, r0, #0x10
	lsrs r3, r0, #0x10
	movs r0, #0xa0
	lsls r0, r0, #8
	ands r0, r3
	cmp r0, #0
	beq _0200E1B4
	cmp r7, #3
	bhi _0200E1B4
	adds r0, r7, #1
	lsls r0, r0, #0x10
	lsrs r7, r0, #0x10
	b _0200E134
	.align 2, 0
	.pool
_0200E1B4:
	ldr r2, =0x04000204
	ldrh r0, [r2]
	ldr r1, =0x0000FFFC
	ands r0, r1
	movs r1, #3
	orrs r0, r1
	strh r0, [r2]
	adds r0, r3, #0
_0200E1C4:
	add sp, #0x40
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200E1D4
sub_0200E1D4: @ 0x0200E1D4
	push {r4, r5, r6, r7, lr}
	sub sp, #0x40
	adds r6, r1, #0
	lsls r1, r0, #0x10
	lsrs r4, r1, #0x10
	lsls r2, r2, #0x18
	lsrs r7, r2, #0x18
	ldr r5, =gUnknown_02025234
	ldr r0, [r5]
	ldr r0, [r0, #4]
	cmp r6, r0
	bhs _0200E25C
	lsrs r0, r1, #0x14
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	bl sub_0200DA50
	movs r0, #0xf
	ldr r1, [r5]
	ands r4, r0
	ldrb r1, [r1, #8]
	lsls r4, r1
	movs r1, #0xe0
	lsls r1, r1, #0x14
	adds r0, r6, r1
	adds r4, r4, r0
	mov r0, sp
	bl sub_0200DC64
	ldr r2, =0x04000204
	ldrh r0, [r2]
	ldr r1, =0x0000FFFC
	ands r0, r1
	ldr r1, [r5]
	ldrh r1, [r1, #0x10]
	orrs r0, r1
	strh r0, [r2]
	ldr r2, =0x0E005555
	movs r0, #0xaa
	strb r0, [r2]
	ldr r1, =0x0E002AAA
	movs r0, #0x55
	strb r0, [r1]
	movs r0, #0xa0
	strb r0, [r2]
	strb r7, [r4]
	ldr r0, =gUnknown_0202522C
	ldr r3, [r0]
	movs r0, #1
	adds r1, r4, #0
	adds r2, r7, #0
	bl _call_via_r3
	lsls r0, r0, #0x10
	lsrs r0, r0, #0x10
	b _0200E260
	.align 2, 0
	.pool
_0200E25C:
	movs r0, #0x80
	lsls r0, r0, #8
_0200E260:
	add sp, #0x40
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1

	thumb_func_start sub_0200E268
sub_0200E268: @ 0x0200E268
	push {r4, lr}
	ldr r4, =0x0E005555
	movs r2, #0xaa
	strb r2, [r4]
	ldr r3, =0x0E002AAA
	movs r2, #0x55
	strb r2, [r3]
	movs r2, #0xa0
	strb r2, [r4]
	ldrb r2, [r0]
	strb r2, [r1]
	ldr r3, =gUnknown_0202522C
	ldrb r2, [r0]
	ldr r3, [r3]
	movs r0, #1
	bl _call_via_r3
	lsls r0, r0, #0x10
	lsrs r0, r0, #0x10
	pop {r4}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200E2A0
sub_0200E2A0: @ 0x0200E2A0
	push {r4, r5, r6, r7, lr}
	sub sp, #0x40
	adds r7, r1, #0
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
	ldr r0, =gUnknown_02025234
	ldr r0, [r0]
	ldrh r0, [r0, #0xa]
	cmp r4, r0
	blo _0200E2C0
	ldr r0, =0x000080FF
	b _0200E33A
	.align 2, 0
	.pool
_0200E2C0:
	adds r0, r4, #0
	bl sub_0200E104
	lsls r0, r0, #0x10
	lsrs r5, r0, #0x10
	cmp r5, #0
	bne _0200E338
	lsrs r0, r4, #4
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	bl sub_0200DA50
	movs r0, #0xf
	ands r4, r0
	mov r0, sp
	bl sub_0200DC64
	ldr r3, =0x04000204
	ldrh r1, [r3]
	ldr r0, =0x0000FFFC
	ands r1, r0
	ldr r0, =gUnknown_02025234
	ldr r2, [r0]
	ldrh r0, [r2, #0x10]
	orrs r1, r0
	strh r1, [r3]
	ldr r1, =gUnknown_0202523C
	ldr r0, [r2, #4]
	strh r0, [r1]
	ldrb r0, [r2, #8]
	lsls r4, r0
	movs r0, #0xe0
	lsls r0, r0, #0x14
	adds r4, r4, r0
	adds r6, r1, #0
	b _0200E322
	.align 2, 0
	.pool
_0200E318:
	ldrh r0, [r6]
	subs r0, #1
	strh r0, [r6]
	adds r7, #1
	adds r4, #1
_0200E322:
	ldrh r0, [r6]
	cmp r0, #0
	beq _0200E338
	adds r0, r7, #0
	adds r1, r4, #0
	bl sub_0200E268
	lsls r0, r0, #0x10
	lsrs r5, r0, #0x10
	cmp r5, #0
	beq _0200E318
_0200E338:
	adds r0, r5, #0
_0200E33A:
	add sp, #0x40
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0
