	.include "asm/macros/function.inc"
	.text
	.syntax unified

	thumb_func_start sub_0200E6D0
sub_0200E6D0: @ 0x0200E6D0
	push {r7, lr}
	sub sp, #8
	mov r7, sp
	str r0, [r7]
	ldr r1, =gUnknown_02021388
	adds r0, r1, #0
	bl sub_0200EE84
	ldr r0, =gUnknown_02021388
	ldrb r1, [r0]
	adds r0, r1, #0
	bl sub_0200EB5C
	ldr r1, [r7]
	strb r0, [r1]
	ldr r0, =gUnknown_02021388
	ldr r1, =gUnknown_02025260
	ldr r2, =gUnknown_02022ED8
	ldr r3, [r2]
	adds r2, r3, #0
	adds r2, #0x98
	bl sub_0200F080
	ldr r0, =gUnknown_02025258
	ldr r1, =gUnknown_02022ED8
	ldr r2, [r1]
	adds r1, r2, #0
	adds r1, #0xa0
	ldr r2, =gUnknown_02025260
	bl sub_0200F1E4
	ldr r1, =gUnknown_02025258
	movs r2, #0
	ldrsh r0, [r1, r2]
	adds r1, r0, #0
	lsls r2, r1, #1
	adds r2, r2, r0
	lsls r1, r2, #4
	subs r1, r1, r2
	lsls r0, r1, #5
	ldr r2, =gUnknown_02025258
	movs r1, #2
	ldrsb r1, [r2, r1]
	adds r3, r1, #0
	lsls r2, r3, #4
	subs r2, r2, r1
	lsls r1, r2, #2
	adds r0, r0, r1
	ldr r1, =gUnknown_02025258
	movs r2, #3
	ldrsb r2, [r1, r2]
	adds r0, r0, r2
	str r0, [r7, #4]
	ldr r0, [r7, #4]
	cmp r0, #0
	blt _0200E756
	movs r0, #1
	b _0200E75A
	.align 2, 0
	.pool
_0200E754: @ 0x0200E754
	b _0200E75A
_0200E756:
	movs r0, #0
	b _0200E75A
_0200E75A:
	add sp, #8
	pop {r7}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_0200E764
sub_0200E764: @ 0x0200E764
	push {r7, lr}
	sub sp, #8
	mov r7, sp
	adds r1, r7, #0
	strb r0, [r1]
	movs r0, #0
	str r0, [r7, #4]
	adds r0, r7, #0
	ldrb r1, [r0]
	cmp r1, #0x63
	bls _0200E77E
	movs r0, #0xff
	b _0200E7A6
_0200E77E:
	adds r0, r7, #0
	ldrb r1, [r0]
	adds r0, r1, #0
	movs r1, #0xa
	bl Div
	lsls r1, r0, #4
	str r1, [r7, #4]
	adds r0, r7, #0
	ldrb r1, [r0]
	adds r0, r1, #0
	movs r1, #0xa
	bl Mod
	ldr r1, [r7, #4]
	orrs r0, r1
	str r0, [r7, #4]
	ldr r1, [r7, #4]
	adds r0, r1, #0
	b _0200E7A6
_0200E7A6:
	add sp, #8
	pop {r7}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_0200E7B0
sub_0200E7B0: @ 0x0200E7B0
	push {r7, lr}
	sub sp, #4
	mov r7, sp
	str r0, [r7]
	ldr r0, [r7]
	ldrb r1, [r0]
	adds r0, r1, #0
	bl sub_0200EB5C
	adds r1, r0, #0
	adds r0, r1, #1
	adds r1, r0, #0
	lsls r0, r1, #0x18
	lsrs r1, r0, #0x18
	adds r0, r1, #0
	bl sub_0200E764
	ldr r1, [r7]
	strb r0, [r1]
	add sp, #4
	pop {r7}
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start sub_0200E7E0
sub_0200E7E0: @ 0x0200E7E0
	push {r7, lr}
	sub sp, #4
	mov r7, sp
	str r0, [r7]
	ldr r0, [r7]
	adds r1, r0, #1
	adds r0, r1, #0
	bl sub_0200E7B0
	ldr r0, [r7]
	ldrb r1, [r0, #1]
	adds r0, r1, #0
	bl sub_0200EB5C
	cmp r0, #0xc
	bgt _0200E802
	b _0200E81C
_0200E802:
	ldr r0, [r7]
	bl sub_0200E7B0
	ldr r0, [r7]
	ldrb r1, [r0, #1]
	movs r2, #0
	ands r1, r2
	adds r2, r1, #0
	movs r3, #1
	adds r1, r2, #0
	orrs r1, r3
	adds r2, r1, #0
	strb r2, [r0, #1]
_0200E81C:
	add sp, #4
	pop {r7}
	pop {r0}
	bx r0

	thumb_func_start sub_0200E824
sub_0200E824: @ 0x0200E824
	push {r4, r5, r7, lr}
	sub sp, #4
	mov r7, sp
	str r0, [r7]
	ldr r0, [r7]
	adds r1, r0, #2
	adds r0, r1, #0
	bl sub_0200E7B0
	ldr r0, [r7]
	ldrb r1, [r0, #2]
	adds r0, r1, #0
	bl sub_0200EB5C
	adds r4, r0, #0
	ldr r5, =gUnknown_0201F318
	ldr r0, [r7]
	ldrb r1, [r0, #1]
	adds r0, r1, #0
	bl sub_0200EB5C
	subs r1, r0, #1
	adds r0, r1, #0
	lsls r1, r0, #2
	adds r0, r5, r1
	ldr r1, [r0]
	cmp r4, r1
	bgt _0200E864
	b _0200E8BA
	.align 2, 0
	.pool
_0200E864:
	ldr r0, [r7]
	ldrb r1, [r0]
	adds r0, r1, #0
	bl sub_0200EB5C
	adds r1, r0, #0
	lsls r0, r1, #0x18
	lsrs r1, r0, #0x18
	adds r0, r1, #0
	bl sub_0200EBC4
	lsls r1, r0, #0x18
	lsrs r0, r1, #0x18
	cmp r0, #0
	beq _0200E8A0
	ldr r0, [r7]
	ldrb r1, [r0, #1]
	adds r0, r1, #0
	bl sub_0200EB5C
	cmp r0, #2
	bne _0200E8A0
	ldr r0, [r7]
	ldrb r1, [r0, #2]
	adds r0, r1, #0
	bl sub_0200EB5C
	cmp r0, #0x1d
	bne _0200E8A0
	b _0200E8BA
_0200E8A0:
	ldr r0, [r7]
	ldrb r1, [r0, #2]
	movs r2, #0
	ands r1, r2
	adds r2, r1, #0
	movs r3, #1
	adds r1, r2, #0
	orrs r1, r3
	adds r2, r1, #0
	strb r2, [r0, #2]
	ldr r0, [r7]
	bl sub_0200E7E0
_0200E8BA:
	add sp, #4
	pop {r4, r5, r7}
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start sub_0200E8C4
sub_0200E8C4: @ 0x0200E8C4
	push {r7, lr}
	sub sp, #4
	mov r7, sp
	str r0, [r7]
	ldr r0, [r7]
	ldrb r1, [r0]
	adds r0, r1, #0
	bl sub_0200EB5C
	cmp r0, #0
	bne _0200E914
	ldr r0, [r7]
	ldrb r1, [r0, #1]
	adds r0, r1, #0
	bl sub_0200EB5C
	cmp r0, #1
	bne _0200E8EC
	movs r0, #0
	b _0200E92A
_0200E8EC:
	ldr r0, [r7]
	ldrb r1, [r0, #1]
	adds r0, r1, #0
	bl sub_0200EB5C
	cmp r0, #2
	ble _0200E8FE
	movs r0, #1
	b _0200E92A
_0200E8FE:
	ldr r0, [r7]
	ldrb r1, [r0, #2]
	adds r0, r1, #0
	bl sub_0200EB5C
	cmp r0, #0x1d
	bne _0200E910
	movs r0, #1
	b _0200E92A
_0200E910:
	movs r0, #0
	b _0200E92A
_0200E914:
	ldr r0, [r7]
	ldrb r1, [r0]
	adds r0, r1, #0
	bl sub_0200EB5C
	cmp r0, #1
	bne _0200E926
	movs r0, #1
	b _0200E92A
_0200E926:
	movs r0, #0
	b _0200E92A
_0200E92A:
	add sp, #4
	pop {r7}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_0200E934
sub_0200E934: @ 0x0200E934
	push {r7, lr}
	mov r7, sp
	ldr r1, =gUnknown_02021388
	adds r0, r1, #0
	bl sub_0200EE84
	ldr r0, =gUnknown_02021388
	ldrb r1, [r0]
	adds r0, r1, #0
	bl sub_0200EB5C
	cmp r0, #0
	beq _0200E964
	ldr r0, =gUnknown_02021388
	ldrb r1, [r0]
	adds r0, r1, #0
	bl sub_0200EB5C
	cmp r0, #1
	beq _0200E964
	b _0200E9F0
	.align 2, 0
	.pool
_0200E964:
	ldr r0, =gUnknown_02021388
	ldrb r1, [r0]
	adds r0, r1, #0
	bl sub_0200EB5C
	cmp r0, #1
	bne _0200E9BC
	ldr r0, =gUnknown_02021388
	ldrb r1, [r0]
	movs r2, #0
	ands r1, r2
	adds r2, r1, #0
	movs r3, #2
	adds r1, r2, #0
	orrs r1, r3
	adds r2, r1, #0
	strb r2, [r0]
	ldr r0, =gUnknown_02021388
	ldrb r1, [r0, #1]
	movs r2, #0
	ands r1, r2
	adds r2, r1, #0
	movs r3, #1
	adds r1, r2, #0
	orrs r1, r3
	adds r2, r1, #0
	strb r2, [r0, #1]
	ldr r0, =gUnknown_02021388
	ldrb r1, [r0, #2]
	movs r2, #0
	ands r1, r2
	adds r2, r1, #0
	movs r3, #2
	adds r1, r2, #0
	orrs r1, r3
	adds r2, r1, #0
	strb r2, [r0, #2]
	ldr r1, =gUnknown_02021388
	adds r0, r1, #0
	bl sub_0200E6A0
	b _0200E9F0
	.align 2, 0
	.pool
_0200E9BC:
	ldr r1, =gUnknown_02021388
	adds r0, r1, #0
	bl sub_0200E8C4
	cmp r0, #1
	bne _0200E9E0
	ldr r1, =gUnknown_02021388
	adds r0, r1, #0
	bl sub_0200E824
	ldr r1, =gUnknown_02021388
	adds r0, r1, #0
	bl sub_0200E7B0
	b _0200E9E8
	.align 2, 0
	.pool
_0200E9E0:
	ldr r1, =gUnknown_02021388
	adds r0, r1, #0
	bl sub_0200E7B0
_0200E9E8:
	ldr r1, =gUnknown_02021388
	adds r0, r1, #0
	bl sub_0200E6A0
_0200E9F0:
	pop {r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_0200E9FC
sub_0200E9FC: @ 0x0200E9FC
	push {r7, lr}
	sub sp, #8
	mov r7, sp
	str r0, [r7]
	adds r0, r1, #0
	adds r1, r7, #4
	strb r0, [r1]
	ldr r0, [r7]
	adds r1, r7, #4
	ldrb r2, [r1]
	movs r3, #0xf0
	adds r1, r2, #0
	ands r1, r3
	adds r3, r1, #0
	lsls r2, r3, #0x18
	lsrs r1, r2, #0x18
	lsrs r2, r1, #4
	adds r1, r2, #0
	adds r2, r1, #0
	adds r2, #0x30
	adds r1, r2, #0
	strb r1, [r0]
	ldr r0, [r7]
	adds r1, r0, #1
	str r1, [r7]
	ldr r0, [r7]
	adds r1, r7, #4
	ldrb r2, [r1]
	movs r3, #0xf
	adds r1, r2, #0
	ands r1, r3
	adds r2, r1, #0
	adds r1, r2, #0
	adds r1, #0x30
	adds r2, r1, #0
	strb r2, [r0]
	ldr r0, [r7]
	adds r1, r0, #1
	str r1, [r7]
	ldr r0, [r7]
	movs r1, #0
	strb r1, [r0]
	ldr r1, [r7]
	adds r0, r1, #0
	b _0200EA56
_0200EA56:
	add sp, #8
	pop {r7}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_0200EA60
sub_0200EA60: @ 0x0200EA60
	push {r7, lr}
	sub sp, #4
	mov r7, sp
	str r0, [r7]
	ldr r0, =gUnknown_02025250
	ldr r1, [r0]
	cmp r1, #1
	beq _0200EA80
	ldr r0, =gUnknown_02025250
	ldr r1, [r0]
	cmp r1, #2
	beq _0200EA80
	b _0200EA88
	.align 2, 0
	.pool
_0200EA80:
	ldr r1, =gUnknown_02021388
	adds r0, r1, #0
	bl sub_0200EE84
_0200EA88:
	ldr r0, =gUnknown_02021388
	ldrb r1, [r0]
	ldr r0, [r7]
	bl sub_0200E9FC
	str r0, [r7]
	ldr r0, [r7]
	movs r1, #0x20
	strb r1, [r0]
	adds r0, #1
	str r0, [r7]
	ldr r0, =gUnknown_02021388
	ldrb r1, [r0, #1]
	ldr r0, [r7]
	bl sub_0200E9FC
	str r0, [r7]
	ldr r0, [r7]
	movs r1, #0x20
	strb r1, [r0]
	adds r0, #1
	str r0, [r7]
	ldr r0, =gUnknown_02021388
	ldrb r1, [r0, #2]
	ldr r0, [r7]
	bl sub_0200E9FC
	str r0, [r7]
	ldr r0, [r7]
	movs r1, #0x20
	strb r1, [r0]
	adds r0, #1
	str r0, [r7]
	ldr r0, =gUnknown_02021388
	ldrb r1, [r0, #4]
	ldr r0, [r7]
	bl sub_0200E9FC
	str r0, [r7]
	ldr r0, [r7]
	movs r1, #0x3a
	strb r1, [r0]
	adds r0, #1
	str r0, [r7]
	ldr r0, =gUnknown_02021388
	ldrb r1, [r0, #5]
	ldr r0, [r7]
	bl sub_0200E9FC
	str r0, [r7]
	ldr r0, [r7]
	movs r1, #0x3a
	strb r1, [r0]
	adds r0, #1
	str r0, [r7]
	ldr r0, =gUnknown_02021388
	ldrb r1, [r0, #6]
	ldr r0, [r7]
	bl sub_0200E9FC
	str r0, [r7]
	ldr r0, [r7]
	movs r1, #0
	strb r1, [r0]
	adds r0, #1
	str r0, [r7]
	ldr r1, [r7]
	adds r0, r1, #0
	b _0200EB18
	.align 2, 0
	.pool
_0200EB18:
	add sp, #4
	pop {r7}
	pop {r1}
	bx r1

	thumb_func_start sub_0200EB20
sub_0200EB20: @ 0x0200EB20
	push {r7, lr}
	mov r7, sp
	ldr r0, =gUnknown_020213AE
	ldr r1, =0x04000208
	ldrh r2, [r1]
	strh r2, [r0]
	ldr r0, =0x04000208
	movs r1, #0
	strh r1, [r0]
	pop {r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_0200EB40
sub_0200EB40: @ 0x0200EB40
	push {r7, lr}
	mov r7, sp
	ldr r0, =0x04000208
	ldr r1, =gUnknown_020213AE
	ldrh r2, [r1]
	strh r2, [r0]
	pop {r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_0200EB5C
sub_0200EB5C: @ 0x0200EB5C
	push {r4, r7, lr}
	sub sp, #4
	mov r7, sp
	adds r1, r7, #0
	strb r0, [r1]
	adds r0, r7, #0
	ldrb r1, [r0]
	cmp r1, #0x9f
	bhi _0200EB84
	adds r0, r7, #0
	ldrb r1, [r0]
	movs r2, #0xf
	adds r0, r1, #0
	ands r0, r2
	adds r2, r0, #0
	lsls r1, r2, #0x18
	lsrs r0, r1, #0x18
	cmp r0, #9
	bhi _0200EB84
	b _0200EB88
_0200EB84:
	movs r0, #0xff
	b _0200EBBA
_0200EB88:
	adds r0, r7, #0
	ldrb r1, [r0]
	lsrs r0, r1, #4
	adds r1, r0, #0
	movs r2, #0xf
	adds r0, r1, #0
	ands r0, r2
	adds r1, r0, #0
	lsls r0, r1, #0x18
	lsrs r1, r0, #0x18
	adds r0, r1, #0
	lsls r2, r0, #2
	adds r2, r2, r1
	lsls r0, r2, #1
	adds r2, r7, #0
	ldrb r3, [r2]
	movs r4, #0xf
	adds r2, r3, #0
	ands r2, r4
	adds r4, r2, #0
	lsls r3, r4, #0x18
	lsrs r2, r3, #0x18
	adds r1, r0, r2
	adds r0, r1, #0
	b _0200EBBA
_0200EBBA:
	add sp, #4
	pop {r4, r7}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_0200EBC4
sub_0200EBC4: @ 0x0200EBC4
	push {r7, lr}
	sub sp, #4
	mov r7, sp
	adds r1, r7, #0
	strb r0, [r1]
	adds r0, r7, #0
	ldrb r1, [r0]
	movs r2, #3
	adds r0, r1, #0
	ands r0, r2
	adds r2, r0, #0
	lsls r1, r2, #0x18
	lsrs r0, r1, #0x18
	cmp r0, #0
	bne _0200EBFA
	adds r0, r7, #0
	ldrb r1, [r0]
	adds r0, r1, #0
	movs r1, #0x64
	bl __umodsi3
	adds r2, r0, #0
	lsls r1, r2, #0x18
	lsrs r0, r1, #0x18
	cmp r0, #0
	bne _0200EC0E
	b _0200EBFA
_0200EBFA:
	adds r0, r7, #0
	ldrb r1, [r0]
	adds r0, r1, #0
	movs r1, #0xc8
	lsls r1, r1, #1
	bl __modsi3
	cmp r0, #0
	bne _0200EC14
	b _0200EC0E
_0200EC0E:
	movs r0, #1
	b _0200EC18
_0200EC12: @ 0x0200EC12
	b _0200EC18
_0200EC14:
	movs r0, #0
	b _0200EC18
_0200EC18:
	add sp, #4
	pop {r7}
	pop {r1}
	bx r1

	thumb_func_start sub_0200EC20
sub_0200EC20: @ 0x0200EC20
	push {r4, r7, lr}
	sub sp, #0xc
	mov r7, sp
	adds r3, r0, #0
	adds r0, r2, #0
	adds r2, r7, #0
	strb r3, [r2]
	adds r2, r7, #1
	strb r1, [r2]
	adds r1, r7, #2
	strb r0, [r1]
	adds r0, r7, #4
	movs r1, #0
	strh r1, [r0]
	adds r0, r7, #0
	ldrb r1, [r0]
	subs r0, r1, #1
	str r0, [r7, #8]
_0200EC44:
	ldr r0, [r7, #8]
	cmp r0, #0
	bgt _0200EC4C
	b _0200EC8C
_0200EC4C:
	adds r0, r7, #4
	adds r1, r7, #4
	ldrh r2, [r1]
	ldr r3, =0x0000016D
	adds r1, r2, r3
	adds r2, r1, #0
	strh r2, [r0]
	ldr r1, [r7, #8]
	adds r0, r1, #0
	lsls r2, r0, #0x18
	lsrs r1, r2, #0x18
	adds r0, r1, #0
	bl sub_0200EBC4
	lsls r1, r0, #0x18
	lsrs r0, r1, #0x18
	cmp r0, #1
	bne _0200EC7E
	adds r1, r7, #4
	adds r0, r7, #4
	adds r1, r7, #4
	ldrh r2, [r1]
	adds r1, r2, #1
	adds r2, r1, #0
	strh r2, [r0]
_0200EC7E:
	ldr r0, [r7, #8]
	subs r1, r0, #1
	str r1, [r7, #8]
	b _0200EC44
	.align 2, 0
	.pool
_0200EC8C:
	movs r0, #0
	str r0, [r7, #8]
_0200EC90:
	adds r0, r7, #1
	ldrb r1, [r0]
	subs r0, r1, #1
	ldr r1, [r7, #8]
	cmp r1, r0
	blt _0200EC9E
	b _0200ECC4
_0200EC9E:
	adds r0, r7, #4
	adds r1, r7, #4
	ldr r2, =gUnknown_0201F318
	ldr r3, [r7, #8]
	adds r4, r3, #0
	lsls r3, r4, #2
	adds r2, r2, r3
	ldr r3, [r2]
	adds r2, r3, #0
	ldrh r1, [r1]
	adds r2, r1, r2
	adds r1, r2, #0
	strh r1, [r0]
	ldr r0, [r7, #8]
	adds r1, r0, #1
	str r1, [r7, #8]
	b _0200EC90
	.align 2, 0
	.pool
_0200ECC4:
	adds r0, r7, #1
	ldrb r1, [r0]
	cmp r1, #2
	bls _0200ECEA
	adds r0, r7, #0
	ldrb r1, [r0]
	adds r0, r1, #0
	bl sub_0200EBC4
	lsls r1, r0, #0x18
	lsrs r0, r1, #0x18
	cmp r0, #1
	bne _0200ECEA
	adds r0, r7, #4
	adds r1, r7, #4
	ldrh r2, [r1]
	adds r1, r2, #1
	adds r2, r1, #0
	strh r2, [r0]
_0200ECEA:
	adds r0, r7, #4
	adds r1, r7, #4
	adds r2, r7, #2
	ldrb r3, [r2]
	adds r2, r3, #0
	ldrh r1, [r1]
	adds r2, r1, r2
	adds r1, r2, #0
	strh r1, [r0]
	adds r0, r7, #4
	ldrh r1, [r0]
	adds r0, r1, #0
	b _0200ED04
_0200ED04:
	add sp, #0xc
	pop {r4, r7}
	pop {r1}
	bx r1

	thumb_func_start sub_0200ED0C
sub_0200ED0C: @ 0x0200ED0C
	push {r4, r5, r7, lr}
	sub sp, #4
	mov r7, sp
	str r0, [r7]
	ldr r0, [r7]
	ldrb r1, [r0]
	adds r0, r1, #0
	bl sub_0200EB5C
	adds r1, r0, #0
	lsls r0, r1, #0x18
	lsrs r4, r0, #0x18
	ldr r0, [r7]
	ldrb r1, [r0, #1]
	adds r0, r1, #0
	bl sub_0200EB5C
	adds r1, r0, #0
	lsls r0, r1, #0x18
	lsrs r5, r0, #0x18
	ldr r0, [r7]
	ldrb r1, [r0, #2]
	adds r0, r1, #0
	bl sub_0200EB5C
	adds r1, r0, #0
	lsls r0, r1, #0x18
	lsrs r2, r0, #0x18
	adds r0, r4, #0
	adds r1, r5, #0
	bl sub_0200EC20
	lsls r2, r0, #0x10
	lsrs r1, r2, #0x10
	adds r0, r1, #0
	b _0200ED54
_0200ED54:
	add sp, #4
	pop {r4, r5, r7}
	pop {r1}
	bx r1

	thumb_func_start sub_0200ED5C
sub_0200ED5C: @ 0x0200ED5C
	push {r7, lr}
	mov r7, sp
	ldr r0, =gUnknown_02021398
	movs r1, #0
	strh r1, [r0]
	bl sub_0200EB20
	bl SiiRtcUnprotect
	bl SiiRtcProbe
	ldr r1, =gUnknown_020213AC
	strb r0, [r1]
	bl sub_0200EB40
	ldr r0, =gUnknown_020213AC
	ldrb r1, [r0]
	movs r2, #0xf
	adds r0, r1, #0
	ands r0, r2
	adds r2, r0, #0
	lsls r1, r2, #0x18
	lsrs r0, r1, #0x18
	cmp r0, #1
	beq _0200EDA0
	ldr r0, =gUnknown_02021398
	movs r1, #1
	strh r1, [r0]
	b _0200EDDE
	.align 2, 0
	.pool
_0200EDA0:
	ldr r0, =gUnknown_020213AC
	ldrb r1, [r0]
	movs r2, #0xf0
	adds r0, r1, #0
	ands r0, r2
	adds r2, r0, #0
	lsls r1, r2, #0x18
	lsrs r0, r1, #0x18
	cmp r0, #0
	beq _0200EDC4
	ldr r0, =gUnknown_02021398
	movs r1, #2
	strh r1, [r0]
	b _0200EDCA
	.align 2, 0
	.pool
_0200EDC4:
	ldr r0, =gUnknown_02021398
	movs r1, #0
	strh r1, [r0]
_0200EDCA:
	ldr r1, =gUnknown_020213A0
	adds r0, r1, #0
	bl sub_0200EE84
	ldr r1, =gUnknown_020213A0
	adds r0, r1, #0
	bl sub_0200EEA0
	ldr r1, =gUnknown_02021398
	strh r0, [r1]
_0200EDDE:
	pop {r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_0200EDEC
sub_0200EDEC: @ 0x0200EDEC
	push {r7, lr}
	mov r7, sp
	ldr r0, =gUnknown_02021398
	ldrh r1, [r0]
	adds r0, r1, #0
	b _0200EDFC
	.align 2, 0
	.pool
_0200EDFC:
	pop {r7}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_0200EE04
sub_0200EE04: @ 0x0200EE04
	push {r4, r7, lr}
	sub sp, #4
	mov r7, sp
	str r0, [r7]
	ldr r0, =gUnknown_02021398
	ldrh r1, [r0]
	movs r2, #0xff
	lsls r2, r2, #4
	adds r0, r1, #0
	ands r0, r2
	adds r2, r0, #0
	lsls r1, r2, #0x10
	lsrs r0, r1, #0x10
	cmp r0, #0
	beq _0200EE34
	ldr r0, [r7]
	ldr r1, =gUnknown_0201F304
	ldm r1!, {r2, r3, r4}
	stm r0!, {r2, r3, r4}
	b _0200EE3A
	.align 2, 0
	.pool
_0200EE34:
	ldr r0, [r7]
	bl sub_0200EE84
_0200EE3A:
	add sp, #4
	pop {r4, r7}
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start sub_0200EE44
sub_0200EE44: @ 0x0200EE44
	push {r7, lr}
	sub sp, #4
	mov r7, sp
	str r0, [r7]
	bl sub_0200EB20
	ldr r0, [r7]
	bl SiiRtcGetDateTime
	bl sub_0200EB40
	add sp, #4
	pop {r7}
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start sub_0200EE64
sub_0200EE64: @ 0x0200EE64
	push {r7, lr}
	sub sp, #4
	mov r7, sp
	str r0, [r7]
	bl sub_0200EB20
	ldr r0, [r7]
	bl SiiRtcGetStatus
	bl sub_0200EB40
	add sp, #4
	pop {r7}
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start sub_0200EE84
sub_0200EE84: @ 0x0200EE84
	push {r7, lr}
	sub sp, #4
	mov r7, sp
	str r0, [r7]
	ldr r0, [r7]
	bl sub_0200EE64
	ldr r0, [r7]
	bl sub_0200EE44
	add sp, #4
	pop {r7}
	pop {r0}
	bx r0

	thumb_func_start sub_0200EEA0
sub_0200EEA0: @ 0x0200EEA0
	push {r7, lr}
	sub sp, #0x14
	mov r7, sp
	str r0, [r7]
	adds r0, r7, #4
	movs r1, #0
	strh r1, [r0]
	ldr r0, [r7]
	ldrb r1, [r0, #7]
	movs r2, #0x80
	adds r0, r1, #0
	ands r0, r2
	adds r2, r0, #0
	lsls r1, r2, #0x18
	lsrs r0, r1, #0x18
	cmp r0, #0
	beq _0200EED2
	adds r0, r7, #4
	adds r1, r7, #4
	ldrh r2, [r1]
	movs r3, #0x20
	adds r1, r2, #0
	orrs r1, r3
	adds r2, r1, #0
	strh r2, [r0]
_0200EED2:
	ldr r0, [r7]
	ldrb r1, [r0, #7]
	movs r2, #0x40
	adds r0, r1, #0
	ands r0, r2
	adds r2, r0, #0
	lsls r1, r2, #0x18
	lsrs r0, r1, #0x18
	cmp r0, #0
	bne _0200EEF6
	adds r0, r7, #4
	adds r1, r7, #4
	ldrh r2, [r1]
	movs r3, #0x10
	adds r1, r2, #0
	orrs r1, r3
	adds r2, r1, #0
	strh r2, [r0]
_0200EEF6:
	ldr r0, [r7]
	ldrb r1, [r0]
	adds r0, r1, #0
	bl sub_0200EB5C
	str r0, [r7, #8]
	ldr r0, [r7, #8]
	cmp r0, #0xff
	bne _0200EF18
	adds r0, r7, #4
	adds r1, r7, #4
	ldrh r2, [r1]
	movs r3, #0x40
	adds r1, r2, #0
	orrs r1, r3
	adds r2, r1, #0
	strh r2, [r0]
_0200EF18:
	ldr r0, [r7]
	ldrb r1, [r0, #1]
	adds r0, r1, #0
	bl sub_0200EB5C
	str r0, [r7, #0xc]
	ldr r0, [r7, #0xc]
	cmp r0, #0xff
	beq _0200EF38
	ldr r0, [r7, #0xc]
	cmp r0, #0
	beq _0200EF38
	ldr r0, [r7, #0xc]
	cmp r0, #0xc
	bgt _0200EF38
	b _0200EF48
_0200EF38:
	adds r0, r7, #4
	adds r1, r7, #4
	ldrh r2, [r1]
	movs r3, #0x80
	adds r1, r2, #0
	orrs r1, r3
	adds r2, r1, #0
	strh r2, [r0]
_0200EF48:
	ldr r0, [r7]
	ldrb r1, [r0, #2]
	adds r0, r1, #0
	bl sub_0200EB5C
	str r0, [r7, #0x10]
	ldr r0, [r7, #0x10]
	cmp r0, #0xff
	bne _0200EF6C
	adds r0, r7, #4
	adds r1, r7, #4
	ldrh r2, [r1]
	movs r3, #0x80
	lsls r3, r3, #1
	adds r1, r2, #0
	orrs r1, r3
	adds r2, r1, #0
	strh r2, [r0]
_0200EF6C:
	ldr r0, [r7, #0xc]
	cmp r0, #2
	bne _0200EFA8
	ldr r1, [r7, #8]
	adds r0, r1, #0
	lsls r2, r0, #0x18
	lsrs r1, r2, #0x18
	adds r0, r1, #0
	bl sub_0200EBC4
	lsls r1, r0, #0x18
	lsrs r0, r1, #0x18
	ldr r1, =gUnknown_0201F318
	ldr r2, [r1, #4]
	adds r0, r0, r2
	ldr r1, [r7, #0x10]
	cmp r1, r0
	ble _0200EFA2
	adds r0, r7, #4
	adds r1, r7, #4
	ldrh r2, [r1]
	movs r3, #0x80
	lsls r3, r3, #1
	adds r1, r2, #0
	orrs r1, r3
	adds r2, r1, #0
	strh r2, [r0]
_0200EFA2:
	b _0200EFCE
	.align 2, 0
	.pool
_0200EFA8:
	ldr r0, =gUnknown_0201F318
	ldr r2, [r7, #0xc]
	subs r1, r2, #1
	adds r2, r1, #0
	lsls r1, r2, #2
	adds r0, r0, r1
	ldr r1, [r7, #0x10]
	ldr r0, [r0]
	cmp r1, r0
	ble _0200EFCE
	adds r0, r7, #4
	adds r1, r7, #4
	ldrh r2, [r1]
	movs r3, #0x80
	lsls r3, r3, #1
	adds r1, r2, #0
	orrs r1, r3
	adds r2, r1, #0
	strh r2, [r0]
_0200EFCE:
	ldr r0, [r7]
	ldrb r1, [r0, #4]
	adds r0, r1, #0
	bl sub_0200EB5C
	str r0, [r7, #0x10]
	ldr r0, [r7, #0x10]
	cmp r0, #0xff
	beq _0200EFEC
	ldr r0, [r7, #0x10]
	cmp r0, #0x18
	bgt _0200EFEC
	b _0200EFFE
	.align 2, 0
	.pool
_0200EFEC:
	adds r0, r7, #4
	adds r1, r7, #4
	ldrh r2, [r1]
	movs r3, #0x80
	lsls r3, r3, #2
	adds r1, r2, #0
	orrs r1, r3
	adds r2, r1, #0
	strh r2, [r0]
_0200EFFE:
	ldr r0, [r7]
	ldrb r1, [r0, #5]
	adds r0, r1, #0
	bl sub_0200EB5C
	str r0, [r7, #0x10]
	ldr r0, [r7, #0x10]
	cmp r0, #0xff
	beq _0200F018
	ldr r0, [r7, #0x10]
	cmp r0, #0x3c
	bgt _0200F018
	b _0200F02A
_0200F018:
	adds r0, r7, #4
	adds r1, r7, #4
	ldrh r2, [r1]
	movs r3, #0x80
	lsls r3, r3, #3
	adds r1, r2, #0
	orrs r1, r3
	adds r2, r1, #0
	strh r2, [r0]
_0200F02A:
	ldr r0, [r7]
	ldrb r1, [r0, #6]
	adds r0, r1, #0
	bl sub_0200EB5C
	str r0, [r7, #0x10]
	ldr r0, [r7, #0x10]
	cmp r0, #0xff
	beq _0200F044
	ldr r0, [r7, #0x10]
	cmp r0, #0x3c
	bgt _0200F044
	b _0200F056
_0200F044:
	adds r0, r7, #4
	adds r1, r7, #4
	ldrh r2, [r1]
	movs r3, #0x80
	lsls r3, r3, #4
	adds r1, r2, #0
	orrs r1, r3
	adds r2, r1, #0
	strh r2, [r0]
_0200F056:
	adds r0, r7, #4
	ldrh r1, [r0]
	adds r0, r1, #0
	b _0200F05E
_0200F05E:
	add sp, #0x14
	pop {r7}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_0200F068
sub_0200F068: @ 0x0200F068
	push {r7, lr}
	mov r7, sp
	bl sub_0200EB20
	bl SiiRtcReset
	bl sub_0200EB40
	pop {r7}
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start sub_0200F080
sub_0200F080: @ 0x0200F080
	push {r7, lr}
	sub sp, #0x10
	mov r7, sp
	str r0, [r7]
	str r1, [r7, #4]
	str r2, [r7, #8]
	ldr r0, [r7]
	bl sub_0200ED0C
	adds r1, r7, #0
	adds r1, #0xc
	strh r0, [r1]
	ldr r0, [r7]
	ldrb r1, [r0, #6]
	adds r0, r1, #0
	bl sub_0200EB5C
	adds r1, r0, #0
	ldr r0, [r7, #4]
	ldr r2, [r7, #8]
	ldrb r2, [r2, #4]
	subs r1, r1, r2
	ldrb r2, [r0, #4]
	movs r3, #0
	ands r2, r3
	adds r3, r2, #0
	adds r2, r3, #0
	orrs r2, r1
	adds r1, r2, #0
	strb r1, [r0, #4]
	ldr r0, [r7]
	ldrb r1, [r0, #5]
	adds r0, r1, #0
	bl sub_0200EB5C
	adds r1, r0, #0
	ldr r0, [r7, #4]
	ldr r2, [r7, #8]
	ldrb r2, [r2, #3]
	subs r1, r1, r2
	ldrb r2, [r0, #3]
	movs r3, #0
	ands r2, r3
	adds r3, r2, #0
	adds r2, r3, #0
	orrs r2, r1
	adds r1, r2, #0
	strb r1, [r0, #3]
	ldr r0, [r7]
	ldrb r1, [r0, #4]
	adds r0, r1, #0
	bl sub_0200EB5C
	adds r1, r0, #0
	ldr r0, [r7, #4]
	ldr r2, [r7, #8]
	ldrb r2, [r2, #2]
	subs r1, r1, r2
	ldrb r2, [r0, #2]
	movs r3, #0
	ands r2, r3
	adds r3, r2, #0
	adds r2, r3, #0
	orrs r2, r1
	adds r1, r2, #0
	strb r1, [r0, #2]
	ldr r0, [r7, #4]
	adds r1, r7, #0
	adds r1, #0xc
	ldr r2, [r7, #8]
	ldrh r1, [r1]
	ldrh r2, [r2]
	subs r1, r1, r2
	ldrh r2, [r0]
	movs r3, #0
	ands r2, r3
	adds r3, r2, #0
	adds r2, r3, #0
	orrs r2, r1
	adds r1, r2, #0
	strh r1, [r0]
	ldr r0, [r7, #4]
	movs r1, #4
	ldrsb r1, [r0, r1]
	cmp r1, #0
	bge _0200F160
	ldr r0, [r7, #4]
	ldr r1, [r7, #4]
	ldrb r2, [r1, #4]
	adds r1, r2, #0
	adds r1, #0x3c
	ldrb r2, [r0, #4]
	movs r3, #0
	ands r2, r3
	adds r3, r2, #0
	adds r2, r3, #0
	orrs r2, r1
	adds r1, r2, #0
	strb r1, [r0, #4]
	ldr r1, [r7, #4]
	ldr r0, [r7, #4]
	ldr r1, [r7, #4]
	ldrb r2, [r1, #3]
	subs r1, r2, #1
	ldrb r2, [r0, #3]
	movs r3, #0
	ands r2, r3
	adds r3, r2, #0
	adds r2, r3, #0
	orrs r2, r1
	adds r1, r2, #0
	strb r1, [r0, #3]
_0200F160:
	ldr r0, [r7, #4]
	movs r1, #3
	ldrsb r1, [r0, r1]
	cmp r1, #0
	bge _0200F19E
	ldr r0, [r7, #4]
	ldr r1, [r7, #4]
	ldrb r2, [r1, #3]
	adds r1, r2, #0
	adds r1, #0x3c
	ldrb r2, [r0, #3]
	movs r3, #0
	ands r2, r3
	adds r3, r2, #0
	adds r2, r3, #0
	orrs r2, r1
	adds r1, r2, #0
	strb r1, [r0, #3]
	ldr r1, [r7, #4]
	ldr r0, [r7, #4]
	ldr r1, [r7, #4]
	ldrb r2, [r1, #2]
	subs r1, r2, #1
	ldrb r2, [r0, #2]
	movs r3, #0
	ands r2, r3
	adds r3, r2, #0
	adds r2, r3, #0
	orrs r2, r1
	adds r1, r2, #0
	strb r1, [r0, #2]
_0200F19E:
	ldr r0, [r7, #4]
	movs r1, #2
	ldrsb r1, [r0, r1]
	cmp r1, #0
	bge _0200F1DC
	ldr r0, [r7, #4]
	ldr r1, [r7, #4]
	ldrb r2, [r1, #2]
	adds r1, r2, #0
	adds r1, #0x18
	ldrb r2, [r0, #2]
	movs r3, #0
	ands r2, r3
	adds r3, r2, #0
	adds r2, r3, #0
	orrs r2, r1
	adds r1, r2, #0
	strb r1, [r0, #2]
	ldr r1, [r7, #4]
	ldr r0, [r7, #4]
	ldr r1, [r7, #4]
	ldrh r2, [r1]
	subs r1, r2, #1
	ldrh r2, [r0]
	movs r3, #0
	ands r2, r3
	adds r3, r2, #0
	adds r2, r3, #0
	orrs r2, r1
	adds r1, r2, #0
	strh r1, [r0]
_0200F1DC:
	add sp, #0x10
	pop {r7}
	pop {r0}
	bx r0

	thumb_func_start sub_0200F1E4
sub_0200F1E4: @ 0x0200F1E4
	push {r7, lr}
	sub sp, #0xc
	mov r7, sp
	str r0, [r7]
	str r1, [r7, #4]
	str r2, [r7, #8]
	ldr r0, [r7]
	ldr r1, [r7, #8]
	ldr r2, [r7, #4]
	ldrb r1, [r1, #4]
	ldrb r2, [r2, #4]
	subs r1, r1, r2
	ldrb r2, [r0, #4]
	movs r3, #0
	ands r2, r3
	adds r3, r2, #0
	adds r2, r3, #0
	orrs r2, r1
	adds r1, r2, #0
	strb r1, [r0, #4]
	ldr r0, [r7]
	ldr r1, [r7, #8]
	ldr r2, [r7, #4]
	ldrb r1, [r1, #3]
	ldrb r2, [r2, #3]
	subs r1, r1, r2
	ldrb r2, [r0, #3]
	movs r3, #0
	ands r2, r3
	adds r3, r2, #0
	adds r2, r3, #0
	orrs r2, r1
	adds r1, r2, #0
	strb r1, [r0, #3]
	ldr r0, [r7]
	ldr r1, [r7, #8]
	ldr r2, [r7, #4]
	ldrb r1, [r1, #2]
	ldrb r2, [r2, #2]
	subs r1, r1, r2
	ldrb r2, [r0, #2]
	movs r3, #0
	ands r2, r3
	adds r3, r2, #0
	adds r2, r3, #0
	orrs r2, r1
	adds r1, r2, #0
	strb r1, [r0, #2]
	ldr r0, [r7]
	ldr r1, [r7, #8]
	ldr r2, [r7, #4]
	ldrh r1, [r1]
	ldrh r2, [r2]
	subs r1, r1, r2
	ldrh r2, [r0]
	movs r3, #0
	ands r2, r3
	adds r3, r2, #0
	adds r2, r3, #0
	orrs r2, r1
	adds r1, r2, #0
	strh r1, [r0]
	ldr r0, [r7]
	movs r1, #4
	ldrsb r1, [r0, r1]
	cmp r1, #0
	bge _0200F29E
	ldr r0, [r7]
	ldr r1, [r7]
	ldrb r2, [r1, #4]
	adds r1, r2, #0
	adds r1, #0x3c
	ldrb r2, [r0, #4]
	movs r3, #0
	ands r2, r3
	adds r3, r2, #0
	adds r2, r3, #0
	orrs r2, r1
	adds r1, r2, #0
	strb r1, [r0, #4]
	ldr r1, [r7]
	ldr r0, [r7]
	ldr r1, [r7]
	ldrb r2, [r1, #3]
	subs r1, r2, #1
	ldrb r2, [r0, #3]
	movs r3, #0
	ands r2, r3
	adds r3, r2, #0
	adds r2, r3, #0
	orrs r2, r1
	adds r1, r2, #0
	strb r1, [r0, #3]
_0200F29E:
	ldr r0, [r7]
	movs r1, #3
	ldrsb r1, [r0, r1]
	cmp r1, #0
	bge _0200F2DC
	ldr r0, [r7]
	ldr r1, [r7]
	ldrb r2, [r1, #3]
	adds r1, r2, #0
	adds r1, #0x3c
	ldrb r2, [r0, #3]
	movs r3, #0
	ands r2, r3
	adds r3, r2, #0
	adds r2, r3, #0
	orrs r2, r1
	adds r1, r2, #0
	strb r1, [r0, #3]
	ldr r1, [r7]
	ldr r0, [r7]
	ldr r1, [r7]
	ldrb r2, [r1, #2]
	subs r1, r2, #1
	ldrb r2, [r0, #2]
	movs r3, #0
	ands r2, r3
	adds r3, r2, #0
	adds r2, r3, #0
	orrs r2, r1
	adds r1, r2, #0
	strb r1, [r0, #2]
_0200F2DC:
	ldr r0, [r7]
	movs r1, #2
	ldrsb r1, [r0, r1]
	cmp r1, #0
	bge _0200F31A
	ldr r0, [r7]
	ldr r1, [r7]
	ldrb r2, [r1, #2]
	adds r1, r2, #0
	adds r1, #0x18
	ldrb r2, [r0, #2]
	movs r3, #0
	ands r2, r3
	adds r3, r2, #0
	adds r2, r3, #0
	orrs r2, r1
	adds r1, r2, #0
	strb r1, [r0, #2]
	ldr r1, [r7]
	ldr r0, [r7]
	ldr r1, [r7]
	ldrh r2, [r1]
	subs r1, r2, #1
	ldrh r2, [r0]
	movs r3, #0
	ands r2, r3
	adds r3, r2, #0
	adds r2, r3, #0
	orrs r2, r1
	adds r1, r2, #0
	strh r1, [r0]
_0200F31A:
	add sp, #0xc
	pop {r7}
	pop {r0}
	bx r0
	.align 2, 0

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
	bl sub_0200E6D0
	ldr r1, [r7, #4]
	ldrh r0, [r1]
	ldr r1, =gUnknown_02025260
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
	bl sub_0200E6D0
	ldr r0, =gUnknown_02025260
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
