	.include "asm/macros/function.inc"
	.include "constants/gba_constants.inc"
	.include "constants/m4a_constants.inc"
	.text
	.syntax unified

	thumb_func_start MidiKeyToFreq
MidiKeyToFreq: @ 0x020070E8
	push {r4, r5, r6, r7, lr}
	mov ip, r0
	lsls r1, r1, #0x18
	lsrs r6, r1, #0x18
	lsls r7, r2, #0x18
	cmp r6, #0xb2
	bls _020070FC
	movs r6, #0xb2
	movs r7, #0xff
	lsls r7, r7, #0x18
_020070FC:
	ldr r3, =gScaleTable
	adds r0, r6, r3
	ldrb r5, [r0]
	ldr r4, =gFreqTable
	movs r2, #0xf
	adds r0, r5, #0
	ands r0, r2
	lsls r0, r0, #2
	adds r0, r0, r4
	lsrs r1, r5, #4
	ldr r5, [r0]
	lsrs r5, r1
	adds r0, r6, #1
	adds r0, r0, r3
	ldrb r1, [r0]
	adds r0, r1, #0
	ands r0, r2
	lsls r0, r0, #2
	adds r0, r0, r4
	lsrs r1, r1, #4
	ldr r0, [r0]
	lsrs r0, r1
	mov r1, ip
	ldr r4, [r1, #4]
	subs r0, r0, r5
	adds r1, r7, #0
	bl umul3232H32
	adds r1, r0, #0
	adds r1, r5, r1
	adds r0, r4, #0
	bl umul3232H32
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start UnusedDummyFunc
UnusedDummyFunc: @ 0x0200714C
	bx lr
	.align 2, 0

	thumb_func_start MPlayContinue
MPlayContinue: @ 0x02007150
	adds r2, r0, #0
	ldr r3, [r2, #0x34]
	ldr r0, =ID_NUMBER
	cmp r3, r0
	bne _02007162
	ldr r0, [r2, #4]
	ldr r1, =0x7FFFFFFF
	ands r0, r1
	str r0, [r2, #4]
_02007162:
	bx lr
	.align 2, 0
	.pool

	thumb_func_start MPlayFadeOut
MPlayFadeOut: @ 0x0200716C
	adds r2, r0, #0
	lsls r1, r1, #0x10
	lsrs r1, r1, #0x10
	ldr r3, [r2, #0x34]
	ldr r0, =ID_NUMBER
	cmp r3, r0
	bne _02007184
	strh r1, [r2, #0x26]
	strh r1, [r2, #0x24]
	movs r0, #0x80
	lsls r0, r0, #1
	strh r0, [r2, #0x28]
_02007184:
	bx lr
	.align 2, 0
	.pool

	thumb_func_start m4aSoundInit
m4aSoundInit: @ 0x0200718C
	push {r4, r5, r6, r7, lr}
	mov r7, r8
	push {r7}
	ldr r0, =SoundMainRAM
	movs r1, #2
	rsbs r1, r1, #0
	ands r0, r1
	ldr r1, =SoundMainRAM_Buffer
	ldr r2, =0x04000100
	bl CpuSet
	ldr r0, =gUnknown_02021A40
	bl SoundInit
	ldr r0, =gUnknown_02022A80
	bl MPlayExtender
	ldr r0, =0x0093F800
	bl m4aSoundMode
	ldr r0, =0x00000001
	lsls r0, r0, #0x10
	lsrs r0, r0, #0x10
	cmp r0, #0
	beq _020071E8
	ldr r1, =gMPlayTable
	mov r8, r1
	mov r5, r8
	movs r7, #0
	adds r6, r0, #0
_020071C8:
	ldr r4, [r5]
	mov r0, r8
	adds r0, #4
	adds r0, r7, r0
	ldr r1, [r0]
	ldrb r2, [r5, #8]
	adds r0, r4, #0
	bl MPlayOpen
	ldr r0, =gUnknown_02022BC0
	str r0, [r4, #0x18]
	adds r5, #0xc
	adds r7, #0xc
	subs r6, #1
	cmp r6, #0
	bne _020071C8
_020071E8:
	pop {r3}
	mov r8, r3
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start m4aSoundMain
m4aSoundMain: @ 0x02007218
	push {lr}
	bl SoundMain
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start m4aSongNumStart
m4aSongNumStart: @ 0x02007224
	push {lr}
	lsls r0, r0, #0x10
	ldr r2, =gMPlayTable
	ldr r1, =gSongTable
	lsrs r0, r0, #0xd
	adds r0, r0, r1
	ldrh r3, [r0, #4]
	lsls r1, r3, #1
	adds r1, r1, r3
	lsls r1, r1, #2
	adds r1, r1, r2
	ldr r2, [r1]
	ldr r1, [r0]
	adds r0, r2, #0
	bl MPlayStart
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start m4aSongNumStartOrChange
m4aSongNumStartOrChange: @ 0x02007250
	push {lr}
	lsls r0, r0, #0x10
	ldr r2, =gMPlayTable
	ldr r1, =gSongTable
	lsrs r0, r0, #0xd
	adds r0, r0, r1
	ldrh r3, [r0, #4]
	lsls r1, r3, #1
	adds r1, r1, r3
	lsls r1, r1, #2
	adds r1, r1, r2
	ldr r1, [r1]
	ldr r3, [r1]
	ldr r2, [r0]
	cmp r3, r2
	beq _02007284
	adds r0, r1, #0
	adds r1, r2, #0
	bl MPlayStart
	b _02007298
	.align 2, 0
	.pool
_02007284:
	ldr r2, [r1, #4]
	ldrh r0, [r1, #4]
	cmp r0, #0
	beq _02007290
	cmp r2, #0
	bge _02007298
_02007290:
	adds r0, r1, #0
	adds r1, r3, #0
	bl MPlayStart
_02007298:
	pop {r0}
	bx r0

	thumb_func_start m4aSongNumStartOrContinue
m4aSongNumStartOrContinue: @ 0x0200729C
	push {lr}
	lsls r0, r0, #0x10
	ldr r2, =gMPlayTable
	ldr r1, =gSongTable
	lsrs r0, r0, #0xd
	adds r0, r0, r1
	ldrh r3, [r0, #4]
	lsls r1, r3, #1
	adds r1, r1, r3
	lsls r1, r1, #2
	adds r1, r1, r2
	ldr r1, [r1]
	ldr r3, [r1]
	ldr r2, [r0]
	cmp r3, r2
	beq _020072D0
	adds r0, r1, #0
	adds r1, r2, #0
	bl MPlayStart
	b _020072EC
	.align 2, 0
	.pool
_020072D0:
	ldr r2, [r1, #4]
	ldrh r0, [r1, #4]
	cmp r0, #0
	bne _020072E2
	adds r0, r1, #0
	adds r1, r3, #0
	bl MPlayStart
	b _020072EC
_020072E2:
	cmp r2, #0
	bge _020072EC
	adds r0, r1, #0
	bl MPlayContinue
_020072EC:
	pop {r0}
	bx r0

	thumb_func_start m4aSongNumStop
m4aSongNumStop: @ 0x020072F0
	push {lr}
	lsls r0, r0, #0x10
	ldr r2, =gMPlayTable
	ldr r1, =gSongTable
	lsrs r0, r0, #0xd
	adds r0, r0, r1
	ldrh r3, [r0, #4]
	lsls r1, r3, #1
	adds r1, r1, r3
	lsls r1, r1, #2
	adds r1, r1, r2
	ldr r2, [r1]
	ldr r1, [r2]
	ldr r0, [r0]
	cmp r1, r0
	bne _02007316
	adds r0, r2, #0
	bl m4aMPlayStop
_02007316:
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start m4aSongNumContinue
m4aSongNumContinue: @ 0x02007324
	push {lr}
	lsls r0, r0, #0x10
	ldr r2, =gMPlayTable
	ldr r1, =gSongTable
	lsrs r0, r0, #0xd
	adds r0, r0, r1
	ldrh r3, [r0, #4]
	lsls r1, r3, #1
	adds r1, r1, r3
	lsls r1, r1, #2
	adds r1, r1, r2
	ldr r2, [r1]
	ldr r1, [r2]
	ldr r0, [r0]
	cmp r1, r0
	bne _0200734A
	adds r0, r2, #0
	bl MPlayContinue
_0200734A:
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start m4aMPlayAllStop
m4aMPlayAllStop: @ 0x02007358
	push {r4, r5, lr}
	ldr r0, =0x00000001
	lsls r0, r0, #0x10
	lsrs r0, r0, #0x10
	cmp r0, #0
	beq _02007376
	ldr r5, =gMPlayTable
	adds r4, r0, #0
_02007368:
	ldr r0, [r5]
	bl m4aMPlayStop
	adds r5, #0xc
	subs r4, #1
	cmp r4, #0
	bne _02007368
_02007376:
	pop {r4, r5}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start m4aMPlayContinue
m4aMPlayContinue: @ 0x02007384
	push {lr}
	bl MPlayContinue
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start m4aMPlayAllContinue
m4aMPlayAllContinue: @ 0x02007390
	push {r4, r5, lr}
	ldr r0, =0x00000001
	lsls r0, r0, #0x10
	lsrs r0, r0, #0x10
	cmp r0, #0
	beq _020073AE
	ldr r5, =gMPlayTable
	adds r4, r0, #0
_020073A0:
	ldr r0, [r5]
	bl MPlayContinue
	adds r5, #0xc
	subs r4, #1
	cmp r4, #0
	bne _020073A0
_020073AE:
	pop {r4, r5}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start m4aMPlayFadeOut
m4aMPlayFadeOut: @ 0x020073BC
	push {lr}
	lsls r1, r1, #0x10
	lsrs r1, r1, #0x10
	bl MPlayFadeOut
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start m4aMPlayFadeOutTemporarily
m4aMPlayFadeOutTemporarily: @ 0x020073CC
	push {r4, r5, r6, r7, lr}
	ldrb r5, [r0, #8]
	ldr r4, [r0, #0x2c]
	cmp r5, #0
	ble _0200740E
	movs r7, #0x80
_020073D8:
	ldrb r1, [r4]
	adds r0, r7, #0
	ands r0, r1
	cmp r0, #0
	beq _02007406
	movs r6, #0x40
	adds r0, r6, #0
	ands r0, r1
	cmp r0, #0
	beq _02007406
	adds r0, r4, #0
	bl Clear64byte
	strb r7, [r4]
	movs r0, #2
	strb r0, [r4, #0xf]
	strb r6, [r4, #0x13]
	movs r0, #0x16
	strb r0, [r4, #0x19]
	adds r1, r4, #0
	adds r1, #0x24
	movs r0, #1
	strb r0, [r1]
_02007406:
	subs r5, #1
	adds r4, #0x50
	cmp r5, #0
	bgt _020073D8
_0200740E:
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0

	thumb_func_start MPlayExtender
MPlayExtender: @ 0x02007414
	push {r4, r5, r6, lr}
	sub sp, #4
	adds r5, r0, #0
	ldr r1, =0x04000084
	movs r0, #0x8f
	strh r0, [r1]
	ldr r2, =0x04000080
	movs r0, #0x77
	strh r0, [r2]
	ldr r0, =0x04000063
	movs r1, #8
	strb r1, [r0]
	adds r0, #6
	strb r1, [r0]
	adds r0, #0x10
	strb r1, [r0]
	subs r0, #0x14
	movs r1, #0x80
	strb r1, [r0]
	adds r0, #8
	strb r1, [r0]
	adds r0, #0x10
	strb r1, [r0]
	ldr r1, =0x04000070
	movs r0, #0
	strb r0, [r1]
	ldr r1, =0x0000FF77
	adds r0, r1, #0
	strh r0, [r2]
	ldr r0, =SOUND_INFO_PTR
	ldr r4, [r0]
	ldr r6, [r4]
	ldr r0, =ID_NUMBER
	cmp r6, r0
	bne _020074D8
	adds r0, r6, #1
	str r0, [r4]
	ldr r1, =gMPlayJumpTable
	ldr r0, =ply_memacc
	str r0, [r1, #0x20]
	ldr r0, =ply_lfos
	str r0, [r1, #0x44]
	ldr r0, =ply_mod
	str r0, [r1, #0x4c]
	ldr r0, =ply_xcmd
	str r0, [r1, #0x70]
	ldr r0, =ply_endtie
	str r0, [r1, #0x74]
	ldr r0, =SampleFreqSet
	str r0, [r1, #0x78]
	ldr r0, =TrackStop
	str r0, [r1, #0x7c]
	adds r2, r1, #0
	adds r2, #0x80
	ldr r0, =FadeOutBody
	str r0, [r2]
	adds r1, #0x84
	ldr r0, =TrkVolPitSet
	str r0, [r1]
	str r5, [r4, #0x1c]
	ldr r0, =CgbSound
	str r0, [r4, #0x28]
	ldr r0, =CgbOscOff
	str r0, [r4, #0x2c]
	ldr r0, =MidiKeyToCgbFreq
	str r0, [r4, #0x30]
	ldr r0, =0x00000000
	movs r1, #0
	strb r0, [r4, #0xc]
	str r1, [sp]
	ldr r2, =0x05000040
	mov r0, sp
	adds r1, r5, #0
	bl CpuSet
	movs r0, #1
	strb r0, [r5, #1]
	movs r0, #0x11
	strb r0, [r5, #0x1c]
	adds r1, r5, #0
	adds r1, #0x41
	movs r0, #2
	strb r0, [r1]
	adds r1, #0x1b
	movs r0, #0x22
	strb r0, [r1]
	adds r1, #0x25
	movs r0, #3
	strb r0, [r1]
	adds r1, #0x1b
	movs r0, #0x44
	strb r0, [r1]
	adds r1, #0x24
	movs r0, #4
	strb r0, [r1, #1]
	movs r0, #0x88
	strb r0, [r1, #0x1c]
	str r6, [r4]
_020074D8:
	add sp, #4
	pop {r4, r5, r6}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start MusicPlayerJumpTableCopy
MusicPlayerJumpTableCopy: @ 0x02007538
	svc #0x2a
	bx lr

	thumb_func_start ClearChain
ClearChain: @ 0x0200753C
	push {lr}
	ldr r1, =gUnknown_02022A78
	ldr r1, [r1]
	bl _call_via_r1
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start Clear64byte
Clear64byte: @ 0x02007550
	push {lr}
	ldr r1, =gUnknown_02022A7C
	ldr r1, [r1]
	bl _call_via_r1
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start SoundInit
SoundInit: @ 0x02007564
	push {r4, r5, lr}
	sub sp, #4
	adds r5, r0, #0
	movs r3, #0
	str r3, [r5]
	ldr r0, =0x040000C6
	strh r3, [r0]
	adds r0, #0xc
	strh r3, [r0]
	ldr r1, =0x04000084
	movs r0, #0x8f
	strh r0, [r1]
	subs r1, #2
	ldr r2, =0x0000A90E
	adds r0, r2, #0
	strh r0, [r1]
	ldr r2, =0x04000089
	ldrb r1, [r2]
	movs r0, #0x3f
	ands r0, r1
	movs r1, #0x40
	orrs r0, r1
	strb r0, [r2]
	ldr r1, =0x040000BC
	movs r2, #0xd4
	lsls r2, r2, #2
	adds r0, r5, r2
	str r0, [r1]
	adds r1, #4
	ldr r0, =0x040000A0
	str r0, [r1]
	adds r1, #8
	movs r2, #0x98
	lsls r2, r2, #4
	adds r0, r5, r2
	str r0, [r1]
	adds r1, #4
	ldr r0, =0x040000A4
	str r0, [r1]
	ldr r0, =SOUND_INFO_PTR
	str r5, [r0]
	str r3, [sp]
	ldr r2, =0x050003EC
	mov r0, sp
	adds r1, r5, #0
	bl CpuSet
	movs r0, #8
	strb r0, [r5, #6]
	movs r0, #0xf
	strb r0, [r5, #7]
	ldr r0, =ply_note
	str r0, [r5, #0x38]
	ldr r0, =DummyFunc
	str r0, [r5, #0x28]
	str r0, [r5, #0x2c]
	str r0, [r5, #0x30]
	str r0, [r5, #0x3c]
	ldr r4, =gMPlayJumpTable
	adds r0, r4, #0
	bl MPlayJumpTableCopy
	str r4, [r5, #0x34]
	movs r0, #0x80
	lsls r0, r0, #0xb
	bl SampleFreqSet
	ldr r0, =ID_NUMBER
	str r0, [r5]
	add sp, #4
	pop {r4, r5}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start SampleFreqSet
SampleFreqSet: @ 0x0200762C
	push {r4, r5, r6, lr}
	adds r2, r0, #0
	ldr r0, =SOUND_INFO_PTR
	ldr r4, [r0]
	movs r0, #0xf0
	lsls r0, r0, #0xc
	ands r0, r2
	lsrs r2, r0, #0x10
	movs r6, #0
	strb r2, [r4, #8]
	ldr r1, =gPcmSamplesPerVBlankTable
	subs r0, r2, #1
	lsls r0, r0, #1
	adds r0, r0, r1
	ldrh r5, [r0]
	str r5, [r4, #0x10]
	movs r0, #0xc6
	lsls r0, r0, #3
	adds r1, r5, #0
	bl __divsi3
	strb r0, [r4, #0xb]
	ldr r0, =0x00091D1B
	muls r0, r5, r0
	ldr r1, =0x00001388
	adds r0, r0, r1
	ldr r1, =0x00002710
	bl __divsi3
	adds r1, r0, #0
	str r1, [r4, #0x14]
	movs r0, #0x80
	lsls r0, r0, #0x11
	bl __divsi3
	adds r0, #1
	asrs r0, r0, #1
	str r0, [r4, #0x18]
	ldr r0, =0x04000102
	strh r6, [r0]
	ldr r4, =0x04000100
	ldr r0, =0x00044940
	adds r1, r5, #0
	bl __divsi3
	rsbs r0, r0, #0
	strh r0, [r4]
	bl m4aSoundVSyncOn
	ldr r1, =0x04000006
_02007690:
	ldrb r0, [r1]
	cmp r0, #0x9f
	beq _02007690
	ldr r1, =0x04000006
_02007698:
	ldrb r0, [r1]
	cmp r0, #0x9f
	bne _02007698
	ldr r1, =0x04000102
	movs r0, #0x80
	strh r0, [r1]
	pop {r4, r5, r6}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start m4aSoundMode
m4aSoundMode: @ 0x020076D0
	push {r4, r5, lr}
	adds r3, r0, #0
	ldr r0, =SOUND_INFO_PTR
	ldr r5, [r0]
	ldr r1, [r5]
	ldr r0, =ID_NUMBER
	cmp r1, r0
	bne _02007756
	adds r0, r1, #1
	str r0, [r5]
	movs r4, #0xff
	ands r4, r3
	cmp r4, #0
	beq _020076F2
	movs r0, #0x7f
	ands r4, r0
	strb r4, [r5, #5]
_020076F2:
	movs r4, #0xf0
	lsls r4, r4, #4
	ands r4, r3
	cmp r4, #0
	beq _02007712
	lsrs r0, r4, #8
	strb r0, [r5, #6]
	movs r4, #0xc
	adds r0, r5, #0
	adds r0, #0x50
	movs r1, #0
_02007708:
	strb r1, [r0]
	subs r4, #1
	adds r0, #0x40
	cmp r4, #0
	bne _02007708
_02007712:
	movs r4, #0xf0
	lsls r4, r4, #8
	ands r4, r3
	cmp r4, #0
	beq _02007720
	lsrs r0, r4, #0xc
	strb r0, [r5, #7]
_02007720:
	movs r4, #0xb0
	lsls r4, r4, #0x10
	ands r4, r3
	cmp r4, #0
	beq _0200773E
	movs r0, #0xc0
	lsls r0, r0, #0xe
	ands r0, r4
	lsrs r4, r0, #0xe
	ldr r2, =0x04000089
	ldrb r1, [r2]
	movs r0, #0x3f
	ands r0, r1
	orrs r0, r4
	strb r0, [r2]
_0200773E:
	movs r4, #0xf0
	lsls r4, r4, #0xc
	ands r4, r3
	cmp r4, #0
	beq _02007752
	bl m4aSoundVSyncOff
	adds r0, r4, #0
	bl SampleFreqSet
_02007752:
	ldr r0, =ID_NUMBER
	str r0, [r5]
_02007756:
	pop {r4, r5}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start SoundClear
SoundClear: @ 0x02007768
	push {r4, r5, r6, r7, lr}
	ldr r0, =SOUND_INFO_PTR
	ldr r6, [r0]
	ldr r1, [r6]
	ldr r0, =ID_NUMBER
	cmp r1, r0
	bne _020077AE
	adds r0, r1, #1
	str r0, [r6]
	movs r5, #0xc
	adds r4, r6, #0
	adds r4, #0x50
	movs r0, #0
_02007782:
	strb r0, [r4]
	subs r5, #1
	adds r4, #0x40
	cmp r5, #0
	bgt _02007782
	ldr r4, [r6, #0x1c]
	cmp r4, #0
	beq _020077AA
	movs r5, #1
	movs r7, #0
_02007796:
	lsls r0, r5, #0x18
	lsrs r0, r0, #0x18
	ldr r1, [r6, #0x2c]
	bl _call_via_r1
	strb r7, [r4]
	adds r5, #1
	adds r4, #0x40
	cmp r5, #4
	ble _02007796
_020077AA:
	ldr r0, =ID_NUMBER
	str r0, [r6]
_020077AE:
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start m4aSoundVSyncOff
m4aSoundVSyncOff: @ 0x020077BC
	push {lr}
	sub sp, #4
	ldr r0, =SOUND_INFO_PTR
	ldr r2, [r0]
	ldr r1, [r2]
	ldr r3, =0x978C92AD
	adds r0, r1, r3
	cmp r0, #1
	bhi _020077F0
	adds r0, r1, #0
	adds r0, #0xa
	str r0, [r2]
	ldr r0, =0x040000C6
	movs r1, #0
	strh r1, [r0]
	adds r0, #0xc
	strh r1, [r0]
	movs r0, #0
	str r0, [sp]
	movs r0, #0xd4
	lsls r0, r0, #2
	adds r1, r2, r0
	ldr r2, =0x05000318
	mov r0, sp
	bl CpuSet
_020077F0:
	add sp, #4
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start m4aSoundVSyncOn
m4aSoundVSyncOn: @ 0x02007808
	push {r4, lr}
	ldr r0, =SOUND_INFO_PTR
	ldr r2, [r0]
	ldr r3, [r2]
	ldr r0, =ID_NUMBER
	cmp r3, r0
	beq _02007830
	ldr r0, =0x040000C6
	movs r4, #0xb6
	lsls r4, r4, #8
	adds r1, r4, #0
	strh r1, [r0]
	adds r0, #0xc
	strh r1, [r0]
	ldrb r0, [r2, #4]
	movs r0, #0
	strb r0, [r2, #4]
	adds r0, r3, #0
	subs r0, #0xa
	str r0, [r2]
_02007830:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start MPlayOpen
MPlayOpen: @ 0x02007844
	push {r4, r5, r6, r7, lr}
	adds r7, r0, #0
	adds r6, r1, #0
	lsls r2, r2, #0x18
	lsrs r4, r2, #0x18
	cmp r4, #0
	beq _020078A8
	cmp r4, #0x10
	bls _02007858
	movs r4, #0x10
_02007858:
	ldr r0, =SOUND_INFO_PTR
	ldr r5, [r0]
	ldr r1, [r5]
	ldr r0, =ID_NUMBER
	cmp r1, r0
	bne _020078A8
	adds r0, r1, #1
	str r0, [r5]
	adds r0, r7, #0
	bl Clear64byte
	str r6, [r7, #0x2c]
	strb r4, [r7, #8]
	movs r0, #0x80
	lsls r0, r0, #0x18
	str r0, [r7, #4]
	cmp r4, #0
	beq _0200788C
	movs r1, #0
_0200787E:
	strb r1, [r6]
	subs r0, r4, #1
	lsls r0, r0, #0x18
	lsrs r4, r0, #0x18
	adds r6, #0x50
	cmp r4, #0
	bne _0200787E
_0200788C:
	ldr r0, [r5, #0x20]
	cmp r0, #0
	beq _0200789C
	str r0, [r7, #0x38]
	ldr r0, [r5, #0x24]
	str r0, [r7, #0x3c]
	movs r0, #0
	str r0, [r5, #0x20]
_0200789C:
	str r7, [r5, #0x24]
	ldr r0, =MPlayMain
	str r0, [r5, #0x20]
	ldr r0, =ID_NUMBER
	str r0, [r5]
	str r0, [r7, #0x34]
_020078A8:
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start MPlayStart
MPlayStart: @ 0x020078BC
	push {r4, r5, r6, r7, lr}
	mov r7, r8
	push {r7}
	adds r5, r0, #0
	adds r7, r1, #0
	ldr r1, [r5, #0x34]
	ldr r0, =ID_NUMBER
	cmp r1, r0
	bne _02007962
	adds r0, r1, #1
	str r0, [r5, #0x34]
	movs r1, #0
	str r1, [r5, #4]
	str r7, [r5]
	ldr r0, [r7, #4]
	str r0, [r5, #0x30]
	ldrb r0, [r7, #2]
	strb r0, [r5, #9]
	str r1, [r5, #0xc]
	movs r0, #0x96
	strh r0, [r5, #0x1c]
	strh r0, [r5, #0x20]
	adds r0, #0x6a
	strh r0, [r5, #0x1e]
	strh r1, [r5, #0x22]
	strh r1, [r5, #0x24]
	movs r6, #0
	ldr r4, [r5, #0x2c]
	ldrb r0, [r7]
	cmp r6, r0
	bge _0200792E
	ldrb r1, [r5, #8]
	cmp r6, r1
	bge _0200794E
	mov r8, r6
_02007902:
	adds r0, r5, #0
	adds r1, r4, #0
	bl TrackStop
	movs r0, #0xc0
	strb r0, [r4]
	mov r0, r8
	str r0, [r4, #0x20]
	lsls r1, r6, #2
	adds r0, r7, #0
	adds r0, #8
	adds r0, r0, r1
	ldr r0, [r0]
	str r0, [r4, #0x40]
	adds r6, #1
	adds r4, #0x50
	ldrb r1, [r7]
	cmp r6, r1
	bge _0200792E
	ldrb r0, [r5, #8]
	cmp r6, r0
	blt _02007902
_0200792E:
	ldrb r1, [r5, #8]
	cmp r6, r1
	bge _0200794E
	movs r0, #0
	mov r8, r0
_02007938:
	adds r0, r5, #0
	adds r1, r4, #0
	bl TrackStop
	mov r1, r8
	strb r1, [r4]
	adds r6, #1
	adds r4, #0x50
	ldrb r0, [r5, #8]
	cmp r6, r0
	blt _02007938
_0200794E:
	movs r0, #0x80
	ldrb r1, [r7, #3]
	ands r0, r1
	cmp r0, #0
	beq _0200795E
	ldrb r0, [r7, #3]
	bl m4aSoundMode
_0200795E:
	ldr r0, =ID_NUMBER
	str r0, [r5, #0x34]
_02007962:
	pop {r3}
	mov r8, r3
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start m4aMPlayStop
m4aMPlayStop: @ 0x02007970
	push {r4, r5, r6, lr}
	adds r6, r0, #0
	ldr r1, [r6, #0x34]
	ldr r0, =ID_NUMBER
	cmp r1, r0
	bne _020079A6
	adds r0, r1, #1
	str r0, [r6, #0x34]
	ldr r0, [r6, #4]
	movs r1, #0x80
	lsls r1, r1, #0x18
	orrs r0, r1
	str r0, [r6, #4]
	ldrb r4, [r6, #8]
	ldr r5, [r6, #0x2c]
	cmp r4, #0
	ble _020079A2
_02007992:
	adds r0, r6, #0
	adds r1, r5, #0
	bl TrackStop
	subs r4, #1
	adds r5, #0x50
	cmp r4, #0
	bgt _02007992
_020079A2:
	ldr r0, =ID_NUMBER
	str r0, [r6, #0x34]
_020079A6:
	pop {r4, r5, r6}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start FadeOutBody
FadeOutBody: @ 0x020079B0
	push {r4, r5, r6, r7, lr}
	adds r6, r0, #0
	ldrh r2, [r6, #0x24]
	cmp r2, #0
	beq _02007A2A
	ldrh r0, [r6, #0x26]
	subs r0, #1
	strh r0, [r6, #0x26]
	ldr r3, =0x0000FFFF
	adds r1, r3, #0
	lsls r0, r0, #0x10
	cmp r0, #0
	bne _02007A2A
	ldrh r0, [r6, #0x28]
	subs r0, #0x10
	strh r0, [r6, #0x28]
	ands r0, r1
	lsls r0, r0, #0x10
	cmp r0, #0
	bgt _020079FC
	ldrb r5, [r6, #8]
	ldr r4, [r6, #0x2c]
	cmp r5, #0
	ble _02007A2A
	movs r7, #0
_020079E2:
	adds r0, r6, #0
	adds r1, r4, #0
	bl TrackStop
	strb r7, [r4]
	subs r5, #1
	adds r4, #0x50
	cmp r5, #0
	bgt _020079E2
	b _02007A2A
	.align 2, 0
	.pool
_020079FC:
	strh r2, [r6, #0x26]
	ldrb r5, [r6, #8]
	ldr r4, [r6, #0x2c]
	cmp r5, #0
	ble _02007A2A
	movs r3, #0x80
	movs r7, #0
	movs r2, #3
_02007A0C:
	ldrb r1, [r4]
	adds r0, r3, #0
	ands r0, r1
	cmp r0, #0
	beq _02007A22
	ldrh r7, [r6, #0x28]
	lsrs r0, r7, #2
	strb r0, [r4, #0x13]
	adds r0, r1, #0
	orrs r0, r2
	strb r0, [r4]
_02007A22:
	subs r5, #1
	adds r4, #0x50
	cmp r5, #0
	bgt _02007A0C
_02007A2A:
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0

	thumb_func_start TrkVolPitSet
TrkVolPitSet: @ 0x02007A30
	push {r4, lr}
	adds r2, r1, #0
	movs r0, #1
	ldrb r1, [r2]
	ands r0, r1
	cmp r0, #0
	beq _02007AA8
	ldrb r3, [r2, #0x13]
	ldrb r1, [r2, #0x12]
	adds r0, r3, #0
	muls r0, r1, r0
	lsrs r3, r0, #5
	ldrb r4, [r2, #0x18]
	cmp r4, #1
	bne _02007A58
	movs r0, #0x16
	ldrsb r0, [r2, r0]
	adds r0, #0x80
	muls r0, r3, r0
	lsrs r3, r0, #7
_02007A58:
	movs r0, #0x14
	ldrsb r0, [r2, r0]
	lsls r0, r0, #1
	movs r1, #0x15
	ldrsb r1, [r2, r1]
	adds r1, r0, r1
	cmp r4, #2
	bne _02007A6E
	movs r0, #0x16
	ldrsb r0, [r2, r0]
	adds r1, r1, r0
_02007A6E:
	movs r0, #0x80
	rsbs r0, r0, #0
	cmp r1, r0
	bge _02007A7A
	adds r1, r0, #0
	b _02007A80
_02007A7A:
	cmp r1, #0x7f
	ble _02007A80
	movs r1, #0x7f
_02007A80:
	adds r0, r1, #0
	adds r0, #0x80
	muls r0, r3, r0
	lsrs r0, r0, #8
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	cmp r0, #0xff
	bls _02007A92
	movs r0, #0xff
_02007A92:
	strb r0, [r2, #0x10]
	movs r0, #0x7f
	subs r0, r0, r1
	muls r0, r3, r0
	lsrs r0, r0, #8
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	cmp r0, #0xff
	bls _02007AA6
	movs r0, #0xff
_02007AA6:
	strb r0, [r2, #0x11]
_02007AA8:
	ldrb r1, [r2]
	movs r0, #4
	ands r0, r1
	adds r3, r1, #0
	cmp r0, #0
	beq _02007AEC
	movs r0, #0xe
	ldrsb r0, [r2, r0]
	ldrb r1, [r2, #0xf]
	muls r0, r1, r0
	movs r1, #0xc
	ldrsb r1, [r2, r1]
	adds r1, r1, r0
	lsls r1, r1, #2
	movs r0, #0xa
	ldrsb r0, [r2, r0]
	lsls r0, r0, #8
	adds r1, r1, r0
	movs r0, #0xb
	ldrsb r0, [r2, r0]
	lsls r0, r0, #8
	adds r1, r1, r0
	ldrb r0, [r2, #0xd]
	adds r1, r0, r1
	ldrb r0, [r2, #0x18]
	cmp r0, #0
	bne _02007AE6
	movs r0, #0x16
	ldrsb r0, [r2, r0]
	lsls r0, r0, #4
	adds r1, r1, r0
_02007AE6:
	asrs r0, r1, #8
	strb r0, [r2, #8]
	strb r1, [r2, #9]
_02007AEC:
	movs r0, #0xfa
	ands r0, r3
	strb r0, [r2]
	pop {r4}
	pop {r0}
	bx r0

	thumb_func_start MidiKeyToCgbFreq
MidiKeyToCgbFreq: @ 0x02007AF8
	push {r4, r5, r6, r7, lr}
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	lsls r1, r1, #0x18
	lsrs r5, r1, #0x18
	lsls r2, r2, #0x18
	lsrs r2, r2, #0x18
	mov ip, r2
	cmp r0, #4
	bne _02007B30
	cmp r5, #0x14
	bhi _02007B14
	movs r5, #0
	b _02007B22
_02007B14:
	adds r0, r5, #0
	subs r0, #0x15
	lsls r0, r0, #0x18
	lsrs r5, r0, #0x18
	cmp r5, #0x3b
	bls _02007B22
	movs r5, #0x3b
_02007B22:
	ldr r0, =gNoiseTable
	adds r0, r5, r0
	ldrb r0, [r0]
	b _02007B92
	.align 2, 0
	.pool
_02007B30:
	cmp r5, #0x23
	bhi _02007B3C
	movs r0, #0
	mov ip, r0
	movs r5, #0
	b _02007B4E
_02007B3C:
	adds r0, r5, #0
	subs r0, #0x24
	lsls r0, r0, #0x18
	lsrs r5, r0, #0x18
	cmp r5, #0x82
	bls _02007B4E
	movs r5, #0x82
	movs r1, #0xff
	mov ip, r1
_02007B4E:
	ldr r3, =gCgbScaleTable
	adds r0, r5, r3
	ldrb r6, [r0]
	ldr r4, =gCgbFreqTable
	movs r2, #0xf
	adds r0, r6, #0
	ands r0, r2
	lsls r0, r0, #1
	adds r0, r0, r4
	movs r7, #0
	ldrsh r1, [r0, r7]
	asrs r0, r6, #4
	adds r6, r1, #0
	asrs r6, r0
	adds r0, r5, #1
	adds r0, r0, r3
	ldrb r1, [r0]
	adds r0, r1, #0
	ands r0, r2
	lsls r0, r0, #1
	adds r0, r0, r4
	movs r2, #0
	ldrsh r0, [r0, r2]
	asrs r1, r1, #4
	asrs r0, r1
	subs r0, r0, r6
	mov r7, ip
	muls r7, r0, r7
	adds r0, r7, #0
	asrs r0, r0, #8
	adds r0, r6, r0
	movs r1, #0x80
	lsls r1, r1, #4
	adds r0, r0, r1
_02007B92:
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0
	.pool

	thumb_func_start CgbOscOff
CgbOscOff: @ 0x02007BA0
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	adds r1, r0, #0
	cmp r0, #2
	beq _02007BC8
	cmp r0, #2
	bgt _02007BB4
	cmp r0, #1
	beq _02007BBA
	b _02007BDC
_02007BB4:
	cmp r1, #3
	beq _02007BD0
	b _02007BDC
_02007BBA:
	ldr r1, =0x04000063
	movs r0, #8
	strb r0, [r1]
	adds r1, #2
	b _02007BE4
	.align 2, 0
	.pool
_02007BC8:
	ldr r1, =0x04000069
	b _02007BDE
	.align 2, 0
	.pool
_02007BD0:
	ldr r1, =0x04000070
	movs r0, #0
	b _02007BE6
	.align 2, 0
	.pool
_02007BDC:
	ldr r1, =0x04000079
_02007BDE:
	movs r0, #8
	strb r0, [r1]
	adds r1, #4
_02007BE4:
	movs r0, #0x80
_02007BE6:
	strb r0, [r1]
	bx lr
	.align 2, 0
	.pool

	thumb_func_start GcbModVol
GcbModVol: @ 0x02007BF0
	push {r4, lr}
	adds r1, r0, #0
	ldrb r0, [r1, #2]
	lsls r2, r0, #0x18
	lsrs r4, r2, #0x18
	ldrb r3, [r1, #3]
	lsls r0, r3, #0x18
	lsrs r3, r0, #0x18
	cmp r4, r3
	blo _02007C10
	lsrs r0, r2, #0x19
	cmp r0, r3
	blo _02007C1C
	movs r0, #0xf
	strb r0, [r1, #0x1b]
	b _02007C2A
_02007C10:
	lsrs r0, r0, #0x19
	cmp r0, r4
	blo _02007C1C
	movs r0, #0xf0
	strb r0, [r1, #0x1b]
	b _02007C2A
_02007C1C:
	movs r0, #0xff
	strb r0, [r1, #0x1b]
	ldrb r2, [r1, #3]
	ldrb r3, [r1, #2]
	adds r0, r2, r3
	lsrs r0, r0, #4
	b _02007C3A
_02007C2A:
	ldrb r2, [r1, #3]
	ldrb r3, [r1, #2]
	adds r0, r2, r3
	lsrs r0, r0, #4
	strb r0, [r1, #0xa]
	cmp r0, #0xf
	bls _02007C3C
	movs r0, #0xf
_02007C3A:
	strb r0, [r1, #0xa]
_02007C3C:
	ldrb r2, [r1, #6]
	ldrb r3, [r1, #0xa]
	adds r0, r2, #0
	muls r0, r3, r0
	adds r0, #0xf
	asrs r0, r0, #4
	strb r0, [r1, #0x19]
	ldrb r0, [r1, #0x1c]
	ldrb r2, [r1, #0x1b]
	ands r0, r2
	strb r0, [r1, #0x1b]
	pop {r4}
	pop {r0}
	bx r0

	thumb_func_start CgbSound
CgbSound: @ 0x02007C58
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #0x20
	ldr r0, =SOUND_INFO_PTR
	ldr r0, [r0]
	str r0, [sp, #4]
	ldrb r0, [r0, #0xa]
	cmp r0, #0
	beq _02007C7C
	subs r0, #1
	ldr r1, [sp, #4]
	strb r0, [r1, #0xa]
	b _02007C82
	.align 2, 0
	.pool
_02007C7C:
	movs r0, #0xe
	ldr r2, [sp, #4]
	strb r0, [r2, #0xa]
_02007C82:
	movs r6, #1
	ldr r0, [sp, #4]
	ldr r4, [r0, #0x1c]
_02007C88:
	ldrb r1, [r4]
	movs r0, #0xc7
	ands r0, r1
	adds r2, r6, #1
	mov sb, r2
	movs r2, #0x40
	adds r2, r2, r4
	mov r8, r2
	cmp r0, #0
	bne _02007C9E
	b _02008082
_02007C9E:
	cmp r6, #2
	beq _02007CD0
	cmp r6, #2
	bgt _02007CAC
	cmp r6, #1
	beq _02007CB2
	b _02007D08
_02007CAC:
	cmp r6, #3
	beq _02007CE8
	b _02007D08
_02007CB2:
	ldr r0, =0x04000060
	str r0, [sp, #8]
	ldr r7, =0x04000062
	ldr r2, =0x04000063
	str r2, [sp, #0xc]
	adds r0, #4
	str r0, [sp, #0x10]
	adds r2, #2
	b _02007D18
	.align 2, 0
	.pool
_02007CD0:
	ldr r0, =0x04000061
	str r0, [sp, #8]
	ldr r7, =0x04000068
	ldr r2, =0x04000069
	b _02007D10
	.align 2, 0
	.pool
_02007CE8:
	ldr r0, =0x04000070
	str r0, [sp, #8]
	ldr r7, =0x04000072
	ldr r2, =0x04000073
	str r2, [sp, #0xc]
	adds r0, #4
	str r0, [sp, #0x10]
	adds r2, #2
	b _02007D18
	.align 2, 0
	.pool
_02007D08:
	ldr r0, =0x04000071
	str r0, [sp, #8]
	ldr r7, =0x04000078
	ldr r2, =0x04000079
_02007D10:
	str r2, [sp, #0xc]
	adds r0, #0xb
	str r0, [sp, #0x10]
	adds r2, #4
_02007D18:
	str r2, [sp, #0x14]
	ldr r0, [sp, #4]
	ldrb r0, [r0, #0xa]
	str r0, [sp]
	adds r2, r1, #0
	movs r0, #0x80
	mov sl, r0
	ands r0, r2
	cmp r0, #0
	beq _02007E12
	movs r3, #0x40
	adds r0, r3, #0
	ands r0, r2
	lsls r0, r0, #0x18
	lsrs r5, r0, #0x18
	adds r1, r6, #1
	mov sb, r1
	movs r2, #0x40
	adds r2, r2, r4
	mov r8, r2
	cmp r5, #0
	bne _02007E36
	movs r0, #3
	strb r0, [r4]
	strb r0, [r4, #0x1d]
	adds r0, r4, #0
	str r3, [sp, #0x1c]
	bl GcbModVol
	ldr r3, [sp, #0x1c]
	cmp r6, #2
	beq _02007D7C
	cmp r6, #2
	bgt _02007D70
	cmp r6, #1
	beq _02007D76
	b _02007DD4
	.align 2, 0
	.pool
_02007D70:
	cmp r6, #3
	beq _02007D88
	b _02007DD4
_02007D76:
	ldrb r0, [r4, #0x1f]
	ldr r1, [sp, #8]
	strb r0, [r1]
_02007D7C:
	ldr r0, [r4, #0x24]
	lsls r0, r0, #6
	ldrb r2, [r4, #0x1e]
	adds r0, r2, r0
	strb r0, [r7]
	b _02007DE0
_02007D88:
	ldr r1, [r4, #0x24]
	ldr r0, [r4, #0x28]
	cmp r1, r0
	beq _02007DB0
	ldr r0, [sp, #8]
	strb r3, [r0]
	ldr r1, =0x04000090
	ldr r2, [r4, #0x24]
	ldr r0, [r2]
	str r0, [r1]
	adds r1, #4
	ldr r0, [r2, #4]
	str r0, [r1]
	adds r1, #4
	ldr r0, [r2, #8]
	str r0, [r1]
	adds r1, #4
	ldr r0, [r2, #0xc]
	str r0, [r1]
	str r2, [r4, #0x28]
_02007DB0:
	ldr r1, [sp, #8]
	strb r5, [r1]
	ldrb r0, [r4, #0x1e]
	strb r0, [r7]
	ldrb r0, [r4, #0x1e]
	cmp r0, #0
	beq _02007DCC
	movs r0, #0xc0
	strb r0, [r4, #0x1a]
	ldrb r1, [r4, #4]
	b _02007DF6
	.align 2, 0
	.pool
_02007DCC:
	mov r2, sl
	strb r2, [r4, #0x1a]
	ldrb r1, [r4, #4]
	b _02007DF6
_02007DD4:
	ldrb r0, [r4, #0x1e]
	strb r0, [r7]
	ldr r0, [r4, #0x24]
	lsls r0, r0, #3
	ldr r1, [sp, #0x10]
	strb r0, [r1]
_02007DE0:
	ldrb r1, [r4, #4]
	adds r0, r1, #0
	adds r0, #8
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	str r0, [sp, #0x18]
	ldrb r0, [r4, #0x1e]
	cmp r0, #0
	beq _02007DF4
	movs r0, #0x40
_02007DF4:
	strb r0, [r4, #0x1a]
_02007DF6:
	movs r2, #0
	strb r1, [r4, #0xb]
	movs r0, #0xff
	ands r0, r1
	adds r1, r6, #1
	mov sb, r1
	movs r1, #0x40
	adds r1, r1, r4
	mov r8, r1
	cmp r0, #0
	bne _02007E0E
	b _02007F42
_02007E0E:
	strb r2, [r4, #9]
	b _02007F70
_02007E12:
	movs r0, #4
	ands r0, r2
	cmp r0, #0
	beq _02007E44
	ldrb r0, [r4, #0xd]
	subs r0, #1
	strb r0, [r4, #0xd]
	movs r2, #0xff
	ands r0, r2
	lsls r0, r0, #0x18
	adds r1, r6, #1
	mov sb, r1
	movs r2, #0x40
	adds r2, r2, r4
	mov r8, r2
	cmp r0, #0
	ble _02007E36
	b _02007F82
_02007E36:
	lsls r0, r6, #0x18
	lsrs r0, r0, #0x18
	bl CgbOscOff
	movs r0, #0
	strb r0, [r4]
	b _0200807E
_02007E44:
	movs r0, #0x40
	ands r0, r1
	adds r2, r6, #1
	mov sb, r2
	movs r2, #0x40
	adds r2, r2, r4
	mov r8, r2
	cmp r0, #0
	beq _02007E84
	movs r0, #3
	ands r0, r1
	cmp r0, #0
	beq _02007E84
	movs r0, #0xfc
	ands r0, r1
	movs r2, #0
	strb r0, [r4]
	ldrb r1, [r4, #7]
	strb r1, [r4, #0xb]
	movs r0, #0xff
	ands r0, r1
	cmp r0, #0
	beq _02007EB6
	movs r0, #1
	ldrb r1, [r4, #0x1d]
	orrs r0, r1
	strb r0, [r4, #0x1d]
	cmp r6, #3
	beq _02007F70
	ldrb r2, [r4, #7]
	str r2, [sp, #0x18]
	b _02007F70
_02007E84:
	ldrb r0, [r4, #0xb]
	cmp r0, #0
	bne _02007F70
	cmp r6, #3
	bne _02007E96
	movs r0, #1
	ldrb r1, [r4, #0x1d]
	orrs r0, r1
	strb r0, [r4, #0x1d]
_02007E96:
	adds r0, r4, #0
	bl GcbModVol
	movs r0, #3
	ldrb r2, [r4]
	ands r0, r2
	cmp r0, #0
	bne _02007EE2
	ldrb r0, [r4, #9]
	subs r0, #1
	strb r0, [r4, #9]
	movs r1, #0xff
	ands r0, r1
	lsls r0, r0, #0x18
	cmp r0, #0
	bgt _02007EDE
_02007EB6:
	ldrb r2, [r4, #0xc]
	ldrb r1, [r4, #0xa]
	adds r0, r2, #0
	muls r0, r1, r0
	adds r0, #0xff
	asrs r0, r0, #8
	movs r1, #0
	strb r0, [r4, #9]
	lsls r0, r0, #0x18
	cmp r0, #0
	beq _02007E36
	movs r0, #4
	ldrb r2, [r4]
	orrs r0, r2
	strb r0, [r4]
	movs r0, #1
	ldrb r1, [r4, #0x1d]
	orrs r0, r1
	strb r0, [r4, #0x1d]
	b _02007F82
_02007EDE:
	ldrb r0, [r4, #7]
	b _02007F6E
_02007EE2:
	cmp r0, #1
	bne _02007EEE
_02007EE6:
	ldrb r0, [r4, #0x19]
	strb r0, [r4, #9]
	movs r0, #7
	b _02007F6E
_02007EEE:
	cmp r0, #2
	bne _02007F32
	ldrb r0, [r4, #9]
	subs r0, #1
	strb r0, [r4, #9]
	movs r2, #0xff
	ands r0, r2
	lsls r0, r0, #0x18
	ldrb r2, [r4, #0x19]
	lsls r1, r2, #0x18
	cmp r0, r1
	bgt _02007F2E
_02007F06:
	ldrb r0, [r4, #6]
	cmp r0, #0
	bne _02007F16
	movs r0, #0xfc
	ldrb r1, [r4]
	ands r0, r1
	strb r0, [r4]
	b _02007EB6
_02007F16:
	ldrb r0, [r4]
	subs r0, #1
	strb r0, [r4]
	movs r0, #1
	ldrb r2, [r4, #0x1d]
	orrs r0, r2
	strb r0, [r4, #0x1d]
	cmp r6, #3
	beq _02007EE6
	movs r0, #8
	str r0, [sp, #0x18]
	b _02007EE6
_02007F2E:
	ldrb r0, [r4, #5]
	b _02007F6E
_02007F32:
	ldrb r0, [r4, #9]
	adds r0, #1
	strb r0, [r4, #9]
	movs r1, #0xff
	ands r0, r1
	ldrb r2, [r4, #0xa]
	cmp r0, r2
	blo _02007F6C
_02007F42:
	ldrb r0, [r4]
	subs r0, #1
	movs r2, #0
	strb r0, [r4]
	ldrb r1, [r4, #5]
	strb r1, [r4, #0xb]
	movs r0, #0xff
	ands r0, r1
	cmp r0, #0
	beq _02007F06
	movs r0, #1
	ldrb r1, [r4, #0x1d]
	orrs r0, r1
	strb r0, [r4, #0x1d]
	ldrb r0, [r4, #0xa]
	strb r0, [r4, #9]
	cmp r6, #3
	beq _02007F70
	ldrb r2, [r4, #5]
	str r2, [sp, #0x18]
	b _02007F70
_02007F6C:
	ldrb r0, [r4, #4]
_02007F6E:
	strb r0, [r4, #0xb]
_02007F70:
	ldrb r0, [r4, #0xb]
	subs r0, #1
	strb r0, [r4, #0xb]
	ldr r0, [sp]
	cmp r0, #0
	bne _02007F82
	subs r0, #1
	str r0, [sp]
	b _02007E84
_02007F82:
	movs r0, #2
	ldrb r1, [r4, #0x1d]
	ands r0, r1
	cmp r0, #0
	beq _02007FFA
	cmp r6, #3
	bgt _02007FC2
	movs r0, #8
	ldrb r2, [r4, #1]
	ands r0, r2
	cmp r0, #0
	beq _02007FC2
	ldr r0, =0x04000089
	ldrb r0, [r0]
	cmp r0, #0x3f
	bgt _02007FB4
	ldr r0, [r4, #0x20]
	adds r0, #2
	ldr r1, =0x000007FC
	b _02007FBE
	.align 2, 0
	.pool
_02007FB4:
	cmp r0, #0x7f
	bgt _02007FC2
	ldr r0, [r4, #0x20]
	adds r0, #1
	ldr r1, =0x000007FE
_02007FBE:
	ands r0, r1
	str r0, [r4, #0x20]
_02007FC2:
	cmp r6, #4
	beq _02007FD4
	ldr r0, [r4, #0x20]
	ldr r1, [sp, #0x10]
	strb r0, [r1]
	b _02007FE2
	.align 2, 0
	.pool
_02007FD4:
	ldr r2, [sp, #0x10]
	ldrb r0, [r2]
	movs r1, #8
	ands r1, r0
	ldr r0, [r4, #0x20]
	orrs r0, r1
	strb r0, [r2]
_02007FE2:
	movs r0, #0xc0
	ldrb r1, [r4, #0x1a]
	ands r0, r1
	adds r1, r4, #0
	adds r1, #0x21
	ldrb r1, [r1]
	adds r0, r1, r0
	strb r0, [r4, #0x1a]
	movs r2, #0xff
	ands r0, r2
	ldr r1, [sp, #0x14]
	strb r0, [r1]
_02007FFA:
	movs r0, #1
	ldrb r2, [r4, #0x1d]
	ands r0, r2
	cmp r0, #0
	beq _0200807E
	ldr r1, =0x04000081
	ldrb r0, [r1]
	ldrb r2, [r4, #0x1c]
	bics r0, r2
	ldrb r2, [r4, #0x1b]
	orrs r0, r2
	strb r0, [r1]
	cmp r6, #3
	bne _0200804C
	ldr r0, =gCgb3Vol
	ldrb r1, [r4, #9]
	adds r0, r1, r0
	ldrb r0, [r0]
	ldr r2, [sp, #0xc]
	strb r0, [r2]
	movs r1, #0x80
	adds r0, r1, #0
	ldrb r2, [r4, #0x1a]
	ands r0, r2
	cmp r0, #0
	beq _0200807E
	ldr r0, [sp, #8]
	strb r1, [r0]
	ldrb r0, [r4, #0x1a]
	ldr r1, [sp, #0x14]
	strb r0, [r1]
	movs r0, #0x7f
	ldrb r2, [r4, #0x1a]
	ands r0, r2
	strb r0, [r4, #0x1a]
	b _0200807E
	.align 2, 0
	.pool
_0200804C:
	movs r0, #0xf
	ldr r1, [sp, #0x18]
	ands r0, r1
	ldrb r2, [r4, #9]
	lsls r1, r2, #4
	adds r0, r0, r1
	ldr r1, [sp, #0xc]
	strb r0, [r1]
	movs r2, #0x80
	ldrb r0, [r4, #0x1a]
	orrs r0, r2
	ldr r1, [sp, #0x14]
	strb r0, [r1]
	cmp r6, #1
	bne _0200807E
	ldr r0, [sp, #8]
	ldrb r1, [r0]
	movs r0, #8
	ands r0, r1
	cmp r0, #0
	bne _0200807E
	ldrb r0, [r4, #0x1a]
	orrs r0, r2
	ldr r1, [sp, #0x14]
	strb r0, [r1]
_0200807E:
	movs r0, #0
	strb r0, [r4, #0x1d]
_02008082:
	mov r6, sb
	mov r4, r8
	cmp r6, #4
	bgt _0200808C
	b _02007C88
_0200808C:
	add sp, #0x20
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0

	thumb_func_start m4aMPlayTempoControl
m4aMPlayTempoControl: @ 0x0200809C
	push {r4, lr}
	adds r2, r0, #0
	lsls r1, r1, #0x10
	lsrs r1, r1, #0x10
	ldr r3, [r2, #0x34]
	ldr r0, =ID_NUMBER
	cmp r3, r0
	bne _020080B8
	strh r1, [r2, #0x1e]
	ldrh r4, [r2, #0x1c]
	adds r0, r1, #0
	muls r0, r4, r0
	asrs r0, r0, #8
	strh r0, [r2, #0x20]
_020080B8:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start m4aMPlayVolumeControl
m4aMPlayVolumeControl: @ 0x020080C4
	push {r4, r5, r6, r7, lr}
	mov r7, sb
	mov r6, r8
	push {r6, r7}
	adds r4, r0, #0
	lsls r1, r1, #0x10
	lsrs r7, r1, #0x10
	lsls r6, r2, #0x10
	ldr r3, [r4, #0x34]
	ldr r0, =ID_NUMBER
	cmp r3, r0
	bne _0200811C
	adds r0, r3, #1
	str r0, [r4, #0x34]
	ldrb r2, [r4, #8]
	ldr r1, [r4, #0x2c]
	movs r5, #1
	cmp r2, #0
	ble _02008118
	movs r0, #0x80
	mov r8, r0
	lsrs r6, r6, #0x12
	movs r0, #3
	mov ip, r0
_020080F4:
	adds r0, r7, #0
	ands r0, r5
	cmp r0, #0
	beq _0200810E
	ldrb r3, [r1]
	mov r0, r8
	ands r0, r3
	cmp r0, #0
	beq _0200810E
	strb r6, [r1, #0x13]
	mov r0, ip
	orrs r0, r3
	strb r0, [r1]
_0200810E:
	subs r2, #1
	adds r1, #0x50
	lsls r5, r5, #1
	cmp r2, #0
	bgt _020080F4
_02008118:
	ldr r0, =ID_NUMBER
	str r0, [r4, #0x34]
_0200811C:
	pop {r3, r4}
	mov r8, r3
	mov sb, r4
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start m4aMPlayPitchControl
m4aMPlayPitchControl: @ 0x0200812C
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	adds r4, r0, #0
	lsls r1, r1, #0x10
	lsrs r1, r1, #0x10
	mov ip, r1
	lsls r2, r2, #0x10
	lsrs r6, r2, #0x10
	ldr r3, [r4, #0x34]
	ldr r0, =ID_NUMBER
	cmp r3, r0
	bne _0200818E
	adds r0, r3, #1
	str r0, [r4, #0x34]
	ldrb r2, [r4, #8]
	ldr r3, [r4, #0x2c]
	movs r5, #1
	cmp r2, #0
	ble _0200818A
	movs r0, #0x80
	mov sb, r0
	lsls r0, r6, #0x10
	asrs r7, r0, #0x18
	movs r0, #0xc
	mov r8, r0
_02008164:
	mov r0, ip
	ands r0, r5
	cmp r0, #0
	beq _02008180
	ldrb r1, [r3]
	mov r0, sb
	ands r0, r1
	cmp r0, #0
	beq _02008180
	strb r7, [r3, #0xb]
	strb r6, [r3, #0xd]
	mov r0, r8
	orrs r0, r1
	strb r0, [r3]
_02008180:
	subs r2, #1
	adds r3, #0x50
	lsls r5, r5, #1
	cmp r2, #0
	bgt _02008164
_0200818A:
	ldr r0, =ID_NUMBER
	str r0, [r4, #0x34]
_0200818E:
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start m4aMPlayPanpotControl
m4aMPlayPanpotControl: @ 0x020081A0
	push {r4, r5, r6, r7, lr}
	mov r7, sb
	mov r6, r8
	push {r6, r7}
	adds r4, r0, #0
	lsls r1, r1, #0x10
	lsrs r7, r1, #0x10
	lsls r2, r2, #0x18
	lsrs r6, r2, #0x18
	ldr r3, [r4, #0x34]
	ldr r0, =ID_NUMBER
	cmp r3, r0
	bne _020081F8
	adds r0, r3, #1
	str r0, [r4, #0x34]
	ldrb r2, [r4, #8]
	ldr r1, [r4, #0x2c]
	movs r5, #1
	cmp r2, #0
	ble _020081F4
	movs r0, #0x80
	mov r8, r0
	movs r0, #3
	mov ip, r0
_020081D0:
	adds r0, r7, #0
	ands r0, r5
	cmp r0, #0
	beq _020081EA
	ldrb r3, [r1]
	mov r0, r8
	ands r0, r3
	cmp r0, #0
	beq _020081EA
	strb r6, [r1, #0x15]
	mov r0, ip
	orrs r0, r3
	strb r0, [r1]
_020081EA:
	subs r2, #1
	adds r1, #0x50
	lsls r5, r5, #1
	cmp r2, #0
	bgt _020081D0
_020081F4:
	ldr r0, =ID_NUMBER
	str r0, [r4, #0x34]
_020081F8:
	pop {r3, r4}
	mov r8, r3
	mov sb, r4
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start ClearModM
ClearModM: @ 0x02008208
	adds r1, r0, #0
	movs r2, #0
	movs r0, #0
	strb r0, [r1, #0x1a]
	strb r0, [r1, #0x16]
	ldrb r0, [r1, #0x18]
	cmp r0, #0
	bne _0200821C
	movs r0, #0xc
	b _0200821E
_0200821C:
	movs r0, #3
_0200821E:
	ldrb r2, [r1]
	orrs r0, r2
	strb r0, [r1]
	bx lr
	.align 2, 0

	thumb_func_start m4aMPlayModDepthSet
m4aMPlayModDepthSet: @ 0x02008228
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	adds r6, r0, #0
	lsls r1, r1, #0x10
	lsrs r1, r1, #0x10
	mov sl, r1
	lsls r2, r2, #0x18
	lsrs r2, r2, #0x18
	mov r8, r2
	ldr r1, [r6, #0x34]
	ldr r0, =ID_NUMBER
	cmp r1, r0
	bne _02008288
	adds r0, r1, #1
	str r0, [r6, #0x34]
	ldrb r5, [r6, #8]
	ldr r4, [r6, #0x2c]
	movs r7, #1
	cmp r5, #0
	ble _02008284
	mov sb, r8
_02008258:
	mov r0, sl
	ands r0, r7
	cmp r0, #0
	beq _0200827A
	movs r0, #0x80
	ldrb r1, [r4]
	ands r0, r1
	cmp r0, #0
	beq _0200827A
	mov r0, r8
	strb r0, [r4, #0x17]
	mov r1, sb
	cmp r1, #0
	bne _0200827A
	adds r0, r4, #0
	bl ClearModM
_0200827A:
	subs r5, #1
	adds r4, #0x50
	lsls r7, r7, #1
	cmp r5, #0
	bgt _02008258
_02008284:
	ldr r0, =ID_NUMBER
	str r0, [r6, #0x34]
_02008288:
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start m4aMPlayLFOSpeedSet
m4aMPlayLFOSpeedSet: @ 0x0200829C
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	adds r6, r0, #0
	lsls r1, r1, #0x10
	lsrs r1, r1, #0x10
	mov sl, r1
	lsls r2, r2, #0x18
	lsrs r2, r2, #0x18
	mov r8, r2
	ldr r1, [r6, #0x34]
	ldr r0, =ID_NUMBER
	cmp r1, r0
	bne _020082FC
	adds r0, r1, #1
	str r0, [r6, #0x34]
	ldrb r5, [r6, #8]
	ldr r4, [r6, #0x2c]
	movs r7, #1
	cmp r5, #0
	ble _020082F8
	mov sb, r8
_020082CC:
	mov r0, sl
	ands r0, r7
	cmp r0, #0
	beq _020082EE
	movs r0, #0x80
	ldrb r1, [r4]
	ands r0, r1
	cmp r0, #0
	beq _020082EE
	mov r0, r8
	strb r0, [r4, #0x19]
	mov r1, sb
	cmp r1, #0
	bne _020082EE
	adds r0, r4, #0
	bl ClearModM
_020082EE:
	subs r5, #1
	adds r4, #0x50
	lsls r7, r7, #1
	cmp r5, #0
	bgt _020082CC
_020082F8:
	ldr r0, =ID_NUMBER
	str r0, [r6, #0x34]
_020082FC:
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start ply_memacc
ply_memacc: @ 0x02008310
	push {r4, r5, r6, lr}
	adds r4, r0, #0
	adds r6, r1, #0
	ldr r1, [r6, #0x40]
	ldrb r5, [r1]
	adds r2, r1, #1
	str r2, [r6, #0x40]
	ldr r0, [r4, #0x18]
	ldrb r1, [r1, #1]
	adds r3, r1, r0
	adds r0, r2, #1
	str r0, [r6, #0x40]
	ldrb r2, [r2, #1]
	adds r0, #1
	str r0, [r6, #0x40]
	cmp r5, #0x11
	bls _02008334
	b _02008462
_02008334:
	lsls r0, r5, #2
	ldr r1, =_02008344
	adds r0, r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
	.pool
_02008344: @ jump table
	.4byte _0200838C @ case 0
	.4byte _02008390 @ case 1
	.4byte _02008398 @ case 2
	.4byte _020083A0 @ case 3
	.4byte _020083AA @ case 4
	.4byte _020083B8 @ case 5
	.4byte _020083C6 @ case 6
	.4byte _020083CE @ case 7
	.4byte _020083D6 @ case 8
	.4byte _020083DE @ case 9
	.4byte _020083E6 @ case 10
	.4byte _020083EE @ case 11
	.4byte _020083F6 @ case 12
	.4byte _02008404 @ case 13
	.4byte _02008412 @ case 14
	.4byte _02008420 @ case 15
	.4byte _0200842E @ case 16
	.4byte _0200843C @ case 17
_0200838C:
	strb r2, [r3]
	b _02008462
_02008390:
	ldrb r1, [r3]
	adds r0, r1, r2
	strb r0, [r3]
	b _02008462
_02008398:
	ldrb r1, [r3]
	subs r0, r1, r2
	strb r0, [r3]
	b _02008462
_020083A0:
	ldr r0, [r4, #0x18]
	adds r0, r0, r2
	ldrb r0, [r0]
	strb r0, [r3]
	b _02008462
_020083AA:
	ldr r0, [r4, #0x18]
	adds r0, r0, r2
	ldrb r1, [r3]
	ldrb r0, [r0]
	adds r0, r1, r0
	strb r0, [r3]
	b _02008462
_020083B8:
	ldr r0, [r4, #0x18]
	adds r0, r0, r2
	ldrb r1, [r3]
	ldrb r0, [r0]
	subs r0, r1, r0
	strb r0, [r3]
	b _02008462
_020083C6:
	ldrb r3, [r3]
	cmp r3, r2
	beq _02008448
	b _0200845C
_020083CE:
	ldrb r3, [r3]
	cmp r3, r2
	bne _02008448
	b _0200845C
_020083D6:
	ldrb r3, [r3]
	cmp r3, r2
	bhi _02008448
	b _0200845C
_020083DE:
	ldrb r3, [r3]
	cmp r3, r2
	bhs _02008448
	b _0200845C
_020083E6:
	ldrb r3, [r3]
	cmp r3, r2
	bls _02008448
	b _0200845C
_020083EE:
	ldrb r3, [r3]
	cmp r3, r2
	blo _02008448
	b _0200845C
_020083F6:
	ldr r0, [r4, #0x18]
	adds r0, r0, r2
	ldrb r3, [r3]
	ldrb r0, [r0]
	cmp r3, r0
	beq _02008448
	b _0200845C
_02008404:
	ldr r0, [r4, #0x18]
	adds r0, r0, r2
	ldrb r3, [r3]
	ldrb r0, [r0]
	cmp r3, r0
	bne _02008448
	b _0200845C
_02008412:
	ldr r0, [r4, #0x18]
	adds r0, r0, r2
	ldrb r3, [r3]
	ldrb r0, [r0]
	cmp r3, r0
	bhi _02008448
	b _0200845C
_02008420:
	ldr r0, [r4, #0x18]
	adds r0, r0, r2
	ldrb r3, [r3]
	ldrb r0, [r0]
	cmp r3, r0
	bhs _02008448
	b _0200845C
_0200842E:
	ldr r0, [r4, #0x18]
	adds r0, r0, r2
	ldrb r3, [r3]
	ldrb r0, [r0]
	cmp r3, r0
	bls _02008448
	b _0200845C
_0200843C:
	ldr r0, [r4, #0x18]
	adds r0, r0, r2
	ldrb r3, [r3]
	ldrb r0, [r0]
	cmp r3, r0
	bhs _0200845C
_02008448:
	ldr r0, =gUnknown_020229F4
	ldr r2, [r0]
	adds r0, r4, #0
	adds r1, r6, #0
	bl _call_via_r2
	b _02008462
	.align 2, 0
	.pool
_0200845C:
	ldr r0, [r6, #0x40]
	adds r0, #4
	str r0, [r6, #0x40]
_02008462:
	pop {r4, r5, r6}
	pop {r0}
	bx r0

	thumb_func_start ply_xcmd
ply_xcmd: @ 0x02008468
	push {lr}
	ldr r2, [r1, #0x40]
	ldrb r3, [r2]
	adds r2, #1
	str r2, [r1, #0x40]
	ldr r2, =gXcmdTable
	lsls r3, r3, #2
	adds r3, r3, r2
	ldr r2, [r3]
	bl _call_via_r2
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start ply_xxx
ply_xxx: @ 0x02008488
	push {lr}
	ldr r2, =gMPlayJumpTable
	ldr r2, [r2]
	bl _call_via_r2
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start ply_xwave
ply_xwave: @ 0x0200849C
	push {r4, lr}
	ldr r2, [r1, #0x40]
	ldr r0, =0xFFFFFF00
	ands r4, r0
	ldrb r0, [r2]
	orrs r4, r0
	ldrb r0, [r2, #1]
	lsls r3, r0, #8
	ldr r0, =0xFFFF00FF
	ands r4, r0
	orrs r4, r3
	ldrb r0, [r2, #2]
	lsls r3, r0, #0x10
	ldr r0, =0xFF00FFFF
	ands r4, r0
	orrs r4, r3
	ldrb r0, [r2, #3]
	lsls r3, r0, #0x18
	ldr r0, =0x00FFFFFF
	ands r4, r0
	orrs r4, r3
	str r4, [r1, #0x28]
	adds r2, #4
	str r2, [r1, #0x40]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start ply_xtype
ply_xtype: @ 0x020084E4
	ldr r0, [r1, #0x40]
	ldrb r2, [r0]
	adds r0, r1, #0
	adds r0, #0x24
	strb r2, [r0]
	ldr r0, [r1, #0x40]
	adds r0, #1
	str r0, [r1, #0x40]
	bx lr
	.align 2, 0

	thumb_func_start ply_xatta
ply_xatta: @ 0x020084F8
	ldr r0, [r1, #0x40]
	ldrb r2, [r0]
	adds r0, r1, #0
	adds r0, #0x2c
	strb r2, [r0]
	ldr r0, [r1, #0x40]
	adds r0, #1
	str r0, [r1, #0x40]
	bx lr
	.align 2, 0

	thumb_func_start ply_xdeca
ply_xdeca: @ 0x0200850C
	ldr r0, [r1, #0x40]
	ldrb r0, [r0]
	adds r2, r1, #0
	adds r2, #0x2d
	strb r0, [r2]
	ldr r0, [r1, #0x40]
	adds r0, #1
	str r0, [r1, #0x40]
	bx lr
	.align 2, 0

	thumb_func_start ply_xsust
ply_xsust: @ 0x02008520
	ldr r0, [r1, #0x40]
	ldrb r0, [r0]
	adds r2, r1, #0
	adds r2, #0x2e
	strb r0, [r2]
	ldr r0, [r1, #0x40]
	adds r0, #1
	str r0, [r1, #0x40]
	bx lr
	.align 2, 0

	thumb_func_start ply_xrele
ply_xrele: @ 0x02008534
	ldr r0, [r1, #0x40]
	ldrb r0, [r0]
	adds r2, r1, #0
	adds r2, #0x2f
	strb r0, [r2]
	ldr r0, [r1, #0x40]
	adds r0, #1
	str r0, [r1, #0x40]
	bx lr
	.align 2, 0

	thumb_func_start ply_xiecv
ply_xiecv: @ 0x02008548
	ldr r0, [r1, #0x40]
	ldrb r2, [r0]
	strb r2, [r1, #0x1e]
	adds r0, #1
	str r0, [r1, #0x40]
	bx lr

	thumb_func_start ply_xiecl
ply_xiecl: @ 0x02008554
	ldr r0, [r1, #0x40]
	ldrb r2, [r0]
	strb r2, [r1, #0x1f]
	adds r0, #1
	str r0, [r1, #0x40]
	bx lr

	thumb_func_start ply_xleng
ply_xleng: @ 0x02008560
	ldr r0, [r1, #0x40]
	ldrb r0, [r0]
	adds r2, r1, #0
	adds r2, #0x26
	strb r0, [r2]
	ldr r0, [r1, #0x40]
	adds r0, #1
	str r0, [r1, #0x40]
	bx lr
	.align 2, 0

	thumb_func_start ply_xswee
ply_xswee: @ 0x02008574
	ldr r0, [r1, #0x40]
	ldrb r0, [r0]
	adds r2, r1, #0
	adds r2, #0x27
	strb r0, [r2]
	ldr r0, [r1, #0x40]
	adds r0, #1
	str r0, [r1, #0x40]
	bx lr
	.align 2, 0

	thumb_func_start DummyFunc
DummyFunc: @ 0x02008588
	bx lr
	.align 2, 0

	.section .bss.code
	.align 2
	.global SoundMainRAM_Buffer
SoundMainRAM_Buffer:
	.space 0x400
