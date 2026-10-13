OUTPUT_FORMAT("elf32-powerpc");
OUTPUT_ARCH(powerpc:common);

/* Adresses mémoire exactes pour New Super Mario Bros. Wii (NTSC v1.01) */
GetSpecificPlayerActor = 0x8005eb90;
_ZN19ClassWithCameraInfo8instanceE = 0x8042a748;
_Z11CreateActor6ActorsjP4VEC3Pvc = 0x80061e30;

SECTIONS {
    .text : { 
        __text_start = .;
        *(.text .text.*) 
        __text_end = .;
    }
    .data : { *(.data .data.*) }
    .bss : { *(.bss .bss.*) }
    .rodata : { *(.rodata .rodata.*) }
    
    /* C'est ICI que Kamek stocke les ponts d'injection ! */
    .kamek : {
        *(.kamek .kamek.*)
    }
}