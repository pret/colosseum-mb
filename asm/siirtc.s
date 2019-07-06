	.include "asm/macros/function.inc"
	.text
	.syntax unified

	thumb_func_start SiiRtcUnprotect
SiiRtcUnprotect: @ 0x0200F43C
	push {r7, lr}
	mov r7, sp
	bl EnableGpioPortRead
	ldr r0, =gUnknown_020213B2
	movs r1, #0
	strb r1, [r0]
	pop {r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start SiiRtcProtect
SiiRtcProtect: @ 0x0200F454
	push {r7, lr}
	mov r7, sp
	bl DisableGpioPortRead
	ldr r0, =gUnknown_020213B2
	movs r1, #1
	strb r1, [r0]
	pop {r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start SiiRtcProbe
SiiRtcProbe: @ 0x0200F46C
	push {r7, lr}
	sub sp, #0x10
	mov r7, sp
	adds r1, r7, #4
	adds r0, r1, #0
	bl SiiRtcGetStatus
	lsls r1, r0, #0x18
	lsrs r0, r1, #0x18
	cmp r0, #0
	bne _0200F486
	movs r0, #0
	b _0200F53A
_0200F486:
	adds r0, r7, #0
	movs r1, #0
	strb r1, [r0]
	adds r0, r7, #4
	ldrb r1, [r0, #7]
	movs r2, #0xc0
	adds r0, r1, #0
	ands r0, r2
	adds r2, r0, #0
	lsls r1, r2, #0x18
	lsrs r0, r1, #0x18
	cmp r0, #0x80
	beq _0200F4B6
	adds r0, r7, #4
	ldrb r1, [r0, #7]
	movs r2, #0xc0
	adds r0, r1, #0
	ands r0, r2
	adds r2, r0, #0
	lsls r1, r2, #0x18
	lsrs r0, r1, #0x18
	cmp r0, #0
	bne _0200F4D4
	b _0200F4B6
_0200F4B6:
	bl SiiRtcReset
	lsls r1, r0, #0x18
	lsrs r0, r1, #0x18
	cmp r0, #0
	bne _0200F4C6
	movs r0, #0
	b _0200F53A
_0200F4C6:
	adds r1, r7, #0
	adds r0, r7, #0
	adds r1, r7, #0
	ldrb r2, [r1]
	adds r1, r2, #1
	adds r2, r1, #0
	strb r2, [r0]
_0200F4D4:
	adds r1, r7, #4
	adds r0, r1, #0
	bl SiiRtcGetTime
	adds r0, r7, #4
	ldrb r1, [r0, #6]
	movs r2, #0x80
	adds r0, r1, #0
	ands r0, r2
	adds r2, r0, #0
	lsls r1, r2, #0x18
	lsrs r0, r1, #0x18
	cmp r0, #0
	beq _0200F522
	bl SiiRtcReset
	lsls r1, r0, #0x18
	lsrs r0, r1, #0x18
	cmp r0, #0
	bne _0200F514
	adds r0, r7, #0
	ldrb r1, [r0]
	lsls r0, r1, #4
	adds r1, r0, #0
	movs r2, #0xf
	adds r0, r1, #0
	bics r0, r2
	adds r1, r0, #0
	lsls r0, r1, #0x18
	lsrs r1, r0, #0x18
	adds r0, r1, #0
	b _0200F53A
_0200F514:
	adds r1, r7, #0
	adds r0, r7, #0
	adds r1, r7, #0
	ldrb r2, [r1]
	adds r1, r2, #1
	adds r2, r1, #0
	strb r2, [r0]
_0200F522:
	adds r0, r7, #0
	ldrb r1, [r0]
	lsls r0, r1, #4
	adds r1, r0, #0
	movs r2, #1
	adds r0, r1, #0
	orrs r0, r2
	adds r1, r0, #0
	lsls r0, r1, #0x18
	lsrs r1, r0, #0x18
	adds r0, r1, #0
	b _0200F53A
_0200F53A:
	add sp, #0x10
	pop {r7}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start SiiRtcReset
SiiRtcReset: @ 0x0200F544
	push {r7, lr}
	sub sp, #0x10
	mov r7, sp
	ldr r0, =gUnknown_020213B2
	ldrb r1, [r0]
	cmp r1, #1
	bne _0200F55C
	movs r0, #0
	b _0200F5C0
	.align 2, 0
	.pool
_0200F55C:
	ldr r0, =gUnknown_020213B2
	movs r1, #1
	strb r1, [r0]
	ldr r0, =0x080000C4
	movs r1, #1
	strh r1, [r0]
	ldr r0, =0x080000C4
	movs r1, #5
	strh r1, [r0]
	ldr r0, =0x080000C6
	movs r1, #7
	strh r1, [r0]
	movs r0, #0x60
	bl WriteCommand
	ldr r0, =0x080000C4
	movs r1, #1
	strh r1, [r0]
	ldr r0, =0x080000C4
	movs r1, #1
	strh r1, [r0]
	ldr r0, =gUnknown_020213B2
	movs r1, #0
	strb r1, [r0]
	adds r0, r7, #4
	ldrb r1, [r0, #7]
	movs r2, #0
	ands r1, r2
	adds r2, r1, #0
	movs r3, #0x40
	adds r1, r2, #0
	orrs r1, r3
	adds r2, r1, #0
	strb r2, [r0, #7]
	adds r1, r7, #4
	adds r0, r1, #0
	bl SiiRtcSetStatus
	adds r1, r7, #0
	strb r0, [r1]
	adds r0, r7, #0
	ldrb r1, [r0]
	adds r0, r1, #0
	b _0200F5C0
	.align 2, 0
	.pool
_0200F5C0:
	add sp, #0x10
	pop {r7}
	pop {r1}
	bx r1

	thumb_func_start SiiRtcGetStatus
SiiRtcGetStatus: @ 0x0200F5C8
	push {r4, r7, lr}
	sub sp, #8
	mov r7, sp
	str r0, [r7]
	ldr r0, =gUnknown_020213B2
	ldrb r1, [r0]
	cmp r1, #1
	bne _0200F5E0
	movs r0, #0
	b _0200F68C
	.align 2, 0
	.pool
_0200F5E0:
	ldr r0, =gUnknown_020213B2
	movs r1, #1
	strb r1, [r0]
	ldr r0, =0x080000C4
	movs r1, #1
	strh r1, [r0]
	ldr r0, =0x080000C4
	movs r1, #5
	strh r1, [r0]
	ldr r0, =0x080000C6
	movs r1, #7
	strh r1, [r0]
	movs r0, #0x63
	bl WriteCommand
	ldr r0, =0x080000C6
	movs r1, #5
	strh r1, [r0]
	bl ReadData
	adds r1, r7, #4
	strb r0, [r1]
	ldr r0, [r7]
	adds r1, r7, #4
	ldrb r2, [r1]
	movs r3, #0xc0
	adds r1, r2, #0
	ands r1, r3
	adds r2, r7, #4
	ldrb r3, [r2]
	movs r4, #0x20
	adds r2, r3, #0
	ands r2, r4
	adds r4, r2, #0
	lsls r3, r4, #0x18
	lsrs r2, r3, #0x18
	lsrs r3, r2, #3
	adds r2, r3, #0
	orrs r1, r2
	adds r2, r7, #4
	ldrb r3, [r2]
	movs r4, #8
	adds r2, r3, #0
	ands r2, r4
	adds r4, r2, #0
	lsls r3, r4, #0x18
	lsrs r2, r3, #0x18
	lsrs r3, r2, #2
	adds r2, r3, #0
	orrs r1, r2
	adds r2, r7, #4
	ldrb r3, [r2]
	movs r4, #2
	adds r2, r3, #0
	ands r2, r4
	adds r4, r2, #0
	lsls r3, r4, #0x18
	lsrs r2, r3, #0x18
	lsrs r3, r2, #1
	adds r2, r3, #0
	orrs r1, r2
	ldrb r2, [r0, #7]
	movs r3, #0
	ands r2, r3
	adds r3, r2, #0
	adds r2, r3, #0
	orrs r2, r1
	adds r1, r2, #0
	strb r1, [r0, #7]
	ldr r0, =0x080000C4
	movs r1, #1
	strh r1, [r0]
	ldr r0, =0x080000C4
	movs r1, #1
	strh r1, [r0]
	ldr r0, =gUnknown_020213B2
	movs r1, #0
	strb r1, [r0]
	movs r0, #1
	b _0200F68C
	.align 2, 0
	.pool
_0200F68C:
	add sp, #8
	pop {r4, r7}
	pop {r1}
	bx r1

	thumb_func_start SiiRtcSetStatus
SiiRtcSetStatus: @ 0x0200F694
	push {r4, r7, lr}
	sub sp, #8
	mov r7, sp
	str r0, [r7]
	ldr r0, =gUnknown_020213B2
	ldrb r1, [r0]
	cmp r1, #1
	bne _0200F6AC
	movs r0, #0
	b _0200F734
	.align 2, 0
	.pool
_0200F6AC:
	ldr r0, =gUnknown_020213B2
	movs r1, #1
	strb r1, [r0]
	ldr r0, =0x080000C4
	movs r1, #1
	strh r1, [r0]
	ldr r0, =0x080000C4
	movs r1, #5
	strh r1, [r0]
	adds r0, r7, #4
	ldr r1, [r7]
	ldrb r2, [r1, #7]
	movs r3, #4
	adds r1, r2, #0
	ands r1, r3
	adds r2, r1, #0
	lsls r1, r2, #3
	ldr r2, [r7]
	ldrb r3, [r2, #7]
	movs r4, #2
	adds r2, r3, #0
	ands r2, r4
	adds r3, r2, #0
	lsls r2, r3, #2
	adds r3, r2, #0
	movs r4, #0x40
	adds r2, r3, #0
	orrs r2, r4
	orrs r1, r2
	ldr r2, [r7]
	ldrb r3, [r2, #7]
	movs r4, #1
	adds r2, r3, #0
	ands r2, r4
	adds r3, r2, #0
	lsls r2, r3, #1
	orrs r1, r2
	adds r2, r1, #0
	strb r2, [r0]
	ldr r0, =0x080000C6
	movs r1, #7
	strh r1, [r0]
	movs r0, #0x62
	bl WriteCommand
	adds r0, r7, #4
	ldrb r1, [r0]
	adds r0, r1, #0
	bl WriteData
	ldr r0, =0x080000C4
	movs r1, #1
	strh r1, [r0]
	ldr r0, =0x080000C4
	movs r1, #1
	strh r1, [r0]
	ldr r0, =gUnknown_020213B2
	movs r1, #0
	strb r1, [r0]
	movs r0, #1
	b _0200F734
	.align 2, 0
	.pool
_0200F734:
	add sp, #8
	pop {r4, r7}
	pop {r1}
	bx r1

	thumb_func_start SiiRtcGetDateTime
SiiRtcGetDateTime: @ 0x0200F73C
	push {r7, lr}
	sub sp, #8
	mov r7, sp
	str r0, [r7]
	ldr r0, =gUnknown_020213B2
	ldrb r1, [r0]
	cmp r1, #1
	bne _0200F754
	movs r0, #0
	b _0200F7E4
	.align 2, 0
	.pool
_0200F754:
	ldr r0, =gUnknown_020213B2
	movs r1, #1
	strb r1, [r0]
	ldr r0, =0x080000C4
	movs r1, #1
	strh r1, [r0]
	ldr r0, =0x080000C4
	movs r1, #5
	strh r1, [r0]
	ldr r0, =0x080000C6
	movs r1, #7
	strh r1, [r0]
	movs r0, #0x65
	bl WriteCommand
	ldr r0, =0x080000C6
	movs r1, #5
	strh r1, [r0]
	adds r0, r7, #4
	movs r1, #0
	strb r1, [r0]
_0200F77E:
	adds r0, r7, #4
	ldrb r1, [r0]
	cmp r1, #6
	bls _0200F794
	b _0200F7B2
	.align 2, 0
	.pool
_0200F794:
	bl ReadData
	adds r1, r7, #4
	ldrb r2, [r1]
	ldr r3, [r7]
	adds r1, r2, r3
	strb r0, [r1]
	adds r1, r7, #4
	adds r0, r7, #4
	adds r1, r7, #4
	ldrb r2, [r1]
	adds r1, r2, #1
	adds r2, r1, #0
	strb r2, [r0]
	b _0200F77E
_0200F7B2:
	ldr r1, [r7]
	adds r0, r1, #4
	ldr r2, [r7]
	adds r1, r2, #4
	ldrb r2, [r1]
	movs r3, #0x7f
	adds r1, r2, #0
	ands r1, r3
	adds r2, r1, #0
	strb r2, [r0]
	ldr r0, =0x080000C4
	movs r1, #1
	strh r1, [r0]
	ldr r0, =0x080000C4
	movs r1, #1
	strh r1, [r0]
	ldr r0, =gUnknown_020213B2
	movs r1, #0
	strb r1, [r0]
	movs r0, #1
	b _0200F7E4
	.align 2, 0
	.pool
_0200F7E4:
	add sp, #8
	pop {r7}
	pop {r1}
	bx r1

	thumb_func_start SiiRtcSetDateTime
SiiRtcSetDateTime: @ 0x0200F7EC
	push {r7, lr}
	sub sp, #8
	mov r7, sp
	str r0, [r7]
	ldr r0, =gUnknown_020213B2
	ldrb r1, [r0]
	cmp r1, #1
	bne _0200F804
	movs r0, #0
	b _0200F880
	.align 2, 0
	.pool
_0200F804:
	ldr r0, =gUnknown_020213B2
	movs r1, #1
	strb r1, [r0]
	ldr r0, =0x080000C4
	movs r1, #1
	strh r1, [r0]
	ldr r0, =0x080000C4
	movs r1, #5
	strh r1, [r0]
	ldr r0, =0x080000C6
	movs r1, #7
	strh r1, [r0]
	movs r0, #0x64
	bl WriteCommand
	adds r0, r7, #4
	movs r1, #0
	strb r1, [r0]
_0200F828:
	adds r0, r7, #4
	ldrb r1, [r0]
	cmp r1, #6
	bls _0200F840
	b _0200F860
	.align 2, 0
	.pool
_0200F840:
	adds r0, r7, #4
	ldrb r1, [r0]
	ldr r2, [r7]
	adds r0, r1, r2
	ldrb r1, [r0]
	adds r0, r1, #0
	bl WriteData
	adds r1, r7, #4
	adds r0, r7, #4
	adds r1, r7, #4
	ldrb r2, [r1]
	adds r1, r2, #1
	adds r2, r1, #0
	strb r2, [r0]
	b _0200F828
_0200F860:
	ldr r0, =0x080000C4
	movs r1, #1
	strh r1, [r0]
	ldr r0, =0x080000C4
	movs r1, #1
	strh r1, [r0]
	ldr r0, =gUnknown_020213B2
	movs r1, #0
	strb r1, [r0]
	movs r0, #1
	b _0200F880
	.align 2, 0
	.pool
_0200F880:
	add sp, #8
	pop {r7}
	pop {r1}
	bx r1

	thumb_func_start SiiRtcGetTime
SiiRtcGetTime: @ 0x0200F888
	push {r7, lr}
	sub sp, #8
	mov r7, sp
	str r0, [r7]
	ldr r0, =gUnknown_020213B2
	ldrb r1, [r0]
	cmp r1, #1
	bne _0200F8A0
	movs r0, #0
	b _0200F934
	.align 2, 0
	.pool
_0200F8A0:
	ldr r0, =gUnknown_020213B2
	movs r1, #1
	strb r1, [r0]
	ldr r0, =0x080000C4
	movs r1, #1
	strh r1, [r0]
	ldr r0, =0x080000C4
	movs r1, #5
	strh r1, [r0]
	ldr r0, =0x080000C6
	movs r1, #7
	strh r1, [r0]
	movs r0, #0x67
	bl WriteCommand
	ldr r0, =0x080000C6
	movs r1, #5
	strh r1, [r0]
	adds r0, r7, #4
	movs r1, #0
	strb r1, [r0]
_0200F8CA:
	adds r0, r7, #4
	ldrb r1, [r0]
	cmp r1, #2
	bls _0200F8E0
	b _0200F900
	.align 2, 0
	.pool
_0200F8E0:
	bl ReadData
	adds r1, r7, #4
	ldrb r2, [r1]
	ldr r3, [r7]
	adds r1, r2, r3
	adds r2, r1, #4
	strb r0, [r2]
	adds r1, r7, #4
	adds r0, r7, #4
	adds r1, r7, #4
	ldrb r2, [r1]
	adds r1, r2, #1
	adds r2, r1, #0
	strb r2, [r0]
	b _0200F8CA
_0200F900:
	ldr r1, [r7]
	adds r0, r1, #4
	ldr r2, [r7]
	adds r1, r2, #4
	ldrb r2, [r1]
	movs r3, #0x7f
	adds r1, r2, #0
	ands r1, r3
	adds r2, r1, #0
	strb r2, [r0]
	ldr r0, =0x080000C4
	movs r1, #1
	strh r1, [r0]
	ldr r0, =0x080000C4
	movs r1, #1
	strh r1, [r0]
	ldr r0, =gUnknown_020213B2
	movs r1, #0
	strb r1, [r0]
	movs r0, #1
	b _0200F934
	.align 2, 0
	.pool
_0200F934:
	add sp, #8
	pop {r7}
	pop {r1}
	bx r1

	thumb_func_start SiiRtcSetTime
SiiRtcSetTime: @ 0x0200F93C
	push {r7, lr}
	sub sp, #8
	mov r7, sp
	str r0, [r7]
	ldr r0, =gUnknown_020213B2
	ldrb r1, [r0]
	cmp r1, #1
	bne _0200F954
	movs r0, #0
	b _0200F9D0
	.align 2, 0
	.pool
_0200F954:
	ldr r0, =gUnknown_020213B2
	movs r1, #1
	strb r1, [r0]
	ldr r0, =0x080000C4
	movs r1, #1
	strh r1, [r0]
	ldr r0, =0x080000C4
	movs r1, #5
	strh r1, [r0]
	ldr r0, =0x080000C6
	movs r1, #7
	strh r1, [r0]
	movs r0, #0x66
	bl WriteCommand
	adds r0, r7, #4
	movs r1, #0
	strb r1, [r0]
_0200F978:
	adds r0, r7, #4
	ldrb r1, [r0]
	cmp r1, #2
	bls _0200F990
	b _0200F9B2
	.align 2, 0
	.pool
_0200F990:
	adds r0, r7, #4
	ldrb r1, [r0]
	ldr r2, [r7]
	adds r0, r1, r2
	adds r1, r0, #4
	ldrb r2, [r1]
	adds r0, r2, #0
	bl WriteData
	adds r1, r7, #4
	adds r0, r7, #4
	adds r1, r7, #4
	ldrb r2, [r1]
	adds r1, r2, #1
	adds r2, r1, #0
	strb r2, [r0]
	b _0200F978
_0200F9B2:
	ldr r0, =0x080000C4
	movs r1, #1
	strh r1, [r0]
	ldr r0, =0x080000C4
	movs r1, #1
	strh r1, [r0]
	ldr r0, =gUnknown_020213B2
	movs r1, #0
	strb r1, [r0]
	movs r0, #1
	b _0200F9D0
	.align 2, 0
	.pool
_0200F9D0:
	add sp, #8
	pop {r7}
	pop {r1}
	bx r1

	thumb_func_start SiiRtcSetAlarm
SiiRtcSetAlarm: @ 0x0200F9D8
	push {r4, r7, lr}
	sub sp, #0xc
	mov r7, sp
	str r0, [r7]
	ldr r0, =gUnknown_020213B2
	ldrb r1, [r0]
	cmp r1, #1
	bne _0200F9F0
	movs r0, #0
	b _0200FB04
	.align 2, 0
	.pool
_0200F9F0:
	ldr r0, =gUnknown_020213B2
	movs r1, #1
	strb r1, [r0]
	adds r0, r7, #0
	adds r0, #8
	ldr r1, [r7]
	ldrb r2, [r1, #8]
	movs r3, #0xf
	adds r1, r2, #0
	ands r1, r3
	ldr r2, [r7]
	ldrb r3, [r2, #8]
	lsrs r2, r3, #4
	adds r3, r2, #0
	movs r4, #0xf
	adds r2, r3, #0
	ands r2, r4
	adds r4, r2, #0
	lsls r3, r4, #0x18
	lsrs r2, r3, #0x18
	adds r4, r2, #0
	lsls r3, r4, #2
	adds r3, r3, r2
	lsls r2, r3, #1
	adds r1, r1, r2
	ldrb r2, [r0]
	movs r3, #0
	ands r2, r3
	adds r3, r2, #0
	adds r2, r3, #0
	orrs r2, r1
	adds r1, r2, #0
	strb r1, [r0]
	adds r0, r7, #0
	adds r0, #8
	ldrb r1, [r0]
	cmp r1, #0xb
	bhi _0200FA5C
	adds r0, r7, #0
	adds r0, #8
	ldr r1, [r7]
	ldrb r2, [r0]
	movs r3, #0
	ands r2, r3
	adds r3, r2, #0
	ldrb r1, [r1, #8]
	adds r2, r3, #0
	orrs r2, r1
	adds r1, r2, #0
	strb r1, [r0]
	b _0200FA7A
	.align 2, 0
	.pool
_0200FA5C:
	adds r0, r7, #0
	adds r0, #8
	ldr r1, [r7]
	ldrb r2, [r1, #8]
	movs r3, #0x80
	adds r1, r2, #0
	orrs r1, r3
	ldrb r2, [r0]
	movs r3, #0
	ands r2, r3
	adds r3, r2, #0
	adds r2, r3, #0
	orrs r2, r1
	adds r1, r2, #0
	strb r1, [r0]
_0200FA7A:
	adds r0, r7, #0
	adds r0, #8
	ldr r1, [r7]
	ldrb r2, [r0, #1]
	movs r3, #0
	ands r2, r3
	adds r3, r2, #0
	ldrb r1, [r1, #9]
	adds r2, r3, #0
	orrs r2, r1
	adds r1, r2, #0
	strb r1, [r0, #1]
	ldr r0, =0x080000C4
	movs r1, #1
	strh r1, [r0]
	ldr r0, =0x080000C4
	movs r1, #5
	strh r1, [r0]
	ldr r0, =0x080000C6
	movs r1, #7
	strh r1, [r0]
	movs r0, #0x68
	bl WriteCommand
	adds r0, r7, #4
	movs r1, #0
	strb r1, [r0]
_0200FAB0:
	adds r0, r7, #4
	ldrb r1, [r0]
	cmp r1, #1
	bls _0200FAC4
	b _0200FAE6
	.align 2, 0
	.pool
_0200FAC4:
	adds r0, r7, #0
	adds r0, #8
	adds r1, r7, #4
	ldrb r2, [r1]
	adds r0, r0, r2
	ldrb r1, [r0]
	adds r0, r1, #0
	bl WriteData
	adds r1, r7, #4
	adds r0, r7, #4
	adds r1, r7, #4
	ldrb r2, [r1]
	adds r1, r2, #1
	adds r2, r1, #0
	strb r2, [r0]
	b _0200FAB0
_0200FAE6:
	ldr r0, =0x080000C4
	movs r1, #1
	strh r1, [r0]
	ldr r0, =0x080000C4
	movs r1, #1
	strh r1, [r0]
	ldr r0, =gUnknown_020213B2
	movs r1, #0
	strb r1, [r0]
	movs r0, #1
	b _0200FB04
	.align 2, 0
	.pool
_0200FB04:
	add sp, #0xc
	pop {r4, r7}
	pop {r1}
	bx r1

	thumb_func_start WriteCommand
WriteCommand: @ 0x0200FB0C
	push {r4, r5, r7, lr}
	sub sp, #4
	mov r7, sp
	adds r1, r0, #0
	adds r2, r7, #0
	strb r1, [r2]
	adds r1, r7, #1
	movs r2, #0
	strb r2, [r1]
_0200FB1E:
	adds r1, r7, #1
	ldrb r2, [r1]
	cmp r2, #7
	bls _0200FB28
	b _0200FBA8
_0200FB28:
	adds r1, r7, #2
	adds r3, r7, #0
	ldrb r2, [r3]
	adds r3, r7, #1
	ldrb r4, [r3]
	movs r5, #7
	subs r3, r5, r4
	asrs r2, r3
	adds r3, r2, #0
	movs r4, #1
	adds r2, r3, #0
	ands r2, r4
	adds r3, r2, #0
	strb r3, [r1]
	ldr r1, =0x080000C4
	adds r2, r7, #2
	ldrb r3, [r2]
	adds r2, r3, #0
	lsls r3, r2, #1
	adds r2, r3, #0
	movs r3, #4
	orrs r2, r3
	adds r3, r2, #0
	strh r3, [r1]
	ldr r1, =0x080000C4
	adds r2, r7, #2
	ldrb r3, [r2]
	adds r2, r3, #0
	lsls r3, r2, #1
	adds r2, r3, #0
	movs r3, #4
	orrs r2, r3
	adds r3, r2, #0
	strh r3, [r1]
	ldr r1, =0x080000C4
	adds r2, r7, #2
	ldrb r3, [r2]
	adds r2, r3, #0
	lsls r3, r2, #1
	adds r2, r3, #0
	movs r3, #4
	orrs r2, r3
	adds r3, r2, #0
	strh r3, [r1]
	ldr r1, =0x080000C4
	adds r2, r7, #2
	ldrb r3, [r2]
	adds r2, r3, #0
	lsls r3, r2, #1
	adds r2, r3, #0
	movs r3, #5
	orrs r2, r3
	adds r3, r2, #0
	strh r3, [r1]
	adds r2, r7, #1
	adds r1, r7, #1
	adds r2, r7, #1
	ldrb r3, [r2]
	adds r2, r3, #1
	adds r3, r2, #0
	strb r3, [r1]
	b _0200FB1E
	.align 2, 0
	.pool
_0200FBA8:
	add sp, #4
	pop {r4, r5, r7}
	pop {r1}
	bx r1

	thumb_func_start WriteData
WriteData: @ 0x0200FBB0
	push {r4, r7, lr}
	sub sp, #4
	mov r7, sp
	adds r1, r0, #0
	adds r2, r7, #0
	strb r1, [r2]
	adds r1, r7, #1
	movs r2, #0
	strb r2, [r1]
_0200FBC2:
	adds r1, r7, #1
	ldrb r2, [r1]
	cmp r2, #7
	bls _0200FBCC
	b _0200FC48
_0200FBCC:
	adds r1, r7, #2
	adds r3, r7, #0
	ldrb r2, [r3]
	adds r3, r7, #1
	ldrb r4, [r3]
	asrs r2, r4
	adds r3, r2, #0
	movs r4, #1
	adds r2, r3, #0
	ands r2, r4
	adds r3, r2, #0
	strb r3, [r1]
	ldr r1, =0x080000C4
	adds r2, r7, #2
	ldrb r3, [r2]
	adds r2, r3, #0
	lsls r3, r2, #1
	adds r2, r3, #0
	movs r3, #4
	orrs r2, r3
	adds r3, r2, #0
	strh r3, [r1]
	ldr r1, =0x080000C4
	adds r2, r7, #2
	ldrb r3, [r2]
	adds r2, r3, #0
	lsls r3, r2, #1
	adds r2, r3, #0
	movs r3, #4
	orrs r2, r3
	adds r3, r2, #0
	strh r3, [r1]
	ldr r1, =0x080000C4
	adds r2, r7, #2
	ldrb r3, [r2]
	adds r2, r3, #0
	lsls r3, r2, #1
	adds r2, r3, #0
	movs r3, #4
	orrs r2, r3
	adds r3, r2, #0
	strh r3, [r1]
	ldr r1, =0x080000C4
	adds r2, r7, #2
	ldrb r3, [r2]
	adds r2, r3, #0
	lsls r3, r2, #1
	adds r2, r3, #0
	movs r3, #5
	orrs r2, r3
	adds r3, r2, #0
	strh r3, [r1]
	adds r2, r7, #1
	adds r1, r7, #1
	adds r2, r7, #1
	ldrb r3, [r2]
	adds r2, r3, #1
	adds r3, r2, #0
	strb r3, [r1]
	b _0200FBC2
	.align 2, 0
	.pool
_0200FC48:
	add sp, #4
	pop {r4, r7}
	pop {r1}
	bx r1

	thumb_func_start ReadData
ReadData: @ 0x0200FC50
	push {r7, lr}
	sub sp, #4
	mov r7, sp
	adds r0, r7, #0
	movs r1, #0
	strb r1, [r0]
_0200FC5C:
	adds r0, r7, #0
	ldrb r1, [r0]
	cmp r1, #7
	bls _0200FC66
	b _0200FCCC
_0200FC66:
	ldr r0, =0x080000C4
	movs r1, #4
	strh r1, [r0]
	ldr r0, =0x080000C4
	movs r1, #4
	strh r1, [r0]
	ldr r0, =0x080000C4
	movs r1, #4
	strh r1, [r0]
	ldr r0, =0x080000C4
	movs r1, #4
	strh r1, [r0]
	ldr r0, =0x080000C4
	movs r1, #4
	strh r1, [r0]
	ldr r0, =0x080000C4
	movs r1, #5
	strh r1, [r0]
	adds r0, r7, #1
	ldr r1, =0x080000C4
	ldrh r2, [r1]
	movs r3, #2
	adds r1, r2, #0
	ands r1, r3
	adds r3, r1, #0
	lsls r2, r3, #0x10
	lsrs r1, r2, #0x10
	lsrs r2, r1, #1
	adds r1, r2, #0
	strb r1, [r0]
	adds r0, r7, #2
	adds r1, r7, #2
	ldrb r2, [r1]
	lsrs r1, r2, #1
	adds r2, r7, #1
	ldrb r3, [r2]
	lsls r2, r3, #7
	orrs r1, r2
	adds r2, r1, #0
	strb r2, [r0]
	adds r1, r7, #0
	adds r0, r7, #0
	adds r1, r7, #0
	ldrb r2, [r1]
	adds r1, r2, #1
	adds r2, r1, #0
	strb r2, [r0]
	b _0200FC5C
	.align 2, 0
	.pool
_0200FCCC:
	adds r0, r7, #2
	ldrb r1, [r0]
	adds r0, r1, #0
	b _0200FCD4
_0200FCD4:
	add sp, #4
	pop {r7}
	pop {r1}
	bx r1

	thumb_func_start EnableGpioPortRead
EnableGpioPortRead: @ 0x0200FCDC
	push {r7, lr}
	mov r7, sp
	ldr r0, =0x080000C8
	movs r1, #1
	strh r1, [r0]
	pop {r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start DisableGpioPortRead
DisableGpioPortRead: @ 0x0200FCF0
	push {r7, lr}
	mov r7, sp
	ldr r0, =0x080000C8
	movs r1, #0
	strh r1, [r0]
	pop {r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
