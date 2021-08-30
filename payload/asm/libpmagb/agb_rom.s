	.include "asm/macros/function.inc"
	.include "constants/gba_constants.inc"
	.text
	.syntax unified

	thumb_func_start SaveBlocksInit
SaveBlocksInit: @ 0x020094A8
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	bl ReadFirstSaveSector
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
	ldr r2, =gLastSaveBlockPtr
	movs r3, #0xff
	ands r3, r5
	lsls r0, r3, #2
	ldr r1, =gSaveBlockLoadRegions
	adds r0, r0, r1
	str r0, [r2]
	ldr r0, =gSaveRngValue
	strh r5, [r0]
	cmp r3, #0
	beq _020094EC
	adds r4, r3, #0
_020094E2:
	bl SaveRandom
	subs r4, #1
	cmp r4, #0
	bne _020094E2
_020094EC:
	bl SaveRandom
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
_02009522: @ case 0
	ldr r7, =gSaveBlock1Ptr
	ldr r0, =gAgbPmRomParams
	mov sl, r0
	ldr r0, [r0]
	adds r0, #0x8c
	ldr r4, [r0]
	ldr r1, =gLastSaveBlockPtr
	mov r8, r1
	ldr r2, [r1]
	mov sb, r2
	bl SaveRandom
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
	bl SaveRandom
	mov r2, r8
	ldr r4, [r2]
	add r4, sb
	adds r1, r5, #0
	ands r1, r0
	lsls r1, r1, #2
	adds r4, r4, r1
	str r4, [r2]
	str r6, [r7]
	ldr r0, =gPokemonStoragePtr
	mov sb, r0
	bl SaveRandom
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
	ldr r2, =gSaveBlock1BakPtr
	mov sb, r2
	mov r1, sl
	ldr r0, [r1]
	adds r0, #0x8c
	ldr r4, [r0]
	bl SaveRandom
	mov r2, r8
	ldr r1, [r2]
	adds r1, r1, r4
	ands r5, r0
	lsls r5, r5, #2
	adds r1, r1, r5
	b _0200965C
	.align 2, 0
	.pool
_020095D0: @ case 1
	ldr r1, =gPokemonStoragePtr
	mov sb, r1
	ldr r2, =gLastSaveBlockPtr
	mov r8, r2
	ldr r5, [r2]
	bl SaveRandom
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
	ldr r7, =gSaveBlock1BakPtr
	ldr r2, =gAgbPmRomParams
	mov sl, r2
	ldr r0, [r2]
	adds r0, #0x8c
	ldr r0, [r0]
	mov sb, r0
	bl SaveRandom
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
	ldr r7, =gSaveBlock1Ptr
	mov r1, sl
	ldr r0, [r1]
	adds r0, #0x8c
	ldr r0, [r0]
	mov sb, r0
	bl SaveRandom
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
	bl SaveRandom
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
_02009680: @ case 2
	ldr r1, =gSaveBlock2Ptr
	mov sb, r1
	ldr r2, =gAgbPmRomParams
	mov sl, r2
	ldr r0, [r2]
	adds r0, #0x88
	ldr r5, [r0]
	ldr r0, =gLastSaveBlockPtr
	mov r8, r0
	ldr r6, [r0]
	bl SaveRandom
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
	ldr r7, =gSaveBlock1Ptr
	mov r1, sl
	ldr r0, [r1]
	adds r0, #0x8c
	ldr r0, [r0]
	mov sb, r0
	bl SaveRandom
	mov r2, r8
	ldr r6, [r2]
	add r6, sb
	adds r1, r5, #0
	ands r1, r0
	lsls r1, r1, #2
	adds r6, r6, r1
	str r6, [r2]
	str r4, [r7]
	ldr r7, =gSaveBlock1BakPtr
	mov r1, sl
	ldr r0, [r1]
	adds r0, #0x8c
	ldr r0, [r0]
	mov sb, r0
	bl SaveRandom
	mov r2, r8
	ldr r4, [r2]
	add r4, sb
	adds r1, r5, #0
	ands r1, r0
	lsls r1, r1, #2
	adds r4, r4, r1
	str r4, [r2]
	str r6, [r7]
	ldr r6, =gPokemonStoragePtr
	bl SaveRandom
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
_0200972C: @ case 3
	ldr r1, =gSaveBlock1BakPtr
	mov sb, r1
	ldr r2, =gAgbPmRomParams
	mov sl, r2
	ldr r0, [r2]
	adds r0, #0x8c
	ldr r4, [r0]
	ldr r0, =gLastSaveBlockPtr
	mov r8, r0
	ldr r6, [r0]
	bl SaveRandom
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
	ldr r1, =gPokemonStoragePtr
	mov sb, r1
	bl SaveRandom
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
	bl SaveRandom
	mov r2, r8
	ldr r5, [r2]
	add r5, sb
	adds r1, r4, #0
	ands r1, r0
	lsls r1, r1, #2
	adds r5, r5, r1
	str r5, [r2]
	str r6, [r7]
	ldr r0, =gSaveBlock1Ptr
	mov sb, r0
	mov r1, sl
	ldr r0, [r1]
	adds r0, #0x8c
	ldr r6, [r0]
	bl SaveRandom
	mov r2, r8
	ldr r1, [r2]
	adds r1, r1, r6
	ands r4, r0
	lsls r4, r4, #2
	adds r1, r1, r4
	str r1, [r2]
	mov r0, sb
	str r5, [r0]
_020097BE: @ break
	ldr r3, =gPlayerPartyPtr
	ldr r1, =gSaveBlock1Ptr
	ldr r0, =gAgbPmRomParams
	ldr r4, [r0]
	adds r0, r4, #0
	adds r0, #0x94
	ldr r2, [r1]
	ldr r1, [r0]
	adds r0, r2, r1
	str r0, [r3]
	ldr r3, =gPlayerPartyBakPtr
	ldr r0, =gSaveBlock1BakPtr
	ldr r0, [r0]
	adds r0, r0, r1
	str r0, [r3]
	ldr r1, =gPlayerPartyCountPtr
	adds r0, r4, #0
	adds r0, #0x90
	ldr r0, [r0]
	adds r0, r2, r0
	str r0, [r1]
	ldr r3, =gPokedexPtr
	ldr r0, =gSaveBlock2Ptr
	ldr r0, [r0]
	ldr r1, [r4, #0x58]
	adds r0, r0, r1
	str r0, [r3]
	ldr r1, =gDexSeen2Ptr
	ldr r0, [r4, #0x5c]
	adds r0, r2, r0
	str r0, [r1]
	ldr r1, =gDexSeen3Ptr
	ldr r0, [r4, #0x60]
	adds r0, r2, r0
	str r0, [r1]
	ldr r1, =gFlagsPtr
	ldr r0, [r4, #0x50]
	adds r0, r2, r0
	str r0, [r1]
	ldr r1, =gVarsPtr
	ldr r0, [r4, #0x54]
	adds r0, r2, r0
	str r0, [r1]
	ldr r1, =gGiftRibbonsPtr
	adds r0, r4, #0
	adds r0, #0xf0
	ldr r0, [r0]
	adds r0, r2, r0
	str r0, [r1]
	ldr r1, =gEnigmaBerryPtr
	adds r0, r4, #0
	adds r0, #0xf4
	ldr r0, [r0]
	adds r0, r2, r0
	str r0, [r1]
	ldr r1, =gPcItemsPtr
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

	@ lcrng: state = (state * 2061 + 7) % 65536
	thumb_func_start SaveRandom
SaveRandom: @ 0x02009890
	ldr r1, =gSaveRngValue
	ldr r0, =0x0000080D
	ldrh r2, [r1]
	muls r0, r2, r0
	adds r0, #7
	strh r0, [r1]
	ldrh r0, [r1]
	bx lr
	.align 2, 0
	.pool

	thumb_func_start UpdateSaveBlockPtr
UpdateSaveBlockPtr: @ 0x020098A8
	push {r4, r5, r6, lr}
	adds r5, r0, #0
	ldr r4, =gLastSaveBlockPtr
	ldr r6, [r4]
	bl SaveRandom
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
