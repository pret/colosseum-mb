	.include "asm/macros/function.inc"
	.include "constants/gba_constants.inc"
	.text
	.syntax unified

	thumb_func_start SpeciesToNationalDexNum
SpeciesToNationalDexNum: @ 0x0200C920
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
	ldr r0, =gSpeciesToNationalPokedexNum
	lsls r1, r1, #1
	adds r1, r1, r0
	ldrh r0, [r1]
_0200C944:
	bx lr
	.align 2, 0
	.pool

	thumb_func_start SetSpeciesCaughtFlag
SetSpeciesCaughtFlag: @ 0x0200C94C
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
	ldr r1, =gSpeciesToNationalPokedexNum
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
	bl GetSetPokedexFlag
	cmp r0, #0
	bne _0200C9A2
	@ Unown
	cmp r4, #0xc9
	bne _0200C992
	ldr r0, =gPokedexPtr
	ldr r1, [r0]
	ldr r0, [r6]
	str r0, [r1, #4]
_0200C992:
	@ Spinda
	movs r0, #0x9a
	lsls r0, r0, #1
	cmp r4, r0
	bne _0200C9A2
	ldr r0, =gPokedexPtr
	ldr r1, [r0]
	ldr r0, [r6]
	str r0, [r1, #8]
_0200C9A2:
	adds r4, r5, #0
	adds r0, r4, #0
	movs r1, #2
	bl GetSetPokedexFlag
	adds r0, r4, #0
	movs r1, #3
	bl GetSetPokedexFlag
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
	ldr r0, =gAgbPmRomParams
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
	bl GetPlayerMapType
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
	bl IsFRLG
	ands r0, r4
	lsls r0, r0, #2
	movs r1, #5
	rsbs r1, r1, #0
	ldrb r2, [r7]
	ands r1, r2
	orrs r1, r0
	strb r1, [r7]
	bl GetPlayerMapType
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
	ldr r0, =gPlayerPartyPtr
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
	ldr r3, =gGiftRibbonsPtr
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

	thumb_func_start SetFlag
SetFlag: @ 0x0200CB60
	adds r2, r0, #0
	cmp r2, #0
	beq _0200CB88
	ldr r0, =gFlagsPtr
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
	ldr r2, =gFlagsPtr
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
	ldr r2, =gFlagsPtr
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

	thumb_func_start DetectROM
DetectROM: @ 0x0200CBF8
	push {r4, r5, lr}
	ldr r2, =gRomDetection_IsRubySapphire
	movs r0, #0
	strb r0, [r2]
	ldr r1, =gRomDetection_IsEnglishROM
	strb r0, [r1]
	movs r4, #0
	ldr r0, =0x080000AC
	ldr r3, [r0]
	ldr r0, =0x46505841 @ AXPF
	adds r5, r1, #0
	cmp r3, r0
	beq _0200CCA8
	cmp r3, r0
	bhi _0200CC54
	ldr r0, =0x44565841 @ AXVD
	cmp r3, r0
	beq _0200CCA8
	cmp r3, r0
	bhi _0200CC3C
	ldr r0, =0x44505841 @ AXPD
	b _0200CC7C
	.align 2, 0
	.pool
_0200CC3C:
	ldr r0, =0x45505841 @ AXPE
	cmp r3, r0
	beq _0200CC9C
	ldr r0, =0x45565841 @ AXVE
	cmp r3, r0
	beq _0200CC90
	b _0200CC80
	.align 2, 0
	.pool
_0200CC54:
	ldr r0, =0x49565841 @ AXVI
	cmp r3, r0
	beq _0200CCA8
	cmp r3, r0
	bhi _0200CC74
	ldr r0, =0x46565841 @ AXVF
	cmp r3, r0
	beq _0200CCA8
	ldr r0, =0x49505841 @ AXPI
	b _0200CC7C
	.align 2, 0
	.pool
_0200CC74:
	ldr r0, =0x53505841 @ AXPS
	cmp r3, r0
	beq _0200CCA8
	ldr r0, =0x53565841 @ AXVS
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
	ldr r1, =gAgbPmRomParams
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
	ldr r1, =gAgbPmRomParams
	ldr r0, =gAgbPmRomParams_AXVE_rev0
	b _0200CD10
	.align 2, 0
	.pool
_0200CCE0:
	ldr r1, =gAgbPmRomParams
	ldr r0, =gAgbPmRomParams_AXVE_rev2
	b _0200CD10
	.align 2, 0
	.pool
_0200CCF0:
	ldr r0, =0x080000BC
	ldrb r0, [r0]
	cmp r0, #0
	bne _0200CD0C
	ldr r1, =gAgbPmRomParams
	ldr r0, =gAgbPmRomParams_AXPE_rev0
	b _0200CD10
	.align 2, 0
	.pool
_0200CD0C:
	ldr r1, =gAgbPmRomParams
	ldr r0, =gAgbPmRomParams_AXPE_rev2
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

	thumb_func_start GetPlayerMapType
GetPlayerMapType: @ 0x0200CD38
	push {lr}
	ldr r0, =gRomDetection_IsRubySapphire
	ldrb r0, [r0]
	cmp r0, #0
	bne _0200CD60
	ldr r0, =gAgbPmRomParams
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
	ldr r0, =gSaveBlock1Ptr
	ldr r0, [r0]
	bl USRom_GetPlayerMapType
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
	ldr r0, =gRomDetection_IsRubySapphire
	ldrb r0, [r0]
	cmp r0, #0
	bne _0200CDB4
	ldr r0, =gAgbPmRomParams
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

	thumb_func_start IsFRLG
IsFRLG: @ 0x0200CDD0
	ldr r0, =gAgbPmRomParams
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

	thumb_func_start CheckGameClear
CheckGameClear: @ 0x0200CDE8
	ldr r1, =gSaveBlock1Ptr
	ldr r0, =gAgbPmRomParams
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

	thumb_func_start GetStringSizeHandleExtCtrlCodes
GetStringSizeHandleExtCtrlCodes: @ 0x0200CE1C
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
	bl ExtCtrlCodeGetLength
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

	thumb_func_start ExtCtrlCodeGetLength
ExtCtrlCodeGetLength: @ 0x0200CEC0
	lsls r0, r0, #0x18
	lsrs r1, r0, #0x18
	movs r0, #0
	cmp r1, #0x16
	bhi _0200CED0
	ldr r0, =gExtCtrlCodeLengths
	adds r0, r1, r0
	ldrb r0, [r0]
_0200CED0:
	bx lr
	.align 2, 0
	.pool

	thumb_func_start USRom_GetPlayerMapType
USRom_GetPlayerMapType: @ 0x0200CED8
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
	ldr r2, =gRSPokemonCenterMaps
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
	ldr r2, =gRSSpecialAreaMaps
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
	ldr r4, =gPlayerPartyPtr
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
	ldr r0, =gUnknown_02024960 + 0x81C
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
	ldr r1, =gSaveBlock1Ptr
	ldr r0, =gAgbPmRomParams
	ldr r0, [r0]
	adds r0, #0xb4
	ldr r1, [r1]
	ldr r0, [r0]
	adds r6, r1, r0
	ldr r5, =gUnknown_02024960 + 0x868
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
	ldr r0, =gPcItemsPtr
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
	bl GetPtrToEmptyPartySlot
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
	ldr r0, =gUnknown_02024960 + 0x85C
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
	ldr r0, =gHeldKeys
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
	ldr r1, =gSaveBlock1Ptr
	ldr r2, =gAgbPmRomParams
	ldr r0, [r2]
	adds r0, #0xb4
	ldr r1, [r1]
	ldr r0, [r0]
	adds r6, r1, r0
	ldr r5, =gUnknown_02024960 + 0x868
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
	bl CheckGameClear
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
	ldr r0, =gPlayerPartyCountPtr
	ldr r0, [r0]
	ldrb r0, [r0]
	lsls r1, r0, #0x10
	ldr r0, [r4, #4]
	orrs r1, r0
	ldr r0, =0x04000154
	str r1, [r0]
	ldr r0, =gPcItemsPtr
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
