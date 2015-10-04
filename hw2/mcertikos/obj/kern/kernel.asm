
obj/kern/kernel:     file format elf32-i386


Disassembly of section .text:

00100000 <video_init>:
  100000:	55                   	push   %ebp
  100001:	89 e5                	mov    %esp,%ebp
  100003:	83 ec 28             	sub    $0x28,%esp
  100006:	c7 45 f4 00 80 0b 00 	movl   $0xb8000,-0xc(%ebp)
  10000d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100010:	0f b7 00             	movzwl (%eax),%eax
  100013:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
  100017:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10001a:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
  10001f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100022:	0f b7 00             	movzwl (%eax),%eax
  100025:	66 3d 5a a5          	cmp    $0xa55a,%ax
  100029:	74 28                	je     100053 <video_init+0x53>
  10002b:	c7 45 f4 00 00 0b 00 	movl   $0xb0000,-0xc(%ebp)
  100032:	c7 05 8c e4 90 00 b4 	movl   $0x3b4,0x90e48c
  100039:	03 00 00 
  10003c:	a1 8c e4 90 00       	mov    0x90e48c,%eax
  100041:	89 44 24 04          	mov    %eax,0x4(%esp)
  100045:	c7 04 24 c8 52 10 00 	movl   $0x1052c8,(%esp)
  10004c:	e8 a0 28 00 00       	call   1028f1 <dprintf>
  100051:	eb 29                	jmp    10007c <video_init+0x7c>
  100053:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100056:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  10005a:	66 89 10             	mov    %dx,(%eax)
  10005d:	c7 05 8c e4 90 00 d4 	movl   $0x3d4,0x90e48c
  100064:	03 00 00 
  100067:	a1 8c e4 90 00       	mov    0x90e48c,%eax
  10006c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100070:	c7 04 24 c8 52 10 00 	movl   $0x1052c8,(%esp)
  100077:	e8 75 28 00 00       	call   1028f1 <dprintf>
  10007c:	a1 8c e4 90 00       	mov    0x90e48c,%eax
  100081:	c7 44 24 04 0e 00 00 	movl   $0xe,0x4(%esp)
  100088:	00 
  100089:	89 04 24             	mov    %eax,(%esp)
  10008c:	e8 94 35 00 00       	call   103625 <outb>
  100091:	a1 8c e4 90 00       	mov    0x90e48c,%eax
  100096:	83 c0 01             	add    $0x1,%eax
  100099:	89 04 24             	mov    %eax,(%esp)
  10009c:	e8 4a 35 00 00       	call   1035eb <inb>
  1000a1:	0f b6 c0             	movzbl %al,%eax
  1000a4:	c1 e0 08             	shl    $0x8,%eax
  1000a7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1000aa:	a1 8c e4 90 00       	mov    0x90e48c,%eax
  1000af:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
  1000b6:	00 
  1000b7:	89 04 24             	mov    %eax,(%esp)
  1000ba:	e8 66 35 00 00       	call   103625 <outb>
  1000bf:	a1 8c e4 90 00       	mov    0x90e48c,%eax
  1000c4:	83 c0 01             	add    $0x1,%eax
  1000c7:	89 04 24             	mov    %eax,(%esp)
  1000ca:	e8 1c 35 00 00       	call   1035eb <inb>
  1000cf:	0f b6 c0             	movzbl %al,%eax
  1000d2:	09 45 ec             	or     %eax,-0x14(%ebp)
  1000d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1000d8:	a3 80 e4 90 00       	mov    %eax,0x90e480
  1000dd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1000e0:	66 a3 84 e4 90 00    	mov    %ax,0x90e484
  1000e6:	c7 05 88 e4 90 00 00 	movl   $0x0,0x90e488
  1000ed:	00 00 00 
  1000f0:	c9                   	leave  
  1000f1:	c3                   	ret    

001000f2 <video_putc>:
  1000f2:	55                   	push   %ebp
  1000f3:	89 e5                	mov    %esp,%ebp
  1000f5:	53                   	push   %ebx
  1000f6:	83 ec 24             	sub    $0x24,%esp
  1000f9:	8b 45 08             	mov    0x8(%ebp),%eax
  1000fc:	b0 00                	mov    $0x0,%al
  1000fe:	85 c0                	test   %eax,%eax
  100100:	75 07                	jne    100109 <video_putc+0x17>
  100102:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
  100109:	8b 45 08             	mov    0x8(%ebp),%eax
  10010c:	0f b6 c0             	movzbl %al,%eax
  10010f:	83 f8 09             	cmp    $0x9,%eax
  100112:	0f 84 ac 00 00 00    	je     1001c4 <video_putc+0xd2>
  100118:	83 f8 09             	cmp    $0x9,%eax
  10011b:	7f 0a                	jg     100127 <video_putc+0x35>
  10011d:	83 f8 08             	cmp    $0x8,%eax
  100120:	74 14                	je     100136 <video_putc+0x44>
  100122:	e9 db 00 00 00       	jmp    100202 <video_putc+0x110>
  100127:	83 f8 0a             	cmp    $0xa,%eax
  10012a:	74 4e                	je     10017a <video_putc+0x88>
  10012c:	83 f8 0d             	cmp    $0xd,%eax
  10012f:	74 59                	je     10018a <video_putc+0x98>
  100131:	e9 cc 00 00 00       	jmp    100202 <video_putc+0x110>
  100136:	0f b7 05 84 e4 90 00 	movzwl 0x90e484,%eax
  10013d:	66 85 c0             	test   %ax,%ax
  100140:	74 33                	je     100175 <video_putc+0x83>
  100142:	0f b7 05 84 e4 90 00 	movzwl 0x90e484,%eax
  100149:	83 e8 01             	sub    $0x1,%eax
  10014c:	66 a3 84 e4 90 00    	mov    %ax,0x90e484
  100152:	a1 80 e4 90 00       	mov    0x90e480,%eax
  100157:	0f b7 15 84 e4 90 00 	movzwl 0x90e484,%edx
  10015e:	0f b7 d2             	movzwl %dx,%edx
  100161:	01 d2                	add    %edx,%edx
  100163:	01 c2                	add    %eax,%edx
  100165:	8b 45 08             	mov    0x8(%ebp),%eax
  100168:	b0 00                	mov    $0x0,%al
  10016a:	83 c8 20             	or     $0x20,%eax
  10016d:	66 89 02             	mov    %ax,(%edx)
  100170:	e9 b3 00 00 00       	jmp    100228 <video_putc+0x136>
  100175:	e9 ae 00 00 00       	jmp    100228 <video_putc+0x136>
  10017a:	0f b7 05 84 e4 90 00 	movzwl 0x90e484,%eax
  100181:	83 c0 50             	add    $0x50,%eax
  100184:	66 a3 84 e4 90 00    	mov    %ax,0x90e484
  10018a:	0f b7 1d 84 e4 90 00 	movzwl 0x90e484,%ebx
  100191:	0f b7 0d 84 e4 90 00 	movzwl 0x90e484,%ecx
  100198:	0f b7 c1             	movzwl %cx,%eax
  10019b:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
  1001a1:	c1 e8 10             	shr    $0x10,%eax
  1001a4:	89 c2                	mov    %eax,%edx
  1001a6:	66 c1 ea 06          	shr    $0x6,%dx
  1001aa:	89 d0                	mov    %edx,%eax
  1001ac:	c1 e0 02             	shl    $0x2,%eax
  1001af:	01 d0                	add    %edx,%eax
  1001b1:	c1 e0 04             	shl    $0x4,%eax
  1001b4:	29 c1                	sub    %eax,%ecx
  1001b6:	89 ca                	mov    %ecx,%edx
  1001b8:	89 d8                	mov    %ebx,%eax
  1001ba:	29 d0                	sub    %edx,%eax
  1001bc:	66 a3 84 e4 90 00    	mov    %ax,0x90e484
  1001c2:	eb 64                	jmp    100228 <video_putc+0x136>
  1001c4:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1001cb:	e8 22 ff ff ff       	call   1000f2 <video_putc>
  1001d0:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1001d7:	e8 16 ff ff ff       	call   1000f2 <video_putc>
  1001dc:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1001e3:	e8 0a ff ff ff       	call   1000f2 <video_putc>
  1001e8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1001ef:	e8 fe fe ff ff       	call   1000f2 <video_putc>
  1001f4:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1001fb:	e8 f2 fe ff ff       	call   1000f2 <video_putc>
  100200:	eb 26                	jmp    100228 <video_putc+0x136>
  100202:	8b 0d 80 e4 90 00    	mov    0x90e480,%ecx
  100208:	0f b7 05 84 e4 90 00 	movzwl 0x90e484,%eax
  10020f:	8d 50 01             	lea    0x1(%eax),%edx
  100212:	66 89 15 84 e4 90 00 	mov    %dx,0x90e484
  100219:	0f b7 c0             	movzwl %ax,%eax
  10021c:	01 c0                	add    %eax,%eax
  10021e:	8d 14 01             	lea    (%ecx,%eax,1),%edx
  100221:	8b 45 08             	mov    0x8(%ebp),%eax
  100224:	66 89 02             	mov    %ax,(%edx)
  100227:	90                   	nop
  100228:	0f b7 05 84 e4 90 00 	movzwl 0x90e484,%eax
  10022f:	66 3d cf 07          	cmp    $0x7cf,%ax
  100233:	76 5b                	jbe    100290 <video_putc+0x19e>
  100235:	a1 80 e4 90 00       	mov    0x90e480,%eax
  10023a:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  100240:	a1 80 e4 90 00       	mov    0x90e480,%eax
  100245:	c7 44 24 08 00 0f 00 	movl   $0xf00,0x8(%esp)
  10024c:	00 
  10024d:	89 54 24 04          	mov    %edx,0x4(%esp)
  100251:	89 04 24             	mov    %eax,(%esp)
  100254:	e8 01 22 00 00       	call   10245a <memmove>
  100259:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  100260:	eb 15                	jmp    100277 <video_putc+0x185>
  100262:	a1 80 e4 90 00       	mov    0x90e480,%eax
  100267:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10026a:	01 d2                	add    %edx,%edx
  10026c:	01 d0                	add    %edx,%eax
  10026e:	66 c7 00 20 07       	movw   $0x720,(%eax)
  100273:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100277:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  10027e:	7e e2                	jle    100262 <video_putc+0x170>
  100280:	0f b7 05 84 e4 90 00 	movzwl 0x90e484,%eax
  100287:	83 e8 50             	sub    $0x50,%eax
  10028a:	66 a3 84 e4 90 00    	mov    %ax,0x90e484
  100290:	a1 8c e4 90 00       	mov    0x90e48c,%eax
  100295:	c7 44 24 04 0e 00 00 	movl   $0xe,0x4(%esp)
  10029c:	00 
  10029d:	89 04 24             	mov    %eax,(%esp)
  1002a0:	e8 80 33 00 00       	call   103625 <outb>
  1002a5:	0f b7 05 84 e4 90 00 	movzwl 0x90e484,%eax
  1002ac:	66 c1 e8 08          	shr    $0x8,%ax
  1002b0:	0f b6 d0             	movzbl %al,%edx
  1002b3:	a1 8c e4 90 00       	mov    0x90e48c,%eax
  1002b8:	83 c0 01             	add    $0x1,%eax
  1002bb:	89 54 24 04          	mov    %edx,0x4(%esp)
  1002bf:	89 04 24             	mov    %eax,(%esp)
  1002c2:	e8 5e 33 00 00       	call   103625 <outb>
  1002c7:	a1 8c e4 90 00       	mov    0x90e48c,%eax
  1002cc:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
  1002d3:	00 
  1002d4:	89 04 24             	mov    %eax,(%esp)
  1002d7:	e8 49 33 00 00       	call   103625 <outb>
  1002dc:	0f b7 05 84 e4 90 00 	movzwl 0x90e484,%eax
  1002e3:	0f b6 d0             	movzbl %al,%edx
  1002e6:	a1 8c e4 90 00       	mov    0x90e48c,%eax
  1002eb:	83 c0 01             	add    $0x1,%eax
  1002ee:	89 54 24 04          	mov    %edx,0x4(%esp)
  1002f2:	89 04 24             	mov    %eax,(%esp)
  1002f5:	e8 2b 33 00 00       	call   103625 <outb>
  1002fa:	83 c4 24             	add    $0x24,%esp
  1002fd:	5b                   	pop    %ebx
  1002fe:	5d                   	pop    %ebp
  1002ff:	c3                   	ret    

00100300 <video_set_cursor>:
  100300:	55                   	push   %ebp
  100301:	89 e5                	mov    %esp,%ebp
  100303:	8b 45 08             	mov    0x8(%ebp),%eax
  100306:	89 c2                	mov    %eax,%edx
  100308:	89 d0                	mov    %edx,%eax
  10030a:	c1 e0 02             	shl    $0x2,%eax
  10030d:	01 d0                	add    %edx,%eax
  10030f:	c1 e0 04             	shl    $0x4,%eax
  100312:	89 c2                	mov    %eax,%edx
  100314:	8b 45 0c             	mov    0xc(%ebp),%eax
  100317:	01 d0                	add    %edx,%eax
  100319:	66 a3 84 e4 90 00    	mov    %ax,0x90e484
  10031f:	5d                   	pop    %ebp
  100320:	c3                   	ret    

00100321 <video_clear_screen>:
  100321:	55                   	push   %ebp
  100322:	89 e5                	mov    %esp,%ebp
  100324:	83 ec 10             	sub    $0x10,%esp
  100327:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10032e:	eb 15                	jmp    100345 <video_clear_screen+0x24>
  100330:	a1 80 e4 90 00       	mov    0x90e480,%eax
  100335:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100338:	01 d2                	add    %edx,%edx
  10033a:	01 d0                	add    %edx,%eax
  10033c:	66 c7 00 20 00       	movw   $0x20,(%eax)
  100341:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  100345:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%ebp)
  10034c:	7e e2                	jle    100330 <video_clear_screen+0xf>
  10034e:	c9                   	leave  
  10034f:	c3                   	ret    

00100350 <cons_init>:
  100350:	55                   	push   %ebp
  100351:	89 e5                	mov    %esp,%ebp
  100353:	83 ec 18             	sub    $0x18,%esp
  100356:	c7 44 24 08 08 02 00 	movl   $0x208,0x8(%esp)
  10035d:	00 
  10035e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100365:	00 
  100366:	c7 04 24 a0 e4 90 00 	movl   $0x90e4a0,(%esp)
  10036d:	e8 7a 20 00 00       	call   1023ec <memset>
  100372:	e8 3b 03 00 00       	call   1006b2 <serial_init>
  100377:	e8 84 fc ff ff       	call   100000 <video_init>
  10037c:	c9                   	leave  
  10037d:	c3                   	ret    

0010037e <cons_intr>:
  10037e:	55                   	push   %ebp
  10037f:	89 e5                	mov    %esp,%ebp
  100381:	83 ec 18             	sub    $0x18,%esp
  100384:	eb 35                	jmp    1003bb <cons_intr+0x3d>
  100386:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10038a:	75 02                	jne    10038e <cons_intr+0x10>
  10038c:	eb 2d                	jmp    1003bb <cons_intr+0x3d>
  10038e:	a1 a4 e6 90 00       	mov    0x90e6a4,%eax
  100393:	8d 50 01             	lea    0x1(%eax),%edx
  100396:	89 15 a4 e6 90 00    	mov    %edx,0x90e6a4
  10039c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10039f:	88 90 a0 e4 90 00    	mov    %dl,0x90e4a0(%eax)
  1003a5:	a1 a4 e6 90 00       	mov    0x90e6a4,%eax
  1003aa:	3d 00 02 00 00       	cmp    $0x200,%eax
  1003af:	75 0a                	jne    1003bb <cons_intr+0x3d>
  1003b1:	c7 05 a4 e6 90 00 00 	movl   $0x0,0x90e6a4
  1003b8:	00 00 00 
  1003bb:	8b 45 08             	mov    0x8(%ebp),%eax
  1003be:	ff d0                	call   *%eax
  1003c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1003c3:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  1003c7:	75 bd                	jne    100386 <cons_intr+0x8>
  1003c9:	c9                   	leave  
  1003ca:	c3                   	ret    

001003cb <cons_getc>:
  1003cb:	55                   	push   %ebp
  1003cc:	89 e5                	mov    %esp,%ebp
  1003ce:	83 ec 18             	sub    $0x18,%esp
  1003d1:	e8 ee 01 00 00       	call   1005c4 <serial_intr>
  1003d6:	e8 3c 05 00 00       	call   100917 <keyboard_intr>
  1003db:	8b 15 a0 e6 90 00    	mov    0x90e6a0,%edx
  1003e1:	a1 a4 e6 90 00       	mov    0x90e6a4,%eax
  1003e6:	39 c2                	cmp    %eax,%edx
  1003e8:	74 36                	je     100420 <cons_getc+0x55>
  1003ea:	a1 a0 e6 90 00       	mov    0x90e6a0,%eax
  1003ef:	8d 50 01             	lea    0x1(%eax),%edx
  1003f2:	89 15 a0 e6 90 00    	mov    %edx,0x90e6a0
  1003f8:	0f b6 80 a0 e4 90 00 	movzbl 0x90e4a0(%eax),%eax
  1003ff:	0f be c0             	movsbl %al,%eax
  100402:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100405:	a1 a0 e6 90 00       	mov    0x90e6a0,%eax
  10040a:	3d 00 02 00 00       	cmp    $0x200,%eax
  10040f:	75 0a                	jne    10041b <cons_getc+0x50>
  100411:	c7 05 a0 e6 90 00 00 	movl   $0x0,0x90e6a0
  100418:	00 00 00 
  10041b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10041e:	eb 05                	jmp    100425 <cons_getc+0x5a>
  100420:	b8 00 00 00 00       	mov    $0x0,%eax
  100425:	c9                   	leave  
  100426:	c3                   	ret    

00100427 <cons_putc>:
  100427:	55                   	push   %ebp
  100428:	89 e5                	mov    %esp,%ebp
  10042a:	83 ec 18             	sub    $0x18,%esp
  10042d:	8b 45 08             	mov    0x8(%ebp),%eax
  100430:	88 45 f4             	mov    %al,-0xc(%ebp)
  100433:	0f be 45 f4          	movsbl -0xc(%ebp),%eax
  100437:	89 04 24             	mov    %eax,(%esp)
  10043a:	e8 f8 01 00 00       	call   100637 <serial_putc>
  10043f:	0f be 45 f4          	movsbl -0xc(%ebp),%eax
  100443:	89 04 24             	mov    %eax,(%esp)
  100446:	e8 a7 fc ff ff       	call   1000f2 <video_putc>
  10044b:	c9                   	leave  
  10044c:	c3                   	ret    

0010044d <getchar>:
  10044d:	55                   	push   %ebp
  10044e:	89 e5                	mov    %esp,%ebp
  100450:	83 ec 18             	sub    $0x18,%esp
  100453:	e8 73 ff ff ff       	call   1003cb <cons_getc>
  100458:	88 45 f7             	mov    %al,-0x9(%ebp)
  10045b:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  10045f:	74 f2                	je     100453 <getchar+0x6>
  100461:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  100465:	c9                   	leave  
  100466:	c3                   	ret    

00100467 <putchar>:
  100467:	55                   	push   %ebp
  100468:	89 e5                	mov    %esp,%ebp
  10046a:	83 ec 18             	sub    $0x18,%esp
  10046d:	8b 45 08             	mov    0x8(%ebp),%eax
  100470:	88 45 f4             	mov    %al,-0xc(%ebp)
  100473:	0f be 45 f4          	movsbl -0xc(%ebp),%eax
  100477:	89 04 24             	mov    %eax,(%esp)
  10047a:	e8 a8 ff ff ff       	call   100427 <cons_putc>
  10047f:	c9                   	leave  
  100480:	c3                   	ret    

00100481 <readline>:
  100481:	55                   	push   %ebp
  100482:	89 e5                	mov    %esp,%ebp
  100484:	83 ec 28             	sub    $0x28,%esp
  100487:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  10048b:	74 13                	je     1004a0 <readline+0x1f>
  10048d:	8b 45 08             	mov    0x8(%ebp),%eax
  100490:	89 44 24 04          	mov    %eax,0x4(%esp)
  100494:	c7 04 24 d6 52 10 00 	movl   $0x1052d6,(%esp)
  10049b:	e8 51 24 00 00       	call   1028f1 <dprintf>
  1004a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  1004a7:	e8 a1 ff ff ff       	call   10044d <getchar>
  1004ac:	88 45 f3             	mov    %al,-0xd(%ebp)
  1004af:	80 7d f3 00          	cmpb   $0x0,-0xd(%ebp)
  1004b3:	79 1e                	jns    1004d3 <readline+0x52>
  1004b5:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
  1004b9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1004bd:	c7 04 24 d9 52 10 00 	movl   $0x1052d9,(%esp)
  1004c4:	e8 28 24 00 00       	call   1028f1 <dprintf>
  1004c9:	b8 00 00 00 00       	mov    $0x0,%eax
  1004ce:	e9 83 00 00 00       	jmp    100556 <readline+0xd5>
  1004d3:	80 7d f3 08          	cmpb   $0x8,-0xd(%ebp)
  1004d7:	74 06                	je     1004df <readline+0x5e>
  1004d9:	80 7d f3 7f          	cmpb   $0x7f,-0xd(%ebp)
  1004dd:	75 18                	jne    1004f7 <readline+0x76>
  1004df:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1004e3:	7e 12                	jle    1004f7 <readline+0x76>
  1004e5:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1004ec:	e8 76 ff ff ff       	call   100467 <putchar>
  1004f1:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  1004f5:	eb 5a                	jmp    100551 <readline+0xd0>
  1004f7:	80 7d f3 1f          	cmpb   $0x1f,-0xd(%ebp)
  1004fb:	7e 2a                	jle    100527 <readline+0xa6>
  1004fd:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  100504:	7f 21                	jg     100527 <readline+0xa6>
  100506:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
  10050a:	89 04 24             	mov    %eax,(%esp)
  10050d:	e8 55 ff ff ff       	call   100467 <putchar>
  100512:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100515:	8d 50 01             	lea    0x1(%eax),%edx
  100518:	89 55 f4             	mov    %edx,-0xc(%ebp)
  10051b:	0f b6 55 f3          	movzbl -0xd(%ebp),%edx
  10051f:	88 90 00 d0 10 00    	mov    %dl,0x10d000(%eax)
  100525:	eb 2a                	jmp    100551 <readline+0xd0>
  100527:	80 7d f3 0a          	cmpb   $0xa,-0xd(%ebp)
  10052b:	74 06                	je     100533 <readline+0xb2>
  10052d:	80 7d f3 0d          	cmpb   $0xd,-0xd(%ebp)
  100531:	75 1e                	jne    100551 <readline+0xd0>
  100533:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  10053a:	e8 28 ff ff ff       	call   100467 <putchar>
  10053f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100542:	05 00 d0 10 00       	add    $0x10d000,%eax
  100547:	c6 00 00             	movb   $0x0,(%eax)
  10054a:	b8 00 d0 10 00       	mov    $0x10d000,%eax
  10054f:	eb 05                	jmp    100556 <readline+0xd5>
  100551:	e9 51 ff ff ff       	jmp    1004a7 <readline+0x26>
  100556:	c9                   	leave  
  100557:	c3                   	ret    

00100558 <delay>:
  100558:	55                   	push   %ebp
  100559:	89 e5                	mov    %esp,%ebp
  10055b:	83 ec 18             	sub    $0x18,%esp
  10055e:	c7 04 24 84 00 00 00 	movl   $0x84,(%esp)
  100565:	e8 81 30 00 00       	call   1035eb <inb>
  10056a:	c7 04 24 84 00 00 00 	movl   $0x84,(%esp)
  100571:	e8 75 30 00 00       	call   1035eb <inb>
  100576:	c7 04 24 84 00 00 00 	movl   $0x84,(%esp)
  10057d:	e8 69 30 00 00       	call   1035eb <inb>
  100582:	c7 04 24 84 00 00 00 	movl   $0x84,(%esp)
  100589:	e8 5d 30 00 00       	call   1035eb <inb>
  10058e:	c9                   	leave  
  10058f:	c3                   	ret    

00100590 <serial_proc_data>:
  100590:	55                   	push   %ebp
  100591:	89 e5                	mov    %esp,%ebp
  100593:	83 ec 18             	sub    $0x18,%esp
  100596:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
  10059d:	e8 49 30 00 00       	call   1035eb <inb>
  1005a2:	0f b6 c0             	movzbl %al,%eax
  1005a5:	83 e0 01             	and    $0x1,%eax
  1005a8:	85 c0                	test   %eax,%eax
  1005aa:	75 07                	jne    1005b3 <serial_proc_data+0x23>
  1005ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1005b1:	eb 0f                	jmp    1005c2 <serial_proc_data+0x32>
  1005b3:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
  1005ba:	e8 2c 30 00 00       	call   1035eb <inb>
  1005bf:	0f b6 c0             	movzbl %al,%eax
  1005c2:	c9                   	leave  
  1005c3:	c3                   	ret    

001005c4 <serial_intr>:
  1005c4:	55                   	push   %ebp
  1005c5:	89 e5                	mov    %esp,%ebp
  1005c7:	83 ec 18             	sub    $0x18,%esp
  1005ca:	0f b6 05 a8 e6 90 00 	movzbl 0x90e6a8,%eax
  1005d1:	84 c0                	test   %al,%al
  1005d3:	74 0c                	je     1005e1 <serial_intr+0x1d>
  1005d5:	c7 04 24 90 05 10 00 	movl   $0x100590,(%esp)
  1005dc:	e8 9d fd ff ff       	call   10037e <cons_intr>
  1005e1:	c9                   	leave  
  1005e2:	c3                   	ret    

001005e3 <serial_reformatnewline>:
  1005e3:	55                   	push   %ebp
  1005e4:	89 e5                	mov    %esp,%ebp
  1005e6:	83 ec 28             	sub    $0x28,%esp
  1005e9:	c7 45 f4 0d 00 00 00 	movl   $0xd,-0xc(%ebp)
  1005f0:	c7 45 f0 0a 00 00 00 	movl   $0xa,-0x10(%ebp)
  1005f7:	8b 45 08             	mov    0x8(%ebp),%eax
  1005fa:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  1005fd:	75 31                	jne    100630 <serial_reformatnewline+0x4d>
  1005ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100602:	0f b6 c0             	movzbl %al,%eax
  100605:	89 44 24 04          	mov    %eax,0x4(%esp)
  100609:	8b 45 0c             	mov    0xc(%ebp),%eax
  10060c:	89 04 24             	mov    %eax,(%esp)
  10060f:	e8 11 30 00 00       	call   103625 <outb>
  100614:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100617:	0f b6 c0             	movzbl %al,%eax
  10061a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10061e:	8b 45 0c             	mov    0xc(%ebp),%eax
  100621:	89 04 24             	mov    %eax,(%esp)
  100624:	e8 fc 2f 00 00       	call   103625 <outb>
  100629:	b8 01 00 00 00       	mov    $0x1,%eax
  10062e:	eb 05                	jmp    100635 <serial_reformatnewline+0x52>
  100630:	b8 00 00 00 00       	mov    $0x0,%eax
  100635:	c9                   	leave  
  100636:	c3                   	ret    

00100637 <serial_putc>:
  100637:	55                   	push   %ebp
  100638:	89 e5                	mov    %esp,%ebp
  10063a:	83 ec 28             	sub    $0x28,%esp
  10063d:	8b 45 08             	mov    0x8(%ebp),%eax
  100640:	88 45 e4             	mov    %al,-0x1c(%ebp)
  100643:	0f b6 05 a8 e6 90 00 	movzbl 0x90e6a8,%eax
  10064a:	84 c0                	test   %al,%al
  10064c:	75 02                	jne    100650 <serial_putc+0x19>
  10064e:	eb 60                	jmp    1006b0 <serial_putc+0x79>
  100650:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100657:	eb 09                	jmp    100662 <serial_putc+0x2b>
  100659:	e8 fa fe ff ff       	call   100558 <delay>
  10065e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100662:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
  100669:	e8 7d 2f 00 00       	call   1035eb <inb>
  10066e:	0f b6 c0             	movzbl %al,%eax
  100671:	83 e0 20             	and    $0x20,%eax
  100674:	85 c0                	test   %eax,%eax
  100676:	75 09                	jne    100681 <serial_putc+0x4a>
  100678:	81 7d f4 ff 31 00 00 	cmpl   $0x31ff,-0xc(%ebp)
  10067f:	7e d8                	jle    100659 <serial_putc+0x22>
  100681:	0f be 45 e4          	movsbl -0x1c(%ebp),%eax
  100685:	c7 44 24 04 f8 03 00 	movl   $0x3f8,0x4(%esp)
  10068c:	00 
  10068d:	89 04 24             	mov    %eax,(%esp)
  100690:	e8 4e ff ff ff       	call   1005e3 <serial_reformatnewline>
  100695:	85 c0                	test   %eax,%eax
  100697:	75 17                	jne    1006b0 <serial_putc+0x79>
  100699:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
  10069d:	0f b6 c0             	movzbl %al,%eax
  1006a0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1006a4:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
  1006ab:	e8 75 2f 00 00       	call   103625 <outb>
  1006b0:	c9                   	leave  
  1006b1:	c3                   	ret    

001006b2 <serial_init>:
  1006b2:	55                   	push   %ebp
  1006b3:	89 e5                	mov    %esp,%ebp
  1006b5:	83 ec 18             	sub    $0x18,%esp
  1006b8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1006bf:	00 
  1006c0:	c7 04 24 f9 03 00 00 	movl   $0x3f9,(%esp)
  1006c7:	e8 59 2f 00 00       	call   103625 <outb>
  1006cc:	c7 44 24 04 80 00 00 	movl   $0x80,0x4(%esp)
  1006d3:	00 
  1006d4:	c7 04 24 fb 03 00 00 	movl   $0x3fb,(%esp)
  1006db:	e8 45 2f 00 00       	call   103625 <outb>
  1006e0:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  1006e7:	00 
  1006e8:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
  1006ef:	e8 31 2f 00 00       	call   103625 <outb>
  1006f4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1006fb:	00 
  1006fc:	c7 04 24 f9 03 00 00 	movl   $0x3f9,(%esp)
  100703:	e8 1d 2f 00 00       	call   103625 <outb>
  100708:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
  10070f:	00 
  100710:	c7 04 24 fb 03 00 00 	movl   $0x3fb,(%esp)
  100717:	e8 09 2f 00 00       	call   103625 <outb>
  10071c:	c7 44 24 04 c7 00 00 	movl   $0xc7,0x4(%esp)
  100723:	00 
  100724:	c7 04 24 fa 03 00 00 	movl   $0x3fa,(%esp)
  10072b:	e8 f5 2e 00 00       	call   103625 <outb>
  100730:	c7 44 24 04 0b 00 00 	movl   $0xb,0x4(%esp)
  100737:	00 
  100738:	c7 04 24 fc 03 00 00 	movl   $0x3fc,(%esp)
  10073f:	e8 e1 2e 00 00       	call   103625 <outb>
  100744:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
  10074b:	e8 9b 2e 00 00       	call   1035eb <inb>
  100750:	3c ff                	cmp    $0xff,%al
  100752:	0f 95 c0             	setne  %al
  100755:	a2 a8 e6 90 00       	mov    %al,0x90e6a8
  10075a:	c7 04 24 fa 03 00 00 	movl   $0x3fa,(%esp)
  100761:	e8 85 2e 00 00       	call   1035eb <inb>
  100766:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
  10076d:	e8 79 2e 00 00       	call   1035eb <inb>
  100772:	c9                   	leave  
  100773:	c3                   	ret    

00100774 <serial_intenable>:
  100774:	55                   	push   %ebp
  100775:	89 e5                	mov    %esp,%ebp
  100777:	83 ec 18             	sub    $0x18,%esp
  10077a:	0f b6 05 a8 e6 90 00 	movzbl 0x90e6a8,%eax
  100781:	84 c0                	test   %al,%al
  100783:	74 19                	je     10079e <serial_intenable+0x2a>
  100785:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  10078c:	00 
  10078d:	c7 04 24 f9 03 00 00 	movl   $0x3f9,(%esp)
  100794:	e8 8c 2e 00 00       	call   103625 <outb>
  100799:	e8 26 fe ff ff       	call   1005c4 <serial_intr>
  10079e:	c9                   	leave  
  10079f:	c3                   	ret    

001007a0 <kbd_proc_data>:
  1007a0:	55                   	push   %ebp
  1007a1:	89 e5                	mov    %esp,%ebp
  1007a3:	83 ec 28             	sub    $0x28,%esp
  1007a6:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
  1007ad:	e8 39 2e 00 00       	call   1035eb <inb>
  1007b2:	83 e0 01             	and    $0x1,%eax
  1007b5:	85 c0                	test   %eax,%eax
  1007b7:	75 0a                	jne    1007c3 <kbd_proc_data+0x23>
  1007b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1007be:	e9 52 01 00 00       	jmp    100915 <kbd_proc_data+0x175>
  1007c3:	c7 04 24 60 00 00 00 	movl   $0x60,(%esp)
  1007ca:	e8 1c 2e 00 00       	call   1035eb <inb>
  1007cf:	88 45 f3             	mov    %al,-0xd(%ebp)
  1007d2:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  1007d6:	75 17                	jne    1007ef <kbd_proc_data+0x4f>
  1007d8:	a1 00 d4 10 00       	mov    0x10d400,%eax
  1007dd:	83 c8 40             	or     $0x40,%eax
  1007e0:	a3 00 d4 10 00       	mov    %eax,0x10d400
  1007e5:	b8 00 00 00 00       	mov    $0x0,%eax
  1007ea:	e9 26 01 00 00       	jmp    100915 <kbd_proc_data+0x175>
  1007ef:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1007f3:	84 c0                	test   %al,%al
  1007f5:	79 47                	jns    10083e <kbd_proc_data+0x9e>
  1007f7:	a1 00 d4 10 00       	mov    0x10d400,%eax
  1007fc:	83 e0 40             	and    $0x40,%eax
  1007ff:	85 c0                	test   %eax,%eax
  100801:	75 09                	jne    10080c <kbd_proc_data+0x6c>
  100803:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  100807:	83 e0 7f             	and    $0x7f,%eax
  10080a:	eb 04                	jmp    100810 <kbd_proc_data+0x70>
  10080c:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  100810:	88 45 f3             	mov    %al,-0xd(%ebp)
  100813:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  100817:	0f b6 80 00 80 10 00 	movzbl 0x108000(%eax),%eax
  10081e:	83 c8 40             	or     $0x40,%eax
  100821:	0f b6 c0             	movzbl %al,%eax
  100824:	f7 d0                	not    %eax
  100826:	89 c2                	mov    %eax,%edx
  100828:	a1 00 d4 10 00       	mov    0x10d400,%eax
  10082d:	21 d0                	and    %edx,%eax
  10082f:	a3 00 d4 10 00       	mov    %eax,0x10d400
  100834:	b8 00 00 00 00       	mov    $0x0,%eax
  100839:	e9 d7 00 00 00       	jmp    100915 <kbd_proc_data+0x175>
  10083e:	a1 00 d4 10 00       	mov    0x10d400,%eax
  100843:	83 e0 40             	and    $0x40,%eax
  100846:	85 c0                	test   %eax,%eax
  100848:	74 11                	je     10085b <kbd_proc_data+0xbb>
  10084a:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
  10084e:	a1 00 d4 10 00       	mov    0x10d400,%eax
  100853:	83 e0 bf             	and    $0xffffffbf,%eax
  100856:	a3 00 d4 10 00       	mov    %eax,0x10d400
  10085b:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10085f:	0f b6 80 00 80 10 00 	movzbl 0x108000(%eax),%eax
  100866:	0f b6 d0             	movzbl %al,%edx
  100869:	a1 00 d4 10 00       	mov    0x10d400,%eax
  10086e:	09 d0                	or     %edx,%eax
  100870:	a3 00 d4 10 00       	mov    %eax,0x10d400
  100875:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  100879:	0f b6 80 00 81 10 00 	movzbl 0x108100(%eax),%eax
  100880:	0f b6 d0             	movzbl %al,%edx
  100883:	a1 00 d4 10 00       	mov    0x10d400,%eax
  100888:	31 d0                	xor    %edx,%eax
  10088a:	a3 00 d4 10 00       	mov    %eax,0x10d400
  10088f:	a1 00 d4 10 00       	mov    0x10d400,%eax
  100894:	83 e0 03             	and    $0x3,%eax
  100897:	8b 14 85 00 85 10 00 	mov    0x108500(,%eax,4),%edx
  10089e:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1008a2:	01 d0                	add    %edx,%eax
  1008a4:	0f b6 00             	movzbl (%eax),%eax
  1008a7:	0f b6 c0             	movzbl %al,%eax
  1008aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1008ad:	a1 00 d4 10 00       	mov    0x10d400,%eax
  1008b2:	83 e0 08             	and    $0x8,%eax
  1008b5:	85 c0                	test   %eax,%eax
  1008b7:	74 22                	je     1008db <kbd_proc_data+0x13b>
  1008b9:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  1008bd:	7e 0c                	jle    1008cb <kbd_proc_data+0x12b>
  1008bf:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  1008c3:	7f 06                	jg     1008cb <kbd_proc_data+0x12b>
  1008c5:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  1008c9:	eb 10                	jmp    1008db <kbd_proc_data+0x13b>
  1008cb:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  1008cf:	7e 0a                	jle    1008db <kbd_proc_data+0x13b>
  1008d1:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  1008d5:	7f 04                	jg     1008db <kbd_proc_data+0x13b>
  1008d7:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
  1008db:	a1 00 d4 10 00       	mov    0x10d400,%eax
  1008e0:	f7 d0                	not    %eax
  1008e2:	83 e0 06             	and    $0x6,%eax
  1008e5:	85 c0                	test   %eax,%eax
  1008e7:	75 29                	jne    100912 <kbd_proc_data+0x172>
  1008e9:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  1008f0:	75 20                	jne    100912 <kbd_proc_data+0x172>
  1008f2:	c7 04 24 e9 52 10 00 	movl   $0x1052e9,(%esp)
  1008f9:	e8 f3 1f 00 00       	call   1028f1 <dprintf>
  1008fe:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
  100905:	00 
  100906:	c7 04 24 92 00 00 00 	movl   $0x92,(%esp)
  10090d:	e8 13 2d 00 00       	call   103625 <outb>
  100912:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100915:	c9                   	leave  
  100916:	c3                   	ret    

00100917 <keyboard_intr>:
  100917:	55                   	push   %ebp
  100918:	89 e5                	mov    %esp,%ebp
  10091a:	83 ec 18             	sub    $0x18,%esp
  10091d:	c7 04 24 a0 07 10 00 	movl   $0x1007a0,(%esp)
  100924:	e8 55 fa ff ff       	call   10037e <cons_intr>
  100929:	c9                   	leave  
  10092a:	c3                   	ret    
  10092b:	90                   	nop

0010092c <devinit>:
  10092c:	55                   	push   %ebp
  10092d:	89 e5                	mov    %esp,%ebp
  10092f:	83 ec 18             	sub    $0x18,%esp
  100932:	e8 b1 24 00 00       	call   102de8 <seg_init>
  100937:	e8 95 2a 00 00       	call   1033d1 <enable_sse>
  10093c:	e8 0f fa ff ff       	call   100350 <cons_init>
  100941:	c7 44 24 08 f5 52 10 	movl   $0x1052f5,0x8(%esp)
  100948:	00 
  100949:	c7 44 24 04 13 00 00 	movl   $0x13,0x4(%esp)
  100950:	00 
  100951:	c7 04 24 08 53 10 00 	movl   $0x105308,(%esp)
  100958:	e8 33 1d 00 00       	call   102690 <debug_normal>
  10095d:	8b 45 08             	mov    0x8(%ebp),%eax
  100960:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100964:	c7 44 24 08 1b 53 10 	movl   $0x10531b,0x8(%esp)
  10096b:	00 
  10096c:	c7 44 24 04 14 00 00 	movl   $0x14,0x4(%esp)
  100973:	00 
  100974:	c7 04 24 08 53 10 00 	movl   $0x105308,(%esp)
  10097b:	e8 10 1d 00 00       	call   102690 <debug_normal>
  100980:	e8 52 18 00 00       	call   1021d7 <intr_init>
  100985:	8b 45 08             	mov    0x8(%ebp),%eax
  100988:	89 04 24             	mov    %eax,(%esp)
  10098b:	e8 5d 03 00 00       	call   100ced <pmmap_init>
  100990:	c9                   	leave  
  100991:	c3                   	ret    
  100992:	66 90                	xchg   %ax,%ax

00100994 <pmmap_alloc_slot>:
  100994:	55                   	push   %ebp
  100995:	89 e5                	mov    %esp,%ebp
  100997:	a1 20 de 10 00       	mov    0x10de20,%eax
  10099c:	3d 80 00 00 00       	cmp    $0x80,%eax
  1009a1:	0f 94 c0             	sete   %al
  1009a4:	0f b6 c0             	movzbl %al,%eax
  1009a7:	85 c0                	test   %eax,%eax
  1009a9:	74 07                	je     1009b2 <pmmap_alloc_slot+0x1e>
  1009ab:	b8 00 00 00 00       	mov    $0x0,%eax
  1009b0:	eb 1e                	jmp    1009d0 <pmmap_alloc_slot+0x3c>
  1009b2:	a1 20 de 10 00       	mov    0x10de20,%eax
  1009b7:	89 c2                	mov    %eax,%edx
  1009b9:	8d 42 01             	lea    0x1(%edx),%eax
  1009bc:	a3 20 de 10 00       	mov    %eax,0x10de20
  1009c1:	89 d0                	mov    %edx,%eax
  1009c3:	c1 e0 02             	shl    $0x2,%eax
  1009c6:	01 d0                	add    %edx,%eax
  1009c8:	c1 e0 02             	shl    $0x2,%eax
  1009cb:	05 20 d4 10 00       	add    $0x10d420,%eax
  1009d0:	5d                   	pop    %ebp
  1009d1:	c3                   	ret    

001009d2 <pmmap_insert>:
  1009d2:	55                   	push   %ebp
  1009d3:	89 e5                	mov    %esp,%ebp
  1009d5:	83 ec 28             	sub    $0x28,%esp
  1009d8:	e8 b7 ff ff ff       	call   100994 <pmmap_alloc_slot>
  1009dd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1009e0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  1009e4:	75 1c                	jne    100a02 <pmmap_insert+0x30>
  1009e6:	c7 44 24 08 30 53 10 	movl   $0x105330,0x8(%esp)
  1009ed:	00 
  1009ee:	c7 44 24 04 3e 00 00 	movl   $0x3e,0x4(%esp)
  1009f5:	00 
  1009f6:	c7 04 24 4d 53 10 00 	movl   $0x10534d,(%esp)
  1009fd:	e8 2f 1d 00 00       	call   102731 <debug_panic>
  100a02:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100a05:	8b 55 08             	mov    0x8(%ebp),%edx
  100a08:	89 10                	mov    %edx,(%eax)
  100a0a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100a0d:	8b 55 0c             	mov    0xc(%ebp),%edx
  100a10:	89 50 04             	mov    %edx,0x4(%eax)
  100a13:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100a16:	8b 55 10             	mov    0x10(%ebp),%edx
  100a19:	89 50 08             	mov    %edx,0x8(%eax)
  100a1c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  100a23:	a1 24 de 10 00       	mov    0x10de24,%eax
  100a28:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100a2b:	eb 1b                	jmp    100a48 <pmmap_insert+0x76>
  100a2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a30:	8b 00                	mov    (%eax),%eax
  100a32:	3b 45 08             	cmp    0x8(%ebp),%eax
  100a35:	76 02                	jbe    100a39 <pmmap_insert+0x67>
  100a37:	eb 15                	jmp    100a4e <pmmap_insert+0x7c>
  100a39:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a3c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  100a3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a42:	8b 40 0c             	mov    0xc(%eax),%eax
  100a45:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100a48:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100a4c:	75 df                	jne    100a2d <pmmap_insert+0x5b>
  100a4e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100a52:	75 16                	jne    100a6a <pmmap_insert+0x98>
  100a54:	8b 15 24 de 10 00    	mov    0x10de24,%edx
  100a5a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100a5d:	89 50 0c             	mov    %edx,0xc(%eax)
  100a60:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100a63:	a3 24 de 10 00       	mov    %eax,0x10de24
  100a68:	eb 15                	jmp    100a7f <pmmap_insert+0xad>
  100a6a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100a6d:	8b 50 0c             	mov    0xc(%eax),%edx
  100a70:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100a73:	89 50 0c             	mov    %edx,0xc(%eax)
  100a76:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100a79:	8b 55 ec             	mov    -0x14(%ebp),%edx
  100a7c:	89 50 0c             	mov    %edx,0xc(%eax)
  100a7f:	c9                   	leave  
  100a80:	c3                   	ret    

00100a81 <pmmap_merge>:
  100a81:	55                   	push   %ebp
  100a82:	89 e5                	mov    %esp,%ebp
  100a84:	83 ec 38             	sub    $0x38,%esp
  100a87:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  100a8e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  100a95:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  100a9c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  100aa3:	a1 24 de 10 00       	mov    0x10de24,%eax
  100aa8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100aab:	eb 74                	jmp    100b21 <pmmap_merge+0xa0>
  100aad:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ab0:	8b 40 0c             	mov    0xc(%eax),%eax
  100ab3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  100ab6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100aba:	75 02                	jne    100abe <pmmap_merge+0x3d>
  100abc:	eb 69                	jmp    100b27 <pmmap_merge+0xa6>
  100abe:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ac1:	8b 10                	mov    (%eax),%edx
  100ac3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100ac6:	8b 00                	mov    (%eax),%eax
  100ac8:	39 c2                	cmp    %eax,%edx
  100aca:	77 4c                	ja     100b18 <pmmap_merge+0x97>
  100acc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100acf:	8b 50 04             	mov    0x4(%eax),%edx
  100ad2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100ad5:	8b 00                	mov    (%eax),%eax
  100ad7:	39 c2                	cmp    %eax,%edx
  100ad9:	72 3d                	jb     100b18 <pmmap_merge+0x97>
  100adb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ade:	8b 50 08             	mov    0x8(%eax),%edx
  100ae1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100ae4:	8b 40 08             	mov    0x8(%eax),%eax
  100ae7:	39 c2                	cmp    %eax,%edx
  100ae9:	75 2d                	jne    100b18 <pmmap_merge+0x97>
  100aeb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100aee:	8b 50 04             	mov    0x4(%eax),%edx
  100af1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100af4:	8b 40 04             	mov    0x4(%eax),%eax
  100af7:	89 54 24 04          	mov    %edx,0x4(%esp)
  100afb:	89 04 24             	mov    %eax,(%esp)
  100afe:	e8 e9 27 00 00       	call   1032ec <max>
  100b03:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100b06:	89 42 04             	mov    %eax,0x4(%edx)
  100b09:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b0c:	8b 40 0c             	mov    0xc(%eax),%eax
  100b0f:	8b 50 0c             	mov    0xc(%eax),%edx
  100b12:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b15:	89 50 0c             	mov    %edx,0xc(%eax)
  100b18:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b1b:	8b 40 0c             	mov    0xc(%eax),%eax
  100b1e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100b21:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100b25:	75 86                	jne    100aad <pmmap_merge+0x2c>
  100b27:	a1 24 de 10 00       	mov    0x10de24,%eax
  100b2c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100b2f:	e9 d4 00 00 00       	jmp    100c08 <pmmap_merge+0x187>
  100b34:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b37:	8b 40 08             	mov    0x8(%eax),%eax
  100b3a:	83 f8 01             	cmp    $0x1,%eax
  100b3d:	74 3d                	je     100b7c <pmmap_merge+0xfb>
  100b3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b42:	8b 40 08             	mov    0x8(%eax),%eax
  100b45:	83 f8 02             	cmp    $0x2,%eax
  100b48:	74 2b                	je     100b75 <pmmap_merge+0xf4>
  100b4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b4d:	8b 40 08             	mov    0x8(%eax),%eax
  100b50:	83 f8 03             	cmp    $0x3,%eax
  100b53:	74 19                	je     100b6e <pmmap_merge+0xed>
  100b55:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b58:	8b 40 08             	mov    0x8(%eax),%eax
  100b5b:	83 f8 04             	cmp    $0x4,%eax
  100b5e:	75 07                	jne    100b67 <pmmap_merge+0xe6>
  100b60:	b8 03 00 00 00       	mov    $0x3,%eax
  100b65:	eb 1a                	jmp    100b81 <pmmap_merge+0x100>
  100b67:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100b6c:	eb 13                	jmp    100b81 <pmmap_merge+0x100>
  100b6e:	b8 02 00 00 00       	mov    $0x2,%eax
  100b73:	eb 0c                	jmp    100b81 <pmmap_merge+0x100>
  100b75:	b8 01 00 00 00       	mov    $0x1,%eax
  100b7a:	eb 05                	jmp    100b81 <pmmap_merge+0x100>
  100b7c:	b8 00 00 00 00       	mov    $0x0,%eax
  100b81:	89 45 ec             	mov    %eax,-0x14(%ebp)
  100b84:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
  100b88:	75 24                	jne    100bae <pmmap_merge+0x12d>
  100b8a:	c7 44 24 0c 5e 53 10 	movl   $0x10535e,0xc(%esp)
  100b91:	00 
  100b92:	c7 44 24 08 6f 53 10 	movl   $0x10536f,0x8(%esp)
  100b99:	00 
  100b9a:	c7 44 24 04 71 00 00 	movl   $0x71,0x4(%esp)
  100ba1:	00 
  100ba2:	c7 04 24 4d 53 10 00 	movl   $0x10534d,(%esp)
  100ba9:	e8 83 1b 00 00       	call   102731 <debug_panic>
  100bae:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100bb1:	8b 44 85 dc          	mov    -0x24(%ebp,%eax,4),%eax
  100bb5:	85 c0                	test   %eax,%eax
  100bb7:	74 1f                	je     100bd8 <pmmap_merge+0x157>
  100bb9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100bbc:	8b 44 85 dc          	mov    -0x24(%ebp,%eax,4),%eax
  100bc0:	8b 50 10             	mov    0x10(%eax),%edx
  100bc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100bc6:	89 50 10             	mov    %edx,0x10(%eax)
  100bc9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100bcc:	8b 44 85 dc          	mov    -0x24(%ebp,%eax,4),%eax
  100bd0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100bd3:	89 50 10             	mov    %edx,0x10(%eax)
  100bd6:	eb 1d                	jmp    100bf5 <pmmap_merge+0x174>
  100bd8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100bdb:	8b 14 85 28 de 10 00 	mov    0x10de28(,%eax,4),%edx
  100be2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100be5:	89 50 10             	mov    %edx,0x10(%eax)
  100be8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100beb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100bee:	89 14 85 28 de 10 00 	mov    %edx,0x10de28(,%eax,4)
  100bf5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100bf8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100bfb:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
  100bff:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c02:	8b 40 0c             	mov    0xc(%eax),%eax
  100c05:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100c08:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100c0c:	0f 85 22 ff ff ff    	jne    100b34 <pmmap_merge+0xb3>
  100c12:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100c15:	85 c0                	test   %eax,%eax
  100c17:	74 0b                	je     100c24 <pmmap_merge+0x1a3>
  100c19:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100c1c:	8b 40 04             	mov    0x4(%eax),%eax
  100c1f:	a3 38 de 10 00       	mov    %eax,0x10de38
  100c24:	c9                   	leave  
  100c25:	c3                   	ret    

00100c26 <pmmap_dump>:
  100c26:	55                   	push   %ebp
  100c27:	89 e5                	mov    %esp,%ebp
  100c29:	83 ec 28             	sub    $0x28,%esp
  100c2c:	a1 24 de 10 00       	mov    0x10de24,%eax
  100c31:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100c34:	e9 a8 00 00 00       	jmp    100ce1 <pmmap_dump+0xbb>
  100c39:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c3c:	8b 40 08             	mov    0x8(%eax),%eax
  100c3f:	83 f8 01             	cmp    $0x1,%eax
  100c42:	74 3f                	je     100c83 <pmmap_dump+0x5d>
  100c44:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c47:	8b 40 08             	mov    0x8(%eax),%eax
  100c4a:	83 f8 02             	cmp    $0x2,%eax
  100c4d:	74 2b                	je     100c7a <pmmap_dump+0x54>
  100c4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c52:	8b 40 08             	mov    0x8(%eax),%eax
  100c55:	83 f8 03             	cmp    $0x3,%eax
  100c58:	74 19                	je     100c73 <pmmap_dump+0x4d>
  100c5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c5d:	8b 40 08             	mov    0x8(%eax),%eax
  100c60:	83 f8 04             	cmp    $0x4,%eax
  100c63:	75 07                	jne    100c6c <pmmap_dump+0x46>
  100c65:	b8 8c 53 10 00       	mov    $0x10538c,%eax
  100c6a:	eb 13                	jmp    100c7f <pmmap_dump+0x59>
  100c6c:	b8 95 53 10 00       	mov    $0x105395,%eax
  100c71:	eb 0c                	jmp    100c7f <pmmap_dump+0x59>
  100c73:	b8 9d 53 10 00       	mov    $0x10539d,%eax
  100c78:	eb 05                	jmp    100c7f <pmmap_dump+0x59>
  100c7a:	b8 a7 53 10 00       	mov    $0x1053a7,%eax
  100c7f:	89 c2                	mov    %eax,%edx
  100c81:	eb 05                	jmp    100c88 <pmmap_dump+0x62>
  100c83:	ba b0 53 10 00       	mov    $0x1053b0,%edx
  100c88:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c8b:	8b 08                	mov    (%eax),%ecx
  100c8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c90:	8b 40 04             	mov    0x4(%eax),%eax
  100c93:	39 c1                	cmp    %eax,%ecx
  100c95:	75 08                	jne    100c9f <pmmap_dump+0x79>
  100c97:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c9a:	8b 40 04             	mov    0x4(%eax),%eax
  100c9d:	eb 1c                	jmp    100cbb <pmmap_dump+0x95>
  100c9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ca2:	8b 40 04             	mov    0x4(%eax),%eax
  100ca5:	83 f8 ff             	cmp    $0xffffffff,%eax
  100ca8:	75 08                	jne    100cb2 <pmmap_dump+0x8c>
  100caa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100cad:	8b 40 04             	mov    0x4(%eax),%eax
  100cb0:	eb 09                	jmp    100cbb <pmmap_dump+0x95>
  100cb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100cb5:	8b 40 04             	mov    0x4(%eax),%eax
  100cb8:	83 e8 01             	sub    $0x1,%eax
  100cbb:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  100cbe:	8b 09                	mov    (%ecx),%ecx
  100cc0:	89 54 24 0c          	mov    %edx,0xc(%esp)
  100cc4:	89 44 24 08          	mov    %eax,0x8(%esp)
  100cc8:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100ccc:	c7 04 24 b8 53 10 00 	movl   $0x1053b8,(%esp)
  100cd3:	e8 98 19 00 00       	call   102670 <debug_info>
  100cd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100cdb:	8b 40 0c             	mov    0xc(%eax),%eax
  100cde:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100ce1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100ce5:	0f 85 4e ff ff ff    	jne    100c39 <pmmap_dump+0x13>
  100ceb:	c9                   	leave  
  100cec:	c3                   	ret    

00100ced <pmmap_init>:
  100ced:	55                   	push   %ebp
  100cee:	89 e5                	mov    %esp,%ebp
  100cf0:	83 ec 38             	sub    $0x38,%esp
  100cf3:	c7 04 24 d9 53 10 00 	movl   $0x1053d9,(%esp)
  100cfa:	e8 71 19 00 00       	call   102670 <debug_info>
  100cff:	8b 45 08             	mov    0x8(%ebp),%eax
  100d02:	89 45 e8             	mov    %eax,-0x18(%ebp)
  100d05:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100d08:	8b 40 30             	mov    0x30(%eax),%eax
  100d0b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100d0e:	c7 05 24 de 10 00 00 	movl   $0x0,0x10de24
  100d15:	00 00 00 
  100d18:	c7 05 28 de 10 00 00 	movl   $0x0,0x10de28
  100d1f:	00 00 00 
  100d22:	c7 05 2c de 10 00 00 	movl   $0x0,0x10de2c
  100d29:	00 00 00 
  100d2c:	c7 05 30 de 10 00 00 	movl   $0x0,0x10de30
  100d33:	00 00 00 
  100d36:	c7 05 34 de 10 00 00 	movl   $0x0,0x10de34
  100d3d:	00 00 00 
  100d40:	eb 70                	jmp    100db2 <pmmap_init+0xc5>
  100d42:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d45:	8b 40 08             	mov    0x8(%eax),%eax
  100d48:	85 c0                	test   %eax,%eax
  100d4a:	74 02                	je     100d4e <pmmap_init+0x61>
  100d4c:	eb 5b                	jmp    100da9 <pmmap_init+0xbc>
  100d4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d51:	8b 40 04             	mov    0x4(%eax),%eax
  100d54:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  100d57:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d5a:	8b 40 10             	mov    0x10(%eax),%eax
  100d5d:	85 c0                	test   %eax,%eax
  100d5f:	75 0f                	jne    100d70 <pmmap_init+0x83>
  100d61:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d64:	8b 40 0c             	mov    0xc(%eax),%eax
  100d67:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  100d6a:	f7 d2                	not    %edx
  100d6c:	39 d0                	cmp    %edx,%eax
  100d6e:	72 09                	jb     100d79 <pmmap_init+0x8c>
  100d70:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)
  100d77:	eb 0e                	jmp    100d87 <pmmap_init+0x9a>
  100d79:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d7c:	8b 50 0c             	mov    0xc(%eax),%edx
  100d7f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100d82:	01 d0                	add    %edx,%eax
  100d84:	89 45 f0             	mov    %eax,-0x10(%ebp)
  100d87:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d8a:	8b 40 14             	mov    0x14(%eax),%eax
  100d8d:	89 45 e0             	mov    %eax,-0x20(%ebp)
  100d90:	8b 45 e0             	mov    -0x20(%ebp),%eax
  100d93:	89 44 24 08          	mov    %eax,0x8(%esp)
  100d97:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100d9a:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d9e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100da1:	89 04 24             	mov    %eax,(%esp)
  100da4:	e8 29 fc ff ff       	call   1009d2 <pmmap_insert>
  100da9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100dac:	83 c0 18             	add    $0x18,%eax
  100daf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100db2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100db5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100db8:	8b 40 30             	mov    0x30(%eax),%eax
  100dbb:	29 c2                	sub    %eax,%edx
  100dbd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100dc0:	8b 40 2c             	mov    0x2c(%eax),%eax
  100dc3:	39 c2                	cmp    %eax,%edx
  100dc5:	0f 82 77 ff ff ff    	jb     100d42 <pmmap_init+0x55>
  100dcb:	e8 b1 fc ff ff       	call   100a81 <pmmap_merge>
  100dd0:	e8 51 fe ff ff       	call   100c26 <pmmap_dump>
  100dd5:	a1 24 de 10 00       	mov    0x10de24,%eax
  100dda:	89 45 ec             	mov    %eax,-0x14(%ebp)
  100ddd:	eb 16                	jmp    100df5 <pmmap_init+0x108>
  100ddf:	a1 40 de 10 00       	mov    0x10de40,%eax
  100de4:	83 c0 01             	add    $0x1,%eax
  100de7:	a3 40 de 10 00       	mov    %eax,0x10de40
  100dec:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100def:	8b 40 0c             	mov    0xc(%eax),%eax
  100df2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  100df5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  100df9:	75 e4                	jne    100ddf <pmmap_init+0xf2>
  100dfb:	a1 38 de 10 00       	mov    0x10de38,%eax
  100e00:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  100e07:	00 
  100e08:	89 04 24             	mov    %eax,(%esp)
  100e0b:	e8 fa 24 00 00       	call   10330a <rounddown>
  100e10:	c1 e8 0c             	shr    $0xc,%eax
  100e13:	a3 3c de 10 00       	mov    %eax,0x10de3c
  100e18:	c9                   	leave  
  100e19:	c3                   	ret    

00100e1a <get_size>:
  100e1a:	55                   	push   %ebp
  100e1b:	89 e5                	mov    %esp,%ebp
  100e1d:	a1 40 de 10 00       	mov    0x10de40,%eax
  100e22:	5d                   	pop    %ebp
  100e23:	c3                   	ret    

00100e24 <get_mms>:
  100e24:	55                   	push   %ebp
  100e25:	89 e5                	mov    %esp,%ebp
  100e27:	83 ec 10             	sub    $0x10,%esp
  100e2a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  100e31:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  100e38:	a1 24 de 10 00       	mov    0x10de24,%eax
  100e3d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100e40:	eb 17                	jmp    100e59 <get_mms+0x35>
  100e42:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e45:	3b 45 08             	cmp    0x8(%ebp),%eax
  100e48:	75 02                	jne    100e4c <get_mms+0x28>
  100e4a:	eb 13                	jmp    100e5f <get_mms+0x3b>
  100e4c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  100e50:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100e53:	8b 40 0c             	mov    0xc(%eax),%eax
  100e56:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100e59:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  100e5d:	75 e3                	jne    100e42 <get_mms+0x1e>
  100e5f:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  100e63:	74 0a                	je     100e6f <get_mms+0x4b>
  100e65:	a1 40 de 10 00       	mov    0x10de40,%eax
  100e6a:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  100e6d:	75 07                	jne    100e76 <get_mms+0x52>
  100e6f:	b8 00 00 00 00       	mov    $0x0,%eax
  100e74:	eb 05                	jmp    100e7b <get_mms+0x57>
  100e76:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100e79:	8b 00                	mov    (%eax),%eax
  100e7b:	c9                   	leave  
  100e7c:	c3                   	ret    

00100e7d <get_mml>:
  100e7d:	55                   	push   %ebp
  100e7e:	89 e5                	mov    %esp,%ebp
  100e80:	83 ec 10             	sub    $0x10,%esp
  100e83:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  100e8a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  100e91:	a1 24 de 10 00       	mov    0x10de24,%eax
  100e96:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100e99:	eb 17                	jmp    100eb2 <get_mml+0x35>
  100e9b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e9e:	3b 45 08             	cmp    0x8(%ebp),%eax
  100ea1:	75 02                	jne    100ea5 <get_mml+0x28>
  100ea3:	eb 13                	jmp    100eb8 <get_mml+0x3b>
  100ea5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  100ea9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100eac:	8b 40 0c             	mov    0xc(%eax),%eax
  100eaf:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100eb2:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  100eb6:	75 e3                	jne    100e9b <get_mml+0x1e>
  100eb8:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  100ebc:	74 0a                	je     100ec8 <get_mml+0x4b>
  100ebe:	a1 40 de 10 00       	mov    0x10de40,%eax
  100ec3:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  100ec6:	75 07                	jne    100ecf <get_mml+0x52>
  100ec8:	b8 00 00 00 00       	mov    $0x0,%eax
  100ecd:	eb 0f                	jmp    100ede <get_mml+0x61>
  100ecf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100ed2:	8b 50 04             	mov    0x4(%eax),%edx
  100ed5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100ed8:	8b 00                	mov    (%eax),%eax
  100eda:	29 c2                	sub    %eax,%edx
  100edc:	89 d0                	mov    %edx,%eax
  100ede:	c9                   	leave  
  100edf:	c3                   	ret    

00100ee0 <is_usable>:
  100ee0:	55                   	push   %ebp
  100ee1:	89 e5                	mov    %esp,%ebp
  100ee3:	83 ec 10             	sub    $0x10,%esp
  100ee6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  100eed:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  100ef4:	a1 24 de 10 00       	mov    0x10de24,%eax
  100ef9:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100efc:	eb 17                	jmp    100f15 <is_usable+0x35>
  100efe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100f01:	3b 45 08             	cmp    0x8(%ebp),%eax
  100f04:	75 02                	jne    100f08 <is_usable+0x28>
  100f06:	eb 13                	jmp    100f1b <is_usable+0x3b>
  100f08:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  100f0c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100f0f:	8b 40 0c             	mov    0xc(%eax),%eax
  100f12:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100f15:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  100f19:	75 e3                	jne    100efe <is_usable+0x1e>
  100f1b:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  100f1f:	74 0a                	je     100f2b <is_usable+0x4b>
  100f21:	a1 40 de 10 00       	mov    0x10de40,%eax
  100f26:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  100f29:	75 07                	jne    100f32 <is_usable+0x52>
  100f2b:	b8 00 00 00 00       	mov    $0x0,%eax
  100f30:	eb 0f                	jmp    100f41 <is_usable+0x61>
  100f32:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100f35:	8b 40 08             	mov    0x8(%eax),%eax
  100f38:	83 f8 01             	cmp    $0x1,%eax
  100f3b:	0f 94 c0             	sete   %al
  100f3e:	0f b6 c0             	movzbl %al,%eax
  100f41:	c9                   	leave  
  100f42:	c3                   	ret    

00100f43 <set_cr3>:
  100f43:	55                   	push   %ebp
  100f44:	89 e5                	mov    %esp,%ebp
  100f46:	83 ec 18             	sub    $0x18,%esp
  100f49:	8b 45 08             	mov    0x8(%ebp),%eax
  100f4c:	89 04 24             	mov    %eax,(%esp)
  100f4f:	e8 70 26 00 00       	call   1035c4 <lcr3>
  100f54:	c9                   	leave  
  100f55:	c3                   	ret    

00100f56 <enable_paging>:
  100f56:	55                   	push   %ebp
  100f57:	89 e5                	mov    %esp,%ebp
  100f59:	83 ec 28             	sub    $0x28,%esp
  100f5c:	e8 79 26 00 00       	call   1035da <rcr4>
  100f61:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100f64:	81 4d f4 80 00 00 00 	orl    $0x80,-0xc(%ebp)
  100f6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100f6e:	89 04 24             	mov    %eax,(%esp)
  100f71:	e8 59 26 00 00       	call   1035cf <lcr4>
  100f76:	e8 27 26 00 00       	call   1035a2 <rcr0>
  100f7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  100f7e:	81 4d f0 23 00 05 80 	orl    $0x80050023,-0x10(%ebp)
  100f85:	83 65 f0 f3          	andl   $0xfffffff3,-0x10(%ebp)
  100f89:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100f8c:	89 04 24             	mov    %eax,(%esp)
  100f8f:	e8 03 26 00 00       	call   103597 <lcr0>
  100f94:	c9                   	leave  
  100f95:	c3                   	ret    
  100f96:	66 90                	xchg   %ax,%ax

00100f98 <intr_init_idt>:
  100f98:	55                   	push   %ebp
  100f99:	89 e5                	mov    %esp,%ebp
  100f9b:	83 ec 10             	sub    $0x10,%esp
  100f9e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  100fa5:	e9 b9 00 00 00       	jmp    101063 <intr_init_idt+0xcb>
  100faa:	b8 aa 23 10 00       	mov    $0x1023aa,%eax
  100faf:	89 c2                	mov    %eax,%edx
  100fb1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100fb4:	66 89 14 c5 c0 e6 90 	mov    %dx,0x90e6c0(,%eax,8)
  100fbb:	00 
  100fbc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100fbf:	66 c7 04 c5 c2 e6 90 	movw   $0x8,0x90e6c2(,%eax,8)
  100fc6:	00 08 00 
  100fc9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100fcc:	0f b6 14 c5 c4 e6 90 	movzbl 0x90e6c4(,%eax,8),%edx
  100fd3:	00 
  100fd4:	83 e2 e0             	and    $0xffffffe0,%edx
  100fd7:	88 14 c5 c4 e6 90 00 	mov    %dl,0x90e6c4(,%eax,8)
  100fde:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100fe1:	0f b6 14 c5 c4 e6 90 	movzbl 0x90e6c4(,%eax,8),%edx
  100fe8:	00 
  100fe9:	83 e2 1f             	and    $0x1f,%edx
  100fec:	88 14 c5 c4 e6 90 00 	mov    %dl,0x90e6c4(,%eax,8)
  100ff3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100ff6:	0f b6 14 c5 c5 e6 90 	movzbl 0x90e6c5(,%eax,8),%edx
  100ffd:	00 
  100ffe:	83 e2 f0             	and    $0xfffffff0,%edx
  101001:	83 ca 0e             	or     $0xe,%edx
  101004:	88 14 c5 c5 e6 90 00 	mov    %dl,0x90e6c5(,%eax,8)
  10100b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10100e:	0f b6 14 c5 c5 e6 90 	movzbl 0x90e6c5(,%eax,8),%edx
  101015:	00 
  101016:	83 e2 ef             	and    $0xffffffef,%edx
  101019:	88 14 c5 c5 e6 90 00 	mov    %dl,0x90e6c5(,%eax,8)
  101020:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101023:	0f b6 14 c5 c5 e6 90 	movzbl 0x90e6c5(,%eax,8),%edx
  10102a:	00 
  10102b:	83 e2 9f             	and    $0xffffff9f,%edx
  10102e:	88 14 c5 c5 e6 90 00 	mov    %dl,0x90e6c5(,%eax,8)
  101035:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101038:	0f b6 14 c5 c5 e6 90 	movzbl 0x90e6c5(,%eax,8),%edx
  10103f:	00 
  101040:	83 ca 80             	or     $0xffffff80,%edx
  101043:	88 14 c5 c5 e6 90 00 	mov    %dl,0x90e6c5(,%eax,8)
  10104a:	b8 aa 23 10 00       	mov    $0x1023aa,%eax
  10104f:	c1 e8 10             	shr    $0x10,%eax
  101052:	89 c2                	mov    %eax,%edx
  101054:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101057:	66 89 14 c5 c6 e6 90 	mov    %dx,0x90e6c6(,%eax,8)
  10105e:	00 
  10105f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  101063:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101066:	3d ff 00 00 00       	cmp    $0xff,%eax
  10106b:	0f 86 39 ff ff ff    	jbe    100faa <intr_init_idt+0x12>
  101071:	b8 00 22 10 00       	mov    $0x102200,%eax
  101076:	66 a3 c0 e6 90 00    	mov    %ax,0x90e6c0
  10107c:	66 c7 05 c2 e6 90 00 	movw   $0x8,0x90e6c2
  101083:	08 00 
  101085:	0f b6 05 c4 e6 90 00 	movzbl 0x90e6c4,%eax
  10108c:	83 e0 e0             	and    $0xffffffe0,%eax
  10108f:	a2 c4 e6 90 00       	mov    %al,0x90e6c4
  101094:	0f b6 05 c4 e6 90 00 	movzbl 0x90e6c4,%eax
  10109b:	83 e0 1f             	and    $0x1f,%eax
  10109e:	a2 c4 e6 90 00       	mov    %al,0x90e6c4
  1010a3:	0f b6 05 c5 e6 90 00 	movzbl 0x90e6c5,%eax
  1010aa:	83 e0 f0             	and    $0xfffffff0,%eax
  1010ad:	83 c8 0e             	or     $0xe,%eax
  1010b0:	a2 c5 e6 90 00       	mov    %al,0x90e6c5
  1010b5:	0f b6 05 c5 e6 90 00 	movzbl 0x90e6c5,%eax
  1010bc:	83 e0 ef             	and    $0xffffffef,%eax
  1010bf:	a2 c5 e6 90 00       	mov    %al,0x90e6c5
  1010c4:	0f b6 05 c5 e6 90 00 	movzbl 0x90e6c5,%eax
  1010cb:	83 e0 9f             	and    $0xffffff9f,%eax
  1010ce:	a2 c5 e6 90 00       	mov    %al,0x90e6c5
  1010d3:	0f b6 05 c5 e6 90 00 	movzbl 0x90e6c5,%eax
  1010da:	83 c8 80             	or     $0xffffff80,%eax
  1010dd:	a2 c5 e6 90 00       	mov    %al,0x90e6c5
  1010e2:	b8 00 22 10 00       	mov    $0x102200,%eax
  1010e7:	c1 e8 10             	shr    $0x10,%eax
  1010ea:	66 a3 c6 e6 90 00    	mov    %ax,0x90e6c6
  1010f0:	b8 0a 22 10 00       	mov    $0x10220a,%eax
  1010f5:	66 a3 c8 e6 90 00    	mov    %ax,0x90e6c8
  1010fb:	66 c7 05 ca e6 90 00 	movw   $0x8,0x90e6ca
  101102:	08 00 
  101104:	0f b6 05 cc e6 90 00 	movzbl 0x90e6cc,%eax
  10110b:	83 e0 e0             	and    $0xffffffe0,%eax
  10110e:	a2 cc e6 90 00       	mov    %al,0x90e6cc
  101113:	0f b6 05 cc e6 90 00 	movzbl 0x90e6cc,%eax
  10111a:	83 e0 1f             	and    $0x1f,%eax
  10111d:	a2 cc e6 90 00       	mov    %al,0x90e6cc
  101122:	0f b6 05 cd e6 90 00 	movzbl 0x90e6cd,%eax
  101129:	83 e0 f0             	and    $0xfffffff0,%eax
  10112c:	83 c8 0e             	or     $0xe,%eax
  10112f:	a2 cd e6 90 00       	mov    %al,0x90e6cd
  101134:	0f b6 05 cd e6 90 00 	movzbl 0x90e6cd,%eax
  10113b:	83 e0 ef             	and    $0xffffffef,%eax
  10113e:	a2 cd e6 90 00       	mov    %al,0x90e6cd
  101143:	0f b6 05 cd e6 90 00 	movzbl 0x90e6cd,%eax
  10114a:	83 e0 9f             	and    $0xffffff9f,%eax
  10114d:	a2 cd e6 90 00       	mov    %al,0x90e6cd
  101152:	0f b6 05 cd e6 90 00 	movzbl 0x90e6cd,%eax
  101159:	83 c8 80             	or     $0xffffff80,%eax
  10115c:	a2 cd e6 90 00       	mov    %al,0x90e6cd
  101161:	b8 0a 22 10 00       	mov    $0x10220a,%eax
  101166:	c1 e8 10             	shr    $0x10,%eax
  101169:	66 a3 ce e6 90 00    	mov    %ax,0x90e6ce
  10116f:	b8 14 22 10 00       	mov    $0x102214,%eax
  101174:	66 a3 d0 e6 90 00    	mov    %ax,0x90e6d0
  10117a:	66 c7 05 d2 e6 90 00 	movw   $0x8,0x90e6d2
  101181:	08 00 
  101183:	0f b6 05 d4 e6 90 00 	movzbl 0x90e6d4,%eax
  10118a:	83 e0 e0             	and    $0xffffffe0,%eax
  10118d:	a2 d4 e6 90 00       	mov    %al,0x90e6d4
  101192:	0f b6 05 d4 e6 90 00 	movzbl 0x90e6d4,%eax
  101199:	83 e0 1f             	and    $0x1f,%eax
  10119c:	a2 d4 e6 90 00       	mov    %al,0x90e6d4
  1011a1:	0f b6 05 d5 e6 90 00 	movzbl 0x90e6d5,%eax
  1011a8:	83 e0 f0             	and    $0xfffffff0,%eax
  1011ab:	83 c8 0e             	or     $0xe,%eax
  1011ae:	a2 d5 e6 90 00       	mov    %al,0x90e6d5
  1011b3:	0f b6 05 d5 e6 90 00 	movzbl 0x90e6d5,%eax
  1011ba:	83 e0 ef             	and    $0xffffffef,%eax
  1011bd:	a2 d5 e6 90 00       	mov    %al,0x90e6d5
  1011c2:	0f b6 05 d5 e6 90 00 	movzbl 0x90e6d5,%eax
  1011c9:	83 e0 9f             	and    $0xffffff9f,%eax
  1011cc:	a2 d5 e6 90 00       	mov    %al,0x90e6d5
  1011d1:	0f b6 05 d5 e6 90 00 	movzbl 0x90e6d5,%eax
  1011d8:	83 c8 80             	or     $0xffffff80,%eax
  1011db:	a2 d5 e6 90 00       	mov    %al,0x90e6d5
  1011e0:	b8 14 22 10 00       	mov    $0x102214,%eax
  1011e5:	c1 e8 10             	shr    $0x10,%eax
  1011e8:	66 a3 d6 e6 90 00    	mov    %ax,0x90e6d6
  1011ee:	b8 1e 22 10 00       	mov    $0x10221e,%eax
  1011f3:	66 a3 d8 e6 90 00    	mov    %ax,0x90e6d8
  1011f9:	66 c7 05 da e6 90 00 	movw   $0x8,0x90e6da
  101200:	08 00 
  101202:	0f b6 05 dc e6 90 00 	movzbl 0x90e6dc,%eax
  101209:	83 e0 e0             	and    $0xffffffe0,%eax
  10120c:	a2 dc e6 90 00       	mov    %al,0x90e6dc
  101211:	0f b6 05 dc e6 90 00 	movzbl 0x90e6dc,%eax
  101218:	83 e0 1f             	and    $0x1f,%eax
  10121b:	a2 dc e6 90 00       	mov    %al,0x90e6dc
  101220:	0f b6 05 dd e6 90 00 	movzbl 0x90e6dd,%eax
  101227:	83 e0 f0             	and    $0xfffffff0,%eax
  10122a:	83 c8 0e             	or     $0xe,%eax
  10122d:	a2 dd e6 90 00       	mov    %al,0x90e6dd
  101232:	0f b6 05 dd e6 90 00 	movzbl 0x90e6dd,%eax
  101239:	83 e0 ef             	and    $0xffffffef,%eax
  10123c:	a2 dd e6 90 00       	mov    %al,0x90e6dd
  101241:	0f b6 05 dd e6 90 00 	movzbl 0x90e6dd,%eax
  101248:	83 c8 60             	or     $0x60,%eax
  10124b:	a2 dd e6 90 00       	mov    %al,0x90e6dd
  101250:	0f b6 05 dd e6 90 00 	movzbl 0x90e6dd,%eax
  101257:	83 c8 80             	or     $0xffffff80,%eax
  10125a:	a2 dd e6 90 00       	mov    %al,0x90e6dd
  10125f:	b8 1e 22 10 00       	mov    $0x10221e,%eax
  101264:	c1 e8 10             	shr    $0x10,%eax
  101267:	66 a3 de e6 90 00    	mov    %ax,0x90e6de
  10126d:	b8 28 22 10 00       	mov    $0x102228,%eax
  101272:	66 a3 e0 e6 90 00    	mov    %ax,0x90e6e0
  101278:	66 c7 05 e2 e6 90 00 	movw   $0x8,0x90e6e2
  10127f:	08 00 
  101281:	0f b6 05 e4 e6 90 00 	movzbl 0x90e6e4,%eax
  101288:	83 e0 e0             	and    $0xffffffe0,%eax
  10128b:	a2 e4 e6 90 00       	mov    %al,0x90e6e4
  101290:	0f b6 05 e4 e6 90 00 	movzbl 0x90e6e4,%eax
  101297:	83 e0 1f             	and    $0x1f,%eax
  10129a:	a2 e4 e6 90 00       	mov    %al,0x90e6e4
  10129f:	0f b6 05 e5 e6 90 00 	movzbl 0x90e6e5,%eax
  1012a6:	83 e0 f0             	and    $0xfffffff0,%eax
  1012a9:	83 c8 0e             	or     $0xe,%eax
  1012ac:	a2 e5 e6 90 00       	mov    %al,0x90e6e5
  1012b1:	0f b6 05 e5 e6 90 00 	movzbl 0x90e6e5,%eax
  1012b8:	83 e0 ef             	and    $0xffffffef,%eax
  1012bb:	a2 e5 e6 90 00       	mov    %al,0x90e6e5
  1012c0:	0f b6 05 e5 e6 90 00 	movzbl 0x90e6e5,%eax
  1012c7:	83 c8 60             	or     $0x60,%eax
  1012ca:	a2 e5 e6 90 00       	mov    %al,0x90e6e5
  1012cf:	0f b6 05 e5 e6 90 00 	movzbl 0x90e6e5,%eax
  1012d6:	83 c8 80             	or     $0xffffff80,%eax
  1012d9:	a2 e5 e6 90 00       	mov    %al,0x90e6e5
  1012de:	b8 28 22 10 00       	mov    $0x102228,%eax
  1012e3:	c1 e8 10             	shr    $0x10,%eax
  1012e6:	66 a3 e6 e6 90 00    	mov    %ax,0x90e6e6
  1012ec:	b8 32 22 10 00       	mov    $0x102232,%eax
  1012f1:	66 a3 e8 e6 90 00    	mov    %ax,0x90e6e8
  1012f7:	66 c7 05 ea e6 90 00 	movw   $0x8,0x90e6ea
  1012fe:	08 00 
  101300:	0f b6 05 ec e6 90 00 	movzbl 0x90e6ec,%eax
  101307:	83 e0 e0             	and    $0xffffffe0,%eax
  10130a:	a2 ec e6 90 00       	mov    %al,0x90e6ec
  10130f:	0f b6 05 ec e6 90 00 	movzbl 0x90e6ec,%eax
  101316:	83 e0 1f             	and    $0x1f,%eax
  101319:	a2 ec e6 90 00       	mov    %al,0x90e6ec
  10131e:	0f b6 05 ed e6 90 00 	movzbl 0x90e6ed,%eax
  101325:	83 e0 f0             	and    $0xfffffff0,%eax
  101328:	83 c8 0e             	or     $0xe,%eax
  10132b:	a2 ed e6 90 00       	mov    %al,0x90e6ed
  101330:	0f b6 05 ed e6 90 00 	movzbl 0x90e6ed,%eax
  101337:	83 e0 ef             	and    $0xffffffef,%eax
  10133a:	a2 ed e6 90 00       	mov    %al,0x90e6ed
  10133f:	0f b6 05 ed e6 90 00 	movzbl 0x90e6ed,%eax
  101346:	83 e0 9f             	and    $0xffffff9f,%eax
  101349:	a2 ed e6 90 00       	mov    %al,0x90e6ed
  10134e:	0f b6 05 ed e6 90 00 	movzbl 0x90e6ed,%eax
  101355:	83 c8 80             	or     $0xffffff80,%eax
  101358:	a2 ed e6 90 00       	mov    %al,0x90e6ed
  10135d:	b8 32 22 10 00       	mov    $0x102232,%eax
  101362:	c1 e8 10             	shr    $0x10,%eax
  101365:	66 a3 ee e6 90 00    	mov    %ax,0x90e6ee
  10136b:	b8 3c 22 10 00       	mov    $0x10223c,%eax
  101370:	66 a3 f0 e6 90 00    	mov    %ax,0x90e6f0
  101376:	66 c7 05 f2 e6 90 00 	movw   $0x8,0x90e6f2
  10137d:	08 00 
  10137f:	0f b6 05 f4 e6 90 00 	movzbl 0x90e6f4,%eax
  101386:	83 e0 e0             	and    $0xffffffe0,%eax
  101389:	a2 f4 e6 90 00       	mov    %al,0x90e6f4
  10138e:	0f b6 05 f4 e6 90 00 	movzbl 0x90e6f4,%eax
  101395:	83 e0 1f             	and    $0x1f,%eax
  101398:	a2 f4 e6 90 00       	mov    %al,0x90e6f4
  10139d:	0f b6 05 f5 e6 90 00 	movzbl 0x90e6f5,%eax
  1013a4:	83 e0 f0             	and    $0xfffffff0,%eax
  1013a7:	83 c8 0e             	or     $0xe,%eax
  1013aa:	a2 f5 e6 90 00       	mov    %al,0x90e6f5
  1013af:	0f b6 05 f5 e6 90 00 	movzbl 0x90e6f5,%eax
  1013b6:	83 e0 ef             	and    $0xffffffef,%eax
  1013b9:	a2 f5 e6 90 00       	mov    %al,0x90e6f5
  1013be:	0f b6 05 f5 e6 90 00 	movzbl 0x90e6f5,%eax
  1013c5:	83 e0 9f             	and    $0xffffff9f,%eax
  1013c8:	a2 f5 e6 90 00       	mov    %al,0x90e6f5
  1013cd:	0f b6 05 f5 e6 90 00 	movzbl 0x90e6f5,%eax
  1013d4:	83 c8 80             	or     $0xffffff80,%eax
  1013d7:	a2 f5 e6 90 00       	mov    %al,0x90e6f5
  1013dc:	b8 3c 22 10 00       	mov    $0x10223c,%eax
  1013e1:	c1 e8 10             	shr    $0x10,%eax
  1013e4:	66 a3 f6 e6 90 00    	mov    %ax,0x90e6f6
  1013ea:	b8 46 22 10 00       	mov    $0x102246,%eax
  1013ef:	66 a3 f8 e6 90 00    	mov    %ax,0x90e6f8
  1013f5:	66 c7 05 fa e6 90 00 	movw   $0x8,0x90e6fa
  1013fc:	08 00 
  1013fe:	0f b6 05 fc e6 90 00 	movzbl 0x90e6fc,%eax
  101405:	83 e0 e0             	and    $0xffffffe0,%eax
  101408:	a2 fc e6 90 00       	mov    %al,0x90e6fc
  10140d:	0f b6 05 fc e6 90 00 	movzbl 0x90e6fc,%eax
  101414:	83 e0 1f             	and    $0x1f,%eax
  101417:	a2 fc e6 90 00       	mov    %al,0x90e6fc
  10141c:	0f b6 05 fd e6 90 00 	movzbl 0x90e6fd,%eax
  101423:	83 e0 f0             	and    $0xfffffff0,%eax
  101426:	83 c8 0e             	or     $0xe,%eax
  101429:	a2 fd e6 90 00       	mov    %al,0x90e6fd
  10142e:	0f b6 05 fd e6 90 00 	movzbl 0x90e6fd,%eax
  101435:	83 e0 ef             	and    $0xffffffef,%eax
  101438:	a2 fd e6 90 00       	mov    %al,0x90e6fd
  10143d:	0f b6 05 fd e6 90 00 	movzbl 0x90e6fd,%eax
  101444:	83 e0 9f             	and    $0xffffff9f,%eax
  101447:	a2 fd e6 90 00       	mov    %al,0x90e6fd
  10144c:	0f b6 05 fd e6 90 00 	movzbl 0x90e6fd,%eax
  101453:	83 c8 80             	or     $0xffffff80,%eax
  101456:	a2 fd e6 90 00       	mov    %al,0x90e6fd
  10145b:	b8 46 22 10 00       	mov    $0x102246,%eax
  101460:	c1 e8 10             	shr    $0x10,%eax
  101463:	66 a3 fe e6 90 00    	mov    %ax,0x90e6fe
  101469:	b8 50 22 10 00       	mov    $0x102250,%eax
  10146e:	66 a3 00 e7 90 00    	mov    %ax,0x90e700
  101474:	66 c7 05 02 e7 90 00 	movw   $0x8,0x90e702
  10147b:	08 00 
  10147d:	0f b6 05 04 e7 90 00 	movzbl 0x90e704,%eax
  101484:	83 e0 e0             	and    $0xffffffe0,%eax
  101487:	a2 04 e7 90 00       	mov    %al,0x90e704
  10148c:	0f b6 05 04 e7 90 00 	movzbl 0x90e704,%eax
  101493:	83 e0 1f             	and    $0x1f,%eax
  101496:	a2 04 e7 90 00       	mov    %al,0x90e704
  10149b:	0f b6 05 05 e7 90 00 	movzbl 0x90e705,%eax
  1014a2:	83 e0 f0             	and    $0xfffffff0,%eax
  1014a5:	83 c8 0e             	or     $0xe,%eax
  1014a8:	a2 05 e7 90 00       	mov    %al,0x90e705
  1014ad:	0f b6 05 05 e7 90 00 	movzbl 0x90e705,%eax
  1014b4:	83 e0 ef             	and    $0xffffffef,%eax
  1014b7:	a2 05 e7 90 00       	mov    %al,0x90e705
  1014bc:	0f b6 05 05 e7 90 00 	movzbl 0x90e705,%eax
  1014c3:	83 e0 9f             	and    $0xffffff9f,%eax
  1014c6:	a2 05 e7 90 00       	mov    %al,0x90e705
  1014cb:	0f b6 05 05 e7 90 00 	movzbl 0x90e705,%eax
  1014d2:	83 c8 80             	or     $0xffffff80,%eax
  1014d5:	a2 05 e7 90 00       	mov    %al,0x90e705
  1014da:	b8 50 22 10 00       	mov    $0x102250,%eax
  1014df:	c1 e8 10             	shr    $0x10,%eax
  1014e2:	66 a3 06 e7 90 00    	mov    %ax,0x90e706
  1014e8:	b8 62 22 10 00       	mov    $0x102262,%eax
  1014ed:	66 a3 10 e7 90 00    	mov    %ax,0x90e710
  1014f3:	66 c7 05 12 e7 90 00 	movw   $0x8,0x90e712
  1014fa:	08 00 
  1014fc:	0f b6 05 14 e7 90 00 	movzbl 0x90e714,%eax
  101503:	83 e0 e0             	and    $0xffffffe0,%eax
  101506:	a2 14 e7 90 00       	mov    %al,0x90e714
  10150b:	0f b6 05 14 e7 90 00 	movzbl 0x90e714,%eax
  101512:	83 e0 1f             	and    $0x1f,%eax
  101515:	a2 14 e7 90 00       	mov    %al,0x90e714
  10151a:	0f b6 05 15 e7 90 00 	movzbl 0x90e715,%eax
  101521:	83 e0 f0             	and    $0xfffffff0,%eax
  101524:	83 c8 0e             	or     $0xe,%eax
  101527:	a2 15 e7 90 00       	mov    %al,0x90e715
  10152c:	0f b6 05 15 e7 90 00 	movzbl 0x90e715,%eax
  101533:	83 e0 ef             	and    $0xffffffef,%eax
  101536:	a2 15 e7 90 00       	mov    %al,0x90e715
  10153b:	0f b6 05 15 e7 90 00 	movzbl 0x90e715,%eax
  101542:	83 e0 9f             	and    $0xffffff9f,%eax
  101545:	a2 15 e7 90 00       	mov    %al,0x90e715
  10154a:	0f b6 05 15 e7 90 00 	movzbl 0x90e715,%eax
  101551:	83 c8 80             	or     $0xffffff80,%eax
  101554:	a2 15 e7 90 00       	mov    %al,0x90e715
  101559:	b8 62 22 10 00       	mov    $0x102262,%eax
  10155e:	c1 e8 10             	shr    $0x10,%eax
  101561:	66 a3 16 e7 90 00    	mov    %ax,0x90e716
  101567:	b8 6a 22 10 00       	mov    $0x10226a,%eax
  10156c:	66 a3 18 e7 90 00    	mov    %ax,0x90e718
  101572:	66 c7 05 1a e7 90 00 	movw   $0x8,0x90e71a
  101579:	08 00 
  10157b:	0f b6 05 1c e7 90 00 	movzbl 0x90e71c,%eax
  101582:	83 e0 e0             	and    $0xffffffe0,%eax
  101585:	a2 1c e7 90 00       	mov    %al,0x90e71c
  10158a:	0f b6 05 1c e7 90 00 	movzbl 0x90e71c,%eax
  101591:	83 e0 1f             	and    $0x1f,%eax
  101594:	a2 1c e7 90 00       	mov    %al,0x90e71c
  101599:	0f b6 05 1d e7 90 00 	movzbl 0x90e71d,%eax
  1015a0:	83 e0 f0             	and    $0xfffffff0,%eax
  1015a3:	83 c8 0e             	or     $0xe,%eax
  1015a6:	a2 1d e7 90 00       	mov    %al,0x90e71d
  1015ab:	0f b6 05 1d e7 90 00 	movzbl 0x90e71d,%eax
  1015b2:	83 e0 ef             	and    $0xffffffef,%eax
  1015b5:	a2 1d e7 90 00       	mov    %al,0x90e71d
  1015ba:	0f b6 05 1d e7 90 00 	movzbl 0x90e71d,%eax
  1015c1:	83 e0 9f             	and    $0xffffff9f,%eax
  1015c4:	a2 1d e7 90 00       	mov    %al,0x90e71d
  1015c9:	0f b6 05 1d e7 90 00 	movzbl 0x90e71d,%eax
  1015d0:	83 c8 80             	or     $0xffffff80,%eax
  1015d3:	a2 1d e7 90 00       	mov    %al,0x90e71d
  1015d8:	b8 6a 22 10 00       	mov    $0x10226a,%eax
  1015dd:	c1 e8 10             	shr    $0x10,%eax
  1015e0:	66 a3 1e e7 90 00    	mov    %ax,0x90e71e
  1015e6:	b8 72 22 10 00       	mov    $0x102272,%eax
  1015eb:	66 a3 20 e7 90 00    	mov    %ax,0x90e720
  1015f1:	66 c7 05 22 e7 90 00 	movw   $0x8,0x90e722
  1015f8:	08 00 
  1015fa:	0f b6 05 24 e7 90 00 	movzbl 0x90e724,%eax
  101601:	83 e0 e0             	and    $0xffffffe0,%eax
  101604:	a2 24 e7 90 00       	mov    %al,0x90e724
  101609:	0f b6 05 24 e7 90 00 	movzbl 0x90e724,%eax
  101610:	83 e0 1f             	and    $0x1f,%eax
  101613:	a2 24 e7 90 00       	mov    %al,0x90e724
  101618:	0f b6 05 25 e7 90 00 	movzbl 0x90e725,%eax
  10161f:	83 e0 f0             	and    $0xfffffff0,%eax
  101622:	83 c8 0e             	or     $0xe,%eax
  101625:	a2 25 e7 90 00       	mov    %al,0x90e725
  10162a:	0f b6 05 25 e7 90 00 	movzbl 0x90e725,%eax
  101631:	83 e0 ef             	and    $0xffffffef,%eax
  101634:	a2 25 e7 90 00       	mov    %al,0x90e725
  101639:	0f b6 05 25 e7 90 00 	movzbl 0x90e725,%eax
  101640:	83 e0 9f             	and    $0xffffff9f,%eax
  101643:	a2 25 e7 90 00       	mov    %al,0x90e725
  101648:	0f b6 05 25 e7 90 00 	movzbl 0x90e725,%eax
  10164f:	83 c8 80             	or     $0xffffff80,%eax
  101652:	a2 25 e7 90 00       	mov    %al,0x90e725
  101657:	b8 72 22 10 00       	mov    $0x102272,%eax
  10165c:	c1 e8 10             	shr    $0x10,%eax
  10165f:	66 a3 26 e7 90 00    	mov    %ax,0x90e726
  101665:	b8 7a 22 10 00       	mov    $0x10227a,%eax
  10166a:	66 a3 28 e7 90 00    	mov    %ax,0x90e728
  101670:	66 c7 05 2a e7 90 00 	movw   $0x8,0x90e72a
  101677:	08 00 
  101679:	0f b6 05 2c e7 90 00 	movzbl 0x90e72c,%eax
  101680:	83 e0 e0             	and    $0xffffffe0,%eax
  101683:	a2 2c e7 90 00       	mov    %al,0x90e72c
  101688:	0f b6 05 2c e7 90 00 	movzbl 0x90e72c,%eax
  10168f:	83 e0 1f             	and    $0x1f,%eax
  101692:	a2 2c e7 90 00       	mov    %al,0x90e72c
  101697:	0f b6 05 2d e7 90 00 	movzbl 0x90e72d,%eax
  10169e:	83 e0 f0             	and    $0xfffffff0,%eax
  1016a1:	83 c8 0e             	or     $0xe,%eax
  1016a4:	a2 2d e7 90 00       	mov    %al,0x90e72d
  1016a9:	0f b6 05 2d e7 90 00 	movzbl 0x90e72d,%eax
  1016b0:	83 e0 ef             	and    $0xffffffef,%eax
  1016b3:	a2 2d e7 90 00       	mov    %al,0x90e72d
  1016b8:	0f b6 05 2d e7 90 00 	movzbl 0x90e72d,%eax
  1016bf:	83 e0 9f             	and    $0xffffff9f,%eax
  1016c2:	a2 2d e7 90 00       	mov    %al,0x90e72d
  1016c7:	0f b6 05 2d e7 90 00 	movzbl 0x90e72d,%eax
  1016ce:	83 c8 80             	or     $0xffffff80,%eax
  1016d1:	a2 2d e7 90 00       	mov    %al,0x90e72d
  1016d6:	b8 7a 22 10 00       	mov    $0x10227a,%eax
  1016db:	c1 e8 10             	shr    $0x10,%eax
  1016de:	66 a3 2e e7 90 00    	mov    %ax,0x90e72e
  1016e4:	b8 82 22 10 00       	mov    $0x102282,%eax
  1016e9:	66 a3 30 e7 90 00    	mov    %ax,0x90e730
  1016ef:	66 c7 05 32 e7 90 00 	movw   $0x8,0x90e732
  1016f6:	08 00 
  1016f8:	0f b6 05 34 e7 90 00 	movzbl 0x90e734,%eax
  1016ff:	83 e0 e0             	and    $0xffffffe0,%eax
  101702:	a2 34 e7 90 00       	mov    %al,0x90e734
  101707:	0f b6 05 34 e7 90 00 	movzbl 0x90e734,%eax
  10170e:	83 e0 1f             	and    $0x1f,%eax
  101711:	a2 34 e7 90 00       	mov    %al,0x90e734
  101716:	0f b6 05 35 e7 90 00 	movzbl 0x90e735,%eax
  10171d:	83 e0 f0             	and    $0xfffffff0,%eax
  101720:	83 c8 0e             	or     $0xe,%eax
  101723:	a2 35 e7 90 00       	mov    %al,0x90e735
  101728:	0f b6 05 35 e7 90 00 	movzbl 0x90e735,%eax
  10172f:	83 e0 ef             	and    $0xffffffef,%eax
  101732:	a2 35 e7 90 00       	mov    %al,0x90e735
  101737:	0f b6 05 35 e7 90 00 	movzbl 0x90e735,%eax
  10173e:	83 e0 9f             	and    $0xffffff9f,%eax
  101741:	a2 35 e7 90 00       	mov    %al,0x90e735
  101746:	0f b6 05 35 e7 90 00 	movzbl 0x90e735,%eax
  10174d:	83 c8 80             	or     $0xffffff80,%eax
  101750:	a2 35 e7 90 00       	mov    %al,0x90e735
  101755:	b8 82 22 10 00       	mov    $0x102282,%eax
  10175a:	c1 e8 10             	shr    $0x10,%eax
  10175d:	66 a3 36 e7 90 00    	mov    %ax,0x90e736
  101763:	b8 94 22 10 00       	mov    $0x102294,%eax
  101768:	66 a3 40 e7 90 00    	mov    %ax,0x90e740
  10176e:	66 c7 05 42 e7 90 00 	movw   $0x8,0x90e742
  101775:	08 00 
  101777:	0f b6 05 44 e7 90 00 	movzbl 0x90e744,%eax
  10177e:	83 e0 e0             	and    $0xffffffe0,%eax
  101781:	a2 44 e7 90 00       	mov    %al,0x90e744
  101786:	0f b6 05 44 e7 90 00 	movzbl 0x90e744,%eax
  10178d:	83 e0 1f             	and    $0x1f,%eax
  101790:	a2 44 e7 90 00       	mov    %al,0x90e744
  101795:	0f b6 05 45 e7 90 00 	movzbl 0x90e745,%eax
  10179c:	83 e0 f0             	and    $0xfffffff0,%eax
  10179f:	83 c8 0e             	or     $0xe,%eax
  1017a2:	a2 45 e7 90 00       	mov    %al,0x90e745
  1017a7:	0f b6 05 45 e7 90 00 	movzbl 0x90e745,%eax
  1017ae:	83 e0 ef             	and    $0xffffffef,%eax
  1017b1:	a2 45 e7 90 00       	mov    %al,0x90e745
  1017b6:	0f b6 05 45 e7 90 00 	movzbl 0x90e745,%eax
  1017bd:	83 e0 9f             	and    $0xffffff9f,%eax
  1017c0:	a2 45 e7 90 00       	mov    %al,0x90e745
  1017c5:	0f b6 05 45 e7 90 00 	movzbl 0x90e745,%eax
  1017cc:	83 c8 80             	or     $0xffffff80,%eax
  1017cf:	a2 45 e7 90 00       	mov    %al,0x90e745
  1017d4:	b8 94 22 10 00       	mov    $0x102294,%eax
  1017d9:	c1 e8 10             	shr    $0x10,%eax
  1017dc:	66 a3 46 e7 90 00    	mov    %ax,0x90e746
  1017e2:	b8 9e 22 10 00       	mov    $0x10229e,%eax
  1017e7:	66 a3 48 e7 90 00    	mov    %ax,0x90e748
  1017ed:	66 c7 05 4a e7 90 00 	movw   $0x8,0x90e74a
  1017f4:	08 00 
  1017f6:	0f b6 05 4c e7 90 00 	movzbl 0x90e74c,%eax
  1017fd:	83 e0 e0             	and    $0xffffffe0,%eax
  101800:	a2 4c e7 90 00       	mov    %al,0x90e74c
  101805:	0f b6 05 4c e7 90 00 	movzbl 0x90e74c,%eax
  10180c:	83 e0 1f             	and    $0x1f,%eax
  10180f:	a2 4c e7 90 00       	mov    %al,0x90e74c
  101814:	0f b6 05 4d e7 90 00 	movzbl 0x90e74d,%eax
  10181b:	83 e0 f0             	and    $0xfffffff0,%eax
  10181e:	83 c8 0e             	or     $0xe,%eax
  101821:	a2 4d e7 90 00       	mov    %al,0x90e74d
  101826:	0f b6 05 4d e7 90 00 	movzbl 0x90e74d,%eax
  10182d:	83 e0 ef             	and    $0xffffffef,%eax
  101830:	a2 4d e7 90 00       	mov    %al,0x90e74d
  101835:	0f b6 05 4d e7 90 00 	movzbl 0x90e74d,%eax
  10183c:	83 e0 9f             	and    $0xffffff9f,%eax
  10183f:	a2 4d e7 90 00       	mov    %al,0x90e74d
  101844:	0f b6 05 4d e7 90 00 	movzbl 0x90e74d,%eax
  10184b:	83 c8 80             	or     $0xffffff80,%eax
  10184e:	a2 4d e7 90 00       	mov    %al,0x90e74d
  101853:	b8 9e 22 10 00       	mov    $0x10229e,%eax
  101858:	c1 e8 10             	shr    $0x10,%eax
  10185b:	66 a3 4e e7 90 00    	mov    %ax,0x90e74e
  101861:	b8 a6 22 10 00       	mov    $0x1022a6,%eax
  101866:	66 a3 50 e7 90 00    	mov    %ax,0x90e750
  10186c:	66 c7 05 52 e7 90 00 	movw   $0x8,0x90e752
  101873:	08 00 
  101875:	0f b6 05 54 e7 90 00 	movzbl 0x90e754,%eax
  10187c:	83 e0 e0             	and    $0xffffffe0,%eax
  10187f:	a2 54 e7 90 00       	mov    %al,0x90e754
  101884:	0f b6 05 54 e7 90 00 	movzbl 0x90e754,%eax
  10188b:	83 e0 1f             	and    $0x1f,%eax
  10188e:	a2 54 e7 90 00       	mov    %al,0x90e754
  101893:	0f b6 05 55 e7 90 00 	movzbl 0x90e755,%eax
  10189a:	83 e0 f0             	and    $0xfffffff0,%eax
  10189d:	83 c8 0e             	or     $0xe,%eax
  1018a0:	a2 55 e7 90 00       	mov    %al,0x90e755
  1018a5:	0f b6 05 55 e7 90 00 	movzbl 0x90e755,%eax
  1018ac:	83 e0 ef             	and    $0xffffffef,%eax
  1018af:	a2 55 e7 90 00       	mov    %al,0x90e755
  1018b4:	0f b6 05 55 e7 90 00 	movzbl 0x90e755,%eax
  1018bb:	83 e0 9f             	and    $0xffffff9f,%eax
  1018be:	a2 55 e7 90 00       	mov    %al,0x90e755
  1018c3:	0f b6 05 55 e7 90 00 	movzbl 0x90e755,%eax
  1018ca:	83 c8 80             	or     $0xffffff80,%eax
  1018cd:	a2 55 e7 90 00       	mov    %al,0x90e755
  1018d2:	b8 a6 22 10 00       	mov    $0x1022a6,%eax
  1018d7:	c1 e8 10             	shr    $0x10,%eax
  1018da:	66 a3 56 e7 90 00    	mov    %ax,0x90e756
  1018e0:	b8 b0 22 10 00       	mov    $0x1022b0,%eax
  1018e5:	66 a3 c0 e7 90 00    	mov    %ax,0x90e7c0
  1018eb:	66 c7 05 c2 e7 90 00 	movw   $0x8,0x90e7c2
  1018f2:	08 00 
  1018f4:	0f b6 05 c4 e7 90 00 	movzbl 0x90e7c4,%eax
  1018fb:	83 e0 e0             	and    $0xffffffe0,%eax
  1018fe:	a2 c4 e7 90 00       	mov    %al,0x90e7c4
  101903:	0f b6 05 c4 e7 90 00 	movzbl 0x90e7c4,%eax
  10190a:	83 e0 1f             	and    $0x1f,%eax
  10190d:	a2 c4 e7 90 00       	mov    %al,0x90e7c4
  101912:	0f b6 05 c5 e7 90 00 	movzbl 0x90e7c5,%eax
  101919:	83 e0 f0             	and    $0xfffffff0,%eax
  10191c:	83 c8 0e             	or     $0xe,%eax
  10191f:	a2 c5 e7 90 00       	mov    %al,0x90e7c5
  101924:	0f b6 05 c5 e7 90 00 	movzbl 0x90e7c5,%eax
  10192b:	83 e0 ef             	and    $0xffffffef,%eax
  10192e:	a2 c5 e7 90 00       	mov    %al,0x90e7c5
  101933:	0f b6 05 c5 e7 90 00 	movzbl 0x90e7c5,%eax
  10193a:	83 e0 9f             	and    $0xffffff9f,%eax
  10193d:	a2 c5 e7 90 00       	mov    %al,0x90e7c5
  101942:	0f b6 05 c5 e7 90 00 	movzbl 0x90e7c5,%eax
  101949:	83 c8 80             	or     $0xffffff80,%eax
  10194c:	a2 c5 e7 90 00       	mov    %al,0x90e7c5
  101951:	b8 b0 22 10 00       	mov    $0x1022b0,%eax
  101956:	c1 e8 10             	shr    $0x10,%eax
  101959:	66 a3 c6 e7 90 00    	mov    %ax,0x90e7c6
  10195f:	b8 ba 22 10 00       	mov    $0x1022ba,%eax
  101964:	66 a3 c8 e7 90 00    	mov    %ax,0x90e7c8
  10196a:	66 c7 05 ca e7 90 00 	movw   $0x8,0x90e7ca
  101971:	08 00 
  101973:	0f b6 05 cc e7 90 00 	movzbl 0x90e7cc,%eax
  10197a:	83 e0 e0             	and    $0xffffffe0,%eax
  10197d:	a2 cc e7 90 00       	mov    %al,0x90e7cc
  101982:	0f b6 05 cc e7 90 00 	movzbl 0x90e7cc,%eax
  101989:	83 e0 1f             	and    $0x1f,%eax
  10198c:	a2 cc e7 90 00       	mov    %al,0x90e7cc
  101991:	0f b6 05 cd e7 90 00 	movzbl 0x90e7cd,%eax
  101998:	83 e0 f0             	and    $0xfffffff0,%eax
  10199b:	83 c8 0e             	or     $0xe,%eax
  10199e:	a2 cd e7 90 00       	mov    %al,0x90e7cd
  1019a3:	0f b6 05 cd e7 90 00 	movzbl 0x90e7cd,%eax
  1019aa:	83 e0 ef             	and    $0xffffffef,%eax
  1019ad:	a2 cd e7 90 00       	mov    %al,0x90e7cd
  1019b2:	0f b6 05 cd e7 90 00 	movzbl 0x90e7cd,%eax
  1019b9:	83 e0 9f             	and    $0xffffff9f,%eax
  1019bc:	a2 cd e7 90 00       	mov    %al,0x90e7cd
  1019c1:	0f b6 05 cd e7 90 00 	movzbl 0x90e7cd,%eax
  1019c8:	83 c8 80             	or     $0xffffff80,%eax
  1019cb:	a2 cd e7 90 00       	mov    %al,0x90e7cd
  1019d0:	b8 ba 22 10 00       	mov    $0x1022ba,%eax
  1019d5:	c1 e8 10             	shr    $0x10,%eax
  1019d8:	66 a3 ce e7 90 00    	mov    %ax,0x90e7ce
  1019de:	b8 c4 22 10 00       	mov    $0x1022c4,%eax
  1019e3:	66 a3 d0 e7 90 00    	mov    %ax,0x90e7d0
  1019e9:	66 c7 05 d2 e7 90 00 	movw   $0x8,0x90e7d2
  1019f0:	08 00 
  1019f2:	0f b6 05 d4 e7 90 00 	movzbl 0x90e7d4,%eax
  1019f9:	83 e0 e0             	and    $0xffffffe0,%eax
  1019fc:	a2 d4 e7 90 00       	mov    %al,0x90e7d4
  101a01:	0f b6 05 d4 e7 90 00 	movzbl 0x90e7d4,%eax
  101a08:	83 e0 1f             	and    $0x1f,%eax
  101a0b:	a2 d4 e7 90 00       	mov    %al,0x90e7d4
  101a10:	0f b6 05 d5 e7 90 00 	movzbl 0x90e7d5,%eax
  101a17:	83 e0 f0             	and    $0xfffffff0,%eax
  101a1a:	83 c8 0e             	or     $0xe,%eax
  101a1d:	a2 d5 e7 90 00       	mov    %al,0x90e7d5
  101a22:	0f b6 05 d5 e7 90 00 	movzbl 0x90e7d5,%eax
  101a29:	83 e0 ef             	and    $0xffffffef,%eax
  101a2c:	a2 d5 e7 90 00       	mov    %al,0x90e7d5
  101a31:	0f b6 05 d5 e7 90 00 	movzbl 0x90e7d5,%eax
  101a38:	83 e0 9f             	and    $0xffffff9f,%eax
  101a3b:	a2 d5 e7 90 00       	mov    %al,0x90e7d5
  101a40:	0f b6 05 d5 e7 90 00 	movzbl 0x90e7d5,%eax
  101a47:	83 c8 80             	or     $0xffffff80,%eax
  101a4a:	a2 d5 e7 90 00       	mov    %al,0x90e7d5
  101a4f:	b8 c4 22 10 00       	mov    $0x1022c4,%eax
  101a54:	c1 e8 10             	shr    $0x10,%eax
  101a57:	66 a3 d6 e7 90 00    	mov    %ax,0x90e7d6
  101a5d:	b8 ce 22 10 00       	mov    $0x1022ce,%eax
  101a62:	66 a3 d8 e7 90 00    	mov    %ax,0x90e7d8
  101a68:	66 c7 05 da e7 90 00 	movw   $0x8,0x90e7da
  101a6f:	08 00 
  101a71:	0f b6 05 dc e7 90 00 	movzbl 0x90e7dc,%eax
  101a78:	83 e0 e0             	and    $0xffffffe0,%eax
  101a7b:	a2 dc e7 90 00       	mov    %al,0x90e7dc
  101a80:	0f b6 05 dc e7 90 00 	movzbl 0x90e7dc,%eax
  101a87:	83 e0 1f             	and    $0x1f,%eax
  101a8a:	a2 dc e7 90 00       	mov    %al,0x90e7dc
  101a8f:	0f b6 05 dd e7 90 00 	movzbl 0x90e7dd,%eax
  101a96:	83 e0 f0             	and    $0xfffffff0,%eax
  101a99:	83 c8 0e             	or     $0xe,%eax
  101a9c:	a2 dd e7 90 00       	mov    %al,0x90e7dd
  101aa1:	0f b6 05 dd e7 90 00 	movzbl 0x90e7dd,%eax
  101aa8:	83 e0 ef             	and    $0xffffffef,%eax
  101aab:	a2 dd e7 90 00       	mov    %al,0x90e7dd
  101ab0:	0f b6 05 dd e7 90 00 	movzbl 0x90e7dd,%eax
  101ab7:	83 e0 9f             	and    $0xffffff9f,%eax
  101aba:	a2 dd e7 90 00       	mov    %al,0x90e7dd
  101abf:	0f b6 05 dd e7 90 00 	movzbl 0x90e7dd,%eax
  101ac6:	83 c8 80             	or     $0xffffff80,%eax
  101ac9:	a2 dd e7 90 00       	mov    %al,0x90e7dd
  101ace:	b8 ce 22 10 00       	mov    $0x1022ce,%eax
  101ad3:	c1 e8 10             	shr    $0x10,%eax
  101ad6:	66 a3 de e7 90 00    	mov    %ax,0x90e7de
  101adc:	b8 d8 22 10 00       	mov    $0x1022d8,%eax
  101ae1:	66 a3 e0 e7 90 00    	mov    %ax,0x90e7e0
  101ae7:	66 c7 05 e2 e7 90 00 	movw   $0x8,0x90e7e2
  101aee:	08 00 
  101af0:	0f b6 05 e4 e7 90 00 	movzbl 0x90e7e4,%eax
  101af7:	83 e0 e0             	and    $0xffffffe0,%eax
  101afa:	a2 e4 e7 90 00       	mov    %al,0x90e7e4
  101aff:	0f b6 05 e4 e7 90 00 	movzbl 0x90e7e4,%eax
  101b06:	83 e0 1f             	and    $0x1f,%eax
  101b09:	a2 e4 e7 90 00       	mov    %al,0x90e7e4
  101b0e:	0f b6 05 e5 e7 90 00 	movzbl 0x90e7e5,%eax
  101b15:	83 e0 f0             	and    $0xfffffff0,%eax
  101b18:	83 c8 0e             	or     $0xe,%eax
  101b1b:	a2 e5 e7 90 00       	mov    %al,0x90e7e5
  101b20:	0f b6 05 e5 e7 90 00 	movzbl 0x90e7e5,%eax
  101b27:	83 e0 ef             	and    $0xffffffef,%eax
  101b2a:	a2 e5 e7 90 00       	mov    %al,0x90e7e5
  101b2f:	0f b6 05 e5 e7 90 00 	movzbl 0x90e7e5,%eax
  101b36:	83 e0 9f             	and    $0xffffff9f,%eax
  101b39:	a2 e5 e7 90 00       	mov    %al,0x90e7e5
  101b3e:	0f b6 05 e5 e7 90 00 	movzbl 0x90e7e5,%eax
  101b45:	83 c8 80             	or     $0xffffff80,%eax
  101b48:	a2 e5 e7 90 00       	mov    %al,0x90e7e5
  101b4d:	b8 d8 22 10 00       	mov    $0x1022d8,%eax
  101b52:	c1 e8 10             	shr    $0x10,%eax
  101b55:	66 a3 e6 e7 90 00    	mov    %ax,0x90e7e6
  101b5b:	b8 e2 22 10 00       	mov    $0x1022e2,%eax
  101b60:	66 a3 e8 e7 90 00    	mov    %ax,0x90e7e8
  101b66:	66 c7 05 ea e7 90 00 	movw   $0x8,0x90e7ea
  101b6d:	08 00 
  101b6f:	0f b6 05 ec e7 90 00 	movzbl 0x90e7ec,%eax
  101b76:	83 e0 e0             	and    $0xffffffe0,%eax
  101b79:	a2 ec e7 90 00       	mov    %al,0x90e7ec
  101b7e:	0f b6 05 ec e7 90 00 	movzbl 0x90e7ec,%eax
  101b85:	83 e0 1f             	and    $0x1f,%eax
  101b88:	a2 ec e7 90 00       	mov    %al,0x90e7ec
  101b8d:	0f b6 05 ed e7 90 00 	movzbl 0x90e7ed,%eax
  101b94:	83 e0 f0             	and    $0xfffffff0,%eax
  101b97:	83 c8 0e             	or     $0xe,%eax
  101b9a:	a2 ed e7 90 00       	mov    %al,0x90e7ed
  101b9f:	0f b6 05 ed e7 90 00 	movzbl 0x90e7ed,%eax
  101ba6:	83 e0 ef             	and    $0xffffffef,%eax
  101ba9:	a2 ed e7 90 00       	mov    %al,0x90e7ed
  101bae:	0f b6 05 ed e7 90 00 	movzbl 0x90e7ed,%eax
  101bb5:	83 e0 9f             	and    $0xffffff9f,%eax
  101bb8:	a2 ed e7 90 00       	mov    %al,0x90e7ed
  101bbd:	0f b6 05 ed e7 90 00 	movzbl 0x90e7ed,%eax
  101bc4:	83 c8 80             	or     $0xffffff80,%eax
  101bc7:	a2 ed e7 90 00       	mov    %al,0x90e7ed
  101bcc:	b8 e2 22 10 00       	mov    $0x1022e2,%eax
  101bd1:	c1 e8 10             	shr    $0x10,%eax
  101bd4:	66 a3 ee e7 90 00    	mov    %ax,0x90e7ee
  101bda:	b8 ec 22 10 00       	mov    $0x1022ec,%eax
  101bdf:	66 a3 f0 e7 90 00    	mov    %ax,0x90e7f0
  101be5:	66 c7 05 f2 e7 90 00 	movw   $0x8,0x90e7f2
  101bec:	08 00 
  101bee:	0f b6 05 f4 e7 90 00 	movzbl 0x90e7f4,%eax
  101bf5:	83 e0 e0             	and    $0xffffffe0,%eax
  101bf8:	a2 f4 e7 90 00       	mov    %al,0x90e7f4
  101bfd:	0f b6 05 f4 e7 90 00 	movzbl 0x90e7f4,%eax
  101c04:	83 e0 1f             	and    $0x1f,%eax
  101c07:	a2 f4 e7 90 00       	mov    %al,0x90e7f4
  101c0c:	0f b6 05 f5 e7 90 00 	movzbl 0x90e7f5,%eax
  101c13:	83 e0 f0             	and    $0xfffffff0,%eax
  101c16:	83 c8 0e             	or     $0xe,%eax
  101c19:	a2 f5 e7 90 00       	mov    %al,0x90e7f5
  101c1e:	0f b6 05 f5 e7 90 00 	movzbl 0x90e7f5,%eax
  101c25:	83 e0 ef             	and    $0xffffffef,%eax
  101c28:	a2 f5 e7 90 00       	mov    %al,0x90e7f5
  101c2d:	0f b6 05 f5 e7 90 00 	movzbl 0x90e7f5,%eax
  101c34:	83 e0 9f             	and    $0xffffff9f,%eax
  101c37:	a2 f5 e7 90 00       	mov    %al,0x90e7f5
  101c3c:	0f b6 05 f5 e7 90 00 	movzbl 0x90e7f5,%eax
  101c43:	83 c8 80             	or     $0xffffff80,%eax
  101c46:	a2 f5 e7 90 00       	mov    %al,0x90e7f5
  101c4b:	b8 ec 22 10 00       	mov    $0x1022ec,%eax
  101c50:	c1 e8 10             	shr    $0x10,%eax
  101c53:	66 a3 f6 e7 90 00    	mov    %ax,0x90e7f6
  101c59:	b8 f6 22 10 00       	mov    $0x1022f6,%eax
  101c5e:	66 a3 f8 e7 90 00    	mov    %ax,0x90e7f8
  101c64:	66 c7 05 fa e7 90 00 	movw   $0x8,0x90e7fa
  101c6b:	08 00 
  101c6d:	0f b6 05 fc e7 90 00 	movzbl 0x90e7fc,%eax
  101c74:	83 e0 e0             	and    $0xffffffe0,%eax
  101c77:	a2 fc e7 90 00       	mov    %al,0x90e7fc
  101c7c:	0f b6 05 fc e7 90 00 	movzbl 0x90e7fc,%eax
  101c83:	83 e0 1f             	and    $0x1f,%eax
  101c86:	a2 fc e7 90 00       	mov    %al,0x90e7fc
  101c8b:	0f b6 05 fd e7 90 00 	movzbl 0x90e7fd,%eax
  101c92:	83 e0 f0             	and    $0xfffffff0,%eax
  101c95:	83 c8 0e             	or     $0xe,%eax
  101c98:	a2 fd e7 90 00       	mov    %al,0x90e7fd
  101c9d:	0f b6 05 fd e7 90 00 	movzbl 0x90e7fd,%eax
  101ca4:	83 e0 ef             	and    $0xffffffef,%eax
  101ca7:	a2 fd e7 90 00       	mov    %al,0x90e7fd
  101cac:	0f b6 05 fd e7 90 00 	movzbl 0x90e7fd,%eax
  101cb3:	83 e0 9f             	and    $0xffffff9f,%eax
  101cb6:	a2 fd e7 90 00       	mov    %al,0x90e7fd
  101cbb:	0f b6 05 fd e7 90 00 	movzbl 0x90e7fd,%eax
  101cc2:	83 c8 80             	or     $0xffffff80,%eax
  101cc5:	a2 fd e7 90 00       	mov    %al,0x90e7fd
  101cca:	b8 f6 22 10 00       	mov    $0x1022f6,%eax
  101ccf:	c1 e8 10             	shr    $0x10,%eax
  101cd2:	66 a3 fe e7 90 00    	mov    %ax,0x90e7fe
  101cd8:	b8 00 23 10 00       	mov    $0x102300,%eax
  101cdd:	66 a3 00 e8 90 00    	mov    %ax,0x90e800
  101ce3:	66 c7 05 02 e8 90 00 	movw   $0x8,0x90e802
  101cea:	08 00 
  101cec:	0f b6 05 04 e8 90 00 	movzbl 0x90e804,%eax
  101cf3:	83 e0 e0             	and    $0xffffffe0,%eax
  101cf6:	a2 04 e8 90 00       	mov    %al,0x90e804
  101cfb:	0f b6 05 04 e8 90 00 	movzbl 0x90e804,%eax
  101d02:	83 e0 1f             	and    $0x1f,%eax
  101d05:	a2 04 e8 90 00       	mov    %al,0x90e804
  101d0a:	0f b6 05 05 e8 90 00 	movzbl 0x90e805,%eax
  101d11:	83 e0 f0             	and    $0xfffffff0,%eax
  101d14:	83 c8 0e             	or     $0xe,%eax
  101d17:	a2 05 e8 90 00       	mov    %al,0x90e805
  101d1c:	0f b6 05 05 e8 90 00 	movzbl 0x90e805,%eax
  101d23:	83 e0 ef             	and    $0xffffffef,%eax
  101d26:	a2 05 e8 90 00       	mov    %al,0x90e805
  101d2b:	0f b6 05 05 e8 90 00 	movzbl 0x90e805,%eax
  101d32:	83 e0 9f             	and    $0xffffff9f,%eax
  101d35:	a2 05 e8 90 00       	mov    %al,0x90e805
  101d3a:	0f b6 05 05 e8 90 00 	movzbl 0x90e805,%eax
  101d41:	83 c8 80             	or     $0xffffff80,%eax
  101d44:	a2 05 e8 90 00       	mov    %al,0x90e805
  101d49:	b8 00 23 10 00       	mov    $0x102300,%eax
  101d4e:	c1 e8 10             	shr    $0x10,%eax
  101d51:	66 a3 06 e8 90 00    	mov    %ax,0x90e806
  101d57:	b8 0a 23 10 00       	mov    $0x10230a,%eax
  101d5c:	66 a3 08 e8 90 00    	mov    %ax,0x90e808
  101d62:	66 c7 05 0a e8 90 00 	movw   $0x8,0x90e80a
  101d69:	08 00 
  101d6b:	0f b6 05 0c e8 90 00 	movzbl 0x90e80c,%eax
  101d72:	83 e0 e0             	and    $0xffffffe0,%eax
  101d75:	a2 0c e8 90 00       	mov    %al,0x90e80c
  101d7a:	0f b6 05 0c e8 90 00 	movzbl 0x90e80c,%eax
  101d81:	83 e0 1f             	and    $0x1f,%eax
  101d84:	a2 0c e8 90 00       	mov    %al,0x90e80c
  101d89:	0f b6 05 0d e8 90 00 	movzbl 0x90e80d,%eax
  101d90:	83 e0 f0             	and    $0xfffffff0,%eax
  101d93:	83 c8 0e             	or     $0xe,%eax
  101d96:	a2 0d e8 90 00       	mov    %al,0x90e80d
  101d9b:	0f b6 05 0d e8 90 00 	movzbl 0x90e80d,%eax
  101da2:	83 e0 ef             	and    $0xffffffef,%eax
  101da5:	a2 0d e8 90 00       	mov    %al,0x90e80d
  101daa:	0f b6 05 0d e8 90 00 	movzbl 0x90e80d,%eax
  101db1:	83 e0 9f             	and    $0xffffff9f,%eax
  101db4:	a2 0d e8 90 00       	mov    %al,0x90e80d
  101db9:	0f b6 05 0d e8 90 00 	movzbl 0x90e80d,%eax
  101dc0:	83 c8 80             	or     $0xffffff80,%eax
  101dc3:	a2 0d e8 90 00       	mov    %al,0x90e80d
  101dc8:	b8 0a 23 10 00       	mov    $0x10230a,%eax
  101dcd:	c1 e8 10             	shr    $0x10,%eax
  101dd0:	66 a3 0e e8 90 00    	mov    %ax,0x90e80e
  101dd6:	b8 14 23 10 00       	mov    $0x102314,%eax
  101ddb:	66 a3 10 e8 90 00    	mov    %ax,0x90e810
  101de1:	66 c7 05 12 e8 90 00 	movw   $0x8,0x90e812
  101de8:	08 00 
  101dea:	0f b6 05 14 e8 90 00 	movzbl 0x90e814,%eax
  101df1:	83 e0 e0             	and    $0xffffffe0,%eax
  101df4:	a2 14 e8 90 00       	mov    %al,0x90e814
  101df9:	0f b6 05 14 e8 90 00 	movzbl 0x90e814,%eax
  101e00:	83 e0 1f             	and    $0x1f,%eax
  101e03:	a2 14 e8 90 00       	mov    %al,0x90e814
  101e08:	0f b6 05 15 e8 90 00 	movzbl 0x90e815,%eax
  101e0f:	83 e0 f0             	and    $0xfffffff0,%eax
  101e12:	83 c8 0e             	or     $0xe,%eax
  101e15:	a2 15 e8 90 00       	mov    %al,0x90e815
  101e1a:	0f b6 05 15 e8 90 00 	movzbl 0x90e815,%eax
  101e21:	83 e0 ef             	and    $0xffffffef,%eax
  101e24:	a2 15 e8 90 00       	mov    %al,0x90e815
  101e29:	0f b6 05 15 e8 90 00 	movzbl 0x90e815,%eax
  101e30:	83 e0 9f             	and    $0xffffff9f,%eax
  101e33:	a2 15 e8 90 00       	mov    %al,0x90e815
  101e38:	0f b6 05 15 e8 90 00 	movzbl 0x90e815,%eax
  101e3f:	83 c8 80             	or     $0xffffff80,%eax
  101e42:	a2 15 e8 90 00       	mov    %al,0x90e815
  101e47:	b8 14 23 10 00       	mov    $0x102314,%eax
  101e4c:	c1 e8 10             	shr    $0x10,%eax
  101e4f:	66 a3 16 e8 90 00    	mov    %ax,0x90e816
  101e55:	b8 1e 23 10 00       	mov    $0x10231e,%eax
  101e5a:	66 a3 18 e8 90 00    	mov    %ax,0x90e818
  101e60:	66 c7 05 1a e8 90 00 	movw   $0x8,0x90e81a
  101e67:	08 00 
  101e69:	0f b6 05 1c e8 90 00 	movzbl 0x90e81c,%eax
  101e70:	83 e0 e0             	and    $0xffffffe0,%eax
  101e73:	a2 1c e8 90 00       	mov    %al,0x90e81c
  101e78:	0f b6 05 1c e8 90 00 	movzbl 0x90e81c,%eax
  101e7f:	83 e0 1f             	and    $0x1f,%eax
  101e82:	a2 1c e8 90 00       	mov    %al,0x90e81c
  101e87:	0f b6 05 1d e8 90 00 	movzbl 0x90e81d,%eax
  101e8e:	83 e0 f0             	and    $0xfffffff0,%eax
  101e91:	83 c8 0e             	or     $0xe,%eax
  101e94:	a2 1d e8 90 00       	mov    %al,0x90e81d
  101e99:	0f b6 05 1d e8 90 00 	movzbl 0x90e81d,%eax
  101ea0:	83 e0 ef             	and    $0xffffffef,%eax
  101ea3:	a2 1d e8 90 00       	mov    %al,0x90e81d
  101ea8:	0f b6 05 1d e8 90 00 	movzbl 0x90e81d,%eax
  101eaf:	83 e0 9f             	and    $0xffffff9f,%eax
  101eb2:	a2 1d e8 90 00       	mov    %al,0x90e81d
  101eb7:	0f b6 05 1d e8 90 00 	movzbl 0x90e81d,%eax
  101ebe:	83 c8 80             	or     $0xffffff80,%eax
  101ec1:	a2 1d e8 90 00       	mov    %al,0x90e81d
  101ec6:	b8 1e 23 10 00       	mov    $0x10231e,%eax
  101ecb:	c1 e8 10             	shr    $0x10,%eax
  101ece:	66 a3 1e e8 90 00    	mov    %ax,0x90e81e
  101ed4:	b8 28 23 10 00       	mov    $0x102328,%eax
  101ed9:	66 a3 20 e8 90 00    	mov    %ax,0x90e820
  101edf:	66 c7 05 22 e8 90 00 	movw   $0x8,0x90e822
  101ee6:	08 00 
  101ee8:	0f b6 05 24 e8 90 00 	movzbl 0x90e824,%eax
  101eef:	83 e0 e0             	and    $0xffffffe0,%eax
  101ef2:	a2 24 e8 90 00       	mov    %al,0x90e824
  101ef7:	0f b6 05 24 e8 90 00 	movzbl 0x90e824,%eax
  101efe:	83 e0 1f             	and    $0x1f,%eax
  101f01:	a2 24 e8 90 00       	mov    %al,0x90e824
  101f06:	0f b6 05 25 e8 90 00 	movzbl 0x90e825,%eax
  101f0d:	83 e0 f0             	and    $0xfffffff0,%eax
  101f10:	83 c8 0e             	or     $0xe,%eax
  101f13:	a2 25 e8 90 00       	mov    %al,0x90e825
  101f18:	0f b6 05 25 e8 90 00 	movzbl 0x90e825,%eax
  101f1f:	83 e0 ef             	and    $0xffffffef,%eax
  101f22:	a2 25 e8 90 00       	mov    %al,0x90e825
  101f27:	0f b6 05 25 e8 90 00 	movzbl 0x90e825,%eax
  101f2e:	83 e0 9f             	and    $0xffffff9f,%eax
  101f31:	a2 25 e8 90 00       	mov    %al,0x90e825
  101f36:	0f b6 05 25 e8 90 00 	movzbl 0x90e825,%eax
  101f3d:	83 c8 80             	or     $0xffffff80,%eax
  101f40:	a2 25 e8 90 00       	mov    %al,0x90e825
  101f45:	b8 28 23 10 00       	mov    $0x102328,%eax
  101f4a:	c1 e8 10             	shr    $0x10,%eax
  101f4d:	66 a3 26 e8 90 00    	mov    %ax,0x90e826
  101f53:	b8 32 23 10 00       	mov    $0x102332,%eax
  101f58:	66 a3 28 e8 90 00    	mov    %ax,0x90e828
  101f5e:	66 c7 05 2a e8 90 00 	movw   $0x8,0x90e82a
  101f65:	08 00 
  101f67:	0f b6 05 2c e8 90 00 	movzbl 0x90e82c,%eax
  101f6e:	83 e0 e0             	and    $0xffffffe0,%eax
  101f71:	a2 2c e8 90 00       	mov    %al,0x90e82c
  101f76:	0f b6 05 2c e8 90 00 	movzbl 0x90e82c,%eax
  101f7d:	83 e0 1f             	and    $0x1f,%eax
  101f80:	a2 2c e8 90 00       	mov    %al,0x90e82c
  101f85:	0f b6 05 2d e8 90 00 	movzbl 0x90e82d,%eax
  101f8c:	83 e0 f0             	and    $0xfffffff0,%eax
  101f8f:	83 c8 0e             	or     $0xe,%eax
  101f92:	a2 2d e8 90 00       	mov    %al,0x90e82d
  101f97:	0f b6 05 2d e8 90 00 	movzbl 0x90e82d,%eax
  101f9e:	83 e0 ef             	and    $0xffffffef,%eax
  101fa1:	a2 2d e8 90 00       	mov    %al,0x90e82d
  101fa6:	0f b6 05 2d e8 90 00 	movzbl 0x90e82d,%eax
  101fad:	83 e0 9f             	and    $0xffffff9f,%eax
  101fb0:	a2 2d e8 90 00       	mov    %al,0x90e82d
  101fb5:	0f b6 05 2d e8 90 00 	movzbl 0x90e82d,%eax
  101fbc:	83 c8 80             	or     $0xffffff80,%eax
  101fbf:	a2 2d e8 90 00       	mov    %al,0x90e82d
  101fc4:	b8 32 23 10 00       	mov    $0x102332,%eax
  101fc9:	c1 e8 10             	shr    $0x10,%eax
  101fcc:	66 a3 2e e8 90 00    	mov    %ax,0x90e82e
  101fd2:	b8 3c 23 10 00       	mov    $0x10233c,%eax
  101fd7:	66 a3 30 e8 90 00    	mov    %ax,0x90e830
  101fdd:	66 c7 05 32 e8 90 00 	movw   $0x8,0x90e832
  101fe4:	08 00 
  101fe6:	0f b6 05 34 e8 90 00 	movzbl 0x90e834,%eax
  101fed:	83 e0 e0             	and    $0xffffffe0,%eax
  101ff0:	a2 34 e8 90 00       	mov    %al,0x90e834
  101ff5:	0f b6 05 34 e8 90 00 	movzbl 0x90e834,%eax
  101ffc:	83 e0 1f             	and    $0x1f,%eax
  101fff:	a2 34 e8 90 00       	mov    %al,0x90e834
  102004:	0f b6 05 35 e8 90 00 	movzbl 0x90e835,%eax
  10200b:	83 e0 f0             	and    $0xfffffff0,%eax
  10200e:	83 c8 0e             	or     $0xe,%eax
  102011:	a2 35 e8 90 00       	mov    %al,0x90e835
  102016:	0f b6 05 35 e8 90 00 	movzbl 0x90e835,%eax
  10201d:	83 e0 ef             	and    $0xffffffef,%eax
  102020:	a2 35 e8 90 00       	mov    %al,0x90e835
  102025:	0f b6 05 35 e8 90 00 	movzbl 0x90e835,%eax
  10202c:	83 e0 9f             	and    $0xffffff9f,%eax
  10202f:	a2 35 e8 90 00       	mov    %al,0x90e835
  102034:	0f b6 05 35 e8 90 00 	movzbl 0x90e835,%eax
  10203b:	83 c8 80             	or     $0xffffff80,%eax
  10203e:	a2 35 e8 90 00       	mov    %al,0x90e835
  102043:	b8 3c 23 10 00       	mov    $0x10233c,%eax
  102048:	c1 e8 10             	shr    $0x10,%eax
  10204b:	66 a3 36 e8 90 00    	mov    %ax,0x90e836
  102051:	b8 46 23 10 00       	mov    $0x102346,%eax
  102056:	66 a3 38 e8 90 00    	mov    %ax,0x90e838
  10205c:	66 c7 05 3a e8 90 00 	movw   $0x8,0x90e83a
  102063:	08 00 
  102065:	0f b6 05 3c e8 90 00 	movzbl 0x90e83c,%eax
  10206c:	83 e0 e0             	and    $0xffffffe0,%eax
  10206f:	a2 3c e8 90 00       	mov    %al,0x90e83c
  102074:	0f b6 05 3c e8 90 00 	movzbl 0x90e83c,%eax
  10207b:	83 e0 1f             	and    $0x1f,%eax
  10207e:	a2 3c e8 90 00       	mov    %al,0x90e83c
  102083:	0f b6 05 3d e8 90 00 	movzbl 0x90e83d,%eax
  10208a:	83 e0 f0             	and    $0xfffffff0,%eax
  10208d:	83 c8 0e             	or     $0xe,%eax
  102090:	a2 3d e8 90 00       	mov    %al,0x90e83d
  102095:	0f b6 05 3d e8 90 00 	movzbl 0x90e83d,%eax
  10209c:	83 e0 ef             	and    $0xffffffef,%eax
  10209f:	a2 3d e8 90 00       	mov    %al,0x90e83d
  1020a4:	0f b6 05 3d e8 90 00 	movzbl 0x90e83d,%eax
  1020ab:	83 e0 9f             	and    $0xffffff9f,%eax
  1020ae:	a2 3d e8 90 00       	mov    %al,0x90e83d
  1020b3:	0f b6 05 3d e8 90 00 	movzbl 0x90e83d,%eax
  1020ba:	83 c8 80             	or     $0xffffff80,%eax
  1020bd:	a2 3d e8 90 00       	mov    %al,0x90e83d
  1020c2:	b8 46 23 10 00       	mov    $0x102346,%eax
  1020c7:	c1 e8 10             	shr    $0x10,%eax
  1020ca:	66 a3 3e e8 90 00    	mov    %ax,0x90e83e
  1020d0:	b8 a0 23 10 00       	mov    $0x1023a0,%eax
  1020d5:	66 a3 40 e8 90 00    	mov    %ax,0x90e840
  1020db:	66 c7 05 42 e8 90 00 	movw   $0x8,0x90e842
  1020e2:	08 00 
  1020e4:	0f b6 05 44 e8 90 00 	movzbl 0x90e844,%eax
  1020eb:	83 e0 e0             	and    $0xffffffe0,%eax
  1020ee:	a2 44 e8 90 00       	mov    %al,0x90e844
  1020f3:	0f b6 05 44 e8 90 00 	movzbl 0x90e844,%eax
  1020fa:	83 e0 1f             	and    $0x1f,%eax
  1020fd:	a2 44 e8 90 00       	mov    %al,0x90e844
  102102:	0f b6 05 45 e8 90 00 	movzbl 0x90e845,%eax
  102109:	83 e0 f0             	and    $0xfffffff0,%eax
  10210c:	83 c8 0e             	or     $0xe,%eax
  10210f:	a2 45 e8 90 00       	mov    %al,0x90e845
  102114:	0f b6 05 45 e8 90 00 	movzbl 0x90e845,%eax
  10211b:	83 e0 ef             	and    $0xffffffef,%eax
  10211e:	a2 45 e8 90 00       	mov    %al,0x90e845
  102123:	0f b6 05 45 e8 90 00 	movzbl 0x90e845,%eax
  10212a:	83 c8 60             	or     $0x60,%eax
  10212d:	a2 45 e8 90 00       	mov    %al,0x90e845
  102132:	0f b6 05 45 e8 90 00 	movzbl 0x90e845,%eax
  102139:	83 c8 80             	or     $0xffffff80,%eax
  10213c:	a2 45 e8 90 00       	mov    %al,0x90e845
  102141:	b8 a0 23 10 00       	mov    $0x1023a0,%eax
  102146:	c1 e8 10             	shr    $0x10,%eax
  102149:	66 a3 46 e8 90 00    	mov    %ax,0x90e846
  10214f:	b8 aa 23 10 00       	mov    $0x1023aa,%eax
  102154:	66 a3 b0 ee 90 00    	mov    %ax,0x90eeb0
  10215a:	66 c7 05 b2 ee 90 00 	movw   $0x8,0x90eeb2
  102161:	08 00 
  102163:	0f b6 05 b4 ee 90 00 	movzbl 0x90eeb4,%eax
  10216a:	83 e0 e0             	and    $0xffffffe0,%eax
  10216d:	a2 b4 ee 90 00       	mov    %al,0x90eeb4
  102172:	0f b6 05 b4 ee 90 00 	movzbl 0x90eeb4,%eax
  102179:	83 e0 1f             	and    $0x1f,%eax
  10217c:	a2 b4 ee 90 00       	mov    %al,0x90eeb4
  102181:	0f b6 05 b5 ee 90 00 	movzbl 0x90eeb5,%eax
  102188:	83 e0 f0             	and    $0xfffffff0,%eax
  10218b:	83 c8 0e             	or     $0xe,%eax
  10218e:	a2 b5 ee 90 00       	mov    %al,0x90eeb5
  102193:	0f b6 05 b5 ee 90 00 	movzbl 0x90eeb5,%eax
  10219a:	83 e0 ef             	and    $0xffffffef,%eax
  10219d:	a2 b5 ee 90 00       	mov    %al,0x90eeb5
  1021a2:	0f b6 05 b5 ee 90 00 	movzbl 0x90eeb5,%eax
  1021a9:	83 e0 9f             	and    $0xffffff9f,%eax
  1021ac:	a2 b5 ee 90 00       	mov    %al,0x90eeb5
  1021b1:	0f b6 05 b5 ee 90 00 	movzbl 0x90eeb5,%eax
  1021b8:	83 c8 80             	or     $0xffffff80,%eax
  1021bb:	a2 b5 ee 90 00       	mov    %al,0x90eeb5
  1021c0:	b8 aa 23 10 00       	mov    $0x1023aa,%eax
  1021c5:	c1 e8 10             	shr    $0x10,%eax
  1021c8:	66 a3 b6 ee 90 00    	mov    %ax,0x90eeb6
  1021ce:	0f 01 1d 10 85 10 00 	lidtl  0x108510
  1021d5:	c9                   	leave  
  1021d6:	c3                   	ret    

001021d7 <intr_init>:
  1021d7:	55                   	push   %ebp
  1021d8:	89 e5                	mov    %esp,%ebp
  1021da:	0f b6 05 44 de 10 00 	movzbl 0x10de44,%eax
  1021e1:	3c 01                	cmp    $0x1,%al
  1021e3:	75 02                	jne    1021e7 <intr_init+0x10>
  1021e5:	eb 0c                	jmp    1021f3 <intr_init+0x1c>
  1021e7:	e8 ac ed ff ff       	call   100f98 <intr_init_idt>
  1021ec:	c6 05 44 de 10 00 01 	movb   $0x1,0x10de44
  1021f3:	5d                   	pop    %ebp
  1021f4:	c3                   	ret    
  1021f5:	66 90                	xchg   %ax,%ax
  1021f7:	66 90                	xchg   %ax,%ax
  1021f9:	66 90                	xchg   %ax,%ax
  1021fb:	66 90                	xchg   %ax,%ax
  1021fd:	66 90                	xchg   %ax,%ax
  1021ff:	90                   	nop

00102200 <Xdivide>:
  102200:	6a 00                	push   $0x0
  102202:	6a 00                	push   $0x0
  102204:	e9 b7 01 00 00       	jmp    1023c0 <_alltraps>
  102209:	90                   	nop

0010220a <Xdebug>:
  10220a:	6a 00                	push   $0x0
  10220c:	6a 01                	push   $0x1
  10220e:	e9 ad 01 00 00       	jmp    1023c0 <_alltraps>
  102213:	90                   	nop

00102214 <Xnmi>:
  102214:	6a 00                	push   $0x0
  102216:	6a 02                	push   $0x2
  102218:	e9 a3 01 00 00       	jmp    1023c0 <_alltraps>
  10221d:	90                   	nop

0010221e <Xbrkpt>:
  10221e:	6a 00                	push   $0x0
  102220:	6a 03                	push   $0x3
  102222:	e9 99 01 00 00       	jmp    1023c0 <_alltraps>
  102227:	90                   	nop

00102228 <Xoflow>:
  102228:	6a 00                	push   $0x0
  10222a:	6a 04                	push   $0x4
  10222c:	e9 8f 01 00 00       	jmp    1023c0 <_alltraps>
  102231:	90                   	nop

00102232 <Xbound>:
  102232:	6a 00                	push   $0x0
  102234:	6a 05                	push   $0x5
  102236:	e9 85 01 00 00       	jmp    1023c0 <_alltraps>
  10223b:	90                   	nop

0010223c <Xillop>:
  10223c:	6a 00                	push   $0x0
  10223e:	6a 06                	push   $0x6
  102240:	e9 7b 01 00 00       	jmp    1023c0 <_alltraps>
  102245:	90                   	nop

00102246 <Xdevice>:
  102246:	6a 00                	push   $0x0
  102248:	6a 07                	push   $0x7
  10224a:	e9 71 01 00 00       	jmp    1023c0 <_alltraps>
  10224f:	90                   	nop

00102250 <Xdblflt>:
  102250:	6a 08                	push   $0x8
  102252:	e9 69 01 00 00       	jmp    1023c0 <_alltraps>
  102257:	90                   	nop

00102258 <Xcoproc>:
  102258:	6a 00                	push   $0x0
  10225a:	6a 09                	push   $0x9
  10225c:	e9 5f 01 00 00       	jmp    1023c0 <_alltraps>
  102261:	90                   	nop

00102262 <Xtss>:
  102262:	6a 0a                	push   $0xa
  102264:	e9 57 01 00 00       	jmp    1023c0 <_alltraps>
  102269:	90                   	nop

0010226a <Xsegnp>:
  10226a:	6a 0b                	push   $0xb
  10226c:	e9 4f 01 00 00       	jmp    1023c0 <_alltraps>
  102271:	90                   	nop

00102272 <Xstack>:
  102272:	6a 0c                	push   $0xc
  102274:	e9 47 01 00 00       	jmp    1023c0 <_alltraps>
  102279:	90                   	nop

0010227a <Xgpflt>:
  10227a:	6a 0d                	push   $0xd
  10227c:	e9 3f 01 00 00       	jmp    1023c0 <_alltraps>
  102281:	90                   	nop

00102282 <Xpgflt>:
  102282:	6a 0e                	push   $0xe
  102284:	e9 37 01 00 00       	jmp    1023c0 <_alltraps>
  102289:	90                   	nop

0010228a <Xres>:
  10228a:	6a 00                	push   $0x0
  10228c:	6a 0f                	push   $0xf
  10228e:	e9 2d 01 00 00       	jmp    1023c0 <_alltraps>
  102293:	90                   	nop

00102294 <Xfperr>:
  102294:	6a 00                	push   $0x0
  102296:	6a 10                	push   $0x10
  102298:	e9 23 01 00 00       	jmp    1023c0 <_alltraps>
  10229d:	90                   	nop

0010229e <Xalign>:
  10229e:	6a 11                	push   $0x11
  1022a0:	e9 1b 01 00 00       	jmp    1023c0 <_alltraps>
  1022a5:	90                   	nop

001022a6 <Xmchk>:
  1022a6:	6a 00                	push   $0x0
  1022a8:	6a 12                	push   $0x12
  1022aa:	e9 11 01 00 00       	jmp    1023c0 <_alltraps>
  1022af:	90                   	nop

001022b0 <Xirq_timer>:
  1022b0:	6a 00                	push   $0x0
  1022b2:	6a 20                	push   $0x20
  1022b4:	e9 07 01 00 00       	jmp    1023c0 <_alltraps>
  1022b9:	90                   	nop

001022ba <Xirq_kbd>:
  1022ba:	6a 00                	push   $0x0
  1022bc:	6a 21                	push   $0x21
  1022be:	e9 fd 00 00 00       	jmp    1023c0 <_alltraps>
  1022c3:	90                   	nop

001022c4 <Xirq_slave>:
  1022c4:	6a 00                	push   $0x0
  1022c6:	6a 22                	push   $0x22
  1022c8:	e9 f3 00 00 00       	jmp    1023c0 <_alltraps>
  1022cd:	90                   	nop

001022ce <Xirq_serial2>:
  1022ce:	6a 00                	push   $0x0
  1022d0:	6a 23                	push   $0x23
  1022d2:	e9 e9 00 00 00       	jmp    1023c0 <_alltraps>
  1022d7:	90                   	nop

001022d8 <Xirq_serial1>:
  1022d8:	6a 00                	push   $0x0
  1022da:	6a 24                	push   $0x24
  1022dc:	e9 df 00 00 00       	jmp    1023c0 <_alltraps>
  1022e1:	90                   	nop

001022e2 <Xirq_lpt>:
  1022e2:	6a 00                	push   $0x0
  1022e4:	6a 25                	push   $0x25
  1022e6:	e9 d5 00 00 00       	jmp    1023c0 <_alltraps>
  1022eb:	90                   	nop

001022ec <Xirq_floppy>:
  1022ec:	6a 00                	push   $0x0
  1022ee:	6a 26                	push   $0x26
  1022f0:	e9 cb 00 00 00       	jmp    1023c0 <_alltraps>
  1022f5:	90                   	nop

001022f6 <Xirq_spurious>:
  1022f6:	6a 00                	push   $0x0
  1022f8:	6a 27                	push   $0x27
  1022fa:	e9 c1 00 00 00       	jmp    1023c0 <_alltraps>
  1022ff:	90                   	nop

00102300 <Xirq_rtc>:
  102300:	6a 00                	push   $0x0
  102302:	6a 28                	push   $0x28
  102304:	e9 b7 00 00 00       	jmp    1023c0 <_alltraps>
  102309:	90                   	nop

0010230a <Xirq9>:
  10230a:	6a 00                	push   $0x0
  10230c:	6a 29                	push   $0x29
  10230e:	e9 ad 00 00 00       	jmp    1023c0 <_alltraps>
  102313:	90                   	nop

00102314 <Xirq10>:
  102314:	6a 00                	push   $0x0
  102316:	6a 2a                	push   $0x2a
  102318:	e9 a3 00 00 00       	jmp    1023c0 <_alltraps>
  10231d:	90                   	nop

0010231e <Xirq11>:
  10231e:	6a 00                	push   $0x0
  102320:	6a 2b                	push   $0x2b
  102322:	e9 99 00 00 00       	jmp    1023c0 <_alltraps>
  102327:	90                   	nop

00102328 <Xirq_mouse>:
  102328:	6a 00                	push   $0x0
  10232a:	6a 2c                	push   $0x2c
  10232c:	e9 8f 00 00 00       	jmp    1023c0 <_alltraps>
  102331:	90                   	nop

00102332 <Xirq_coproc>:
  102332:	6a 00                	push   $0x0
  102334:	6a 2d                	push   $0x2d
  102336:	e9 85 00 00 00       	jmp    1023c0 <_alltraps>
  10233b:	90                   	nop

0010233c <Xirq_ide1>:
  10233c:	6a 00                	push   $0x0
  10233e:	6a 2e                	push   $0x2e
  102340:	e9 7b 00 00 00       	jmp    1023c0 <_alltraps>
  102345:	90                   	nop

00102346 <Xirq_ide2>:
  102346:	6a 00                	push   $0x0
  102348:	6a 2f                	push   $0x2f
  10234a:	e9 71 00 00 00       	jmp    1023c0 <_alltraps>
  10234f:	90                   	nop

00102350 <Xirq_ehci1>:
  102350:	6a 00                	push   $0x0
  102352:	6a 30                	push   $0x30
  102354:	e9 67 00 00 00       	jmp    1023c0 <_alltraps>
  102359:	90                   	nop

0010235a <Xirq17>:
  10235a:	6a 00                	push   $0x0
  10235c:	6a 31                	push   $0x31
  10235e:	e9 5d 00 00 00       	jmp    1023c0 <_alltraps>
  102363:	90                   	nop

00102364 <Xirq18>:
  102364:	6a 00                	push   $0x0
  102366:	6a 32                	push   $0x32
  102368:	e9 53 00 00 00       	jmp    1023c0 <_alltraps>
  10236d:	90                   	nop

0010236e <Xirq19>:
  10236e:	6a 00                	push   $0x0
  102370:	6a 33                	push   $0x33
  102372:	e9 49 00 00 00       	jmp    1023c0 <_alltraps>
  102377:	90                   	nop

00102378 <Xirq20>:
  102378:	6a 00                	push   $0x0
  10237a:	6a 34                	push   $0x34
  10237c:	e9 3f 00 00 00       	jmp    1023c0 <_alltraps>
  102381:	90                   	nop

00102382 <Xirq21>:
  102382:	6a 00                	push   $0x0
  102384:	6a 35                	push   $0x35
  102386:	e9 35 00 00 00       	jmp    1023c0 <_alltraps>
  10238b:	90                   	nop

0010238c <Xirq22>:
  10238c:	6a 00                	push   $0x0
  10238e:	6a 36                	push   $0x36
  102390:	e9 2b 00 00 00       	jmp    1023c0 <_alltraps>
  102395:	90                   	nop

00102396 <Xirq_ehci2>:
  102396:	6a 00                	push   $0x0
  102398:	6a 37                	push   $0x37
  10239a:	e9 21 00 00 00       	jmp    1023c0 <_alltraps>
  10239f:	90                   	nop

001023a0 <Xsyscall>:
  1023a0:	6a 00                	push   $0x0
  1023a2:	6a 30                	push   $0x30
  1023a4:	e9 17 00 00 00       	jmp    1023c0 <_alltraps>
  1023a9:	90                   	nop

001023aa <Xdefault>:
  1023aa:	68 fe 00 00 00       	push   $0xfe
  1023af:	e9 0c 00 00 00       	jmp    1023c0 <_alltraps>
  1023b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1023ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001023c0 <_alltraps>:
  1023c0:	fa                   	cli    
  1023c1:	1e                   	push   %ds
  1023c2:	06                   	push   %es
  1023c3:	60                   	pusha  
  1023c4:	b8 10 00 00 00       	mov    $0x10,%eax
  1023c9:	8e d8                	mov    %eax,%ds
  1023cb:	8e c0                	mov    %eax,%es
  1023cd:	54                   	push   %esp
  1023ce:	e8 69 1f 00 00       	call   10433c <trap>
  1023d3:	f4                   	hlt    
  1023d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1023da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001023e0 <trap_return>:
  1023e0:	8b 64 24 04          	mov    0x4(%esp),%esp
  1023e4:	61                   	popa   
  1023e5:	07                   	pop    %es
  1023e6:	1f                   	pop    %ds
  1023e7:	83 c4 08             	add    $0x8,%esp
  1023ea:	c3                   	ret    
  1023eb:	90                   	nop

001023ec <memset>:
  1023ec:	55                   	push   %ebp
  1023ed:	89 e5                	mov    %esp,%ebp
  1023ef:	57                   	push   %edi
  1023f0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1023f4:	75 05                	jne    1023fb <memset+0xf>
  1023f6:	8b 45 08             	mov    0x8(%ebp),%eax
  1023f9:	eb 5c                	jmp    102457 <memset+0x6b>
  1023fb:	8b 45 08             	mov    0x8(%ebp),%eax
  1023fe:	83 e0 03             	and    $0x3,%eax
  102401:	85 c0                	test   %eax,%eax
  102403:	75 41                	jne    102446 <memset+0x5a>
  102405:	8b 45 10             	mov    0x10(%ebp),%eax
  102408:	83 e0 03             	and    $0x3,%eax
  10240b:	85 c0                	test   %eax,%eax
  10240d:	75 37                	jne    102446 <memset+0x5a>
  10240f:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
  102416:	8b 45 0c             	mov    0xc(%ebp),%eax
  102419:	c1 e0 18             	shl    $0x18,%eax
  10241c:	89 c2                	mov    %eax,%edx
  10241e:	8b 45 0c             	mov    0xc(%ebp),%eax
  102421:	c1 e0 10             	shl    $0x10,%eax
  102424:	09 c2                	or     %eax,%edx
  102426:	8b 45 0c             	mov    0xc(%ebp),%eax
  102429:	c1 e0 08             	shl    $0x8,%eax
  10242c:	09 d0                	or     %edx,%eax
  10242e:	09 45 0c             	or     %eax,0xc(%ebp)
  102431:	8b 45 10             	mov    0x10(%ebp),%eax
  102434:	c1 e8 02             	shr    $0x2,%eax
  102437:	89 c1                	mov    %eax,%ecx
  102439:	8b 55 08             	mov    0x8(%ebp),%edx
  10243c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10243f:	89 d7                	mov    %edx,%edi
  102441:	fc                   	cld    
  102442:	f3 ab                	rep stos %eax,%es:(%edi)
  102444:	eb 0e                	jmp    102454 <memset+0x68>
  102446:	8b 55 08             	mov    0x8(%ebp),%edx
  102449:	8b 45 0c             	mov    0xc(%ebp),%eax
  10244c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  10244f:	89 d7                	mov    %edx,%edi
  102451:	fc                   	cld    
  102452:	f3 aa                	rep stos %al,%es:(%edi)
  102454:	8b 45 08             	mov    0x8(%ebp),%eax
  102457:	5f                   	pop    %edi
  102458:	5d                   	pop    %ebp
  102459:	c3                   	ret    

0010245a <memmove>:
  10245a:	55                   	push   %ebp
  10245b:	89 e5                	mov    %esp,%ebp
  10245d:	57                   	push   %edi
  10245e:	56                   	push   %esi
  10245f:	53                   	push   %ebx
  102460:	83 ec 10             	sub    $0x10,%esp
  102463:	8b 45 0c             	mov    0xc(%ebp),%eax
  102466:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102469:	8b 45 08             	mov    0x8(%ebp),%eax
  10246c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10246f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102472:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  102475:	73 6d                	jae    1024e4 <memmove+0x8a>
  102477:	8b 45 10             	mov    0x10(%ebp),%eax
  10247a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10247d:	01 d0                	add    %edx,%eax
  10247f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  102482:	76 60                	jbe    1024e4 <memmove+0x8a>
  102484:	8b 45 10             	mov    0x10(%ebp),%eax
  102487:	01 45 f0             	add    %eax,-0x10(%ebp)
  10248a:	8b 45 10             	mov    0x10(%ebp),%eax
  10248d:	01 45 ec             	add    %eax,-0x14(%ebp)
  102490:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102493:	83 e0 03             	and    $0x3,%eax
  102496:	85 c0                	test   %eax,%eax
  102498:	75 2f                	jne    1024c9 <memmove+0x6f>
  10249a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10249d:	83 e0 03             	and    $0x3,%eax
  1024a0:	85 c0                	test   %eax,%eax
  1024a2:	75 25                	jne    1024c9 <memmove+0x6f>
  1024a4:	8b 45 10             	mov    0x10(%ebp),%eax
  1024a7:	83 e0 03             	and    $0x3,%eax
  1024aa:	85 c0                	test   %eax,%eax
  1024ac:	75 1b                	jne    1024c9 <memmove+0x6f>
  1024ae:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1024b1:	83 e8 04             	sub    $0x4,%eax
  1024b4:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1024b7:	83 ea 04             	sub    $0x4,%edx
  1024ba:	8b 4d 10             	mov    0x10(%ebp),%ecx
  1024bd:	c1 e9 02             	shr    $0x2,%ecx
  1024c0:	89 c7                	mov    %eax,%edi
  1024c2:	89 d6                	mov    %edx,%esi
  1024c4:	fd                   	std    
  1024c5:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  1024c7:	eb 18                	jmp    1024e1 <memmove+0x87>
  1024c9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1024cc:	8d 50 ff             	lea    -0x1(%eax),%edx
  1024cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1024d2:	8d 58 ff             	lea    -0x1(%eax),%ebx
  1024d5:	8b 45 10             	mov    0x10(%ebp),%eax
  1024d8:	89 d7                	mov    %edx,%edi
  1024da:	89 de                	mov    %ebx,%esi
  1024dc:	89 c1                	mov    %eax,%ecx
  1024de:	fd                   	std    
  1024df:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  1024e1:	fc                   	cld    
  1024e2:	eb 45                	jmp    102529 <memmove+0xcf>
  1024e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1024e7:	83 e0 03             	and    $0x3,%eax
  1024ea:	85 c0                	test   %eax,%eax
  1024ec:	75 2b                	jne    102519 <memmove+0xbf>
  1024ee:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1024f1:	83 e0 03             	and    $0x3,%eax
  1024f4:	85 c0                	test   %eax,%eax
  1024f6:	75 21                	jne    102519 <memmove+0xbf>
  1024f8:	8b 45 10             	mov    0x10(%ebp),%eax
  1024fb:	83 e0 03             	and    $0x3,%eax
  1024fe:	85 c0                	test   %eax,%eax
  102500:	75 17                	jne    102519 <memmove+0xbf>
  102502:	8b 45 10             	mov    0x10(%ebp),%eax
  102505:	c1 e8 02             	shr    $0x2,%eax
  102508:	89 c1                	mov    %eax,%ecx
  10250a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10250d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102510:	89 c7                	mov    %eax,%edi
  102512:	89 d6                	mov    %edx,%esi
  102514:	fc                   	cld    
  102515:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  102517:	eb 10                	jmp    102529 <memmove+0xcf>
  102519:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10251c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10251f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  102522:	89 c7                	mov    %eax,%edi
  102524:	89 d6                	mov    %edx,%esi
  102526:	fc                   	cld    
  102527:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102529:	8b 45 08             	mov    0x8(%ebp),%eax
  10252c:	83 c4 10             	add    $0x10,%esp
  10252f:	5b                   	pop    %ebx
  102530:	5e                   	pop    %esi
  102531:	5f                   	pop    %edi
  102532:	5d                   	pop    %ebp
  102533:	c3                   	ret    

00102534 <memcpy>:
  102534:	55                   	push   %ebp
  102535:	89 e5                	mov    %esp,%ebp
  102537:	83 ec 0c             	sub    $0xc,%esp
  10253a:	8b 45 10             	mov    0x10(%ebp),%eax
  10253d:	89 44 24 08          	mov    %eax,0x8(%esp)
  102541:	8b 45 0c             	mov    0xc(%ebp),%eax
  102544:	89 44 24 04          	mov    %eax,0x4(%esp)
  102548:	8b 45 08             	mov    0x8(%ebp),%eax
  10254b:	89 04 24             	mov    %eax,(%esp)
  10254e:	e8 07 ff ff ff       	call   10245a <memmove>
  102553:	c9                   	leave  
  102554:	c3                   	ret    

00102555 <strncmp>:
  102555:	55                   	push   %ebp
  102556:	89 e5                	mov    %esp,%ebp
  102558:	eb 0c                	jmp    102566 <strncmp+0x11>
  10255a:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  10255e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102562:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  102566:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10256a:	74 1a                	je     102586 <strncmp+0x31>
  10256c:	8b 45 08             	mov    0x8(%ebp),%eax
  10256f:	0f b6 00             	movzbl (%eax),%eax
  102572:	84 c0                	test   %al,%al
  102574:	74 10                	je     102586 <strncmp+0x31>
  102576:	8b 45 08             	mov    0x8(%ebp),%eax
  102579:	0f b6 10             	movzbl (%eax),%edx
  10257c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10257f:	0f b6 00             	movzbl (%eax),%eax
  102582:	38 c2                	cmp    %al,%dl
  102584:	74 d4                	je     10255a <strncmp+0x5>
  102586:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10258a:	75 07                	jne    102593 <strncmp+0x3e>
  10258c:	b8 00 00 00 00       	mov    $0x0,%eax
  102591:	eb 16                	jmp    1025a9 <strncmp+0x54>
  102593:	8b 45 08             	mov    0x8(%ebp),%eax
  102596:	0f b6 00             	movzbl (%eax),%eax
  102599:	0f b6 d0             	movzbl %al,%edx
  10259c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10259f:	0f b6 00             	movzbl (%eax),%eax
  1025a2:	0f b6 c0             	movzbl %al,%eax
  1025a5:	29 c2                	sub    %eax,%edx
  1025a7:	89 d0                	mov    %edx,%eax
  1025a9:	5d                   	pop    %ebp
  1025aa:	c3                   	ret    

001025ab <strnlen>:
  1025ab:	55                   	push   %ebp
  1025ac:	89 e5                	mov    %esp,%ebp
  1025ae:	83 ec 10             	sub    $0x10,%esp
  1025b1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  1025b8:	eb 0c                	jmp    1025c6 <strnlen+0x1b>
  1025ba:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1025be:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  1025c2:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
  1025c6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1025ca:	74 0a                	je     1025d6 <strnlen+0x2b>
  1025cc:	8b 45 08             	mov    0x8(%ebp),%eax
  1025cf:	0f b6 00             	movzbl (%eax),%eax
  1025d2:	84 c0                	test   %al,%al
  1025d4:	75 e4                	jne    1025ba <strnlen+0xf>
  1025d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1025d9:	c9                   	leave  
  1025da:	c3                   	ret    

001025db <strcmp>:
  1025db:	55                   	push   %ebp
  1025dc:	89 e5                	mov    %esp,%ebp
  1025de:	eb 08                	jmp    1025e8 <strcmp+0xd>
  1025e0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  1025e4:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  1025e8:	8b 45 08             	mov    0x8(%ebp),%eax
  1025eb:	0f b6 00             	movzbl (%eax),%eax
  1025ee:	84 c0                	test   %al,%al
  1025f0:	74 10                	je     102602 <strcmp+0x27>
  1025f2:	8b 45 08             	mov    0x8(%ebp),%eax
  1025f5:	0f b6 10             	movzbl (%eax),%edx
  1025f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1025fb:	0f b6 00             	movzbl (%eax),%eax
  1025fe:	38 c2                	cmp    %al,%dl
  102600:	74 de                	je     1025e0 <strcmp+0x5>
  102602:	8b 45 08             	mov    0x8(%ebp),%eax
  102605:	0f b6 00             	movzbl (%eax),%eax
  102608:	0f b6 d0             	movzbl %al,%edx
  10260b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10260e:	0f b6 00             	movzbl (%eax),%eax
  102611:	0f b6 c0             	movzbl %al,%eax
  102614:	29 c2                	sub    %eax,%edx
  102616:	89 d0                	mov    %edx,%eax
  102618:	5d                   	pop    %ebp
  102619:	c3                   	ret    

0010261a <strchr>:
  10261a:	55                   	push   %ebp
  10261b:	89 e5                	mov    %esp,%ebp
  10261d:	83 ec 04             	sub    $0x4,%esp
  102620:	8b 45 0c             	mov    0xc(%ebp),%eax
  102623:	88 45 fc             	mov    %al,-0x4(%ebp)
  102626:	eb 14                	jmp    10263c <strchr+0x22>
  102628:	8b 45 08             	mov    0x8(%ebp),%eax
  10262b:	0f b6 00             	movzbl (%eax),%eax
  10262e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  102631:	75 05                	jne    102638 <strchr+0x1e>
  102633:	8b 45 08             	mov    0x8(%ebp),%eax
  102636:	eb 13                	jmp    10264b <strchr+0x31>
  102638:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  10263c:	8b 45 08             	mov    0x8(%ebp),%eax
  10263f:	0f b6 00             	movzbl (%eax),%eax
  102642:	84 c0                	test   %al,%al
  102644:	75 e2                	jne    102628 <strchr+0xe>
  102646:	b8 00 00 00 00       	mov    $0x0,%eax
  10264b:	c9                   	leave  
  10264c:	c3                   	ret    

0010264d <memzero>:
  10264d:	55                   	push   %ebp
  10264e:	89 e5                	mov    %esp,%ebp
  102650:	83 ec 0c             	sub    $0xc,%esp
  102653:	8b 45 0c             	mov    0xc(%ebp),%eax
  102656:	89 44 24 08          	mov    %eax,0x8(%esp)
  10265a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  102661:	00 
  102662:	8b 45 08             	mov    0x8(%ebp),%eax
  102665:	89 04 24             	mov    %eax,(%esp)
  102668:	e8 7f fd ff ff       	call   1023ec <memset>
  10266d:	c9                   	leave  
  10266e:	c3                   	ret    
  10266f:	90                   	nop

00102670 <debug_info>:
  102670:	55                   	push   %ebp
  102671:	89 e5                	mov    %esp,%ebp
  102673:	83 ec 28             	sub    $0x28,%esp
  102676:	8d 45 0c             	lea    0xc(%ebp),%eax
  102679:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10267c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10267f:	89 44 24 04          	mov    %eax,0x4(%esp)
  102683:	8b 45 08             	mov    0x8(%ebp),%eax
  102686:	89 04 24             	mov    %eax,(%esp)
  102689:	e8 fb 01 00 00       	call   102889 <vdprintf>
  10268e:	c9                   	leave  
  10268f:	c3                   	ret    

00102690 <debug_normal>:
  102690:	55                   	push   %ebp
  102691:	89 e5                	mov    %esp,%ebp
  102693:	83 ec 28             	sub    $0x28,%esp
  102696:	8b 45 0c             	mov    0xc(%ebp),%eax
  102699:	89 44 24 08          	mov    %eax,0x8(%esp)
  10269d:	8b 45 08             	mov    0x8(%ebp),%eax
  1026a0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1026a4:	c7 04 24 db 53 10 00 	movl   $0x1053db,(%esp)
  1026ab:	e8 41 02 00 00       	call   1028f1 <dprintf>
  1026b0:	8d 45 14             	lea    0x14(%ebp),%eax
  1026b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1026b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1026b9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1026bd:	8b 45 10             	mov    0x10(%ebp),%eax
  1026c0:	89 04 24             	mov    %eax,(%esp)
  1026c3:	e8 c1 01 00 00       	call   102889 <vdprintf>
  1026c8:	c9                   	leave  
  1026c9:	c3                   	ret    

001026ca <debug_trace>:
  1026ca:	55                   	push   %ebp
  1026cb:	89 e5                	mov    %esp,%ebp
  1026cd:	83 ec 10             	sub    $0x10,%esp
  1026d0:	8b 45 08             	mov    0x8(%ebp),%eax
  1026d3:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1026d6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  1026dd:	eb 23                	jmp    102702 <debug_trace+0x38>
  1026df:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1026e2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  1026e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1026ec:	01 c2                	add    %eax,%edx
  1026ee:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1026f1:	8b 40 04             	mov    0x4(%eax),%eax
  1026f4:	89 02                	mov    %eax,(%edx)
  1026f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1026f9:	8b 00                	mov    (%eax),%eax
  1026fb:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1026fe:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  102702:	83 7d fc 09          	cmpl   $0x9,-0x4(%ebp)
  102706:	7f 06                	jg     10270e <debug_trace+0x44>
  102708:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  10270c:	75 d1                	jne    1026df <debug_trace+0x15>
  10270e:	eb 19                	jmp    102729 <debug_trace+0x5f>
  102710:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102713:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  10271a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10271d:	01 d0                	add    %edx,%eax
  10271f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  102725:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  102729:	83 7d fc 09          	cmpl   $0x9,-0x4(%ebp)
  10272d:	7e e1                	jle    102710 <debug_trace+0x46>
  10272f:	c9                   	leave  
  102730:	c3                   	ret    

00102731 <debug_panic>:
  102731:	55                   	push   %ebp
  102732:	89 e5                	mov    %esp,%ebp
  102734:	83 ec 48             	sub    $0x48,%esp
  102737:	8b 45 0c             	mov    0xc(%ebp),%eax
  10273a:	89 44 24 08          	mov    %eax,0x8(%esp)
  10273e:	8b 45 08             	mov    0x8(%ebp),%eax
  102741:	89 44 24 04          	mov    %eax,0x4(%esp)
  102745:	c7 04 24 e7 53 10 00 	movl   $0x1053e7,(%esp)
  10274c:	e8 a0 01 00 00       	call   1028f1 <dprintf>
  102751:	8d 45 14             	lea    0x14(%ebp),%eax
  102754:	89 45 c8             	mov    %eax,-0x38(%ebp)
  102757:	8b 45 c8             	mov    -0x38(%ebp),%eax
  10275a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10275e:	8b 45 10             	mov    0x10(%ebp),%eax
  102761:	89 04 24             	mov    %eax,(%esp)
  102764:	e8 20 01 00 00       	call   102889 <vdprintf>
  102769:	e8 da 0b 00 00       	call   103348 <read_ebp>
  10276e:	8d 55 cc             	lea    -0x34(%ebp),%edx
  102771:	89 54 24 04          	mov    %edx,0x4(%esp)
  102775:	89 04 24             	mov    %eax,(%esp)
  102778:	e8 4d ff ff ff       	call   1026ca <debug_trace>
  10277d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  102784:	eb 1b                	jmp    1027a1 <debug_panic+0x70>
  102786:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102789:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
  10278d:	89 44 24 04          	mov    %eax,0x4(%esp)
  102791:	c7 04 24 f3 53 10 00 	movl   $0x1053f3,(%esp)
  102798:	e8 54 01 00 00       	call   1028f1 <dprintf>
  10279d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  1027a1:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
  1027a5:	7f 0b                	jg     1027b2 <debug_panic+0x81>
  1027a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1027aa:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
  1027ae:	85 c0                	test   %eax,%eax
  1027b0:	75 d4                	jne    102786 <debug_panic+0x55>
  1027b2:	c7 04 24 01 54 10 00 	movl   $0x105401,(%esp)
  1027b9:	e8 33 01 00 00       	call   1028f1 <dprintf>
  1027be:	e8 f2 0b 00 00       	call   1033b5 <halt>
  1027c3:	c9                   	leave  
  1027c4:	c3                   	ret    

001027c5 <debug_warn>:
  1027c5:	55                   	push   %ebp
  1027c6:	89 e5                	mov    %esp,%ebp
  1027c8:	83 ec 28             	sub    $0x28,%esp
  1027cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  1027ce:	89 44 24 08          	mov    %eax,0x8(%esp)
  1027d2:	8b 45 08             	mov    0x8(%ebp),%eax
  1027d5:	89 44 24 04          	mov    %eax,0x4(%esp)
  1027d9:	c7 04 24 13 54 10 00 	movl   $0x105413,(%esp)
  1027e0:	e8 0c 01 00 00       	call   1028f1 <dprintf>
  1027e5:	8d 45 14             	lea    0x14(%ebp),%eax
  1027e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1027eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1027ee:	89 44 24 04          	mov    %eax,0x4(%esp)
  1027f2:	8b 45 10             	mov    0x10(%ebp),%eax
  1027f5:	89 04 24             	mov    %eax,(%esp)
  1027f8:	e8 8c 00 00 00       	call   102889 <vdprintf>
  1027fd:	c9                   	leave  
  1027fe:	c3                   	ret    
  1027ff:	90                   	nop

00102800 <cputs>:
  102800:	55                   	push   %ebp
  102801:	89 e5                	mov    %esp,%ebp
  102803:	83 ec 18             	sub    $0x18,%esp
  102806:	eb 15                	jmp    10281d <cputs+0x1d>
  102808:	8b 45 08             	mov    0x8(%ebp),%eax
  10280b:	0f b6 00             	movzbl (%eax),%eax
  10280e:	0f be c0             	movsbl %al,%eax
  102811:	89 04 24             	mov    %eax,(%esp)
  102814:	e8 0e dc ff ff       	call   100427 <cons_putc>
  102819:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  10281d:	8b 45 08             	mov    0x8(%ebp),%eax
  102820:	0f b6 00             	movzbl (%eax),%eax
  102823:	84 c0                	test   %al,%al
  102825:	75 e1                	jne    102808 <cputs+0x8>
  102827:	c9                   	leave  
  102828:	c3                   	ret    

00102829 <putch>:
  102829:	55                   	push   %ebp
  10282a:	89 e5                	mov    %esp,%ebp
  10282c:	83 ec 18             	sub    $0x18,%esp
  10282f:	8b 45 0c             	mov    0xc(%ebp),%eax
  102832:	8b 00                	mov    (%eax),%eax
  102834:	8d 48 01             	lea    0x1(%eax),%ecx
  102837:	8b 55 0c             	mov    0xc(%ebp),%edx
  10283a:	89 0a                	mov    %ecx,(%edx)
  10283c:	8b 55 08             	mov    0x8(%ebp),%edx
  10283f:	89 d1                	mov    %edx,%ecx
  102841:	8b 55 0c             	mov    0xc(%ebp),%edx
  102844:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
  102848:	8b 45 0c             	mov    0xc(%ebp),%eax
  10284b:	8b 00                	mov    (%eax),%eax
  10284d:	3d ff 01 00 00       	cmp    $0x1ff,%eax
  102852:	75 24                	jne    102878 <putch+0x4f>
  102854:	8b 45 0c             	mov    0xc(%ebp),%eax
  102857:	8b 00                	mov    (%eax),%eax
  102859:	8b 55 0c             	mov    0xc(%ebp),%edx
  10285c:	c6 44 02 08 00       	movb   $0x0,0x8(%edx,%eax,1)
  102861:	8b 45 0c             	mov    0xc(%ebp),%eax
  102864:	83 c0 08             	add    $0x8,%eax
  102867:	89 04 24             	mov    %eax,(%esp)
  10286a:	e8 91 ff ff ff       	call   102800 <cputs>
  10286f:	8b 45 0c             	mov    0xc(%ebp),%eax
  102872:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  102878:	8b 45 0c             	mov    0xc(%ebp),%eax
  10287b:	8b 40 04             	mov    0x4(%eax),%eax
  10287e:	8d 50 01             	lea    0x1(%eax),%edx
  102881:	8b 45 0c             	mov    0xc(%ebp),%eax
  102884:	89 50 04             	mov    %edx,0x4(%eax)
  102887:	c9                   	leave  
  102888:	c3                   	ret    

00102889 <vdprintf>:
  102889:	55                   	push   %ebp
  10288a:	89 e5                	mov    %esp,%ebp
  10288c:	81 ec 28 02 00 00    	sub    $0x228,%esp
  102892:	c7 85 f0 fd ff ff 00 	movl   $0x0,-0x210(%ebp)
  102899:	00 00 00 
  10289c:	c7 85 f4 fd ff ff 00 	movl   $0x0,-0x20c(%ebp)
  1028a3:	00 00 00 
  1028a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1028a9:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1028ad:	8b 45 08             	mov    0x8(%ebp),%eax
  1028b0:	89 44 24 08          	mov    %eax,0x8(%esp)
  1028b4:	8d 85 f0 fd ff ff    	lea    -0x210(%ebp),%eax
  1028ba:	89 44 24 04          	mov    %eax,0x4(%esp)
  1028be:	c7 04 24 29 28 10 00 	movl   $0x102829,(%esp)
  1028c5:	e8 c2 01 00 00       	call   102a8c <vprintfmt>
  1028ca:	8b 85 f0 fd ff ff    	mov    -0x210(%ebp),%eax
  1028d0:	c6 84 05 f8 fd ff ff 	movb   $0x0,-0x208(%ebp,%eax,1)
  1028d7:	00 
  1028d8:	8d 85 f0 fd ff ff    	lea    -0x210(%ebp),%eax
  1028de:	83 c0 08             	add    $0x8,%eax
  1028e1:	89 04 24             	mov    %eax,(%esp)
  1028e4:	e8 17 ff ff ff       	call   102800 <cputs>
  1028e9:	8b 85 f4 fd ff ff    	mov    -0x20c(%ebp),%eax
  1028ef:	c9                   	leave  
  1028f0:	c3                   	ret    

001028f1 <dprintf>:
  1028f1:	55                   	push   %ebp
  1028f2:	89 e5                	mov    %esp,%ebp
  1028f4:	83 ec 28             	sub    $0x28,%esp
  1028f7:	8d 45 0c             	lea    0xc(%ebp),%eax
  1028fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1028fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102900:	89 44 24 04          	mov    %eax,0x4(%esp)
  102904:	8b 45 08             	mov    0x8(%ebp),%eax
  102907:	89 04 24             	mov    %eax,(%esp)
  10290a:	e8 7a ff ff ff       	call   102889 <vdprintf>
  10290f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102912:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102915:	c9                   	leave  
  102916:	c3                   	ret    
  102917:	90                   	nop

00102918 <printnum>:
  102918:	55                   	push   %ebp
  102919:	89 e5                	mov    %esp,%ebp
  10291b:	53                   	push   %ebx
  10291c:	83 ec 34             	sub    $0x34,%esp
  10291f:	8b 45 10             	mov    0x10(%ebp),%eax
  102922:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102925:	8b 45 14             	mov    0x14(%ebp),%eax
  102928:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10292b:	8b 45 18             	mov    0x18(%ebp),%eax
  10292e:	ba 00 00 00 00       	mov    $0x0,%edx
  102933:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  102936:	77 72                	ja     1029aa <printnum+0x92>
  102938:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  10293b:	72 05                	jb     102942 <printnum+0x2a>
  10293d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  102940:	77 68                	ja     1029aa <printnum+0x92>
  102942:	8b 45 1c             	mov    0x1c(%ebp),%eax
  102945:	8d 58 ff             	lea    -0x1(%eax),%ebx
  102948:	8b 45 18             	mov    0x18(%ebp),%eax
  10294b:	ba 00 00 00 00       	mov    $0x0,%edx
  102950:	89 44 24 08          	mov    %eax,0x8(%esp)
  102954:	89 54 24 0c          	mov    %edx,0xc(%esp)
  102958:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10295b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10295e:	89 04 24             	mov    %eax,(%esp)
  102961:	89 54 24 04          	mov    %edx,0x4(%esp)
  102965:	e8 d6 26 00 00       	call   105040 <__udivdi3>
  10296a:	8b 4d 20             	mov    0x20(%ebp),%ecx
  10296d:	89 4c 24 18          	mov    %ecx,0x18(%esp)
  102971:	89 5c 24 14          	mov    %ebx,0x14(%esp)
  102975:	8b 4d 18             	mov    0x18(%ebp),%ecx
  102978:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  10297c:	89 44 24 08          	mov    %eax,0x8(%esp)
  102980:	89 54 24 0c          	mov    %edx,0xc(%esp)
  102984:	8b 45 0c             	mov    0xc(%ebp),%eax
  102987:	89 44 24 04          	mov    %eax,0x4(%esp)
  10298b:	8b 45 08             	mov    0x8(%ebp),%eax
  10298e:	89 04 24             	mov    %eax,(%esp)
  102991:	e8 82 ff ff ff       	call   102918 <printnum>
  102996:	eb 1c                	jmp    1029b4 <printnum+0x9c>
  102998:	8b 45 0c             	mov    0xc(%ebp),%eax
  10299b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10299f:	8b 45 20             	mov    0x20(%ebp),%eax
  1029a2:	89 04 24             	mov    %eax,(%esp)
  1029a5:	8b 45 08             	mov    0x8(%ebp),%eax
  1029a8:	ff d0                	call   *%eax
  1029aa:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
  1029ae:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  1029b2:	7f e4                	jg     102998 <printnum+0x80>
  1029b4:	8b 4d 18             	mov    0x18(%ebp),%ecx
  1029b7:	bb 00 00 00 00       	mov    $0x0,%ebx
  1029bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1029bf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1029c2:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  1029c6:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  1029ca:	89 04 24             	mov    %eax,(%esp)
  1029cd:	89 54 24 04          	mov    %edx,0x4(%esp)
  1029d1:	e8 9a 27 00 00       	call   105170 <__umoddi3>
  1029d6:	05 20 54 10 00       	add    $0x105420,%eax
  1029db:	0f b6 00             	movzbl (%eax),%eax
  1029de:	0f be c0             	movsbl %al,%eax
  1029e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  1029e4:	89 54 24 04          	mov    %edx,0x4(%esp)
  1029e8:	89 04 24             	mov    %eax,(%esp)
  1029eb:	8b 45 08             	mov    0x8(%ebp),%eax
  1029ee:	ff d0                	call   *%eax
  1029f0:	83 c4 34             	add    $0x34,%esp
  1029f3:	5b                   	pop    %ebx
  1029f4:	5d                   	pop    %ebp
  1029f5:	c3                   	ret    

001029f6 <getuint>:
  1029f6:	55                   	push   %ebp
  1029f7:	89 e5                	mov    %esp,%ebp
  1029f9:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  1029fd:	7e 14                	jle    102a13 <getuint+0x1d>
  1029ff:	8b 45 08             	mov    0x8(%ebp),%eax
  102a02:	8b 00                	mov    (%eax),%eax
  102a04:	8d 48 08             	lea    0x8(%eax),%ecx
  102a07:	8b 55 08             	mov    0x8(%ebp),%edx
  102a0a:	89 0a                	mov    %ecx,(%edx)
  102a0c:	8b 50 04             	mov    0x4(%eax),%edx
  102a0f:	8b 00                	mov    (%eax),%eax
  102a11:	eb 30                	jmp    102a43 <getuint+0x4d>
  102a13:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102a17:	74 16                	je     102a2f <getuint+0x39>
  102a19:	8b 45 08             	mov    0x8(%ebp),%eax
  102a1c:	8b 00                	mov    (%eax),%eax
  102a1e:	8d 48 04             	lea    0x4(%eax),%ecx
  102a21:	8b 55 08             	mov    0x8(%ebp),%edx
  102a24:	89 0a                	mov    %ecx,(%edx)
  102a26:	8b 00                	mov    (%eax),%eax
  102a28:	ba 00 00 00 00       	mov    $0x0,%edx
  102a2d:	eb 14                	jmp    102a43 <getuint+0x4d>
  102a2f:	8b 45 08             	mov    0x8(%ebp),%eax
  102a32:	8b 00                	mov    (%eax),%eax
  102a34:	8d 48 04             	lea    0x4(%eax),%ecx
  102a37:	8b 55 08             	mov    0x8(%ebp),%edx
  102a3a:	89 0a                	mov    %ecx,(%edx)
  102a3c:	8b 00                	mov    (%eax),%eax
  102a3e:	ba 00 00 00 00       	mov    $0x0,%edx
  102a43:	5d                   	pop    %ebp
  102a44:	c3                   	ret    

00102a45 <getint>:
  102a45:	55                   	push   %ebp
  102a46:	89 e5                	mov    %esp,%ebp
  102a48:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  102a4c:	7e 14                	jle    102a62 <getint+0x1d>
  102a4e:	8b 45 08             	mov    0x8(%ebp),%eax
  102a51:	8b 00                	mov    (%eax),%eax
  102a53:	8d 48 08             	lea    0x8(%eax),%ecx
  102a56:	8b 55 08             	mov    0x8(%ebp),%edx
  102a59:	89 0a                	mov    %ecx,(%edx)
  102a5b:	8b 50 04             	mov    0x4(%eax),%edx
  102a5e:	8b 00                	mov    (%eax),%eax
  102a60:	eb 28                	jmp    102a8a <getint+0x45>
  102a62:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102a66:	74 12                	je     102a7a <getint+0x35>
  102a68:	8b 45 08             	mov    0x8(%ebp),%eax
  102a6b:	8b 00                	mov    (%eax),%eax
  102a6d:	8d 48 04             	lea    0x4(%eax),%ecx
  102a70:	8b 55 08             	mov    0x8(%ebp),%edx
  102a73:	89 0a                	mov    %ecx,(%edx)
  102a75:	8b 00                	mov    (%eax),%eax
  102a77:	99                   	cltd   
  102a78:	eb 10                	jmp    102a8a <getint+0x45>
  102a7a:	8b 45 08             	mov    0x8(%ebp),%eax
  102a7d:	8b 00                	mov    (%eax),%eax
  102a7f:	8d 48 04             	lea    0x4(%eax),%ecx
  102a82:	8b 55 08             	mov    0x8(%ebp),%edx
  102a85:	89 0a                	mov    %ecx,(%edx)
  102a87:	8b 00                	mov    (%eax),%eax
  102a89:	99                   	cltd   
  102a8a:	5d                   	pop    %ebp
  102a8b:	c3                   	ret    

00102a8c <vprintfmt>:
  102a8c:	55                   	push   %ebp
  102a8d:	89 e5                	mov    %esp,%ebp
  102a8f:	56                   	push   %esi
  102a90:	53                   	push   %ebx
  102a91:	83 ec 40             	sub    $0x40,%esp
  102a94:	eb 18                	jmp    102aae <vprintfmt+0x22>
  102a96:	85 db                	test   %ebx,%ebx
  102a98:	75 05                	jne    102a9f <vprintfmt+0x13>
  102a9a:	e9 41 03 00 00       	jmp    102de0 <vprintfmt+0x354>
  102a9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  102aa2:	89 44 24 04          	mov    %eax,0x4(%esp)
  102aa6:	89 1c 24             	mov    %ebx,(%esp)
  102aa9:	8b 45 08             	mov    0x8(%ebp),%eax
  102aac:	ff d0                	call   *%eax
  102aae:	8b 45 10             	mov    0x10(%ebp),%eax
  102ab1:	8d 50 01             	lea    0x1(%eax),%edx
  102ab4:	89 55 10             	mov    %edx,0x10(%ebp)
  102ab7:	0f b6 00             	movzbl (%eax),%eax
  102aba:	0f b6 d8             	movzbl %al,%ebx
  102abd:	83 fb 25             	cmp    $0x25,%ebx
  102ac0:	75 d4                	jne    102a96 <vprintfmt+0xa>
  102ac2:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
  102ac6:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  102acd:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
  102ad4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  102adb:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  102ae2:	8b 45 10             	mov    0x10(%ebp),%eax
  102ae5:	8d 50 01             	lea    0x1(%eax),%edx
  102ae8:	89 55 10             	mov    %edx,0x10(%ebp)
  102aeb:	0f b6 00             	movzbl (%eax),%eax
  102aee:	0f b6 d8             	movzbl %al,%ebx
  102af1:	8d 43 dd             	lea    -0x23(%ebx),%eax
  102af4:	83 f8 55             	cmp    $0x55,%eax
  102af7:	0f 87 b2 02 00 00    	ja     102daf <vprintfmt+0x323>
  102afd:	8b 04 85 38 54 10 00 	mov    0x105438(,%eax,4),%eax
  102b04:	ff e0                	jmp    *%eax
  102b06:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
  102b0a:	eb d6                	jmp    102ae2 <vprintfmt+0x56>
  102b0c:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
  102b10:	eb d0                	jmp    102ae2 <vprintfmt+0x56>
  102b12:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  102b19:	8b 55 e0             	mov    -0x20(%ebp),%edx
  102b1c:	89 d0                	mov    %edx,%eax
  102b1e:	c1 e0 02             	shl    $0x2,%eax
  102b21:	01 d0                	add    %edx,%eax
  102b23:	01 c0                	add    %eax,%eax
  102b25:	01 d8                	add    %ebx,%eax
  102b27:	83 e8 30             	sub    $0x30,%eax
  102b2a:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102b2d:	8b 45 10             	mov    0x10(%ebp),%eax
  102b30:	0f b6 00             	movzbl (%eax),%eax
  102b33:	0f be d8             	movsbl %al,%ebx
  102b36:	83 fb 2f             	cmp    $0x2f,%ebx
  102b39:	7e 0b                	jle    102b46 <vprintfmt+0xba>
  102b3b:	83 fb 39             	cmp    $0x39,%ebx
  102b3e:	7f 06                	jg     102b46 <vprintfmt+0xba>
  102b40:	83 45 10 01          	addl   $0x1,0x10(%ebp)
  102b44:	eb d3                	jmp    102b19 <vprintfmt+0x8d>
  102b46:	eb 33                	jmp    102b7b <vprintfmt+0xef>
  102b48:	8b 45 14             	mov    0x14(%ebp),%eax
  102b4b:	8d 50 04             	lea    0x4(%eax),%edx
  102b4e:	89 55 14             	mov    %edx,0x14(%ebp)
  102b51:	8b 00                	mov    (%eax),%eax
  102b53:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102b56:	eb 23                	jmp    102b7b <vprintfmt+0xef>
  102b58:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  102b5c:	79 0c                	jns    102b6a <vprintfmt+0xde>
  102b5e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  102b65:	e9 78 ff ff ff       	jmp    102ae2 <vprintfmt+0x56>
  102b6a:	e9 73 ff ff ff       	jmp    102ae2 <vprintfmt+0x56>
  102b6f:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
  102b76:	e9 67 ff ff ff       	jmp    102ae2 <vprintfmt+0x56>
  102b7b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  102b7f:	79 12                	jns    102b93 <vprintfmt+0x107>
  102b81:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102b84:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102b87:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
  102b8e:	e9 4f ff ff ff       	jmp    102ae2 <vprintfmt+0x56>
  102b93:	e9 4a ff ff ff       	jmp    102ae2 <vprintfmt+0x56>
  102b98:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
  102b9c:	e9 41 ff ff ff       	jmp    102ae2 <vprintfmt+0x56>
  102ba1:	8b 45 14             	mov    0x14(%ebp),%eax
  102ba4:	8d 50 04             	lea    0x4(%eax),%edx
  102ba7:	89 55 14             	mov    %edx,0x14(%ebp)
  102baa:	8b 00                	mov    (%eax),%eax
  102bac:	8b 55 0c             	mov    0xc(%ebp),%edx
  102baf:	89 54 24 04          	mov    %edx,0x4(%esp)
  102bb3:	89 04 24             	mov    %eax,(%esp)
  102bb6:	8b 45 08             	mov    0x8(%ebp),%eax
  102bb9:	ff d0                	call   *%eax
  102bbb:	e9 1a 02 00 00       	jmp    102dda <vprintfmt+0x34e>
  102bc0:	8b 45 14             	mov    0x14(%ebp),%eax
  102bc3:	8d 50 04             	lea    0x4(%eax),%edx
  102bc6:	89 55 14             	mov    %edx,0x14(%ebp)
  102bc9:	8b 30                	mov    (%eax),%esi
  102bcb:	85 f6                	test   %esi,%esi
  102bcd:	75 05                	jne    102bd4 <vprintfmt+0x148>
  102bcf:	be 31 54 10 00       	mov    $0x105431,%esi
  102bd4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  102bd8:	7e 37                	jle    102c11 <vprintfmt+0x185>
  102bda:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  102bde:	74 31                	je     102c11 <vprintfmt+0x185>
  102be0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102be3:	89 44 24 04          	mov    %eax,0x4(%esp)
  102be7:	89 34 24             	mov    %esi,(%esp)
  102bea:	e8 bc f9 ff ff       	call   1025ab <strnlen>
  102bef:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  102bf2:	eb 17                	jmp    102c0b <vprintfmt+0x17f>
  102bf4:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  102bf8:	8b 55 0c             	mov    0xc(%ebp),%edx
  102bfb:	89 54 24 04          	mov    %edx,0x4(%esp)
  102bff:	89 04 24             	mov    %eax,(%esp)
  102c02:	8b 45 08             	mov    0x8(%ebp),%eax
  102c05:	ff d0                	call   *%eax
  102c07:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
  102c0b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  102c0f:	7f e3                	jg     102bf4 <vprintfmt+0x168>
  102c11:	eb 38                	jmp    102c4b <vprintfmt+0x1bf>
  102c13:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  102c17:	74 1f                	je     102c38 <vprintfmt+0x1ac>
  102c19:	83 fb 1f             	cmp    $0x1f,%ebx
  102c1c:	7e 05                	jle    102c23 <vprintfmt+0x197>
  102c1e:	83 fb 7e             	cmp    $0x7e,%ebx
  102c21:	7e 15                	jle    102c38 <vprintfmt+0x1ac>
  102c23:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c26:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c2a:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
  102c31:	8b 45 08             	mov    0x8(%ebp),%eax
  102c34:	ff d0                	call   *%eax
  102c36:	eb 0f                	jmp    102c47 <vprintfmt+0x1bb>
  102c38:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c3b:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c3f:	89 1c 24             	mov    %ebx,(%esp)
  102c42:	8b 45 08             	mov    0x8(%ebp),%eax
  102c45:	ff d0                	call   *%eax
  102c47:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
  102c4b:	89 f0                	mov    %esi,%eax
  102c4d:	8d 70 01             	lea    0x1(%eax),%esi
  102c50:	0f b6 00             	movzbl (%eax),%eax
  102c53:	0f be d8             	movsbl %al,%ebx
  102c56:	85 db                	test   %ebx,%ebx
  102c58:	74 10                	je     102c6a <vprintfmt+0x1de>
  102c5a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  102c5e:	78 b3                	js     102c13 <vprintfmt+0x187>
  102c60:	83 6d e0 01          	subl   $0x1,-0x20(%ebp)
  102c64:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  102c68:	79 a9                	jns    102c13 <vprintfmt+0x187>
  102c6a:	eb 17                	jmp    102c83 <vprintfmt+0x1f7>
  102c6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c6f:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c73:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  102c7a:	8b 45 08             	mov    0x8(%ebp),%eax
  102c7d:	ff d0                	call   *%eax
  102c7f:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
  102c83:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  102c87:	7f e3                	jg     102c6c <vprintfmt+0x1e0>
  102c89:	e9 4c 01 00 00       	jmp    102dda <vprintfmt+0x34e>
  102c8e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102c91:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c95:	8d 45 14             	lea    0x14(%ebp),%eax
  102c98:	89 04 24             	mov    %eax,(%esp)
  102c9b:	e8 a5 fd ff ff       	call   102a45 <getint>
  102ca0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102ca3:	89 55 f4             	mov    %edx,-0xc(%ebp)
  102ca6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102ca9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102cac:	85 d2                	test   %edx,%edx
  102cae:	79 26                	jns    102cd6 <vprintfmt+0x24a>
  102cb0:	8b 45 0c             	mov    0xc(%ebp),%eax
  102cb3:	89 44 24 04          	mov    %eax,0x4(%esp)
  102cb7:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
  102cbe:	8b 45 08             	mov    0x8(%ebp),%eax
  102cc1:	ff d0                	call   *%eax
  102cc3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102cc6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102cc9:	f7 d8                	neg    %eax
  102ccb:	83 d2 00             	adc    $0x0,%edx
  102cce:	f7 da                	neg    %edx
  102cd0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102cd3:	89 55 f4             	mov    %edx,-0xc(%ebp)
  102cd6:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
  102cdd:	e9 84 00 00 00       	jmp    102d66 <vprintfmt+0x2da>
  102ce2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102ce5:	89 44 24 04          	mov    %eax,0x4(%esp)
  102ce9:	8d 45 14             	lea    0x14(%ebp),%eax
  102cec:	89 04 24             	mov    %eax,(%esp)
  102cef:	e8 02 fd ff ff       	call   1029f6 <getuint>
  102cf4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102cf7:	89 55 f4             	mov    %edx,-0xc(%ebp)
  102cfa:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
  102d01:	eb 63                	jmp    102d66 <vprintfmt+0x2da>
  102d03:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d06:	89 44 24 04          	mov    %eax,0x4(%esp)
  102d0a:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
  102d11:	8b 45 08             	mov    0x8(%ebp),%eax
  102d14:	ff d0                	call   *%eax
  102d16:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d19:	89 44 24 04          	mov    %eax,0x4(%esp)
  102d1d:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
  102d24:	8b 45 08             	mov    0x8(%ebp),%eax
  102d27:	ff d0                	call   *%eax
  102d29:	8b 45 14             	mov    0x14(%ebp),%eax
  102d2c:	8d 50 04             	lea    0x4(%eax),%edx
  102d2f:	89 55 14             	mov    %edx,0x14(%ebp)
  102d32:	8b 00                	mov    (%eax),%eax
  102d34:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102d37:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  102d3e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
  102d45:	eb 1f                	jmp    102d66 <vprintfmt+0x2da>
  102d47:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102d4a:	89 44 24 04          	mov    %eax,0x4(%esp)
  102d4e:	8d 45 14             	lea    0x14(%ebp),%eax
  102d51:	89 04 24             	mov    %eax,(%esp)
  102d54:	e8 9d fc ff ff       	call   1029f6 <getuint>
  102d59:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102d5c:	89 55 f4             	mov    %edx,-0xc(%ebp)
  102d5f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
  102d66:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  102d6a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102d6d:	89 54 24 18          	mov    %edx,0x18(%esp)
  102d71:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102d74:	89 54 24 14          	mov    %edx,0x14(%esp)
  102d78:	89 44 24 10          	mov    %eax,0x10(%esp)
  102d7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102d7f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102d82:	89 44 24 08          	mov    %eax,0x8(%esp)
  102d86:	89 54 24 0c          	mov    %edx,0xc(%esp)
  102d8a:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d8d:	89 44 24 04          	mov    %eax,0x4(%esp)
  102d91:	8b 45 08             	mov    0x8(%ebp),%eax
  102d94:	89 04 24             	mov    %eax,(%esp)
  102d97:	e8 7c fb ff ff       	call   102918 <printnum>
  102d9c:	eb 3c                	jmp    102dda <vprintfmt+0x34e>
  102d9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  102da1:	89 44 24 04          	mov    %eax,0x4(%esp)
  102da5:	89 1c 24             	mov    %ebx,(%esp)
  102da8:	8b 45 08             	mov    0x8(%ebp),%eax
  102dab:	ff d0                	call   *%eax
  102dad:	eb 2b                	jmp    102dda <vprintfmt+0x34e>
  102daf:	8b 45 0c             	mov    0xc(%ebp),%eax
  102db2:	89 44 24 04          	mov    %eax,0x4(%esp)
  102db6:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  102dbd:	8b 45 08             	mov    0x8(%ebp),%eax
  102dc0:	ff d0                	call   *%eax
  102dc2:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  102dc6:	eb 04                	jmp    102dcc <vprintfmt+0x340>
  102dc8:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  102dcc:	8b 45 10             	mov    0x10(%ebp),%eax
  102dcf:	83 e8 01             	sub    $0x1,%eax
  102dd2:	0f b6 00             	movzbl (%eax),%eax
  102dd5:	3c 25                	cmp    $0x25,%al
  102dd7:	75 ef                	jne    102dc8 <vprintfmt+0x33c>
  102dd9:	90                   	nop
  102dda:	90                   	nop
  102ddb:	e9 ce fc ff ff       	jmp    102aae <vprintfmt+0x22>
  102de0:	83 c4 40             	add    $0x40,%esp
  102de3:	5b                   	pop    %ebx
  102de4:	5e                   	pop    %esi
  102de5:	5d                   	pop    %ebp
  102de6:	c3                   	ret    
  102de7:	90                   	nop

00102de8 <seg_init>:
  102de8:	55                   	push   %ebp
  102de9:	89 e5                	mov    %esp,%ebp
  102deb:	83 ec 28             	sub    $0x28,%esp
  102dee:	ba 00 f0 90 00       	mov    $0x90f000,%edx
  102df3:	b8 21 c5 10 00       	mov    $0x10c521,%eax
  102df8:	29 c2                	sub    %eax,%edx
  102dfa:	89 d0                	mov    %edx,%eax
  102dfc:	89 44 24 04          	mov    %eax,0x4(%esp)
  102e00:	c7 04 24 21 c5 10 00 	movl   $0x10c521,(%esp)
  102e07:	e8 41 f8 ff ff       	call   10264d <memzero>
  102e0c:	b8 00 40 d9 00       	mov    $0xd94000,%eax
  102e11:	8d 90 00 f0 ff ff    	lea    -0x1000(%eax),%edx
  102e17:	b8 00 f0 90 00       	mov    $0x90f000,%eax
  102e1c:	29 c2                	sub    %eax,%edx
  102e1e:	89 d0                	mov    %edx,%eax
  102e20:	89 44 24 04          	mov    %eax,0x4(%esp)
  102e24:	c7 04 24 00 00 91 00 	movl   $0x910000,(%esp)
  102e2b:	e8 1d f8 ff ff       	call   10264d <memzero>
  102e30:	c7 05 00 00 95 00 00 	movl   $0x0,0x950000
  102e37:	00 00 00 
  102e3a:	c7 05 04 00 95 00 00 	movl   $0x0,0x950004
  102e41:	00 00 00 
  102e44:	66 c7 05 08 00 95 00 	movw   $0xffff,0x950008
  102e4b:	ff ff 
  102e4d:	66 c7 05 0a 00 95 00 	movw   $0x0,0x95000a
  102e54:	00 00 
  102e56:	c6 05 0c 00 95 00 00 	movb   $0x0,0x95000c
  102e5d:	0f b6 05 0d 00 95 00 	movzbl 0x95000d,%eax
  102e64:	83 e0 f0             	and    $0xfffffff0,%eax
  102e67:	83 c8 0a             	or     $0xa,%eax
  102e6a:	a2 0d 00 95 00       	mov    %al,0x95000d
  102e6f:	0f b6 05 0d 00 95 00 	movzbl 0x95000d,%eax
  102e76:	83 c8 10             	or     $0x10,%eax
  102e79:	a2 0d 00 95 00       	mov    %al,0x95000d
  102e7e:	0f b6 05 0d 00 95 00 	movzbl 0x95000d,%eax
  102e85:	83 e0 9f             	and    $0xffffff9f,%eax
  102e88:	a2 0d 00 95 00       	mov    %al,0x95000d
  102e8d:	0f b6 05 0d 00 95 00 	movzbl 0x95000d,%eax
  102e94:	83 c8 80             	or     $0xffffff80,%eax
  102e97:	a2 0d 00 95 00       	mov    %al,0x95000d
  102e9c:	0f b6 05 0e 00 95 00 	movzbl 0x95000e,%eax
  102ea3:	83 c8 0f             	or     $0xf,%eax
  102ea6:	a2 0e 00 95 00       	mov    %al,0x95000e
  102eab:	0f b6 05 0e 00 95 00 	movzbl 0x95000e,%eax
  102eb2:	83 e0 ef             	and    $0xffffffef,%eax
  102eb5:	a2 0e 00 95 00       	mov    %al,0x95000e
  102eba:	0f b6 05 0e 00 95 00 	movzbl 0x95000e,%eax
  102ec1:	83 e0 df             	and    $0xffffffdf,%eax
  102ec4:	a2 0e 00 95 00       	mov    %al,0x95000e
  102ec9:	0f b6 05 0e 00 95 00 	movzbl 0x95000e,%eax
  102ed0:	83 c8 40             	or     $0x40,%eax
  102ed3:	a2 0e 00 95 00       	mov    %al,0x95000e
  102ed8:	0f b6 05 0e 00 95 00 	movzbl 0x95000e,%eax
  102edf:	83 c8 80             	or     $0xffffff80,%eax
  102ee2:	a2 0e 00 95 00       	mov    %al,0x95000e
  102ee7:	c6 05 0f 00 95 00 00 	movb   $0x0,0x95000f
  102eee:	66 c7 05 10 00 95 00 	movw   $0xffff,0x950010
  102ef5:	ff ff 
  102ef7:	66 c7 05 12 00 95 00 	movw   $0x0,0x950012
  102efe:	00 00 
  102f00:	c6 05 14 00 95 00 00 	movb   $0x0,0x950014
  102f07:	0f b6 05 15 00 95 00 	movzbl 0x950015,%eax
  102f0e:	83 e0 f0             	and    $0xfffffff0,%eax
  102f11:	83 c8 02             	or     $0x2,%eax
  102f14:	a2 15 00 95 00       	mov    %al,0x950015
  102f19:	0f b6 05 15 00 95 00 	movzbl 0x950015,%eax
  102f20:	83 c8 10             	or     $0x10,%eax
  102f23:	a2 15 00 95 00       	mov    %al,0x950015
  102f28:	0f b6 05 15 00 95 00 	movzbl 0x950015,%eax
  102f2f:	83 e0 9f             	and    $0xffffff9f,%eax
  102f32:	a2 15 00 95 00       	mov    %al,0x950015
  102f37:	0f b6 05 15 00 95 00 	movzbl 0x950015,%eax
  102f3e:	83 c8 80             	or     $0xffffff80,%eax
  102f41:	a2 15 00 95 00       	mov    %al,0x950015
  102f46:	0f b6 05 16 00 95 00 	movzbl 0x950016,%eax
  102f4d:	83 c8 0f             	or     $0xf,%eax
  102f50:	a2 16 00 95 00       	mov    %al,0x950016
  102f55:	0f b6 05 16 00 95 00 	movzbl 0x950016,%eax
  102f5c:	83 e0 ef             	and    $0xffffffef,%eax
  102f5f:	a2 16 00 95 00       	mov    %al,0x950016
  102f64:	0f b6 05 16 00 95 00 	movzbl 0x950016,%eax
  102f6b:	83 e0 df             	and    $0xffffffdf,%eax
  102f6e:	a2 16 00 95 00       	mov    %al,0x950016
  102f73:	0f b6 05 16 00 95 00 	movzbl 0x950016,%eax
  102f7a:	83 c8 40             	or     $0x40,%eax
  102f7d:	a2 16 00 95 00       	mov    %al,0x950016
  102f82:	0f b6 05 16 00 95 00 	movzbl 0x950016,%eax
  102f89:	83 c8 80             	or     $0xffffff80,%eax
  102f8c:	a2 16 00 95 00       	mov    %al,0x950016
  102f91:	c6 05 17 00 95 00 00 	movb   $0x0,0x950017
  102f98:	66 c7 05 18 00 95 00 	movw   $0xffff,0x950018
  102f9f:	ff ff 
  102fa1:	66 c7 05 1a 00 95 00 	movw   $0x0,0x95001a
  102fa8:	00 00 
  102faa:	c6 05 1c 00 95 00 00 	movb   $0x0,0x95001c
  102fb1:	0f b6 05 1d 00 95 00 	movzbl 0x95001d,%eax
  102fb8:	83 e0 f0             	and    $0xfffffff0,%eax
  102fbb:	83 c8 0a             	or     $0xa,%eax
  102fbe:	a2 1d 00 95 00       	mov    %al,0x95001d
  102fc3:	0f b6 05 1d 00 95 00 	movzbl 0x95001d,%eax
  102fca:	83 c8 10             	or     $0x10,%eax
  102fcd:	a2 1d 00 95 00       	mov    %al,0x95001d
  102fd2:	0f b6 05 1d 00 95 00 	movzbl 0x95001d,%eax
  102fd9:	83 c8 60             	or     $0x60,%eax
  102fdc:	a2 1d 00 95 00       	mov    %al,0x95001d
  102fe1:	0f b6 05 1d 00 95 00 	movzbl 0x95001d,%eax
  102fe8:	83 c8 80             	or     $0xffffff80,%eax
  102feb:	a2 1d 00 95 00       	mov    %al,0x95001d
  102ff0:	0f b6 05 1e 00 95 00 	movzbl 0x95001e,%eax
  102ff7:	83 c8 0f             	or     $0xf,%eax
  102ffa:	a2 1e 00 95 00       	mov    %al,0x95001e
  102fff:	0f b6 05 1e 00 95 00 	movzbl 0x95001e,%eax
  103006:	83 e0 ef             	and    $0xffffffef,%eax
  103009:	a2 1e 00 95 00       	mov    %al,0x95001e
  10300e:	0f b6 05 1e 00 95 00 	movzbl 0x95001e,%eax
  103015:	83 e0 df             	and    $0xffffffdf,%eax
  103018:	a2 1e 00 95 00       	mov    %al,0x95001e
  10301d:	0f b6 05 1e 00 95 00 	movzbl 0x95001e,%eax
  103024:	83 c8 40             	or     $0x40,%eax
  103027:	a2 1e 00 95 00       	mov    %al,0x95001e
  10302c:	0f b6 05 1e 00 95 00 	movzbl 0x95001e,%eax
  103033:	83 c8 80             	or     $0xffffff80,%eax
  103036:	a2 1e 00 95 00       	mov    %al,0x95001e
  10303b:	c6 05 1f 00 95 00 00 	movb   $0x0,0x95001f
  103042:	66 c7 05 20 00 95 00 	movw   $0xffff,0x950020
  103049:	ff ff 
  10304b:	66 c7 05 22 00 95 00 	movw   $0x0,0x950022
  103052:	00 00 
  103054:	c6 05 24 00 95 00 00 	movb   $0x0,0x950024
  10305b:	0f b6 05 25 00 95 00 	movzbl 0x950025,%eax
  103062:	83 e0 f0             	and    $0xfffffff0,%eax
  103065:	83 c8 02             	or     $0x2,%eax
  103068:	a2 25 00 95 00       	mov    %al,0x950025
  10306d:	0f b6 05 25 00 95 00 	movzbl 0x950025,%eax
  103074:	83 c8 10             	or     $0x10,%eax
  103077:	a2 25 00 95 00       	mov    %al,0x950025
  10307c:	0f b6 05 25 00 95 00 	movzbl 0x950025,%eax
  103083:	83 c8 60             	or     $0x60,%eax
  103086:	a2 25 00 95 00       	mov    %al,0x950025
  10308b:	0f b6 05 25 00 95 00 	movzbl 0x950025,%eax
  103092:	83 c8 80             	or     $0xffffff80,%eax
  103095:	a2 25 00 95 00       	mov    %al,0x950025
  10309a:	0f b6 05 26 00 95 00 	movzbl 0x950026,%eax
  1030a1:	83 c8 0f             	or     $0xf,%eax
  1030a4:	a2 26 00 95 00       	mov    %al,0x950026
  1030a9:	0f b6 05 26 00 95 00 	movzbl 0x950026,%eax
  1030b0:	83 e0 ef             	and    $0xffffffef,%eax
  1030b3:	a2 26 00 95 00       	mov    %al,0x950026
  1030b8:	0f b6 05 26 00 95 00 	movzbl 0x950026,%eax
  1030bf:	83 e0 df             	and    $0xffffffdf,%eax
  1030c2:	a2 26 00 95 00       	mov    %al,0x950026
  1030c7:	0f b6 05 26 00 95 00 	movzbl 0x950026,%eax
  1030ce:	83 c8 40             	or     $0x40,%eax
  1030d1:	a2 26 00 95 00       	mov    %al,0x950026
  1030d6:	0f b6 05 26 00 95 00 	movzbl 0x950026,%eax
  1030dd:	83 c8 80             	or     $0xffffff80,%eax
  1030e0:	a2 26 00 95 00       	mov    %al,0x950026
  1030e5:	c6 05 27 00 95 00 00 	movb   $0x0,0x950027
  1030ec:	b8 00 f0 90 00       	mov    $0x90f000,%eax
  1030f1:	05 00 10 00 00       	add    $0x1000,%eax
  1030f6:	a3 64 de 10 00       	mov    %eax,0x10de64
  1030fb:	66 c7 05 68 de 10 00 	movw   $0x10,0x10de68
  103102:	10 00 
  103104:	66 c7 05 28 00 95 00 	movw   $0xeb,0x950028
  10310b:	eb 00 
  10310d:	b8 60 de 10 00       	mov    $0x10de60,%eax
  103112:	66 a3 2a 00 95 00    	mov    %ax,0x95002a
  103118:	b8 60 de 10 00       	mov    $0x10de60,%eax
  10311d:	c1 e8 10             	shr    $0x10,%eax
  103120:	a2 2c 00 95 00       	mov    %al,0x95002c
  103125:	0f b6 05 2d 00 95 00 	movzbl 0x95002d,%eax
  10312c:	83 e0 f0             	and    $0xfffffff0,%eax
  10312f:	83 c8 09             	or     $0x9,%eax
  103132:	a2 2d 00 95 00       	mov    %al,0x95002d
  103137:	0f b6 05 2d 00 95 00 	movzbl 0x95002d,%eax
  10313e:	83 c8 10             	or     $0x10,%eax
  103141:	a2 2d 00 95 00       	mov    %al,0x95002d
  103146:	0f b6 05 2d 00 95 00 	movzbl 0x95002d,%eax
  10314d:	83 e0 9f             	and    $0xffffff9f,%eax
  103150:	a2 2d 00 95 00       	mov    %al,0x95002d
  103155:	0f b6 05 2d 00 95 00 	movzbl 0x95002d,%eax
  10315c:	83 c8 80             	or     $0xffffff80,%eax
  10315f:	a2 2d 00 95 00       	mov    %al,0x95002d
  103164:	0f b6 05 2e 00 95 00 	movzbl 0x95002e,%eax
  10316b:	83 e0 f0             	and    $0xfffffff0,%eax
  10316e:	a2 2e 00 95 00       	mov    %al,0x95002e
  103173:	0f b6 05 2e 00 95 00 	movzbl 0x95002e,%eax
  10317a:	83 e0 ef             	and    $0xffffffef,%eax
  10317d:	a2 2e 00 95 00       	mov    %al,0x95002e
  103182:	0f b6 05 2e 00 95 00 	movzbl 0x95002e,%eax
  103189:	83 e0 df             	and    $0xffffffdf,%eax
  10318c:	a2 2e 00 95 00       	mov    %al,0x95002e
  103191:	0f b6 05 2e 00 95 00 	movzbl 0x95002e,%eax
  103198:	83 c8 40             	or     $0x40,%eax
  10319b:	a2 2e 00 95 00       	mov    %al,0x95002e
  1031a0:	0f b6 05 2e 00 95 00 	movzbl 0x95002e,%eax
  1031a7:	83 e0 7f             	and    $0x7f,%eax
  1031aa:	a2 2e 00 95 00       	mov    %al,0x95002e
  1031af:	b8 60 de 10 00       	mov    $0x10de60,%eax
  1031b4:	c1 e8 18             	shr    $0x18,%eax
  1031b7:	a2 2f 00 95 00       	mov    %al,0x95002f
  1031bc:	0f b6 05 2d 00 95 00 	movzbl 0x95002d,%eax
  1031c3:	83 e0 ef             	and    $0xffffffef,%eax
  1031c6:	a2 2d 00 95 00       	mov    %al,0x95002d
  1031cb:	66 c7 45 ee 2f 00    	movw   $0x2f,-0x12(%ebp)
  1031d1:	b8 00 00 95 00       	mov    $0x950000,%eax
  1031d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1031d9:	0f 01 55 ee          	lgdtl  -0x12(%ebp)
  1031dd:	b8 10 00 00 00       	mov    $0x10,%eax
  1031e2:	8e e8                	mov    %eax,%gs
  1031e4:	b8 10 00 00 00       	mov    $0x10,%eax
  1031e9:	8e e0                	mov    %eax,%fs
  1031eb:	b8 10 00 00 00       	mov    $0x10,%eax
  1031f0:	8e c0                	mov    %eax,%es
  1031f2:	b8 10 00 00 00       	mov    $0x10,%eax
  1031f7:	8e d8                	mov    %eax,%ds
  1031f9:	b8 10 00 00 00       	mov    $0x10,%eax
  1031fe:	8e d0                	mov    %eax,%ss
  103200:	ea 07 32 10 00 08 00 	ljmp   $0x8,$0x103207
  103207:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10320e:	e8 45 01 00 00       	call   103358 <lldt>
  103213:	c7 04 24 28 00 00 00 	movl   $0x28,(%esp)
  10321a:	e8 62 03 00 00       	call   103581 <ltr>
  10321f:	0f 01 1d 10 85 10 00 	lidtl  0x108510
  103226:	c7 44 24 04 00 3b 00 	movl   $0x3b00,0x4(%esp)
  10322d:	00 
  10322e:	c7 04 24 40 00 95 00 	movl   $0x950040,(%esp)
  103235:	e8 13 f4 ff ff       	call   10264d <memzero>
  10323a:	c7 44 24 04 00 00 04 	movl   $0x40000,0x4(%esp)
  103241:	00 
  103242:	c7 04 24 00 00 91 00 	movl   $0x910000,(%esp)
  103249:	e8 ff f3 ff ff       	call   10264d <memzero>
  10324e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  103255:	e9 83 00 00 00       	jmp    1032dd <seg_init+0x4f5>
  10325a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10325d:	c1 e0 0c             	shl    $0xc,%eax
  103260:	05 00 00 91 00       	add    $0x910000,%eax
  103265:	8d 90 00 10 00 00    	lea    0x1000(%eax),%edx
  10326b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10326e:	69 c0 ec 00 00 00    	imul   $0xec,%eax,%eax
  103274:	05 44 00 95 00       	add    $0x950044,%eax
  103279:	89 10                	mov    %edx,(%eax)
  10327b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10327e:	69 c0 ec 00 00 00    	imul   $0xec,%eax,%eax
  103284:	05 40 00 95 00       	add    $0x950040,%eax
  103289:	66 c7 40 08 10 00    	movw   $0x10,0x8(%eax)
  10328f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103292:	69 c0 ec 00 00 00    	imul   $0xec,%eax,%eax
  103298:	05 a0 00 95 00       	add    $0x9500a0,%eax
  10329d:	66 c7 40 06 68 00    	movw   $0x68,0x6(%eax)
  1032a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1032a6:	69 c0 ec 00 00 00    	imul   $0xec,%eax,%eax
  1032ac:	83 c0 60             	add    $0x60,%eax
  1032af:	05 40 00 95 00       	add    $0x950040,%eax
  1032b4:	83 c0 08             	add    $0x8,%eax
  1032b7:	c7 44 24 04 80 00 00 	movl   $0x80,0x4(%esp)
  1032be:	00 
  1032bf:	89 04 24             	mov    %eax,(%esp)
  1032c2:	e8 86 f3 ff ff       	call   10264d <memzero>
  1032c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1032ca:	69 c0 ec 00 00 00    	imul   $0xec,%eax,%eax
  1032d0:	05 20 01 95 00       	add    $0x950120,%eax
  1032d5:	c6 40 08 ff          	movb   $0xff,0x8(%eax)
  1032d9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  1032dd:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
  1032e1:	0f 86 73 ff ff ff    	jbe    10325a <seg_init+0x472>
  1032e7:	c9                   	leave  
  1032e8:	c3                   	ret    
  1032e9:	66 90                	xchg   %ax,%ax
  1032eb:	90                   	nop

001032ec <max>:
  1032ec:	55                   	push   %ebp
  1032ed:	89 e5                	mov    %esp,%ebp
  1032ef:	8b 45 08             	mov    0x8(%ebp),%eax
  1032f2:	39 45 0c             	cmp    %eax,0xc(%ebp)
  1032f5:	0f 43 45 0c          	cmovae 0xc(%ebp),%eax
  1032f9:	5d                   	pop    %ebp
  1032fa:	c3                   	ret    

001032fb <min>:
  1032fb:	55                   	push   %ebp
  1032fc:	89 e5                	mov    %esp,%ebp
  1032fe:	8b 45 08             	mov    0x8(%ebp),%eax
  103301:	39 45 0c             	cmp    %eax,0xc(%ebp)
  103304:	0f 46 45 0c          	cmovbe 0xc(%ebp),%eax
  103308:	5d                   	pop    %ebp
  103309:	c3                   	ret    

0010330a <rounddown>:
  10330a:	55                   	push   %ebp
  10330b:	89 e5                	mov    %esp,%ebp
  10330d:	8b 45 08             	mov    0x8(%ebp),%eax
  103310:	ba 00 00 00 00       	mov    $0x0,%edx
  103315:	f7 75 0c             	divl   0xc(%ebp)
  103318:	89 d0                	mov    %edx,%eax
  10331a:	8b 55 08             	mov    0x8(%ebp),%edx
  10331d:	29 c2                	sub    %eax,%edx
  10331f:	89 d0                	mov    %edx,%eax
  103321:	5d                   	pop    %ebp
  103322:	c3                   	ret    

00103323 <roundup>:
  103323:	55                   	push   %ebp
  103324:	89 e5                	mov    %esp,%ebp
  103326:	83 ec 08             	sub    $0x8,%esp
  103329:	8b 45 0c             	mov    0xc(%ebp),%eax
  10332c:	8b 55 08             	mov    0x8(%ebp),%edx
  10332f:	01 d0                	add    %edx,%eax
  103331:	8d 50 ff             	lea    -0x1(%eax),%edx
  103334:	8b 45 0c             	mov    0xc(%ebp),%eax
  103337:	89 44 24 04          	mov    %eax,0x4(%esp)
  10333b:	89 14 24             	mov    %edx,(%esp)
  10333e:	e8 c7 ff ff ff       	call   10330a <rounddown>
  103343:	c9                   	leave  
  103344:	c3                   	ret    
  103345:	66 90                	xchg   %ax,%ax
  103347:	90                   	nop

00103348 <read_ebp>:
  103348:	55                   	push   %ebp
  103349:	89 e5                	mov    %esp,%ebp
  10334b:	83 ec 10             	sub    $0x10,%esp
  10334e:	89 e8                	mov    %ebp,%eax
  103350:	89 45 fc             	mov    %eax,-0x4(%ebp)
  103353:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103356:	c9                   	leave  
  103357:	c3                   	ret    

00103358 <lldt>:
  103358:	55                   	push   %ebp
  103359:	89 e5                	mov    %esp,%ebp
  10335b:	83 ec 04             	sub    $0x4,%esp
  10335e:	8b 45 08             	mov    0x8(%ebp),%eax
  103361:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  103365:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
  103369:	0f 00 d0             	lldt   %ax
  10336c:	c9                   	leave  
  10336d:	c3                   	ret    

0010336e <cli>:
  10336e:	55                   	push   %ebp
  10336f:	89 e5                	mov    %esp,%ebp
  103371:	fa                   	cli    
  103372:	5d                   	pop    %ebp
  103373:	c3                   	ret    

00103374 <sti>:
  103374:	55                   	push   %ebp
  103375:	89 e5                	mov    %esp,%ebp
  103377:	fb                   	sti    
  103378:	90                   	nop
  103379:	5d                   	pop    %ebp
  10337a:	c3                   	ret    

0010337b <rdmsr>:
  10337b:	55                   	push   %ebp
  10337c:	89 e5                	mov    %esp,%ebp
  10337e:	83 ec 10             	sub    $0x10,%esp
  103381:	8b 45 08             	mov    0x8(%ebp),%eax
  103384:	89 c1                	mov    %eax,%ecx
  103386:	0f 32                	rdmsr  
  103388:	89 45 f8             	mov    %eax,-0x8(%ebp)
  10338b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  10338e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103391:	8b 55 fc             	mov    -0x4(%ebp),%edx
  103394:	c9                   	leave  
  103395:	c3                   	ret    

00103396 <wrmsr>:
  103396:	55                   	push   %ebp
  103397:	89 e5                	mov    %esp,%ebp
  103399:	83 ec 08             	sub    $0x8,%esp
  10339c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10339f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1033a2:	8b 45 10             	mov    0x10(%ebp),%eax
  1033a5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1033a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1033ab:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1033ae:	8b 4d 08             	mov    0x8(%ebp),%ecx
  1033b1:	0f 30                	wrmsr  
  1033b3:	c9                   	leave  
  1033b4:	c3                   	ret    

001033b5 <halt>:
  1033b5:	55                   	push   %ebp
  1033b6:	89 e5                	mov    %esp,%ebp
  1033b8:	f4                   	hlt    
  1033b9:	5d                   	pop    %ebp
  1033ba:	c3                   	ret    

001033bb <rdtsc>:
  1033bb:	55                   	push   %ebp
  1033bc:	89 e5                	mov    %esp,%ebp
  1033be:	83 ec 10             	sub    $0x10,%esp
  1033c1:	0f 31                	rdtsc  
  1033c3:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1033c6:	89 55 fc             	mov    %edx,-0x4(%ebp)
  1033c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1033cc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1033cf:	c9                   	leave  
  1033d0:	c3                   	ret    

001033d1 <enable_sse>:
  1033d1:	55                   	push   %ebp
  1033d2:	89 e5                	mov    %esp,%ebp
  1033d4:	83 ec 20             	sub    $0x20,%esp
  1033d7:	0f 20 e0             	mov    %cr4,%eax
  1033da:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1033dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1033e0:	80 cc 06             	or     $0x6,%ah
  1033e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1033e6:	0f ae f0             	mfence 
  1033e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1033ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1033ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1033f2:	0f 22 e0             	mov    %eax,%cr4
  1033f5:	0f 20 c0             	mov    %cr0,%eax
  1033f8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1033fb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1033fe:	83 c8 02             	or     $0x2,%eax
  103401:	89 45 f8             	mov    %eax,-0x8(%ebp)
  103404:	0f ae f0             	mfence 
  103407:	83 65 f8 f3          	andl   $0xfffffff3,-0x8(%ebp)
  10340b:	c9                   	leave  
  10340c:	c3                   	ret    

0010340d <cpuid>:
  10340d:	55                   	push   %ebp
  10340e:	89 e5                	mov    %esp,%ebp
  103410:	53                   	push   %ebx
  103411:	83 ec 10             	sub    $0x10,%esp
  103414:	8b 45 08             	mov    0x8(%ebp),%eax
  103417:	0f a2                	cpuid  
  103419:	89 45 f8             	mov    %eax,-0x8(%ebp)
  10341c:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  10341f:	89 4d f0             	mov    %ecx,-0x10(%ebp)
  103422:	89 55 ec             	mov    %edx,-0x14(%ebp)
  103425:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  103429:	74 08                	je     103433 <cpuid+0x26>
  10342b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10342e:	8b 55 f8             	mov    -0x8(%ebp),%edx
  103431:	89 10                	mov    %edx,(%eax)
  103433:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103437:	74 08                	je     103441 <cpuid+0x34>
  103439:	8b 45 10             	mov    0x10(%ebp),%eax
  10343c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10343f:	89 10                	mov    %edx,(%eax)
  103441:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
  103445:	74 08                	je     10344f <cpuid+0x42>
  103447:	8b 45 14             	mov    0x14(%ebp),%eax
  10344a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10344d:	89 10                	mov    %edx,(%eax)
  10344f:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
  103453:	74 08                	je     10345d <cpuid+0x50>
  103455:	8b 45 18             	mov    0x18(%ebp),%eax
  103458:	8b 55 ec             	mov    -0x14(%ebp),%edx
  10345b:	89 10                	mov    %edx,(%eax)
  10345d:	83 c4 10             	add    $0x10,%esp
  103460:	5b                   	pop    %ebx
  103461:	5d                   	pop    %ebp
  103462:	c3                   	ret    

00103463 <vendor>:
  103463:	55                   	push   %ebp
  103464:	89 e5                	mov    %esp,%ebp
  103466:	53                   	push   %ebx
  103467:	83 ec 64             	sub    $0x64,%esp
  10346a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  103471:	8d 45 d0             	lea    -0x30(%ebp),%eax
  103474:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103477:	8d 45 cc             	lea    -0x34(%ebp),%eax
  10347a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10347d:	8d 45 c8             	lea    -0x38(%ebp),%eax
  103480:	89 45 e8             	mov    %eax,-0x18(%ebp)
  103483:	8d 45 c4             	lea    -0x3c(%ebp),%eax
  103486:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  103489:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10348c:	0f a2                	cpuid  
  10348e:	89 45 e0             	mov    %eax,-0x20(%ebp)
  103491:	89 5d dc             	mov    %ebx,-0x24(%ebp)
  103494:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  103497:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  10349a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  10349e:	74 08                	je     1034a8 <vendor+0x45>
  1034a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1034a3:	8b 55 e0             	mov    -0x20(%ebp),%edx
  1034a6:	89 10                	mov    %edx,(%eax)
  1034a8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  1034ac:	74 08                	je     1034b6 <vendor+0x53>
  1034ae:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1034b1:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1034b4:	89 10                	mov    %edx,(%eax)
  1034b6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1034ba:	74 08                	je     1034c4 <vendor+0x61>
  1034bc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1034bf:	8b 55 d8             	mov    -0x28(%ebp),%edx
  1034c2:	89 10                	mov    %edx,(%eax)
  1034c4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  1034c8:	74 08                	je     1034d2 <vendor+0x6f>
  1034ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1034cd:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1034d0:	89 10                	mov    %edx,(%eax)
  1034d2:	8d 45 b7             	lea    -0x49(%ebp),%eax
  1034d5:	8b 55 cc             	mov    -0x34(%ebp),%edx
  1034d8:	89 10                	mov    %edx,(%eax)
  1034da:	8d 45 b7             	lea    -0x49(%ebp),%eax
  1034dd:	83 c0 04             	add    $0x4,%eax
  1034e0:	8b 55 c4             	mov    -0x3c(%ebp),%edx
  1034e3:	89 10                	mov    %edx,(%eax)
  1034e5:	8d 45 b7             	lea    -0x49(%ebp),%eax
  1034e8:	83 c0 08             	add    $0x8,%eax
  1034eb:	8b 55 c8             	mov    -0x38(%ebp),%edx
  1034ee:	89 10                	mov    %edx,(%eax)
  1034f0:	c6 45 c3 00          	movb   $0x0,-0x3d(%ebp)
  1034f4:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
  1034fb:	00 
  1034fc:	c7 44 24 04 90 55 10 	movl   $0x105590,0x4(%esp)
  103503:	00 
  103504:	8d 45 b7             	lea    -0x49(%ebp),%eax
  103507:	89 04 24             	mov    %eax,(%esp)
  10350a:	e8 46 f0 ff ff       	call   102555 <strncmp>
  10350f:	85 c0                	test   %eax,%eax
  103511:	75 07                	jne    10351a <vendor+0xb7>
  103513:	b8 01 00 00 00       	mov    $0x1,%eax
  103518:	eb 2b                	jmp    103545 <vendor+0xe2>
  10351a:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
  103521:	00 
  103522:	c7 44 24 04 9d 55 10 	movl   $0x10559d,0x4(%esp)
  103529:	00 
  10352a:	8d 45 b7             	lea    -0x49(%ebp),%eax
  10352d:	89 04 24             	mov    %eax,(%esp)
  103530:	e8 20 f0 ff ff       	call   102555 <strncmp>
  103535:	85 c0                	test   %eax,%eax
  103537:	75 07                	jne    103540 <vendor+0xdd>
  103539:	b8 02 00 00 00       	mov    $0x2,%eax
  10353e:	eb 05                	jmp    103545 <vendor+0xe2>
  103540:	b8 00 00 00 00       	mov    $0x0,%eax
  103545:	83 c4 64             	add    $0x64,%esp
  103548:	5b                   	pop    %ebx
  103549:	5d                   	pop    %ebp
  10354a:	c3                   	ret    

0010354b <rcr3>:
  10354b:	55                   	push   %ebp
  10354c:	89 e5                	mov    %esp,%ebp
  10354e:	83 ec 10             	sub    $0x10,%esp
  103551:	0f 20 d8             	mov    %cr3,%eax
  103554:	89 45 fc             	mov    %eax,-0x4(%ebp)
  103557:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10355a:	c9                   	leave  
  10355b:	c3                   	ret    

0010355c <outl>:
  10355c:	55                   	push   %ebp
  10355d:	89 e5                	mov    %esp,%ebp
  10355f:	8b 45 0c             	mov    0xc(%ebp),%eax
  103562:	8b 55 08             	mov    0x8(%ebp),%edx
  103565:	ef                   	out    %eax,(%dx)
  103566:	5d                   	pop    %ebp
  103567:	c3                   	ret    

00103568 <inl>:
  103568:	55                   	push   %ebp
  103569:	89 e5                	mov    %esp,%ebp
  10356b:	83 ec 10             	sub    $0x10,%esp
  10356e:	8b 45 08             	mov    0x8(%ebp),%eax
  103571:	89 c2                	mov    %eax,%edx
  103573:	ed                   	in     (%dx),%eax
  103574:	89 45 fc             	mov    %eax,-0x4(%ebp)
  103577:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10357a:	c9                   	leave  
  10357b:	c3                   	ret    

0010357c <smp_wmb>:
  10357c:	55                   	push   %ebp
  10357d:	89 e5                	mov    %esp,%ebp
  10357f:	5d                   	pop    %ebp
  103580:	c3                   	ret    

00103581 <ltr>:
  103581:	55                   	push   %ebp
  103582:	89 e5                	mov    %esp,%ebp
  103584:	83 ec 04             	sub    $0x4,%esp
  103587:	8b 45 08             	mov    0x8(%ebp),%eax
  10358a:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  10358e:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
  103592:	0f 00 d8             	ltr    %ax
  103595:	c9                   	leave  
  103596:	c3                   	ret    

00103597 <lcr0>:
  103597:	55                   	push   %ebp
  103598:	89 e5                	mov    %esp,%ebp
  10359a:	8b 45 08             	mov    0x8(%ebp),%eax
  10359d:	0f 22 c0             	mov    %eax,%cr0
  1035a0:	5d                   	pop    %ebp
  1035a1:	c3                   	ret    

001035a2 <rcr0>:
  1035a2:	55                   	push   %ebp
  1035a3:	89 e5                	mov    %esp,%ebp
  1035a5:	83 ec 10             	sub    $0x10,%esp
  1035a8:	0f 20 c0             	mov    %cr0,%eax
  1035ab:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1035ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1035b1:	c9                   	leave  
  1035b2:	c3                   	ret    

001035b3 <rcr2>:
  1035b3:	55                   	push   %ebp
  1035b4:	89 e5                	mov    %esp,%ebp
  1035b6:	83 ec 10             	sub    $0x10,%esp
  1035b9:	0f 20 d0             	mov    %cr2,%eax
  1035bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1035bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1035c2:	c9                   	leave  
  1035c3:	c3                   	ret    

001035c4 <lcr3>:
  1035c4:	55                   	push   %ebp
  1035c5:	89 e5                	mov    %esp,%ebp
  1035c7:	8b 45 08             	mov    0x8(%ebp),%eax
  1035ca:	0f 22 d8             	mov    %eax,%cr3
  1035cd:	5d                   	pop    %ebp
  1035ce:	c3                   	ret    

001035cf <lcr4>:
  1035cf:	55                   	push   %ebp
  1035d0:	89 e5                	mov    %esp,%ebp
  1035d2:	8b 45 08             	mov    0x8(%ebp),%eax
  1035d5:	0f 22 e0             	mov    %eax,%cr4
  1035d8:	5d                   	pop    %ebp
  1035d9:	c3                   	ret    

001035da <rcr4>:
  1035da:	55                   	push   %ebp
  1035db:	89 e5                	mov    %esp,%ebp
  1035dd:	83 ec 10             	sub    $0x10,%esp
  1035e0:	0f 20 e0             	mov    %cr4,%eax
  1035e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1035e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1035e9:	c9                   	leave  
  1035ea:	c3                   	ret    

001035eb <inb>:
  1035eb:	55                   	push   %ebp
  1035ec:	89 e5                	mov    %esp,%ebp
  1035ee:	83 ec 10             	sub    $0x10,%esp
  1035f1:	8b 45 08             	mov    0x8(%ebp),%eax
  1035f4:	89 c2                	mov    %eax,%edx
  1035f6:	ec                   	in     (%dx),%al
  1035f7:	88 45 ff             	mov    %al,-0x1(%ebp)
  1035fa:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
  1035fe:	c9                   	leave  
  1035ff:	c3                   	ret    

00103600 <insl>:
  103600:	55                   	push   %ebp
  103601:	89 e5                	mov    %esp,%ebp
  103603:	57                   	push   %edi
  103604:	53                   	push   %ebx
  103605:	8b 55 08             	mov    0x8(%ebp),%edx
  103608:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  10360b:	8b 45 10             	mov    0x10(%ebp),%eax
  10360e:	89 cb                	mov    %ecx,%ebx
  103610:	89 df                	mov    %ebx,%edi
  103612:	89 c1                	mov    %eax,%ecx
  103614:	fc                   	cld    
  103615:	f2 6d                	repnz insl (%dx),%es:(%edi)
  103617:	89 c8                	mov    %ecx,%eax
  103619:	89 fb                	mov    %edi,%ebx
  10361b:	89 5d 0c             	mov    %ebx,0xc(%ebp)
  10361e:	89 45 10             	mov    %eax,0x10(%ebp)
  103621:	5b                   	pop    %ebx
  103622:	5f                   	pop    %edi
  103623:	5d                   	pop    %ebp
  103624:	c3                   	ret    

00103625 <outb>:
  103625:	55                   	push   %ebp
  103626:	89 e5                	mov    %esp,%ebp
  103628:	83 ec 04             	sub    $0x4,%esp
  10362b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10362e:	88 45 fc             	mov    %al,-0x4(%ebp)
  103631:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  103635:	8b 55 08             	mov    0x8(%ebp),%edx
  103638:	ee                   	out    %al,(%dx)
  103639:	c9                   	leave  
  10363a:	c3                   	ret    

0010363b <outsw>:
  10363b:	55                   	push   %ebp
  10363c:	89 e5                	mov    %esp,%ebp
  10363e:	56                   	push   %esi
  10363f:	53                   	push   %ebx
  103640:	8b 55 08             	mov    0x8(%ebp),%edx
  103643:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  103646:	8b 45 10             	mov    0x10(%ebp),%eax
  103649:	89 cb                	mov    %ecx,%ebx
  10364b:	89 de                	mov    %ebx,%esi
  10364d:	89 c1                	mov    %eax,%ecx
  10364f:	fc                   	cld    
  103650:	f2 66 6f             	repnz outsw %ds:(%esi),(%dx)
  103653:	89 c8                	mov    %ecx,%eax
  103655:	89 f3                	mov    %esi,%ebx
  103657:	89 5d 0c             	mov    %ebx,0xc(%ebp)
  10365a:	89 45 10             	mov    %eax,0x10(%ebp)
  10365d:	5b                   	pop    %ebx
  10365e:	5e                   	pop    %esi
  10365f:	5d                   	pop    %ebp
  103660:	c3                   	ret    
  103661:	66 90                	xchg   %ax,%ax
  103663:	90                   	nop

00103664 <mon_start_user>:
  103664:	55                   	push   %ebp
  103665:	89 e5                	mov    %esp,%ebp
  103667:	83 ec 28             	sub    $0x28,%esp
  10366a:	a1 4c df 10 00       	mov    0x10df4c,%eax
  10366f:	85 c0                	test   %eax,%eax
  103671:	74 13                	je     103686 <mon_start_user+0x22>
  103673:	c7 04 24 20 56 10 00 	movl   $0x105620,(%esp)
  10367a:	e8 72 f2 ff ff       	call   1028f1 <dprintf>
  10367f:	b8 00 00 00 00       	mov    $0x0,%eax
  103684:	eb 6c                	jmp    1036f2 <mon_start_user+0x8e>
  103686:	c7 45 f4 04 a0 10 00 	movl   $0x10a004,-0xc(%ebp)
  10368d:	c7 44 24 04 00 00 10 	movl   $0x100000,0x4(%esp)
  103694:	00 
  103695:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10369c:	e8 8f 19 00 00       	call   105030 <alloc_mem_quota>
  1036a1:	a3 4c df 10 00       	mov    %eax,0x10df4c
  1036a6:	a1 4c df 10 00       	mov    0x10df4c,%eax
  1036ab:	89 44 24 04          	mov    %eax,0x4(%esp)
  1036af:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1036b2:	89 04 24             	mov    %eax,(%esp)
  1036b5:	e8 1e 06 00 00       	call   103cd8 <elf_load>
  1036ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1036bd:	89 44 24 04          	mov    %eax,0x4(%esp)
  1036c1:	c7 04 24 7c 56 10 00 	movl   $0x10567c,(%esp)
  1036c8:	e8 24 f2 ff ff       	call   1028f1 <dprintf>
  1036cd:	a1 4c df 10 00       	mov    0x10df4c,%eax
  1036d2:	89 04 24             	mov    %eax,(%esp)
  1036d5:	e8 86 13 00 00       	call   104a60 <set_pdir_base>
  1036da:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1036dd:	89 04 24             	mov    %eax,(%esp)
  1036e0:	e8 e4 08 00 00       	call   103fc9 <elf_entry>
  1036e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1036e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1036eb:	ff d0                	call   *%eax
  1036ed:	b8 00 00 00 00       	mov    $0x0,%eax
  1036f2:	c9                   	leave  
  1036f3:	c3                   	ret    

001036f4 <mon_help>:
  1036f4:	55                   	push   %ebp
  1036f5:	89 e5                	mov    %esp,%ebp
  1036f7:	83 ec 28             	sub    $0x28,%esp
  1036fa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  103701:	eb 3f                	jmp    103742 <mon_help+0x4e>
  103703:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103706:	89 d0                	mov    %edx,%eax
  103708:	01 c0                	add    %eax,%eax
  10370a:	01 d0                	add    %edx,%eax
  10370c:	c1 e0 02             	shl    $0x2,%eax
  10370f:	05 20 85 10 00       	add    $0x108520,%eax
  103714:	8b 48 04             	mov    0x4(%eax),%ecx
  103717:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10371a:	89 d0                	mov    %edx,%eax
  10371c:	01 c0                	add    %eax,%eax
  10371e:	01 d0                	add    %edx,%eax
  103720:	c1 e0 02             	shl    $0x2,%eax
  103723:	05 20 85 10 00       	add    $0x108520,%eax
  103728:	8b 00                	mov    (%eax),%eax
  10372a:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  10372e:	89 44 24 04          	mov    %eax,0x4(%esp)
  103732:	c7 04 24 97 56 10 00 	movl   $0x105697,(%esp)
  103739:	e8 b3 f1 ff ff       	call   1028f1 <dprintf>
  10373e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  103742:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103745:	83 f8 02             	cmp    $0x2,%eax
  103748:	76 b9                	jbe    103703 <mon_help+0xf>
  10374a:	b8 00 00 00 00       	mov    $0x0,%eax
  10374f:	c9                   	leave  
  103750:	c3                   	ret    

00103751 <mon_kerninfo>:
  103751:	55                   	push   %ebp
  103752:	89 e5                	mov    %esp,%ebp
  103754:	83 ec 28             	sub    $0x28,%esp
  103757:	c7 04 24 a0 56 10 00 	movl   $0x1056a0,(%esp)
  10375e:	e8 8e f1 ff ff       	call   1028f1 <dprintf>
  103763:	c7 44 24 04 34 44 10 	movl   $0x104434,0x4(%esp)
  10376a:	00 
  10376b:	c7 04 24 b9 56 10 00 	movl   $0x1056b9,(%esp)
  103772:	e8 7a f1 ff ff       	call   1028f1 <dprintf>
  103777:	c7 44 24 04 c7 52 10 	movl   $0x1052c7,0x4(%esp)
  10377e:	00 
  10377f:	c7 04 24 c8 56 10 00 	movl   $0x1056c8,(%esp)
  103786:	e8 66 f1 ff ff       	call   1028f1 <dprintf>
  10378b:	c7 44 24 04 21 c5 10 	movl   $0x10c521,0x4(%esp)
  103792:	00 
  103793:	c7 04 24 d7 56 10 00 	movl   $0x1056d7,(%esp)
  10379a:	e8 52 f1 ff ff       	call   1028f1 <dprintf>
  10379f:	c7 44 24 04 00 40 d9 	movl   $0xd94000,0x4(%esp)
  1037a6:	00 
  1037a7:	c7 04 24 e6 56 10 00 	movl   $0x1056e6,(%esp)
  1037ae:	e8 3e f1 ff ff       	call   1028f1 <dprintf>
  1037b3:	ba 00 40 d9 00       	mov    $0xd94000,%edx
  1037b8:	b8 34 44 10 00       	mov    $0x104434,%eax
  1037bd:	29 c2                	sub    %eax,%edx
  1037bf:	89 d0                	mov    %edx,%eax
  1037c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1037c4:	c7 45 f0 00 04 00 00 	movl   $0x400,-0x10(%ebp)
  1037cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1037ce:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1037d1:	01 d0                	add    %edx,%eax
  1037d3:	83 e8 01             	sub    $0x1,%eax
  1037d6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1037d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1037dc:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1037df:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1037e2:	99                   	cltd   
  1037e3:	f7 7d e8             	idivl  -0x18(%ebp)
  1037e6:	89 d0                	mov    %edx,%eax
  1037e8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1037eb:	29 c2                	sub    %eax,%edx
  1037ed:	89 d0                	mov    %edx,%eax
  1037ef:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  1037f5:	85 c0                	test   %eax,%eax
  1037f7:	0f 48 c2             	cmovs  %edx,%eax
  1037fa:	c1 f8 0a             	sar    $0xa,%eax
  1037fd:	89 44 24 04          	mov    %eax,0x4(%esp)
  103801:	c7 04 24 f8 56 10 00 	movl   $0x1056f8,(%esp)
  103808:	e8 e4 f0 ff ff       	call   1028f1 <dprintf>
  10380d:	b8 00 00 00 00       	mov    $0x0,%eax
  103812:	c9                   	leave  
  103813:	c3                   	ret    

00103814 <mon_backtrace>:
  103814:	55                   	push   %ebp
  103815:	89 e5                	mov    %esp,%ebp
  103817:	b8 00 00 00 00       	mov    $0x0,%eax
  10381c:	5d                   	pop    %ebp
  10381d:	c3                   	ret    

0010381e <runcmd>:
  10381e:	55                   	push   %ebp
  10381f:	89 e5                	mov    %esp,%ebp
  103821:	83 ec 68             	sub    $0x68,%esp
  103824:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  10382b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10382e:	c7 44 85 b0 00 00 00 	movl   $0x0,-0x50(%ebp,%eax,4)
  103835:	00 
  103836:	eb 0c                	jmp    103844 <runcmd+0x26>
  103838:	8b 45 08             	mov    0x8(%ebp),%eax
  10383b:	8d 50 01             	lea    0x1(%eax),%edx
  10383e:	89 55 08             	mov    %edx,0x8(%ebp)
  103841:	c6 00 00             	movb   $0x0,(%eax)
  103844:	8b 45 08             	mov    0x8(%ebp),%eax
  103847:	0f b6 00             	movzbl (%eax),%eax
  10384a:	84 c0                	test   %al,%al
  10384c:	74 1d                	je     10386b <runcmd+0x4d>
  10384e:	8b 45 08             	mov    0x8(%ebp),%eax
  103851:	0f b6 00             	movzbl (%eax),%eax
  103854:	0f be c0             	movsbl %al,%eax
  103857:	89 44 24 04          	mov    %eax,0x4(%esp)
  10385b:	c7 04 24 22 57 10 00 	movl   $0x105722,(%esp)
  103862:	e8 b3 ed ff ff       	call   10261a <strchr>
  103867:	85 c0                	test   %eax,%eax
  103869:	75 cd                	jne    103838 <runcmd+0x1a>
  10386b:	8b 45 08             	mov    0x8(%ebp),%eax
  10386e:	0f b6 00             	movzbl (%eax),%eax
  103871:	84 c0                	test   %al,%al
  103873:	75 14                	jne    103889 <runcmd+0x6b>
  103875:	90                   	nop
  103876:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103879:	c7 44 85 b0 00 00 00 	movl   $0x0,-0x50(%ebp,%eax,4)
  103880:	00 
  103881:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  103885:	75 70                	jne    1038f7 <runcmd+0xd9>
  103887:	eb 67                	jmp    1038f0 <runcmd+0xd2>
  103889:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  10388d:	75 1e                	jne    1038ad <runcmd+0x8f>
  10388f:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
  103896:	00 
  103897:	c7 04 24 27 57 10 00 	movl   $0x105727,(%esp)
  10389e:	e8 4e f0 ff ff       	call   1028f1 <dprintf>
  1038a3:	b8 00 00 00 00       	mov    $0x0,%eax
  1038a8:	e9 c9 00 00 00       	jmp    103976 <runcmd+0x158>
  1038ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1038b0:	8d 50 01             	lea    0x1(%eax),%edx
  1038b3:	89 55 f4             	mov    %edx,-0xc(%ebp)
  1038b6:	8b 55 08             	mov    0x8(%ebp),%edx
  1038b9:	89 54 85 b0          	mov    %edx,-0x50(%ebp,%eax,4)
  1038bd:	eb 04                	jmp    1038c3 <runcmd+0xa5>
  1038bf:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  1038c3:	8b 45 08             	mov    0x8(%ebp),%eax
  1038c6:	0f b6 00             	movzbl (%eax),%eax
  1038c9:	84 c0                	test   %al,%al
  1038cb:	74 1d                	je     1038ea <runcmd+0xcc>
  1038cd:	8b 45 08             	mov    0x8(%ebp),%eax
  1038d0:	0f b6 00             	movzbl (%eax),%eax
  1038d3:	0f be c0             	movsbl %al,%eax
  1038d6:	89 44 24 04          	mov    %eax,0x4(%esp)
  1038da:	c7 04 24 22 57 10 00 	movl   $0x105722,(%esp)
  1038e1:	e8 34 ed ff ff       	call   10261a <strchr>
  1038e6:	85 c0                	test   %eax,%eax
  1038e8:	74 d5                	je     1038bf <runcmd+0xa1>
  1038ea:	90                   	nop
  1038eb:	e9 54 ff ff ff       	jmp    103844 <runcmd+0x26>
  1038f0:	b8 00 00 00 00       	mov    $0x0,%eax
  1038f5:	eb 7f                	jmp    103976 <runcmd+0x158>
  1038f7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  1038fe:	eb 56                	jmp    103956 <runcmd+0x138>
  103900:	8b 55 f0             	mov    -0x10(%ebp),%edx
  103903:	89 d0                	mov    %edx,%eax
  103905:	01 c0                	add    %eax,%eax
  103907:	01 d0                	add    %edx,%eax
  103909:	c1 e0 02             	shl    $0x2,%eax
  10390c:	05 20 85 10 00       	add    $0x108520,%eax
  103911:	8b 10                	mov    (%eax),%edx
  103913:	8b 45 b0             	mov    -0x50(%ebp),%eax
  103916:	89 54 24 04          	mov    %edx,0x4(%esp)
  10391a:	89 04 24             	mov    %eax,(%esp)
  10391d:	e8 b9 ec ff ff       	call   1025db <strcmp>
  103922:	85 c0                	test   %eax,%eax
  103924:	75 2c                	jne    103952 <runcmd+0x134>
  103926:	8b 55 f0             	mov    -0x10(%ebp),%edx
  103929:	89 d0                	mov    %edx,%eax
  10392b:	01 c0                	add    %eax,%eax
  10392d:	01 d0                	add    %edx,%eax
  10392f:	c1 e0 02             	shl    $0x2,%eax
  103932:	05 20 85 10 00       	add    $0x108520,%eax
  103937:	8b 40 08             	mov    0x8(%eax),%eax
  10393a:	8b 55 0c             	mov    0xc(%ebp),%edx
  10393d:	89 54 24 08          	mov    %edx,0x8(%esp)
  103941:	8d 55 b0             	lea    -0x50(%ebp),%edx
  103944:	89 54 24 04          	mov    %edx,0x4(%esp)
  103948:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10394b:	89 14 24             	mov    %edx,(%esp)
  10394e:	ff d0                	call   *%eax
  103950:	eb 24                	jmp    103976 <runcmd+0x158>
  103952:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  103956:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103959:	83 f8 02             	cmp    $0x2,%eax
  10395c:	76 a2                	jbe    103900 <runcmd+0xe2>
  10395e:	8b 45 b0             	mov    -0x50(%ebp),%eax
  103961:	89 44 24 04          	mov    %eax,0x4(%esp)
  103965:	c7 04 24 44 57 10 00 	movl   $0x105744,(%esp)
  10396c:	e8 80 ef ff ff       	call   1028f1 <dprintf>
  103971:	b8 00 00 00 00       	mov    $0x0,%eax
  103976:	c9                   	leave  
  103977:	c3                   	ret    

00103978 <monitor>:
  103978:	55                   	push   %ebp
  103979:	89 e5                	mov    %esp,%ebp
  10397b:	83 ec 28             	sub    $0x28,%esp
  10397e:	c7 04 24 5c 57 10 00 	movl   $0x10575c,(%esp)
  103985:	e8 67 ef ff ff       	call   1028f1 <dprintf>
  10398a:	c7 04 24 88 57 10 00 	movl   $0x105788,(%esp)
  103991:	e8 5b ef ff ff       	call   1028f1 <dprintf>
  103996:	c7 04 24 5c 57 10 00 	movl   $0x10575c,(%esp)
  10399d:	e8 4f ef ff ff       	call   1028f1 <dprintf>
  1039a2:	c7 04 24 b4 57 10 00 	movl   $0x1057b4,(%esp)
  1039a9:	e8 43 ef ff ff       	call   1028f1 <dprintf>
  1039ae:	c7 04 24 d9 57 10 00 	movl   $0x1057d9,(%esp)
  1039b5:	e8 c7 ca ff ff       	call   100481 <readline>
  1039ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1039bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1039c1:	74 18                	je     1039db <monitor+0x63>
  1039c3:	8b 45 08             	mov    0x8(%ebp),%eax
  1039c6:	89 44 24 04          	mov    %eax,0x4(%esp)
  1039ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1039cd:	89 04 24             	mov    %eax,(%esp)
  1039d0:	e8 49 fe ff ff       	call   10381e <runcmd>
  1039d5:	85 c0                	test   %eax,%eax
  1039d7:	79 02                	jns    1039db <monitor+0x63>
  1039d9:	eb 02                	jmp    1039dd <monitor+0x65>
  1039db:	eb d1                	jmp    1039ae <monitor+0x36>
  1039dd:	c9                   	leave  
  1039de:	c3                   	ret    
  1039df:	90                   	nop

001039e0 <pt_copyin>:
  1039e0:	55                   	push   %ebp
  1039e1:	89 e5                	mov    %esp,%ebp
  1039e3:	83 ec 28             	sub    $0x28,%esp
  1039e6:	81 7d 0c ff ff ff 3f 	cmpl   $0x3fffffff,0xc(%ebp)
  1039ed:	76 0f                	jbe    1039fe <pt_copyin+0x1e>
  1039ef:	8b 45 14             	mov    0x14(%ebp),%eax
  1039f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  1039f5:	01 d0                	add    %edx,%eax
  1039f7:	3d 00 00 00 f0       	cmp    $0xf0000000,%eax
  1039fc:	76 0a                	jbe    103a08 <pt_copyin+0x28>
  1039fe:	b8 00 00 00 00       	mov    $0x0,%eax
  103a03:	e9 e6 00 00 00       	jmp    103aee <pt_copyin+0x10e>
  103a08:	8b 55 10             	mov    0x10(%ebp),%edx
  103a0b:	8b 45 14             	mov    0x14(%ebp),%eax
  103a0e:	01 d0                	add    %edx,%eax
  103a10:	3d 00 00 00 f0       	cmp    $0xf0000000,%eax
  103a15:	76 0a                	jbe    103a21 <pt_copyin+0x41>
  103a17:	b8 00 00 00 00       	mov    $0x0,%eax
  103a1c:	e9 cd 00 00 00       	jmp    103aee <pt_copyin+0x10e>
  103a21:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  103a28:	e9 b4 00 00 00       	jmp    103ae1 <pt_copyin+0x101>
  103a2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  103a30:	89 44 24 04          	mov    %eax,0x4(%esp)
  103a34:	8b 45 08             	mov    0x8(%ebp),%eax
  103a37:	89 04 24             	mov    %eax,(%esp)
  103a3a:	e8 a1 11 00 00       	call   104be0 <get_ptbl_entry_by_va>
  103a3f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103a42:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103a45:	83 e0 01             	and    $0x1,%eax
  103a48:	85 c0                	test   %eax,%eax
  103a4a:	75 2f                	jne    103a7b <pt_copyin+0x9b>
  103a4c:	c7 44 24 08 07 00 00 	movl   $0x7,0x8(%esp)
  103a53:	00 
  103a54:	8b 45 0c             	mov    0xc(%ebp),%eax
  103a57:	89 44 24 04          	mov    %eax,0x4(%esp)
  103a5b:	8b 45 08             	mov    0x8(%ebp),%eax
  103a5e:	89 04 24             	mov    %eax,(%esp)
  103a61:	e8 7a 15 00 00       	call   104fe0 <alloc_page>
  103a66:	8b 45 0c             	mov    0xc(%ebp),%eax
  103a69:	89 44 24 04          	mov    %eax,0x4(%esp)
  103a6d:	8b 45 08             	mov    0x8(%ebp),%eax
  103a70:	89 04 24             	mov    %eax,(%esp)
  103a73:	e8 68 11 00 00       	call   104be0 <get_ptbl_entry_by_va>
  103a78:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103a7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103a7e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  103a83:	89 c2                	mov    %eax,%edx
  103a85:	8b 45 0c             	mov    0xc(%ebp),%eax
  103a88:	25 ff 0f 00 00       	and    $0xfff,%eax
  103a8d:	01 d0                	add    %edx,%eax
  103a8f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103a92:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103a95:	25 ff 0f 00 00       	and    $0xfff,%eax
  103a9a:	89 c2                	mov    %eax,%edx
  103a9c:	b8 00 10 00 00       	mov    $0x1000,%eax
  103aa1:	29 d0                	sub    %edx,%eax
  103aa3:	89 c2                	mov    %eax,%edx
  103aa5:	8b 45 14             	mov    0x14(%ebp),%eax
  103aa8:	39 c2                	cmp    %eax,%edx
  103aaa:	0f 46 c2             	cmovbe %edx,%eax
  103aad:	89 45 ec             	mov    %eax,-0x14(%ebp)
  103ab0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103ab3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  103ab6:	89 54 24 08          	mov    %edx,0x8(%esp)
  103aba:	89 44 24 04          	mov    %eax,0x4(%esp)
  103abe:	8b 45 10             	mov    0x10(%ebp),%eax
  103ac1:	89 04 24             	mov    %eax,(%esp)
  103ac4:	e8 6b ea ff ff       	call   102534 <memcpy>
  103ac9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103acc:	29 45 14             	sub    %eax,0x14(%ebp)
  103acf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103ad2:	01 45 0c             	add    %eax,0xc(%ebp)
  103ad5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103ad8:	01 45 10             	add    %eax,0x10(%ebp)
  103adb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103ade:	01 45 f4             	add    %eax,-0xc(%ebp)
  103ae1:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
  103ae5:	0f 85 42 ff ff ff    	jne    103a2d <pt_copyin+0x4d>
  103aeb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103aee:	c9                   	leave  
  103aef:	c3                   	ret    

00103af0 <pt_copyout>:
  103af0:	55                   	push   %ebp
  103af1:	89 e5                	mov    %esp,%ebp
  103af3:	83 ec 28             	sub    $0x28,%esp
  103af6:	81 7d 10 ff ff ff 3f 	cmpl   $0x3fffffff,0x10(%ebp)
  103afd:	76 0f                	jbe    103b0e <pt_copyout+0x1e>
  103aff:	8b 45 14             	mov    0x14(%ebp),%eax
  103b02:	8b 55 10             	mov    0x10(%ebp),%edx
  103b05:	01 d0                	add    %edx,%eax
  103b07:	3d 00 00 00 f0       	cmp    $0xf0000000,%eax
  103b0c:	76 0a                	jbe    103b18 <pt_copyout+0x28>
  103b0e:	b8 00 00 00 00       	mov    $0x0,%eax
  103b13:	e9 e6 00 00 00       	jmp    103bfe <pt_copyout+0x10e>
  103b18:	8b 55 08             	mov    0x8(%ebp),%edx
  103b1b:	8b 45 14             	mov    0x14(%ebp),%eax
  103b1e:	01 d0                	add    %edx,%eax
  103b20:	3d 00 00 00 f0       	cmp    $0xf0000000,%eax
  103b25:	76 0a                	jbe    103b31 <pt_copyout+0x41>
  103b27:	b8 00 00 00 00       	mov    $0x0,%eax
  103b2c:	e9 cd 00 00 00       	jmp    103bfe <pt_copyout+0x10e>
  103b31:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  103b38:	e9 b4 00 00 00       	jmp    103bf1 <pt_copyout+0x101>
  103b3d:	8b 45 10             	mov    0x10(%ebp),%eax
  103b40:	89 44 24 04          	mov    %eax,0x4(%esp)
  103b44:	8b 45 0c             	mov    0xc(%ebp),%eax
  103b47:	89 04 24             	mov    %eax,(%esp)
  103b4a:	e8 91 10 00 00       	call   104be0 <get_ptbl_entry_by_va>
  103b4f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103b52:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103b55:	83 e0 01             	and    $0x1,%eax
  103b58:	85 c0                	test   %eax,%eax
  103b5a:	75 2f                	jne    103b8b <pt_copyout+0x9b>
  103b5c:	c7 44 24 08 07 00 00 	movl   $0x7,0x8(%esp)
  103b63:	00 
  103b64:	8b 45 10             	mov    0x10(%ebp),%eax
  103b67:	89 44 24 04          	mov    %eax,0x4(%esp)
  103b6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  103b6e:	89 04 24             	mov    %eax,(%esp)
  103b71:	e8 6a 14 00 00       	call   104fe0 <alloc_page>
  103b76:	8b 45 10             	mov    0x10(%ebp),%eax
  103b79:	89 44 24 04          	mov    %eax,0x4(%esp)
  103b7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  103b80:	89 04 24             	mov    %eax,(%esp)
  103b83:	e8 58 10 00 00       	call   104be0 <get_ptbl_entry_by_va>
  103b88:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103b8b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103b8e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  103b93:	89 c2                	mov    %eax,%edx
  103b95:	8b 45 10             	mov    0x10(%ebp),%eax
  103b98:	25 ff 0f 00 00       	and    $0xfff,%eax
  103b9d:	01 d0                	add    %edx,%eax
  103b9f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103ba2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103ba5:	25 ff 0f 00 00       	and    $0xfff,%eax
  103baa:	89 c2                	mov    %eax,%edx
  103bac:	b8 00 10 00 00       	mov    $0x1000,%eax
  103bb1:	29 d0                	sub    %edx,%eax
  103bb3:	89 c2                	mov    %eax,%edx
  103bb5:	8b 45 14             	mov    0x14(%ebp),%eax
  103bb8:	39 c2                	cmp    %eax,%edx
  103bba:	0f 46 c2             	cmovbe %edx,%eax
  103bbd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  103bc0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103bc3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  103bc6:	89 54 24 08          	mov    %edx,0x8(%esp)
  103bca:	8b 55 08             	mov    0x8(%ebp),%edx
  103bcd:	89 54 24 04          	mov    %edx,0x4(%esp)
  103bd1:	89 04 24             	mov    %eax,(%esp)
  103bd4:	e8 5b e9 ff ff       	call   102534 <memcpy>
  103bd9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103bdc:	29 45 14             	sub    %eax,0x14(%ebp)
  103bdf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103be2:	01 45 10             	add    %eax,0x10(%ebp)
  103be5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103be8:	01 45 08             	add    %eax,0x8(%ebp)
  103beb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103bee:	01 45 f4             	add    %eax,-0xc(%ebp)
  103bf1:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
  103bf5:	0f 85 42 ff ff ff    	jne    103b3d <pt_copyout+0x4d>
  103bfb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103bfe:	c9                   	leave  
  103bff:	c3                   	ret    

00103c00 <pt_memset>:
  103c00:	55                   	push   %ebp
  103c01:	89 e5                	mov    %esp,%ebp
  103c03:	83 ec 28             	sub    $0x28,%esp
  103c06:	8b 45 10             	mov    0x10(%ebp),%eax
  103c09:	88 45 e4             	mov    %al,-0x1c(%ebp)
  103c0c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  103c13:	e9 af 00 00 00       	jmp    103cc7 <pt_memset+0xc7>
  103c18:	8b 45 0c             	mov    0xc(%ebp),%eax
  103c1b:	89 44 24 04          	mov    %eax,0x4(%esp)
  103c1f:	8b 45 08             	mov    0x8(%ebp),%eax
  103c22:	89 04 24             	mov    %eax,(%esp)
  103c25:	e8 b6 0f 00 00       	call   104be0 <get_ptbl_entry_by_va>
  103c2a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103c2d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103c30:	83 e0 01             	and    $0x1,%eax
  103c33:	85 c0                	test   %eax,%eax
  103c35:	75 2f                	jne    103c66 <pt_memset+0x66>
  103c37:	c7 44 24 08 07 00 00 	movl   $0x7,0x8(%esp)
  103c3e:	00 
  103c3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  103c42:	89 44 24 04          	mov    %eax,0x4(%esp)
  103c46:	8b 45 08             	mov    0x8(%ebp),%eax
  103c49:	89 04 24             	mov    %eax,(%esp)
  103c4c:	e8 8f 13 00 00       	call   104fe0 <alloc_page>
  103c51:	8b 45 0c             	mov    0xc(%ebp),%eax
  103c54:	89 44 24 04          	mov    %eax,0x4(%esp)
  103c58:	8b 45 08             	mov    0x8(%ebp),%eax
  103c5b:	89 04 24             	mov    %eax,(%esp)
  103c5e:	e8 7d 0f 00 00       	call   104be0 <get_ptbl_entry_by_va>
  103c63:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103c66:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103c69:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  103c6e:	89 c2                	mov    %eax,%edx
  103c70:	8b 45 0c             	mov    0xc(%ebp),%eax
  103c73:	25 ff 0f 00 00       	and    $0xfff,%eax
  103c78:	01 d0                	add    %edx,%eax
  103c7a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103c7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103c80:	25 ff 0f 00 00       	and    $0xfff,%eax
  103c85:	89 c2                	mov    %eax,%edx
  103c87:	b8 00 10 00 00       	mov    $0x1000,%eax
  103c8c:	29 d0                	sub    %edx,%eax
  103c8e:	89 c2                	mov    %eax,%edx
  103c90:	8b 45 14             	mov    0x14(%ebp),%eax
  103c93:	39 c2                	cmp    %eax,%edx
  103c95:	0f 46 c2             	cmovbe %edx,%eax
  103c98:	89 45 ec             	mov    %eax,-0x14(%ebp)
  103c9b:	0f be 55 e4          	movsbl -0x1c(%ebp),%edx
  103c9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103ca2:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  103ca5:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  103ca9:	89 54 24 04          	mov    %edx,0x4(%esp)
  103cad:	89 04 24             	mov    %eax,(%esp)
  103cb0:	e8 37 e7 ff ff       	call   1023ec <memset>
  103cb5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103cb8:	29 45 14             	sub    %eax,0x14(%ebp)
  103cbb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103cbe:	01 45 0c             	add    %eax,0xc(%ebp)
  103cc1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103cc4:	01 45 f4             	add    %eax,-0xc(%ebp)
  103cc7:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
  103ccb:	0f 85 47 ff ff ff    	jne    103c18 <pt_memset+0x18>
  103cd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103cd4:	c9                   	leave  
  103cd5:	c3                   	ret    
  103cd6:	66 90                	xchg   %ax,%ax

00103cd8 <elf_load>:
  103cd8:	55                   	push   %ebp
  103cd9:	89 e5                	mov    %esp,%ebp
  103cdb:	83 ec 48             	sub    $0x48,%esp
  103cde:	8b 45 08             	mov    0x8(%ebp),%eax
  103ce1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  103ce4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103ce7:	89 45 e0             	mov    %eax,-0x20(%ebp)
  103cea:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103ced:	8b 00                	mov    (%eax),%eax
  103cef:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
  103cf4:	74 24                	je     103d1a <elf_load+0x42>
  103cf6:	c7 44 24 0c e0 57 10 	movl   $0x1057e0,0xc(%esp)
  103cfd:	00 
  103cfe:	c7 44 24 08 f9 57 10 	movl   $0x1057f9,0x8(%esp)
  103d05:	00 
  103d06:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
  103d0d:	00 
  103d0e:	c7 04 24 16 58 10 00 	movl   $0x105816,(%esp)
  103d15:	e8 17 ea ff ff       	call   102731 <debug_panic>
  103d1a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103d1d:	0f b7 40 32          	movzwl 0x32(%eax),%eax
  103d21:	66 85 c0             	test   %ax,%ax
  103d24:	75 24                	jne    103d4a <elf_load+0x72>
  103d26:	c7 44 24 0c 28 58 10 	movl   $0x105828,0xc(%esp)
  103d2d:	00 
  103d2e:	c7 44 24 08 f9 57 10 	movl   $0x1057f9,0x8(%esp)
  103d35:	00 
  103d36:	c7 44 24 04 26 00 00 	movl   $0x26,0x4(%esp)
  103d3d:	00 
  103d3e:	c7 04 24 16 58 10 00 	movl   $0x105816,(%esp)
  103d45:	e8 e7 e9 ff ff       	call   102731 <debug_panic>
  103d4a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103d4d:	8b 50 20             	mov    0x20(%eax),%edx
  103d50:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103d53:	01 d0                	add    %edx,%eax
  103d55:	89 45 dc             	mov    %eax,-0x24(%ebp)
  103d58:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103d5b:	0f b7 40 30          	movzwl 0x30(%eax),%eax
  103d5f:	0f b7 d0             	movzwl %ax,%edx
  103d62:	89 d0                	mov    %edx,%eax
  103d64:	c1 e0 02             	shl    $0x2,%eax
  103d67:	01 d0                	add    %edx,%eax
  103d69:	c1 e0 03             	shl    $0x3,%eax
  103d6c:	89 c2                	mov    %eax,%edx
  103d6e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103d71:	01 d0                	add    %edx,%eax
  103d73:	89 45 d8             	mov    %eax,-0x28(%ebp)
  103d76:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103d79:	0f b7 40 32          	movzwl 0x32(%eax),%eax
  103d7d:	0f b7 d0             	movzwl %ax,%edx
  103d80:	89 d0                	mov    %edx,%eax
  103d82:	c1 e0 02             	shl    $0x2,%eax
  103d85:	01 d0                	add    %edx,%eax
  103d87:	c1 e0 03             	shl    $0x3,%eax
  103d8a:	89 c2                	mov    %eax,%edx
  103d8c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103d8f:	01 d0                	add    %edx,%eax
  103d91:	8b 50 10             	mov    0x10(%eax),%edx
  103d94:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103d97:	01 d0                	add    %edx,%eax
  103d99:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  103d9c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103d9f:	0f b7 40 32          	movzwl 0x32(%eax),%eax
  103da3:	0f b7 d0             	movzwl %ax,%edx
  103da6:	89 d0                	mov    %edx,%eax
  103da8:	c1 e0 02             	shl    $0x2,%eax
  103dab:	01 d0                	add    %edx,%eax
  103dad:	c1 e0 03             	shl    $0x3,%eax
  103db0:	89 c2                	mov    %eax,%edx
  103db2:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103db5:	01 d0                	add    %edx,%eax
  103db7:	8b 40 04             	mov    0x4(%eax),%eax
  103dba:	83 f8 03             	cmp    $0x3,%eax
  103dbd:	74 24                	je     103de3 <elf_load+0x10b>
  103dbf:	c7 44 24 0c 48 58 10 	movl   $0x105848,0xc(%esp)
  103dc6:	00 
  103dc7:	c7 44 24 08 f9 57 10 	movl   $0x1057f9,0x8(%esp)
  103dce:	00 
  103dcf:	c7 44 24 04 2c 00 00 	movl   $0x2c,0x4(%esp)
  103dd6:	00 
  103dd7:	c7 04 24 16 58 10 00 	movl   $0x105816,(%esp)
  103dde:	e8 4e e9 ff ff       	call   102731 <debug_panic>
  103de3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103de6:	8b 50 1c             	mov    0x1c(%eax),%edx
  103de9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103dec:	01 d0                	add    %edx,%eax
  103dee:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103df1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103df4:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  103df8:	0f b7 c0             	movzwl %ax,%eax
  103dfb:	c1 e0 05             	shl    $0x5,%eax
  103dfe:	89 c2                	mov    %eax,%edx
  103e00:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103e03:	01 d0                	add    %edx,%eax
  103e05:	89 45 d0             	mov    %eax,-0x30(%ebp)
  103e08:	e9 8b 01 00 00       	jmp    103f98 <elf_load+0x2c0>
  103e0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103e10:	8b 00                	mov    (%eax),%eax
  103e12:	83 f8 01             	cmp    $0x1,%eax
  103e15:	74 05                	je     103e1c <elf_load+0x144>
  103e17:	e9 78 01 00 00       	jmp    103f94 <elf_load+0x2bc>
  103e1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103e1f:	8b 40 04             	mov    0x4(%eax),%eax
  103e22:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  103e29:	00 
  103e2a:	89 04 24             	mov    %eax,(%esp)
  103e2d:	e8 d8 f4 ff ff       	call   10330a <rounddown>
  103e32:	8b 55 e0             	mov    -0x20(%ebp),%edx
  103e35:	01 d0                	add    %edx,%eax
  103e37:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103e3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103e3d:	8b 40 08             	mov    0x8(%eax),%eax
  103e40:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  103e47:	00 
  103e48:	89 04 24             	mov    %eax,(%esp)
  103e4b:	e8 ba f4 ff ff       	call   10330a <rounddown>
  103e50:	89 45 ec             	mov    %eax,-0x14(%ebp)
  103e53:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103e56:	8b 50 08             	mov    0x8(%eax),%edx
  103e59:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103e5c:	8b 40 10             	mov    0x10(%eax),%eax
  103e5f:	01 d0                	add    %edx,%eax
  103e61:	89 45 cc             	mov    %eax,-0x34(%ebp)
  103e64:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103e67:	8b 50 08             	mov    0x8(%eax),%edx
  103e6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103e6d:	8b 40 14             	mov    0x14(%eax),%eax
  103e70:	01 d0                	add    %edx,%eax
  103e72:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  103e79:	00 
  103e7a:	89 04 24             	mov    %eax,(%esp)
  103e7d:	e8 a1 f4 ff ff       	call   103323 <roundup>
  103e82:	89 45 c8             	mov    %eax,-0x38(%ebp)
  103e85:	c7 45 e8 05 00 00 00 	movl   $0x5,-0x18(%ebp)
  103e8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103e8f:	8b 40 18             	mov    0x18(%eax),%eax
  103e92:	83 e0 02             	and    $0x2,%eax
  103e95:	85 c0                	test   %eax,%eax
  103e97:	74 09                	je     103ea2 <elf_load+0x1ca>
  103e99:	83 4d e8 02          	orl    $0x2,-0x18(%ebp)
  103e9d:	e9 e6 00 00 00       	jmp    103f88 <elf_load+0x2b0>
  103ea2:	e9 e1 00 00 00       	jmp    103f88 <elf_load+0x2b0>
  103ea7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103eaa:	89 44 24 08          	mov    %eax,0x8(%esp)
  103eae:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103eb1:	89 44 24 04          	mov    %eax,0x4(%esp)
  103eb5:	8b 45 0c             	mov    0xc(%ebp),%eax
  103eb8:	89 04 24             	mov    %eax,(%esp)
  103ebb:	e8 20 11 00 00       	call   104fe0 <alloc_page>
  103ec0:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  103ec7:	00 
  103ec8:	8b 45 cc             	mov    -0x34(%ebp),%eax
  103ecb:	89 04 24             	mov    %eax,(%esp)
  103ece:	e8 37 f4 ff ff       	call   10330a <rounddown>
  103ed3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  103ed6:	76 23                	jbe    103efb <elf_load+0x223>
  103ed8:	8b 55 0c             	mov    0xc(%ebp),%edx
  103edb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103ede:	c7 44 24 0c 00 10 00 	movl   $0x1000,0xc(%esp)
  103ee5:	00 
  103ee6:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  103ee9:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  103eed:	89 54 24 04          	mov    %edx,0x4(%esp)
  103ef1:	89 04 24             	mov    %eax,(%esp)
  103ef4:	e8 f7 fb ff ff       	call   103af0 <pt_copyout>
  103ef9:	eb 7f                	jmp    103f7a <elf_load+0x2a2>
  103efb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103efe:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  103f01:	73 55                	jae    103f58 <elf_load+0x280>
  103f03:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103f06:	8b 40 10             	mov    0x10(%eax),%eax
  103f09:	85 c0                	test   %eax,%eax
  103f0b:	74 4b                	je     103f58 <elf_load+0x280>
  103f0d:	8b 45 0c             	mov    0xc(%ebp),%eax
  103f10:	c7 44 24 0c 00 10 00 	movl   $0x1000,0xc(%esp)
  103f17:	00 
  103f18:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  103f1f:	00 
  103f20:	8b 55 ec             	mov    -0x14(%ebp),%edx
  103f23:	89 54 24 04          	mov    %edx,0x4(%esp)
  103f27:	89 04 24             	mov    %eax,(%esp)
  103f2a:	e8 d1 fc ff ff       	call   103c00 <pt_memset>
  103f2f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103f32:	8b 55 cc             	mov    -0x34(%ebp),%edx
  103f35:	89 d1                	mov    %edx,%ecx
  103f37:	29 c1                	sub    %eax,%ecx
  103f39:	8b 55 0c             	mov    0xc(%ebp),%edx
  103f3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103f3f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  103f43:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  103f46:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  103f4a:	89 54 24 04          	mov    %edx,0x4(%esp)
  103f4e:	89 04 24             	mov    %eax,(%esp)
  103f51:	e8 9a fb ff ff       	call   103af0 <pt_copyout>
  103f56:	eb 22                	jmp    103f7a <elf_load+0x2a2>
  103f58:	8b 45 0c             	mov    0xc(%ebp),%eax
  103f5b:	c7 44 24 0c 00 10 00 	movl   $0x1000,0xc(%esp)
  103f62:	00 
  103f63:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  103f6a:	00 
  103f6b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  103f6e:	89 54 24 04          	mov    %edx,0x4(%esp)
  103f72:	89 04 24             	mov    %eax,(%esp)
  103f75:	e8 86 fc ff ff       	call   103c00 <pt_memset>
  103f7a:	81 45 ec 00 10 00 00 	addl   $0x1000,-0x14(%ebp)
  103f81:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
  103f88:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103f8b:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  103f8e:	0f 82 13 ff ff ff    	jb     103ea7 <elf_load+0x1cf>
  103f94:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
  103f98:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103f9b:	3b 45 d0             	cmp    -0x30(%ebp),%eax
  103f9e:	0f 82 69 fe ff ff    	jb     103e0d <elf_load+0x135>
  103fa4:	8b 45 0c             	mov    0xc(%ebp),%eax
  103fa7:	c7 44 24 0c 00 10 00 	movl   $0x1000,0xc(%esp)
  103fae:	00 
  103faf:	c7 44 24 08 00 00 00 	movl   $0xe0000000,0x8(%esp)
  103fb6:	e0 
  103fb7:	89 44 24 04          	mov    %eax,0x4(%esp)
  103fbb:	c7 04 24 00 90 10 00 	movl   $0x109000,(%esp)
  103fc2:	e8 29 fb ff ff       	call   103af0 <pt_copyout>
  103fc7:	c9                   	leave  
  103fc8:	c3                   	ret    

00103fc9 <elf_entry>:
  103fc9:	55                   	push   %ebp
  103fca:	89 e5                	mov    %esp,%ebp
  103fcc:	83 ec 28             	sub    $0x28,%esp
  103fcf:	8b 45 08             	mov    0x8(%ebp),%eax
  103fd2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103fd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103fd8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103fdb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103fde:	8b 00                	mov    (%eax),%eax
  103fe0:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
  103fe5:	74 24                	je     10400b <elf_entry+0x42>
  103fe7:	c7 44 24 0c e0 57 10 	movl   $0x1057e0,0xc(%esp)
  103fee:	00 
  103fef:	c7 44 24 08 f9 57 10 	movl   $0x1057f9,0x8(%esp)
  103ff6:	00 
  103ff7:	c7 44 24 04 62 00 00 	movl   $0x62,0x4(%esp)
  103ffe:	00 
  103fff:	c7 04 24 16 58 10 00 	movl   $0x105816,(%esp)
  104006:	e8 26 e7 ff ff       	call   102731 <debug_panic>
  10400b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10400e:	8b 40 18             	mov    0x18(%eax),%eax
  104011:	c9                   	leave  
  104012:	c3                   	ret    
  104013:	90                   	nop

00104014 <trap_dump>:
  104014:	55                   	push   %ebp
  104015:	89 e5                	mov    %esp,%ebp
  104017:	83 ec 28             	sub    $0x28,%esp
  10401a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  10401e:	75 05                	jne    104025 <trap_dump+0x11>
  104020:	e9 55 02 00 00       	jmp    10427a <trap_dump+0x266>
  104025:	8b 45 08             	mov    0x8(%ebp),%eax
  104028:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10402b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10402e:	89 44 24 0c          	mov    %eax,0xc(%esp)
  104032:	c7 44 24 08 78 58 10 	movl   $0x105878,0x8(%esp)
  104039:	00 
  10403a:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
  104041:	00 
  104042:	c7 04 24 89 58 10 00 	movl   $0x105889,(%esp)
  104049:	e8 42 e6 ff ff       	call   102690 <debug_normal>
  10404e:	8b 45 08             	mov    0x8(%ebp),%eax
  104051:	8b 10                	mov    (%eax),%edx
  104053:	8b 45 08             	mov    0x8(%ebp),%eax
  104056:	89 54 24 08          	mov    %edx,0x8(%esp)
  10405a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10405e:	c7 04 24 99 58 10 00 	movl   $0x105899,(%esp)
  104065:	e8 06 e6 ff ff       	call   102670 <debug_info>
  10406a:	8b 45 08             	mov    0x8(%ebp),%eax
  10406d:	8b 40 04             	mov    0x4(%eax),%eax
  104070:	8b 55 08             	mov    0x8(%ebp),%edx
  104073:	83 c2 04             	add    $0x4,%edx
  104076:	89 44 24 08          	mov    %eax,0x8(%esp)
  10407a:	89 54 24 04          	mov    %edx,0x4(%esp)
  10407e:	c7 04 24 af 58 10 00 	movl   $0x1058af,(%esp)
  104085:	e8 e6 e5 ff ff       	call   102670 <debug_info>
  10408a:	8b 45 08             	mov    0x8(%ebp),%eax
  10408d:	8b 40 08             	mov    0x8(%eax),%eax
  104090:	8b 55 08             	mov    0x8(%ebp),%edx
  104093:	83 c2 08             	add    $0x8,%edx
  104096:	89 44 24 08          	mov    %eax,0x8(%esp)
  10409a:	89 54 24 04          	mov    %edx,0x4(%esp)
  10409e:	c7 04 24 c5 58 10 00 	movl   $0x1058c5,(%esp)
  1040a5:	e8 c6 e5 ff ff       	call   102670 <debug_info>
  1040aa:	8b 45 08             	mov    0x8(%ebp),%eax
  1040ad:	8b 40 0c             	mov    0xc(%eax),%eax
  1040b0:	8b 55 08             	mov    0x8(%ebp),%edx
  1040b3:	83 c2 0c             	add    $0xc,%edx
  1040b6:	89 44 24 08          	mov    %eax,0x8(%esp)
  1040ba:	89 54 24 04          	mov    %edx,0x4(%esp)
  1040be:	c7 04 24 db 58 10 00 	movl   $0x1058db,(%esp)
  1040c5:	e8 a6 e5 ff ff       	call   102670 <debug_info>
  1040ca:	8b 45 08             	mov    0x8(%ebp),%eax
  1040cd:	8b 40 10             	mov    0x10(%eax),%eax
  1040d0:	8b 55 08             	mov    0x8(%ebp),%edx
  1040d3:	83 c2 10             	add    $0x10,%edx
  1040d6:	89 44 24 08          	mov    %eax,0x8(%esp)
  1040da:	89 54 24 04          	mov    %edx,0x4(%esp)
  1040de:	c7 04 24 f1 58 10 00 	movl   $0x1058f1,(%esp)
  1040e5:	e8 86 e5 ff ff       	call   102670 <debug_info>
  1040ea:	8b 45 08             	mov    0x8(%ebp),%eax
  1040ed:	8b 40 14             	mov    0x14(%eax),%eax
  1040f0:	8b 55 08             	mov    0x8(%ebp),%edx
  1040f3:	83 c2 14             	add    $0x14,%edx
  1040f6:	89 44 24 08          	mov    %eax,0x8(%esp)
  1040fa:	89 54 24 04          	mov    %edx,0x4(%esp)
  1040fe:	c7 04 24 07 59 10 00 	movl   $0x105907,(%esp)
  104105:	e8 66 e5 ff ff       	call   102670 <debug_info>
  10410a:	8b 45 08             	mov    0x8(%ebp),%eax
  10410d:	8b 40 18             	mov    0x18(%eax),%eax
  104110:	8b 55 08             	mov    0x8(%ebp),%edx
  104113:	83 c2 18             	add    $0x18,%edx
  104116:	89 44 24 08          	mov    %eax,0x8(%esp)
  10411a:	89 54 24 04          	mov    %edx,0x4(%esp)
  10411e:	c7 04 24 1d 59 10 00 	movl   $0x10591d,(%esp)
  104125:	e8 46 e5 ff ff       	call   102670 <debug_info>
  10412a:	8b 45 08             	mov    0x8(%ebp),%eax
  10412d:	8b 40 1c             	mov    0x1c(%eax),%eax
  104130:	8b 55 08             	mov    0x8(%ebp),%edx
  104133:	83 c2 1c             	add    $0x1c,%edx
  104136:	89 44 24 08          	mov    %eax,0x8(%esp)
  10413a:	89 54 24 04          	mov    %edx,0x4(%esp)
  10413e:	c7 04 24 33 59 10 00 	movl   $0x105933,(%esp)
  104145:	e8 26 e5 ff ff       	call   102670 <debug_info>
  10414a:	8b 45 08             	mov    0x8(%ebp),%eax
  10414d:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  104151:	0f b7 c0             	movzwl %ax,%eax
  104154:	8b 55 08             	mov    0x8(%ebp),%edx
  104157:	83 c2 20             	add    $0x20,%edx
  10415a:	89 44 24 08          	mov    %eax,0x8(%esp)
  10415e:	89 54 24 04          	mov    %edx,0x4(%esp)
  104162:	c7 04 24 49 59 10 00 	movl   $0x105949,(%esp)
  104169:	e8 02 e5 ff ff       	call   102670 <debug_info>
  10416e:	8b 45 08             	mov    0x8(%ebp),%eax
  104171:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  104175:	0f b7 c0             	movzwl %ax,%eax
  104178:	8b 55 08             	mov    0x8(%ebp),%edx
  10417b:	83 c2 24             	add    $0x24,%edx
  10417e:	89 44 24 08          	mov    %eax,0x8(%esp)
  104182:	89 54 24 04          	mov    %edx,0x4(%esp)
  104186:	c7 04 24 5f 59 10 00 	movl   $0x10595f,(%esp)
  10418d:	e8 de e4 ff ff       	call   102670 <debug_info>
  104192:	8b 45 08             	mov    0x8(%ebp),%eax
  104195:	8b 40 28             	mov    0x28(%eax),%eax
  104198:	8b 55 08             	mov    0x8(%ebp),%edx
  10419b:	83 c2 28             	add    $0x28,%edx
  10419e:	89 44 24 08          	mov    %eax,0x8(%esp)
  1041a2:	89 54 24 04          	mov    %edx,0x4(%esp)
  1041a6:	c7 04 24 75 59 10 00 	movl   $0x105975,(%esp)
  1041ad:	e8 be e4 ff ff       	call   102670 <debug_info>
  1041b2:	8b 45 08             	mov    0x8(%ebp),%eax
  1041b5:	8b 40 2c             	mov    0x2c(%eax),%eax
  1041b8:	8b 55 08             	mov    0x8(%ebp),%edx
  1041bb:	83 c2 2c             	add    $0x2c,%edx
  1041be:	89 44 24 08          	mov    %eax,0x8(%esp)
  1041c2:	89 54 24 04          	mov    %edx,0x4(%esp)
  1041c6:	c7 04 24 8b 59 10 00 	movl   $0x10598b,(%esp)
  1041cd:	e8 9e e4 ff ff       	call   102670 <debug_info>
  1041d2:	8b 45 08             	mov    0x8(%ebp),%eax
  1041d5:	8b 40 30             	mov    0x30(%eax),%eax
  1041d8:	8b 55 08             	mov    0x8(%ebp),%edx
  1041db:	83 c2 30             	add    $0x30,%edx
  1041de:	89 44 24 08          	mov    %eax,0x8(%esp)
  1041e2:	89 54 24 04          	mov    %edx,0x4(%esp)
  1041e6:	c7 04 24 a1 59 10 00 	movl   $0x1059a1,(%esp)
  1041ed:	e8 7e e4 ff ff       	call   102670 <debug_info>
  1041f2:	8b 45 08             	mov    0x8(%ebp),%eax
  1041f5:	0f b7 40 34          	movzwl 0x34(%eax),%eax
  1041f9:	0f b7 c0             	movzwl %ax,%eax
  1041fc:	8b 55 08             	mov    0x8(%ebp),%edx
  1041ff:	83 c2 34             	add    $0x34,%edx
  104202:	89 44 24 08          	mov    %eax,0x8(%esp)
  104206:	89 54 24 04          	mov    %edx,0x4(%esp)
  10420a:	c7 04 24 b7 59 10 00 	movl   $0x1059b7,(%esp)
  104211:	e8 5a e4 ff ff       	call   102670 <debug_info>
  104216:	8b 45 08             	mov    0x8(%ebp),%eax
  104219:	8b 40 38             	mov    0x38(%eax),%eax
  10421c:	8b 55 08             	mov    0x8(%ebp),%edx
  10421f:	83 c2 38             	add    $0x38,%edx
  104222:	89 44 24 08          	mov    %eax,0x8(%esp)
  104226:	89 54 24 04          	mov    %edx,0x4(%esp)
  10422a:	c7 04 24 cd 59 10 00 	movl   $0x1059cd,(%esp)
  104231:	e8 3a e4 ff ff       	call   102670 <debug_info>
  104236:	8b 45 08             	mov    0x8(%ebp),%eax
  104239:	8b 40 3c             	mov    0x3c(%eax),%eax
  10423c:	8b 55 08             	mov    0x8(%ebp),%edx
  10423f:	83 c2 3c             	add    $0x3c,%edx
  104242:	89 44 24 08          	mov    %eax,0x8(%esp)
  104246:	89 54 24 04          	mov    %edx,0x4(%esp)
  10424a:	c7 04 24 db 58 10 00 	movl   $0x1058db,(%esp)
  104251:	e8 1a e4 ff ff       	call   102670 <debug_info>
  104256:	8b 45 08             	mov    0x8(%ebp),%eax
  104259:	0f b7 40 40          	movzwl 0x40(%eax),%eax
  10425d:	0f b7 c0             	movzwl %ax,%eax
  104260:	8b 55 08             	mov    0x8(%ebp),%edx
  104263:	83 c2 40             	add    $0x40,%edx
  104266:	89 44 24 08          	mov    %eax,0x8(%esp)
  10426a:	89 54 24 04          	mov    %edx,0x4(%esp)
  10426e:	c7 04 24 e3 59 10 00 	movl   $0x1059e3,(%esp)
  104275:	e8 f6 e3 ff ff       	call   102670 <debug_info>
  10427a:	c9                   	leave  
  10427b:	c3                   	ret    

0010427c <pgflt_handler>:
  10427c:	55                   	push   %ebp
  10427d:	89 e5                	mov    %esp,%ebp
  10427f:	83 ec 38             	sub    $0x38,%esp
  104282:	8b 45 08             	mov    0x8(%ebp),%eax
  104285:	8b 40 2c             	mov    0x2c(%eax),%eax
  104288:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10428b:	e8 23 f3 ff ff       	call   1035b3 <rcr2>
  104290:	89 45 f0             	mov    %eax,-0x10(%ebp)
  104293:	8b 45 08             	mov    0x8(%ebp),%eax
  104296:	8b 50 30             	mov    0x30(%eax),%edx
  104299:	a1 4c df 10 00       	mov    0x10df4c,%eax
  10429e:	89 54 24 10          	mov    %edx,0x10(%esp)
  1042a2:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1042a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1042a9:	89 44 24 08          	mov    %eax,0x8(%esp)
  1042ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1042b0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1042b4:	c7 04 24 fc 59 10 00 	movl   $0x1059fc,(%esp)
  1042bb:	e8 31 e6 ff ff       	call   1028f1 <dprintf>
  1042c0:	8b 45 08             	mov    0x8(%ebp),%eax
  1042c3:	8b 40 2c             	mov    0x2c(%eax),%eax
  1042c6:	83 e0 01             	and    $0x1,%eax
  1042c9:	85 c0                	test   %eax,%eax
  1042cb:	74 2c                	je     1042f9 <pgflt_handler+0x7d>
  1042cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1042d0:	89 44 24 10          	mov    %eax,0x10(%esp)
  1042d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1042d7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1042db:	c7 44 24 08 40 5a 10 	movl   $0x105a40,0x8(%esp)
  1042e2:	00 
  1042e3:	c7 44 24 04 35 00 00 	movl   $0x35,0x4(%esp)
  1042ea:	00 
  1042eb:	c7 04 24 89 58 10 00 	movl   $0x105889,(%esp)
  1042f2:	e8 3a e4 ff ff       	call   102731 <debug_panic>
  1042f7:	eb 2d                	jmp    104326 <pgflt_handler+0xaa>
  1042f9:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  104300:	00 
  104301:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104304:	89 04 24             	mov    %eax,(%esp)
  104307:	e8 fe ef ff ff       	call   10330a <rounddown>
  10430c:	8b 15 4c df 10 00    	mov    0x10df4c,%edx
  104312:	c7 44 24 08 07 00 00 	movl   $0x7,0x8(%esp)
  104319:	00 
  10431a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10431e:	89 14 24             	mov    %edx,(%esp)
  104321:	e8 ba 0c 00 00       	call   104fe0 <alloc_page>
  104326:	c9                   	leave  
  104327:	c3                   	ret    

00104328 <checkpoint>:
  104328:	55                   	push   %ebp
  104329:	89 e5                	mov    %esp,%ebp
  10432b:	83 ec 18             	sub    $0x18,%esp
  10432e:	c7 04 24 71 5a 10 00 	movl   $0x105a71,(%esp)
  104335:	e8 36 e3 ff ff       	call   102670 <debug_info>
  10433a:	c9                   	leave  
  10433b:	c3                   	ret    

0010433c <trap>:
  10433c:	55                   	push   %ebp
  10433d:	89 e5                	mov    %esp,%ebp
  10433f:	83 ec 18             	sub    $0x18,%esp
  104342:	8b 45 08             	mov    0x8(%ebp),%eax
  104345:	8b 40 28             	mov    0x28(%eax),%eax
  104348:	83 f8 0e             	cmp    $0xe,%eax
  10434b:	75 19                	jne    104366 <trap+0x2a>
  10434d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104354:	e8 07 07 00 00       	call   104a60 <set_pdir_base>
  104359:	8b 45 08             	mov    0x8(%ebp),%eax
  10435c:	89 04 24             	mov    %eax,(%esp)
  10435f:	e8 18 ff ff ff       	call   10427c <pgflt_handler>
  104364:	eb 4d                	jmp    1043b3 <trap+0x77>
  104366:	8b 45 08             	mov    0x8(%ebp),%eax
  104369:	8b 40 28             	mov    0x28(%eax),%eax
  10436c:	89 44 24 0c          	mov    %eax,0xc(%esp)
  104370:	c7 44 24 08 7e 5a 10 	movl   $0x105a7e,0x8(%esp)
  104377:	00 
  104378:	c7 44 24 04 4e 00 00 	movl   $0x4e,0x4(%esp)
  10437f:	00 
  104380:	c7 04 24 89 58 10 00 	movl   $0x105889,(%esp)
  104387:	e8 04 e3 ff ff       	call   102690 <debug_normal>
  10438c:	8b 45 08             	mov    0x8(%ebp),%eax
  10438f:	89 04 24             	mov    %eax,(%esp)
  104392:	e8 7d fc ff ff       	call   104014 <trap_dump>
  104397:	c7 44 24 08 92 5a 10 	movl   $0x105a92,0x8(%esp)
  10439e:	00 
  10439f:	c7 44 24 04 50 00 00 	movl   $0x50,0x4(%esp)
  1043a6:	00 
  1043a7:	c7 04 24 89 58 10 00 	movl   $0x105889,(%esp)
  1043ae:	e8 7e e3 ff ff       	call   102731 <debug_panic>
  1043b3:	a1 4c df 10 00       	mov    0x10df4c,%eax
  1043b8:	89 04 24             	mov    %eax,(%esp)
  1043bb:	e8 a0 06 00 00       	call   104a60 <set_pdir_base>
  1043c0:	8b 45 08             	mov    0x8(%ebp),%eax
  1043c3:	89 04 24             	mov    %eax,(%esp)
  1043c6:	e8 15 e0 ff ff       	call   1023e0 <trap_return>
  1043cb:	c9                   	leave  
  1043cc:	c3                   	ret    
  1043cd:	66 90                	xchg   %ax,%ax
  1043cf:	90                   	nop

001043d0 <kern_init>:
    #endif
}

void
kern_init (uintptr_t mbi_addr)
{
  1043d0:	83 ec 1c             	sub    $0x1c,%esp
    #ifdef TEST
    pdir_init_kern(mbi_addr);
    #else
    paging_init (mbi_addr);
  1043d3:	8b 44 24 20          	mov    0x20(%esp),%eax
  1043d7:	89 04 24             	mov    %eax,(%esp)
  1043da:	e8 d1 0b 00 00       	call   104fb0 <paging_init>
    #endif

    KERN_DEBUG("Kernel initialized.\n");
  1043df:	c7 44 24 08 99 5a 10 	movl   $0x105a99,0x8(%esp)
  1043e6:	00 
  1043e7:	c7 44 24 04 50 00 00 	movl   $0x50,0x4(%esp)
  1043ee:	00 
  1043ef:	c7 04 24 ae 5a 10 00 	movl   $0x105aae,(%esp)
  1043f6:	e8 95 e2 ff ff       	call   102690 <debug_normal>
#endif

static void
kern_main (void)
{
    KERN_DEBUG("In kernel main.\n\n");
  1043fb:	c7 44 24 08 bf 5a 10 	movl   $0x105abf,0x8(%esp)
  104402:	00 
  104403:	c7 44 24 04 16 00 00 	movl   $0x16,0x4(%esp)
  10440a:	00 
  10440b:	c7 04 24 ae 5a 10 00 	movl   $0x105aae,(%esp)
  104412:	e8 79 e2 ff ff       	call   102690 <debug_normal>
      dprintf("All tests passed.\n");
    else
      dprintf("Test failed.\n");
    dprintf("\nTest complete. Please Use Ctrl-a x to exit qemu.");
    #else
    monitor(NULL);
  104417:	c7 44 24 20 00 00 00 	movl   $0x0,0x20(%esp)
  10441e:	00 
    #endif

    KERN_DEBUG("Kernel initialized.\n");

    kern_main ();
}
  10441f:	83 c4 1c             	add    $0x1c,%esp
      dprintf("All tests passed.\n");
    else
      dprintf("Test failed.\n");
    dprintf("\nTest complete. Please Use Ctrl-a x to exit qemu.");
    #else
    monitor(NULL);
  104422:	e9 51 f5 ff ff       	jmp    103978 <monitor>
  104427:	90                   	nop
  104428:	02 b0 ad 1b 03 00    	add    0x31bad(%eax),%dh
  10442e:	00 00                	add    %al,(%eax)
  104430:	fb                   	sti    
  104431:	4f                   	dec    %edi
  104432:	52                   	push   %edx
  104433:	e4 fa                	in     $0xfa,%al

00104434 <start>:
  104434:	fa                   	cli    
  104435:	3d 02 b0 ad 2b       	cmp    $0x2badb002,%eax
  10443a:	75 27                	jne    104463 <spin>
  10443c:	89 1d 64 44 10 00    	mov    %ebx,0x104464
  104442:	66 c7 05 72 04 00 00 	movw   $0x1234,0x472
  104449:	34 12 
  10444b:	6a 02                	push   $0x2
  10444d:	9d                   	popf   
  10444e:	bd 00 00 00 00       	mov    $0x0,%ebp
  104453:	bc 00 00 91 00       	mov    $0x910000,%esp
  104458:	ff 35 64 44 10 00    	pushl  0x104464
  10445e:	e8 6d ff ff ff       	call   1043d0 <kern_init>

00104463 <spin>:
  104463:	f4                   	hlt    

00104464 <multiboot_ptr>:
  104464:	00 00                	add    %al,(%eax)
  104466:	00 00                	add    %al,(%eax)
  104468:	66 90                	xchg   %ax,%ax
  10446a:	66 90                	xchg   %ax,%ax
  10446c:	66 90                	xchg   %ax,%ax
  10446e:	66 90                	xchg   %ax,%ax

00104470 <get_nps>:
//The getter function for NUM_PAGES.
unsigned int gcc_inline
get_nps(void)
{
	return NUM_PAGES;
}
  104470:	a1 60 df 90 00       	mov    0x90df60,%eax
  104475:	c3                   	ret    
  104476:	8d 76 00             	lea    0x0(%esi),%esi
  104479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104480 <set_nps>:

//The setter function for NUM_PAGES.
void gcc_inline
set_nps(unsigned int nps)
{
	NUM_PAGES = nps;
  104480:	8b 44 24 04          	mov    0x4(%esp),%eax
  104484:	a3 60 df 90 00       	mov    %eax,0x90df60
  104489:	c3                   	ret    
  10448a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104490 <at_is_norm>:
 * If the page with the given index has the normal permission,
 * then returns 1, otherwise returns 0.
 */
unsigned int
at_is_norm(unsigned int page_index)
{
  104490:	8b 54 24 04          	mov    0x4(%esp),%edx
  if (page_index >= (1 << 20)) {
	return 0;
  104494:	31 c0                	xor    %eax,%eax
 * then returns 1, otherwise returns 0.
 */
unsigned int
at_is_norm(unsigned int page_index)
{
  if (page_index >= (1 << 20)) {
  104496:	81 fa ff ff 0f 00    	cmp    $0xfffff,%edx
  10449c:	77 0d                	ja     1044ab <at_is_norm+0x1b>
	return 0;
        dprintf("page index in at_is_norm() out index");
  }
  if (AT[page_index].perm > 1) {
  10449e:	31 c0                	xor    %eax,%eax
  1044a0:	83 3c d5 60 df 10 00 	cmpl   $0x1,0x10df60(,%edx,8)
  1044a7:	01 
  1044a8:	0f 97 c0             	seta   %al
      return 1;
  } else {
      return 0;
  }
}
  1044ab:	f3 c3                	repz ret 
  1044ad:	8d 76 00             	lea    0x0(%esi),%esi

001044b0 <at_set_perm>:
 * Sets the permission of the page with given index.
 * It also marks the page as unallocated.
 */
void
at_set_perm(unsigned int page_index, unsigned int norm_val)
{
  1044b0:	8b 44 24 04          	mov    0x4(%esp),%eax
  if (page_index >= (1 << 20) ) {
  1044b4:	3d ff ff 0f 00       	cmp    $0xfffff,%eax
  1044b9:	77 16                	ja     1044d1 <at_set_perm+0x21>
	return;
  }
  AT[page_index].perm = norm_val;
  1044bb:	8b 54 24 08          	mov    0x8(%esp),%edx
at_set_allocated(unsigned int page_index, unsigned int allocated)
{
    if (page_index >= (1 << 20)) {
	return;
    }
    AT[page_index].allocated = allocated;
  1044bf:	c7 04 c5 64 df 10 00 	movl   $0x0,0x10df64(,%eax,8)
  1044c6:	00 00 00 00 
at_set_perm(unsigned int page_index, unsigned int norm_val)
{
  if (page_index >= (1 << 20) ) {
	return;
  }
  AT[page_index].perm = norm_val;
  1044ca:	89 14 c5 60 df 10 00 	mov    %edx,0x10df60(,%eax,8)
  1044d1:	f3 c3                	repz ret 
  1044d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1044d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001044e0 <at_is_allocated>:
 * The getter function for the physical page allocation flag.
 * Returns 0 if the page is not allocated. O.w., returns 1.
 */
unsigned int
at_is_allocated(unsigned int page_index)
{
  1044e0:	8b 54 24 04          	mov    0x4(%esp),%edx
  if (page_index >= (1 << 20)) {
     return 1;
  1044e4:	b8 01 00 00 00       	mov    $0x1,%eax
 * Returns 0 if the page is not allocated. O.w., returns 1.
 */
unsigned int
at_is_allocated(unsigned int page_index)
{
  if (page_index >= (1 << 20)) {
  1044e9:	81 fa ff ff 0f 00    	cmp    $0xfffff,%edx
  1044ef:	77 0e                	ja     1044ff <at_is_allocated+0x1f>
     return 1;
  }
  if (AT[page_index].allocated > 0) {
  1044f1:	8b 14 d5 64 df 10 00 	mov    0x10df64(,%edx,8),%edx
  1044f8:	31 c0                	xor    %eax,%eax
  1044fa:	85 d2                	test   %edx,%edx
  1044fc:	0f 95 c0             	setne  %al
     return 1;
  } else {
     return 0;
  }
}
  1044ff:	f3 c3                	repz ret 
  104501:	eb 0d                	jmp    104510 <at_set_allocated>
  104503:	90                   	nop
  104504:	90                   	nop
  104505:	90                   	nop
  104506:	90                   	nop
  104507:	90                   	nop
  104508:	90                   	nop
  104509:	90                   	nop
  10450a:	90                   	nop
  10450b:	90                   	nop
  10450c:	90                   	nop
  10450d:	90                   	nop
  10450e:	90                   	nop
  10450f:	90                   	nop

00104510 <at_set_allocated>:
 * The setter function for the physical page allocation flag.
 * Set the flag of the page with given index to the given value.
 */
void
at_set_allocated(unsigned int page_index, unsigned int allocated)
{
  104510:	8b 44 24 04          	mov    0x4(%esp),%eax
    if (page_index >= (1 << 20)) {
  104514:	3d ff ff 0f 00       	cmp    $0xfffff,%eax
  104519:	77 0b                	ja     104526 <at_set_allocated+0x16>
	return;
    }
    AT[page_index].allocated = allocated;
  10451b:	8b 54 24 08          	mov    0x8(%esp),%edx
  10451f:	89 14 c5 64 df 10 00 	mov    %edx,0x10df64(,%eax,8)
  104526:	f3 c3                	repz ret 
  104528:	66 90                	xchg   %ax,%ax
  10452a:	66 90                	xchg   %ax,%ax
  10452c:	66 90                	xchg   %ax,%ax
  10452e:	66 90                	xchg   %ax,%ax

00104530 <find_first_row>:
          }
    }
  } 
}

unsigned int find_first_row(unsigned int start_row, unsigned int rows, unsigned int page_index) {
  104530:	55                   	push   %ebp
  104531:	57                   	push   %edi
  104532:	56                   	push   %esi
  104533:	53                   	push   %ebx
  104534:	83 ec 1c             	sub    $0x1c,%esp
    int i;
    for(i = start_row; i < rows; i++) {
  104537:	8b 7c 24 30          	mov    0x30(%esp),%edi
  10453b:	89 fb                	mov    %edi,%ebx
  10453d:	89 fe                	mov    %edi,%esi
  10453f:	c1 e3 0c             	shl    $0xc,%ebx
  104542:	3b 7c 24 34          	cmp    0x34(%esp),%edi
  104546:	72 19                	jb     104561 <find_first_row+0x31>
  104548:	eb 46                	jmp    104590 <find_first_row+0x60>
  10454a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104550:	83 c7 01             	add    $0x1,%edi
  104553:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  104559:	3b 7c 24 34          	cmp    0x34(%esp),%edi
  10455d:	89 fe                	mov    %edi,%esi
  10455f:	73 2f                	jae    104590 <find_first_row+0x60>
      if (get_mms(i) >= i * PAGESIZE && get_mms(i) + get_mml(i) >= i * PAGESIZE) {
  104561:	89 34 24             	mov    %esi,(%esp)
  104564:	e8 bb c8 ff ff       	call   100e24 <get_mms>
  104569:	39 d8                	cmp    %ebx,%eax
  10456b:	72 e3                	jb     104550 <find_first_row+0x20>
  10456d:	89 34 24             	mov    %esi,(%esp)
  104570:	e8 af c8 ff ff       	call   100e24 <get_mms>
  104575:	89 34 24             	mov    %esi,(%esp)
  104578:	89 c5                	mov    %eax,%ebp
  10457a:	e8 fe c8 ff ff       	call   100e7d <get_mml>
  10457f:	01 c5                	add    %eax,%ebp
  104581:	39 dd                	cmp    %ebx,%ebp
  104583:	72 cb                	jb     104550 <find_first_row+0x20>
        return i;
      }
    }
    return 0;
}
  104585:	83 c4 1c             	add    $0x1c,%esp
  104588:	89 f0                	mov    %esi,%eax
  10458a:	5b                   	pop    %ebx
  10458b:	5e                   	pop    %esi
  10458c:	5f                   	pop    %edi
  10458d:	5d                   	pop    %ebp
  10458e:	c3                   	ret    
  10458f:	90                   	nop
  104590:	83 c4 1c             	add    $0x1c,%esp
    for(i = start_row; i < rows; i++) {
      if (get_mms(i) >= i * PAGESIZE && get_mms(i) + get_mml(i) >= i * PAGESIZE) {
        return i;
      }
    }
    return 0;
  104593:	31 c0                	xor    %eax,%eax
}
  104595:	5b                   	pop    %ebx
  104596:	5e                   	pop    %esi
  104597:	5f                   	pop    %edi
  104598:	5d                   	pop    %ebp
  104599:	c3                   	ret    
  10459a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001045a0 <pmem_init>:
 *    Review import.h in the current directory for the list of avaiable getter and setter functions.
 */
unsigned int find_first_row(unsigned int start_row, unsigned int rows, unsigned int page_index);
void
pmem_init(unsigned int mbi_addr)
{
  1045a0:	55                   	push   %ebp
  //      first_row = i;
  //      break;
  //  }
 // }
  first_row = 0;
  for (i = 0; i < nps; i++) {
  1045a1:	bd 01 00 00 00       	mov    $0x1,%ebp
 *    Review import.h in the current directory for the list of avaiable getter and setter functions.
 */
unsigned int find_first_row(unsigned int start_row, unsigned int rows, unsigned int page_index);
void
pmem_init(unsigned int mbi_addr)
{
  1045a6:	57                   	push   %edi
  1045a7:	56                   	push   %esi
  1045a8:	53                   	push   %ebx
  1045a9:	83 ec 2c             	sub    $0x2c,%esp
  unsigned int h_addr;
  unsigned int i;
  unsigned int first_row;
  //Calls the lower layer initializatin primitives.
  //The parameter mbi_addr shell not be used in the further code.
	devinit(mbi_addr);
  1045ac:	8b 44 24 40          	mov    0x40(%esp),%eax
  1045b0:	89 04 24             	mov    %eax,(%esp)
  1045b3:	e8 74 c3 ff ff       	call   10092c <devinit>
   * Calculate the number of actual number of avaiable physical pages and store it into the local varaible nps.
   * Hint: Think of it as the highest address possible in the ranges of the memory map table,
   *       divided by the page size.
   */
  // TODO
  rows = get_size();
  1045b8:	e8 5d c8 ff ff       	call   100e1a <get_size>
  h_addr = get_mms(rows - 1) + get_mml(rows - 1);
  1045bd:	8d 78 ff             	lea    -0x1(%eax),%edi
   * Calculate the number of actual number of avaiable physical pages and store it into the local varaible nps.
   * Hint: Think of it as the highest address possible in the ranges of the memory map table,
   *       divided by the page size.
   */
  // TODO
  rows = get_size();
  1045c0:	89 c6                	mov    %eax,%esi
  h_addr = get_mms(rows - 1) + get_mml(rows - 1);
  1045c2:	89 3c 24             	mov    %edi,(%esp)
  1045c5:	e8 5a c8 ff ff       	call   100e24 <get_mms>
  1045ca:	89 3c 24             	mov    %edi,(%esp)
  //  if(get_mms(i) <= VM_USERLO && get_mms(i) + get_mml(i) >=VM_USERLO) {
  //      first_row = i;
  //      break;
  //  }
 // }
  first_row = 0;
  1045cd:	31 ff                	xor    %edi,%edi
   * Hint: Think of it as the highest address possible in the ranges of the memory map table,
   *       divided by the page size.
   */
  // TODO
  rows = get_size();
  h_addr = get_mms(rows - 1) + get_mml(rows - 1);
  1045cf:	89 c3                	mov    %eax,%ebx
  1045d1:	e8 a7 c8 ff ff       	call   100e7d <get_mml>
  dprintf("h_addr: %u\n", h_addr);
  1045d6:	c7 04 24 d1 5a 10 00 	movl   $0x105ad1,(%esp)
   * Hint: Think of it as the highest address possible in the ranges of the memory map table,
   *       divided by the page size.
   */
  // TODO
  rows = get_size();
  h_addr = get_mms(rows - 1) + get_mml(rows - 1);
  1045dd:	01 c3                	add    %eax,%ebx
  dprintf("h_addr: %u\n", h_addr);
  1045df:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  nps = h_addr / PAGESIZE;
  1045e3:	c1 eb 0c             	shr    $0xc,%ebx
   *       divided by the page size.
   */
  // TODO
  rows = get_size();
  h_addr = get_mms(rows - 1) + get_mml(rows - 1);
  dprintf("h_addr: %u\n", h_addr);
  1045e6:	e8 06 e3 ff ff       	call   1028f1 <dprintf>
  nps = h_addr / PAGESIZE;
	set_nps(nps); // Setting the value computed above to NUM_PAGES.
  1045eb:	89 1c 24             	mov    %ebx,(%esp)
  1045ee:	e8 8d fe ff ff       	call   104480 <set_nps>
  //      first_row = i;
  //      break;
  //  }
 // }
  first_row = 0;
  for (i = 0; i < nps; i++) {
  1045f3:	85 db                	test   %ebx,%ebx
  1045f5:	75 0b                	jne    104602 <pmem_init+0x62>
  1045f7:	eb 30                	jmp    104629 <pmem_init+0x89>
  1045f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104600:	89 c5                	mov    %eax,%ebp
  104602:	8d 85 ff ff fb ff    	lea    -0x40001(%ebp),%eax
    if (i < VM_USERLO_PI  || i >= VM_USERHI_PI) {
  104608:	3d ff ff 0a 00       	cmp    $0xaffff,%eax
  10460d:	8d 55 ff             	lea    -0x1(%ebp),%edx
  104610:	76 1f                	jbe    104631 <pmem_init+0x91>
    // this is reserved by kernel
       at_set_perm(i, 1);
  104612:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  104619:	00 
  10461a:	89 14 24             	mov    %edx,(%esp)
  10461d:	e8 8e fe ff ff       	call   1044b0 <at_set_perm>
  //      first_row = i;
  //      break;
  //  }
 // }
  first_row = 0;
  for (i = 0; i < nps; i++) {
  104622:	39 eb                	cmp    %ebp,%ebx
  104624:	8d 45 01             	lea    0x1(%ebp),%eax
  104627:	77 d7                	ja     104600 <pmem_init+0x60>
              }
            }
          }
    }
  } 
}
  104629:	83 c4 2c             	add    $0x2c,%esp
  10462c:	5b                   	pop    %ebx
  10462d:	5e                   	pop    %esi
  10462e:	5f                   	pop    %edi
  10462f:	5d                   	pop    %ebp
  104630:	c3                   	ret    
  for (i = 0; i < nps; i++) {
    if (i < VM_USERLO_PI  || i >= VM_USERHI_PI) {
    // this is reserved by kernel
       at_set_perm(i, 1);
    } else {
       first_row = find_first_row(first_row, rows, i);
  104631:	89 3c 24             	mov    %edi,(%esp)
  104634:	89 54 24 08          	mov    %edx,0x8(%esp)
  104638:	89 74 24 04          	mov    %esi,0x4(%esp)
  10463c:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  104640:	e8 eb fe ff ff       	call   104530 <find_first_row>
        while (first_row < rows) {
  104645:	39 c6                	cmp    %eax,%esi
  for (i = 0; i < nps; i++) {
    if (i < VM_USERLO_PI  || i >= VM_USERHI_PI) {
    // this is reserved by kernel
       at_set_perm(i, 1);
    } else {
       first_row = find_first_row(first_row, rows, i);
  104647:	89 c7                	mov    %eax,%edi
        while (first_row < rows) {
  104649:	76 d7                	jbe    104622 <pmem_init+0x82>
  10464b:	89 e8                	mov    %ebp,%eax
  10464d:	c1 e0 0c             	shl    $0xc,%eax
  104650:	83 e8 01             	sub    $0x1,%eax
  104653:	89 44 24 10          	mov    %eax,0x10(%esp)
  104657:	89 74 24 0c          	mov    %esi,0xc(%esp)
  10465b:	89 5c 24 14          	mov    %ebx,0x14(%esp)
  10465f:	89 6c 24 18          	mov    %ebp,0x18(%esp)
  104663:	eb 2f                	jmp    104694 <pmem_init+0xf4>
              at_set_perm(i, 0);
            }
            first_row ++;
            break;
          } else {
            if (first_row + 1 < rows && get_mms(first_row + 1) == get_mms(first_row) + get_mml(first_row) + 1) {
  104665:	8d 6f 01             	lea    0x1(%edi),%ebp
  104668:	39 6c 24 0c          	cmp    %ebp,0xc(%esp)
  10466c:	76 7c                	jbe    1046ea <pmem_init+0x14a>
  10466e:	89 2c 24             	mov    %ebp,(%esp)
  104671:	e8 ae c7 ff ff       	call   100e24 <get_mms>
  104676:	89 3c 24             	mov    %edi,(%esp)
  104679:	89 c3                	mov    %eax,%ebx
  10467b:	e8 a4 c7 ff ff       	call   100e24 <get_mms>
  104680:	89 3c 24             	mov    %edi,(%esp)
  104683:	89 c6                	mov    %eax,%esi
  104685:	e8 f3 c7 ff ff       	call   100e7d <get_mml>
  10468a:	8d 44 06 01          	lea    0x1(%esi,%eax,1),%eax
  10468e:	39 c3                	cmp    %eax,%ebx
  104690:	75 58                	jne    1046ea <pmem_init+0x14a>
  104692:	89 ef                	mov    %ebp,%edi
    // this is reserved by kernel
       at_set_perm(i, 1);
    } else {
       first_row = find_first_row(first_row, rows, i);
        while (first_row < rows) {
          if (get_mms(first_row) + get_mml(first_row) >= (i + 1) * PAGESIZE - 1) {
  104694:	89 3c 24             	mov    %edi,(%esp)
  104697:	e8 88 c7 ff ff       	call   100e24 <get_mms>
  10469c:	89 3c 24             	mov    %edi,(%esp)
  10469f:	89 c3                	mov    %eax,%ebx
  1046a1:	e8 d7 c7 ff ff       	call   100e7d <get_mml>
  1046a6:	01 c3                	add    %eax,%ebx
  1046a8:	3b 5c 24 10          	cmp    0x10(%esp),%ebx
  1046ac:	72 b7                	jb     104665 <pmem_init+0xc5>
  1046ae:	8b 54 24 1c          	mov    0x1c(%esp),%edx
            if (is_usable(first_row)) {
  1046b2:	89 3c 24             	mov    %edi,(%esp)
  1046b5:	8b 74 24 0c          	mov    0xc(%esp),%esi
  1046b9:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  1046bd:	8b 6c 24 18          	mov    0x18(%esp),%ebp
  1046c1:	89 54 24 0c          	mov    %edx,0xc(%esp)
  1046c5:	e8 16 c8 ff ff       	call   100ee0 <is_usable>
  1046ca:	8b 54 24 0c          	mov    0xc(%esp),%edx
  1046ce:	85 c0                	test   %eax,%eax
  1046d0:	74 47                	je     104719 <pmem_init+0x179>
              at_set_perm(i, 2);
  1046d2:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  1046d9:	00 
  1046da:	89 14 24             	mov    %edx,(%esp)
  1046dd:	e8 ce fd ff ff       	call   1044b0 <at_set_perm>
            } else {
              at_set_perm(i, 0);
            }
            first_row ++;
  1046e2:	83 c7 01             	add    $0x1,%edi
            break;
  1046e5:	e9 38 ff ff ff       	jmp    104622 <pmem_init+0x82>
  1046ea:	8b 54 24 1c          	mov    0x1c(%esp),%edx
            if (first_row + 1 < rows && get_mms(first_row + 1) == get_mms(first_row) + get_mml(first_row) + 1) {

              first_row ++;
            } else {
              first_row++;
              at_set_perm(i, 0);
  1046ee:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1046f5:	00 
  1046f6:	8b 74 24 0c          	mov    0xc(%esp),%esi
  1046fa:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  1046fe:	89 6c 24 0c          	mov    %ebp,0xc(%esp)
  104702:	8b 6c 24 18          	mov    0x18(%esp),%ebp
  104706:	89 14 24             	mov    %edx,(%esp)
  104709:	e8 a2 fd ff ff       	call   1044b0 <at_set_perm>
              break;
  10470e:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  104712:	89 cf                	mov    %ecx,%edi
  104714:	e9 09 ff ff ff       	jmp    104622 <pmem_init+0x82>
        while (first_row < rows) {
          if (get_mms(first_row) + get_mml(first_row) >= (i + 1) * PAGESIZE - 1) {
            if (is_usable(first_row)) {
              at_set_perm(i, 2);
            } else {
              at_set_perm(i, 0);
  104719:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104720:	00 
  104721:	89 14 24             	mov    %edx,(%esp)
  104724:	e8 87 fd ff ff       	call   1044b0 <at_set_perm>
  104729:	eb b7                	jmp    1046e2 <pmem_init+0x142>
  10472b:	66 90                	xchg   %ax,%ax
  10472d:	66 90                	xchg   %ax,%ax
  10472f:	90                   	nop

00104730 <naive_palloc>:
 *    return 0.
 * 2. Optimize the code with the memorization techniques so that you do not have to
 *    scan the allocation table from scratch every time.
 */

unsigned int naive_palloc() {
  104730:	53                   	push   %ebx
     //unsigned int nps = get_nps() - 1 > VM_USERHI_PI ? VM_USERHI_PI : get_nps() - 1;
     unsigned int i;
     for (i = VM_USERLO_PI; i <  VM_USERHI_PI; i++) {
  104731:	bb 00 00 04 00       	mov    $0x40000,%ebx
 *    return 0.
 * 2. Optimize the code with the memorization techniques so that you do not have to
 *    scan the allocation table from scratch every time.
 */

unsigned int naive_palloc() {
  104736:	83 ec 18             	sub    $0x18,%esp
  104739:	eb 10                	jmp    10474b <naive_palloc+0x1b>
  10473b:	90                   	nop
  10473c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     //unsigned int nps = get_nps() - 1 > VM_USERHI_PI ? VM_USERHI_PI : get_nps() - 1;
     unsigned int i;
     for (i = VM_USERLO_PI; i <  VM_USERHI_PI; i++) {
  104740:	83 c3 01             	add    $0x1,%ebx
  104743:	81 fb 00 00 0f 00    	cmp    $0xf0000,%ebx
  104749:	74 35                	je     104780 <naive_palloc+0x50>
//         dprintf("%u:is_allocated %u, is_norm %u", at_is_allocated(i), at_is_norm(i));
     if (at_is_allocated(i) == 0 && at_is_norm(i)) {
  10474b:	89 1c 24             	mov    %ebx,(%esp)
  10474e:	e8 8d fd ff ff       	call   1044e0 <at_is_allocated>
  104753:	85 c0                	test   %eax,%eax
  104755:	75 e9                	jne    104740 <naive_palloc+0x10>
  104757:	89 1c 24             	mov    %ebx,(%esp)
  10475a:	e8 31 fd ff ff       	call   104490 <at_is_norm>
  10475f:	85 c0                	test   %eax,%eax
  104761:	74 dd                	je     104740 <naive_palloc+0x10>
             at_set_allocated(i, 1);
  104763:	89 1c 24             	mov    %ebx,(%esp)
  104766:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  10476d:	00 
  10476e:	e8 9d fd ff ff       	call   104510 <at_set_allocated>
             return i;
         }
     }
     dprintf("find nothing!");
     return 0;
}
  104773:	83 c4 18             	add    $0x18,%esp
     unsigned int i;
     for (i = VM_USERLO_PI; i <  VM_USERHI_PI; i++) {
//         dprintf("%u:is_allocated %u, is_norm %u", at_is_allocated(i), at_is_norm(i));
     if (at_is_allocated(i) == 0 && at_is_norm(i)) {
             at_set_allocated(i, 1);
             return i;
  104776:	89 d8                	mov    %ebx,%eax
         }
     }
     dprintf("find nothing!");
     return 0;
}
  104778:	5b                   	pop    %ebx
  104779:	c3                   	ret    
  10477a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     if (at_is_allocated(i) == 0 && at_is_norm(i)) {
             at_set_allocated(i, 1);
             return i;
         }
     }
     dprintf("find nothing!");
  104780:	c7 04 24 dd 5a 10 00 	movl   $0x105add,(%esp)
  104787:	e8 65 e1 ff ff       	call   1028f1 <dprintf>
     return 0;
}
  10478c:	83 c4 18             	add    $0x18,%esp
             at_set_allocated(i, 1);
             return i;
         }
     }
     dprintf("find nothing!");
     return 0;
  10478f:	31 c0                	xor    %eax,%eax
}
  104791:	5b                   	pop    %ebx
  104792:	c3                   	ret    
  104793:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001047a0 <palloc>:
unsigned int
palloc()
{
  // TODO
  static unsigned int start = VM_USERLO_PI;
  for (; start < VM_USERHI_PI; start++) {
  1047a0:	a1 00 a0 10 00       	mov    0x10a000,%eax
  1047a5:	3d ff ff 0e 00       	cmp    $0xeffff,%eax
  1047aa:	77 5b                	ja     104807 <palloc+0x67>
     return 0;
}

unsigned int
palloc()
{
  1047ac:	83 ec 1c             	sub    $0x1c,%esp
  1047af:	eb 1b                	jmp    1047cc <palloc+0x2c>
  1047b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  // TODO
  static unsigned int start = VM_USERLO_PI;
  for (; start < VM_USERHI_PI; start++) {
  1047b8:	a1 00 a0 10 00       	mov    0x10a000,%eax
  1047bd:	83 c0 01             	add    $0x1,%eax
  1047c0:	3d ff ff 0e 00       	cmp    $0xeffff,%eax
  1047c5:	a3 00 a0 10 00       	mov    %eax,0x10a000
  1047ca:	77 37                	ja     104803 <palloc+0x63>
    if (at_is_allocated(start) == 0 && at_is_norm(start)) {
  1047cc:	89 04 24             	mov    %eax,(%esp)
  1047cf:	e8 0c fd ff ff       	call   1044e0 <at_is_allocated>
  1047d4:	85 c0                	test   %eax,%eax
  1047d6:	75 e0                	jne    1047b8 <palloc+0x18>
  1047d8:	a1 00 a0 10 00       	mov    0x10a000,%eax
  1047dd:	89 04 24             	mov    %eax,(%esp)
  1047e0:	e8 ab fc ff ff       	call   104490 <at_is_norm>
  1047e5:	85 c0                	test   %eax,%eax
  1047e7:	74 cf                	je     1047b8 <palloc+0x18>
      at_set_allocated(start, 1);
  1047e9:	a1 00 a0 10 00       	mov    0x10a000,%eax
  1047ee:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  1047f5:	00 
  1047f6:	89 04 24             	mov    %eax,(%esp)
  1047f9:	e8 12 fd ff ff       	call   104510 <at_set_allocated>
      return start;
  1047fe:	a1 00 a0 10 00       	mov    0x10a000,%eax
    }
  }     
  //return 0;
  //return naive_palloc();
} 
  104803:	83 c4 1c             	add    $0x1c,%esp
  104806:	c3                   	ret    
  104807:	f3 c3                	repz ret 
  104809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104810 <pfree>:
 *
 * Hint: Simple.
 */
void
pfree(unsigned int pfree_index)
{
  104810:	53                   	push   %ebx
  104811:	83 ec 18             	sub    $0x18,%esp
  104814:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  // TODO
  if (pfree_index < get_nps()) {
  104818:	e8 53 fc ff ff       	call   104470 <get_nps>
  10481d:	39 d8                	cmp    %ebx,%eax
  10481f:	76 10                	jbe    104831 <pfree+0x21>
      at_set_allocated(pfree_index, 0);
  104821:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104828:	00 
  104829:	89 1c 24             	mov    %ebx,(%esp)
  10482c:	e8 df fc ff ff       	call   104510 <at_set_allocated>
  } 
}
  104831:	83 c4 18             	add    $0x18,%esp
  104834:	5b                   	pop    %ebx
  104835:	c3                   	ret    
  104836:	66 90                	xchg   %ax,%ax
  104838:	66 90                	xchg   %ax,%ax
  10483a:	66 90                	xchg   %ax,%ax
  10483c:	66 90                	xchg   %ax,%ax
  10483e:	66 90                	xchg   %ax,%ax

00104840 <container_init>:
/**
 * Initializes the container data for the root process (the one with index 0).
 * The root process is the one that gets spawned first by the kernel.
 */
void container_init(unsigned int mbi_addr)
{
  104840:	57                   	push   %edi
  unsigned int real_quota;
  int max_nps;
  int i;
  pmem_init(mbi_addr);
  real_quota = 0;
  104841:	31 ff                	xor    %edi,%edi
/**
 * Initializes the container data for the root process (the one with index 0).
 * The root process is the one that gets spawned first by the kernel.
 */
void container_init(unsigned int mbi_addr)
{
  104843:	56                   	push   %esi
  104844:	53                   	push   %ebx
  /**
   * TODO: compute the available quota and store it into the variable real_quota.
   * It should be the number of the unallocated pages with the normal permission
   * in the physical memory allocation table.
   */
  for (i = 0; i < max_nps; i++) 
  104845:	31 db                	xor    %ebx,%ebx
/**
 * Initializes the container data for the root process (the one with index 0).
 * The root process is the one that gets spawned first by the kernel.
 */
void container_init(unsigned int mbi_addr)
{
  104847:	83 ec 10             	sub    $0x10,%esp
  unsigned int real_quota;
  int max_nps;
  int i;
  pmem_init(mbi_addr);
  10484a:	8b 44 24 20          	mov    0x20(%esp),%eax
  10484e:	89 04 24             	mov    %eax,(%esp)
  104851:	e8 4a fd ff ff       	call   1045a0 <pmem_init>
  real_quota = 0;
  max_nps = get_nps();
  104856:	e8 15 fc ff ff       	call   104470 <get_nps>
  /**
   * TODO: compute the available quota and store it into the variable real_quota.
   * It should be the number of the unallocated pages with the normal permission
   * in the physical memory allocation table.
   */
  for (i = 0; i < max_nps; i++) 
  10485b:	85 c0                	test   %eax,%eax
  unsigned int real_quota;
  int max_nps;
  int i;
  pmem_init(mbi_addr);
  real_quota = 0;
  max_nps = get_nps();
  10485d:	89 c6                	mov    %eax,%esi
  /**
   * TODO: compute the available quota and store it into the variable real_quota.
   * It should be the number of the unallocated pages with the normal permission
   * in the physical memory allocation table.
   */
  for (i = 0; i < max_nps; i++) 
  10485f:	7f 0e                	jg     10486f <container_init+0x2f>
  104861:	eb 37                	jmp    10489a <container_init+0x5a>
  104863:	90                   	nop
  104864:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104868:	83 c3 01             	add    $0x1,%ebx
  10486b:	39 de                	cmp    %ebx,%esi
  10486d:	74 29                	je     104898 <container_init+0x58>
  {
    if (at_is_norm(i) == 1 && at_is_allocated(i) == 0)
  10486f:	89 1c 24             	mov    %ebx,(%esp)
  104872:	e8 19 fc ff ff       	call   104490 <at_is_norm>
  104877:	83 f8 01             	cmp    $0x1,%eax
  10487a:	75 ec                	jne    104868 <container_init+0x28>
  10487c:	89 1c 24             	mov    %ebx,(%esp)
  10487f:	e8 5c fc ff ff       	call   1044e0 <at_is_allocated>
    {
      real_quota += 1;
  104884:	83 f8 01             	cmp    $0x1,%eax
  104887:	83 d7 00             	adc    $0x0,%edi
  /**
   * TODO: compute the available quota and store it into the variable real_quota.
   * It should be the number of the unallocated pages with the normal permission
   * in the physical memory allocation table.
   */
  for (i = 0; i < max_nps; i++) 
  10488a:	83 c3 01             	add    $0x1,%ebx
  10488d:	39 de                	cmp    %ebx,%esi
  10488f:	75 de                	jne    10486f <container_init+0x2f>
  104891:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104898:	89 fb                	mov    %edi,%ebx
    if (at_is_norm(i) == 1 && at_is_allocated(i) == 0)
    {
      real_quota += 1;
    }
  }
  KERN_DEBUG("\nreal quota: %d\n\n", real_quota);
  10489a:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  10489e:	c7 44 24 08 eb 5a 10 	movl   $0x105aeb,0x8(%esp)
  1048a5:	00 
  1048a6:	c7 44 24 04 28 00 00 	movl   $0x28,0x4(%esp)
  1048ad:	00 
  1048ae:	c7 04 24 00 5b 10 00 	movl   $0x105b00,(%esp)
  1048b5:	e8 d6 dd ff ff       	call   102690 <debug_normal>

  CONTAINER[0].quota = real_quota;
  1048ba:	89 1d 80 df 90 00    	mov    %ebx,0x90df80
  CONTAINER[0].usage = 0;
  1048c0:	c7 05 84 df 90 00 00 	movl   $0x0,0x90df84
  1048c7:	00 00 00 
  CONTAINER[0].parent = 0;
  1048ca:	c7 05 88 df 90 00 00 	movl   $0x0,0x90df88
  1048d1:	00 00 00 
  CONTAINER[0].nchildren = 0;
  1048d4:	c7 05 8c df 90 00 00 	movl   $0x0,0x90df8c
  1048db:	00 00 00 
  CONTAINER[0].used = 1;
  1048de:	c7 05 90 df 90 00 01 	movl   $0x1,0x90df90
  1048e5:	00 00 00 
}
  1048e8:	83 c4 10             	add    $0x10,%esp
  1048eb:	5b                   	pop    %ebx
  1048ec:	5e                   	pop    %esi
  1048ed:	5f                   	pop    %edi
  1048ee:	c3                   	ret    
  1048ef:	90                   	nop

001048f0 <container_get_parent>:


// get the id of parent process of process # [id]
unsigned int container_get_parent(unsigned int id)
{
  1048f0:	8b 54 24 04          	mov    0x4(%esp),%edx
  // TODO
  if (id >= NUM_IDS) 
  {
      return 0;
  1048f4:	31 c0                	xor    %eax,%eax

// get the id of parent process of process # [id]
unsigned int container_get_parent(unsigned int id)
{
  // TODO
  if (id >= NUM_IDS) 
  1048f6:	83 fa 3f             	cmp    $0x3f,%edx
  1048f9:	77 0a                	ja     104905 <container_get_parent+0x15>
  {
      return 0;
  }
  return CONTAINER[id].parent;
  1048fb:	8d 04 92             	lea    (%edx,%edx,4),%eax
  1048fe:	8b 04 85 88 df 90 00 	mov    0x90df88(,%eax,4),%eax
}
  104905:	f3 c3                	repz ret 
  104907:	89 f6                	mov    %esi,%esi
  104909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104910 <container_get_nchildren>:


// get the number of children of process # [id]
unsigned int container_get_nchildren(unsigned int id)
{
  104910:	8b 54 24 04          	mov    0x4(%esp),%edx
  // TODO
  if (id < NUM_IDS && id >= 0) 
  {
      return CONTAINER[id].nchildren;
  }
  return 0;
  104914:	31 c0                	xor    %eax,%eax

// get the number of children of process # [id]
unsigned int container_get_nchildren(unsigned int id)
{
  // TODO
  if (id < NUM_IDS && id >= 0) 
  104916:	83 fa 3f             	cmp    $0x3f,%edx
  104919:	77 0a                	ja     104925 <container_get_nchildren+0x15>
  {
      return CONTAINER[id].nchildren;
  10491b:	8d 04 92             	lea    (%edx,%edx,4),%eax
  10491e:	8b 04 85 8c df 90 00 	mov    0x90df8c(,%eax,4),%eax
  }
  return 0;
}
  104925:	f3 c3                	repz ret 
  104927:	89 f6                	mov    %esi,%esi
  104929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104930 <container_get_quota>:


// get the maximum memory quota of process # [id]
unsigned int container_get_quota(unsigned int id)
{
  104930:	8b 44 24 04          	mov    0x4(%esp),%eax
  // TODO
  return CONTAINER[id].quota;
  104934:	8d 04 80             	lea    (%eax,%eax,4),%eax
  104937:	8b 04 85 80 df 90 00 	mov    0x90df80(,%eax,4),%eax
}
  10493e:	c3                   	ret    
  10493f:	90                   	nop

00104940 <container_get_usage>:


// get the current memory usage of process # [id]
unsigned int container_get_usage(unsigned int id)
{
  104940:	8b 44 24 04          	mov    0x4(%esp),%eax
  // TODO
  return CONTAINER[id].usage;
  104944:	8d 04 80             	lea    (%eax,%eax,4),%eax
  104947:	8b 04 85 84 df 90 00 	mov    0x90df84(,%eax,4),%eax
}
  10494e:	c3                   	ret    
  10494f:	90                   	nop

00104950 <container_can_consume>:


// determines whether the process # [id] can consume extra
// [n] pages of memory. If so, returns 1, o.w., returns 0.
unsigned int container_can_consume(unsigned int id, unsigned int n)
{
  104950:	8b 44 24 04          	mov    0x4(%esp),%eax
  // TODO
  return CONTAINER[id].quota - CONTAINER[id].usage >= n ? 1 : 0;
  104954:	8d 14 80             	lea    (%eax,%eax,4),%edx
  104957:	8b 04 95 80 df 90 00 	mov    0x90df80(,%edx,4),%eax
  10495e:	2b 04 95 84 df 90 00 	sub    0x90df84(,%edx,4),%eax
  104965:	3b 44 24 08          	cmp    0x8(%esp),%eax
  104969:	0f 93 c0             	setae  %al
  10496c:	0f b6 c0             	movzbl %al,%eax
}
  10496f:	c3                   	ret    

00104970 <container_split>:
 * dedicates [quota] pages of memory for a new child process.
 * you can assume it is safe to allocate [quota] pages (i.e., the check is already done outside before calling this function)
 * returns the container index for the new child process.
 */
unsigned int container_split(unsigned int id, unsigned int quota)
{
  104970:	56                   	push   %esi
  104971:	53                   	push   %ebx
  104972:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  104976:	8b 74 24 10          	mov    0x10(%esp),%esi
  unsigned int child, nc;

  nc = CONTAINER[id].nchildren;
  10497a:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
  child = id * MAX_CHILDREN + 1 + nc; //container index for the child process
  10497d:	8b 14 85 8c df 90 00 	mov    0x90df8c(,%eax,4),%edx
  104984:	8d 04 5b             	lea    (%ebx,%ebx,2),%eax
  104987:	8d 44 02 01          	lea    0x1(%edx,%eax,1),%eax

  /**
   * TODO: update the container structure of both parent and child process appropriately.
   */
  while(CONTAINER[child].used)
  10498b:	8d 14 80             	lea    (%eax,%eax,4),%edx
  10498e:	8b 14 95 90 df 90 00 	mov    0x90df90(,%edx,4),%edx
  104995:	85 d2                	test   %edx,%edx
  104997:	74 1d                	je     1049b6 <container_split+0x46>
  104999:	8d 48 01             	lea    0x1(%eax),%ecx
  10499c:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
  10499f:	8d 14 85 90 df 90 00 	lea    0x90df90(,%eax,4),%edx
  1049a6:	eb 03                	jmp    1049ab <container_split+0x3b>
  1049a8:	83 c1 01             	add    $0x1,%ecx
  1049ab:	83 c2 14             	add    $0x14,%edx
  {
    child++;
  1049ae:	89 c8                	mov    %ecx,%eax
  child = id * MAX_CHILDREN + 1 + nc; //container index for the child process

  /**
   * TODO: update the container structure of both parent and child process appropriately.
   */
  while(CONTAINER[child].used)
  1049b0:	83 7a ec 00          	cmpl   $0x0,-0x14(%edx)
  1049b4:	75 f2                	jne    1049a8 <container_split+0x38>
  {
    child++;
  }
  // modify parent(id) info
  CONTAINER[id].usage += quota;
  1049b6:	8d 14 9b             	lea    (%ebx,%ebx,4),%edx
  1049b9:	8d 14 95 80 df 90 00 	lea    0x90df80(,%edx,4),%edx
  1049c0:	01 72 04             	add    %esi,0x4(%edx)
  CONTAINER[id].nchildren += 1;
  1049c3:	83 42 0c 01          	addl   $0x1,0xc(%edx)
  // modify child info
  CONTAINER[child].quota = quota;
  1049c7:	8d 14 80             	lea    (%eax,%eax,4),%edx
  1049ca:	c1 e2 02             	shl    $0x2,%edx
  1049cd:	89 b2 80 df 90 00    	mov    %esi,0x90df80(%edx)
  CONTAINER[child].usage = 0;
  CONTAINER[child].parent = id;
  1049d3:	89 9a 88 df 90 00    	mov    %ebx,0x90df88(%edx)
  // modify parent(id) info
  CONTAINER[id].usage += quota;
  CONTAINER[id].nchildren += 1;
  // modify child info
  CONTAINER[child].quota = quota;
  CONTAINER[child].usage = 0;
  1049d9:	c7 82 84 df 90 00 00 	movl   $0x0,0x90df84(%edx)
  1049e0:	00 00 00 
  CONTAINER[child].parent = id;
  CONTAINER[child].nchildren = 0;
  CONTAINER[child].used = 1;
  return child;
}
  1049e3:	5b                   	pop    %ebx
  CONTAINER[id].nchildren += 1;
  // modify child info
  CONTAINER[child].quota = quota;
  CONTAINER[child].usage = 0;
  CONTAINER[child].parent = id;
  CONTAINER[child].nchildren = 0;
  1049e4:	c7 82 8c df 90 00 00 	movl   $0x0,0x90df8c(%edx)
  1049eb:	00 00 00 
  CONTAINER[child].used = 1;
  1049ee:	c7 82 90 df 90 00 01 	movl   $0x1,0x90df90(%edx)
  1049f5:	00 00 00 
  return child;
}
  1049f8:	5e                   	pop    %esi
  1049f9:	c3                   	ret    
  1049fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104a00 <container_alloc>:
 * allocates one more page for process # [id], given that its usage would not exceed the quota.
 * the container structure should be updated accordingly after the allocation.
 * returns the page index of the allocated page, or 0 in the case of failure.
 */
unsigned int container_alloc(unsigned int id)
{
  104a00:	53                   	push   %ebx
  104a01:	83 ec 08             	sub    $0x8,%esp
  104a04:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  /*
   * TODO: implement the function here.
   */
  int page_id = palloc();
  104a08:	e8 93 fd ff ff       	call   1047a0 <palloc>
  if (page_id == 0) {
  104a0d:	85 c0                	test   %eax,%eax
  104a0f:	74 17                	je     104a28 <container_alloc+0x28>
    return 0;
  }
  CONTAINER[id].usage += 1;
  104a11:	8d 14 9b             	lea    (%ebx,%ebx,4),%edx
  104a14:	c1 e2 02             	shl    $0x2,%edx
  104a17:	83 82 84 df 90 00 01 	addl   $0x1,0x90df84(%edx)
  CONTAINER[id].used = 1;
  104a1e:	c7 82 90 df 90 00 01 	movl   $0x1,0x90df90(%edx)
  104a25:	00 00 00 
  return page_id;
}
  104a28:	83 c4 08             	add    $0x8,%esp
  104a2b:	5b                   	pop    %ebx
  104a2c:	c3                   	ret    
  104a2d:	8d 76 00             	lea    0x0(%esi),%esi

00104a30 <container_free>:

// frees the physical page and reduces the usage by 1.
void container_free(unsigned int id, unsigned int page_index)
{
  104a30:	53                   	push   %ebx
  104a31:	83 ec 18             	sub    $0x18,%esp
  // TODO
  pfree(page_index);
  104a34:	8b 44 24 24          	mov    0x24(%esp),%eax
  return page_id;
}

// frees the physical page and reduces the usage by 1.
void container_free(unsigned int id, unsigned int page_index)
{
  104a38:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  // TODO
  pfree(page_index);
  104a3c:	89 04 24             	mov    %eax,(%esp)
  104a3f:	e8 cc fd ff ff       	call   104810 <pfree>
  CONTAINER[id].usage -= 1;
  104a44:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
  104a47:	83 2c 85 84 df 90 00 	subl   $0x1,0x90df84(,%eax,4)
  104a4e:	01 
}
  104a4f:	83 c4 18             	add    $0x18,%esp
  104a52:	5b                   	pop    %ebx
  104a53:	c3                   	ret    
  104a54:	66 90                	xchg   %ax,%ax
  104a56:	66 90                	xchg   %ax,%ax
  104a58:	66 90                	xchg   %ax,%ax
  104a5a:	66 90                	xchg   %ax,%ax
  104a5c:	66 90                	xchg   %ax,%ax
  104a5e:	66 90                	xchg   %ax,%ax

00104a60 <set_pdir_base>:
unsigned int IDPTbl[1024][1024] gcc_aligned(PAGESIZE);


// sets the CR3 register with the start address of the page structure for process # [index]
void set_pdir_base(unsigned int index)
{
  104a60:	8b 44 24 04          	mov    0x4(%esp),%eax
    // TODO
    if (index >= NUM_IDS)
  104a64:	83 f8 3f             	cmp    $0x3f,%eax
  104a67:	76 07                	jbe    104a70 <set_pdir_base+0x10>
  104a69:	f3 c3                	repz ret 
  104a6b:	90                   	nop
  104a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    {
	// process id exceed the boundary
	return;
    }
    set_cr3(PDirPool[index]);
  104a70:	c1 e0 0c             	shl    $0xc,%eax
  104a73:	05 00 40 d5 00       	add    $0xd54000,%eax
  104a78:	89 44 24 04          	mov    %eax,0x4(%esp)
  104a7c:	e9 c2 c4 ff ff       	jmp    100f43 <set_cr3>
  104a81:	eb 0d                	jmp    104a90 <get_pdir_entry>
  104a83:	90                   	nop
  104a84:	90                   	nop
  104a85:	90                   	nop
  104a86:	90                   	nop
  104a87:	90                   	nop
  104a88:	90                   	nop
  104a89:	90                   	nop
  104a8a:	90                   	nop
  104a8b:	90                   	nop
  104a8c:	90                   	nop
  104a8d:	90                   	nop
  104a8e:	90                   	nop
  104a8f:	90                   	nop

00104a90 <get_pdir_entry>:
}

// returns the page directory entry # [pde_index] of the process # [proc_index]
// this can be used to test whether the page directory entry is mapped
unsigned int get_pdir_entry(unsigned int proc_index, unsigned int pde_index)
{
  104a90:	8b 44 24 04          	mov    0x4(%esp),%eax
    // TODO
    return (unsigned int)PDirPool[proc_index][pde_index];
  104a94:	c1 e0 0a             	shl    $0xa,%eax
  104a97:	03 44 24 08          	add    0x8(%esp),%eax
  104a9b:	8b 04 85 00 40 d5 00 	mov    0xd54000(,%eax,4),%eax
}   
  104aa2:	c3                   	ret    
  104aa3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104aa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104ab0 <set_pdir_entry>:

// sets specified page directory entry with the start address of physical page # [page_index].
// you should also set the permissions PTE_P, PTE_W, and PTE_U
void set_pdir_entry(unsigned int proc_index, unsigned int pde_index, unsigned int page_index)
{
  104ab0:	8b 44 24 04          	mov    0x4(%esp),%eax
    if (proc_index >= NUM_IDS || pde_index >= 1024) 
  104ab4:	83 f8 3f             	cmp    $0x3f,%eax
  104ab7:	77 22                	ja     104adb <set_pdir_entry+0x2b>
  104ab9:	81 7c 24 08 ff 03 00 	cmpl   $0x3ff,0x8(%esp)
  104ac0:	00 
  104ac1:	77 18                	ja     104adb <set_pdir_entry+0x2b>
    {
	return;
    }
    PDirPool[proc_index][pde_index] = (char*)(page_index * PAGESIZE + PT_PERM_PTU);
  104ac3:	8b 54 24 0c          	mov    0xc(%esp),%edx
  104ac7:	c1 e0 0a             	shl    $0xa,%eax
  104aca:	03 44 24 08          	add    0x8(%esp),%eax
  104ace:	c1 e2 0c             	shl    $0xc,%edx
  104ad1:	83 c2 07             	add    $0x7,%edx
  104ad4:	89 14 85 00 40 d5 00 	mov    %edx,0xd54000(,%eax,4)
  104adb:	f3 c3                	repz ret 
  104add:	8d 76 00             	lea    0x0(%esi),%esi

00104ae0 <set_pdir_entry_identity>:
// sets the page directory entry # [pde_index] for the process # [proc_index]
// with the initial address of page directory # [pde_index] in IDPTbl
// you should also set the permissions PTE_P, PTE_W, and PTE_U
// this will be used to map the page directory entry to identity page table.
void set_pdir_entry_identity(unsigned int proc_index, unsigned int pde_index)
{   
  104ae0:	8b 54 24 04          	mov    0x4(%esp),%edx
  104ae4:	8b 44 24 08          	mov    0x8(%esp),%eax
    PDirPool[proc_index][pde_index] = (char*)((unsigned int)IDPTbl[pde_index] | PT_PERM_PTU);
  104ae8:	c1 e2 0a             	shl    $0xa,%edx
  104aeb:	01 c2                	add    %eax,%edx
  104aed:	c1 e0 0c             	shl    $0xc,%eax
  104af0:	05 00 40 95 00       	add    $0x954000,%eax
  104af5:	83 c8 07             	or     $0x7,%eax
  104af8:	89 04 95 00 40 d5 00 	mov    %eax,0xd54000(,%edx,4)
  104aff:	c3                   	ret    

00104b00 <rmv_pdir_entry>:
}   

// removes specified page directory entry (set the page directory entry to 0).
// don't forget to cast the value to (char *).
void rmv_pdir_entry(unsigned int proc_index, unsigned int pde_index)
{
  104b00:	8b 44 24 04          	mov    0x4(%esp),%eax
    PDirPool[proc_index][pde_index] = (char*)0;
  104b04:	c1 e0 0a             	shl    $0xa,%eax
  104b07:	03 44 24 08          	add    0x8(%esp),%eax
  104b0b:	c7 04 85 00 40 d5 00 	movl   $0x0,0xd54000(,%eax,4)
  104b12:	00 00 00 00 
  104b16:	c3                   	ret    
  104b17:	89 f6                	mov    %esi,%esi
  104b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104b20 <get_ptbl_entry>:
}   

// returns the specified page table entry.
// do not forget that the permission info is also stored in the page directory entries.
unsigned int get_ptbl_entry(unsigned int proc_index, unsigned int pde_index, unsigned int pte_index)
{   
  104b20:	8b 44 24 04          	mov    0x4(%esp),%eax
// returns the page directory entry # [pde_index] of the process # [proc_index]
// this can be used to test whether the page directory entry is mapped
unsigned int get_pdir_entry(unsigned int proc_index, unsigned int pde_index)
{
    // TODO
    return (unsigned int)PDirPool[proc_index][pde_index];
  104b24:	c1 e0 0a             	shl    $0xa,%eax
  104b27:	03 44 24 08          	add    0x8(%esp),%eax

// returns the specified page table entry.
// do not forget that the permission info is also stored in the page directory entries.
unsigned int get_ptbl_entry(unsigned int proc_index, unsigned int pde_index, unsigned int pte_index)
{   
    unsigned int  ptl_address = (unsigned int)get_pdir_entry(proc_index, pde_index) & ~0xFFF;
  104b2b:	8b 14 85 00 40 d5 00 	mov    0xd54000(,%eax,4),%edx
    if(ptl_address){
        return ((unsigned int *)ptl_address)[pte_index];
    }
	else {
		return 0;
  104b32:	31 c0                	xor    %eax,%eax
// returns the specified page table entry.
// do not forget that the permission info is also stored in the page directory entries.
unsigned int get_ptbl_entry(unsigned int proc_index, unsigned int pde_index, unsigned int pte_index)
{   
    unsigned int  ptl_address = (unsigned int)get_pdir_entry(proc_index, pde_index) & ~0xFFF;
    if(ptl_address){
  104b34:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  104b3a:	74 07                	je     104b43 <get_ptbl_entry+0x23>
        return ((unsigned int *)ptl_address)[pte_index];
  104b3c:	8b 44 24 0c          	mov    0xc(%esp),%eax
  104b40:	8b 04 82             	mov    (%edx,%eax,4),%eax
    }
	else {
		return 0;
	}
}
  104b43:	f3 c3                	repz ret 
  104b45:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104b50 <set_ptbl_entry>:

// sets specified page table entry with the start address of physical page # [page_index]
// you should also set the given permission
void set_ptbl_entry(unsigned int proc_index, unsigned int pde_index, unsigned int pte_index, unsigned int page_index, unsigned int perm)
{   
  104b50:	8b 54 24 04          	mov    0x4(%esp),%edx
  104b54:	8b 44 24 10          	mov    0x10(%esp),%eax
    unsigned int pt_address = (unsigned int)(PDirPool[proc_index][pde_index]);
    pt_address = pt_address & ~0xFFF;
    ((unsigned int *)pt_address)[pte_index] = (unsigned int)(page_index * PAGESIZE + perm);
  104b58:	8b 4c 24 0c          	mov    0xc(%esp),%ecx

// sets specified page table entry with the start address of physical page # [page_index]
// you should also set the given permission
void set_ptbl_entry(unsigned int proc_index, unsigned int pde_index, unsigned int pte_index, unsigned int page_index, unsigned int perm)
{   
    unsigned int pt_address = (unsigned int)(PDirPool[proc_index][pde_index]);
  104b5c:	c1 e2 0a             	shl    $0xa,%edx
  104b5f:	03 54 24 08          	add    0x8(%esp),%edx
    pt_address = pt_address & ~0xFFF;
    ((unsigned int *)pt_address)[pte_index] = (unsigned int)(page_index * PAGESIZE + perm);
  104b63:	c1 e0 0c             	shl    $0xc,%eax
  104b66:	03 44 24 14          	add    0x14(%esp),%eax

// sets specified page table entry with the start address of physical page # [page_index]
// you should also set the given permission
void set_ptbl_entry(unsigned int proc_index, unsigned int pde_index, unsigned int pte_index, unsigned int page_index, unsigned int perm)
{   
    unsigned int pt_address = (unsigned int)(PDirPool[proc_index][pde_index]);
  104b6a:	8b 14 95 00 40 d5 00 	mov    0xd54000(,%edx,4),%edx
    pt_address = pt_address & ~0xFFF;
  104b71:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
    ((unsigned int *)pt_address)[pte_index] = (unsigned int)(page_index * PAGESIZE + perm);
  104b77:	89 04 8a             	mov    %eax,(%edx,%ecx,4)
  104b7a:	c3                   	ret    
  104b7b:	90                   	nop
  104b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00104b80 <set_ptbl_entry_identity>:
}   

// sets the specified page table entry in IDPTbl as the identity map.
// you should also set the given permission
void set_ptbl_entry_identity(unsigned int pde_index, unsigned int pte_index, unsigned int perm)
{
  104b80:	8b 54 24 04          	mov    0x4(%esp),%edx
  104b84:	8b 44 24 08          	mov    0x8(%esp),%eax
    // TODO
    IDPTbl[pde_index][pte_index] = pde_index << 22 | pte_index << 12 | perm;
  104b88:	89 d1                	mov    %edx,%ecx
  104b8a:	c1 e1 0a             	shl    $0xa,%ecx
  104b8d:	01 c1                	add    %eax,%ecx
  104b8f:	c1 e0 0c             	shl    $0xc,%eax
  104b92:	0b 44 24 0c          	or     0xc(%esp),%eax
  104b96:	c1 e2 16             	shl    $0x16,%edx
  104b99:	09 d0                	or     %edx,%eax
  104b9b:	89 04 8d 00 40 95 00 	mov    %eax,0x954000(,%ecx,4)
  104ba2:	c3                   	ret    
  104ba3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104bb0 <rmv_ptbl_entry>:
}

// sets the specified page table entry to 0
void rmv_ptbl_entry(unsigned int proc_index, unsigned int pde_index, unsigned int pte_index)
{
  104bb0:	8b 44 24 04          	mov    0x4(%esp),%eax
    // TODO
   unsigned int  pt_address =  (unsigned int)PDirPool[proc_index][pde_index] & ~0xFFF;
   ((char**)pt_address)[pte_index] = 0;
  104bb4:	8b 54 24 0c          	mov    0xc(%esp),%edx

// sets the specified page table entry to 0
void rmv_ptbl_entry(unsigned int proc_index, unsigned int pde_index, unsigned int pte_index)
{
    // TODO
   unsigned int  pt_address =  (unsigned int)PDirPool[proc_index][pde_index] & ~0xFFF;
  104bb8:	c1 e0 0a             	shl    $0xa,%eax
  104bbb:	03 44 24 08          	add    0x8(%esp),%eax
  104bbf:	8b 04 85 00 40 d5 00 	mov    0xd54000(,%eax,4),%eax
  104bc6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
   ((char**)pt_address)[pte_index] = 0;
  104bcb:	c7 04 90 00 00 00 00 	movl   $0x0,(%eax,%edx,4)
  104bd2:	c3                   	ret    
  104bd3:	66 90                	xchg   %ax,%ax
  104bd5:	66 90                	xchg   %ax,%ax
  104bd7:	66 90                	xchg   %ax,%ax
  104bd9:	66 90                	xchg   %ax,%ax
  104bdb:	66 90                	xchg   %ax,%ax
  104bdd:	66 90                	xchg   %ax,%ax
  104bdf:	90                   	nop

00104be0 <get_ptbl_entry_by_va>:
 * Returns the page table entry corresponding to the virtual address,
 * according to the page structure of process # [proc_index].
 * Returns 0 if the mapping does not exist.
 */
unsigned int get_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
  104be0:	56                   	push   %esi
  104be1:	53                   	push   %ebx
  104be2:	83 ec 14             	sub    $0x14,%esp
  104be5:	8b 5c 24 20          	mov    0x20(%esp),%ebx
    // TODO
    if (proc_index >= NUM_IDS) 
  104be9:	83 fb 3f             	cmp    $0x3f,%ebx
  104bec:	76 0a                	jbe    104bf8 <get_ptbl_entry_by_va+0x18>
    if (get_pdir_entry(proc_index, pde_index) == 0) 
    {
        return 0;
    }
    return get_ptbl_entry(proc_index, pde_index, pte_index);
}         
  104bee:	83 c4 14             	add    $0x14,%esp
unsigned int get_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
    // TODO
    if (proc_index >= NUM_IDS) 
    {
        return 0;
  104bf1:	31 c0                	xor    %eax,%eax
    if (get_pdir_entry(proc_index, pde_index) == 0) 
    {
        return 0;
    }
    return get_ptbl_entry(proc_index, pde_index, pte_index);
}         
  104bf3:	5b                   	pop    %ebx
  104bf4:	5e                   	pop    %esi
  104bf5:	c3                   	ret    
  104bf6:	66 90                	xchg   %ax,%ax
    // TODO
    if (proc_index >= NUM_IDS) 
    {
        return 0;
    }
    unsigned int pde_index = vaddr >> 22;
  104bf8:	8b 74 24 24          	mov    0x24(%esp),%esi
    unsigned int pte_index = (vaddr>>12) & (0x003FF);
    if (get_pdir_entry(proc_index, pde_index) == 0) 
  104bfc:	89 1c 24             	mov    %ebx,(%esp)
    // TODO
    if (proc_index >= NUM_IDS) 
    {
        return 0;
    }
    unsigned int pde_index = vaddr >> 22;
  104bff:	c1 ee 16             	shr    $0x16,%esi
    unsigned int pte_index = (vaddr>>12) & (0x003FF);
    if (get_pdir_entry(proc_index, pde_index) == 0) 
  104c02:	89 74 24 04          	mov    %esi,0x4(%esp)
  104c06:	e8 85 fe ff ff       	call   104a90 <get_pdir_entry>
  104c0b:	85 c0                	test   %eax,%eax
  104c0d:	74 df                	je     104bee <get_ptbl_entry_by_va+0xe>
    if (proc_index >= NUM_IDS) 
    {
        return 0;
    }
    unsigned int pde_index = vaddr >> 22;
    unsigned int pte_index = (vaddr>>12) & (0x003FF);
  104c0f:	8b 44 24 24          	mov    0x24(%esp),%eax
    if (get_pdir_entry(proc_index, pde_index) == 0) 
    {
        return 0;
    }
    return get_ptbl_entry(proc_index, pde_index, pte_index);
  104c13:	89 74 24 04          	mov    %esi,0x4(%esp)
  104c17:	89 1c 24             	mov    %ebx,(%esp)
    if (proc_index >= NUM_IDS) 
    {
        return 0;
    }
    unsigned int pde_index = vaddr >> 22;
    unsigned int pte_index = (vaddr>>12) & (0x003FF);
  104c1a:	c1 e8 0c             	shr    $0xc,%eax
  104c1d:	25 ff 03 00 00       	and    $0x3ff,%eax
    if (get_pdir_entry(proc_index, pde_index) == 0) 
    {
        return 0;
    }
    return get_ptbl_entry(proc_index, pde_index, pte_index);
  104c22:	89 44 24 08          	mov    %eax,0x8(%esp)
  104c26:	e8 f5 fe ff ff       	call   104b20 <get_ptbl_entry>
}         
  104c2b:	83 c4 14             	add    $0x14,%esp
  104c2e:	5b                   	pop    %ebx
  104c2f:	5e                   	pop    %esi
  104c30:	c3                   	ret    
  104c31:	eb 0d                	jmp    104c40 <get_pdir_entry_by_va>
  104c33:	90                   	nop
  104c34:	90                   	nop
  104c35:	90                   	nop
  104c36:	90                   	nop
  104c37:	90                   	nop
  104c38:	90                   	nop
  104c39:	90                   	nop
  104c3a:	90                   	nop
  104c3b:	90                   	nop
  104c3c:	90                   	nop
  104c3d:	90                   	nop
  104c3e:	90                   	nop
  104c3f:	90                   	nop

00104c40 <get_pdir_entry_by_va>:
// returns the page directory entry corresponding to the given virtual address
unsigned int get_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
    // TODO
    unsigned int pde_index = vaddr >> 22;
    return get_pdir_entry(proc_index, pde_index);
  104c40:	c1 6c 24 08 16       	shrl   $0x16,0x8(%esp)
  104c45:	e9 46 fe ff ff       	jmp    104a90 <get_pdir_entry>
  104c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104c50 <rmv_ptbl_entry_by_va>:
}

// removes the page table entry for the given virtual address
void rmv_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
  104c50:	83 ec 1c             	sub    $0x1c,%esp
  104c53:	8b 54 24 24          	mov    0x24(%esp),%edx
    // TODO
    unsigned int pde_index = vaddr >> 22;
    unsigned int pte_index = (vaddr>>12) & (0x003FF); 
  104c57:	89 d0                	mov    %edx,%eax
  104c59:	c1 e8 0c             	shr    $0xc,%eax
  104c5c:	25 ff 03 00 00       	and    $0x3ff,%eax
    rmv_ptbl_entry(proc_index, pde_index, pte_index);
  104c61:	89 44 24 08          	mov    %eax,0x8(%esp)
  104c65:	8b 44 24 20          	mov    0x20(%esp),%eax

// removes the page table entry for the given virtual address
void rmv_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
    // TODO
    unsigned int pde_index = vaddr >> 22;
  104c69:	c1 ea 16             	shr    $0x16,%edx
    unsigned int pte_index = (vaddr>>12) & (0x003FF); 
    rmv_ptbl_entry(proc_index, pde_index, pte_index);
  104c6c:	89 54 24 04          	mov    %edx,0x4(%esp)
  104c70:	89 04 24             	mov    %eax,(%esp)
  104c73:	e8 38 ff ff ff       	call   104bb0 <rmv_ptbl_entry>
}
  104c78:	83 c4 1c             	add    $0x1c,%esp
  104c7b:	c3                   	ret    
  104c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00104c80 <rmv_pdir_entry_by_va>:
// removes the page directory entry for the given virtual address
void rmv_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
    // TODO
    unsigned int pde_index = vaddr >> 22;
    rmv_pdir_entry(proc_index, pde_index);
  104c80:	c1 6c 24 08 16       	shrl   $0x16,0x8(%esp)
  104c85:	e9 76 fe ff ff       	jmp    104b00 <rmv_pdir_entry>
  104c8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104c90 <set_ptbl_entry_by_va>:
}

// maps the virtual address [vaddr] to the physical page # [page_index] with permission [perm]
// you do not need to worry about the page directory entry. just map the page table entry.
void set_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr, unsigned int page_index, unsigned int perm)
{
  104c90:	83 ec 2c             	sub    $0x2c,%esp
    // TODO
    unsigned int pde_index = vaddr >> 22;
    unsigned int pte_index = (vaddr>>12) & (0x003FF); 
    set_ptbl_entry(proc_index, pde_index, pte_index, page_index, perm);
  104c93:	8b 44 24 3c          	mov    0x3c(%esp),%eax
}

// maps the virtual address [vaddr] to the physical page # [page_index] with permission [perm]
// you do not need to worry about the page directory entry. just map the page table entry.
void set_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr, unsigned int page_index, unsigned int perm)
{
  104c97:	8b 54 24 34          	mov    0x34(%esp),%edx
    // TODO
    unsigned int pde_index = vaddr >> 22;
    unsigned int pte_index = (vaddr>>12) & (0x003FF); 
    set_ptbl_entry(proc_index, pde_index, pte_index, page_index, perm);
  104c9b:	89 44 24 10          	mov    %eax,0x10(%esp)
  104c9f:	8b 44 24 38          	mov    0x38(%esp),%eax
  104ca3:	89 44 24 0c          	mov    %eax,0xc(%esp)
// you do not need to worry about the page directory entry. just map the page table entry.
void set_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr, unsigned int page_index, unsigned int perm)
{
    // TODO
    unsigned int pde_index = vaddr >> 22;
    unsigned int pte_index = (vaddr>>12) & (0x003FF); 
  104ca7:	89 d0                	mov    %edx,%eax
  104ca9:	c1 e8 0c             	shr    $0xc,%eax
  104cac:	25 ff 03 00 00       	and    $0x3ff,%eax
    set_ptbl_entry(proc_index, pde_index, pte_index, page_index, perm);
  104cb1:	89 44 24 08          	mov    %eax,0x8(%esp)
  104cb5:	8b 44 24 30          	mov    0x30(%esp),%eax
// maps the virtual address [vaddr] to the physical page # [page_index] with permission [perm]
// you do not need to worry about the page directory entry. just map the page table entry.
void set_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr, unsigned int page_index, unsigned int perm)
{
    // TODO
    unsigned int pde_index = vaddr >> 22;
  104cb9:	c1 ea 16             	shr    $0x16,%edx
    unsigned int pte_index = (vaddr>>12) & (0x003FF); 
    set_ptbl_entry(proc_index, pde_index, pte_index, page_index, perm);
  104cbc:	89 54 24 04          	mov    %edx,0x4(%esp)
  104cc0:	89 04 24             	mov    %eax,(%esp)
  104cc3:	e8 88 fe ff ff       	call   104b50 <set_ptbl_entry>
}
  104cc8:	83 c4 2c             	add    $0x2c,%esp
  104ccb:	c3                   	ret    
  104ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00104cd0 <set_pdir_entry_by_va>:

// registers the mapping from [vaddr] to physical page # [page_index] in the page directory
void set_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr, unsigned int page_index)
{
  104cd0:	8b 44 24 08          	mov    0x8(%esp),%eax
    // TODO
    unsigned int pde_index = vaddr >> 22;
  104cd4:	c1 e8 16             	shr    $0x16,%eax
    set_pdir_entry(proc_index, pde_index, page_index);    
  104cd7:	89 44 24 08          	mov    %eax,0x8(%esp)
  104cdb:	e9 d0 fd ff ff       	jmp    104ab0 <set_pdir_entry>

00104ce0 <idptbl_init>:

// initializes the identity page table
// the permission for the kernel memory should be PTE_P, PTE_W, and PTE_G,
// while the permission for the rest should be PTE_P and PTE_W.
void idptbl_init(unsigned int mbi_adr)
{
  104ce0:	57                   	push   %edi
  104ce1:	56                   	push   %esi
    int pde_index, ptb_index;
    container_init(mbi_adr);
    for (pde_index = 0; pde_index < 1024; pde_index ++)
  104ce2:	31 f6                	xor    %esi,%esi

// initializes the identity page table
// the permission for the kernel memory should be PTE_P, PTE_W, and PTE_G,
// while the permission for the rest should be PTE_P and PTE_W.
void idptbl_init(unsigned int mbi_adr)
{
  104ce4:	53                   	push   %ebx
  104ce5:	83 ec 10             	sub    $0x10,%esp
    int pde_index, ptb_index;
    container_init(mbi_adr);
  104ce8:	8b 44 24 20          	mov    0x20(%esp),%eax
  104cec:	89 04 24             	mov    %eax,(%esp)
  104cef:	e8 4c fb ff ff       	call   104840 <container_init>
  104cf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104cf8:	89 f7                	mov    %esi,%edi

// initializes the identity page table
// the permission for the kernel memory should be PTE_P, PTE_W, and PTE_G,
// while the permission for the rest should be PTE_P and PTE_W.
void idptbl_init(unsigned int mbi_adr)
{
  104cfa:	31 db                	xor    %ebx,%ebx
  104cfc:	c1 e7 16             	shl    $0x16,%edi
  104cff:	eb 26                	jmp    104d27 <idptbl_init+0x47>
  104d01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        {
            unsigned int ph_address = pde_index << 22 | ptb_index << 12;
            if (ph_address < 0x40000000 || ph_address >= 0xF0000000) 
            {
                // reserved by kernel
                set_ptbl_entry_identity(pde_index, ptb_index, PTE_P|PTE_W|PTE_G);
  104d08:	89 5c 24 04          	mov    %ebx,0x4(%esp)
{
    int pde_index, ptb_index;
    container_init(mbi_adr);
    for (pde_index = 0; pde_index < 1024; pde_index ++)
    {
        for (ptb_index = 0; ptb_index < 1024; ptb_index++) 
  104d0c:	83 c3 01             	add    $0x1,%ebx
        {
            unsigned int ph_address = pde_index << 22 | ptb_index << 12;
            if (ph_address < 0x40000000 || ph_address >= 0xF0000000) 
            {
                // reserved by kernel
                set_ptbl_entry_identity(pde_index, ptb_index, PTE_P|PTE_W|PTE_G);
  104d0f:	c7 44 24 08 03 01 00 	movl   $0x103,0x8(%esp)
  104d16:	00 
  104d17:	89 34 24             	mov    %esi,(%esp)
  104d1a:	e8 61 fe ff ff       	call   104b80 <set_ptbl_entry_identity>
{
    int pde_index, ptb_index;
    container_init(mbi_adr);
    for (pde_index = 0; pde_index < 1024; pde_index ++)
    {
        for (ptb_index = 0; ptb_index < 1024; ptb_index++) 
  104d1f:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
  104d25:	74 32                	je     104d59 <idptbl_init+0x79>
        {
            unsigned int ph_address = pde_index << 22 | ptb_index << 12;
  104d27:	89 d8                	mov    %ebx,%eax
  104d29:	c1 e0 0c             	shl    $0xc,%eax
  104d2c:	09 f8                	or     %edi,%eax
            if (ph_address < 0x40000000 || ph_address >= 0xF0000000) 
  104d2e:	2d 00 00 00 40       	sub    $0x40000000,%eax
  104d33:	3d ff ff ff af       	cmp    $0xafffffff,%eax
  104d38:	77 ce                	ja     104d08 <idptbl_init+0x28>
                // reserved by kernel
                set_ptbl_entry_identity(pde_index, ptb_index, PTE_P|PTE_W|PTE_G);
            }
            else
            {
        		set_ptbl_entry_identity(pde_index, ptb_index, PTE_P|PTE_W);    
  104d3a:	89 5c 24 04          	mov    %ebx,0x4(%esp)
{
    int pde_index, ptb_index;
    container_init(mbi_adr);
    for (pde_index = 0; pde_index < 1024; pde_index ++)
    {
        for (ptb_index = 0; ptb_index < 1024; ptb_index++) 
  104d3e:	83 c3 01             	add    $0x1,%ebx
                // reserved by kernel
                set_ptbl_entry_identity(pde_index, ptb_index, PTE_P|PTE_W|PTE_G);
            }
            else
            {
        		set_ptbl_entry_identity(pde_index, ptb_index, PTE_P|PTE_W);    
  104d41:	c7 44 24 08 03 00 00 	movl   $0x3,0x8(%esp)
  104d48:	00 
  104d49:	89 34 24             	mov    %esi,(%esp)
  104d4c:	e8 2f fe ff ff       	call   104b80 <set_ptbl_entry_identity>
{
    int pde_index, ptb_index;
    container_init(mbi_adr);
    for (pde_index = 0; pde_index < 1024; pde_index ++)
    {
        for (ptb_index = 0; ptb_index < 1024; ptb_index++) 
  104d51:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
  104d57:	75 ce                	jne    104d27 <idptbl_init+0x47>
// while the permission for the rest should be PTE_P and PTE_W.
void idptbl_init(unsigned int mbi_adr)
{
    int pde_index, ptb_index;
    container_init(mbi_adr);
    for (pde_index = 0; pde_index < 1024; pde_index ++)
  104d59:	83 c6 01             	add    $0x1,%esi
  104d5c:	81 fe 00 04 00 00    	cmp    $0x400,%esi
  104d62:	75 94                	jne    104cf8 <idptbl_init+0x18>
            {
        		set_ptbl_entry_identity(pde_index, ptb_index, PTE_P|PTE_W);    
			}
        }
    } 
}
  104d64:	83 c4 10             	add    $0x10,%esp
  104d67:	5b                   	pop    %ebx
  104d68:	5e                   	pop    %esi
  104d69:	5f                   	pop    %edi
  104d6a:	c3                   	ret    
  104d6b:	66 90                	xchg   %ax,%ax
  104d6d:	66 90                	xchg   %ax,%ax
  104d6f:	90                   	nop

00104d70 <pdir_init>:
 * For each process from id 0 to NUM_IDS -1,
 * set the page directory entries sothat the kernel portion of the map as identity map,
 * and the rest of page directories are unmmaped.
 */
void pdir_init(unsigned int mbi_adr)
{
  104d70:	56                   	push   %esi
    idptbl_init(mbi_adr);
    unsigned int PG_LO = (0x40000000 >> 22);
    unsigned int PG_HI = (0xF0000000 >> 22);
    //unsigned int PG_LO = 256, PG_HI = 960;
    // TODO
    for (proc_index = 0; proc_index < NUM_IDS; proc_index++)
  104d71:	31 f6                	xor    %esi,%esi
 * For each process from id 0 to NUM_IDS -1,
 * set the page directory entries sothat the kernel portion of the map as identity map,
 * and the rest of page directories are unmmaped.
 */
void pdir_init(unsigned int mbi_adr)
{
  104d73:	53                   	push   %ebx
  104d74:	83 ec 14             	sub    $0x14,%esp
    // TODO: define your local variables here.
    unsigned int proc_index, pde_index;
    idptbl_init(mbi_adr);
  104d77:	8b 44 24 20          	mov    0x20(%esp),%eax
  104d7b:	89 04 24             	mov    %eax,(%esp)
  104d7e:	e8 5d ff ff ff       	call   104ce0 <idptbl_init>
  104d83:	90                   	nop
  104d84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 * For each process from id 0 to NUM_IDS -1,
 * set the page directory entries sothat the kernel portion of the map as identity map,
 * and the rest of page directories are unmmaped.
 */
void pdir_init(unsigned int mbi_adr)
{
  104d88:	31 db                	xor    %ebx,%ebx
  104d8a:	eb 0f                	jmp    104d9b <pdir_init+0x2b>
  104d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    unsigned int PG_HI = (0xF0000000 >> 22);
    //unsigned int PG_LO = 256, PG_HI = 960;
    // TODO
    for (proc_index = 0; proc_index < NUM_IDS; proc_index++)
    {
       for (pde_index = 0; pde_index < 1024; pde_index++)
  104d90:	83 c3 01             	add    $0x1,%ebx
  104d93:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
  104d99:	74 24                	je     104dbf <pdir_init+0x4f>
  104d9b:	8d 83 00 ff ff ff    	lea    -0x100(%ebx),%eax
       {
          if (pde_index < PG_LO || pde_index >= PG_HI) 
  104da1:	3d bf 02 00 00       	cmp    $0x2bf,%eax
  104da6:	76 e8                	jbe    104d90 <pdir_init+0x20>
          {
              // reserve for kernel
              set_pdir_entry_identity(proc_index, pde_index);
  104da8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    unsigned int PG_HI = (0xF0000000 >> 22);
    //unsigned int PG_LO = 256, PG_HI = 960;
    // TODO
    for (proc_index = 0; proc_index < NUM_IDS; proc_index++)
    {
       for (pde_index = 0; pde_index < 1024; pde_index++)
  104dac:	83 c3 01             	add    $0x1,%ebx
       {
          if (pde_index < PG_LO || pde_index >= PG_HI) 
          {
              // reserve for kernel
              set_pdir_entry_identity(proc_index, pde_index);
  104daf:	89 34 24             	mov    %esi,(%esp)
  104db2:	e8 29 fd ff ff       	call   104ae0 <set_pdir_entry_identity>
    unsigned int PG_HI = (0xF0000000 >> 22);
    //unsigned int PG_LO = 256, PG_HI = 960;
    // TODO
    for (proc_index = 0; proc_index < NUM_IDS; proc_index++)
    {
       for (pde_index = 0; pde_index < 1024; pde_index++)
  104db7:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
  104dbd:	75 dc                	jne    104d9b <pdir_init+0x2b>
    idptbl_init(mbi_adr);
    unsigned int PG_LO = (0x40000000 >> 22);
    unsigned int PG_HI = (0xF0000000 >> 22);
    //unsigned int PG_LO = 256, PG_HI = 960;
    // TODO
    for (proc_index = 0; proc_index < NUM_IDS; proc_index++)
  104dbf:	83 c6 01             	add    $0x1,%esi
  104dc2:	83 fe 40             	cmp    $0x40,%esi
  104dc5:	75 c1                	jne    104d88 <pdir_init+0x18>
              // reserve for kernel
              set_pdir_entry_identity(proc_index, pde_index);
          }
       }
    }
}
  104dc7:	83 c4 14             	add    $0x14,%esp
  104dca:	5b                   	pop    %ebx
  104dcb:	5e                   	pop    %esi
  104dcc:	c3                   	ret    
  104dcd:	8d 76 00             	lea    0x0(%esi),%esi

00104dd0 <alloc_ptbl>:
 * and clears (set to 0) the whole page table entries for this newly mapped page table.
 * It returns the page index of the newly allocated physical page.
 * In the case when there's no physical page available, it returns 0.
 */
unsigned int alloc_ptbl(unsigned int proc_index, unsigned int vadr)
{
  104dd0:	55                   	push   %ebp
  104dd1:	57                   	push   %edi
  104dd2:	56                   	push   %esi
  104dd3:	53                   	push   %ebx
  104dd4:	83 ec 1c             	sub    $0x1c,%esp
  104dd7:	8b 74 24 30          	mov    0x30(%esp),%esi
  unsigned int page_id, pde_index, pte_index;
  if (proc_index <= NUM_IDS && proc_index > 0)
  104ddb:	8d 46 ff             	lea    -0x1(%esi),%eax
  104dde:	83 f8 3f             	cmp    $0x3f,%eax
  104de1:	76 0d                	jbe    104df0 <alloc_ptbl+0x20>
      rmv_ptbl_entry(proc_index, pde_index, pte_index);
    }
    return page_id;    
  }
  return 0;
}
  104de3:	83 c4 1c             	add    $0x1c,%esp
    {
      rmv_ptbl_entry(proc_index, pde_index, pte_index);
    }
    return page_id;    
  }
  return 0;
  104de6:	31 c0                	xor    %eax,%eax
}
  104de8:	5b                   	pop    %ebx
  104de9:	5e                   	pop    %esi
  104dea:	5f                   	pop    %edi
  104deb:	5d                   	pop    %ebp
  104dec:	c3                   	ret    
  104ded:	8d 76 00             	lea    0x0(%esi),%esi
unsigned int alloc_ptbl(unsigned int proc_index, unsigned int vadr)
{
  unsigned int page_id, pde_index, pte_index;
  if (proc_index <= NUM_IDS && proc_index > 0)
  {
    page_id = container_alloc(proc_index);
  104df0:	89 34 24             	mov    %esi,(%esp)
  104df3:	e8 08 fc ff ff       	call   104a00 <container_alloc>
    if (page_id == 0) {
  104df8:	85 c0                	test   %eax,%eax
unsigned int alloc_ptbl(unsigned int proc_index, unsigned int vadr)
{
  unsigned int page_id, pde_index, pte_index;
  if (proc_index <= NUM_IDS && proc_index > 0)
  {
    page_id = container_alloc(proc_index);
  104dfa:	89 c5                	mov    %eax,%ebp
    if (page_id == 0) {
  104dfc:	74 e5                	je     104de3 <alloc_ptbl+0x13>
        return 0;
    }
    set_pdir_entry_by_va(proc_index, vadr, page_id);
  104dfe:	89 44 24 08          	mov    %eax,0x8(%esp)
  104e02:	8b 44 24 34          	mov    0x34(%esp),%eax
    pde_index = vadr >> 22;
    for (pte_index = 0; pte_index < 1024; pte_index ++)
  104e06:	31 db                	xor    %ebx,%ebx
  {
    page_id = container_alloc(proc_index);
    if (page_id == 0) {
        return 0;
    }
    set_pdir_entry_by_va(proc_index, vadr, page_id);
  104e08:	89 34 24             	mov    %esi,(%esp)
  104e0b:	89 44 24 04          	mov    %eax,0x4(%esp)
  104e0f:	e8 bc fe ff ff       	call   104cd0 <set_pdir_entry_by_va>
    pde_index = vadr >> 22;
  104e14:	8b 7c 24 34          	mov    0x34(%esp),%edi
  104e18:	c1 ef 16             	shr    $0x16,%edi
  104e1b:	90                   	nop
  104e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for (pte_index = 0; pte_index < 1024; pte_index ++)
    {
      rmv_ptbl_entry(proc_index, pde_index, pte_index);
  104e20:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    if (page_id == 0) {
        return 0;
    }
    set_pdir_entry_by_va(proc_index, vadr, page_id);
    pde_index = vadr >> 22;
    for (pte_index = 0; pte_index < 1024; pte_index ++)
  104e24:	83 c3 01             	add    $0x1,%ebx
    {
      rmv_ptbl_entry(proc_index, pde_index, pte_index);
  104e27:	89 7c 24 04          	mov    %edi,0x4(%esp)
  104e2b:	89 34 24             	mov    %esi,(%esp)
  104e2e:	e8 7d fd ff ff       	call   104bb0 <rmv_ptbl_entry>
    if (page_id == 0) {
        return 0;
    }
    set_pdir_entry_by_va(proc_index, vadr, page_id);
    pde_index = vadr >> 22;
    for (pte_index = 0; pte_index < 1024; pte_index ++)
  104e33:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
  104e39:	75 e5                	jne    104e20 <alloc_ptbl+0x50>
      rmv_ptbl_entry(proc_index, pde_index, pte_index);
    }
    return page_id;    
  }
  return 0;
}
  104e3b:	83 c4 1c             	add    $0x1c,%esp
  104e3e:	89 e8                	mov    %ebp,%eax
  104e40:	5b                   	pop    %ebx
  104e41:	5e                   	pop    %esi
  104e42:	5f                   	pop    %edi
  104e43:	5d                   	pop    %ebp
  104e44:	c3                   	ret    
  104e45:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104e50 <free_ptbl>:

// Reverse operation of alloc_ptbl.
// Removes corresponding page directory entry,
// and frees the page for the page table entries (with container_free).
void free_ptbl(unsigned int proc_index, unsigned int vadr)
{
  104e50:	55                   	push   %ebp
  104e51:	57                   	push   %edi
  104e52:	56                   	push   %esi
  104e53:	53                   	push   %ebx
    unsigned int pde_address = vadr >> 22;
    unsigned int pte_index;
    pde_address = get_pdir_entry_by_va(proc_index, vadr);
    for (pte_index = 0; pte_index < 1024; pte_index++)
  104e54:	31 db                	xor    %ebx,%ebx

// Reverse operation of alloc_ptbl.
// Removes corresponding page directory entry,
// and frees the page for the page table entries (with container_free).
void free_ptbl(unsigned int proc_index, unsigned int vadr)
{
  104e56:	83 ec 1c             	sub    $0x1c,%esp
  104e59:	8b 74 24 30          	mov    0x30(%esp),%esi
  104e5d:	8b 7c 24 34          	mov    0x34(%esp),%edi
    unsigned int pde_address = vadr >> 22;
    unsigned int pte_index;
    pde_address = get_pdir_entry_by_va(proc_index, vadr);
  104e61:	89 34 24             	mov    %esi,(%esp)
  104e64:	89 7c 24 04          	mov    %edi,0x4(%esp)
  104e68:	e8 d3 fd ff ff       	call   104c40 <get_pdir_entry_by_va>
  104e6d:	89 c5                	mov    %eax,%ebp
  104e6f:	90                   	nop
    for (pte_index = 0; pte_index < 1024; pte_index++)
    {
       container_free(proc_index, ((unsigned int *)pde_address)[pte_index]);
  104e70:	8b 54 9d 00          	mov    0x0(%ebp,%ebx,4),%edx
void free_ptbl(unsigned int proc_index, unsigned int vadr)
{
    unsigned int pde_address = vadr >> 22;
    unsigned int pte_index;
    pde_address = get_pdir_entry_by_va(proc_index, vadr);
    for (pte_index = 0; pte_index < 1024; pte_index++)
  104e74:	83 c3 01             	add    $0x1,%ebx
    {
       container_free(proc_index, ((unsigned int *)pde_address)[pte_index]);
  104e77:	89 34 24             	mov    %esi,(%esp)
  104e7a:	89 54 24 04          	mov    %edx,0x4(%esp)
  104e7e:	e8 ad fb ff ff       	call   104a30 <container_free>
void free_ptbl(unsigned int proc_index, unsigned int vadr)
{
    unsigned int pde_address = vadr >> 22;
    unsigned int pte_index;
    pde_address = get_pdir_entry_by_va(proc_index, vadr);
    for (pte_index = 0; pte_index < 1024; pte_index++)
  104e83:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
  104e89:	75 e5                	jne    104e70 <free_ptbl+0x20>
    {
       container_free(proc_index, ((unsigned int *)pde_address)[pte_index]);
    }
    rmv_pdir_entry_by_va(proc_index, vadr);
  104e8b:	89 7c 24 34          	mov    %edi,0x34(%esp)
  104e8f:	89 74 24 30          	mov    %esi,0x30(%esp)
}
  104e93:	83 c4 1c             	add    $0x1c,%esp
  104e96:	5b                   	pop    %ebx
  104e97:	5e                   	pop    %esi
  104e98:	5f                   	pop    %edi
  104e99:	5d                   	pop    %ebp
    pde_address = get_pdir_entry_by_va(proc_index, vadr);
    for (pte_index = 0; pte_index < 1024; pte_index++)
    {
       container_free(proc_index, ((unsigned int *)pde_address)[pte_index]);
    }
    rmv_pdir_entry_by_va(proc_index, vadr);
  104e9a:	e9 e1 fd ff ff       	jmp    104c80 <rmv_pdir_entry_by_va>
  104e9f:	90                   	nop

00104ea0 <pdir_init_kern>:
/**
 * Sets the entire page map for process 0 as identity map.
 * Note that part of the task is already completed by pdir_init.
 */
void pdir_init_kern(unsigned int mbi_adr)
{
  104ea0:	53                   	push   %ebx
    unsigned int pde_index;
    pdir_init(mbi_adr);
    for (pde_index = 0; pde_index < 1024; pde_index ++)
  104ea1:	31 db                	xor    %ebx,%ebx
/**
 * Sets the entire page map for process 0 as identity map.
 * Note that part of the task is already completed by pdir_init.
 */
void pdir_init_kern(unsigned int mbi_adr)
{
  104ea3:	83 ec 18             	sub    $0x18,%esp
    unsigned int pde_index;
    pdir_init(mbi_adr);
  104ea6:	8b 44 24 20          	mov    0x20(%esp),%eax
  104eaa:	89 04 24             	mov    %eax,(%esp)
  104ead:	e8 be fe ff ff       	call   104d70 <pdir_init>
  104eb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for (pde_index = 0; pde_index < 1024; pde_index ++)
    {
        set_pdir_entry_identity(0, pde_index);    
  104eb8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 */
void pdir_init_kern(unsigned int mbi_adr)
{
    unsigned int pde_index;
    pdir_init(mbi_adr);
    for (pde_index = 0; pde_index < 1024; pde_index ++)
  104ebc:	83 c3 01             	add    $0x1,%ebx
    {
        set_pdir_entry_identity(0, pde_index);    
  104ebf:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104ec6:	e8 15 fc ff ff       	call   104ae0 <set_pdir_entry_identity>
 */
void pdir_init_kern(unsigned int mbi_adr)
{
    unsigned int pde_index;
    pdir_init(mbi_adr);
    for (pde_index = 0; pde_index < 1024; pde_index ++)
  104ecb:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
  104ed1:	75 e5                	jne    104eb8 <pdir_init_kern+0x18>
    {
        set_pdir_entry_identity(0, pde_index);    
    }
}
  104ed3:	83 c4 18             	add    $0x18,%esp
  104ed6:	5b                   	pop    %ebx
  104ed7:	c3                   	ret    
  104ed8:	90                   	nop
  104ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104ee0 <map_page>:
 * In the case of error, it returns the constant MagicNumber defined in lib/x86.h,
 * otherwise, it returns the physical page index registered in the page directory,
 * e.g., the return value of get_pdir_entry_by_va or alloc_ptbl.
 */
unsigned int map_page(unsigned int proc_index, unsigned int vadr, unsigned int page_index, unsigned int perm)
{   
  104ee0:	57                   	push   %edi
  104ee1:	56                   	push   %esi
  104ee2:	53                   	push   %ebx
  104ee3:	83 ec 20             	sub    $0x20,%esp
  104ee6:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  104eea:	8b 74 24 34          	mov    0x34(%esp),%esi
  // TODO
  unsigned int pdir_entry = get_pdir_entry_by_va(proc_index, vadr);
  104eee:	89 1c 24             	mov    %ebx,(%esp)
  104ef1:	89 74 24 04          	mov    %esi,0x4(%esp)
  104ef5:	e8 46 fd ff ff       	call   104c40 <get_pdir_entry_by_va>
  if (pdir_entry == 0) 
  104efa:	85 c0                	test   %eax,%eax
 * e.g., the return value of get_pdir_entry_by_va or alloc_ptbl.
 */
unsigned int map_page(unsigned int proc_index, unsigned int vadr, unsigned int page_index, unsigned int perm)
{   
  // TODO
  unsigned int pdir_entry = get_pdir_entry_by_va(proc_index, vadr);
  104efc:	89 c7                	mov    %eax,%edi
  if (pdir_entry == 0) 
  104efe:	75 20                	jne    104f20 <map_page+0x40>
  {
      // page not set up
      int page_id = alloc_ptbl(proc_index, vadr);
  104f00:	89 74 24 04          	mov    %esi,0x4(%esp)
  104f04:	89 1c 24             	mov    %ebx,(%esp)
  104f07:	e8 c4 fe ff ff       	call   104dd0 <alloc_ptbl>
      if (page_id != 0) {
  104f0c:	85 c0                	test   %eax,%eax
  104f0e:	75 38                	jne    104f48 <map_page+0x68>
      // page set up already
      set_ptbl_entry_by_va(proc_index, vadr, page_index, perm);
      return pdir_entry;
  } 
  return MagicNumber;
}
  104f10:	83 c4 20             	add    $0x20,%esp
  {
      // page set up already
      set_ptbl_entry_by_va(proc_index, vadr, page_index, perm);
      return pdir_entry;
  } 
  return MagicNumber;
  104f13:	b8 01 00 10 00       	mov    $0x100001,%eax
}
  104f18:	5b                   	pop    %ebx
  104f19:	5e                   	pop    %esi
  104f1a:	5f                   	pop    %edi
  104f1b:	c3                   	ret    
  104f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } 
  }
  else 
  {
      // page set up already
      set_ptbl_entry_by_va(proc_index, vadr, page_index, perm);
  104f20:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  104f24:	89 74 24 04          	mov    %esi,0x4(%esp)
  104f28:	89 1c 24             	mov    %ebx,(%esp)
  104f2b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  104f2f:	8b 44 24 38          	mov    0x38(%esp),%eax
  104f33:	89 44 24 08          	mov    %eax,0x8(%esp)
  104f37:	e8 54 fd ff ff       	call   104c90 <set_ptbl_entry_by_va>
      return pdir_entry;
  104f3c:	89 f8                	mov    %edi,%eax
  } 
  return MagicNumber;
}
  104f3e:	83 c4 20             	add    $0x20,%esp
  104f41:	5b                   	pop    %ebx
  104f42:	5e                   	pop    %esi
  104f43:	5f                   	pop    %edi
  104f44:	c3                   	ret    
  104f45:	8d 76 00             	lea    0x0(%esi),%esi
  104f48:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  if (pdir_entry == 0) 
  {
      // page not set up
      int page_id = alloc_ptbl(proc_index, vadr);
      if (page_id != 0) {
          set_ptbl_entry_by_va(proc_index, vadr, page_index, perm);
  104f4c:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  104f50:	89 74 24 04          	mov    %esi,0x4(%esp)
  104f54:	89 1c 24             	mov    %ebx,(%esp)
  104f57:	89 44 24 0c          	mov    %eax,0xc(%esp)
  104f5b:	8b 44 24 38          	mov    0x38(%esp),%eax
  104f5f:	89 44 24 08          	mov    %eax,0x8(%esp)
  104f63:	e8 28 fd ff ff       	call   104c90 <set_ptbl_entry_by_va>
          return page_id;
  104f68:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  104f6c:	eb d0                	jmp    104f3e <map_page+0x5e>
  104f6e:	66 90                	xchg   %ax,%ax

00104f70 <unmap_page>:
 * Nothing should be done if the mapping no longer exists.
 * You do not need to unmap the page table from the page directory.
 * It should return the corresponding page table entry.
 */
unsigned int unmap_page(unsigned int proc_index, unsigned int vadr)
{
  104f70:	56                   	push   %esi
  104f71:	53                   	push   %ebx
  104f72:	83 ec 14             	sub    $0x14,%esp
  104f75:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  104f79:	8b 74 24 24          	mov    0x24(%esp),%esi
    unsigned int ptbl_entry = get_ptbl_entry_by_va(proc_index, vadr);
  104f7d:	89 1c 24             	mov    %ebx,(%esp)
  104f80:	89 74 24 04          	mov    %esi,0x4(%esp)
  104f84:	e8 57 fc ff ff       	call   104be0 <get_ptbl_entry_by_va>
    if (ptbl_entry == 0) 
  104f89:	85 c0                	test   %eax,%eax
  104f8b:	74 14                	je     104fa1 <unmap_page+0x31>
    {
        return 0;
    }
    else 
    {
        rmv_ptbl_entry_by_va(proc_index, vadr);
  104f8d:	89 74 24 04          	mov    %esi,0x4(%esp)
  104f91:	89 1c 24             	mov    %ebx,(%esp)
  104f94:	89 44 24 0c          	mov    %eax,0xc(%esp)
  104f98:	e8 b3 fc ff ff       	call   104c50 <rmv_ptbl_entry_by_va>
  104f9d:	8b 44 24 0c          	mov    0xc(%esp),%eax
        return ptbl_entry;
    }
}   
  104fa1:	83 c4 14             	add    $0x14,%esp
  104fa4:	5b                   	pop    %ebx
  104fa5:	5e                   	pop    %esi
  104fa6:	c3                   	ret    
  104fa7:	66 90                	xchg   %ax,%ax
  104fa9:	66 90                	xchg   %ax,%ax
  104fab:	66 90                	xchg   %ax,%ax
  104fad:	66 90                	xchg   %ax,%ax
  104faf:	90                   	nop

00104fb0 <paging_init>:
 * Initializes the page structures,
 * move to the page structure # 0 (kernel).
 * and turn on the paging.
 */
void paging_init(unsigned int mbi_addr)
{
  104fb0:	83 ec 1c             	sub    $0x1c,%esp
	pdir_init_kern(mbi_addr);
  104fb3:	8b 44 24 20          	mov    0x20(%esp),%eax
  104fb7:	89 04 24             	mov    %eax,(%esp)
  104fba:	e8 e1 fe ff ff       	call   104ea0 <pdir_init_kern>
	set_pdir_base(0);
  104fbf:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104fc6:	e8 95 fa ff ff       	call   104a60 <set_pdir_base>
	enable_paging();
}
  104fcb:	83 c4 1c             	add    $0x1c,%esp
 */
void paging_init(unsigned int mbi_addr)
{
	pdir_init_kern(mbi_addr);
	set_pdir_base(0);
	enable_paging();
  104fce:	e9 83 bf ff ff       	jmp    100f56 <enable_paging>
  104fd3:	66 90                	xchg   %ax,%ax
  104fd5:	66 90                	xchg   %ax,%ax
  104fd7:	66 90                	xchg   %ax,%ax
  104fd9:	66 90                	xchg   %ax,%ax
  104fdb:	66 90                	xchg   %ax,%ax
  104fdd:	66 90                	xchg   %ax,%ax
  104fdf:	90                   	nop

00104fe0 <alloc_page>:
 * It should return the physical page index registered in the page directory, i.e., the
 * return value from map_page.
 * In the case of error, it should return the MagicNumber.
 */
unsigned int alloc_page (unsigned int proc_index, unsigned int vaddr, unsigned int perm)
{
  104fe0:	53                   	push   %ebx
  104fe1:	83 ec 18             	sub    $0x18,%esp
  104fe4:	8b 5c 24 20          	mov    0x20(%esp),%ebx
    unsigned int page_id;
    if (page_id = container_alloc(proc_index))
  104fe8:	89 1c 24             	mov    %ebx,(%esp)
  104feb:	e8 10 fa ff ff       	call   104a00 <container_alloc>
    {
        return map_page(proc_index, vaddr, page_id, perm);
    }   
	return MagicNumber;
  104ff0:	ba 01 00 10 00       	mov    $0x100001,%edx
 * In the case of error, it should return the MagicNumber.
 */
unsigned int alloc_page (unsigned int proc_index, unsigned int vaddr, unsigned int perm)
{
    unsigned int page_id;
    if (page_id = container_alloc(proc_index))
  104ff5:	85 c0                	test   %eax,%eax
  104ff7:	75 07                	jne    105000 <alloc_page+0x20>
    {
        return map_page(proc_index, vaddr, page_id, perm);
    }   
	return MagicNumber;
}
  104ff9:	83 c4 18             	add    $0x18,%esp
  104ffc:	89 d0                	mov    %edx,%eax
  104ffe:	5b                   	pop    %ebx
  104fff:	c3                   	ret    
unsigned int alloc_page (unsigned int proc_index, unsigned int vaddr, unsigned int perm)
{
    unsigned int page_id;
    if (page_id = container_alloc(proc_index))
    {
        return map_page(proc_index, vaddr, page_id, perm);
  105000:	8b 54 24 28          	mov    0x28(%esp),%edx
  105004:	89 44 24 08          	mov    %eax,0x8(%esp)
  105008:	8b 44 24 24          	mov    0x24(%esp),%eax
  10500c:	89 1c 24             	mov    %ebx,(%esp)
  10500f:	89 54 24 0c          	mov    %edx,0xc(%esp)
  105013:	89 44 24 04          	mov    %eax,0x4(%esp)
  105017:	e8 c4 fe ff ff       	call   104ee0 <map_page>
    }   
	return MagicNumber;
}
  10501c:	83 c4 18             	add    $0x18,%esp
  10501f:	5b                   	pop    %ebx
unsigned int alloc_page (unsigned int proc_index, unsigned int vaddr, unsigned int perm)
{
    unsigned int page_id;
    if (page_id = container_alloc(proc_index))
    {
        return map_page(proc_index, vaddr, page_id, perm);
  105020:	89 c2                	mov    %eax,%edx
    }   
	return MagicNumber;
}
  105022:	89 d0                	mov    %edx,%eax
  105024:	c3                   	ret    
  105025:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  105029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105030 <alloc_mem_quota>:
 * Designate some memory quota for the next child process.
 */
unsigned int alloc_mem_quota (unsigned int id, unsigned int quota)
{
	unsigned int child;
	child = container_split (id, quota);
  105030:	e9 3b f9 ff ff       	jmp    104970 <container_split>
  105035:	66 90                	xchg   %ax,%ax
  105037:	66 90                	xchg   %ax,%ax
  105039:	66 90                	xchg   %ax,%ax
  10503b:	66 90                	xchg   %ax,%ax
  10503d:	66 90                	xchg   %ax,%ax
  10503f:	90                   	nop

00105040 <__udivdi3>:
  105040:	55                   	push   %ebp
  105041:	57                   	push   %edi
  105042:	56                   	push   %esi
  105043:	83 ec 0c             	sub    $0xc,%esp
  105046:	8b 44 24 28          	mov    0x28(%esp),%eax
  10504a:	8b 7c 24 1c          	mov    0x1c(%esp),%edi
  10504e:	8b 6c 24 20          	mov    0x20(%esp),%ebp
  105052:	8b 4c 24 24          	mov    0x24(%esp),%ecx
  105056:	85 c0                	test   %eax,%eax
  105058:	89 7c 24 04          	mov    %edi,0x4(%esp)
  10505c:	89 ea                	mov    %ebp,%edx
  10505e:	89 0c 24             	mov    %ecx,(%esp)
  105061:	75 2d                	jne    105090 <__udivdi3+0x50>
  105063:	39 e9                	cmp    %ebp,%ecx
  105065:	77 61                	ja     1050c8 <__udivdi3+0x88>
  105067:	85 c9                	test   %ecx,%ecx
  105069:	89 ce                	mov    %ecx,%esi
  10506b:	75 0b                	jne    105078 <__udivdi3+0x38>
  10506d:	b8 01 00 00 00       	mov    $0x1,%eax
  105072:	31 d2                	xor    %edx,%edx
  105074:	f7 f1                	div    %ecx
  105076:	89 c6                	mov    %eax,%esi
  105078:	31 d2                	xor    %edx,%edx
  10507a:	89 e8                	mov    %ebp,%eax
  10507c:	f7 f6                	div    %esi
  10507e:	89 c5                	mov    %eax,%ebp
  105080:	89 f8                	mov    %edi,%eax
  105082:	f7 f6                	div    %esi
  105084:	89 ea                	mov    %ebp,%edx
  105086:	83 c4 0c             	add    $0xc,%esp
  105089:	5e                   	pop    %esi
  10508a:	5f                   	pop    %edi
  10508b:	5d                   	pop    %ebp
  10508c:	c3                   	ret    
  10508d:	8d 76 00             	lea    0x0(%esi),%esi
  105090:	39 e8                	cmp    %ebp,%eax
  105092:	77 24                	ja     1050b8 <__udivdi3+0x78>
  105094:	0f bd e8             	bsr    %eax,%ebp
  105097:	83 f5 1f             	xor    $0x1f,%ebp
  10509a:	75 3c                	jne    1050d8 <__udivdi3+0x98>
  10509c:	8b 74 24 04          	mov    0x4(%esp),%esi
  1050a0:	39 34 24             	cmp    %esi,(%esp)
  1050a3:	0f 86 9f 00 00 00    	jbe    105148 <__udivdi3+0x108>
  1050a9:	39 d0                	cmp    %edx,%eax
  1050ab:	0f 82 97 00 00 00    	jb     105148 <__udivdi3+0x108>
  1050b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1050b8:	31 d2                	xor    %edx,%edx
  1050ba:	31 c0                	xor    %eax,%eax
  1050bc:	83 c4 0c             	add    $0xc,%esp
  1050bf:	5e                   	pop    %esi
  1050c0:	5f                   	pop    %edi
  1050c1:	5d                   	pop    %ebp
  1050c2:	c3                   	ret    
  1050c3:	90                   	nop
  1050c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1050c8:	89 f8                	mov    %edi,%eax
  1050ca:	f7 f1                	div    %ecx
  1050cc:	31 d2                	xor    %edx,%edx
  1050ce:	83 c4 0c             	add    $0xc,%esp
  1050d1:	5e                   	pop    %esi
  1050d2:	5f                   	pop    %edi
  1050d3:	5d                   	pop    %ebp
  1050d4:	c3                   	ret    
  1050d5:	8d 76 00             	lea    0x0(%esi),%esi
  1050d8:	89 e9                	mov    %ebp,%ecx
  1050da:	8b 3c 24             	mov    (%esp),%edi
  1050dd:	d3 e0                	shl    %cl,%eax
  1050df:	89 c6                	mov    %eax,%esi
  1050e1:	b8 20 00 00 00       	mov    $0x20,%eax
  1050e6:	29 e8                	sub    %ebp,%eax
  1050e8:	89 c1                	mov    %eax,%ecx
  1050ea:	d3 ef                	shr    %cl,%edi
  1050ec:	89 e9                	mov    %ebp,%ecx
  1050ee:	89 7c 24 08          	mov    %edi,0x8(%esp)
  1050f2:	8b 3c 24             	mov    (%esp),%edi
  1050f5:	09 74 24 08          	or     %esi,0x8(%esp)
  1050f9:	89 d6                	mov    %edx,%esi
  1050fb:	d3 e7                	shl    %cl,%edi
  1050fd:	89 c1                	mov    %eax,%ecx
  1050ff:	89 3c 24             	mov    %edi,(%esp)
  105102:	8b 7c 24 04          	mov    0x4(%esp),%edi
  105106:	d3 ee                	shr    %cl,%esi
  105108:	89 e9                	mov    %ebp,%ecx
  10510a:	d3 e2                	shl    %cl,%edx
  10510c:	89 c1                	mov    %eax,%ecx
  10510e:	d3 ef                	shr    %cl,%edi
  105110:	09 d7                	or     %edx,%edi
  105112:	89 f2                	mov    %esi,%edx
  105114:	89 f8                	mov    %edi,%eax
  105116:	f7 74 24 08          	divl   0x8(%esp)
  10511a:	89 d6                	mov    %edx,%esi
  10511c:	89 c7                	mov    %eax,%edi
  10511e:	f7 24 24             	mull   (%esp)
  105121:	39 d6                	cmp    %edx,%esi
  105123:	89 14 24             	mov    %edx,(%esp)
  105126:	72 30                	jb     105158 <__udivdi3+0x118>
  105128:	8b 54 24 04          	mov    0x4(%esp),%edx
  10512c:	89 e9                	mov    %ebp,%ecx
  10512e:	d3 e2                	shl    %cl,%edx
  105130:	39 c2                	cmp    %eax,%edx
  105132:	73 05                	jae    105139 <__udivdi3+0xf9>
  105134:	3b 34 24             	cmp    (%esp),%esi
  105137:	74 1f                	je     105158 <__udivdi3+0x118>
  105139:	89 f8                	mov    %edi,%eax
  10513b:	31 d2                	xor    %edx,%edx
  10513d:	e9 7a ff ff ff       	jmp    1050bc <__udivdi3+0x7c>
  105142:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105148:	31 d2                	xor    %edx,%edx
  10514a:	b8 01 00 00 00       	mov    $0x1,%eax
  10514f:	e9 68 ff ff ff       	jmp    1050bc <__udivdi3+0x7c>
  105154:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  105158:	8d 47 ff             	lea    -0x1(%edi),%eax
  10515b:	31 d2                	xor    %edx,%edx
  10515d:	83 c4 0c             	add    $0xc,%esp
  105160:	5e                   	pop    %esi
  105161:	5f                   	pop    %edi
  105162:	5d                   	pop    %ebp
  105163:	c3                   	ret    
  105164:	66 90                	xchg   %ax,%ax
  105166:	66 90                	xchg   %ax,%ax
  105168:	66 90                	xchg   %ax,%ax
  10516a:	66 90                	xchg   %ax,%ax
  10516c:	66 90                	xchg   %ax,%ax
  10516e:	66 90                	xchg   %ax,%ax

00105170 <__umoddi3>:
  105170:	55                   	push   %ebp
  105171:	57                   	push   %edi
  105172:	56                   	push   %esi
  105173:	83 ec 14             	sub    $0x14,%esp
  105176:	8b 44 24 28          	mov    0x28(%esp),%eax
  10517a:	8b 4c 24 24          	mov    0x24(%esp),%ecx
  10517e:	8b 74 24 2c          	mov    0x2c(%esp),%esi
  105182:	89 c7                	mov    %eax,%edi
  105184:	89 44 24 04          	mov    %eax,0x4(%esp)
  105188:	8b 44 24 30          	mov    0x30(%esp),%eax
  10518c:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  105190:	89 34 24             	mov    %esi,(%esp)
  105193:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  105197:	85 c0                	test   %eax,%eax
  105199:	89 c2                	mov    %eax,%edx
  10519b:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  10519f:	75 17                	jne    1051b8 <__umoddi3+0x48>
  1051a1:	39 fe                	cmp    %edi,%esi
  1051a3:	76 4b                	jbe    1051f0 <__umoddi3+0x80>
  1051a5:	89 c8                	mov    %ecx,%eax
  1051a7:	89 fa                	mov    %edi,%edx
  1051a9:	f7 f6                	div    %esi
  1051ab:	89 d0                	mov    %edx,%eax
  1051ad:	31 d2                	xor    %edx,%edx
  1051af:	83 c4 14             	add    $0x14,%esp
  1051b2:	5e                   	pop    %esi
  1051b3:	5f                   	pop    %edi
  1051b4:	5d                   	pop    %ebp
  1051b5:	c3                   	ret    
  1051b6:	66 90                	xchg   %ax,%ax
  1051b8:	39 f8                	cmp    %edi,%eax
  1051ba:	77 54                	ja     105210 <__umoddi3+0xa0>
  1051bc:	0f bd e8             	bsr    %eax,%ebp
  1051bf:	83 f5 1f             	xor    $0x1f,%ebp
  1051c2:	75 5c                	jne    105220 <__umoddi3+0xb0>
  1051c4:	8b 7c 24 08          	mov    0x8(%esp),%edi
  1051c8:	39 3c 24             	cmp    %edi,(%esp)
  1051cb:	0f 87 e7 00 00 00    	ja     1052b8 <__umoddi3+0x148>
  1051d1:	8b 7c 24 04          	mov    0x4(%esp),%edi
  1051d5:	29 f1                	sub    %esi,%ecx
  1051d7:	19 c7                	sbb    %eax,%edi
  1051d9:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  1051dd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  1051e1:	8b 44 24 08          	mov    0x8(%esp),%eax
  1051e5:	8b 54 24 0c          	mov    0xc(%esp),%edx
  1051e9:	83 c4 14             	add    $0x14,%esp
  1051ec:	5e                   	pop    %esi
  1051ed:	5f                   	pop    %edi
  1051ee:	5d                   	pop    %ebp
  1051ef:	c3                   	ret    
  1051f0:	85 f6                	test   %esi,%esi
  1051f2:	89 f5                	mov    %esi,%ebp
  1051f4:	75 0b                	jne    105201 <__umoddi3+0x91>
  1051f6:	b8 01 00 00 00       	mov    $0x1,%eax
  1051fb:	31 d2                	xor    %edx,%edx
  1051fd:	f7 f6                	div    %esi
  1051ff:	89 c5                	mov    %eax,%ebp
  105201:	8b 44 24 04          	mov    0x4(%esp),%eax
  105205:	31 d2                	xor    %edx,%edx
  105207:	f7 f5                	div    %ebp
  105209:	89 c8                	mov    %ecx,%eax
  10520b:	f7 f5                	div    %ebp
  10520d:	eb 9c                	jmp    1051ab <__umoddi3+0x3b>
  10520f:	90                   	nop
  105210:	89 c8                	mov    %ecx,%eax
  105212:	89 fa                	mov    %edi,%edx
  105214:	83 c4 14             	add    $0x14,%esp
  105217:	5e                   	pop    %esi
  105218:	5f                   	pop    %edi
  105219:	5d                   	pop    %ebp
  10521a:	c3                   	ret    
  10521b:	90                   	nop
  10521c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  105220:	8b 04 24             	mov    (%esp),%eax
  105223:	be 20 00 00 00       	mov    $0x20,%esi
  105228:	89 e9                	mov    %ebp,%ecx
  10522a:	29 ee                	sub    %ebp,%esi
  10522c:	d3 e2                	shl    %cl,%edx
  10522e:	89 f1                	mov    %esi,%ecx
  105230:	d3 e8                	shr    %cl,%eax
  105232:	89 e9                	mov    %ebp,%ecx
  105234:	89 44 24 04          	mov    %eax,0x4(%esp)
  105238:	8b 04 24             	mov    (%esp),%eax
  10523b:	09 54 24 04          	or     %edx,0x4(%esp)
  10523f:	89 fa                	mov    %edi,%edx
  105241:	d3 e0                	shl    %cl,%eax
  105243:	89 f1                	mov    %esi,%ecx
  105245:	89 44 24 08          	mov    %eax,0x8(%esp)
  105249:	8b 44 24 10          	mov    0x10(%esp),%eax
  10524d:	d3 ea                	shr    %cl,%edx
  10524f:	89 e9                	mov    %ebp,%ecx
  105251:	d3 e7                	shl    %cl,%edi
  105253:	89 f1                	mov    %esi,%ecx
  105255:	d3 e8                	shr    %cl,%eax
  105257:	89 e9                	mov    %ebp,%ecx
  105259:	09 f8                	or     %edi,%eax
  10525b:	8b 7c 24 10          	mov    0x10(%esp),%edi
  10525f:	f7 74 24 04          	divl   0x4(%esp)
  105263:	d3 e7                	shl    %cl,%edi
  105265:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  105269:	89 d7                	mov    %edx,%edi
  10526b:	f7 64 24 08          	mull   0x8(%esp)
  10526f:	39 d7                	cmp    %edx,%edi
  105271:	89 c1                	mov    %eax,%ecx
  105273:	89 14 24             	mov    %edx,(%esp)
  105276:	72 2c                	jb     1052a4 <__umoddi3+0x134>
  105278:	39 44 24 0c          	cmp    %eax,0xc(%esp)
  10527c:	72 22                	jb     1052a0 <__umoddi3+0x130>
  10527e:	8b 44 24 0c          	mov    0xc(%esp),%eax
  105282:	29 c8                	sub    %ecx,%eax
  105284:	19 d7                	sbb    %edx,%edi
  105286:	89 e9                	mov    %ebp,%ecx
  105288:	89 fa                	mov    %edi,%edx
  10528a:	d3 e8                	shr    %cl,%eax
  10528c:	89 f1                	mov    %esi,%ecx
  10528e:	d3 e2                	shl    %cl,%edx
  105290:	89 e9                	mov    %ebp,%ecx
  105292:	d3 ef                	shr    %cl,%edi
  105294:	09 d0                	or     %edx,%eax
  105296:	89 fa                	mov    %edi,%edx
  105298:	83 c4 14             	add    $0x14,%esp
  10529b:	5e                   	pop    %esi
  10529c:	5f                   	pop    %edi
  10529d:	5d                   	pop    %ebp
  10529e:	c3                   	ret    
  10529f:	90                   	nop
  1052a0:	39 d7                	cmp    %edx,%edi
  1052a2:	75 da                	jne    10527e <__umoddi3+0x10e>
  1052a4:	8b 14 24             	mov    (%esp),%edx
  1052a7:	89 c1                	mov    %eax,%ecx
  1052a9:	2b 4c 24 08          	sub    0x8(%esp),%ecx
  1052ad:	1b 54 24 04          	sbb    0x4(%esp),%edx
  1052b1:	eb cb                	jmp    10527e <__umoddi3+0x10e>
  1052b3:	90                   	nop
  1052b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1052b8:	3b 44 24 0c          	cmp    0xc(%esp),%eax
  1052bc:	0f 82 0f ff ff ff    	jb     1051d1 <__umoddi3+0x61>
  1052c2:	e9 1a ff ff ff       	jmp    1051e1 <__umoddi3+0x71>
