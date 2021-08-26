	.include "asm/macros/function.inc"
	.include "constants/gba_constants.inc"
	.text
	.syntax unified

	thumb_func_start sub_0200A118
sub_0200A118: @ 0x0200A118
	push {r4, r5, lr}
	lsls r0, r0, #0x10
	lsrs r0, r0, #0x10
	ldr r1, =gFirstSaveSector
	ldrh r1, [r1]
	adds r0, r1, r0
	subs r0, #1
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
	adds r0, r4, #0
	movs r1, #0xe
	bl __umodsi3
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
	ldr r0, =gSaveCounter
	ldr r1, [r0]
	movs r5, #1
	ands r1, r5
	lsls r0, r1, #3
	subs r0, r0, r1
	lsls r0, r0, #1
	adds r0, r4, r0
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
	bl SoundVSyncOff
	ldr r3, =ProgramFlashByte
	ldr r1, =0x00000FF8
	ldr r0, =gFastSaveSection
	ldr r0, [r0]
	adds r0, r0, r1
	ldrb r2, [r0]
	ldr r3, [r3]
	adds r0, r4, #0
	bl _call_via_r3
	lsls r0, r0, #0x10
	cmp r0, #0
	bne _0200A198
	lsls r0, r4, #0x18
	lsrs r0, r0, #0x18
	ldr r2, =gDamagedSaveSectors
	adds r1, r5, #0
	lsls r1, r0
	ldr r0, [r2]
	bics r0, r1
	str r0, [r2]
	bl SoundVSyncOn
	movs r0, #1
	b _0200A1AE
	.align 2, 0
	.pool
_0200A198:
	lsls r0, r4, #0x18
	lsrs r0, r0, #0x18
	ldr r2, =gDamagedSaveSectors
	adds r1, r5, #0
	lsls r1, r0
	ldr r0, [r2]
	orrs r0, r1
	str r0, [r2]
	bl SoundVSyncOn
	movs r0, #0xff
_0200A1AE:
	pop {r4, r5}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200A1B8
sub_0200A1B8: @ 0x0200A1B8
	push {r4, r5, lr}
	lsls r0, r0, #0x10
	lsrs r0, r0, #0x10
	ldr r1, =gFirstSaveSector
	ldrh r1, [r1]
	adds r0, r1, r0
	subs r0, #1
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
	adds r0, r4, #0
	movs r1, #0xe
	bl __umodsi3
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
	ldr r0, =gSaveCounter
	ldr r1, [r0]
	movs r5, #1
	ands r1, r5
	lsls r0, r1, #3
	subs r0, r0, r1
	lsls r0, r0, #1
	adds r0, r4, r0
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
	bl SoundVSyncOff
	ldr r3, =ProgramFlashByte
	ldr r1, =0x00000FF8
	ldr r0, =gFastSaveSection
	ldr r0, [r0]
	adds r0, r0, r1
	ldrb r0, [r0]
	mvns r2, r0
	lsls r2, r2, #0x18
	lsrs r2, r2, #0x18
	ldr r3, [r3]
	adds r0, r4, #0
	bl _call_via_r3
	lsls r0, r0, #0x10
	cmp r0, #0
	bne _0200A240
	lsls r0, r4, #0x18
	lsrs r0, r0, #0x18
	ldr r2, =gDamagedSaveSectors
	adds r1, r5, #0
	lsls r1, r0
	ldr r0, [r2]
	bics r0, r1
	str r0, [r2]
	bl SoundVSyncOn
	movs r0, #1
	b _0200A256
	.align 2, 0
	.pool
_0200A240:
	lsls r0, r4, #0x18
	lsrs r0, r0, #0x18
	ldr r2, =gDamagedSaveSectors
	adds r1, r5, #0
	lsls r1, r0
	ldr r0, [r2]
	orrs r0, r1
	str r0, [r2]
	bl SoundVSyncOn
	movs r0, #0xff
_0200A256:
	pop {r4, r5}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200A260
sub_0200A260: @ 0x0200A260
	push {r4, lr}
_0200A262:
	ldr r1, =sSaveBlockChunks
	ldr r4, =gUnknown_02023F40
	ldrh r0, [r4]
	cmp r0, #0xd
	bge _0200A290
	bl WriteSingleChunk
	ldr r0, =gDamagedSaveSectors
	ldr r0, [r0]
	movs r1, #0xff
	cmp r0, #0
	bne _0200A292
	movs r1, #1
	ldrh r0, [r4]
	adds r0, #1
	strh r0, [r4]
	b _0200A292
	.align 2, 0
	.pool
_0200A290:
	movs r1, #0xff
_0200A292:
	adds r4, r1, #0
	ldr r0, =gDamagedSaveSectors
	ldr r0, [r0]
	cmp r0, #0
	beq _0200A2B0
	bl WipeFailedSectors
	lsls r0, r0, #0x18
	cmp r0, #0
	beq _0200A262
	ldr r0, =gUnknown_02022F10
	movs r1, #1
	ldrb r2, [r0, #4]
	orrs r1, r2
	strb r1, [r0, #4]
_0200A2B0:
	cmp r4, #0xff
	beq _0200A2C0
	movs r0, #0
	b _0200A2C2
	.align 2, 0
	.pool
_0200A2C0:
	movs r0, #1
_0200A2C2:
	pop {r4}
	pop {r1}
	bx r1

	thumb_func_start sub_0200A2C8
sub_0200A2C8: @ 0x0200A2C8
	push {r4, r5, lr}
	cmp r0, #1
	bne _0200A2D0
	b _0200A42C
_0200A2D0:
	cmp r0, #1
	bgt _0200A2DA
	cmp r0, #0
	beq _0200A2E2
	b _0200A4AE
_0200A2DA:
	cmp r0, #2
	bne _0200A2E0
	b _0200A478
_0200A2E0:
	b _0200A4AE
_0200A2E2:
	ldr r2, =gUnknown_02022F10
	ldr r1, [r2, #8]
	movs r0, #1
	orrs r1, r0
	movs r0, #0xfe
	ldrb r3, [r2, #4]
	ands r0, r3
	strb r0, [r2, #4]
	movs r0, #7
	rsbs r0, r0, #0
	ands r1, r0
	str r1, [r2, #8]
	ldr r0, =gSaveBlock2Ptr
	ldr r3, [r0]
	movs r1, #0
	ldr r0, =gAgbPmRomParams
	ldr r0, [r0]
	adds r0, #0x88
	ldr r0, [r0]
	cmp r1, r0
	bhs _0200A31C
	adds r2, r0, #0
_0200A30E:
	adds r0, r3, r1
	ldrb r0, [r0]
	cmp r0, #0
	bne _0200A354
	adds r1, #1
	cmp r1, r2
	blo _0200A30E
_0200A31C:
	movs r4, #0
	ldr r5, =EraseFlashSector
_0200A320:
	lsls r0, r4, #0x10
	lsrs r0, r0, #0x10
	ldr r1, [r5]
	bl _call_via_r1
	adds r4, #1
	cmp r4, #0x1f
	ble _0200A320
	ldr r0, =gSaveCounter
	movs r3, #0
	str r3, [r0]
	ldr r0, =gFirstSaveSector
	strh r3, [r0]
	ldr r0, =gDamagedSaveSectors
	str r3, [r0]
	ldr r1, =gSaveValidStatus
	movs r0, #0x80
	str r0, [r1]
	ldr r2, =gUnknown_02022F10
	ldr r0, [r2, #8]
	movs r1, #8
	orrs r0, r1
	str r0, [r2, #8]
	movs r0, #4
	strb r0, [r2, #1]
	strh r3, [r2, #0x10]
_0200A354:
	ldr r1, =gFastSaveSection
	ldr r0, =gSaveReadBuffer
	str r0, [r1]
	ldr r0, =gLastKnownGoodSector
	ldr r4, =gFirstSaveSector
	ldrh r1, [r4]
	strh r1, [r0]
	ldr r2, =gPrevSaveCounter
	ldr r5, =gSaveCounter
	ldr r0, [r5]
	str r0, [r2]
	adds r1, #1
	strh r1, [r4]
	ldrh r0, [r4]
	movs r1, #0xe
	bl __umodsi3
	strh r0, [r4]
	ldr r0, [r5]
	adds r0, #1
	str r0, [r5]
	ldr r1, =gUnknown_02023F40
	movs r0, #0
	strh r0, [r1]
	ldr r0, =gDamagedSaveSectors
	movs r1, #0
	str r1, [r0]
	ldr r4, =gUnknown_02022F10
	ldrb r0, [r4, #1]
	adds r0, #1
	strb r0, [r4, #1]
	strh r1, [r4, #0x10]
	movs r0, #5
	bl DelayFrames
	movs r5, #1
	b _0200A3DE
	.align 2, 0
	.pool
_0200A3D4:
	adds r0, r5, #0
	ldrb r1, [r4, #4]
	ands r0, r1
	cmp r0, #0
	bne _0200A46E
_0200A3DE:
	bl sub_0200A260
	cmp r0, #0
	beq _0200A3D4
	ldr r1, =sWipeTries
	movs r0, #0
	strb r0, [r1]
_0200A3EC:
	ldr r4, =sSaveBlockChunks
	bl SoundVSyncOff
	movs r0, #0xd
	adds r1, r4, #0
	bl sub_02009F4C
	bl SoundVSyncOn
	ldr r0, =gDamagedSaveSectors
	ldr r0, [r0]
	cmp r0, #0
	beq _0200A462
	bl WipeFailedSectors
	lsls r0, r0, #0x18
	cmp r0, #0
	beq _0200A3EC
	ldr r0, =gUnknown_02022F10
	movs r1, #1
	ldrb r2, [r0, #4]
	orrs r1, r2
	b _0200A460
	.align 2, 0
	.pool
_0200A42C:
	movs r4, #0
_0200A42E:
	ldr r1, =sSaveBlockChunks
	movs r0, #0xe
	bl sub_0200A118
	ldr r1, =gDamagedSaveSectors
	ldr r0, [r1]
	cmp r0, #0
	beq _0200A462
	adds r0, r4, #1
	lsls r0, r0, #0x18
	lsrs r4, r0, #0x18
	cmp r4, #3
	bhi _0200A458
	movs r0, #0
	str r0, [r1]
	b _0200A42E
	.align 2, 0
	.pool
_0200A458:
	ldr r0, =gUnknown_02022F10
	movs r1, #1
	ldrb r3, [r0, #4]
	orrs r1, r3
_0200A460:
	strb r1, [r0, #4]
_0200A462:
	ldr r1, =gUnknown_02022F10
	movs r0, #1
	ldrb r1, [r1, #4]
	ands r0, r1
	cmp r0, #0
	beq _0200A4AE
_0200A46E:
	movs r0, #1
	b _0200A4B0
	.align 2, 0
	.pool
_0200A478:
	movs r4, #0
_0200A47A:
	ldr r1, =sSaveBlockChunks
	movs r0, #0xe
	bl sub_0200A1B8
	ldr r1, =gDamagedSaveSectors
	ldr r0, [r1]
	cmp r0, #0
	beq _0200A4AE
	adds r0, r4, #1
	lsls r0, r0, #0x18
	lsrs r4, r0, #0x18
	cmp r4, #3
	bhi _0200A4A4
	movs r0, #0
	str r0, [r1]
	b _0200A47A
	.align 2, 0
	.pool
_0200A4A4:
	ldr r0, =gUnknown_02022F10
	movs r1, #1
	ldrb r2, [r0, #4]
	orrs r1, r2
	strb r1, [r0, #4]
_0200A4AE:
	movs r0, #0
_0200A4B0:
	pop {r4, r5}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start WipeSector
WipeSector: @ 0x0200A4BC
	push {r4, r5, r6, r7, lr}
	mov r7, sb
	mov r6, r8
	push {r6, r7}
	lsls r0, r0, #0x10
	lsrs r6, r0, #0x10
	movs r5, #0
	bl SoundVSyncOff
	ldr r0, =0x00000FFF
	mov sb, r0
	ldr r0, =ProgramFlashByte
	mov r8, r0
	ldr r7, =gSaveReadBuffer
_0200A4D8:
	movs r4, #0
	adds r5, #1
_0200A4DC:
	mov r0, r8
	ldr r3, [r0]
	adds r0, r6, #0
	adds r1, r4, #0
	movs r2, #0
	bl _call_via_r3
	adds r0, r4, #1
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
	cmp r4, sb
	bls _0200A4DC
	adds r0, r6, #0
	movs r1, #0
	adds r2, r7, #0
	movs r3, #0x80
	lsls r3, r3, #5
	bl ReadFlash
	adds r2, r7, #0
	movs r1, #0
	ldr r3, =0x000003FF
_0200A508:
	ldr r0, [r2]
	cmp r0, #0
	beq _0200A524
	movs r0, #1
	b _0200A532
	.align 2, 0
	.pool
_0200A524:
	adds r0, r1, #1
	lsls r0, r0, #0x10
	lsrs r1, r0, #0x10
	adds r2, #4
	cmp r1, r3
	bls _0200A508
	movs r0, #0
_0200A532:
	adds r4, r0, #0
	lsls r0, r5, #0x10
	lsrs r5, r0, #0x10
	cmp r4, #0
	beq _0200A540
	cmp r5, #0x81
	bls _0200A4D8
_0200A540:
	bl SoundVSyncOn
	adds r0, r4, #0
	pop {r3, r4}
	mov r8, r3
	mov sb, r4
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start WipeFailedSectors
WipeFailedSectors: @ 0x0200A554
	push {r4, r5, r6, lr}
	ldr r2, =gUnknown_02022F10
	ldr r0, [r2, #8]
	movs r1, #2
	orrs r0, r1
	str r0, [r2, #8]
	ldr r0, =gDamagedSaveSectors
	ldr r1, [r0]
	cmp r1, #0
	beq _0200A5B8
	ldr r0, =sWipeTries
	ldrb r0, [r0]
	cmp r0, #2
	bhi _0200A5B8
	adds r6, r1, #0
	movs r4, #0
_0200A574:
	movs r5, #1
	lsls r5, r4
	adds r0, r6, #0
	ands r0, r5
	cmp r0, #0
	beq _0200A58E
	adds r0, r4, #0
	bl WipeSector
	lsls r0, r0, #0x18
	cmp r0, #0
	bne _0200A58E
	bics r6, r5
_0200A58E:
	adds r0, r4, #1
	lsls r0, r0, #0x10
	lsrs r4, r0, #0x10
	cmp r4, #0x1f
	bls _0200A574
	ldr r0, =gDamagedSaveSectors
	str r6, [r0]
	ldr r1, =sWipeTries
	ldrb r0, [r1]
	adds r0, #1
	strb r0, [r1]
	cmp r6, #0
	bne _0200A5B8
	movs r0, #0
	b _0200A5BA
	.align 2, 0
	.pool
_0200A5B8:
	movs r0, #1
_0200A5BA:
	pop {r4, r5, r6}
	pop {r1}
	bx r1

	thumb_func_start sub_0200A5C0
sub_0200A5C0: @ 0x0200A5C0
	ldr r0, =gSaveReadBuffer
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_0200A5C8
sub_0200A5C8: @ 0x0200A5C8
	ldr r0, =gSaveCounter
	movs r1, #0
	str r1, [r0]
	ldr r0, =gFirstSaveSector
	strh r1, [r0]
	ldr r0, =gDamagedSaveSectors
	str r1, [r0]
	ldr r1, =gSaveValidStatus
	movs r0, #0x80
	str r0, [r1]
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_0200A5F0
sub_0200A5F0: @ 0x0200A5F0
	push {r4, r5, lr}
	movs r4, #0
	ldr r5, =EraseFlashSector
_0200A5F6:
	lsls r0, r4, #0x10
	lsrs r0, r0, #0x10
	ldr r1, [r5]
	bl _call_via_r1
	adds r4, #1
	cmp r4, #0x1f
	ble _0200A5F6
	ldr r0, =gSaveCounter
	movs r1, #0
	str r1, [r0]
	ldr r0, =gFirstSaveSector
	strh r1, [r0]
	ldr r0, =gDamagedSaveSectors
	str r1, [r0]
	ldr r1, =gSaveValidStatus
	movs r0, #0x80
	str r0, [r1]
	pop {r4, r5}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_0200A634
sub_0200A634: @ 0x0200A634
	push {r4, r5, r6, lr}
	adds r6, r0, #0
	ldr r0, =gSaveCounter
	ldr r1, [r0]
	movs r0, #1
	ands r1, r0
	lsls r0, r1, #3
	subs r0, r0, r1
	lsls r5, r0, #1
	movs r4, #0
_0200A648:
	adds r0, r4, r5
	adds r1, r4, #0
	adds r2, r6, #0
	bl ReadSaveChunkI
	adds r4, #1
	cmp r4, #0xd
	ble _0200A648
	movs r0, #1
	pop {r4, r5, r6}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200A664
sub_0200A664: @ 0x0200A664
	push {r4, r5, r6, lr}
	adds r2, r0, #0
	adds r6, r1, #0
	ldr r1, =gFastSaveSection
	ldr r0, =gSaveReadBuffer
	str r0, [r1]
	cmp r2, #0
	beq _0200A684
	cmp r2, #1
	beq _0200A6B4
	b _0200A6D6
	.align 2, 0
	.pool
_0200A684:
	ldr r4, =gSaveValidStatus
	adds r0, r6, #0
	bl GetSaveValidStatus
	lsls r0, r0, #0x10
	lsrs r0, r0, #0x10
	str r0, [r4]
	ldr r0, =gSaveCounter
	ldr r1, [r0]
	movs r0, #1
	ands r1, r0
	lsls r0, r1, #3
	subs r0, r0, r1
	lsls r0, r0, #1
	movs r1, #0
	adds r2, r6, #0
	bl ReadSaveChunkI
	ldr r0, [r4]
	b _0200A6D6
	.align 2, 0
	.pool
_0200A6B4:
	ldr r0, =gSaveCounter
	ldr r1, [r0]
	ands r1, r2
	lsls r0, r1, #3
	subs r0, r0, r1
	lsls r5, r0, #1
	movs r4, #0
_0200A6C2:
	adds r0, r4, r5
	adds r1, r4, #0
	adds r2, r6, #0
	bl ReadSaveChunkI
	adds r4, #1
	cmp r4, #0xd
	ble _0200A6C2
	ldr r0, =gSaveValidStatus
	ldr r0, [r0]
_0200A6D6:
	pop {r4, r5, r6}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200A6E4
sub_0200A6E4: @ 0x0200A6E4
	push {r4, r5, r6, r7, lr}
	adds r7, r1, #0
	lsls r0, r0, #0x10
	lsrs r2, r0, #0x10
	ldr r1, =gFastSaveSection
	ldr r0, =gSaveReadBuffer
	str r0, [r1]
	ldr r0, =0x0000FFFF
	cmp r2, r0
	beq _0200A710
	adds r0, r2, #0
	adds r1, r7, #0
	bl WriteSingleChunk
	adds r5, r0, #0
	b _0200A760
	.align 2, 0
	.pool
_0200A710:
	ldr r1, =gLastKnownGoodSector
	ldr r5, =gFirstSaveSector
	ldrh r0, [r5]
	strh r0, [r1]
	ldr r1, =gPrevSaveCounter
	ldr r6, =gSaveCounter
	ldr r4, [r6]
	str r4, [r1]
	adds r0, #1
	strh r0, [r5]
	ldrh r0, [r5]
	movs r1, #0xe
	bl __umodsi3
	strh r0, [r5]
	adds r4, #1
	str r4, [r6]
	movs r5, #1
	movs r4, #0
_0200A736:
	lsls r0, r4, #0x10
	lsrs r0, r0, #0x10
	adds r1, r7, #0
	bl WriteSingleChunk
	adds r4, #1
	cmp r4, #0xd
	ble _0200A736
	ldr r0, =gDamagedSaveSectors
	ldr r0, [r0]
	cmp r0, #0
	beq _0200A760
	movs r5, #0xff
	ldr r1, =gFirstSaveSector
	ldr r0, =gLastKnownGoodSector
	ldrh r0, [r0]
	strh r0, [r1]
	ldr r1, =gSaveCounter
	ldr r0, =gPrevSaveCounter
	ldr r0, [r0]
	str r0, [r1]
_0200A760:
	adds r0, r5, #0
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200A77C
sub_0200A77C: @ 0x0200A77C
	push {r4, r5, r6, lr}
	ldr r1, =gFastSaveSection
	ldr r0, =gSaveReadBuffer
	str r0, [r1]
	ldr r1, =gLastKnownGoodSector
	ldr r5, =gFirstSaveSector
	ldrh r0, [r5]
	strh r0, [r1]
	ldr r1, =gPrevSaveCounter
	ldr r6, =gSaveCounter
	ldr r4, [r6]
	str r4, [r1]
	adds r0, #1
	strh r0, [r5]
	ldrh r0, [r5]
	movs r1, #0xe
	bl __umodsi3
	strh r0, [r5]
	adds r4, #1
	str r4, [r6]
	ldr r1, =gUnknown_02023F40
	movs r0, #0
	strh r0, [r1]
	ldr r1, =gDamagedSaveSectors
	movs r0, #0
	str r0, [r1]
	pop {r4, r5, r6}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start sub_0200A7D8
sub_0200A7D8: @ 0x0200A7D8
	ldr r1, =gFastSaveSection
	ldr r0, =gSaveReadBuffer
	str r0, [r1]
	ldr r1, =gLastKnownGoodSector
	ldr r0, =gFirstSaveSector
	ldrh r0, [r0]
	strh r0, [r1]
	ldr r1, =gPrevSaveCounter
	ldr r0, =gSaveCounter
	ldr r0, [r0]
	str r0, [r1]
	ldr r1, =gUnknown_02023F40
	movs r0, #0
	strh r0, [r1]
	ldr r1, =gDamagedSaveSectors
	movs r0, #0
	str r0, [r1]
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_0200A81C
sub_0200A81C: @ 0x0200A81C
	ldr r1, =gFirstSaveSector
	ldr r0, =gLastKnownGoodSector
	ldrh r0, [r0]
	strh r0, [r1]
	ldr r1, =gSaveCounter
	ldr r0, =gPrevSaveCounter
	ldr r0, [r0]
	str r0, [r1]
	bx lr
	.align 2, 0
	.pool

	thumb_func_start sub_0200A840
sub_0200A840: @ 0x0200A840
	push {r4, lr}
	lsls r0, r0, #0x10
	lsrs r0, r0, #0x10
	ldr r4, =gUnknown_02023F40
	ldrh r2, [r4]
	subs r0, #1
	cmp r2, r0
	bge _0200A874
	adds r0, r2, #0
	bl WriteSingleChunk
	ldr r0, =gDamagedSaveSectors
	ldr r0, [r0]
	movs r1, #0xff
	cmp r0, #0
	bne _0200A876
	movs r1, #1
	ldrh r0, [r4]
	adds r0, #1
	strh r0, [r4]
	b _0200A876
	.align 2, 0
	.pool
_0200A874:
	movs r1, #0xff
_0200A876:
	adds r0, r1, #0
	pop {r4}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_0200A880
sub_0200A880: @ 0x0200A880
	push {r4, r5, r6, lr}
	adds r4, r0, #0
	adds r5, r1, #0
	lsls r4, r4, #0x10
	lsrs r4, r4, #0x10
	movs r6, #1
	bl SoundVSyncOff
	subs r4, #1
	lsls r4, r4, #0x10
	lsrs r4, r4, #0x10
	adds r0, r4, #0
	adds r1, r5, #0
	bl sub_02009F4C
	bl SoundVSyncOn
	ldr r0, =gDamagedSaveSectors
	ldr r0, [r0]
	cmp r0, #0
	beq _0200A8AC
	movs r6, #0xff
_0200A8AC:
	adds r0, r6, #0
	pop {r4, r5, r6}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	.lcomm sWipeTries, 4
    .lcomm gSaveValidStatus, 4

	.global sWipeTries
	.global gSaveValidStatus
