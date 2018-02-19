@--------------------------------------------------------------------------------
@ ws2811_routines.S - write pixel data to ws2811 leds
@--------------------------------------------------------------------------------
@
@ lpc810 cortex-m0+ ARM ASM routine for streaming pixels data @400k (low speed)
@
@ assumes interrupts are disabled when called
@ assumes 12MHz system clock, flash wait state set to 0
@ assumes P0_2 configured as OUTPUT connected to ws2811 DIN pin
@
@ Author: rick@kimballsoftware.com
@   Date: 21-Jul-2013
@   Desc: this code is part of the fabooh framework
@
@
   .cpu cortex-m0
   .thumb
   .fpu softvfp
   .syntax unified

   .file   "ws2811_utils.s"

@--------------------------------------------------------------------------------
@ void ws2811_write(uint8_t *pixel_data, unsigned byte_cnt)
@
@ Desc: Stream Green Red Blue data to a ws2811 chip with timing based on
@       cycle counting. See ws2811 data sheet for timing details. NOPS
@       are used to fill the time between turning P0_2 on and off to
@       achieve precise timings.
@
@ Example:
@
@      // 3 color bytes for each ws2811 ic chip
@      // light up 4 ws2811 leds pixels
@      static const uint8_t pixel_data[] = {
@        0x00,0x3F,0x00, // red
@        0x3F,0x3F,0x3F, // white
@        0x00,0x00,0x3F, // blue
@        0x3F,0x00,0x00, // green
@      };
@
@      ws2811_write((uint8_t *)&pixel_data[0],12);
@      delay_usec(50);
@
@
   .text
   .align   1
   .global   ws2811_write
   .thumb_func
   .type   ws2811_write, %function

ws2811_write:
   push   {r4, r5, r6, r7, lr}      @ save off registers we affect

   cpsid  i
   @movs   r2, #0x20             @ led pin mask P0_2
   ldr    r2, =0xFFF             @ led pin mask P0_2
   movs   r3, #0x0
   ldrb   r4, [r0, #0]          @ work byte from pixel_data[0]
   ldr    r5, =0x50010100       @ &LPC_GPIO_PORT_1
   @ldr    r5, =0x50001000       @ &LPC_GPIO_PORT_1
   movs   r6, #0x80             @ mask bit msb -> lsb

.L_loop:                        @ loop through each pixel_data byte a bit at a time MSB->LSB
   str   r2, [r5, #0]           @ set P0_2 high - start of on cycle
   nop
   nop
   nop
   ands   r4, r4, r6            @ check if bit is high or low
   bne   .L_set1                @ if 1 then


.L_set0:                        @--- Off bit is 500ns on / 2000ns off
   str   r3, [r5, #0]           @ set P0_2 low  - end of on duration, begin off cycle
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   b   .L2

.L_set1:                        @--- On bit is 1200ns on /  1300ns off
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   str   r3, [r5, #0]             @ set P0_2 low - end of on duration, begin off cycle

.L2:
   nop
   nop
   nop
   nop
   ldrb   r4, [r0, #0]
   lsrs   r6, r6, #1
   beq   .L3_outer

.L3_inner:
   nop                          @ one extra nop because we didn't branch
   nop
   nop
   nop
   b   .L_loop

.L3_outer:
   movs   r6, #0x80         @ start again at most significant bit of pixel
   adds   r0, #1            @ pixel_data++
   subs   r1, #1            @ cnt--
   bne   .L_loop

.L_done:
   cpsie i
   pop   {r4, r5, r6, r7, pc}      @ restore registers and return to caller

   .size   ws2811_write, .-ws2811_write
