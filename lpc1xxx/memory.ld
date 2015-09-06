MEMORY
{
  flash(rx): ORIGIN = 0x00000000, LENGTH = 16K
  sram(rwx): ORIGIN = 0x10000000+0, LENGTH = 4K-0
}
INCLUDE lpc1xxx/linkscript.ld
