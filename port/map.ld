MEMORY
{
    FLASH : ORIGIN = 0x00000000, LENGTH = 128K
    RAM   : ORIGIN = 0x20000000, LENGTH = 8K
}

/*
 * MEMORY DIAGRAM (using symbols defined below)
 * ==============================================
 *
 *                     RAM (8K)
 *                     0x20002000  (ORIGIN(RAM) + LENGTH(RAM))
 *                     +-------------------+
 *                     | __StackTop         |  <- initial SP (__stack)
 *                     |        ^           |
 *                     |        |           |
 *                     |   (stack grows     |
 *                     |    downward)       |
 *                     |        |           |
 *                     |        v           |
 *                     |   (heap grows      |
 *                     |    upward)         |
 *                     +-------------------+
 *                     | _end               |  <- heap start (newlib sbrk)
 *                     +-------------------+
 *                     | _ebss              |
 *                     |   .bss (zeroed)    |
 *                     | _sbss              |
 *                     +-------------------+
 *                     | _edata             |
 *                     |   .data contents   |  <- runtime read/write copy
 *                     | _sdata             |
 *                     +-------------------+
 *                     0x20000000  (ORIGIN(RAM))
 *
 *                     FLASH (128K)
 *                     0x00020000  (ORIGIN(FLASH) + LENGTH(FLASH))
 *                     +-------------------+
 *                     | _sidata            |  <- LMA: .data's stored init
 *                     |   (.data load copy)|     values live here in FLASH
 *                     +-------------------+
 *                     | _etext             |
 *                     |   .rodata          |
 *                     |   .text            |
 *                     |   .vectors         |
 *                     | _stext             |
 *                     +-------------------+
 *                     0x00000000  (ORIGIN(FLASH))
 *
 * Startup code responsibility (in your reset handler):
 *   1. Copy (_edata - _sdata) bytes from _sidata (FLASH) to _sdata (RAM)
 *   2. Zero-fill from _sbss to _ebss
 *   3. Set initial SP = __stack, then jump to main()
 */

SECTIONS
{
    .text :
    {
        _stext = .;
        KEEP(*(.vectors*))     /* protect vector table from --gc-sections */
        *(.text*)
        *(.rodata*)
        _etext = .;
    } > FLASH

    .data : ALIGN(4)
    {
        _sdata = .;             /* RAM start address (destination) */
        *(.data*)
        . = ALIGN(4);
        _edata = .;              /* RAM end address */
    } > RAM AT > FLASH           /* runtime home = RAM, load image = FLASH */

    _sidata = LOADADDR(.data);   /* FLASH address holding .data's init values */

    .bss : ALIGN(4)
    {
        _sbss = .;
        *(.bss*)
        . = ALIGN(4);
        _ebss = .;
    } > RAM

    PROVIDE(_end = .);           /* heap start, used by newlib sbrk() */

    __StackTop = ORIGIN(RAM) + LENGTH(RAM);
    PROVIDE(__stack = __StackTop);   /* initial stack pointer, top of RAM */
}