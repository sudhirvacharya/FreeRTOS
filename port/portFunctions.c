void* memset(void *dst, int value, unsigned int size)
{
    unsigned char *ptr = (unsigned char *)dst;
    unsigned char val = (unsigned char)value;

    while (size >0)
    {
        *ptr++ = val;
        ptr++;
        size--;
    }

    return dst;
}