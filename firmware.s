
build/firmware.elf:     file format elf32-littlearm


Disassembly of section .text:

00000000 <vectors>:
       0:	f0 0f 00 10 11 0e 00 00 09 0e 00 00 09 0e 00 00     ................
      10:	09 0e 00 00 09 0e 00 00 09 0e 00 00 00 00 00 00     ................
	...
      2c:	09 0e 00 00 09 0e 00 00 00 00 00 00 09 0e 00 00     ................
      3c:	29 05 00 00 c5 03 00 00 c5 03 00 00 c5 03 00 00     )...............
      4c:	c5 03 00 00 c5 03 00 00 c5 03 00 00 c5 03 00 00     ................
      5c:	c5 03 00 00 c5 03 00 00 c5 03 00 00 c5 03 00 00     ................
      6c:	c5 03 00 00 c5 03 00 00 01 0e 00 00 bd 04 00 00     ................
      7c:	d5 01 00 00 55 05 00 00 79 05 00 00 9d 05 00 00     ....U...y.......
      8c:	c1 05 00 00 2d 04 00 00 e5 05 00 00 01 0e 00 00     ....-...........
      9c:	01 0e 00 00 01 0e 00 00 91 0d 00 00 01 0e 00 00     ................
      ac:	01 0e 00 00 01 0e 00 00 01 0e 00 00 01 0e 00 00     ................
      bc:	01 0e 00 00                                         ....

000000c0 <main>:
      c0:	b580      	push	{r7, lr}
      c2:	af00      	add	r7, sp, #0
      c4:	f000 f802 	bl	cc <test>
      c8:	e7fe      	b.n	c8 <main+0x8>
      ca:	46c0      	nop			; (mov r8, r8)

000000cc <test>:
      cc:	300a      	adds	r0, #10
	...

000000d0 <cpuPllSetup>:
      d0:	b580      	push	{r7, lr}
      d2:	b084      	sub	sp, #16
      d4:	af00      	add	r7, sp, #0
      d6:	1c02      	adds	r2, r0, #0
      d8:	1dfb      	adds	r3, r7, #7
      da:	701a      	strb	r2, [r3, #0]
      dc:	4b33      	ldr	r3, [pc, #204]	; (1ac <cpuPllSetup+0xdc>)
      de:	4a33      	ldr	r2, [pc, #204]	; (1ac <cpuPllSetup+0xdc>)
      e0:	6812      	ldr	r2, [r2, #0]
      e2:	2120      	movs	r1, #32
      e4:	438a      	bics	r2, r1
      e6:	601a      	str	r2, [r3, #0]
      e8:	4b31      	ldr	r3, [pc, #196]	; (1b0 <cpuPllSetup+0xe0>)
      ea:	2200      	movs	r2, #0
      ec:	601a      	str	r2, [r3, #0]
      ee:	2300      	movs	r3, #0
      f0:	60fb      	str	r3, [r7, #12]
      f2:	e003      	b.n	fc <cpuPllSetup+0x2c>
      f4:	46c0      	nop			; (mov r8, r8)
      f6:	68fb      	ldr	r3, [r7, #12]
      f8:	3301      	adds	r3, #1
      fa:	60fb      	str	r3, [r7, #12]
      fc:	68fb      	ldr	r3, [r7, #12]
      fe:	2bc7      	cmp	r3, #199	; 0xc7
     100:	d9f8      	bls.n	f4 <cpuPllSetup+0x24>
     102:	4b2c      	ldr	r3, [pc, #176]	; (1b4 <cpuPllSetup+0xe4>)
     104:	2200      	movs	r2, #0
     106:	601a      	str	r2, [r3, #0]
     108:	4b2b      	ldr	r3, [pc, #172]	; (1b8 <cpuPllSetup+0xe8>)
     10a:	2201      	movs	r2, #1
     10c:	601a      	str	r2, [r3, #0]
     10e:	4b2a      	ldr	r3, [pc, #168]	; (1b8 <cpuPllSetup+0xe8>)
     110:	2200      	movs	r2, #0
     112:	601a      	str	r2, [r3, #0]
     114:	4b28      	ldr	r3, [pc, #160]	; (1b8 <cpuPllSetup+0xe8>)
     116:	2201      	movs	r2, #1
     118:	601a      	str	r2, [r3, #0]
     11a:	46c0      	nop			; (mov r8, r8)
     11c:	4b26      	ldr	r3, [pc, #152]	; (1b8 <cpuPllSetup+0xe8>)
     11e:	681a      	ldr	r2, [r3, #0]
     120:	2301      	movs	r3, #1
     122:	4013      	ands	r3, r2
     124:	d0fa      	beq.n	11c <cpuPllSetup+0x4c>
     126:	1dfb      	adds	r3, r7, #7
     128:	781b      	ldrb	r3, [r3, #0]
     12a:	2b02      	cmp	r3, #2
     12c:	d007      	beq.n	13e <cpuPllSetup+0x6e>
     12e:	2b03      	cmp	r3, #3
     130:	d009      	beq.n	146 <cpuPllSetup+0x76>
     132:	2b01      	cmp	r3, #1
     134:	d10b      	bne.n	14e <cpuPllSetup+0x7e>
     136:	4b21      	ldr	r3, [pc, #132]	; (1bc <cpuPllSetup+0xec>)
     138:	2221      	movs	r2, #33	; 0x21
     13a:	601a      	str	r2, [r3, #0]
     13c:	e00b      	b.n	156 <cpuPllSetup+0x86>
     13e:	4b1f      	ldr	r3, [pc, #124]	; (1bc <cpuPllSetup+0xec>)
     140:	2222      	movs	r2, #34	; 0x22
     142:	601a      	str	r2, [r3, #0]
     144:	e007      	b.n	156 <cpuPllSetup+0x86>
     146:	4b1d      	ldr	r3, [pc, #116]	; (1bc <cpuPllSetup+0xec>)
     148:	2203      	movs	r2, #3
     14a:	601a      	str	r2, [r3, #0]
     14c:	e003      	b.n	156 <cpuPllSetup+0x86>
     14e:	4b1b      	ldr	r3, [pc, #108]	; (1bc <cpuPllSetup+0xec>)
     150:	2240      	movs	r2, #64	; 0x40
     152:	601a      	str	r2, [r3, #0]
     154:	46c0      	nop			; (mov r8, r8)
     156:	4b15      	ldr	r3, [pc, #84]	; (1ac <cpuPllSetup+0xdc>)
     158:	4a14      	ldr	r2, [pc, #80]	; (1ac <cpuPllSetup+0xdc>)
     15a:	6812      	ldr	r2, [r2, #0]
     15c:	2180      	movs	r1, #128	; 0x80
     15e:	438a      	bics	r2, r1
     160:	601a      	str	r2, [r3, #0]
     162:	46c0      	nop			; (mov r8, r8)
     164:	4b16      	ldr	r3, [pc, #88]	; (1c0 <cpuPllSetup+0xf0>)
     166:	681a      	ldr	r2, [r3, #0]
     168:	2301      	movs	r3, #1
     16a:	4013      	ands	r3, r2
     16c:	d0fa      	beq.n	164 <cpuPllSetup+0x94>
     16e:	4b15      	ldr	r3, [pc, #84]	; (1c4 <cpuPllSetup+0xf4>)
     170:	2203      	movs	r2, #3
     172:	601a      	str	r2, [r3, #0]
     174:	4b14      	ldr	r3, [pc, #80]	; (1c8 <cpuPllSetup+0xf8>)
     176:	2201      	movs	r2, #1
     178:	601a      	str	r2, [r3, #0]
     17a:	4b13      	ldr	r3, [pc, #76]	; (1c8 <cpuPllSetup+0xf8>)
     17c:	2200      	movs	r2, #0
     17e:	601a      	str	r2, [r3, #0]
     180:	4b11      	ldr	r3, [pc, #68]	; (1c8 <cpuPllSetup+0xf8>)
     182:	2201      	movs	r2, #1
     184:	601a      	str	r2, [r3, #0]
     186:	46c0      	nop			; (mov r8, r8)
     188:	4b0f      	ldr	r3, [pc, #60]	; (1c8 <cpuPllSetup+0xf8>)
     18a:	681a      	ldr	r2, [r3, #0]
     18c:	2301      	movs	r3, #1
     18e:	4013      	ands	r3, r2
     190:	d0fa      	beq.n	188 <cpuPllSetup+0xb8>
     192:	4b0e      	ldr	r3, [pc, #56]	; (1cc <cpuPllSetup+0xfc>)
     194:	2201      	movs	r2, #1
     196:	601a      	str	r2, [r3, #0]
     198:	4b0d      	ldr	r3, [pc, #52]	; (1d0 <cpuPllSetup+0x100>)
     19a:	4a0d      	ldr	r2, [pc, #52]	; (1d0 <cpuPllSetup+0x100>)
     19c:	6812      	ldr	r2, [r2, #0]
     19e:	2180      	movs	r1, #128	; 0x80
     1a0:	0249      	lsls	r1, r1, #9
     1a2:	430a      	orrs	r2, r1
     1a4:	601a      	str	r2, [r3, #0]
     1a6:	46bd      	mov	sp, r7
     1a8:	b004      	add	sp, #16
     1aa:	bd80      	pop	{r7, pc}
     1ac:	40048238 	.word	0x40048238
     1b0:	40048020 	.word	0x40048020
     1b4:	40048040 	.word	0x40048040
     1b8:	40048044 	.word	0x40048044
     1bc:	40048008 	.word	0x40048008
     1c0:	4004800c 	.word	0x4004800c
     1c4:	40048070 	.word	0x40048070
     1c8:	40048074 	.word	0x40048074
     1cc:	40048078 	.word	0x40048078
     1d0:	40048080 	.word	0x40048080

000001d4 <I2C_IRQHandler>:
     1d4:	b580      	push	{r7, lr}
     1d6:	b082      	sub	sp, #8
     1d8:	af00      	add	r7, sp, #0
     1da:	4b6d      	ldr	r3, [pc, #436]	; (390 <I2C_IRQHandler+0x1bc>)
     1dc:	681a      	ldr	r2, [r3, #0]
     1de:	1dfb      	adds	r3, r7, #7
     1e0:	701a      	strb	r2, [r3, #0]
     1e2:	1dfb      	adds	r3, r7, #7
     1e4:	781b      	ldrb	r3, [r3, #0]
     1e6:	3b08      	subs	r3, #8
     1e8:	2b50      	cmp	r3, #80	; 0x50
     1ea:	d900      	bls.n	1ee <I2C_IRQHandler+0x1a>
     1ec:	e0c8      	b.n	380 <I2C_IRQHandler+0x1ac>
     1ee:	009a      	lsls	r2, r3, #2
     1f0:	4b68      	ldr	r3, [pc, #416]	; (394 <I2C_IRQHandler+0x1c0>)
     1f2:	18d3      	adds	r3, r2, r3
     1f4:	681b      	ldr	r3, [r3, #0]
     1f6:	469f      	mov	pc, r3
     1f8:	4b67      	ldr	r3, [pc, #412]	; (398 <I2C_IRQHandler+0x1c4>)
     1fa:	2200      	movs	r2, #0
     1fc:	601a      	str	r2, [r3, #0]
     1fe:	4a67      	ldr	r2, [pc, #412]	; (39c <I2C_IRQHandler+0x1c8>)
     200:	4b65      	ldr	r3, [pc, #404]	; (398 <I2C_IRQHandler+0x1c4>)
     202:	681b      	ldr	r3, [r3, #0]
     204:	4966      	ldr	r1, [pc, #408]	; (3a0 <I2C_IRQHandler+0x1cc>)
     206:	5cc9      	ldrb	r1, [r1, r3]
     208:	b2c9      	uxtb	r1, r1
     20a:	6011      	str	r1, [r2, #0]
     20c:	1c5a      	adds	r2, r3, #1
     20e:	4b62      	ldr	r3, [pc, #392]	; (398 <I2C_IRQHandler+0x1c4>)
     210:	601a      	str	r2, [r3, #0]
     212:	4b64      	ldr	r3, [pc, #400]	; (3a4 <I2C_IRQHandler+0x1d0>)
     214:	2228      	movs	r2, #40	; 0x28
     216:	601a      	str	r2, [r3, #0]
     218:	4b63      	ldr	r3, [pc, #396]	; (3a8 <I2C_IRQHandler+0x1d4>)
     21a:	2201      	movs	r2, #1
     21c:	601a      	str	r2, [r3, #0]
     21e:	e0b3      	b.n	388 <I2C_IRQHandler+0x1b4>
     220:	4b62      	ldr	r3, [pc, #392]	; (3ac <I2C_IRQHandler+0x1d8>)
     222:	2200      	movs	r2, #0
     224:	601a      	str	r2, [r3, #0]
     226:	4a5d      	ldr	r2, [pc, #372]	; (39c <I2C_IRQHandler+0x1c8>)
     228:	4b5b      	ldr	r3, [pc, #364]	; (398 <I2C_IRQHandler+0x1c4>)
     22a:	681b      	ldr	r3, [r3, #0]
     22c:	495c      	ldr	r1, [pc, #368]	; (3a0 <I2C_IRQHandler+0x1cc>)
     22e:	5cc9      	ldrb	r1, [r1, r3]
     230:	b2c9      	uxtb	r1, r1
     232:	6011      	str	r1, [r2, #0]
     234:	1c5a      	adds	r2, r3, #1
     236:	4b58      	ldr	r3, [pc, #352]	; (398 <I2C_IRQHandler+0x1c4>)
     238:	601a      	str	r2, [r3, #0]
     23a:	4b5a      	ldr	r3, [pc, #360]	; (3a4 <I2C_IRQHandler+0x1d0>)
     23c:	2228      	movs	r2, #40	; 0x28
     23e:	601a      	str	r2, [r3, #0]
     240:	e0a2      	b.n	388 <I2C_IRQHandler+0x1b4>
     242:	4a56      	ldr	r2, [pc, #344]	; (39c <I2C_IRQHandler+0x1c8>)
     244:	4b54      	ldr	r3, [pc, #336]	; (398 <I2C_IRQHandler+0x1c4>)
     246:	681b      	ldr	r3, [r3, #0]
     248:	4955      	ldr	r1, [pc, #340]	; (3a0 <I2C_IRQHandler+0x1cc>)
     24a:	5cc9      	ldrb	r1, [r1, r3]
     24c:	b2c9      	uxtb	r1, r1
     24e:	6011      	str	r1, [r2, #0]
     250:	1c5a      	adds	r2, r3, #1
     252:	4b51      	ldr	r3, [pc, #324]	; (398 <I2C_IRQHandler+0x1c4>)
     254:	601a      	str	r2, [r3, #0]
     256:	4b53      	ldr	r3, [pc, #332]	; (3a4 <I2C_IRQHandler+0x1d0>)
     258:	2208      	movs	r2, #8
     25a:	601a      	str	r2, [r3, #0]
     25c:	e094      	b.n	388 <I2C_IRQHandler+0x1b4>
     25e:	2380      	movs	r3, #128	; 0x80
     260:	05db      	lsls	r3, r3, #23
     262:	2210      	movs	r2, #16
     264:	601a      	str	r2, [r3, #0]
     266:	4b4f      	ldr	r3, [pc, #316]	; (3a4 <I2C_IRQHandler+0x1d0>)
     268:	2208      	movs	r2, #8
     26a:	601a      	str	r2, [r3, #0]
     26c:	4b4e      	ldr	r3, [pc, #312]	; (3a8 <I2C_IRQHandler+0x1d4>)
     26e:	4a50      	ldr	r2, [pc, #320]	; (3b0 <I2C_IRQHandler+0x1dc>)
     270:	601a      	str	r2, [r3, #0]
     272:	e089      	b.n	388 <I2C_IRQHandler+0x1b4>
     274:	4b48      	ldr	r3, [pc, #288]	; (398 <I2C_IRQHandler+0x1c4>)
     276:	681a      	ldr	r2, [r3, #0]
     278:	4b4e      	ldr	r3, [pc, #312]	; (3b4 <I2C_IRQHandler+0x1e0>)
     27a:	681b      	ldr	r3, [r3, #0]
     27c:	429a      	cmp	r2, r3
     27e:	d20a      	bcs.n	296 <I2C_IRQHandler+0xc2>
     280:	4a46      	ldr	r2, [pc, #280]	; (39c <I2C_IRQHandler+0x1c8>)
     282:	4b45      	ldr	r3, [pc, #276]	; (398 <I2C_IRQHandler+0x1c4>)
     284:	681b      	ldr	r3, [r3, #0]
     286:	4946      	ldr	r1, [pc, #280]	; (3a0 <I2C_IRQHandler+0x1cc>)
     288:	5cc9      	ldrb	r1, [r1, r3]
     28a:	b2c9      	uxtb	r1, r1
     28c:	6011      	str	r1, [r2, #0]
     28e:	1c5a      	adds	r2, r3, #1
     290:	4b41      	ldr	r3, [pc, #260]	; (398 <I2C_IRQHandler+0x1c4>)
     292:	601a      	str	r2, [r3, #0]
     294:	e00f      	b.n	2b6 <I2C_IRQHandler+0xe2>
     296:	4b48      	ldr	r3, [pc, #288]	; (3b8 <I2C_IRQHandler+0x1e4>)
     298:	681b      	ldr	r3, [r3, #0]
     29a:	2b00      	cmp	r3, #0
     29c:	d004      	beq.n	2a8 <I2C_IRQHandler+0xd4>
     29e:	2380      	movs	r3, #128	; 0x80
     2a0:	05db      	lsls	r3, r3, #23
     2a2:	2220      	movs	r2, #32
     2a4:	601a      	str	r2, [r3, #0]
     2a6:	e006      	b.n	2b6 <I2C_IRQHandler+0xe2>
     2a8:	4b3f      	ldr	r3, [pc, #252]	; (3a8 <I2C_IRQHandler+0x1d4>)
     2aa:	4a44      	ldr	r2, [pc, #272]	; (3bc <I2C_IRQHandler+0x1e8>)
     2ac:	601a      	str	r2, [r3, #0]
     2ae:	2380      	movs	r3, #128	; 0x80
     2b0:	05db      	lsls	r3, r3, #23
     2b2:	2210      	movs	r2, #16
     2b4:	601a      	str	r2, [r3, #0]
     2b6:	4b3b      	ldr	r3, [pc, #236]	; (3a4 <I2C_IRQHandler+0x1d0>)
     2b8:	2208      	movs	r2, #8
     2ba:	601a      	str	r2, [r3, #0]
     2bc:	e064      	b.n	388 <I2C_IRQHandler+0x1b4>
     2be:	2380      	movs	r3, #128	; 0x80
     2c0:	05db      	lsls	r3, r3, #23
     2c2:	2210      	movs	r2, #16
     2c4:	601a      	str	r2, [r3, #0]
     2c6:	4b37      	ldr	r3, [pc, #220]	; (3a4 <I2C_IRQHandler+0x1d0>)
     2c8:	2208      	movs	r2, #8
     2ca:	601a      	str	r2, [r3, #0]
     2cc:	4b36      	ldr	r3, [pc, #216]	; (3a8 <I2C_IRQHandler+0x1d4>)
     2ce:	2281      	movs	r2, #129	; 0x81
     2d0:	0052      	lsls	r2, r2, #1
     2d2:	601a      	str	r2, [r3, #0]
     2d4:	e058      	b.n	388 <I2C_IRQHandler+0x1b4>
     2d6:	4b34      	ldr	r3, [pc, #208]	; (3a8 <I2C_IRQHandler+0x1d4>)
     2d8:	2282      	movs	r2, #130	; 0x82
     2da:	0052      	lsls	r2, r2, #1
     2dc:	601a      	str	r2, [r3, #0]
     2de:	4b31      	ldr	r3, [pc, #196]	; (3a4 <I2C_IRQHandler+0x1d0>)
     2e0:	2208      	movs	r2, #8
     2e2:	601a      	str	r2, [r3, #0]
     2e4:	e050      	b.n	388 <I2C_IRQHandler+0x1b4>
     2e6:	4b34      	ldr	r3, [pc, #208]	; (3b8 <I2C_IRQHandler+0x1e4>)
     2e8:	681b      	ldr	r3, [r3, #0]
     2ea:	2b01      	cmp	r3, #1
     2ec:	d103      	bne.n	2f6 <I2C_IRQHandler+0x122>
     2ee:	4b2d      	ldr	r3, [pc, #180]	; (3a4 <I2C_IRQHandler+0x1d0>)
     2f0:	2204      	movs	r2, #4
     2f2:	601a      	str	r2, [r3, #0]
     2f4:	e003      	b.n	2fe <I2C_IRQHandler+0x12a>
     2f6:	2380      	movs	r3, #128	; 0x80
     2f8:	05db      	lsls	r3, r3, #23
     2fa:	2204      	movs	r2, #4
     2fc:	601a      	str	r2, [r3, #0]
     2fe:	4b29      	ldr	r3, [pc, #164]	; (3a4 <I2C_IRQHandler+0x1d0>)
     300:	2208      	movs	r2, #8
     302:	601a      	str	r2, [r3, #0]
     304:	e040      	b.n	388 <I2C_IRQHandler+0x1b4>
     306:	2380      	movs	r3, #128	; 0x80
     308:	05db      	lsls	r3, r3, #23
     30a:	2210      	movs	r2, #16
     30c:	601a      	str	r2, [r3, #0]
     30e:	4b25      	ldr	r3, [pc, #148]	; (3a4 <I2C_IRQHandler+0x1d0>)
     310:	2208      	movs	r2, #8
     312:	601a      	str	r2, [r3, #0]
     314:	4b24      	ldr	r3, [pc, #144]	; (3a8 <I2C_IRQHandler+0x1d4>)
     316:	4a26      	ldr	r2, [pc, #152]	; (3b0 <I2C_IRQHandler+0x1dc>)
     318:	601a      	str	r2, [r3, #0]
     31a:	e035      	b.n	388 <I2C_IRQHandler+0x1b4>
     31c:	4b23      	ldr	r3, [pc, #140]	; (3ac <I2C_IRQHandler+0x1d8>)
     31e:	681b      	ldr	r3, [r3, #0]
     320:	4a1e      	ldr	r2, [pc, #120]	; (39c <I2C_IRQHandler+0x1c8>)
     322:	6812      	ldr	r2, [r2, #0]
     324:	b2d1      	uxtb	r1, r2
     326:	4a26      	ldr	r2, [pc, #152]	; (3c0 <I2C_IRQHandler+0x1ec>)
     328:	54d1      	strb	r1, [r2, r3]
     32a:	1c5a      	adds	r2, r3, #1
     32c:	4b1f      	ldr	r3, [pc, #124]	; (3ac <I2C_IRQHandler+0x1d8>)
     32e:	601a      	str	r2, [r3, #0]
     330:	4b21      	ldr	r3, [pc, #132]	; (3b8 <I2C_IRQHandler+0x1e4>)
     332:	681b      	ldr	r3, [r3, #0]
     334:	1e5a      	subs	r2, r3, #1
     336:	4b1d      	ldr	r3, [pc, #116]	; (3ac <I2C_IRQHandler+0x1d8>)
     338:	681b      	ldr	r3, [r3, #0]
     33a:	429a      	cmp	r2, r3
     33c:	d904      	bls.n	348 <I2C_IRQHandler+0x174>
     33e:	2380      	movs	r3, #128	; 0x80
     340:	05db      	lsls	r3, r3, #23
     342:	2204      	movs	r2, #4
     344:	601a      	str	r2, [r3, #0]
     346:	e002      	b.n	34e <I2C_IRQHandler+0x17a>
     348:	4b16      	ldr	r3, [pc, #88]	; (3a4 <I2C_IRQHandler+0x1d0>)
     34a:	2204      	movs	r2, #4
     34c:	601a      	str	r2, [r3, #0]
     34e:	4b15      	ldr	r3, [pc, #84]	; (3a4 <I2C_IRQHandler+0x1d0>)
     350:	2208      	movs	r2, #8
     352:	601a      	str	r2, [r3, #0]
     354:	e018      	b.n	388 <I2C_IRQHandler+0x1b4>
     356:	4b15      	ldr	r3, [pc, #84]	; (3ac <I2C_IRQHandler+0x1d8>)
     358:	681b      	ldr	r3, [r3, #0]
     35a:	4a10      	ldr	r2, [pc, #64]	; (39c <I2C_IRQHandler+0x1c8>)
     35c:	6812      	ldr	r2, [r2, #0]
     35e:	b2d1      	uxtb	r1, r2
     360:	4a17      	ldr	r2, [pc, #92]	; (3c0 <I2C_IRQHandler+0x1ec>)
     362:	54d1      	strb	r1, [r2, r3]
     364:	1c5a      	adds	r2, r3, #1
     366:	4b11      	ldr	r3, [pc, #68]	; (3ac <I2C_IRQHandler+0x1d8>)
     368:	601a      	str	r2, [r3, #0]
     36a:	4b0f      	ldr	r3, [pc, #60]	; (3a8 <I2C_IRQHandler+0x1d4>)
     36c:	4a13      	ldr	r2, [pc, #76]	; (3bc <I2C_IRQHandler+0x1e8>)
     36e:	601a      	str	r2, [r3, #0]
     370:	2380      	movs	r3, #128	; 0x80
     372:	05db      	lsls	r3, r3, #23
     374:	2210      	movs	r2, #16
     376:	601a      	str	r2, [r3, #0]
     378:	4b0a      	ldr	r3, [pc, #40]	; (3a4 <I2C_IRQHandler+0x1d0>)
     37a:	2208      	movs	r2, #8
     37c:	601a      	str	r2, [r3, #0]
     37e:	e003      	b.n	388 <I2C_IRQHandler+0x1b4>
     380:	4b08      	ldr	r3, [pc, #32]	; (3a4 <I2C_IRQHandler+0x1d0>)
     382:	2208      	movs	r2, #8
     384:	601a      	str	r2, [r3, #0]
     386:	46c0      	nop			; (mov r8, r8)
     388:	46c0      	nop			; (mov r8, r8)
     38a:	46bd      	mov	sp, r7
     38c:	b002      	add	sp, #8
     38e:	bd80      	pop	{r7, pc}
     390:	40000004 	.word	0x40000004
     394:	00000ef4 	.word	0x00000ef4
     398:	10000148 	.word	0x10000148
     39c:	40000008 	.word	0x40000008
     3a0:	10000104 	.word	0x10000104
     3a4:	40000018 	.word	0x40000018
     3a8:	10000000 	.word	0x10000000
     3ac:	100000bc 	.word	0x100000bc
     3b0:	00000103 	.word	0x00000103
     3b4:	10000144 	.word	0x10000144
     3b8:	100000b8 	.word	0x100000b8
     3bc:	00000101 	.word	0x00000101
     3c0:	100000c0 	.word	0x100000c0

000003c4 <WAKEUP_IRQHandler>:
     3c4:	b580      	push	{r7, lr}
     3c6:	b082      	sub	sp, #8
     3c8:	af00      	add	r7, sp, #0
     3ca:	2002      	movs	r0, #2
     3cc:	f7ff fe80 	bl	d0 <cpuPllSetup>
     3d0:	4b0f      	ldr	r3, [pc, #60]	; (410 <WAKEUP_IRQHandler+0x4c>)
     3d2:	2200      	movs	r2, #0
     3d4:	601a      	str	r2, [r3, #0]
     3d6:	4b0f      	ldr	r3, [pc, #60]	; (414 <WAKEUP_IRQHandler+0x50>)
     3d8:	2201      	movs	r2, #1
     3da:	4252      	negs	r2, r2
     3dc:	601a      	str	r2, [r3, #0]
     3de:	4b0e      	ldr	r3, [pc, #56]	; (418 <WAKEUP_IRQHandler+0x54>)
     3e0:	4a0d      	ldr	r2, [pc, #52]	; (418 <WAKEUP_IRQHandler+0x54>)
     3e2:	6812      	ldr	r2, [r2, #0]
     3e4:	2104      	movs	r1, #4
     3e6:	438a      	bics	r2, r1
     3e8:	601a      	str	r2, [r3, #0]
     3ea:	4b0c      	ldr	r3, [pc, #48]	; (41c <WAKEUP_IRQHandler+0x58>)
     3ec:	2200      	movs	r2, #0
     3ee:	601a      	str	r2, [r3, #0]
     3f0:	4b0b      	ldr	r3, [pc, #44]	; (420 <WAKEUP_IRQHandler+0x5c>)
     3f2:	681b      	ldr	r3, [r3, #0]
     3f4:	607b      	str	r3, [r7, #4]
     3f6:	687b      	ldr	r3, [r7, #4]
     3f8:	2b00      	cmp	r3, #0
     3fa:	d002      	beq.n	402 <WAKEUP_IRQHandler+0x3e>
     3fc:	4b05      	ldr	r3, [pc, #20]	; (414 <WAKEUP_IRQHandler+0x50>)
     3fe:	687a      	ldr	r2, [r7, #4]
     400:	601a      	str	r2, [r3, #0]
     402:	f000 f80f 	bl	424 <pmuRestoreHW>
     406:	46c0      	nop			; (mov r8, r8)
     408:	46c0      	nop			; (mov r8, r8)
     40a:	46bd      	mov	sp, r7
     40c:	b002      	add	sp, #8
     40e:	bd80      	pop	{r7, pc}
     410:	4001403c 	.word	0x4001403c
     414:	40048208 	.word	0x40048208
     418:	e000ed10 	.word	0xe000ed10
     41c:	40014004 	.word	0x40014004
     420:	4004820c 	.word	0x4004820c

00000424 <pmuRestoreHW>:
     424:	b580      	push	{r7, lr}
     426:	af00      	add	r7, sp, #0
     428:	46bd      	mov	sp, r7
     42a:	bd80      	pop	{r7, pc}

0000042c <SSP0_IRQHandler>:
     42c:	b580      	push	{r7, lr}
     42e:	b082      	sub	sp, #8
     430:	af00      	add	r7, sp, #0
     432:	4b1a      	ldr	r3, [pc, #104]	; (49c <SSP0_IRQHandler+0x70>)
     434:	681b      	ldr	r3, [r3, #0]
     436:	607b      	str	r3, [r7, #4]
     438:	687a      	ldr	r2, [r7, #4]
     43a:	2301      	movs	r3, #1
     43c:	4013      	ands	r3, r2
     43e:	d00b      	beq.n	458 <SSP0_IRQHandler+0x2c>
     440:	4b17      	ldr	r3, [pc, #92]	; (4a0 <SSP0_IRQHandler+0x74>)
     442:	1c18      	adds	r0, r3, #0
     444:	f000 fc8c 	bl	d60 <printf>
     448:	4b16      	ldr	r3, [pc, #88]	; (4a4 <SSP0_IRQHandler+0x78>)
     44a:	681b      	ldr	r3, [r3, #0]
     44c:	1c5a      	adds	r2, r3, #1
     44e:	4b15      	ldr	r3, [pc, #84]	; (4a4 <SSP0_IRQHandler+0x78>)
     450:	601a      	str	r2, [r3, #0]
     452:	4b15      	ldr	r3, [pc, #84]	; (4a8 <SSP0_IRQHandler+0x7c>)
     454:	2201      	movs	r2, #1
     456:	601a      	str	r2, [r3, #0]
     458:	687a      	ldr	r2, [r7, #4]
     45a:	2302      	movs	r3, #2
     45c:	4013      	ands	r3, r2
     45e:	d00b      	beq.n	478 <SSP0_IRQHandler+0x4c>
     460:	4b12      	ldr	r3, [pc, #72]	; (4ac <SSP0_IRQHandler+0x80>)
     462:	1c18      	adds	r0, r3, #0
     464:	f000 fc7c 	bl	d60 <printf>
     468:	4b11      	ldr	r3, [pc, #68]	; (4b0 <SSP0_IRQHandler+0x84>)
     46a:	681b      	ldr	r3, [r3, #0]
     46c:	1c5a      	adds	r2, r3, #1
     46e:	4b10      	ldr	r3, [pc, #64]	; (4b0 <SSP0_IRQHandler+0x84>)
     470:	601a      	str	r2, [r3, #0]
     472:	4b0d      	ldr	r3, [pc, #52]	; (4a8 <SSP0_IRQHandler+0x7c>)
     474:	2202      	movs	r2, #2
     476:	601a      	str	r2, [r3, #0]
     478:	687a      	ldr	r2, [r7, #4]
     47a:	2304      	movs	r3, #4
     47c:	4013      	ands	r3, r2
     47e:	d008      	beq.n	492 <SSP0_IRQHandler+0x66>
     480:	4b0c      	ldr	r3, [pc, #48]	; (4b4 <SSP0_IRQHandler+0x88>)
     482:	1c18      	adds	r0, r3, #0
     484:	f000 fc6c 	bl	d60 <printf>
     488:	4b0b      	ldr	r3, [pc, #44]	; (4b8 <SSP0_IRQHandler+0x8c>)
     48a:	681b      	ldr	r3, [r3, #0]
     48c:	1c5a      	adds	r2, r3, #1
     48e:	4b0a      	ldr	r3, [pc, #40]	; (4b8 <SSP0_IRQHandler+0x8c>)
     490:	601a      	str	r2, [r3, #0]
     492:	46c0      	nop			; (mov r8, r8)
     494:	46bd      	mov	sp, r7
     496:	b002      	add	sp, #8
     498:	bd80      	pop	{r7, pc}
     49a:	46c0      	nop			; (mov r8, r8)
     49c:	4004001c 	.word	0x4004001c
     4a0:	00001038 	.word	0x00001038
     4a4:	10000008 	.word	0x10000008
     4a8:	40040020 	.word	0x40040020
     4ac:	00001044 	.word	0x00001044
     4b0:	1000000c 	.word	0x1000000c
     4b4:	00001050 	.word	0x00001050
     4b8:	10000004 	.word	0x10000004

000004bc <SSP1_IRQHandler>:
     4bc:	b580      	push	{r7, lr}
     4be:	b082      	sub	sp, #8
     4c0:	af00      	add	r7, sp, #0
     4c2:	4b14      	ldr	r3, [pc, #80]	; (514 <SSP1_IRQHandler+0x58>)
     4c4:	681b      	ldr	r3, [r3, #0]
     4c6:	607b      	str	r3, [r7, #4]
     4c8:	687a      	ldr	r2, [r7, #4]
     4ca:	2301      	movs	r3, #1
     4cc:	4013      	ands	r3, r2
     4ce:	d007      	beq.n	4e0 <SSP1_IRQHandler+0x24>
     4d0:	4b11      	ldr	r3, [pc, #68]	; (518 <SSP1_IRQHandler+0x5c>)
     4d2:	681b      	ldr	r3, [r3, #0]
     4d4:	1c5a      	adds	r2, r3, #1
     4d6:	4b10      	ldr	r3, [pc, #64]	; (518 <SSP1_IRQHandler+0x5c>)
     4d8:	601a      	str	r2, [r3, #0]
     4da:	4b10      	ldr	r3, [pc, #64]	; (51c <SSP1_IRQHandler+0x60>)
     4dc:	2201      	movs	r2, #1
     4de:	601a      	str	r2, [r3, #0]
     4e0:	687a      	ldr	r2, [r7, #4]
     4e2:	2302      	movs	r3, #2
     4e4:	4013      	ands	r3, r2
     4e6:	d007      	beq.n	4f8 <SSP1_IRQHandler+0x3c>
     4e8:	4b0d      	ldr	r3, [pc, #52]	; (520 <SSP1_IRQHandler+0x64>)
     4ea:	681b      	ldr	r3, [r3, #0]
     4ec:	1c5a      	adds	r2, r3, #1
     4ee:	4b0c      	ldr	r3, [pc, #48]	; (520 <SSP1_IRQHandler+0x64>)
     4f0:	601a      	str	r2, [r3, #0]
     4f2:	4b0a      	ldr	r3, [pc, #40]	; (51c <SSP1_IRQHandler+0x60>)
     4f4:	2202      	movs	r2, #2
     4f6:	601a      	str	r2, [r3, #0]
     4f8:	687a      	ldr	r2, [r7, #4]
     4fa:	2304      	movs	r3, #4
     4fc:	4013      	ands	r3, r2
     4fe:	d004      	beq.n	50a <SSP1_IRQHandler+0x4e>
     500:	4b08      	ldr	r3, [pc, #32]	; (524 <SSP1_IRQHandler+0x68>)
     502:	681b      	ldr	r3, [r3, #0]
     504:	1c5a      	adds	r2, r3, #1
     506:	4b07      	ldr	r3, [pc, #28]	; (524 <SSP1_IRQHandler+0x68>)
     508:	601a      	str	r2, [r3, #0]
     50a:	46c0      	nop			; (mov r8, r8)
     50c:	46bd      	mov	sp, r7
     50e:	b002      	add	sp, #8
     510:	bd80      	pop	{r7, pc}
     512:	46c0      	nop			; (mov r8, r8)
     514:	4005801c 	.word	0x4005801c
     518:	10000008 	.word	0x10000008
     51c:	40058020 	.word	0x40058020
     520:	1000000c 	.word	0x1000000c
     524:	10000004 	.word	0x10000004

00000528 <SysTick_Handler>:
     528:	b580      	push	{r7, lr}
     52a:	af00      	add	r7, sp, #0
     52c:	4b07      	ldr	r3, [pc, #28]	; (54c <SysTick_Handler+0x24>)
     52e:	681b      	ldr	r3, [r3, #0]
     530:	1c5a      	adds	r2, r3, #1
     532:	4b06      	ldr	r3, [pc, #24]	; (54c <SysTick_Handler+0x24>)
     534:	601a      	str	r2, [r3, #0]
     536:	4b05      	ldr	r3, [pc, #20]	; (54c <SysTick_Handler+0x24>)
     538:	681b      	ldr	r3, [r3, #0]
     53a:	3301      	adds	r3, #1
     53c:	d104      	bne.n	548 <SysTick_Handler+0x20>
     53e:	4b04      	ldr	r3, [pc, #16]	; (550 <SysTick_Handler+0x28>)
     540:	681b      	ldr	r3, [r3, #0]
     542:	1c5a      	adds	r2, r3, #1
     544:	4b02      	ldr	r3, [pc, #8]	; (550 <SysTick_Handler+0x28>)
     546:	601a      	str	r2, [r3, #0]
     548:	46bd      	mov	sp, r7
     54a:	bd80      	pop	{r7, pc}
     54c:	10000010 	.word	0x10000010
     550:	10000014 	.word	0x10000014

00000554 <TIMER16_0_IRQHandler>:
     554:	b580      	push	{r7, lr}
     556:	af00      	add	r7, sp, #0
     558:	4b05      	ldr	r3, [pc, #20]	; (570 <TIMER16_0_IRQHandler+0x1c>)
     55a:	2201      	movs	r2, #1
     55c:	601a      	str	r2, [r3, #0]
     55e:	4b05      	ldr	r3, [pc, #20]	; (574 <TIMER16_0_IRQHandler+0x20>)
     560:	681b      	ldr	r3, [r3, #0]
     562:	1c5a      	adds	r2, r3, #1
     564:	4b03      	ldr	r3, [pc, #12]	; (574 <TIMER16_0_IRQHandler+0x20>)
     566:	601a      	str	r2, [r3, #0]
     568:	46c0      	nop			; (mov r8, r8)
     56a:	46bd      	mov	sp, r7
     56c:	bd80      	pop	{r7, pc}
     56e:	46c0      	nop			; (mov r8, r8)
     570:	4000c000 	.word	0x4000c000
     574:	10000018 	.word	0x10000018

00000578 <TIMER16_1_IRQHandler>:
     578:	b580      	push	{r7, lr}
     57a:	af00      	add	r7, sp, #0
     57c:	4b05      	ldr	r3, [pc, #20]	; (594 <TIMER16_1_IRQHandler+0x1c>)
     57e:	2201      	movs	r2, #1
     580:	601a      	str	r2, [r3, #0]
     582:	4b05      	ldr	r3, [pc, #20]	; (598 <TIMER16_1_IRQHandler+0x20>)
     584:	681b      	ldr	r3, [r3, #0]
     586:	1c5a      	adds	r2, r3, #1
     588:	4b03      	ldr	r3, [pc, #12]	; (598 <TIMER16_1_IRQHandler+0x20>)
     58a:	601a      	str	r2, [r3, #0]
     58c:	46c0      	nop			; (mov r8, r8)
     58e:	46bd      	mov	sp, r7
     590:	bd80      	pop	{r7, pc}
     592:	46c0      	nop			; (mov r8, r8)
     594:	40010000 	.word	0x40010000
     598:	1000001c 	.word	0x1000001c

0000059c <TIMER32_0_IRQHandler>:
     59c:	b580      	push	{r7, lr}
     59e:	af00      	add	r7, sp, #0
     5a0:	4b05      	ldr	r3, [pc, #20]	; (5b8 <TIMER32_0_IRQHandler+0x1c>)
     5a2:	2201      	movs	r2, #1
     5a4:	601a      	str	r2, [r3, #0]
     5a6:	4b05      	ldr	r3, [pc, #20]	; (5bc <TIMER32_0_IRQHandler+0x20>)
     5a8:	681b      	ldr	r3, [r3, #0]
     5aa:	1c5a      	adds	r2, r3, #1
     5ac:	4b03      	ldr	r3, [pc, #12]	; (5bc <TIMER32_0_IRQHandler+0x20>)
     5ae:	601a      	str	r2, [r3, #0]
     5b0:	46c0      	nop			; (mov r8, r8)
     5b2:	46bd      	mov	sp, r7
     5b4:	bd80      	pop	{r7, pc}
     5b6:	46c0      	nop			; (mov r8, r8)
     5b8:	40014000 	.word	0x40014000
     5bc:	10000020 	.word	0x10000020

000005c0 <TIMER32_1_IRQHandler>:
     5c0:	b580      	push	{r7, lr}
     5c2:	af00      	add	r7, sp, #0
     5c4:	4b05      	ldr	r3, [pc, #20]	; (5dc <TIMER32_1_IRQHandler+0x1c>)
     5c6:	2201      	movs	r2, #1
     5c8:	601a      	str	r2, [r3, #0]
     5ca:	4b05      	ldr	r3, [pc, #20]	; (5e0 <TIMER32_1_IRQHandler+0x20>)
     5cc:	681b      	ldr	r3, [r3, #0]
     5ce:	1c5a      	adds	r2, r3, #1
     5d0:	4b03      	ldr	r3, [pc, #12]	; (5e0 <TIMER32_1_IRQHandler+0x20>)
     5d2:	601a      	str	r2, [r3, #0]
     5d4:	46c0      	nop			; (mov r8, r8)
     5d6:	46bd      	mov	sp, r7
     5d8:	bd80      	pop	{r7, pc}
     5da:	46c0      	nop			; (mov r8, r8)
     5dc:	40018000 	.word	0x40018000
     5e0:	10000024 	.word	0x10000024

000005e4 <UART_IRQHandler>:
     5e4:	b580      	push	{r7, lr}
     5e6:	b082      	sub	sp, #8
     5e8:	af00      	add	r7, sp, #0
     5ea:	1dfb      	adds	r3, r7, #7
     5ec:	1dfa      	adds	r2, r7, #7
     5ee:	7812      	ldrb	r2, [r2, #0]
     5f0:	701a      	strb	r2, [r3, #0]
     5f2:	4b30      	ldr	r3, [pc, #192]	; (6b4 <UART_IRQHandler+0xd0>)
     5f4:	681a      	ldr	r2, [r3, #0]
     5f6:	1dbb      	adds	r3, r7, #6
     5f8:	701a      	strb	r2, [r3, #0]
     5fa:	1dbb      	adds	r3, r7, #6
     5fc:	1dba      	adds	r2, r7, #6
     5fe:	7812      	ldrb	r2, [r2, #0]
     600:	2101      	movs	r1, #1
     602:	438a      	bics	r2, r1
     604:	701a      	strb	r2, [r3, #0]
     606:	1dbb      	adds	r3, r7, #6
     608:	1dba      	adds	r2, r7, #6
     60a:	7811      	ldrb	r1, [r2, #0]
     60c:	220e      	movs	r2, #14
     60e:	400a      	ands	r2, r1
     610:	701a      	strb	r2, [r3, #0]
     612:	1dbb      	adds	r3, r7, #6
     614:	781b      	ldrb	r3, [r3, #0]
     616:	2b06      	cmp	r3, #6
     618:	d11d      	bne.n	656 <UART_IRQHandler+0x72>
     61a:	4b27      	ldr	r3, [pc, #156]	; (6b8 <UART_IRQHandler+0xd4>)
     61c:	681a      	ldr	r2, [r3, #0]
     61e:	1d7b      	adds	r3, r7, #5
     620:	701a      	strb	r2, [r3, #0]
     622:	1d7b      	adds	r3, r7, #5
     624:	781a      	ldrb	r2, [r3, #0]
     626:	239e      	movs	r3, #158	; 0x9e
     628:	4013      	ands	r3, r2
     62a:	d008      	beq.n	63e <UART_IRQHandler+0x5a>
     62c:	1d7b      	adds	r3, r7, #5
     62e:	781a      	ldrb	r2, [r3, #0]
     630:	4b22      	ldr	r3, [pc, #136]	; (6bc <UART_IRQHandler+0xd8>)
     632:	605a      	str	r2, [r3, #4]
     634:	4b22      	ldr	r3, [pc, #136]	; (6c0 <UART_IRQHandler+0xdc>)
     636:	681a      	ldr	r2, [r3, #0]
     638:	1dfb      	adds	r3, r7, #7
     63a:	701a      	strb	r2, [r3, #0]
     63c:	e037      	b.n	6ae <UART_IRQHandler+0xca>
     63e:	1d7b      	adds	r3, r7, #5
     640:	781a      	ldrb	r2, [r3, #0]
     642:	2301      	movs	r3, #1
     644:	4013      	ands	r3, r2
     646:	d031      	beq.n	6ac <UART_IRQHandler+0xc8>
     648:	4b1d      	ldr	r3, [pc, #116]	; (6c0 <UART_IRQHandler+0xdc>)
     64a:	681b      	ldr	r3, [r3, #0]
     64c:	b2db      	uxtb	r3, r3
     64e:	1c18      	adds	r0, r3, #0
     650:	f000 f858 	bl	704 <uartRxBufferWrite>
     654:	e02a      	b.n	6ac <UART_IRQHandler+0xc8>
     656:	1dbb      	adds	r3, r7, #6
     658:	781b      	ldrb	r3, [r3, #0]
     65a:	2b04      	cmp	r3, #4
     65c:	d106      	bne.n	66c <UART_IRQHandler+0x88>
     65e:	4b18      	ldr	r3, [pc, #96]	; (6c0 <UART_IRQHandler+0xdc>)
     660:	681b      	ldr	r3, [r3, #0]
     662:	b2db      	uxtb	r3, r3
     664:	1c18      	adds	r0, r3, #0
     666:	f000 f84d 	bl	704 <uartRxBufferWrite>
     66a:	e01f      	b.n	6ac <UART_IRQHandler+0xc8>
     66c:	1dbb      	adds	r3, r7, #6
     66e:	781b      	ldrb	r3, [r3, #0]
     670:	2b0c      	cmp	r3, #12
     672:	d107      	bne.n	684 <UART_IRQHandler+0xa0>
     674:	4b11      	ldr	r3, [pc, #68]	; (6bc <UART_IRQHandler+0xd8>)
     676:	685b      	ldr	r3, [r3, #4]
     678:	2280      	movs	r2, #128	; 0x80
     67a:	0052      	lsls	r2, r2, #1
     67c:	431a      	orrs	r2, r3
     67e:	4b0f      	ldr	r3, [pc, #60]	; (6bc <UART_IRQHandler+0xd8>)
     680:	605a      	str	r2, [r3, #4]
     682:	e013      	b.n	6ac <UART_IRQHandler+0xc8>
     684:	1dbb      	adds	r3, r7, #6
     686:	781b      	ldrb	r3, [r3, #0]
     688:	2b02      	cmp	r3, #2
     68a:	d10f      	bne.n	6ac <UART_IRQHandler+0xc8>
     68c:	4b0a      	ldr	r3, [pc, #40]	; (6b8 <UART_IRQHandler+0xd4>)
     68e:	681a      	ldr	r2, [r3, #0]
     690:	1d7b      	adds	r3, r7, #5
     692:	701a      	strb	r2, [r3, #0]
     694:	1d7b      	adds	r3, r7, #5
     696:	781a      	ldrb	r2, [r3, #0]
     698:	2320      	movs	r3, #32
     69a:	4013      	ands	r3, r2
     69c:	d003      	beq.n	6a6 <UART_IRQHandler+0xc2>
     69e:	4b07      	ldr	r3, [pc, #28]	; (6bc <UART_IRQHandler+0xd8>)
     6a0:	2200      	movs	r2, #0
     6a2:	609a      	str	r2, [r3, #8]
     6a4:	e002      	b.n	6ac <UART_IRQHandler+0xc8>
     6a6:	4b05      	ldr	r3, [pc, #20]	; (6bc <UART_IRQHandler+0xd8>)
     6a8:	2201      	movs	r2, #1
     6aa:	609a      	str	r2, [r3, #8]
     6ac:	46c0      	nop			; (mov r8, r8)
     6ae:	46bd      	mov	sp, r7
     6b0:	b002      	add	sp, #8
     6b2:	bd80      	pop	{r7, pc}
     6b4:	40008008 	.word	0x40008008
     6b8:	40008014 	.word	0x40008014
     6bc:	10000028 	.word	0x10000028
     6c0:	40008000 	.word	0x40008000

000006c4 <uartGetPCB>:
     6c4:	b580      	push	{r7, lr}
     6c6:	af00      	add	r7, sp, #0
     6c8:	4b01      	ldr	r3, [pc, #4]	; (6d0 <uartGetPCB+0xc>)
     6ca:	1c18      	adds	r0, r3, #0
     6cc:	46bd      	mov	sp, r7
     6ce:	bd80      	pop	{r7, pc}
     6d0:	10000028 	.word	0x10000028

000006d4 <uartSendByte>:
     6d4:	b580      	push	{r7, lr}
     6d6:	b082      	sub	sp, #8
     6d8:	af00      	add	r7, sp, #0
     6da:	1c02      	adds	r2, r0, #0
     6dc:	1dfb      	adds	r3, r7, #7
     6de:	701a      	strb	r2, [r3, #0]
     6e0:	46c0      	nop			; (mov r8, r8)
     6e2:	4b06      	ldr	r3, [pc, #24]	; (6fc <uartSendByte+0x28>)
     6e4:	681a      	ldr	r2, [r3, #0]
     6e6:	2320      	movs	r3, #32
     6e8:	4013      	ands	r3, r2
     6ea:	d0fa      	beq.n	6e2 <uartSendByte+0xe>
     6ec:	4b04      	ldr	r3, [pc, #16]	; (700 <uartSendByte+0x2c>)
     6ee:	1dfa      	adds	r2, r7, #7
     6f0:	7812      	ldrb	r2, [r2, #0]
     6f2:	601a      	str	r2, [r3, #0]
     6f4:	46c0      	nop			; (mov r8, r8)
     6f6:	46bd      	mov	sp, r7
     6f8:	b002      	add	sp, #8
     6fa:	bd80      	pop	{r7, pc}
     6fc:	40008014 	.word	0x40008014
     700:	40008000 	.word	0x40008000

00000704 <uartRxBufferWrite>:
     704:	b580      	push	{r7, lr}
     706:	b084      	sub	sp, #16
     708:	af00      	add	r7, sp, #0
     70a:	1c02      	adds	r2, r0, #0
     70c:	1dfb      	adds	r3, r7, #7
     70e:	701a      	strb	r2, [r3, #0]
     710:	f7ff ffd8 	bl	6c4 <uartGetPCB>
     714:	1c03      	adds	r3, r0, #0
     716:	60fb      	str	r3, [r7, #12]
     718:	68fb      	ldr	r3, [r7, #12]
     71a:	7b9b      	ldrb	r3, [r3, #14]
     71c:	b2db      	uxtb	r3, r3
     71e:	1c1a      	adds	r2, r3, #0
     720:	68f9      	ldr	r1, [r7, #12]
     722:	2308      	movs	r3, #8
     724:	188a      	adds	r2, r1, r2
     726:	18d3      	adds	r3, r2, r3
     728:	1dfa      	adds	r2, r7, #7
     72a:	7812      	ldrb	r2, [r2, #0]
     72c:	721a      	strb	r2, [r3, #8]
     72e:	68fb      	ldr	r3, [r7, #12]
     730:	7b9b      	ldrb	r3, [r3, #14]
     732:	b2db      	uxtb	r3, r3
     734:	1c5a      	adds	r2, r3, #1
     736:	4b0a      	ldr	r3, [pc, #40]	; (760 <uartRxBufferWrite+0x5c>)
     738:	4013      	ands	r3, r2
     73a:	d504      	bpl.n	746 <uartRxBufferWrite+0x42>
     73c:	3b01      	subs	r3, #1
     73e:	2280      	movs	r2, #128	; 0x80
     740:	4252      	negs	r2, r2
     742:	4313      	orrs	r3, r2
     744:	3301      	adds	r3, #1
     746:	b2da      	uxtb	r2, r3
     748:	68fb      	ldr	r3, [r7, #12]
     74a:	739a      	strb	r2, [r3, #14]
     74c:	68fb      	ldr	r3, [r7, #12]
     74e:	7b5b      	ldrb	r3, [r3, #13]
     750:	b2db      	uxtb	r3, r3
     752:	3301      	adds	r3, #1
     754:	b2da      	uxtb	r2, r3
     756:	68fb      	ldr	r3, [r7, #12]
     758:	735a      	strb	r2, [r3, #13]
     75a:	46bd      	mov	sp, r7
     75c:	b004      	add	sp, #16
     75e:	bd80      	pop	{r7, pc}
     760:	8000007f 	.word	0x8000007f

00000764 <append_char>:
     764:	b580      	push	{r7, lr}
     766:	b082      	sub	sp, #8
     768:	af00      	add	r7, sp, #0
     76a:	6078      	str	r0, [r7, #4]
     76c:	1c0a      	adds	r2, r1, #0
     76e:	1cfb      	adds	r3, r7, #3
     770:	701a      	strb	r2, [r3, #0]
     772:	687b      	ldr	r3, [r7, #4]
     774:	1cfa      	adds	r2, r7, #3
     776:	7812      	ldrb	r2, [r2, #0]
     778:	701a      	strb	r2, [r3, #0]
     77a:	2301      	movs	r3, #1
     77c:	1c18      	adds	r0, r3, #0
     77e:	46bd      	mov	sp, r7
     780:	b002      	add	sp, #8
     782:	bd80      	pop	{r7, pc}

00000784 <PutString>:
     784:	b580      	push	{r7, lr}
     786:	b086      	sub	sp, #24
     788:	af00      	add	r7, sp, #0
     78a:	60f8      	str	r0, [r7, #12]
     78c:	607a      	str	r2, [r7, #4]
     78e:	603b      	str	r3, [r7, #0]
     790:	1c3b      	adds	r3, r7, #0
     792:	330b      	adds	r3, #11
     794:	1c0a      	adds	r2, r1, #0
     796:	701a      	strb	r2, [r3, #0]
     798:	2300      	movs	r3, #0
     79a:	617b      	str	r3, [r7, #20]
     79c:	e00c      	b.n	7b8 <PutString+0x34>
     79e:	683b      	ldr	r3, [r7, #0]
     7a0:	781a      	ldrb	r2, [r3, #0]
     7a2:	68fb      	ldr	r3, [r7, #12]
     7a4:	701a      	strb	r2, [r3, #0]
     7a6:	68fb      	ldr	r3, [r7, #12]
     7a8:	3301      	adds	r3, #1
     7aa:	60fb      	str	r3, [r7, #12]
     7ac:	683b      	ldr	r3, [r7, #0]
     7ae:	3301      	adds	r3, #1
     7b0:	603b      	str	r3, [r7, #0]
     7b2:	697b      	ldr	r3, [r7, #20]
     7b4:	3301      	adds	r3, #1
     7b6:	617b      	str	r3, [r7, #20]
     7b8:	683b      	ldr	r3, [r7, #0]
     7ba:	781b      	ldrb	r3, [r3, #0]
     7bc:	2b00      	cmp	r3, #0
     7be:	d1ee      	bne.n	79e <PutString+0x1a>
     7c0:	687a      	ldr	r2, [r7, #4]
     7c2:	697b      	ldr	r3, [r7, #20]
     7c4:	1ad3      	subs	r3, r2, r3
     7c6:	607b      	str	r3, [r7, #4]
     7c8:	e00d      	b.n	7e6 <PutString+0x62>
     7ca:	68fb      	ldr	r3, [r7, #12]
     7cc:	1c3a      	adds	r2, r7, #0
     7ce:	320b      	adds	r2, #11
     7d0:	7812      	ldrb	r2, [r2, #0]
     7d2:	701a      	strb	r2, [r3, #0]
     7d4:	68fb      	ldr	r3, [r7, #12]
     7d6:	3301      	adds	r3, #1
     7d8:	60fb      	str	r3, [r7, #12]
     7da:	697b      	ldr	r3, [r7, #20]
     7dc:	3301      	adds	r3, #1
     7de:	617b      	str	r3, [r7, #20]
     7e0:	687b      	ldr	r3, [r7, #4]
     7e2:	3b01      	subs	r3, #1
     7e4:	607b      	str	r3, [r7, #4]
     7e6:	687b      	ldr	r3, [r7, #4]
     7e8:	2b00      	cmp	r3, #0
     7ea:	dcee      	bgt.n	7ca <PutString+0x46>
     7ec:	697b      	ldr	r3, [r7, #20]
     7ee:	1c18      	adds	r0, r3, #0
     7f0:	46bd      	mov	sp, r7
     7f2:	b006      	add	sp, #24
     7f4:	bd80      	pop	{r7, pc}
     7f6:	46c0      	nop			; (mov r8, r8)

000007f8 <PutUnsignedInt>:
     7f8:	b580      	push	{r7, lr}
     7fa:	b086      	sub	sp, #24
     7fc:	af00      	add	r7, sp, #0
     7fe:	60f8      	str	r0, [r7, #12]
     800:	607a      	str	r2, [r7, #4]
     802:	603b      	str	r3, [r7, #0]
     804:	1c3b      	adds	r3, r7, #0
     806:	330b      	adds	r3, #11
     808:	1c0a      	adds	r2, r1, #0
     80a:	701a      	strb	r2, [r3, #0]
     80c:	2300      	movs	r3, #0
     80e:	617b      	str	r3, [r7, #20]
     810:	687b      	ldr	r3, [r7, #4]
     812:	3b01      	subs	r3, #1
     814:	607b      	str	r3, [r7, #4]
     816:	683b      	ldr	r3, [r7, #0]
     818:	2b09      	cmp	r3, #9
     81a:	d924      	bls.n	866 <PutUnsignedInt+0x6e>
     81c:	683b      	ldr	r3, [r7, #0]
     81e:	1c18      	adds	r0, r3, #0
     820:	210a      	movs	r1, #10
     822:	f000 fb17 	bl	e54 <__aeabi_uidiv>
     826:	1c03      	adds	r3, r0, #0
     828:	68f8      	ldr	r0, [r7, #12]
     82a:	1c3a      	adds	r2, r7, #0
     82c:	320b      	adds	r2, #11
     82e:	7811      	ldrb	r1, [r2, #0]
     830:	687a      	ldr	r2, [r7, #4]
     832:	f7ff ffe1 	bl	7f8 <PutUnsignedInt>
     836:	1c03      	adds	r3, r0, #0
     838:	617b      	str	r3, [r7, #20]
     83a:	697b      	ldr	r3, [r7, #20]
     83c:	68fa      	ldr	r2, [r7, #12]
     83e:	18d3      	adds	r3, r2, r3
     840:	60fb      	str	r3, [r7, #12]
     842:	e013      	b.n	86c <PutUnsignedInt+0x74>
     844:	68fa      	ldr	r2, [r7, #12]
     846:	1c3b      	adds	r3, r7, #0
     848:	330b      	adds	r3, #11
     84a:	781b      	ldrb	r3, [r3, #0]
     84c:	1c10      	adds	r0, r2, #0
     84e:	1c19      	adds	r1, r3, #0
     850:	f7ff ff88 	bl	764 <append_char>
     854:	68fb      	ldr	r3, [r7, #12]
     856:	3301      	adds	r3, #1
     858:	60fb      	str	r3, [r7, #12]
     85a:	697b      	ldr	r3, [r7, #20]
     85c:	3301      	adds	r3, #1
     85e:	617b      	str	r3, [r7, #20]
     860:	687b      	ldr	r3, [r7, #4]
     862:	3b01      	subs	r3, #1
     864:	607b      	str	r3, [r7, #4]
     866:	687b      	ldr	r3, [r7, #4]
     868:	2b00      	cmp	r3, #0
     86a:	dceb      	bgt.n	844 <PutUnsignedInt+0x4c>
     86c:	683b      	ldr	r3, [r7, #0]
     86e:	1c18      	adds	r0, r3, #0
     870:	210a      	movs	r1, #10
     872:	f000 fb33 	bl	edc <__aeabi_uidivmod>
     876:	1c0b      	adds	r3, r1, #0
     878:	b2db      	uxtb	r3, r3
     87a:	3330      	adds	r3, #48	; 0x30
     87c:	b2db      	uxtb	r3, r3
     87e:	68fa      	ldr	r2, [r7, #12]
     880:	1c10      	adds	r0, r2, #0
     882:	1c19      	adds	r1, r3, #0
     884:	f7ff ff6e 	bl	764 <append_char>
     888:	1c03      	adds	r3, r0, #0
     88a:	697a      	ldr	r2, [r7, #20]
     88c:	18d3      	adds	r3, r2, r3
     88e:	617b      	str	r3, [r7, #20]
     890:	697b      	ldr	r3, [r7, #20]
     892:	1c18      	adds	r0, r3, #0
     894:	46bd      	mov	sp, r7
     896:	b006      	add	sp, #24
     898:	bd80      	pop	{r7, pc}
     89a:	46c0      	nop			; (mov r8, r8)

0000089c <PutSignedInt>:
     89c:	b580      	push	{r7, lr}
     89e:	b086      	sub	sp, #24
     8a0:	af00      	add	r7, sp, #0
     8a2:	60f8      	str	r0, [r7, #12]
     8a4:	607a      	str	r2, [r7, #4]
     8a6:	603b      	str	r3, [r7, #0]
     8a8:	1c3b      	adds	r3, r7, #0
     8aa:	330b      	adds	r3, #11
     8ac:	1c0a      	adds	r2, r1, #0
     8ae:	701a      	strb	r2, [r3, #0]
     8b0:	2300      	movs	r3, #0
     8b2:	617b      	str	r3, [r7, #20]
     8b4:	683b      	ldr	r3, [r7, #0]
     8b6:	2b00      	cmp	r3, #0
     8b8:	da03      	bge.n	8c2 <PutSignedInt+0x26>
     8ba:	683b      	ldr	r3, [r7, #0]
     8bc:	425b      	negs	r3, r3
     8be:	613b      	str	r3, [r7, #16]
     8c0:	e001      	b.n	8c6 <PutSignedInt+0x2a>
     8c2:	683b      	ldr	r3, [r7, #0]
     8c4:	613b      	str	r3, [r7, #16]
     8c6:	687b      	ldr	r3, [r7, #4]
     8c8:	3b01      	subs	r3, #1
     8ca:	607b      	str	r3, [r7, #4]
     8cc:	693b      	ldr	r3, [r7, #16]
     8ce:	2b09      	cmp	r3, #9
     8d0:	d927      	bls.n	922 <PutSignedInt+0x86>
     8d2:	683b      	ldr	r3, [r7, #0]
     8d4:	2b00      	cmp	r3, #0
     8d6:	da10      	bge.n	8fa <PutSignedInt+0x5e>
     8d8:	693b      	ldr	r3, [r7, #16]
     8da:	1c18      	adds	r0, r3, #0
     8dc:	210a      	movs	r1, #10
     8de:	f000 fab9 	bl	e54 <__aeabi_uidiv>
     8e2:	1c03      	adds	r3, r0, #0
     8e4:	425b      	negs	r3, r3
     8e6:	68f8      	ldr	r0, [r7, #12]
     8e8:	1c3a      	adds	r2, r7, #0
     8ea:	320b      	adds	r2, #11
     8ec:	7811      	ldrb	r1, [r2, #0]
     8ee:	687a      	ldr	r2, [r7, #4]
     8f0:	f7ff ffd4 	bl	89c <PutSignedInt>
     8f4:	1c03      	adds	r3, r0, #0
     8f6:	617b      	str	r3, [r7, #20]
     8f8:	e00e      	b.n	918 <PutSignedInt+0x7c>
     8fa:	693b      	ldr	r3, [r7, #16]
     8fc:	1c18      	adds	r0, r3, #0
     8fe:	210a      	movs	r1, #10
     900:	f000 faa8 	bl	e54 <__aeabi_uidiv>
     904:	1c03      	adds	r3, r0, #0
     906:	68f8      	ldr	r0, [r7, #12]
     908:	1c3a      	adds	r2, r7, #0
     90a:	320b      	adds	r2, #11
     90c:	7811      	ldrb	r1, [r2, #0]
     90e:	687a      	ldr	r2, [r7, #4]
     910:	f7ff ffc4 	bl	89c <PutSignedInt>
     914:	1c03      	adds	r3, r0, #0
     916:	617b      	str	r3, [r7, #20]
     918:	697b      	ldr	r3, [r7, #20]
     91a:	68fa      	ldr	r2, [r7, #12]
     91c:	18d3      	adds	r3, r2, r3
     91e:	60fb      	str	r3, [r7, #12]
     920:	e029      	b.n	976 <PutSignedInt+0xda>
     922:	683b      	ldr	r3, [r7, #0]
     924:	2b00      	cmp	r3, #0
     926:	da14      	bge.n	952 <PutSignedInt+0xb6>
     928:	687b      	ldr	r3, [r7, #4]
     92a:	3b01      	subs	r3, #1
     92c:	607b      	str	r3, [r7, #4]
     92e:	e010      	b.n	952 <PutSignedInt+0xb6>
     930:	68fa      	ldr	r2, [r7, #12]
     932:	1c3b      	adds	r3, r7, #0
     934:	330b      	adds	r3, #11
     936:	781b      	ldrb	r3, [r3, #0]
     938:	1c10      	adds	r0, r2, #0
     93a:	1c19      	adds	r1, r3, #0
     93c:	f7ff ff12 	bl	764 <append_char>
     940:	68fb      	ldr	r3, [r7, #12]
     942:	3301      	adds	r3, #1
     944:	60fb      	str	r3, [r7, #12]
     946:	697b      	ldr	r3, [r7, #20]
     948:	3301      	adds	r3, #1
     94a:	617b      	str	r3, [r7, #20]
     94c:	687b      	ldr	r3, [r7, #4]
     94e:	3b01      	subs	r3, #1
     950:	607b      	str	r3, [r7, #4]
     952:	687b      	ldr	r3, [r7, #4]
     954:	2b00      	cmp	r3, #0
     956:	dceb      	bgt.n	930 <PutSignedInt+0x94>
     958:	683b      	ldr	r3, [r7, #0]
     95a:	2b00      	cmp	r3, #0
     95c:	da0b      	bge.n	976 <PutSignedInt+0xda>
     95e:	68fb      	ldr	r3, [r7, #12]
     960:	1c18      	adds	r0, r3, #0
     962:	212d      	movs	r1, #45	; 0x2d
     964:	f7ff fefe 	bl	764 <append_char>
     968:	1c03      	adds	r3, r0, #0
     96a:	697a      	ldr	r2, [r7, #20]
     96c:	18d3      	adds	r3, r2, r3
     96e:	617b      	str	r3, [r7, #20]
     970:	68fb      	ldr	r3, [r7, #12]
     972:	3301      	adds	r3, #1
     974:	60fb      	str	r3, [r7, #12]
     976:	693b      	ldr	r3, [r7, #16]
     978:	1c18      	adds	r0, r3, #0
     97a:	210a      	movs	r1, #10
     97c:	f000 faae 	bl	edc <__aeabi_uidivmod>
     980:	1c0b      	adds	r3, r1, #0
     982:	b2db      	uxtb	r3, r3
     984:	3330      	adds	r3, #48	; 0x30
     986:	b2db      	uxtb	r3, r3
     988:	68fa      	ldr	r2, [r7, #12]
     98a:	1c10      	adds	r0, r2, #0
     98c:	1c19      	adds	r1, r3, #0
     98e:	f7ff fee9 	bl	764 <append_char>
     992:	1c03      	adds	r3, r0, #0
     994:	697a      	ldr	r2, [r7, #20]
     996:	18d3      	adds	r3, r2, r3
     998:	617b      	str	r3, [r7, #20]
     99a:	697b      	ldr	r3, [r7, #20]
     99c:	1c18      	adds	r0, r3, #0
     99e:	46bd      	mov	sp, r7
     9a0:	b006      	add	sp, #24
     9a2:	bd80      	pop	{r7, pc}

000009a4 <PutHexa>:
     9a4:	b590      	push	{r4, r7, lr}
     9a6:	b089      	sub	sp, #36	; 0x24
     9a8:	af02      	add	r7, sp, #8
     9aa:	60f8      	str	r0, [r7, #12]
     9ac:	607a      	str	r2, [r7, #4]
     9ae:	1c1a      	adds	r2, r3, #0
     9b0:	1c3b      	adds	r3, r7, #0
     9b2:	330b      	adds	r3, #11
     9b4:	7019      	strb	r1, [r3, #0]
     9b6:	1c3b      	adds	r3, r7, #0
     9b8:	330a      	adds	r3, #10
     9ba:	701a      	strb	r2, [r3, #0]
     9bc:	2300      	movs	r3, #0
     9be:	617b      	str	r3, [r7, #20]
     9c0:	687b      	ldr	r3, [r7, #4]
     9c2:	3b01      	subs	r3, #1
     9c4:	607b      	str	r3, [r7, #4]
     9c6:	6abb      	ldr	r3, [r7, #40]	; 0x28
     9c8:	091b      	lsrs	r3, r3, #4
     9ca:	d026      	beq.n	a1a <PutHexa+0x76>
     9cc:	6abb      	ldr	r3, [r7, #40]	; 0x28
     9ce:	091c      	lsrs	r4, r3, #4
     9d0:	68f8      	ldr	r0, [r7, #12]
     9d2:	1c3b      	adds	r3, r7, #0
     9d4:	330b      	adds	r3, #11
     9d6:	7819      	ldrb	r1, [r3, #0]
     9d8:	687a      	ldr	r2, [r7, #4]
     9da:	1c3b      	adds	r3, r7, #0
     9dc:	330a      	adds	r3, #10
     9de:	781b      	ldrb	r3, [r3, #0]
     9e0:	9400      	str	r4, [sp, #0]
     9e2:	f7ff ffdf 	bl	9a4 <PutHexa>
     9e6:	1c03      	adds	r3, r0, #0
     9e8:	697a      	ldr	r2, [r7, #20]
     9ea:	18d3      	adds	r3, r2, r3
     9ec:	617b      	str	r3, [r7, #20]
     9ee:	697b      	ldr	r3, [r7, #20]
     9f0:	68fa      	ldr	r2, [r7, #12]
     9f2:	18d3      	adds	r3, r2, r3
     9f4:	60fb      	str	r3, [r7, #12]
     9f6:	e013      	b.n	a20 <PutHexa+0x7c>
     9f8:	68fa      	ldr	r2, [r7, #12]
     9fa:	1c3b      	adds	r3, r7, #0
     9fc:	330b      	adds	r3, #11
     9fe:	781b      	ldrb	r3, [r3, #0]
     a00:	1c10      	adds	r0, r2, #0
     a02:	1c19      	adds	r1, r3, #0
     a04:	f7ff feae 	bl	764 <append_char>
     a08:	68fb      	ldr	r3, [r7, #12]
     a0a:	3301      	adds	r3, #1
     a0c:	60fb      	str	r3, [r7, #12]
     a0e:	697b      	ldr	r3, [r7, #20]
     a10:	3301      	adds	r3, #1
     a12:	617b      	str	r3, [r7, #20]
     a14:	687b      	ldr	r3, [r7, #4]
     a16:	3b01      	subs	r3, #1
     a18:	607b      	str	r3, [r7, #4]
     a1a:	687b      	ldr	r3, [r7, #4]
     a1c:	2b00      	cmp	r3, #0
     a1e:	dceb      	bgt.n	9f8 <PutHexa+0x54>
     a20:	6aba      	ldr	r2, [r7, #40]	; 0x28
     a22:	230f      	movs	r3, #15
     a24:	4013      	ands	r3, r2
     a26:	2b09      	cmp	r3, #9
     a28:	d80c      	bhi.n	a44 <PutHexa+0xa0>
     a2a:	6abb      	ldr	r3, [r7, #40]	; 0x28
     a2c:	b2da      	uxtb	r2, r3
     a2e:	230f      	movs	r3, #15
     a30:	4013      	ands	r3, r2
     a32:	b2db      	uxtb	r3, r3
     a34:	3330      	adds	r3, #48	; 0x30
     a36:	b2db      	uxtb	r3, r3
     a38:	68fa      	ldr	r2, [r7, #12]
     a3a:	1c10      	adds	r0, r2, #0
     a3c:	1c19      	adds	r1, r3, #0
     a3e:	f7ff fe91 	bl	764 <append_char>
     a42:	e01d      	b.n	a80 <PutHexa+0xdc>
     a44:	1c3b      	adds	r3, r7, #0
     a46:	330a      	adds	r3, #10
     a48:	781b      	ldrb	r3, [r3, #0]
     a4a:	2b00      	cmp	r3, #0
     a4c:	d00c      	beq.n	a68 <PutHexa+0xc4>
     a4e:	6abb      	ldr	r3, [r7, #40]	; 0x28
     a50:	b2da      	uxtb	r2, r3
     a52:	230f      	movs	r3, #15
     a54:	4013      	ands	r3, r2
     a56:	b2db      	uxtb	r3, r3
     a58:	3337      	adds	r3, #55	; 0x37
     a5a:	b2db      	uxtb	r3, r3
     a5c:	68fa      	ldr	r2, [r7, #12]
     a5e:	1c10      	adds	r0, r2, #0
     a60:	1c19      	adds	r1, r3, #0
     a62:	f7ff fe7f 	bl	764 <append_char>
     a66:	e00b      	b.n	a80 <PutHexa+0xdc>
     a68:	6abb      	ldr	r3, [r7, #40]	; 0x28
     a6a:	b2da      	uxtb	r2, r3
     a6c:	230f      	movs	r3, #15
     a6e:	4013      	ands	r3, r2
     a70:	b2db      	uxtb	r3, r3
     a72:	3357      	adds	r3, #87	; 0x57
     a74:	b2db      	uxtb	r3, r3
     a76:	68fa      	ldr	r2, [r7, #12]
     a78:	1c10      	adds	r0, r2, #0
     a7a:	1c19      	adds	r1, r3, #0
     a7c:	f7ff fe72 	bl	764 <append_char>
     a80:	697b      	ldr	r3, [r7, #20]
     a82:	3301      	adds	r3, #1
     a84:	617b      	str	r3, [r7, #20]
     a86:	697b      	ldr	r3, [r7, #20]
     a88:	1c18      	adds	r0, r3, #0
     a8a:	46bd      	mov	sp, r7
     a8c:	b007      	add	sp, #28
     a8e:	bd90      	pop	{r4, r7, pc}

00000a90 <vsnprintf>:
     a90:	b580      	push	{r7, lr}
     a92:	b08a      	sub	sp, #40	; 0x28
     a94:	af02      	add	r7, sp, #8
     a96:	60f8      	str	r0, [r7, #12]
     a98:	60b9      	str	r1, [r7, #8]
     a9a:	607a      	str	r2, [r7, #4]
     a9c:	603b      	str	r3, [r7, #0]
     a9e:	2300      	movs	r3, #0
     aa0:	61bb      	str	r3, [r7, #24]
     aa2:	2300      	movs	r3, #0
     aa4:	617b      	str	r3, [r7, #20]
     aa6:	68fb      	ldr	r3, [r7, #12]
     aa8:	2b00      	cmp	r3, #0
     aaa:	d100      	bne.n	aae <vsnprintf+0x1e>
     aac:	e0f1      	b.n	c92 <vsnprintf+0x202>
     aae:	68fb      	ldr	r3, [r7, #12]
     ab0:	2200      	movs	r2, #0
     ab2:	701a      	strb	r2, [r3, #0]
     ab4:	e0ed      	b.n	c92 <vsnprintf+0x202>
     ab6:	687b      	ldr	r3, [r7, #4]
     ab8:	781b      	ldrb	r3, [r3, #0]
     aba:	2b25      	cmp	r3, #37	; 0x25
     abc:	d00d      	beq.n	ada <vsnprintf+0x4a>
     abe:	687b      	ldr	r3, [r7, #4]
     ac0:	781a      	ldrb	r2, [r3, #0]
     ac2:	68fb      	ldr	r3, [r7, #12]
     ac4:	701a      	strb	r2, [r3, #0]
     ac6:	68fb      	ldr	r3, [r7, #12]
     ac8:	3301      	adds	r3, #1
     aca:	60fb      	str	r3, [r7, #12]
     acc:	687b      	ldr	r3, [r7, #4]
     ace:	3301      	adds	r3, #1
     ad0:	607b      	str	r3, [r7, #4]
     ad2:	697b      	ldr	r3, [r7, #20]
     ad4:	3301      	adds	r3, #1
     ad6:	617b      	str	r3, [r7, #20]
     ad8:	e0dc      	b.n	c94 <vsnprintf+0x204>
     ada:	687b      	ldr	r3, [r7, #4]
     adc:	3301      	adds	r3, #1
     ade:	781b      	ldrb	r3, [r3, #0]
     ae0:	2b25      	cmp	r3, #37	; 0x25
     ae2:	d10c      	bne.n	afe <vsnprintf+0x6e>
     ae4:	68fb      	ldr	r3, [r7, #12]
     ae6:	2225      	movs	r2, #37	; 0x25
     ae8:	701a      	strb	r2, [r3, #0]
     aea:	68fb      	ldr	r3, [r7, #12]
     aec:	3301      	adds	r3, #1
     aee:	60fb      	str	r3, [r7, #12]
     af0:	687b      	ldr	r3, [r7, #4]
     af2:	3302      	adds	r3, #2
     af4:	607b      	str	r3, [r7, #4]
     af6:	697b      	ldr	r3, [r7, #20]
     af8:	3301      	adds	r3, #1
     afa:	617b      	str	r3, [r7, #20]
     afc:	e0ca      	b.n	c94 <vsnprintf+0x204>
     afe:	1c3b      	adds	r3, r7, #0
     b00:	331f      	adds	r3, #31
     b02:	2220      	movs	r2, #32
     b04:	701a      	strb	r2, [r3, #0]
     b06:	1c3b      	adds	r3, r7, #0
     b08:	331e      	adds	r3, #30
     b0a:	2200      	movs	r2, #0
     b0c:	701a      	strb	r2, [r3, #0]
     b0e:	687b      	ldr	r3, [r7, #4]
     b10:	3301      	adds	r3, #1
     b12:	607b      	str	r3, [r7, #4]
     b14:	687b      	ldr	r3, [r7, #4]
     b16:	781b      	ldrb	r3, [r3, #0]
     b18:	2b30      	cmp	r3, #48	; 0x30
     b1a:	d106      	bne.n	b2a <vsnprintf+0x9a>
     b1c:	1c3b      	adds	r3, r7, #0
     b1e:	331f      	adds	r3, #31
     b20:	2230      	movs	r2, #48	; 0x30
     b22:	701a      	strb	r2, [r3, #0]
     b24:	687b      	ldr	r3, [r7, #4]
     b26:	3301      	adds	r3, #1
     b28:	607b      	str	r3, [r7, #4]
     b2a:	687b      	ldr	r3, [r7, #4]
     b2c:	781b      	ldrb	r3, [r3, #0]
     b2e:	2b2d      	cmp	r3, #45	; 0x2d
     b30:	d117      	bne.n	b62 <vsnprintf+0xd2>
     b32:	687b      	ldr	r3, [r7, #4]
     b34:	3301      	adds	r3, #1
     b36:	607b      	str	r3, [r7, #4]
     b38:	e013      	b.n	b62 <vsnprintf+0xd2>
     b3a:	1c3b      	adds	r3, r7, #0
     b3c:	331e      	adds	r3, #30
     b3e:	781b      	ldrb	r3, [r3, #0]
     b40:	1c1a      	adds	r2, r3, #0
     b42:	0092      	lsls	r2, r2, #2
     b44:	18d3      	adds	r3, r2, r3
     b46:	005b      	lsls	r3, r3, #1
     b48:	b2da      	uxtb	r2, r3
     b4a:	687b      	ldr	r3, [r7, #4]
     b4c:	781b      	ldrb	r3, [r3, #0]
     b4e:	18d3      	adds	r3, r2, r3
     b50:	b2da      	uxtb	r2, r3
     b52:	1c3b      	adds	r3, r7, #0
     b54:	331e      	adds	r3, #30
     b56:	3a30      	subs	r2, #48	; 0x30
     b58:	701a      	strb	r2, [r3, #0]
     b5a:	687b      	ldr	r3, [r7, #4]
     b5c:	3301      	adds	r3, #1
     b5e:	607b      	str	r3, [r7, #4]
     b60:	e000      	b.n	b64 <vsnprintf+0xd4>
     b62:	46c0      	nop			; (mov r8, r8)
     b64:	687b      	ldr	r3, [r7, #4]
     b66:	781b      	ldrb	r3, [r3, #0]
     b68:	2b2f      	cmp	r3, #47	; 0x2f
     b6a:	d903      	bls.n	b74 <vsnprintf+0xe4>
     b6c:	687b      	ldr	r3, [r7, #4]
     b6e:	781b      	ldrb	r3, [r3, #0]
     b70:	2b39      	cmp	r3, #57	; 0x39
     b72:	d9e2      	bls.n	b3a <vsnprintf+0xaa>
     b74:	1c3b      	adds	r3, r7, #0
     b76:	331e      	adds	r3, #30
     b78:	781a      	ldrb	r2, [r3, #0]
     b7a:	697b      	ldr	r3, [r7, #20]
     b7c:	18d3      	adds	r3, r2, r3
     b7e:	1c1a      	adds	r2, r3, #0
     b80:	68bb      	ldr	r3, [r7, #8]
     b82:	429a      	cmp	r2, r3
     b84:	d907      	bls.n	b96 <vsnprintf+0x106>
     b86:	68bb      	ldr	r3, [r7, #8]
     b88:	b2d9      	uxtb	r1, r3
     b8a:	697b      	ldr	r3, [r7, #20]
     b8c:	b2da      	uxtb	r2, r3
     b8e:	1c3b      	adds	r3, r7, #0
     b90:	331e      	adds	r3, #30
     b92:	1a8a      	subs	r2, r1, r2
     b94:	701a      	strb	r2, [r3, #0]
     b96:	687b      	ldr	r3, [r7, #4]
     b98:	781b      	ldrb	r3, [r3, #0]
     b9a:	3b58      	subs	r3, #88	; 0x58
     b9c:	2b20      	cmp	r3, #32
     b9e:	d869      	bhi.n	c74 <vsnprintf+0x1e4>
     ba0:	009a      	lsls	r2, r3, #2
     ba2:	4b4c      	ldr	r3, [pc, #304]	; (cd4 <vsnprintf+0x244>)
     ba4:	18d3      	adds	r3, r2, r3
     ba6:	681b      	ldr	r3, [r3, #0]
     ba8:	469f      	mov	pc, r3
     baa:	1c3b      	adds	r3, r7, #0
     bac:	331e      	adds	r3, #30
     bae:	781a      	ldrb	r2, [r3, #0]
     bb0:	683b      	ldr	r3, [r7, #0]
     bb2:	1d19      	adds	r1, r3, #4
     bb4:	6039      	str	r1, [r7, #0]
     bb6:	681b      	ldr	r3, [r3, #0]
     bb8:	68f8      	ldr	r0, [r7, #12]
     bba:	1c39      	adds	r1, r7, #0
     bbc:	311f      	adds	r1, #31
     bbe:	7809      	ldrb	r1, [r1, #0]
     bc0:	f7ff fe6c 	bl	89c <PutSignedInt>
     bc4:	1c03      	adds	r3, r0, #0
     bc6:	61bb      	str	r3, [r7, #24]
     bc8:	e057      	b.n	c7a <vsnprintf+0x1ea>
     bca:	1c3b      	adds	r3, r7, #0
     bcc:	331e      	adds	r3, #30
     bce:	781a      	ldrb	r2, [r3, #0]
     bd0:	683b      	ldr	r3, [r7, #0]
     bd2:	1d19      	adds	r1, r3, #4
     bd4:	6039      	str	r1, [r7, #0]
     bd6:	681b      	ldr	r3, [r3, #0]
     bd8:	68f8      	ldr	r0, [r7, #12]
     bda:	1c39      	adds	r1, r7, #0
     bdc:	311f      	adds	r1, #31
     bde:	7809      	ldrb	r1, [r1, #0]
     be0:	f7ff fe0a 	bl	7f8 <PutUnsignedInt>
     be4:	1c03      	adds	r3, r0, #0
     be6:	61bb      	str	r3, [r7, #24]
     be8:	e047      	b.n	c7a <vsnprintf+0x1ea>
     bea:	1c3b      	adds	r3, r7, #0
     bec:	331e      	adds	r3, #30
     bee:	781a      	ldrb	r2, [r3, #0]
     bf0:	683b      	ldr	r3, [r7, #0]
     bf2:	1d19      	adds	r1, r3, #4
     bf4:	6039      	str	r1, [r7, #0]
     bf6:	6818      	ldr	r0, [r3, #0]
     bf8:	68f9      	ldr	r1, [r7, #12]
     bfa:	1c3b      	adds	r3, r7, #0
     bfc:	331f      	adds	r3, #31
     bfe:	781b      	ldrb	r3, [r3, #0]
     c00:	9000      	str	r0, [sp, #0]
     c02:	1c08      	adds	r0, r1, #0
     c04:	1c19      	adds	r1, r3, #0
     c06:	2300      	movs	r3, #0
     c08:	f7ff fecc 	bl	9a4 <PutHexa>
     c0c:	1c03      	adds	r3, r0, #0
     c0e:	61bb      	str	r3, [r7, #24]
     c10:	e033      	b.n	c7a <vsnprintf+0x1ea>
     c12:	1c3b      	adds	r3, r7, #0
     c14:	331e      	adds	r3, #30
     c16:	781a      	ldrb	r2, [r3, #0]
     c18:	683b      	ldr	r3, [r7, #0]
     c1a:	1d19      	adds	r1, r3, #4
     c1c:	6039      	str	r1, [r7, #0]
     c1e:	6818      	ldr	r0, [r3, #0]
     c20:	68f9      	ldr	r1, [r7, #12]
     c22:	1c3b      	adds	r3, r7, #0
     c24:	331f      	adds	r3, #31
     c26:	781b      	ldrb	r3, [r3, #0]
     c28:	9000      	str	r0, [sp, #0]
     c2a:	1c08      	adds	r0, r1, #0
     c2c:	1c19      	adds	r1, r3, #0
     c2e:	2301      	movs	r3, #1
     c30:	f7ff feb8 	bl	9a4 <PutHexa>
     c34:	1c03      	adds	r3, r0, #0
     c36:	61bb      	str	r3, [r7, #24]
     c38:	e01f      	b.n	c7a <vsnprintf+0x1ea>
     c3a:	1c3b      	adds	r3, r7, #0
     c3c:	331e      	adds	r3, #30
     c3e:	781a      	ldrb	r2, [r3, #0]
     c40:	683b      	ldr	r3, [r7, #0]
     c42:	1d19      	adds	r1, r3, #4
     c44:	6039      	str	r1, [r7, #0]
     c46:	681b      	ldr	r3, [r3, #0]
     c48:	68f8      	ldr	r0, [r7, #12]
     c4a:	1c39      	adds	r1, r7, #0
     c4c:	311f      	adds	r1, #31
     c4e:	7809      	ldrb	r1, [r1, #0]
     c50:	f7ff fd98 	bl	784 <PutString>
     c54:	1c03      	adds	r3, r0, #0
     c56:	61bb      	str	r3, [r7, #24]
     c58:	e00f      	b.n	c7a <vsnprintf+0x1ea>
     c5a:	683b      	ldr	r3, [r7, #0]
     c5c:	1d1a      	adds	r2, r3, #4
     c5e:	603a      	str	r2, [r7, #0]
     c60:	681b      	ldr	r3, [r3, #0]
     c62:	b2db      	uxtb	r3, r3
     c64:	68fa      	ldr	r2, [r7, #12]
     c66:	1c10      	adds	r0, r2, #0
     c68:	1c19      	adds	r1, r3, #0
     c6a:	f7ff fd7b 	bl	764 <append_char>
     c6e:	1c03      	adds	r3, r0, #0
     c70:	61bb      	str	r3, [r7, #24]
     c72:	e002      	b.n	c7a <vsnprintf+0x1ea>
     c74:	2301      	movs	r3, #1
     c76:	425b      	negs	r3, r3
     c78:	e027      	b.n	cca <vsnprintf+0x23a>
     c7a:	687b      	ldr	r3, [r7, #4]
     c7c:	3301      	adds	r3, #1
     c7e:	607b      	str	r3, [r7, #4]
     c80:	69bb      	ldr	r3, [r7, #24]
     c82:	68fa      	ldr	r2, [r7, #12]
     c84:	18d3      	adds	r3, r2, r3
     c86:	60fb      	str	r3, [r7, #12]
     c88:	697a      	ldr	r2, [r7, #20]
     c8a:	69bb      	ldr	r3, [r7, #24]
     c8c:	18d3      	adds	r3, r2, r3
     c8e:	617b      	str	r3, [r7, #20]
     c90:	e000      	b.n	c94 <vsnprintf+0x204>
     c92:	46c0      	nop			; (mov r8, r8)
     c94:	687b      	ldr	r3, [r7, #4]
     c96:	781b      	ldrb	r3, [r3, #0]
     c98:	2b00      	cmp	r3, #0
     c9a:	d004      	beq.n	ca6 <vsnprintf+0x216>
     c9c:	697a      	ldr	r2, [r7, #20]
     c9e:	68bb      	ldr	r3, [r7, #8]
     ca0:	429a      	cmp	r2, r3
     ca2:	d200      	bcs.n	ca6 <vsnprintf+0x216>
     ca4:	e707      	b.n	ab6 <vsnprintf+0x26>
     ca6:	697a      	ldr	r2, [r7, #20]
     ca8:	68bb      	ldr	r3, [r7, #8]
     caa:	429a      	cmp	r2, r3
     cac:	d203      	bcs.n	cb6 <vsnprintf+0x226>
     cae:	68fb      	ldr	r3, [r7, #12]
     cb0:	2200      	movs	r2, #0
     cb2:	701a      	strb	r2, [r3, #0]
     cb4:	e008      	b.n	cc8 <vsnprintf+0x238>
     cb6:	68fb      	ldr	r3, [r7, #12]
     cb8:	3b01      	subs	r3, #1
     cba:	60fb      	str	r3, [r7, #12]
     cbc:	68fb      	ldr	r3, [r7, #12]
     cbe:	2200      	movs	r2, #0
     cc0:	701a      	strb	r2, [r3, #0]
     cc2:	697b      	ldr	r3, [r7, #20]
     cc4:	3b01      	subs	r3, #1
     cc6:	617b      	str	r3, [r7, #20]
     cc8:	697b      	ldr	r3, [r7, #20]
     cca:	1c18      	adds	r0, r3, #0
     ccc:	46bd      	mov	sp, r7
     cce:	b008      	add	sp, #32
     cd0:	bd80      	pop	{r7, pc}
     cd2:	46c0      	nop			; (mov r8, r8)
     cd4:	0000105c 	.word	0x0000105c

00000cd8 <vsprintf>:
     cd8:	b580      	push	{r7, lr}
     cda:	b084      	sub	sp, #16
     cdc:	af00      	add	r7, sp, #0
     cde:	60f8      	str	r0, [r7, #12]
     ce0:	60b9      	str	r1, [r7, #8]
     ce2:	607a      	str	r2, [r7, #4]
     ce4:	68f9      	ldr	r1, [r7, #12]
     ce6:	68ba      	ldr	r2, [r7, #8]
     ce8:	687b      	ldr	r3, [r7, #4]
     cea:	1c08      	adds	r0, r1, #0
     cec:	21ff      	movs	r1, #255	; 0xff
     cee:	f7ff fecf 	bl	a90 <vsnprintf>
     cf2:	1c03      	adds	r3, r0, #0
     cf4:	1c18      	adds	r0, r3, #0
     cf6:	46bd      	mov	sp, r7
     cf8:	b004      	add	sp, #16
     cfa:	bd80      	pop	{r7, pc}

00000cfc <vprintf>:
     cfc:	b590      	push	{r4, r7, lr}
     cfe:	b0cd      	sub	sp, #308	; 0x134
     d00:	af00      	add	r7, sp, #0
     d02:	6078      	str	r0, [r7, #4]
     d04:	6039      	str	r1, [r7, #0]
     d06:	4b14      	ldr	r3, [pc, #80]	; (d58 <vprintf+0x5c>)
     d08:	2098      	movs	r0, #152	; 0x98
     d0a:	0040      	lsls	r0, r0, #1
     d0c:	19c0      	adds	r0, r0, r7
     d0e:	18c3      	adds	r3, r0, r3
     d10:	4a12      	ldr	r2, [pc, #72]	; (d5c <vprintf+0x60>)
     d12:	ca13      	ldmia	r2!, {r0, r1, r4}
     d14:	c313      	stmia	r3!, {r0, r1, r4}
     d16:	ca13      	ldmia	r2!, {r0, r1, r4}
     d18:	c313      	stmia	r3!, {r0, r1, r4}
     d1a:	ca13      	ldmia	r2!, {r0, r1, r4}
     d1c:	c313      	stmia	r3!, {r0, r1, r4}
     d1e:	1c39      	adds	r1, r7, #0
     d20:	3130      	adds	r1, #48	; 0x30
     d22:	687a      	ldr	r2, [r7, #4]
     d24:	683b      	ldr	r3, [r7, #0]
     d26:	1c08      	adds	r0, r1, #0
     d28:	1c11      	adds	r1, r2, #0
     d2a:	1c1a      	adds	r2, r3, #0
     d2c:	f7ff ffd4 	bl	cd8 <vsprintf>
     d30:	1c03      	adds	r3, r0, #0
     d32:	2bfe      	cmp	r3, #254	; 0xfe
     d34:	dd05      	ble.n	d42 <vprintf+0x46>
     d36:	1c3b      	adds	r3, r7, #0
     d38:	330c      	adds	r3, #12
     d3a:	1c18      	adds	r0, r3, #0
     d3c:	f000 f84a 	bl	dd4 <puts>
     d40:	e7fe      	b.n	d40 <vprintf+0x44>
     d42:	1c3b      	adds	r3, r7, #0
     d44:	3330      	adds	r3, #48	; 0x30
     d46:	1c18      	adds	r0, r3, #0
     d48:	f000 f844 	bl	dd4 <puts>
     d4c:	1c03      	adds	r3, r0, #0
     d4e:	1c18      	adds	r0, r3, #0
     d50:	46bd      	mov	sp, r7
     d52:	b04d      	add	sp, #308	; 0x134
     d54:	bd90      	pop	{r4, r7, pc}
     d56:	46c0      	nop			; (mov r8, r8)
     d58:	fffffedc 	.word	0xfffffedc
     d5c:	000010e0 	.word	0x000010e0

00000d60 <printf>:
     d60:	b40f      	push	{r0, r1, r2, r3}
     d62:	b580      	push	{r7, lr}
     d64:	b082      	sub	sp, #8
     d66:	af00      	add	r7, sp, #0
     d68:	1c3b      	adds	r3, r7, #0
     d6a:	3314      	adds	r3, #20
     d6c:	603b      	str	r3, [r7, #0]
     d6e:	693a      	ldr	r2, [r7, #16]
     d70:	683b      	ldr	r3, [r7, #0]
     d72:	1c10      	adds	r0, r2, #0
     d74:	1c19      	adds	r1, r3, #0
     d76:	f7ff ffc1 	bl	cfc <vprintf>
     d7a:	1c03      	adds	r3, r0, #0
     d7c:	607b      	str	r3, [r7, #4]
     d7e:	687b      	ldr	r3, [r7, #4]
     d80:	1c18      	adds	r0, r3, #0
     d82:	46bd      	mov	sp, r7
     d84:	b002      	add	sp, #8
     d86:	bc80      	pop	{r7}
     d88:	bc08      	pop	{r3}
     d8a:	b004      	add	sp, #16
     d8c:	4718      	bx	r3
     d8e:	46c0      	nop			; (mov r8, r8)

00000d90 <WDT_IRQHandler>:
     d90:	b580      	push	{r7, lr}
     d92:	af00      	add	r7, sp, #0
     d94:	4b06      	ldr	r3, [pc, #24]	; (db0 <WDT_IRQHandler+0x20>)
     d96:	4a06      	ldr	r2, [pc, #24]	; (db0 <WDT_IRQHandler+0x20>)
     d98:	6812      	ldr	r2, [r2, #0]
     d9a:	2104      	movs	r1, #4
     d9c:	438a      	bics	r2, r1
     d9e:	601a      	str	r2, [r3, #0]
     da0:	4b04      	ldr	r3, [pc, #16]	; (db4 <WDT_IRQHandler+0x24>)
     da2:	681b      	ldr	r3, [r3, #0]
     da4:	1c5a      	adds	r2, r3, #1
     da6:	4b03      	ldr	r3, [pc, #12]	; (db4 <WDT_IRQHandler+0x24>)
     da8:	601a      	str	r2, [r3, #0]
     daa:	46bd      	mov	sp, r7
     dac:	bd80      	pop	{r7, pc}
     dae:	46c0      	nop			; (mov r8, r8)
     db0:	40004000 	.word	0x40004000
     db4:	1000014c 	.word	0x1000014c

00000db8 <__putchar>:
     db8:	b580      	push	{r7, lr}
     dba:	b082      	sub	sp, #8
     dbc:	af00      	add	r7, sp, #0
     dbe:	1c02      	adds	r2, r0, #0
     dc0:	1dfb      	adds	r3, r7, #7
     dc2:	701a      	strb	r2, [r3, #0]
     dc4:	1dfb      	adds	r3, r7, #7
     dc6:	781b      	ldrb	r3, [r3, #0]
     dc8:	1c18      	adds	r0, r3, #0
     dca:	f7ff fc83 	bl	6d4 <uartSendByte>
     dce:	46bd      	mov	sp, r7
     dd0:	b002      	add	sp, #8
     dd2:	bd80      	pop	{r7, pc}

00000dd4 <puts>:
     dd4:	b580      	push	{r7, lr}
     dd6:	b082      	sub	sp, #8
     dd8:	af00      	add	r7, sp, #0
     dda:	6078      	str	r0, [r7, #4]
     ddc:	e007      	b.n	dee <puts+0x1a>
     dde:	687b      	ldr	r3, [r7, #4]
     de0:	781b      	ldrb	r3, [r3, #0]
     de2:	687a      	ldr	r2, [r7, #4]
     de4:	3201      	adds	r2, #1
     de6:	607a      	str	r2, [r7, #4]
     de8:	1c18      	adds	r0, r3, #0
     dea:	f7ff ffe5 	bl	db8 <__putchar>
     dee:	687b      	ldr	r3, [r7, #4]
     df0:	781b      	ldrb	r3, [r3, #0]
     df2:	2b00      	cmp	r3, #0
     df4:	d1f3      	bne.n	dde <puts+0xa>
     df6:	2300      	movs	r3, #0
     df8:	1c18      	adds	r0, r3, #0
     dfa:	46bd      	mov	sp, r7
     dfc:	b002      	add	sp, #8
     dfe:	bd80      	pop	{r7, pc}

00000e00 <irq_undefined>:
     e00:	b580      	push	{r7, lr}
     e02:	af00      	add	r7, sp, #0
     e04:	e7fe      	b.n	e04 <irq_undefined+0x4>
     e06:	46c0      	nop			; (mov r8, r8)

00000e08 <fault_undefined>:
     e08:	b580      	push	{r7, lr}
     e0a:	af00      	add	r7, sp, #0
     e0c:	e7fe      	b.n	e0c <fault_undefined+0x4>
     e0e:	46c0      	nop			; (mov r8, r8)

00000e10 <boot_entry>:
     e10:	b5b0      	push	{r4, r5, r7, lr}
     e12:	af00      	add	r7, sp, #0
     e14:	4d0a      	ldr	r5, [pc, #40]	; (e40 <boot_entry+0x30>)
     e16:	4c0b      	ldr	r4, [pc, #44]	; (e44 <boot_entry+0x34>)
     e18:	e003      	b.n	e22 <boot_entry+0x12>
     e1a:	782b      	ldrb	r3, [r5, #0]
     e1c:	7023      	strb	r3, [r4, #0]
     e1e:	3401      	adds	r4, #1
     e20:	3501      	adds	r5, #1
     e22:	4b09      	ldr	r3, [pc, #36]	; (e48 <boot_entry+0x38>)
     e24:	429c      	cmp	r4, r3
     e26:	d3f8      	bcc.n	e1a <boot_entry+0xa>
     e28:	4c08      	ldr	r4, [pc, #32]	; (e4c <boot_entry+0x3c>)
     e2a:	e002      	b.n	e32 <boot_entry+0x22>
     e2c:	2300      	movs	r3, #0
     e2e:	7023      	strb	r3, [r4, #0]
     e30:	3401      	adds	r4, #1
     e32:	4b07      	ldr	r3, [pc, #28]	; (e50 <boot_entry+0x40>)
     e34:	429c      	cmp	r4, r3
     e36:	d3f9      	bcc.n	e2c <boot_entry+0x1c>
     e38:	f7ff f942 	bl	c0 <main>
     e3c:	e7fe      	b.n	e3c <boot_entry+0x2c>
     e3e:	46c0      	nop			; (mov r8, r8)
     e40:	00001104 	.word	0x00001104
     e44:	10000000 	.word	0x10000000
     e48:	10000000 	.word	0x10000000
     e4c:	10000000 	.word	0x10000000
     e50:	10000150 	.word	0x10000150

00000e54 <__aeabi_uidiv>:
     e54:	2900      	cmp	r1, #0
     e56:	d034      	beq.n	ec2 <.udivsi3_skip_div0_test+0x6a>

00000e58 <.udivsi3_skip_div0_test>:
     e58:	2301      	movs	r3, #1
     e5a:	2200      	movs	r2, #0
     e5c:	b410      	push	{r4}
     e5e:	4288      	cmp	r0, r1
     e60:	d32c      	bcc.n	ebc <.udivsi3_skip_div0_test+0x64>
     e62:	2401      	movs	r4, #1
     e64:	0724      	lsls	r4, r4, #28
     e66:	42a1      	cmp	r1, r4
     e68:	d204      	bcs.n	e74 <.udivsi3_skip_div0_test+0x1c>
     e6a:	4281      	cmp	r1, r0
     e6c:	d202      	bcs.n	e74 <.udivsi3_skip_div0_test+0x1c>
     e6e:	0109      	lsls	r1, r1, #4
     e70:	011b      	lsls	r3, r3, #4
     e72:	e7f8      	b.n	e66 <.udivsi3_skip_div0_test+0xe>
     e74:	00e4      	lsls	r4, r4, #3
     e76:	42a1      	cmp	r1, r4
     e78:	d204      	bcs.n	e84 <.udivsi3_skip_div0_test+0x2c>
     e7a:	4281      	cmp	r1, r0
     e7c:	d202      	bcs.n	e84 <.udivsi3_skip_div0_test+0x2c>
     e7e:	0049      	lsls	r1, r1, #1
     e80:	005b      	lsls	r3, r3, #1
     e82:	e7f8      	b.n	e76 <.udivsi3_skip_div0_test+0x1e>
     e84:	4288      	cmp	r0, r1
     e86:	d301      	bcc.n	e8c <.udivsi3_skip_div0_test+0x34>
     e88:	1a40      	subs	r0, r0, r1
     e8a:	431a      	orrs	r2, r3
     e8c:	084c      	lsrs	r4, r1, #1
     e8e:	42a0      	cmp	r0, r4
     e90:	d302      	bcc.n	e98 <.udivsi3_skip_div0_test+0x40>
     e92:	1b00      	subs	r0, r0, r4
     e94:	085c      	lsrs	r4, r3, #1
     e96:	4322      	orrs	r2, r4
     e98:	088c      	lsrs	r4, r1, #2
     e9a:	42a0      	cmp	r0, r4
     e9c:	d302      	bcc.n	ea4 <.udivsi3_skip_div0_test+0x4c>
     e9e:	1b00      	subs	r0, r0, r4
     ea0:	089c      	lsrs	r4, r3, #2
     ea2:	4322      	orrs	r2, r4
     ea4:	08cc      	lsrs	r4, r1, #3
     ea6:	42a0      	cmp	r0, r4
     ea8:	d302      	bcc.n	eb0 <.udivsi3_skip_div0_test+0x58>
     eaa:	1b00      	subs	r0, r0, r4
     eac:	08dc      	lsrs	r4, r3, #3
     eae:	4322      	orrs	r2, r4
     eb0:	2800      	cmp	r0, #0
     eb2:	d003      	beq.n	ebc <.udivsi3_skip_div0_test+0x64>
     eb4:	091b      	lsrs	r3, r3, #4
     eb6:	d001      	beq.n	ebc <.udivsi3_skip_div0_test+0x64>
     eb8:	0909      	lsrs	r1, r1, #4
     eba:	e7e3      	b.n	e84 <.udivsi3_skip_div0_test+0x2c>
     ebc:	1c10      	adds	r0, r2, #0
     ebe:	bc10      	pop	{r4}
     ec0:	4770      	bx	lr
     ec2:	2800      	cmp	r0, #0
     ec4:	d001      	beq.n	eca <.udivsi3_skip_div0_test+0x72>
     ec6:	2000      	movs	r0, #0
     ec8:	43c0      	mvns	r0, r0
     eca:	b407      	push	{r0, r1, r2}
     ecc:	4802      	ldr	r0, [pc, #8]	; (ed8 <.udivsi3_skip_div0_test+0x80>)
     ece:	a102      	add	r1, pc, #8	; (adr r1, ed8 <.udivsi3_skip_div0_test+0x80>)
     ed0:	1840      	adds	r0, r0, r1
     ed2:	9002      	str	r0, [sp, #8]
     ed4:	bd03      	pop	{r0, r1, pc}
     ed6:	46c0      	nop			; (mov r8, r8)
     ed8:	00000019 	.word	0x00000019

00000edc <__aeabi_uidivmod>:
     edc:	2900      	cmp	r1, #0
     ede:	d0f0      	beq.n	ec2 <.udivsi3_skip_div0_test+0x6a>
     ee0:	b503      	push	{r0, r1, lr}
     ee2:	f7ff ffb9 	bl	e58 <.udivsi3_skip_div0_test>
     ee6:	bc0e      	pop	{r1, r2, r3}
     ee8:	4342      	muls	r2, r0
     eea:	1a89      	subs	r1, r1, r2
     eec:	4718      	bx	r3
     eee:	46c0      	nop			; (mov r8, r8)

00000ef0 <__aeabi_idiv0>:
     ef0:	4770      	bx	lr
     ef2:	46c0      	nop			; (mov r8, r8)
     ef4:	000001f8 	.word	0x000001f8
     ef8:	00000380 	.word	0x00000380
     efc:	00000380 	.word	0x00000380
     f00:	00000380 	.word	0x00000380
     f04:	00000380 	.word	0x00000380
     f08:	00000380 	.word	0x00000380
     f0c:	00000380 	.word	0x00000380
     f10:	00000380 	.word	0x00000380
     f14:	00000220 	.word	0x00000220
     f18:	00000380 	.word	0x00000380
     f1c:	00000380 	.word	0x00000380
     f20:	00000380 	.word	0x00000380
     f24:	00000380 	.word	0x00000380
     f28:	00000380 	.word	0x00000380
     f2c:	00000380 	.word	0x00000380
     f30:	00000380 	.word	0x00000380
     f34:	00000242 	.word	0x00000242
     f38:	00000380 	.word	0x00000380
     f3c:	00000380 	.word	0x00000380
     f40:	00000380 	.word	0x00000380
     f44:	00000380 	.word	0x00000380
     f48:	00000380 	.word	0x00000380
     f4c:	00000380 	.word	0x00000380
     f50:	00000380 	.word	0x00000380
     f54:	0000025e 	.word	0x0000025e
     f58:	00000380 	.word	0x00000380
     f5c:	00000380 	.word	0x00000380
     f60:	00000380 	.word	0x00000380
     f64:	00000380 	.word	0x00000380
     f68:	00000380 	.word	0x00000380
     f6c:	00000380 	.word	0x00000380
     f70:	00000380 	.word	0x00000380
     f74:	00000274 	.word	0x00000274
     f78:	00000380 	.word	0x00000380
     f7c:	00000380 	.word	0x00000380
     f80:	00000380 	.word	0x00000380
     f84:	00000380 	.word	0x00000380
     f88:	00000380 	.word	0x00000380
     f8c:	00000380 	.word	0x00000380
     f90:	00000380 	.word	0x00000380
     f94:	000002be 	.word	0x000002be
     f98:	00000380 	.word	0x00000380
     f9c:	00000380 	.word	0x00000380
     fa0:	00000380 	.word	0x00000380
     fa4:	00000380 	.word	0x00000380
     fa8:	00000380 	.word	0x00000380
     fac:	00000380 	.word	0x00000380
     fb0:	00000380 	.word	0x00000380
     fb4:	000002d6 	.word	0x000002d6
     fb8:	00000380 	.word	0x00000380
     fbc:	00000380 	.word	0x00000380
     fc0:	00000380 	.word	0x00000380
     fc4:	00000380 	.word	0x00000380
     fc8:	00000380 	.word	0x00000380
     fcc:	00000380 	.word	0x00000380
     fd0:	00000380 	.word	0x00000380
     fd4:	000002e6 	.word	0x000002e6
     fd8:	00000380 	.word	0x00000380
     fdc:	00000380 	.word	0x00000380
     fe0:	00000380 	.word	0x00000380
     fe4:	00000380 	.word	0x00000380
     fe8:	00000380 	.word	0x00000380
     fec:	00000380 	.word	0x00000380
     ff0:	00000380 	.word	0x00000380
     ff4:	00000306 	.word	0x00000306
     ff8:	00000380 	.word	0x00000380
     ffc:	00000380 	.word	0x00000380
    1000:	00000380 	.word	0x00000380
    1004:	00000380 	.word	0x00000380
    1008:	00000380 	.word	0x00000380
    100c:	00000380 	.word	0x00000380
    1010:	00000380 	.word	0x00000380
    1014:	0000031c 	.word	0x0000031c
    1018:	00000380 	.word	0x00000380
    101c:	00000380 	.word	0x00000380
    1020:	00000380 	.word	0x00000380
    1024:	00000380 	.word	0x00000380
    1028:	00000380 	.word	0x00000380
    102c:	00000380 	.word	0x00000380
    1030:	00000380 	.word	0x00000380
    1034:	00000356 	.word	0x00000356
    1038:	7265764f 	.word	0x7265764f
    103c:	0d6e7572 	.word	0x0d6e7572
    1040:	0000000a 	.word	0x0000000a
    1044:	656d6954 	.word	0x656d6954
    1048:	0d74756f 	.word	0x0d74756f
    104c:	0000000a 	.word	0x0000000a
    1050:	66207852 	.word	0x66207852
    1054:	0d6c6c75 	.word	0x0d6c6c75
    1058:	0000000a 	.word	0x0000000a
    105c:	00000c12 	.word	0x00000c12
    1060:	00000c74 	.word	0x00000c74
    1064:	00000c74 	.word	0x00000c74
    1068:	00000c74 	.word	0x00000c74
    106c:	00000c74 	.word	0x00000c74
    1070:	00000c74 	.word	0x00000c74
    1074:	00000c74 	.word	0x00000c74
    1078:	00000c74 	.word	0x00000c74
    107c:	00000c74 	.word	0x00000c74
    1080:	00000c74 	.word	0x00000c74
    1084:	00000c74 	.word	0x00000c74
    1088:	00000c5a 	.word	0x00000c5a
    108c:	00000baa 	.word	0x00000baa
    1090:	00000c74 	.word	0x00000c74
    1094:	00000c74 	.word	0x00000c74
    1098:	00000c74 	.word	0x00000c74
    109c:	00000c74 	.word	0x00000c74
    10a0:	00000baa 	.word	0x00000baa
    10a4:	00000c74 	.word	0x00000c74
    10a8:	00000c74 	.word	0x00000c74
    10ac:	00000c74 	.word	0x00000c74
    10b0:	00000c74 	.word	0x00000c74
    10b4:	00000c74 	.word	0x00000c74
    10b8:	00000c74 	.word	0x00000c74
    10bc:	00000c74 	.word	0x00000c74
    10c0:	00000c74 	.word	0x00000c74
    10c4:	00000c74 	.word	0x00000c74
    10c8:	00000c3a 	.word	0x00000c3a
    10cc:	00000c74 	.word	0x00000c74
    10d0:	00000bca 	.word	0x00000bca
    10d4:	00000c74 	.word	0x00000c74
    10d8:	00000c74 	.word	0x00000c74
    10dc:	00000bea 	.word	0x00000bea
    10e0:	69647473 	.word	0x69647473
    10e4:	3a632e6f 	.word	0x3a632e6f
    10e8:	636e6920 	.word	0x636e6920
    10ec:	73616572 	.word	0x73616572
    10f0:	414d2065 	.word	0x414d2065
    10f4:	54535f58 	.word	0x54535f58
    10f8:	474e4952 	.word	0x474e4952
    10fc:	5a49535f 	.word	0x5a49535f
    1100:	000a0d45 	.word	0x000a0d45
