	.include "asm/macros/function.inc"
	.include "constants/gba_constants.inc"
	.text
	.syntax unified

	arm_func_start _start
_start: @ 0x02000000
	b _init
	.global RomHeaderNintendoLogo
RomHeaderNintendoLogo:
	.space 156

RomHeaderGameTitle:
	.space 12

	.global RomHeaderGameCode
RomHeaderGameCode:
	.space 4

RomHeaderMakerCode:
	.space 2

RomHeaderMagic:
	.byte 0

RomHeaderMainUnitCode:
	.byte 0

RomHeaderDeviceType:
	.byte 0

RomHeaderReserved1:
	.space 7

	.global RomHeaderSoftwareVersion
RomHeaderSoftwareVersion:
	.byte 0

RomHeaderChecksum:
	.byte 0

RomHeaderReserved2:
	.space 2
_init:
	mov r0, #0x12
	msr cpsr_fc, r0
	ldr sp, _020000F8 @=0x03007fa0
	mov r0, #0x1f
	msr cpsr_fc, r0
	ldr sp, _020000F4 @=0x03007e60
	ldr r1, _020000FC @=INTR_VECTOR
	adr r0, _intr
	str r0, [r1]
	ldr r1, _02000100 @=AgbMain
	mov lr, pc
	bx r1
	b _init
	.align 2, 0

_020000F4: .4byte 0x03007e60
_020000F8: .4byte 0x03007fa0
_020000FC: .4byte INTR_VECTOR
_02000100: .4byte AgbMain

	arm_func_start _intr
_intr: @ 0x02000104
	mov r3, #0x4000000
	add r3, r3, #0x200
	ldr r2, [r3]
	ldrh r1, [r3, #8]
	mrs r0, spsr
	push {r0, r1, r2, r3, lr}
	mov r0, #1
	strh r0, [r3, #8]
	and r1, r2, r2, lsr #16
	mov ip, #0
	ands r0, r1, #0x80
	bne _020001D4
	add ip, ip, #4
	ands r0, r1, #1
	bne _020001D4
	add ip, ip, #4
	ands r0, r1, #2
	bne _020001D4
	add ip, ip, #4
	ands r0, r1, #4
	bne _020001D4
	add ip, ip, #4
	ands r0, r1, #8
	bne _020001D4
	add ip, ip, #4
	ands r0, r1, #0x10
	bne _020001D4
	add ip, ip, #4
	ands r0, r1, #0x20
	bne _020001D4
	add ip, ip, #4
	ands r0, r1, #0x40
	bne _020001D4
	add ip, ip, #4
	ands r0, r1, #0x100
	bne _020001D4
	add ip, ip, #4
	ands r0, r1, #0x200
	bne _020001D4
	add ip, ip, #4
	ands r0, r1, #0x400
	bne _020001D4
	add ip, ip, #4
	ands r0, r1, #0x800
	bne _020001D4
	add ip, ip, #4
	ands r0, r1, #0x1000
	bne _020001D4
	add ip, ip, #4
	ands r0, r1, #0x2000
	strbne r0, [r3, #-0x17c]
_020001D0:
	bne _020001D0
_020001D4:
	strh r0, [r3, #2]
	mov r1, #0x20c0
	bic r2, r2, r0
	and r1, r1, r2
	strh r1, [r3]
	mrs r3, apsr
	bic r3, r3, #0xdf
	orr r3, r3, #0x1f
	msr cpsr_fc, r3
	ldr r1, =gIntrTableTemplate
	add r1, r1, ip
	ldr r0, [r1]
	stmdb sp!, {lr}
	adr lr, _intr_ret
	bx r0
_intr_ret: @ 0x02000210
	ldm sp!, {lr}
	mrs r3, apsr
	bic r3, r3, #0xdf
	orr r3, r3, #0x92
	msr cpsr_fc, r3
	pop {r0, r1, r2, r3, lr}
	strh r2, [r3]
	strh r1, [r3, #8]
	msr spsr_fc, r0
	bx lr
	.align 2, 0
	.pool
