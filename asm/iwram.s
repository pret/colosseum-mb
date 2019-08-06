	.include "asm/macros.inc"
	.include "constants/constants.inc"

	.text
	.syntax unified

	arm_func_start arm_LZ77UnCompWRAM
arm_LZ77UnCompWRAM: @ 0x02016818
	mov ip, sp
	push {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r7, r0
	ldr r3, [r7], #4
	mov lr, r1
	add sb, lr, r3, asr #8
	cmp lr, sb
	bhs _02016940
	mov r8, #0xff0
	add r8, r8, #0xf
_02016844:
	mov r5, #0x80
	ldrb sl, [r7], #1
_0201684C:
	tst sl, r5
	beq _02016924
	ldrb r3, [r7], #1
	ldrb r1, [r7], #1
	sub r0, lr, #1
	orr r1, r1, r3, lsl #8
	and r3, r1, r8
	rsb r0, r3, r0
	orr r2, lr, r0
	tst r2, #1
	asr r1, r1, #0xc
	add r1, r1, #3
	bne _020168C0
	asr ip, r1, #2
	cmp ip, #0
	and r4, r1, #2
	and r6, r1, #1
	lsr r1, r5, #1
	beq _020168B0
_02016898:
	ldrh r3, [r0], #2
	strh r3, [lr], #2
	ldrh r3, [r0], #2
	strh r3, [lr], #2
	subs ip, ip, #1
	bne _02016898
_020168B0:
	cmp r4, #0
	ldrhne r3, [r0], #2
	strhne r3, [lr], #2
	b _02016914
_020168C0:
	asr ip, r1, #2
	cmp ip, #0
	and r4, r1, #2
	and r6, r1, #1
	lsr r1, r5, #1
	beq _02016900
_020168D8:
	ldrb r3, [r0], #1
	strb r3, [lr], #1
	ldrb r2, [r0], #1
	strb r2, [lr], #1
	ldrb r3, [r0], #1
	strb r3, [lr], #1
	ldrb r2, [r0], #1
	strb r2, [lr], #1
	subs ip, ip, #1
	bne _020168D8
_02016900:
	cmp r4, #0
	ldrbne r3, [r0], #1
	strbne r3, [lr], #1
	ldrbne r2, [r0], #1
	strbne r2, [lr], #1
_02016914:
	cmp r6, #0
	beq _02016930
	ldrb r3, [r0]
	b _0201692C
_02016924:
	ldrb r3, [r7], #1
	lsr r1, r5, #1
_0201692C:
	strb r3, [lr], #1
_02016930:
	ands r5, r1, #0xff
	bne _0201684C
	cmp lr, sb
	blo _02016844
_02016940:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, lr}
	bx lr

	arm_func_start arm_Bootstrap
arm_Bootstrap: @ 0x02016948
	mov ip, sp
	push {r4, r5, fp, ip, lr, pc}
	mov r3, #0xac
	add r3, r3, #0x2000000
	mov r1, #0
	ldr r2, =ImageEnd
	sub fp, ip, #4
	ldr ip, =Image
	mov r5, #0x2000000
	ldr r4, [r3]
	rsb r2, ip, r2
	rsb r0, r2, #0x2000000
	add r0, r0, #0x3fc00
	add r0, r0, #0x300
	cmp r1, r2
	bge _0201699C
_02016988:
	ldrb r3, [ip, r1]
	strb r3, [r0, r1]
	add r1, r1, #1
	cmp r1, r2
	blt _02016988
_0201699C:
	mov r3, #0x208
	add r3, r3, #0x4000000
	mov r2, #0
	strh r2, [r3]
	mov r1, #0x2000000
	bl arm_LZ77UnCompWRAM
	mov r3, #0xac
	add r3, r3, #0x2000000
	str r4, [r3]
	mov lr, pc
	bx r5
	b _020169D4
	.pool
_020169D4: @ 0x020169D4
	ldmdb fp, {r4, r5, fp, sp, lr}
	bx lr
