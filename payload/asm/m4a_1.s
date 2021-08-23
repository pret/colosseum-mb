	.include "asm/macros/function.inc"
	.include "constants/gba_constants.inc"
	.include "constants/m4a_constants.inc"
	.text
	.syntax unified

	thumb_func_start umul3232H32
umul3232H32: @ 0x020064F4
	adr r2, __umul3232H32
	bx r2
	.arm
__umul3232H32: @ 0x020064F8
	umull r2, r3, r0, r1
	add r0, r3, #0
	bx lr

	thumb_func_start SoundMain
SoundMain: @ 0x02006504
	ldr r0, =SOUND_INFO_PTR
	ldr r0, [r0]
	ldr r2, =ID_NUMBER
	ldr r3, [r0]
	cmp r2, r3
	beq _02006512
	bx lr
_02006512:
	adds r3, #1
	str r3, [r0]
	push {r4, r5, r6, r7, lr}
	mov r1, r8
	mov r2, sb
	mov r3, sl
	mov r4, fp
	push {r0, r1, r2, r3, r4}
	sub sp, #0x18
	ldrb r1, [r0, #0xc]
	cmp r1, #0
	beq _02006536
	ldr r2, _0200657C @=0x04000006
	ldrb r2, [r2]
	cmp r2, #0xa0
	bhs _02006534
	adds r2, #0xe4
_02006534:
	adds r1, r1, r2
_02006536:
	str r1, [sp, #0x14]
	ldr r3, [r0, #0x20]
	cmp r3, #0
	beq _02006546
	ldr r0, [r0, #0x24]
	bl _02006926
	ldr r0, [sp, #0x18]
_02006546:
	ldr r3, [r0, #0x28]
	bl _02006926
	ldr r0, [sp, #0x18]
	ldr r3, [r0, #0x10]
	mov r8, r3
	ldr r5, _02006580 @=0x00000350
	adds r5, r5, r0
	ldrb r4, [r0, #4]
	subs r7, r4, #1
	bls _02006566
	ldrb r1, [r0, #0xb]
	subs r1, r1, r7
	mov r2, r8
	muls r2, r1, r2
	adds r5, r5, r2
_02006566:
	str r5, [sp, #8]
	ldr r6, _02006584 @=0x00000630
	ldr r3, =SoundMainRAM_Buffer + 1
	bx r3
	.align 2, 0
	.pool
_0200657C: .4byte 0x04000006
_02006580: .4byte 0x00000350
_02006584: .4byte 0x00000630

	thumb_func_start SoundMainRAM
SoundMainRAM: @ 0x02006588
	ldrb r3, [r0, #5]
	cmp r3, #0
	beq _020065E8
	adr r1, SoundMainRAM_Reverb
	bx r1
	.align 2, 0
	.arm
SoundMainRAM_Reverb: @ 0x02006594
	cmp r4, #2
	addeq r7, r0, #0x350
	addne r7, r5, r8
	mov r4, r8
_020065A4:
	ldrsb r0, [r5, r6]
	ldrsb r1, [r5]
	add r0, r0, r1
	ldrsb r1, [r7, r6]
	add r0, r0, r1
	ldrsb r1, [r7], #1
	add r0, r0, r1
	mul r1, r0, r3
	asr r0, r1, #9
	tst r0, #0x80
	addne r0, r0, #1
	strb r0, [r5, r6]
	strb r0, [r5], #1
	subs r4, r4, #1
	bgt _020065A4
	adr r0, _02006616 + 1
	bx r0
	.thumb
_020065E8:
	movs r0, #0
	mov r1, r8
	adds r6, r6, r5
	lsrs r1, r1, #3
	blo _020065F6
	stm r5!, {r0}
	stm r6!, {r0}
_020065F6:
	lsrs r1, r1, #1
	blo _02006602
	stm r5!, {r0}
	stm r6!, {r0}
	stm r5!, {r0}
	stm r6!, {r0}
_02006602:
	stm r5!, {r0}
	stm r6!, {r0}
	stm r5!, {r0}
	stm r6!, {r0}
	stm r5!, {r0}
	stm r6!, {r0}
	stm r5!, {r0}
	stm r6!, {r0}
	subs r1, #1
	bgt _02006602
_02006616:
	ldr r4, [sp, #0x18]
	ldr r0, [r4, #0x18]
	mov ip, r0
	ldrb r0, [r4, #6]
	adds r4, #0x50
_02006620:
	str r0, [sp, #4]
	ldr r3, [r4, #0x24]
	ldr r0, [sp, #0x14]
	cmp r0, #0
	beq _02006640
	ldr r1, =0x04000006
	ldrb r1, [r1]
	cmp r1, #0xa0
	bhs _02006634
	adds r1, #0xe4
_02006634:
	cmp r1, r0
	blo _02006640
	b _02006912
	.align 2, 0
	.pool
_02006640:
	ldrb r6, [r4]
	movs r0, #0xc7
	tst r0, r6
	bne _0200664A
	b _02006908
_0200664A:
	movs r0, #0x80
	tst r0, r6
	beq _0200667A
	movs r0, #0x40
	tst r0, r6
	bne _0200668A
	movs r6, #3
	strb r6, [r4]
	adds r0, r3, #0
	adds r0, #0x10
	str r0, [r4, #0x28]
	ldr r0, [r3, #0xc]
	str r0, [r4, #0x18]
	movs r5, #0
	strb r5, [r4, #9]
	str r5, [r4, #0x1c]
	ldrb r2, [r3, #3]
	movs r0, #0xc0
	tst r0, r2
	beq _020066D2
	movs r0, #0x10
	orrs r6, r0
	strb r6, [r4]
	b _020066D2
_0200667A:
	ldrb r5, [r4, #9]
	movs r0, #4
	tst r0, r6
	beq _02006690
	ldrb r0, [r4, #0xd]
	subs r0, #1
	strb r0, [r4, #0xd]
	bhi _020066E0
_0200668A:
	movs r0, #0
	strb r0, [r4]
	b _02006908
_02006690:
	movs r0, #0x40
	tst r0, r6
	beq _020066B0
	ldrb r0, [r4, #7]
	muls r5, r0, r5
	lsrs r5, r5, #8
	ldrb r0, [r4, #0xc]
	cmp r5, r0
	bhi _020066E0
_020066A2:
	ldrb r5, [r4, #0xc]
	cmp r5, #0
	beq _0200668A
	movs r0, #4
	orrs r6, r0
	strb r6, [r4]
	b _020066E0
_020066B0:
	movs r2, #3
	ands r2, r6
	cmp r2, #2
	bne _020066CE
	ldrb r0, [r4, #5]
	muls r5, r0, r5
	lsrs r5, r5, #8
	ldrb r0, [r4, #6]
	cmp r5, r0
	bhi _020066E0
	adds r5, r0, #0
	beq _020066A2
	subs r6, #1
	strb r6, [r4]
	b _020066E0
_020066CE:
	cmp r2, #3
	bne _020066E0
_020066D2:
	ldrb r0, [r4, #4]
	adds r5, r5, r0
	cmp r5, #0xff
	blo _020066E0
	movs r5, #0xff
	subs r6, #1
	strb r6, [r4]
_020066E0:
	strb r5, [r4, #9]
	ldr r0, [sp, #0x18]
	ldrb r0, [r0, #7]
	adds r0, #1
	muls r0, r5, r0
	lsrs r5, r0, #4
	ldrb r0, [r4, #2]
	muls r0, r5, r0
	lsrs r0, r0, #8
	strb r0, [r4, #0xa]
	ldrb r0, [r4, #3]
	muls r0, r5, r0
	lsrs r0, r0, #8
	strb r0, [r4, #0xb]
	movs r0, #0x10
	ands r0, r6
	str r0, [sp, #0x10]
	beq _02006714
	adds r0, r3, #0
	adds r0, #0x10
	ldr r1, [r3, #8]
	adds r0, r0, r1
	str r0, [sp, #0xc]
	ldr r0, [r3, #0xc]
	subs r0, r0, r1
	str r0, [sp, #0x10]
_02006714:
	ldr r5, [sp, #8]
	ldr r2, [r4, #0x18]
	ldr r3, [r4, #0x28]
	adr r0, _02006720
	bx r0
	.align 2, 0
	.arm
_02006720: @ 0x02006720
	str r8, [sp]
	ldrb sl, [r4, #0xa]
	lsl sl, sl, #0x10
	ldrb fp, [r4, #0xb]
	lsl fp, fp, #0x10
	ldrb r0, [r4, #1]
	tst r0, #8
	beq _02006860
_02006740:
	cmp r2, #4
	ble _020067B0
	subs r2, r2, r8
	movgt lr, #0
	bgt _0200676C
	mov lr, r8
	add r2, r2, r8
	sub r8, r2, #4
	sub lr, lr, r8
	ands r2, r2, #3
	moveq r2, #4
_0200676C:
	ldr r6, [r5]
	ldr r7, [r5, #0x630]
_02006774:
	ldrsb r0, [r3], #1
	mul r1, sl, r0
	bic r1, r1, #0xff0000
	add r6, r1, r6, ror #8
	mul r1, fp, r0
	bic r1, r1, #0xff0000
	add r7, r1, r7, ror #8
	adds r5, r5, #0x40000000
	blo _02006774
	str r7, [r5, #0x630]
	str r6, [r5], #4
	subs r8, r8, #4
	bgt _0200676C
	adds r8, r8, lr
	beq _020068F4
_020067B0:
	ldr r6, [r5]
	ldr r7, [r5, #0x630]
_020067B8:
	ldrsb r0, [r3], #1
	mul r1, sl, r0
	bic r1, r1, #0xff0000
	add r6, r1, r6, ror #8
	mul r1, fp, r0
	bic r1, r1, #0xff0000
	add r7, r1, r7, ror #8
	subs r2, r2, #1
	beq _02006828
_020067DC:
	adds r5, r5, #0x40000000
	blo _020067B8
	str r7, [r5, #0x630]
	str r6, [r5], #4
	subs r8, r8, #4
	bgt _02006740
	b _020068F4
_020067F8:
	ldr r0, [sp, #0x18]
	cmp r0, #0
	beq _0200681C
	ldr r3, [sp, #0x14]
	rsb sb, r2, #0
_0200680C:
	adds r2, r0, r2
	bgt _020068C4
	sub sb, sb, r0
	b _0200680C
_0200681C:
	pop {r4, ip}
	mov r2, #0
	b _02006838
_02006828:
	ldr r2, [sp, #0x10]
	cmp r2, #0
	ldrne r3, [sp, #0xc]
	bne _020067DC
_02006838:
	strb r2, [r4]
	lsr r0, r5, #0x1e
	bic r5, r5, #0xc0000000
	rsb r0, r0, #3
	lsl r0, r0, #3
	ror r6, r6, r0
	ror r7, r7, r0
	str r7, [r5, #0x630]
	str r6, [r5], #4
	b _020068FC
_02006860:
	push {r4, ip}
	ldr lr, [r4, #0x1c]
	ldr r1, [r4, #0x20]
	mul r4, ip, r1
	ldrsb r0, [r3]
	ldrsb r1, [r3, #1]!
	sub r1, r1, r0
_0200687C:
	ldr r6, [r5]
	ldr r7, [r5, #0x630]
_02006884:
	mul sb, lr, r1
	add sb, r0, sb, asr #23
	mul ip, sl, sb
	bic ip, ip, #0xff0000
	add r6, ip, r6, ror #8
	mul ip, fp, sb
	bic ip, ip, #0xff0000
	add r7, ip, r7, ror #8
	add lr, lr, r4
	lsrs sb, lr, #0x17
	beq _020068D0
	bic lr, lr, #0x3f800000
	subs r2, r2, sb
	ble _020067F8
	subs sb, sb, #1
	addeq r0, r0, r1
_020068C4:
	ldrsbne r0, [r3, sb]!
	ldrsb r1, [r3, #1]!
	sub r1, r1, r0
_020068D0:
	adds r5, r5, #0x40000000
	blo _02006884
	str r7, [r5, #0x630]
	str r6, [r5], #4
	subs r8, r8, #4
	bgt _0200687C
	sub r3, r3, #1
	pop {r4, ip}
	str lr, [r4, #0x1c]
_020068F4:
	str r2, [r4, #0x18]
	str r3, [r4, #0x28]
_020068FC:
	ldr r8, [sp]
	adr r0, _02006908+1
	bx r0
	.thumb
_02006908:
	ldr r0, [sp, #4]
	subs r0, #1
	ble _02006912
	adds r4, #0x40
	b _02006620
_02006912:
	ldr r0, [sp, #0x18]
	ldr r3, =ID_NUMBER
	str r3, [r0]
	add sp, #0x1c
	pop {r0, r1, r2, r3, r4, r5, r6, r7}
	mov r8, r0
	mov sb, r1
	mov sl, r2
	mov fp, r3
	pop {r3}
_02006926:
	bx r3
	.align 2, 0
	.pool

	thumb_func_start SoundMainBTM
SoundMainBTM: @ 0x0200692C
	mov ip, r4
	movs r1, #0
	movs r2, #0
	movs r3, #0
	movs r4, #0
	stm r0!, {r1, r2, r3, r4}
	stm r0!, {r1, r2, r3, r4}
	stm r0!, {r1, r2, r3, r4}
	stm r0!, {r1, r2, r3, r4}
	mov r4, ip
	bx lr
	.align 2, 0

	thumb_func_start RealClearChain
RealClearChain: @ 0x02006944
	ldr r3, [r0, #0x2c]
	cmp r3, #0
	beq _02006962
	ldr r1, [r0, #0x34]
	ldr r2, [r0, #0x30]
	cmp r2, #0
	beq _02006956
	str r1, [r2, #0x34]
	b _02006958
_02006956:
	str r1, [r3, #0x20]
_02006958:
	cmp r1, #0
	beq _0200695E
	str r2, [r1, #0x30]
_0200695E:
	movs r1, #0
	str r1, [r0, #0x2c]
_02006962:
	bx lr

	thumb_func_start ply_fine
ply_fine:
	push {r4, r5, lr}
	adds r5, r1, #0
	ldr r4, [r5, #0x20]
	cmp r4, #0
	beq _02006988
_0200696E:
	ldrb r1, [r4]
	movs r0, #0xc7
	tst r0, r1
	beq _0200697C
	movs r0, #0x40
	orrs r1, r0
	strb r1, [r4]
_0200697C:
	adds r0, r4, #0
	bl RealClearChain
	ldr r4, [r4, #0x34]
	cmp r4, #0
	bne _0200696E
_02006988:
	movs r0, #0
	strb r0, [r5]
	pop {r4, r5}
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start MPlayJumpTableCopy
MPlayJumpTableCopy: @ 0x02006994
	mov ip, lr
	movs r1, #0x24
	ldr r2, =gMPlayJumpTableTemplate
_0200699A:
	ldr r3, [r2]
	bl chk_adr_r2
	stm r0!, {r3}
	adds r2, #4
	subs r1, #1
	bgt _0200699A
	bx ip
	.align 2, 0

	thumb_func_start ldrb_r3_r2
ldrb_r3_r2: @ 0x020069AC
	ldrb r3, [r2]
chk_adr_r2:
	push {r0}
	lsrs r0, r2, #0x19
	bne _020069C0
	ldr r0, =gMPlayJumpTableTemplate
	cmp r2, r0
	blo _020069BE
	lsrs r0, r2, #0xe
	beq _020069C0
_020069BE:
	movs r3, #0
_020069C0:
	pop {r0}
	bx lr
	.align 2, 0
	.pool

	thumb_func_start ld_r3_tp_adr_i
ld_r3_tp_adr_i: @ 0x020069C8
	ldr r2, [r1, #0x40]
_020069CA:
	adds r3, r2, #1
	str r3, [r1, #0x40]
	ldrb r3, [r2]
	b chk_adr_r2

	thumb_func_start ply_goto
ply_goto:
	push {lr}
_020069D6:
	ldr r2, [r1, #0x40]
	ldrb r0, [r2, #3]
	lsls r0, r0, #8
	ldrb r3, [r2, #2]
	orrs r0, r3
	lsls r0, r0, #8
	ldrb r3, [r2, #1]
	orrs r0, r3
	lsls r0, r0, #8
	bl ldrb_r3_r2
	orrs r0, r3
	str r0, [r1, #0x40]
	pop {r0}
	bx r0

	thumb_func_start ply_patt
ply_patt: @ 0x020069F4
	ldrb r2, [r1, #2]
	cmp r2, #3
	bhs _02006A0C
	lsls r2, r2, #2
	adds r3, r1, r2
	ldr r2, [r1, #0x40]
	adds r2, #4
	str r2, [r3, #0x44]
	ldrb r2, [r1, #2]
	adds r2, #1
	strb r2, [r1, #2]
	b ply_goto
_02006A0C:
	b ply_fine
	.align 2, 0

	thumb_func_start ply_pend
ply_pend: @ 0x02006A10
	ldrb r2, [r1, #2]
	cmp r2, #0
	beq _02006A22
	subs r2, #1
	strb r2, [r1, #2]
	lsls r2, r2, #2
	adds r3, r1, r2
	ldr r2, [r3, #0x44]
	str r2, [r1, #0x40]
_02006A22:
	bx lr

	thumb_func_start ply_rept
ply_rept: @ 0x02006A24
	push {lr}
	ldr r2, [r1, #0x40]
	ldrb r3, [r2]
	cmp r3, #0
	bne _02006A34
	adds r2, #1
	str r2, [r1, #0x40]
	b _020069D6
_02006A34:
	ldrb r3, [r1, #3]
	adds r3, #1
	strb r3, [r1, #3]
	mov ip, r3
	bl ld_r3_tp_adr_i
	cmp ip, r3
	bhs _02006A46
	b _020069D6
_02006A46:
	movs r3, #0
	strb r3, [r1, #3]
	adds r2, #5
	str r2, [r1, #0x40]
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start ply_prio
ply_prio: @ 0x02006A54
	mov ip, lr
	bl ld_r3_tp_adr_i
	strb r3, [r1, #0x1d]
	bx ip
	.align 2, 0

	thumb_func_start ply_tempo
ply_tempo: @ 0x02006A60
	mov ip, lr
	bl ld_r3_tp_adr_i
	lsls r3, r3, #1
	strh r3, [r0, #0x1c]
	ldrh r2, [r0, #0x1e]
	muls r3, r2, r3
	lsrs r3, r3, #8
	strh r3, [r0, #0x20]
	bx ip

	thumb_func_start ply_keysh
ply_keysh: @ 0x02006A74
	mov ip, lr
	bl ld_r3_tp_adr_i
	strb r3, [r1, #0xa]
	ldrb r3, [r1]
	movs r2, #0xc
	orrs r3, r2
	strb r3, [r1]
	bx ip
	.align 2, 0

	thumb_func_start ply_voice
ply_voice: @ 0x02006A88
	mov ip, lr
	ldr r2, [r1, #0x40]
	ldrb r3, [r2]
	adds r2, #1
	str r2, [r1, #0x40]
	lsls r2, r3, #1
	adds r2, r2, r3
	lsls r2, r2, #2
	ldr r3, [r0, #0x30]
	adds r2, r2, r3
	ldr r3, [r2]
	bl chk_adr_r2
	str r3, [r1, #0x24]
	ldr r3, [r2, #4]
	bl chk_adr_r2
	str r3, [r1, #0x28]
	ldr r3, [r2, #8]
	bl chk_adr_r2
	str r3, [r1, #0x2c]
	bx ip
	.align 2, 0

	thumb_func_start ply_vol
ply_vol: @ 0x02006AB8
	mov ip, lr
	bl ld_r3_tp_adr_i
	strb r3, [r1, #0x12]
	ldrb r3, [r1]
	movs r2, #3
	orrs r3, r2
	strb r3, [r1]
	bx ip
	.align 2, 0

	thumb_func_start ply_pan
ply_pan: @ 0x02006ACC
	mov ip, lr
	bl ld_r3_tp_adr_i
	subs r3, #0x40
	strb r3, [r1, #0x14]
	ldrb r3, [r1]
	movs r2, #3
	orrs r3, r2
	strb r3, [r1]
	bx ip

	thumb_func_start ply_bend
ply_bend: @ 0x02006AE0
	mov ip, lr
	bl ld_r3_tp_adr_i
	subs r3, #0x40
	strb r3, [r1, #0xe]
	ldrb r3, [r1]
	movs r2, #0xc
	orrs r3, r2
	strb r3, [r1]
	bx ip

	thumb_func_start ply_bendr
ply_bendr: @ 0x02006AF4
	mov ip, lr
	bl ld_r3_tp_adr_i
	strb r3, [r1, #0xf]
	ldrb r3, [r1]
	movs r2, #0xc
	orrs r3, r2
	strb r3, [r1]
	bx ip
	.align 2, 0

	thumb_func_start ply_lfodl
ply_lfodl: @ 0x02006B08
	mov ip, lr
	bl ld_r3_tp_adr_i
	strb r3, [r1, #0x1b]
	bx ip
	.align 2, 0

	thumb_func_start ply_modt
ply_modt: @ 0x02006B14
	mov ip, lr
	bl ld_r3_tp_adr_i
	ldrb r0, [r1, #0x18]
	cmp r0, r3
	beq _02006B2A
	strb r3, [r1, #0x18]
	ldrb r3, [r1]
	movs r2, #0xf
	orrs r3, r2
	strb r3, [r1]
_02006B2A:
	bx ip

	thumb_func_start ply_tune
ply_tune: @ 0x02006B2C
	mov ip, lr
	bl ld_r3_tp_adr_i
	subs r3, #0x40
	strb r3, [r1, #0xc]
	ldrb r3, [r1]
	movs r2, #0xc
	orrs r3, r2
	strb r3, [r1]
	bx ip

	thumb_func_start ply_port
ply_port: @ 0x02006B40
	mov ip, lr
	ldr r2, [r1, #0x40]
	ldrb r3, [r2]
	adds r2, #1
	ldr r0, =0x04000060
	adds r0, r0, r3
	bl _020069CA
	strb r3, [r0]
	bx ip
	.align 2, 0
	.pool

	thumb_func_start m4aSoundVSync
m4aSoundVSync: @ 0x02006B58
	ldr r0, _02006DF4 @=SOUND_INFO_PTR
	ldr r0, [r0]
	ldr r2, _02006DF8 @=ID_NUMBER
	ldr r3, [r0]
	subs r3, r3, r2
	cmp r3, #1
	bhi _02006B84
	ldrb r1, [r0, #4]
	subs r1, #1
	strb r1, [r0, #4]
	bgt _02006B84
	ldrb r1, [r0, #0xb]
	strb r1, [r0, #4]
	movs r0, #0
	movs r1, #0xb6
	lsls r1, r1, #8
	ldr r2, =0x040000C6
	ldr r3, =0x040000D2
	strh r0, [r2]
	strh r0, [r3]
	strh r1, [r2]
	strh r1, [r3]
_02006B84:
	bx lr
	.align 2, 0
	.pool

	thumb_func_start MPlayMain
MPlayMain: @ 0x02006B90
	ldr r2,_02006DF8 @=ID_NUMBER
	ldr r3, [r0, #0x34]
	cmp r2, r3
	beq _02006B9A
	bx lr
_02006B9A:
	adds r3, #1
	str r3, [r0, #0x34]
	push {r0, lr}
	ldr r3, [r0, #0x38]
	cmp r3, #0
	beq _02006BAC
	ldr r0, [r0, #0x3c]
	bl call_r3
_02006BAC:
	pop {r0}
	push {r4, r5, r6, r7}
	mov r4, r8
	mov r5, sb
	mov r6, sl
	mov r7, fp
	push {r4, r5, r6, r7}
	adds r7, r0, #0
	ldr r0, [r7, #4]
	cmp r0, #0
	bge _02006BC4
	b _02006DDC
_02006BC4:
	ldr r0, _02006DF4 @=SOUND_INFO_PTR
	ldr r0, [r0]
	mov r8, r0
	adds r0, r7, #0
	bl FadeOutBody
	ldrh r0, [r7, #0x22]
	ldrh r1, [r7, #0x20]
	adds r0, r0, r1
	b _02006D20
_02006BD8:
	ldrb r6, [r7, #8]
	ldr r5, [r7, #0x2c]
	movs r3, #1
	movs r4, #0
_02006BE0:
	ldrb r0, [r5]
	movs r1, #0x80
	tst r1, r0
	bne _02006BEA
	b _02006CFC
_02006BEA:
	mov sl, r3
	orrs r4, r3
	mov fp, r4
	ldr r4, [r5, #0x20]
	cmp r4, #0
	beq _02006C1E
_02006BF6:
	ldrb r1, [r4]
	movs r0, #0xc7
	tst r0, r1
	beq _02006C12
	ldrb r0, [r4, #0x10]
	cmp r0, #0
	beq _02006C18
	subs r0, #1
	strb r0, [r4, #0x10]
	bne _02006C18
	movs r0, #0x40
	orrs r1, r0
	strb r1, [r4]
	b _02006C18
_02006C12:
	adds r0, r4, #0
	bl ClearChain
_02006C18:
	ldr r4, [r4, #0x34]
	cmp r4, #0
	bne _02006BF6
_02006C1E:
	ldrb r3, [r5]
	movs r0, #0x40
	tst r0, r3
	beq _02006C9C
	adds r0, r5, #0
	bl Clear64byte
	movs r0, #0x80
	strb r0, [r5]
	movs r0, #2
	strb r0, [r5, #0xf]
	movs r0, #0x40
	strb r0, [r5, #0x13]
	movs r0, #0x16
	strb r0, [r5, #0x19]
	movs r0, #1
	adds r1, r5, #6
	strb r0, [r1, #0x1e]
	b _02006C9C
_02006C44:
	ldr r2, [r5, #0x40]
	ldrb r1, [r2]
	cmp r1, #0x80
	bhs _02006C50
	ldrb r1, [r5, #7]
	b _02006C5A
_02006C50:
	adds r2, #1
	str r2, [r5, #0x40]
	cmp r1, #0xbd
	blo _02006C5A
	strb r1, [r5, #7]
_02006C5A:
	cmp r1, #0xcf
	blo _02006C70
	mov r0, r8
	ldr r3, [r0, #0x38]
	adds r0, r1, #0
	subs r0, #0xcf
	adds r1, r7, #0
	adds r2, r5, #0
	bl call_r3
	b _02006C9C
_02006C70:
	cmp r1, #0xb0
	bls _02006C92
	adds r0, r1, #0
	subs r0, #0xb1
	strb r0, [r7, #0xa]
	mov r3, r8
	ldr r3, [r3, #0x34]
	lsls r0, r0, #2
	ldr r3, [r3, r0]
	adds r0, r7, #0
	adds r1, r5, #0
	bl call_r3
	ldrb r0, [r5]
	cmp r0, #0
	beq _02006CF8
	b _02006C9C
_02006C92:
	ldr r0, =gClockTable
	subs r1, #0x80
	adds r1, r1, r0
	ldrb r0, [r1]
	strb r0, [r5, #1]
_02006C9C:
	ldrb r0, [r5, #1]
	cmp r0, #0
	beq _02006C44
	subs r0, #1
	strb r0, [r5, #1]
	ldrb r1, [r5, #0x19]
	cmp r1, #0
	beq _02006CF8
	ldrb r0, [r5, #0x17]
	cmp r0, #0
	beq _02006CF8
	ldrb r0, [r5, #0x1c]
	cmp r0, #0
	beq _02006CBE
	subs r0, #1
	strb r0, [r5, #0x1c]
	b _02006CF8
_02006CBE:
	ldrb r0, [r5, #0x1a]
	adds r0, r0, r1
	strb r0, [r5, #0x1a]
	adds r1, r0, #0
	subs r0, #0x40
	lsls r0, r0, #0x18
	bpl _02006CD2
	lsls r2, r1, #0x18
	asrs r2, r2, #0x18
	b _02006CD6
_02006CD2:
	movs r0, #0x80
	subs r2, r0, r1
_02006CD6:
	ldrb r0, [r5, #0x17]
	muls r0, r2, r0
	asrs r2, r0, #6
	ldrb r0, [r5, #0x16]
	eors r0, r2
	lsls r0, r0, #0x18
	beq _02006CF8
	strb r2, [r5, #0x16]
	ldrb r0, [r5]
	ldrb r1, [r5, #0x18]
	cmp r1, #0
	bne _02006CF2
	movs r1, #0xc
	b _02006CF4
_02006CF2:
	movs r1, #3
_02006CF4:
	orrs r0, r1
	strb r0, [r5]
_02006CF8:
	mov r3, sl
	mov r4, fp
_02006CFC:
	subs r6, #1
	ble _02006D08
	movs r0, #0x50
	adds r5, r5, r0
	lsls r3, r3, #1
	b _02006BE0
_02006D08:
	ldr r0, [r7, #0xc]
	adds r0, #1
	str r0, [r7, #0xc]
	cmp r4, #0
	bne _02006D1A
	movs r0, #0x80
	lsls r0, r0, #0x18
	str r0, [r7, #4]
	b _02006DDC
_02006D1A:
	str r4, [r7, #4]
	ldrh r0, [r7, #0x22]
	subs r0, #0x96
_02006D20:
	strh r0, [r7, #0x22]
	cmp r0, #0x96
	blo _02006D28
	b _02006BD8
_02006D28:
	ldrb r2, [r7, #8]
	ldr r5, [r7, #0x2c]
_02006D2C:
	ldrb r0, [r5]
	movs r1, #0x80
	tst r1, r0
	beq _02006DD2
	movs r1, #0xf
	tst r1, r0
	beq _02006DD2
	mov sb, r2
	adds r0, r7, #0
	adds r1, r5, #0
	bl TrkVolPitSet
	ldr r4, [r5, #0x20]
	cmp r4, #0
	beq _02006DC8
_02006D4A:
	ldrb r1, [r4]
	movs r0, #0xc7
	tst r0, r1
	bne _02006D5A
	adds r0, r4, #0
	bl ClearChain
	b _02006DC2
_02006D5A:
	ldrb r0, [r4, #1]
	movs r6, #7
	ands r6, r0
	ldrb r3, [r5]
	movs r0, #3
	tst r0, r3
	beq _02006D86
	ldrb r1, [r4, #0x12]
	ldrb r0, [r5, #0x10]
	muls r0, r1, r0
	asrs r0, r0, #7
	strb r0, [r4, #2]
	ldrb r0, [r5, #0x11]
	muls r0, r1, r0
	asrs r0, r0, #7
	strb r0, [r4, #3]
	cmp r6, #0
	beq _02006D86
	ldrb r0, [r4, #0x1d]
	movs r1, #1
	orrs r0, r1
	strb r0, [r4, #0x1d]
_02006D86:
	movs r0, #0xc
	tst r0, r3
	beq _02006DC2
	ldrb r1, [r4, #8]
	movs r0, #8
	ldrsb r0, [r5, r0]
	adds r2, r1, r0
	bpl _02006D98
	movs r2, #0
_02006D98:
	cmp r6, #0
	beq _02006DB6
	mov r0, r8
	ldr r3, [r0, #0x30]
	adds r1, r2, #0
	ldrb r2, [r5, #9]
	adds r0, r6, #0
	bl call_r3
	str r0, [r4, #0x20]
	ldrb r0, [r4, #0x1d]
	movs r1, #2
	orrs r0, r1
	strb r0, [r4, #0x1d]
	b _02006DC2
_02006DB6:
	adds r1, r2, #0
	ldrb r2, [r5, #9]
	ldr r0, [r4, #0x24]
	bl MidiKeyToFreq
	str r0, [r4, #0x20]
_02006DC2:
	ldr r4, [r4, #0x34]
	cmp r4, #0
	bne _02006D4A
_02006DC8:
	ldrb r0, [r5]
	movs r1, #0xf0
	ands r0, r1
	strb r0, [r5]
	mov r2, sb
_02006DD2:
	subs r2, #1
	ble _02006DDC
	movs r0, #0x50
	adds r5, r5, r0
	bgt _02006D2C
_02006DDC:
	ldr r0, _02006DF8 @=ID_NUMBER
	str r0, [r7, #0x34]
	pop {r0, r1, r2, r3, r4, r5, r6, r7}
	mov r8, r0
	mov sb, r1
	mov sl, r2
	mov fp, r3
	pop {r3}

	thumb_func_start call_r3
call_r3: @ 0x02006DEC
	bx r3
	.align 2, 0
	.pool
_02006DF4: .4byte SOUND_INFO_PTR
_02006DF8: .4byte ID_NUMBER

	thumb_func_start TrackStop
TrackStop: @ 0x02006DFC
	push {r4, r5, r6, lr}
	adds r5, r1, #0
	ldrb r1, [r5]
	movs r0, #0x80
	tst r0, r1
	beq _02006E34
	ldr r4, [r5, #0x20]
	cmp r4, #0
	beq _02006E32
	movs r6, #0
_02006E10:
	ldrb r0, [r4]
	cmp r0, #0
	beq _02006E2A
	ldrb r0, [r4, #1]
	movs r3, #7
	ands r0, r3
	beq _02006E28
	ldr r3, =SOUND_INFO_PTR
	ldr r3, [r3]
	ldr r3, [r3, #0x2c]
	bl call_r3
_02006E28:
	strb r6, [r4]
_02006E2A:
	str r6, [r4, #0x2c]
	ldr r4, [r4, #0x34]
	cmp r4, #0
	bne _02006E10
_02006E32:
	str r4, [r5, #0x20]
_02006E34:
	pop {r4, r5, r6}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start ply_note
ply_note: @ 0x02006E40
	push {r4, r5, r6, r7, lr}
	mov r4, r8
	mov r5, sb
	mov r6, sl
	mov r7, fp
	push {r4, r5, r6, r7}
	sub sp, #0x18
	str r1, [sp]
	adds r5, r2, #0
	ldr r1, =SOUND_INFO_PTR
	ldr r1, [r1]
	str r1, [sp, #4]
	ldr r1, =gClockTable
	adds r0, r0, r1
	ldrb r0, [r0]
	strb r0, [r5, #4]
	ldr r3, [r5, #0x40]
	ldrb r0, [r3]
	cmp r0, #0x80
	bhs _02006E86
	strb r0, [r5, #5]
	adds r3, #1
	ldrb r0, [r3]
	cmp r0, #0x80
	bhs _02006E84
	strb r0, [r5, #6]
	adds r3, #1
	ldrb r0, [r3]
	cmp r0, #0x80
	bhs _02006E84
	ldrb r1, [r5, #4]
	adds r1, r1, r0
	strb r1, [r5, #4]
	adds r3, #1
_02006E84:
	str r3, [r5, #0x40]
_02006E86:
	movs r0, #0
	str r0, [sp, #0x14]
	adds r4, r5, #0
	adds r4, #0x24
	ldrb r2, [r4]
	movs r0, #0xc0
	tst r0, r2
	beq _02006ED4
	ldrb r3, [r5, #5]
	movs r0, #0x40
	tst r0, r2
	beq _02006EA6
	ldr r1, [r5, #0x2c]
	adds r1, r1, r3
	ldrb r0, [r1]
	b _02006EA8
_02006EA6:
	adds r0, r3, #0
_02006EA8:
	lsls r1, r0, #1
	adds r1, r1, r0
	lsls r1, r1, #2
	ldr r0, [r5, #0x28]
	adds r1, r1, r0
	mov sb, r1
	mov r6, sb
	ldrb r1, [r6]
	movs r0, #0xc0
	tst r0, r1
	beq _02006EC0
	b _02007040
_02006EC0:
	movs r0, #0x80
	tst r0, r2
	beq _02006ED8
	ldrb r1, [r6, #3]
	movs r0, #0x80
	tst r0, r1
	beq _02006ED0
	str r1, [sp, #0x14]
_02006ED0:
	ldrb r3, [r6, #1]
	b _02006ED8
_02006ED4:
	mov sb, r4
	ldrb r3, [r5, #5]
_02006ED8:
	str r3, [sp, #8]
	ldr r6, [sp]
	ldrb r1, [r6, #9]
	ldrb r0, [r5, #0x1d]
	adds r0, r0, r1
	cmp r0, #0xff
	bls _02006EE8
	movs r0, #0xff
_02006EE8:
	str r0, [sp, #0x10]
	mov r6, sb
	ldrb r0, [r6]
	movs r6, #7
	ands r6, r0
	str r6, [sp, #0xc]
	beq _02006F28
	ldr r0, [sp, #4]
	ldr r4, [r0, #0x1c]
	cmp r4, #0
	bne _02006F00
	b _02007040
_02006F00:
	subs r6, #1
	lsls r0, r6, #6
	adds r4, r4, r0
	ldrb r1, [r4]
	movs r0, #0xc7
	tst r0, r1
	beq _02006F7C
	movs r0, #0x40
	tst r0, r1
	bne _02006F7C
	ldrb r1, [r4, #0x13]
	ldr r0, [sp, #0x10]
	cmp r1, r0
	blo _02006F7C
	beq _02006F20
	b _02007040
_02006F20:
	ldr r0, [r4, #0x2c]
	cmp r0, r5
	bhs _02006F7C
	b _02007040
_02006F28:
	ldr r6, [sp, #0x10]
	adds r7, r5, #0
	movs r2, #0
	mov r8, r2
	ldr r4, [sp, #4]
	ldrb r3, [r4, #6]
	adds r4, #0x50
_02006F36:
	ldrb r1, [r4]
	movs r0, #0xc7
	tst r0, r1
	beq _02006F7C
	movs r0, #0x40
	tst r0, r1
	beq _02006F50
	cmp r2, #0
	bne _02006F54
	adds r2, #1
	ldrb r6, [r4, #0x13]
	ldr r7, [r4, #0x2c]
	b _02006F6E
_02006F50:
	cmp r2, #0
	bne _02006F70
_02006F54:
	ldrb r0, [r4, #0x13]
	cmp r0, r6
	bhs _02006F60
	adds r6, r0, #0
	ldr r7, [r4, #0x2c]
	b _02006F6E
_02006F60:
	bhi _02006F70
	ldr r0, [r4, #0x2c]
	cmp r0, r7
	bls _02006F6C
	adds r7, r0, #0
	b _02006F6E
_02006F6C:
	blo _02006F70
_02006F6E:
	mov r8, r4
_02006F70:
	adds r4, #0x40
	subs r3, #1
	bgt _02006F36
	mov r4, r8
	cmp r4, #0
	beq _02007040
_02006F7C:
	adds r0, r4, #0
	bl ClearChain
	movs r1, #0
	str r1, [r4, #0x30]
	ldr r3, [r5, #0x20]
	str r3, [r4, #0x34]
	cmp r3, #0
	beq _02006F90
	str r4, [r3, #0x30]
_02006F90:
	str r4, [r5, #0x20]
	str r5, [r4, #0x2c]
	ldrb r0, [r5, #0x1b]
	strb r0, [r5, #0x1c]
	cmp r0, r1
	beq _02006FA2
	adds r1, r5, #0
	bl clear_modM
_02006FA2:
	ldr r1, [sp, #0x14]
	cmp r1, #0
	beq _02006FB6
	subs r1, #0xc0
	lsls r1, r1, #1
	strb r1, [r5, #0x15]
	ldrb r0, [r5]
	movs r1, #3
	orrs r0, r1
	strb r0, [r5]
_02006FB6:
	ldr r0, [sp]
	adds r1, r5, #0
	bl TrkVolPitSet
	ldr r0, [r5, #4]
	str r0, [r4, #0x10]
	ldr r0, [sp, #0x10]
	strb r0, [r4, #0x13]
	ldr r0, [sp, #8]
	strb r0, [r4, #8]
	mov r6, sb
	ldrb r0, [r6]
	strb r0, [r4, #1]
	ldr r7, [r6, #4]
	str r7, [r4, #0x24]
	ldr r0, [r6, #8]
	str r0, [r4, #4]
	ldrh r0, [r5, #0x1e]
	strh r0, [r4, #0xc]
	ldrb r1, [r4, #0x12]
	ldrb r0, [r5, #0x10]
	muls r0, r1, r0
	asrs r0, r0, #7
	strb r0, [r4, #2]
	ldrb r0, [r5, #0x11]
	muls r0, r1, r0
	asrs r0, r0, #7
	strb r0, [r4, #3]
	ldrb r1, [r4, #8]
	movs r0, #8
	ldrsb r0, [r5, r0]
	adds r3, r1, r0
	bpl _02006FFA
	movs r3, #0
_02006FFA:
	ldr r6, [sp, #0xc]
	cmp r6, #0
	beq _02007028
	mov r6, sb
	ldrb r0, [r6, #2]
	strb r0, [r4, #0x1e]
	ldrb r1, [r6, #3]
	movs r0, #0x80
	tst r0, r1
	bne _02007014
	movs r0, #0x70
	tst r0, r1
	bne _02007016
_02007014:
	movs r1, #8
_02007016:
	strb r1, [r4, #0x1f]
	ldrb r2, [r5, #9]
	adds r1, r3, #0
	ldr r0, [sp, #0xc]
	ldr r3, [sp, #4]
	ldr r3, [r3, #0x30]
	bl call_r3
	b _02007032
_02007028:
	ldrb r2, [r5, #9]
	adds r1, r3, #0
	adds r0, r7, #0
	bl MidiKeyToFreq
_02007032:
	str r0, [r4, #0x20]
	movs r0, #0x80
	strb r0, [r4]
	ldrb r1, [r5]
	movs r0, #0xf0
	ands r0, r1
	strb r0, [r5]
_02007040:
	add sp, #0x18
	pop {r0, r1, r2, r3, r4, r5, r6, r7}
	mov r8, r0
	mov sb, r1
	mov sl, r2
	mov fp, r3
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start ply_endtie
ply_endtie: @ 0x02007058
	push {r4, r5}
	ldr r2, [r1, #0x40]
	ldrb r3, [r2]
	cmp r3, #0x80
	bhs _0200706A
	strb r3, [r1, #5]
	adds r2, #1
	str r2, [r1, #0x40]
	b _0200706C
_0200706A:
	ldrb r3, [r1, #5]
_0200706C:
	ldr r1, [r1, #0x20]
	cmp r1, #0
	beq _02007094
	movs r4, #0x83
	movs r5, #0x40
_02007076:
	ldrb r2, [r1]
	tst r2, r4
	beq _0200708E
	tst r2, r5
	bne _0200708E
	ldrb r0, [r1, #0x11]
	cmp r0, r3
	bne _0200708E
	movs r0, #0x40
	orrs r2, r0
	strb r2, [r1]
	b _02007094
_0200708E:
	ldr r1, [r1, #0x34]
	cmp r1, #0
	bne _02007076
_02007094:
	pop {r4, r5}
	bx lr

	thumb_func_start clear_modM
clear_modM: @ 0x02007098
	movs r2, #0
	strb r2, [r1, #0x16]
	strb r2, [r1, #0x1a]
	ldrb r2, [r1, #0x18]
	cmp r2, #0
	bne _020070A8
	movs r2, #0xc
	b _020070AA
_020070A8:
	movs r2, #3
_020070AA:
	ldrb r3, [r1]
	orrs r3, r2
	strb r3, [r1]
	bx lr
	.align 2, 0

	thumb_func_start ld_r3_tp_adr_i_unchecked
ld_r3_tp_adr_i_unchecked: @ 0x020070B4
	ldr r2, [r1, #0x40]
	adds r3, r2, #1
	str r3, [r1, #0x40]
	ldrb r3, [r2]
	bx lr
	.align 2, 0

	thumb_func_start ply_lfos
ply_lfos: @ 0x020070C0
	mov ip, lr
	bl ld_r3_tp_adr_i_unchecked
	strb r3, [r1, #0x19]
	cmp r3, #0
	bne _020070D0
	bl clear_modM
_020070D0:
	bx ip
	.align 2, 0

	thumb_func_start ply_mod
ply_mod: @ 0x020070D4
	mov ip, lr
	bl ld_r3_tp_adr_i_unchecked
	strb r3, [r1, #0x17]
	cmp r3, #0
	bne _020070E4
	bl clear_modM
_020070E4:
	bx ip
	.align 2, 0

	.bss
	.align 3

	.global gMPlay1Track
gMPlay1Track: @ 0x02020A50
	.space 0x280
	.size gMPlay1Track,.-gMPlay1Track
