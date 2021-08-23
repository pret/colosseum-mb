	.include "asm/macros/function.inc"
	.include "constants/gba_constants.inc"
	.text
	.syntax unified

	.section .rodata

	.align 2, 0
AgbLibFlashVersion: @ 0x0201F170
	.asciz "FLASH1M_V103"

	.align 2, 0
sSetupInfos:
	.4byte MX29L010
	.4byte LE26FV10N1TS
	.4byte DefaultFlash

	.text

	thumb_func_start IdentifyFlash
IdentifyFlash: @ 0x0200DF50
	push {r4, lr}
	ldr r2, =0x04000204
	ldrh r0, [r2]
	ldr r1, =0x0000FFFC
	ands r0, r1
	movs r1, #3
	orrs r0, r1
	strh r0, [r2]
	bl ReadFlashId
	lsls r0, r0, #0x10
	lsrs r3, r0, #0x10
	ldr r2, =sSetupInfos
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
	ldr r1, =ProgramFlashByte
	ldr r0, [r2]
	ldr r0, [r0]
	str r0, [r1]
	ldr r1, =ProgramFlashSector
	ldr r0, [r2]
	ldr r0, [r0, #4]
	str r0, [r1]
	ldr r1, =EraseFlashChip
	ldr r0, [r2]
	ldr r0, [r0, #8]
	str r0, [r1]
	ldr r1, =EraseFlashSector
	ldr r0, [r2]
	ldr r0, [r0, #0xc]
	str r0, [r1]
	ldr r1, =WaitForFlashWrite
	ldr r0, [r2]
	ldr r0, [r0, #0x10]
	str r0, [r1]
	ldr r1, =gFlashMaxTime
	ldr r0, [r2]
	ldr r0, [r0, #0x14]
	str r0, [r1]
	ldr r1, =gFlashSize
	ldr r0, [r2]
	adds r0, #0x18
	str r0, [r1]
	adds r0, r4, #0
	pop {r4}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	.section .rodata
	.align 2, 0

	.4byte sSetupInfos
	.4byte ProgramFlashByte
	.4byte ProgramFlashSector
	.4byte EraseFlashChip
	.4byte EraseFlashSector
	.4byte WaitForFlashWrite
	.4byte gFlashMaxTime
	.4byte gFlashSize

	.text

	thumb_func_start WaitForFlashWrite_Common
WaitForFlashWrite_Common: @ 0x0200DFF0
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
	bl StartFlashTimer
	ldr r6, =PollFlashStatus
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
	ldr r0, =gFlashTimeoutFlag
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
	bl StopFlashTimer
	mov r0, r8
	pop {r3, r4}
	mov r8, r3
	mov sb, r4
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0

	.section .rodata
	.align 2, 0

	.4byte PollFlashStatus
	.4byte gFlashTimeoutFlag
