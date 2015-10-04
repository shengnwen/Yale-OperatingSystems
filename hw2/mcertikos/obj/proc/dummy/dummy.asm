
obj/proc/dummy/dummy:     file format elf32-i386


Disassembly of section .text:

400000a0 <main>:
400000a0:	55                   	push   %ebp
400000a1:	89 e5                	mov    %esp,%ebp
400000a3:	56                   	push   %esi
400000a4:	31 f6                	xor    %esi,%esi
400000a6:	53                   	push   %ebx
400000a7:	83 e4 f0             	and    $0xfffffff0,%esp
400000aa:	83 ec 10             	sub    $0x10,%esp
400000ad:	c7 04 24 70 15 00 40 	movl   $0x40001570,(%esp)
400000b4:	e8 67 04 00 00       	call   40000520 <printf>
400000b9:	c7 04 24 a4 15 00 40 	movl   $0x400015a4,(%esp)
400000c0:	e8 5b 04 00 00       	call   40000520 <printf>
400000c5:	c7 04 24 4c 17 00 40 	movl   $0x4000174c,(%esp)
400000cc:	e8 4f 04 00 00       	call   40000520 <printf>
400000d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400000d8:	e8 13 10 00 00       	call   400010f0 <sys_getc>
400000dd:	85 c0                	test   %eax,%eax
400000df:	74 f7                	je     400000d8 <main+0x38>
400000e1:	83 f8 1a             	cmp    $0x1a,%eax
400000e4:	74 4a                	je     40000130 <main+0x90>
400000e6:	83 f8 0d             	cmp    $0xd,%eax
400000e9:	74 5d                	je     40000148 <main+0xa8>
400000eb:	83 f8 0a             	cmp    $0xa,%eax
400000ee:	66 90                	xchg   %ax,%ax
400000f0:	74 56                	je     40000148 <main+0xa8>
400000f2:	8d 50 d0             	lea    -0x30(%eax),%edx
400000f5:	83 fa 09             	cmp    $0x9,%edx
400000f8:	77 de                	ja     400000d8 <main+0x38>
400000fa:	81 fe 98 99 99 19    	cmp    $0x19999998,%esi
40000100:	0f 86 c2 00 00 00    	jbe    400001c8 <main+0x128>
40000106:	c7 04 24 8b 17 00 40 	movl   $0x4000178b,(%esp)
4000010d:	31 f6                	xor    %esi,%esi
4000010f:	e8 0c 04 00 00       	call   40000520 <printf>
40000114:	c7 04 24 4c 17 00 40 	movl   $0x4000174c,(%esp)
4000011b:	e8 00 04 00 00       	call   40000520 <printf>
40000120:	e8 cb 0f 00 00       	call   400010f0 <sys_getc>
40000125:	85 c0                	test   %eax,%eax
40000127:	74 af                	je     400000d8 <main+0x38>
40000129:	83 f8 1a             	cmp    $0x1a,%eax
4000012c:	75 b8                	jne    400000e6 <main+0x46>
4000012e:	66 90                	xchg   %ax,%ax
40000130:	c7 04 24 dc 15 00 40 	movl   $0x400015dc,(%esp)
40000137:	e8 e4 03 00 00       	call   40000520 <printf>
4000013c:	8d 65 f8             	lea    -0x8(%ebp),%esp
4000013f:	31 c0                	xor    %eax,%eax
40000141:	5b                   	pop    %ebx
40000142:	5e                   	pop    %esi
40000143:	5d                   	pop    %ebp
40000144:	c3                   	ret    
40000145:	8d 76 00             	lea    0x0(%esi),%esi
40000148:	c7 04 24 a1 17 00 40 	movl   $0x400017a1,(%esp)
4000014f:	e8 cc 03 00 00       	call   40000520 <printf>
40000154:	89 74 24 04          	mov    %esi,0x4(%esp)
40000158:	c7 04 24 60 17 00 40 	movl   $0x40001760,(%esp)
4000015f:	e8 bc 03 00 00       	call   40000520 <printf>
40000164:	c7 04 24 00 16 00 40 	movl   $0x40001600,(%esp)
4000016b:	e8 b0 03 00 00       	call   40000520 <printf>
40000170:	e8 7b 0f 00 00       	call   400010f0 <sys_getc>
40000175:	84 c0                	test   %al,%al
40000177:	89 c3                	mov    %eax,%ebx
40000179:	74 f5                	je     40000170 <main+0xd0>
4000017b:	0f be c0             	movsbl %al,%eax
4000017e:	89 44 24 04          	mov    %eax,0x4(%esp)
40000182:	c7 04 24 75 17 00 40 	movl   $0x40001775,(%esp)
40000189:	e8 92 03 00 00       	call   40000520 <printf>
4000018e:	80 fb 72             	cmp    $0x72,%bl
40000191:	74 55                	je     400001e8 <main+0x148>
40000193:	80 fb 77             	cmp    $0x77,%bl
40000196:	0f 84 84 00 00 00    	je     40000220 <main+0x180>
4000019c:	c7 04 24 79 17 00 40 	movl   $0x40001779,(%esp)
400001a3:	e8 78 03 00 00       	call   40000520 <printf>
400001a8:	c7 04 24 00 16 00 40 	movl   $0x40001600,(%esp)
400001af:	e8 6c 03 00 00       	call   40000520 <printf>
400001b4:	e8 37 0f 00 00       	call   400010f0 <sys_getc>
400001b9:	84 c0                	test   %al,%al
400001bb:	89 c3                	mov    %eax,%ebx
400001bd:	74 b1                	je     40000170 <main+0xd0>
400001bf:	90                   	nop
400001c0:	eb b9                	jmp    4000017b <main+0xdb>
400001c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
400001c8:	8d 14 b6             	lea    (%esi,%esi,4),%edx
400001cb:	89 44 24 04          	mov    %eax,0x4(%esp)
400001cf:	8d 74 50 d0          	lea    -0x30(%eax,%edx,2),%esi
400001d3:	c7 04 24 a3 17 00 40 	movl   $0x400017a3,(%esp)
400001da:	e8 41 03 00 00       	call   40000520 <printf>
400001df:	e9 f4 fe ff ff       	jmp    400000d8 <main+0x38>
400001e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
400001e8:	8b 06                	mov    (%esi),%eax
400001ea:	89 74 24 04          	mov    %esi,0x4(%esp)
400001ee:	c7 04 24 30 16 00 40 	movl   $0x40001630,(%esp)
400001f5:	89 44 24 08          	mov    %eax,0x8(%esp)
400001f9:	e8 22 03 00 00       	call   40000520 <printf>
400001fe:	c7 04 24 14 17 00 40 	movl   $0x40001714,(%esp)
40000205:	31 f6                	xor    %esi,%esi
40000207:	e8 14 03 00 00       	call   40000520 <printf>
4000020c:	c7 04 24 4c 17 00 40 	movl   $0x4000174c,(%esp)
40000213:	e8 08 03 00 00       	call   40000520 <printf>
40000218:	e9 bb fe ff ff       	jmp    400000d8 <main+0x38>
4000021d:	8d 76 00             	lea    0x0(%esi),%esi
40000220:	c7 04 24 58 16 00 40 	movl   $0x40001658,(%esp)
40000227:	e8 f4 02 00 00       	call   40000520 <printf>
4000022c:	c7 04 24 8c 16 00 40 	movl   $0x4000168c,(%esp)
40000233:	e8 e8 02 00 00       	call   40000520 <printf>
40000238:	e8 b3 0e 00 00       	call   400010f0 <sys_getc>
4000023d:	8d 58 d0             	lea    -0x30(%eax),%ebx
40000240:	83 fb 09             	cmp    $0x9,%ebx
40000243:	77 f3                	ja     40000238 <main+0x198>
40000245:	89 44 24 04          	mov    %eax,0x4(%esp)
40000249:	c7 04 24 75 17 00 40 	movl   $0x40001775,(%esp)
40000250:	e8 cb 02 00 00       	call   40000520 <printf>
40000255:	89 1e                	mov    %ebx,(%esi)
40000257:	c7 04 24 ac 16 00 40 	movl   $0x400016ac,(%esp)
4000025e:	e8 bd 02 00 00       	call   40000520 <printf>
40000263:	eb 99                	jmp    400001fe <main+0x15e>
40000265:	66 90                	xchg   %ax,%ax
40000267:	90                   	nop

40000268 <_start>:
40000268:	60                   	pusha  
40000269:	e8 52 0e 00 00       	call   400010c0 <init>
4000026e:	e8 2d fe ff ff       	call   400000a0 <main>
40000273:	61                   	popa   
40000274:	c3                   	ret    
40000275:	66 90                	xchg   %ax,%ax
40000277:	66 90                	xchg   %ax,%ax
40000279:	66 90                	xchg   %ax,%ax
4000027b:	66 90                	xchg   %ax,%ax
4000027d:	66 90                	xchg   %ax,%ax
4000027f:	90                   	nop

40000280 <debug>:
40000280:	83 ec 1c             	sub    $0x1c,%esp
40000283:	8b 44 24 24          	mov    0x24(%esp),%eax
40000287:	c7 04 24 d8 13 00 40 	movl   $0x400013d8,(%esp)
4000028e:	89 44 24 08          	mov    %eax,0x8(%esp)
40000292:	8b 44 24 20          	mov    0x20(%esp),%eax
40000296:	89 44 24 04          	mov    %eax,0x4(%esp)
4000029a:	e8 81 02 00 00       	call   40000520 <printf>
4000029f:	8d 44 24 2c          	lea    0x2c(%esp),%eax
400002a3:	89 44 24 04          	mov    %eax,0x4(%esp)
400002a7:	8b 44 24 28          	mov    0x28(%esp),%eax
400002ab:	89 04 24             	mov    %eax,(%esp)
400002ae:	e8 fd 01 00 00       	call   400004b0 <vcprintf>
400002b3:	83 c4 1c             	add    $0x1c,%esp
400002b6:	c3                   	ret    
400002b7:	89 f6                	mov    %esi,%esi
400002b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

400002c0 <warn>:
400002c0:	83 ec 1c             	sub    $0x1c,%esp
400002c3:	8b 44 24 24          	mov    0x24(%esp),%eax
400002c7:	c7 04 24 e4 13 00 40 	movl   $0x400013e4,(%esp)
400002ce:	89 44 24 08          	mov    %eax,0x8(%esp)
400002d2:	8b 44 24 20          	mov    0x20(%esp),%eax
400002d6:	89 44 24 04          	mov    %eax,0x4(%esp)
400002da:	e8 41 02 00 00       	call   40000520 <printf>
400002df:	8d 44 24 2c          	lea    0x2c(%esp),%eax
400002e3:	89 44 24 04          	mov    %eax,0x4(%esp)
400002e7:	8b 44 24 28          	mov    0x28(%esp),%eax
400002eb:	89 04 24             	mov    %eax,(%esp)
400002ee:	e8 bd 01 00 00       	call   400004b0 <vcprintf>
400002f3:	83 c4 1c             	add    $0x1c,%esp
400002f6:	c3                   	ret    
400002f7:	89 f6                	mov    %esi,%esi
400002f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000300 <panic>:
40000300:	83 ec 1c             	sub    $0x1c,%esp
40000303:	8b 44 24 24          	mov    0x24(%esp),%eax
40000307:	c7 04 24 f0 13 00 40 	movl   $0x400013f0,(%esp)
4000030e:	89 44 24 08          	mov    %eax,0x8(%esp)
40000312:	8b 44 24 20          	mov    0x20(%esp),%eax
40000316:	89 44 24 04          	mov    %eax,0x4(%esp)
4000031a:	e8 01 02 00 00       	call   40000520 <printf>
4000031f:	8d 44 24 2c          	lea    0x2c(%esp),%eax
40000323:	89 44 24 04          	mov    %eax,0x4(%esp)
40000327:	8b 44 24 28          	mov    0x28(%esp),%eax
4000032b:	89 04 24             	mov    %eax,(%esp)
4000032e:	e8 7d 01 00 00       	call   400004b0 <vcprintf>
40000333:	90                   	nop
40000334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000338:	e8 a3 0d 00 00       	call   400010e0 <yield>
4000033d:	eb f9                	jmp    40000338 <panic+0x38>
4000033f:	90                   	nop

40000340 <atoi>:
40000340:	55                   	push   %ebp
40000341:	57                   	push   %edi
40000342:	56                   	push   %esi
40000343:	53                   	push   %ebx
40000344:	8b 74 24 14          	mov    0x14(%esp),%esi
40000348:	0f b6 06             	movzbl (%esi),%eax
4000034b:	3c 2b                	cmp    $0x2b,%al
4000034d:	74 51                	je     400003a0 <atoi+0x60>
4000034f:	3c 2d                	cmp    $0x2d,%al
40000351:	0f 94 c0             	sete   %al
40000354:	0f b6 c0             	movzbl %al,%eax
40000357:	89 c5                	mov    %eax,%ebp
40000359:	89 c7                	mov    %eax,%edi
4000035b:	0f be 0c 06          	movsbl (%esi,%eax,1),%ecx
4000035f:	8d 41 d0             	lea    -0x30(%ecx),%eax
40000362:	3c 09                	cmp    $0x9,%al
40000364:	77 4a                	ja     400003b0 <atoi+0x70>
40000366:	89 f8                	mov    %edi,%eax
40000368:	31 d2                	xor    %edx,%edx
4000036a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000370:	83 c0 01             	add    $0x1,%eax
40000373:	8d 14 92             	lea    (%edx,%edx,4),%edx
40000376:	8d 54 51 d0          	lea    -0x30(%ecx,%edx,2),%edx
4000037a:	0f be 0c 06          	movsbl (%esi,%eax,1),%ecx
4000037e:	8d 59 d0             	lea    -0x30(%ecx),%ebx
40000381:	80 fb 09             	cmp    $0x9,%bl
40000384:	76 ea                	jbe    40000370 <atoi+0x30>
40000386:	39 c7                	cmp    %eax,%edi
40000388:	74 26                	je     400003b0 <atoi+0x70>
4000038a:	89 d1                	mov    %edx,%ecx
4000038c:	f7 d9                	neg    %ecx
4000038e:	85 ed                	test   %ebp,%ebp
40000390:	0f 45 d1             	cmovne %ecx,%edx
40000393:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000397:	89 11                	mov    %edx,(%ecx)
40000399:	5b                   	pop    %ebx
4000039a:	5e                   	pop    %esi
4000039b:	5f                   	pop    %edi
4000039c:	5d                   	pop    %ebp
4000039d:	c3                   	ret    
4000039e:	66 90                	xchg   %ax,%ax
400003a0:	b8 01 00 00 00       	mov    $0x1,%eax
400003a5:	31 ed                	xor    %ebp,%ebp
400003a7:	bf 01 00 00 00       	mov    $0x1,%edi
400003ac:	eb ad                	jmp    4000035b <atoi+0x1b>
400003ae:	66 90                	xchg   %ax,%ax
400003b0:	5b                   	pop    %ebx
400003b1:	31 c0                	xor    %eax,%eax
400003b3:	5e                   	pop    %esi
400003b4:	5f                   	pop    %edi
400003b5:	5d                   	pop    %ebp
400003b6:	c3                   	ret    
400003b7:	66 90                	xchg   %ax,%ax
400003b9:	66 90                	xchg   %ax,%ax
400003bb:	66 90                	xchg   %ax,%ax
400003bd:	66 90                	xchg   %ax,%ax
400003bf:	90                   	nop

400003c0 <putch>:
400003c0:	53                   	push   %ebx
400003c1:	83 ec 18             	sub    $0x18,%esp
400003c4:	8b 5c 24 24          	mov    0x24(%esp),%ebx
400003c8:	8b 4c 24 20          	mov    0x20(%esp),%ecx
400003cc:	8b 13                	mov    (%ebx),%edx
400003ce:	8d 42 01             	lea    0x1(%edx),%eax
400003d1:	3d ff 0f 00 00       	cmp    $0xfff,%eax
400003d6:	89 03                	mov    %eax,(%ebx)
400003d8:	88 4c 13 08          	mov    %cl,0x8(%ebx,%edx,1)
400003dc:	74 0a                	je     400003e8 <putch+0x28>
400003de:	83 43 04 01          	addl   $0x1,0x4(%ebx)
400003e2:	83 c4 18             	add    $0x18,%esp
400003e5:	5b                   	pop    %ebx
400003e6:	c3                   	ret    
400003e7:	90                   	nop
400003e8:	8d 43 08             	lea    0x8(%ebx),%eax
400003eb:	c6 83 07 10 00 00 00 	movb   $0x0,0x1007(%ebx)
400003f2:	c7 44 24 04 ff 0f 00 	movl   $0xfff,0x4(%esp)
400003f9:	00 
400003fa:	89 04 24             	mov    %eax,(%esp)
400003fd:	e8 fe 0c 00 00       	call   40001100 <sys_puts>
40000402:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
40000408:	83 43 04 01          	addl   $0x1,0x4(%ebx)
4000040c:	83 c4 18             	add    $0x18,%esp
4000040f:	5b                   	pop    %ebx
40000410:	c3                   	ret    
40000411:	eb 0d                	jmp    40000420 <gets>
40000413:	90                   	nop
40000414:	90                   	nop
40000415:	90                   	nop
40000416:	90                   	nop
40000417:	90                   	nop
40000418:	90                   	nop
40000419:	90                   	nop
4000041a:	90                   	nop
4000041b:	90                   	nop
4000041c:	90                   	nop
4000041d:	90                   	nop
4000041e:	90                   	nop
4000041f:	90                   	nop

40000420 <gets>:
40000420:	55                   	push   %ebp
40000421:	57                   	push   %edi
40000422:	56                   	push   %esi
40000423:	53                   	push   %ebx
40000424:	31 db                	xor    %ebx,%ebx
40000426:	83 ec 2c             	sub    $0x2c,%esp
40000429:	8b 44 24 44          	mov    0x44(%esp),%eax
4000042d:	8d 6c 24 1e          	lea    0x1e(%esp),%ebp
40000431:	8b 74 24 40          	mov    0x40(%esp),%esi
40000435:	c6 44 24 1f 00       	movb   $0x0,0x1f(%esp)
4000043a:	83 e8 01             	sub    $0x1,%eax
4000043d:	85 c0                	test   %eax,%eax
4000043f:	89 44 24 0c          	mov    %eax,0xc(%esp)
40000443:	7e 41                	jle    40000486 <gets+0x66>
40000445:	8d 76 00             	lea    0x0(%esi),%esi
40000448:	e8 a3 0c 00 00       	call   400010f0 <sys_getc>
4000044d:	84 c0                	test   %al,%al
4000044f:	89 c7                	mov    %eax,%edi
40000451:	74 f5                	je     40000448 <gets+0x28>
40000453:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
4000045a:	00 
4000045b:	89 2c 24             	mov    %ebp,(%esp)
4000045e:	88 44 24 1e          	mov    %al,0x1e(%esp)
40000462:	89 44 24 08          	mov    %eax,0x8(%esp)
40000466:	e8 95 0c 00 00       	call   40001100 <sys_puts>
4000046b:	89 f8                	mov    %edi,%eax
4000046d:	3c 0d                	cmp    $0xd,%al
4000046f:	74 26                	je     40000497 <gets+0x77>
40000471:	3c 0a                	cmp    $0xa,%al
40000473:	8b 44 24 08          	mov    0x8(%esp),%eax
40000477:	74 1e                	je     40000497 <gets+0x77>
40000479:	83 c3 01             	add    $0x1,%ebx
4000047c:	3b 5c 24 0c          	cmp    0xc(%esp),%ebx
40000480:	88 44 1e ff          	mov    %al,-0x1(%esi,%ebx,1)
40000484:	75 c2                	jne    40000448 <gets+0x28>
40000486:	8b 44 24 44          	mov    0x44(%esp),%eax
4000048a:	c6 44 06 ff 00       	movb   $0x0,-0x1(%esi,%eax,1)
4000048f:	83 c4 2c             	add    $0x2c,%esp
40000492:	5b                   	pop    %ebx
40000493:	5e                   	pop    %esi
40000494:	5f                   	pop    %edi
40000495:	5d                   	pop    %ebp
40000496:	c3                   	ret    
40000497:	c6 04 1e 00          	movb   $0x0,(%esi,%ebx,1)
4000049b:	83 c4 2c             	add    $0x2c,%esp
4000049e:	5b                   	pop    %ebx
4000049f:	5e                   	pop    %esi
400004a0:	5f                   	pop    %edi
400004a1:	5d                   	pop    %ebp
400004a2:	c3                   	ret    
400004a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
400004a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

400004b0 <vcprintf>:
400004b0:	81 ec 2c 10 00 00    	sub    $0x102c,%esp
400004b6:	8b 84 24 34 10 00 00 	mov    0x1034(%esp),%eax
400004bd:	c7 04 24 c0 03 00 40 	movl   $0x400003c0,(%esp)
400004c4:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
400004cb:	00 
400004cc:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
400004d3:	00 
400004d4:	89 44 24 0c          	mov    %eax,0xc(%esp)
400004d8:	8b 84 24 30 10 00 00 	mov    0x1030(%esp),%eax
400004df:	89 44 24 08          	mov    %eax,0x8(%esp)
400004e3:	8d 44 24 18          	lea    0x18(%esp),%eax
400004e7:	89 44 24 04          	mov    %eax,0x4(%esp)
400004eb:	e8 b0 01 00 00       	call   400006a0 <vprintfmt>
400004f0:	8b 44 24 18          	mov    0x18(%esp),%eax
400004f4:	c6 44 04 20 00       	movb   $0x0,0x20(%esp,%eax,1)
400004f9:	89 44 24 04          	mov    %eax,0x4(%esp)
400004fd:	8d 44 24 20          	lea    0x20(%esp),%eax
40000501:	89 04 24             	mov    %eax,(%esp)
40000504:	e8 f7 0b 00 00       	call   40001100 <sys_puts>
40000509:	8b 44 24 1c          	mov    0x1c(%esp),%eax
4000050d:	81 c4 2c 10 00 00    	add    $0x102c,%esp
40000513:	c3                   	ret    
40000514:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
4000051a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

40000520 <printf>:
40000520:	83 ec 1c             	sub    $0x1c,%esp
40000523:	8d 44 24 24          	lea    0x24(%esp),%eax
40000527:	89 44 24 04          	mov    %eax,0x4(%esp)
4000052b:	8b 44 24 20          	mov    0x20(%esp),%eax
4000052f:	89 04 24             	mov    %eax,(%esp)
40000532:	e8 79 ff ff ff       	call   400004b0 <vcprintf>
40000537:	83 c4 1c             	add    $0x1c,%esp
4000053a:	c3                   	ret    
4000053b:	90                   	nop
4000053c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000540 <printf2>:
40000540:	83 ec 1c             	sub    $0x1c,%esp
40000543:	8d 44 24 24          	lea    0x24(%esp),%eax
40000547:	89 44 24 04          	mov    %eax,0x4(%esp)
4000054b:	8b 44 24 20          	mov    0x20(%esp),%eax
4000054f:	89 04 24             	mov    %eax,(%esp)
40000552:	e8 59 ff ff ff       	call   400004b0 <vcprintf>
40000557:	83 c4 1c             	add    $0x1c,%esp
4000055a:	c3                   	ret    
4000055b:	66 90                	xchg   %ax,%ax
4000055d:	66 90                	xchg   %ax,%ax
4000055f:	90                   	nop

40000560 <printnum>:
40000560:	55                   	push   %ebp
40000561:	57                   	push   %edi
40000562:	89 d7                	mov    %edx,%edi
40000564:	56                   	push   %esi
40000565:	89 c6                	mov    %eax,%esi
40000567:	53                   	push   %ebx
40000568:	83 ec 3c             	sub    $0x3c,%esp
4000056b:	8b 44 24 50          	mov    0x50(%esp),%eax
4000056f:	8b 4c 24 58          	mov    0x58(%esp),%ecx
40000573:	8b 5c 24 5c          	mov    0x5c(%esp),%ebx
40000577:	8b 6c 24 60          	mov    0x60(%esp),%ebp
4000057b:	89 44 24 20          	mov    %eax,0x20(%esp)
4000057f:	8b 44 24 54          	mov    0x54(%esp),%eax
40000583:	89 ca                	mov    %ecx,%edx
40000585:	89 4c 24 28          	mov    %ecx,0x28(%esp)
40000589:	31 c9                	xor    %ecx,%ecx
4000058b:	89 54 24 18          	mov    %edx,0x18(%esp)
4000058f:	39 c1                	cmp    %eax,%ecx
40000591:	89 44 24 24          	mov    %eax,0x24(%esp)
40000595:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
40000599:	0f 83 a9 00 00 00    	jae    40000648 <printnum+0xe8>
4000059f:	8b 44 24 28          	mov    0x28(%esp),%eax
400005a3:	83 eb 01             	sub    $0x1,%ebx
400005a6:	8b 54 24 1c          	mov    0x1c(%esp),%edx
400005aa:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
400005ae:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
400005b2:	89 6c 24 10          	mov    %ebp,0x10(%esp)
400005b6:	89 44 24 08          	mov    %eax,0x8(%esp)
400005ba:	8b 44 24 18          	mov    0x18(%esp),%eax
400005be:	8b 4c 24 08          	mov    0x8(%esp),%ecx
400005c2:	89 54 24 0c          	mov    %edx,0xc(%esp)
400005c6:	89 5c 24 2c          	mov    %ebx,0x2c(%esp)
400005ca:	89 44 24 08          	mov    %eax,0x8(%esp)
400005ce:	8b 44 24 20          	mov    0x20(%esp),%eax
400005d2:	89 4c 24 28          	mov    %ecx,0x28(%esp)
400005d6:	89 04 24             	mov    %eax,(%esp)
400005d9:	8b 44 24 24          	mov    0x24(%esp),%eax
400005dd:	89 44 24 04          	mov    %eax,0x4(%esp)
400005e1:	e8 6a 0b 00 00       	call   40001150 <__udivdi3>
400005e6:	8b 4c 24 28          	mov    0x28(%esp),%ecx
400005ea:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
400005ee:	89 4c 24 08          	mov    %ecx,0x8(%esp)
400005f2:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
400005f6:	89 04 24             	mov    %eax,(%esp)
400005f9:	89 f0                	mov    %esi,%eax
400005fb:	89 54 24 04          	mov    %edx,0x4(%esp)
400005ff:	89 fa                	mov    %edi,%edx
40000601:	e8 5a ff ff ff       	call   40000560 <printnum>
40000606:	8b 44 24 18          	mov    0x18(%esp),%eax
4000060a:	8b 54 24 1c          	mov    0x1c(%esp),%edx
4000060e:	89 7c 24 54          	mov    %edi,0x54(%esp)
40000612:	89 44 24 08          	mov    %eax,0x8(%esp)
40000616:	8b 44 24 20          	mov    0x20(%esp),%eax
4000061a:	89 54 24 0c          	mov    %edx,0xc(%esp)
4000061e:	89 04 24             	mov    %eax,(%esp)
40000621:	8b 44 24 24          	mov    0x24(%esp),%eax
40000625:	89 44 24 04          	mov    %eax,0x4(%esp)
40000629:	e8 52 0c 00 00       	call   40001280 <__umoddi3>
4000062e:	0f be 80 fc 13 00 40 	movsbl 0x400013fc(%eax),%eax
40000635:	89 44 24 50          	mov    %eax,0x50(%esp)
40000639:	83 c4 3c             	add    $0x3c,%esp
4000063c:	89 f0                	mov    %esi,%eax
4000063e:	5b                   	pop    %ebx
4000063f:	5e                   	pop    %esi
40000640:	5f                   	pop    %edi
40000641:	5d                   	pop    %ebp
40000642:	ff e0                	jmp    *%eax
40000644:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000648:	76 1e                	jbe    40000668 <printnum+0x108>
4000064a:	83 eb 01             	sub    $0x1,%ebx
4000064d:	85 db                	test   %ebx,%ebx
4000064f:	7e b5                	jle    40000606 <printnum+0xa6>
40000651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000658:	89 7c 24 04          	mov    %edi,0x4(%esp)
4000065c:	89 2c 24             	mov    %ebp,(%esp)
4000065f:	ff d6                	call   *%esi
40000661:	83 eb 01             	sub    $0x1,%ebx
40000664:	75 f2                	jne    40000658 <printnum+0xf8>
40000666:	eb 9e                	jmp    40000606 <printnum+0xa6>
40000668:	8b 44 24 20          	mov    0x20(%esp),%eax
4000066c:	39 44 24 28          	cmp    %eax,0x28(%esp)
40000670:	0f 86 29 ff ff ff    	jbe    4000059f <printnum+0x3f>
40000676:	eb d2                	jmp    4000064a <printnum+0xea>
40000678:	90                   	nop
40000679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000680 <sprintputch>:
40000680:	8b 44 24 08          	mov    0x8(%esp),%eax
40000684:	8b 10                	mov    (%eax),%edx
40000686:	83 40 08 01          	addl   $0x1,0x8(%eax)
4000068a:	3b 50 04             	cmp    0x4(%eax),%edx
4000068d:	73 0b                	jae    4000069a <sprintputch+0x1a>
4000068f:	8d 4a 01             	lea    0x1(%edx),%ecx
40000692:	89 08                	mov    %ecx,(%eax)
40000694:	8b 44 24 04          	mov    0x4(%esp),%eax
40000698:	88 02                	mov    %al,(%edx)
4000069a:	f3 c3                	repz ret 
4000069c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

400006a0 <vprintfmt>:
400006a0:	55                   	push   %ebp
400006a1:	57                   	push   %edi
400006a2:	56                   	push   %esi
400006a3:	53                   	push   %ebx
400006a4:	83 ec 3c             	sub    $0x3c,%esp
400006a7:	8b 6c 24 50          	mov    0x50(%esp),%ebp
400006ab:	8b 74 24 54          	mov    0x54(%esp),%esi
400006af:	8b 7c 24 58          	mov    0x58(%esp),%edi
400006b3:	0f b6 07             	movzbl (%edi),%eax
400006b6:	8d 5f 01             	lea    0x1(%edi),%ebx
400006b9:	83 f8 25             	cmp    $0x25,%eax
400006bc:	75 17                	jne    400006d5 <vprintfmt+0x35>
400006be:	eb 28                	jmp    400006e8 <vprintfmt+0x48>
400006c0:	83 c3 01             	add    $0x1,%ebx
400006c3:	89 04 24             	mov    %eax,(%esp)
400006c6:	89 74 24 04          	mov    %esi,0x4(%esp)
400006ca:	ff d5                	call   *%ebp
400006cc:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
400006d0:	83 f8 25             	cmp    $0x25,%eax
400006d3:	74 13                	je     400006e8 <vprintfmt+0x48>
400006d5:	85 c0                	test   %eax,%eax
400006d7:	75 e7                	jne    400006c0 <vprintfmt+0x20>
400006d9:	83 c4 3c             	add    $0x3c,%esp
400006dc:	5b                   	pop    %ebx
400006dd:	5e                   	pop    %esi
400006de:	5f                   	pop    %edi
400006df:	5d                   	pop    %ebp
400006e0:	c3                   	ret    
400006e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400006e8:	c6 44 24 24 20       	movb   $0x20,0x24(%esp)
400006ed:	ba ff ff ff ff       	mov    $0xffffffff,%edx
400006f2:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
400006f9:	00 
400006fa:	c7 44 24 20 ff ff ff 	movl   $0xffffffff,0x20(%esp)
40000701:	ff 
40000702:	c7 44 24 28 00 00 00 	movl   $0x0,0x28(%esp)
40000709:	00 
4000070a:	0f b6 03             	movzbl (%ebx),%eax
4000070d:	8d 7b 01             	lea    0x1(%ebx),%edi
40000710:	0f b6 c8             	movzbl %al,%ecx
40000713:	83 e8 23             	sub    $0x23,%eax
40000716:	3c 55                	cmp    $0x55,%al
40000718:	0f 87 69 02 00 00    	ja     40000987 <vprintfmt+0x2e7>
4000071e:	0f b6 c0             	movzbl %al,%eax
40000721:	ff 24 85 14 14 00 40 	jmp    *0x40001414(,%eax,4)
40000728:	89 fb                	mov    %edi,%ebx
4000072a:	c6 44 24 24 30       	movb   $0x30,0x24(%esp)
4000072f:	eb d9                	jmp    4000070a <vprintfmt+0x6a>
40000731:	0f be 43 01          	movsbl 0x1(%ebx),%eax
40000735:	8d 51 d0             	lea    -0x30(%ecx),%edx
40000738:	89 fb                	mov    %edi,%ebx
4000073a:	8d 48 d0             	lea    -0x30(%eax),%ecx
4000073d:	83 f9 09             	cmp    $0x9,%ecx
40000740:	0f 87 02 02 00 00    	ja     40000948 <vprintfmt+0x2a8>
40000746:	66 90                	xchg   %ax,%ax
40000748:	83 c3 01             	add    $0x1,%ebx
4000074b:	8d 14 92             	lea    (%edx,%edx,4),%edx
4000074e:	8d 54 50 d0          	lea    -0x30(%eax,%edx,2),%edx
40000752:	0f be 03             	movsbl (%ebx),%eax
40000755:	8d 48 d0             	lea    -0x30(%eax),%ecx
40000758:	83 f9 09             	cmp    $0x9,%ecx
4000075b:	76 eb                	jbe    40000748 <vprintfmt+0xa8>
4000075d:	e9 e6 01 00 00       	jmp    40000948 <vprintfmt+0x2a8>
40000762:	8b 44 24 5c          	mov    0x5c(%esp),%eax
40000766:	89 74 24 04          	mov    %esi,0x4(%esp)
4000076a:	83 44 24 5c 04       	addl   $0x4,0x5c(%esp)
4000076f:	8b 00                	mov    (%eax),%eax
40000771:	89 04 24             	mov    %eax,(%esp)
40000774:	ff d5                	call   *%ebp
40000776:	e9 38 ff ff ff       	jmp    400006b3 <vprintfmt+0x13>
4000077b:	8b 44 24 5c          	mov    0x5c(%esp),%eax
4000077f:	83 7c 24 28 01       	cmpl   $0x1,0x28(%esp)
40000784:	8b 08                	mov    (%eax),%ecx
40000786:	0f 8e e7 02 00 00    	jle    40000a73 <vprintfmt+0x3d3>
4000078c:	8b 58 04             	mov    0x4(%eax),%ebx
4000078f:	83 c0 08             	add    $0x8,%eax
40000792:	89 44 24 5c          	mov    %eax,0x5c(%esp)
40000796:	89 ca                	mov    %ecx,%edx
40000798:	89 d9                	mov    %ebx,%ecx
4000079a:	85 c9                	test   %ecx,%ecx
4000079c:	bb 0a 00 00 00       	mov    $0xa,%ebx
400007a1:	0f 88 dd 02 00 00    	js     40000a84 <vprintfmt+0x3e4>
400007a7:	0f be 44 24 24       	movsbl 0x24(%esp),%eax
400007ac:	89 14 24             	mov    %edx,(%esp)
400007af:	89 f2                	mov    %esi,%edx
400007b1:	89 5c 24 08          	mov    %ebx,0x8(%esp)
400007b5:	89 4c 24 04          	mov    %ecx,0x4(%esp)
400007b9:	89 44 24 10          	mov    %eax,0x10(%esp)
400007bd:	8b 44 24 20          	mov    0x20(%esp),%eax
400007c1:	89 44 24 0c          	mov    %eax,0xc(%esp)
400007c5:	89 e8                	mov    %ebp,%eax
400007c7:	e8 94 fd ff ff       	call   40000560 <printnum>
400007cc:	e9 e2 fe ff ff       	jmp    400006b3 <vprintfmt+0x13>
400007d1:	83 44 24 28 01       	addl   $0x1,0x28(%esp)
400007d6:	89 fb                	mov    %edi,%ebx
400007d8:	e9 2d ff ff ff       	jmp    4000070a <vprintfmt+0x6a>
400007dd:	89 74 24 04          	mov    %esi,0x4(%esp)
400007e1:	c7 04 24 58 00 00 00 	movl   $0x58,(%esp)
400007e8:	ff d5                	call   *%ebp
400007ea:	89 74 24 04          	mov    %esi,0x4(%esp)
400007ee:	c7 04 24 58 00 00 00 	movl   $0x58,(%esp)
400007f5:	ff d5                	call   *%ebp
400007f7:	89 74 24 04          	mov    %esi,0x4(%esp)
400007fb:	c7 04 24 58 00 00 00 	movl   $0x58,(%esp)
40000802:	ff d5                	call   *%ebp
40000804:	e9 aa fe ff ff       	jmp    400006b3 <vprintfmt+0x13>
40000809:	8b 5c 24 5c          	mov    0x5c(%esp),%ebx
4000080d:	89 74 24 04          	mov    %esi,0x4(%esp)
40000811:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
40000818:	ff d5                	call   *%ebp
4000081a:	89 74 24 04          	mov    %esi,0x4(%esp)
4000081e:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
40000825:	ff d5                	call   *%ebp
40000827:	8b 13                	mov    (%ebx),%edx
40000829:	31 c9                	xor    %ecx,%ecx
4000082b:	83 44 24 5c 04       	addl   $0x4,0x5c(%esp)
40000830:	bb 10 00 00 00       	mov    $0x10,%ebx
40000835:	e9 6d ff ff ff       	jmp    400007a7 <vprintfmt+0x107>
4000083a:	8b 44 24 5c          	mov    0x5c(%esp),%eax
4000083e:	83 44 24 5c 04       	addl   $0x4,0x5c(%esp)
40000843:	8b 08                	mov    (%eax),%ecx
40000845:	b8 0d 14 00 40       	mov    $0x4000140d,%eax
4000084a:	85 c9                	test   %ecx,%ecx
4000084c:	0f 44 c8             	cmove  %eax,%ecx
4000084f:	80 7c 24 24 2d       	cmpb   $0x2d,0x24(%esp)
40000854:	0f 85 a9 01 00 00    	jne    40000a03 <vprintfmt+0x363>
4000085a:	0f be 01             	movsbl (%ecx),%eax
4000085d:	8d 59 01             	lea    0x1(%ecx),%ebx
40000860:	85 c0                	test   %eax,%eax
40000862:	0f 84 52 01 00 00    	je     400009ba <vprintfmt+0x31a>
40000868:	89 74 24 54          	mov    %esi,0x54(%esp)
4000086c:	89 de                	mov    %ebx,%esi
4000086e:	89 d3                	mov    %edx,%ebx
40000870:	89 7c 24 58          	mov    %edi,0x58(%esp)
40000874:	8b 7c 24 20          	mov    0x20(%esp),%edi
40000878:	eb 25                	jmp    4000089f <vprintfmt+0x1ff>
4000087a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000880:	8b 4c 24 54          	mov    0x54(%esp),%ecx
40000884:	89 04 24             	mov    %eax,(%esp)
40000887:	89 4c 24 04          	mov    %ecx,0x4(%esp)
4000088b:	ff d5                	call   *%ebp
4000088d:	83 c6 01             	add    $0x1,%esi
40000890:	0f be 46 ff          	movsbl -0x1(%esi),%eax
40000894:	83 ef 01             	sub    $0x1,%edi
40000897:	85 c0                	test   %eax,%eax
40000899:	0f 84 0f 01 00 00    	je     400009ae <vprintfmt+0x30e>
4000089f:	85 db                	test   %ebx,%ebx
400008a1:	78 0c                	js     400008af <vprintfmt+0x20f>
400008a3:	83 eb 01             	sub    $0x1,%ebx
400008a6:	83 fb ff             	cmp    $0xffffffff,%ebx
400008a9:	0f 84 ff 00 00 00    	je     400009ae <vprintfmt+0x30e>
400008af:	8b 54 24 18          	mov    0x18(%esp),%edx
400008b3:	85 d2                	test   %edx,%edx
400008b5:	74 c9                	je     40000880 <vprintfmt+0x1e0>
400008b7:	8d 48 e0             	lea    -0x20(%eax),%ecx
400008ba:	83 f9 5e             	cmp    $0x5e,%ecx
400008bd:	76 c1                	jbe    40000880 <vprintfmt+0x1e0>
400008bf:	8b 44 24 54          	mov    0x54(%esp),%eax
400008c3:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
400008ca:	89 44 24 04          	mov    %eax,0x4(%esp)
400008ce:	ff d5                	call   *%ebp
400008d0:	eb bb                	jmp    4000088d <vprintfmt+0x1ed>
400008d2:	8b 44 24 5c          	mov    0x5c(%esp),%eax
400008d6:	83 7c 24 28 01       	cmpl   $0x1,0x28(%esp)
400008db:	8b 10                	mov    (%eax),%edx
400008dd:	0f 8e 04 01 00 00    	jle    400009e7 <vprintfmt+0x347>
400008e3:	8b 48 04             	mov    0x4(%eax),%ecx
400008e6:	83 c0 08             	add    $0x8,%eax
400008e9:	89 44 24 5c          	mov    %eax,0x5c(%esp)
400008ed:	bb 0a 00 00 00       	mov    $0xa,%ebx
400008f2:	e9 b0 fe ff ff       	jmp    400007a7 <vprintfmt+0x107>
400008f7:	8b 44 24 5c          	mov    0x5c(%esp),%eax
400008fb:	83 7c 24 28 01       	cmpl   $0x1,0x28(%esp)
40000900:	8b 10                	mov    (%eax),%edx
40000902:	0f 8e ed 00 00 00    	jle    400009f5 <vprintfmt+0x355>
40000908:	8b 48 04             	mov    0x4(%eax),%ecx
4000090b:	83 c0 08             	add    $0x8,%eax
4000090e:	89 44 24 5c          	mov    %eax,0x5c(%esp)
40000912:	bb 10 00 00 00       	mov    $0x10,%ebx
40000917:	e9 8b fe ff ff       	jmp    400007a7 <vprintfmt+0x107>
4000091c:	89 fb                	mov    %edi,%ebx
4000091e:	c7 44 24 18 01 00 00 	movl   $0x1,0x18(%esp)
40000925:	00 
40000926:	e9 df fd ff ff       	jmp    4000070a <vprintfmt+0x6a>
4000092b:	89 74 24 04          	mov    %esi,0x4(%esp)
4000092f:	89 0c 24             	mov    %ecx,(%esp)
40000932:	ff d5                	call   *%ebp
40000934:	e9 7a fd ff ff       	jmp    400006b3 <vprintfmt+0x13>
40000939:	8b 44 24 5c          	mov    0x5c(%esp),%eax
4000093d:	89 fb                	mov    %edi,%ebx
4000093f:	8b 10                	mov    (%eax),%edx
40000941:	83 c0 04             	add    $0x4,%eax
40000944:	89 44 24 5c          	mov    %eax,0x5c(%esp)
40000948:	8b 7c 24 20          	mov    0x20(%esp),%edi
4000094c:	85 ff                	test   %edi,%edi
4000094e:	0f 89 b6 fd ff ff    	jns    4000070a <vprintfmt+0x6a>
40000954:	89 54 24 20          	mov    %edx,0x20(%esp)
40000958:	ba ff ff ff ff       	mov    $0xffffffff,%edx
4000095d:	e9 a8 fd ff ff       	jmp    4000070a <vprintfmt+0x6a>
40000962:	89 fb                	mov    %edi,%ebx
40000964:	c6 44 24 24 2d       	movb   $0x2d,0x24(%esp)
40000969:	e9 9c fd ff ff       	jmp    4000070a <vprintfmt+0x6a>
4000096e:	8b 4c 24 20          	mov    0x20(%esp),%ecx
40000972:	b8 00 00 00 00       	mov    $0x0,%eax
40000977:	89 fb                	mov    %edi,%ebx
40000979:	85 c9                	test   %ecx,%ecx
4000097b:	0f 49 c1             	cmovns %ecx,%eax
4000097e:	89 44 24 20          	mov    %eax,0x20(%esp)
40000982:	e9 83 fd ff ff       	jmp    4000070a <vprintfmt+0x6a>
40000987:	89 74 24 04          	mov    %esi,0x4(%esp)
4000098b:	89 df                	mov    %ebx,%edi
4000098d:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
40000994:	ff d5                	call   *%ebp
40000996:	80 7b ff 25          	cmpb   $0x25,-0x1(%ebx)
4000099a:	0f 84 13 fd ff ff    	je     400006b3 <vprintfmt+0x13>
400009a0:	83 ef 01             	sub    $0x1,%edi
400009a3:	80 7f ff 25          	cmpb   $0x25,-0x1(%edi)
400009a7:	75 f7                	jne    400009a0 <vprintfmt+0x300>
400009a9:	e9 05 fd ff ff       	jmp    400006b3 <vprintfmt+0x13>
400009ae:	89 7c 24 20          	mov    %edi,0x20(%esp)
400009b2:	8b 74 24 54          	mov    0x54(%esp),%esi
400009b6:	8b 7c 24 58          	mov    0x58(%esp),%edi
400009ba:	8b 4c 24 20          	mov    0x20(%esp),%ecx
400009be:	8b 5c 24 20          	mov    0x20(%esp),%ebx
400009c2:	85 c9                	test   %ecx,%ecx
400009c4:	0f 8e e9 fc ff ff    	jle    400006b3 <vprintfmt+0x13>
400009ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
400009d0:	89 74 24 04          	mov    %esi,0x4(%esp)
400009d4:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
400009db:	ff d5                	call   *%ebp
400009dd:	83 eb 01             	sub    $0x1,%ebx
400009e0:	75 ee                	jne    400009d0 <vprintfmt+0x330>
400009e2:	e9 cc fc ff ff       	jmp    400006b3 <vprintfmt+0x13>
400009e7:	83 c0 04             	add    $0x4,%eax
400009ea:	31 c9                	xor    %ecx,%ecx
400009ec:	89 44 24 5c          	mov    %eax,0x5c(%esp)
400009f0:	e9 f8 fe ff ff       	jmp    400008ed <vprintfmt+0x24d>
400009f5:	83 c0 04             	add    $0x4,%eax
400009f8:	31 c9                	xor    %ecx,%ecx
400009fa:	89 44 24 5c          	mov    %eax,0x5c(%esp)
400009fe:	e9 0f ff ff ff       	jmp    40000912 <vprintfmt+0x272>
40000a03:	8b 5c 24 20          	mov    0x20(%esp),%ebx
40000a07:	85 db                	test   %ebx,%ebx
40000a09:	0f 8e 4b fe ff ff    	jle    4000085a <vprintfmt+0x1ba>
40000a0f:	89 54 24 04          	mov    %edx,0x4(%esp)
40000a13:	89 0c 24             	mov    %ecx,(%esp)
40000a16:	89 54 24 2c          	mov    %edx,0x2c(%esp)
40000a1a:	89 4c 24 28          	mov    %ecx,0x28(%esp)
40000a1e:	e8 ed 01 00 00       	call   40000c10 <strnlen>
40000a23:	8b 4c 24 28          	mov    0x28(%esp),%ecx
40000a27:	8b 54 24 2c          	mov    0x2c(%esp),%edx
40000a2b:	29 44 24 20          	sub    %eax,0x20(%esp)
40000a2f:	8b 44 24 20          	mov    0x20(%esp),%eax
40000a33:	85 c0                	test   %eax,%eax
40000a35:	0f 8e 1f fe ff ff    	jle    4000085a <vprintfmt+0x1ba>
40000a3b:	0f be 5c 24 24       	movsbl 0x24(%esp),%ebx
40000a40:	89 7c 24 58          	mov    %edi,0x58(%esp)
40000a44:	89 c7                	mov    %eax,%edi
40000a46:	89 4c 24 20          	mov    %ecx,0x20(%esp)
40000a4a:	89 54 24 24          	mov    %edx,0x24(%esp)
40000a4e:	66 90                	xchg   %ax,%ax
40000a50:	89 74 24 04          	mov    %esi,0x4(%esp)
40000a54:	89 1c 24             	mov    %ebx,(%esp)
40000a57:	ff d5                	call   *%ebp
40000a59:	83 ef 01             	sub    $0x1,%edi
40000a5c:	75 f2                	jne    40000a50 <vprintfmt+0x3b0>
40000a5e:	8b 4c 24 20          	mov    0x20(%esp),%ecx
40000a62:	8b 54 24 24          	mov    0x24(%esp),%edx
40000a66:	89 7c 24 20          	mov    %edi,0x20(%esp)
40000a6a:	8b 7c 24 58          	mov    0x58(%esp),%edi
40000a6e:	e9 e7 fd ff ff       	jmp    4000085a <vprintfmt+0x1ba>
40000a73:	89 cb                	mov    %ecx,%ebx
40000a75:	83 c0 04             	add    $0x4,%eax
40000a78:	c1 fb 1f             	sar    $0x1f,%ebx
40000a7b:	89 44 24 5c          	mov    %eax,0x5c(%esp)
40000a7f:	e9 12 fd ff ff       	jmp    40000796 <vprintfmt+0xf6>
40000a84:	89 54 24 18          	mov    %edx,0x18(%esp)
40000a88:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
40000a8c:	89 74 24 04          	mov    %esi,0x4(%esp)
40000a90:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
40000a97:	ff d5                	call   *%ebp
40000a99:	8b 54 24 18          	mov    0x18(%esp),%edx
40000a9d:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
40000aa1:	f7 da                	neg    %edx
40000aa3:	83 d1 00             	adc    $0x0,%ecx
40000aa6:	f7 d9                	neg    %ecx
40000aa8:	e9 fa fc ff ff       	jmp    400007a7 <vprintfmt+0x107>
40000aad:	8d 76 00             	lea    0x0(%esi),%esi

40000ab0 <printfmt>:
40000ab0:	83 ec 1c             	sub    $0x1c,%esp
40000ab3:	8d 44 24 2c          	lea    0x2c(%esp),%eax
40000ab7:	89 44 24 0c          	mov    %eax,0xc(%esp)
40000abb:	8b 44 24 28          	mov    0x28(%esp),%eax
40000abf:	89 44 24 08          	mov    %eax,0x8(%esp)
40000ac3:	8b 44 24 24          	mov    0x24(%esp),%eax
40000ac7:	89 44 24 04          	mov    %eax,0x4(%esp)
40000acb:	8b 44 24 20          	mov    0x20(%esp),%eax
40000acf:	89 04 24             	mov    %eax,(%esp)
40000ad2:	e8 c9 fb ff ff       	call   400006a0 <vprintfmt>
40000ad7:	83 c4 1c             	add    $0x1c,%esp
40000ada:	c3                   	ret    
40000adb:	90                   	nop
40000adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000ae0 <vsprintf>:
40000ae0:	83 ec 2c             	sub    $0x2c,%esp
40000ae3:	8b 44 24 30          	mov    0x30(%esp),%eax
40000ae7:	c7 04 24 80 06 00 40 	movl   $0x40000680,(%esp)
40000aee:	c7 44 24 18 ff ff ff 	movl   $0xffffffff,0x18(%esp)
40000af5:	ff 
40000af6:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
40000afd:	00 
40000afe:	89 44 24 14          	mov    %eax,0x14(%esp)
40000b02:	8b 44 24 38          	mov    0x38(%esp),%eax
40000b06:	89 44 24 0c          	mov    %eax,0xc(%esp)
40000b0a:	8b 44 24 34          	mov    0x34(%esp),%eax
40000b0e:	89 44 24 08          	mov    %eax,0x8(%esp)
40000b12:	8d 44 24 14          	lea    0x14(%esp),%eax
40000b16:	89 44 24 04          	mov    %eax,0x4(%esp)
40000b1a:	e8 81 fb ff ff       	call   400006a0 <vprintfmt>
40000b1f:	8b 44 24 14          	mov    0x14(%esp),%eax
40000b23:	c6 00 00             	movb   $0x0,(%eax)
40000b26:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000b2a:	83 c4 2c             	add    $0x2c,%esp
40000b2d:	c3                   	ret    
40000b2e:	66 90                	xchg   %ax,%ax

40000b30 <sprintf>:
40000b30:	83 ec 1c             	sub    $0x1c,%esp
40000b33:	8d 44 24 28          	lea    0x28(%esp),%eax
40000b37:	89 44 24 08          	mov    %eax,0x8(%esp)
40000b3b:	8b 44 24 24          	mov    0x24(%esp),%eax
40000b3f:	89 44 24 04          	mov    %eax,0x4(%esp)
40000b43:	8b 44 24 20          	mov    0x20(%esp),%eax
40000b47:	89 04 24             	mov    %eax,(%esp)
40000b4a:	e8 91 ff ff ff       	call   40000ae0 <vsprintf>
40000b4f:	83 c4 1c             	add    $0x1c,%esp
40000b52:	c3                   	ret    
40000b53:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000b60 <vsnprintf>:
40000b60:	83 ec 2c             	sub    $0x2c,%esp
40000b63:	8b 44 24 30          	mov    0x30(%esp),%eax
40000b67:	8b 54 24 34          	mov    0x34(%esp),%edx
40000b6b:	c7 04 24 80 06 00 40 	movl   $0x40000680,(%esp)
40000b72:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
40000b79:	00 
40000b7a:	89 44 24 14          	mov    %eax,0x14(%esp)
40000b7e:	8d 44 10 ff          	lea    -0x1(%eax,%edx,1),%eax
40000b82:	89 44 24 18          	mov    %eax,0x18(%esp)
40000b86:	8b 44 24 3c          	mov    0x3c(%esp),%eax
40000b8a:	89 44 24 0c          	mov    %eax,0xc(%esp)
40000b8e:	8b 44 24 38          	mov    0x38(%esp),%eax
40000b92:	89 44 24 08          	mov    %eax,0x8(%esp)
40000b96:	8d 44 24 14          	lea    0x14(%esp),%eax
40000b9a:	89 44 24 04          	mov    %eax,0x4(%esp)
40000b9e:	e8 fd fa ff ff       	call   400006a0 <vprintfmt>
40000ba3:	8b 44 24 14          	mov    0x14(%esp),%eax
40000ba7:	c6 00 00             	movb   $0x0,(%eax)
40000baa:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000bae:	83 c4 2c             	add    $0x2c,%esp
40000bb1:	c3                   	ret    
40000bb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000bc0 <snprintf>:
40000bc0:	83 ec 1c             	sub    $0x1c,%esp
40000bc3:	8d 44 24 2c          	lea    0x2c(%esp),%eax
40000bc7:	89 44 24 0c          	mov    %eax,0xc(%esp)
40000bcb:	8b 44 24 28          	mov    0x28(%esp),%eax
40000bcf:	89 44 24 08          	mov    %eax,0x8(%esp)
40000bd3:	8b 44 24 24          	mov    0x24(%esp),%eax
40000bd7:	89 44 24 04          	mov    %eax,0x4(%esp)
40000bdb:	8b 44 24 20          	mov    0x20(%esp),%eax
40000bdf:	89 04 24             	mov    %eax,(%esp)
40000be2:	e8 79 ff ff ff       	call   40000b60 <vsnprintf>
40000be7:	83 c4 1c             	add    $0x1c,%esp
40000bea:	c3                   	ret    
40000beb:	66 90                	xchg   %ax,%ax
40000bed:	66 90                	xchg   %ax,%ax
40000bef:	90                   	nop

40000bf0 <strlen>:
40000bf0:	8b 54 24 04          	mov    0x4(%esp),%edx
40000bf4:	31 c0                	xor    %eax,%eax
40000bf6:	80 3a 00             	cmpb   $0x0,(%edx)
40000bf9:	74 10                	je     40000c0b <strlen+0x1b>
40000bfb:	90                   	nop
40000bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000c00:	83 c0 01             	add    $0x1,%eax
40000c03:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
40000c07:	75 f7                	jne    40000c00 <strlen+0x10>
40000c09:	f3 c3                	repz ret 
40000c0b:	f3 c3                	repz ret 
40000c0d:	8d 76 00             	lea    0x0(%esi),%esi

40000c10 <strnlen>:
40000c10:	53                   	push   %ebx
40000c11:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000c15:	8b 5c 24 08          	mov    0x8(%esp),%ebx
40000c19:	85 c9                	test   %ecx,%ecx
40000c1b:	74 25                	je     40000c42 <strnlen+0x32>
40000c1d:	80 3b 00             	cmpb   $0x0,(%ebx)
40000c20:	74 20                	je     40000c42 <strnlen+0x32>
40000c22:	ba 01 00 00 00       	mov    $0x1,%edx
40000c27:	eb 11                	jmp    40000c3a <strnlen+0x2a>
40000c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000c30:	83 c2 01             	add    $0x1,%edx
40000c33:	80 7c 13 ff 00       	cmpb   $0x0,-0x1(%ebx,%edx,1)
40000c38:	74 06                	je     40000c40 <strnlen+0x30>
40000c3a:	39 ca                	cmp    %ecx,%edx
40000c3c:	89 d0                	mov    %edx,%eax
40000c3e:	75 f0                	jne    40000c30 <strnlen+0x20>
40000c40:	5b                   	pop    %ebx
40000c41:	c3                   	ret    
40000c42:	31 c0                	xor    %eax,%eax
40000c44:	5b                   	pop    %ebx
40000c45:	c3                   	ret    
40000c46:	8d 76 00             	lea    0x0(%esi),%esi
40000c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000c50 <strcpy>:
40000c50:	53                   	push   %ebx
40000c51:	8b 44 24 08          	mov    0x8(%esp),%eax
40000c55:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000c59:	89 c2                	mov    %eax,%edx
40000c5b:	90                   	nop
40000c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000c60:	83 c1 01             	add    $0x1,%ecx
40000c63:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
40000c67:	83 c2 01             	add    $0x1,%edx
40000c6a:	84 db                	test   %bl,%bl
40000c6c:	88 5a ff             	mov    %bl,-0x1(%edx)
40000c6f:	75 ef                	jne    40000c60 <strcpy+0x10>
40000c71:	5b                   	pop    %ebx
40000c72:	c3                   	ret    
40000c73:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000c80 <strncpy>:
40000c80:	57                   	push   %edi
40000c81:	56                   	push   %esi
40000c82:	53                   	push   %ebx
40000c83:	8b 74 24 18          	mov    0x18(%esp),%esi
40000c87:	8b 7c 24 10          	mov    0x10(%esp),%edi
40000c8b:	8b 4c 24 14          	mov    0x14(%esp),%ecx
40000c8f:	85 f6                	test   %esi,%esi
40000c91:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
40000c94:	89 fa                	mov    %edi,%edx
40000c96:	74 13                	je     40000cab <strncpy+0x2b>
40000c98:	0f b6 01             	movzbl (%ecx),%eax
40000c9b:	83 c2 01             	add    $0x1,%edx
40000c9e:	88 42 ff             	mov    %al,-0x1(%edx)
40000ca1:	80 39 01             	cmpb   $0x1,(%ecx)
40000ca4:	83 d9 ff             	sbb    $0xffffffff,%ecx
40000ca7:	39 da                	cmp    %ebx,%edx
40000ca9:	75 ed                	jne    40000c98 <strncpy+0x18>
40000cab:	89 f8                	mov    %edi,%eax
40000cad:	5b                   	pop    %ebx
40000cae:	5e                   	pop    %esi
40000caf:	5f                   	pop    %edi
40000cb0:	c3                   	ret    
40000cb1:	eb 0d                	jmp    40000cc0 <strlcpy>
40000cb3:	90                   	nop
40000cb4:	90                   	nop
40000cb5:	90                   	nop
40000cb6:	90                   	nop
40000cb7:	90                   	nop
40000cb8:	90                   	nop
40000cb9:	90                   	nop
40000cba:	90                   	nop
40000cbb:	90                   	nop
40000cbc:	90                   	nop
40000cbd:	90                   	nop
40000cbe:	90                   	nop
40000cbf:	90                   	nop

40000cc0 <strlcpy>:
40000cc0:	56                   	push   %esi
40000cc1:	31 c0                	xor    %eax,%eax
40000cc3:	53                   	push   %ebx
40000cc4:	8b 74 24 14          	mov    0x14(%esp),%esi
40000cc8:	8b 5c 24 10          	mov    0x10(%esp),%ebx
40000ccc:	85 f6                	test   %esi,%esi
40000cce:	74 36                	je     40000d06 <strlcpy+0x46>
40000cd0:	83 fe 01             	cmp    $0x1,%esi
40000cd3:	74 34                	je     40000d09 <strlcpy+0x49>
40000cd5:	0f b6 0b             	movzbl (%ebx),%ecx
40000cd8:	84 c9                	test   %cl,%cl
40000cda:	74 2d                	je     40000d09 <strlcpy+0x49>
40000cdc:	83 ee 02             	sub    $0x2,%esi
40000cdf:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000ce3:	eb 0e                	jmp    40000cf3 <strlcpy+0x33>
40000ce5:	8d 76 00             	lea    0x0(%esi),%esi
40000ce8:	83 c0 01             	add    $0x1,%eax
40000ceb:	0f b6 0c 03          	movzbl (%ebx,%eax,1),%ecx
40000cef:	84 c9                	test   %cl,%cl
40000cf1:	74 0a                	je     40000cfd <strlcpy+0x3d>
40000cf3:	83 c2 01             	add    $0x1,%edx
40000cf6:	39 f0                	cmp    %esi,%eax
40000cf8:	88 4a ff             	mov    %cl,-0x1(%edx)
40000cfb:	75 eb                	jne    40000ce8 <strlcpy+0x28>
40000cfd:	89 d0                	mov    %edx,%eax
40000cff:	2b 44 24 0c          	sub    0xc(%esp),%eax
40000d03:	c6 02 00             	movb   $0x0,(%edx)
40000d06:	5b                   	pop    %ebx
40000d07:	5e                   	pop    %esi
40000d08:	c3                   	ret    
40000d09:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000d0d:	eb f4                	jmp    40000d03 <strlcpy+0x43>
40000d0f:	90                   	nop

40000d10 <strcmp>:
40000d10:	53                   	push   %ebx
40000d11:	8b 54 24 08          	mov    0x8(%esp),%edx
40000d15:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000d19:	0f b6 02             	movzbl (%edx),%eax
40000d1c:	84 c0                	test   %al,%al
40000d1e:	74 2d                	je     40000d4d <strcmp+0x3d>
40000d20:	0f b6 19             	movzbl (%ecx),%ebx
40000d23:	38 d8                	cmp    %bl,%al
40000d25:	74 0f                	je     40000d36 <strcmp+0x26>
40000d27:	eb 2b                	jmp    40000d54 <strcmp+0x44>
40000d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000d30:	38 c8                	cmp    %cl,%al
40000d32:	75 15                	jne    40000d49 <strcmp+0x39>
40000d34:	89 d9                	mov    %ebx,%ecx
40000d36:	83 c2 01             	add    $0x1,%edx
40000d39:	0f b6 02             	movzbl (%edx),%eax
40000d3c:	8d 59 01             	lea    0x1(%ecx),%ebx
40000d3f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
40000d43:	84 c0                	test   %al,%al
40000d45:	75 e9                	jne    40000d30 <strcmp+0x20>
40000d47:	31 c0                	xor    %eax,%eax
40000d49:	29 c8                	sub    %ecx,%eax
40000d4b:	5b                   	pop    %ebx
40000d4c:	c3                   	ret    
40000d4d:	0f b6 09             	movzbl (%ecx),%ecx
40000d50:	31 c0                	xor    %eax,%eax
40000d52:	eb f5                	jmp    40000d49 <strcmp+0x39>
40000d54:	0f b6 cb             	movzbl %bl,%ecx
40000d57:	eb f0                	jmp    40000d49 <strcmp+0x39>
40000d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000d60 <strncmp>:
40000d60:	56                   	push   %esi
40000d61:	53                   	push   %ebx
40000d62:	8b 74 24 14          	mov    0x14(%esp),%esi
40000d66:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000d6a:	8b 5c 24 10          	mov    0x10(%esp),%ebx
40000d6e:	85 f6                	test   %esi,%esi
40000d70:	74 30                	je     40000da2 <strncmp+0x42>
40000d72:	0f b6 01             	movzbl (%ecx),%eax
40000d75:	84 c0                	test   %al,%al
40000d77:	74 2e                	je     40000da7 <strncmp+0x47>
40000d79:	0f b6 13             	movzbl (%ebx),%edx
40000d7c:	38 d0                	cmp    %dl,%al
40000d7e:	75 3e                	jne    40000dbe <strncmp+0x5e>
40000d80:	8d 51 01             	lea    0x1(%ecx),%edx
40000d83:	01 ce                	add    %ecx,%esi
40000d85:	eb 14                	jmp    40000d9b <strncmp+0x3b>
40000d87:	90                   	nop
40000d88:	0f b6 02             	movzbl (%edx),%eax
40000d8b:	84 c0                	test   %al,%al
40000d8d:	74 29                	je     40000db8 <strncmp+0x58>
40000d8f:	0f b6 19             	movzbl (%ecx),%ebx
40000d92:	83 c2 01             	add    $0x1,%edx
40000d95:	38 d8                	cmp    %bl,%al
40000d97:	75 17                	jne    40000db0 <strncmp+0x50>
40000d99:	89 cb                	mov    %ecx,%ebx
40000d9b:	39 f2                	cmp    %esi,%edx
40000d9d:	8d 4b 01             	lea    0x1(%ebx),%ecx
40000da0:	75 e6                	jne    40000d88 <strncmp+0x28>
40000da2:	31 c0                	xor    %eax,%eax
40000da4:	5b                   	pop    %ebx
40000da5:	5e                   	pop    %esi
40000da6:	c3                   	ret    
40000da7:	0f b6 1b             	movzbl (%ebx),%ebx
40000daa:	31 c0                	xor    %eax,%eax
40000dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000db0:	0f b6 d3             	movzbl %bl,%edx
40000db3:	29 d0                	sub    %edx,%eax
40000db5:	5b                   	pop    %ebx
40000db6:	5e                   	pop    %esi
40000db7:	c3                   	ret    
40000db8:	0f b6 5b 01          	movzbl 0x1(%ebx),%ebx
40000dbc:	eb f2                	jmp    40000db0 <strncmp+0x50>
40000dbe:	89 d3                	mov    %edx,%ebx
40000dc0:	eb ee                	jmp    40000db0 <strncmp+0x50>
40000dc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000dd0 <strchr>:
40000dd0:	53                   	push   %ebx
40000dd1:	8b 44 24 08          	mov    0x8(%esp),%eax
40000dd5:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000dd9:	0f b6 18             	movzbl (%eax),%ebx
40000ddc:	84 db                	test   %bl,%bl
40000dde:	74 16                	je     40000df6 <strchr+0x26>
40000de0:	38 d3                	cmp    %dl,%bl
40000de2:	89 d1                	mov    %edx,%ecx
40000de4:	75 06                	jne    40000dec <strchr+0x1c>
40000de6:	eb 10                	jmp    40000df8 <strchr+0x28>
40000de8:	38 ca                	cmp    %cl,%dl
40000dea:	74 0c                	je     40000df8 <strchr+0x28>
40000dec:	83 c0 01             	add    $0x1,%eax
40000def:	0f b6 10             	movzbl (%eax),%edx
40000df2:	84 d2                	test   %dl,%dl
40000df4:	75 f2                	jne    40000de8 <strchr+0x18>
40000df6:	31 c0                	xor    %eax,%eax
40000df8:	5b                   	pop    %ebx
40000df9:	c3                   	ret    
40000dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000e00 <strfind>:
40000e00:	53                   	push   %ebx
40000e01:	8b 44 24 08          	mov    0x8(%esp),%eax
40000e05:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000e09:	0f b6 18             	movzbl (%eax),%ebx
40000e0c:	84 db                	test   %bl,%bl
40000e0e:	74 16                	je     40000e26 <strfind+0x26>
40000e10:	38 d3                	cmp    %dl,%bl
40000e12:	89 d1                	mov    %edx,%ecx
40000e14:	75 06                	jne    40000e1c <strfind+0x1c>
40000e16:	eb 0e                	jmp    40000e26 <strfind+0x26>
40000e18:	38 ca                	cmp    %cl,%dl
40000e1a:	74 0a                	je     40000e26 <strfind+0x26>
40000e1c:	83 c0 01             	add    $0x1,%eax
40000e1f:	0f b6 10             	movzbl (%eax),%edx
40000e22:	84 d2                	test   %dl,%dl
40000e24:	75 f2                	jne    40000e18 <strfind+0x18>
40000e26:	5b                   	pop    %ebx
40000e27:	c3                   	ret    
40000e28:	90                   	nop
40000e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000e30 <strtol>:
40000e30:	55                   	push   %ebp
40000e31:	57                   	push   %edi
40000e32:	56                   	push   %esi
40000e33:	53                   	push   %ebx
40000e34:	8b 54 24 14          	mov    0x14(%esp),%edx
40000e38:	8b 74 24 18          	mov    0x18(%esp),%esi
40000e3c:	0f b6 0a             	movzbl (%edx),%ecx
40000e3f:	80 f9 20             	cmp    $0x20,%cl
40000e42:	0f 85 e6 00 00 00    	jne    40000f2e <strtol+0xfe>
40000e48:	83 c2 01             	add    $0x1,%edx
40000e4b:	0f b6 0a             	movzbl (%edx),%ecx
40000e4e:	80 f9 09             	cmp    $0x9,%cl
40000e51:	74 f5                	je     40000e48 <strtol+0x18>
40000e53:	80 f9 20             	cmp    $0x20,%cl
40000e56:	74 f0                	je     40000e48 <strtol+0x18>
40000e58:	80 f9 2b             	cmp    $0x2b,%cl
40000e5b:	0f 84 8f 00 00 00    	je     40000ef0 <strtol+0xc0>
40000e61:	31 ff                	xor    %edi,%edi
40000e63:	80 f9 2d             	cmp    $0x2d,%cl
40000e66:	0f 84 94 00 00 00    	je     40000f00 <strtol+0xd0>
40000e6c:	f7 44 24 1c ef ff ff 	testl  $0xffffffef,0x1c(%esp)
40000e73:	ff 
40000e74:	0f be 0a             	movsbl (%edx),%ecx
40000e77:	75 19                	jne    40000e92 <strtol+0x62>
40000e79:	80 f9 30             	cmp    $0x30,%cl
40000e7c:	0f 84 8a 00 00 00    	je     40000f0c <strtol+0xdc>
40000e82:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
40000e86:	85 db                	test   %ebx,%ebx
40000e88:	75 08                	jne    40000e92 <strtol+0x62>
40000e8a:	c7 44 24 1c 0a 00 00 	movl   $0xa,0x1c(%esp)
40000e91:	00 
40000e92:	31 db                	xor    %ebx,%ebx
40000e94:	eb 18                	jmp    40000eae <strtol+0x7e>
40000e96:	66 90                	xchg   %ax,%ax
40000e98:	83 e9 30             	sub    $0x30,%ecx
40000e9b:	3b 4c 24 1c          	cmp    0x1c(%esp),%ecx
40000e9f:	7d 28                	jge    40000ec9 <strtol+0x99>
40000ea1:	0f af 5c 24 1c       	imul   0x1c(%esp),%ebx
40000ea6:	83 c2 01             	add    $0x1,%edx
40000ea9:	01 cb                	add    %ecx,%ebx
40000eab:	0f be 0a             	movsbl (%edx),%ecx
40000eae:	8d 69 d0             	lea    -0x30(%ecx),%ebp
40000eb1:	89 e8                	mov    %ebp,%eax
40000eb3:	3c 09                	cmp    $0x9,%al
40000eb5:	76 e1                	jbe    40000e98 <strtol+0x68>
40000eb7:	8d 69 9f             	lea    -0x61(%ecx),%ebp
40000eba:	89 e8                	mov    %ebp,%eax
40000ebc:	3c 19                	cmp    $0x19,%al
40000ebe:	77 20                	ja     40000ee0 <strtol+0xb0>
40000ec0:	83 e9 57             	sub    $0x57,%ecx
40000ec3:	3b 4c 24 1c          	cmp    0x1c(%esp),%ecx
40000ec7:	7c d8                	jl     40000ea1 <strtol+0x71>
40000ec9:	85 f6                	test   %esi,%esi
40000ecb:	74 02                	je     40000ecf <strtol+0x9f>
40000ecd:	89 16                	mov    %edx,(%esi)
40000ecf:	89 d8                	mov    %ebx,%eax
40000ed1:	f7 d8                	neg    %eax
40000ed3:	85 ff                	test   %edi,%edi
40000ed5:	0f 44 c3             	cmove  %ebx,%eax
40000ed8:	5b                   	pop    %ebx
40000ed9:	5e                   	pop    %esi
40000eda:	5f                   	pop    %edi
40000edb:	5d                   	pop    %ebp
40000edc:	c3                   	ret    
40000edd:	8d 76 00             	lea    0x0(%esi),%esi
40000ee0:	8d 69 bf             	lea    -0x41(%ecx),%ebp
40000ee3:	89 e8                	mov    %ebp,%eax
40000ee5:	3c 19                	cmp    $0x19,%al
40000ee7:	77 e0                	ja     40000ec9 <strtol+0x99>
40000ee9:	83 e9 37             	sub    $0x37,%ecx
40000eec:	eb ad                	jmp    40000e9b <strtol+0x6b>
40000eee:	66 90                	xchg   %ax,%ax
40000ef0:	83 c2 01             	add    $0x1,%edx
40000ef3:	31 ff                	xor    %edi,%edi
40000ef5:	e9 72 ff ff ff       	jmp    40000e6c <strtol+0x3c>
40000efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000f00:	83 c2 01             	add    $0x1,%edx
40000f03:	66 bf 01 00          	mov    $0x1,%di
40000f07:	e9 60 ff ff ff       	jmp    40000e6c <strtol+0x3c>
40000f0c:	80 7a 01 78          	cmpb   $0x78,0x1(%edx)
40000f10:	74 2a                	je     40000f3c <strtol+0x10c>
40000f12:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000f16:	85 c0                	test   %eax,%eax
40000f18:	75 36                	jne    40000f50 <strtol+0x120>
40000f1a:	0f be 4a 01          	movsbl 0x1(%edx),%ecx
40000f1e:	83 c2 01             	add    $0x1,%edx
40000f21:	c7 44 24 1c 08 00 00 	movl   $0x8,0x1c(%esp)
40000f28:	00 
40000f29:	e9 64 ff ff ff       	jmp    40000e92 <strtol+0x62>
40000f2e:	80 f9 09             	cmp    $0x9,%cl
40000f31:	0f 84 11 ff ff ff    	je     40000e48 <strtol+0x18>
40000f37:	e9 1c ff ff ff       	jmp    40000e58 <strtol+0x28>
40000f3c:	0f be 4a 02          	movsbl 0x2(%edx),%ecx
40000f40:	83 c2 02             	add    $0x2,%edx
40000f43:	c7 44 24 1c 10 00 00 	movl   $0x10,0x1c(%esp)
40000f4a:	00 
40000f4b:	e9 42 ff ff ff       	jmp    40000e92 <strtol+0x62>
40000f50:	b9 30 00 00 00       	mov    $0x30,%ecx
40000f55:	e9 38 ff ff ff       	jmp    40000e92 <strtol+0x62>
40000f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000f60 <memset>:
40000f60:	57                   	push   %edi
40000f61:	56                   	push   %esi
40000f62:	53                   	push   %ebx
40000f63:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000f67:	8b 7c 24 10          	mov    0x10(%esp),%edi
40000f6b:	85 c9                	test   %ecx,%ecx
40000f6d:	74 14                	je     40000f83 <memset+0x23>
40000f6f:	f7 c7 03 00 00 00    	test   $0x3,%edi
40000f75:	75 05                	jne    40000f7c <memset+0x1c>
40000f77:	f6 c1 03             	test   $0x3,%cl
40000f7a:	74 14                	je     40000f90 <memset+0x30>
40000f7c:	8b 44 24 14          	mov    0x14(%esp),%eax
40000f80:	fc                   	cld    
40000f81:	f3 aa                	rep stos %al,%es:(%edi)
40000f83:	89 f8                	mov    %edi,%eax
40000f85:	5b                   	pop    %ebx
40000f86:	5e                   	pop    %esi
40000f87:	5f                   	pop    %edi
40000f88:	c3                   	ret    
40000f89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000f90:	0f b6 54 24 14       	movzbl 0x14(%esp),%edx
40000f95:	c1 e9 02             	shr    $0x2,%ecx
40000f98:	89 d0                	mov    %edx,%eax
40000f9a:	89 d6                	mov    %edx,%esi
40000f9c:	c1 e0 18             	shl    $0x18,%eax
40000f9f:	89 d3                	mov    %edx,%ebx
40000fa1:	c1 e6 10             	shl    $0x10,%esi
40000fa4:	09 f0                	or     %esi,%eax
40000fa6:	c1 e3 08             	shl    $0x8,%ebx
40000fa9:	09 d0                	or     %edx,%eax
40000fab:	09 d8                	or     %ebx,%eax
40000fad:	fc                   	cld    
40000fae:	f3 ab                	rep stos %eax,%es:(%edi)
40000fb0:	89 f8                	mov    %edi,%eax
40000fb2:	5b                   	pop    %ebx
40000fb3:	5e                   	pop    %esi
40000fb4:	5f                   	pop    %edi
40000fb5:	c3                   	ret    
40000fb6:	8d 76 00             	lea    0x0(%esi),%esi
40000fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000fc0 <memmove>:
40000fc0:	57                   	push   %edi
40000fc1:	56                   	push   %esi
40000fc2:	8b 44 24 0c          	mov    0xc(%esp),%eax
40000fc6:	8b 74 24 10          	mov    0x10(%esp),%esi
40000fca:	8b 4c 24 14          	mov    0x14(%esp),%ecx
40000fce:	39 c6                	cmp    %eax,%esi
40000fd0:	73 26                	jae    40000ff8 <memmove+0x38>
40000fd2:	8d 14 0e             	lea    (%esi,%ecx,1),%edx
40000fd5:	39 d0                	cmp    %edx,%eax
40000fd7:	73 1f                	jae    40000ff8 <memmove+0x38>
40000fd9:	8d 3c 08             	lea    (%eax,%ecx,1),%edi
40000fdc:	89 d6                	mov    %edx,%esi
40000fde:	09 fe                	or     %edi,%esi
40000fe0:	83 e6 03             	and    $0x3,%esi
40000fe3:	74 33                	je     40001018 <memmove+0x58>
40000fe5:	83 ef 01             	sub    $0x1,%edi
40000fe8:	8d 72 ff             	lea    -0x1(%edx),%esi
40000feb:	fd                   	std    
40000fec:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
40000fee:	fc                   	cld    
40000fef:	5e                   	pop    %esi
40000ff0:	5f                   	pop    %edi
40000ff1:	c3                   	ret    
40000ff2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000ff8:	89 f2                	mov    %esi,%edx
40000ffa:	09 c2                	or     %eax,%edx
40000ffc:	83 e2 03             	and    $0x3,%edx
40000fff:	75 0f                	jne    40001010 <memmove+0x50>
40001001:	f6 c1 03             	test   $0x3,%cl
40001004:	75 0a                	jne    40001010 <memmove+0x50>
40001006:	c1 e9 02             	shr    $0x2,%ecx
40001009:	89 c7                	mov    %eax,%edi
4000100b:	fc                   	cld    
4000100c:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
4000100e:	eb 05                	jmp    40001015 <memmove+0x55>
40001010:	89 c7                	mov    %eax,%edi
40001012:	fc                   	cld    
40001013:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
40001015:	5e                   	pop    %esi
40001016:	5f                   	pop    %edi
40001017:	c3                   	ret    
40001018:	f6 c1 03             	test   $0x3,%cl
4000101b:	75 c8                	jne    40000fe5 <memmove+0x25>
4000101d:	83 ef 04             	sub    $0x4,%edi
40001020:	8d 72 fc             	lea    -0x4(%edx),%esi
40001023:	c1 e9 02             	shr    $0x2,%ecx
40001026:	fd                   	std    
40001027:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40001029:	eb c3                	jmp    40000fee <memmove+0x2e>
4000102b:	90                   	nop
4000102c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40001030 <memcpy>:
40001030:	e9 8b ff ff ff       	jmp    40000fc0 <memmove>
40001035:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40001039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40001040 <memcmp>:
40001040:	57                   	push   %edi
40001041:	56                   	push   %esi
40001042:	53                   	push   %ebx
40001043:	8b 44 24 18          	mov    0x18(%esp),%eax
40001047:	8b 5c 24 10          	mov    0x10(%esp),%ebx
4000104b:	8b 74 24 14          	mov    0x14(%esp),%esi
4000104f:	85 c0                	test   %eax,%eax
40001051:	8d 78 ff             	lea    -0x1(%eax),%edi
40001054:	74 26                	je     4000107c <memcmp+0x3c>
40001056:	0f b6 03             	movzbl (%ebx),%eax
40001059:	31 d2                	xor    %edx,%edx
4000105b:	0f b6 0e             	movzbl (%esi),%ecx
4000105e:	38 c8                	cmp    %cl,%al
40001060:	74 16                	je     40001078 <memcmp+0x38>
40001062:	eb 24                	jmp    40001088 <memcmp+0x48>
40001064:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40001068:	0f b6 44 13 01       	movzbl 0x1(%ebx,%edx,1),%eax
4000106d:	83 c2 01             	add    $0x1,%edx
40001070:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
40001074:	38 c8                	cmp    %cl,%al
40001076:	75 10                	jne    40001088 <memcmp+0x48>
40001078:	39 fa                	cmp    %edi,%edx
4000107a:	75 ec                	jne    40001068 <memcmp+0x28>
4000107c:	5b                   	pop    %ebx
4000107d:	31 c0                	xor    %eax,%eax
4000107f:	5e                   	pop    %esi
40001080:	5f                   	pop    %edi
40001081:	c3                   	ret    
40001082:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40001088:	5b                   	pop    %ebx
40001089:	29 c8                	sub    %ecx,%eax
4000108b:	5e                   	pop    %esi
4000108c:	5f                   	pop    %edi
4000108d:	c3                   	ret    
4000108e:	66 90                	xchg   %ax,%ax

40001090 <memchr>:
40001090:	53                   	push   %ebx
40001091:	8b 44 24 08          	mov    0x8(%esp),%eax
40001095:	8b 54 24 10          	mov    0x10(%esp),%edx
40001099:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
4000109d:	01 c2                	add    %eax,%edx
4000109f:	39 d0                	cmp    %edx,%eax
400010a1:	73 18                	jae    400010bb <memchr+0x2b>
400010a3:	38 18                	cmp    %bl,(%eax)
400010a5:	89 d9                	mov    %ebx,%ecx
400010a7:	75 0b                	jne    400010b4 <memchr+0x24>
400010a9:	eb 12                	jmp    400010bd <memchr+0x2d>
400010ab:	90                   	nop
400010ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
400010b0:	38 08                	cmp    %cl,(%eax)
400010b2:	74 09                	je     400010bd <memchr+0x2d>
400010b4:	83 c0 01             	add    $0x1,%eax
400010b7:	39 d0                	cmp    %edx,%eax
400010b9:	75 f5                	jne    400010b0 <memchr+0x20>
400010bb:	31 c0                	xor    %eax,%eax
400010bd:	5b                   	pop    %ebx
400010be:	c3                   	ret    
400010bf:	90                   	nop

400010c0 <init>:
400010c0:	a1 00 00 00 e0       	mov    0xe0000000,%eax
400010c5:	a3 20 34 00 40       	mov    %eax,0x40003420
400010ca:	a1 04 00 00 e0       	mov    0xe0000004,%eax
400010cf:	a3 00 30 00 40       	mov    %eax,0x40003000
400010d4:	c3                   	ret    
400010d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
400010d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

400010e0 <yield>:
400010e0:	f3 c3                	repz ret 
400010e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400010e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

400010f0 <sys_getc>:
400010f0:	83 ec 0c             	sub    $0xc,%esp
400010f3:	ff 15 00 30 00 40    	call   *0x40003000
400010f9:	83 c4 0c             	add    $0xc,%esp
400010fc:	0f be c0             	movsbl %al,%eax
400010ff:	c3                   	ret    

40001100 <sys_puts>:
40001100:	56                   	push   %esi
40001101:	53                   	push   %ebx
40001102:	bb ff 03 00 00       	mov    $0x3ff,%ebx
40001107:	83 ec 14             	sub    $0x14,%esp
4000110a:	8b 44 24 24          	mov    0x24(%esp),%eax
4000110e:	8b 74 24 20          	mov    0x20(%esp),%esi
40001112:	c7 04 24 20 30 00 40 	movl   $0x40003020,(%esp)
40001119:	3d ff 03 00 00       	cmp    $0x3ff,%eax
4000111e:	0f 46 d8             	cmovbe %eax,%ebx
40001121:	89 5c 24 08          	mov    %ebx,0x8(%esp)
40001125:	89 74 24 04          	mov    %esi,0x4(%esp)
40001129:	e8 52 fb ff ff       	call   40000c80 <strncpy>
4000112e:	a1 20 34 00 40       	mov    0x40003420,%eax
40001133:	c6 83 20 30 00 40 00 	movb   $0x0,0x40003020(%ebx)
4000113a:	89 74 24 24          	mov    %esi,0x24(%esp)
4000113e:	c7 44 24 20 6c 15 00 	movl   $0x4000156c,0x20(%esp)
40001145:	40 
40001146:	83 c4 14             	add    $0x14,%esp
40001149:	5b                   	pop    %ebx
4000114a:	5e                   	pop    %esi
4000114b:	ff e0                	jmp    *%eax
4000114d:	66 90                	xchg   %ax,%ax
4000114f:	90                   	nop

40001150 <__udivdi3>:
40001150:	55                   	push   %ebp
40001151:	57                   	push   %edi
40001152:	56                   	push   %esi
40001153:	83 ec 0c             	sub    $0xc,%esp
40001156:	8b 44 24 28          	mov    0x28(%esp),%eax
4000115a:	8b 7c 24 1c          	mov    0x1c(%esp),%edi
4000115e:	8b 6c 24 20          	mov    0x20(%esp),%ebp
40001162:	8b 4c 24 24          	mov    0x24(%esp),%ecx
40001166:	85 c0                	test   %eax,%eax
40001168:	89 7c 24 04          	mov    %edi,0x4(%esp)
4000116c:	89 ea                	mov    %ebp,%edx
4000116e:	89 0c 24             	mov    %ecx,(%esp)
40001171:	75 2d                	jne    400011a0 <__udivdi3+0x50>
40001173:	39 e9                	cmp    %ebp,%ecx
40001175:	77 61                	ja     400011d8 <__udivdi3+0x88>
40001177:	85 c9                	test   %ecx,%ecx
40001179:	89 ce                	mov    %ecx,%esi
4000117b:	75 0b                	jne    40001188 <__udivdi3+0x38>
4000117d:	b8 01 00 00 00       	mov    $0x1,%eax
40001182:	31 d2                	xor    %edx,%edx
40001184:	f7 f1                	div    %ecx
40001186:	89 c6                	mov    %eax,%esi
40001188:	31 d2                	xor    %edx,%edx
4000118a:	89 e8                	mov    %ebp,%eax
4000118c:	f7 f6                	div    %esi
4000118e:	89 c5                	mov    %eax,%ebp
40001190:	89 f8                	mov    %edi,%eax
40001192:	f7 f6                	div    %esi
40001194:	89 ea                	mov    %ebp,%edx
40001196:	83 c4 0c             	add    $0xc,%esp
40001199:	5e                   	pop    %esi
4000119a:	5f                   	pop    %edi
4000119b:	5d                   	pop    %ebp
4000119c:	c3                   	ret    
4000119d:	8d 76 00             	lea    0x0(%esi),%esi
400011a0:	39 e8                	cmp    %ebp,%eax
400011a2:	77 24                	ja     400011c8 <__udivdi3+0x78>
400011a4:	0f bd e8             	bsr    %eax,%ebp
400011a7:	83 f5 1f             	xor    $0x1f,%ebp
400011aa:	75 3c                	jne    400011e8 <__udivdi3+0x98>
400011ac:	8b 74 24 04          	mov    0x4(%esp),%esi
400011b0:	39 34 24             	cmp    %esi,(%esp)
400011b3:	0f 86 9f 00 00 00    	jbe    40001258 <__udivdi3+0x108>
400011b9:	39 d0                	cmp    %edx,%eax
400011bb:	0f 82 97 00 00 00    	jb     40001258 <__udivdi3+0x108>
400011c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400011c8:	31 d2                	xor    %edx,%edx
400011ca:	31 c0                	xor    %eax,%eax
400011cc:	83 c4 0c             	add    $0xc,%esp
400011cf:	5e                   	pop    %esi
400011d0:	5f                   	pop    %edi
400011d1:	5d                   	pop    %ebp
400011d2:	c3                   	ret    
400011d3:	90                   	nop
400011d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
400011d8:	89 f8                	mov    %edi,%eax
400011da:	f7 f1                	div    %ecx
400011dc:	31 d2                	xor    %edx,%edx
400011de:	83 c4 0c             	add    $0xc,%esp
400011e1:	5e                   	pop    %esi
400011e2:	5f                   	pop    %edi
400011e3:	5d                   	pop    %ebp
400011e4:	c3                   	ret    
400011e5:	8d 76 00             	lea    0x0(%esi),%esi
400011e8:	89 e9                	mov    %ebp,%ecx
400011ea:	8b 3c 24             	mov    (%esp),%edi
400011ed:	d3 e0                	shl    %cl,%eax
400011ef:	89 c6                	mov    %eax,%esi
400011f1:	b8 20 00 00 00       	mov    $0x20,%eax
400011f6:	29 e8                	sub    %ebp,%eax
400011f8:	89 c1                	mov    %eax,%ecx
400011fa:	d3 ef                	shr    %cl,%edi
400011fc:	89 e9                	mov    %ebp,%ecx
400011fe:	89 7c 24 08          	mov    %edi,0x8(%esp)
40001202:	8b 3c 24             	mov    (%esp),%edi
40001205:	09 74 24 08          	or     %esi,0x8(%esp)
40001209:	89 d6                	mov    %edx,%esi
4000120b:	d3 e7                	shl    %cl,%edi
4000120d:	89 c1                	mov    %eax,%ecx
4000120f:	89 3c 24             	mov    %edi,(%esp)
40001212:	8b 7c 24 04          	mov    0x4(%esp),%edi
40001216:	d3 ee                	shr    %cl,%esi
40001218:	89 e9                	mov    %ebp,%ecx
4000121a:	d3 e2                	shl    %cl,%edx
4000121c:	89 c1                	mov    %eax,%ecx
4000121e:	d3 ef                	shr    %cl,%edi
40001220:	09 d7                	or     %edx,%edi
40001222:	89 f2                	mov    %esi,%edx
40001224:	89 f8                	mov    %edi,%eax
40001226:	f7 74 24 08          	divl   0x8(%esp)
4000122a:	89 d6                	mov    %edx,%esi
4000122c:	89 c7                	mov    %eax,%edi
4000122e:	f7 24 24             	mull   (%esp)
40001231:	39 d6                	cmp    %edx,%esi
40001233:	89 14 24             	mov    %edx,(%esp)
40001236:	72 30                	jb     40001268 <__udivdi3+0x118>
40001238:	8b 54 24 04          	mov    0x4(%esp),%edx
4000123c:	89 e9                	mov    %ebp,%ecx
4000123e:	d3 e2                	shl    %cl,%edx
40001240:	39 c2                	cmp    %eax,%edx
40001242:	73 05                	jae    40001249 <__udivdi3+0xf9>
40001244:	3b 34 24             	cmp    (%esp),%esi
40001247:	74 1f                	je     40001268 <__udivdi3+0x118>
40001249:	89 f8                	mov    %edi,%eax
4000124b:	31 d2                	xor    %edx,%edx
4000124d:	e9 7a ff ff ff       	jmp    400011cc <__udivdi3+0x7c>
40001252:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40001258:	31 d2                	xor    %edx,%edx
4000125a:	b8 01 00 00 00       	mov    $0x1,%eax
4000125f:	e9 68 ff ff ff       	jmp    400011cc <__udivdi3+0x7c>
40001264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40001268:	8d 47 ff             	lea    -0x1(%edi),%eax
4000126b:	31 d2                	xor    %edx,%edx
4000126d:	83 c4 0c             	add    $0xc,%esp
40001270:	5e                   	pop    %esi
40001271:	5f                   	pop    %edi
40001272:	5d                   	pop    %ebp
40001273:	c3                   	ret    
40001274:	66 90                	xchg   %ax,%ax
40001276:	66 90                	xchg   %ax,%ax
40001278:	66 90                	xchg   %ax,%ax
4000127a:	66 90                	xchg   %ax,%ax
4000127c:	66 90                	xchg   %ax,%ax
4000127e:	66 90                	xchg   %ax,%ax

40001280 <__umoddi3>:
40001280:	55                   	push   %ebp
40001281:	57                   	push   %edi
40001282:	56                   	push   %esi
40001283:	83 ec 14             	sub    $0x14,%esp
40001286:	8b 44 24 28          	mov    0x28(%esp),%eax
4000128a:	8b 4c 24 24          	mov    0x24(%esp),%ecx
4000128e:	8b 74 24 2c          	mov    0x2c(%esp),%esi
40001292:	89 c7                	mov    %eax,%edi
40001294:	89 44 24 04          	mov    %eax,0x4(%esp)
40001298:	8b 44 24 30          	mov    0x30(%esp),%eax
4000129c:	89 4c 24 10          	mov    %ecx,0x10(%esp)
400012a0:	89 34 24             	mov    %esi,(%esp)
400012a3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
400012a7:	85 c0                	test   %eax,%eax
400012a9:	89 c2                	mov    %eax,%edx
400012ab:	89 7c 24 0c          	mov    %edi,0xc(%esp)
400012af:	75 17                	jne    400012c8 <__umoddi3+0x48>
400012b1:	39 fe                	cmp    %edi,%esi
400012b3:	76 4b                	jbe    40001300 <__umoddi3+0x80>
400012b5:	89 c8                	mov    %ecx,%eax
400012b7:	89 fa                	mov    %edi,%edx
400012b9:	f7 f6                	div    %esi
400012bb:	89 d0                	mov    %edx,%eax
400012bd:	31 d2                	xor    %edx,%edx
400012bf:	83 c4 14             	add    $0x14,%esp
400012c2:	5e                   	pop    %esi
400012c3:	5f                   	pop    %edi
400012c4:	5d                   	pop    %ebp
400012c5:	c3                   	ret    
400012c6:	66 90                	xchg   %ax,%ax
400012c8:	39 f8                	cmp    %edi,%eax
400012ca:	77 54                	ja     40001320 <__umoddi3+0xa0>
400012cc:	0f bd e8             	bsr    %eax,%ebp
400012cf:	83 f5 1f             	xor    $0x1f,%ebp
400012d2:	75 5c                	jne    40001330 <__umoddi3+0xb0>
400012d4:	8b 7c 24 08          	mov    0x8(%esp),%edi
400012d8:	39 3c 24             	cmp    %edi,(%esp)
400012db:	0f 87 e7 00 00 00    	ja     400013c8 <__umoddi3+0x148>
400012e1:	8b 7c 24 04          	mov    0x4(%esp),%edi
400012e5:	29 f1                	sub    %esi,%ecx
400012e7:	19 c7                	sbb    %eax,%edi
400012e9:	89 4c 24 08          	mov    %ecx,0x8(%esp)
400012ed:	89 7c 24 0c          	mov    %edi,0xc(%esp)
400012f1:	8b 44 24 08          	mov    0x8(%esp),%eax
400012f5:	8b 54 24 0c          	mov    0xc(%esp),%edx
400012f9:	83 c4 14             	add    $0x14,%esp
400012fc:	5e                   	pop    %esi
400012fd:	5f                   	pop    %edi
400012fe:	5d                   	pop    %ebp
400012ff:	c3                   	ret    
40001300:	85 f6                	test   %esi,%esi
40001302:	89 f5                	mov    %esi,%ebp
40001304:	75 0b                	jne    40001311 <__umoddi3+0x91>
40001306:	b8 01 00 00 00       	mov    $0x1,%eax
4000130b:	31 d2                	xor    %edx,%edx
4000130d:	f7 f6                	div    %esi
4000130f:	89 c5                	mov    %eax,%ebp
40001311:	8b 44 24 04          	mov    0x4(%esp),%eax
40001315:	31 d2                	xor    %edx,%edx
40001317:	f7 f5                	div    %ebp
40001319:	89 c8                	mov    %ecx,%eax
4000131b:	f7 f5                	div    %ebp
4000131d:	eb 9c                	jmp    400012bb <__umoddi3+0x3b>
4000131f:	90                   	nop
40001320:	89 c8                	mov    %ecx,%eax
40001322:	89 fa                	mov    %edi,%edx
40001324:	83 c4 14             	add    $0x14,%esp
40001327:	5e                   	pop    %esi
40001328:	5f                   	pop    %edi
40001329:	5d                   	pop    %ebp
4000132a:	c3                   	ret    
4000132b:	90                   	nop
4000132c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40001330:	8b 04 24             	mov    (%esp),%eax
40001333:	be 20 00 00 00       	mov    $0x20,%esi
40001338:	89 e9                	mov    %ebp,%ecx
4000133a:	29 ee                	sub    %ebp,%esi
4000133c:	d3 e2                	shl    %cl,%edx
4000133e:	89 f1                	mov    %esi,%ecx
40001340:	d3 e8                	shr    %cl,%eax
40001342:	89 e9                	mov    %ebp,%ecx
40001344:	89 44 24 04          	mov    %eax,0x4(%esp)
40001348:	8b 04 24             	mov    (%esp),%eax
4000134b:	09 54 24 04          	or     %edx,0x4(%esp)
4000134f:	89 fa                	mov    %edi,%edx
40001351:	d3 e0                	shl    %cl,%eax
40001353:	89 f1                	mov    %esi,%ecx
40001355:	89 44 24 08          	mov    %eax,0x8(%esp)
40001359:	8b 44 24 10          	mov    0x10(%esp),%eax
4000135d:	d3 ea                	shr    %cl,%edx
4000135f:	89 e9                	mov    %ebp,%ecx
40001361:	d3 e7                	shl    %cl,%edi
40001363:	89 f1                	mov    %esi,%ecx
40001365:	d3 e8                	shr    %cl,%eax
40001367:	89 e9                	mov    %ebp,%ecx
40001369:	09 f8                	or     %edi,%eax
4000136b:	8b 7c 24 10          	mov    0x10(%esp),%edi
4000136f:	f7 74 24 04          	divl   0x4(%esp)
40001373:	d3 e7                	shl    %cl,%edi
40001375:	89 7c 24 0c          	mov    %edi,0xc(%esp)
40001379:	89 d7                	mov    %edx,%edi
4000137b:	f7 64 24 08          	mull   0x8(%esp)
4000137f:	39 d7                	cmp    %edx,%edi
40001381:	89 c1                	mov    %eax,%ecx
40001383:	89 14 24             	mov    %edx,(%esp)
40001386:	72 2c                	jb     400013b4 <__umoddi3+0x134>
40001388:	39 44 24 0c          	cmp    %eax,0xc(%esp)
4000138c:	72 22                	jb     400013b0 <__umoddi3+0x130>
4000138e:	8b 44 24 0c          	mov    0xc(%esp),%eax
40001392:	29 c8                	sub    %ecx,%eax
40001394:	19 d7                	sbb    %edx,%edi
40001396:	89 e9                	mov    %ebp,%ecx
40001398:	89 fa                	mov    %edi,%edx
4000139a:	d3 e8                	shr    %cl,%eax
4000139c:	89 f1                	mov    %esi,%ecx
4000139e:	d3 e2                	shl    %cl,%edx
400013a0:	89 e9                	mov    %ebp,%ecx
400013a2:	d3 ef                	shr    %cl,%edi
400013a4:	09 d0                	or     %edx,%eax
400013a6:	89 fa                	mov    %edi,%edx
400013a8:	83 c4 14             	add    $0x14,%esp
400013ab:	5e                   	pop    %esi
400013ac:	5f                   	pop    %edi
400013ad:	5d                   	pop    %ebp
400013ae:	c3                   	ret    
400013af:	90                   	nop
400013b0:	39 d7                	cmp    %edx,%edi
400013b2:	75 da                	jne    4000138e <__umoddi3+0x10e>
400013b4:	8b 14 24             	mov    (%esp),%edx
400013b7:	89 c1                	mov    %eax,%ecx
400013b9:	2b 4c 24 08          	sub    0x8(%esp),%ecx
400013bd:	1b 54 24 04          	sbb    0x4(%esp),%edx
400013c1:	eb cb                	jmp    4000138e <__umoddi3+0x10e>
400013c3:	90                   	nop
400013c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
400013c8:	3b 44 24 0c          	cmp    0xc(%esp),%eax
400013cc:	0f 82 0f ff ff ff    	jb     400012e1 <__umoddi3+0x61>
400013d2:	e9 1a ff ff ff       	jmp    400012f1 <__umoddi3+0x71>
