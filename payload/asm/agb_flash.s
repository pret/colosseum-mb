	.include "asm/macros/function.inc"
	.include "constants/gba_constants.inc"
	.text
	.syntax unified

	thumb_func_start SwitchFlashBank
SwitchFlashBank: @ 0x0200DA50
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

	thumb_func_start ReadFlashId
ReadFlashId: @ 0x0200DA74
	push {r4, r5, lr}
	sub sp, #0x44
	mov r0, sp
	bl SetReadFlash1
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

	thumb_func_start FlashTimerIntr
FlashTimerIntr: @ 0x0200DB10
	push {lr}
	ldr r1, =sTimerCount
	ldrh r0, [r1]
	cmp r0, #0
	beq _0200DB2C
	ldrh r0, [r1]
	subs r0, #1
	strh r0, [r1]
	lsls r0, r0, #0x10
	cmp r0, #0
	bne _0200DB2C
	ldr r1, =gFlashTimeoutFlag
	movs r0, #1
	strb r0, [r1]
_0200DB2C:
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start SetFlashTimerIntr
SetFlashTimerIntr: @ 0x0200DB38
	push {lr}
	adds r2, r1, #0
	lsls r0, r0, #0x18
	lsrs r1, r0, #0x18
	cmp r1, #3
	bhi _0200DB6C
	ldr r0, =sTimerNum
	strb r1, [r0]
	ldr r1, =sTimerReg
	ldrb r0, [r0]
	lsls r0, r0, #2
	ldr r3, =0x04000100
	adds r0, r0, r3
	str r0, [r1]
	ldr r0, =FlashTimerIntr
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

	thumb_func_start StartFlashTimer
StartFlashTimer: @ 0x0200DB74
	push {r4, r5, r6, lr}
	mov r6, sl
	mov r5, sb
	mov r4, r8
	push {r4, r5, r6}
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	ldr r1, =gFlashMaxTime
	lsls r2, r0, #1
	adds r2, r2, r0
	lsls r2, r2, #1
	ldr r0, [r1]
	adds r2, r2, r0
	ldr r1, =sSavedIme
	ldr r0, =0x04000208
	mov sb, r0
	ldrh r0, [r0]
	strh r0, [r1]
	movs r3, #0
	mov r1, sb
	strh r3, [r1]
	ldr r0, =sTimerReg
	mov r8, r0
	ldr r4, [r0]
	strh r3, [r4, #2]
	ldr r6, =0x04000200
	ldr r1, =sTimerNum
	mov sl, r1
	ldrb r1, [r1]
	movs r5, #8
	adds r0, r5, #0
	lsls r0, r1
	adds r1, r0, #0
	ldrh r0, [r6]
	orrs r0, r1
	strh r0, [r6]
	ldr r0, =gFlashTimeoutFlag
	strb r3, [r0]
	ldr r1, =sTimerCount
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

	thumb_func_start StopFlashTimer
StopFlashTimer: @ 0x0200DC1C
	ldr r3, =0x04000208
	movs r1, #0
	strh r1, [r3]
	ldr r2, =sTimerReg
	ldr r0, [r2]
	strh r1, [r0]
	adds r0, #2
	str r0, [r2]
	strh r1, [r0]
	subs r0, #2
	str r0, [r2]
	ldr r2, =0x04000200
	ldr r0, =sTimerNum
	ldrb r0, [r0]
	movs r1, #8
	lsls r1, r0
	ldrh r0, [r2]
	bics r0, r1
	strh r0, [r2]
	ldr r0, =sSavedIme
	ldrh r0, [r0]
	strh r0, [r3]
	bx lr
	.align 2, 0
	.pool

	thumb_func_start ReadFlash1
ReadFlash1: @ 0x0200DC60
	ldrb r0, [r0]
	bx lr

	thumb_func_start SetReadFlash1
SetReadFlash1: @ 0x0200DC64
	push {lr}
	adds r2, r0, #0
	ldr r1, =PollFlashStatus
	adds r0, r2, #1
	str r0, [r1]
	ldr r3, =ReadFlash1
	movs r0, #1
	eors r3, r0
	ldr r0, =SetReadFlash1
	ldr r1, =ReadFlash1
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

	thumb_func_start ReadFlash_Core
ReadFlash_Core: @ 0x0200DCA4
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

	thumb_func_start ReadFlash
ReadFlash: @ 0x0200DCC8
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
	ldr r0, =gFlashSize
	ldr r0, [r0]
	ldr r1, [r0]
	movs r0, #0x80
	lsls r0, r0, #0xa
	cmp r1, r0
	bne _0200DD00
	lsrs r0, r3, #0x14
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	bl SwitchFlashBank
	movs r0, #0xf
	ands r4, r0
_0200DD00:
	ldr r3, =ReadFlash_Core
	movs r0, #1
	eors r3, r0
	mov r2, sp
	ldr r0, =ReadFlash
	ldr r1, =ReadFlash_Core
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
	ldr r0, =gFlashSize
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

	thumb_func_start VerifyFlashSector_Core
VerifyFlashSector_Core: @ 0x0200DD64
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

	thumb_func_start VerifyFlashSector
VerifyFlashSector: @ 0x0200DD94
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
	ldr r0, =gFlashSize
	ldr r0, [r0]
	ldr r1, [r0]
	movs r0, #0x80
	lsls r0, r0, #0xa
	cmp r1, r0
	bne _0200DDC8
	lsrs r0, r3, #0x14
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	bl SwitchFlashBank
	movs r0, #0xf
	ands r4, r0
_0200DDC8:
	ldr r3, =VerifyFlashSector_Core
	movs r0, #1
	eors r3, r0
	mov r2, sp
	ldr r0, =VerifyFlashSector
	ldr r1, =VerifyFlashSector_Core
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
	ldr r0, =gFlashSize
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

	thumb_func_start VerifyFlashSectorNBytes
VerifyFlashSectorNBytes: @ 0x0200DE2C
	push {r4, r5, r6, lr}
	sub sp, #0x100
	adds r5, r1, #0
	adds r6, r2, #0
	lsls r2, r0, #0x10
	lsrs r4, r2, #0x10
	ldr r0, =gFlashSize
	ldr r0, [r0]
	ldr r1, [r0]
	movs r0, #0x80
	lsls r0, r0, #0xa
	cmp r1, r0
	bne _0200DE54
	lsrs r0, r2, #0x14
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	bl SwitchFlashBank
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
	ldr r3, =VerifyFlashSector_Core
	movs r0, #1
	eors r3, r0
	mov r2, sp
	ldr r0, =VerifyFlashSector
	ldr r1, =VerifyFlashSector_Core
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
	ldr r0, =gFlashSize
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

	thumb_func_start ProgramFlashSectorAndVerify
ProgramFlashSectorAndVerify: @ 0x0200DEC4
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
	ldr r0, =ProgramFlashSector
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
	bl VerifyFlashSector
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

	thumb_func_start ProgramFlashSectorAndVerifyNBytes
ProgramFlashSectorAndVerifyNBytes: @ 0x0200DF08
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
	ldr r0, =ProgramFlashSector
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
	bl VerifyFlashSectorNBytes
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

	.bss

sTimerNum:
	.space 0x2

sTimerCount:
	.space 0x2

sTimerReg:
	.space 0x4

sSavedIme:
	.space 0x4
