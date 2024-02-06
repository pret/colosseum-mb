	.include "asm/macros/function.inc"
	.include "constants/gba_constants.inc"
	.text
	.syntax unified

	


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
