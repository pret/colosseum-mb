	.include "asm/macros/function.inc"
	.include "constants/gba_constants.inc"
	.text
	.syntax unified

	.section .rodata
	.align 2, 0

mxMaxTime:
	.2byte 0x000a, 0xffbd, 0x00c2
	.2byte 0x000a, 0xffbd, 0x00c2
	.2byte 0x07d0, 0xffbd, 0x00c2
	.2byte 0x07d0, 0xffbd, 0x00c2

	.global MX29L010
MX29L010:
	.4byte ProgramFlashByte_MX
	.4byte ProgramFlashSector_MX
	.4byte EraseFlashChip_MX
	.4byte EraseFlashSector_MX
	.4byte WaitForFlashWrite_Common
	.4byte mxMaxTime
	.4byte 0x00020000
	.4byte 0x00001000
	.4byte 0x0020000c
	.4byte 0x00000000
	.4byte 0x00010003
	.4byte 0x000009c2

	.global DefaultFlash
DefaultFlash:
	.4byte ProgramFlashByte_MX
	.4byte ProgramFlashSector_MX
	.4byte EraseFlashChip_MX
	.4byte EraseFlashSector_MX
	.4byte WaitForFlashWrite_Common
	.4byte mxMaxTime
	.4byte 0x00020000
	.4byte 0x00001000
	.4byte 0x0020000c
	.4byte 0x00000000
	.4byte 0x00010003
	.4byte 0x00000000

	.text

	thumb_func_start EraseFlashChip_MX
EraseFlashChip_MX: @ 0x0200E090
	push {r4, r5, r6, lr}
	sub sp, #0x40
	ldr r5, =0x04000204
	ldrh r1, [r5]
	ldr r6, =0x0000FFFC
	ands r1, r6
	ldr r0, =gFlashSize
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
	bl SetReadFlash1
	ldr r0, =WaitForFlashWrite
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

	.section .rodata
	.align 2, 0

	.4byte gFlashSize
	.4byte WaitForFlashWrite

	.text

	thumb_func_start EraseFlashSector_MX
EraseFlashSector_MX: @ 0x0200E104
	push {r4, r5, r6, r7, lr}
	sub sp, #0x40
	lsls r0, r0, #0x10
	lsrs r6, r0, #0x10
	ldr r0, =gFlashSize
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
	bl SwitchFlashBank
	movs r0, #0xf
	ands r6, r0
	movs r7, #0
_0200E134:
	ldr r3, =0x04000204
	ldrh r1, [r3]
	ldr r0, =0x0000FFFC
	ands r1, r0
	ldr r0, =gFlashSize
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
	bl SetReadFlash1
	ldr r0, =WaitForFlashWrite
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

	.section .rodata
	.align 2, 0

	.4byte gFlashSize
	.4byte WaitForFlashWrite

	.text

	thumb_func_start ProgramFlashByte_MX
ProgramFlashByte_MX: @ 0x0200E1D4
	push {r4, r5, r6, r7, lr}
	sub sp, #0x40
	adds r6, r1, #0
	lsls r1, r0, #0x10
	lsrs r4, r1, #0x10
	lsls r2, r2, #0x18
	lsrs r7, r2, #0x18
	ldr r5, =gFlashSize
	ldr r0, [r5]
	ldr r0, [r0, #4]
	cmp r6, r0
	bhs _0200E25C
	lsrs r0, r1, #0x14
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	bl SwitchFlashBank
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
	bl SetReadFlash1
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
	ldr r0, =WaitForFlashWrite
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

	.section .rodata
	.align 2, 0

	.4byte gFlashSize
	.4byte WaitForFlashWrite

	.text

	thumb_func_start ProgramByte
ProgramByte: @ 0x0200E268
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
	ldr r3, =WaitForFlashWrite
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

	.section .rodata
	.align 2, 0

	.4byte WaitForFlashWrite

	.text

	thumb_func_start ProgramFlashSector_MX
ProgramFlashSector_MX: @ 0x0200E2A0
	push {r4, r5, r6, r7, lr}
	sub sp, #0x40
	adds r7, r1, #0
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
	ldr r0, =gFlashSize
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
	bl EraseFlashSector_MX
	lsls r0, r0, #0x10
	lsrs r5, r0, #0x10
	cmp r5, #0
	bne _0200E338
	lsrs r0, r4, #4
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	bl SwitchFlashBank
	movs r0, #0xf
	ands r4, r0
	mov r0, sp
	bl SetReadFlash1
	ldr r3, =0x04000204
	ldrh r1, [r3]
	ldr r0, =0x0000FFFC
	ands r1, r0
	ldr r0, =gFlashSize
	ldr r2, [r0]
	ldrh r0, [r2, #0x10]
	orrs r1, r0
	strh r1, [r3]
	ldr r1, =gFlashRemainingBytes
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
	bl ProgramByte
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

	.section .rodata
	.align 2, 0

	.4byte gFlashSize
	.4byte gFlashRemainingBytes
