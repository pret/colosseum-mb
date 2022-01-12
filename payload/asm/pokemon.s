	.include "asm/macros/function.inc"
	.include "constants/gba_constants.inc"
	.text
	.syntax unified

	thumb_func_start GetSubstruct
GetSubstruct: @ 0x0200A8B8
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

	thumb_func_start CalculateBoxMonChecksum
CalculateBoxMonChecksum: @ 0x0200ADE0
	push {r4, r5, r6, r7, lr}
	mov r7, r8
	push {r7}
	adds r4, r0, #0
	movs r6, #0
	ldr r1, [r4]
	movs r2, #0
	bl GetSubstruct
	adds r5, r0, #0
	ldr r1, [r4]
	adds r0, r4, #0
	movs r2, #1
	bl GetSubstruct
	adds r7, r0, #0
	ldr r1, [r4]
	adds r0, r4, #0
	movs r2, #2
	bl GetSubstruct
	mov r8, r0
	ldr r1, [r4]
	adds r0, r4, #0
	movs r2, #3
	bl GetSubstruct
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

	thumb_func_start GetBoxMonData
GetBoxMonData: @ 0x0200AE74
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
	bl GetSubstruct
	mov sb, r0
	mov r0, r8
	ldr r1, [r0]
	movs r2, #1
	bl GetSubstruct
	mov sl, r0
	mov r2, r8
	ldr r1, [r2]
	mov r0, r8
	movs r2, #2
	bl GetSubstruct
	adds r7, r0, #0
	mov r3, r8
	ldr r1, [r3]
	mov r0, r8
	movs r2, #3
	bl GetSubstruct
	adds r5, r0, #0
	@ begin: DecryptBoxMon
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
	@ end: DecryptBoxMon
	mov r0, r8
	bl CalculateBoxMonChecksum
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
	ldr r1, =gText_BadEgg
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
	ldr r1, =gText_Egg
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
	bl GetStringSizeHandleExtCtrlCodes
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
	ldr r3, =gAgbPmRomParams
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
	ldr r2, =gBitTable
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
	@ begin: EncryptBoxMon
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
	@ end: EncryptBoxMon
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

	thumb_func_start GetBoxMonPalettePtr
GetBoxMonPalettePtr: @ 0x0200B4E0
	push {r4, r5, r6, r7, lr}
	mov r7, r8
	push {r7}
	movs r1, #0x64
	adds r4, r0, #0
	muls r4, r1, r4
	ldr r5, =gPlayerPartyPtr
	ldr r0, [r5]
	adds r0, r4, r0
	movs r1, #0x41
	movs r2, #0
	bl GetBoxMonData
	lsls r0, r0, #0x10
	lsrs r7, r0, #0x10
	mov r8, r7
	ldr r0, [r5]
	adds r0, r4, r0
	movs r1, #1
	movs r2, #0
	bl GetBoxMonData
	adds r6, r0, #0
	ldr r0, [r5]
	adds r4, r4, r0
	adds r0, r4, #0
	movs r1, #0
	movs r2, #0
	bl GetBoxMonData
	adds r3, r0, #0
	movs r0, #0xce
	lsls r0, r0, #1
	cmp r7, r0
	bls _0200B538
	ldr r0, =gAgbPmRomParams
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
	ldr r0, =gAgbPmRomParams
	ldr r0, [r0]
	lsls r1, r7, #3
	ldr r0, [r0, #0x34]
	b _0200B56A
	.align 2, 0
	.pool
_0200B560:
	ldr r0, =gAgbPmRomParams
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

	thumb_func_start GetBoxMonAbility
GetBoxMonAbility: @ 0x0200B57C
	push {r4, r5, r6, lr}
	adds r4, r0, #0
	ldr r0, =gAgbPmRomParams
	ldr r0, [r0]
	adds r0, #0xbc
	ldr r6, [r0]
	adds r0, r4, #0
	movs r1, #0xb
	movs r2, #0
	bl GetBoxMonData
	adds r5, r0, #0
	adds r0, r4, #0
	movs r1, #0x2e
	movs r2, #0
	bl GetBoxMonData
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

	thumb_func_start BoxMonCaughtBallToItemId
BoxMonCaughtBallToItemId: @ 0x0200B5C4
	push {lr}
	movs r1, #0x26
	movs r2, #0
	bl GetBoxMonData
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
	ldr r0, =gAgbPmRomParams
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

	thumb_func_start BoxMonGetCaughtBallItemPalette
BoxMonGetCaughtBallItemPalette: @ 0x0200B65C
	push {lr}
	movs r1, #0x26
	movs r2, #0
	bl GetBoxMonData
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
	ldr r0, =gAgbPmRomParams
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

	thumb_func_start GetBoxMonMoveBySlot
GetBoxMonMoveBySlot: @ 0x0200B6F4
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
	bl GetBoxMonData
	b _0200B724
_0200B71C:
	movs r1, #0x10
	movs r2, #0
	bl GetBoxMonData
_0200B724:
	pop {r1}
	bx r1

	thumb_func_start GetBoxMonPPByMoveSlot
GetBoxMonPPByMoveSlot: @ 0x0200B728
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
	bl GetBoxMonData
	b _0200B75E
_0200B756:
	movs r1, #0x14
	movs r2, #0
	bl GetBoxMonData
_0200B75E:
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start CheckPartyPokerus
CheckPartyPokerus: @ 0x0200B764
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
	bl GetBoxMonData
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
	bl GetBoxMonData
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

	thumb_func_start GetMonStatus
GetMonStatus: @ 0x0200B7D0
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
	bl CheckPartyPokerus
	cmp r0, #0
	bne _0200B832
	movs r0, #0
	b _0200B834
_0200B832:
	movs r0, #6
_0200B834:
	pop {r1}
	bx r1

	thumb_func_start CheckPartyHasHadPokerus
CheckPartyHasHadPokerus: @ 0x0200B838
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
	bl GetBoxMonData
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
	bl GetBoxMonData
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

	thumb_func_start DrawSpindasSpots
DrawSpindasSpots: @ 0x0200B89C
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
	ldr r0, =gRomDetection_IsRubySapphire
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
	ldr r0, =gSpindaSpotGraphics
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
	ldr r3, =gSpindaSpotGraphics + 2
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

	thumb_func_start SetBoxMonData
SetBoxMonData: @ 0x0200B9C0
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
	bl GetSubstruct
	mov sb, r0
	ldr r1, [r6]
	adds r0, r6, #0
	movs r2, #1
	bl GetSubstruct
	mov sl, r0
	ldr r1, [r6]
	adds r0, r6, #0
	movs r2, #2
	bl GetSubstruct
	adds r7, r0, #0
	ldr r1, [r6]
	adds r0, r6, #0
	movs r2, #3
	bl GetSubstruct
	adds r5, r0, #0
	@ begin: DecryptBoxMon
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
	@ end: DecryptBoxMon
	adds r0, r6, #0
	bl CalculateBoxMonChecksum
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
	@ begin: EncryptBoxMon
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
	@ end: EncryptBoxMon
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
	ldr r5, =gAgbPmRomParams
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
	ldr r5, =gAgbPmRomParams
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
	bl CalculateBoxMonChecksum
	strh r0, [r6, #0x1c]
	@ begin: EncryptBoxMon
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
	@ end: EncryptBoxMon
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

	thumb_func_start SetMonData
SetMonData: @ 0x0200C040
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
	bl SetBoxMonData
_0200C12A:
	pop {r4}
	pop {r0}
	bx r0

	thumb_func_start GiveGiftRibbonToParty
GiveGiftRibbonToParty: @ 0x0200C130
	push {r4, r5, r6, r7, lr}
	sub sp, #8
	lsls r0, r0, #0x18
	lsrs r4, r0, #0x18
	lsls r1, r1, #0x18
	lsrs r5, r1, #0x18
	movs r7, #0
	ldr r1, =gGiftRibbonMonDataIds
	mov r0, sp
	movs r2, #7
	bl memcpy
	cmp r4, #0xa
	bhi _0200C19E
	cmp r5, #0x40
	bhi _0200C19E
	cmp r4, #6
	bhi _0200C19E
	ldr r0, =gGiftRibbonsPtr
	ldr r0, [r0]
	adds r0, r0, r4
	strb r5, [r0]
	movs r5, #0
	ldr r6, =gPlayerPartyPtr
_0200C160:
	movs r0, #0x64
	adds r4, r5, #0
	muls r4, r0, r4
	ldr r0, [r6]
	adds r0, r4, r0
	movs r1, #0xb
	movs r2, #0
	bl GetBoxMonData
	cmp r0, #0
	beq _0200C188
	ldr r0, [r6]
	adds r0, r4, r0
	movs r1, #6
	movs r2, #0
	bl GetBoxMonData
	cmp r0, #0
	bne _0200C188
	movs r7, #1
_0200C188:
	adds r5, #1
	cmp r5, #5
	ble _0200C160
	cmp r7, #0
	beq _0200C19E
	ldr r0, =gAgbPmRomParams
	ldr r0, [r0]
	adds r0, #0xf0
	ldr r0, [r0]
	bl SetFlag
_0200C19E:
	add sp, #8
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start GetMonData
GetMonData: @ 0x0200C1B8
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
	bl GetBoxMonData
_0200C24E:
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start GetMonGender
GetMonGender: @ 0x0200C254
	push {r4, r5, r6, lr}
	adds r4, r0, #0
	ldr r0, =gAgbPmRomParams
	ldr r0, [r0]
	adds r0, #0xbc
	ldr r6, [r0]
	adds r0, r4, #0
	movs r1, #0xb
	movs r2, #0
	bl GetBoxMonData
	lsls r0, r0, #0x10
	lsrs r5, r0, #0x10
	adds r0, r4, #0
	movs r1, #0
	movs r2, #0
	bl GetBoxMonData
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

	thumb_func_start GetMonPalettePtrBySpeciesIdPersonality
GetMonPalettePtrBySpeciesIdPersonality: @ 0x0200C2BC
	push {r4, r5, lr}
	adds r3, r2, #0
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
	adds r5, r4, #0
	movs r0, #0xce
	lsls r0, r0, #1
	cmp r4, r0
	bls _0200C2DC
	ldr r0, =gAgbPmRomParams
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
	ldr r0, =gAgbPmRomParams
	ldr r0, [r0]
	lsls r1, r4, #3
	ldr r0, [r0, #0x30]
	b _0200C30C
	.align 2, 0
	.pool
_0200C304:
	ldr r0, =gAgbPmRomParams
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

	thumb_func_start FixUnownSpecies
FixUnownSpecies: @ 0x0200C318
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

	thumb_func_start GetSpeciesName
GetSpeciesName: @ 0x0200C378
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #4
	mov ip, r0
	adds r5, r1, #0
	ldr r0, =gAgbPmRomParams
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

	thumb_func_start GetMonType
GetMonType: @ 0x0200C3FC
	push {r4, r5, lr}
	adds r4, r1, #0
	ldr r1, =gAgbPmRomParams
	ldr r1, [r1]
	adds r1, #0xbc
	ldr r5, [r1]
	movs r1, #0xb
	movs r2, #0
	bl GetBoxMonData
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

	thumb_func_start GetMonSpritePaletteNumByBaseBlock
GetMonSpritePaletteNumByBaseBlock: @ 0x0200C440
	ldr r1, =gTypeToPaletteNumber
	adds r0, r0, r1
	ldrb r0, [r0]
	bx lr
	.align 2, 0
	.pool

	thumb_func_start GetAbilityName
GetAbilityName: @ 0x0200C44C
	adds r2, r0, #0
	ldr r0, =gAgbPmRomParams
	ldr r0, [r0]
	adds r0, #0xc0
	ldr r0, [r0]
	movs r1, #0xd
	muls r1, r2, r1
	adds r0, r0, r1
	bx lr
	.align 2, 0
	.pool

	thumb_func_start GetAbilityDescription
GetAbilityDescription: @ 0x0200C464
	ldr r1, =gAgbPmRomParams
	ldr r1, [r1]
	adds r1, #0xc4
	ldr r1, [r1]
	lsls r0, r0, #2
	adds r0, r0, r1
	ldr r0, [r0]
	bx lr
	.align 2, 0
	.pool

	thumb_func_start CalculatePPWithBonus
CalculatePPWithBonus: @ 0x0200C478
	push {r4, lr}
	ldr r3, =gAgbPmRomParams
	ldr r3, [r3]
	adds r3, #0xcc
	ldr r4, [r3]
	lsls r3, r0, #1
	adds r3, r3, r0
	lsls r3, r3, #2
	adds r3, r3, r4
	ldrb r4, [r3, #4]
	ldr r0, =gPPUpReadMasks
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

	thumb_func_start CopyMoveName
CopyMoveName: @ 0x0200C4B8
	push {r4, r5, r6, r7, lr}
	adds r3, r0, #0
	mov ip, r1
	ldr r0, =gAgbPmRomParams
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

	thumb_func_start GetPtrToEmptyPartySlot
GetPtrToEmptyPartySlot: @ 0x0200C520
	ldr r0, =gPlayerPartyCountPtr
	ldr r1, [r0]
	ldrb r0, [r1]
	cmp r0, #6
	beq _0200C540
	ldr r2, =gPlayerPartyPtr
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

	thumb_func_start GetMonGender2
GetMonGender2: @ 0x0200C544
	push {r4, r5, r6, lr}
	adds r4, r0, #0
	ldr r0, =gAgbPmRomParams
	ldr r0, [r0]
	adds r0, #0xbc
	ldr r6, [r0]
	adds r0, r4, #0
	movs r1, #0xb
	movs r2, #0
	bl GetBoxMonData
	lsls r0, r0, #0x10
	lsrs r5, r0, #0x10
	adds r0, r4, #0
	movs r1, #0
	movs r2, #0
	bl GetBoxMonData
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

	thumb_func_start GetUnownLetterByPersonality
GetUnownLetterByPersonality: @ 0x0200C5A8
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
