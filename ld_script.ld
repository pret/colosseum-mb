SECTIONS {
    . = 0x02000000;
    .text :
    ALIGN(4)
    {
		asm/crt0.o(.text);
        asm/all.o(.text);
		asm/m4a.o(.text);
		asm/main.o(.text);
		asm/unk_200E344.o(.text);
		asm/siirtc.o(.text);
		asm/libagbsyscall.o(.text);
		*libgcc.a:_call_via_rX.o(.text);
		*libgcc.a:_divsi3.o(.text);
		*libgcc.a:_dvmd_tls.o(.text);
		*libgcc.a:_modsi3.o(.text);
		*libgcc.a:_umodsi3.o(.text);
		*libc.a:memcpy.o(.text);
    } =0
    .rodata :
    ALIGN(4)
    {
        data/data.o(.rodata);
    } =0
    ewram_data :
    ALIGN(4)
    {
        asm/ewram.o(ewram_data);
    } =0
    . = 0x03000000;
    iwram :
    ALIGN(4)
    {
        asm/all.o(.bss);
    }
    /DISCARD/ :
    {
        *(*);
    }
}
