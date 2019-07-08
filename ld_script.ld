SECTIONS {
    . = 0x02000000;
    .text :
    ALIGN(4)
    {
		asm/crt0.o(.text);
        asm/all.o(.text);
		asm/m4a.o(.text);
		src/main.o(.text);
		asm/main.o(.text);
		src/unk_200E344.o(.text);
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
        data/ewram.o(ewram_data);
    } =0
    . = 0x03000000;
    iwram :
    ALIGN(4)
    {
		. = 0x1000;
        data/bss.o(.bss);
    }
	. = 0x08000000;
	rom_image :
	{
		Start = 0;
		ROMHeader_NintendoLogo = 4;
		ROMHeader_Title = 0xA0;
		ROMHeader_Language = 0xAF;
		ROMHeader_MakerCodeLo = 0xB0;
		ROMHeader_MakerCodeHi = 0xB1;
		ROMHeader_Magic = 0xB2;
		ROMHeader_Version = 0xBC;
	} =0
    /DISCARD/ :
    {
        *(*);
    }
}
