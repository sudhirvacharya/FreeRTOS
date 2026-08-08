MEMORY
{
    FLASH : ORIGIN = 0x00000000, LENGTH = 128K
    RAM : ORIGIN = 0x20000000, LENGTH = 8K

}

SECTIONS
{
    .text :
    {
        *(.vector)
        *(.text)
        *(.text*)
    } > FLASH

    __StackTop = ORIGIN(RAM) + LENGTH(RAM);
    PROVIDE(__stack = __StackTop - 4);
}