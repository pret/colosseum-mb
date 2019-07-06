	.include "asm/macros/function.inc"
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
	ldr r0, =0x03007FF0
	ldr r0, [r0]
	ldr r2, =0x68736D53
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
	bl sub_02006926
	ldr r0, [sp, #0x18]
_02006546:
	ldr r3, [r0, #0x28]
	bl sub_02006926
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
	ldr r3, =gUnknown_020213B5
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
	ldr r3, =0x68736D53
	str r3, [r0]
	add sp, #0x1c
	pop {r0, r1, r2, r3, r4, r5, r6, r7}
	mov r8, r0
	mov sb, r1
	mov sl, r2
	mov fp, r3
	pop {r3}
sub_02006926: @ 0x02006926
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
	ldr r2, =gUnknown_0201D6C4
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
	ldr r0, =gUnknown_0201D6C4
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
	non_word_aligned_thumb_func_start sub_020069CA
sub_020069CA: @ 0x020069CA
	adds r3, r2, #1
	str r3, [r1, #0x40]
	ldrb r3, [r2]
	b chk_adr_r2
	.align 2, 0
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
	bl sub_020069CA
	strb r3, [r0]
	bx ip
	.align 2, 0
	.pool

	thumb_func_start m4aSoundVSync
m4aSoundVSync: @ 0x02006B58
	ldr r0, _02006DF4 @=0x03007FF0
	ldr r0, [r0]
	ldr r2, _02006DF8 @=0x68736D53
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
	ldr r2,_02006DF8 @=0x68736D53
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
	bl sub_02006DEC
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
	ldr r0, _02006DF4 @=0x03007FF0
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
	bl sub_0200753C
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
	bl sub_02007550
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
	bl sub_02006DEC
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
	bl sub_02006DEC
	ldrb r0, [r5]
	cmp r0, #0
	beq _02006CF8
	b _02006C9C
_02006C92:
	ldr r0, =gUnknown_0201D938
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
	bl sub_0200753C
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
	bl sub_02006DEC
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
	ldr r0, _02006DF8 @=0x68736D53
	str r0, [r7, #0x34]
	pop {r0, r1, r2, r3, r4, r5, r6, r7}
	mov r8, r0
	mov sb, r1
	mov sl, r2
	mov fp, r3
	pop {r3}

	thumb_func_start sub_02006DEC
sub_02006DEC: @ 0x02006DEC
	bx r3
	.align 2, 0
	.pool
_02006DF4: .4byte 0x03007FF0
_02006DF8: .4byte 0x68736D53

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
	ldr r3, =0x03007FF0
	ldr r3, [r3]
	ldr r3, [r3, #0x2c]
	bl sub_02006DEC
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
	ldr r1, =0x03007FF0
	ldr r1, [r1]
	str r1, [sp, #4]
	ldr r1, =gUnknown_0201D938
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
	bl sub_0200753C
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
	bl sub_02006DEC
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
	ldr r3, =gUnknown_0201D754
	adds r0, r6, r3
	ldrb r5, [r0]
	ldr r4, =gUnknown_0201D808
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
	ldr r0, =0x68736D53
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
	ldr r0, =0x68736D53
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
	ldr r1, =gUnknown_020213B4
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
	ldr r1, =gUnknown_0201DDF8
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
	ldr r2, =gUnknown_0201DDF8
	ldr r1, =gUnknown_0201DE04
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
	ldr r2, =gUnknown_0201DDF8
	ldr r1, =gUnknown_0201DE04
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
	ldr r2, =gUnknown_0201DDF8
	ldr r1, =gUnknown_0201DE04
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
	ldr r2, =gUnknown_0201DDF8
	ldr r1, =gUnknown_0201DE04
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
	ldr r2, =gUnknown_0201DDF8
	ldr r1, =gUnknown_0201DE04
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
	ldr r5, =gUnknown_0201DDF8
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
	ldr r5, =gUnknown_0201DDF8
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
	bl sub_02007550
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
	ldr r0, =0x03007FF0
	ldr r4, [r0]
	ldr r6, [r4]
	ldr r0, =0x68736D53
	cmp r6, r0
	bne _020074D8
	adds r0, r6, #1
	str r0, [r4]
	ldr r1, =gUnknown_020229F0
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
	ldr r0, =sub_0200762C
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

	thumb_func_start sub_0200753C
sub_0200753C: @ 0x0200753C
	push {lr}
	ldr r1, =gUnknown_02022A78
	ldr r1, [r1]
	bl _call_via_r1
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_02007550
sub_02007550: @ 0x02007550
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
	ldr r0, =0x03007FF0
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
	ldr r0, =sub_02008588
	str r0, [r5, #0x28]
	str r0, [r5, #0x2c]
	str r0, [r5, #0x30]
	str r0, [r5, #0x3c]
	ldr r4, =gUnknown_020229F0
	adds r0, r4, #0
	bl MPlayJumpTableCopy
	str r4, [r5, #0x34]
	movs r0, #0x80
	lsls r0, r0, #0xb
	bl sub_0200762C
	ldr r0, =0x68736D53
	str r0, [r5]
	add sp, #4
	pop {r4, r5}
	pop {r0}
	bx r0
	.align 2, 0
	.pool

	thumb_func_start sub_0200762C
sub_0200762C: @ 0x0200762C
	push {r4, r5, r6, lr}
	adds r2, r0, #0
	ldr r0, =0x03007FF0
	ldr r4, [r0]
	movs r0, #0xf0
	lsls r0, r0, #0xc
	ands r0, r2
	lsrs r2, r0, #0x10
	movs r6, #0
	strb r2, [r4, #8]
	ldr r1, =gUnknown_0201D838
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
	ldr r0, =0x03007FF0
	ldr r5, [r0]
	ldr r1, [r5]
	ldr r0, =0x68736D53
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
	bl sub_0200762C
_02007752:
	ldr r0, =0x68736D53
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
	ldr r0, =0x03007FF0
	ldr r6, [r0]
	ldr r1, [r6]
	ldr r0, =0x68736D53
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
	ldr r0, =0x68736D53
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
	ldr r0, =0x03007FF0
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
	ldr r0, =0x03007FF0
	ldr r2, [r0]
	ldr r3, [r2]
	ldr r0, =0x68736D53
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
	ldr r0, =0x03007FF0
	ldr r5, [r0]
	ldr r1, [r5]
	ldr r0, =0x68736D53
	cmp r1, r0
	bne _020078A8
	adds r0, r1, #1
	str r0, [r5]
	adds r0, r7, #0
	bl sub_02007550
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
	ldr r0, =0x68736D53
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
	ldr r0, =0x68736D53
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
	ldr r0, =0x68736D53
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
	ldr r0, =0x68736D53
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
	ldr r0, =0x68736D53
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
	ldr r0, =gUnknown_0201D8EC
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
	ldr r3, =gUnknown_0201D850
	adds r0, r5, r3
	ldrb r6, [r0]
	ldr r4, =gUnknown_0201D8D4
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
	ldr r0, =0x03007FF0
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
	ldr r0, =gUnknown_0201D928
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
	ldr r0, =0x68736D53
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
	ldr r0, =0x68736D53
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
	ldr r0, =0x68736D53
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
	ldr r0, =0x68736D53
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
	ldr r0, =0x68736D53
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
	ldr r0, =0x68736D53
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
	ldr r0, =0x68736D53
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
	ldr r0, =0x68736D53
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
	ldr r0, =0x68736D53
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
	ldr r0, =0x68736D53
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
	ldr r0, =0x68736D53
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
	ldr r2, =gUnknown_0201D96C
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
	ldr r2, =gUnknown_020229F0
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

	thumb_func_start sub_02008588
sub_02008588: @ 0x02008588
	bx lr
	.align 2, 0
