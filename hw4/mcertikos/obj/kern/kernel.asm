
obj/kern/kernel:     file format elf32-i386


Disassembly of section .text:

00100000 <video_init>:
#include "video.h"
//tmphack
//#include<dev/serial.h>
void
video_init(void)
{
  100000:	56                   	push   %esi
	unsigned pos;

	/* Get a pointer to the memory-mapped text display buffer. */
	cp = (uint16_t*) CGA_BUF;
	was = *cp;
	*cp = (uint16_t) 0xA55A;
  100001:	b8 5a a5 ff ff       	mov    $0xffffa55a,%eax
#include "video.h"
//tmphack
//#include<dev/serial.h>
void
video_init(void)
{
  100006:	53                   	push   %ebx
  100007:	83 ec 14             	sub    $0x14,%esp
	uint16_t was;
	unsigned pos;

	/* Get a pointer to the memory-mapped text display buffer. */
	cp = (uint16_t*) CGA_BUF;
	was = *cp;
  10000a:	0f b7 15 00 80 0b 00 	movzwl 0xb8000,%edx
	*cp = (uint16_t) 0xA55A;
  100011:	66 a3 00 80 0b 00    	mov    %ax,0xb8000
	if (*cp != 0xA55A) {
  100017:	0f b7 05 00 80 0b 00 	movzwl 0xb8000,%eax
  10001e:	66 3d 5a a5          	cmp    $0xa55a,%ax
  100022:	0f 84 98 00 00 00    	je     1000c0 <video_init+0xc0>
		cp = (uint16_t*) MONO_BUF;
		addr_6845 = MONO_BASE;
		dprintf("addr_6845:%x\n",addr_6845);
  100028:	c7 44 24 04 b4 03 00 	movl   $0x3b4,0x4(%esp)
  10002f:	00 
	/* Get a pointer to the memory-mapped text display buffer. */
	cp = (uint16_t*) CGA_BUF;
	was = *cp;
	*cp = (uint16_t) 0xA55A;
	if (*cp != 0xA55A) {
		cp = (uint16_t*) MONO_BUF;
  100030:	be 00 00 0b 00       	mov    $0xb0000,%esi
		addr_6845 = MONO_BASE;
		dprintf("addr_6845:%x\n",addr_6845);
  100035:	c7 04 24 00 7c 10 00 	movl   $0x107c00,(%esp)
	cp = (uint16_t*) CGA_BUF;
	was = *cp;
	*cp = (uint16_t) 0xA55A;
	if (*cp != 0xA55A) {
		cp = (uint16_t*) MONO_BUF;
		addr_6845 = MONO_BASE;
  10003c:	c7 05 0c d4 96 00 b4 	movl   $0x3b4,0x96d40c
  100043:	03 00 00 
		dprintf("addr_6845:%x\n",addr_6845);
  100046:	e8 45 3c 00 00       	call   103c90 <dprintf>
		addr_6845 = CGA_BASE;
		dprintf("addr_6845:%x\n",addr_6845);
	}
	
	/* Extract cursor location */
	outb(addr_6845, 14);
  10004b:	a1 0c d4 96 00       	mov    0x96d40c,%eax
  100050:	c7 44 24 04 0e 00 00 	movl   $0xe,0x4(%esp)
  100057:	00 
  100058:	89 04 24             	mov    %eax,(%esp)
  10005b:	e8 e0 48 00 00       	call   104940 <outb>
	pos = inb(addr_6845 + 1) << 8;
  100060:	a1 0c d4 96 00       	mov    0x96d40c,%eax
  100065:	83 c0 01             	add    $0x1,%eax
  100068:	89 04 24             	mov    %eax,(%esp)
  10006b:	e8 a0 48 00 00       	call   104910 <inb>
	outb(addr_6845, 15);
  100070:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
  100077:	00 
		dprintf("addr_6845:%x\n",addr_6845);
	}
	
	/* Extract cursor location */
	outb(addr_6845, 14);
	pos = inb(addr_6845 + 1) << 8;
  100078:	0f b6 d8             	movzbl %al,%ebx
	outb(addr_6845, 15);
  10007b:	a1 0c d4 96 00       	mov    0x96d40c,%eax
		dprintf("addr_6845:%x\n",addr_6845);
	}
	
	/* Extract cursor location */
	outb(addr_6845, 14);
	pos = inb(addr_6845 + 1) << 8;
  100080:	c1 e3 08             	shl    $0x8,%ebx
	outb(addr_6845, 15);
  100083:	89 04 24             	mov    %eax,(%esp)
  100086:	e8 b5 48 00 00       	call   104940 <outb>
	pos |= inb(addr_6845 + 1);
  10008b:	a1 0c d4 96 00       	mov    0x96d40c,%eax
  100090:	83 c0 01             	add    $0x1,%eax
  100093:	89 04 24             	mov    %eax,(%esp)
  100096:	e8 75 48 00 00       	call   104910 <inb>

	terminal.crt_buf = (uint16_t*) cp;
  10009b:	89 35 00 d4 96 00    	mov    %esi,0x96d400
	terminal.crt_pos = pos;
	terminal.active_console = 0;
  1000a1:	c7 05 08 d4 96 00 00 	movl   $0x0,0x96d408
  1000a8:	00 00 00 
	
	/* Extract cursor location */
	outb(addr_6845, 14);
	pos = inb(addr_6845 + 1) << 8;
	outb(addr_6845, 15);
	pos |= inb(addr_6845 + 1);
  1000ab:	0f b6 c0             	movzbl %al,%eax
  1000ae:	09 d8                	or     %ebx,%eax

	terminal.crt_buf = (uint16_t*) cp;
	terminal.crt_pos = pos;
  1000b0:	66 a3 04 d4 96 00    	mov    %ax,0x96d404
	terminal.active_console = 0;
//  video_clear_screen();
}
  1000b6:	83 c4 14             	add    $0x14,%esp
  1000b9:	5b                   	pop    %ebx
  1000ba:	5e                   	pop    %esi
  1000bb:	c3                   	ret    
  1000bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if (*cp != 0xA55A) {
		cp = (uint16_t*) MONO_BUF;
		addr_6845 = MONO_BASE;
		dprintf("addr_6845:%x\n",addr_6845);
	} else {
		*cp = was;
  1000c0:	66 89 15 00 80 0b 00 	mov    %dx,0xb8000
	volatile uint16_t *cp;
	uint16_t was;
	unsigned pos;

	/* Get a pointer to the memory-mapped text display buffer. */
	cp = (uint16_t*) CGA_BUF;
  1000c7:	be 00 80 0b 00       	mov    $0xb8000,%esi
		addr_6845 = MONO_BASE;
		dprintf("addr_6845:%x\n",addr_6845);
	} else {
		*cp = was;
		addr_6845 = CGA_BASE;
		dprintf("addr_6845:%x\n",addr_6845);
  1000cc:	c7 44 24 04 d4 03 00 	movl   $0x3d4,0x4(%esp)
  1000d3:	00 
  1000d4:	c7 04 24 00 7c 10 00 	movl   $0x107c00,(%esp)
		cp = (uint16_t*) MONO_BUF;
		addr_6845 = MONO_BASE;
		dprintf("addr_6845:%x\n",addr_6845);
	} else {
		*cp = was;
		addr_6845 = CGA_BASE;
  1000db:	c7 05 0c d4 96 00 d4 	movl   $0x3d4,0x96d40c
  1000e2:	03 00 00 
		dprintf("addr_6845:%x\n",addr_6845);
  1000e5:	e8 a6 3b 00 00       	call   103c90 <dprintf>
  1000ea:	e9 5c ff ff ff       	jmp    10004b <video_init+0x4b>
  1000ef:	90                   	nop

001000f0 <video_putc>:
//  video_clear_screen();
}

void
video_putc(int c)
{
  1000f0:	83 ec 1c             	sub    $0x1c,%esp
  1000f3:	8b 44 24 20          	mov    0x20(%esp),%eax

	// if no attribute given, then use black on white
	if (!(c & ~0xFF))
		c |= 0x0700;
  1000f7:	89 c2                	mov    %eax,%edx
  1000f9:	80 ce 07             	or     $0x7,%dh
  1000fc:	a9 00 ff ff ff       	test   $0xffffff00,%eax
  100101:	0f 44 c2             	cmove  %edx,%eax

	switch (c & 0xff) {
  100104:	0f b6 d0             	movzbl %al,%edx
  100107:	83 fa 09             	cmp    $0x9,%edx
  10010a:	0f 84 64 01 00 00    	je     100274 <video_putc+0x184>
  100110:	0f 8e fa 00 00 00    	jle    100210 <video_putc+0x120>
  100116:	83 fa 0a             	cmp    $0xa,%edx
  100119:	0f 84 92 00 00 00    	je     1001b1 <video_putc+0xc1>
  10011f:	83 fa 0d             	cmp    $0xd,%edx
  100122:	0f b7 0d 04 d4 96 00 	movzwl 0x96d404,%ecx
  100129:	0f 85 1e 01 00 00    	jne    10024d <video_putc+0x15d>
		break;
	case '\n':
		terminal.crt_pos += CRT_COLS;
		/* fallthru */
	case '\r':
		terminal.crt_pos -= (terminal.crt_pos % CRT_COLS);
  10012f:	0f b7 c1             	movzwl %cx,%eax
  100132:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
  100138:	c1 e8 16             	shr    $0x16,%eax
  10013b:	8d 04 80             	lea    (%eax,%eax,4),%eax
  10013e:	c1 e0 04             	shl    $0x4,%eax
  100141:	66 a3 04 d4 96 00    	mov    %ax,0x96d404
	default:
		terminal.crt_buf[terminal.crt_pos++] = c;		/* write the character */
		break;
	}

	if (terminal.crt_pos >= CRT_SIZE) {
  100147:	66 3d cf 07          	cmp    $0x7cf,%ax
  10014b:	77 73                	ja     1001c0 <video_putc+0xd0>
		terminal.crt_pos -= CRT_COLS;
	}


	/* move that little blinky thing */
	outb(addr_6845, 14);
  10014d:	a1 0c d4 96 00       	mov    0x96d40c,%eax
  100152:	c7 44 24 04 0e 00 00 	movl   $0xe,0x4(%esp)
  100159:	00 
  10015a:	89 04 24             	mov    %eax,(%esp)
  10015d:	e8 de 47 00 00       	call   104940 <outb>
	outb(addr_6845 + 1, terminal.crt_pos >> 8);
  100162:	0f b6 05 05 d4 96 00 	movzbl 0x96d405,%eax
  100169:	89 44 24 04          	mov    %eax,0x4(%esp)
  10016d:	a1 0c d4 96 00       	mov    0x96d40c,%eax
  100172:	83 c0 01             	add    $0x1,%eax
  100175:	89 04 24             	mov    %eax,(%esp)
  100178:	e8 c3 47 00 00       	call   104940 <outb>
	outb(addr_6845, 15);
  10017d:	a1 0c d4 96 00       	mov    0x96d40c,%eax
  100182:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
  100189:	00 
  10018a:	89 04 24             	mov    %eax,(%esp)
  10018d:	e8 ae 47 00 00       	call   104940 <outb>
	outb(addr_6845 + 1, terminal.crt_pos);
  100192:	0f b6 05 04 d4 96 00 	movzbl 0x96d404,%eax
  100199:	89 44 24 04          	mov    %eax,0x4(%esp)
  10019d:	a1 0c d4 96 00       	mov    0x96d40c,%eax
  1001a2:	83 c0 01             	add    $0x1,%eax
  1001a5:	89 04 24             	mov    %eax,(%esp)
  1001a8:	e8 93 47 00 00       	call   104940 <outb>
       	  }
       outb(COM1+COM_TX, c);
       tmpcount++;
	  }
	*/
}
  1001ad:	83 c4 1c             	add    $0x1c,%esp
  1001b0:	c3                   	ret    
			terminal.crt_pos--;
			terminal.crt_buf[terminal.crt_pos] = (c & ~0xff) | ' ';
		}
		break;
	case '\n':
		terminal.crt_pos += CRT_COLS;
  1001b1:	0f b7 05 04 d4 96 00 	movzwl 0x96d404,%eax
  1001b8:	8d 48 50             	lea    0x50(%eax),%ecx
  1001bb:	e9 6f ff ff ff       	jmp    10012f <video_putc+0x3f>
		break;
	}

	if (terminal.crt_pos >= CRT_SIZE) {
		int i;
		memmove(terminal.crt_buf, terminal.crt_buf + CRT_COLS,
  1001c0:	a1 00 d4 96 00       	mov    0x96d400,%eax
  1001c5:	c7 44 24 08 00 0f 00 	movl   $0xf00,0x8(%esp)
  1001cc:	00 
  1001cd:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  1001d3:	89 54 24 04          	mov    %edx,0x4(%esp)
  1001d7:	89 04 24             	mov    %eax,(%esp)
  1001da:	e8 d1 35 00 00       	call   1037b0 <memmove>
  1001df:	8b 15 00 d4 96 00    	mov    0x96d400,%edx
			(CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
		for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i++)
  1001e5:	b8 80 07 00 00       	mov    $0x780,%eax
  1001ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			terminal.crt_buf[i] = 0x0700 | ' ';
  1001f0:	b9 20 07 00 00       	mov    $0x720,%ecx
  1001f5:	66 89 0c 42          	mov    %cx,(%edx,%eax,2)

	if (terminal.crt_pos >= CRT_SIZE) {
		int i;
		memmove(terminal.crt_buf, terminal.crt_buf + CRT_COLS,
			(CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
		for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i++)
  1001f9:	83 c0 01             	add    $0x1,%eax
  1001fc:	3d d0 07 00 00       	cmp    $0x7d0,%eax
  100201:	75 ed                	jne    1001f0 <video_putc+0x100>
			terminal.crt_buf[i] = 0x0700 | ' ';
		terminal.crt_pos -= CRT_COLS;
  100203:	66 83 2d 04 d4 96 00 	subw   $0x50,0x96d404
  10020a:	50 
  10020b:	e9 3d ff ff ff       	jmp    10014d <video_putc+0x5d>

	// if no attribute given, then use black on white
	if (!(c & ~0xFF))
		c |= 0x0700;

	switch (c & 0xff) {
  100210:	83 fa 08             	cmp    $0x8,%edx
  100213:	75 38                	jne    10024d <video_putc+0x15d>
	case '\b':
		if (terminal.crt_pos > 0) {
  100215:	0f b7 15 04 d4 96 00 	movzwl 0x96d404,%edx
  10021c:	66 85 d2             	test   %dx,%dx
  10021f:	0f 84 28 ff ff ff    	je     10014d <video_putc+0x5d>
			terminal.crt_pos--;
			terminal.crt_buf[terminal.crt_pos] = (c & ~0xff) | ' ';
  100225:	8b 0d 00 d4 96 00    	mov    0x96d400,%ecx
		c |= 0x0700;

	switch (c & 0xff) {
	case '\b':
		if (terminal.crt_pos > 0) {
			terminal.crt_pos--;
  10022b:	83 ea 01             	sub    $0x1,%edx
			terminal.crt_buf[terminal.crt_pos] = (c & ~0xff) | ' ';
  10022e:	30 c0                	xor    %al,%al
		c |= 0x0700;

	switch (c & 0xff) {
	case '\b':
		if (terminal.crt_pos > 0) {
			terminal.crt_pos--;
  100230:	66 89 15 04 d4 96 00 	mov    %dx,0x96d404
			terminal.crt_buf[terminal.crt_pos] = (c & ~0xff) | ' ';
  100237:	83 c8 20             	or     $0x20,%eax
  10023a:	0f b7 d2             	movzwl %dx,%edx
  10023d:	66 89 04 51          	mov    %ax,(%ecx,%edx,2)
  100241:	0f b7 05 04 d4 96 00 	movzwl 0x96d404,%eax
  100248:	e9 fa fe ff ff       	jmp    100147 <video_putc+0x57>
		video_putc(' ');
		video_putc(' ');
		video_putc(' ');
		break;
	default:
		terminal.crt_buf[terminal.crt_pos++] = c;		/* write the character */
  10024d:	0f b7 15 04 d4 96 00 	movzwl 0x96d404,%edx
  100254:	8d 4a 01             	lea    0x1(%edx),%ecx
  100257:	66 89 0d 04 d4 96 00 	mov    %cx,0x96d404
  10025e:	8b 0d 00 d4 96 00    	mov    0x96d400,%ecx
  100264:	66 89 04 51          	mov    %ax,(%ecx,%edx,2)
  100268:	0f b7 05 04 d4 96 00 	movzwl 0x96d404,%eax
		break;
  10026f:	e9 d3 fe ff ff       	jmp    100147 <video_putc+0x57>
		/* fallthru */
	case '\r':
		terminal.crt_pos -= (terminal.crt_pos % CRT_COLS);
		break;
	case '\t':
		video_putc(' ');
  100274:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  10027b:	e8 70 fe ff ff       	call   1000f0 <video_putc>
		video_putc(' ');
  100280:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  100287:	e8 64 fe ff ff       	call   1000f0 <video_putc>
		video_putc(' ');
  10028c:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  100293:	e8 58 fe ff ff       	call   1000f0 <video_putc>
		video_putc(' ');
  100298:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  10029f:	e8 4c fe ff ff       	call   1000f0 <video_putc>
		video_putc(' ');
  1002a4:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1002ab:	e8 40 fe ff ff       	call   1000f0 <video_putc>
  1002b0:	0f b7 05 04 d4 96 00 	movzwl 0x96d404,%eax
		break;
  1002b7:	e9 8b fe ff ff       	jmp    100147 <video_putc+0x57>
  1002bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001002c0 <video_set_cursor>:
	*/
}

void
video_set_cursor (int x, int y)
{
  1002c0:	8b 44 24 04          	mov    0x4(%esp),%eax
    terminal.crt_pos = x * CRT_COLS + y;
  1002c4:	8d 04 80             	lea    (%eax,%eax,4),%eax
  1002c7:	c1 e0 04             	shl    $0x4,%eax
  1002ca:	66 03 44 24 08       	add    0x8(%esp),%ax
  1002cf:	66 a3 04 d4 96 00    	mov    %ax,0x96d404
  1002d5:	c3                   	ret    
  1002d6:	8d 76 00             	lea    0x0(%esi),%esi
  1002d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001002e0 <video_clear_screen>:
}

void
video_clear_screen ()
{
  1002e0:	8b 15 00 d4 96 00    	mov    0x96d400,%edx
    int i;
    for (i = 0; i < CRT_SIZE; i++)
  1002e6:	31 c0                	xor    %eax,%eax
    {
        terminal.crt_buf[i] = ' ';
  1002e8:	b9 20 00 00 00       	mov    $0x20,%ecx
  1002ed:	66 89 0c 42          	mov    %cx,(%edx,%eax,2)

void
video_clear_screen ()
{
    int i;
    for (i = 0; i < CRT_SIZE; i++)
  1002f1:	83 c0 01             	add    $0x1,%eax
  1002f4:	3d d0 07 00 00       	cmp    $0x7d0,%eax
  1002f9:	75 ed                	jne    1002e8 <video_clear_screen+0x8>
    {
        terminal.crt_buf[i] = ' ';
    }
}
  1002fb:	f3 c3                	repz ret 
  1002fd:	66 90                	xchg   %ax,%ax
  1002ff:	90                   	nop

00100300 <cons_init>:
	uint32_t rpos, wpos;
} cons;

void
cons_init()
{
  100300:	83 ec 1c             	sub    $0x1c,%esp
	memset(&cons, 0x0, sizeof(cons));
  100303:	c7 44 24 08 08 02 00 	movl   $0x208,0x8(%esp)
  10030a:	00 
  10030b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100312:	00 
  100313:	c7 04 24 80 d4 96 00 	movl   $0x96d480,(%esp)
  10031a:	e8 31 34 00 00       	call   103750 <memset>
	serial_init();
  10031f:	e8 3c 03 00 00       	call   100660 <serial_init>
	video_init();
  100324:	e8 d7 fc ff ff       	call   100000 <video_init>
	spinlock_init(&serialLock);
  100329:	c7 04 24 48 d4 96 00 	movl   $0x96d448,(%esp)
  100330:	e8 3b 4e 00 00       	call   105170 <spinlock_init>
	spinlock_init(&videoLock);
  100335:	c7 04 24 68 d4 96 00 	movl   $0x96d468,(%esp)
  10033c:	e8 2f 4e 00 00       	call   105170 <spinlock_init>
}
  100341:	83 c4 1c             	add    $0x1c,%esp
  100344:	c3                   	ret    
  100345:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100350 <cons_intr>:

void
cons_intr(int (*proc)(void))
{
  100350:	53                   	push   %ebx
  100351:	83 ec 08             	sub    $0x8,%esp
  100354:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	int c;

	while ((c = (*proc)()) != -1) {
  100358:	ff d3                	call   *%ebx
  10035a:	83 f8 ff             	cmp    $0xffffffff,%eax
  10035d:	74 39                	je     100398 <cons_intr+0x48>
		if (c == 0)
  10035f:	85 c0                	test   %eax,%eax
  100361:	74 f5                	je     100358 <cons_intr+0x8>
			continue;
		cons.buf[cons.wpos++] = c;
  100363:	8b 0d 84 d6 96 00    	mov    0x96d684,%ecx
  100369:	8d 51 01             	lea    0x1(%ecx),%edx
		if (cons.wpos == CONSOLE_BUFFER_SIZE)
  10036c:	81 fa 00 02 00 00    	cmp    $0x200,%edx
	int c;

	while ((c = (*proc)()) != -1) {
		if (c == 0)
			continue;
		cons.buf[cons.wpos++] = c;
  100372:	89 15 84 d6 96 00    	mov    %edx,0x96d684
  100378:	88 81 80 d4 96 00    	mov    %al,0x96d480(%ecx)
		if (cons.wpos == CONSOLE_BUFFER_SIZE)
  10037e:	75 d8                	jne    100358 <cons_intr+0x8>
			cons.wpos = 0;
  100380:	c7 05 84 d6 96 00 00 	movl   $0x0,0x96d684
  100387:	00 00 00 
void
cons_intr(int (*proc)(void))
{
	int c;

	while ((c = (*proc)()) != -1) {
  10038a:	ff d3                	call   *%ebx
  10038c:	83 f8 ff             	cmp    $0xffffffff,%eax
  10038f:	75 ce                	jne    10035f <cons_intr+0xf>
  100391:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		cons.buf[cons.wpos++] = c;
		if (cons.wpos == CONSOLE_BUFFER_SIZE)
			cons.wpos = 0;
	}

}
  100398:	83 c4 08             	add    $0x8,%esp
  10039b:	5b                   	pop    %ebx
  10039c:	c3                   	ret    
  10039d:	8d 76 00             	lea    0x0(%esi),%esi

001003a0 <cons_getc>:

char
cons_getc(void)
{
  1003a0:	83 ec 0c             	sub    $0xc,%esp


  // poll for any pending input characters,
  // so that this function works even when interrupts are disabled
  // (e.g., when called from the kernel monitor).
  serial_intr();
  1003a3:	e8 c8 01 00 00       	call   100570 <serial_intr>
  keyboard_intr();
  1003a8:	e8 d3 04 00 00       	call   100880 <keyboard_intr>

  // grab the next character from the input buffer.
  if (cons.rpos != cons.wpos) {
  1003ad:	a1 80 d6 96 00       	mov    0x96d680,%eax
  1003b2:	3b 05 84 d6 96 00    	cmp    0x96d684,%eax
  1003b8:	74 2e                	je     1003e8 <cons_getc+0x48>
    c = cons.buf[cons.rpos++];
  1003ba:	8d 50 01             	lea    0x1(%eax),%edx
  1003bd:	0f b6 80 80 d4 96 00 	movzbl 0x96d480(%eax),%eax
    if (cons.rpos == CONSOLE_BUFFER_SIZE)
  1003c4:	81 fa 00 02 00 00    	cmp    $0x200,%edx
  serial_intr();
  keyboard_intr();

  // grab the next character from the input buffer.
  if (cons.rpos != cons.wpos) {
    c = cons.buf[cons.rpos++];
  1003ca:	89 15 80 d6 96 00    	mov    %edx,0x96d680
    if (cons.rpos == CONSOLE_BUFFER_SIZE)
  1003d0:	74 06                	je     1003d8 <cons_getc+0x38>
      cons.rpos = 0;
    return c;
  }

  return 0;
}
  1003d2:	83 c4 0c             	add    $0xc,%esp
  1003d5:	c3                   	ret    
  1003d6:	66 90                	xchg   %ax,%ax

  // grab the next character from the input buffer.
  if (cons.rpos != cons.wpos) {
    c = cons.buf[cons.rpos++];
    if (cons.rpos == CONSOLE_BUFFER_SIZE)
      cons.rpos = 0;
  1003d8:	c7 05 80 d6 96 00 00 	movl   $0x0,0x96d680
  1003df:	00 00 00 
    return c;
  }

  return 0;
}
  1003e2:	83 c4 0c             	add    $0xc,%esp
  1003e5:	c3                   	ret    
  1003e6:	66 90                	xchg   %ax,%ax
    if (cons.rpos == CONSOLE_BUFFER_SIZE)
      cons.rpos = 0;
    return c;
  }

  return 0;
  1003e8:	31 c0                	xor    %eax,%eax
}
  1003ea:	83 c4 0c             	add    $0xc,%esp
  1003ed:	c3                   	ret    
  1003ee:	66 90                	xchg   %ax,%ax

001003f0 <cons_putc>:

void
cons_putc(char c)
{
  1003f0:	53                   	push   %ebx
  1003f1:	83 ec 18             	sub    $0x18,%esp
  1003f4:	8b 5c 24 20          	mov    0x20(%esp),%ebx
	spinlock_acquire(&serialLock);
  1003f8:	c7 04 24 48 d4 96 00 	movl   $0x96d448,(%esp)
  1003ff:	e8 2c 4f 00 00       	call   105330 <spinlock_acquire>
	serial_putc(c);
  100404:	0f be db             	movsbl %bl,%ebx
  100407:	89 1c 24             	mov    %ebx,(%esp)
  10040a:	e8 91 01 00 00       	call   1005a0 <serial_putc>
	spinlock_release(&serialLock);
  10040f:	c7 04 24 48 d4 96 00 	movl   $0x96d448,(%esp)
  100416:	e8 95 4f 00 00       	call   1053b0 <spinlock_release>
	spinlock_acquire(&videoLock);
  10041b:	c7 04 24 68 d4 96 00 	movl   $0x96d468,(%esp)
  100422:	e8 09 4f 00 00       	call   105330 <spinlock_acquire>
 	video_putc(c);
  100427:	89 1c 24             	mov    %ebx,(%esp)
  10042a:	e8 c1 fc ff ff       	call   1000f0 <video_putc>
	spinlock_release(&videoLock);
  10042f:	c7 44 24 20 68 d4 96 	movl   $0x96d468,0x20(%esp)
  100436:	00 
}
  100437:	83 c4 18             	add    $0x18,%esp
  10043a:	5b                   	pop    %ebx
	spinlock_acquire(&serialLock);
	serial_putc(c);
	spinlock_release(&serialLock);
	spinlock_acquire(&videoLock);
 	video_putc(c);
	spinlock_release(&videoLock);
  10043b:	e9 70 4f 00 00       	jmp    1053b0 <spinlock_release>

00100440 <getchar>:
}

char
getchar(void)
{
  100440:	83 ec 0c             	sub    $0xc,%esp
  100443:	90                   	nop
  100444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char c;

  while ((c = cons_getc()) == 0)
  100448:	e8 53 ff ff ff       	call   1003a0 <cons_getc>
  10044d:	84 c0                	test   %al,%al
  10044f:	74 f7                	je     100448 <getchar+0x8>
    /* do nothing */;
  return c;
}
  100451:	83 c4 0c             	add    $0xc,%esp
  100454:	c3                   	ret    
  100455:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100460 <putchar>:

void
putchar(char c)
{
  cons_putc(c);
  100460:	0f be 44 24 04       	movsbl 0x4(%esp),%eax
  100465:	89 44 24 04          	mov    %eax,0x4(%esp)
  100469:	e9 82 ff ff ff       	jmp    1003f0 <cons_putc>
  10046e:	66 90                	xchg   %ax,%ax

00100470 <readline>:
}

char *
readline(const char *prompt)
{
  100470:	53                   	push   %ebx
  100471:	83 ec 18             	sub    $0x18,%esp
  100474:	8b 44 24 20          	mov    0x20(%esp),%eax
  int i;
  char c;

  if (prompt != NULL)
  100478:	85 c0                	test   %eax,%eax
  10047a:	74 10                	je     10048c <readline+0x1c>
    dprintf("%s", prompt);
  10047c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100480:	c7 04 24 02 94 10 00 	movl   $0x109402,(%esp)
  100487:	e8 04 38 00 00       	call   103c90 <dprintf>
    } else if ((c == '\b' || c == '\x7f') && i > 0) {
      putchar('\b');
      i--;
    } else if (c >= ' ' && i < BUFLEN-1) {
      putchar(c);
      linebuf[i++] = c;
  10048c:	31 db                	xor    %ebx,%ebx
  10048e:	66 90                	xchg   %ax,%ax
char
getchar(void)
{
  char c;

  while ((c = cons_getc()) == 0)
  100490:	e8 0b ff ff ff       	call   1003a0 <cons_getc>
  100495:	84 c0                	test   %al,%al
  100497:	74 f7                	je     100490 <readline+0x20>
    dprintf("%s", prompt);

  i = 0;
  while (1) {
    c = getchar();
    if (c < 0) {
  100499:	78 7e                	js     100519 <readline+0xa9>
      dprintf("read error: %e\n", c);
      return NULL;
    } else if ((c == '\b' || c == '\x7f') && i > 0) {
  10049b:	3c 7f                	cmp    $0x7f,%al
  10049d:	8d 76 00             	lea    0x0(%esi),%esi
  1004a0:	74 04                	je     1004a6 <readline+0x36>
  1004a2:	3c 08                	cmp    $0x8,%al
  1004a4:	75 1a                	jne    1004c0 <readline+0x50>
  1004a6:	85 db                	test   %ebx,%ebx
  1004a8:	74 16                	je     1004c0 <readline+0x50>
}

void
putchar(char c)
{
  cons_putc(c);
  1004aa:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    if (c < 0) {
      dprintf("read error: %e\n", c);
      return NULL;
    } else if ((c == '\b' || c == '\x7f') && i > 0) {
      putchar('\b');
      i--;
  1004b1:	83 eb 01             	sub    $0x1,%ebx
}

void
putchar(char c)
{
  cons_putc(c);
  1004b4:	e8 37 ff ff ff       	call   1003f0 <cons_putc>
    if (c < 0) {
      dprintf("read error: %e\n", c);
      return NULL;
    } else if ((c == '\b' || c == '\x7f') && i > 0) {
      putchar('\b');
      i--;
  1004b9:	eb d5                	jmp    100490 <readline+0x20>
  1004bb:	90                   	nop
  1004bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if (c >= ' ' && i < BUFLEN-1) {
  1004c0:	3c 1f                	cmp    $0x1f,%al
  1004c2:	7f 2c                	jg     1004f0 <readline+0x80>
      putchar(c);
      linebuf[i++] = c;
    } else if (c == '\n' || c == '\r') {
  1004c4:	3c 0d                	cmp    $0xd,%al
  1004c6:	74 04                	je     1004cc <readline+0x5c>
  1004c8:	3c 0a                	cmp    $0xa,%al
  1004ca:	75 c4                	jne    100490 <readline+0x20>
}

void
putchar(char c)
{
  cons_putc(c);
  1004cc:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  1004d3:	e8 18 ff ff ff       	call   1003f0 <cons_putc>
      putchar(c);
      linebuf[i++] = c;
    } else if (c == '\n' || c == '\r') {
      putchar('\n');
      linebuf[i] = 0;
      return linebuf;
  1004d8:	b8 00 c0 12 00       	mov    $0x12c000,%eax
    } else if (c >= ' ' && i < BUFLEN-1) {
      putchar(c);
      linebuf[i++] = c;
    } else if (c == '\n' || c == '\r') {
      putchar('\n');
      linebuf[i] = 0;
  1004dd:	c6 83 00 c0 12 00 00 	movb   $0x0,0x12c000(%ebx)
      return linebuf;
    }
  }
}
  1004e4:	83 c4 18             	add    $0x18,%esp
  1004e7:	5b                   	pop    %ebx
  1004e8:	c3                   	ret    
  1004e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      dprintf("read error: %e\n", c);
      return NULL;
    } else if ((c == '\b' || c == '\x7f') && i > 0) {
      putchar('\b');
      i--;
    } else if (c >= ' ' && i < BUFLEN-1) {
  1004f0:	81 fb fe 03 00 00    	cmp    $0x3fe,%ebx
  1004f6:	7f cc                	jg     1004c4 <readline+0x54>
}

void
putchar(char c)
{
  cons_putc(c);
  1004f8:	0f be d0             	movsbl %al,%edx
    } else if ((c == '\b' || c == '\x7f') && i > 0) {
      putchar('\b');
      i--;
    } else if (c >= ' ' && i < BUFLEN-1) {
      putchar(c);
      linebuf[i++] = c;
  1004fb:	83 c3 01             	add    $0x1,%ebx
}

void
putchar(char c)
{
  cons_putc(c);
  1004fe:	89 14 24             	mov    %edx,(%esp)
  100501:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100505:	e8 e6 fe ff ff       	call   1003f0 <cons_putc>
    } else if ((c == '\b' || c == '\x7f') && i > 0) {
      putchar('\b');
      i--;
    } else if (c >= ' ' && i < BUFLEN-1) {
      putchar(c);
      linebuf[i++] = c;
  10050a:	8b 44 24 0c          	mov    0xc(%esp),%eax
  10050e:	88 83 ff bf 12 00    	mov    %al,0x12bfff(%ebx)
  100514:	e9 77 ff ff ff       	jmp    100490 <readline+0x20>

  i = 0;
  while (1) {
    c = getchar();
    if (c < 0) {
      dprintf("read error: %e\n", c);
  100519:	0f be c0             	movsbl %al,%eax
  10051c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100520:	c7 04 24 0e 7c 10 00 	movl   $0x107c0e,(%esp)
  100527:	e8 64 37 00 00       	call   103c90 <dprintf>
      putchar('\n');
      linebuf[i] = 0;
      return linebuf;
    }
  }
}
  10052c:	83 c4 18             	add    $0x18,%esp
  i = 0;
  while (1) {
    c = getchar();
    if (c < 0) {
      dprintf("read error: %e\n", c);
      return NULL;
  10052f:	31 c0                	xor    %eax,%eax
      putchar('\n');
      linebuf[i] = 0;
      return linebuf;
    }
  }
}
  100531:	5b                   	pop    %ebx
  100532:	c3                   	ret    
  100533:	66 90                	xchg   %ax,%ax
  100535:	66 90                	xchg   %ax,%ax
  100537:	66 90                	xchg   %ax,%ax
  100539:	66 90                	xchg   %ax,%ax
  10053b:	66 90                	xchg   %ax,%ax
  10053d:	66 90                	xchg   %ax,%ax
  10053f:	90                   	nop

00100540 <serial_proc_data>:
	inb(0x84);
}

static int
serial_proc_data(void)
{
  100540:	83 ec 1c             	sub    $0x1c,%esp
	if (!(inb(COM1+COM_LSR) & COM_LSR_DATA))
  100543:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
  10054a:	e8 c1 43 00 00       	call   104910 <inb>
  10054f:	a8 01                	test   $0x1,%al
  100551:	74 15                	je     100568 <serial_proc_data+0x28>
		return -1;
	return inb(COM1+COM_RX);
  100553:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
  10055a:	e8 b1 43 00 00       	call   104910 <inb>
  10055f:	0f b6 c0             	movzbl %al,%eax
}
  100562:	83 c4 1c             	add    $0x1c,%esp
  100565:	c3                   	ret    
  100566:	66 90                	xchg   %ax,%ax

static int
serial_proc_data(void)
{
	if (!(inb(COM1+COM_LSR) & COM_LSR_DATA))
		return -1;
  100568:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10056d:	eb f3                	jmp    100562 <serial_proc_data+0x22>
  10056f:	90                   	nop

00100570 <serial_intr>:
}

void
serial_intr(void)
{
	if (serial_exists)
  100570:	80 3d 88 d6 96 00 00 	cmpb   $0x0,0x96d688
  100577:	75 07                	jne    100580 <serial_intr+0x10>
		cons_intr(serial_proc_data);
}
  100579:	c3                   	ret    
  10057a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	return inb(COM1+COM_RX);
}

void
serial_intr(void)
{
  100580:	83 ec 1c             	sub    $0x1c,%esp
	if (serial_exists)
		cons_intr(serial_proc_data);
  100583:	c7 04 24 40 05 10 00 	movl   $0x100540,(%esp)
  10058a:	e8 c1 fd ff ff       	call   100350 <cons_intr>
}
  10058f:	83 c4 1c             	add    $0x1c,%esp
  100592:	c3                   	ret    
  100593:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001005a0 <serial_putc>:
		return 0;
}

void
serial_putc(char c)
{
  1005a0:	56                   	push   %esi
  1005a1:	53                   	push   %ebx
	if (!serial_exists)
  1005a2:	bb 01 32 00 00       	mov    $0x3201,%ebx
		return 0;
}

void
serial_putc(char c)
{
  1005a7:	83 ec 14             	sub    $0x14,%esp
	if (!serial_exists)
  1005aa:	80 3d 88 d6 96 00 00 	cmpb   $0x0,0x96d688
		return 0;
}

void
serial_putc(char c)
{
  1005b1:	8b 74 24 20          	mov    0x20(%esp),%esi
	if (!serial_exists)
  1005b5:	75 3e                	jne    1005f5 <serial_putc+0x55>
  1005b7:	eb 67                	jmp    100620 <serial_putc+0x80>
  1005b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return;

	int i;
	for (i = 0;
	     !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800;
  1005c0:	83 eb 01             	sub    $0x1,%ebx
  1005c3:	74 40                	je     100605 <serial_putc+0x65>

// Stupid I/O delay routine necessitated by historical PC design flaws
static void
delay(void)
{
	inb(0x84);
  1005c5:	c7 04 24 84 00 00 00 	movl   $0x84,(%esp)
  1005cc:	e8 3f 43 00 00       	call   104910 <inb>
	inb(0x84);
  1005d1:	c7 04 24 84 00 00 00 	movl   $0x84,(%esp)
  1005d8:	e8 33 43 00 00       	call   104910 <inb>
	inb(0x84);
  1005dd:	c7 04 24 84 00 00 00 	movl   $0x84,(%esp)
  1005e4:	e8 27 43 00 00       	call   104910 <inb>
	inb(0x84);
  1005e9:	c7 04 24 84 00 00 00 	movl   $0x84,(%esp)
  1005f0:	e8 1b 43 00 00       	call   104910 <inb>
	if (!serial_exists)
		return;

	int i;
	for (i = 0;
	     !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800;
  1005f5:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
  1005fc:	e8 0f 43 00 00       	call   104910 <inb>
{
	if (!serial_exists)
		return;

	int i;
	for (i = 0;
  100601:	a8 20                	test   $0x20,%al
  100603:	74 bb                	je     1005c0 <serial_putc+0x20>
	int nl = '\n';
	/* POSIX requires newline on the serial line to
	 * be a CR-LF pair. Without this, you get a malformed output
	 * with clients like minicom or screen
	 */
	if (c == nl) {
  100605:	89 f0                	mov    %esi,%eax
  100607:	3c 0a                	cmp    $0xa,%al
  100609:	74 1d                	je     100628 <serial_putc+0x88>
	     !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800;
	     i++)
		delay();

	if (!serial_reformatnewline(c, COM1 + COM_TX))
		outb(COM1 + COM_TX, c);
  10060b:	89 f0                	mov    %esi,%eax
  10060d:	0f b6 f0             	movzbl %al,%esi
  100610:	89 74 24 04          	mov    %esi,0x4(%esp)
  100614:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
  10061b:	e8 20 43 00 00       	call   104940 <outb>
}
  100620:	83 c4 14             	add    $0x14,%esp
  100623:	5b                   	pop    %ebx
  100624:	5e                   	pop    %esi
  100625:	c3                   	ret    
  100626:	66 90                	xchg   %ax,%ax
	/* POSIX requires newline on the serial line to
	 * be a CR-LF pair. Without this, you get a malformed output
	 * with clients like minicom or screen
	 */
	if (c == nl) {
		outb(p, cr);
  100628:	c7 44 24 04 0d 00 00 	movl   $0xd,0x4(%esp)
  10062f:	00 
  100630:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
  100637:	e8 04 43 00 00       	call   104940 <outb>
		outb(p, nl);
  10063c:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
  100643:	00 
  100644:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
  10064b:	e8 f0 42 00 00       	call   104940 <outb>
	     i++)
		delay();

	if (!serial_reformatnewline(c, COM1 + COM_TX))
		outb(COM1 + COM_TX, c);
}
  100650:	83 c4 14             	add    $0x14,%esp
  100653:	5b                   	pop    %ebx
  100654:	5e                   	pop    %esi
  100655:	c3                   	ret    
  100656:	8d 76 00             	lea    0x0(%esi),%esi
  100659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100660 <serial_init>:

void
serial_init(void)
{
  100660:	83 ec 1c             	sub    $0x1c,%esp
	/* turn off interrupt */
	outb(COM1 + COM_IER, 0);
  100663:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10066a:	00 
  10066b:	c7 04 24 f9 03 00 00 	movl   $0x3f9,(%esp)
  100672:	e8 c9 42 00 00       	call   104940 <outb>

	/* set DLAB */
	outb(COM1 + COM_LCR, COM_LCR_DLAB);
  100677:	c7 44 24 04 80 00 00 	movl   $0x80,0x4(%esp)
  10067e:	00 
  10067f:	c7 04 24 fb 03 00 00 	movl   $0x3fb,(%esp)
  100686:	e8 b5 42 00 00       	call   104940 <outb>

	/* set baud rate */
	outb(COM1 + COM_DLL, 0x0001 & 0xff);
  10068b:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  100692:	00 
  100693:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
  10069a:	e8 a1 42 00 00       	call   104940 <outb>
	outb(COM1 + COM_DLM, 0x0001 >> 8);
  10069f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1006a6:	00 
  1006a7:	c7 04 24 f9 03 00 00 	movl   $0x3f9,(%esp)
  1006ae:	e8 8d 42 00 00       	call   104940 <outb>

	/* Set the line status.  */
	outb(COM1 + COM_LCR, COM_LCR_WLEN8 & ~COM_LCR_DLAB);
  1006b3:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
  1006ba:	00 
  1006bb:	c7 04 24 fb 03 00 00 	movl   $0x3fb,(%esp)
  1006c2:	e8 79 42 00 00       	call   104940 <outb>

	/* Enable the FIFO.  */
	outb(COM1 + COM_FCR, 0xc7);
  1006c7:	c7 44 24 04 c7 00 00 	movl   $0xc7,0x4(%esp)
  1006ce:	00 
  1006cf:	c7 04 24 fa 03 00 00 	movl   $0x3fa,(%esp)
  1006d6:	e8 65 42 00 00       	call   104940 <outb>

	/* Turn on DTR, RTS, and OUT2.  */
	outb(COM1 + COM_MCR, 0x0b);
  1006db:	c7 44 24 04 0b 00 00 	movl   $0xb,0x4(%esp)
  1006e2:	00 
  1006e3:	c7 04 24 fc 03 00 00 	movl   $0x3fc,(%esp)
  1006ea:	e8 51 42 00 00       	call   104940 <outb>

	// Clear any preexisting overrun indications and interrupts
	// Serial COM1 doesn't exist if COM_LSR returns 0xFF
	serial_exists = (inb(COM1+COM_LSR) != 0xFF);
  1006ef:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
  1006f6:	e8 15 42 00 00       	call   104910 <inb>
	(void) inb(COM1+COM_IIR);
  1006fb:	c7 04 24 fa 03 00 00 	movl   $0x3fa,(%esp)
	/* Turn on DTR, RTS, and OUT2.  */
	outb(COM1 + COM_MCR, 0x0b);

	// Clear any preexisting overrun indications and interrupts
	// Serial COM1 doesn't exist if COM_LSR returns 0xFF
	serial_exists = (inb(COM1+COM_LSR) != 0xFF);
  100702:	3c ff                	cmp    $0xff,%al
  100704:	0f 95 05 88 d6 96 00 	setne  0x96d688
	(void) inb(COM1+COM_IIR);
  10070b:	e8 00 42 00 00       	call   104910 <inb>
	(void) inb(COM1+COM_RX);
  100710:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
  100717:	e8 f4 41 00 00       	call   104910 <inb>
}
  10071c:	83 c4 1c             	add    $0x1c,%esp
  10071f:	c3                   	ret    

00100720 <serial_intenable>:

void
serial_intenable(void)
{
	if (serial_exists) {
  100720:	80 3d 88 d6 96 00 00 	cmpb   $0x0,0x96d688
  100727:	75 07                	jne    100730 <serial_intenable+0x10>
		outb(COM1+COM_IER, 1);
		//intr_enable(IRQ_SERIAL13);
		serial_intr();
	}
}
  100729:	c3                   	ret    
  10072a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	(void) inb(COM1+COM_RX);
}

void
serial_intenable(void)
{
  100730:	83 ec 1c             	sub    $0x1c,%esp
	if (serial_exists) {
		outb(COM1+COM_IER, 1);
  100733:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  10073a:	00 
  10073b:	c7 04 24 f9 03 00 00 	movl   $0x3f9,(%esp)
  100742:	e8 f9 41 00 00       	call   104940 <outb>
}

void
serial_intr(void)
{
	if (serial_exists)
  100747:	80 3d 88 d6 96 00 00 	cmpb   $0x0,0x96d688
  10074e:	74 0c                	je     10075c <serial_intenable+0x3c>
		cons_intr(serial_proc_data);
  100750:	c7 04 24 40 05 10 00 	movl   $0x100540,(%esp)
  100757:	e8 f4 fb ff ff       	call   100350 <cons_intr>
	if (serial_exists) {
		outb(COM1+COM_IER, 1);
		//intr_enable(IRQ_SERIAL13);
		serial_intr();
	}
}
  10075c:	83 c4 1c             	add    $0x1c,%esp
  10075f:	c3                   	ret    

00100760 <kbd_proc_data>:
 * Get data from the keyboard.  If we finish a character, return it.  Else 0.
 * Return -1 if no data.
 */
static int
kbd_proc_data(void)
{
  100760:	53                   	push   %ebx
  100761:	83 ec 18             	sub    $0x18,%esp
  int c;
  uint8_t data;
  static uint32_t shift;

  if ((inb(KBSTATP) & KBS_DIB) == 0)
  100764:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
  10076b:	e8 a0 41 00 00       	call   104910 <inb>
  100770:	a8 01                	test   $0x1,%al
  100772:	0f 84 f8 00 00 00    	je     100870 <kbd_proc_data+0x110>
    return -1;

  data = inb(KBDATAP);
  100778:	c7 04 24 60 00 00 00 	movl   $0x60,(%esp)
  10077f:	e8 8c 41 00 00       	call   104910 <inb>

  if (data == 0xE0) {
  100784:	3c e0                	cmp    $0xe0,%al
  static uint32_t shift;

  if ((inb(KBSTATP) & KBS_DIB) == 0)
    return -1;

  data = inb(KBDATAP);
  100786:	89 c2                	mov    %eax,%edx

  if (data == 0xE0) {
  100788:	0f 84 d2 00 00 00    	je     100860 <kbd_proc_data+0x100>
    // E0 escape character
    shift |= E0ESC;
    return 0;
  } else if (data & 0x80) {
  10078e:	84 c0                	test   %al,%al
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
  100790:	8b 0d 00 c4 12 00    	mov    0x12c400,%ecx

  if (data == 0xE0) {
    // E0 escape character
    shift |= E0ESC;
    return 0;
  } else if (data & 0x80) {
  100796:	0f 88 94 00 00 00    	js     100830 <kbd_proc_data+0xd0>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if (shift & E0ESC) {
  10079c:	f6 c1 40             	test   $0x40,%cl
  10079f:	74 08                	je     1007a9 <kbd_proc_data+0x49>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
  1007a1:	89 c2                	mov    %eax,%edx
    shift &= ~E0ESC;
  1007a3:	83 e1 bf             	and    $0xffffffbf,%ecx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if (shift & E0ESC) {
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
  1007a6:	83 ca 80             	or     $0xffffff80,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  1007a9:	0f b6 c2             	movzbl %dl,%eax
  1007ac:	0f b6 90 60 7d 10 00 	movzbl 0x107d60(%eax),%edx
  1007b3:	09 ca                	or     %ecx,%edx
  shift ^= togglecode[data];
  1007b5:	0f b6 88 60 7c 10 00 	movzbl 0x107c60(%eax),%ecx
  1007bc:	31 ca                	xor    %ecx,%edx

  c = charcode[shift & (CTL | SHIFT)][data];
  1007be:	89 d1                	mov    %edx,%ecx
  1007c0:	83 e1 03             	and    $0x3,%ecx
  if (shift & CAPSLOCK) {
  1007c3:	f6 c2 08             	test   $0x8,%dl
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];

  c = charcode[shift & (CTL | SHIFT)][data];
  1007c6:	8b 0c 8d 40 7c 10 00 	mov    0x107c40(,%ecx,4),%ecx
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  1007cd:	89 15 00 c4 12 00    	mov    %edx,0x12c400

  c = charcode[shift & (CTL | SHIFT)][data];
  1007d3:	0f b6 1c 01          	movzbl (%ecx,%eax,1),%ebx
  if (shift & CAPSLOCK) {
  1007d7:	74 23                	je     1007fc <kbd_proc_data+0x9c>
    if ('a' <= c && c <= 'z')
  1007d9:	8d 43 9f             	lea    -0x61(%ebx),%eax
  1007dc:	83 f8 19             	cmp    $0x19,%eax
  1007df:	77 0f                	ja     1007f0 <kbd_proc_data+0x90>
      c += 'A' - 'a';
  1007e1:	83 eb 20             	sub    $0x20,%ebx
  1007e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dprintf("Rebooting!\n");
    outb(0x92, 0x3); // courtesy of Chris Frost
  }

  return c;
}
  1007e8:	83 c4 18             	add    $0x18,%esp
  1007eb:	89 d8                	mov    %ebx,%eax
  1007ed:	5b                   	pop    %ebx
  1007ee:	c3                   	ret    
  1007ef:	90                   	nop

  c = charcode[shift & (CTL | SHIFT)][data];
  if (shift & CAPSLOCK) {
    if ('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if ('A' <= c && c <= 'Z')
  1007f0:	8d 4b bf             	lea    -0x41(%ebx),%ecx
      c += 'a' - 'A';
  1007f3:	8d 43 20             	lea    0x20(%ebx),%eax
  1007f6:	83 f9 19             	cmp    $0x19,%ecx
  1007f9:	0f 46 d8             	cmovbe %eax,%ebx
  }

  // Process special keys
  // Ctrl-Alt-Del: reboot
  if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  1007fc:	f7 d2                	not    %edx
  1007fe:	83 e2 06             	and    $0x6,%edx
  100801:	75 e5                	jne    1007e8 <kbd_proc_data+0x88>
  100803:	81 fb e9 00 00 00    	cmp    $0xe9,%ebx
  100809:	75 dd                	jne    1007e8 <kbd_proc_data+0x88>
    dprintf("Rebooting!\n");
  10080b:	c7 04 24 1e 7c 10 00 	movl   $0x107c1e,(%esp)
  100812:	e8 79 34 00 00       	call   103c90 <dprintf>
    outb(0x92, 0x3); // courtesy of Chris Frost
  100817:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
  10081e:	00 
  10081f:	c7 04 24 92 00 00 00 	movl   $0x92,(%esp)
  100826:	e8 15 41 00 00       	call   104940 <outb>
  10082b:	eb bb                	jmp    1007e8 <kbd_proc_data+0x88>
  10082d:	8d 76 00             	lea    0x0(%esi),%esi
    // E0 escape character
    shift |= E0ESC;
    return 0;
  } else if (data & 0x80) {
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
  100830:	83 e0 7f             	and    $0x7f,%eax
  100833:	f6 c1 40             	test   $0x40,%cl
  100836:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  100839:	31 db                	xor    %ebx,%ebx
    shift |= E0ESC;
    return 0;
  } else if (data & 0x80) {
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
  10083b:	0f b6 d2             	movzbl %dl,%edx
  10083e:	0f b6 82 60 7d 10 00 	movzbl 0x107d60(%edx),%eax
  100845:	83 c8 40             	or     $0x40,%eax
  100848:	0f b6 c0             	movzbl %al,%eax
  10084b:	f7 d0                	not    %eax
  10084d:	21 c8                	and    %ecx,%eax
  10084f:	a3 00 c4 12 00       	mov    %eax,0x12c400
    dprintf("Rebooting!\n");
    outb(0x92, 0x3); // courtesy of Chris Frost
  }

  return c;
}
  100854:	83 c4 18             	add    $0x18,%esp
  100857:	89 d8                	mov    %ebx,%eax
  100859:	5b                   	pop    %ebx
  10085a:	c3                   	ret    
  10085b:	90                   	nop
  10085c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  data = inb(KBDATAP);

  if (data == 0xE0) {
    // E0 escape character
    shift |= E0ESC;
    return 0;
  100860:	31 db                	xor    %ebx,%ebx

  data = inb(KBDATAP);

  if (data == 0xE0) {
    // E0 escape character
    shift |= E0ESC;
  100862:	83 0d 00 c4 12 00 40 	orl    $0x40,0x12c400
    dprintf("Rebooting!\n");
    outb(0x92, 0x3); // courtesy of Chris Frost
  }

  return c;
}
  100869:	83 c4 18             	add    $0x18,%esp
  10086c:	89 d8                	mov    %ebx,%eax
  10086e:	5b                   	pop    %ebx
  10086f:	c3                   	ret    
  int c;
  uint8_t data;
  static uint32_t shift;

  if ((inb(KBSTATP) & KBS_DIB) == 0)
    return -1;
  100870:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  100875:	e9 6e ff ff ff       	jmp    1007e8 <kbd_proc_data+0x88>
  10087a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00100880 <keyboard_intr>:
  return c;
}

void
keyboard_intr(void)
{
  100880:	83 ec 1c             	sub    $0x1c,%esp
  cons_intr(kbd_proc_data);
  100883:	c7 04 24 60 07 10 00 	movl   $0x100760,(%esp)
  10088a:	e8 c1 fa ff ff       	call   100350 <cons_intr>
}
  10088f:	83 c4 1c             	add    $0x1c,%esp
  100892:	c3                   	ret    
  100893:	66 90                	xchg   %ax,%ax
  100895:	66 90                	xchg   %ax,%ax
  100897:	66 90                	xchg   %ax,%ax
  100899:	66 90                	xchg   %ax,%ax
  10089b:	66 90                	xchg   %ax,%ax
  10089d:	66 90                	xchg   %ax,%ax
  10089f:	90                   	nop

001008a0 <devinit>:

void intr_init(void);

void
devinit (uintptr_t mbi_addr)
{
  1008a0:	53                   	push   %ebx
  1008a1:	83 ec 18             	sub    $0x18,%esp
  1008a4:	8b 5c 24 20          	mov    0x20(%esp),%ebx
	seg_init (0);
  1008a8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1008af:	e8 cc 39 00 00       	call   104280 <seg_init>

	enable_sse ();
  1008b4:	e8 97 3e 00 00       	call   104750 <enable_sse>

	cons_init ();
  1008b9:	e8 42 fa ff ff       	call   100300 <cons_init>
  1008be:	66 90                	xchg   %ax,%ax

	debug_init();
  1008c0:	e8 1b 31 00 00       	call   1039e0 <debug_init>
	KERN_INFO("[BSP KERN] cons initialized.\n");
  1008c5:	c7 04 24 60 7e 10 00 	movl   $0x107e60,(%esp)
  1008cc:	e8 1f 31 00 00       	call   1039f0 <debug_info>
	KERN_INFO("[BSP KERN] devinit mbi_adr: %d\n", mbi_addr);
  1008d1:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  1008d5:	c7 04 24 30 7f 10 00 	movl   $0x107f30,(%esp)
  1008dc:	e8 0f 31 00 00       	call   1039f0 <debug_info>

	/* pcpu init codes */
	pcpu_init();
  1008e1:	e8 fa 4c 00 00       	call   1055e0 <pcpu_init>
	KERN_INFO("[BSP KERN] PCPU initialized\n");
  1008e6:	c7 04 24 7e 7e 10 00 	movl   $0x107e7e,(%esp)
  1008ed:	e8 fe 30 00 00       	call   1039f0 <debug_info>

	tsc_init();
  1008f2:	e8 19 12 00 00       	call   101b10 <tsc_init>
	KERN_INFO("[BSP KERN] TSC initialized\n");
  1008f7:	c7 04 24 9b 7e 10 00 	movl   $0x107e9b,(%esp)
  1008fe:	e8 ed 30 00 00       	call   1039f0 <debug_info>

	intr_init();
  100903:	e8 88 05 00 00       	call   100e90 <intr_init>
	KERN_INFO("[BSP KERN] INTR initialized\n");
  100908:	c7 04 24 b7 7e 10 00 	movl   $0x107eb7,(%esp)
  10090f:	e8 dc 30 00 00       	call   1039f0 <debug_info>
	
	trap_init(0);
  100914:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10091b:	e8 d0 6e 00 00       	call   1077f0 <trap_init>

	pmmap_init (mbi_addr);
  100920:	89 5c 24 20          	mov    %ebx,0x20(%esp)

}
  100924:	83 c4 18             	add    $0x18,%esp
  100927:	5b                   	pop    %ebx
	intr_init();
	KERN_INFO("[BSP KERN] INTR initialized\n");
	
	trap_init(0);

	pmmap_init (mbi_addr);
  100928:	e9 13 01 00 00       	jmp    100a40 <pmmap_init>
  10092d:	8d 76 00             	lea    0x0(%esi),%esi

00100930 <devinit_ap>:

}

void 
devinit_ap (void)
{
  100930:	53                   	push   %ebx
  100931:	83 ec 18             	sub    $0x18,%esp
	/* Figure out the current (booting) kernel stack) */
  	struct kstack *ks =
                (struct kstack *) ROUNDDOWN(get_stack_pointer(), KSTACK_SIZE);
  100934:	e8 67 3d 00 00       	call   1046a0 <get_stack_pointer>

	KERN_ASSERT(ks != NULL);
  100939:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  10093e:	89 c3                	mov    %eax,%ebx
  100940:	0f 84 92 00 00 00    	je     1009d8 <devinit_ap+0xa8>
	KERN_ASSERT(1 <= ks->cpu_idx && ks->cpu_idx < 8);
  100946:	8b 83 1c 01 00 00    	mov    0x11c(%ebx),%eax
  10094c:	8d 50 ff             	lea    -0x1(%eax),%edx
  10094f:	83 fa 06             	cmp    $0x6,%edx
  100952:	76 2a                	jbe    10097e <devinit_ap+0x4e>
  100954:	c7 44 24 0c 50 7f 10 	movl   $0x107f50,0xc(%esp)
  10095b:	00 
  10095c:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  100963:	00 
  100964:	c7 44 24 04 36 00 00 	movl   $0x36,0x4(%esp)
  10096b:	00 
  10096c:	c7 04 24 fc 7e 10 00 	movl   $0x107efc,(%esp)
  100973:	e8 08 31 00 00       	call   103a80 <debug_panic>
  100978:	8b 83 1c 01 00 00    	mov    0x11c(%ebx),%eax

  	/* kernel stack for this cpu initialized */
  	seg_init(ks->cpu_idx);
  10097e:	89 04 24             	mov    %eax,(%esp)
  100981:	e8 fa 38 00 00       	call   104280 <seg_init>

  	pcpu_init();
  100986:	e8 55 4c 00 00       	call   1055e0 <pcpu_init>
  	KERN_INFO("[AP%d KERN] PCPU initialized\n", ks->cpu_idx);
  10098b:	8b 83 1c 01 00 00    	mov    0x11c(%ebx),%eax
  100991:	c7 04 24 0f 7f 10 00 	movl   $0x107f0f,(%esp)
  100998:	89 44 24 04          	mov    %eax,0x4(%esp)
  10099c:	e8 4f 30 00 00       	call   1039f0 <debug_info>
	
	intr_init();
  1009a1:	e8 ea 04 00 00       	call   100e90 <intr_init>
  	KERN_INFO("[AP%d KERN] INTR initialized.\n", ks->cpu_idx);
  1009a6:	8b 83 1c 01 00 00    	mov    0x11c(%ebx),%eax
  1009ac:	c7 04 24 74 7f 10 00 	movl   $0x107f74,(%esp)
  1009b3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009b7:	e8 34 30 00 00       	call   1039f0 <debug_info>

	trap_init(ks->cpu_idx);
  1009bc:	8b 83 1c 01 00 00    	mov    0x11c(%ebx),%eax
  1009c2:	89 04 24             	mov    %eax,(%esp)
  1009c5:	e8 26 6e 00 00       	call   1077f0 <trap_init>

	paging_init_ap();
}
  1009ca:	83 c4 18             	add    $0x18,%esp
  1009cd:	5b                   	pop    %ebx
	intr_init();
  	KERN_INFO("[AP%d KERN] INTR initialized.\n", ks->cpu_idx);

	trap_init(ks->cpu_idx);

	paging_init_ap();
  1009ce:	e9 ad 59 00 00       	jmp    106380 <paging_init_ap>
  1009d3:	90                   	nop
  1009d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
	/* Figure out the current (booting) kernel stack) */
  	struct kstack *ks =
                (struct kstack *) ROUNDDOWN(get_stack_pointer(), KSTACK_SIZE);

	KERN_ASSERT(ks != NULL);
  1009d8:	c7 44 24 0c d4 7e 10 	movl   $0x107ed4,0xc(%esp)
  1009df:	00 
  1009e0:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  1009e7:	00 
  1009e8:	c7 44 24 04 35 00 00 	movl   $0x35,0x4(%esp)
  1009ef:	00 
  1009f0:	c7 04 24 fc 7e 10 00 	movl   $0x107efc,(%esp)
  1009f7:	e8 84 30 00 00       	call   103a80 <debug_panic>
  1009fc:	e9 45 ff ff ff       	jmp    100946 <devinit_ap+0x16>
  100a01:	66 90                	xchg   %ax,%ax
  100a03:	66 90                	xchg   %ax,%ax
  100a05:	66 90                	xchg   %ax,%ax
  100a07:	66 90                	xchg   %ax,%ax
  100a09:	66 90                	xchg   %ax,%ax
  100a0b:	66 90                	xchg   %ax,%ax
  100a0d:	66 90                	xchg   %ax,%ax
  100a0f:	90                   	nop

00100a10 <pmmap_alloc_slot>:
static int pmmap_nentries = 0;

struct pmmap *
pmmap_alloc_slot(void)
{
	if (unlikely(pmmap_slots_next_free == 128))
  100a10:	a1 40 c4 12 00       	mov    0x12c440,%eax
  100a15:	3d 80 00 00 00       	cmp    $0x80,%eax
  100a1a:	74 14                	je     100a30 <pmmap_alloc_slot+0x20>
		return NULL;
	return &pmmap_slots[pmmap_slots_next_free++];
  100a1c:	8d 50 01             	lea    0x1(%eax),%edx
  100a1f:	8d 04 80             	lea    (%eax,%eax,4),%eax
  100a22:	89 15 40 c4 12 00    	mov    %edx,0x12c440
  100a28:	8d 04 85 60 c4 12 00 	lea    0x12c460(,%eax,4),%eax
  100a2f:	c3                   	ret    

struct pmmap *
pmmap_alloc_slot(void)
{
	if (unlikely(pmmap_slots_next_free == 128))
		return NULL;
  100a30:	31 c0                	xor    %eax,%eax
	return &pmmap_slots[pmmap_slots_next_free++];
}
  100a32:	c3                   	ret    
  100a33:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100a40 <pmmap_init>:
	}
}

void
pmmap_init(uintptr_t mbi_addr)
{
  100a40:	55                   	push   %ebp
  100a41:	57                   	push   %edi
  100a42:	56                   	push   %esi
  100a43:	53                   	push   %ebx
  100a44:	83 ec 3c             	sub    $0x3c,%esp
  100a47:	8b 7c 24 50          	mov    0x50(%esp),%edi
	KERN_INFO("\n");
  100a4b:	c7 04 24 6f 92 10 00 	movl   $0x10926f,(%esp)
  100a52:	e8 99 2f 00 00       	call   1039f0 <debug_info>

	mboot_info_t *mbi = (mboot_info_t *) mbi_addr;
	mboot_mmap_t *p = (mboot_mmap_t *) mbi->mmap_addr;

	SLIST_INIT(&pmmap_list);
  100a57:	c7 05 3c c4 12 00 00 	movl   $0x0,0x12c43c
  100a5e:	00 00 00 
	SLIST_INIT(&pmmap_sublist[PMMAP_NVS]);

	/*
	 * Copy memory map information from multiboot information mbi to pmmap.
	 */
	while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  100a61:	8b 5f 2c             	mov    0x2c(%edi),%ebx
pmmap_init(uintptr_t mbi_addr)
{
	KERN_INFO("\n");

	mboot_info_t *mbi = (mboot_info_t *) mbi_addr;
	mboot_mmap_t *p = (mboot_mmap_t *) mbi->mmap_addr;
  100a64:	8b 47 30             	mov    0x30(%edi),%eax

	SLIST_INIT(&pmmap_list);
	SLIST_INIT(&pmmap_sublist[PMMAP_USABLE]);
  100a67:	c7 05 2c c4 12 00 00 	movl   $0x0,0x12c42c
  100a6e:	00 00 00 
	SLIST_INIT(&pmmap_sublist[PMMAP_RESV]);
  100a71:	c7 05 30 c4 12 00 00 	movl   $0x0,0x12c430
  100a78:	00 00 00 
	SLIST_INIT(&pmmap_sublist[PMMAP_NVS]);

	/*
	 * Copy memory map information from multiboot information mbi to pmmap.
	 */
	while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  100a7b:	85 db                	test   %ebx,%ebx
	mboot_mmap_t *p = (mboot_mmap_t *) mbi->mmap_addr;

	SLIST_INIT(&pmmap_list);
	SLIST_INIT(&pmmap_sublist[PMMAP_USABLE]);
	SLIST_INIT(&pmmap_sublist[PMMAP_RESV]);
	SLIST_INIT(&pmmap_sublist[PMMAP_ACPI]);
  100a7d:	c7 05 34 c4 12 00 00 	movl   $0x0,0x12c434
  100a84:	00 00 00 
	SLIST_INIT(&pmmap_sublist[PMMAP_NVS]);
  100a87:	c7 05 38 c4 12 00 00 	movl   $0x0,0x12c438
  100a8e:	00 00 00 

	/*
	 * Copy memory map information from multiboot information mbi to pmmap.
	 */
	while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  100a91:	0f 84 11 01 00 00    	je     100ba8 <pmmap_init+0x168>
  100a97:	8d 70 18             	lea    0x18(%eax),%esi
  100a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		uintptr_t start,end;
		uint32_t type;

		if (p->base_addr_high != 0)	/* ignore address above 4G */
  100aa0:	8b 48 08             	mov    0x8(%eax),%ecx
  100aa3:	85 c9                	test   %ecx,%ecx
  100aa5:	75 7c                	jne    100b23 <pmmap_init+0xe3>
			goto next;
		else
			start = p->base_addr_low;

		if (p->length_high != 0 ||
  100aa7:	8b 50 10             	mov    0x10(%eax),%edx
		    p->length_low >= 0xffffffff - start)
			end = 0xffffffff;
  100aaa:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
		uint32_t type;

		if (p->base_addr_high != 0)	/* ignore address above 4G */
			goto next;
		else
			start = p->base_addr_low;
  100aaf:	8b 58 04             	mov    0x4(%eax),%ebx

		if (p->length_high != 0 ||
  100ab2:	85 d2                	test   %edx,%edx
  100ab4:	75 0f                	jne    100ac5 <pmmap_init+0x85>
		    p->length_low >= 0xffffffff - start)
			end = 0xffffffff;
		else
			end = start + p->length_low;
  100ab6:	8b 50 0c             	mov    0xc(%eax),%edx
  100ab9:	89 d9                	mov    %ebx,%ecx
  100abb:	f7 d1                	not    %ecx
  100abd:	01 da                	add    %ebx,%edx
  100abf:	39 48 0c             	cmp    %ecx,0xc(%eax)
  100ac2:	0f 42 ea             	cmovb  %edx,%ebp

		type = p->type;
  100ac5:	8b 50 14             	mov    0x14(%eax),%edx
static int pmmap_nentries = 0;

struct pmmap *
pmmap_alloc_slot(void)
{
	if (unlikely(pmmap_slots_next_free == 128))
  100ac8:	a1 40 c4 12 00       	mov    0x12c440,%eax
  100acd:	3d 80 00 00 00       	cmp    $0x80,%eax
  100ad2:	0f 84 67 02 00 00    	je     100d3f <pmmap_init+0x2ff>
		return NULL;
	return &pmmap_slots[pmmap_slots_next_free++];
  100ad8:	8d 48 01             	lea    0x1(%eax),%ecx
  100adb:	8d 04 80             	lea    (%eax,%eax,4),%eax
  100ade:	89 0d 40 c4 12 00    	mov    %ecx,0x12c440
  100ae4:	8d 0c 85 60 c4 12 00 	lea    0x12c460(,%eax,4),%ecx
	if ((free_slot = pmmap_alloc_slot()) == NULL)
		KERN_PANIC("More than 128 E820 entries.\n");

	free_slot->start = start;
	free_slot->end = end;
	free_slot->type = type;
  100aeb:	89 51 08             	mov    %edx,0x8(%ecx)

	last_slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100aee:	8b 15 3c c4 12 00    	mov    0x12c43c,%edx
	struct pmmap *free_slot, *slot, *last_slot;

	if ((free_slot = pmmap_alloc_slot()) == NULL)
		KERN_PANIC("More than 128 E820 entries.\n");

	free_slot->start = start;
  100af4:	89 19                	mov    %ebx,(%ecx)
	free_slot->end = end;
  100af6:	89 69 04             	mov    %ebp,0x4(%ecx)
	free_slot->type = type;

	last_slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100af9:	85 d2                	test   %edx,%edx
  100afb:	0f 84 0e 02 00 00    	je     100d0f <pmmap_init+0x2cf>
		if (start < slot->start)
  100b01:	3b 1a                	cmp    (%edx),%ebx
  100b03:	73 11                	jae    100b16 <pmmap_init+0xd6>
  100b05:	e9 05 02 00 00       	jmp    100d0f <pmmap_init+0x2cf>
  100b0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100b10:	3b 18                	cmp    (%eax),%ebx
  100b12:	72 09                	jb     100b1d <pmmap_init+0xdd>
  100b14:	89 c2                	mov    %eax,%edx
	free_slot->end = end;
	free_slot->type = type;

	last_slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100b16:	8b 42 0c             	mov    0xc(%edx),%eax
  100b19:	85 c0                	test   %eax,%eax
  100b1b:	75 f3                	jne    100b10 <pmmap_init+0xd0>
  {
		SLIST_INSERT_HEAD(&pmmap_list, free_slot, next);
  }
	else
  {
		SLIST_INSERT_AFTER(last_slot, free_slot, next);
  100b1d:	89 41 0c             	mov    %eax,0xc(%ecx)
  100b20:	89 4a 0c             	mov    %ecx,0xc(%edx)
	SLIST_INIT(&pmmap_sublist[PMMAP_NVS]);

	/*
	 * Copy memory map information from multiboot information mbi to pmmap.
	 */
	while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  100b23:	89 f2                	mov    %esi,%edx

		pmmap_insert(start, end, type);
    //pmmap_dump();

	next:
		p = (mboot_mmap_t *) (((uint32_t) p) + sizeof(mboot_mmap_t)/* p->size */);
  100b25:	89 f0                	mov    %esi,%eax
	SLIST_INIT(&pmmap_sublist[PMMAP_NVS]);

	/*
	 * Copy memory map information from multiboot information mbi to pmmap.
	 */
	while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  100b27:	2b 57 30             	sub    0x30(%edi),%edx
  100b2a:	83 c6 18             	add    $0x18,%esi
  100b2d:	3b 57 2c             	cmp    0x2c(%edi),%edx
  100b30:	0f 82 6a ff ff ff    	jb     100aa0 <pmmap_init+0x60>
  100b36:	8b 1d 3c c4 12 00    	mov    0x12c43c,%ebx

static void
pmmap_merge(void)
{
	struct pmmap *slot, *next_slot;
	struct pmmap *last_slot[4] = { NULL, NULL, NULL, NULL };
  100b3c:	c7 44 24 20 00 00 00 	movl   $0x0,0x20(%esp)
  100b43:	00 
  100b44:	c7 44 24 24 00 00 00 	movl   $0x0,0x24(%esp)
  100b4b:	00 
  100b4c:	c7 44 24 28 00 00 00 	movl   $0x0,0x28(%esp)
  100b53:	00 
	int sublist_nr;

	/*
	 * Step 1: Merge overlaped entries in pmmap_list.
	 */
	SLIST_FOREACH(slot, &pmmap_list, next) {
  100b54:	85 db                	test   %ebx,%ebx

static void
pmmap_merge(void)
{
	struct pmmap *slot, *next_slot;
	struct pmmap *last_slot[4] = { NULL, NULL, NULL, NULL };
  100b56:	c7 44 24 2c 00 00 00 	movl   $0x0,0x2c(%esp)
  100b5d:	00 
	int sublist_nr;

	/*
	 * Step 1: Merge overlaped entries in pmmap_list.
	 */
	SLIST_FOREACH(slot, &pmmap_list, next) {
  100b5e:	74 48                	je     100ba8 <pmmap_init+0x168>
		if ((next_slot = SLIST_NEXT(slot, next)) == NULL)
  100b60:	8b 43 0c             	mov    0xc(%ebx),%eax
  100b63:	85 c0                	test   %eax,%eax
  100b65:	75 10                	jne    100b77 <pmmap_init+0x137>
  100b67:	eb 7b                	jmp    100be4 <pmmap_init+0x1a4>
  100b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100b70:	8b 43 0c             	mov    0xc(%ebx),%eax
  100b73:	85 c0                	test   %eax,%eax
  100b75:	74 20                	je     100b97 <pmmap_init+0x157>
			break;
		if (slot->start <= next_slot->start &&
  100b77:	8b 10                	mov    (%eax),%edx
  100b79:	39 13                	cmp    %edx,(%ebx)
  100b7b:	77 13                	ja     100b90 <pmmap_init+0x150>
		    slot->end >= next_slot->start &&
  100b7d:	8b 4b 04             	mov    0x4(%ebx),%ecx
	 * Step 1: Merge overlaped entries in pmmap_list.
	 */
	SLIST_FOREACH(slot, &pmmap_list, next) {
		if ((next_slot = SLIST_NEXT(slot, next)) == NULL)
			break;
		if (slot->start <= next_slot->start &&
  100b80:	39 ca                	cmp    %ecx,%edx
  100b82:	77 0c                	ja     100b90 <pmmap_init+0x150>
		    slot->end >= next_slot->start &&
  100b84:	8b 70 08             	mov    0x8(%eax),%esi
  100b87:	39 73 08             	cmp    %esi,0x8(%ebx)
  100b8a:	0f 84 8d 01 00 00    	je     100d1d <pmmap_init+0x2dd>
  100b90:	8b 5b 0c             	mov    0xc(%ebx),%ebx
	int sublist_nr;

	/*
	 * Step 1: Merge overlaped entries in pmmap_list.
	 */
	SLIST_FOREACH(slot, &pmmap_list, next) {
  100b93:	85 db                	test   %ebx,%ebx
  100b95:	75 d9                	jne    100b70 <pmmap_init+0x130>

	/*
	 * Step 2: Create the specfic lists: pmmap_usable, pmmap_resv,
	 *         pmmap_acpi, pmmap_nvs.
	 */
	SLIST_FOREACH(slot, &pmmap_list, next) {
  100b97:	8b 1d 3c c4 12 00    	mov    0x12c43c,%ebx
  100b9d:	85 db                	test   %ebx,%ebx
  100b9f:	75 43                	jne    100be4 <pmmap_init+0x1a4>
  100ba1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	SLIST_FOREACH(slot, &pmmap_list, next) {
		pmmap_nentries++;
	}

	/* Calculate the maximum page number */
	mem_npages = rounddown(max_usable_memory, PAGESIZE) / PAGESIZE;
  100ba8:	a1 28 c4 12 00       	mov    0x12c428,%eax
  100bad:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  100bb4:	00 
  100bb5:	89 04 24             	mov    %eax,(%esp)
  100bb8:	e8 93 3a 00 00       	call   104650 <rounddown>
  100bbd:	c1 e8 0c             	shr    $0xc,%eax
  100bc0:	a3 24 c4 12 00       	mov    %eax,0x12c424
}
  100bc5:	83 c4 3c             	add    $0x3c,%esp
  100bc8:	5b                   	pop    %ebx
  100bc9:	5e                   	pop    %esi
  100bca:	5f                   	pop    %edi
  100bcb:	5d                   	pop    %ebp
  100bcc:	c3                   	ret    
  100bcd:	8d 76 00             	lea    0x0(%esi),%esi
	 */
	SLIST_FOREACH(slot, &pmmap_list, next) {
		sublist_nr = PMMAP_SUBLIST_NR(slot->type);
    KERN_ASSERT(sublist_nr != -1);
		if (last_slot[sublist_nr] != NULL)
			SLIST_INSERT_AFTER(last_slot[sublist_nr], slot,
  100bd0:	8b 4a 10             	mov    0x10(%edx),%ecx
					   type_next);
		else
			SLIST_INSERT_HEAD(&pmmap_sublist[sublist_nr], slot,
					  type_next);
		last_slot[sublist_nr] = slot;
  100bd3:	89 5c 84 20          	mov    %ebx,0x20(%esp,%eax,4)
	 */
	SLIST_FOREACH(slot, &pmmap_list, next) {
		sublist_nr = PMMAP_SUBLIST_NR(slot->type);
    KERN_ASSERT(sublist_nr != -1);
		if (last_slot[sublist_nr] != NULL)
			SLIST_INSERT_AFTER(last_slot[sublist_nr], slot,
  100bd7:	89 4b 10             	mov    %ecx,0x10(%ebx)
  100bda:	89 5a 10             	mov    %ebx,0x10(%edx)

	/*
	 * Step 2: Create the specfic lists: pmmap_usable, pmmap_resv,
	 *         pmmap_acpi, pmmap_nvs.
	 */
	SLIST_FOREACH(slot, &pmmap_list, next) {
  100bdd:	8b 5b 0c             	mov    0xc(%ebx),%ebx
  100be0:	85 db                	test   %ebx,%ebx
  100be2:	74 6c                	je     100c50 <pmmap_init+0x210>
		sublist_nr = PMMAP_SUBLIST_NR(slot->type);
  100be4:	8b 53 08             	mov    0x8(%ebx),%edx
  100be7:	31 c0                	xor    %eax,%eax
  100be9:	83 fa 01             	cmp    $0x1,%edx
  100bec:	74 3e                	je     100c2c <pmmap_init+0x1ec>
  100bee:	83 fa 02             	cmp    $0x2,%edx
  100bf1:	b0 01                	mov    $0x1,%al
  100bf3:	74 37                	je     100c2c <pmmap_init+0x1ec>
  100bf5:	83 fa 03             	cmp    $0x3,%edx
  100bf8:	b0 02                	mov    $0x2,%al
  100bfa:	74 30                	je     100c2c <pmmap_init+0x1ec>
  100bfc:	83 fa 04             	cmp    $0x4,%edx
  100bff:	b0 03                	mov    $0x3,%al
  100c01:	74 29                	je     100c2c <pmmap_init+0x1ec>
    KERN_ASSERT(sublist_nr != -1);
  100c03:	c7 44 24 0c ec 7f 10 	movl   $0x107fec,0xc(%esp)
  100c0a:	00 
  100c0b:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  100c12:	00 
  100c13:	c7 44 24 04 71 00 00 	movl   $0x71,0x4(%esp)
  100c1a:	00 
  100c1b:	c7 04 24 db 7f 10 00 	movl   $0x107fdb,(%esp)
  100c22:	e8 59 2e 00 00       	call   103a80 <debug_panic>
	/*
	 * Step 2: Create the specfic lists: pmmap_usable, pmmap_resv,
	 *         pmmap_acpi, pmmap_nvs.
	 */
	SLIST_FOREACH(slot, &pmmap_list, next) {
		sublist_nr = PMMAP_SUBLIST_NR(slot->type);
  100c27:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    KERN_ASSERT(sublist_nr != -1);
		if (last_slot[sublist_nr] != NULL)
  100c2c:	8b 54 84 20          	mov    0x20(%esp,%eax,4),%edx
  100c30:	85 d2                	test   %edx,%edx
  100c32:	75 9c                	jne    100bd0 <pmmap_init+0x190>
			SLIST_INSERT_AFTER(last_slot[sublist_nr], slot,
					   type_next);
		else
			SLIST_INSERT_HEAD(&pmmap_sublist[sublist_nr], slot,
  100c34:	8b 14 85 2c c4 12 00 	mov    0x12c42c(,%eax,4),%edx
					  type_next);
		last_slot[sublist_nr] = slot;
  100c3b:	89 5c 84 20          	mov    %ebx,0x20(%esp,%eax,4)
    KERN_ASSERT(sublist_nr != -1);
		if (last_slot[sublist_nr] != NULL)
			SLIST_INSERT_AFTER(last_slot[sublist_nr], slot,
					   type_next);
		else
			SLIST_INSERT_HEAD(&pmmap_sublist[sublist_nr], slot,
  100c3f:	89 1c 85 2c c4 12 00 	mov    %ebx,0x12c42c(,%eax,4)
  100c46:	89 53 10             	mov    %edx,0x10(%ebx)

	/*
	 * Step 2: Create the specfic lists: pmmap_usable, pmmap_resv,
	 *         pmmap_acpi, pmmap_nvs.
	 */
	SLIST_FOREACH(slot, &pmmap_list, next) {
  100c49:	8b 5b 0c             	mov    0xc(%ebx),%ebx
  100c4c:	85 db                	test   %ebx,%ebx
  100c4e:	75 94                	jne    100be4 <pmmap_init+0x1a4>
  100c50:	8b 44 24 20          	mov    0x20(%esp),%eax
  100c54:	8b 1d 3c c4 12 00    	mov    0x12c43c,%ebx
			SLIST_INSERT_HEAD(&pmmap_sublist[sublist_nr], slot,
					  type_next);
		last_slot[sublist_nr] = slot;
	}

	if (last_slot[PMMAP_USABLE] != NULL)
  100c5a:	85 c0                	test   %eax,%eax
  100c5c:	74 08                	je     100c66 <pmmap_init+0x226>
		max_usable_memory = last_slot[PMMAP_USABLE]->end;
  100c5e:	8b 40 04             	mov    0x4(%eax),%eax
  100c61:	a3 28 c4 12 00       	mov    %eax,0x12c428

static void
pmmap_dump(void)
{
	struct pmmap *slot;
	SLIST_FOREACH(slot, &pmmap_list, next) {
  100c66:	85 db                	test   %ebx,%ebx
  100c68:	0f 84 3a ff ff ff    	je     100ba8 <pmmap_init+0x168>
		KERN_INFO("BIOS-e820: 0x%08x - 0x%08x (%s)\n",
  100c6e:	be 9a 7f 10 00       	mov    $0x107f9a,%esi
  100c73:	90                   	nop
  100c74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100c78:	8b 43 08             	mov    0x8(%ebx),%eax
  100c7b:	bf 93 7f 10 00       	mov    $0x107f93,%edi
  100c80:	83 f8 01             	cmp    $0x1,%eax
  100c83:	74 1f                	je     100ca4 <pmmap_init+0x264>
  100c85:	83 f8 02             	cmp    $0x2,%eax
  100c88:	bf a2 7f 10 00       	mov    $0x107fa2,%edi
  100c8d:	74 15                	je     100ca4 <pmmap_init+0x264>
  100c8f:	83 f8 03             	cmp    $0x3,%eax
  100c92:	bf ab 7f 10 00       	mov    $0x107fab,%edi
  100c97:	74 0b                	je     100ca4 <pmmap_init+0x264>
  100c99:	83 f8 04             	cmp    $0x4,%eax
  100c9c:	bf b5 7f 10 00       	mov    $0x107fb5,%edi
  100ca1:	0f 45 fe             	cmovne %esi,%edi
  100ca4:	8b 0b                	mov    (%ebx),%ecx
  100ca6:	8b 53 04             	mov    0x4(%ebx),%edx
  100ca9:	89 c8                	mov    %ecx,%eax
  100cab:	39 d1                	cmp    %edx,%ecx
  100cad:	74 0e                	je     100cbd <pmmap_init+0x27d>
  100caf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100cb4:	83 fa ff             	cmp    $0xffffffff,%edx
  100cb7:	8d 6a ff             	lea    -0x1(%edx),%ebp
  100cba:	0f 45 c5             	cmovne %ebp,%eax
  100cbd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  100cc1:	89 44 24 08          	mov    %eax,0x8(%esp)
  100cc5:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100cc9:	c7 04 24 00 80 10 00 	movl   $0x108000,(%esp)
  100cd0:	e8 1b 2d 00 00       	call   1039f0 <debug_info>

static void
pmmap_dump(void)
{
	struct pmmap *slot;
	SLIST_FOREACH(slot, &pmmap_list, next) {
  100cd5:	8b 5b 0c             	mov    0xc(%ebx),%ebx
  100cd8:	85 db                	test   %ebx,%ebx
  100cda:	75 9c                	jne    100c78 <pmmap_init+0x238>
	pmmap_merge();
	pmmap_dump();

	/* count the number of pmmap entries */
	struct pmmap *slot;
	SLIST_FOREACH(slot, &pmmap_list, next) {
  100cdc:	a1 3c c4 12 00       	mov    0x12c43c,%eax
  100ce1:	85 c0                	test   %eax,%eax
  100ce3:	0f 84 bf fe ff ff    	je     100ba8 <pmmap_init+0x168>
  100ce9:	8b 35 20 c4 12 00    	mov    0x12c420,%esi
  100cef:	8d 56 01             	lea    0x1(%esi),%edx
  100cf2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100cf8:	8b 40 0c             	mov    0xc(%eax),%eax
		pmmap_nentries++;
  100cfb:	89 d1                	mov    %edx,%ecx
  100cfd:	83 c2 01             	add    $0x1,%edx
	pmmap_merge();
	pmmap_dump();

	/* count the number of pmmap entries */
	struct pmmap *slot;
	SLIST_FOREACH(slot, &pmmap_list, next) {
  100d00:	85 c0                	test   %eax,%eax
  100d02:	75 f4                	jne    100cf8 <pmmap_init+0x2b8>
  100d04:	89 0d 20 c4 12 00    	mov    %ecx,0x12c420
  100d0a:	e9 99 fe ff ff       	jmp    100ba8 <pmmap_init+0x168>
		last_slot = slot;
	}

	if (last_slot == NULL)
  {
		SLIST_INSERT_HEAD(&pmmap_list, free_slot, next);
  100d0f:	89 51 0c             	mov    %edx,0xc(%ecx)
  100d12:	89 0d 3c c4 12 00    	mov    %ecx,0x12c43c
  100d18:	e9 06 fe ff ff       	jmp    100b23 <pmmap_init+0xe3>
		if ((next_slot = SLIST_NEXT(slot, next)) == NULL)
			break;
		if (slot->start <= next_slot->start &&
		    slot->end >= next_slot->start &&
		    slot->type == next_slot->type) {
			slot->end = max(slot->end, next_slot->end);
  100d1d:	8b 40 04             	mov    0x4(%eax),%eax
  100d20:	89 0c 24             	mov    %ecx,(%esp)
  100d23:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d27:	e8 04 39 00 00       	call   104630 <max>
  100d2c:	89 43 04             	mov    %eax,0x4(%ebx)
			SLIST_REMOVE_AFTER(slot, next);
  100d2f:	8b 43 0c             	mov    0xc(%ebx),%eax
  100d32:	8b 40 0c             	mov    0xc(%eax),%eax
  100d35:	89 43 0c             	mov    %eax,0xc(%ebx)
  100d38:	89 c3                	mov    %eax,%ebx
  100d3a:	e9 54 fe ff ff       	jmp    100b93 <pmmap_init+0x153>
pmmap_insert(uintptr_t start, uintptr_t end, uint32_t type)
{
	struct pmmap *free_slot, *slot, *last_slot;

	if ((free_slot = pmmap_alloc_slot()) == NULL)
		KERN_PANIC("More than 128 E820 entries.\n");
  100d3f:	c7 44 24 08 be 7f 10 	movl   $0x107fbe,0x8(%esp)
  100d46:	00 
  100d47:	c7 44 24 04 3e 00 00 	movl   $0x3e,0x4(%esp)
  100d4e:	00 
  100d4f:	c7 04 24 db 7f 10 00 	movl   $0x107fdb,(%esp)
  100d56:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  100d5a:	e8 21 2d 00 00       	call   103a80 <debug_panic>

struct pmmap *
pmmap_alloc_slot(void)
{
	if (unlikely(pmmap_slots_next_free == 128))
		return NULL;
  100d5f:	31 c9                	xor    %ecx,%ecx
  100d61:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  100d65:	e9 81 fd ff ff       	jmp    100aeb <pmmap_init+0xab>
  100d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00100d70 <get_size>:

int
get_size(void)
{
	return pmmap_nentries;
}
  100d70:	a1 20 c4 12 00       	mov    0x12c420,%eax
  100d75:	c3                   	ret    
  100d76:	8d 76 00             	lea    0x0(%esi),%esi
  100d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100d80 <get_mms>:
get_mms(int idx)
{
	int i = 0;
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100d80:	a1 3c c4 12 00       	mov    0x12c43c,%eax
	return pmmap_nentries;
}

uint32_t
get_mms(int idx)
{
  100d85:	8b 4c 24 04          	mov    0x4(%esp),%ecx
	int i = 0;
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100d89:	85 c0                	test   %eax,%eax
  100d8b:	74 2b                	je     100db8 <get_mms+0x38>
}

uint32_t
get_mms(int idx)
{
	int i = 0;
  100d8d:	31 d2                	xor    %edx,%edx
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
		if (i == idx)
  100d8f:	85 c9                	test   %ecx,%ecx
  100d91:	75 09                	jne    100d9c <get_mms+0x1c>
  100d93:	eb 13                	jmp    100da8 <get_mms+0x28>
  100d95:	8d 76 00             	lea    0x0(%esi),%esi
  100d98:	39 d1                	cmp    %edx,%ecx
  100d9a:	74 0c                	je     100da8 <get_mms+0x28>
get_mms(int idx)
{
	int i = 0;
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100d9c:	8b 40 0c             	mov    0xc(%eax),%eax
		if (i == idx)
			break;
		i++;
  100d9f:	83 c2 01             	add    $0x1,%edx
get_mms(int idx)
{
	int i = 0;
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100da2:	85 c0                	test   %eax,%eax
  100da4:	75 f2                	jne    100d98 <get_mms+0x18>
  100da6:	f3 c3                	repz ret 
		if (i == idx)
			break;
		i++;
	}

	if (slot == NULL || i == pmmap_nentries)
  100da8:	3b 15 20 c4 12 00    	cmp    0x12c420,%edx
  100dae:	74 08                	je     100db8 <get_mms+0x38>
		return 0;

	return slot->start;
  100db0:	8b 00                	mov    (%eax),%eax
  100db2:	c3                   	ret    
  100db3:	90                   	nop
  100db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
			break;
		i++;
	}

	if (slot == NULL || i == pmmap_nentries)
		return 0;
  100db8:	31 c0                	xor    %eax,%eax
  100dba:	c3                   	ret    
  100dbb:	90                   	nop
  100dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00100dc0 <get_mml>:
get_mml(int idx)
{
	int i = 0;
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100dc0:	8b 15 3c c4 12 00    	mov    0x12c43c,%edx
	return slot->start;
}

uint32_t
get_mml(int idx)
{
  100dc6:	8b 4c 24 04          	mov    0x4(%esp),%ecx
	int i = 0;
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100dca:	85 d2                	test   %edx,%edx
  100dcc:	74 18                	je     100de6 <get_mml+0x26>
}

uint32_t
get_mml(int idx)
{
	int i = 0;
  100dce:	31 c0                	xor    %eax,%eax
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
		if (i == idx)
  100dd0:	85 c9                	test   %ecx,%ecx
  100dd2:	75 08                	jne    100ddc <get_mml+0x1c>
  100dd4:	eb 1a                	jmp    100df0 <get_mml+0x30>
  100dd6:	66 90                	xchg   %ax,%ax
  100dd8:	39 c1                	cmp    %eax,%ecx
  100dda:	74 14                	je     100df0 <get_mml+0x30>
get_mml(int idx)
{
	int i = 0;
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100ddc:	8b 52 0c             	mov    0xc(%edx),%edx
		if (i == idx)
			break;
		i++;
  100ddf:	83 c0 01             	add    $0x1,%eax
get_mml(int idx)
{
	int i = 0;
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100de2:	85 d2                	test   %edx,%edx
  100de4:	75 f2                	jne    100dd8 <get_mml+0x18>
			break;
		i++;
	}

	if (slot == NULL || i == pmmap_nentries)
		return 0;
  100de6:	31 c0                	xor    %eax,%eax
  100de8:	c3                   	ret    
  100de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		if (i == idx)
			break;
		i++;
	}

	if (slot == NULL || i == pmmap_nentries)
  100df0:	3b 05 20 c4 12 00    	cmp    0x12c420,%eax
  100df6:	74 ee                	je     100de6 <get_mml+0x26>
		return 0;

	return slot->end - slot->start;
  100df8:	8b 42 04             	mov    0x4(%edx),%eax
  100dfb:	2b 02                	sub    (%edx),%eax
  100dfd:	c3                   	ret    
  100dfe:	66 90                	xchg   %ax,%ax

00100e00 <is_usable>:
is_usable(int idx)
{
	int i = 0;
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100e00:	a1 3c c4 12 00       	mov    0x12c43c,%eax
	return slot->end - slot->start;
}

int
is_usable(int idx)
{
  100e05:	8b 4c 24 04          	mov    0x4(%esp),%ecx
	int i = 0;
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100e09:	85 c0                	test   %eax,%eax
  100e0b:	74 33                	je     100e40 <is_usable+0x40>
}

int
is_usable(int idx)
{
	int i = 0;
  100e0d:	31 d2                	xor    %edx,%edx
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
		if (i == idx)
  100e0f:	85 c9                	test   %ecx,%ecx
  100e11:	75 09                	jne    100e1c <is_usable+0x1c>
  100e13:	eb 13                	jmp    100e28 <is_usable+0x28>
  100e15:	8d 76 00             	lea    0x0(%esi),%esi
  100e18:	39 d1                	cmp    %edx,%ecx
  100e1a:	74 0c                	je     100e28 <is_usable+0x28>
is_usable(int idx)
{
	int i = 0;
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100e1c:	8b 40 0c             	mov    0xc(%eax),%eax
		if (i == idx)
			break;
		i++;
  100e1f:	83 c2 01             	add    $0x1,%edx
is_usable(int idx)
{
	int i = 0;
	struct pmmap *slot = NULL;

	SLIST_FOREACH(slot, &pmmap_list, next) {
  100e22:	85 c0                	test   %eax,%eax
  100e24:	75 f2                	jne    100e18 <is_usable+0x18>
  100e26:	f3 c3                	repz ret 
		if (i == idx)
			break;
		i++;
	}

	if (slot == NULL || i == pmmap_nentries)
  100e28:	3b 15 20 c4 12 00    	cmp    0x12c420,%edx
  100e2e:	74 10                	je     100e40 <is_usable+0x40>
		return 0;

	return slot->type == MEM_RAM;
  100e30:	83 78 08 01          	cmpl   $0x1,0x8(%eax)
  100e34:	0f 94 c0             	sete   %al
  100e37:	0f b6 c0             	movzbl %al,%eax
  100e3a:	c3                   	ret    
  100e3b:	90                   	nop
  100e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
			break;
		i++;
	}

	if (slot == NULL || i == pmmap_nentries)
		return 0;
  100e40:	31 c0                	xor    %eax,%eax
  100e42:	c3                   	ret    
  100e43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100e50 <set_cr3>:
}

void
set_cr3(char **pdir)
{
	lcr3((uint32_t) pdir);
  100e50:	e9 8b 3a 00 00       	jmp    1048e0 <lcr3>
  100e55:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100e60 <enable_paging>:
}

void
enable_paging(void)
{
  100e60:	83 ec 1c             	sub    $0x1c,%esp
	/* enable global pages (Sec 4.10.2.4, Intel ASDM Vol3) */
	uint32_t cr4 = rcr4();
  100e63:	e8 98 3a 00 00       	call   104900 <rcr4>
	cr4 |= CR4_PGE;
  100e68:	0c 80                	or     $0x80,%al
	lcr4(cr4);
  100e6a:	89 04 24             	mov    %eax,(%esp)
  100e6d:	e8 7e 3a 00 00       	call   1048f0 <lcr4>

	/* turn on paging */
	uint32_t cr0 = rcr0();
  100e72:	e8 49 3a 00 00       	call   1048c0 <rcr0>
	cr0 |= CR0_PE | CR0_PG | CR0_AM | CR0_WP | CR0_NE | CR0_MP;
	cr0 &= ~(CR0_EM | CR0_TS);
  100e77:	83 e0 f3             	and    $0xfffffff3,%eax
  100e7a:	0d 23 00 05 80       	or     $0x80050023,%eax
	lcr0(cr0);
  100e7f:	89 04 24             	mov    %eax,(%esp)
  100e82:	e8 29 3a 00 00       	call   1048b0 <lcr0>
}
  100e87:	83 c4 1c             	add    $0x1c,%esp
  100e8a:	c3                   	ret    
  100e8b:	66 90                	xchg   %ax,%ax
  100e8d:	66 90                	xchg   %ax,%ax
  100e8f:	90                   	nop

00100e90 <intr_init>:
	asm volatile("lidt %0" : : "m" (idt_pd));
}

void
intr_init(void)
{
  100e90:	56                   	push   %esi
  100e91:	53                   	push   %ebx
  100e92:	83 ec 34             	sub    $0x34,%esp
  pic_init();
  100e95:	e8 16 09 00 00       	call   1017b0 <pic_init>

  uint32_t dummy, edx;
  cpuid(0x00000001, &dummy, &dummy, &dummy, &edx);
  100e9a:	8d 44 24 2c          	lea    0x2c(%esp),%eax
  100e9e:	89 44 24 10          	mov    %eax,0x10(%esp)
  100ea2:	8d 44 24 28          	lea    0x28(%esp),%eax
  100ea6:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100eaa:	89 44 24 08          	mov    %eax,0x8(%esp)
  100eae:	89 44 24 04          	mov    %eax,0x4(%esp)
  100eb2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  100eb9:	e8 b2 38 00 00       	call   104770 <cpuid>
  using_apic = (edx & CPUID_FEATURE_APIC) ? TRUE : FALSE;
  100ebe:	8b 44 24 2c          	mov    0x2c(%esp),%eax
  100ec2:	c1 e8 09             	shr    $0x9,%eax
  100ec5:	83 e0 01             	and    $0x1,%eax
  100ec8:	a2 61 ce 12 00       	mov    %al,0x12ce61
  KERN_ASSERT(using_apic == TRUE);
  100ecd:	0f b6 05 61 ce 12 00 	movzbl 0x12ce61,%eax
  100ed4:	3c 01                	cmp    $0x1,%al
  100ed6:	74 24                	je     100efc <intr_init+0x6c>
  100ed8:	c7 44 24 0c 21 80 10 	movl   $0x108021,0xc(%esp)
  100edf:	00 
  100ee0:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  100ee7:	00 
  100ee8:	c7 44 24 04 5f 00 00 	movl   $0x5f,0x4(%esp)
  100eef:	00 
  100ef0:	c7 04 24 34 80 10 00 	movl   $0x108034,(%esp)
  100ef7:	e8 84 2b 00 00       	call   103a80 <debug_panic>

	if (using_apic == TRUE){
  100efc:	0f b6 05 61 ce 12 00 	movzbl 0x12ce61,%eax
  100f03:	3c 01                	cmp    $0x1,%al
  100f05:	0f 84 a1 06 00 00    	je     1015ac <intr_init+0x71c>
  100f0b:	bb 0a 20 10 00       	mov    $0x10200a,%ebx
	asm volatile("lidt %0" : : "m" (idt_pd));
}

void
intr_init(void)
{
  100f10:	31 c0                	xor    %eax,%eax
  100f12:	89 de                	mov    %ebx,%esi
  100f14:	89 d9                	mov    %ebx,%ecx
  100f16:	c1 ee 10             	shr    $0x10,%esi
  100f19:	89 f2                	mov    %esi,%edx
  100f1b:	90                   	nop
  100f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	/* check that T_IRQ0 is a multiple of 8 */
	KERN_ASSERT((T_IRQ0 & 7) == 0);

	/* install a default handler */
	for (i = 0; i < sizeof(idt)/sizeof(idt[0]); i++)
		SETGATE(idt[i], 0, CPU_GDT_KCODE, &Xdefault, 0);
  100f20:	66 89 0c c5 00 80 9b 	mov    %cx,0x9b8000(,%eax,8)
  100f27:	00 
  100f28:	66 c7 04 c5 02 80 9b 	movw   $0x8,0x9b8002(,%eax,8)
  100f2f:	00 08 00 
  100f32:	c6 04 c5 04 80 9b 00 	movb   $0x0,0x9b8004(,%eax,8)
  100f39:	00 
  100f3a:	c6 04 c5 05 80 9b 00 	movb   $0x8e,0x9b8005(,%eax,8)
  100f41:	8e 
  100f42:	66 89 14 c5 06 80 9b 	mov    %dx,0x9b8006(,%eax,8)
  100f49:	00 

	/* check that T_IRQ0 is a multiple of 8 */
	KERN_ASSERT((T_IRQ0 & 7) == 0);

	/* install a default handler */
	for (i = 0; i < sizeof(idt)/sizeof(idt[0]); i++)
  100f4a:	83 c0 01             	add    $0x1,%eax
  100f4d:	3d 00 01 00 00       	cmp    $0x100,%eax
  100f52:	75 cc                	jne    100f20 <intr_init+0x90>
		SETGATE(idt[i], 0, CPU_GDT_KCODE, &Xdefault, 0);

	SETGATE(idt[T_DIVIDE],            0, CPU_GDT_KCODE, &Xdivide,       0);
  100f54:	b8 b0 1e 10 00       	mov    $0x101eb0,%eax
  100f59:	ba 08 00 00 00       	mov    $0x8,%edx
  100f5e:	66 a3 00 80 9b 00    	mov    %ax,0x9b8000
  100f64:	c1 e8 10             	shr    $0x10,%eax
	SETGATE(idt[T_DEBUG],             0, CPU_GDT_KCODE, &Xdebug,        0);
  100f67:	b9 08 00 00 00       	mov    $0x8,%ecx

	/* install a default handler */
	for (i = 0; i < sizeof(idt)/sizeof(idt[0]); i++)
		SETGATE(idt[i], 0, CPU_GDT_KCODE, &Xdefault, 0);

	SETGATE(idt[T_DIVIDE],            0, CPU_GDT_KCODE, &Xdivide,       0);
  100f6c:	66 a3 06 80 9b 00    	mov    %ax,0x9b8006
	SETGATE(idt[T_DEBUG],             0, CPU_GDT_KCODE, &Xdebug,        0);
  100f72:	b8 ba 1e 10 00       	mov    $0x101eba,%eax
  100f77:	66 a3 08 80 9b 00    	mov    %ax,0x9b8008
  100f7d:	c1 e8 10             	shr    $0x10,%eax
  100f80:	66 a3 0e 80 9b 00    	mov    %ax,0x9b800e
	SETGATE(idt[T_NMI],               0, CPU_GDT_KCODE, &Xnmi,          0);
  100f86:	b8 c4 1e 10 00       	mov    $0x101ec4,%eax
  100f8b:	66 a3 10 80 9b 00    	mov    %ax,0x9b8010
  100f91:	c1 e8 10             	shr    $0x10,%eax
  100f94:	66 a3 16 80 9b 00    	mov    %ax,0x9b8016
	SETGATE(idt[T_BRKPT],             0, CPU_GDT_KCODE, &Xbrkpt,        3);
  100f9a:	b8 ce 1e 10 00       	mov    $0x101ece,%eax
  100f9f:	66 a3 18 80 9b 00    	mov    %ax,0x9b8018
  100fa5:	c1 e8 10             	shr    $0x10,%eax
  100fa8:	66 a3 1e 80 9b 00    	mov    %ax,0x9b801e
	SETGATE(idt[T_OFLOW],             0, CPU_GDT_KCODE, &Xoflow,        3);
  100fae:	b8 d8 1e 10 00       	mov    $0x101ed8,%eax
  100fb3:	66 a3 20 80 9b 00    	mov    %ax,0x9b8020
  100fb9:	c1 e8 10             	shr    $0x10,%eax
  100fbc:	66 a3 26 80 9b 00    	mov    %ax,0x9b8026
	SETGATE(idt[T_BOUND],             0, CPU_GDT_KCODE, &Xbound,        0);
  100fc2:	b8 e2 1e 10 00       	mov    $0x101ee2,%eax

	/* install a default handler */
	for (i = 0; i < sizeof(idt)/sizeof(idt[0]); i++)
		SETGATE(idt[i], 0, CPU_GDT_KCODE, &Xdefault, 0);

	SETGATE(idt[T_DIVIDE],            0, CPU_GDT_KCODE, &Xdivide,       0);
  100fc7:	66 89 15 02 80 9b 00 	mov    %dx,0x9b8002
	SETGATE(idt[T_DEBUG],             0, CPU_GDT_KCODE, &Xdebug,        0);
	SETGATE(idt[T_NMI],               0, CPU_GDT_KCODE, &Xnmi,          0);
  100fce:	ba 08 00 00 00       	mov    $0x8,%edx
	SETGATE(idt[T_BRKPT],             0, CPU_GDT_KCODE, &Xbrkpt,        3);
	SETGATE(idt[T_OFLOW],             0, CPU_GDT_KCODE, &Xoflow,        3);
	SETGATE(idt[T_BOUND],             0, CPU_GDT_KCODE, &Xbound,        0);
  100fd3:	66 a3 28 80 9b 00    	mov    %ax,0x9b8028
  100fd9:	c1 e8 10             	shr    $0x10,%eax
	/* install a default handler */
	for (i = 0; i < sizeof(idt)/sizeof(idt[0]); i++)
		SETGATE(idt[i], 0, CPU_GDT_KCODE, &Xdefault, 0);

	SETGATE(idt[T_DIVIDE],            0, CPU_GDT_KCODE, &Xdivide,       0);
	SETGATE(idt[T_DEBUG],             0, CPU_GDT_KCODE, &Xdebug,        0);
  100fdc:	66 89 0d 0a 80 9b 00 	mov    %cx,0x9b800a
	SETGATE(idt[T_NMI],               0, CPU_GDT_KCODE, &Xnmi,          0);
	SETGATE(idt[T_BRKPT],             0, CPU_GDT_KCODE, &Xbrkpt,        3);
  100fe3:	b9 08 00 00 00       	mov    $0x8,%ecx
	for (i = 0; i < sizeof(idt)/sizeof(idt[0]); i++)
		SETGATE(idt[i], 0, CPU_GDT_KCODE, &Xdefault, 0);

	SETGATE(idt[T_DIVIDE],            0, CPU_GDT_KCODE, &Xdivide,       0);
	SETGATE(idt[T_DEBUG],             0, CPU_GDT_KCODE, &Xdebug,        0);
	SETGATE(idt[T_NMI],               0, CPU_GDT_KCODE, &Xnmi,          0);
  100fe8:	66 89 15 12 80 9b 00 	mov    %dx,0x9b8012
	SETGATE(idt[T_BRKPT],             0, CPU_GDT_KCODE, &Xbrkpt,        3);
	SETGATE(idt[T_OFLOW],             0, CPU_GDT_KCODE, &Xoflow,        3);
  100fef:	ba 08 00 00 00       	mov    $0x8,%edx
	SETGATE(idt[T_BOUND],             0, CPU_GDT_KCODE, &Xbound,        0);
  100ff4:	66 a3 2e 80 9b 00    	mov    %ax,0x9b802e
	SETGATE(idt[T_ILLOP],             0, CPU_GDT_KCODE, &Xillop,        0);
  100ffa:	b8 ec 1e 10 00       	mov    $0x101eec,%eax
		SETGATE(idt[i], 0, CPU_GDT_KCODE, &Xdefault, 0);

	SETGATE(idt[T_DIVIDE],            0, CPU_GDT_KCODE, &Xdivide,       0);
	SETGATE(idt[T_DEBUG],             0, CPU_GDT_KCODE, &Xdebug,        0);
	SETGATE(idt[T_NMI],               0, CPU_GDT_KCODE, &Xnmi,          0);
	SETGATE(idt[T_BRKPT],             0, CPU_GDT_KCODE, &Xbrkpt,        3);
  100fff:	66 89 0d 1a 80 9b 00 	mov    %cx,0x9b801a
	SETGATE(idt[T_OFLOW],             0, CPU_GDT_KCODE, &Xoflow,        3);
	SETGATE(idt[T_BOUND],             0, CPU_GDT_KCODE, &Xbound,        0);
  101006:	b9 08 00 00 00       	mov    $0x8,%ecx

	SETGATE(idt[T_DIVIDE],            0, CPU_GDT_KCODE, &Xdivide,       0);
	SETGATE(idt[T_DEBUG],             0, CPU_GDT_KCODE, &Xdebug,        0);
	SETGATE(idt[T_NMI],               0, CPU_GDT_KCODE, &Xnmi,          0);
	SETGATE(idt[T_BRKPT],             0, CPU_GDT_KCODE, &Xbrkpt,        3);
	SETGATE(idt[T_OFLOW],             0, CPU_GDT_KCODE, &Xoflow,        3);
  10100b:	66 89 15 22 80 9b 00 	mov    %dx,0x9b8022
	SETGATE(idt[T_BOUND],             0, CPU_GDT_KCODE, &Xbound,        0);
	SETGATE(idt[T_ILLOP],             0, CPU_GDT_KCODE, &Xillop,        0);
  101012:	ba 08 00 00 00       	mov    $0x8,%edx
  101017:	66 a3 30 80 9b 00    	mov    %ax,0x9b8030
  10101d:	c1 e8 10             	shr    $0x10,%eax
	SETGATE(idt[T_DIVIDE],            0, CPU_GDT_KCODE, &Xdivide,       0);
	SETGATE(idt[T_DEBUG],             0, CPU_GDT_KCODE, &Xdebug,        0);
	SETGATE(idt[T_NMI],               0, CPU_GDT_KCODE, &Xnmi,          0);
	SETGATE(idt[T_BRKPT],             0, CPU_GDT_KCODE, &Xbrkpt,        3);
	SETGATE(idt[T_OFLOW],             0, CPU_GDT_KCODE, &Xoflow,        3);
	SETGATE(idt[T_BOUND],             0, CPU_GDT_KCODE, &Xbound,        0);
  101020:	66 89 0d 2a 80 9b 00 	mov    %cx,0x9b802a
	SETGATE(idt[T_ILLOP],             0, CPU_GDT_KCODE, &Xillop,        0);
	SETGATE(idt[T_DEVICE],            0, CPU_GDT_KCODE, &Xdevice,       0);
  101027:	b9 08 00 00 00       	mov    $0x8,%ecx
	SETGATE(idt[T_DEBUG],             0, CPU_GDT_KCODE, &Xdebug,        0);
	SETGATE(idt[T_NMI],               0, CPU_GDT_KCODE, &Xnmi,          0);
	SETGATE(idt[T_BRKPT],             0, CPU_GDT_KCODE, &Xbrkpt,        3);
	SETGATE(idt[T_OFLOW],             0, CPU_GDT_KCODE, &Xoflow,        3);
	SETGATE(idt[T_BOUND],             0, CPU_GDT_KCODE, &Xbound,        0);
	SETGATE(idt[T_ILLOP],             0, CPU_GDT_KCODE, &Xillop,        0);
  10102c:	66 89 15 32 80 9b 00 	mov    %dx,0x9b8032
	SETGATE(idt[T_DEVICE],            0, CPU_GDT_KCODE, &Xdevice,       0);
	SETGATE(idt[T_DBLFLT],            0, CPU_GDT_KCODE, &Xdblflt,       0);
  101033:	ba 08 00 00 00       	mov    $0x8,%edx

	/* install a default handler */
	for (i = 0; i < sizeof(idt)/sizeof(idt[0]); i++)
		SETGATE(idt[i], 0, CPU_GDT_KCODE, &Xdefault, 0);

	SETGATE(idt[T_DIVIDE],            0, CPU_GDT_KCODE, &Xdivide,       0);
  101038:	c6 05 04 80 9b 00 00 	movb   $0x0,0x9b8004
  10103f:	c6 05 05 80 9b 00 8e 	movb   $0x8e,0x9b8005
	SETGATE(idt[T_DEBUG],             0, CPU_GDT_KCODE, &Xdebug,        0);
  101046:	c6 05 0c 80 9b 00 00 	movb   $0x0,0x9b800c
  10104d:	c6 05 0d 80 9b 00 8e 	movb   $0x8e,0x9b800d
	SETGATE(idt[T_NMI],               0, CPU_GDT_KCODE, &Xnmi,          0);
  101054:	c6 05 14 80 9b 00 00 	movb   $0x0,0x9b8014
  10105b:	c6 05 15 80 9b 00 8e 	movb   $0x8e,0x9b8015
	SETGATE(idt[T_BRKPT],             0, CPU_GDT_KCODE, &Xbrkpt,        3);
  101062:	c6 05 1c 80 9b 00 00 	movb   $0x0,0x9b801c
  101069:	c6 05 1d 80 9b 00 ee 	movb   $0xee,0x9b801d
	SETGATE(idt[T_OFLOW],             0, CPU_GDT_KCODE, &Xoflow,        3);
  101070:	c6 05 24 80 9b 00 00 	movb   $0x0,0x9b8024
  101077:	c6 05 25 80 9b 00 ee 	movb   $0xee,0x9b8025
	SETGATE(idt[T_BOUND],             0, CPU_GDT_KCODE, &Xbound,        0);
  10107e:	c6 05 2c 80 9b 00 00 	movb   $0x0,0x9b802c
  101085:	c6 05 2d 80 9b 00 8e 	movb   $0x8e,0x9b802d
	SETGATE(idt[T_ILLOP],             0, CPU_GDT_KCODE, &Xillop,        0);
  10108c:	c6 05 34 80 9b 00 00 	movb   $0x0,0x9b8034
  101093:	c6 05 35 80 9b 00 8e 	movb   $0x8e,0x9b8035
  10109a:	66 a3 36 80 9b 00    	mov    %ax,0x9b8036
	SETGATE(idt[T_DEVICE],            0, CPU_GDT_KCODE, &Xdevice,       0);
  1010a0:	b8 f6 1e 10 00       	mov    $0x101ef6,%eax
  1010a5:	66 a3 38 80 9b 00    	mov    %ax,0x9b8038
  1010ab:	c1 e8 10             	shr    $0x10,%eax
  1010ae:	66 a3 3e 80 9b 00    	mov    %ax,0x9b803e
	SETGATE(idt[T_DBLFLT],            0, CPU_GDT_KCODE, &Xdblflt,       0);
  1010b4:	b8 00 1f 10 00       	mov    $0x101f00,%eax
  1010b9:	66 a3 40 80 9b 00    	mov    %ax,0x9b8040
  1010bf:	c1 e8 10             	shr    $0x10,%eax
  1010c2:	66 a3 46 80 9b 00    	mov    %ax,0x9b8046
	SETGATE(idt[T_TSS],               0, CPU_GDT_KCODE, &Xtss,          0);
  1010c8:	b8 12 1f 10 00       	mov    $0x101f12,%eax
  1010cd:	66 a3 50 80 9b 00    	mov    %ax,0x9b8050
  1010d3:	c1 e8 10             	shr    $0x10,%eax
  1010d6:	66 a3 56 80 9b 00    	mov    %ax,0x9b8056
	SETGATE(idt[T_SEGNP],             0, CPU_GDT_KCODE, &Xsegnp,        0);
  1010dc:	b8 1a 1f 10 00       	mov    $0x101f1a,%eax
  1010e1:	66 a3 58 80 9b 00    	mov    %ax,0x9b8058
  1010e7:	c1 e8 10             	shr    $0x10,%eax
  1010ea:	66 a3 5e 80 9b 00    	mov    %ax,0x9b805e
	SETGATE(idt[T_STACK],             0, CPU_GDT_KCODE, &Xstack,        0);
  1010f0:	b8 22 1f 10 00       	mov    $0x101f22,%eax
  1010f5:	66 a3 60 80 9b 00    	mov    %ax,0x9b8060
  1010fb:	c1 e8 10             	shr    $0x10,%eax
  1010fe:	66 a3 66 80 9b 00    	mov    %ax,0x9b8066
	SETGATE(idt[T_GPFLT],             0, CPU_GDT_KCODE, &Xgpflt,        0);
  101104:	b8 2a 1f 10 00       	mov    $0x101f2a,%eax
	SETGATE(idt[T_NMI],               0, CPU_GDT_KCODE, &Xnmi,          0);
	SETGATE(idt[T_BRKPT],             0, CPU_GDT_KCODE, &Xbrkpt,        3);
	SETGATE(idt[T_OFLOW],             0, CPU_GDT_KCODE, &Xoflow,        3);
	SETGATE(idt[T_BOUND],             0, CPU_GDT_KCODE, &Xbound,        0);
	SETGATE(idt[T_ILLOP],             0, CPU_GDT_KCODE, &Xillop,        0);
	SETGATE(idt[T_DEVICE],            0, CPU_GDT_KCODE, &Xdevice,       0);
  101109:	66 89 0d 3a 80 9b 00 	mov    %cx,0x9b803a
	SETGATE(idt[T_DBLFLT],            0, CPU_GDT_KCODE, &Xdblflt,       0);
	SETGATE(idt[T_TSS],               0, CPU_GDT_KCODE, &Xtss,          0);
  101110:	b9 08 00 00 00       	mov    $0x8,%ecx
	SETGATE(idt[T_SEGNP],             0, CPU_GDT_KCODE, &Xsegnp,        0);
	SETGATE(idt[T_STACK],             0, CPU_GDT_KCODE, &Xstack,        0);
	SETGATE(idt[T_GPFLT],             0, CPU_GDT_KCODE, &Xgpflt,        0);
  101115:	66 a3 68 80 9b 00    	mov    %ax,0x9b8068
  10111b:	c1 e8 10             	shr    $0x10,%eax
	SETGATE(idt[T_BRKPT],             0, CPU_GDT_KCODE, &Xbrkpt,        3);
	SETGATE(idt[T_OFLOW],             0, CPU_GDT_KCODE, &Xoflow,        3);
	SETGATE(idt[T_BOUND],             0, CPU_GDT_KCODE, &Xbound,        0);
	SETGATE(idt[T_ILLOP],             0, CPU_GDT_KCODE, &Xillop,        0);
	SETGATE(idt[T_DEVICE],            0, CPU_GDT_KCODE, &Xdevice,       0);
	SETGATE(idt[T_DBLFLT],            0, CPU_GDT_KCODE, &Xdblflt,       0);
  10111e:	66 89 15 42 80 9b 00 	mov    %dx,0x9b8042
	SETGATE(idt[T_TSS],               0, CPU_GDT_KCODE, &Xtss,          0);
	SETGATE(idt[T_SEGNP],             0, CPU_GDT_KCODE, &Xsegnp,        0);
  101125:	ba 08 00 00 00       	mov    $0x8,%edx
	SETGATE(idt[T_OFLOW],             0, CPU_GDT_KCODE, &Xoflow,        3);
	SETGATE(idt[T_BOUND],             0, CPU_GDT_KCODE, &Xbound,        0);
	SETGATE(idt[T_ILLOP],             0, CPU_GDT_KCODE, &Xillop,        0);
	SETGATE(idt[T_DEVICE],            0, CPU_GDT_KCODE, &Xdevice,       0);
	SETGATE(idt[T_DBLFLT],            0, CPU_GDT_KCODE, &Xdblflt,       0);
	SETGATE(idt[T_TSS],               0, CPU_GDT_KCODE, &Xtss,          0);
  10112a:	66 89 0d 52 80 9b 00 	mov    %cx,0x9b8052
	SETGATE(idt[T_SEGNP],             0, CPU_GDT_KCODE, &Xsegnp,        0);
	SETGATE(idt[T_STACK],             0, CPU_GDT_KCODE, &Xstack,        0);
  101131:	b9 08 00 00 00       	mov    $0x8,%ecx
	SETGATE(idt[T_GPFLT],             0, CPU_GDT_KCODE, &Xgpflt,        0);
  101136:	66 a3 6e 80 9b 00    	mov    %ax,0x9b806e
	SETGATE(idt[T_PGFLT],             0, CPU_GDT_KCODE, &Xpgflt,        0);
  10113c:	b8 32 1f 10 00       	mov    $0x101f32,%eax
	SETGATE(idt[T_BOUND],             0, CPU_GDT_KCODE, &Xbound,        0);
	SETGATE(idt[T_ILLOP],             0, CPU_GDT_KCODE, &Xillop,        0);
	SETGATE(idt[T_DEVICE],            0, CPU_GDT_KCODE, &Xdevice,       0);
	SETGATE(idt[T_DBLFLT],            0, CPU_GDT_KCODE, &Xdblflt,       0);
	SETGATE(idt[T_TSS],               0, CPU_GDT_KCODE, &Xtss,          0);
	SETGATE(idt[T_SEGNP],             0, CPU_GDT_KCODE, &Xsegnp,        0);
  101141:	66 89 15 5a 80 9b 00 	mov    %dx,0x9b805a
	SETGATE(idt[T_STACK],             0, CPU_GDT_KCODE, &Xstack,        0);
	SETGATE(idt[T_GPFLT],             0, CPU_GDT_KCODE, &Xgpflt,        0);
  101148:	ba 08 00 00 00       	mov    $0x8,%edx
	SETGATE(idt[T_ILLOP],             0, CPU_GDT_KCODE, &Xillop,        0);
	SETGATE(idt[T_DEVICE],            0, CPU_GDT_KCODE, &Xdevice,       0);
	SETGATE(idt[T_DBLFLT],            0, CPU_GDT_KCODE, &Xdblflt,       0);
	SETGATE(idt[T_TSS],               0, CPU_GDT_KCODE, &Xtss,          0);
	SETGATE(idt[T_SEGNP],             0, CPU_GDT_KCODE, &Xsegnp,        0);
	SETGATE(idt[T_STACK],             0, CPU_GDT_KCODE, &Xstack,        0);
  10114d:	66 89 0d 62 80 9b 00 	mov    %cx,0x9b8062
	SETGATE(idt[T_GPFLT],             0, CPU_GDT_KCODE, &Xgpflt,        0);
	SETGATE(idt[T_PGFLT],             0, CPU_GDT_KCODE, &Xpgflt,        0);
  101154:	b9 08 00 00 00       	mov    $0x8,%ecx
  101159:	66 a3 70 80 9b 00    	mov    %ax,0x9b8070
  10115f:	c1 e8 10             	shr    $0x10,%eax
	SETGATE(idt[T_DEVICE],            0, CPU_GDT_KCODE, &Xdevice,       0);
	SETGATE(idt[T_DBLFLT],            0, CPU_GDT_KCODE, &Xdblflt,       0);
	SETGATE(idt[T_TSS],               0, CPU_GDT_KCODE, &Xtss,          0);
	SETGATE(idt[T_SEGNP],             0, CPU_GDT_KCODE, &Xsegnp,        0);
	SETGATE(idt[T_STACK],             0, CPU_GDT_KCODE, &Xstack,        0);
	SETGATE(idt[T_GPFLT],             0, CPU_GDT_KCODE, &Xgpflt,        0);
  101162:	66 89 15 6a 80 9b 00 	mov    %dx,0x9b806a
	SETGATE(idt[T_PGFLT],             0, CPU_GDT_KCODE, &Xpgflt,        0);
	SETGATE(idt[T_FPERR],             0, CPU_GDT_KCODE, &Xfperr,        0);
  101169:	ba 08 00 00 00       	mov    $0x8,%edx
	SETGATE(idt[T_DBLFLT],            0, CPU_GDT_KCODE, &Xdblflt,       0);
	SETGATE(idt[T_TSS],               0, CPU_GDT_KCODE, &Xtss,          0);
	SETGATE(idt[T_SEGNP],             0, CPU_GDT_KCODE, &Xsegnp,        0);
	SETGATE(idt[T_STACK],             0, CPU_GDT_KCODE, &Xstack,        0);
	SETGATE(idt[T_GPFLT],             0, CPU_GDT_KCODE, &Xgpflt,        0);
	SETGATE(idt[T_PGFLT],             0, CPU_GDT_KCODE, &Xpgflt,        0);
  10116e:	66 89 0d 72 80 9b 00 	mov    %cx,0x9b8072
	SETGATE(idt[T_FPERR],             0, CPU_GDT_KCODE, &Xfperr,        0);
	SETGATE(idt[T_ALIGN],             0, CPU_GDT_KCODE, &Xalign,        0);
  101175:	b9 08 00 00 00       	mov    $0x8,%ecx
	SETGATE(idt[T_NMI],               0, CPU_GDT_KCODE, &Xnmi,          0);
	SETGATE(idt[T_BRKPT],             0, CPU_GDT_KCODE, &Xbrkpt,        3);
	SETGATE(idt[T_OFLOW],             0, CPU_GDT_KCODE, &Xoflow,        3);
	SETGATE(idt[T_BOUND],             0, CPU_GDT_KCODE, &Xbound,        0);
	SETGATE(idt[T_ILLOP],             0, CPU_GDT_KCODE, &Xillop,        0);
	SETGATE(idt[T_DEVICE],            0, CPU_GDT_KCODE, &Xdevice,       0);
  10117a:	c6 05 3c 80 9b 00 00 	movb   $0x0,0x9b803c
  101181:	c6 05 3d 80 9b 00 8e 	movb   $0x8e,0x9b803d
	SETGATE(idt[T_DBLFLT],            0, CPU_GDT_KCODE, &Xdblflt,       0);
  101188:	c6 05 44 80 9b 00 00 	movb   $0x0,0x9b8044
  10118f:	c6 05 45 80 9b 00 8e 	movb   $0x8e,0x9b8045
	SETGATE(idt[T_TSS],               0, CPU_GDT_KCODE, &Xtss,          0);
  101196:	c6 05 54 80 9b 00 00 	movb   $0x0,0x9b8054
  10119d:	c6 05 55 80 9b 00 8e 	movb   $0x8e,0x9b8055
	SETGATE(idt[T_SEGNP],             0, CPU_GDT_KCODE, &Xsegnp,        0);
  1011a4:	c6 05 5c 80 9b 00 00 	movb   $0x0,0x9b805c
  1011ab:	c6 05 5d 80 9b 00 8e 	movb   $0x8e,0x9b805d
	SETGATE(idt[T_STACK],             0, CPU_GDT_KCODE, &Xstack,        0);
  1011b2:	c6 05 64 80 9b 00 00 	movb   $0x0,0x9b8064
  1011b9:	c6 05 65 80 9b 00 8e 	movb   $0x8e,0x9b8065
	SETGATE(idt[T_GPFLT],             0, CPU_GDT_KCODE, &Xgpflt,        0);
  1011c0:	c6 05 6c 80 9b 00 00 	movb   $0x0,0x9b806c
  1011c7:	c6 05 6d 80 9b 00 8e 	movb   $0x8e,0x9b806d
	SETGATE(idt[T_PGFLT],             0, CPU_GDT_KCODE, &Xpgflt,        0);
  1011ce:	c6 05 74 80 9b 00 00 	movb   $0x0,0x9b8074
  1011d5:	66 a3 76 80 9b 00    	mov    %ax,0x9b8076
	SETGATE(idt[T_FPERR],             0, CPU_GDT_KCODE, &Xfperr,        0);
  1011db:	b8 44 1f 10 00       	mov    $0x101f44,%eax
  1011e0:	66 a3 80 80 9b 00    	mov    %ax,0x9b8080
  1011e6:	c1 e8 10             	shr    $0x10,%eax
  1011e9:	66 a3 86 80 9b 00    	mov    %ax,0x9b8086
	SETGATE(idt[T_ALIGN],             0, CPU_GDT_KCODE, &Xalign,        0);
  1011ef:	b8 4e 1f 10 00       	mov    $0x101f4e,%eax
  1011f4:	66 a3 88 80 9b 00    	mov    %ax,0x9b8088
  1011fa:	c1 e8 10             	shr    $0x10,%eax
  1011fd:	66 a3 8e 80 9b 00    	mov    %ax,0x9b808e
	SETGATE(idt[T_MCHK],              0, CPU_GDT_KCODE, &Xmchk,         0);
  101203:	b8 56 1f 10 00       	mov    $0x101f56,%eax
  101208:	66 a3 90 80 9b 00    	mov    %ax,0x9b8090
  10120e:	c1 e8 10             	shr    $0x10,%eax
  101211:	66 a3 96 80 9b 00    	mov    %ax,0x9b8096

	SETGATE(idt[T_IRQ0+IRQ_TIMER],    0, CPU_GDT_KCODE, &Xirq_timer,    0);
  101217:	b8 60 1f 10 00       	mov    $0x101f60,%eax
  10121c:	66 a3 00 81 9b 00    	mov    %ax,0x9b8100
  101222:	c1 e8 10             	shr    $0x10,%eax
  101225:	66 a3 06 81 9b 00    	mov    %ax,0x9b8106
	SETGATE(idt[T_IRQ0+IRQ_KBD],      0, CPU_GDT_KCODE, &Xirq_kbd,      0);
  10122b:	b8 6a 1f 10 00       	mov    $0x101f6a,%eax
  101230:	66 a3 08 81 9b 00    	mov    %ax,0x9b8108
  101236:	c1 e8 10             	shr    $0x10,%eax
  101239:	66 a3 0e 81 9b 00    	mov    %ax,0x9b810e
	SETGATE(idt[T_IRQ0+IRQ_SLAVE],    0, CPU_GDT_KCODE, &Xirq_slave,    0);
  10123f:	b8 74 1f 10 00       	mov    $0x101f74,%eax
	SETGATE(idt[T_TSS],               0, CPU_GDT_KCODE, &Xtss,          0);
	SETGATE(idt[T_SEGNP],             0, CPU_GDT_KCODE, &Xsegnp,        0);
	SETGATE(idt[T_STACK],             0, CPU_GDT_KCODE, &Xstack,        0);
	SETGATE(idt[T_GPFLT],             0, CPU_GDT_KCODE, &Xgpflt,        0);
	SETGATE(idt[T_PGFLT],             0, CPU_GDT_KCODE, &Xpgflt,        0);
	SETGATE(idt[T_FPERR],             0, CPU_GDT_KCODE, &Xfperr,        0);
  101244:	66 89 15 82 80 9b 00 	mov    %dx,0x9b8082
	SETGATE(idt[T_ALIGN],             0, CPU_GDT_KCODE, &Xalign,        0);
	SETGATE(idt[T_MCHK],              0, CPU_GDT_KCODE, &Xmchk,         0);
  10124b:	ba 08 00 00 00       	mov    $0x8,%edx

	SETGATE(idt[T_IRQ0+IRQ_TIMER],    0, CPU_GDT_KCODE, &Xirq_timer,    0);
	SETGATE(idt[T_IRQ0+IRQ_KBD],      0, CPU_GDT_KCODE, &Xirq_kbd,      0);
	SETGATE(idt[T_IRQ0+IRQ_SLAVE],    0, CPU_GDT_KCODE, &Xirq_slave,    0);
  101250:	66 a3 10 81 9b 00    	mov    %ax,0x9b8110
  101256:	c1 e8 10             	shr    $0x10,%eax
	SETGATE(idt[T_SEGNP],             0, CPU_GDT_KCODE, &Xsegnp,        0);
	SETGATE(idt[T_STACK],             0, CPU_GDT_KCODE, &Xstack,        0);
	SETGATE(idt[T_GPFLT],             0, CPU_GDT_KCODE, &Xgpflt,        0);
	SETGATE(idt[T_PGFLT],             0, CPU_GDT_KCODE, &Xpgflt,        0);
	SETGATE(idt[T_FPERR],             0, CPU_GDT_KCODE, &Xfperr,        0);
	SETGATE(idt[T_ALIGN],             0, CPU_GDT_KCODE, &Xalign,        0);
  101259:	66 89 0d 8a 80 9b 00 	mov    %cx,0x9b808a
	SETGATE(idt[T_MCHK],              0, CPU_GDT_KCODE, &Xmchk,         0);

	SETGATE(idt[T_IRQ0+IRQ_TIMER],    0, CPU_GDT_KCODE, &Xirq_timer,    0);
  101260:	b9 08 00 00 00       	mov    $0x8,%ecx
	SETGATE(idt[T_STACK],             0, CPU_GDT_KCODE, &Xstack,        0);
	SETGATE(idt[T_GPFLT],             0, CPU_GDT_KCODE, &Xgpflt,        0);
	SETGATE(idt[T_PGFLT],             0, CPU_GDT_KCODE, &Xpgflt,        0);
	SETGATE(idt[T_FPERR],             0, CPU_GDT_KCODE, &Xfperr,        0);
	SETGATE(idt[T_ALIGN],             0, CPU_GDT_KCODE, &Xalign,        0);
	SETGATE(idt[T_MCHK],              0, CPU_GDT_KCODE, &Xmchk,         0);
  101265:	66 89 15 92 80 9b 00 	mov    %dx,0x9b8092

	SETGATE(idt[T_IRQ0+IRQ_TIMER],    0, CPU_GDT_KCODE, &Xirq_timer,    0);
	SETGATE(idt[T_IRQ0+IRQ_KBD],      0, CPU_GDT_KCODE, &Xirq_kbd,      0);
  10126c:	ba 08 00 00 00       	mov    $0x8,%edx
	SETGATE(idt[T_IRQ0+IRQ_SLAVE],    0, CPU_GDT_KCODE, &Xirq_slave,    0);
  101271:	66 a3 16 81 9b 00    	mov    %ax,0x9b8116
	SETGATE(idt[T_IRQ0+IRQ_SERIAL24], 0, CPU_GDT_KCODE, &Xirq_serial2,  0);
  101277:	b8 7e 1f 10 00       	mov    $0x101f7e,%eax
	SETGATE(idt[T_PGFLT],             0, CPU_GDT_KCODE, &Xpgflt,        0);
	SETGATE(idt[T_FPERR],             0, CPU_GDT_KCODE, &Xfperr,        0);
	SETGATE(idt[T_ALIGN],             0, CPU_GDT_KCODE, &Xalign,        0);
	SETGATE(idt[T_MCHK],              0, CPU_GDT_KCODE, &Xmchk,         0);

	SETGATE(idt[T_IRQ0+IRQ_TIMER],    0, CPU_GDT_KCODE, &Xirq_timer,    0);
  10127c:	66 89 0d 02 81 9b 00 	mov    %cx,0x9b8102
	SETGATE(idt[T_IRQ0+IRQ_KBD],      0, CPU_GDT_KCODE, &Xirq_kbd,      0);
	SETGATE(idt[T_IRQ0+IRQ_SLAVE],    0, CPU_GDT_KCODE, &Xirq_slave,    0);
  101283:	b9 08 00 00 00       	mov    $0x8,%ecx
	SETGATE(idt[T_FPERR],             0, CPU_GDT_KCODE, &Xfperr,        0);
	SETGATE(idt[T_ALIGN],             0, CPU_GDT_KCODE, &Xalign,        0);
	SETGATE(idt[T_MCHK],              0, CPU_GDT_KCODE, &Xmchk,         0);

	SETGATE(idt[T_IRQ0+IRQ_TIMER],    0, CPU_GDT_KCODE, &Xirq_timer,    0);
	SETGATE(idt[T_IRQ0+IRQ_KBD],      0, CPU_GDT_KCODE, &Xirq_kbd,      0);
  101288:	66 89 15 0a 81 9b 00 	mov    %dx,0x9b810a
	SETGATE(idt[T_IRQ0+IRQ_SLAVE],    0, CPU_GDT_KCODE, &Xirq_slave,    0);
	SETGATE(idt[T_IRQ0+IRQ_SERIAL24], 0, CPU_GDT_KCODE, &Xirq_serial2,  0);
  10128f:	ba 08 00 00 00       	mov    $0x8,%edx
  101294:	66 a3 18 81 9b 00    	mov    %ax,0x9b8118
  10129a:	c1 e8 10             	shr    $0x10,%eax
	SETGATE(idt[T_ALIGN],             0, CPU_GDT_KCODE, &Xalign,        0);
	SETGATE(idt[T_MCHK],              0, CPU_GDT_KCODE, &Xmchk,         0);

	SETGATE(idt[T_IRQ0+IRQ_TIMER],    0, CPU_GDT_KCODE, &Xirq_timer,    0);
	SETGATE(idt[T_IRQ0+IRQ_KBD],      0, CPU_GDT_KCODE, &Xirq_kbd,      0);
	SETGATE(idt[T_IRQ0+IRQ_SLAVE],    0, CPU_GDT_KCODE, &Xirq_slave,    0);
  10129d:	66 89 0d 12 81 9b 00 	mov    %cx,0x9b8112
	SETGATE(idt[T_IRQ0+IRQ_SERIAL24], 0, CPU_GDT_KCODE, &Xirq_serial2,  0);
	SETGATE(idt[T_IRQ0+IRQ_SERIAL13], 0, CPU_GDT_KCODE, &Xirq_serial1,  0);
  1012a4:	b9 08 00 00 00       	mov    $0x8,%ecx
	SETGATE(idt[T_DBLFLT],            0, CPU_GDT_KCODE, &Xdblflt,       0);
	SETGATE(idt[T_TSS],               0, CPU_GDT_KCODE, &Xtss,          0);
	SETGATE(idt[T_SEGNP],             0, CPU_GDT_KCODE, &Xsegnp,        0);
	SETGATE(idt[T_STACK],             0, CPU_GDT_KCODE, &Xstack,        0);
	SETGATE(idt[T_GPFLT],             0, CPU_GDT_KCODE, &Xgpflt,        0);
	SETGATE(idt[T_PGFLT],             0, CPU_GDT_KCODE, &Xpgflt,        0);
  1012a9:	c6 05 75 80 9b 00 8e 	movb   $0x8e,0x9b8075
	SETGATE(idt[T_FPERR],             0, CPU_GDT_KCODE, &Xfperr,        0);
  1012b0:	c6 05 84 80 9b 00 00 	movb   $0x0,0x9b8084
  1012b7:	c6 05 85 80 9b 00 8e 	movb   $0x8e,0x9b8085
	SETGATE(idt[T_ALIGN],             0, CPU_GDT_KCODE, &Xalign,        0);
  1012be:	c6 05 8c 80 9b 00 00 	movb   $0x0,0x9b808c
  1012c5:	c6 05 8d 80 9b 00 8e 	movb   $0x8e,0x9b808d
	SETGATE(idt[T_MCHK],              0, CPU_GDT_KCODE, &Xmchk,         0);
  1012cc:	c6 05 94 80 9b 00 00 	movb   $0x0,0x9b8094
  1012d3:	c6 05 95 80 9b 00 8e 	movb   $0x8e,0x9b8095

	SETGATE(idt[T_IRQ0+IRQ_TIMER],    0, CPU_GDT_KCODE, &Xirq_timer,    0);
  1012da:	c6 05 04 81 9b 00 00 	movb   $0x0,0x9b8104
  1012e1:	c6 05 05 81 9b 00 8e 	movb   $0x8e,0x9b8105
	SETGATE(idt[T_IRQ0+IRQ_KBD],      0, CPU_GDT_KCODE, &Xirq_kbd,      0);
  1012e8:	c6 05 0c 81 9b 00 00 	movb   $0x0,0x9b810c
  1012ef:	c6 05 0d 81 9b 00 8e 	movb   $0x8e,0x9b810d
	SETGATE(idt[T_IRQ0+IRQ_SLAVE],    0, CPU_GDT_KCODE, &Xirq_slave,    0);
  1012f6:	c6 05 14 81 9b 00 00 	movb   $0x0,0x9b8114
  1012fd:	c6 05 15 81 9b 00 8e 	movb   $0x8e,0x9b8115
	SETGATE(idt[T_IRQ0+IRQ_SERIAL24], 0, CPU_GDT_KCODE, &Xirq_serial2,  0);
  101304:	66 89 15 1a 81 9b 00 	mov    %dx,0x9b811a
	SETGATE(idt[T_IRQ0+IRQ_SERIAL13], 0, CPU_GDT_KCODE, &Xirq_serial1,  0);
	SETGATE(idt[T_IRQ0+IRQ_LPT2],     0, CPU_GDT_KCODE, &Xirq_lpt,      0);
  10130b:	ba 08 00 00 00       	mov    $0x8,%edx
	SETGATE(idt[T_MCHK],              0, CPU_GDT_KCODE, &Xmchk,         0);

	SETGATE(idt[T_IRQ0+IRQ_TIMER],    0, CPU_GDT_KCODE, &Xirq_timer,    0);
	SETGATE(idt[T_IRQ0+IRQ_KBD],      0, CPU_GDT_KCODE, &Xirq_kbd,      0);
	SETGATE(idt[T_IRQ0+IRQ_SLAVE],    0, CPU_GDT_KCODE, &Xirq_slave,    0);
	SETGATE(idt[T_IRQ0+IRQ_SERIAL24], 0, CPU_GDT_KCODE, &Xirq_serial2,  0);
  101310:	66 a3 1e 81 9b 00    	mov    %ax,0x9b811e
	SETGATE(idt[T_IRQ0+IRQ_SERIAL13], 0, CPU_GDT_KCODE, &Xirq_serial1,  0);
  101316:	b8 88 1f 10 00       	mov    $0x101f88,%eax
  10131b:	66 a3 20 81 9b 00    	mov    %ax,0x9b8120
  101321:	c1 e8 10             	shr    $0x10,%eax
  101324:	66 a3 26 81 9b 00    	mov    %ax,0x9b8126
	SETGATE(idt[T_IRQ0+IRQ_LPT2],     0, CPU_GDT_KCODE, &Xirq_lpt,      0);
  10132a:	b8 92 1f 10 00       	mov    $0x101f92,%eax
  10132f:	66 a3 28 81 9b 00    	mov    %ax,0x9b8128
  101335:	c1 e8 10             	shr    $0x10,%eax
  101338:	66 a3 2e 81 9b 00    	mov    %ax,0x9b812e
	SETGATE(idt[T_IRQ0+IRQ_FLOPPY],   0, CPU_GDT_KCODE, &Xirq_floppy,   0);
  10133e:	b8 9c 1f 10 00       	mov    $0x101f9c,%eax
  101343:	66 a3 30 81 9b 00    	mov    %ax,0x9b8130
  101349:	c1 e8 10             	shr    $0x10,%eax
  10134c:	66 a3 36 81 9b 00    	mov    %ax,0x9b8136
	SETGATE(idt[T_IRQ0+IRQ_SPURIOUS], 0, CPU_GDT_KCODE, &Xirq_spurious, 0);
  101352:	b8 a6 1f 10 00       	mov    $0x101fa6,%eax
  101357:	66 a3 38 81 9b 00    	mov    %ax,0x9b8138
  10135d:	c1 e8 10             	shr    $0x10,%eax
  101360:	66 a3 3e 81 9b 00    	mov    %ax,0x9b813e
	SETGATE(idt[T_IRQ0+IRQ_RTC],      0, CPU_GDT_KCODE, &Xirq_rtc,      0);
  101366:	b8 b0 1f 10 00       	mov    $0x101fb0,%eax
  10136b:	66 a3 40 81 9b 00    	mov    %ax,0x9b8140
  101371:	c1 e8 10             	shr    $0x10,%eax
  101374:	66 a3 46 81 9b 00    	mov    %ax,0x9b8146
	SETGATE(idt[T_IRQ0+9],            0, CPU_GDT_KCODE, &Xirq9,         0);
  10137a:	b8 ba 1f 10 00       	mov    $0x101fba,%eax

	SETGATE(idt[T_IRQ0+IRQ_TIMER],    0, CPU_GDT_KCODE, &Xirq_timer,    0);
	SETGATE(idt[T_IRQ0+IRQ_KBD],      0, CPU_GDT_KCODE, &Xirq_kbd,      0);
	SETGATE(idt[T_IRQ0+IRQ_SLAVE],    0, CPU_GDT_KCODE, &Xirq_slave,    0);
	SETGATE(idt[T_IRQ0+IRQ_SERIAL24], 0, CPU_GDT_KCODE, &Xirq_serial2,  0);
	SETGATE(idt[T_IRQ0+IRQ_SERIAL13], 0, CPU_GDT_KCODE, &Xirq_serial1,  0);
  10137f:	66 89 0d 22 81 9b 00 	mov    %cx,0x9b8122
	SETGATE(idt[T_IRQ0+IRQ_LPT2],     0, CPU_GDT_KCODE, &Xirq_lpt,      0);
	SETGATE(idt[T_IRQ0+IRQ_FLOPPY],   0, CPU_GDT_KCODE, &Xirq_floppy,   0);
  101386:	b9 08 00 00 00       	mov    $0x8,%ecx
	SETGATE(idt[T_IRQ0+IRQ_TIMER],    0, CPU_GDT_KCODE, &Xirq_timer,    0);
	SETGATE(idt[T_IRQ0+IRQ_KBD],      0, CPU_GDT_KCODE, &Xirq_kbd,      0);
	SETGATE(idt[T_IRQ0+IRQ_SLAVE],    0, CPU_GDT_KCODE, &Xirq_slave,    0);
	SETGATE(idt[T_IRQ0+IRQ_SERIAL24], 0, CPU_GDT_KCODE, &Xirq_serial2,  0);
	SETGATE(idt[T_IRQ0+IRQ_SERIAL13], 0, CPU_GDT_KCODE, &Xirq_serial1,  0);
	SETGATE(idt[T_IRQ0+IRQ_LPT2],     0, CPU_GDT_KCODE, &Xirq_lpt,      0);
  10138b:	66 89 15 2a 81 9b 00 	mov    %dx,0x9b812a
	SETGATE(idt[T_IRQ0+IRQ_FLOPPY],   0, CPU_GDT_KCODE, &Xirq_floppy,   0);
	SETGATE(idt[T_IRQ0+IRQ_SPURIOUS], 0, CPU_GDT_KCODE, &Xirq_spurious, 0);
  101392:	ba 08 00 00 00       	mov    $0x8,%edx
	SETGATE(idt[T_IRQ0+IRQ_RTC],      0, CPU_GDT_KCODE, &Xirq_rtc,      0);
	SETGATE(idt[T_IRQ0+9],            0, CPU_GDT_KCODE, &Xirq9,         0);
  101397:	66 a3 48 81 9b 00    	mov    %ax,0x9b8148
  10139d:	c1 e8 10             	shr    $0x10,%eax
	SETGATE(idt[T_IRQ0+IRQ_KBD],      0, CPU_GDT_KCODE, &Xirq_kbd,      0);
	SETGATE(idt[T_IRQ0+IRQ_SLAVE],    0, CPU_GDT_KCODE, &Xirq_slave,    0);
	SETGATE(idt[T_IRQ0+IRQ_SERIAL24], 0, CPU_GDT_KCODE, &Xirq_serial2,  0);
	SETGATE(idt[T_IRQ0+IRQ_SERIAL13], 0, CPU_GDT_KCODE, &Xirq_serial1,  0);
	SETGATE(idt[T_IRQ0+IRQ_LPT2],     0, CPU_GDT_KCODE, &Xirq_lpt,      0);
	SETGATE(idt[T_IRQ0+IRQ_FLOPPY],   0, CPU_GDT_KCODE, &Xirq_floppy,   0);
  1013a0:	66 89 0d 32 81 9b 00 	mov    %cx,0x9b8132
	SETGATE(idt[T_IRQ0+IRQ_SPURIOUS], 0, CPU_GDT_KCODE, &Xirq_spurious, 0);
	SETGATE(idt[T_IRQ0+IRQ_RTC],      0, CPU_GDT_KCODE, &Xirq_rtc,      0);
  1013a7:	b9 08 00 00 00       	mov    $0x8,%ecx
	SETGATE(idt[T_IRQ0+IRQ_SLAVE],    0, CPU_GDT_KCODE, &Xirq_slave,    0);
	SETGATE(idt[T_IRQ0+IRQ_SERIAL24], 0, CPU_GDT_KCODE, &Xirq_serial2,  0);
	SETGATE(idt[T_IRQ0+IRQ_SERIAL13], 0, CPU_GDT_KCODE, &Xirq_serial1,  0);
	SETGATE(idt[T_IRQ0+IRQ_LPT2],     0, CPU_GDT_KCODE, &Xirq_lpt,      0);
	SETGATE(idt[T_IRQ0+IRQ_FLOPPY],   0, CPU_GDT_KCODE, &Xirq_floppy,   0);
	SETGATE(idt[T_IRQ0+IRQ_SPURIOUS], 0, CPU_GDT_KCODE, &Xirq_spurious, 0);
  1013ac:	66 89 15 3a 81 9b 00 	mov    %dx,0x9b813a
	SETGATE(idt[T_IRQ0+IRQ_RTC],      0, CPU_GDT_KCODE, &Xirq_rtc,      0);
	SETGATE(idt[T_IRQ0+9],            0, CPU_GDT_KCODE, &Xirq9,         0);
  1013b3:	ba 08 00 00 00       	mov    $0x8,%edx
  1013b8:	66 a3 4e 81 9b 00    	mov    %ax,0x9b814e
	SETGATE(idt[T_IRQ0+10],           0, CPU_GDT_KCODE, &Xirq10,        0);
  1013be:	b8 c4 1f 10 00       	mov    $0x101fc4,%eax
	SETGATE(idt[T_IRQ0+IRQ_SERIAL24], 0, CPU_GDT_KCODE, &Xirq_serial2,  0);
	SETGATE(idt[T_IRQ0+IRQ_SERIAL13], 0, CPU_GDT_KCODE, &Xirq_serial1,  0);
	SETGATE(idt[T_IRQ0+IRQ_LPT2],     0, CPU_GDT_KCODE, &Xirq_lpt,      0);
	SETGATE(idt[T_IRQ0+IRQ_FLOPPY],   0, CPU_GDT_KCODE, &Xirq_floppy,   0);
	SETGATE(idt[T_IRQ0+IRQ_SPURIOUS], 0, CPU_GDT_KCODE, &Xirq_spurious, 0);
	SETGATE(idt[T_IRQ0+IRQ_RTC],      0, CPU_GDT_KCODE, &Xirq_rtc,      0);
  1013c3:	66 89 0d 42 81 9b 00 	mov    %cx,0x9b8142
	SETGATE(idt[T_IRQ0+9],            0, CPU_GDT_KCODE, &Xirq9,         0);
	SETGATE(idt[T_IRQ0+10],           0, CPU_GDT_KCODE, &Xirq10,        0);
  1013ca:	b9 08 00 00 00       	mov    $0x8,%ecx
	SETGATE(idt[T_IRQ0+IRQ_SERIAL13], 0, CPU_GDT_KCODE, &Xirq_serial1,  0);
	SETGATE(idt[T_IRQ0+IRQ_LPT2],     0, CPU_GDT_KCODE, &Xirq_lpt,      0);
	SETGATE(idt[T_IRQ0+IRQ_FLOPPY],   0, CPU_GDT_KCODE, &Xirq_floppy,   0);
	SETGATE(idt[T_IRQ0+IRQ_SPURIOUS], 0, CPU_GDT_KCODE, &Xirq_spurious, 0);
	SETGATE(idt[T_IRQ0+IRQ_RTC],      0, CPU_GDT_KCODE, &Xirq_rtc,      0);
	SETGATE(idt[T_IRQ0+9],            0, CPU_GDT_KCODE, &Xirq9,         0);
  1013cf:	66 89 15 4a 81 9b 00 	mov    %dx,0x9b814a
	SETGATE(idt[T_IRQ0+10],           0, CPU_GDT_KCODE, &Xirq10,        0);
	SETGATE(idt[T_IRQ0+11],           0, CPU_GDT_KCODE, &Xirq11,        0);
  1013d6:	ba 08 00 00 00       	mov    $0x8,%edx
	SETGATE(idt[T_MCHK],              0, CPU_GDT_KCODE, &Xmchk,         0);

	SETGATE(idt[T_IRQ0+IRQ_TIMER],    0, CPU_GDT_KCODE, &Xirq_timer,    0);
	SETGATE(idt[T_IRQ0+IRQ_KBD],      0, CPU_GDT_KCODE, &Xirq_kbd,      0);
	SETGATE(idt[T_IRQ0+IRQ_SLAVE],    0, CPU_GDT_KCODE, &Xirq_slave,    0);
	SETGATE(idt[T_IRQ0+IRQ_SERIAL24], 0, CPU_GDT_KCODE, &Xirq_serial2,  0);
  1013db:	c6 05 1c 81 9b 00 00 	movb   $0x0,0x9b811c
  1013e2:	c6 05 1d 81 9b 00 8e 	movb   $0x8e,0x9b811d
	SETGATE(idt[T_IRQ0+IRQ_SERIAL13], 0, CPU_GDT_KCODE, &Xirq_serial1,  0);
  1013e9:	c6 05 24 81 9b 00 00 	movb   $0x0,0x9b8124
  1013f0:	c6 05 25 81 9b 00 8e 	movb   $0x8e,0x9b8125
	SETGATE(idt[T_IRQ0+IRQ_LPT2],     0, CPU_GDT_KCODE, &Xirq_lpt,      0);
  1013f7:	c6 05 2c 81 9b 00 00 	movb   $0x0,0x9b812c
  1013fe:	c6 05 2d 81 9b 00 8e 	movb   $0x8e,0x9b812d
	SETGATE(idt[T_IRQ0+IRQ_FLOPPY],   0, CPU_GDT_KCODE, &Xirq_floppy,   0);
  101405:	c6 05 34 81 9b 00 00 	movb   $0x0,0x9b8134
  10140c:	c6 05 35 81 9b 00 8e 	movb   $0x8e,0x9b8135
	SETGATE(idt[T_IRQ0+IRQ_SPURIOUS], 0, CPU_GDT_KCODE, &Xirq_spurious, 0);
  101413:	c6 05 3c 81 9b 00 00 	movb   $0x0,0x9b813c
  10141a:	c6 05 3d 81 9b 00 8e 	movb   $0x8e,0x9b813d
	SETGATE(idt[T_IRQ0+IRQ_RTC],      0, CPU_GDT_KCODE, &Xirq_rtc,      0);
  101421:	c6 05 44 81 9b 00 00 	movb   $0x0,0x9b8144
  101428:	c6 05 45 81 9b 00 8e 	movb   $0x8e,0x9b8145
	SETGATE(idt[T_IRQ0+9],            0, CPU_GDT_KCODE, &Xirq9,         0);
  10142f:	c6 05 4c 81 9b 00 00 	movb   $0x0,0x9b814c
  101436:	c6 05 4d 81 9b 00 8e 	movb   $0x8e,0x9b814d
	SETGATE(idt[T_IRQ0+10],           0, CPU_GDT_KCODE, &Xirq10,        0);
  10143d:	66 a3 50 81 9b 00    	mov    %ax,0x9b8150
  101443:	c1 e8 10             	shr    $0x10,%eax
  101446:	66 a3 56 81 9b 00    	mov    %ax,0x9b8156
	SETGATE(idt[T_IRQ0+11],           0, CPU_GDT_KCODE, &Xirq11,        0);
  10144c:	b8 ce 1f 10 00       	mov    $0x101fce,%eax
  101451:	66 a3 58 81 9b 00    	mov    %ax,0x9b8158
  101457:	c1 e8 10             	shr    $0x10,%eax
  10145a:	66 a3 5e 81 9b 00    	mov    %ax,0x9b815e
	SETGATE(idt[T_IRQ0+IRQ_MOUSE],    0, CPU_GDT_KCODE, &Xirq_mouse,    0);
  101460:	b8 d8 1f 10 00       	mov    $0x101fd8,%eax
  101465:	66 a3 60 81 9b 00    	mov    %ax,0x9b8160
  10146b:	c1 e8 10             	shr    $0x10,%eax
  10146e:	66 a3 66 81 9b 00    	mov    %ax,0x9b8166
	SETGATE(idt[T_IRQ0+IRQ_COPROCESSOR], 0, CPU_GDT_KCODE, &Xirq_coproc, 0);
  101474:	b8 e2 1f 10 00       	mov    $0x101fe2,%eax
  101479:	66 a3 68 81 9b 00    	mov    %ax,0x9b8168
  10147f:	c1 e8 10             	shr    $0x10,%eax
  101482:	66 a3 6e 81 9b 00    	mov    %ax,0x9b816e
	SETGATE(idt[T_IRQ0+IRQ_IDE1],     0, CPU_GDT_KCODE, &Xirq_ide1,     0);
  101488:	b8 ec 1f 10 00       	mov    $0x101fec,%eax
  10148d:	66 a3 70 81 9b 00    	mov    %ax,0x9b8170
  101493:	c1 e8 10             	shr    $0x10,%eax
  101496:	66 a3 76 81 9b 00    	mov    %ax,0x9b8176
	SETGATE(idt[T_IRQ0+IRQ_IDE2],     0, CPU_GDT_KCODE, &Xirq_ide2,     0);
  10149c:	b8 f6 1f 10 00       	mov    $0x101ff6,%eax
	SETGATE(idt[T_IRQ0+IRQ_LPT2],     0, CPU_GDT_KCODE, &Xirq_lpt,      0);
	SETGATE(idt[T_IRQ0+IRQ_FLOPPY],   0, CPU_GDT_KCODE, &Xirq_floppy,   0);
	SETGATE(idt[T_IRQ0+IRQ_SPURIOUS], 0, CPU_GDT_KCODE, &Xirq_spurious, 0);
	SETGATE(idt[T_IRQ0+IRQ_RTC],      0, CPU_GDT_KCODE, &Xirq_rtc,      0);
	SETGATE(idt[T_IRQ0+9],            0, CPU_GDT_KCODE, &Xirq9,         0);
	SETGATE(idt[T_IRQ0+10],           0, CPU_GDT_KCODE, &Xirq10,        0);
  1014a1:	66 89 0d 52 81 9b 00 	mov    %cx,0x9b8152
	SETGATE(idt[T_IRQ0+11],           0, CPU_GDT_KCODE, &Xirq11,        0);
	SETGATE(idt[T_IRQ0+IRQ_MOUSE],    0, CPU_GDT_KCODE, &Xirq_mouse,    0);
  1014a8:	b9 08 00 00 00       	mov    $0x8,%ecx
	SETGATE(idt[T_IRQ0+IRQ_COPROCESSOR], 0, CPU_GDT_KCODE, &Xirq_coproc, 0);
	SETGATE(idt[T_IRQ0+IRQ_IDE1],     0, CPU_GDT_KCODE, &Xirq_ide1,     0);
	SETGATE(idt[T_IRQ0+IRQ_IDE2],     0, CPU_GDT_KCODE, &Xirq_ide2,     0);
  1014ad:	66 a3 78 81 9b 00    	mov    %ax,0x9b8178
  1014b3:	c1 e8 10             	shr    $0x10,%eax
	SETGATE(idt[T_IRQ0+IRQ_FLOPPY],   0, CPU_GDT_KCODE, &Xirq_floppy,   0);
	SETGATE(idt[T_IRQ0+IRQ_SPURIOUS], 0, CPU_GDT_KCODE, &Xirq_spurious, 0);
	SETGATE(idt[T_IRQ0+IRQ_RTC],      0, CPU_GDT_KCODE, &Xirq_rtc,      0);
	SETGATE(idt[T_IRQ0+9],            0, CPU_GDT_KCODE, &Xirq9,         0);
	SETGATE(idt[T_IRQ0+10],           0, CPU_GDT_KCODE, &Xirq10,        0);
	SETGATE(idt[T_IRQ0+11],           0, CPU_GDT_KCODE, &Xirq11,        0);
  1014b6:	66 89 15 5a 81 9b 00 	mov    %dx,0x9b815a
	SETGATE(idt[T_IRQ0+IRQ_MOUSE],    0, CPU_GDT_KCODE, &Xirq_mouse,    0);
	SETGATE(idt[T_IRQ0+IRQ_COPROCESSOR], 0, CPU_GDT_KCODE, &Xirq_coproc, 0);
  1014bd:	ba 08 00 00 00       	mov    $0x8,%edx
	SETGATE(idt[T_IRQ0+IRQ_SPURIOUS], 0, CPU_GDT_KCODE, &Xirq_spurious, 0);
	SETGATE(idt[T_IRQ0+IRQ_RTC],      0, CPU_GDT_KCODE, &Xirq_rtc,      0);
	SETGATE(idt[T_IRQ0+9],            0, CPU_GDT_KCODE, &Xirq9,         0);
	SETGATE(idt[T_IRQ0+10],           0, CPU_GDT_KCODE, &Xirq10,        0);
	SETGATE(idt[T_IRQ0+11],           0, CPU_GDT_KCODE, &Xirq11,        0);
	SETGATE(idt[T_IRQ0+IRQ_MOUSE],    0, CPU_GDT_KCODE, &Xirq_mouse,    0);
  1014c2:	66 89 0d 62 81 9b 00 	mov    %cx,0x9b8162
	SETGATE(idt[T_IRQ0+IRQ_COPROCESSOR], 0, CPU_GDT_KCODE, &Xirq_coproc, 0);
	SETGATE(idt[T_IRQ0+IRQ_IDE1],     0, CPU_GDT_KCODE, &Xirq_ide1,     0);
  1014c9:	b9 08 00 00 00       	mov    $0x8,%ecx
	SETGATE(idt[T_IRQ0+IRQ_IDE2],     0, CPU_GDT_KCODE, &Xirq_ide2,     0);
  1014ce:	66 a3 7e 81 9b 00    	mov    %ax,0x9b817e

	// Use DPL=3 here because system calls are explicitly invoked
	// by the user process (with "int $T_SYSCALL").
	SETGATE(idt[T_SYSCALL],           0, CPU_GDT_KCODE, &Xsyscall,      3);
  1014d4:	b8 00 20 10 00       	mov    $0x102000,%eax
	SETGATE(idt[T_IRQ0+IRQ_RTC],      0, CPU_GDT_KCODE, &Xirq_rtc,      0);
	SETGATE(idt[T_IRQ0+9],            0, CPU_GDT_KCODE, &Xirq9,         0);
	SETGATE(idt[T_IRQ0+10],           0, CPU_GDT_KCODE, &Xirq10,        0);
	SETGATE(idt[T_IRQ0+11],           0, CPU_GDT_KCODE, &Xirq11,        0);
	SETGATE(idt[T_IRQ0+IRQ_MOUSE],    0, CPU_GDT_KCODE, &Xirq_mouse,    0);
	SETGATE(idt[T_IRQ0+IRQ_COPROCESSOR], 0, CPU_GDT_KCODE, &Xirq_coproc, 0);
  1014d9:	66 89 15 6a 81 9b 00 	mov    %dx,0x9b816a
	SETGATE(idt[T_IRQ0+IRQ_IDE1],     0, CPU_GDT_KCODE, &Xirq_ide1,     0);
	SETGATE(idt[T_IRQ0+IRQ_IDE2],     0, CPU_GDT_KCODE, &Xirq_ide2,     0);
  1014e0:	ba 08 00 00 00       	mov    $0x8,%edx
	SETGATE(idt[T_IRQ0+9],            0, CPU_GDT_KCODE, &Xirq9,         0);
	SETGATE(idt[T_IRQ0+10],           0, CPU_GDT_KCODE, &Xirq10,        0);
	SETGATE(idt[T_IRQ0+11],           0, CPU_GDT_KCODE, &Xirq11,        0);
	SETGATE(idt[T_IRQ0+IRQ_MOUSE],    0, CPU_GDT_KCODE, &Xirq_mouse,    0);
	SETGATE(idt[T_IRQ0+IRQ_COPROCESSOR], 0, CPU_GDT_KCODE, &Xirq_coproc, 0);
	SETGATE(idt[T_IRQ0+IRQ_IDE1],     0, CPU_GDT_KCODE, &Xirq_ide1,     0);
  1014e5:	66 89 0d 72 81 9b 00 	mov    %cx,0x9b8172
	SETGATE(idt[T_IRQ0+IRQ_IDE2],     0, CPU_GDT_KCODE, &Xirq_ide2,     0);

	// Use DPL=3 here because system calls are explicitly invoked
	// by the user process (with "int $T_SYSCALL").
	SETGATE(idt[T_SYSCALL],           0, CPU_GDT_KCODE, &Xsyscall,      3);
  1014ec:	b9 08 00 00 00       	mov    $0x8,%ecx
  1014f1:	66 a3 80 81 9b 00    	mov    %ax,0x9b8180
  1014f7:	c1 e8 10             	shr    $0x10,%eax
	SETGATE(idt[T_IRQ0+10],           0, CPU_GDT_KCODE, &Xirq10,        0);
	SETGATE(idt[T_IRQ0+11],           0, CPU_GDT_KCODE, &Xirq11,        0);
	SETGATE(idt[T_IRQ0+IRQ_MOUSE],    0, CPU_GDT_KCODE, &Xirq_mouse,    0);
	SETGATE(idt[T_IRQ0+IRQ_COPROCESSOR], 0, CPU_GDT_KCODE, &Xirq_coproc, 0);
	SETGATE(idt[T_IRQ0+IRQ_IDE1],     0, CPU_GDT_KCODE, &Xirq_ide1,     0);
	SETGATE(idt[T_IRQ0+IRQ_IDE2],     0, CPU_GDT_KCODE, &Xirq_ide2,     0);
  1014fa:	66 89 15 7a 81 9b 00 	mov    %dx,0x9b817a

	// Use DPL=3 here because system calls are explicitly invoked
	// by the user process (with "int $T_SYSCALL").
	SETGATE(idt[T_SYSCALL],           0, CPU_GDT_KCODE, &Xsyscall,      3);
  101501:	66 89 0d 82 81 9b 00 	mov    %cx,0x9b8182
	SETGATE(idt[T_IRQ0+IRQ_LPT2],     0, CPU_GDT_KCODE, &Xirq_lpt,      0);
	SETGATE(idt[T_IRQ0+IRQ_FLOPPY],   0, CPU_GDT_KCODE, &Xirq_floppy,   0);
	SETGATE(idt[T_IRQ0+IRQ_SPURIOUS], 0, CPU_GDT_KCODE, &Xirq_spurious, 0);
	SETGATE(idt[T_IRQ0+IRQ_RTC],      0, CPU_GDT_KCODE, &Xirq_rtc,      0);
	SETGATE(idt[T_IRQ0+9],            0, CPU_GDT_KCODE, &Xirq9,         0);
	SETGATE(idt[T_IRQ0+10],           0, CPU_GDT_KCODE, &Xirq10,        0);
  101508:	c6 05 54 81 9b 00 00 	movb   $0x0,0x9b8154
  10150f:	c6 05 55 81 9b 00 8e 	movb   $0x8e,0x9b8155
	SETGATE(idt[T_IRQ0+11],           0, CPU_GDT_KCODE, &Xirq11,        0);
  101516:	c6 05 5c 81 9b 00 00 	movb   $0x0,0x9b815c
  10151d:	c6 05 5d 81 9b 00 8e 	movb   $0x8e,0x9b815d
	SETGATE(idt[T_IRQ0+IRQ_MOUSE],    0, CPU_GDT_KCODE, &Xirq_mouse,    0);
  101524:	c6 05 64 81 9b 00 00 	movb   $0x0,0x9b8164
  10152b:	c6 05 65 81 9b 00 8e 	movb   $0x8e,0x9b8165
	SETGATE(idt[T_IRQ0+IRQ_COPROCESSOR], 0, CPU_GDT_KCODE, &Xirq_coproc, 0);
  101532:	c6 05 6c 81 9b 00 00 	movb   $0x0,0x9b816c
  101539:	c6 05 6d 81 9b 00 8e 	movb   $0x8e,0x9b816d
	SETGATE(idt[T_IRQ0+IRQ_IDE1],     0, CPU_GDT_KCODE, &Xirq_ide1,     0);
  101540:	c6 05 74 81 9b 00 00 	movb   $0x0,0x9b8174
  101547:	c6 05 75 81 9b 00 8e 	movb   $0x8e,0x9b8175
	SETGATE(idt[T_IRQ0+IRQ_IDE2],     0, CPU_GDT_KCODE, &Xirq_ide2,     0);
  10154e:	c6 05 7c 81 9b 00 00 	movb   $0x0,0x9b817c
  101555:	c6 05 7d 81 9b 00 8e 	movb   $0x8e,0x9b817d

	// Use DPL=3 here because system calls are explicitly invoked
	// by the user process (with "int $T_SYSCALL").
	SETGATE(idt[T_SYSCALL],           0, CPU_GDT_KCODE, &Xsyscall,      3);
  10155c:	c6 05 84 81 9b 00 00 	movb   $0x0,0x9b8184
  101563:	c6 05 85 81 9b 00 ee 	movb   $0xee,0x9b8185
  10156a:	66 a3 86 81 9b 00    	mov    %ax,0x9b8186

	/* default */
	SETGATE(idt[T_DEFAULT],           0, CPU_GDT_KCODE, &Xdefault,      0);
  101570:	66 89 1d f0 87 9b 00 	mov    %bx,0x9b87f0
  101577:	bb 08 00 00 00       	mov    $0x8,%ebx
  10157c:	66 89 1d f2 87 9b 00 	mov    %bx,0x9b87f2
  101583:	c6 05 f4 87 9b 00 00 	movb   $0x0,0x9b87f4
  10158a:	c6 05 f5 87 9b 00 8e 	movb   $0x8e,0x9b87f5
  101591:	66 89 35 f6 87 9b 00 	mov    %si,0x9b87f6

	asm volatile("lidt %0" : : "m" (idt_pd));
  101598:	0f 01 1d 00 d3 10 00 	lidtl  0x10d300
		}
		lapic_init();
	}

	intr_init_idt();
	intr_inited = TRUE;
  10159f:	c6 05 60 ce 12 00 01 	movb   $0x1,0x12ce60
}
  1015a6:	83 c4 34             	add    $0x34,%esp
  1015a9:	5b                   	pop    %ebx
  1015aa:	5e                   	pop    %esi
  1015ab:	c3                   	ret    
  cpuid(0x00000001, &dummy, &dummy, &dummy, &edx);
  using_apic = (edx & CPUID_FEATURE_APIC) ? TRUE : FALSE;
  KERN_ASSERT(using_apic == TRUE);

	if (using_apic == TRUE){
		if(pcpu_onboot()){
  1015ac:	e8 bf 1f 00 00       	call   103570 <pcpu_onboot>
  1015b1:	85 c0                	test   %eax,%eax
  1015b3:	75 10                	jne    1015c5 <intr_init+0x735>
			ioapic_init();
		}
		lapic_init();
  1015b5:	e8 86 0d 00 00       	call   102340 <lapic_init>
  1015ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1015c0:	e9 46 f9 ff ff       	jmp    100f0b <intr_init+0x7b>
  using_apic = (edx & CPUID_FEATURE_APIC) ? TRUE : FALSE;
  KERN_ASSERT(using_apic == TRUE);

	if (using_apic == TRUE){
		if(pcpu_onboot()){
			ioapic_init();
  1015c5:	e8 96 12 00 00       	call   102860 <ioapic_init>
  1015ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1015d0:	eb e3                	jmp    1015b5 <intr_init+0x725>
  1015d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1015d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001015e0 <intr_enable>:
	intr_inited = TRUE;
}

void
intr_enable(uint8_t irq, int cpunum)
{
  1015e0:	56                   	push   %esi
  1015e1:	53                   	push   %ebx
  1015e2:	83 ec 14             	sub    $0x14,%esp
  1015e5:	8b 5c 24 24          	mov    0x24(%esp),%ebx
  1015e9:	8b 74 24 20          	mov    0x20(%esp),%esi
    KERN_ASSERT(cpunum == 0xff || (0 <= cpunum && cpunum < pcpu_ncpu()));
  1015ed:	81 fb ff 00 00 00    	cmp    $0xff,%ebx
  1015f3:	74 0d                	je     101602 <intr_enable+0x22>
  1015f5:	85 db                	test   %ebx,%ebx
  1015f7:	78 77                	js     101670 <intr_enable+0x90>
  1015f9:	e8 52 1f 00 00       	call   103550 <pcpu_ncpu>
  1015fe:	39 c3                	cmp    %eax,%ebx
  101600:	7d 6e                	jge    101670 <intr_enable+0x90>

    if (irq >= 24)
  101602:	89 f0                	mov    %esi,%eax
  101604:	3c 17                	cmp    $0x17,%al
  101606:	77 61                	ja     101669 <intr_enable+0x89>
        return;

    if (using_apic == TRUE) {
  101608:	0f b6 05 61 ce 12 00 	movzbl 0x12ce61,%eax
  10160f:	3c 01                	cmp    $0x1,%al
  101611:	74 1d                	je     101630 <intr_enable+0x50>
        ioapic_enable(irq, (cpunum == 0xff) ?
                          0xff : pcpu_cpu_lapicid(cpunum), 0, 0);
    } else {
        KERN_ASSERT(irq < 16);
  101613:	89 f0                	mov    %esi,%eax
  101615:	3c 0f                	cmp    $0xf,%al
  101617:	0f 87 83 00 00 00    	ja     1016a0 <intr_enable+0xc0>
        pic_enable(irq);
  10161d:	89 f0                	mov    %esi,%eax
  10161f:	0f b6 f0             	movzbl %al,%esi
  101622:	89 74 24 20          	mov    %esi,0x20(%esp)
    }
}
  101626:	83 c4 14             	add    $0x14,%esp
  101629:	5b                   	pop    %ebx
  10162a:	5e                   	pop    %esi
    if (using_apic == TRUE) {
        ioapic_enable(irq, (cpunum == 0xff) ?
                          0xff : pcpu_cpu_lapicid(cpunum), 0, 0);
    } else {
        KERN_ASSERT(irq < 16);
        pic_enable(irq);
  10162b:	e9 20 03 00 00       	jmp    101950 <pic_enable>

    if (irq >= 24)
        return;

    if (using_apic == TRUE) {
        ioapic_enable(irq, (cpunum == 0xff) ?
  101630:	81 fb ff 00 00 00    	cmp    $0xff,%ebx
  101636:	b8 ff 00 00 00       	mov    $0xff,%eax
  10163b:	74 0b                	je     101648 <intr_enable+0x68>
                          0xff : pcpu_cpu_lapicid(cpunum), 0, 0);
  10163d:	89 1c 24             	mov    %ebx,(%esp)
  101640:	e8 5b 1f 00 00       	call   1035a0 <pcpu_cpu_lapicid>

    if (irq >= 24)
        return;

    if (using_apic == TRUE) {
        ioapic_enable(irq, (cpunum == 0xff) ?
  101645:	0f b6 c0             	movzbl %al,%eax
  101648:	89 44 24 04          	mov    %eax,0x4(%esp)
  10164c:	89 f0                	mov    %esi,%eax
  10164e:	0f b6 f0             	movzbl %al,%esi
  101651:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  101658:	00 
  101659:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  101660:	00 
  101661:	89 34 24             	mov    %esi,(%esp)
  101664:	e8 07 13 00 00       	call   102970 <ioapic_enable>
                          0xff : pcpu_cpu_lapicid(cpunum), 0, 0);
    } else {
        KERN_ASSERT(irq < 16);
        pic_enable(irq);
    }
}
  101669:	83 c4 14             	add    $0x14,%esp
  10166c:	5b                   	pop    %ebx
  10166d:	5e                   	pop    %esi
  10166e:	c3                   	ret    
  10166f:	90                   	nop
}

void
intr_enable(uint8_t irq, int cpunum)
{
    KERN_ASSERT(cpunum == 0xff || (0 <= cpunum && cpunum < pcpu_ncpu()));
  101670:	c7 44 24 0c 50 80 10 	movl   $0x108050,0xc(%esp)
  101677:	00 
  101678:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  10167f:	00 
  101680:	c7 44 24 04 6f 00 00 	movl   $0x6f,0x4(%esp)
  101687:	00 
  101688:	c7 04 24 34 80 10 00 	movl   $0x108034,(%esp)
  10168f:	e8 ec 23 00 00       	call   103a80 <debug_panic>
  101694:	e9 69 ff ff ff       	jmp    101602 <intr_enable+0x22>
  101699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    if (using_apic == TRUE) {
        ioapic_enable(irq, (cpunum == 0xff) ?
                          0xff : pcpu_cpu_lapicid(cpunum), 0, 0);
    } else {
        KERN_ASSERT(irq < 16);
  1016a0:	c7 44 24 0c 44 80 10 	movl   $0x108044,0xc(%esp)
  1016a7:	00 
  1016a8:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  1016af:	00 
  1016b0:	c7 44 24 04 78 00 00 	movl   $0x78,0x4(%esp)
  1016b7:	00 
  1016b8:	c7 04 24 34 80 10 00 	movl   $0x108034,(%esp)
  1016bf:	e8 bc 23 00 00       	call   103a80 <debug_panic>
  1016c4:	e9 54 ff ff ff       	jmp    10161d <intr_enable+0x3d>
  1016c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001016d0 <intr_enable_lapicid>:
    }
}

void
intr_enable_lapicid(uint8_t irq, int lapic_id)
{
  1016d0:	53                   	push   %ebx
  1016d1:	83 ec 18             	sub    $0x18,%esp
  1016d4:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  1016d8:	8b 54 24 24          	mov    0x24(%esp),%edx
    if (irq > 24)
  1016dc:	80 fb 18             	cmp    $0x18,%bl
  1016df:	77 4f                	ja     101730 <intr_enable_lapicid+0x60>
        return;

    if (using_apic == TRUE) {
  1016e1:	0f b6 05 61 ce 12 00 	movzbl 0x12ce61,%eax
  1016e8:	3c 01                	cmp    $0x1,%al
  1016ea:	74 1c                	je     101708 <intr_enable_lapicid+0x38>
        ioapic_enable(irq, (lapic_id == 0xff) ?
                          0xff : lapic_id, 0, 0);
    } else {
        KERN_ASSERT(irq < 16);
  1016ec:	80 fb 0f             	cmp    $0xf,%bl
  1016ef:	77 47                	ja     101738 <intr_enable_lapicid+0x68>
        pic_enable(irq);
  1016f1:	0f b6 db             	movzbl %bl,%ebx
  1016f4:	89 5c 24 20          	mov    %ebx,0x20(%esp)
    }
}
  1016f8:	83 c4 18             	add    $0x18,%esp
  1016fb:	5b                   	pop    %ebx
    if (using_apic == TRUE) {
        ioapic_enable(irq, (lapic_id == 0xff) ?
                          0xff : lapic_id, 0, 0);
    } else {
        KERN_ASSERT(irq < 16);
        pic_enable(irq);
  1016fc:	e9 4f 02 00 00       	jmp    101950 <pic_enable>
  101701:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
    if (irq > 24)
        return;

    if (using_apic == TRUE) {
        ioapic_enable(irq, (lapic_id == 0xff) ?
  101708:	0f b6 d2             	movzbl %dl,%edx
  10170b:	0f b6 db             	movzbl %bl,%ebx
  10170e:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  101715:	00 
  101716:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  10171d:	00 
  10171e:	89 54 24 04          	mov    %edx,0x4(%esp)
  101722:	89 1c 24             	mov    %ebx,(%esp)
  101725:	e8 46 12 00 00       	call   102970 <ioapic_enable>
  10172a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                          0xff : lapic_id, 0, 0);
    } else {
        KERN_ASSERT(irq < 16);
        pic_enable(irq);
    }
}
  101730:	83 c4 18             	add    $0x18,%esp
  101733:	5b                   	pop    %ebx
  101734:	c3                   	ret    
  101735:	8d 76 00             	lea    0x0(%esi),%esi

    if (using_apic == TRUE) {
        ioapic_enable(irq, (lapic_id == 0xff) ?
                          0xff : lapic_id, 0, 0);
    } else {
        KERN_ASSERT(irq < 16);
  101738:	c7 44 24 0c 44 80 10 	movl   $0x108044,0xc(%esp)
  10173f:	00 
        pic_enable(irq);
  101740:	0f b6 db             	movzbl %bl,%ebx

    if (using_apic == TRUE) {
        ioapic_enable(irq, (lapic_id == 0xff) ?
                          0xff : lapic_id, 0, 0);
    } else {
        KERN_ASSERT(irq < 16);
  101743:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  10174a:	00 
  10174b:	c7 44 24 04 87 00 00 	movl   $0x87,0x4(%esp)
  101752:	00 
  101753:	c7 04 24 34 80 10 00 	movl   $0x108034,(%esp)
  10175a:	e8 21 23 00 00       	call   103a80 <debug_panic>
        pic_enable(irq);
  10175f:	89 5c 24 20          	mov    %ebx,0x20(%esp)
    }
}
  101763:	83 c4 18             	add    $0x18,%esp
  101766:	5b                   	pop    %ebx
    if (using_apic == TRUE) {
        ioapic_enable(irq, (lapic_id == 0xff) ?
                          0xff : lapic_id, 0, 0);
    } else {
        KERN_ASSERT(irq < 16);
        pic_enable(irq);
  101767:	e9 e4 01 00 00       	jmp    101950 <pic_enable>
  10176c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00101770 <intr_eoi>:
}

void
intr_eoi(void)
{
  if (using_apic == TRUE)
  101770:	0f b6 05 61 ce 12 00 	movzbl 0x12ce61,%eax
  101777:	3c 01                	cmp    $0x1,%al
  101779:	74 05                	je     101780 <intr_eoi+0x10>
    lapic_eoi();
  else
	  pic_eoi();
  10177b:	e9 f0 01 00 00       	jmp    101970 <pic_eoi>

void
intr_eoi(void)
{
  if (using_apic == TRUE)
    lapic_eoi();
  101780:	e9 ab 0e 00 00       	jmp    102630 <lapic_eoi>
  101785:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101790 <intr_local_enable>:
}

void
intr_local_enable(void)
{
	sti();
  101790:	e9 4b 2f 00 00       	jmp    1046e0 <sti>
  101795:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001017a0 <intr_local_disable>:
}

void
intr_local_disable(void)
{
	cli();
  1017a0:	e9 2b 2f 00 00       	jmp    1046d0 <cli>
  1017a5:	66 90                	xchg   %ax,%ax
  1017a7:	66 90                	xchg   %ax,%ax
  1017a9:	66 90                	xchg   %ax,%ax
  1017ab:	66 90                	xchg   %ax,%ax
  1017ad:	66 90                	xchg   %ax,%ax
  1017af:	90                   	nop

001017b0 <pic_init>:

/* Initialize the 8259A interrupt controllers. */
void
pic_init(void)
{
	if (pic_inited == TRUE)		// only do once on bootstrap CPU
  1017b0:	80 3d 64 ce 12 00 01 	cmpb   $0x1,0x12ce64
  1017b7:	0f 84 4d 01 00 00    	je     10190a <pic_init+0x15a>
static bool pic_inited = FALSE;

/* Initialize the 8259A interrupt controllers. */
void
pic_init(void)
{
  1017bd:	83 ec 1c             	sub    $0x1c,%esp
	if (pic_inited == TRUE)		// only do once on bootstrap CPU
		return;
	pic_inited = TRUE;

	/* mask all interrupts */
	outb(IO_PIC1+1, 0xff);
  1017c0:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
  1017c7:	00 
  1017c8:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
void
pic_init(void)
{
	if (pic_inited == TRUE)		// only do once on bootstrap CPU
		return;
	pic_inited = TRUE;
  1017cf:	c6 05 64 ce 12 00 01 	movb   $0x1,0x12ce64

	/* mask all interrupts */
	outb(IO_PIC1+1, 0xff);
  1017d6:	e8 65 31 00 00       	call   104940 <outb>
	outb(IO_PIC2+1, 0xff);
  1017db:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
  1017e2:	00 
  1017e3:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
  1017ea:	e8 51 31 00 00       	call   104940 <outb>

	// ICW1:  0001g0hi
	//    g:  0 = edge triggering, 1 = level triggering
	//    h:  0 = cascaded PICs, 1 = master only
	//    i:  0 = no ICW4, 1 = ICW4 required
	outb(IO_PIC1, 0x11);
  1017ef:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
  1017f6:	00 
  1017f7:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1017fe:	e8 3d 31 00 00       	call   104940 <outb>

	// ICW2:  Vector offset
	outb(IO_PIC1+1, T_IRQ0);
  101803:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  10180a:	00 
  10180b:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
  101812:	e8 29 31 00 00       	call   104940 <outb>

	// ICW3:  bit mask of IR lines connected to slave PICs (master PIC),
	//        3-bit No of IR line at which slave connects to master(slave PIC).
	outb(IO_PIC1+1, 1<<IRQ_SLAVE);
  101817:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
  10181e:	00 
  10181f:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
  101826:	e8 15 31 00 00       	call   104940 <outb>
	//    m:  0 = slave PIC, 1 = master PIC
	//	  (ignored when b is 0, as the master/slave role
	//	  can be hardwired).
	//    a:  1 = Automatic EOI mode
	//    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
	outb(IO_PIC1+1, 0x1);
  10182b:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  101832:	00 
  101833:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
  10183a:	e8 01 31 00 00       	call   104940 <outb>

	// Set up slave (8259A-2)
	outb(IO_PIC2, 0x11);			// ICW1
  10183f:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
  101846:	00 
  101847:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
  10184e:	e8 ed 30 00 00       	call   104940 <outb>
	outb(IO_PIC2+1, T_IRQ0 + 8);		// ICW2
  101853:	c7 44 24 04 28 00 00 	movl   $0x28,0x4(%esp)
  10185a:	00 
  10185b:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
  101862:	e8 d9 30 00 00       	call   104940 <outb>
	outb(IO_PIC2+1, IRQ_SLAVE);		// ICW3
  101867:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  10186e:	00 
  10186f:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
  101876:	e8 c5 30 00 00       	call   104940 <outb>
	// NB Automatic EOI mode doesn't tend to work on the slave.
	// Linux source code says it's "to be investigated".
	outb(IO_PIC2+1, 0x01);			// ICW4
  10187b:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  101882:	00 
  101883:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
  10188a:	e8 b1 30 00 00       	call   104940 <outb>

	// OCW3:  0ef01prs
	//   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
	//    p:  0 = no polling, 1 = polling mode
	//   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
	outb(IO_PIC1, 0x68);             /* clear specific mask */
  10188f:	c7 44 24 04 68 00 00 	movl   $0x68,0x4(%esp)
  101896:	00 
  101897:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  10189e:	e8 9d 30 00 00       	call   104940 <outb>
	outb(IO_PIC1, 0x0a);             /* read IRR by default */
  1018a3:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
  1018aa:	00 
  1018ab:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1018b2:	e8 89 30 00 00       	call   104940 <outb>

	outb(IO_PIC2, 0x68);               /* OCW3 */
  1018b7:	c7 44 24 04 68 00 00 	movl   $0x68,0x4(%esp)
  1018be:	00 
  1018bf:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
  1018c6:	e8 75 30 00 00       	call   104940 <outb>
	outb(IO_PIC2, 0x0a);               /* OCW3 */
  1018cb:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
  1018d2:	00 
  1018d3:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
  1018da:	e8 61 30 00 00       	call   104940 <outb>

	// mask all interrupts
	outb(IO_PIC1+1, 0xFF);
  1018df:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
  1018e6:	00 
  1018e7:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
  1018ee:	e8 4d 30 00 00       	call   104940 <outb>
	outb(IO_PIC2+1, 0xFF);
  1018f3:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
  1018fa:	00 
  1018fb:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
  101902:	e8 39 30 00 00       	call   104940 <outb>
}
  101907:	83 c4 1c             	add    $0x1c,%esp
  10190a:	f3 c3                	repz ret 
  10190c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00101910 <pic_setmask>:

void
pic_setmask(uint16_t mask)
{
  101910:	53                   	push   %ebx
  101911:	83 ec 18             	sub    $0x18,%esp
  101914:	8b 5c 24 20          	mov    0x20(%esp),%ebx
	irqmask = mask;
	outb(IO_PIC1+1, (char)mask);
  101918:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
  10191f:	0f b6 c3             	movzbl %bl,%eax
  101922:	89 44 24 04          	mov    %eax,0x4(%esp)
}

void
pic_setmask(uint16_t mask)
{
	irqmask = mask;
  101926:	66 89 1d 08 d3 10 00 	mov    %bx,0x10d308
	outb(IO_PIC1+1, (char)mask);
	outb(IO_PIC2+1, (char)(mask >> 8));
  10192d:	0f b6 df             	movzbl %bh,%ebx

void
pic_setmask(uint16_t mask)
{
	irqmask = mask;
	outb(IO_PIC1+1, (char)mask);
  101930:	e8 0b 30 00 00       	call   104940 <outb>
	outb(IO_PIC2+1, (char)(mask >> 8));
  101935:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  101939:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
  101940:	e8 fb 2f 00 00       	call   104940 <outb>
}
  101945:	83 c4 18             	add    $0x18,%esp
  101948:	5b                   	pop    %ebx
  101949:	c3                   	ret    
  10194a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00101950 <pic_enable>:

void
pic_enable(int irq)
{
	pic_setmask(irqmask & ~(1 << irq));
  101950:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  101954:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
  101959:	d3 c0                	rol    %cl,%eax
  10195b:	66 23 05 08 d3 10 00 	and    0x10d308,%ax
  101962:	0f b7 c0             	movzwl %ax,%eax
  101965:	89 44 24 04          	mov    %eax,0x4(%esp)
  101969:	e9 a2 ff ff ff       	jmp    101910 <pic_setmask>
  10196e:	66 90                	xchg   %ax,%ax

00101970 <pic_eoi>:
}

void
pic_eoi(void)
{
  101970:	83 ec 1c             	sub    $0x1c,%esp
	// OCW2: rse00xxx
	//   r: rotate
	//   s: specific
	//   e: end-of-interrupt
	// xxx: specific interrupt line
	outb(IO_PIC1, 0x20);
  101973:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  10197a:	00 
  10197b:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  101982:	e8 b9 2f 00 00       	call   104940 <outb>
	outb(IO_PIC2, 0x20);
  101987:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  10198e:	00 
  10198f:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
  101996:	e8 a5 2f 00 00       	call   104940 <outb>
}
  10199b:	83 c4 1c             	add    $0x1c,%esp
  10199e:	c3                   	ret    
  10199f:	90                   	nop

001019a0 <pic_reset>:

void
pic_reset(void)
{
  1019a0:	83 ec 1c             	sub    $0x1c,%esp
	// mask all interrupts
	outb(IO_PIC1+1, 0x00);
  1019a3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1019aa:	00 
  1019ab:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
  1019b2:	e8 89 2f 00 00       	call   104940 <outb>
	outb(IO_PIC2+1, 0x00);
  1019b7:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1019be:	00 
  1019bf:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
  1019c6:	e8 75 2f 00 00       	call   104940 <outb>

	// ICW1:  0001g0hi
	//    g:  0 = edge triggering, 1 = level triggering
	//    h:  0 = cascaded PICs, 1 = master only
	//    i:  0 = no ICW4, 1 = ICW4 required
	outb(IO_PIC1, 0x11);
  1019cb:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
  1019d2:	00 
  1019d3:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1019da:	e8 61 2f 00 00       	call   104940 <outb>

	// ICW2:  Vector offset
	outb(IO_PIC1+1, T_IRQ0);
  1019df:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  1019e6:	00 
  1019e7:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
  1019ee:	e8 4d 2f 00 00       	call   104940 <outb>

	// ICW3:  bit mask of IR lines connected to slave PICs (master PIC),
	//        3-bit No of IR line at which slave connects to master(slave PIC).
	outb(IO_PIC1+1, 1<<IRQ_SLAVE);
  1019f3:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
  1019fa:	00 
  1019fb:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
  101a02:	e8 39 2f 00 00       	call   104940 <outb>
	//    m:  0 = slave PIC, 1 = master PIC
	//	  (ignored when b is 0, as the master/slave role
	//	  can be hardwired).
	//    a:  1 = Automatic EOI mode
	//    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
	outb(IO_PIC1+1, 0x3);
  101a07:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
  101a0e:	00 
  101a0f:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
  101a16:	e8 25 2f 00 00       	call   104940 <outb>

	// Set up slave (8259A-2)
	outb(IO_PIC2, 0x11);			// ICW1
  101a1b:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
  101a22:	00 
  101a23:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
  101a2a:	e8 11 2f 00 00       	call   104940 <outb>
	outb(IO_PIC2+1, T_IRQ0 + 8);		// ICW2
  101a2f:	c7 44 24 04 28 00 00 	movl   $0x28,0x4(%esp)
  101a36:	00 
  101a37:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
  101a3e:	e8 fd 2e 00 00       	call   104940 <outb>
	outb(IO_PIC2+1, IRQ_SLAVE);		// ICW3
  101a43:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  101a4a:	00 
  101a4b:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
  101a52:	e8 e9 2e 00 00       	call   104940 <outb>
	// NB Automatic EOI mode doesn't tend to work on the slave.
	// Linux source code says it's "to be investigated".
	outb(IO_PIC2+1, 0x01);			// ICW4
  101a57:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  101a5e:	00 
  101a5f:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
  101a66:	e8 d5 2e 00 00       	call   104940 <outb>

	// OCW3:  0ef01prs
	//   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
	//    p:  0 = no polling, 1 = polling mode
	//   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
	outb(IO_PIC1, 0x68);             /* clear specific mask */
  101a6b:	c7 44 24 04 68 00 00 	movl   $0x68,0x4(%esp)
  101a72:	00 
  101a73:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  101a7a:	e8 c1 2e 00 00       	call   104940 <outb>
	outb(IO_PIC1, 0x0a);             /* read IRR by default */
  101a7f:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
  101a86:	00 
  101a87:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  101a8e:	e8 ad 2e 00 00       	call   104940 <outb>

	outb(IO_PIC2, 0x68);               /* OCW3 */
  101a93:	c7 44 24 04 68 00 00 	movl   $0x68,0x4(%esp)
  101a9a:	00 
  101a9b:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
  101aa2:	e8 99 2e 00 00       	call   104940 <outb>
	outb(IO_PIC2, 0x0a);               /* OCW3 */
  101aa7:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
  101aae:	00 
  101aaf:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
  101ab6:	e8 85 2e 00 00       	call   104940 <outb>
}
  101abb:	83 c4 1c             	add    $0x1c,%esp
  101abe:	c3                   	ret    
  101abf:	90                   	nop

00101ac0 <timer_hw_init>:

// Initialize the programmable interval timer.

void
timer_hw_init(void)
{
  101ac0:	83 ec 1c             	sub    $0x1c,%esp
	outb(PIT_CONTROL, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  101ac3:	c7 44 24 04 34 00 00 	movl   $0x34,0x4(%esp)
  101aca:	00 
  101acb:	c7 04 24 43 00 00 00 	movl   $0x43,(%esp)
  101ad2:	e8 69 2e 00 00       	call   104940 <outb>
	outb(PIT_CHANNEL0, LOW8(LATCH));
  101ad7:	c7 44 24 04 9c 00 00 	movl   $0x9c,0x4(%esp)
  101ade:	00 
  101adf:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
  101ae6:	e8 55 2e 00 00       	call   104940 <outb>
	outb(PIT_CHANNEL0, HIGH8(LATCH));
  101aeb:	c7 44 24 04 2e 00 00 	movl   $0x2e,0x4(%esp)
  101af2:	00 
  101af3:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
  101afa:	e8 41 2e 00 00       	call   104940 <outb>
}
  101aff:	83 c4 1c             	add    $0x1c,%esp
  101b02:	c3                   	ret    
  101b03:	66 90                	xchg   %ax,%ax
  101b05:	66 90                	xchg   %ax,%ax
  101b07:	66 90                	xchg   %ax,%ax
  101b09:	66 90                	xchg   %ax,%ax
  101b0b:	66 90                	xchg   %ax,%ax
  101b0d:	66 90                	xchg   %ax,%ax
  101b0f:	90                   	nop

00101b10 <tsc_init>:
	return delta / ms;
}

int
tsc_init(void)
{
  101b10:	55                   	push   %ebp
  101b11:	57                   	push   %edi
  101b12:	56                   	push   %esi
  101b13:	53                   	push   %ebx
  101b14:	83 ec 4c             	sub    $0x4c,%esp
	uint64_t ret;
	int i;

	timer_hw_init();
  101b17:	e8 a4 ff ff ff       	call   101ac0 <timer_hw_init>

	tsc_per_ms = 0;
  101b1c:	c7 05 00 88 9b 00 00 	movl   $0x0,0x9b8800
  101b23:	00 00 00 

	/*
	 * XXX: If TSC calibration fails frequently, try to increase the
	 *      upperbound of loop condition, e.g. alternating 3 to 10.
	 */
	for (i = 0; i < 10; i++) {
  101b26:	c7 44 24 34 00 00 00 	movl   $0x0,0x34(%esp)
  101b2d:	00 
	uint64_t ret;
	int i;

	timer_hw_init();

	tsc_per_ms = 0;
  101b2e:	c7 05 04 88 9b 00 00 	movl   $0x0,0x9b8804
  101b35:	00 00 00 
{
	uint64_t tsc, t1, t2, delta, tscmin, tscmax;;
	int pitcnt;

	/* Set the Gate high, disable speaker */
	outb(0x61, (inb(0x61) & ~0x02) | 0x01);
  101b38:	c7 04 24 61 00 00 00 	movl   $0x61,(%esp)
	outb(0x42, latch & 0xff);
	outb(0x42, latch >> 8);

	tsc = t1 = t2 = rdtsc();

	pitcnt = 0;
  101b3f:	31 ff                	xor    %edi,%edi
	tscmax = 0;
  101b41:	31 ed                	xor    %ebp,%ebp
{
	uint64_t tsc, t1, t2, delta, tscmin, tscmax;;
	int pitcnt;

	/* Set the Gate high, disable speaker */
	outb(0x61, (inb(0x61) & ~0x02) | 0x01);
  101b43:	e8 c8 2d 00 00       	call   104910 <inb>
  101b48:	c7 04 24 61 00 00 00 	movl   $0x61,(%esp)
  101b4f:	25 fc 00 00 00       	and    $0xfc,%eax
  101b54:	83 c8 01             	or     $0x1,%eax
  101b57:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b5b:	e8 e0 2d 00 00       	call   104940 <outb>
	/*
	 * Setup CTC channel 2 for mode 0, (interrupt on terminal
	 * count mode), binary count. Set the latch register to 50ms
	 * (LSB then MSB) to begin countdown.
	 */
	outb(0x43, 0xb0);
  101b60:	c7 44 24 04 b0 00 00 	movl   $0xb0,0x4(%esp)
  101b67:	00 
  101b68:	c7 04 24 43 00 00 00 	movl   $0x43,(%esp)
  101b6f:	e8 cc 2d 00 00       	call   104940 <outb>
	outb(0x42, latch & 0xff);
  101b74:	c7 44 24 04 9b 00 00 	movl   $0x9b,0x4(%esp)
  101b7b:	00 
  101b7c:	c7 04 24 42 00 00 00 	movl   $0x42,(%esp)
  101b83:	e8 b8 2d 00 00       	call   104940 <outb>
	outb(0x42, latch >> 8);
  101b88:	c7 44 24 04 2e 00 00 	movl   $0x2e,0x4(%esp)
  101b8f:	00 
  101b90:	c7 04 24 42 00 00 00 	movl   $0x42,(%esp)
  101b97:	e8 a4 2d 00 00       	call   104940 <outb>

	tsc = t1 = t2 = rdtsc();
  101b9c:	e8 9f 2b 00 00       	call   104740 <rdtsc>

	pitcnt = 0;
	tscmax = 0;
  101ba1:	c7 44 24 30 00 00 00 	movl   $0x0,0x30(%esp)
  101ba8:	00 
	tscmin = ~(uint64_t) 0x0;
  101ba9:	c7 44 24 2c ff ff ff 	movl   $0xffffffff,0x2c(%esp)
  101bb0:	ff 
  101bb1:	c7 44 24 24 ff ff ff 	movl   $0xffffffff,0x24(%esp)
  101bb8:	ff 
	 */
	outb(0x43, 0xb0);
	outb(0x42, latch & 0xff);
	outb(0x42, latch >> 8);

	tsc = t1 = t2 = rdtsc();
  101bb9:	89 c3                	mov    %eax,%ebx
  101bbb:	89 44 24 38          	mov    %eax,0x38(%esp)
  101bbf:	89 f8                	mov    %edi,%eax
  101bc1:	89 de                	mov    %ebx,%esi
  101bc3:	89 54 24 3c          	mov    %edx,0x3c(%esp)
  101bc7:	89 d7                	mov    %edx,%edi
  101bc9:	89 44 24 28          	mov    %eax,0x28(%esp)
  101bcd:	eb 43                	jmp    101c12 <tsc_init+0x102>
  101bcf:	90                   	nop

	pitcnt = 0;
	tscmax = 0;
	tscmin = ~(uint64_t) 0x0;
	while ((inb(0x61) & 0x20) == 0) {
		t2 = rdtsc();
  101bd0:	e8 6b 2b 00 00       	call   104740 <rdtsc>
		delta = t2 - tsc;
  101bd5:	89 c1                	mov    %eax,%ecx
  101bd7:	89 d3                	mov    %edx,%ebx
  101bd9:	29 f1                	sub    %esi,%ecx
  101bdb:	19 fb                	sbb    %edi,%ebx
  101bdd:	89 ce                	mov    %ecx,%esi
  101bdf:	39 5c 24 24          	cmp    %ebx,0x24(%esp)
  101be3:	89 df                	mov    %ebx,%edi
  101be5:	72 10                	jb     101bf7 <tsc_init+0xe7>
  101be7:	77 06                	ja     101bef <tsc_init+0xdf>
  101be9:	39 4c 24 2c          	cmp    %ecx,0x2c(%esp)
  101bed:	76 08                	jbe    101bf7 <tsc_init+0xe7>
  101bef:	89 74 24 2c          	mov    %esi,0x2c(%esp)
  101bf3:	89 7c 24 24          	mov    %edi,0x24(%esp)
  101bf7:	39 fd                	cmp    %edi,%ebp
  101bf9:	77 0e                	ja     101c09 <tsc_init+0xf9>
  101bfb:	72 06                	jb     101c03 <tsc_init+0xf3>
  101bfd:	39 74 24 30          	cmp    %esi,0x30(%esp)
  101c01:	73 06                	jae    101c09 <tsc_init+0xf9>
  101c03:	89 74 24 30          	mov    %esi,0x30(%esp)
  101c07:	89 fd                	mov    %edi,%ebp
		tsc = t2;
		if (delta < tscmin)
			tscmin = delta;
		if (delta > tscmax)
			tscmax = delta;
		pitcnt++;
  101c09:	83 44 24 28 01       	addl   $0x1,0x28(%esp)
	tscmax = 0;
	tscmin = ~(uint64_t) 0x0;
	while ((inb(0x61) & 0x20) == 0) {
		t2 = rdtsc();
		delta = t2 - tsc;
		tsc = t2;
  101c0e:	89 c6                	mov    %eax,%esi
  101c10:	89 d7                	mov    %edx,%edi
	tsc = t1 = t2 = rdtsc();

	pitcnt = 0;
	tscmax = 0;
	tscmin = ~(uint64_t) 0x0;
	while ((inb(0x61) & 0x20) == 0) {
  101c12:	c7 04 24 61 00 00 00 	movl   $0x61,(%esp)
  101c19:	e8 f2 2c 00 00       	call   104910 <inb>
  101c1e:	a8 20                	test   $0x20,%al
  101c20:	74 ae                	je     101bd0 <tsc_init+0xc0>
  101c22:	8b 44 24 28          	mov    0x28(%esp),%eax
  101c26:	89 f3                	mov    %esi,%ebx
  101c28:	89 fe                	mov    %edi,%esi
	 * times, then we have been hit by a massive SMI
	 *
	 * If the maximum is 10 times larger than the minimum,
	 * then we got hit by an SMI as well.
	 */
	KERN_DEBUG("pitcnt=%u, tscmin=%llu, tscmax=%llu\n",
  101c2a:	89 6c 24 1c          	mov    %ebp,0x1c(%esp)
  101c2e:	c7 44 24 08 88 80 10 	movl   $0x108088,0x8(%esp)
  101c35:	00 
  101c36:	c7 44 24 04 3a 00 00 	movl   $0x3a,0x4(%esp)
  101c3d:	00 
  101c3e:	89 c7                	mov    %eax,%edi
  101c40:	8b 44 24 30          	mov    0x30(%esp),%eax
  101c44:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  101c48:	c7 04 24 ad 80 10 00 	movl   $0x1080ad,(%esp)
  101c4f:	89 44 24 18          	mov    %eax,0x18(%esp)
  101c53:	8b 44 24 2c          	mov    0x2c(%esp),%eax
  101c57:	89 44 24 10          	mov    %eax,0x10(%esp)
  101c5b:	8b 44 24 24          	mov    0x24(%esp),%eax
  101c5f:	89 44 24 14          	mov    %eax,0x14(%esp)
  101c63:	e8 c8 1d 00 00       	call   103a30 <debug_normal>
		   pitcnt, tscmin, tscmax);
	if (pitcnt < loopmin || tscmax > 10 * tscmin)
  101c68:	81 ff e7 03 00 00    	cmp    $0x3e7,%edi
  101c6e:	0f 8f 94 00 00 00    	jg     101d08 <tsc_init+0x1f8>
	 */
	for (i = 0; i < 10; i++) {
		ret = tsc_calibrate(CAL_LATCH, CAL_MS, CAL_PIT_LOOPS);
		if (ret != ~(uint64_t) 0x0)
			break;
		KERN_DEBUG("[%d] Retry to calibrate TSC.\n", i+1);
  101c74:	83 44 24 34 01       	addl   $0x1,0x34(%esp)
  101c79:	8b 7c 24 34          	mov    0x34(%esp),%edi
  101c7d:	c7 44 24 08 04 81 10 	movl   $0x108104,0x8(%esp)
  101c84:	00 
  101c85:	c7 44 24 04 55 00 00 	movl   $0x55,0x4(%esp)
  101c8c:	00 
  101c8d:	c7 04 24 ad 80 10 00 	movl   $0x1080ad,(%esp)
  101c94:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  101c98:	e8 93 1d 00 00       	call   103a30 <debug_normal>

	/*
	 * XXX: If TSC calibration fails frequently, try to increase the
	 *      upperbound of loop condition, e.g. alternating 3 to 10.
	 */
	for (i = 0; i < 10; i++) {
  101c9d:	83 ff 0a             	cmp    $0xa,%edi
  101ca0:	0f 85 92 fe ff ff    	jne    101b38 <tsc_init+0x28>
			break;
		KERN_DEBUG("[%d] Retry to calibrate TSC.\n", i+1);
	}

	if (ret == ~(uint64_t) 0x0) {
		KERN_DEBUG("TSC calibration failed.\n");
  101ca6:	c7 44 24 08 d1 80 10 	movl   $0x1080d1,0x8(%esp)
  101cad:	00 
  101cae:	c7 44 24 04 59 00 00 	movl   $0x59,0x4(%esp)
  101cb5:	00 
  101cb6:	c7 04 24 ad 80 10 00 	movl   $0x1080ad,(%esp)
  101cbd:	e8 6e 1d 00 00       	call   103a30 <debug_normal>
		KERN_DEBUG("Assume TSC freq = 1 GHz.\n");
  101cc2:	c7 44 24 08 ea 80 10 	movl   $0x1080ea,0x8(%esp)
  101cc9:	00 
  101cca:	c7 44 24 04 5a 00 00 	movl   $0x5a,0x4(%esp)
  101cd1:	00 
  101cd2:	c7 04 24 ad 80 10 00 	movl   $0x1080ad,(%esp)
  101cd9:	e8 52 1d 00 00       	call   103a30 <debug_normal>
		tsc_per_ms = 1000000;
  101cde:	c7 05 00 88 9b 00 40 	movl   $0xf4240,0x9b8800
  101ce5:	42 0f 00 
  101ce8:	c7 05 04 88 9b 00 00 	movl   $0x0,0x9b8804
  101cef:	00 00 00 

		timer_hw_init();
  101cf2:	e8 c9 fd ff ff       	call   101ac0 <timer_hw_init>
		KERN_DEBUG("TSC freq = %llu Hz.\n", tsc_per_ms*1000);

		timer_hw_init();
		return 0;
	}
}
  101cf7:	83 c4 4c             	add    $0x4c,%esp
		KERN_DEBUG("TSC calibration failed.\n");
		KERN_DEBUG("Assume TSC freq = 1 GHz.\n");
		tsc_per_ms = 1000000;

		timer_hw_init();
		return 1;
  101cfa:	b8 01 00 00 00       	mov    $0x1,%eax
		KERN_DEBUG("TSC freq = %llu Hz.\n", tsc_per_ms*1000);

		timer_hw_init();
		return 0;
	}
}
  101cff:	5b                   	pop    %ebx
  101d00:	5e                   	pop    %esi
  101d01:	5f                   	pop    %edi
  101d02:	5d                   	pop    %ebp
  101d03:	c3                   	ret    
  101d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	 * If the maximum is 10 times larger than the minimum,
	 * then we got hit by an SMI as well.
	 */
	KERN_DEBUG("pitcnt=%u, tscmin=%llu, tscmax=%llu\n",
		   pitcnt, tscmin, tscmax);
	if (pitcnt < loopmin || tscmax > 10 * tscmin)
  101d08:	6b 7c 24 24 0a       	imul   $0xa,0x24(%esp),%edi
  101d0d:	b8 0a 00 00 00       	mov    $0xa,%eax
  101d12:	f7 64 24 2c          	mull   0x2c(%esp)
  101d16:	01 fa                	add    %edi,%edx
  101d18:	39 d5                	cmp    %edx,%ebp
  101d1a:	0f 87 54 ff ff ff    	ja     101c74 <tsc_init+0x164>
  101d20:	72 0a                	jb     101d2c <tsc_init+0x21c>
  101d22:	39 44 24 30          	cmp    %eax,0x30(%esp)
  101d26:	0f 87 48 ff ff ff    	ja     101c74 <tsc_init+0x164>
		return ~(uint64_t) 0x0;

	/* Calculate the PIT value */
	delta = t2 - t1;
  101d2c:	89 d8                	mov    %ebx,%eax
  101d2e:	89 f2                	mov    %esi,%edx
  101d30:	2b 44 24 38          	sub    0x38(%esp),%eax
  101d34:	1b 54 24 3c          	sbb    0x3c(%esp),%edx
	return delta / ms;
  101d38:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
  101d3f:	00 
  101d40:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  101d47:	00 
  101d48:	89 04 24             	mov    %eax,(%esp)
  101d4b:	89 54 24 04          	mov    %edx,0x4(%esp)
  101d4f:	e8 1c 5c 00 00       	call   107970 <__udivdi3>

		timer_hw_init();
		return 1;
	} else {
		tsc_per_ms = ret;
		KERN_DEBUG("TSC freq = %llu Hz.\n", tsc_per_ms*1000);
  101d54:	c7 44 24 08 bc 80 10 	movl   $0x1080bc,0x8(%esp)
  101d5b:	00 
  101d5c:	c7 44 24 04 61 00 00 	movl   $0x61,0x4(%esp)
  101d63:	00 
  101d64:	c7 04 24 ad 80 10 00 	movl   $0x1080ad,(%esp)
		tsc_per_ms = 1000000;

		timer_hw_init();
		return 1;
	} else {
		tsc_per_ms = ret;
  101d6b:	a3 00 88 9b 00       	mov    %eax,0x9b8800
  101d70:	89 15 04 88 9b 00    	mov    %edx,0x9b8804
		KERN_DEBUG("TSC freq = %llu Hz.\n", tsc_per_ms*1000);
  101d76:	a1 00 88 9b 00       	mov    0x9b8800,%eax
  101d7b:	8b 15 04 88 9b 00    	mov    0x9b8804,%edx
  101d81:	69 ca e8 03 00 00    	imul   $0x3e8,%edx,%ecx
  101d87:	ba e8 03 00 00       	mov    $0x3e8,%edx
  101d8c:	f7 e2                	mul    %edx
  101d8e:	01 ca                	add    %ecx,%edx
  101d90:	89 44 24 0c          	mov    %eax,0xc(%esp)
  101d94:	89 54 24 10          	mov    %edx,0x10(%esp)
  101d98:	e8 93 1c 00 00       	call   103a30 <debug_normal>

		timer_hw_init();
  101d9d:	e8 1e fd ff ff       	call   101ac0 <timer_hw_init>
		return 0;
	}
}
  101da2:	83 c4 4c             	add    $0x4c,%esp
	} else {
		tsc_per_ms = ret;
		KERN_DEBUG("TSC freq = %llu Hz.\n", tsc_per_ms*1000);

		timer_hw_init();
		return 0;
  101da5:	31 c0                	xor    %eax,%eax
	}
}
  101da7:	5b                   	pop    %ebx
  101da8:	5e                   	pop    %esi
  101da9:	5f                   	pop    %edi
  101daa:	5d                   	pop    %ebp
  101dab:	c3                   	ret    
  101dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00101db0 <delay>:
/*
 * Wait for ms millisecond.
 */
void
delay(uint32_t ms)
{
  101db0:	57                   	push   %edi
  101db1:	56                   	push   %esi
  101db2:	53                   	push   %ebx
  101db3:	83 ec 10             	sub    $0x10,%esp
	volatile uint64_t ticks = tsc_per_ms * ms;
  101db6:	a1 00 88 9b 00       	mov    0x9b8800,%eax
  101dbb:	8b 15 04 88 9b 00    	mov    0x9b8804,%edx
/*
 * Wait for ms millisecond.
 */
void
delay(uint32_t ms)
{
  101dc1:	8b 4c 24 20          	mov    0x20(%esp),%ecx
	volatile uint64_t ticks = tsc_per_ms * ms;
  101dc5:	89 d3                	mov    %edx,%ebx
  101dc7:	0f af d9             	imul   %ecx,%ebx
  101dca:	f7 e1                	mul    %ecx
  101dcc:	01 da                	add    %ebx,%edx
  101dce:	89 04 24             	mov    %eax,(%esp)
  101dd1:	89 54 24 04          	mov    %edx,0x4(%esp)
	volatile uint64_t start = rdtsc();
  101dd5:	e8 66 29 00 00       	call   104740 <rdtsc>
  101dda:	89 44 24 08          	mov    %eax,0x8(%esp)
  101dde:	89 54 24 0c          	mov    %edx,0xc(%esp)
  101de2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	while (rdtsc() < start + ticks);
  101de8:	e8 53 29 00 00       	call   104740 <rdtsc>
  101ded:	8b 74 24 08          	mov    0x8(%esp),%esi
  101df1:	8b 7c 24 0c          	mov    0xc(%esp),%edi
  101df5:	8b 0c 24             	mov    (%esp),%ecx
  101df8:	8b 5c 24 04          	mov    0x4(%esp),%ebx
  101dfc:	01 f1                	add    %esi,%ecx
  101dfe:	11 fb                	adc    %edi,%ebx
  101e00:	39 da                	cmp    %ebx,%edx
  101e02:	76 0c                	jbe    101e10 <delay+0x60>
}
  101e04:	83 c4 10             	add    $0x10,%esp
  101e07:	5b                   	pop    %ebx
  101e08:	5e                   	pop    %esi
  101e09:	5f                   	pop    %edi
  101e0a:	c3                   	ret    
  101e0b:	90                   	nop
  101e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
void
delay(uint32_t ms)
{
	volatile uint64_t ticks = tsc_per_ms * ms;
	volatile uint64_t start = rdtsc();
	while (rdtsc() < start + ticks);
  101e10:	72 d6                	jb     101de8 <delay+0x38>
  101e12:	39 c8                	cmp    %ecx,%eax
  101e14:	72 d2                	jb     101de8 <delay+0x38>
}
  101e16:	83 c4 10             	add    $0x10,%esp
  101e19:	5b                   	pop    %ebx
  101e1a:	5e                   	pop    %esi
  101e1b:	5f                   	pop    %edi
  101e1c:	c3                   	ret    
  101e1d:	8d 76 00             	lea    0x0(%esi),%esi

00101e20 <udelay>:
/*
 * Wait for us microsecond.
 */
void
udelay(uint32_t us)
{
  101e20:	57                   	push   %edi
  101e21:	56                   	push   %esi
  101e22:	53                   	push   %ebx
  101e23:	83 ec 20             	sub    $0x20,%esp
    volatile uint64_t ticks = tsc_per_ms / 1000 * us;
  101e26:	8b 0d 00 88 9b 00    	mov    0x9b8800,%ecx
  101e2c:	8b 1d 04 88 9b 00    	mov    0x9b8804,%ebx
  101e32:	c7 44 24 08 e8 03 00 	movl   $0x3e8,0x8(%esp)
  101e39:	00 
/*
 * Wait for us microsecond.
 */
void
udelay(uint32_t us)
{
  101e3a:	8b 74 24 30          	mov    0x30(%esp),%esi
    volatile uint64_t ticks = tsc_per_ms / 1000 * us;
  101e3e:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  101e45:	00 
  101e46:	89 0c 24             	mov    %ecx,(%esp)
  101e49:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  101e4d:	e8 1e 5b 00 00       	call   107970 <__udivdi3>
  101e52:	89 d1                	mov    %edx,%ecx
  101e54:	0f af ce             	imul   %esi,%ecx
  101e57:	f7 e6                	mul    %esi
  101e59:	01 ca                	add    %ecx,%edx
  101e5b:	89 44 24 10          	mov    %eax,0x10(%esp)
  101e5f:	89 54 24 14          	mov    %edx,0x14(%esp)
    volatile uint64_t start = rdtsc();
  101e63:	e8 d8 28 00 00       	call   104740 <rdtsc>
  101e68:	89 44 24 18          	mov    %eax,0x18(%esp)
  101e6c:	89 54 24 1c          	mov    %edx,0x1c(%esp)
    while (rdtsc() < start + ticks);
  101e70:	e8 cb 28 00 00       	call   104740 <rdtsc>
  101e75:	8b 74 24 18          	mov    0x18(%esp),%esi
  101e79:	8b 7c 24 1c          	mov    0x1c(%esp),%edi
  101e7d:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  101e81:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  101e85:	01 f1                	add    %esi,%ecx
  101e87:	11 fb                	adc    %edi,%ebx
  101e89:	39 da                	cmp    %ebx,%edx
  101e8b:	76 0b                	jbe    101e98 <udelay+0x78>
}
  101e8d:	83 c4 20             	add    $0x20,%esp
  101e90:	5b                   	pop    %ebx
  101e91:	5e                   	pop    %esi
  101e92:	5f                   	pop    %edi
  101e93:	c3                   	ret    
  101e94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
void
udelay(uint32_t us)
{
    volatile uint64_t ticks = tsc_per_ms / 1000 * us;
    volatile uint64_t start = rdtsc();
    while (rdtsc() < start + ticks);
  101e98:	72 d6                	jb     101e70 <udelay+0x50>
  101e9a:	39 c8                	cmp    %ecx,%eax
  101e9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101ea0:	72 ce                	jb     101e70 <udelay+0x50>
}
  101ea2:	83 c4 20             	add    $0x20,%esp
  101ea5:	5b                   	pop    %ebx
  101ea6:	5e                   	pop    %esi
  101ea7:	5f                   	pop    %edi
  101ea8:	c3                   	ret    
  101ea9:	66 90                	xchg   %ax,%ax
  101eab:	66 90                	xchg   %ax,%ax
  101ead:	66 90                	xchg   %ax,%ax
  101eaf:	90                   	nop

00101eb0 <Xdivide>:
	jmp _alltraps

.text

/* exceptions  */
TRAPHANDLER_NOEC(Xdivide,	T_DIVIDE)
  101eb0:	6a 00                	push   $0x0
  101eb2:	6a 00                	push   $0x0
  101eb4:	e9 67 01 00 00       	jmp    102020 <_alltraps>
  101eb9:	90                   	nop

00101eba <Xdebug>:
TRAPHANDLER_NOEC(Xdebug,	T_DEBUG)
  101eba:	6a 00                	push   $0x0
  101ebc:	6a 01                	push   $0x1
  101ebe:	e9 5d 01 00 00       	jmp    102020 <_alltraps>
  101ec3:	90                   	nop

00101ec4 <Xnmi>:
TRAPHANDLER_NOEC(Xnmi,		T_NMI)
  101ec4:	6a 00                	push   $0x0
  101ec6:	6a 02                	push   $0x2
  101ec8:	e9 53 01 00 00       	jmp    102020 <_alltraps>
  101ecd:	90                   	nop

00101ece <Xbrkpt>:
TRAPHANDLER_NOEC(Xbrkpt,	T_BRKPT)
  101ece:	6a 00                	push   $0x0
  101ed0:	6a 03                	push   $0x3
  101ed2:	e9 49 01 00 00       	jmp    102020 <_alltraps>
  101ed7:	90                   	nop

00101ed8 <Xoflow>:
TRAPHANDLER_NOEC(Xoflow,	T_OFLOW)
  101ed8:	6a 00                	push   $0x0
  101eda:	6a 04                	push   $0x4
  101edc:	e9 3f 01 00 00       	jmp    102020 <_alltraps>
  101ee1:	90                   	nop

00101ee2 <Xbound>:
TRAPHANDLER_NOEC(Xbound,	T_BOUND)
  101ee2:	6a 00                	push   $0x0
  101ee4:	6a 05                	push   $0x5
  101ee6:	e9 35 01 00 00       	jmp    102020 <_alltraps>
  101eeb:	90                   	nop

00101eec <Xillop>:
TRAPHANDLER_NOEC(Xillop,	T_ILLOP)
  101eec:	6a 00                	push   $0x0
  101eee:	6a 06                	push   $0x6
  101ef0:	e9 2b 01 00 00       	jmp    102020 <_alltraps>
  101ef5:	90                   	nop

00101ef6 <Xdevice>:
TRAPHANDLER_NOEC(Xdevice,	T_DEVICE)
  101ef6:	6a 00                	push   $0x0
  101ef8:	6a 07                	push   $0x7
  101efa:	e9 21 01 00 00       	jmp    102020 <_alltraps>
  101eff:	90                   	nop

00101f00 <Xdblflt>:
TRAPHANDLER     (Xdblflt,	T_DBLFLT)
  101f00:	6a 08                	push   $0x8
  101f02:	e9 19 01 00 00       	jmp    102020 <_alltraps>
  101f07:	90                   	nop

00101f08 <Xcoproc>:
TRAPHANDLER_NOEC(Xcoproc,	T_COPROC)
  101f08:	6a 00                	push   $0x0
  101f0a:	6a 09                	push   $0x9
  101f0c:	e9 0f 01 00 00       	jmp    102020 <_alltraps>
  101f11:	90                   	nop

00101f12 <Xtss>:
TRAPHANDLER     (Xtss,		T_TSS)
  101f12:	6a 0a                	push   $0xa
  101f14:	e9 07 01 00 00       	jmp    102020 <_alltraps>
  101f19:	90                   	nop

00101f1a <Xsegnp>:
TRAPHANDLER     (Xsegnp,	T_SEGNP)
  101f1a:	6a 0b                	push   $0xb
  101f1c:	e9 ff 00 00 00       	jmp    102020 <_alltraps>
  101f21:	90                   	nop

00101f22 <Xstack>:
TRAPHANDLER     (Xstack,	T_STACK)
  101f22:	6a 0c                	push   $0xc
  101f24:	e9 f7 00 00 00       	jmp    102020 <_alltraps>
  101f29:	90                   	nop

00101f2a <Xgpflt>:
TRAPHANDLER     (Xgpflt,	T_GPFLT)
  101f2a:	6a 0d                	push   $0xd
  101f2c:	e9 ef 00 00 00       	jmp    102020 <_alltraps>
  101f31:	90                   	nop

00101f32 <Xpgflt>:
TRAPHANDLER     (Xpgflt,	T_PGFLT)
  101f32:	6a 0e                	push   $0xe
  101f34:	e9 e7 00 00 00       	jmp    102020 <_alltraps>
  101f39:	90                   	nop

00101f3a <Xres>:
TRAPHANDLER_NOEC(Xres,		T_RES)
  101f3a:	6a 00                	push   $0x0
  101f3c:	6a 0f                	push   $0xf
  101f3e:	e9 dd 00 00 00       	jmp    102020 <_alltraps>
  101f43:	90                   	nop

00101f44 <Xfperr>:
TRAPHANDLER_NOEC(Xfperr,	T_FPERR)
  101f44:	6a 00                	push   $0x0
  101f46:	6a 10                	push   $0x10
  101f48:	e9 d3 00 00 00       	jmp    102020 <_alltraps>
  101f4d:	90                   	nop

00101f4e <Xalign>:
TRAPHANDLER     (Xalign,	T_ALIGN)
  101f4e:	6a 11                	push   $0x11
  101f50:	e9 cb 00 00 00       	jmp    102020 <_alltraps>
  101f55:	90                   	nop

00101f56 <Xmchk>:
TRAPHANDLER_NOEC(Xmchk,		T_MCHK)
  101f56:	6a 00                	push   $0x0
  101f58:	6a 12                	push   $0x12
  101f5a:	e9 c1 00 00 00       	jmp    102020 <_alltraps>
  101f5f:	90                   	nop

00101f60 <Xirq_timer>:

/* ISA interrupts  */
TRAPHANDLER_NOEC(Xirq_timer,	T_IRQ0 + IRQ_TIMER)
  101f60:	6a 00                	push   $0x0
  101f62:	6a 20                	push   $0x20
  101f64:	e9 b7 00 00 00       	jmp    102020 <_alltraps>
  101f69:	90                   	nop

00101f6a <Xirq_kbd>:
TRAPHANDLER_NOEC(Xirq_kbd,	T_IRQ0 + IRQ_KBD)
  101f6a:	6a 00                	push   $0x0
  101f6c:	6a 21                	push   $0x21
  101f6e:	e9 ad 00 00 00       	jmp    102020 <_alltraps>
  101f73:	90                   	nop

00101f74 <Xirq_slave>:
TRAPHANDLER_NOEC(Xirq_slave,	T_IRQ0 + IRQ_SLAVE)
  101f74:	6a 00                	push   $0x0
  101f76:	6a 22                	push   $0x22
  101f78:	e9 a3 00 00 00       	jmp    102020 <_alltraps>
  101f7d:	90                   	nop

00101f7e <Xirq_serial2>:
TRAPHANDLER_NOEC(Xirq_serial2,	T_IRQ0 + IRQ_SERIAL24)
  101f7e:	6a 00                	push   $0x0
  101f80:	6a 23                	push   $0x23
  101f82:	e9 99 00 00 00       	jmp    102020 <_alltraps>
  101f87:	90                   	nop

00101f88 <Xirq_serial1>:
TRAPHANDLER_NOEC(Xirq_serial1,	T_IRQ0 + IRQ_SERIAL13)
  101f88:	6a 00                	push   $0x0
  101f8a:	6a 24                	push   $0x24
  101f8c:	e9 8f 00 00 00       	jmp    102020 <_alltraps>
  101f91:	90                   	nop

00101f92 <Xirq_lpt>:
TRAPHANDLER_NOEC(Xirq_lpt,	T_IRQ0 + IRQ_LPT2)
  101f92:	6a 00                	push   $0x0
  101f94:	6a 25                	push   $0x25
  101f96:	e9 85 00 00 00       	jmp    102020 <_alltraps>
  101f9b:	90                   	nop

00101f9c <Xirq_floppy>:
TRAPHANDLER_NOEC(Xirq_floppy,	T_IRQ0 + IRQ_FLOPPY)
  101f9c:	6a 00                	push   $0x0
  101f9e:	6a 26                	push   $0x26
  101fa0:	e9 7b 00 00 00       	jmp    102020 <_alltraps>
  101fa5:	90                   	nop

00101fa6 <Xirq_spurious>:
TRAPHANDLER_NOEC(Xirq_spurious,	T_IRQ0 + IRQ_SPURIOUS)
  101fa6:	6a 00                	push   $0x0
  101fa8:	6a 27                	push   $0x27
  101faa:	e9 71 00 00 00       	jmp    102020 <_alltraps>
  101faf:	90                   	nop

00101fb0 <Xirq_rtc>:
TRAPHANDLER_NOEC(Xirq_rtc,	T_IRQ0 + IRQ_RTC)
  101fb0:	6a 00                	push   $0x0
  101fb2:	6a 28                	push   $0x28
  101fb4:	e9 67 00 00 00       	jmp    102020 <_alltraps>
  101fb9:	90                   	nop

00101fba <Xirq9>:
TRAPHANDLER_NOEC(Xirq9,		T_IRQ0 + 9)
  101fba:	6a 00                	push   $0x0
  101fbc:	6a 29                	push   $0x29
  101fbe:	e9 5d 00 00 00       	jmp    102020 <_alltraps>
  101fc3:	90                   	nop

00101fc4 <Xirq10>:
TRAPHANDLER_NOEC(Xirq10,	T_IRQ0 + 10)
  101fc4:	6a 00                	push   $0x0
  101fc6:	6a 2a                	push   $0x2a
  101fc8:	e9 53 00 00 00       	jmp    102020 <_alltraps>
  101fcd:	90                   	nop

00101fce <Xirq11>:
TRAPHANDLER_NOEC(Xirq11,	T_IRQ0 + 11)
  101fce:	6a 00                	push   $0x0
  101fd0:	6a 2b                	push   $0x2b
  101fd2:	e9 49 00 00 00       	jmp    102020 <_alltraps>
  101fd7:	90                   	nop

00101fd8 <Xirq_mouse>:
TRAPHANDLER_NOEC(Xirq_mouse,	T_IRQ0 + IRQ_MOUSE)
  101fd8:	6a 00                	push   $0x0
  101fda:	6a 2c                	push   $0x2c
  101fdc:	e9 3f 00 00 00       	jmp    102020 <_alltraps>
  101fe1:	90                   	nop

00101fe2 <Xirq_coproc>:
TRAPHANDLER_NOEC(Xirq_coproc,	T_IRQ0 + IRQ_COPROCESSOR)
  101fe2:	6a 00                	push   $0x0
  101fe4:	6a 2d                	push   $0x2d
  101fe6:	e9 35 00 00 00       	jmp    102020 <_alltraps>
  101feb:	90                   	nop

00101fec <Xirq_ide1>:
TRAPHANDLER_NOEC(Xirq_ide1,	T_IRQ0 + IRQ_IDE1)
  101fec:	6a 00                	push   $0x0
  101fee:	6a 2e                	push   $0x2e
  101ff0:	e9 2b 00 00 00       	jmp    102020 <_alltraps>
  101ff5:	90                   	nop

00101ff6 <Xirq_ide2>:
TRAPHANDLER_NOEC(Xirq_ide2,	T_IRQ0 + IRQ_IDE2)
  101ff6:	6a 00                	push   $0x0
  101ff8:	6a 2f                	push   $0x2f
  101ffa:	e9 21 00 00 00       	jmp    102020 <_alltraps>
  101fff:	90                   	nop

00102000 <Xsyscall>:

/* syscall */
TRAPHANDLER_NOEC(Xsyscall,	T_SYSCALL)
  102000:	6a 00                	push   $0x0
  102002:	6a 30                	push   $0x30
  102004:	e9 17 00 00 00       	jmp    102020 <_alltraps>
  102009:	90                   	nop

0010200a <Xdefault>:

/* default ? */
TRAPHANDLER     (Xdefault,	T_DEFAULT)
  10200a:	68 fe 00 00 00       	push   $0xfe
  10200f:	e9 0c 00 00 00       	jmp    102020 <_alltraps>
  102014:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10201a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00102020 <_alltraps>:

.globl	_alltraps
.type	_alltraps,@function
.p2align 4, 0x90		/* 16-byte alignment, nop filled */
_alltraps:
  cli			# make sure there is no nested trap
  102020:	fa                   	cli    

	cld
  102021:	fc                   	cld    

	pushl %ds		# build context
  102022:	1e                   	push   %ds
	pushl %es
  102023:	06                   	push   %es
	pushal
  102024:	60                   	pusha  

	movl $CPU_GDT_KDATA,%eax # load kernel's data segment
  102025:	b8 10 00 00 00       	mov    $0x10,%eax
	movw %ax,%ds
  10202a:	8e d8                	mov    %eax,%ds
	movw %ax,%es
  10202c:	8e c0                	mov    %eax,%es

	pushl %esp		# pass pointer to this trapframe
  10202e:	54                   	push   %esp
	call trap		# and call trap (does not return)
  10202f:	e8 ec 55 00 00       	call   107620 <trap>

1:	hlt			# should never get here; just spin...
  102034:	f4                   	hlt    
  102035:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102040 <trap_return>:
//
.globl	trap_return
.type	trap_return,@function
.p2align 4, 0x90		/* 16-byte alignment, nop filled */
trap_return:
	movl	4(%esp),%esp	// reset stack pointer to point to trap frame
  102040:	8b 64 24 04          	mov    0x4(%esp),%esp
	popal			// restore general-purpose registers except esp
  102044:	61                   	popa   
	popl	%es		// restore data segment registers
  102045:	07                   	pop    %es
	popl	%ds
  102046:	1f                   	pop    %ds
	addl	$8,%esp		// skip tf_trapno and tf_errcode
  102047:	83 c4 08             	add    $0x8,%esp
	iret			// return from trap handler
  10204a:	cf                   	iret   
  10204b:	66 90                	xchg   %ax,%ax
  10204d:	66 90                	xchg   %ax,%ax
  10204f:	90                   	nop

00102050 <acpi_probe_rsdp_aux>:
	return sum;
}

static acpi_rsdp_t *
acpi_probe_rsdp_aux(uint8_t *addr, int length)
{
  102050:	56                   	push   %esi
	uint8_t *e, *p;

	/* debug("Search %08x ~ %08x for RSDP\n", addr, addr+length); */
	e = addr + length;
  102051:	8d 34 10             	lea    (%eax,%edx,1),%esi
	for (p = addr; p < e; p += 16) {
  102054:	39 f0                	cmp    %esi,%eax
	return sum;
}

static acpi_rsdp_t *
acpi_probe_rsdp_aux(uint8_t *addr, int length)
{
  102056:	53                   	push   %ebx
	uint8_t *e, *p;

	/* debug("Search %08x ~ %08x for RSDP\n", addr, addr+length); */
	e = addr + length;
	for (p = addr; p < e; p += 16) {
  102057:	72 0e                	jb     102067 <acpi_probe_rsdp_aux+0x17>
  102059:	eb 3d                	jmp    102098 <acpi_probe_rsdp_aux+0x48>
  10205b:	90                   	nop
  10205c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102060:	83 c0 10             	add    $0x10,%eax
  102063:	39 c6                	cmp    %eax,%esi
  102065:	76 31                	jbe    102098 <acpi_probe_rsdp_aux+0x48>
		if (*(uint32_t *)p == ACPI_RSDP_SIG1 &&
  102067:	81 38 52 53 44 20    	cmpl   $0x20445352,(%eax)
  10206d:	75 f1                	jne    102060 <acpi_probe_rsdp_aux+0x10>
  10206f:	81 78 04 50 54 52 20 	cmpl   $0x20525450,0x4(%eax)
  102076:	75 e8                	jne    102060 <acpi_probe_rsdp_aux+0x10>
  102078:	31 d2                	xor    %edx,%edx
  10207a:	31 c9                	xor    %ecx,%ecx
  10207c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {

		sum += addr[i];
  102080:	0f b6 1c 08          	movzbl (%eax,%ecx,1),%ebx
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {
  102084:	83 c1 01             	add    $0x1,%ecx

		sum += addr[i];
  102087:	01 da                	add    %ebx,%edx
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {
  102089:	83 f9 24             	cmp    $0x24,%ecx
  10208c:	75 f2                	jne    102080 <acpi_probe_rsdp_aux+0x30>

	/* debug("Search %08x ~ %08x for RSDP\n", addr, addr+length); */
	e = addr + length;
	for (p = addr; p < e; p += 16) {
		if (*(uint32_t *)p == ACPI_RSDP_SIG1 &&
		    *(uint32_t *)(p + 4) == ACPI_RSDP_SIG2 &&
  10208e:	84 d2                	test   %dl,%dl
  102090:	75 ce                	jne    102060 <acpi_probe_rsdp_aux+0x10>
			return (acpi_rsdp_t *)p;
		}
	}

	return NULL;
}
  102092:	5b                   	pop    %ebx
  102093:	5e                   	pop    %esi
  102094:	c3                   	ret    
  102095:	8d 76 00             	lea    0x0(%esi),%esi
			/* debug("RSDP is at %08x\n", p); */
			return (acpi_rsdp_t *)p;
		}
	}

	return NULL;
  102098:	31 c0                	xor    %eax,%eax
}
  10209a:	5b                   	pop    %ebx
  10209b:	5e                   	pop    %esi
  10209c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1020a0:	c3                   	ret    
  1020a1:	eb 0d                	jmp    1020b0 <acpi_probe_rsdp>
  1020a3:	90                   	nop
  1020a4:	90                   	nop
  1020a5:	90                   	nop
  1020a6:	90                   	nop
  1020a7:	90                   	nop
  1020a8:	90                   	nop
  1020a9:	90                   	nop
  1020aa:	90                   	nop
  1020ab:	90                   	nop
  1020ac:	90                   	nop
  1020ad:	90                   	nop
  1020ae:	90                   	nop
  1020af:	90                   	nop

001020b0 <acpi_probe_rsdp>:
	uint8_t *bda;
	uint32_t p;
	acpi_rsdp_t *rsdp;

	bda = (uint8_t *) 0x400;
	if ((p = ((bda[0x0F] << 8) | bda[0x0E]) << 4)) {
  1020b0:	0f b6 05 0f 04 00 00 	movzbl 0x40f,%eax
  1020b7:	0f b6 15 0e 04 00 00 	movzbl 0x40e,%edx
  1020be:	c1 e0 08             	shl    $0x8,%eax
  1020c1:	09 d0                	or     %edx,%eax
  1020c3:	c1 e0 04             	shl    $0x4,%eax
  1020c6:	85 c0                	test   %eax,%eax
  1020c8:	74 16                	je     1020e0 <acpi_probe_rsdp+0x30>
		/* debug("Search RSDP from %08x\n", p); */
		if ((rsdp = acpi_probe_rsdp_aux((uint8_t *) p, 1024)))
  1020ca:	ba 00 04 00 00       	mov    $0x400,%edx
  1020cf:	e8 7c ff ff ff       	call   102050 <acpi_probe_rsdp_aux>
  1020d4:	85 c0                	test   %eax,%eax
  1020d6:	74 08                	je     1020e0 <acpi_probe_rsdp+0x30>
			return rsdp;
	}

	/* debug("Search RSDP from 0xE0000\n"); */
	return acpi_probe_rsdp_aux((uint8_t *) 0xE0000, 0x1FFFF);
}
  1020d8:	f3 c3                	repz ret 
  1020da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		if ((rsdp = acpi_probe_rsdp_aux((uint8_t *) p, 1024)))
			return rsdp;
	}

	/* debug("Search RSDP from 0xE0000\n"); */
	return acpi_probe_rsdp_aux((uint8_t *) 0xE0000, 0x1FFFF);
  1020e0:	ba ff ff 01 00       	mov    $0x1ffff,%edx
  1020e5:	b8 00 00 0e 00       	mov    $0xe0000,%eax
  1020ea:	e9 61 ff ff ff       	jmp    102050 <acpi_probe_rsdp_aux>
  1020ef:	90                   	nop

001020f0 <acpi_probe_rsdt>:
}

acpi_rsdt_t *
acpi_probe_rsdt(acpi_rsdp_t *rsdp)
{
  1020f0:	56                   	push   %esi
  1020f1:	53                   	push   %ebx
  1020f2:	83 ec 14             	sub    $0x14,%esp
  1020f5:	8b 5c 24 20          	mov    0x20(%esp),%ebx
	KERN_ASSERT(rsdp != NULL);
  1020f9:	85 db                	test   %ebx,%ebx
  1020fb:	74 40                	je     10213d <acpi_probe_rsdt+0x4d>

	acpi_rsdt_t *rsdt = (acpi_rsdt_t *)(rsdp->rsdt_addr);
  1020fd:	8b 73 10             	mov    0x10(%ebx),%esi
	/* KERN_DEBUG("rsdp->rsdt_addr = %08x\n", rsdt); */
	if (rsdt == NULL)
		return NULL;
  102100:	31 c0                	xor    %eax,%eax
{
	KERN_ASSERT(rsdp != NULL);

	acpi_rsdt_t *rsdt = (acpi_rsdt_t *)(rsdp->rsdt_addr);
	/* KERN_DEBUG("rsdp->rsdt_addr = %08x\n", rsdt); */
	if (rsdt == NULL)
  102102:	85 f6                	test   %esi,%esi
  102104:	74 2d                	je     102133 <acpi_probe_rsdt+0x43>
		return NULL;
	if (rsdt->sig == ACPI_RSDT_SIG &&
  102106:	81 3e 52 53 44 54    	cmpl   $0x54445352,(%esi)
  10210c:	75 25                	jne    102133 <acpi_probe_rsdt+0x43>
	    sum((uint8_t *)rsdt, rsdt->length) == 0) {
  10210e:	8b 5e 04             	mov    0x4(%esi),%ebx
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {
  102111:	85 db                	test   %ebx,%ebx
  102113:	7e 24                	jle    102139 <acpi_probe_rsdt+0x49>
  102115:	01 f3                	add    %esi,%ebx
  102117:	89 f0                	mov    %esi,%eax
static uint8_t
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
  102119:	31 d2                	xor    %edx,%edx
  10211b:	90                   	nop
  10211c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	for (i = 0; i < len; i++) {

		sum += addr[i];
  102120:	0f b6 08             	movzbl (%eax),%ecx
  102123:	83 c0 01             	add    $0x1,%eax
  102126:	01 ca                	add    %ecx,%edx
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {
  102128:	39 d8                	cmp    %ebx,%eax
  10212a:	75 f4                	jne    102120 <acpi_probe_rsdt+0x30>
	KERN_ASSERT(rsdp != NULL);

	acpi_rsdt_t *rsdt = (acpi_rsdt_t *)(rsdp->rsdt_addr);
	/* KERN_DEBUG("rsdp->rsdt_addr = %08x\n", rsdt); */
	if (rsdt == NULL)
		return NULL;
  10212c:	31 c0                	xor    %eax,%eax
  10212e:	84 d2                	test   %dl,%dl
  102130:	0f 44 c6             	cmove  %esi,%eax
		/* debug("RSDT is at %08x\n", rsdt); */
		return rsdt;
	}

	return NULL;
}
  102133:	83 c4 14             	add    $0x14,%esp
  102136:	5b                   	pop    %ebx
  102137:	5e                   	pop    %esi
  102138:	c3                   	ret    
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {
  102139:	89 f0                	mov    %esi,%eax
  10213b:	eb f6                	jmp    102133 <acpi_probe_rsdt+0x43>
}

acpi_rsdt_t *
acpi_probe_rsdt(acpi_rsdp_t *rsdp)
{
	KERN_ASSERT(rsdp != NULL);
  10213d:	c7 44 24 0c 22 81 10 	movl   $0x108122,0xc(%esp)
  102144:	00 
  102145:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  10214c:	00 
  10214d:	c7 44 24 04 3c 00 00 	movl   $0x3c,0x4(%esp)
  102154:	00 
  102155:	c7 04 24 2f 81 10 00 	movl   $0x10812f,(%esp)
  10215c:	e8 1f 19 00 00       	call   103a80 <debug_panic>
  102161:	eb 9a                	jmp    1020fd <acpi_probe_rsdt+0xd>
  102163:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102170 <acpi_probe_rsdt_ent>:
	return NULL;
}

acpi_sdt_hdr_t *
acpi_probe_rsdt_ent(acpi_rsdt_t *rsdt, const uint32_t sig)
{
  102170:	55                   	push   %ebp
  102171:	57                   	push   %edi
  102172:	56                   	push   %esi
  102173:	53                   	push   %ebx
  102174:	83 ec 2c             	sub    $0x2c,%esp
  102177:	8b 5c 24 40          	mov    0x40(%esp),%ebx
  10217b:	8b 6c 24 44          	mov    0x44(%esp),%ebp
	KERN_ASSERT(rsdt != NULL);
  10217f:	85 db                	test   %ebx,%ebx
  102181:	74 67                	je     1021ea <acpi_probe_rsdt_ent+0x7a>

	uint8_t * p = (uint8_t *)(&rsdt->ent[0]),
		* e = (uint8_t *)rsdt + rsdt->length;
  102183:	8b 43 04             	mov    0x4(%ebx),%eax
  102186:	01 d8                	add    %ebx,%eax
  102188:	89 c7                	mov    %eax,%edi
  10218a:	89 44 24 1c          	mov    %eax,0x1c(%esp)
acpi_sdt_hdr_t *
acpi_probe_rsdt_ent(acpi_rsdt_t *rsdt, const uint32_t sig)
{
	KERN_ASSERT(rsdt != NULL);

	uint8_t * p = (uint8_t *)(&rsdt->ent[0]),
  10218e:	8d 43 24             	lea    0x24(%ebx),%eax
		* e = (uint8_t *)rsdt + rsdt->length;

	/* debug("RSDT->entry is at %08x\n", rsdt->ent); */

	int i;
	for (i = 0; p < e; i++) {
  102191:	39 c7                	cmp    %eax,%edi
  102193:	77 11                	ja     1021a6 <acpi_probe_rsdt_ent+0x36>
  102195:	eb 49                	jmp    1021e0 <acpi_probe_rsdt_ent+0x70>
  102197:	90                   	nop
  102198:	8d 43 04             	lea    0x4(%ebx),%eax
  10219b:	83 c3 28             	add    $0x28,%ebx
  10219e:	39 5c 24 1c          	cmp    %ebx,0x1c(%esp)
  1021a2:	76 3c                	jbe    1021e0 <acpi_probe_rsdt_ent+0x70>
  1021a4:	89 c3                	mov    %eax,%ebx
		acpi_sdt_hdr_t *hdr = (acpi_sdt_hdr_t *)(rsdt->ent[i]);
  1021a6:	8b 7b 24             	mov    0x24(%ebx),%edi
		/* debug("RSDT entry (%08x): addr = %08x, sig = %08x, length = %x\n", &rsdt->ent[i], hdr, hdr->sig, hdr->length); */
		if (hdr->sig == sig &&
  1021a9:	39 2f                	cmp    %ebp,(%edi)
  1021ab:	75 eb                	jne    102198 <acpi_probe_rsdt_ent+0x28>
		    sum((uint8_t *)hdr, hdr->length) == 0) {
  1021ad:	8b 77 04             	mov    0x4(%edi),%esi
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {
  1021b0:	85 f6                	test   %esi,%esi
  1021b2:	7e 1c                	jle    1021d0 <acpi_probe_rsdt_ent+0x60>
  1021b4:	01 fe                	add    %edi,%esi
  1021b6:	89 f8                	mov    %edi,%eax
static uint8_t
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
  1021b8:	31 d2                	xor    %edx,%edx
  1021ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	for (i = 0; i < len; i++) {

		sum += addr[i];
  1021c0:	0f b6 08             	movzbl (%eax),%ecx
  1021c3:	83 c0 01             	add    $0x1,%eax
  1021c6:	01 ca                	add    %ecx,%edx
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {
  1021c8:	39 f0                	cmp    %esi,%eax
  1021ca:	75 f4                	jne    1021c0 <acpi_probe_rsdt_ent+0x50>

	int i;
	for (i = 0; p < e; i++) {
		acpi_sdt_hdr_t *hdr = (acpi_sdt_hdr_t *)(rsdt->ent[i]);
		/* debug("RSDT entry (%08x): addr = %08x, sig = %08x, length = %x\n", &rsdt->ent[i], hdr, hdr->sig, hdr->length); */
		if (hdr->sig == sig &&
  1021cc:	84 d2                	test   %dl,%dl
  1021ce:	75 c8                	jne    102198 <acpi_probe_rsdt_ent+0x28>
		}
		p = (uint8_t *)(&rsdt->ent[i+1]);
	}

	return NULL;
}
  1021d0:	83 c4 2c             	add    $0x2c,%esp

	/* debug("RSDT->entry is at %08x\n", rsdt->ent); */

	int i;
	for (i = 0; p < e; i++) {
		acpi_sdt_hdr_t *hdr = (acpi_sdt_hdr_t *)(rsdt->ent[i]);
  1021d3:	89 f8                	mov    %edi,%eax
		}
		p = (uint8_t *)(&rsdt->ent[i+1]);
	}

	return NULL;
}
  1021d5:	5b                   	pop    %ebx
  1021d6:	5e                   	pop    %esi
  1021d7:	5f                   	pop    %edi
  1021d8:	5d                   	pop    %ebp
  1021d9:	c3                   	ret    
  1021da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1021e0:	83 c4 2c             	add    $0x2c,%esp
			return hdr;
		}
		p = (uint8_t *)(&rsdt->ent[i+1]);
	}

	return NULL;
  1021e3:	31 c0                	xor    %eax,%eax
}
  1021e5:	5b                   	pop    %ebx
  1021e6:	5e                   	pop    %esi
  1021e7:	5f                   	pop    %edi
  1021e8:	5d                   	pop    %ebp
  1021e9:	c3                   	ret    
}

acpi_sdt_hdr_t *
acpi_probe_rsdt_ent(acpi_rsdt_t *rsdt, const uint32_t sig)
{
	KERN_ASSERT(rsdt != NULL);
  1021ea:	c7 44 24 0c 3f 81 10 	movl   $0x10813f,0xc(%esp)
  1021f1:	00 
  1021f2:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  1021f9:	00 
  1021fa:	c7 44 24 04 4e 00 00 	movl   $0x4e,0x4(%esp)
  102201:	00 
  102202:	c7 04 24 2f 81 10 00 	movl   $0x10812f,(%esp)
  102209:	e8 72 18 00 00       	call   103a80 <debug_panic>
  10220e:	e9 70 ff ff ff       	jmp    102183 <acpi_probe_rsdt_ent+0x13>
  102213:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102220 <acpi_probe_xsdt>:
	return NULL;
}

acpi_xsdt_t *
acpi_probe_xsdt(acpi_rsdp_t *rsdp)
{
  102220:	56                   	push   %esi
  102221:	53                   	push   %ebx
  102222:	83 ec 14             	sub    $0x14,%esp
  102225:	8b 5c 24 20          	mov    0x20(%esp),%ebx
	KERN_ASSERT(rsdp != NULL);
  102229:	85 db                	test   %ebx,%ebx
  10222b:	74 39                	je     102266 <acpi_probe_xsdt+0x46>

	acpi_xsdt_t *xsdt  = (acpi_xsdt_t *)(uintptr_t) rsdp->xsdt_addr;
  10222d:	8b 5b 18             	mov    0x18(%ebx),%ebx
	/* debug("rsdp->xsdt_addr = %08x\n", xsdt); */
	if (xsdt == NULL)
		return NULL;
  102230:	31 c0                	xor    %eax,%eax
{
	KERN_ASSERT(rsdp != NULL);

	acpi_xsdt_t *xsdt  = (acpi_xsdt_t *)(uintptr_t) rsdp->xsdt_addr;
	/* debug("rsdp->xsdt_addr = %08x\n", xsdt); */
	if (xsdt == NULL)
  102232:	85 db                	test   %ebx,%ebx
  102234:	74 26                	je     10225c <acpi_probe_xsdt+0x3c>
		return NULL;
	if (xsdt->sig == ACPI_XSDT_SIG &&
  102236:	81 3b 58 53 44 54    	cmpl   $0x54445358,(%ebx)
  10223c:	75 1e                	jne    10225c <acpi_probe_xsdt+0x3c>
	    sum((uint8_t *)xsdt, xsdt->length) == 0) {
  10223e:	8b 73 04             	mov    0x4(%ebx),%esi
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {
  102241:	85 f6                	test   %esi,%esi
  102243:	7e 1d                	jle    102262 <acpi_probe_xsdt+0x42>
static uint8_t
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
  102245:	31 d2                	xor    %edx,%edx
  102247:	90                   	nop
	for (i = 0; i < len; i++) {

		sum += addr[i];
  102248:	0f b6 0c 18          	movzbl (%eax,%ebx,1),%ecx
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {
  10224c:	83 c0 01             	add    $0x1,%eax

		sum += addr[i];
  10224f:	01 ca                	add    %ecx,%edx
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {
  102251:	39 c6                	cmp    %eax,%esi
  102253:	75 f3                	jne    102248 <acpi_probe_xsdt+0x28>
	KERN_ASSERT(rsdp != NULL);

	acpi_xsdt_t *xsdt  = (acpi_xsdt_t *)(uintptr_t) rsdp->xsdt_addr;
	/* debug("rsdp->xsdt_addr = %08x\n", xsdt); */
	if (xsdt == NULL)
		return NULL;
  102255:	31 c0                	xor    %eax,%eax
  102257:	84 d2                	test   %dl,%dl
  102259:	0f 44 c3             	cmove  %ebx,%eax
		/* debug("XSDT is at %08x\n", xsdt); */
		return xsdt;
	}

	return NULL;
}
  10225c:	83 c4 14             	add    $0x14,%esp
  10225f:	5b                   	pop    %ebx
  102260:	5e                   	pop    %esi
  102261:	c3                   	ret    
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {
  102262:	89 d8                	mov    %ebx,%eax
  102264:	eb f6                	jmp    10225c <acpi_probe_xsdt+0x3c>
}

acpi_xsdt_t *
acpi_probe_xsdt(acpi_rsdp_t *rsdp)
{
	KERN_ASSERT(rsdp != NULL);
  102266:	c7 44 24 0c 22 81 10 	movl   $0x108122,0xc(%esp)
  10226d:	00 
  10226e:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  102275:	00 
  102276:	c7 44 24 04 66 00 00 	movl   $0x66,0x4(%esp)
  10227d:	00 
  10227e:	c7 04 24 2f 81 10 00 	movl   $0x10812f,(%esp)
  102285:	e8 f6 17 00 00       	call   103a80 <debug_panic>
  10228a:	eb a1                	jmp    10222d <acpi_probe_xsdt+0xd>
  10228c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00102290 <acpi_probe_xsdt_ent>:
	return NULL;
}

acpi_sdt_hdr_t *
acpi_probe_xsdt_ent(acpi_xsdt_t *xsdt, const uint32_t sig)
{
  102290:	55                   	push   %ebp
  102291:	57                   	push   %edi
  102292:	56                   	push   %esi
  102293:	53                   	push   %ebx
  102294:	83 ec 2c             	sub    $0x2c,%esp
  102297:	8b 74 24 40          	mov    0x40(%esp),%esi
  10229b:	8b 6c 24 44          	mov    0x44(%esp),%ebp
	KERN_ASSERT(xsdt != NULL);
  10229f:	85 f6                	test   %esi,%esi
  1022a1:	74 5f                	je     102302 <acpi_probe_xsdt_ent+0x72>

	uint8_t * p = (uint8_t *)(&xsdt->ent[0]),
		* e = (uint8_t *)xsdt + xsdt->length;
  1022a3:	8b 46 04             	mov    0x4(%esi),%eax
  1022a6:	01 f0                	add    %esi,%eax
  1022a8:	89 c7                	mov    %eax,%edi
  1022aa:	89 44 24 1c          	mov    %eax,0x1c(%esp)
acpi_sdt_hdr_t *
acpi_probe_xsdt_ent(acpi_xsdt_t *xsdt, const uint32_t sig)
{
	KERN_ASSERT(xsdt != NULL);

	uint8_t * p = (uint8_t *)(&xsdt->ent[0]),
  1022ae:	8d 46 24             	lea    0x24(%esi),%eax
		* e = (uint8_t *)xsdt + xsdt->length;

	int i;
	for (i = 0; p < e; i++) {
  1022b1:	39 c7                	cmp    %eax,%edi
  1022b3:	77 11                	ja     1022c6 <acpi_probe_xsdt_ent+0x36>
  1022b5:	eb 41                	jmp    1022f8 <acpi_probe_xsdt_ent+0x68>
  1022b7:	90                   	nop
  1022b8:	8d 46 08             	lea    0x8(%esi),%eax
  1022bb:	83 c6 2c             	add    $0x2c,%esi
  1022be:	39 74 24 1c          	cmp    %esi,0x1c(%esp)
  1022c2:	76 34                	jbe    1022f8 <acpi_probe_xsdt_ent+0x68>
  1022c4:	89 c6                	mov    %eax,%esi
		acpi_sdt_hdr_t *hdr =
			(acpi_sdt_hdr_t *)(uintptr_t) (xsdt->ent[i]);
  1022c6:	8b 5e 24             	mov    0x24(%esi),%ebx
		/* debug("probe XSDT entry %d at %08x\n", i, hdr); */
		if (hdr->sig == sig &&
  1022c9:	39 2b                	cmp    %ebp,(%ebx)
  1022cb:	75 eb                	jne    1022b8 <acpi_probe_xsdt_ent+0x28>
		    sum((uint8_t *)hdr, hdr->length) == 0) {
  1022cd:	8b 7b 04             	mov    0x4(%ebx),%edi
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {
  1022d0:	85 ff                	test   %edi,%edi
  1022d2:	7e 15                	jle    1022e9 <acpi_probe_xsdt_ent+0x59>
static uint8_t
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
  1022d4:	31 d2                	xor    %edx,%edx
	for (i = 0; i < len; i++) {
  1022d6:	31 c0                	xor    %eax,%eax

		sum += addr[i];
  1022d8:	0f b6 0c 18          	movzbl (%eax,%ebx,1),%ecx
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {
  1022dc:	83 c0 01             	add    $0x1,%eax

		sum += addr[i];
  1022df:	01 ca                	add    %ecx,%edx
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++) {
  1022e1:	39 c7                	cmp    %eax,%edi
  1022e3:	75 f3                	jne    1022d8 <acpi_probe_xsdt_ent+0x48>
	int i;
	for (i = 0; p < e; i++) {
		acpi_sdt_hdr_t *hdr =
			(acpi_sdt_hdr_t *)(uintptr_t) (xsdt->ent[i]);
		/* debug("probe XSDT entry %d at %08x\n", i, hdr); */
		if (hdr->sig == sig &&
  1022e5:	84 d2                	test   %dl,%dl
  1022e7:	75 cf                	jne    1022b8 <acpi_probe_xsdt_ent+0x28>
		}
		p = (uint8_t *)(&xsdt->ent[i+1]);
	}

	return NULL;
}
  1022e9:	83 c4 2c             	add    $0x2c,%esp
	uint8_t * p = (uint8_t *)(&xsdt->ent[0]),
		* e = (uint8_t *)xsdt + xsdt->length;

	int i;
	for (i = 0; p < e; i++) {
		acpi_sdt_hdr_t *hdr =
  1022ec:	89 d8                	mov    %ebx,%eax
		}
		p = (uint8_t *)(&xsdt->ent[i+1]);
	}

	return NULL;
}
  1022ee:	5b                   	pop    %ebx
  1022ef:	5e                   	pop    %esi
  1022f0:	5f                   	pop    %edi
  1022f1:	5d                   	pop    %ebp
  1022f2:	c3                   	ret    
  1022f3:	90                   	nop
  1022f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1022f8:	83 c4 2c             	add    $0x2c,%esp
			return hdr;
		}
		p = (uint8_t *)(&xsdt->ent[i+1]);
	}

	return NULL;
  1022fb:	31 c0                	xor    %eax,%eax
}
  1022fd:	5b                   	pop    %ebx
  1022fe:	5e                   	pop    %esi
  1022ff:	5f                   	pop    %edi
  102300:	5d                   	pop    %ebp
  102301:	c3                   	ret    
}

acpi_sdt_hdr_t *
acpi_probe_xsdt_ent(acpi_xsdt_t *xsdt, const uint32_t sig)
{
	KERN_ASSERT(xsdt != NULL);
  102302:	c7 44 24 0c 4c 81 10 	movl   $0x10814c,0xc(%esp)
  102309:	00 
  10230a:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  102311:	00 
  102312:	c7 44 24 04 78 00 00 	movl   $0x78,0x4(%esp)
  102319:	00 
  10231a:	c7 04 24 2f 81 10 00 	movl   $0x10812f,(%esp)
  102321:	e8 5a 17 00 00       	call   103a80 <debug_panic>
  102326:	e9 78 ff ff ff       	jmp    1022a3 <acpi_probe_xsdt_ent+0x13>
  10232b:	66 90                	xchg   %ax,%ax
  10232d:	66 90                	xchg   %ax,%ax
  10232f:	90                   	nop

00102330 <lapic_register>:
}

void
lapic_register(uintptr_t lapic_addr)
{
	lapic = (lapic_t *) lapic_addr;
  102330:	8b 44 24 04          	mov    0x4(%esp),%eax
  102334:	a3 08 88 9b 00       	mov    %eax,0x9b8808
  102339:	c3                   	ret    
  10233a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102340 <lapic_init>:
/*
 * Initialize local APIC.
 */
void
lapic_init()
{
  102340:	55                   	push   %ebp
  102341:	57                   	push   %edi
  102342:	56                   	push   %esi
  102343:	53                   	push   %ebx
  102344:	83 ec 2c             	sub    $0x2c,%esp
	if (!lapic)
  102347:	a1 08 88 9b 00       	mov    0x9b8808,%eax
  10234c:	85 c0                	test   %eax,%eax
  10234e:	0f 84 b4 02 00 00    	je     102608 <lapic_init+0x2c8>

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  102354:	c7 80 f0 00 00 00 27 	movl   $0x127,0xf0(%eax)
  10235b:	01 00 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  10235e:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  102361:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
  102368:	00 00 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  10236b:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  10236e:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
  102375:	00 02 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  102378:	8b 50 20             	mov    0x20(%eax),%edx
	 * Calibrate the internal timer of LAPIC using TSC.
	 * XXX: TSC should be already calibrated before here.
	 */
	uint32_t lapic_ticks_per_ms;
	int i;
	for (i = 0; i < 5; i++) {
  10237b:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  102382:	00 

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  102383:	c7 80 80 03 00 00 ff 	movl   $0xffffffff,0x380(%eax)
  10238a:	ff ff ff 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  10238d:	8b 40 20             	mov    0x20(%eax),%eax
	outb(0x42, latch & 0xff);
	outb(0x42, latch >> 8);

	timer = timer1 = timer2 = lapic_read(LAPIC_TCCR);

	pitcnt = 0;
  102390:	31 db                	xor    %ebx,%ebx
	int pitcnt;

	lapic_write(LAPIC_TICR, ~(uint32_t) 0x0);

	/* Set the Gate high, disable speaker */
	outb(0x61, (inb(0x61) & ~0x02) | 0x01);
  102392:	c7 04 24 61 00 00 00 	movl   $0x61,(%esp)
	outb(0x42, latch >> 8);

	timer = timer1 = timer2 = lapic_read(LAPIC_TCCR);

	pitcnt = 0;
	timermax = 0;
  102399:	31 ed                	xor    %ebp,%ebp
	timermin = ~(uint32_t) 0x0;
  10239b:	bf ff ff ff ff       	mov    $0xffffffff,%edi
	int pitcnt;

	lapic_write(LAPIC_TICR, ~(uint32_t) 0x0);

	/* Set the Gate high, disable speaker */
	outb(0x61, (inb(0x61) & ~0x02) | 0x01);
  1023a0:	e8 6b 25 00 00       	call   104910 <inb>
  1023a5:	c7 04 24 61 00 00 00 	movl   $0x61,(%esp)
  1023ac:	25 fc 00 00 00       	and    $0xfc,%eax
  1023b1:	83 c8 01             	or     $0x1,%eax
  1023b4:	89 44 24 04          	mov    %eax,0x4(%esp)
  1023b8:	e8 83 25 00 00       	call   104940 <outb>
	/*
	 * Setup CTC channel 2* for mode 0, (interrupt on terminal
	 * count mode), binary count. Set the latch register to 50ms
	 * (LSB then MSB) to begin countdown.
	 */
	outb(0x43, 0xb0);
  1023bd:	c7 44 24 04 b0 00 00 	movl   $0xb0,0x4(%esp)
  1023c4:	00 
  1023c5:	c7 04 24 43 00 00 00 	movl   $0x43,(%esp)
  1023cc:	e8 6f 25 00 00       	call   104940 <outb>
	outb(0x42, latch & 0xff);
  1023d1:	c7 44 24 04 9b 00 00 	movl   $0x9b,0x4(%esp)
  1023d8:	00 
  1023d9:	c7 04 24 42 00 00 00 	movl   $0x42,(%esp)
  1023e0:	e8 5b 25 00 00       	call   104940 <outb>
	outb(0x42, latch >> 8);
  1023e5:	c7 44 24 04 2e 00 00 	movl   $0x2e,0x4(%esp)
  1023ec:	00 
  1023ed:	c7 04 24 42 00 00 00 	movl   $0x42,(%esp)
  1023f4:	e8 47 25 00 00       	call   104940 <outb>
 * Read the index'th local APIC register.
 */
static uint32_t
lapic_read(int index)
{
	return lapic[index];
  1023f9:	a1 08 88 9b 00       	mov    0x9b8808,%eax
  1023fe:	8b 80 90 03 00 00    	mov    0x390(%eax),%eax
  102404:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  102408:	89 c6                	mov    %eax,%esi
  10240a:	eb 20                	jmp    10242c <lapic_init+0xec>
  10240c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102410:	a1 08 88 9b 00       	mov    0x9b8808,%eax
  102415:	8b 80 90 03 00 00    	mov    0x390(%eax),%eax
	pitcnt = 0;
	timermax = 0;
	timermin = ~(uint32_t) 0x0;
	while ((inb(0x61) & 0x20) == 0) {
		timer2 = lapic_read(LAPIC_TCCR);
		delta = timer - timer2;
  10241b:	29 c6                	sub    %eax,%esi
  10241d:	39 f7                	cmp    %esi,%edi
  10241f:	0f 47 fe             	cmova  %esi,%edi
  102422:	39 f5                	cmp    %esi,%ebp
  102424:	0f 42 ee             	cmovb  %esi,%ebp
		timer = timer2;
		if (delta < timermin)
			timermin = delta;
		if (delta > timermax)
			timermax = delta;
		pitcnt++;
  102427:	83 c3 01             	add    $0x1,%ebx
	timermax = 0;
	timermin = ~(uint32_t) 0x0;
	while ((inb(0x61) & 0x20) == 0) {
		timer2 = lapic_read(LAPIC_TCCR);
		delta = timer - timer2;
		timer = timer2;
  10242a:	89 c6                	mov    %eax,%esi
	timer = timer1 = timer2 = lapic_read(LAPIC_TCCR);

	pitcnt = 0;
	timermax = 0;
	timermin = ~(uint32_t) 0x0;
	while ((inb(0x61) & 0x20) == 0) {
  10242c:	c7 04 24 61 00 00 00 	movl   $0x61,(%esp)
  102433:	e8 d8 24 00 00       	call   104910 <inb>
  102438:	a8 20                	test   $0x20,%al
  10243a:	74 d4                	je     102410 <lapic_init+0xd0>
	 * times, then we have been hit by a massive SMI
	 *
	 * If the maximum is 10 times larger than the minimum,
	 * then we got hit by an SMI as well.
	 */
	if (pitcnt < loopmin || timermax > 10 * timermin)
  10243c:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
  102442:	7f 3c                	jg     102480 <lapic_init+0x140>
	for (i = 0; i < 5; i++) {
		lapic_ticks_per_ms =
			lapic_calibrate_timer(CAL_LATCH, CAL_MS, CAL_PIT_LOOPS);
		if (lapic_ticks_per_ms != ~(uint32_t) 0x0)
			break;
		KERN_DEBUG("[%d] Retry to calibrate internal timer of LAPIC.\n", i);
  102444:	8b 44 24 18          	mov    0x18(%esp),%eax
  102448:	c7 44 24 08 0c 82 10 	movl   $0x10820c,0x8(%esp)
  10244f:	00 
  102450:	c7 44 24 04 80 00 00 	movl   $0x80,0x4(%esp)
  102457:	00 
  102458:	c7 04 24 62 81 10 00 	movl   $0x108162,(%esp)
  10245f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  102463:	e8 c8 15 00 00       	call   103a30 <debug_normal>
	 * Calibrate the internal timer of LAPIC using TSC.
	 * XXX: TSC should be already calibrated before here.
	 */
	uint32_t lapic_ticks_per_ms;
	int i;
	for (i = 0; i < 5; i++) {
  102468:	83 44 24 18 01       	addl   $0x1,0x18(%esp)
  10246d:	83 7c 24 18 05       	cmpl   $0x5,0x18(%esp)
  102472:	74 6c                	je     1024e0 <lapic_init+0x1a0>
  102474:	a1 08 88 9b 00       	mov    0x9b8808,%eax
  102479:	e9 05 ff ff ff       	jmp    102383 <lapic_init+0x43>
  10247e:	66 90                	xchg   %ax,%ax
	 * times, then we have been hit by a massive SMI
	 *
	 * If the maximum is 10 times larger than the minimum,
	 * then we got hit by an SMI as well.
	 */
	if (pitcnt < loopmin || timermax > 10 * timermin)
  102480:	8d 04 bf             	lea    (%edi,%edi,4),%eax
  102483:	01 c0                	add    %eax,%eax
  102485:	39 e8                	cmp    %ebp,%eax
  102487:	72 bb                	jb     102444 <lapic_init+0x104>
		return ~(uint32_t) 0x0;

	/* Calculate the PIT value */
	delta = timer1 - timer2;
  102489:	8b 6c 24 1c          	mov    0x1c(%esp),%ebp
	/* do_div(delta, ms); */
	return delta/ms;
  10248d:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
	if (lapic_ticks_per_ms == ~(uint32_t) 0x0) {
		KERN_WARN("Failed to calibrate internal timer of LAPIC.\n");
		KERN_DEBUG("Assume LAPIC timer freq = 0.5 GHz.\n");
		lapic_ticks_per_ms = 500000;
	} else
		KERN_DEBUG("LAPIC timer freq = %llu Hz.\n",
  102492:	c7 44 24 08 73 81 10 	movl   $0x108173,0x8(%esp)
  102499:	00 
  10249a:	c7 44 24 04 88 00 00 	movl   $0x88,0x4(%esp)
  1024a1:	00 
  1024a2:	c7 04 24 62 81 10 00 	movl   $0x108162,(%esp)
	 */
	if (pitcnt < loopmin || timermax > 10 * timermin)
		return ~(uint32_t) 0x0;

	/* Calculate the PIT value */
	delta = timer1 - timer2;
  1024a9:	29 f5                	sub    %esi,%ebp
	/* do_div(delta, ms); */
	return delta/ms;
  1024ab:	89 e8                	mov    %ebp,%eax
  1024ad:	f7 e2                	mul    %edx
	if (lapic_ticks_per_ms == ~(uint32_t) 0x0) {
		KERN_WARN("Failed to calibrate internal timer of LAPIC.\n");
		KERN_DEBUG("Assume LAPIC timer freq = 0.5 GHz.\n");
		lapic_ticks_per_ms = 500000;
	} else
		KERN_DEBUG("LAPIC timer freq = %llu Hz.\n",
  1024af:	b8 e8 03 00 00       	mov    $0x3e8,%eax
		return ~(uint32_t) 0x0;

	/* Calculate the PIT value */
	delta = timer1 - timer2;
	/* do_div(delta, ms); */
	return delta/ms;
  1024b4:	89 d3                	mov    %edx,%ebx
  1024b6:	c1 eb 03             	shr    $0x3,%ebx
	if (lapic_ticks_per_ms == ~(uint32_t) 0x0) {
		KERN_WARN("Failed to calibrate internal timer of LAPIC.\n");
		KERN_DEBUG("Assume LAPIC timer freq = 0.5 GHz.\n");
		lapic_ticks_per_ms = 500000;
	} else
		KERN_DEBUG("LAPIC timer freq = %llu Hz.\n",
  1024b9:	f7 e3                	mul    %ebx
  1024bb:	69 db e8 03 00 00    	imul   $0x3e8,%ebx,%ebx
  1024c1:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1024c5:	89 54 24 10          	mov    %edx,0x10(%esp)
  1024c9:	e8 62 15 00 00       	call   103a30 <debug_normal>
  1024ce:	89 d8                	mov    %ebx,%eax
  1024d0:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
  1024d5:	f7 e2                	mul    %edx
  1024d7:	89 d3                	mov    %edx,%ebx
  1024d9:	c1 eb 06             	shr    $0x6,%ebx
  1024dc:	eb 3f                	jmp    10251d <lapic_init+0x1dd>
  1024de:	66 90                	xchg   %ax,%ax
		if (lapic_ticks_per_ms != ~(uint32_t) 0x0)
			break;
		KERN_DEBUG("[%d] Retry to calibrate internal timer of LAPIC.\n", i);
	}
	if (lapic_ticks_per_ms == ~(uint32_t) 0x0) {
		KERN_WARN("Failed to calibrate internal timer of LAPIC.\n");
  1024e0:	c7 44 24 08 b8 81 10 	movl   $0x1081b8,0x8(%esp)
  1024e7:	00 
  1024e8:	bb 20 a1 07 00       	mov    $0x7a120,%ebx
  1024ed:	c7 44 24 04 83 00 00 	movl   $0x83,0x4(%esp)
  1024f4:	00 
  1024f5:	c7 04 24 62 81 10 00 	movl   $0x108162,(%esp)
  1024fc:	e8 4f 16 00 00       	call   103b50 <debug_warn>
		KERN_DEBUG("Assume LAPIC timer freq = 0.5 GHz.\n");
  102501:	c7 44 24 08 e8 81 10 	movl   $0x1081e8,0x8(%esp)
  102508:	00 
  102509:	c7 44 24 04 84 00 00 	movl   $0x84,0x4(%esp)
  102510:	00 
  102511:	c7 04 24 62 81 10 00 	movl   $0x108162,(%esp)
  102518:	e8 13 15 00 00       	call   103a30 <debug_normal>
		lapic_ticks_per_ms = 500000;
	} else
		KERN_DEBUG("LAPIC timer freq = %llu Hz.\n",
			   (uint64_t) lapic_ticks_per_ms * 1000);
	uint32_t ticr = lapic_ticks_per_ms * 1000 / LAPIC_TIMER_INTR_FREQ;
	KERN_DEBUG("Set LAPIC TICR = %x.\n", ticr);
  10251d:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  102521:	c7 44 24 08 90 81 10 	movl   $0x108190,0x8(%esp)
  102528:	00 
  102529:	c7 44 24 04 8a 00 00 	movl   $0x8a,0x4(%esp)
  102530:	00 
  102531:	c7 04 24 62 81 10 00 	movl   $0x108162,(%esp)
  102538:	e8 f3 14 00 00       	call   103a30 <debug_normal>

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  10253d:	a1 08 88 9b 00       	mov    0x9b8808,%eax
  102542:	89 98 80 03 00 00    	mov    %ebx,0x380(%eax)
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  102548:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  10254b:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
  102552:	00 01 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  102555:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  102558:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
  10255f:	00 01 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  102562:	8b 50 20             	mov    0x20(%eax),%edx
 * Read the index'th local APIC register.
 */
static uint32_t
lapic_read(int index)
{
	return lapic[index];
  102565:	8b 50 30             	mov    0x30(%eax),%edx
	lapic_write(LAPIC_LINT0, LAPIC_LINT_MASKED);
	lapic_write(LAPIC_LINT1, LAPIC_LINT_MASKED);

	// Disable performance counter overflow interrupts
	// on machines that provide that interrupt entry.
	if (((lapic_read(LAPIC_VER)>>16) & 0xFF) >= 4)
  102568:	c1 ea 10             	shr    $0x10,%edx
  10256b:	80 fa 03             	cmp    $0x3,%dl
  10256e:	76 0d                	jbe    10257d <lapic_init+0x23d>

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  102570:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
  102577:	00 01 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  10257a:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  10257d:	c7 80 e0 00 00 00 00 	movl   $0xf0000000,0xe0(%eax)
  102584:	00 00 f0 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  102587:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  10258a:	c7 80 d0 00 00 00 00 	movl   $0x0,0xd0(%eax)
  102591:	00 00 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  102594:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  102597:	c7 80 70 03 00 00 32 	movl   $0x32,0x370(%eax)
  10259e:	00 00 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  1025a1:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  1025a4:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
  1025ab:	00 00 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  1025ae:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  1025b1:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
  1025b8:	00 00 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  1025bb:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  1025be:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  1025c5:	00 00 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  1025c8:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  1025cb:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
  1025d2:	00 00 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  1025d5:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  1025d8:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
  1025df:	85 08 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  1025e2:	8b 50 20             	mov    0x20(%eax),%edx
  1025e5:	8d 76 00             	lea    0x0(%esi),%esi
 * Read the index'th local APIC register.
 */
static uint32_t
lapic_read(int index)
{
	return lapic[index];
  1025e8:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx

	// Send an Init Level De-Assert to synchronise arbitration ID's.
	lapic_write(LAPIC_ICRHI, 0);
	lapic_write(LAPIC_ICRLO,
		    LAPIC_ICRLO_BCAST | LAPIC_ICRLO_INIT | LAPIC_ICRLO_LEVEL);
	while(lapic_read(LAPIC_ICRLO) & LAPIC_ICRLO_DELIVS)
  1025ee:	80 e6 10             	and    $0x10,%dh
  1025f1:	75 f5                	jne    1025e8 <lapic_init+0x2a8>

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  1025f3:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
  1025fa:	00 00 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  1025fd:	8b 40 20             	mov    0x20(%eax),%eax
	while(lapic_read(LAPIC_ICRLO) & LAPIC_ICRLO_DELIVS)
		;

	// Enable interrupts on the APIC (but not on the processor).
	lapic_write(LAPIC_TPR, 0);
}
  102600:	83 c4 2c             	add    $0x2c,%esp
  102603:	5b                   	pop    %ebx
  102604:	5e                   	pop    %esi
  102605:	5f                   	pop    %edi
  102606:	5d                   	pop    %ebp
  102607:	c3                   	ret    
 */
void
lapic_init()
{
	if (!lapic)
		KERN_PANIC("NO LAPIC");
  102608:	c7 44 24 08 59 81 10 	movl   $0x108159,0x8(%esp)
  10260f:	00 
  102610:	c7 44 24 04 6a 00 00 	movl   $0x6a,0x4(%esp)
  102617:	00 
  102618:	c7 04 24 62 81 10 00 	movl   $0x108162,(%esp)
  10261f:	e8 5c 14 00 00       	call   103a80 <debug_panic>
  102624:	a1 08 88 9b 00       	mov    0x9b8808,%eax
  102629:	e9 26 fd ff ff       	jmp    102354 <lapic_init+0x14>
  10262e:	66 90                	xchg   %ax,%ax

00102630 <lapic_eoi>:
 * Ackownledge the end of interrupts.
 */
void
lapic_eoi(void)
{
	if (lapic)
  102630:	a1 08 88 9b 00       	mov    0x9b8808,%eax
  102635:	85 c0                	test   %eax,%eax
  102637:	74 0d                	je     102646 <lapic_eoi+0x16>

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  102639:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  102640:	00 00 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  102643:	8b 40 20             	mov    0x20(%eax),%eax
  102646:	f3 c3                	repz ret 
  102648:	90                   	nop
  102649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102650 <lapic_startcpu>:
 * Start additional processor running bootstrap code at addr.
 * See Appendix B of MultiProcessor Specification.
 */
void
lapic_startcpu(lapicid_t apicid, uintptr_t addr)
{
  102650:	56                   	push   %esi
  102651:	53                   	push   %ebx
  102652:	83 ec 14             	sub    $0x14,%esp
  102655:	8b 5c 24 24          	mov    0x24(%esp),%ebx
	uint16_t *wrv;

	// "The BSP must initialize CMOS shutdown code to 0AH
	// and the warm reset vector (DWORD based at 40:67) to point at
	// the AP startup code prior to the [universal startup algorithm]."
	outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
  102659:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
  102660:	00 
 * Start additional processor running bootstrap code at addr.
 * See Appendix B of MultiProcessor Specification.
 */
void
lapic_startcpu(lapicid_t apicid, uintptr_t addr)
{
  102661:	8b 74 24 20          	mov    0x20(%esp),%esi
	uint16_t *wrv;

	// "The BSP must initialize CMOS shutdown code to 0AH
	// and the warm reset vector (DWORD based at 40:67) to point at
	// the AP startup code prior to the [universal startup algorithm]."
	outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
  102665:	c7 04 24 70 00 00 00 	movl   $0x70,(%esp)
  10266c:	e8 cf 22 00 00       	call   104940 <outb>
	outb(IO_RTC+1, 0x0A);
  102671:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
  102678:	00 
  102679:	c7 04 24 71 00 00 00 	movl   $0x71,(%esp)
	wrv[0] = 0;
	wrv[1] = addr >> 4;

	// "Universal startup algorithm."
	// Send INIT (level-triggered) interrupt to reset other CPU.
	lapic_write(LAPIC_ICRHI, apicid<<24);
  102680:	c1 e6 18             	shl    $0x18,%esi

	// "The BSP must initialize CMOS shutdown code to 0AH
	// and the warm reset vector (DWORD based at 40:67) to point at
	// the AP startup code prior to the [universal startup algorithm]."
	outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
	outb(IO_RTC+1, 0x0A);
  102683:	e8 b8 22 00 00       	call   104940 <outb>
	wrv = (uint16_t*)(0x40<<4 | 0x67);  // Warm reset vector
	wrv[0] = 0;
  102688:	31 c0                	xor    %eax,%eax
  10268a:	66 a3 67 04 00 00    	mov    %ax,0x467
	wrv[1] = addr >> 4;
  102690:	89 d8                	mov    %ebx,%eax
  102692:	c1 e8 04             	shr    $0x4,%eax
  102695:	66 a3 69 04 00 00    	mov    %ax,0x469

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  10269b:	a1 08 88 9b 00       	mov    0x9b8808,%eax
	// when it is in the halted state due to an INIT.  So the second
	// should be ignored, but it is part of the official Intel algorithm.
	// Bochs complains about the second one.  Too bad for Bochs.
	for (i = 0; i < 2; i++) {
		lapic_write(LAPIC_ICRHI, apicid<<24);
		lapic_write(LAPIC_ICRLO, LAPIC_ICRLO_STARTUP | (addr>>12));
  1026a0:	c1 eb 0c             	shr    $0xc,%ebx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  1026a3:	89 b0 10 03 00 00    	mov    %esi,0x310(%eax)
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  1026a9:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  1026ac:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
  1026b3:	c5 00 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  1026b6:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  1026b9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
  1026c0:	85 00 00 
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  1026c3:	8b 50 20             	mov    0x20(%eax),%edx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  1026c6:	89 b0 10 03 00 00    	mov    %esi,0x310(%eax)
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  1026cc:	8b 50 20             	mov    0x20(%eax),%edx
	// when it is in the halted state due to an INIT.  So the second
	// should be ignored, but it is part of the official Intel algorithm.
	// Bochs complains about the second one.  Too bad for Bochs.
	for (i = 0; i < 2; i++) {
		lapic_write(LAPIC_ICRHI, apicid<<24);
		lapic_write(LAPIC_ICRLO, LAPIC_ICRLO_STARTUP | (addr>>12));
  1026cf:	89 da                	mov    %ebx,%edx
  1026d1:	80 ce 06             	or     $0x6,%dh

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  1026d4:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  1026da:	8b 58 20             	mov    0x20(%eax),%ebx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  1026dd:	89 b0 10 03 00 00    	mov    %esi,0x310(%eax)
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  1026e3:	8b 48 20             	mov    0x20(%eax),%ecx

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  1026e6:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  1026ec:	8b 40 20             	mov    0x20(%eax),%eax
	for (i = 0; i < 2; i++) {
		lapic_write(LAPIC_ICRHI, apicid<<24);
		lapic_write(LAPIC_ICRLO, LAPIC_ICRLO_STARTUP | (addr>>12));
		microdelay(200);
	}
}
  1026ef:	83 c4 14             	add    $0x14,%esp
  1026f2:	5b                   	pop    %ebx
  1026f3:	5e                   	pop    %esi
  1026f4:	c3                   	ret    
  1026f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1026f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102700 <lapic_read_debug>:
 * Read the index'th local APIC register.
 */
static uint32_t
lapic_read(int index)
{
	return lapic[index];
  102700:	a1 08 88 9b 00       	mov    0x9b8808,%eax
  102705:	8b 54 24 04          	mov    0x4(%esp),%edx
  102709:	8d 04 90             	lea    (%eax,%edx,4),%eax
  10270c:	8b 00                	mov    (%eax),%eax

uint32_t
lapic_read_debug(int index)
{
	return lapic_read(index);
}
  10270e:	c3                   	ret    
  10270f:	90                   	nop

00102710 <lapic_send_ipi>:
 * Send an IPI.
 */
void
lapic_send_ipi(lapicid_t apicid, uint8_t vector,
	       uint32_t deliver_mode, uint32_t shorthand_mode)
{
  102710:	55                   	push   %ebp
  102711:	57                   	push   %edi
  102712:	56                   	push   %esi
  102713:	53                   	push   %ebx
  102714:	83 ec 1c             	sub    $0x1c,%esp
  102717:	8b 5c 24 38          	mov    0x38(%esp),%ebx
  10271b:	8b 6c 24 30          	mov    0x30(%esp),%ebp
  10271f:	8b 7c 24 34          	mov    0x34(%esp),%edi
  102723:	8b 74 24 3c          	mov    0x3c(%esp),%esi
	KERN_ASSERT(deliver_mode != LAPIC_ICRLO_INIT &&
  102727:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
  10272d:	74 51                	je     102780 <lapic_send_ipi+0x70>
  10272f:	81 fb 00 05 00 00    	cmp    $0x500,%ebx
  102735:	74 49                	je     102780 <lapic_send_ipi+0x70>
		    deliver_mode != LAPIC_ICRLO_STARTUP);
	KERN_ASSERT(vector >= T_IPI0);
  102737:	89 f8                	mov    %edi,%eax
  102739:	3c 3e                	cmp    $0x3e,%al
  10273b:	77 08                	ja     102745 <lapic_send_ipi+0x35>
  10273d:	eb 6b                	jmp    1027aa <lapic_send_ipi+0x9a>
  10273f:	90                   	nop

	while (lapic_read(LAPIC_ICRLO) & LAPIC_ICRLO_DELIVS)
		pause();
  102740:	e8 db 1f 00 00       	call   104720 <pause>
 * Read the index'th local APIC register.
 */
static uint32_t
lapic_read(int index)
{
	return lapic[index];
  102745:	a1 08 88 9b 00       	mov    0x9b8808,%eax
  10274a:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
{
	KERN_ASSERT(deliver_mode != LAPIC_ICRLO_INIT &&
		    deliver_mode != LAPIC_ICRLO_STARTUP);
	KERN_ASSERT(vector >= T_IPI0);

	while (lapic_read(LAPIC_ICRLO) & LAPIC_ICRLO_DELIVS)
  102750:	80 e6 10             	and    $0x10,%dh
  102753:	75 eb                	jne    102740 <lapic_send_ipi+0x30>
		pause();

	if (shorthand_mode == LAPIC_ICRLO_NOBCAST)
  102755:	85 f6                	test   %esi,%esi
  102757:	75 0c                	jne    102765 <lapic_send_ipi+0x55>
		lapic_write(LAPIC_ICRHI, (apicid << LAPIC_ICRHI_DEST_SHIFT) &
  102759:	c1 e5 18             	shl    $0x18,%ebp

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  10275c:	89 a8 10 03 00 00    	mov    %ebp,0x310(%eax)
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  102762:	8b 50 20             	mov    0x20(%eax),%edx
	if (shorthand_mode == LAPIC_ICRLO_NOBCAST)
		lapic_write(LAPIC_ICRHI, (apicid << LAPIC_ICRHI_DEST_SHIFT) &
			    LAPIC_ICRHI_DEST_MASK);

	lapic_write(LAPIC_ICRLO, shorthand_mode | /* LAPIC_ICRLO_LEVEL | */
		    deliver_mode | (vector & LAPIC_ICRLO_VECTOR));
  102765:	89 f9                	mov    %edi,%ecx
  102767:	0f b6 f9             	movzbl %cl,%edi

	if (shorthand_mode == LAPIC_ICRLO_NOBCAST)
		lapic_write(LAPIC_ICRHI, (apicid << LAPIC_ICRHI_DEST_SHIFT) &
			    LAPIC_ICRHI_DEST_MASK);

	lapic_write(LAPIC_ICRLO, shorthand_mode | /* LAPIC_ICRLO_LEVEL | */
  10276a:	09 f7                	or     %esi,%edi
		    deliver_mode | (vector & LAPIC_ICRLO_VECTOR));
  10276c:	09 df                	or     %ebx,%edi

/* Write value to the index'th local APIC register. */
static void
lapic_write(int index, int value)
{
	lapic[index] = value;
  10276e:	89 b8 00 03 00 00    	mov    %edi,0x300(%eax)
	/* wait for the finish of writing */
	lapic[LAPIC_ID];
  102774:	8b 40 20             	mov    0x20(%eax),%eax

	lapic_write(LAPIC_ICRLO, shorthand_mode | /* LAPIC_ICRLO_LEVEL | */
		    deliver_mode | (vector & LAPIC_ICRLO_VECTOR));

	/* KERN_DEBUG("IPI %d has been sent to processor %d.\n", vector, apicid); */
}
  102777:	83 c4 1c             	add    $0x1c,%esp
  10277a:	5b                   	pop    %ebx
  10277b:	5e                   	pop    %esi
  10277c:	5f                   	pop    %edi
  10277d:	5d                   	pop    %ebp
  10277e:	c3                   	ret    
  10277f:	90                   	nop
 */
void
lapic_send_ipi(lapicid_t apicid, uint8_t vector,
	       uint32_t deliver_mode, uint32_t shorthand_mode)
{
	KERN_ASSERT(deliver_mode != LAPIC_ICRLO_INIT &&
  102780:	c7 44 24 0c 40 82 10 	movl   $0x108240,0xc(%esp)
  102787:	00 
  102788:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  10278f:	00 
  102790:	c7 44 24 04 f3 00 00 	movl   $0xf3,0x4(%esp)
  102797:	00 
  102798:	c7 04 24 62 81 10 00 	movl   $0x108162,(%esp)
  10279f:	e8 dc 12 00 00       	call   103a80 <debug_panic>
		    deliver_mode != LAPIC_ICRLO_STARTUP);
	KERN_ASSERT(vector >= T_IPI0);
  1027a4:	89 f8                	mov    %edi,%eax
  1027a6:	3c 3e                	cmp    $0x3e,%al
  1027a8:	77 9b                	ja     102745 <lapic_send_ipi+0x35>
  1027aa:	c7 44 24 0c a6 81 10 	movl   $0x1081a6,0xc(%esp)
  1027b1:	00 
  1027b2:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  1027b9:	00 
  1027ba:	c7 44 24 04 f4 00 00 	movl   $0xf4,0x4(%esp)
  1027c1:	00 
  1027c2:	c7 04 24 62 81 10 00 	movl   $0x108162,(%esp)
  1027c9:	e8 b2 12 00 00       	call   103a80 <debug_panic>
  1027ce:	e9 72 ff ff ff       	jmp    102745 <lapic_send_ipi+0x35>
  1027d3:	66 90                	xchg   %ax,%ax
  1027d5:	66 90                	xchg   %ax,%ax
  1027d7:	66 90                	xchg   %ax,%ax
  1027d9:	66 90                	xchg   %ax,%ax
  1027db:	66 90                	xchg   %ax,%ax
  1027dd:	66 90                	xchg   %ax,%ax
  1027df:	90                   	nop

001027e0 <ioapic_register>:
	base->data = data;
}

void
ioapic_register(uintptr_t addr, lapicid_t id, int g)
{
  1027e0:	83 ec 1c             	sub    $0x1c,%esp
	if (ioapic_num >= MAX_IOAPIC) {
  1027e3:	a1 68 ce 12 00       	mov    0x12ce68,%eax
	base->data = data;
}

void
ioapic_register(uintptr_t addr, lapicid_t id, int g)
{
  1027e8:	8b 54 24 24          	mov    0x24(%esp),%edx
	if (ioapic_num >= MAX_IOAPIC) {
  1027ec:	83 f8 0f             	cmp    $0xf,%eax
  1027ef:	7f 3f                	jg     102830 <ioapic_register+0x50>
		KERN_WARN("CertiKOS cannot manipulate more than %d IOAPICs.\n",
			  MAX_IOAPIC);
		return;
	}

	ioapics[ioapic_num] = (ioapic_t *) addr;
  1027f1:	a1 68 ce 12 00       	mov    0x12ce68,%eax
  1027f6:	8b 4c 24 20          	mov    0x20(%esp),%ecx
  1027fa:	89 0c 85 80 88 9b 00 	mov    %ecx,0x9b8880(,%eax,4)
	ioapicid[ioapic_num] = id;
  102801:	a1 68 ce 12 00       	mov    0x12ce68,%eax
  102806:	88 90 20 88 9b 00    	mov    %dl,0x9b8820(%eax)
	gsi[ioapic_num] = g;
  10280c:	8b 54 24 28          	mov    0x28(%esp),%edx
  102810:	a1 68 ce 12 00       	mov    0x12ce68,%eax
  102815:	89 14 85 40 88 9b 00 	mov    %edx,0x9b8840(,%eax,4)

	ioapic_num++;
  10281c:	a1 68 ce 12 00       	mov    0x12ce68,%eax
  102821:	83 c0 01             	add    $0x1,%eax
  102824:	a3 68 ce 12 00       	mov    %eax,0x12ce68
}
  102829:	83 c4 1c             	add    $0x1c,%esp
  10282c:	c3                   	ret    
  10282d:	8d 76 00             	lea    0x0(%esi),%esi

void
ioapic_register(uintptr_t addr, lapicid_t id, int g)
{
	if (ioapic_num >= MAX_IOAPIC) {
		KERN_WARN("CertiKOS cannot manipulate more than %d IOAPICs.\n",
  102830:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  102837:	00 
  102838:	c7 44 24 08 88 82 10 	movl   $0x108288,0x8(%esp)
  10283f:	00 
  102840:	c7 44 24 04 26 00 00 	movl   $0x26,0x4(%esp)
  102847:	00 
  102848:	c7 04 24 01 83 10 00 	movl   $0x108301,(%esp)
  10284f:	e8 fc 12 00 00       	call   103b50 <debug_warn>
	ioapics[ioapic_num] = (ioapic_t *) addr;
	ioapicid[ioapic_num] = id;
	gsi[ioapic_num] = g;

	ioapic_num++;
}
  102854:	83 c4 1c             	add    $0x1c,%esp
  102857:	c3                   	ret    
  102858:	90                   	nop
  102859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102860 <ioapic_init>:

void
ioapic_init(void)
{
  102860:	57                   	push   %edi
	/* KERN_ASSERT(ioapics != NULL); */

	int i;

	for (i = 0; i < ioapic_num; i++) {
  102861:	31 ff                	xor    %edi,%edi
	ioapic_num++;
}

void
ioapic_init(void)
{
  102863:	56                   	push   %esi
  102864:	53                   	push   %ebx
  102865:	83 ec 20             	sub    $0x20,%esp
	/* KERN_ASSERT(ioapics != NULL); */

	int i;

	for (i = 0; i < ioapic_num; i++) {
  102868:	a1 68 ce 12 00       	mov    0x12ce68,%eax
  10286d:	85 c0                	test   %eax,%eax
  10286f:	0f 8e bf 00 00 00    	jle    102934 <ioapic_init+0xd4>
  102875:	8d 76 00             	lea    0x0(%esi),%esi
		/* debug("Initialize IOAPIC %x\n", ioapicid[i]); */

		volatile ioapic_t *ioapic = ioapics[i];
  102878:	8b 1c bd 80 88 9b 00 	mov    0x9b8880(,%edi,4),%ebx

		KERN_ASSERT(ioapic != NULL);
  10287f:	85 db                	test   %ebx,%ebx
  102881:	0f 84 b4 00 00 00    	je     10293b <ioapic_init+0xdb>

static uint32_t
ioapic_read(ioapic_t *base, int reg)
{
	/* KERN_DEBUG("ioapic_read: base=%x, reg=%x\n", base, reg); */
	base->reg = reg;
  102887:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
	return base->data;
  10288d:	8b 43 10             	mov    0x10(%ebx),%eax

		volatile ioapic_t *ioapic = ioapics[i];

		KERN_ASSERT(ioapic != NULL);

		lapicid_t id = ioapic_read(ioapic, IOAPIC_ID) >> 24;
  102890:	c1 e8 18             	shr    $0x18,%eax

		if (id == 0) {
  102893:	84 c0                	test   %al,%al

		volatile ioapic_t *ioapic = ioapics[i];

		KERN_ASSERT(ioapic != NULL);

		lapicid_t id = ioapic_read(ioapic, IOAPIC_ID) >> 24;
  102895:	0f b6 d0             	movzbl %al,%edx

		if (id == 0) {
  102898:	75 1a                	jne    1028b4 <ioapic_init+0x54>
			// I/O APIC ID not initialized yet - have to do it ourselves.
			ioapic_write(ioapic, IOAPIC_ID, ioapicid[i] << 24);
  10289a:	0f b6 87 20 88 9b 00 	movzbl 0x9b8820(%edi),%eax

static void
ioapic_write(ioapic_t *base, int reg, uint32_t data)
{
	/* KERN_DEBUG("ioapic_write: base=%x, reg=%x, data@%x\n", base, reg, data); */
	base->reg = reg;
  1028a1:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

		lapicid_t id = ioapic_read(ioapic, IOAPIC_ID) >> 24;

		if (id == 0) {
			// I/O APIC ID not initialized yet - have to do it ourselves.
			ioapic_write(ioapic, IOAPIC_ID, ioapicid[i] << 24);
  1028a7:	c1 e0 18             	shl    $0x18,%eax
static void
ioapic_write(ioapic_t *base, int reg, uint32_t data)
{
	/* KERN_DEBUG("ioapic_write: base=%x, reg=%x, data@%x\n", base, reg, data); */
	base->reg = reg;
	base->data = data;
  1028aa:	89 43 10             	mov    %eax,0x10(%ebx)
		lapicid_t id = ioapic_read(ioapic, IOAPIC_ID) >> 24;

		if (id == 0) {
			// I/O APIC ID not initialized yet - have to do it ourselves.
			ioapic_write(ioapic, IOAPIC_ID, ioapicid[i] << 24);
			id = ioapicid[i];
  1028ad:	0f b6 97 20 88 9b 00 	movzbl 0x9b8820(%edi),%edx
		}

		if (id != ioapicid[i])
  1028b4:	0f b6 87 20 88 9b 00 	movzbl 0x9b8820(%edi),%eax
  1028bb:	38 d0                	cmp    %dl,%al
  1028bd:	74 2b                	je     1028ea <ioapic_init+0x8a>
			KERN_WARN("ioapic_init: id %d != ioapicid %d\n",
  1028bf:	0f b6 87 20 88 9b 00 	movzbl 0x9b8820(%edi),%eax
  1028c6:	89 54 24 0c          	mov    %edx,0xc(%esp)
  1028ca:	c7 44 24 08 bc 82 10 	movl   $0x1082bc,0x8(%esp)
  1028d1:	00 
  1028d2:	c7 44 24 04 49 00 00 	movl   $0x49,0x4(%esp)
  1028d9:	00 
  1028da:	89 44 24 10          	mov    %eax,0x10(%esp)
  1028de:	c7 04 24 01 83 10 00 	movl   $0x108301,(%esp)
  1028e5:	e8 66 12 00 00       	call   103b50 <debug_warn>

static uint32_t
ioapic_read(ioapic_t *base, int reg)
{
	/* KERN_DEBUG("ioapic_read: base=%x, reg=%x\n", base, reg); */
	base->reg = reg;
  1028ea:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
	return base->data;
  1028f0:	8b 43 10             	mov    0x10(%ebx),%eax

		if (id != ioapicid[i])
			KERN_WARN("ioapic_init: id %d != ioapicid %d\n",
				  id, ioapicid[i]);

		int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;
  1028f3:	ba 10 00 00 00       	mov    $0x10,%edx
  1028f8:	c1 e8 10             	shr    $0x10,%eax
  1028fb:	0f b6 f0             	movzbl %al,%esi

		// Mark all interrupts edge-triggered, active high, disabled,
		// and not routed to any CPUs.
		int j;
		for (j = 0; j <= maxintr; j++){
  1028fe:	31 c0                	xor    %eax,%eax
  102900:	8d 48 20             	lea    0x20(%eax),%ecx
  102903:	83 c0 01             	add    $0x1,%eax
			ioapic_write(ioapic, IOAPIC_TABLE + 2 * j,
				     IOAPIC_INT_DISABLED | (T_IRQ0 + j));
  102906:	81 c9 00 00 01 00    	or     $0x10000,%ecx

static void
ioapic_write(ioapic_t *base, int reg, uint32_t data)
{
	/* KERN_DEBUG("ioapic_write: base=%x, reg=%x, data@%x\n", base, reg, data); */
	base->reg = reg;
  10290c:	89 13                	mov    %edx,(%ebx)
	base->data = data;
  10290e:	89 4b 10             	mov    %ecx,0x10(%ebx)
  102911:	8d 4a 01             	lea    0x1(%edx),%ecx
  102914:	83 c2 02             	add    $0x2,%edx
		int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;

		// Mark all interrupts edge-triggered, active high, disabled,
		// and not routed to any CPUs.
		int j;
		for (j = 0; j <= maxintr; j++){
  102917:	39 c6                	cmp    %eax,%esi

static void
ioapic_write(ioapic_t *base, int reg, uint32_t data)
{
	/* KERN_DEBUG("ioapic_write: base=%x, reg=%x, data@%x\n", base, reg, data); */
	base->reg = reg;
  102919:	89 0b                	mov    %ecx,(%ebx)
	base->data = data;
  10291b:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
		int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;

		// Mark all interrupts edge-triggered, active high, disabled,
		// and not routed to any CPUs.
		int j;
		for (j = 0; j <= maxintr; j++){
  102922:	7d dc                	jge    102900 <ioapic_init+0xa0>
{
	/* KERN_ASSERT(ioapics != NULL); */

	int i;

	for (i = 0; i < ioapic_num; i++) {
  102924:	a1 68 ce 12 00       	mov    0x12ce68,%eax
  102929:	83 c7 01             	add    $0x1,%edi
  10292c:	39 f8                	cmp    %edi,%eax
  10292e:	0f 8f 44 ff ff ff    	jg     102878 <ioapic_init+0x18>
				     IOAPIC_INT_DISABLED | (T_IRQ0 + j));
			ioapic_write(ioapic, IOAPIC_TABLE + 2 * j + 1, 0);
		}

	}
}
  102934:	83 c4 20             	add    $0x20,%esp
  102937:	5b                   	pop    %ebx
  102938:	5e                   	pop    %esi
  102939:	5f                   	pop    %edi
  10293a:	c3                   	ret    
	for (i = 0; i < ioapic_num; i++) {
		/* debug("Initialize IOAPIC %x\n", ioapicid[i]); */

		volatile ioapic_t *ioapic = ioapics[i];

		KERN_ASSERT(ioapic != NULL);
  10293b:	c7 44 24 0c 13 83 10 	movl   $0x108313,0xc(%esp)
  102942:	00 
  102943:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  10294a:	00 
  10294b:	c7 44 24 04 3d 00 00 	movl   $0x3d,0x4(%esp)
  102952:	00 
  102953:	c7 04 24 01 83 10 00 	movl   $0x108301,(%esp)
  10295a:	e8 21 11 00 00       	call   103a80 <debug_panic>
  10295f:	e9 23 ff ff ff       	jmp    102887 <ioapic_init+0x27>
  102964:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10296a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00102970 <ioapic_enable>:

// extern bool pcpu_is_smp(void);

void
ioapic_enable(uint8_t irq, lapicid_t apicid, bool trigger_mode, bool polarity)
{
  102970:	55                   	push   %ebp
  102971:	57                   	push   %edi
  102972:	56                   	push   %esi
  102973:	53                   	push   %ebx
  102974:	83 ec 18             	sub    $0x18,%esp
  102977:	8b 44 24 30          	mov    0x30(%esp),%eax
  10297b:	8b 7c 24 2c          	mov    0x2c(%esp),%edi
  10297f:	8b 6c 24 34          	mov    0x34(%esp),%ebp
  102983:	89 44 24 04          	mov    %eax,0x4(%esp)
  102987:	8b 44 24 38          	mov    0x38(%esp),%eax
  10298b:	89 44 24 08          	mov    %eax,0x8(%esp)
	// Mark interrupt edge-triggered, active high,
	// enabled, and routed to the given APIC ID,

	int i;

	for (i = 0; i < ioapic_num; i++) {
  10298f:	a1 68 ce 12 00       	mov    0x12ce68,%eax
  102994:	85 c0                	test   %eax,%eax
  102996:	0f 8e df 00 00 00    	jle    102a7b <ioapic_enable+0x10b>
  10299c:	89 f8                	mov    %edi,%eax
  10299e:	0f b6 d8             	movzbl %al,%ebx
  1029a1:	31 c0                	xor    %eax,%eax
  1029a3:	90                   	nop
  1029a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		ioapic_t *ioapic = ioapics[i];
  1029a8:	8b 14 85 80 88 9b 00 	mov    0x9b8880(,%eax,4),%edx

static uint32_t
ioapic_read(ioapic_t *base, int reg)
{
	/* KERN_DEBUG("ioapic_read: base=%x, reg=%x\n", base, reg); */
	base->reg = reg;
  1029af:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
	return base->data;
  1029b5:	8b 72 10             	mov    0x10(%edx),%esi

	for (i = 0; i < ioapic_num; i++) {
		ioapic_t *ioapic = ioapics[i];
		int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;

		if (irq >= gsi[i] && irq <= gsi[i] + maxintr) {
  1029b8:	8b 0c 85 40 88 9b 00 	mov    0x9b8840(,%eax,4),%ecx
  1029bf:	39 d9                	cmp    %ebx,%ecx
  1029c1:	7f 19                	jg     1029dc <ioapic_enable+0x6c>
  1029c3:	8b 0c 85 40 88 9b 00 	mov    0x9b8840(,%eax,4),%ecx

	int i;

	for (i = 0; i < ioapic_num; i++) {
		ioapic_t *ioapic = ioapics[i];
		int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;
  1029ca:	c1 ee 10             	shr    $0x10,%esi

		if (irq >= gsi[i] && irq <= gsi[i] + maxintr) {
  1029cd:	89 0c 24             	mov    %ecx,(%esp)

	int i;

	for (i = 0; i < ioapic_num; i++) {
		ioapic_t *ioapic = ioapics[i];
		int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;
  1029d0:	89 f1                	mov    %esi,%ecx
  1029d2:	0f b6 f1             	movzbl %cl,%esi

		if (irq >= gsi[i] && irq <= gsi[i] + maxintr) {
  1029d5:	03 34 24             	add    (%esp),%esi
  1029d8:	39 de                	cmp    %ebx,%esi
  1029da:	7d 24                	jge    102a00 <ioapic_enable+0x90>
	// Mark interrupt edge-triggered, active high,
	// enabled, and routed to the given APIC ID,

	int i;

	for (i = 0; i < ioapic_num; i++) {
  1029dc:	8b 15 68 ce 12 00    	mov    0x12ce68,%edx
  1029e2:	83 c0 01             	add    $0x1,%eax
  1029e5:	39 c2                	cmp    %eax,%edx
  1029e7:	7f bf                	jg     1029a8 <ioapic_enable+0x38>
				     apicid << 24);
			break;
		}
	}

	if (i == ioapic_num)
  1029e9:	8b 15 68 ce 12 00    	mov    0x12ce68,%edx
  1029ef:	39 d0                	cmp    %edx,%eax
  1029f1:	74 5b                	je     102a4e <ioapic_enable+0xde>
		KERN_PANIC("Cannot enable IRQ %d on IOAPIC.\n", irq);
}
  1029f3:	83 c4 18             	add    $0x18,%esp
  1029f6:	5b                   	pop    %ebx
  1029f7:	5e                   	pop    %esi
  1029f8:	5f                   	pop    %edi
  1029f9:	5d                   	pop    %ebp
  1029fa:	c3                   	ret    
  1029fb:	90                   	nop
  1029fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;

		if (irq >= gsi[i] && irq <= gsi[i] + maxintr) {
			ioapic_write(ioapic,
				     IOAPIC_TABLE + 2 * (irq - gsi[i]),
				     ((trigger_mode << 15) | (polarity << 13) | (T_IRQ0 + irq)));
  102a00:	89 e9                	mov    %ebp,%ecx
		ioapic_t *ioapic = ioapics[i];
		int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;

		if (irq >= gsi[i] && irq <= gsi[i] + maxintr) {
			ioapic_write(ioapic,
				     IOAPIC_TABLE + 2 * (irq - gsi[i]),
  102a02:	89 de                	mov    %ebx,%esi
				     ((trigger_mode << 15) | (polarity << 13) | (T_IRQ0 + irq)));
  102a04:	0f b6 e9             	movzbl %cl,%ebp
  102a07:	0f b6 4c 24 08       	movzbl 0x8(%esp),%ecx
  102a0c:	c1 e5 0f             	shl    $0xf,%ebp
  102a0f:	c1 e1 0d             	shl    $0xd,%ecx
  102a12:	09 cd                	or     %ecx,%ebp
  102a14:	8d 4b 20             	lea    0x20(%ebx),%ecx
  102a17:	09 cd                	or     %ecx,%ebp
		ioapic_t *ioapic = ioapics[i];
		int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;

		if (irq >= gsi[i] && irq <= gsi[i] + maxintr) {
			ioapic_write(ioapic,
				     IOAPIC_TABLE + 2 * (irq - gsi[i]),
  102a19:	8b 0c 85 40 88 9b 00 	mov    0x9b8840(,%eax,4),%ecx
  102a20:	29 ce                	sub    %ecx,%esi
	for (i = 0; i < ioapic_num; i++) {
		ioapic_t *ioapic = ioapics[i];
		int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;

		if (irq >= gsi[i] && irq <= gsi[i] + maxintr) {
			ioapic_write(ioapic,
  102a22:	8d 4c 36 10          	lea    0x10(%esi,%esi,1),%ecx

static void
ioapic_write(ioapic_t *base, int reg, uint32_t data)
{
	/* KERN_DEBUG("ioapic_write: base=%x, reg=%x, data@%x\n", base, reg, data); */
	base->reg = reg;
  102a26:	89 0a                	mov    %ecx,(%edx)
				     IOAPIC_TABLE + 2 * (irq - gsi[i]),
				     ((trigger_mode << 15) | (polarity << 13) | (T_IRQ0 + irq)));

			ioapic_write(ioapic,
				     IOAPIC_TABLE + 2 * (irq - gsi[i]) + 1,
				     apicid << 24);
  102a28:	8b 4c 24 04          	mov    0x4(%esp),%ecx
static void
ioapic_write(ioapic_t *base, int reg, uint32_t data)
{
	/* KERN_DEBUG("ioapic_write: base=%x, reg=%x, data@%x\n", base, reg, data); */
	base->reg = reg;
	base->data = data;
  102a2c:	89 6a 10             	mov    %ebp,0x10(%edx)
			ioapic_write(ioapic,
				     IOAPIC_TABLE + 2 * (irq - gsi[i]),
				     ((trigger_mode << 15) | (polarity << 13) | (T_IRQ0 + irq)));

			ioapic_write(ioapic,
				     IOAPIC_TABLE + 2 * (irq - gsi[i]) + 1,
  102a2f:	8b 34 85 40 88 9b 00 	mov    0x9b8840(,%eax,4),%esi
				     apicid << 24);
  102a36:	c1 e1 18             	shl    $0x18,%ecx
			ioapic_write(ioapic,
				     IOAPIC_TABLE + 2 * (irq - gsi[i]),
				     ((trigger_mode << 15) | (polarity << 13) | (T_IRQ0 + irq)));

			ioapic_write(ioapic,
				     IOAPIC_TABLE + 2 * (irq - gsi[i]) + 1,
  102a39:	29 f3                	sub    %esi,%ebx
		if (irq >= gsi[i] && irq <= gsi[i] + maxintr) {
			ioapic_write(ioapic,
				     IOAPIC_TABLE + 2 * (irq - gsi[i]),
				     ((trigger_mode << 15) | (polarity << 13) | (T_IRQ0 + irq)));

			ioapic_write(ioapic,
  102a3b:	8d 5c 1b 11          	lea    0x11(%ebx,%ebx,1),%ebx

static void
ioapic_write(ioapic_t *base, int reg, uint32_t data)
{
	/* KERN_DEBUG("ioapic_write: base=%x, reg=%x, data@%x\n", base, reg, data); */
	base->reg = reg;
  102a3f:	89 1a                	mov    %ebx,(%edx)
	base->data = data;
  102a41:	89 4a 10             	mov    %ecx,0x10(%edx)
				     apicid << 24);
			break;
		}
	}

	if (i == ioapic_num)
  102a44:	8b 15 68 ce 12 00    	mov    0x12ce68,%edx
  102a4a:	39 d0                	cmp    %edx,%eax
  102a4c:	75 a5                	jne    1029f3 <ioapic_enable+0x83>
		KERN_PANIC("Cannot enable IRQ %d on IOAPIC.\n", irq);
  102a4e:	89 f8                	mov    %edi,%eax
  102a50:	0f b6 f8             	movzbl %al,%edi
  102a53:	89 7c 24 38          	mov    %edi,0x38(%esp)
  102a57:	c7 44 24 34 e0 82 10 	movl   $0x1082e0,0x34(%esp)
  102a5e:	00 
  102a5f:	c7 44 24 30 75 00 00 	movl   $0x75,0x30(%esp)
  102a66:	00 
  102a67:	c7 44 24 2c 01 83 10 	movl   $0x108301,0x2c(%esp)
  102a6e:	00 
}
  102a6f:	83 c4 18             	add    $0x18,%esp
  102a72:	5b                   	pop    %ebx
  102a73:	5e                   	pop    %esi
  102a74:	5f                   	pop    %edi
  102a75:	5d                   	pop    %ebp
			break;
		}
	}

	if (i == ioapic_num)
		KERN_PANIC("Cannot enable IRQ %d on IOAPIC.\n", irq);
  102a76:	e9 05 10 00 00       	jmp    103a80 <debug_panic>
	// Mark interrupt edge-triggered, active high,
	// enabled, and routed to the given APIC ID,

	int i;

	for (i = 0; i < ioapic_num; i++) {
  102a7b:	31 c0                	xor    %eax,%eax
  102a7d:	e9 67 ff ff ff       	jmp    1029e9 <ioapic_enable+0x79>
  102a82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102a90 <ioapic_number>:
}

int
ioapic_number(void)
{
	return ioapic_num;
  102a90:	a1 68 ce 12 00       	mov    0x12ce68,%eax
}
  102a95:	c3                   	ret    
  102a96:	8d 76 00             	lea    0x0(%esi),%esi
  102a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102aa0 <ioapic_get>:

ioapic_t *
ioapic_get(uint32_t idx)
{
  102aa0:	8b 44 24 04          	mov    0x4(%esp),%eax
	if (idx >= ioapic_num)
  102aa4:	8b 15 68 ce 12 00    	mov    0x12ce68,%edx
  102aaa:	39 c2                	cmp    %eax,%edx
  102aac:	76 0a                	jbe    102ab8 <ioapic_get+0x18>
		return NULL;
	return ioapics[idx];
  102aae:	8b 04 85 80 88 9b 00 	mov    0x9b8880(,%eax,4),%eax
  102ab5:	c3                   	ret    
  102ab6:	66 90                	xchg   %ax,%ax

ioapic_t *
ioapic_get(uint32_t idx)
{
	if (idx >= ioapic_num)
		return NULL;
  102ab8:	31 c0                	xor    %eax,%eax
	return ioapics[idx];
}
  102aba:	c3                   	ret    
  102abb:	66 90                	xchg   %ax,%ax
  102abd:	66 90                	xchg   %ax,%ax
  102abf:	90                   	nop

00102ac0 <pcpu_mp_init_cpu>:
	pcpu_print_cpuinfo(get_pcpu_idx(), cpuinfo);
}

static void
pcpu_mp_init_cpu(uint32_t idx, uint8_t lapic_id, bool is_bsp)
{
  102ac0:	56                   	push   %esi
  102ac1:	89 d6                	mov    %edx,%esi
  102ac3:	53                   	push   %ebx
  102ac4:	89 cb                	mov    %ecx,%ebx
  102ac6:	83 ec 24             	sub    $0x24,%esp
	KERN_ASSERT((is_bsp == TRUE && idx == 0) || (is_bsp == FALSE));
  102ac9:	83 f9 01             	cmp    $0x1,%ecx
  102acc:	75 1a                	jne    102ae8 <pcpu_mp_init_cpu+0x28>
  102ace:	85 c0                	test   %eax,%eax
  102ad0:	75 16                	jne    102ae8 <pcpu_mp_init_cpu+0x28>

	if (idx >= NUM_CPUS)
	return;

	struct pcpuinfo *info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(idx);
  102ad2:	89 04 24             	mov    %eax,(%esp)
  102ad5:	e8 d6 2a 00 00       	call   1055b0 <get_pcpu_arch_info_pointer>

	info->lapicid = lapic_id;
  102ada:	89 30                	mov    %esi,(%eax)
	info->bsp = is_bsp;
  102adc:	88 58 04             	mov    %bl,0x4(%eax)
}
  102adf:	83 c4 24             	add    $0x24,%esp
  102ae2:	5b                   	pop    %ebx
  102ae3:	5e                   	pop    %esi
  102ae4:	c3                   	ret    
  102ae5:	8d 76 00             	lea    0x0(%esi),%esi
}

static void
pcpu_mp_init_cpu(uint32_t idx, uint8_t lapic_id, bool is_bsp)
{
	KERN_ASSERT((is_bsp == TRUE && idx == 0) || (is_bsp == FALSE));
  102ae8:	84 db                	test   %bl,%bl
  102aea:	75 0c                	jne    102af8 <pcpu_mp_init_cpu+0x38>

	if (idx >= NUM_CPUS)
  102aec:	83 f8 07             	cmp    $0x7,%eax
  102aef:	76 e1                	jbe    102ad2 <pcpu_mp_init_cpu+0x12>

	struct pcpuinfo *info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(idx);

	info->lapicid = lapic_id;
	info->bsp = is_bsp;
}
  102af1:	83 c4 24             	add    $0x24,%esp
  102af4:	5b                   	pop    %ebx
  102af5:	5e                   	pop    %esi
  102af6:	c3                   	ret    
  102af7:	90                   	nop
}

static void
pcpu_mp_init_cpu(uint32_t idx, uint8_t lapic_id, bool is_bsp)
{
	KERN_ASSERT((is_bsp == TRUE && idx == 0) || (is_bsp == FALSE));
  102af8:	c7 44 24 0c 24 83 10 	movl   $0x108324,0xc(%esp)
  102aff:	00 
  102b00:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  102b07:	00 
  102b08:	c7 44 24 04 a6 00 00 	movl   $0xa6,0x4(%esp)
  102b0f:	00 
  102b10:	c7 04 24 3c 85 10 00 	movl   $0x10853c,(%esp)
  102b17:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  102b1b:	e8 60 0f 00 00       	call   103a80 <debug_panic>
  102b20:	8b 44 24 1c          	mov    0x1c(%esp),%eax

	if (idx >= NUM_CPUS)
  102b24:	83 f8 07             	cmp    $0x7,%eax
  102b27:	77 c8                	ja     102af1 <pcpu_mp_init_cpu+0x31>
  102b29:	eb a7                	jmp    102ad2 <pcpu_mp_init_cpu+0x12>
  102b2b:	90                   	nop
  102b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00102b30 <mpsearch1>:
}

/* Look for an MP structure in the len bytes at addr. */
static struct mp *
mpsearch1(uint8_t * addr, int len)
{
  102b30:	57                   	push   %edi
  102b31:	89 c7                	mov    %eax,%edi
  102b33:	56                   	push   %esi
  102b34:	53                   	push   %ebx
	uint8_t *e, *p;

	e = addr + len;
  102b35:	8d 34 10             	lea    (%eax,%edx,1),%esi
}

/* Look for an MP structure in the len bytes at addr. */
static struct mp *
mpsearch1(uint8_t * addr, int len)
{
  102b38:	83 ec 10             	sub    $0x10,%esp
	uint8_t *e, *p;

	e = addr + len;
	for (p = addr; p < e; p += sizeof(struct mp))
  102b3b:	39 f0                	cmp    %esi,%eax
  102b3d:	73 3a                	jae    102b79 <mpsearch1+0x49>
  102b3f:	90                   	nop
		if (memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  102b40:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
  102b47:	00 
  102b48:	c7 44 24 04 4f 85 10 	movl   $0x10854f,0x4(%esp)
  102b4f:	00 
  102b50:	89 3c 24             	mov    %edi,(%esp)
  102b53:	e8 38 0e 00 00       	call   103990 <memcmp>
  102b58:	85 c0                	test   %eax,%eax
  102b5a:	75 16                	jne    102b72 <mpsearch1+0x42>
  102b5c:	31 c9                	xor    %ecx,%ecx
  102b5e:	31 d2                	xor    %edx,%edx
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++)
		sum += addr[i];
  102b60:	0f b6 1c 17          	movzbl (%edi,%edx,1),%ebx
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++)
  102b64:	83 c2 01             	add    $0x1,%edx
		sum += addr[i];
  102b67:	01 d9                	add    %ebx,%ecx
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++)
  102b69:	83 fa 10             	cmp    $0x10,%edx
  102b6c:	75 f2                	jne    102b60 <mpsearch1+0x30>
{
	uint8_t *e, *p;

	e = addr + len;
	for (p = addr; p < e; p += sizeof(struct mp))
		if (memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  102b6e:	84 c9                	test   %cl,%cl
  102b70:	74 10                	je     102b82 <mpsearch1+0x52>
mpsearch1(uint8_t * addr, int len)
{
	uint8_t *e, *p;

	e = addr + len;
	for (p = addr; p < e; p += sizeof(struct mp))
  102b72:	83 c7 10             	add    $0x10,%edi
  102b75:	39 fe                	cmp    %edi,%esi
  102b77:	77 c7                	ja     102b40 <mpsearch1+0x10>
		if (memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
			return (struct mp *) p;
	return 0;
}
  102b79:	83 c4 10             	add    $0x10,%esp

	e = addr + len;
	for (p = addr; p < e; p += sizeof(struct mp))
		if (memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
			return (struct mp *) p;
	return 0;
  102b7c:	31 c0                	xor    %eax,%eax
}
  102b7e:	5b                   	pop    %ebx
  102b7f:	5e                   	pop    %esi
  102b80:	5f                   	pop    %edi
  102b81:	c3                   	ret    
  102b82:	83 c4 10             	add    $0x10,%esp
  102b85:	89 f8                	mov    %edi,%eax
  102b87:	5b                   	pop    %ebx
  102b88:	5e                   	pop    %esi
  102b89:	5f                   	pop    %edi
  102b8a:	c3                   	ret    
  102b8b:	90                   	nop
  102b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00102b90 <pcpu_mp_init>:
	acpi_xsdt_t *xsdt;
	acpi_madt_t *madt;
	uint32_t ap_idx = 1;
	bool found_bsp=FALSE;

	if (mp_inited == TRUE)
  102b90:	80 3d 6d ce 12 00 01 	cmpb   $0x1,0x12ce6d
		return TRUE;
  102b97:	b8 01 00 00 00       	mov    $0x1,%eax
	acpi_xsdt_t *xsdt;
	acpi_madt_t *madt;
	uint32_t ap_idx = 1;
	bool found_bsp=FALSE;

	if (mp_inited == TRUE)
  102b9c:	0f 84 59 01 00 00    	je     102cfb <pcpu_mp_init+0x16b>
 * multiple processors initialization method using ACPI
 */

bool
pcpu_mp_init(void)
{
  102ba2:	55                   	push   %ebp
  102ba3:	57                   	push   %edi
  102ba4:	56                   	push   %esi
  102ba5:	53                   	push   %ebx
  102ba6:	83 ec 2c             	sub    $0x2c,%esp
	bool found_bsp=FALSE;

	if (mp_inited == TRUE)
		return TRUE;

	KERN_INFO("\n");
  102ba9:	c7 04 24 6f 92 10 00 	movl   $0x10926f,(%esp)
  102bb0:	e8 3b 0e 00 00       	call   1039f0 <debug_info>

	if ((rsdp = acpi_probe_rsdp()) == NULL) {
  102bb5:	e8 f6 f4 ff ff       	call   1020b0 <acpi_probe_rsdp>
  102bba:	85 c0                	test   %eax,%eax
  102bbc:	89 c3                	mov    %eax,%ebx
  102bbe:	0f 84 bc 01 00 00    	je     102d80 <pcpu_mp_init+0x1f0>
		KERN_DEBUG("Not found RSDP.\n");
		goto fallback;
	}

	xsdt = NULL;
	if ((xsdt = acpi_probe_xsdt(rsdp)) == NULL &&
  102bc4:	89 04 24             	mov    %eax,(%esp)
  102bc7:	e8 54 f6 ff ff       	call   102220 <acpi_probe_xsdt>
  102bcc:	85 c0                	test   %eax,%eax
  102bce:	0f 84 1d 04 00 00    	je     102ff1 <pcpu_mp_init+0x461>
		goto fallback;
	}

	if ((madt =
	     (xsdt != NULL) ?
	     (acpi_madt_t *) acpi_probe_xsdt_ent(xsdt, ACPI_MADT_SIG) :
  102bd4:	c7 44 24 04 41 50 49 	movl   $0x43495041,0x4(%esp)
  102bdb:	43 
  102bdc:	89 04 24             	mov    %eax,(%esp)
  102bdf:	e8 ac f6 ff ff       	call   102290 <acpi_probe_xsdt_ent>
  102be4:	89 c7                	mov    %eax,%edi
	    (rsdt = acpi_probe_rsdt(rsdp)) == NULL) {
		KERN_DEBUG("Not found either RSDT or XSDT.\n");
		goto fallback;
	}

	if ((madt =
  102be6:	85 ff                	test   %edi,%edi
  102be8:	0f 84 8a 03 00 00    	je     102f78 <pcpu_mp_init+0x3e8>
		goto fallback;
	}

	ismp = TRUE;

	lapic_register(madt->lapic_addr);
  102bee:	8b 47 24             	mov    0x24(%edi),%eax

	ncpu = 0;

	p = (uint8_t *)madt->ent;
  102bf1:	8d 5f 2c             	lea    0x2c(%edi),%ebx
	uint8_t *p, *e;
	acpi_rsdp_t *rsdp;
	acpi_rsdt_t *rsdt;
	acpi_xsdt_t *xsdt;
	acpi_madt_t *madt;
	uint32_t ap_idx = 1;
  102bf4:	bd 01 00 00 00       	mov    $0x1,%ebp
	     (acpi_madt_t *) acpi_probe_rsdt_ent(rsdt, ACPI_MADT_SIG)) == NULL) {
		KERN_DEBUG("Not found MADT.\n");
		goto fallback;
	}

	ismp = TRUE;
  102bf9:	c6 05 6c ce 12 00 01 	movb   $0x1,0x12ce6c

	lapic_register(madt->lapic_addr);
  102c00:	89 04 24             	mov    %eax,(%esp)
  102c03:	e8 28 f7 ff ff       	call   102330 <lapic_register>

	ncpu = 0;

	p = (uint8_t *)madt->ent;
	e = (uint8_t *)madt + madt->length;
  102c08:	8b 77 04             	mov    0x4(%edi),%esi

	ismp = TRUE;

	lapic_register(madt->lapic_addr);

	ncpu = 0;
  102c0b:	c7 05 70 ce 12 00 00 	movl   $0x0,0x12ce70
  102c12:	00 00 00 
	acpi_rsdp_t *rsdp;
	acpi_rsdt_t *rsdt;
	acpi_xsdt_t *xsdt;
	acpi_madt_t *madt;
	uint32_t ap_idx = 1;
	bool found_bsp=FALSE;
  102c15:	c6 44 24 1c 00       	movb   $0x0,0x1c(%esp)
	lapic_register(madt->lapic_addr);

	ncpu = 0;

	p = (uint8_t *)madt->ent;
	e = (uint8_t *)madt + madt->length;
  102c1a:	01 fe                	add    %edi,%esi

	while (p < e) {
  102c1c:	39 f3                	cmp    %esi,%ebx
  102c1e:	72 47                	jb     102c67 <pcpu_mp_init+0xd7>
  102c20:	eb 6e                	jmp    102c90 <pcpu_mp_init+0x100>
  102c22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		case ACPI_MADT_APIC_IOAPIC:
			;
			acpi_madt_ioapic_t *
				ioapic_ent = (acpi_madt_ioapic_t *)hdr;

			KERN_INFO("\tIOAPIC: APIC id = %x, base = %x\n",
  102c28:	8b 43 04             	mov    0x4(%ebx),%eax
  102c2b:	89 44 24 08          	mov    %eax,0x8(%esp)
  102c2f:	0f b6 43 02          	movzbl 0x2(%ebx),%eax
  102c33:	c7 04 24 78 83 10 00 	movl   $0x108378,(%esp)
  102c3a:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c3e:	e8 ad 0d 00 00       	call   1039f0 <debug_info>
				  ioapic_ent->ioapic_id, ioapic_ent->ioapic_addr);

			ioapic_register(ioapic_ent->ioapic_addr,
  102c43:	8b 43 08             	mov    0x8(%ebx),%eax
  102c46:	89 44 24 08          	mov    %eax,0x8(%esp)
  102c4a:	0f b6 43 02          	movzbl 0x2(%ebx),%eax
  102c4e:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c52:	8b 43 04             	mov    0x4(%ebx),%eax
  102c55:	89 04 24             	mov    %eax,(%esp)
  102c58:	e8 83 fb ff ff       	call   1027e0 <ioapic_register>
			KERN_INFO("\tUnhandled ACPI entry (type=%x)\n",
				  hdr->type);
			break;
		}

		p += hdr->length;
  102c5d:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
  102c61:	01 c3                	add    %eax,%ebx
	ncpu = 0;

	p = (uint8_t *)madt->ent;
	e = (uint8_t *)madt + madt->length;

	while (p < e) {
  102c63:	39 de                	cmp    %ebx,%esi
  102c65:	76 29                	jbe    102c90 <pcpu_mp_init+0x100>
		acpi_madt_apic_hdr_t * hdr = (acpi_madt_apic_hdr_t *) p;

		switch (hdr->type) {
  102c67:	0f b6 03             	movzbl (%ebx),%eax
  102c6a:	84 c0                	test   %al,%al
  102c6c:	0f 84 8e 00 00 00    	je     102d00 <pcpu_mp_init+0x170>
  102c72:	3c 01                	cmp    $0x1,%al
  102c74:	74 b2                	je     102c28 <pcpu_mp_init+0x98>

			break;

		default:
			;
			KERN_INFO("\tUnhandled ACPI entry (type=%x)\n",
  102c76:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c7a:	c7 04 24 9c 83 10 00 	movl   $0x10839c,(%esp)
  102c81:	e8 6a 0d 00 00       	call   1039f0 <debug_info>
				  hdr->type);
			break;
		}

		p += hdr->length;
  102c86:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
  102c8a:	01 c3                	add    %eax,%ebx
	ncpu = 0;

	p = (uint8_t *)madt->ent;
	e = (uint8_t *)madt + madt->length;

	while (p < e) {
  102c8c:	39 de                	cmp    %ebx,%esi
  102c8e:	77 d7                	ja     102c67 <pcpu_mp_init+0xd7>
	/*
	 * Force NMI and 8259 signals to APIC when PIC mode
	 * is not implemented.
	 *
	 */
	if ((madt->flags & APIC_MADT_PCAT_COMPAT) == 0) {
  102c90:	f6 47 28 01          	testb  $0x1,0x28(%edi)
  102c94:	75 36                	jne    102ccc <pcpu_mp_init+0x13c>
		outb(0x22, 0x70);
  102c96:	c7 44 24 04 70 00 00 	movl   $0x70,0x4(%esp)
  102c9d:	00 
  102c9e:	c7 04 24 22 00 00 00 	movl   $0x22,(%esp)
  102ca5:	e8 96 1c 00 00       	call   104940 <outb>
		outb(0x23, inb(0x23) | 1);
  102caa:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
  102cb1:	e8 5a 1c 00 00       	call   104910 <inb>
  102cb6:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
  102cbd:	83 c8 01             	or     $0x1,%eax
  102cc0:	0f b6 c0             	movzbl %al,%eax
  102cc3:	89 44 24 04          	mov    %eax,0x4(%esp)
  102cc7:	e8 74 1c 00 00       	call   104940 <outb>
	}

	/*
	 * Copy AP boot code to 0x8000.
	 */
	memmove((uint8_t *)0x8000,
  102ccc:	c7 44 24 08 62 00 00 	movl   $0x62,0x8(%esp)
  102cd3:	00 
  102cd4:	c7 44 24 04 64 b4 12 	movl   $0x12b464,0x4(%esp)
  102cdb:	00 
  102cdc:	c7 04 24 00 80 00 00 	movl   $0x8000,(%esp)
  102ce3:	e8 c8 0a 00 00       	call   1037b0 <memmove>
	       _binary___obj_kern_init_boot_ap_start,
		(size_t)_binary___obj_kern_init_boot_ap_size);

	mp_inited = TRUE;

	return TRUE;
  102ce8:	b8 01 00 00 00       	mov    $0x1,%eax
	 */
	memmove((uint8_t *)0x8000,
	       _binary___obj_kern_init_boot_ap_start,
		(size_t)_binary___obj_kern_init_boot_ap_size);

	mp_inited = TRUE;
  102ced:	c6 05 6d ce 12 00 01 	movb   $0x1,0x12ce6d
		ismp = 0;
		ncpu = 1;
		return FALSE;
	} else
		return TRUE;
}
  102cf4:	83 c4 2c             	add    $0x2c,%esp
  102cf7:	5b                   	pop    %ebx
  102cf8:	5e                   	pop    %esi
  102cf9:	5f                   	pop    %edi
  102cfa:	5d                   	pop    %ebp
  102cfb:	f3 c3                	repz ret 
  102cfd:	8d 76 00             	lea    0x0(%esi),%esi
		case ACPI_MADT_APIC_LAPIC:
			;
			acpi_madt_lapic_t *
				lapic_ent = (acpi_madt_lapic_t *) hdr;

			if (!(lapic_ent->flags & ACPI_APIC_ENABLED)) {
  102d00:	f6 43 04 01          	testb  $0x1,0x4(%ebx)
  102d04:	0f 84 53 ff ff ff    	je     102c5d <pcpu_mp_init+0xcd>
				/* KERN_DEBUG("CPU is disabled.\n"); */
				break;
			}

			KERN_INFO("\tCPU%d: APIC id = %x, ",
  102d0a:	0f b6 43 03          	movzbl 0x3(%ebx),%eax
  102d0e:	c7 04 24 76 85 10 00 	movl   $0x108576,(%esp)
  102d15:	89 44 24 08          	mov    %eax,0x8(%esp)
  102d19:	a1 70 ce 12 00       	mov    0x12ce70,%eax
  102d1e:	89 44 24 04          	mov    %eax,0x4(%esp)
  102d22:	e8 c9 0c 00 00       	call   1039f0 <debug_info>
				  ncpu, lapic_ent->lapic_id);

			//according to acpi p.138, section 5.2.12.1,
			//"platform firmware should list the boot processor as the first processor entry in the MADT"
			if (!found_bsp) {
  102d27:	80 7c 24 1c 00       	cmpb   $0x0,0x1c(%esp)
  102d2c:	75 32                	jne    102d60 <pcpu_mp_init+0x1d0>
				found_bsp=TRUE;
				KERN_INFO("BSP\n");
  102d2e:	c7 04 24 8d 85 10 00 	movl   $0x10858d,(%esp)
  102d35:	e8 b6 0c 00 00       	call   1039f0 <debug_info>
				pcpu_mp_init_cpu(0, lapic_ent->lapic_id, TRUE);
  102d3a:	0f b6 53 03          	movzbl 0x3(%ebx),%edx
  102d3e:	b9 01 00 00 00       	mov    $0x1,%ecx
  102d43:	31 c0                	xor    %eax,%eax
  102d45:	e8 76 fd ff ff       	call   102ac0 <pcpu_mp_init_cpu>
				  ncpu, lapic_ent->lapic_id);

			//according to acpi p.138, section 5.2.12.1,
			//"platform firmware should list the boot processor as the first processor entry in the MADT"
			if (!found_bsp) {
				found_bsp=TRUE;
  102d4a:	c6 44 24 1c 01       	movb   $0x1,0x1c(%esp)
				pcpu_mp_init_cpu
					(ap_idx, lapic_ent->lapic_id, FALSE);
				ap_idx++;
			}

			ncpu++;
  102d4f:	83 05 70 ce 12 00 01 	addl   $0x1,0x12ce70

			break;
  102d56:	e9 02 ff ff ff       	jmp    102c5d <pcpu_mp_init+0xcd>
  102d5b:	90                   	nop
  102d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
			if (!found_bsp) {
				found_bsp=TRUE;
				KERN_INFO("BSP\n");
				pcpu_mp_init_cpu(0, lapic_ent->lapic_id, TRUE);
			} else {
				KERN_INFO("AP\n");
  102d60:	c7 04 24 92 85 10 00 	movl   $0x108592,(%esp)
  102d67:	e8 84 0c 00 00       	call   1039f0 <debug_info>
				pcpu_mp_init_cpu
					(ap_idx, lapic_ent->lapic_id, FALSE);
  102d6c:	0f b6 53 03          	movzbl 0x3(%ebx),%edx
  102d70:	89 e8                	mov    %ebp,%eax
  102d72:	31 c9                	xor    %ecx,%ecx
				ap_idx++;
  102d74:	83 c5 01             	add    $0x1,%ebp
				KERN_INFO("BSP\n");
				pcpu_mp_init_cpu(0, lapic_ent->lapic_id, TRUE);
			} else {
				KERN_INFO("AP\n");
				pcpu_mp_init_cpu
					(ap_idx, lapic_ent->lapic_id, FALSE);
  102d77:	e8 44 fd ff ff       	call   102ac0 <pcpu_mp_init_cpu>
  102d7c:	eb d1                	jmp    102d4f <pcpu_mp_init+0x1bf>
  102d7e:	66 90                	xchg   %ax,%ax
		return TRUE;

	KERN_INFO("\n");

	if ((rsdp = acpi_probe_rsdp()) == NULL) {
		KERN_DEBUG("Not found RSDP.\n");
  102d80:	c7 44 24 08 54 85 10 	movl   $0x108554,0x8(%esp)
  102d87:	00 
  102d88:	c7 44 24 04 67 01 00 	movl   $0x167,0x4(%esp)
  102d8f:	00 
  102d90:	c7 04 24 3c 85 10 00 	movl   $0x10853c,(%esp)
  102d97:	e8 94 0c 00 00       	call   103a30 <debug_normal>
	mp_inited = TRUE;

	return TRUE;

 fallback:
	KERN_DEBUG("Use the fallback multiprocessor initialization.\n");
  102d9c:	c7 44 24 08 c0 83 10 	movl   $0x1083c0,0x8(%esp)
  102da3:	00 
  102da4:	c7 44 24 04 d3 01 00 	movl   $0x1d3,0x4(%esp)
  102dab:	00 
  102dac:	c7 04 24 3c 85 10 00 	movl   $0x10853c,(%esp)
  102db3:	e8 78 0c 00 00       	call   103a30 <debug_normal>
	struct mpconf  *conf;
	struct mpproc  *proc;
	struct mpioapic *mpio;
	uint32_t ap_idx = 1;

	if (mp_inited == TRUE)
  102db8:	80 3d 6d ce 12 00 01 	cmpb   $0x1,0x12ce6d
  102dbf:	0f 84 27 01 00 00    	je     102eec <pcpu_mp_init+0x35c>
	uint8_t          *bda;
	uint32_t            p;
	struct mp      *mp;

	bda = (uint8_t *) 0x400;
	if ((p = ((bda[0x0F] << 8) | bda[0x0E]) << 4)) {
  102dc5:	0f b6 05 0f 04 00 00 	movzbl 0x40f,%eax
  102dcc:	0f b6 15 0e 04 00 00 	movzbl 0x40e,%edx
  102dd3:	c1 e0 08             	shl    $0x8,%eax
  102dd6:	09 d0                	or     %edx,%eax
  102dd8:	c1 e0 04             	shl    $0x4,%eax
  102ddb:	85 c0                	test   %eax,%eax
  102ddd:	75 1b                	jne    102dfa <pcpu_mp_init+0x26a>
		if ((mp = mpsearch1((uint8_t *) p, 1024)))
			return mp;
	} else {
		p = ((bda[0x14] << 8) | bda[0x13]) * 1024;
  102ddf:	0f b6 05 14 04 00 00 	movzbl 0x414,%eax
  102de6:	0f b6 15 13 04 00 00 	movzbl 0x413,%edx
  102ded:	c1 e0 08             	shl    $0x8,%eax
  102df0:	09 d0                	or     %edx,%eax
  102df2:	c1 e0 0a             	shl    $0xa,%eax
		if ((mp = mpsearch1((uint8_t *) p - 1024, 1024)))
  102df5:	2d 00 04 00 00       	sub    $0x400,%eax
	uint32_t            p;
	struct mp      *mp;

	bda = (uint8_t *) 0x400;
	if ((p = ((bda[0x0F] << 8) | bda[0x0E]) << 4)) {
		if ((mp = mpsearch1((uint8_t *) p, 1024)))
  102dfa:	ba 00 04 00 00       	mov    $0x400,%edx
  102dff:	e8 2c fd ff ff       	call   102b30 <mpsearch1>
  102e04:	85 c0                	test   %eax,%eax
  102e06:	89 c7                	mov    %eax,%edi
  102e08:	0f 84 83 02 00 00    	je     103091 <pcpu_mp_init+0x501>
static struct mpconf *
mpconfig(struct mp **pmp) {
	struct mpconf  *conf;
	struct mp      *mp;

	if ((mp = mpsearch()) == 0 || mp->physaddr == 0)
  102e0e:	8b 5f 04             	mov    0x4(%edi),%ebx
  102e11:	85 db                	test   %ebx,%ebx
  102e13:	0f 84 25 02 00 00    	je     10303e <pcpu_mp_init+0x4ae>
		return 0;
	conf = (struct mpconf *) mp->physaddr;
	if (memcmp(conf, "PCMP", 4) != 0)
  102e19:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
  102e20:	00 
  102e21:	c7 44 24 04 96 85 10 	movl   $0x108596,0x4(%esp)
  102e28:	00 
  102e29:	89 1c 24             	mov    %ebx,(%esp)
  102e2c:	e8 5f 0b 00 00       	call   103990 <memcmp>
  102e31:	85 c0                	test   %eax,%eax
  102e33:	0f 85 05 02 00 00    	jne    10303e <pcpu_mp_init+0x4ae>
		return 0;
	if (conf->version != 1 && conf->version != 4)
  102e39:	0f b6 43 06          	movzbl 0x6(%ebx),%eax
  102e3d:	3c 04                	cmp    $0x4,%al
  102e3f:	0f 85 f1 01 00 00    	jne    103036 <pcpu_mp_init+0x4a6>
		return 0;
	if (sum((uint8_t *) conf, conf->length) != 0)
  102e45:	0f b7 73 04          	movzwl 0x4(%ebx),%esi
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++)
  102e49:	85 f6                	test   %esi,%esi
  102e4b:	74 20                	je     102e6d <pcpu_mp_init+0x2dd>
static uint8_t
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
  102e4d:	31 d2                	xor    %edx,%edx
	for (i = 0; i < len; i++)
  102e4f:	31 c0                	xor    %eax,%eax
  102e51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		sum += addr[i];
  102e58:	0f b6 0c 03          	movzbl (%ebx,%eax,1),%ecx
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++)
  102e5c:	83 c0 01             	add    $0x1,%eax
		sum += addr[i];
  102e5f:	01 ca                	add    %ecx,%edx
sum(uint8_t * addr, int len)
{
	int i, sum;

	sum = 0;
	for (i = 0; i < len; i++)
  102e61:	39 c6                	cmp    %eax,%esi
  102e63:	7f f3                	jg     102e58 <pcpu_mp_init+0x2c8>
	conf = (struct mpconf *) mp->physaddr;
	if (memcmp(conf, "PCMP", 4) != 0)
		return 0;
	if (conf->version != 1 && conf->version != 4)
		return 0;
	if (sum((uint8_t *) conf, conf->length) != 0)
  102e65:	84 d2                	test   %dl,%dl
  102e67:	0f 85 d1 01 00 00    	jne    10303e <pcpu_mp_init+0x4ae>

	ismp = 1;

	ncpu = 0;

	lapic_register((uintptr_t) conf->lapicaddr);
  102e6d:	8b 43 24             	mov    0x24(%ebx),%eax

	for (p = (uint8_t *) (conf + 1), e = (uint8_t *) conf + conf->length;
  102e70:	8d 6b 2c             	lea    0x2c(%ebx),%ebp
		return TRUE;

	if ((conf = mpconfig(&mp)) == 0) /* not SMP */
		return FALSE;

	ismp = 1;
  102e73:	c6 05 6c ce 12 00 01 	movb   $0x1,0x12ce6c

	ncpu = 0;
  102e7a:	c7 05 70 ce 12 00 00 	movl   $0x0,0x12ce70
  102e81:	00 00 00 

	lapic_register((uintptr_t) conf->lapicaddr);
  102e84:	89 04 24             	mov    %eax,(%esp)
  102e87:	e8 a4 f4 ff ff       	call   102330 <lapic_register>

	for (p = (uint8_t *) (conf + 1), e = (uint8_t *) conf + conf->length;
  102e8c:	0f b7 53 04          	movzwl 0x4(%ebx),%edx
  102e90:	01 d3                	add    %edx,%ebx
  102e92:	39 dd                	cmp    %ebx,%ebp
  102e94:	73 29                	jae    102ebf <pcpu_mp_init+0x32f>
	uint8_t *p, *e;
	struct mp      *mp;
	struct mpconf  *conf;
	struct mpproc  *proc;
	struct mpioapic *mpio;
	uint32_t ap_idx = 1;
  102e96:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
  102e9d:	00 
  102e9e:	66 90                	xchg   %ax,%ax

	lapic_register((uintptr_t) conf->lapicaddr);

	for (p = (uint8_t *) (conf + 1), e = (uint8_t *) conf + conf->length;
	     p < e;) {
		switch (*p) {
  102ea0:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
  102ea4:	3c 04                	cmp    $0x4,%al
  102ea6:	0f 87 a4 00 00 00    	ja     102f50 <pcpu_mp_init+0x3c0>
  102eac:	ff 24 85 00 86 10 00 	jmp    *0x108600(,%eax,4)
  102eb3:	90                   	nop
  102eb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
					mpio->apicno, 0);
			continue;
		case MPBUS:
		case MPIOINTR:
		case MPLINTR:
			p += 8;
  102eb8:	83 c5 08             	add    $0x8,%ebp

	ncpu = 0;

	lapic_register((uintptr_t) conf->lapicaddr);

	for (p = (uint8_t *) (conf + 1), e = (uint8_t *) conf + conf->length;
  102ebb:	39 eb                	cmp    %ebp,%ebx
  102ebd:	77 e1                	ja     102ea0 <pcpu_mp_init+0x310>
		default:
			KERN_WARN("mpinit: unknown config type %x\n", *p);
		}
	}

	if (mp->imcrp) {
  102ebf:	80 7f 0c 00          	cmpb   $0x0,0xc(%edi)
  102ec3:	0f 85 8d 01 00 00    	jne    103056 <pcpu_mp_init+0x4c6>
	}

	/*
	 * Copy AP boot code to 0x8000.
	 */
	memcpy((uint8_t *)0x8000,
  102ec9:	c7 44 24 08 62 00 00 	movl   $0x62,0x8(%esp)
  102ed0:	00 
  102ed1:	c7 44 24 04 64 b4 12 	movl   $0x12b464,0x4(%esp)
  102ed8:	00 
  102ed9:	c7 04 24 00 80 00 00 	movl   $0x8000,(%esp)
  102ee0:	e8 3b 09 00 00       	call   103820 <memcpy>
	       _binary___obj_kern_init_boot_ap_start,
	       (size_t)_binary___obj_kern_init_boot_ap_size);

	mp_inited = TRUE;
  102ee5:	c6 05 6d ce 12 00 01 	movb   $0x1,0x12ce6d
	if (mp_init_fallback() == FALSE) {
		ismp = 0;
		ncpu = 1;
		return FALSE;
	} else
		return TRUE;
  102eec:	b8 01 00 00 00       	mov    $0x1,%eax
  102ef1:	e9 fe fd ff ff       	jmp    102cf4 <pcpu_mp_init+0x164>
  102ef6:	66 90                	xchg   %ax,%ax
	     p < e;) {
		switch (*p) {
		case MPPROC:
			proc = (struct mpproc *) p;
			p += sizeof(struct mpproc);
			if (!(proc->flags & MPENAB))
  102ef8:	f6 45 03 01          	testb  $0x1,0x3(%ebp)
	for (p = (uint8_t *) (conf + 1), e = (uint8_t *) conf + conf->length;
	     p < e;) {
		switch (*p) {
		case MPPROC:
			proc = (struct mpproc *) p;
			p += sizeof(struct mpproc);
  102efc:	8d 75 14             	lea    0x14(%ebp),%esi
			if (!(proc->flags & MPENAB))
  102eff:	0f 85 9b 00 00 00    	jne    102fa0 <pcpu_mp_init+0x410>
	for (p = (uint8_t *) (conf + 1), e = (uint8_t *) conf + conf->length;
	     p < e;) {
		switch (*p) {
		case MPPROC:
			proc = (struct mpproc *) p;
			p += sizeof(struct mpproc);
  102f05:	89 f5                	mov    %esi,%ebp
  102f07:	eb b2                	jmp    102ebb <pcpu_mp_init+0x32b>
  102f09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			continue;
		case MPIOAPIC:
			mpio = (struct mpioapic *) p;
			p += sizeof(struct mpioapic);

			KERN_INFO("\tIOAPIC: APIC id = %x, base = %x\n",
  102f10:	8b 45 04             	mov    0x4(%ebp),%eax
			}
			ncpu++;
			continue;
		case MPIOAPIC:
			mpio = (struct mpioapic *) p;
			p += sizeof(struct mpioapic);
  102f13:	8d 75 08             	lea    0x8(%ebp),%esi

			KERN_INFO("\tIOAPIC: APIC id = %x, base = %x\n",
  102f16:	89 44 24 08          	mov    %eax,0x8(%esp)
  102f1a:	0f b6 45 01          	movzbl 0x1(%ebp),%eax
  102f1e:	c7 04 24 78 83 10 00 	movl   $0x108378,(%esp)
  102f25:	89 44 24 04          	mov    %eax,0x4(%esp)
  102f29:	e8 c2 0a 00 00       	call   1039f0 <debug_info>
				  mpio->apicno, mpio->addr);

			ioapic_register((uintptr_t) mpio->addr,
  102f2e:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  102f35:	00 
  102f36:	0f b6 45 01          	movzbl 0x1(%ebp),%eax
  102f3a:	89 44 24 04          	mov    %eax,0x4(%esp)
  102f3e:	8b 45 04             	mov    0x4(%ebp),%eax
			}
			ncpu++;
			continue;
		case MPIOAPIC:
			mpio = (struct mpioapic *) p;
			p += sizeof(struct mpioapic);
  102f41:	89 f5                	mov    %esi,%ebp

			KERN_INFO("\tIOAPIC: APIC id = %x, base = %x\n",
				  mpio->apicno, mpio->addr);

			ioapic_register((uintptr_t) mpio->addr,
  102f43:	89 04 24             	mov    %eax,(%esp)
  102f46:	e8 95 f8 ff ff       	call   1027e0 <ioapic_register>
  102f4b:	e9 6b ff ff ff       	jmp    102ebb <pcpu_mp_init+0x32b>
		case MPIOINTR:
		case MPLINTR:
			p += 8;
			continue;
		default:
			KERN_WARN("mpinit: unknown config type %x\n", *p);
  102f50:	89 44 24 0c          	mov    %eax,0xc(%esp)
  102f54:	c7 44 24 08 f4 83 10 	movl   $0x1083f4,0x8(%esp)
  102f5b:	00 
  102f5c:	c7 44 24 04 3c 01 00 	movl   $0x13c,0x4(%esp)
  102f63:	00 
  102f64:	c7 04 24 3c 85 10 00 	movl   $0x10853c,(%esp)
  102f6b:	e8 e0 0b 00 00       	call   103b50 <debug_warn>
  102f70:	e9 46 ff ff ff       	jmp    102ebb <pcpu_mp_init+0x32b>
  102f75:	8d 76 00             	lea    0x0(%esi),%esi

	if ((madt =
	     (xsdt != NULL) ?
	     (acpi_madt_t *) acpi_probe_xsdt_ent(xsdt, ACPI_MADT_SIG) :
	     (acpi_madt_t *) acpi_probe_rsdt_ent(rsdt, ACPI_MADT_SIG)) == NULL) {
		KERN_DEBUG("Not found MADT.\n");
  102f78:	c7 44 24 08 65 85 10 	movl   $0x108565,0x8(%esp)
  102f7f:	00 
  102f80:	c7 44 24 04 76 01 00 	movl   $0x176,0x4(%esp)
  102f87:	00 
  102f88:	c7 04 24 3c 85 10 00 	movl   $0x10853c,(%esp)
  102f8f:	e8 9c 0a 00 00       	call   103a30 <debug_normal>
		goto fallback;
  102f94:	e9 03 fe ff ff       	jmp    102d9c <pcpu_mp_init+0x20c>
  102f99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			proc = (struct mpproc *) p;
			p += sizeof(struct mpproc);
			if (!(proc->flags & MPENAB))
				continue;

			KERN_INFO("\tCPU%d: APIC id = %x, ",
  102fa0:	0f b6 45 01          	movzbl 0x1(%ebp),%eax
  102fa4:	c7 04 24 76 85 10 00 	movl   $0x108576,(%esp)
  102fab:	89 44 24 08          	mov    %eax,0x8(%esp)
  102faf:	a1 70 ce 12 00       	mov    0x12ce70,%eax
  102fb4:	89 44 24 04          	mov    %eax,0x4(%esp)
  102fb8:	e8 33 0a 00 00       	call   1039f0 <debug_info>
				  ncpu, proc->apicid);

			if (proc->flags & MPBOOT) {
  102fbd:	f6 45 03 02          	testb  $0x2,0x3(%ebp)
  102fc1:	75 55                	jne    103018 <pcpu_mp_init+0x488>
				KERN_INFO("BSP.\n");
				pcpu_mp_init_cpu(0, proc->apicid, TRUE);
			} else {
				KERN_INFO("AP.\n");
  102fc3:	c7 04 24 a1 85 10 00 	movl   $0x1085a1,(%esp)
  102fca:	e8 21 0a 00 00       	call   1039f0 <debug_info>
				pcpu_mp_init_cpu(ap_idx, proc->apicid, FALSE);
  102fcf:	0f b6 55 01          	movzbl 0x1(%ebp),%edx
  102fd3:	31 c9                	xor    %ecx,%ecx
  102fd5:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  102fd9:	e8 e2 fa ff ff       	call   102ac0 <pcpu_mp_init_cpu>
				ap_idx++;
  102fde:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
			}
			ncpu++;
  102fe3:	83 05 70 ce 12 00 01 	addl   $0x1,0x12ce70
	for (p = (uint8_t *) (conf + 1), e = (uint8_t *) conf + conf->length;
	     p < e;) {
		switch (*p) {
		case MPPROC:
			proc = (struct mpproc *) p;
			p += sizeof(struct mpproc);
  102fea:	89 f5                	mov    %esi,%ebp
  102fec:	e9 ca fe ff ff       	jmp    102ebb <pcpu_mp_init+0x32b>
		KERN_DEBUG("Not found RSDP.\n");
		goto fallback;
	}

	xsdt = NULL;
	if ((xsdt = acpi_probe_xsdt(rsdp)) == NULL &&
  102ff1:	89 1c 24             	mov    %ebx,(%esp)
  102ff4:	e8 f7 f0 ff ff       	call   1020f0 <acpi_probe_rsdt>
  102ff9:	85 c0                	test   %eax,%eax
  102ffb:	0f 84 ab 00 00 00    	je     1030ac <pcpu_mp_init+0x51c>
		goto fallback;
	}

	if ((madt =
	     (xsdt != NULL) ?
	     (acpi_madt_t *) acpi_probe_xsdt_ent(xsdt, ACPI_MADT_SIG) :
  103001:	c7 44 24 04 41 50 49 	movl   $0x43495041,0x4(%esp)
  103008:	43 
  103009:	89 04 24             	mov    %eax,(%esp)
  10300c:	e8 5f f1 ff ff       	call   102170 <acpi_probe_rsdt_ent>
  103011:	89 c7                	mov    %eax,%edi
  103013:	e9 ce fb ff ff       	jmp    102be6 <pcpu_mp_init+0x56>

			KERN_INFO("\tCPU%d: APIC id = %x, ",
				  ncpu, proc->apicid);

			if (proc->flags & MPBOOT) {
				KERN_INFO("BSP.\n");
  103018:	c7 04 24 9b 85 10 00 	movl   $0x10859b,(%esp)
  10301f:	e8 cc 09 00 00       	call   1039f0 <debug_info>
				pcpu_mp_init_cpu(0, proc->apicid, TRUE);
  103024:	0f b6 55 01          	movzbl 0x1(%ebp),%edx
  103028:	b9 01 00 00 00       	mov    $0x1,%ecx
  10302d:	31 c0                	xor    %eax,%eax
  10302f:	e8 8c fa ff ff       	call   102ac0 <pcpu_mp_init_cpu>
  103034:	eb ad                	jmp    102fe3 <pcpu_mp_init+0x453>
	if ((mp = mpsearch()) == 0 || mp->physaddr == 0)
		return 0;
	conf = (struct mpconf *) mp->physaddr;
	if (memcmp(conf, "PCMP", 4) != 0)
		return 0;
	if (conf->version != 1 && conf->version != 4)
  103036:	3c 01                	cmp    $0x1,%al
  103038:	0f 84 07 fe ff ff    	je     102e45 <pcpu_mp_init+0x2b5>
	return TRUE;

 fallback:
	KERN_DEBUG("Use the fallback multiprocessor initialization.\n");
	if (mp_init_fallback() == FALSE) {
		ismp = 0;
  10303e:	c6 05 6c ce 12 00 00 	movb   $0x0,0x12ce6c
		ncpu = 1;
		return FALSE;
  103045:	31 c0                	xor    %eax,%eax

 fallback:
	KERN_DEBUG("Use the fallback multiprocessor initialization.\n");
	if (mp_init_fallback() == FALSE) {
		ismp = 0;
		ncpu = 1;
  103047:	c7 05 70 ce 12 00 01 	movl   $0x1,0x12ce70
  10304e:	00 00 00 
		return FALSE;
  103051:	e9 9e fc ff ff       	jmp    102cf4 <pcpu_mp_init+0x164>
			KERN_WARN("mpinit: unknown config type %x\n", *p);
		}
	}

	if (mp->imcrp) {
		outb(0x22, 0x70);
  103056:	c7 44 24 04 70 00 00 	movl   $0x70,0x4(%esp)
  10305d:	00 
  10305e:	c7 04 24 22 00 00 00 	movl   $0x22,(%esp)
  103065:	e8 d6 18 00 00       	call   104940 <outb>
		outb(0x23, inb(0x23) | 1);
  10306a:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
  103071:	e8 9a 18 00 00       	call   104910 <inb>
  103076:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
  10307d:	83 c8 01             	or     $0x1,%eax
  103080:	0f b6 c0             	movzbl %al,%eax
  103083:	89 44 24 04          	mov    %eax,0x4(%esp)
  103087:	e8 b4 18 00 00       	call   104940 <outb>
  10308c:	e9 38 fe ff ff       	jmp    102ec9 <pcpu_mp_init+0x339>
	} else {
		p = ((bda[0x14] << 8) | bda[0x13]) * 1024;
		if ((mp = mpsearch1((uint8_t *) p - 1024, 1024)))
			return mp;
	}
	return mpsearch1((uint8_t *) 0xF0000, 0x10000);
  103091:	ba 00 00 01 00       	mov    $0x10000,%edx
  103096:	b8 00 00 0f 00       	mov    $0xf0000,%eax
  10309b:	e8 90 fa ff ff       	call   102b30 <mpsearch1>
static struct mpconf *
mpconfig(struct mp **pmp) {
	struct mpconf  *conf;
	struct mp      *mp;

	if ((mp = mpsearch()) == 0 || mp->physaddr == 0)
  1030a0:	85 c0                	test   %eax,%eax
	} else {
		p = ((bda[0x14] << 8) | bda[0x13]) * 1024;
		if ((mp = mpsearch1((uint8_t *) p - 1024, 1024)))
			return mp;
	}
	return mpsearch1((uint8_t *) 0xF0000, 0x10000);
  1030a2:	89 c7                	mov    %eax,%edi
static struct mpconf *
mpconfig(struct mp **pmp) {
	struct mpconf  *conf;
	struct mp      *mp;

	if ((mp = mpsearch()) == 0 || mp->physaddr == 0)
  1030a4:	0f 85 64 fd ff ff    	jne    102e0e <pcpu_mp_init+0x27e>
  1030aa:	eb 92                	jmp    10303e <pcpu_mp_init+0x4ae>
	}

	xsdt = NULL;
	if ((xsdt = acpi_probe_xsdt(rsdp)) == NULL &&
	    (rsdt = acpi_probe_rsdt(rsdp)) == NULL) {
		KERN_DEBUG("Not found either RSDT or XSDT.\n");
  1030ac:	c7 44 24 08 58 83 10 	movl   $0x108358,0x8(%esp)
  1030b3:	00 
  1030b4:	c7 44 24 04 6e 01 00 	movl   $0x16e,0x4(%esp)
  1030bb:	00 
  1030bc:	c7 04 24 3c 85 10 00 	movl   $0x10853c,(%esp)
  1030c3:	e8 68 09 00 00       	call   103a30 <debug_normal>
		goto fallback;
  1030c8:	e9 cf fc ff ff       	jmp    102d9c <pcpu_mp_init+0x20c>
  1030cd:	8d 76 00             	lea    0x0(%esi),%esi

001030d0 <pcpu_init_cpu>:
	return 0;
}

void
pcpu_init_cpu(void)
{
  1030d0:	55                   	push   %ebp
  1030d1:	57                   	push   %edi
  1030d2:	56                   	push   %esi
  1030d3:	53                   	push   %ebx
  1030d4:	81 ec 9c 00 00 00    	sub    $0x9c,%esp
}

static void
pcpu_identify(void)
{
	int cpu_idx = get_pcpu_idx();
  1030da:	e8 e1 23 00 00       	call   1054c0 <get_pcpu_idx>
	struct pcpuinfo *cpuinfo = (struct pcpuinfo*) get_pcpu_arch_info_pointer(cpu_idx);
	uint32_t eax, ebx, ecx, edx;

	int i, j;
	uint8_t *desc;
	uint32_t *regs[4] = { &eax, &ebx, &ecx, &edx };
  1030df:	8d 6c 24 78          	lea    0x78(%esp),%ebp
  1030e3:	8d 5c 24 7c          	lea    0x7c(%esp),%ebx

static void
pcpu_identify(void)
{
	int cpu_idx = get_pcpu_idx();
	struct pcpuinfo *cpuinfo = (struct pcpuinfo*) get_pcpu_arch_info_pointer(cpu_idx);
  1030e7:	89 04 24             	mov    %eax,(%esp)
  1030ea:	e8 c1 24 00 00       	call   1055b0 <get_pcpu_arch_info_pointer>
		[0x66] = {  8, 64 },
		[0x67] = { 16, 64 },
		[0x68] = { 32, 64 }
	};

	cpuid(0x0, &eax, &ebx, &ecx, &edx);
  1030ef:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  1030f3:	89 6c 24 0c          	mov    %ebp,0xc(%esp)
  1030f7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
	struct pcpuinfo *cpuinfo = (struct pcpuinfo*) get_pcpu_arch_info_pointer(cpu_idx);
	uint32_t eax, ebx, ecx, edx;

	int i, j;
	uint8_t *desc;
	uint32_t *regs[4] = { &eax, &ebx, &ecx, &edx };
  1030fe:	89 ac 24 88 00 00 00 	mov    %ebp,0x88(%esp)
  103105:	89 9c 24 8c 00 00 00 	mov    %ebx,0x8c(%esp)

static void
pcpu_identify(void)
{
	int cpu_idx = get_pcpu_idx();
	struct pcpuinfo *cpuinfo = (struct pcpuinfo*) get_pcpu_arch_info_pointer(cpu_idx);
  10310c:	89 c7                	mov    %eax,%edi
	uint32_t eax, ebx, ecx, edx;

	int i, j;
	uint8_t *desc;
	uint32_t *regs[4] = { &eax, &ebx, &ecx, &edx };
  10310e:	8d 44 24 70          	lea    0x70(%esp),%eax
  103112:	89 84 24 80 00 00 00 	mov    %eax,0x80(%esp)
  103119:	8d 44 24 74          	lea    0x74(%esp),%eax
  10311d:	89 84 24 84 00 00 00 	mov    %eax,0x84(%esp)
		[0x66] = {  8, 64 },
		[0x67] = { 16, 64 },
		[0x68] = { 32, 64 }
	};

	cpuid(0x0, &eax, &ebx, &ecx, &edx);
  103124:	89 44 24 08          	mov    %eax,0x8(%esp)
  103128:	8d 44 24 70          	lea    0x70(%esp),%eax
  10312c:	89 44 24 04          	mov    %eax,0x4(%esp)
  103130:	e8 3b 16 00 00       	call   104770 <cpuid>
	cpuinfo->cpuid_high = eax;
  103135:	8b 44 24 70          	mov    0x70(%esp),%eax
	((uint32_t *) cpuinfo->vendor)[0] = ebx;
	((uint32_t *) cpuinfo->vendor)[1] = edx;
	((uint32_t *) cpuinfo->vendor)[2] = ecx;
	cpuinfo->vendor[12] = '\0';
  103139:	c6 47 18 00          	movb   $0x0,0x18(%edi)
		[0x67] = { 16, 64 },
		[0x68] = { 32, 64 }
	};

	cpuid(0x0, &eax, &ebx, &ecx, &edx);
	cpuinfo->cpuid_high = eax;
  10313d:	89 47 08             	mov    %eax,0x8(%edi)
	((uint32_t *) cpuinfo->vendor)[0] = ebx;
  103140:	8b 44 24 74          	mov    0x74(%esp),%eax
  103144:	89 47 0c             	mov    %eax,0xc(%edi)
	((uint32_t *) cpuinfo->vendor)[1] = edx;
  103147:	8b 44 24 7c          	mov    0x7c(%esp),%eax
  10314b:	89 47 10             	mov    %eax,0x10(%edi)
	((uint32_t *) cpuinfo->vendor)[2] = ecx;
  10314e:	8b 44 24 78          	mov    0x78(%esp),%eax
  103152:	89 47 14             	mov    %eax,0x14(%edi)
	cpuinfo->vendor[12] = '\0';

	if (strncmp(cpuinfo->vendor, "GenuineIntel", 20) == 0)
  103155:	8d 47 0c             	lea    0xc(%edi),%eax
  103158:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
  10315f:	00 
  103160:	c7 44 24 04 db 85 10 	movl   $0x1085db,0x4(%esp)
  103167:	00 
  103168:	89 04 24             	mov    %eax,(%esp)
  10316b:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  10316f:	e8 bc 06 00 00       	call   103830 <strncmp>
  103174:	85 c0                	test   %eax,%eax
  103176:	0f 85 44 03 00 00    	jne    1034c0 <pcpu_init_cpu+0x3f0>
		cpuinfo->cpu_vendor = INTEL;
  10317c:	c7 47 20 01 00 00 00 	movl   $0x1,0x20(%edi)
	else if (strncmp(cpuinfo->vendor, "AuthenticAMD", 20) == 0)
		cpuinfo->cpu_vendor = AMD;
	else
		cpuinfo->cpu_vendor = UNKNOWN_CPU;

	cpuid(0x1, &eax, &ebx, &ecx, &edx);
  103183:	8d 44 24 74          	lea    0x74(%esp),%eax
  103187:	89 44 24 08          	mov    %eax,0x8(%esp)
  10318b:	8d 44 24 70          	lea    0x70(%esp),%eax
  10318f:	89 44 24 04          	mov    %eax,0x4(%esp)
  103193:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  103197:	89 6c 24 0c          	mov    %ebp,0xc(%esp)
  10319b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1031a2:	e8 c9 15 00 00       	call   104770 <cpuid>
	cpuinfo->family = (eax >> 8) & 0xf;
  1031a7:	8b 44 24 70          	mov    0x70(%esp),%eax
  1031ab:	89 c2                	mov    %eax,%edx
  1031ad:	c1 ea 08             	shr    $0x8,%edx
  1031b0:	83 e2 0f             	and    $0xf,%edx
  1031b3:	88 57 24             	mov    %dl,0x24(%edi)
	cpuinfo->model = (eax >> 4) & 0xf;
  1031b6:	89 c2                	mov    %eax,%edx
  1031b8:	c1 ea 04             	shr    $0x4,%edx
  1031bb:	83 e2 0f             	and    $0xf,%edx
  1031be:	88 57 25             	mov    %dl,0x25(%edi)
	cpuinfo->step = eax & 0xf;
  1031c1:	89 c2                	mov    %eax,%edx
  1031c3:	83 e2 0f             	and    $0xf,%edx
  1031c6:	88 57 26             	mov    %dl,0x26(%edi)
	cpuinfo->ext_family = (eax >> 20) & 0xff;
  1031c9:	89 c2                	mov    %eax,%edx
	cpuinfo->ext_model = (eax >> 16) & 0xff;
  1031cb:	c1 e8 10             	shr    $0x10,%eax
  1031ce:	88 47 28             	mov    %al,0x28(%edi)
	cpuinfo->brand_idx = ebx & 0xff;
  1031d1:	8b 44 24 74          	mov    0x74(%esp),%eax

	cpuid(0x1, &eax, &ebx, &ecx, &edx);
	cpuinfo->family = (eax >> 8) & 0xf;
	cpuinfo->model = (eax >> 4) & 0xf;
	cpuinfo->step = eax & 0xf;
	cpuinfo->ext_family = (eax >> 20) & 0xff;
  1031d5:	c1 ea 14             	shr    $0x14,%edx
  1031d8:	88 57 27             	mov    %dl,0x27(%edi)
	cpuinfo->ext_model = (eax >> 16) & 0xff;
	cpuinfo->brand_idx = ebx & 0xff;
	cpuinfo->clflush_size = (ebx >> 8) & 0xff;
  1031db:	89 c2                	mov    %eax,%edx
  1031dd:	c1 ea 08             	shr    $0x8,%edx
	cpuinfo->family = (eax >> 8) & 0xf;
	cpuinfo->model = (eax >> 4) & 0xf;
	cpuinfo->step = eax & 0xf;
	cpuinfo->ext_family = (eax >> 20) & 0xff;
	cpuinfo->ext_model = (eax >> 16) & 0xff;
	cpuinfo->brand_idx = ebx & 0xff;
  1031e0:	88 47 29             	mov    %al,0x29(%edi)
	cpuinfo->clflush_size = (ebx >> 8) & 0xff;
  1031e3:	88 57 2a             	mov    %dl,0x2a(%edi)
	cpuinfo->max_cpu_id = (ebx >> 16) &0xff;
  1031e6:	89 c2                	mov    %eax,%edx
	cpuinfo->apic_id = (ebx >> 24) & 0xff;
  1031e8:	c1 e8 18             	shr    $0x18,%eax
  1031eb:	88 47 2c             	mov    %al,0x2c(%edi)
	cpuinfo->feature1 = ecx;
  1031ee:	8b 44 24 78          	mov    0x78(%esp),%eax
	cpuinfo->step = eax & 0xf;
	cpuinfo->ext_family = (eax >> 20) & 0xff;
	cpuinfo->ext_model = (eax >> 16) & 0xff;
	cpuinfo->brand_idx = ebx & 0xff;
	cpuinfo->clflush_size = (ebx >> 8) & 0xff;
	cpuinfo->max_cpu_id = (ebx >> 16) &0xff;
  1031f2:	c1 ea 10             	shr    $0x10,%edx
  1031f5:	88 57 2b             	mov    %dl,0x2b(%edi)
	cpuinfo->apic_id = (ebx >> 24) & 0xff;
	cpuinfo->feature1 = ecx;
  1031f8:	89 47 30             	mov    %eax,0x30(%edi)
	cpuinfo->feature2 = edx;
  1031fb:	8b 44 24 7c          	mov    0x7c(%esp),%eax
  1031ff:	89 47 34             	mov    %eax,0x34(%edi)

	switch (cpuinfo->cpu_vendor) {
  103202:	8b 47 20             	mov    0x20(%edi),%eax
  103205:	83 f8 01             	cmp    $0x1,%eax
  103208:	0f 84 a2 01 00 00    	je     1033b0 <pcpu_init_cpu+0x2e0>
  10320e:	83 f8 02             	cmp    $0x2,%eax
  103211:	0f 84 59 01 00 00    	je     103370 <pcpu_init_cpu+0x2a0>
		cpuid(0x80000005, &eax, &ebx, &ecx, &edx);
		cpuinfo->l1_cache_size = (ecx & 0xff000000) >> 24;
		cpuinfo->l1_cache_line_size = (ecx & 0x000000ff);
		break;
	default:
		cpuinfo->l1_cache_size = 0;
  103217:	c7 47 38 00 00 00 00 	movl   $0x0,0x38(%edi)
		cpuinfo->l1_cache_line_size = 0;
  10321e:	c7 47 3c 00 00 00 00 	movl   $0x0,0x3c(%edi)
		break;
	}

	cpuid(0x80000000, &eax, &ebx, &ecx, &edx);
  103225:	8d 44 24 74          	lea    0x74(%esp),%eax
lapicid_t pcpu_cpu_lapicid(int cpu_idx);

static gcc_inline void
pcpu_print_cpuinfo(uint32_t cpu_idx, struct pcpuinfo *cpuinfo)
{
	KERN_INFO("CPU%d: %s, FAMILY %d(%d), MODEL %d(%d), STEP %d, "
  103229:	be bf 85 10 00       	mov    $0x1085bf,%esi
		cpuinfo->l1_cache_size = 0;
		cpuinfo->l1_cache_line_size = 0;
		break;
	}

	cpuid(0x80000000, &eax, &ebx, &ecx, &edx);
  10322e:	89 44 24 08          	mov    %eax,0x8(%esp)
  103232:	8d 44 24 70          	lea    0x70(%esp),%eax
  103236:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  10323a:	89 6c 24 0c          	mov    %ebp,0xc(%esp)
lapicid_t pcpu_cpu_lapicid(int cpu_idx);

static gcc_inline void
pcpu_print_cpuinfo(uint32_t cpu_idx, struct pcpuinfo *cpuinfo)
{
	KERN_INFO("CPU%d: %s, FAMILY %d(%d), MODEL %d(%d), STEP %d, "
  10323e:	bd a6 85 10 00       	mov    $0x1085a6,%ebp
		cpuinfo->l1_cache_size = 0;
		cpuinfo->l1_cache_line_size = 0;
		break;
	}

	cpuid(0x80000000, &eax, &ebx, &ecx, &edx);
  103243:	89 44 24 04          	mov    %eax,0x4(%esp)
  103247:	c7 04 24 00 00 00 80 	movl   $0x80000000,(%esp)
  10324e:	e8 1d 15 00 00       	call   104770 <cpuid>
	cpuinfo->cpuid_exthigh = eax;
  103253:	8b 44 24 70          	mov    0x70(%esp),%eax
  103257:	89 47 40             	mov    %eax,0x40(%edi)

	pcpu_print_cpuinfo(get_pcpu_idx(), cpuinfo);
  10325a:	e8 61 22 00 00       	call   1054c0 <get_pcpu_idx>
lapicid_t pcpu_cpu_lapicid(int cpu_idx);

static gcc_inline void
pcpu_print_cpuinfo(uint32_t cpu_idx, struct pcpuinfo *cpuinfo)
{
	KERN_INFO("CPU%d: %s, FAMILY %d(%d), MODEL %d(%d), STEP %d, "
  10325f:	8b 5f 38             	mov    0x38(%edi),%ebx
  103262:	ba 70 92 10 00       	mov    $0x109270,%edx
  103267:	b9 b7 85 10 00       	mov    $0x1085b7,%ecx
  10326c:	c7 44 24 58 d5 85 10 	movl   $0x1085d5,0x58(%esp)
  103273:	00 
  103274:	89 5c 24 64          	mov    %ebx,0x64(%esp)
  103278:	bb af 85 10 00       	mov    $0x1085af,%ebx
	}

	cpuid(0x80000000, &eax, &ebx, &ecx, &edx);
	cpuinfo->cpuid_exthigh = eax;

	pcpu_print_cpuinfo(get_pcpu_idx(), cpuinfo);
  10327d:	89 44 24 60          	mov    %eax,0x60(%esp)
lapicid_t pcpu_cpu_lapicid(int cpu_idx);

static gcc_inline void
pcpu_print_cpuinfo(uint32_t cpu_idx, struct pcpuinfo *cpuinfo)
{
	KERN_INFO("CPU%d: %s, FAMILY %d(%d), MODEL %d(%d), STEP %d, "
  103281:	8b 47 30             	mov    0x30(%edi),%eax
  103284:	a9 00 00 80 00       	test   $0x800000,%eax
  103289:	0f 44 ea             	cmove  %edx,%ebp
  10328c:	a9 00 00 10 00       	test   $0x100000,%eax
  103291:	0f 44 da             	cmove  %edx,%ebx
  103294:	a9 00 00 08 00       	test   $0x80000,%eax
  103299:	89 5c 24 6c          	mov    %ebx,0x6c(%esp)
  10329d:	8b 5f 34             	mov    0x34(%edi),%ebx
  1032a0:	0f 44 ca             	cmove  %edx,%ecx
  1032a3:	f6 c4 02             	test   $0x2,%ah
  1032a6:	0f 44 f2             	cmove  %edx,%esi
  1032a9:	a8 01                	test   $0x1,%al
  1032ab:	89 74 24 68          	mov    %esi,0x68(%esp)
  1032af:	be c7 85 10 00       	mov    $0x1085c7,%esi
  1032b4:	89 5c 24 54          	mov    %ebx,0x54(%esp)
  1032b8:	0f 44 f2             	cmove  %edx,%esi
  1032bb:	bb ce 85 10 00       	mov    $0x1085ce,%ebx
  1032c0:	f7 44 24 54 00 00 00 	testl  $0x4000000,0x54(%esp)
  1032c7:	04 
  1032c8:	0f 44 da             	cmove  %edx,%ebx
  1032cb:	f7 44 24 54 00 00 00 	testl  $0x2000000,0x54(%esp)
  1032d2:	02 
  1032d3:	0f 45 54 24 58       	cmovne 0x58(%esp),%edx
  1032d8:	89 54 24 58          	mov    %edx,0x58(%esp)
  1032dc:	8b 57 3c             	mov    0x3c(%edi),%edx
  1032df:	89 4c 24 38          	mov    %ecx,0x38(%esp)
  1032e3:	8b 4c 24 68          	mov    0x68(%esp),%ecx
  1032e7:	89 5c 24 2c          	mov    %ebx,0x2c(%esp)
  1032eb:	8b 5c 24 54          	mov    0x54(%esp),%ebx
  1032ef:	89 6c 24 40          	mov    %ebp,0x40(%esp)
  1032f3:	89 54 24 48          	mov    %edx,0x48(%esp)
  1032f7:	8b 54 24 64          	mov    0x64(%esp),%edx
  1032fb:	89 4c 24 34          	mov    %ecx,0x34(%esp)
  1032ff:	89 74 24 30          	mov    %esi,0x30(%esp)
  103303:	89 5c 24 24          	mov    %ebx,0x24(%esp)
  103307:	89 54 24 44          	mov    %edx,0x44(%esp)
  10330b:	8b 54 24 6c          	mov    0x6c(%esp),%edx
  10330f:	89 44 24 20          	mov    %eax,0x20(%esp)
  103313:	89 54 24 3c          	mov    %edx,0x3c(%esp)
  103317:	8b 54 24 58          	mov    0x58(%esp),%edx
  10331b:	89 54 24 28          	mov    %edx,0x28(%esp)
  10331f:	0f b6 47 26          	movzbl 0x26(%edi),%eax
  103323:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  103327:	0f b6 47 28          	movzbl 0x28(%edi),%eax
  10332b:	89 44 24 18          	mov    %eax,0x18(%esp)
  10332f:	0f b6 47 25          	movzbl 0x25(%edi),%eax
  103333:	8b 5c 24 5c          	mov    0x5c(%esp),%ebx
  103337:	89 44 24 14          	mov    %eax,0x14(%esp)
  10333b:	0f b6 47 27          	movzbl 0x27(%edi),%eax
  10333f:	89 44 24 10          	mov    %eax,0x10(%esp)
  103343:	0f b6 47 24          	movzbl 0x24(%edi),%eax
  103347:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  10334b:	c7 04 24 14 84 10 00 	movl   $0x108414,(%esp)
  103352:	89 44 24 0c          	mov    %eax,0xc(%esp)
  103356:	8b 44 24 60          	mov    0x60(%esp),%eax
  10335a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10335e:	e8 8d 06 00 00       	call   1039f0 <debug_info>

void
pcpu_init_cpu(void)
{
	pcpu_identify();
}
  103363:	81 c4 9c 00 00 00    	add    $0x9c,%esp
  103369:	5b                   	pop    %ebx
  10336a:	5e                   	pop    %esi
  10336b:	5f                   	pop    %edi
  10336c:	5d                   	pop    %ebp
  10336d:	c3                   	ret    
  10336e:	66 90                	xchg   %ax,%ax
			1024;
		cpuinfo->l1_cache_line_size = ((ebx & 0x00000fff)) + 1;

		break;
	case AMD:
		cpuid(0x80000005, &eax, &ebx, &ecx, &edx);
  103370:	8d 44 24 74          	lea    0x74(%esp),%eax
  103374:	89 44 24 08          	mov    %eax,0x8(%esp)
  103378:	8d 44 24 70          	lea    0x70(%esp),%eax
  10337c:	89 44 24 04          	mov    %eax,0x4(%esp)
  103380:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  103384:	89 6c 24 0c          	mov    %ebp,0xc(%esp)
  103388:	c7 04 24 05 00 00 80 	movl   $0x80000005,(%esp)
  10338f:	e8 dc 13 00 00       	call   104770 <cpuid>
		cpuinfo->l1_cache_size = (ecx & 0xff000000) >> 24;
  103394:	8b 44 24 78          	mov    0x78(%esp),%eax
  103398:	89 c2                	mov    %eax,%edx
		cpuinfo->l1_cache_line_size = (ecx & 0x000000ff);
  10339a:	25 ff 00 00 00       	and    $0xff,%eax
		cpuinfo->l1_cache_line_size = ((ebx & 0x00000fff)) + 1;

		break;
	case AMD:
		cpuid(0x80000005, &eax, &ebx, &ecx, &edx);
		cpuinfo->l1_cache_size = (ecx & 0xff000000) >> 24;
  10339f:	c1 ea 18             	shr    $0x18,%edx
  1033a2:	89 57 38             	mov    %edx,0x38(%edi)
		cpuinfo->l1_cache_line_size = (ecx & 0x000000ff);
  1033a5:	89 47 3c             	mov    %eax,0x3c(%edi)
  1033a8:	e9 78 fe ff ff       	jmp    103225 <pcpu_init_cpu+0x155>
  1033ad:	8d 76 00             	lea    0x0(%esi),%esi
	cpuinfo->feature2 = edx;

	switch (cpuinfo->cpu_vendor) {
	case INTEL:
		/* try cpuid 2 first */
		cpuid(0x00000002, &eax, &ebx, &ecx, &edx);
  1033b0:	8d 44 24 74          	lea    0x74(%esp),%eax
  1033b4:	89 44 24 08          	mov    %eax,0x8(%esp)
  1033b8:	8d 44 24 70          	lea    0x70(%esp),%eax
  1033bc:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  1033c0:	89 6c 24 0c          	mov    %ebp,0xc(%esp)
  1033c4:	89 44 24 04          	mov    %eax,0x4(%esp)
  1033c8:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1033cf:	e8 9c 13 00 00       	call   104770 <cpuid>
		i = eax & 0x000000ff;
  1033d4:	0f b6 74 24 70       	movzbl 0x70(%esp),%esi
		while (i--)
  1033d9:	85 f6                	test   %esi,%esi
  1033db:	74 2c                	je     103409 <pcpu_init_cpu+0x339>
  1033dd:	8d 76 00             	lea    0x0(%esi),%esi
			cpuid(0x00000002, &eax, &ebx, &ecx, &edx);
  1033e0:	8d 44 24 74          	lea    0x74(%esp),%eax
  1033e4:	89 44 24 08          	mov    %eax,0x8(%esp)
  1033e8:	8d 44 24 70          	lea    0x70(%esp),%eax
  1033ec:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  1033f0:	89 6c 24 0c          	mov    %ebp,0xc(%esp)
  1033f4:	89 44 24 04          	mov    %eax,0x4(%esp)
  1033f8:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1033ff:	e8 6c 13 00 00       	call   104770 <cpuid>
	switch (cpuinfo->cpu_vendor) {
	case INTEL:
		/* try cpuid 2 first */
		cpuid(0x00000002, &eax, &ebx, &ecx, &edx);
		i = eax & 0x000000ff;
		while (i--)
  103404:	83 ee 01             	sub    $0x1,%esi
  103407:	75 d7                	jne    1033e0 <pcpu_init_cpu+0x310>
  103409:	8d 84 24 80 00 00 00 	lea    0x80(%esp),%eax
  103410:	89 44 24 54          	mov    %eax,0x54(%esp)
			cpuid(0x00000002, &eax, &ebx, &ecx, &edx);

		for (i = 0; i < 4; i++) {
			desc = (uint8_t *) regs[i];
  103414:	8b 44 24 54          	mov    0x54(%esp),%eax
  103418:	8b 10                	mov    (%eax),%edx
			for (j = 0; j < 4; j++) {
  10341a:	31 c0                	xor    %eax,%eax
				cpuinfo->l1_cache_size =
					intel_cache_info[desc[j]][0];
  10341c:	0f b6 0c 02          	movzbl (%edx,%eax,1),%ecx
			cpuid(0x00000002, &eax, &ebx, &ecx, &edx);

		for (i = 0; i < 4; i++) {
			desc = (uint8_t *) regs[i];
			for (j = 0; j < 4; j++) {
				cpuinfo->l1_cache_size =
  103420:	8b 0c cd 20 86 10 00 	mov    0x108620(,%ecx,8),%ecx
  103427:	89 4f 38             	mov    %ecx,0x38(%edi)
					intel_cache_info[desc[j]][0];
				cpuinfo->l1_cache_line_size =
					intel_cache_info[desc[j]][1];
  10342a:	0f b6 34 02          	movzbl (%edx,%eax,1),%esi
		while (i--)
			cpuid(0x00000002, &eax, &ebx, &ecx, &edx);

		for (i = 0; i < 4; i++) {
			desc = (uint8_t *) regs[i];
			for (j = 0; j < 4; j++) {
  10342e:	83 c0 01             	add    $0x1,%eax
  103431:	83 f8 04             	cmp    $0x4,%eax
				cpuinfo->l1_cache_size =
					intel_cache_info[desc[j]][0];
				cpuinfo->l1_cache_line_size =
  103434:	8b 34 f5 24 86 10 00 	mov    0x108624(,%esi,8),%esi
  10343b:	89 77 3c             	mov    %esi,0x3c(%edi)
		while (i--)
			cpuid(0x00000002, &eax, &ebx, &ecx, &edx);

		for (i = 0; i < 4; i++) {
			desc = (uint8_t *) regs[i];
			for (j = 0; j < 4; j++) {
  10343e:	75 dc                	jne    10341c <pcpu_init_cpu+0x34c>
  103440:	83 44 24 54 04       	addl   $0x4,0x54(%esp)
		cpuid(0x00000002, &eax, &ebx, &ecx, &edx);
		i = eax & 0x000000ff;
		while (i--)
			cpuid(0x00000002, &eax, &ebx, &ecx, &edx);

		for (i = 0; i < 4; i++) {
  103445:	8d 84 24 90 00 00 00 	lea    0x90(%esp),%eax
  10344c:	39 44 24 54          	cmp    %eax,0x54(%esp)
  103450:	75 c2                	jne    103414 <pcpu_init_cpu+0x344>
					intel_cache_info[desc[j]][1];
			}
		}

		/* try cpuid 4 if no cache info are got by cpuid 2 */
		if (cpuinfo->l1_cache_size && cpuinfo->l1_cache_line_size)
  103452:	85 c9                	test   %ecx,%ecx
  103454:	0f 85 e6 00 00 00    	jne    103540 <pcpu_init_cpu+0x470>
		while (i--)
			cpuid(0x00000002, &eax, &ebx, &ecx, &edx);

		for (i = 0; i < 4; i++) {
			desc = (uint8_t *) regs[i];
			for (j = 0; j < 4; j++) {
  10345a:	31 f6                	xor    %esi,%esi
		/* try cpuid 4 if no cache info are got by cpuid 2 */
		if (cpuinfo->l1_cache_size && cpuinfo->l1_cache_line_size)
			break;

		for (i = 0; i < 3; i++) {
			cpuid_subleaf(0x00000004, i, &eax, &ebx, &ecx, &edx);
  10345c:	8d 44 24 74          	lea    0x74(%esp),%eax
  103460:	89 44 24 0c          	mov    %eax,0xc(%esp)
  103464:	8d 44 24 70          	lea    0x70(%esp),%eax
  103468:	89 44 24 08          	mov    %eax,0x8(%esp)
  10346c:	89 5c 24 14          	mov    %ebx,0x14(%esp)
  103470:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  103474:	89 74 24 04          	mov    %esi,0x4(%esp)
  103478:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  10347f:	e8 2c 13 00 00       	call   1047b0 <cpuid_subleaf>
			if ((eax & 0xf) == 1 && ((eax & 0xe0) >> 5) == 1)
  103484:	8b 44 24 70          	mov    0x70(%esp),%eax
  103488:	89 c2                	mov    %eax,%edx
  10348a:	83 e2 0f             	and    $0xf,%edx
  10348d:	83 fa 01             	cmp    $0x1,%edx
  103490:	74 5e                	je     1034f0 <pcpu_init_cpu+0x420>

		/* try cpuid 4 if no cache info are got by cpuid 2 */
		if (cpuinfo->l1_cache_size && cpuinfo->l1_cache_line_size)
			break;

		for (i = 0; i < 3; i++) {
  103492:	83 c6 01             	add    $0x1,%esi
  103495:	83 fe 03             	cmp    $0x3,%esi
  103498:	75 c2                	jne    10345c <pcpu_init_cpu+0x38c>
			if ((eax & 0xf) == 1 && ((eax & 0xe0) >> 5) == 1)
				break;
		}

		if (i == 3) {
			KERN_WARN("Cannot determine L1 cache size.\n");
  10349a:	c7 44 24 08 84 84 10 	movl   $0x108484,0x8(%esp)
  1034a1:	00 
  1034a2:	c7 44 24 04 85 00 00 	movl   $0x85,0x4(%esp)
  1034a9:	00 
  1034aa:	c7 04 24 3c 85 10 00 	movl   $0x10853c,(%esp)
  1034b1:	e8 9a 06 00 00       	call   103b50 <debug_warn>
  1034b6:	e9 6a fd ff ff       	jmp    103225 <pcpu_init_cpu+0x155>
  1034bb:	90                   	nop
  1034bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	((uint32_t *) cpuinfo->vendor)[2] = ecx;
	cpuinfo->vendor[12] = '\0';

	if (strncmp(cpuinfo->vendor, "GenuineIntel", 20) == 0)
		cpuinfo->cpu_vendor = INTEL;
	else if (strncmp(cpuinfo->vendor, "AuthenticAMD", 20) == 0)
  1034c0:	8b 44 24 5c          	mov    0x5c(%esp),%eax
  1034c4:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
  1034cb:	00 
  1034cc:	c7 44 24 04 e8 85 10 	movl   $0x1085e8,0x4(%esp)
  1034d3:	00 
  1034d4:	89 04 24             	mov    %eax,(%esp)
  1034d7:	e8 54 03 00 00       	call   103830 <strncmp>
		cpuinfo->cpu_vendor = AMD;
  1034dc:	83 f8 01             	cmp    $0x1,%eax
  1034df:	19 c0                	sbb    %eax,%eax
  1034e1:	83 e0 02             	and    $0x2,%eax
  1034e4:	89 47 20             	mov    %eax,0x20(%edi)
  1034e7:	e9 97 fc ff ff       	jmp    103183 <pcpu_init_cpu+0xb3>
  1034ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		if (cpuinfo->l1_cache_size && cpuinfo->l1_cache_line_size)
			break;

		for (i = 0; i < 3; i++) {
			cpuid_subleaf(0x00000004, i, &eax, &ebx, &ecx, &edx);
			if ((eax & 0xf) == 1 && ((eax & 0xe0) >> 5) == 1)
  1034f0:	25 e0 00 00 00       	and    $0xe0,%eax
  1034f5:	83 f8 20             	cmp    $0x20,%eax
  1034f8:	75 98                	jne    103492 <pcpu_init_cpu+0x3c2>
			KERN_WARN("Cannot determine L1 cache size.\n");
			break;
		}

		cpuinfo->l1_cache_size =
			(((ebx & 0xffc00000) >> 22) + 1) *	/* ways */
  1034fa:	8b 74 24 74          	mov    0x74(%esp),%esi
			(((ebx & 0x003ff000) >> 12) + 1) *	/* partitions */
			(((ebx & 0x00000fff)) + 1) *		/* line size */
			(ecx + 1) /				/* sets */
  1034fe:	8b 54 24 78          	mov    0x78(%esp),%edx
		}

		cpuinfo->l1_cache_size =
			(((ebx & 0xffc00000) >> 22) + 1) *	/* ways */
			(((ebx & 0x003ff000) >> 12) + 1) *	/* partitions */
			(((ebx & 0x00000fff)) + 1) *		/* line size */
  103502:	89 f1                	mov    %esi,%ecx
			KERN_WARN("Cannot determine L1 cache size.\n");
			break;
		}

		cpuinfo->l1_cache_size =
			(((ebx & 0xffc00000) >> 22) + 1) *	/* ways */
  103504:	89 f0                	mov    %esi,%eax
			(((ebx & 0x003ff000) >> 12) + 1) *	/* partitions */
			(((ebx & 0x00000fff)) + 1) *		/* line size */
  103506:	81 e1 ff 0f 00 00    	and    $0xfff,%ecx
			(ecx + 1) /				/* sets */
  10350c:	83 c2 01             	add    $0x1,%edx
			KERN_WARN("Cannot determine L1 cache size.\n");
			break;
		}

		cpuinfo->l1_cache_size =
			(((ebx & 0xffc00000) >> 22) + 1) *	/* ways */
  10350f:	c1 e8 16             	shr    $0x16,%eax
			(((ebx & 0x003ff000) >> 12) + 1) *	/* partitions */
			(((ebx & 0x00000fff)) + 1) *		/* line size */
  103512:	83 c1 01             	add    $0x1,%ecx
			KERN_WARN("Cannot determine L1 cache size.\n");
			break;
		}

		cpuinfo->l1_cache_size =
			(((ebx & 0xffc00000) >> 22) + 1) *	/* ways */
  103515:	83 c0 01             	add    $0x1,%eax
			(((ebx & 0x003ff000) >> 12) + 1) *	/* partitions */
  103518:	81 e6 00 f0 3f 00    	and    $0x3ff000,%esi
			KERN_WARN("Cannot determine L1 cache size.\n");
			break;
		}

		cpuinfo->l1_cache_size =
			(((ebx & 0xffc00000) >> 22) + 1) *	/* ways */
  10351e:	0f af c1             	imul   %ecx,%eax
			(((ebx & 0x003ff000) >> 12) + 1) *	/* partitions */
			(((ebx & 0x00000fff)) + 1) *		/* line size */
			(ecx + 1) /				/* sets */
			1024;
		cpuinfo->l1_cache_line_size = ((ebx & 0x00000fff)) + 1;
  103521:	89 4f 3c             	mov    %ecx,0x3c(%edi)
			break;
		}

		cpuinfo->l1_cache_size =
			(((ebx & 0xffc00000) >> 22) + 1) *	/* ways */
			(((ebx & 0x003ff000) >> 12) + 1) *	/* partitions */
  103524:	0f af c2             	imul   %edx,%eax
  103527:	89 f2                	mov    %esi,%edx
  103529:	c1 ea 0c             	shr    $0xc,%edx
  10352c:	83 c2 01             	add    $0x1,%edx
			(((ebx & 0x00000fff)) + 1) *		/* line size */
  10352f:	0f af c2             	imul   %edx,%eax
			(ecx + 1) /				/* sets */
  103532:	c1 e8 0a             	shr    $0xa,%eax
  103535:	89 47 38             	mov    %eax,0x38(%edi)
  103538:	e9 e8 fc ff ff       	jmp    103225 <pcpu_init_cpu+0x155>
  10353d:	8d 76 00             	lea    0x0(%esi),%esi
					intel_cache_info[desc[j]][1];
			}
		}

		/* try cpuid 4 if no cache info are got by cpuid 2 */
		if (cpuinfo->l1_cache_size && cpuinfo->l1_cache_line_size)
  103540:	85 f6                	test   %esi,%esi
  103542:	0f 85 dd fc ff ff    	jne    103225 <pcpu_init_cpu+0x155>
  103548:	e9 0d ff ff ff       	jmp    10345a <pcpu_init_cpu+0x38a>
  10354d:	8d 76 00             	lea    0x0(%esi),%esi

00103550 <pcpu_ncpu>:

uint32_t
pcpu_ncpu(void)
{
	return ncpu;
}
  103550:	a1 70 ce 12 00       	mov    0x12ce70,%eax
  103555:	c3                   	ret    
  103556:	8d 76 00             	lea    0x0(%esi),%esi
  103559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103560 <pcpu_is_smp>:

bool
pcpu_is_smp(void)
{
	return ismp;
}
  103560:	0f b6 05 6c ce 12 00 	movzbl 0x12ce6c,%eax
  103567:	c3                   	ret    
  103568:	90                   	nop
  103569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103570 <pcpu_onboot>:

bool
pcpu_onboot(void)
{
  103570:	83 ec 1c             	sub    $0x1c,%esp
	int cpu_idx = get_pcpu_idx();
  103573:	e8 48 1f 00 00       	call   1054c0 <get_pcpu_idx>
	struct pcpuinfo* arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  103578:	89 04 24             	mov    %eax,(%esp)
  10357b:	e8 30 20 00 00       	call   1055b0 <get_pcpu_arch_info_pointer>
	return (mp_inited == TRUE) ?
  103580:	80 3d 6d ce 12 00 01 	cmpb   $0x1,0x12ce6d
  103587:	74 0f                	je     103598 <pcpu_onboot+0x28>
		arch_info->bsp : (get_pcpu_idx() == 0);
  103589:	e8 32 1f 00 00       	call   1054c0 <get_pcpu_idx>
  10358e:	85 c0                	test   %eax,%eax
  103590:	0f 94 c0             	sete   %al
}
  103593:	83 c4 1c             	add    $0x1c,%esp
  103596:	c3                   	ret    
  103597:	90                   	nop
bool
pcpu_onboot(void)
{
	int cpu_idx = get_pcpu_idx();
	struct pcpuinfo* arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
	return (mp_inited == TRUE) ?
  103598:	0f b6 40 04          	movzbl 0x4(%eax),%eax
		arch_info->bsp : (get_pcpu_idx() == 0);
}
  10359c:	83 c4 1c             	add    $0x1c,%esp
  10359f:	c3                   	ret    

001035a0 <pcpu_cpu_lapicid>:

lapicid_t
pcpu_cpu_lapicid(int cpu_idx)
{
  1035a0:	56                   	push   %esi
  1035a1:	53                   	push   %ebx
  1035a2:	83 ec 14             	sub    $0x14,%esp
  1035a5:	8b 5c 24 20          	mov    0x20(%esp),%ebx
	struct pcpuinfo* arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  1035a9:	89 1c 24             	mov    %ebx,(%esp)
  1035ac:	e8 ff 1f 00 00       	call   1055b0 <get_pcpu_arch_info_pointer>
	KERN_ASSERT(0 <= cpu_idx && cpu_idx < ncpu);
  1035b1:	85 db                	test   %ebx,%ebx
}

lapicid_t
pcpu_cpu_lapicid(int cpu_idx)
{
	struct pcpuinfo* arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  1035b3:	89 c6                	mov    %eax,%esi
	KERN_ASSERT(0 <= cpu_idx && cpu_idx < ncpu);
  1035b5:	78 08                	js     1035bf <pcpu_cpu_lapicid+0x1f>
  1035b7:	3b 1d 70 ce 12 00    	cmp    0x12ce70,%ebx
  1035bd:	72 24                	jb     1035e3 <pcpu_cpu_lapicid+0x43>
  1035bf:	c7 44 24 0c a8 84 10 	movl   $0x1084a8,0xc(%esp)
  1035c6:	00 
  1035c7:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  1035ce:	00 
  1035cf:	c7 44 24 04 19 02 00 	movl   $0x219,0x4(%esp)
  1035d6:	00 
  1035d7:	c7 04 24 3c 85 10 00 	movl   $0x10853c,(%esp)
  1035de:	e8 9d 04 00 00       	call   103a80 <debug_panic>
	return arch_info->lapicid;
  1035e3:	8b 06                	mov    (%esi),%eax
}
  1035e5:	83 c4 14             	add    $0x14,%esp
  1035e8:	5b                   	pop    %ebx
  1035e9:	5e                   	pop    %esi
  1035ea:	c3                   	ret    
  1035eb:	90                   	nop
  1035ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001035f0 <pcpu_boot_ap>:
		return TRUE;
}

int
pcpu_boot_ap(uint32_t cpu_idx, void (*f)(void), uintptr_t stack_addr)
{
  1035f0:	56                   	push   %esi
  1035f1:	53                   	push   %ebx
  1035f2:	83 ec 14             	sub    $0x14,%esp
  1035f5:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  1035f9:	8b 74 24 24          	mov    0x24(%esp),%esi
	KERN_ASSERT(cpu_idx > 0 && cpu_idx < pcpu_ncpu());
  1035fd:	85 db                	test   %ebx,%ebx
  1035ff:	74 57                	je     103658 <pcpu_boot_ap+0x68>
  103601:	3b 1d 70 ce 12 00    	cmp    0x12ce70,%ebx
  103607:	73 4f                	jae    103658 <pcpu_boot_ap+0x68>
	KERN_ASSERT(get_pcpu_inited_info(cpu_idx) == TRUE);
  103609:	89 1c 24             	mov    %ebx,(%esp)
  10360c:	e8 af 1f 00 00       	call   1055c0 <get_pcpu_inited_info>
  103611:	3c 01                	cmp    $0x1,%al
  103613:	74 24                	je     103639 <pcpu_boot_ap+0x49>
  103615:	c7 44 24 0c f0 84 10 	movl   $0x1084f0,0xc(%esp)
  10361c:	00 
  10361d:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  103624:	00 
  103625:	c7 44 24 04 e0 01 00 	movl   $0x1e0,0x4(%esp)
  10362c:	00 
  10362d:	c7 04 24 3c 85 10 00 	movl   $0x10853c,(%esp)
  103634:	e8 47 04 00 00       	call   103a80 <debug_panic>
	KERN_ASSERT(f != NULL);
  103639:	85 f6                	test   %esi,%esi
  10363b:	0f 84 d7 00 00 00    	je     103718 <pcpu_boot_ap+0x128>

	/* avoid being called by AP */
	if (pcpu_onboot() == FALSE)
  103641:	e8 2a ff ff ff       	call   103570 <pcpu_onboot>
		return 1;
  103646:	ba 01 00 00 00       	mov    $0x1,%edx
	KERN_ASSERT(cpu_idx > 0 && cpu_idx < pcpu_ncpu());
	KERN_ASSERT(get_pcpu_inited_info(cpu_idx) == TRUE);
	KERN_ASSERT(f != NULL);

	/* avoid being called by AP */
	if (pcpu_onboot() == FALSE)
  10364b:	84 c0                	test   %al,%al
  10364d:	75 31                	jne    103680 <pcpu_boot_ap+0x90>
		pause();

	KERN_ASSERT(get_pcpu_boot_info(cpu_idx) == TRUE);

	return 0;
}
  10364f:	83 c4 14             	add    $0x14,%esp
  103652:	89 d0                	mov    %edx,%eax
  103654:	5b                   	pop    %ebx
  103655:	5e                   	pop    %esi
  103656:	c3                   	ret    
  103657:	90                   	nop
}

int
pcpu_boot_ap(uint32_t cpu_idx, void (*f)(void), uintptr_t stack_addr)
{
	KERN_ASSERT(cpu_idx > 0 && cpu_idx < pcpu_ncpu());
  103658:	c7 44 24 0c c8 84 10 	movl   $0x1084c8,0xc(%esp)
  10365f:	00 
  103660:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  103667:	00 
  103668:	c7 44 24 04 df 01 00 	movl   $0x1df,0x4(%esp)
  10366f:	00 
  103670:	c7 04 24 3c 85 10 00 	movl   $0x10853c,(%esp)
  103677:	e8 04 04 00 00       	call   103a80 <debug_panic>
  10367c:	eb 8b                	jmp    103609 <pcpu_boot_ap+0x19>
  10367e:	66 90                	xchg   %ax,%ax

	/* avoid being called by AP */
	if (pcpu_onboot() == FALSE)
		return 1;

	if (get_pcpu_boot_info(cpu_idx) == TRUE)
  103680:	89 1c 24             	mov    %ebx,(%esp)
  103683:	e8 b8 1e 00 00       	call   105540 <get_pcpu_boot_info>
  103688:	3c 01                	cmp    $0x1,%al
  10368a:	74 7d                	je     103709 <pcpu_boot_ap+0x119>
		return 0;

	extern void kern_init_ap(void);		/* defined in sys/kern/init.c */
	uint8_t *boot = (uint8_t *) PCPU_AP_START_ADDR;
	*(uintptr_t *) (boot - 4) = stack_addr + PAGE_SIZE;
  10368c:	8b 44 24 28          	mov    0x28(%esp),%eax
	*(uintptr_t *) (boot - 8) = (uintptr_t) f;
  103690:	89 35 f8 7f 00 00    	mov    %esi,0x7ff8
	*(uintptr_t *) (boot - 12) = (uintptr_t) kern_init_ap;
  103696:	c7 05 f4 7f 00 00 c0 	movl   $0x1058c0,0x7ff4
  10369d:	58 10 00 
	if (get_pcpu_boot_info(cpu_idx) == TRUE)
		return 0;

	extern void kern_init_ap(void);		/* defined in sys/kern/init.c */
	uint8_t *boot = (uint8_t *) PCPU_AP_START_ADDR;
	*(uintptr_t *) (boot - 4) = stack_addr + PAGE_SIZE;
  1036a0:	05 00 10 00 00       	add    $0x1000,%eax
  1036a5:	a3 fc 7f 00 00       	mov    %eax,0x7ffc
	*(uintptr_t *) (boot - 8) = (uintptr_t) f;
	*(uintptr_t *) (boot - 12) = (uintptr_t) kern_init_ap;
	lapic_startcpu(pcpu_cpu_lapicid(cpu_idx), (uintptr_t) boot);
  1036aa:	89 1c 24             	mov    %ebx,(%esp)
  1036ad:	e8 ee fe ff ff       	call   1035a0 <pcpu_cpu_lapicid>
  1036b2:	c7 44 24 04 00 80 00 	movl   $0x8000,0x4(%esp)
  1036b9:	00 
  1036ba:	0f b6 c0             	movzbl %al,%eax
  1036bd:	89 04 24             	mov    %eax,(%esp)
  1036c0:	e8 8b ef ff ff       	call   102650 <lapic_startcpu>

	/* wait until the processor is intialized */
	while (get_pcpu_boot_info(cpu_idx) == FALSE)
  1036c5:	eb 06                	jmp    1036cd <pcpu_boot_ap+0xdd>
  1036c7:	90                   	nop
		pause();
  1036c8:	e8 53 10 00 00       	call   104720 <pause>
	*(uintptr_t *) (boot - 8) = (uintptr_t) f;
	*(uintptr_t *) (boot - 12) = (uintptr_t) kern_init_ap;
	lapic_startcpu(pcpu_cpu_lapicid(cpu_idx), (uintptr_t) boot);

	/* wait until the processor is intialized */
	while (get_pcpu_boot_info(cpu_idx) == FALSE)
  1036cd:	89 1c 24             	mov    %ebx,(%esp)
  1036d0:	e8 6b 1e 00 00       	call   105540 <get_pcpu_boot_info>
  1036d5:	84 c0                	test   %al,%al
  1036d7:	74 ef                	je     1036c8 <pcpu_boot_ap+0xd8>
		pause();

	KERN_ASSERT(get_pcpu_boot_info(cpu_idx) == TRUE);
  1036d9:	89 1c 24             	mov    %ebx,(%esp)
  1036dc:	e8 5f 1e 00 00       	call   105540 <get_pcpu_boot_info>
  1036e1:	3c 01                	cmp    $0x1,%al
  1036e3:	74 24                	je     103709 <pcpu_boot_ap+0x119>
  1036e5:	c7 44 24 0c 18 85 10 	movl   $0x108518,0xc(%esp)
  1036ec:	00 
  1036ed:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  1036f4:	00 
  1036f5:	c7 44 24 04 f5 01 00 	movl   $0x1f5,0x4(%esp)
  1036fc:	00 
  1036fd:	c7 04 24 3c 85 10 00 	movl   $0x10853c,(%esp)
  103704:	e8 77 03 00 00       	call   103a80 <debug_panic>

	return 0;
}
  103709:	83 c4 14             	add    $0x14,%esp
	while (get_pcpu_boot_info(cpu_idx) == FALSE)
		pause();

	KERN_ASSERT(get_pcpu_boot_info(cpu_idx) == TRUE);

	return 0;
  10370c:	31 d2                	xor    %edx,%edx
}
  10370e:	89 d0                	mov    %edx,%eax
  103710:	5b                   	pop    %ebx
  103711:	5e                   	pop    %esi
  103712:	c3                   	ret    
  103713:	90                   	nop
  103714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
pcpu_boot_ap(uint32_t cpu_idx, void (*f)(void), uintptr_t stack_addr)
{
	KERN_ASSERT(cpu_idx > 0 && cpu_idx < pcpu_ncpu());
	KERN_ASSERT(get_pcpu_inited_info(cpu_idx) == TRUE);
	KERN_ASSERT(f != NULL);
  103718:	c7 44 24 0c f5 85 10 	movl   $0x1085f5,0xc(%esp)
  10371f:	00 
  103720:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  103727:	00 
  103728:	c7 44 24 04 e1 01 00 	movl   $0x1e1,0x4(%esp)
  10372f:	00 
  103730:	c7 04 24 3c 85 10 00 	movl   $0x10853c,(%esp)
  103737:	e8 44 03 00 00       	call   103a80 <debug_panic>
  10373c:	e9 00 ff ff ff       	jmp    103641 <pcpu_boot_ap+0x51>
  103741:	66 90                	xchg   %ax,%ax
  103743:	66 90                	xchg   %ax,%ax
  103745:	66 90                	xchg   %ax,%ax
  103747:	66 90                	xchg   %ax,%ax
  103749:	66 90                	xchg   %ax,%ax
  10374b:	66 90                	xchg   %ax,%ax
  10374d:	66 90                	xchg   %ax,%ax
  10374f:	90                   	nop

00103750 <memset>:
#include "string.h"
#include "types.h"

void *
memset(void *v, int c, size_t n)
{
  103750:	57                   	push   %edi
  103751:	56                   	push   %esi
  103752:	53                   	push   %ebx
  103753:	8b 4c 24 18          	mov    0x18(%esp),%ecx
  103757:	8b 7c 24 10          	mov    0x10(%esp),%edi
    if (n == 0)
  10375b:	85 c9                	test   %ecx,%ecx
  10375d:	74 14                	je     103773 <memset+0x23>
        return v;
    if ((int)v%4 == 0 && n%4 == 0) {
  10375f:	f7 c7 03 00 00 00    	test   $0x3,%edi
  103765:	75 05                	jne    10376c <memset+0x1c>
  103767:	f6 c1 03             	test   $0x3,%cl
  10376a:	74 14                	je     103780 <memset+0x30>
        c = (c<<24)|(c<<16)|(c<<8)|c;
        asm volatile("cld; rep stosl\n"
                 :: "D" (v), "a" (c), "c" (n/4)
                 : "cc", "memory");
    } else
        asm volatile("cld; rep stosb\n"
  10376c:	8b 44 24 14          	mov    0x14(%esp),%eax
  103770:	fc                   	cld    
  103771:	f3 aa                	rep stos %al,%es:(%edi)
                 :: "D" (v), "a" (c), "c" (n)
                 : "cc", "memory");
    return v;
}
  103773:	89 f8                	mov    %edi,%eax
  103775:	5b                   	pop    %ebx
  103776:	5e                   	pop    %esi
  103777:	5f                   	pop    %edi
  103778:	c3                   	ret    
  103779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
memset(void *v, int c, size_t n)
{
    if (n == 0)
        return v;
    if ((int)v%4 == 0 && n%4 == 0) {
        c &= 0xFF;
  103780:	0f b6 54 24 14       	movzbl 0x14(%esp),%edx
        c = (c<<24)|(c<<16)|(c<<8)|c;
        asm volatile("cld; rep stosl\n"
                 :: "D" (v), "a" (c), "c" (n/4)
  103785:	c1 e9 02             	shr    $0x2,%ecx
{
    if (n == 0)
        return v;
    if ((int)v%4 == 0 && n%4 == 0) {
        c &= 0xFF;
        c = (c<<24)|(c<<16)|(c<<8)|c;
  103788:	89 d0                	mov    %edx,%eax
  10378a:	89 d6                	mov    %edx,%esi
  10378c:	c1 e0 18             	shl    $0x18,%eax
  10378f:	89 d3                	mov    %edx,%ebx
  103791:	c1 e6 10             	shl    $0x10,%esi
  103794:	09 f0                	or     %esi,%eax
  103796:	c1 e3 08             	shl    $0x8,%ebx
  103799:	09 d0                	or     %edx,%eax
  10379b:	09 d8                	or     %ebx,%eax
        asm volatile("cld; rep stosl\n"
  10379d:	fc                   	cld    
  10379e:	f3 ab                	rep stos %eax,%es:(%edi)
    } else
        asm volatile("cld; rep stosb\n"
                 :: "D" (v), "a" (c), "c" (n)
                 : "cc", "memory");
    return v;
}
  1037a0:	89 f8                	mov    %edi,%eax
  1037a2:	5b                   	pop    %ebx
  1037a3:	5e                   	pop    %esi
  1037a4:	5f                   	pop    %edi
  1037a5:	c3                   	ret    
  1037a6:	8d 76 00             	lea    0x0(%esi),%esi
  1037a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001037b0 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  1037b0:	57                   	push   %edi
  1037b1:	56                   	push   %esi
  1037b2:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1037b6:	8b 74 24 10          	mov    0x10(%esp),%esi
  1037ba:	8b 4c 24 14          	mov    0x14(%esp),%ecx
    const char *s;
    char *d;

    s = src;
    d = dst;
    if (s < d && s + n > d) {
  1037be:	39 c6                	cmp    %eax,%esi
  1037c0:	73 26                	jae    1037e8 <memmove+0x38>
  1037c2:	8d 14 0e             	lea    (%esi,%ecx,1),%edx
  1037c5:	39 d0                	cmp    %edx,%eax
  1037c7:	73 1f                	jae    1037e8 <memmove+0x38>
        s += n;
        d += n;
  1037c9:	8d 3c 08             	lea    (%eax,%ecx,1),%edi
  1037cc:	89 d6                	mov    %edx,%esi
  1037ce:	09 fe                	or     %edi,%esi
        if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
  1037d0:	83 e6 03             	and    $0x3,%esi
  1037d3:	74 33                	je     103808 <memmove+0x58>
            asm volatile("std; rep movsl\n"
                     :: "D" (d-4), "S" (s-4), "c" (n/4)
                     : "cc", "memory");
        else
            asm volatile("std; rep movsb\n"
                     :: "D" (d-1), "S" (s-1), "c" (n)
  1037d5:	83 ef 01             	sub    $0x1,%edi
  1037d8:	8d 72 ff             	lea    -0x1(%edx),%esi
        if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
            asm volatile("std; rep movsl\n"
                     :: "D" (d-4), "S" (s-4), "c" (n/4)
                     : "cc", "memory");
        else
            asm volatile("std; rep movsb\n"
  1037db:	fd                   	std    
  1037dc:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
                     :: "D" (d-1), "S" (s-1), "c" (n)
                     : "cc", "memory");
        // Some versions of GCC rely on DF being clear
        asm volatile("cld" ::: "cc");
  1037de:	fc                   	cld    
            asm volatile("cld; rep movsb\n"
                     :: "D" (d), "S" (s), "c" (n)
                     : "cc", "memory");
    }
    return dst;
}
  1037df:	5e                   	pop    %esi
  1037e0:	5f                   	pop    %edi
  1037e1:	c3                   	ret    
  1037e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1037e8:	89 f2                	mov    %esi,%edx
  1037ea:	09 c2                	or     %eax,%edx
                     :: "D" (d-1), "S" (s-1), "c" (n)
                     : "cc", "memory");
        // Some versions of GCC rely on DF being clear
        asm volatile("cld" ::: "cc");
    } else {
        if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
  1037ec:	83 e2 03             	and    $0x3,%edx
  1037ef:	75 0f                	jne    103800 <memmove+0x50>
  1037f1:	f6 c1 03             	test   $0x3,%cl
  1037f4:	75 0a                	jne    103800 <memmove+0x50>
            asm volatile("cld; rep movsl\n"
                     :: "D" (d), "S" (s), "c" (n/4)
  1037f6:	c1 e9 02             	shr    $0x2,%ecx
                     : "cc", "memory");
        // Some versions of GCC rely on DF being clear
        asm volatile("cld" ::: "cc");
    } else {
        if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
            asm volatile("cld; rep movsl\n"
  1037f9:	89 c7                	mov    %eax,%edi
  1037fb:	fc                   	cld    
  1037fc:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  1037fe:	eb 05                	jmp    103805 <memmove+0x55>
                     :: "D" (d), "S" (s), "c" (n/4)
                     : "cc", "memory");
        else
            asm volatile("cld; rep movsb\n"
  103800:	89 c7                	mov    %eax,%edi
  103802:	fc                   	cld    
  103803:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
                     :: "D" (d), "S" (s), "c" (n)
                     : "cc", "memory");
    }
    return dst;
}
  103805:	5e                   	pop    %esi
  103806:	5f                   	pop    %edi
  103807:	c3                   	ret    
    s = src;
    d = dst;
    if (s < d && s + n > d) {
        s += n;
        d += n;
        if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
  103808:	f6 c1 03             	test   $0x3,%cl
  10380b:	75 c8                	jne    1037d5 <memmove+0x25>
            asm volatile("std; rep movsl\n"
                     :: "D" (d-4), "S" (s-4), "c" (n/4)
  10380d:	83 ef 04             	sub    $0x4,%edi
  103810:	8d 72 fc             	lea    -0x4(%edx),%esi
  103813:	c1 e9 02             	shr    $0x2,%ecx
    d = dst;
    if (s < d && s + n > d) {
        s += n;
        d += n;
        if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
            asm volatile("std; rep movsl\n"
  103816:	fd                   	std    
  103817:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  103819:	eb c3                	jmp    1037de <memmove+0x2e>
  10381b:	90                   	nop
  10381c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00103820 <memcpy>:
}

void *
memcpy(void *dst, const void *src, size_t n)
{
	return memmove(dst, src, n);
  103820:	e9 8b ff ff ff       	jmp    1037b0 <memmove>
  103825:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103830 <strncmp>:
}

int
strncmp(const char *p, const char *q, size_t n)
{
  103830:	56                   	push   %esi
  103831:	53                   	push   %ebx
  103832:	8b 74 24 14          	mov    0x14(%esp),%esi
  103836:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  10383a:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	while (n > 0 && *p && *p == *q)
  10383e:	85 f6                	test   %esi,%esi
  103840:	74 30                	je     103872 <strncmp+0x42>
  103842:	0f b6 01             	movzbl (%ecx),%eax
  103845:	84 c0                	test   %al,%al
  103847:	74 2e                	je     103877 <strncmp+0x47>
  103849:	0f b6 13             	movzbl (%ebx),%edx
  10384c:	38 d0                	cmp    %dl,%al
  10384e:	75 3e                	jne    10388e <strncmp+0x5e>
  103850:	8d 51 01             	lea    0x1(%ecx),%edx
  103853:	01 ce                	add    %ecx,%esi
  103855:	eb 14                	jmp    10386b <strncmp+0x3b>
  103857:	90                   	nop
  103858:	0f b6 02             	movzbl (%edx),%eax
  10385b:	84 c0                	test   %al,%al
  10385d:	74 29                	je     103888 <strncmp+0x58>
  10385f:	0f b6 19             	movzbl (%ecx),%ebx
  103862:	83 c2 01             	add    $0x1,%edx
  103865:	38 d8                	cmp    %bl,%al
  103867:	75 17                	jne    103880 <strncmp+0x50>
		n--, p++, q++;
  103869:	89 cb                	mov    %ecx,%ebx
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
  10386b:	39 f2                	cmp    %esi,%edx
		n--, p++, q++;
  10386d:	8d 4b 01             	lea    0x1(%ebx),%ecx
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
  103870:	75 e6                	jne    103858 <strncmp+0x28>
		n--, p++, q++;
	if (n == 0)
		return 0;
  103872:	31 c0                	xor    %eax,%eax
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
}
  103874:	5b                   	pop    %ebx
  103875:	5e                   	pop    %esi
  103876:	c3                   	ret    
  103877:	0f b6 1b             	movzbl (%ebx),%ebx
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
  10387a:	31 c0                	xor    %eax,%eax
  10387c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		n--, p++, q++;
	if (n == 0)
		return 0;
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  103880:	0f b6 d3             	movzbl %bl,%edx
  103883:	29 d0                	sub    %edx,%eax
}
  103885:	5b                   	pop    %ebx
  103886:	5e                   	pop    %esi
  103887:	c3                   	ret    
  103888:	0f b6 5b 01          	movzbl 0x1(%ebx),%ebx
  10388c:	eb f2                	jmp    103880 <strncmp+0x50>
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
  10388e:	89 d3                	mov    %edx,%ebx
  103890:	eb ee                	jmp    103880 <strncmp+0x50>
  103892:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001038a0 <strnlen>:
		return (int) ((unsigned char) *p - (unsigned char) *q);
}

int
strnlen(const char *s, size_t size)
{
  1038a0:	53                   	push   %ebx
  1038a1:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  1038a5:	8b 5c 24 08          	mov    0x8(%esp),%ebx
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  1038a9:	85 c9                	test   %ecx,%ecx
  1038ab:	74 25                	je     1038d2 <strnlen+0x32>
  1038ad:	80 3b 00             	cmpb   $0x0,(%ebx)
  1038b0:	74 20                	je     1038d2 <strnlen+0x32>
  1038b2:	ba 01 00 00 00       	mov    $0x1,%edx
  1038b7:	eb 11                	jmp    1038ca <strnlen+0x2a>
  1038b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1038c0:	83 c2 01             	add    $0x1,%edx
  1038c3:	80 7c 13 ff 00       	cmpb   $0x0,-0x1(%ebx,%edx,1)
  1038c8:	74 06                	je     1038d0 <strnlen+0x30>
  1038ca:	39 ca                	cmp    %ecx,%edx
		n++;
  1038cc:	89 d0                	mov    %edx,%eax
int
strnlen(const char *s, size_t size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  1038ce:	75 f0                	jne    1038c0 <strnlen+0x20>
		n++;
	return n;
}
  1038d0:	5b                   	pop    %ebx
  1038d1:	c3                   	ret    
int
strnlen(const char *s, size_t size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  1038d2:	31 c0                	xor    %eax,%eax
		n++;
	return n;
}
  1038d4:	5b                   	pop    %ebx
  1038d5:	c3                   	ret    
  1038d6:	8d 76 00             	lea    0x0(%esi),%esi
  1038d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001038e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  1038e0:	53                   	push   %ebx
  1038e1:	8b 54 24 08          	mov    0x8(%esp),%edx
  1038e5:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  while (*p && *p == *q)
  1038e9:	0f b6 02             	movzbl (%edx),%eax
  1038ec:	84 c0                	test   %al,%al
  1038ee:	74 2d                	je     10391d <strcmp+0x3d>
  1038f0:	0f b6 19             	movzbl (%ecx),%ebx
  1038f3:	38 d8                	cmp    %bl,%al
  1038f5:	74 0f                	je     103906 <strcmp+0x26>
  1038f7:	eb 2b                	jmp    103924 <strcmp+0x44>
  1038f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103900:	38 c8                	cmp    %cl,%al
  103902:	75 15                	jne    103919 <strcmp+0x39>
    p++, q++;
  103904:	89 d9                	mov    %ebx,%ecx
  103906:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while (*p && *p == *q)
  103909:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  10390c:	8d 59 01             	lea    0x1(%ecx),%ebx
}

int
strcmp(const char *p, const char *q)
{
  while (*p && *p == *q)
  10390f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
  103913:	84 c0                	test   %al,%al
  103915:	75 e9                	jne    103900 <strcmp+0x20>
  103917:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (int) ((unsigned char) *p - (unsigned char) *q);
  103919:	29 c8                	sub    %ecx,%eax
}
  10391b:	5b                   	pop    %ebx
  10391c:	c3                   	ret    
  10391d:	0f b6 09             	movzbl (%ecx),%ecx
}

int
strcmp(const char *p, const char *q)
{
  while (*p && *p == *q)
  103920:	31 c0                	xor    %eax,%eax
  103922:	eb f5                	jmp    103919 <strcmp+0x39>
  103924:	0f b6 cb             	movzbl %bl,%ecx
  103927:	eb f0                	jmp    103919 <strcmp+0x39>
  103929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103930 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  103930:	53                   	push   %ebx
  103931:	8b 44 24 08          	mov    0x8(%esp),%eax
  103935:	8b 54 24 0c          	mov    0xc(%esp),%edx
  for (; *s; s++)
  103939:	0f b6 18             	movzbl (%eax),%ebx
  10393c:	84 db                	test   %bl,%bl
  10393e:	74 16                	je     103956 <strchr+0x26>
    if (*s == c)
  103940:	38 d3                	cmp    %dl,%bl
  103942:	89 d1                	mov    %edx,%ecx
  103944:	75 06                	jne    10394c <strchr+0x1c>
  103946:	eb 10                	jmp    103958 <strchr+0x28>
  103948:	38 ca                	cmp    %cl,%dl
  10394a:	74 0c                	je     103958 <strchr+0x28>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  for (; *s; s++)
  10394c:	83 c0 01             	add    $0x1,%eax
  10394f:	0f b6 10             	movzbl (%eax),%edx
  103952:	84 d2                	test   %dl,%dl
  103954:	75 f2                	jne    103948 <strchr+0x18>
    if (*s == c)
      return (char *) s;
  return 0;
  103956:	31 c0                	xor    %eax,%eax
}
  103958:	5b                   	pop    %ebx
  103959:	c3                   	ret    
  10395a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00103960 <memzero>:

void *
memzero(void *v, size_t n)
{
  103960:	83 ec 0c             	sub    $0xc,%esp
	return memset(v, 0, n);
  103963:	8b 44 24 14          	mov    0x14(%esp),%eax
  103967:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10396e:	00 
  10396f:	89 44 24 08          	mov    %eax,0x8(%esp)
  103973:	8b 44 24 10          	mov    0x10(%esp),%eax
  103977:	89 04 24             	mov    %eax,(%esp)
  10397a:	e8 d1 fd ff ff       	call   103750 <memset>
}
  10397f:	83 c4 0c             	add    $0xc,%esp
  103982:	c3                   	ret    
  103983:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103990 <memcmp>:

memcmp(const void *v1, const void *v2, size_t n)
{
  103990:	57                   	push   %edi
  103991:	56                   	push   %esi
  103992:	53                   	push   %ebx
  103993:	8b 44 24 18          	mov    0x18(%esp),%eax
  103997:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  10399b:	8b 74 24 14          	mov    0x14(%esp),%esi
        const uint8_t *s1 = (const uint8_t *) v1;
        const uint8_t *s2 = (const uint8_t *) v2;

        while (n-- > 0) {
  10399f:	85 c0                	test   %eax,%eax
  1039a1:	8d 78 ff             	lea    -0x1(%eax),%edi
  1039a4:	74 26                	je     1039cc <memcmp+0x3c>
                if (*s1 != *s2)
  1039a6:	0f b6 03             	movzbl (%ebx),%eax
  1039a9:	31 d2                	xor    %edx,%edx
  1039ab:	0f b6 0e             	movzbl (%esi),%ecx
  1039ae:	38 c8                	cmp    %cl,%al
  1039b0:	74 16                	je     1039c8 <memcmp+0x38>
  1039b2:	eb 24                	jmp    1039d8 <memcmp+0x48>
  1039b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1039b8:	0f b6 44 13 01       	movzbl 0x1(%ebx,%edx,1),%eax
  1039bd:	83 c2 01             	add    $0x1,%edx
  1039c0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
  1039c4:	38 c8                	cmp    %cl,%al
  1039c6:	75 10                	jne    1039d8 <memcmp+0x48>
memcmp(const void *v1, const void *v2, size_t n)
{
        const uint8_t *s1 = (const uint8_t *) v1;
        const uint8_t *s2 = (const uint8_t *) v2;

        while (n-- > 0) {
  1039c8:	39 fa                	cmp    %edi,%edx
  1039ca:	75 ec                	jne    1039b8 <memcmp+0x28>
                        return (int) *s1 - (int) *s2;
                s1++, s2++;
        }

        return 0;
}
  1039cc:	5b                   	pop    %ebx
                if (*s1 != *s2)
                        return (int) *s1 - (int) *s2;
                s1++, s2++;
        }

        return 0;
  1039cd:	31 c0                	xor    %eax,%eax
}
  1039cf:	5e                   	pop    %esi
  1039d0:	5f                   	pop    %edi
  1039d1:	c3                   	ret    
  1039d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1039d8:	5b                   	pop    %ebx
        const uint8_t *s1 = (const uint8_t *) v1;
        const uint8_t *s2 = (const uint8_t *) v2;

        while (n-- > 0) {
                if (*s1 != *s2)
                        return (int) *s1 - (int) *s2;
  1039d9:	29 c8                	sub    %ecx,%eax
                s1++, s2++;
        }

        return 0;
}
  1039db:	5e                   	pop    %esi
  1039dc:	5f                   	pop    %edi
  1039dd:	c3                   	ret    
  1039de:	66 90                	xchg   %ax,%ax

001039e0 <debug_init>:
#include <lib/types.h>
#include <lib/spinlock.h>

void
debug_init(void)
{
  1039e0:	f3 c3                	repz ret 
  1039e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1039e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001039f0 <debug_info>:
}

void
debug_info(const char *fmt, ...)
{
  1039f0:	83 ec 1c             	sub    $0x1c,%esp
#ifdef DEBUG_MSG
	spinlock_acquire(&printLock);
  1039f3:	c7 04 24 40 d4 96 00 	movl   $0x96d440,(%esp)
  1039fa:	e8 31 19 00 00       	call   105330 <spinlock_acquire>
	va_list ap;
	va_start(ap, fmt);
  1039ff:	8d 44 24 24          	lea    0x24(%esp),%eax
	vdprintf(fmt, ap);
  103a03:	89 44 24 04          	mov    %eax,0x4(%esp)
  103a07:	8b 44 24 20          	mov    0x20(%esp),%eax
  103a0b:	89 04 24             	mov    %eax,(%esp)
  103a0e:	e8 fd 01 00 00       	call   103c10 <vdprintf>
	va_end(ap);
	spinlock_release(&printLock);
  103a13:	c7 04 24 40 d4 96 00 	movl   $0x96d440,(%esp)
  103a1a:	e8 91 19 00 00       	call   1053b0 <spinlock_release>

#endif
}
  103a1f:	83 c4 1c             	add    $0x1c,%esp
  103a22:	c3                   	ret    
  103a23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103a30 <debug_normal>:

#ifdef DEBUG_MSG

void
debug_normal(const char *file, int line, const char *fmt, ...)
{
  103a30:	83 ec 1c             	sub    $0x1c,%esp
	spinlock_acquire(&printLock);
  103a33:	c7 04 24 40 d4 96 00 	movl   $0x96d440,(%esp)
  103a3a:	e8 f1 18 00 00       	call   105330 <spinlock_acquire>
	dprintf("[D] %s:%d: ", file, line);
  103a3f:	8b 44 24 24          	mov    0x24(%esp),%eax
  103a43:	c7 04 24 18 8e 10 00 	movl   $0x108e18,(%esp)
  103a4a:	89 44 24 08          	mov    %eax,0x8(%esp)
  103a4e:	8b 44 24 20          	mov    0x20(%esp),%eax
  103a52:	89 44 24 04          	mov    %eax,0x4(%esp)
  103a56:	e8 35 02 00 00       	call   103c90 <dprintf>

	va_list ap;
	va_start(ap, fmt);
  103a5b:	8d 44 24 2c          	lea    0x2c(%esp),%eax
	vdprintf(fmt, ap);
  103a5f:	89 44 24 04          	mov    %eax,0x4(%esp)
  103a63:	8b 44 24 28          	mov    0x28(%esp),%eax
  103a67:	89 04 24             	mov    %eax,(%esp)
  103a6a:	e8 a1 01 00 00       	call   103c10 <vdprintf>
	va_end(ap);
	spinlock_release(&printLock);
  103a6f:	c7 04 24 40 d4 96 00 	movl   $0x96d440,(%esp)
  103a76:	e8 35 19 00 00       	call   1053b0 <spinlock_release>
}
  103a7b:	83 c4 1c             	add    $0x1c,%esp
  103a7e:	c3                   	ret    
  103a7f:	90                   	nop

00103a80 <debug_panic>:
		eips[i] = 0;
}

gcc_noinline void
debug_panic(const char *file, int line, const char *fmt,...)
{
  103a80:	56                   	push   %esi
  103a81:	53                   	push   %ebx
  103a82:	83 ec 44             	sub    $0x44,%esp
	int i;
	uintptr_t eips[DEBUG_TRACEFRAMES];
	va_list ap;
	spinlock_acquire(&printLock);
  103a85:	c7 04 24 40 d4 96 00 	movl   $0x96d440,(%esp)
  103a8c:	e8 9f 18 00 00       	call   105330 <spinlock_acquire>
	dprintf("[P] %s:%d: ", file, line);
  103a91:	8b 44 24 54          	mov    0x54(%esp),%eax
  103a95:	c7 04 24 24 8e 10 00 	movl   $0x108e24,(%esp)
  103a9c:	89 44 24 08          	mov    %eax,0x8(%esp)
  103aa0:	8b 44 24 50          	mov    0x50(%esp),%eax
  103aa4:	89 44 24 04          	mov    %eax,0x4(%esp)
  103aa8:	e8 e3 01 00 00       	call   103c90 <dprintf>

	va_start(ap, fmt);
  103aad:	8d 44 24 5c          	lea    0x5c(%esp),%eax
	vdprintf(fmt, ap);
  103ab1:	89 44 24 04          	mov    %eax,0x4(%esp)
  103ab5:	8b 44 24 58          	mov    0x58(%esp),%eax
  103ab9:	89 04 24             	mov    %eax,(%esp)
  103abc:	e8 4f 01 00 00       	call   103c10 <vdprintf>
	va_end(ap);

	debug_trace(read_ebp(), eips);
  103ac1:	e8 ea 0b 00 00       	call   1046b0 <read_ebp>
debug_trace(uintptr_t ebp, uintptr_t *eips)
{
	int i;
	uintptr_t *frame = (uintptr_t *) ebp;

	for (i = 0; i < DEBUG_TRACEFRAMES && frame; i++) {
  103ac6:	31 d2                	xor    %edx,%edx
  103ac8:	85 c0                	test   %eax,%eax
  103aca:	75 11                	jne    103add <debug_panic+0x5d>
  103acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103ad0:	eb 26                	jmp    103af8 <debug_panic+0x78>
  103ad2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103ad8:	83 fa 09             	cmp    $0x9,%edx
  103adb:	7f 10                	jg     103aed <debug_panic+0x6d>
		eips[i] = frame[1];		/* saved %eip */
  103add:	8b 48 04             	mov    0x4(%eax),%ecx
		frame = (uintptr_t *) frame[0];	/* saved %ebp */
  103ae0:	8b 00                	mov    (%eax),%eax
{
	int i;
	uintptr_t *frame = (uintptr_t *) ebp;

	for (i = 0; i < DEBUG_TRACEFRAMES && frame; i++) {
		eips[i] = frame[1];		/* saved %eip */
  103ae2:	89 4c 94 18          	mov    %ecx,0x18(%esp,%edx,4)
debug_trace(uintptr_t ebp, uintptr_t *eips)
{
	int i;
	uintptr_t *frame = (uintptr_t *) ebp;

	for (i = 0; i < DEBUG_TRACEFRAMES && frame; i++) {
  103ae6:	83 c2 01             	add    $0x1,%edx
  103ae9:	85 c0                	test   %eax,%eax
  103aeb:	75 eb                	jne    103ad8 <debug_panic+0x58>
		eips[i] = frame[1];		/* saved %eip */
		frame = (uintptr_t *) frame[0];	/* saved %ebp */
	}
	for (; i < DEBUG_TRACEFRAMES; i++)
  103aed:	83 fa 09             	cmp    $0x9,%edx
  103af0:	7f 16                	jg     103b08 <debug_panic+0x88>
  103af2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		eips[i] = 0;
  103af8:	c7 44 94 18 00 00 00 	movl   $0x0,0x18(%esp,%edx,4)
  103aff:	00 

	for (i = 0; i < DEBUG_TRACEFRAMES && frame; i++) {
		eips[i] = frame[1];		/* saved %eip */
		frame = (uintptr_t *) frame[0];	/* saved %ebp */
	}
	for (; i < DEBUG_TRACEFRAMES; i++)
  103b00:	83 c2 01             	add    $0x1,%edx
  103b03:	83 fa 09             	cmp    $0x9,%edx
  103b06:	7e f0                	jle    103af8 <debug_panic+0x78>
  103b08:	8d 5c 24 18          	lea    0x18(%esp),%ebx
  103b0c:	8d 74 24 40          	lea    0x40(%esp),%esi
	va_start(ap, fmt);
	vdprintf(fmt, ap);
	va_end(ap);

	debug_trace(read_ebp(), eips);
	for (i = 0; i < DEBUG_TRACEFRAMES && eips[i] != 0; i++)
  103b10:	8b 03                	mov    (%ebx),%eax
  103b12:	85 c0                	test   %eax,%eax
  103b14:	74 17                	je     103b2d <debug_panic+0xad>
		dprintf("\tfrom 0x%08x\n", eips[i]);
  103b16:	89 44 24 04          	mov    %eax,0x4(%esp)
  103b1a:	83 c3 04             	add    $0x4,%ebx
  103b1d:	c7 04 24 30 8e 10 00 	movl   $0x108e30,(%esp)
  103b24:	e8 67 01 00 00       	call   103c90 <dprintf>
	va_start(ap, fmt);
	vdprintf(fmt, ap);
	va_end(ap);

	debug_trace(read_ebp(), eips);
	for (i = 0; i < DEBUG_TRACEFRAMES && eips[i] != 0; i++)
  103b29:	39 f3                	cmp    %esi,%ebx
  103b2b:	75 e3                	jne    103b10 <debug_panic+0x90>
		dprintf("\tfrom 0x%08x\n", eips[i]);

	dprintf("Kernel Panic !!!\n");
  103b2d:	c7 04 24 3e 8e 10 00 	movl   $0x108e3e,(%esp)
  103b34:	e8 57 01 00 00       	call   103c90 <dprintf>
	spinlock_release(&printLock);
  103b39:	c7 04 24 40 d4 96 00 	movl   $0x96d440,(%esp)
  103b40:	e8 6b 18 00 00       	call   1053b0 <spinlock_release>
	//intr_local_disable();
	halt();
  103b45:	e8 c6 0b 00 00       	call   104710 <halt>
}
  103b4a:	83 c4 44             	add    $0x44,%esp
  103b4d:	5b                   	pop    %ebx
  103b4e:	5e                   	pop    %esi
  103b4f:	c3                   	ret    

00103b50 <debug_warn>:

void
debug_warn(const char *file, int line, const char *fmt,...)
{
  103b50:	83 ec 1c             	sub    $0x1c,%esp
	spinlock_acquire(&printLock);
  103b53:	c7 04 24 40 d4 96 00 	movl   $0x96d440,(%esp)
  103b5a:	e8 d1 17 00 00       	call   105330 <spinlock_acquire>
	dprintf("[W] %s:%d: ", file, line);
  103b5f:	8b 44 24 24          	mov    0x24(%esp),%eax
  103b63:	c7 04 24 50 8e 10 00 	movl   $0x108e50,(%esp)
  103b6a:	89 44 24 08          	mov    %eax,0x8(%esp)
  103b6e:	8b 44 24 20          	mov    0x20(%esp),%eax
  103b72:	89 44 24 04          	mov    %eax,0x4(%esp)
  103b76:	e8 15 01 00 00       	call   103c90 <dprintf>

	va_list ap;
	va_start(ap, fmt);
  103b7b:	8d 44 24 2c          	lea    0x2c(%esp),%eax
	vdprintf(fmt, ap);
  103b7f:	89 44 24 04          	mov    %eax,0x4(%esp)
  103b83:	8b 44 24 28          	mov    0x28(%esp),%eax
  103b87:	89 04 24             	mov    %eax,(%esp)
  103b8a:	e8 81 00 00 00       	call   103c10 <vdprintf>
	va_end(ap);
	spinlock_release(&printLock);
  103b8f:	c7 04 24 40 d4 96 00 	movl   $0x96d440,(%esp)
  103b96:	e8 15 18 00 00       	call   1053b0 <spinlock_release>
}
  103b9b:	83 c4 1c             	add    $0x1c,%esp
  103b9e:	c3                   	ret    
  103b9f:	90                   	nop

00103ba0 <putch>:
    }
}

static void
putch (int ch, struct dprintbuf *b)
{
  103ba0:	56                   	push   %esi
  103ba1:	53                   	push   %ebx
  103ba2:	83 ec 14             	sub    $0x14,%esp
  103ba5:	8b 74 24 24          	mov    0x24(%esp),%esi
    b->buf[b->idx++] = ch;
  103ba9:	8b 4c 24 20          	mov    0x20(%esp),%ecx
  103bad:	8b 16                	mov    (%esi),%edx
  103baf:	8d 42 01             	lea    0x1(%edx),%eax
    if (b->idx == CONSOLE_BUFFER_SIZE - 1)
  103bb2:	3d ff 01 00 00       	cmp    $0x1ff,%eax
}

static void
putch (int ch, struct dprintbuf *b)
{
    b->buf[b->idx++] = ch;
  103bb7:	89 06                	mov    %eax,(%esi)
  103bb9:	88 4c 16 08          	mov    %cl,0x8(%esi,%edx,1)
    if (b->idx == CONSOLE_BUFFER_SIZE - 1)
  103bbd:	74 11                	je     103bd0 <putch+0x30>
    {
        b->buf[b->idx] = 0;
        cputs (b->buf);
        b->idx = 0;
    }
    b->cnt++;
  103bbf:	83 46 04 01          	addl   $0x1,0x4(%esi)
}
  103bc3:	83 c4 14             	add    $0x14,%esp
  103bc6:	5b                   	pop    %ebx
  103bc7:	5e                   	pop    %esi
  103bc8:	c3                   	ret    
  103bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
};

static void
cputs (const char *str)
{
    while (*str)
  103bd0:	0f be 46 08          	movsbl 0x8(%esi),%eax
{
    b->buf[b->idx++] = ch;
    if (b->idx == CONSOLE_BUFFER_SIZE - 1)
    {
        b->buf[b->idx] = 0;
        cputs (b->buf);
  103bd4:	8d 5e 08             	lea    0x8(%esi),%ebx
putch (int ch, struct dprintbuf *b)
{
    b->buf[b->idx++] = ch;
    if (b->idx == CONSOLE_BUFFER_SIZE - 1)
    {
        b->buf[b->idx] = 0;
  103bd7:	c6 86 07 02 00 00 00 	movb   $0x0,0x207(%esi)
};

static void
cputs (const char *str)
{
    while (*str)
  103bde:	84 c0                	test   %al,%al
  103be0:	74 18                	je     103bfa <putch+0x5a>
  103be2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    {
        cons_putc (*str);
  103be8:	89 04 24             	mov    %eax,(%esp)
        str += 1;
  103beb:	83 c3 01             	add    $0x1,%ebx
static void
cputs (const char *str)
{
    while (*str)
    {
        cons_putc (*str);
  103bee:	e8 fd c7 ff ff       	call   1003f0 <cons_putc>
};

static void
cputs (const char *str)
{
    while (*str)
  103bf3:	0f be 03             	movsbl (%ebx),%eax
  103bf6:	84 c0                	test   %al,%al
  103bf8:	75 ee                	jne    103be8 <putch+0x48>
    b->buf[b->idx++] = ch;
    if (b->idx == CONSOLE_BUFFER_SIZE - 1)
    {
        b->buf[b->idx] = 0;
        cputs (b->buf);
        b->idx = 0;
  103bfa:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
    }
    b->cnt++;
  103c00:	83 46 04 01          	addl   $0x1,0x4(%esi)
}
  103c04:	83 c4 14             	add    $0x14,%esp
  103c07:	5b                   	pop    %ebx
  103c08:	5e                   	pop    %esi
  103c09:	c3                   	ret    
  103c0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00103c10 <vdprintf>:

int
vdprintf (const char *fmt, va_list ap)
{
  103c10:	53                   	push   %ebx
  103c11:	81 ec 28 02 00 00    	sub    $0x228,%esp

    struct dprintbuf b;

    b.idx = 0;
    b.cnt = 0;
    vprintfmt ((void*) putch, &b, fmt, ap);
  103c17:	8b 84 24 34 02 00 00 	mov    0x234(%esp),%eax
};

static void
cputs (const char *str)
{
    while (*str)
  103c1e:	8d 5c 24 20          	lea    0x20(%esp),%ebx

    struct dprintbuf b;

    b.idx = 0;
    b.cnt = 0;
    vprintfmt ((void*) putch, &b, fmt, ap);
  103c22:	c7 04 24 a0 3b 10 00 	movl   $0x103ba0,(%esp)
vdprintf (const char *fmt, va_list ap)
{

    struct dprintbuf b;

    b.idx = 0;
  103c29:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  103c30:	00 
    b.cnt = 0;
  103c31:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  103c38:	00 
    vprintfmt ((void*) putch, &b, fmt, ap);
  103c39:	89 44 24 0c          	mov    %eax,0xc(%esp)
  103c3d:	8b 84 24 30 02 00 00 	mov    0x230(%esp),%eax
  103c44:	89 44 24 08          	mov    %eax,0x8(%esp)
  103c48:	8d 44 24 18          	lea    0x18(%esp),%eax
  103c4c:	89 44 24 04          	mov    %eax,0x4(%esp)
  103c50:	e8 ab 01 00 00       	call   103e00 <vprintfmt>

    b.buf[b.idx] = 0;
  103c55:	8b 44 24 18          	mov    0x18(%esp),%eax
  103c59:	c6 44 04 20 00       	movb   $0x0,0x20(%esp,%eax,1)
};

static void
cputs (const char *str)
{
    while (*str)
  103c5e:	0f be 44 24 20       	movsbl 0x20(%esp),%eax
  103c63:	84 c0                	test   %al,%al
  103c65:	74 13                	je     103c7a <vdprintf+0x6a>
  103c67:	90                   	nop
    {
        cons_putc (*str);
  103c68:	89 04 24             	mov    %eax,(%esp)
        str += 1;
  103c6b:	83 c3 01             	add    $0x1,%ebx
static void
cputs (const char *str)
{
    while (*str)
    {
        cons_putc (*str);
  103c6e:	e8 7d c7 ff ff       	call   1003f0 <cons_putc>
};

static void
cputs (const char *str)
{
    while (*str)
  103c73:	0f be 03             	movsbl (%ebx),%eax
  103c76:	84 c0                	test   %al,%al
  103c78:	75 ee                	jne    103c68 <vdprintf+0x58>
    vprintfmt ((void*) putch, &b, fmt, ap);

    b.buf[b.idx] = 0;
    cputs (b.buf);

    return b.cnt;
  103c7a:	8b 44 24 1c          	mov    0x1c(%esp),%eax
}
  103c7e:	81 c4 28 02 00 00    	add    $0x228,%esp
  103c84:	5b                   	pop    %ebx
  103c85:	c3                   	ret    
  103c86:	8d 76 00             	lea    0x0(%esi),%esi
  103c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103c90 <dprintf>:

int
dprintf (const char *fmt, ...)
{
  103c90:	83 ec 1c             	sub    $0x1c,%esp
    va_list ap;
    int cnt;

    va_start(ap, fmt);
  103c93:	8d 44 24 24          	lea    0x24(%esp),%eax
    cnt = vdprintf (fmt, ap);
  103c97:	89 44 24 04          	mov    %eax,0x4(%esp)
  103c9b:	8b 44 24 20          	mov    0x20(%esp),%eax
  103c9f:	89 04 24             	mov    %eax,(%esp)
  103ca2:	e8 69 ff ff ff       	call   103c10 <vdprintf>
    va_end(ap);

    return cnt;
}
  103ca7:	83 c4 1c             	add    $0x1c,%esp
  103caa:	c3                   	ret    
  103cab:	66 90                	xchg   %ax,%ax
  103cad:	66 90                	xchg   %ax,%ax
  103caf:	90                   	nop

00103cb0 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(putch_t putch, void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  103cb0:	55                   	push   %ebp
  103cb1:	57                   	push   %edi
  103cb2:	89 d7                	mov    %edx,%edi
  103cb4:	56                   	push   %esi
  103cb5:	89 c6                	mov    %eax,%esi
  103cb7:	53                   	push   %ebx
  103cb8:	83 ec 3c             	sub    $0x3c,%esp
  103cbb:	8b 44 24 50          	mov    0x50(%esp),%eax
  103cbf:	8b 4c 24 58          	mov    0x58(%esp),%ecx
  103cc3:	8b 5c 24 5c          	mov    0x5c(%esp),%ebx
  103cc7:	8b 6c 24 60          	mov    0x60(%esp),%ebp
  103ccb:	89 44 24 20          	mov    %eax,0x20(%esp)
  103ccf:	8b 44 24 54          	mov    0x54(%esp),%eax
	/* first recursively print all preceding (more significant) digits */
	if (num >= base) {
  103cd3:	89 ca                	mov    %ecx,%edx
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(putch_t putch, void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  103cd5:	89 4c 24 28          	mov    %ecx,0x28(%esp)
	/* first recursively print all preceding (more significant) digits */
	if (num >= base) {
  103cd9:	31 c9                	xor    %ecx,%ecx
  103cdb:	89 54 24 18          	mov    %edx,0x18(%esp)
  103cdf:	39 c1                	cmp    %eax,%ecx
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(putch_t putch, void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  103ce1:	89 44 24 24          	mov    %eax,0x24(%esp)
	/* first recursively print all preceding (more significant) digits */
	if (num >= base) {
  103ce5:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
  103ce9:	0f 83 a9 00 00 00    	jae    103d98 <printnum+0xe8>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  103cef:	8b 44 24 28          	mov    0x28(%esp),%eax
  103cf3:	83 eb 01             	sub    $0x1,%ebx
  103cf6:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  103cfa:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  103cfe:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  103d02:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  103d06:	89 44 24 08          	mov    %eax,0x8(%esp)
  103d0a:	8b 44 24 18          	mov    0x18(%esp),%eax
  103d0e:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  103d12:	89 54 24 0c          	mov    %edx,0xc(%esp)
  103d16:	89 5c 24 2c          	mov    %ebx,0x2c(%esp)
  103d1a:	89 44 24 08          	mov    %eax,0x8(%esp)
  103d1e:	8b 44 24 20          	mov    0x20(%esp),%eax
  103d22:	89 4c 24 28          	mov    %ecx,0x28(%esp)
  103d26:	89 04 24             	mov    %eax,(%esp)
  103d29:	8b 44 24 24          	mov    0x24(%esp),%eax
  103d2d:	89 44 24 04          	mov    %eax,0x4(%esp)
  103d31:	e8 3a 3c 00 00       	call   107970 <__udivdi3>
  103d36:	8b 4c 24 28          	mov    0x28(%esp),%ecx
  103d3a:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
  103d3e:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  103d42:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  103d46:	89 04 24             	mov    %eax,(%esp)
  103d49:	89 f0                	mov    %esi,%eax
  103d4b:	89 54 24 04          	mov    %edx,0x4(%esp)
  103d4f:	89 fa                	mov    %edi,%edx
  103d51:	e8 5a ff ff ff       	call   103cb0 <printnum>
		while (--width > 0)
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  103d56:	8b 44 24 18          	mov    0x18(%esp),%eax
  103d5a:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  103d5e:	89 7c 24 54          	mov    %edi,0x54(%esp)
  103d62:	89 44 24 08          	mov    %eax,0x8(%esp)
  103d66:	8b 44 24 20          	mov    0x20(%esp),%eax
  103d6a:	89 54 24 0c          	mov    %edx,0xc(%esp)
  103d6e:	89 04 24             	mov    %eax,(%esp)
  103d71:	8b 44 24 24          	mov    0x24(%esp),%eax
  103d75:	89 44 24 04          	mov    %eax,0x4(%esp)
  103d79:	e8 22 3d 00 00       	call   107aa0 <__umoddi3>
  103d7e:	0f be 80 5c 8e 10 00 	movsbl 0x108e5c(%eax),%eax
  103d85:	89 44 24 50          	mov    %eax,0x50(%esp)
}
  103d89:	83 c4 3c             	add    $0x3c,%esp
		while (--width > 0)
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  103d8c:	89 f0                	mov    %esi,%eax
}
  103d8e:	5b                   	pop    %ebx
  103d8f:	5e                   	pop    %esi
  103d90:	5f                   	pop    %edi
  103d91:	5d                   	pop    %ebp
		while (--width > 0)
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  103d92:	ff e0                	jmp    *%eax
  103d94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static void
printnum(putch_t putch, void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
	/* first recursively print all preceding (more significant) digits */
	if (num >= base) {
  103d98:	76 1e                	jbe    103db8 <printnum+0x108>
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		/* print any needed pad characters before first digit */
		while (--width > 0)
  103d9a:	83 eb 01             	sub    $0x1,%ebx
  103d9d:	85 db                	test   %ebx,%ebx
  103d9f:	7e b5                	jle    103d56 <printnum+0xa6>
  103da1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			putch(padc, putdat);
  103da8:	89 7c 24 04          	mov    %edi,0x4(%esp)
  103dac:	89 2c 24             	mov    %ebp,(%esp)
  103daf:	ff d6                	call   *%esi
	/* first recursively print all preceding (more significant) digits */
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		/* print any needed pad characters before first digit */
		while (--width > 0)
  103db1:	83 eb 01             	sub    $0x1,%ebx
  103db4:	75 f2                	jne    103da8 <printnum+0xf8>
  103db6:	eb 9e                	jmp    103d56 <printnum+0xa6>
static void
printnum(putch_t putch, void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
	/* first recursively print all preceding (more significant) digits */
	if (num >= base) {
  103db8:	8b 44 24 20          	mov    0x20(%esp),%eax
  103dbc:	39 44 24 28          	cmp    %eax,0x28(%esp)
  103dc0:	0f 86 29 ff ff ff    	jbe    103cef <printnum+0x3f>
  103dc6:	eb d2                	jmp    103d9a <printnum+0xea>
  103dc8:	90                   	nop
  103dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103dd0 <getuint>:
 * depending on the lflag parameter.
 */
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
  103dd0:	83 fa 01             	cmp    $0x1,%edx
		return va_arg(*ap, unsigned long long);
  103dd3:	8b 10                	mov    (%eax),%edx
 * depending on the lflag parameter.
 */
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
  103dd5:	7e 11                	jle    103de8 <getuint+0x18>
		return va_arg(*ap, unsigned long long);
  103dd7:	8d 4a 08             	lea    0x8(%edx),%ecx
  103dda:	89 08                	mov    %ecx,(%eax)
  103ddc:	8b 02                	mov    (%edx),%eax
  103dde:	8b 52 04             	mov    0x4(%edx),%edx
  103de1:	c3                   	ret    
  103de2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	else if (lflag)
		return va_arg(*ap, unsigned long);
  103de8:	8d 4a 04             	lea    0x4(%edx),%ecx
  103deb:	89 08                	mov    %ecx,(%eax)
  103ded:	8b 02                	mov    (%edx),%eax
  103def:	31 d2                	xor    %edx,%edx
	else
		return va_arg(*ap, unsigned int);
}
  103df1:	c3                   	ret    
  103df2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103e00 <vprintfmt>:
		return va_arg(*ap, int);
}

void
vprintfmt(putch_t putch, void *putdat, const char *fmt, va_list ap)
{
  103e00:	55                   	push   %ebp
  103e01:	57                   	push   %edi
  103e02:	56                   	push   %esi
  103e03:	53                   	push   %ebx
  103e04:	83 ec 3c             	sub    $0x3c,%esp
  103e07:	8b 7c 24 50          	mov    0x50(%esp),%edi
  103e0b:	8b 74 24 54          	mov    0x54(%esp),%esi
  103e0f:	8b 6c 24 58          	mov    0x58(%esp),%ebp
  103e13:	eb 12                	jmp    103e27 <vprintfmt+0x27>
  103e15:	8d 76 00             	lea    0x0(%esi),%esi
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
  103e18:	85 c0                	test   %eax,%eax
  103e1a:	74 64                	je     103e80 <vprintfmt+0x80>
				return;
			putch(ch, putdat);
  103e1c:	89 74 24 04          	mov    %esi,0x4(%esp)
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  103e20:	89 dd                	mov    %ebx,%ebp
			if (ch == '\0')
				return;
			putch(ch, putdat);
  103e22:	89 04 24             	mov    %eax,(%esp)
  103e25:	ff d7                	call   *%edi
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  103e27:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
  103e2b:	8d 5d 01             	lea    0x1(%ebp),%ebx
  103e2e:	83 f8 25             	cmp    $0x25,%eax
  103e31:	75 e5                	jne    103e18 <vprintfmt+0x18>
  103e33:	8b 44 24 5c          	mov    0x5c(%esp),%eax
  103e37:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  103e3c:	c6 44 24 2b 20       	movb   $0x20,0x2b(%esp)
  103e41:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  103e48:	00 
  103e49:	c7 44 24 20 ff ff ff 	movl   $0xffffffff,0x20(%esp)
  103e50:	ff 
  103e51:	89 44 24 24          	mov    %eax,0x24(%esp)
  103e55:	c7 44 24 2c 00 00 00 	movl   $0x0,0x2c(%esp)
  103e5c:	00 
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  103e5d:	0f b6 03             	movzbl (%ebx),%eax
  103e60:	8d 6b 01             	lea    0x1(%ebx),%ebp
  103e63:	0f b6 c8             	movzbl %al,%ecx
  103e66:	83 e8 23             	sub    $0x23,%eax
  103e69:	3c 55                	cmp    $0x55,%al
  103e6b:	0f 87 7a 02 00 00    	ja     1040eb <vprintfmt+0x2eb>
  103e71:	0f b6 c0             	movzbl %al,%eax
  103e74:	ff 24 85 74 8e 10 00 	jmp    *0x108e74(,%eax,4)
  103e7b:	90                   	nop
  103e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  103e80:	83 c4 3c             	add    $0x3c,%esp
  103e83:	5b                   	pop    %ebx
  103e84:	5e                   	pop    %esi
  103e85:	5f                   	pop    %edi
  103e86:	5d                   	pop    %ebp
  103e87:	c3                   	ret    
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  103e88:	89 eb                	mov    %ebp,%ebx
			padc = '-';
			goto reswitch;

			// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  103e8a:	c6 44 24 2b 30       	movb   $0x30,0x2b(%esp)
  103e8f:	eb cc                	jmp    103e5d <vprintfmt+0x5d>
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
				precision = precision * 10 + ch - '0';
				ch = *fmt;
  103e91:	0f be 43 01          	movsbl 0x1(%ebx),%eax
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
				precision = precision * 10 + ch - '0';
  103e95:	8d 51 d0             	lea    -0x30(%ecx),%edx
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  103e98:	89 eb                	mov    %ebp,%ebx
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
  103e9a:	8d 48 d0             	lea    -0x30(%eax),%ecx
  103e9d:	83 f9 09             	cmp    $0x9,%ecx
  103ea0:	0f 87 06 02 00 00    	ja     1040ac <vprintfmt+0x2ac>
  103ea6:	66 90                	xchg   %ax,%ax
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  103ea8:	83 c3 01             	add    $0x1,%ebx
				precision = precision * 10 + ch - '0';
  103eab:	8d 14 92             	lea    (%edx,%edx,4),%edx
  103eae:	8d 54 50 d0          	lea    -0x30(%eax,%edx,2),%edx
				ch = *fmt;
  103eb2:	0f be 03             	movsbl (%ebx),%eax
				if (ch < '0' || ch > '9')
  103eb5:	8d 48 d0             	lea    -0x30(%eax),%ecx
  103eb8:	83 f9 09             	cmp    $0x9,%ecx
  103ebb:	76 eb                	jbe    103ea8 <vprintfmt+0xa8>
  103ebd:	e9 ea 01 00 00       	jmp    1040ac <vprintfmt+0x2ac>
			lflag++;
			goto reswitch;

			// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  103ec2:	8b 54 24 24          	mov    0x24(%esp),%edx
  103ec6:	89 74 24 04          	mov    %esi,0x4(%esp)
  103eca:	89 d0                	mov    %edx,%eax
  103ecc:	83 c0 04             	add    $0x4,%eax
  103ecf:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  103ed3:	8b 02                	mov    (%edx),%eax
  103ed5:	89 04 24             	mov    %eax,(%esp)
  103ed8:	ff d7                	call   *%edi
			break;
  103eda:	e9 48 ff ff ff       	jmp    103e27 <vprintfmt+0x27>
 */
static long long
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, long long);
  103edf:	8b 54 24 24          	mov    0x24(%esp),%edx
 * because of sign extension
 */
static long long
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
  103ee3:	83 7c 24 2c 01       	cmpl   $0x1,0x2c(%esp)
		return va_arg(*ap, long long);
  103ee8:	89 d0                	mov    %edx,%eax
 * because of sign extension
 */
static long long
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
  103eea:	0f 8e db 02 00 00    	jle    1041cb <vprintfmt+0x3cb>
		return va_arg(*ap, long long);
  103ef0:	83 c0 08             	add    $0x8,%eax
  103ef3:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  103ef7:	89 d0                	mov    %edx,%eax
  103ef9:	8b 52 04             	mov    0x4(%edx),%edx
  103efc:	8b 00                	mov    (%eax),%eax
			break;

			// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
			if ((long long) num < 0) {
  103efe:	85 d2                	test   %edx,%edx
  103f00:	bb 0a 00 00 00       	mov    $0xa,%ebx
  103f05:	0f 88 cf 02 00 00    	js     1041da <vprintfmt+0x3da>
  103f0b:	90                   	nop
  103f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
			// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
			base = 16;
		number:
			printnum(putch, putdat, num, base, width, padc);
  103f10:	0f be 4c 24 2b       	movsbl 0x2b(%esp),%ecx
  103f15:	89 04 24             	mov    %eax,(%esp)
  103f18:	89 f8                	mov    %edi,%eax
  103f1a:	89 54 24 04          	mov    %edx,0x4(%esp)
  103f1e:	89 f2                	mov    %esi,%edx
  103f20:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  103f24:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  103f28:	8b 4c 24 20          	mov    0x20(%esp),%ecx
  103f2c:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  103f30:	e8 7b fd ff ff       	call   103cb0 <printnum>
			break;
  103f35:	e9 ed fe ff ff       	jmp    103e27 <vprintfmt+0x27>
				width = precision, precision = -1;
			goto reswitch;

			// long flag (doubled for long long)
		case 'l':
			lflag++;
  103f3a:	83 44 24 2c 01       	addl   $0x1,0x2c(%esp)
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  103f3f:	89 eb                	mov    %ebp,%ebx
			goto reswitch;

			// long flag (doubled for long long)
		case 'l':
			lflag++;
			goto reswitch;
  103f41:	e9 17 ff ff ff       	jmp    103e5d <vprintfmt+0x5d>
  103f46:	8b 44 24 24          	mov    0x24(%esp),%eax

			// (unsigned) octal
		case 'o':
			num = getuint(&ap, lflag);
			base = 8;
			goto number;
  103f4a:	bb 08 00 00 00       	mov    $0x8,%ebx
			base = 10;
			goto number;

			// (unsigned) octal
		case 'o':
			num = getuint(&ap, lflag);
  103f4f:	8b 54 24 2c          	mov    0x2c(%esp),%edx
  103f53:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  103f57:	8d 44 24 5c          	lea    0x5c(%esp),%eax
  103f5b:	e8 70 fe ff ff       	call   103dd0 <getuint>
			base = 8;
			goto number;
  103f60:	eb ae                	jmp    103f10 <vprintfmt+0x110>
  103f62:	8b 44 24 24          	mov    0x24(%esp),%eax
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
				(uintptr_t) va_arg(ap, void *);
			base = 16;
			goto number;
  103f66:	bb 10 00 00 00       	mov    $0x10,%ebx
			base = 8;
			goto number;

			// pointer
		case 'p':
			putch('0', putdat);
  103f6b:	89 74 24 04          	mov    %esi,0x4(%esp)
  103f6f:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
  103f76:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  103f7a:	ff d7                	call   *%edi
			putch('x', putdat);
  103f7c:	89 74 24 04          	mov    %esi,0x4(%esp)
  103f80:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
  103f87:	ff d7                	call   *%edi
			num = (unsigned long long)
				(uintptr_t) va_arg(ap, void *);
  103f89:	8b 44 24 5c          	mov    0x5c(%esp),%eax
  103f8d:	8d 50 04             	lea    0x4(%eax),%edx
  103f90:	89 54 24 5c          	mov    %edx,0x5c(%esp)

			// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  103f94:	31 d2                	xor    %edx,%edx
  103f96:	8b 00                	mov    (%eax),%eax
				(uintptr_t) va_arg(ap, void *);
			base = 16;
			goto number;
  103f98:	e9 73 ff ff ff       	jmp    103f10 <vprintfmt+0x110>
			putch(va_arg(ap, int), putdat);
			break;

			// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  103f9d:	8b 4c 24 24          	mov    0x24(%esp),%ecx
  103fa1:	89 c8                	mov    %ecx,%eax
  103fa3:	83 c0 04             	add    $0x4,%eax
  103fa6:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  103faa:	8b 09                	mov    (%ecx),%ecx
				p = "(null)";
  103fac:	b8 6d 8e 10 00       	mov    $0x108e6d,%eax
  103fb1:	85 c9                	test   %ecx,%ecx
  103fb3:	0f 44 c8             	cmove  %eax,%ecx
			if (width > 0 && padc != '-')
  103fb6:	80 7c 24 2b 2d       	cmpb   $0x2d,0x2b(%esp)
  103fbb:	0f 85 96 01 00 00    	jne    104157 <vprintfmt+0x357>
				for (width -= strnlen(p, precision);
				     width > 0;
				     width--)
					putch(padc, putdat);
			for (;
			     (ch = *p++) != '\0' &&
  103fc1:	0f be 01             	movsbl (%ecx),%eax
  103fc4:	8d 59 01             	lea    0x1(%ecx),%ebx
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision);
				     width > 0;
				     width--)
					putch(padc, putdat);
			for (;
  103fc7:	85 c0                	test   %eax,%eax
  103fc9:	0f 84 5b 01 00 00    	je     10412a <vprintfmt+0x32a>
  103fcf:	89 74 24 54          	mov    %esi,0x54(%esp)
  103fd3:	89 de                	mov    %ebx,%esi
  103fd5:	89 d3                	mov    %edx,%ebx
  103fd7:	89 6c 24 58          	mov    %ebp,0x58(%esp)
  103fdb:	8b 6c 24 20          	mov    0x20(%esp),%ebp
  103fdf:	eb 26                	jmp    104007 <vprintfmt+0x207>
  103fe1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
				     (precision < 0 || --precision >= 0);
			     width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
  103fe8:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  103fec:	89 04 24             	mov    %eax,(%esp)
  103fef:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  103ff3:	ff d7                	call   *%edi
				for (width -= strnlen(p, precision);
				     width > 0;
				     width--)
					putch(padc, putdat);
			for (;
			     (ch = *p++) != '\0' &&
  103ff5:	83 c6 01             	add    $0x1,%esi
  103ff8:	0f be 46 ff          	movsbl -0x1(%esi),%eax
				     (precision < 0 || --precision >= 0);
			     width--)
  103ffc:	83 ed 01             	sub    $0x1,%ebp
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision);
				     width > 0;
				     width--)
					putch(padc, putdat);
			for (;
  103fff:	85 c0                	test   %eax,%eax
  104001:	0f 84 17 01 00 00    	je     10411e <vprintfmt+0x31e>
			     (ch = *p++) != '\0' &&
  104007:	85 db                	test   %ebx,%ebx
  104009:	78 0c                	js     104017 <vprintfmt+0x217>
				     (precision < 0 || --precision >= 0);
  10400b:	83 eb 01             	sub    $0x1,%ebx
  10400e:	83 fb ff             	cmp    $0xffffffff,%ebx
  104011:	0f 84 07 01 00 00    	je     10411e <vprintfmt+0x31e>
			     width--)
				if (altflag && (ch < ' ' || ch > '~'))
  104017:	8b 54 24 18          	mov    0x18(%esp),%edx
  10401b:	85 d2                	test   %edx,%edx
  10401d:	74 c9                	je     103fe8 <vprintfmt+0x1e8>
  10401f:	8d 48 e0             	lea    -0x20(%eax),%ecx
  104022:	83 f9 5e             	cmp    $0x5e,%ecx
  104025:	76 c1                	jbe    103fe8 <vprintfmt+0x1e8>
					putch('?', putdat);
  104027:	8b 44 24 54          	mov    0x54(%esp),%eax
  10402b:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
  104032:	89 44 24 04          	mov    %eax,0x4(%esp)
  104036:	ff d7                	call   *%edi
  104038:	eb bb                	jmp    103ff5 <vprintfmt+0x1f5>
  10403a:	8b 44 24 24          	mov    0x24(%esp),%eax

			// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
			base = 10;
			goto number;
  10403e:	bb 0a 00 00 00       	mov    $0xa,%ebx
			base = 10;
			goto number;

			// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  104043:	8b 54 24 2c          	mov    0x2c(%esp),%edx
  104047:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  10404b:	8d 44 24 5c          	lea    0x5c(%esp),%eax
  10404f:	e8 7c fd ff ff       	call   103dd0 <getuint>
			base = 10;
			goto number;
  104054:	e9 b7 fe ff ff       	jmp    103f10 <vprintfmt+0x110>
  104059:	8b 44 24 24          	mov    0x24(%esp),%eax
			base = 16;
			goto number;

			// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  10405d:	bb 10 00 00 00       	mov    $0x10,%ebx
  104062:	8b 54 24 2c          	mov    0x2c(%esp),%edx
  104066:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  10406a:	8d 44 24 5c          	lea    0x5c(%esp),%eax
  10406e:	e8 5d fd ff ff       	call   103dd0 <getuint>
  104073:	e9 98 fe ff ff       	jmp    103f10 <vprintfmt+0x110>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  104078:	89 eb                	mov    %ebp,%ebx
			if (width < 0)
				width = 0;
			goto reswitch;

		case '#':
			altflag = 1;
  10407a:	c7 44 24 18 01 00 00 	movl   $0x1,0x18(%esp)
  104081:	00 
			goto reswitch;
  104082:	e9 d6 fd ff ff       	jmp    103e5d <vprintfmt+0x5d>
  104087:	8b 44 24 24          	mov    0x24(%esp),%eax
			printnum(putch, putdat, num, base, width, padc);
			break;

			// escaped '%' character
		case '%':
			putch(ch, putdat);
  10408b:	89 74 24 04          	mov    %esi,0x4(%esp)
  10408f:	89 0c 24             	mov    %ecx,(%esp)
  104092:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  104096:	ff d7                	call   *%edi
			break;
  104098:	e9 8a fd ff ff       	jmp    103e27 <vprintfmt+0x27>
					break;
			}
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  10409d:	8b 44 24 24          	mov    0x24(%esp),%eax
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  1040a1:	89 eb                	mov    %ebp,%ebx
					break;
			}
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  1040a3:	8b 10                	mov    (%eax),%edx
  1040a5:	83 c0 04             	add    $0x4,%eax
  1040a8:	89 44 24 24          	mov    %eax,0x24(%esp)
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  1040ac:	8b 6c 24 20          	mov    0x20(%esp),%ebp
  1040b0:	85 ed                	test   %ebp,%ebp
  1040b2:	0f 89 a5 fd ff ff    	jns    103e5d <vprintfmt+0x5d>
				width = precision, precision = -1;
  1040b8:	89 54 24 20          	mov    %edx,0x20(%esp)
  1040bc:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  1040c1:	e9 97 fd ff ff       	jmp    103e5d <vprintfmt+0x5d>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  1040c6:	89 eb                	mov    %ebp,%ebx

			// flag to pad on the right
		case '-':
			padc = '-';
  1040c8:	c6 44 24 2b 2d       	movb   $0x2d,0x2b(%esp)
  1040cd:	e9 8b fd ff ff       	jmp    103e5d <vprintfmt+0x5d>
  1040d2:	8b 4c 24 20          	mov    0x20(%esp),%ecx
  1040d6:	b8 00 00 00 00       	mov    $0x0,%eax
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  1040db:	89 eb                	mov    %ebp,%ebx
  1040dd:	85 c9                	test   %ecx,%ecx
  1040df:	0f 49 c1             	cmovns %ecx,%eax
  1040e2:	89 44 24 20          	mov    %eax,0x20(%esp)
  1040e6:	e9 72 fd ff ff       	jmp    103e5d <vprintfmt+0x5d>
  1040eb:	8b 44 24 24          	mov    0x24(%esp),%eax
			break;

			// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
			for (fmt--; fmt[-1] != '%'; fmt--)
  1040ef:	89 dd                	mov    %ebx,%ebp
			putch(ch, putdat);
			break;

			// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  1040f1:	89 74 24 04          	mov    %esi,0x4(%esp)
  1040f5:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  1040fc:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  104100:	ff d7                	call   *%edi
			for (fmt--; fmt[-1] != '%'; fmt--)
  104102:	80 7b ff 25          	cmpb   $0x25,-0x1(%ebx)
  104106:	0f 84 1b fd ff ff    	je     103e27 <vprintfmt+0x27>
  10410c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104110:	83 ed 01             	sub    $0x1,%ebp
  104113:	80 7d ff 25          	cmpb   $0x25,-0x1(%ebp)
  104117:	75 f7                	jne    104110 <vprintfmt+0x310>
  104119:	e9 09 fd ff ff       	jmp    103e27 <vprintfmt+0x27>
  10411e:	89 6c 24 20          	mov    %ebp,0x20(%esp)
  104122:	8b 74 24 54          	mov    0x54(%esp),%esi
  104126:	8b 6c 24 58          	mov    0x58(%esp),%ebp
			     width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  10412a:	8b 44 24 20          	mov    0x20(%esp),%eax
  10412e:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  104132:	85 c0                	test   %eax,%eax
  104134:	0f 8e ed fc ff ff    	jle    103e27 <vprintfmt+0x27>
  10413a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
				putch(' ', putdat);
  104140:	89 74 24 04          	mov    %esi,0x4(%esp)
  104144:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  10414b:	ff d7                	call   *%edi
			     width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  10414d:	83 eb 01             	sub    $0x1,%ebx
  104150:	75 ee                	jne    104140 <vprintfmt+0x340>
  104152:	e9 d0 fc ff ff       	jmp    103e27 <vprintfmt+0x27>

			// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
  104157:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  10415b:	85 db                	test   %ebx,%ebx
  10415d:	0f 8e 5e fe ff ff    	jle    103fc1 <vprintfmt+0x1c1>
				for (width -= strnlen(p, precision);
  104163:	89 54 24 04          	mov    %edx,0x4(%esp)
  104167:	89 0c 24             	mov    %ecx,(%esp)
  10416a:	89 54 24 2c          	mov    %edx,0x2c(%esp)
  10416e:	89 4c 24 24          	mov    %ecx,0x24(%esp)
  104172:	e8 29 f7 ff ff       	call   1038a0 <strnlen>
  104177:	8b 4c 24 24          	mov    0x24(%esp),%ecx
  10417b:	8b 54 24 2c          	mov    0x2c(%esp),%edx
  10417f:	29 44 24 20          	sub    %eax,0x20(%esp)
  104183:	8b 44 24 20          	mov    0x20(%esp),%eax
  104187:	85 c0                	test   %eax,%eax
  104189:	0f 8e 32 fe ff ff    	jle    103fc1 <vprintfmt+0x1c1>
  10418f:	0f be 5c 24 2b       	movsbl 0x2b(%esp),%ebx
  104194:	89 6c 24 58          	mov    %ebp,0x58(%esp)
  104198:	89 c5                	mov    %eax,%ebp
  10419a:	89 4c 24 20          	mov    %ecx,0x20(%esp)
  10419e:	89 54 24 24          	mov    %edx,0x24(%esp)
  1041a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
				     width > 0;
				     width--)
					putch(padc, putdat);
  1041a8:	89 74 24 04          	mov    %esi,0x4(%esp)
  1041ac:	89 1c 24             	mov    %ebx,(%esp)
  1041af:	ff d7                	call   *%edi
			// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision);
  1041b1:	83 ed 01             	sub    $0x1,%ebp
  1041b4:	75 f2                	jne    1041a8 <vprintfmt+0x3a8>
  1041b6:	8b 4c 24 20          	mov    0x20(%esp),%ecx
  1041ba:	8b 54 24 24          	mov    0x24(%esp),%edx
  1041be:	89 6c 24 20          	mov    %ebp,0x20(%esp)
  1041c2:	8b 6c 24 58          	mov    0x58(%esp),%ebp
  1041c6:	e9 f6 fd ff ff       	jmp    103fc1 <vprintfmt+0x1c1>
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, long long);
	else if (lflag)
		return va_arg(*ap, long);
  1041cb:	83 c0 04             	add    $0x4,%eax
  1041ce:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  1041d2:	8b 02                	mov    (%edx),%eax
  1041d4:	99                   	cltd   
  1041d5:	e9 24 fd ff ff       	jmp    103efe <vprintfmt+0xfe>
  1041da:	89 44 24 18          	mov    %eax,0x18(%esp)
  1041de:	89 54 24 1c          	mov    %edx,0x1c(%esp)

			// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
			if ((long long) num < 0) {
				putch('-', putdat);
  1041e2:	89 74 24 04          	mov    %esi,0x4(%esp)
  1041e6:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
  1041ed:	ff d7                	call   *%edi
				num = -(long long) num;
  1041ef:	8b 44 24 18          	mov    0x18(%esp),%eax
  1041f3:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  1041f7:	f7 d8                	neg    %eax
  1041f9:	83 d2 00             	adc    $0x0,%edx
  1041fc:	f7 da                	neg    %edx
  1041fe:	e9 0d fd ff ff       	jmp    103f10 <vprintfmt+0x110>
  104203:	66 90                	xchg   %ax,%ax
  104205:	66 90                	xchg   %ax,%ax
  104207:	66 90                	xchg   %ax,%ax
  104209:	66 90                	xchg   %ax,%ax
  10420b:	66 90                	xchg   %ax,%ax
  10420d:	66 90                	xchg   %ax,%ax
  10420f:	90                   	nop

00104210 <kstack_switch>:
#include "seg.h"

#define offsetof(type, member)	__builtin_offsetof(type, member)

void kstack_switch(uint32_t pid)
{
  104210:	53                   	push   %ebx
  104211:	83 ec 18             	sub    $0x18,%esp
  104214:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  int cpu_idx = get_pcpu_idx();
  104218:	e8 a3 12 00 00       	call   1054c0 <get_pcpu_idx>

  struct kstack *ks = (struct kstack *) get_pcpu_kstack_pointer(cpu_idx);
  10421d:	89 04 24             	mov    %eax,(%esp)
  104220:	e8 db 12 00 00       	call   105500 <get_pcpu_kstack_pointer>

  /*
   * Switch to the new TSS.
   */
  ks->tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  104225:	89 da                	mov    %ebx,%edx
  ks->tss.ts_ss0 = CPU_GDT_KDATA;
  ks->gdt[CPU_GDT_TSS >> 3] =
  104227:	b9 eb 00 00 00       	mov    $0xeb,%ecx
  struct kstack *ks = (struct kstack *) get_pcpu_kstack_pointer(cpu_idx);

  /*
   * Switch to the new TSS.
   */
  ks->tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  10422c:	c1 e2 0c             	shl    $0xc,%edx
  10422f:	81 c2 00 70 97 00    	add    $0x977000,%edx
  ks->tss.ts_ss0 = CPU_GDT_KDATA;
  ks->gdt[CPU_GDT_TSS >> 3] =
          SEGDESC16(STS_T32A,
  104235:	c1 e3 0c             	shl    $0xc,%ebx
  struct kstack *ks = (struct kstack *) get_pcpu_kstack_pointer(cpu_idx);

  /*
   * Switch to the new TSS.
   */
  ks->tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  104238:	89 50 34             	mov    %edx,0x34(%eax)
  ks->tss.ts_ss0 = CPU_GDT_KDATA;
  10423b:	ba 10 00 00 00       	mov    $0x10,%edx
  104240:	66 89 50 38          	mov    %dx,0x38(%eax)
  ks->gdt[CPU_GDT_TSS >> 3] =
          SEGDESC16(STS_T32A,
  104244:	89 da                	mov    %ebx,%edx
  104246:	81 c2 30 60 97 00    	add    $0x976030,%edx
  /*
   * Switch to the new TSS.
   */
  ks->tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  ks->tss.ts_ss0 = CPU_GDT_KDATA;
  ks->gdt[CPU_GDT_TSS >> 3] =
  10424c:	66 89 48 28          	mov    %cx,0x28(%eax)
          SEGDESC16(STS_T32A,
  104250:	89 d1                	mov    %edx,%ecx
  /*
   * Switch to the new TSS.
   */
  ks->tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  ks->tss.ts_ss0 = CPU_GDT_KDATA;
  ks->gdt[CPU_GDT_TSS >> 3] =
  104252:	66 89 50 2a          	mov    %dx,0x2a(%eax)
          SEGDESC16(STS_T32A,
  104256:	c1 e9 10             	shr    $0x10,%ecx
  104259:	c1 ea 18             	shr    $0x18,%edx
  /*
   * Switch to the new TSS.
   */
  ks->tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  ks->tss.ts_ss0 = CPU_GDT_KDATA;
  ks->gdt[CPU_GDT_TSS >> 3] =
  10425c:	88 48 2c             	mov    %cl,0x2c(%eax)
  10425f:	c6 40 2e 40          	movb   $0x40,0x2e(%eax)
  104263:	88 50 2f             	mov    %dl,0x2f(%eax)
          SEGDESC16(STS_T32A,
                    (uint32_t) (&(proc_kstack[pid].tss)), sizeof(tss_t) - 1, 0);
  ks->gdt[CPU_GDT_TSS >> 3].sd_s = 0;
  104266:	c6 40 2d 89          	movb   $0x89,0x2d(%eax)
  ltr(CPU_GDT_TSS);
  10426a:	c7 44 24 20 28 00 00 	movl   $0x28,0x20(%esp)
  104271:	00 

}
  104272:	83 c4 18             	add    $0x18,%esp
  104275:	5b                   	pop    %ebx
  ks->tss.ts_ss0 = CPU_GDT_KDATA;
  ks->gdt[CPU_GDT_TSS >> 3] =
          SEGDESC16(STS_T32A,
                    (uint32_t) (&(proc_kstack[pid].tss)), sizeof(tss_t) - 1, 0);
  ks->gdt[CPU_GDT_TSS >> 3].sd_s = 0;
  ltr(CPU_GDT_TSS);
  104276:	e9 25 06 00 00       	jmp    1048a0 <ltr>
  10427b:	90                   	nop
  10427c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00104280 <seg_init>:

}

void seg_init (int cpu_idx)
{
  104280:	55                   	push   %ebp
  104281:	57                   	push   %edi
  104282:	56                   	push   %esi
  104283:	53                   	push   %ebx
  104284:	83 ec 2c             	sub    $0x2c,%esp
  104287:	8b 5c 24 40          	mov    0x40(%esp),%ebx

	/* clear BSS */

	if (cpu_idx == 0){
  10428b:	85 db                	test   %ebx,%ebx
  10428d:	0f 84 c5 01 00 00    	je     104458 <seg_init+0x1d8>
    memzero(edata, ((uint8_t *) (&bsp_kstack[0])) - edata);
    memzero(((uint8_t *) (&bsp_kstack[0])) + 4096, end - ((uint8_t *) (&bsp_kstack[0])) - 4096);
	}

  /* setup GDT */
  bsp_kstack[cpu_idx].gdt[0] = SEGDESC_NULL;
  104293:	89 d8                	mov    %ebx,%eax
  /* 0x08: kernel code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KCODE >> 3] =
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KDATA >> 3] =
  104295:	31 ff                	xor    %edi,%edi
    memzero(edata, ((uint8_t *) (&bsp_kstack[0])) - edata);
    memzero(((uint8_t *) (&bsp_kstack[0])) + 4096, end - ((uint8_t *) (&bsp_kstack[0])) - 4096);
	}

  /* setup GDT */
  bsp_kstack[cpu_idx].gdt[0] = SEGDESC_NULL;
  104297:	c1 e0 0c             	shl    $0xc,%eax
  /* 0x08: kernel code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KCODE >> 3] =
  10429a:	ba ff ff ff ff       	mov    $0xffffffff,%edx
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KDATA >> 3] =
  10429f:	be ff ff ff ff       	mov    $0xffffffff,%esi
	}

  /* setup GDT */
  bsp_kstack[cpu_idx].gdt[0] = SEGDESC_NULL;
  /* 0x08: kernel code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KCODE >> 3] =
  1042a4:	31 c9                	xor    %ecx,%ecx
  1042a6:	66 89 90 08 e0 96 00 	mov    %dx,0x96e008(%eax)
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KDATA >> 3] =
          SEGDESC32(STA_W, 0x0, 0xffffffff, 0);
  /* 0x18: user code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UCODE >> 3] =
  1042ad:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  bsp_kstack[cpu_idx].gdt[0] = SEGDESC_NULL;
  /* 0x08: kernel code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KCODE >> 3] =
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KDATA >> 3] =
  1042b2:	66 89 b0 10 e0 96 00 	mov    %si,0x96e010(%eax)
          SEGDESC32(STA_W, 0x0, 0xffffffff, 0);
  /* 0x18: user code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UCODE >> 3] =
          SEGDESC32(STA_X | STA_R, 0x00000000, 0xffffffff, 3);
  /* 0x20: user data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UDATA >> 3] =
  1042b9:	be ff ff ff ff       	mov    $0xffffffff,%esi
  bsp_kstack[cpu_idx].gdt[0] = SEGDESC_NULL;
  /* 0x08: kernel code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KCODE >> 3] =
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KDATA >> 3] =
  1042be:	66 89 b8 12 e0 96 00 	mov    %di,0x96e012(%eax)
          SEGDESC32(STA_W, 0x0, 0xffffffff, 0);
  /* 0x18: user code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UCODE >> 3] =
          SEGDESC32(STA_X | STA_R, 0x00000000, 0xffffffff, 3);
  /* 0x20: user data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UDATA >> 3] =
  1042c5:	31 ff                	xor    %edi,%edi
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KDATA >> 3] =
          SEGDESC32(STA_W, 0x0, 0xffffffff, 0);
  /* 0x18: user code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UCODE >> 3] =
  1042c7:	66 89 90 18 e0 96 00 	mov    %dx,0x96e018(%eax)
  /* 0x20: user data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UDATA >> 3] =
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  1042ce:	8d 90 30 e0 96 00    	lea    0x96e030(%eax),%edx
          SEGDESC32(STA_W, 0x0, 0xffffffff, 0);
  /* 0x18: user code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UCODE >> 3] =
          SEGDESC32(STA_X | STA_R, 0x00000000, 0xffffffff, 3);
  /* 0x20: user data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UDATA >> 3] =
  1042d4:	66 89 b0 20 e0 96 00 	mov    %si,0x96e020(%eax)
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  1042db:	89 c6                	mov    %eax,%esi
          SEGDESC32(STA_W, 0x0, 0xffffffff, 0);
  /* 0x18: user code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UCODE >> 3] =
          SEGDESC32(STA_X | STA_R, 0x00000000, 0xffffffff, 3);
  /* 0x20: user data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UDATA >> 3] =
  1042dd:	66 89 b8 22 e0 96 00 	mov    %di,0x96e022(%eax)
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  bsp_kstack[cpu_idx].tss.ts_ss0 = CPU_GDT_KDATA;
  bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  1042e4:	bf eb 00 00 00       	mov    $0xeb,%edi
  /* 0x20: user data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UDATA >> 3] =
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  1042e9:	81 c6 00 f0 96 00    	add    $0x96f000,%esi
	}

  /* setup GDT */
  bsp_kstack[cpu_idx].gdt[0] = SEGDESC_NULL;
  /* 0x08: kernel code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KCODE >> 3] =
  1042ef:	66 89 88 0a e0 96 00 	mov    %cx,0x96e00a(%eax)
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KDATA >> 3] =
          SEGDESC32(STA_W, 0x0, 0xffffffff, 0);
  /* 0x18: user code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UCODE >> 3] =
  1042f6:	31 c9                	xor    %ecx,%ecx
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  bsp_kstack[cpu_idx].tss.ts_ss0 = CPU_GDT_KDATA;
  bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  1042f8:	66 89 b8 28 e0 96 00 	mov    %di,0x96e028(%eax)
          SEGDESC16(STS_T32A,
  1042ff:	89 d7                	mov    %edx,%edi
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KDATA >> 3] =
          SEGDESC32(STA_W, 0x0, 0xffffffff, 0);
  /* 0x18: user code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UCODE >> 3] =
  104301:	66 89 88 1a e0 96 00 	mov    %cx,0x96e01a(%eax)

  /* setup TSS */
  bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  bsp_kstack[cpu_idx].tss.ts_ss0 = CPU_GDT_KDATA;
  bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
          SEGDESC16(STS_T32A,
  104308:	c1 ef 10             	shr    $0x10,%edi
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UDATA >> 3] =
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  bsp_kstack[cpu_idx].tss.ts_ss0 = CPU_GDT_KDATA;
  10430b:	b9 10 00 00 00       	mov    $0x10,%ecx
  /* 0x20: user data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UDATA >> 3] =
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  104310:	89 b0 34 e0 96 00    	mov    %esi,0x96e034(%eax)
  bsp_kstack[cpu_idx].tss.ts_ss0 = CPU_GDT_KDATA;
  bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
          SEGDESC16(STS_T32A,
  104316:	89 d6                	mov    %edx,%esi
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UDATA >> 3] =
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  bsp_kstack[cpu_idx].tss.ts_ss0 = CPU_GDT_KDATA;
  104318:	66 89 88 38 e0 96 00 	mov    %cx,0x96e038(%eax)
  bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
          SEGDESC16(STS_T32A,
  10431f:	c1 ee 18             	shr    $0x18,%esi
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  bsp_kstack[cpu_idx].tss.ts_ss0 = CPU_GDT_KDATA;
  bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  104322:	89 f9                	mov    %edi,%ecx
  104324:	88 88 2c e0 96 00    	mov    %cl,0x96e02c(%eax)
  10432a:	89 f1                	mov    %esi,%ecx
    memzero(edata, ((uint8_t *) (&bsp_kstack[0])) - edata);
    memzero(((uint8_t *) (&bsp_kstack[0])) + 4096, end - ((uint8_t *) (&bsp_kstack[0])) - 4096);
	}

  /* setup GDT */
  bsp_kstack[cpu_idx].gdt[0] = SEGDESC_NULL;
  10432c:	8d a8 00 e0 96 00    	lea    0x96e000(%eax),%ebp
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  bsp_kstack[cpu_idx].tss.ts_ss0 = CPU_GDT_KDATA;
  bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  104332:	66 89 90 2a e0 96 00 	mov    %dx,0x96e02a(%eax)
  104339:	88 88 2f e0 96 00    	mov    %cl,0x96e02f(%eax)
    memzero(edata, ((uint8_t *) (&bsp_kstack[0])) - edata);
    memzero(((uint8_t *) (&bsp_kstack[0])) + 4096, end - ((uint8_t *) (&bsp_kstack[0])) - 4096);
	}

  /* setup GDT */
  bsp_kstack[cpu_idx].gdt[0] = SEGDESC_NULL;
  10433f:	c7 80 00 e0 96 00 00 	movl   $0x0,0x96e000(%eax)
  104346:	00 00 00 
  104349:	c7 80 04 e0 96 00 00 	movl   $0x0,0x96e004(%eax)
  104350:	00 00 00 
  /* 0x08: kernel code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KCODE >> 3] =
  104353:	c6 80 0c e0 96 00 00 	movb   $0x0,0x96e00c(%eax)
  10435a:	c6 80 0d e0 96 00 9a 	movb   $0x9a,0x96e00d(%eax)
  104361:	c6 80 0e e0 96 00 cf 	movb   $0xcf,0x96e00e(%eax)
  104368:	c6 80 0f e0 96 00 00 	movb   $0x0,0x96e00f(%eax)
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_KDATA >> 3] =
  10436f:	c6 80 14 e0 96 00 00 	movb   $0x0,0x96e014(%eax)
  104376:	c6 80 15 e0 96 00 92 	movb   $0x92,0x96e015(%eax)
  10437d:	c6 80 16 e0 96 00 cf 	movb   $0xcf,0x96e016(%eax)
  104384:	c6 80 17 e0 96 00 00 	movb   $0x0,0x96e017(%eax)
          SEGDESC32(STA_W, 0x0, 0xffffffff, 0);
  /* 0x18: user code */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UCODE >> 3] =
  10438b:	c6 80 1c e0 96 00 00 	movb   $0x0,0x96e01c(%eax)
  104392:	c6 80 1d e0 96 00 fa 	movb   $0xfa,0x96e01d(%eax)
  104399:	c6 80 1e e0 96 00 cf 	movb   $0xcf,0x96e01e(%eax)
  1043a0:	c6 80 1f e0 96 00 00 	movb   $0x0,0x96e01f(%eax)
          SEGDESC32(STA_X | STA_R, 0x00000000, 0xffffffff, 3);
  /* 0x20: user data */
  bsp_kstack[cpu_idx].gdt[CPU_GDT_UDATA >> 3] =
  1043a7:	c6 80 24 e0 96 00 00 	movb   $0x0,0x96e024(%eax)
  1043ae:	c6 80 25 e0 96 00 f2 	movb   $0xf2,0x96e025(%eax)
  1043b5:	c6 80 26 e0 96 00 cf 	movb   $0xcf,0x96e026(%eax)
  1043bc:	c6 80 27 e0 96 00 00 	movb   $0x0,0x96e027(%eax)
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  bsp_kstack[cpu_idx].tss.ts_ss0 = CPU_GDT_KDATA;
  bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  1043c3:	c6 80 2e e0 96 00 40 	movb   $0x40,0x96e02e(%eax)
          SEGDESC16(STS_T32A,
                    (uint32_t) (&(bsp_kstack[cpu_idx].tss)), sizeof(tss_t) - 1, 0);
  bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3].sd_s = 0;
  1043ca:	c6 80 2d e0 96 00 89 	movb   $0x89,0x96e02d(%eax)

  /* other fields */
  /* Set the KSTACK_MAGIC value when we initialize the kstack */
  bsp_kstack[cpu_idx].magic = KSTACK_MAGIC;
  1043d1:	c7 80 20 e1 96 00 32 	movl   $0x98765432,0x96e120(%eax)
  1043d8:	54 76 98 

  pseudodesc_t gdt_desc = {
  1043db:	b8 2f 00 00 00       	mov    $0x2f,%eax
  1043e0:	66 89 44 24 1a       	mov    %ax,0x1a(%esp)
          .pd_lim   = sizeof(bsp_kstack[cpu_idx].gdt) - 1,
          .pd_base  = (uint32_t) (bsp_kstack[cpu_idx].gdt)
  1043e5:	89 6c 24 1c          	mov    %ebp,0x1c(%esp)
  };
  asm volatile("lgdt %0" :: "m" (gdt_desc));
  1043e9:	0f 01 54 24 1a       	lgdtl  0x1a(%esp)
  asm volatile("movw %%ax,%%gs" :: "a" (CPU_GDT_KDATA));
  1043ee:	b8 10 00 00 00       	mov    $0x10,%eax
  1043f3:	8e e8                	mov    %eax,%gs
  asm volatile("movw %%ax,%%fs" :: "a" (CPU_GDT_KDATA));
  1043f5:	8e e0                	mov    %eax,%fs
  asm volatile("movw %%ax,%%es" :: "a" (CPU_GDT_KDATA));
  1043f7:	8e c0                	mov    %eax,%es
  asm volatile("movw %%ax,%%ds" :: "a" (CPU_GDT_KDATA));
  1043f9:	8e d8                	mov    %eax,%ds
  asm volatile("movw %%ax,%%ss" :: "a" (CPU_GDT_KDATA));
  1043fb:	8e d0                	mov    %eax,%ss
  /* reload %cs */
  asm volatile("ljmp %0,$1f\n 1:\n" :: "i" (CPU_GDT_KCODE));
  1043fd:	ea 04 44 10 00 08 00 	ljmp   $0x8,$0x104404

	/*
	 * Load a null LDT.
	 */
	lldt (0);
  104404:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10440b:	e8 b0 02 00 00       	call   1046c0 <lldt>

	/*
	 * Load the bootstrap TSS.
	 */
	ltr (CPU_GDT_TSS);
  104410:	c7 04 24 28 00 00 00 	movl   $0x28,(%esp)
  104417:	e8 84 04 00 00       	call   1048a0 <ltr>

	/*
	 * Load IDT.
	 */
	extern pseudodesc_t idt_pd;
	asm volatile("lidt %0" : : "m" (idt_pd));
  10441c:	0f 01 1d 00 d3 10 00 	lidtl  0x10d300

	/*
	 * Initialize all TSS structures for processes.
	 */

	if (cpu_idx == 0){
  104423:	85 db                	test   %ebx,%ebx
  104425:	75 28                	jne    10444f <seg_init+0x1cf>
		memzero(&(bsp_kstack[1]), sizeof(struct kstack) * 7);
  104427:	c7 44 24 04 00 70 00 	movl   $0x7000,0x4(%esp)
  10442e:	00 
  10442f:	c7 04 24 00 f0 96 00 	movl   $0x96f000,(%esp)
  104436:	e8 25 f5 ff ff       	call   103960 <memzero>
		memzero(proc_kstack, sizeof(struct kstack) * 64);
  10443b:	c7 44 24 04 00 00 04 	movl   $0x40000,0x4(%esp)
  104442:	00 
  104443:	c7 04 24 00 60 97 00 	movl   $0x976000,(%esp)
  10444a:	e8 11 f5 ff ff       	call   103960 <memzero>
	}
	
}
  10444f:	83 c4 2c             	add    $0x2c,%esp
  104452:	5b                   	pop    %ebx
  104453:	5e                   	pop    %esi
  104454:	5f                   	pop    %edi
  104455:	5d                   	pop    %ebp
  104456:	c3                   	ret    
  104457:	90                   	nop

	/* clear BSS */

	if (cpu_idx == 0){
		extern uint8_t end[], edata[];
    memzero(edata, ((uint8_t *) (&bsp_kstack[0])) - edata);
  104458:	b8 00 e0 96 00       	mov    $0x96e000,%eax
  10445d:	2d c6 b4 12 00       	sub    $0x12b4c6,%eax
  104462:	89 44 24 04          	mov    %eax,0x4(%esp)
  104466:	c7 04 24 c6 b4 12 00 	movl   $0x12b4c6,(%esp)
  10446d:	e8 ee f4 ff ff       	call   103960 <memzero>
    memzero(((uint8_t *) (&bsp_kstack[0])) + 4096, end - ((uint8_t *) (&bsp_kstack[0])) - 4096);
  104472:	b8 60 aa df 00       	mov    $0xdfaa60,%eax
  104477:	2d 00 e0 96 00       	sub    $0x96e000,%eax
  10447c:	89 44 24 04          	mov    %eax,0x4(%esp)
  104480:	c7 04 24 00 f0 96 00 	movl   $0x96f000,(%esp)
  104487:	e8 d4 f4 ff ff       	call   103960 <memzero>
  10448c:	e9 02 fe ff ff       	jmp    104293 <seg_init+0x13>
  104491:	eb 0d                	jmp    1044a0 <seg_init_proc>
  104493:	90                   	nop
  104494:	90                   	nop
  104495:	90                   	nop
  104496:	90                   	nop
  104497:	90                   	nop
  104498:	90                   	nop
  104499:	90                   	nop
  10449a:	90                   	nop
  10449b:	90                   	nop
  10449c:	90                   	nop
  10449d:	90                   	nop
  10449e:	90                   	nop
  10449f:	90                   	nop

001044a0 <seg_init_proc>:
	
}

/* initialize the kernel stack for each process */
void
seg_init_proc(int cpu_idx, int pid){
  1044a0:	57                   	push   %edi

  /* setup GDT */
  proc_kstack[pid].gdt[0] = SEGDESC_NULL;
  /* 0x08: kernel code */
  proc_kstack[pid].gdt[CPU_GDT_KCODE >> 3] =
  1044a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
	
}

/* initialize the kernel stack for each process */
void
seg_init_proc(int cpu_idx, int pid){
  1044a6:	56                   	push   %esi
  proc_kstack[pid].gdt[0] = SEGDESC_NULL;
  /* 0x08: kernel code */
  proc_kstack[pid].gdt[CPU_GDT_KCODE >> 3] =
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  proc_kstack[pid].gdt[CPU_GDT_KDATA >> 3] =
  1044a7:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
	
}

/* initialize the kernel stack for each process */
void
seg_init_proc(int cpu_idx, int pid){
  1044ac:	53                   	push   %ebx
  proc_kstack[pid].gdt[0] = SEGDESC_NULL;
  /* 0x08: kernel code */
  proc_kstack[pid].gdt[CPU_GDT_KCODE >> 3] =
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  proc_kstack[pid].gdt[CPU_GDT_KDATA >> 3] =
  1044ad:	31 f6                	xor    %esi,%esi
	
}

/* initialize the kernel stack for each process */
void
seg_init_proc(int cpu_idx, int pid){
  1044af:	83 ec 10             	sub    $0x10,%esp
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  proc_kstack[pid].gdt[CPU_GDT_KDATA >> 3] =
          SEGDESC32(STA_W, 0x0, 0xffffffff, 0);
  /* 0x18: user code */
  proc_kstack[pid].gdt[CPU_GDT_UCODE >> 3] =
  1044b2:	bf ff ff ff ff       	mov    $0xffffffff,%edi
	
}

/* initialize the kernel stack for each process */
void
seg_init_proc(int cpu_idx, int pid){
  1044b7:	8b 54 24 24          	mov    0x24(%esp),%edx

  /* setup GDT */
  proc_kstack[pid].gdt[0] = SEGDESC_NULL;
  1044bb:	89 d3                	mov    %edx,%ebx
  /* 0x08: kernel code */
  proc_kstack[pid].gdt[CPU_GDT_KCODE >> 3] =
  1044bd:	31 d2                	xor    %edx,%edx
/* initialize the kernel stack for each process */
void
seg_init_proc(int cpu_idx, int pid){

  /* setup GDT */
  proc_kstack[pid].gdt[0] = SEGDESC_NULL;
  1044bf:	c1 e3 0c             	shl    $0xc,%ebx
  /* 0x08: kernel code */
  proc_kstack[pid].gdt[CPU_GDT_KCODE >> 3] =
  1044c2:	66 89 83 08 60 97 00 	mov    %ax,0x976008(%ebx)
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  proc_kstack[pid].gdt[CPU_GDT_KDATA >> 3] =
          SEGDESC32(STA_W, 0x0, 0xffffffff, 0);
  /* 0x18: user code */
  proc_kstack[pid].gdt[CPU_GDT_UCODE >> 3] =
  1044c9:	31 c0                	xor    %eax,%eax
  1044cb:	66 89 83 1a 60 97 00 	mov    %ax,0x97601a(%ebx)
          SEGDESC32(STA_X | STA_R, 0x00000000, 0xffffffff, 3);
  /* 0x20: user data */
  proc_kstack[pid].gdt[CPU_GDT_UDATA >> 3] =
  1044d2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1044d7:	66 89 83 20 60 97 00 	mov    %ax,0x976020(%ebx)
  1044de:	31 c0                	xor    %eax,%eax
seg_init_proc(int cpu_idx, int pid){

  /* setup GDT */
  proc_kstack[pid].gdt[0] = SEGDESC_NULL;
  /* 0x08: kernel code */
  proc_kstack[pid].gdt[CPU_GDT_KCODE >> 3] =
  1044e0:	66 89 93 0a 60 97 00 	mov    %dx,0x97600a(%ebx)
  /* 0x20: user data */
  proc_kstack[pid].gdt[CPU_GDT_UDATA >> 3] =
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  proc_kstack[pid].tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  1044e7:	89 da                	mov    %ebx,%edx
          SEGDESC32(STA_W, 0x0, 0xffffffff, 0);
  /* 0x18: user code */
  proc_kstack[pid].gdt[CPU_GDT_UCODE >> 3] =
          SEGDESC32(STA_X | STA_R, 0x00000000, 0xffffffff, 3);
  /* 0x20: user data */
  proc_kstack[pid].gdt[CPU_GDT_UDATA >> 3] =
  1044e9:	66 89 83 22 60 97 00 	mov    %ax,0x976022(%ebx)
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  proc_kstack[pid].tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  proc_kstack[pid].tss.ts_ss0 = CPU_GDT_KDATA;
  1044f0:	b8 10 00 00 00       	mov    $0x10,%eax
  /* 0x20: user data */
  proc_kstack[pid].gdt[CPU_GDT_UDATA >> 3] =
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  proc_kstack[pid].tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  1044f5:	81 c2 00 70 97 00    	add    $0x977000,%edx
  proc_kstack[pid].tss.ts_ss0 = CPU_GDT_KDATA;
  1044fb:	66 89 83 38 60 97 00 	mov    %ax,0x976038(%ebx)
  proc_kstack[pid].tss.ts_iomb = offsetof(tss_t, ts_iopm);
  104502:	b8 68 00 00 00       	mov    $0x68,%eax
  proc_kstack[pid].gdt[0] = SEGDESC_NULL;
  /* 0x08: kernel code */
  proc_kstack[pid].gdt[CPU_GDT_KCODE >> 3] =
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  proc_kstack[pid].gdt[CPU_GDT_KDATA >> 3] =
  104507:	66 89 8b 10 60 97 00 	mov    %cx,0x976010(%ebx)
  /* 0x20: user data */
  proc_kstack[pid].gdt[CPU_GDT_UDATA >> 3] =
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  proc_kstack[pid].tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  10450e:	89 93 34 60 97 00    	mov    %edx,0x976034(%ebx)
  proc_kstack[pid].gdt[0] = SEGDESC_NULL;
  /* 0x08: kernel code */
  proc_kstack[pid].gdt[CPU_GDT_KCODE >> 3] =
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  proc_kstack[pid].gdt[CPU_GDT_KDATA >> 3] =
  104514:	66 89 b3 12 60 97 00 	mov    %si,0x976012(%ebx)
          SEGDESC32(STA_W, 0x0, 0xffffffff, 0);
  /* 0x18: user code */
  proc_kstack[pid].gdt[CPU_GDT_UCODE >> 3] =
  10451b:	66 89 bb 18 60 97 00 	mov    %di,0x976018(%ebx)
/* initialize the kernel stack for each process */
void
seg_init_proc(int cpu_idx, int pid){

  /* setup GDT */
  proc_kstack[pid].gdt[0] = SEGDESC_NULL;
  104522:	c7 83 00 60 97 00 00 	movl   $0x0,0x976000(%ebx)
  104529:	00 00 00 
  10452c:	c7 83 04 60 97 00 00 	movl   $0x0,0x976004(%ebx)
  104533:	00 00 00 
  /* 0x08: kernel code */
  proc_kstack[pid].gdt[CPU_GDT_KCODE >> 3] =
  104536:	c6 83 0c 60 97 00 00 	movb   $0x0,0x97600c(%ebx)
  10453d:	c6 83 0d 60 97 00 9a 	movb   $0x9a,0x97600d(%ebx)
  104544:	c6 83 0e 60 97 00 cf 	movb   $0xcf,0x97600e(%ebx)
  10454b:	c6 83 0f 60 97 00 00 	movb   $0x0,0x97600f(%ebx)
          SEGDESC32(STA_X | STA_R, 0x0, 0xffffffff, 0);
  /* 0x10: kernel data */
  proc_kstack[pid].gdt[CPU_GDT_KDATA >> 3] =
  104552:	c6 83 14 60 97 00 00 	movb   $0x0,0x976014(%ebx)
  104559:	c6 83 15 60 97 00 92 	movb   $0x92,0x976015(%ebx)
  104560:	c6 83 16 60 97 00 cf 	movb   $0xcf,0x976016(%ebx)
  104567:	c6 83 17 60 97 00 00 	movb   $0x0,0x976017(%ebx)
          SEGDESC32(STA_W, 0x0, 0xffffffff, 0);
  /* 0x18: user code */
  proc_kstack[pid].gdt[CPU_GDT_UCODE >> 3] =
  10456e:	c6 83 1c 60 97 00 00 	movb   $0x0,0x97601c(%ebx)
  104575:	c6 83 1d 60 97 00 fa 	movb   $0xfa,0x97601d(%ebx)
  10457c:	c6 83 1e 60 97 00 cf 	movb   $0xcf,0x97601e(%ebx)
  104583:	c6 83 1f 60 97 00 00 	movb   $0x0,0x97601f(%ebx)
          SEGDESC32(STA_X | STA_R, 0x00000000, 0xffffffff, 3);
  /* 0x20: user data */
  proc_kstack[pid].gdt[CPU_GDT_UDATA >> 3] =
  10458a:	c6 83 24 60 97 00 00 	movb   $0x0,0x976024(%ebx)
  104591:	c6 83 25 60 97 00 f2 	movb   $0xf2,0x976025(%ebx)
  104598:	c6 83 26 60 97 00 cf 	movb   $0xcf,0x976026(%ebx)
  10459f:	c6 83 27 60 97 00 00 	movb   $0x0,0x976027(%ebx)
          SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

  /* setup TSS */
  proc_kstack[pid].tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  proc_kstack[pid].tss.ts_ss0 = CPU_GDT_KDATA;
  proc_kstack[pid].tss.ts_iomb = offsetof(tss_t, ts_iopm);
  1045a6:	66 89 83 96 60 97 00 	mov    %ax,0x976096(%ebx)
  memzero (proc_kstack[pid].tss.ts_iopm, sizeof(uint8_t) * 128);
  1045ad:	8d 83 98 60 97 00    	lea    0x976098(%ebx),%eax
  1045b3:	c7 44 24 04 80 00 00 	movl   $0x80,0x4(%esp)
  1045ba:	00 
  1045bb:	89 04 24             	mov    %eax,(%esp)
  1045be:	e8 9d f3 ff ff       	call   103960 <memzero>
  proc_kstack[pid].tss.ts_iopm[128] = 0xff;

  proc_kstack[pid].gdt[CPU_GDT_TSS >> 3] =
  1045c3:	b8 eb 00 00 00       	mov    $0xeb,%eax
          SEGDESC16(STS_T32A,
  1045c8:	8d 93 30 60 97 00    	lea    0x976030(%ebx),%edx
  proc_kstack[pid].tss.ts_ss0 = CPU_GDT_KDATA;
  proc_kstack[pid].tss.ts_iomb = offsetof(tss_t, ts_iopm);
  memzero (proc_kstack[pid].tss.ts_iopm, sizeof(uint8_t) * 128);
  proc_kstack[pid].tss.ts_iopm[128] = 0xff;

  proc_kstack[pid].gdt[CPU_GDT_TSS >> 3] =
  1045ce:	66 89 83 28 60 97 00 	mov    %ax,0x976028(%ebx)
  proc_kstack[pid].gdt[CPU_GDT_TSS >> 3].sd_s = 0;

  /* other fields */
  proc_kstack[pid].magic = KSTACK_MAGIC;

  proc_kstack[pid].cpu_idx = cpu_idx;
  1045d5:	8b 44 24 20          	mov    0x20(%esp),%eax
  proc_kstack[pid].tss.ts_iomb = offsetof(tss_t, ts_iopm);
  memzero (proc_kstack[pid].tss.ts_iopm, sizeof(uint8_t) * 128);
  proc_kstack[pid].tss.ts_iopm[128] = 0xff;

  proc_kstack[pid].gdt[CPU_GDT_TSS >> 3] =
          SEGDESC16(STS_T32A,
  1045d9:	89 d6                	mov    %edx,%esi
  1045db:	c1 ee 10             	shr    $0x10,%esi
  proc_kstack[pid].tss.ts_ss0 = CPU_GDT_KDATA;
  proc_kstack[pid].tss.ts_iomb = offsetof(tss_t, ts_iopm);
  memzero (proc_kstack[pid].tss.ts_iopm, sizeof(uint8_t) * 128);
  proc_kstack[pid].tss.ts_iopm[128] = 0xff;

  proc_kstack[pid].gdt[CPU_GDT_TSS >> 3] =
  1045de:	66 89 93 2a 60 97 00 	mov    %dx,0x97602a(%ebx)
  1045e5:	89 f1                	mov    %esi,%ecx
          SEGDESC16(STS_T32A,
  1045e7:	c1 ea 18             	shr    $0x18,%edx
  /* setup TSS */
  proc_kstack[pid].tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  proc_kstack[pid].tss.ts_ss0 = CPU_GDT_KDATA;
  proc_kstack[pid].tss.ts_iomb = offsetof(tss_t, ts_iopm);
  memzero (proc_kstack[pid].tss.ts_iopm, sizeof(uint8_t) * 128);
  proc_kstack[pid].tss.ts_iopm[128] = 0xff;
  1045ea:	c6 83 18 61 97 00 ff 	movb   $0xff,0x976118(%ebx)

  proc_kstack[pid].gdt[CPU_GDT_TSS >> 3] =
  1045f1:	88 8b 2c 60 97 00    	mov    %cl,0x97602c(%ebx)
  1045f7:	c6 83 2e 60 97 00 40 	movb   $0x40,0x97602e(%ebx)
  1045fe:	88 93 2f 60 97 00    	mov    %dl,0x97602f(%ebx)
          SEGDESC16(STS_T32A,
                    (uint32_t) (&(proc_kstack[pid].tss)), sizeof(tss_t) - 1, 0);
  proc_kstack[pid].gdt[CPU_GDT_TSS >> 3].sd_s = 0;
  104604:	c6 83 2d 60 97 00 89 	movb   $0x89,0x97602d(%ebx)

  /* other fields */
  proc_kstack[pid].magic = KSTACK_MAGIC;
  10460b:	c7 83 20 61 97 00 32 	movl   $0x98765432,0x976120(%ebx)
  104612:	54 76 98 

  proc_kstack[pid].cpu_idx = cpu_idx;
  104615:	89 83 1c 61 97 00    	mov    %eax,0x97611c(%ebx)

}
  10461b:	83 c4 10             	add    $0x10,%esp
  10461e:	5b                   	pop    %ebx
  10461f:	5e                   	pop    %esi
  104620:	5f                   	pop    %edi
  104621:	c3                   	ret    
  104622:	66 90                	xchg   %ax,%ax
  104624:	66 90                	xchg   %ax,%ax
  104626:	66 90                	xchg   %ax,%ax
  104628:	66 90                	xchg   %ax,%ax
  10462a:	66 90                	xchg   %ax,%ax
  10462c:	66 90                	xchg   %ax,%ax
  10462e:	66 90                	xchg   %ax,%ax

00104630 <max>:
#include "types.h"

uint32_t
max(uint32_t a, uint32_t b)
{
  104630:	8b 44 24 04          	mov    0x4(%esp),%eax
  104634:	8b 54 24 08          	mov    0x8(%esp),%edx
	return (a > b) ? a : b;
  104638:	39 c2                	cmp    %eax,%edx
  10463a:	0f 43 c2             	cmovae %edx,%eax
}
  10463d:	c3                   	ret    
  10463e:	66 90                	xchg   %ax,%ax

00104640 <min>:

uint32_t
min(uint32_t a, uint32_t b)
{
  104640:	8b 44 24 04          	mov    0x4(%esp),%eax
  104644:	8b 54 24 08          	mov    0x8(%esp),%edx
	return (a < b) ? a : b;
  104648:	39 c2                	cmp    %eax,%edx
  10464a:	0f 46 c2             	cmovbe %edx,%eax
}
  10464d:	c3                   	ret    
  10464e:	66 90                	xchg   %ax,%ax

00104650 <rounddown>:

uint32_t
rounddown(uint32_t a, uint32_t n)
{
  104650:	8b 4c 24 04          	mov    0x4(%esp),%ecx
	return a - a % n;
  104654:	31 d2                	xor    %edx,%edx
  104656:	89 c8                	mov    %ecx,%eax
  104658:	f7 74 24 08          	divl   0x8(%esp)
  10465c:	89 c8                	mov    %ecx,%eax
  10465e:	29 d0                	sub    %edx,%eax
}
  104660:	c3                   	ret    
  104661:	eb 0d                	jmp    104670 <roundup>
  104663:	90                   	nop
  104664:	90                   	nop
  104665:	90                   	nop
  104666:	90                   	nop
  104667:	90                   	nop
  104668:	90                   	nop
  104669:	90                   	nop
  10466a:	90                   	nop
  10466b:	90                   	nop
  10466c:	90                   	nop
  10466d:	90                   	nop
  10466e:	90                   	nop
  10466f:	90                   	nop

00104670 <roundup>:

uint32_t
roundup(uint32_t a, uint32_t n)
{
  104670:	53                   	push   %ebx
  104671:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
}

uint32_t
rounddown(uint32_t a, uint32_t n)
{
	return a - a % n;
  104675:	31 d2                	xor    %edx,%edx
}

uint32_t
roundup(uint32_t a, uint32_t n)
{
	return rounddown(a+n-1, n);
  104677:	8d 4b ff             	lea    -0x1(%ebx),%ecx
  10467a:	03 4c 24 08          	add    0x8(%esp),%ecx
}

uint32_t
rounddown(uint32_t a, uint32_t n)
{
	return a - a % n;
  10467e:	89 c8                	mov    %ecx,%eax
  104680:	f7 f3                	div    %ebx
  104682:	89 c8                	mov    %ecx,%eax

uint32_t
roundup(uint32_t a, uint32_t n)
{
	return rounddown(a+n-1, n);
}
  104684:	5b                   	pop    %ebx
}

uint32_t
rounddown(uint32_t a, uint32_t n)
{
	return a - a % n;
  104685:	29 d0                	sub    %edx,%eax

uint32_t
roundup(uint32_t a, uint32_t n)
{
	return rounddown(a+n-1, n);
}
  104687:	c3                   	ret    
  104688:	66 90                	xchg   %ax,%ax
  10468a:	66 90                	xchg   %ax,%ax
  10468c:	66 90                	xchg   %ax,%ax
  10468e:	66 90                	xchg   %ax,%ax

00104690 <get_stack_base>:

gcc_inline uintptr_t
get_stack_base(void)
{
        uint32_t ebp;
        __asm __volatile("movl %%ebp,%0" : "=rm" (ebp));
  104690:	89 e8                	mov    %ebp,%eax
        return ebp;
}
  104692:	c3                   	ret    
  104693:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001046a0 <get_stack_pointer>:

gcc_inline uintptr_t
get_stack_pointer(void)
{
        uint32_t esp;
        __asm __volatile("movl %%esp,%0" : "=rm" (esp));
  1046a0:	89 e0                	mov    %esp,%eax
        return esp;
}
  1046a2:	c3                   	ret    
  1046a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1046a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001046b0 <read_ebp>:

gcc_inline uint32_t
read_ebp(void)
{
	uint32_t ebp;
	__asm __volatile("movl %%ebp,%0" : "=rm" (ebp));
  1046b0:	89 e8                	mov    %ebp,%eax
	return ebp;
}
  1046b2:	c3                   	ret    
  1046b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1046b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001046c0 <lldt>:

gcc_inline void
lldt(uint16_t sel)
{
	__asm __volatile("lldt %0" : : "r" (sel));
  1046c0:	8b 44 24 04          	mov    0x4(%esp),%eax
  1046c4:	0f 00 d0             	lldt   %ax
  1046c7:	c3                   	ret    
  1046c8:	90                   	nop
  1046c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001046d0 <cli>:
}

gcc_inline void
cli(void)
{
	__asm __volatile("cli":::"memory");
  1046d0:	fa                   	cli    
  1046d1:	c3                   	ret    
  1046d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1046d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001046e0 <sti>:
}

gcc_inline void
sti(void)
{
	__asm __volatile("sti;nop");
  1046e0:	fb                   	sti    
  1046e1:	90                   	nop
  1046e2:	c3                   	ret    
  1046e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1046e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001046f0 <rdmsr>:

gcc_inline uint64_t
rdmsr(uint32_t msr)
{
	uint64_t rv;
	__asm __volatile("rdmsr" : "=A" (rv) : "c" (msr));
  1046f0:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  1046f4:	0f 32                	rdmsr  
	return rv;
}
  1046f6:	c3                   	ret    
  1046f7:	89 f6                	mov    %esi,%esi
  1046f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104700 <wrmsr>:

gcc_inline void
wrmsr(uint32_t msr, uint64_t newval)
{
        __asm __volatile("wrmsr" : : "A" (newval), "c" (msr));
  104700:	8b 44 24 08          	mov    0x8(%esp),%eax
  104704:	8b 54 24 0c          	mov    0xc(%esp),%edx
  104708:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  10470c:	0f 30                	wrmsr  
  10470e:	c3                   	ret    
  10470f:	90                   	nop

00104710 <halt>:
}

gcc_inline void
halt(void)
{
	__asm __volatile("hlt");
  104710:	f4                   	hlt    
  104711:	c3                   	ret    
  104712:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104720 <pause>:
}

gcc_inline void
pause(void)
{
        __asm __volatile("pause":::"memory");
  104720:	f3 90                	pause  
  104722:	c3                   	ret    
  104723:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104730 <xchg>:
}

gcc_inline uint32_t
xchg(volatile uint32_t *addr, uint32_t newval)
{
  104730:	8b 54 24 04          	mov    0x4(%esp),%edx
        uint32_t result;

        __asm __volatile("lock; xchgl %0, %1" :
  104734:	8b 44 24 08          	mov    0x8(%esp),%eax
  104738:	f0 87 02             	lock xchg %eax,(%edx)
                         "+m" (*addr), "=a" (result) :
                         "1" (newval) :
                         "cc");

        return result;
}
  10473b:	c3                   	ret    
  10473c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00104740 <rdtsc>:
gcc_inline uint64_t
rdtsc(void)
{
	uint64_t rv;

	__asm __volatile("rdtsc" : "=A" (rv));
  104740:	0f 31                	rdtsc  
	return (rv);
}
  104742:	c3                   	ret    
  104743:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104750 <enable_sse>:

gcc_inline uint32_t
rcr4(void)
{
	uint32_t cr4;
	__asm __volatile("movl %%cr4,%0" : "=r" (cr4));
  104750:	0f 20 e0             	mov    %cr4,%eax
enable_sse(void)
{
	uint32_t cr0, cr4;

	cr4 = rcr4() | CR4_OSFXSR | CR4_OSXMMEXCPT;
	FENCE();
  104753:	0f ae f0             	mfence 
gcc_inline void
enable_sse(void)
{
	uint32_t cr0, cr4;

	cr4 = rcr4() | CR4_OSFXSR | CR4_OSXMMEXCPT;
  104756:	80 cc 06             	or     $0x6,%ah
}

gcc_inline void
lcr4(uint32_t val)
{
	__asm __volatile("movl %0,%%cr4" : : "r" (val));
  104759:	0f 22 e0             	mov    %eax,%cr4

gcc_inline uint32_t
rcr0(void)
{
	uint32_t val;
	__asm __volatile("movl %%cr0,%0" : "=r" (val));
  10475c:	0f 20 c0             	mov    %cr0,%eax
	cr4 = rcr4() | CR4_OSFXSR | CR4_OSXMMEXCPT;
	FENCE();
	lcr4(cr4);

	cr0 = rcr0() | CR0_MP;
	FENCE();
  10475f:	0f ae f0             	mfence 
  104762:	c3                   	ret    
  104763:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104770 <cpuid>:
}

gcc_inline void
cpuid(uint32_t info,
      uint32_t *eaxp, uint32_t *ebxp, uint32_t *ecxp, uint32_t *edxp)
{
  104770:	55                   	push   %ebp
  104771:	57                   	push   %edi
  104772:	56                   	push   %esi
  104773:	53                   	push   %ebx
  104774:	8b 44 24 14          	mov    0x14(%esp),%eax
  104778:	8b 7c 24 18          	mov    0x18(%esp),%edi
  10477c:	8b 6c 24 1c          	mov    0x1c(%esp),%ebp
  104780:	8b 74 24 24          	mov    0x24(%esp),%esi
	uint32_t eax, ebx, ecx, edx;
	__asm __volatile("cpuid"
  104784:	0f a2                	cpuid  
			 : "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
			 : "a" (info));
	if (eaxp)
  104786:	85 ff                	test   %edi,%edi
  104788:	74 02                	je     10478c <cpuid+0x1c>
		*eaxp = eax;
  10478a:	89 07                	mov    %eax,(%edi)
	if (ebxp)
  10478c:	85 ed                	test   %ebp,%ebp
  10478e:	74 03                	je     104793 <cpuid+0x23>
		*ebxp = ebx;
  104790:	89 5d 00             	mov    %ebx,0x0(%ebp)
	if (ecxp)
  104793:	8b 44 24 20          	mov    0x20(%esp),%eax
  104797:	85 c0                	test   %eax,%eax
  104799:	74 06                	je     1047a1 <cpuid+0x31>
		*ecxp = ecx;
  10479b:	8b 44 24 20          	mov    0x20(%esp),%eax
  10479f:	89 08                	mov    %ecx,(%eax)
	if (edxp)
  1047a1:	85 f6                	test   %esi,%esi
  1047a3:	74 02                	je     1047a7 <cpuid+0x37>
		*edxp = edx;
  1047a5:	89 16                	mov    %edx,(%esi)
}
  1047a7:	5b                   	pop    %ebx
  1047a8:	5e                   	pop    %esi
  1047a9:	5f                   	pop    %edi
  1047aa:	5d                   	pop    %ebp
  1047ab:	c3                   	ret    
  1047ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001047b0 <cpuid_subleaf>:

gcc_inline void
cpuid_subleaf(uint32_t leaf, uint32_t subleaf,
              uint32_t *eaxp, uint32_t *ebxp, uint32_t *ecxp, uint32_t *edxp)
{
  1047b0:	55                   	push   %ebp
  1047b1:	57                   	push   %edi
  1047b2:	56                   	push   %esi
  1047b3:	53                   	push   %ebx
  1047b4:	8b 7c 24 1c          	mov    0x1c(%esp),%edi
  1047b8:	8b 6c 24 20          	mov    0x20(%esp),%ebp
  1047bc:	8b 74 24 28          	mov    0x28(%esp),%esi
        uint32_t eax, ebx, ecx, edx;
        asm volatile("cpuid"
  1047c0:	8b 4c 24 18          	mov    0x18(%esp),%ecx
  1047c4:	8b 44 24 14          	mov    0x14(%esp),%eax
  1047c8:	0f a2                	cpuid  
                     : "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
                     : "a" (leaf), "c" (subleaf));
        if (eaxp)
  1047ca:	85 ff                	test   %edi,%edi
  1047cc:	74 02                	je     1047d0 <cpuid_subleaf+0x20>
                *eaxp = eax;
  1047ce:	89 07                	mov    %eax,(%edi)
        if (ebxp)
  1047d0:	85 ed                	test   %ebp,%ebp
  1047d2:	74 03                	je     1047d7 <cpuid_subleaf+0x27>
                *ebxp = ebx;
  1047d4:	89 5d 00             	mov    %ebx,0x0(%ebp)
        if (ecxp)
  1047d7:	8b 44 24 24          	mov    0x24(%esp),%eax
  1047db:	85 c0                	test   %eax,%eax
  1047dd:	74 06                	je     1047e5 <cpuid_subleaf+0x35>
                *ecxp = ecx;
  1047df:	8b 44 24 24          	mov    0x24(%esp),%eax
  1047e3:	89 08                	mov    %ecx,(%eax)
        if (edxp)
  1047e5:	85 f6                	test   %esi,%esi
  1047e7:	74 02                	je     1047eb <cpuid_subleaf+0x3b>
                *edxp = edx;
  1047e9:	89 16                	mov    %edx,(%esi)
}
  1047eb:	5b                   	pop    %ebx
  1047ec:	5e                   	pop    %esi
  1047ed:	5f                   	pop    %edi
  1047ee:	5d                   	pop    %ebp
  1047ef:	c3                   	ret    

001047f0 <vendor>:


gcc_inline cpu_vendor
vendor()
{
  1047f0:	53                   	push   %ebx
gcc_inline void
cpuid(uint32_t info,
      uint32_t *eaxp, uint32_t *ebxp, uint32_t *ecxp, uint32_t *edxp)
{
	uint32_t eax, ebx, ecx, edx;
	__asm __volatile("cpuid"
  1047f1:	31 c0                	xor    %eax,%eax
}


gcc_inline cpu_vendor
vendor()
{
  1047f3:	83 ec 28             	sub    $0x28,%esp
gcc_inline void
cpuid(uint32_t info,
      uint32_t *eaxp, uint32_t *ebxp, uint32_t *ecxp, uint32_t *edxp)
{
	uint32_t eax, ebx, ecx, edx;
	__asm __volatile("cpuid"
  1047f6:	0f a2                	cpuid  
{
    uint32_t eax, ebx, ecx, edx;
    char cpuvendor[13];

    cpuid(0x0, &eax, &ebx, &ecx, &edx);
    ((uint32_t *) cpuvendor)[0] = ebx;
  1047f8:	89 5c 24 13          	mov    %ebx,0x13(%esp)
    ((uint32_t *) cpuvendor)[1] = edx;
    ((uint32_t *) cpuvendor)[2] = ecx;
    cpuvendor[12] = '\0';

    if (strncmp(cpuvendor, "GenuineIntel", 20) == 0)
  1047fc:	8d 5c 24 13          	lea    0x13(%esp),%ebx
  104800:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
  104807:	00 
  104808:	c7 44 24 04 db 85 10 	movl   $0x1085db,0x4(%esp)
  10480f:	00 
  104810:	89 1c 24             	mov    %ebx,(%esp)
    uint32_t eax, ebx, ecx, edx;
    char cpuvendor[13];

    cpuid(0x0, &eax, &ebx, &ecx, &edx);
    ((uint32_t *) cpuvendor)[0] = ebx;
    ((uint32_t *) cpuvendor)[1] = edx;
  104813:	89 54 24 17          	mov    %edx,0x17(%esp)
    ((uint32_t *) cpuvendor)[2] = ecx;
  104817:	89 4c 24 1b          	mov    %ecx,0x1b(%esp)
    cpuvendor[12] = '\0';
  10481b:	c6 44 24 1f 00       	movb   $0x0,0x1f(%esp)

    if (strncmp(cpuvendor, "GenuineIntel", 20) == 0)
  104820:	e8 0b f0 ff ff       	call   103830 <strncmp>
        return INTEL;
  104825:	ba 01 00 00 00       	mov    $0x1,%edx
    ((uint32_t *) cpuvendor)[0] = ebx;
    ((uint32_t *) cpuvendor)[1] = edx;
    ((uint32_t *) cpuvendor)[2] = ecx;
    cpuvendor[12] = '\0';

    if (strncmp(cpuvendor, "GenuineIntel", 20) == 0)
  10482a:	85 c0                	test   %eax,%eax
  10482c:	74 20                	je     10484e <vendor+0x5e>
        return INTEL;
    else if (strncmp(cpuvendor, "AuthenticAMD", 20) == 0)
  10482e:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
  104835:	00 
  104836:	c7 44 24 04 e8 85 10 	movl   $0x1085e8,0x4(%esp)
  10483d:	00 
  10483e:	89 1c 24             	mov    %ebx,(%esp)
  104841:	e8 ea ef ff ff       	call   103830 <strncmp>
        return AMD;
  104846:	83 f8 01             	cmp    $0x1,%eax
  104849:	19 d2                	sbb    %edx,%edx
  10484b:	83 e2 02             	and    $0x2,%edx
    else
        return UNKNOWN_CPU;
}
  10484e:	83 c4 28             	add    $0x28,%esp
  104851:	89 d0                	mov    %edx,%eax
  104853:	5b                   	pop    %ebx
  104854:	c3                   	ret    
  104855:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104860 <rcr3>:

gcc_inline uint32_t
rcr3(void)
{
    uint32_t val;
    __asm __volatile("movl %%cr3,%0" : "=r" (val));
  104860:	0f 20 d8             	mov    %cr3,%eax
    return val;
}
  104863:	c3                   	ret    
  104864:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10486a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00104870 <outl>:

gcc_inline void
outl(int port, uint32_t data)
{
	__asm __volatile("outl %0,%w1" : : "a" (data), "d" (port));
  104870:	8b 44 24 08          	mov    0x8(%esp),%eax
  104874:	8b 54 24 04          	mov    0x4(%esp),%edx
  104878:	ef                   	out    %eax,(%dx)
  104879:	c3                   	ret    
  10487a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104880 <inl>:

gcc_inline uint32_t
inl(int port)
{
	uint32_t data;
	__asm __volatile("inl %w1,%0" : "=a" (data) : "d" (port));
  104880:	8b 54 24 04          	mov    0x4(%esp),%edx
  104884:	ed                   	in     (%dx),%eax
	return data;
}
  104885:	c3                   	ret    
  104886:	8d 76 00             	lea    0x0(%esi),%esi
  104889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104890 <smp_wmb>:

gcc_inline void
smp_wmb(void)
{
	__asm __volatile("":::"memory");
  104890:	c3                   	ret    
  104891:	eb 0d                	jmp    1048a0 <ltr>
  104893:	90                   	nop
  104894:	90                   	nop
  104895:	90                   	nop
  104896:	90                   	nop
  104897:	90                   	nop
  104898:	90                   	nop
  104899:	90                   	nop
  10489a:	90                   	nop
  10489b:	90                   	nop
  10489c:	90                   	nop
  10489d:	90                   	nop
  10489e:	90                   	nop
  10489f:	90                   	nop

001048a0 <ltr>:


gcc_inline void
ltr(uint16_t sel)
{
	__asm __volatile("ltr %0" : : "r" (sel));
  1048a0:	8b 44 24 04          	mov    0x4(%esp),%eax
  1048a4:	0f 00 d8             	ltr    %ax
  1048a7:	c3                   	ret    
  1048a8:	90                   	nop
  1048a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001048b0 <lcr0>:
}

gcc_inline void
lcr0(uint32_t val)
{
	__asm __volatile("movl %0,%%cr0" : : "r" (val));
  1048b0:	8b 44 24 04          	mov    0x4(%esp),%eax
  1048b4:	0f 22 c0             	mov    %eax,%cr0
  1048b7:	c3                   	ret    
  1048b8:	90                   	nop
  1048b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001048c0 <rcr0>:

gcc_inline uint32_t
rcr0(void)
{
	uint32_t val;
	__asm __volatile("movl %%cr0,%0" : "=r" (val));
  1048c0:	0f 20 c0             	mov    %cr0,%eax
	return val;
}
  1048c3:	c3                   	ret    
  1048c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1048ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001048d0 <rcr2>:

gcc_inline uint32_t
rcr2(void)
{
	uint32_t val;
	__asm __volatile("movl %%cr2,%0" : "=r" (val));
  1048d0:	0f 20 d0             	mov    %cr2,%eax
	return val;
}
  1048d3:	c3                   	ret    
  1048d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1048da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001048e0 <lcr3>:

gcc_inline void
lcr3(uint32_t val)
{
	__asm __volatile("movl %0,%%cr3" : : "r" (val));
  1048e0:	8b 44 24 04          	mov    0x4(%esp),%eax
  1048e4:	0f 22 d8             	mov    %eax,%cr3
  1048e7:	c3                   	ret    
  1048e8:	90                   	nop
  1048e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001048f0 <lcr4>:
}

gcc_inline void
lcr4(uint32_t val)
{
	__asm __volatile("movl %0,%%cr4" : : "r" (val));
  1048f0:	8b 44 24 04          	mov    0x4(%esp),%eax
  1048f4:	0f 22 e0             	mov    %eax,%cr4
  1048f7:	c3                   	ret    
  1048f8:	90                   	nop
  1048f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104900 <rcr4>:

gcc_inline uint32_t
rcr4(void)
{
	uint32_t cr4;
	__asm __volatile("movl %%cr4,%0" : "=r" (cr4));
  104900:	0f 20 e0             	mov    %cr4,%eax
	return cr4;
}
  104903:	c3                   	ret    
  104904:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10490a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00104910 <inb>:

gcc_inline uint8_t
inb(int port)
{
	uint8_t data;
	__asm __volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  104910:	8b 54 24 04          	mov    0x4(%esp),%edx
  104914:	ec                   	in     (%dx),%al
	return data;
}
  104915:	c3                   	ret    
  104916:	8d 76 00             	lea    0x0(%esi),%esi
  104919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104920 <insl>:

gcc_inline void
insl(int port, void *addr, int cnt)
{
  104920:	57                   	push   %edi
	__asm __volatile("cld\n\trepne\n\tinsl"                 :
  104921:	8b 7c 24 0c          	mov    0xc(%esp),%edi
  104925:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  104929:	8b 54 24 08          	mov    0x8(%esp),%edx
  10492d:	fc                   	cld    
  10492e:	f2 6d                	repnz insl (%dx),%es:(%edi)
			 "=D" (addr), "=c" (cnt)                :
			 "d" (port), "0" (addr), "1" (cnt)      :
			 "memory", "cc");
}
  104930:	5f                   	pop    %edi
  104931:	c3                   	ret    
  104932:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104940 <outb>:

gcc_inline void
outb(int port, uint8_t data)
{
	__asm __volatile("outb %0,%w1" : : "a" (data), "d" (port));
  104940:	8b 44 24 08          	mov    0x8(%esp),%eax
  104944:	8b 54 24 04          	mov    0x4(%esp),%edx
  104948:	ee                   	out    %al,(%dx)
  104949:	c3                   	ret    
  10494a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104950 <outsw>:
}

gcc_inline void
outsw(int port, const void *addr, int cnt)
{
  104950:	56                   	push   %esi
	__asm __volatile("cld\n\trepne\n\toutsw"                :
  104951:	8b 74 24 0c          	mov    0xc(%esp),%esi
  104955:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  104959:	8b 54 24 08          	mov    0x8(%esp),%edx
  10495d:	fc                   	cld    
  10495e:	f2 66 6f             	repnz outsw %ds:(%esi),(%dx)
			 "=S" (addr), "=c" (cnt)                :
			 "d" (port), "0" (addr), "1" (cnt)      :
			 "cc");
}
  104961:	5e                   	pop    %esi
  104962:	c3                   	ret    
  104963:	66 90                	xchg   %ax,%ax
  104965:	66 90                	xchg   %ax,%ax
  104967:	66 90                	xchg   %ax,%ax
  104969:	66 90                	xchg   %ax,%ax
  10496b:	66 90                	xchg   %ax,%ax
  10496d:	66 90                	xchg   %ax,%ax
  10496f:	90                   	nop

00104970 <mon_help>:

/***** Implementations of basic kernel monitor commands *****/

int
mon_help (int argc, char **argv, struct Trapframe *tf)
{
  104970:	83 ec 1c             	sub    $0x1c,%esp
	int i;

	for (i = 0; i < NCOMMANDS; i++)
		dprintf("%s - %s\n", commands[i].name, commands[i].desc);
  104973:	c7 44 24 08 cc 8f 10 	movl   $0x108fcc,0x8(%esp)
  10497a:	00 
  10497b:	c7 44 24 04 ea 8f 10 	movl   $0x108fea,0x4(%esp)
  104982:	00 
  104983:	c7 04 24 ef 8f 10 00 	movl   $0x108fef,(%esp)
  10498a:	e8 01 f3 ff ff       	call   103c90 <dprintf>
  10498f:	c7 44 24 08 94 90 10 	movl   $0x109094,0x8(%esp)
  104996:	00 
  104997:	c7 44 24 04 f8 8f 10 	movl   $0x108ff8,0x4(%esp)
  10499e:	00 
  10499f:	c7 04 24 ef 8f 10 00 	movl   $0x108fef,(%esp)
  1049a6:	e8 e5 f2 ff ff       	call   103c90 <dprintf>
	return 0;
}
  1049ab:	31 c0                	xor    %eax,%eax
  1049ad:	83 c4 1c             	add    $0x1c,%esp
  1049b0:	c3                   	ret    
  1049b1:	eb 0d                	jmp    1049c0 <mon_kerninfo>
  1049b3:	90                   	nop
  1049b4:	90                   	nop
  1049b5:	90                   	nop
  1049b6:	90                   	nop
  1049b7:	90                   	nop
  1049b8:	90                   	nop
  1049b9:	90                   	nop
  1049ba:	90                   	nop
  1049bb:	90                   	nop
  1049bc:	90                   	nop
  1049bd:	90                   	nop
  1049be:	90                   	nop
  1049bf:	90                   	nop

001049c0 <mon_kerninfo>:

int
mon_kerninfo (int argc, char **argv, struct Trapframe *tf)
{
  1049c0:	83 ec 1c             	sub    $0x1c,%esp
	extern uint8_t start[], etext[], edata[], end[];

	dprintf("Special kernel symbols:\n");
  1049c3:	c7 04 24 01 90 10 00 	movl   $0x109001,(%esp)
  1049ca:	e8 c1 f2 ff ff       	call   103c90 <dprintf>
	dprintf("  start  %08x\n", start);
  1049cf:	c7 44 24 04 e4 58 10 	movl   $0x1058e4,0x4(%esp)
  1049d6:	00 
  1049d7:	c7 04 24 1a 90 10 00 	movl   $0x10901a,(%esp)
  1049de:	e8 ad f2 ff ff       	call   103c90 <dprintf>
	dprintf("  etext  %08x\n", etext);
  1049e3:	c7 44 24 04 f7 7b 10 	movl   $0x107bf7,0x4(%esp)
  1049ea:	00 
  1049eb:	c7 04 24 29 90 10 00 	movl   $0x109029,(%esp)
  1049f2:	e8 99 f2 ff ff       	call   103c90 <dprintf>
	dprintf("  edata  %08x\n", edata);
  1049f7:	c7 44 24 04 c6 b4 12 	movl   $0x12b4c6,0x4(%esp)
  1049fe:	00 
  1049ff:	c7 04 24 38 90 10 00 	movl   $0x109038,(%esp)
  104a06:	e8 85 f2 ff ff       	call   103c90 <dprintf>
	dprintf("  end    %08x\n", end);
  104a0b:	c7 44 24 04 60 ba df 	movl   $0xdfba60,0x4(%esp)
  104a12:	00 
  104a13:	c7 04 24 47 90 10 00 	movl   $0x109047,(%esp)
  104a1a:	e8 71 f2 ff ff       	call   103c90 <dprintf>
	dprintf("Kernel executable memory footprint: %dKB\n",
		ROUNDUP(end - start, 1024) / 1024);
  104a1f:	ba 60 ba df 00       	mov    $0xdfba60,%edx
  104a24:	81 ea e5 54 10 00    	sub    $0x1054e5,%edx
  104a2a:	89 d1                	mov    %edx,%ecx
  104a2c:	c1 f9 1f             	sar    $0x1f,%ecx
  104a2f:	c1 e9 16             	shr    $0x16,%ecx
  104a32:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
  104a35:	25 ff 03 00 00       	and    $0x3ff,%eax
  104a3a:	29 c8                	sub    %ecx,%eax
  104a3c:	29 c2                	sub    %eax,%edx
	dprintf("Special kernel symbols:\n");
	dprintf("  start  %08x\n", start);
	dprintf("  etext  %08x\n", etext);
	dprintf("  edata  %08x\n", edata);
	dprintf("  end    %08x\n", end);
	dprintf("Kernel executable memory footprint: %dKB\n",
  104a3e:	85 d2                	test   %edx,%edx
  104a40:	8d 82 ff 03 00 00    	lea    0x3ff(%edx),%eax
  104a46:	0f 48 d0             	cmovs  %eax,%edx
  104a49:	c1 fa 0a             	sar    $0xa,%edx
  104a4c:	89 54 24 04          	mov    %edx,0x4(%esp)
  104a50:	c7 04 24 bc 90 10 00 	movl   $0x1090bc,(%esp)
  104a57:	e8 34 f2 ff ff       	call   103c90 <dprintf>
		ROUNDUP(end - start, 1024) / 1024);
	return 0;
}
  104a5c:	31 c0                	xor    %eax,%eax
  104a5e:	83 c4 1c             	add    $0x1c,%esp
  104a61:	c3                   	ret    
  104a62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104a70 <monitor>:
	return 0;
}

void
monitor (struct Trapframe *tf)
{
  104a70:	55                   	push   %ebp
  104a71:	57                   	push   %edi
  104a72:	56                   	push   %esi
  104a73:	53                   	push   %ebx
  104a74:	83 ec 5c             	sub    $0x5c,%esp
	char *buf;

	dprintf("\n****************************************\n\n");
  104a77:	c7 04 24 e8 90 10 00 	movl   $0x1090e8,(%esp)
  104a7e:	8d 7c 24 10          	lea    0x10(%esp),%edi
  104a82:	e8 09 f2 ff ff       	call   103c90 <dprintf>
	dprintf("Welcome to the mCertiKOS kernel monitor!\n");
  104a87:	c7 04 24 14 91 10 00 	movl   $0x109114,(%esp)
  104a8e:	e8 fd f1 ff ff       	call   103c90 <dprintf>
	dprintf("\n****************************************\n\n");
  104a93:	c7 04 24 e8 90 10 00 	movl   $0x1090e8,(%esp)
  104a9a:	e8 f1 f1 ff ff       	call   103c90 <dprintf>
	dprintf("Type 'help' for a list of commands.\n");
  104a9f:	c7 04 24 40 91 10 00 	movl   $0x109140,(%esp)
  104aa6:	e8 e5 f1 ff ff       	call   103c90 <dprintf>
  104aab:	90                   	nop
  104aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

	while (1)
	{
		buf = (char *) readline ("$> ");
  104ab0:	c7 04 24 56 90 10 00 	movl   $0x109056,(%esp)
  104ab7:	e8 b4 b9 ff ff       	call   100470 <readline>
		if (buf != NULL)
  104abc:	85 c0                	test   %eax,%eax
	dprintf("\n****************************************\n\n");
	dprintf("Type 'help' for a list of commands.\n");

	while (1)
	{
		buf = (char *) readline ("$> ");
  104abe:	89 c3                	mov    %eax,%ebx
		if (buf != NULL)
  104ac0:	74 ee                	je     104ab0 <monitor+0x40>
	char *argv[MAXARGS];
	int i;

	// Parse the command buffer into whitespace-separated arguments
	argc = 0;
	argv[argc] = 0;
  104ac2:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  104ac9:	00 
  104aca:	0f be 00             	movsbl (%eax),%eax
	int argc;
	char *argv[MAXARGS];
	int i;

	// Parse the command buffer into whitespace-separated arguments
	argc = 0;
  104acd:	31 ed                	xor    %ebp,%ebp
  104acf:	90                   	nop
	argv[argc] = 0;
	while (1)
	{
		// gobble whitespace
		while (*buf && strchr (WHITESPACE, *buf))
  104ad0:	84 c0                	test   %al,%al
  104ad2:	75 5c                	jne    104b30 <monitor+0xc0>
			buf++;
	}
	argv[argc] = 0;

	// Lookup and invoke the command
	if (argc == 0)
  104ad4:	85 ed                	test   %ebp,%ebp
		}
		argv[argc++] = buf;
		while (*buf && !strchr (WHITESPACE, *buf))
			buf++;
	}
	argv[argc] = 0;
  104ad6:	c7 44 ac 10 00 00 00 	movl   $0x0,0x10(%esp,%ebp,4)
  104add:	00 

	// Lookup and invoke the command
	if (argc == 0)
  104ade:	74 d0                	je     104ab0 <monitor+0x40>
		return 0;
	for (i = 0; i < NCOMMANDS; i++)
	{
		if (strcmp (argv[0], commands[i].name) == 0)
  104ae0:	8b 44 24 10          	mov    0x10(%esp),%eax
  104ae4:	c7 44 24 04 ea 8f 10 	movl   $0x108fea,0x4(%esp)
  104aeb:	00 
  104aec:	89 04 24             	mov    %eax,(%esp)
  104aef:	e8 ec ed ff ff       	call   1038e0 <strcmp>
  104af4:	85 c0                	test   %eax,%eax
  104af6:	0f 84 b9 00 00 00    	je     104bb5 <monitor+0x145>
  104afc:	8b 44 24 10          	mov    0x10(%esp),%eax
  104b00:	c7 44 24 04 f8 8f 10 	movl   $0x108ff8,0x4(%esp)
  104b07:	00 
  104b08:	89 04 24             	mov    %eax,(%esp)
  104b0b:	e8 d0 ed ff ff       	call   1038e0 <strcmp>
  104b10:	85 c0                	test   %eax,%eax
  104b12:	0f 84 ca 00 00 00    	je     104be2 <monitor+0x172>
			return commands[i].func (argc, argv, tf);
	}
	dprintf("Unknown command '%s'\n", argv[0]);
  104b18:	8b 44 24 10          	mov    0x10(%esp),%eax
  104b1c:	c7 04 24 7c 90 10 00 	movl   $0x10907c,(%esp)
  104b23:	89 44 24 04          	mov    %eax,0x4(%esp)
  104b27:	e8 64 f1 ff ff       	call   103c90 <dprintf>
  104b2c:	eb 82                	jmp    104ab0 <monitor+0x40>
  104b2e:	66 90                	xchg   %ax,%ax
	argc = 0;
	argv[argc] = 0;
	while (1)
	{
		// gobble whitespace
		while (*buf && strchr (WHITESPACE, *buf))
  104b30:	89 44 24 04          	mov    %eax,0x4(%esp)
  104b34:	c7 04 24 5a 90 10 00 	movl   $0x10905a,(%esp)
  104b3b:	e8 f0 ed ff ff       	call   103930 <strchr>
  104b40:	85 c0                	test   %eax,%eax
  104b42:	75 44                	jne    104b88 <monitor+0x118>
			*buf++ = 0;
		if (*buf == 0)
  104b44:	80 3b 00             	cmpb   $0x0,(%ebx)
  104b47:	74 8b                	je     104ad4 <monitor+0x64>
			break;

		// save and scan past next arg
		if (argc == MAXARGS - 1)
  104b49:	83 fd 0f             	cmp    $0xf,%ebp
  104b4c:	74 4e                	je     104b9c <monitor+0x12c>
		{
			dprintf("Too many arguments (max %d)\n", MAXARGS);
			return 0;
		}
		argv[argc++] = buf;
  104b4e:	89 5c ac 10          	mov    %ebx,0x10(%esp,%ebp,4)
		while (*buf && !strchr (WHITESPACE, *buf))
  104b52:	0f be 03             	movsbl (%ebx),%eax
		if (argc == MAXARGS - 1)
		{
			dprintf("Too many arguments (max %d)\n", MAXARGS);
			return 0;
		}
		argv[argc++] = buf;
  104b55:	8d 75 01             	lea    0x1(%ebp),%esi
		while (*buf && !strchr (WHITESPACE, *buf))
  104b58:	84 c0                	test   %al,%al
  104b5a:	75 0e                	jne    104b6a <monitor+0xfa>
  104b5c:	eb 23                	jmp    104b81 <monitor+0x111>
  104b5e:	66 90                	xchg   %ax,%ax
			buf++;
  104b60:	83 c3 01             	add    $0x1,%ebx
		{
			dprintf("Too many arguments (max %d)\n", MAXARGS);
			return 0;
		}
		argv[argc++] = buf;
		while (*buf && !strchr (WHITESPACE, *buf))
  104b63:	0f be 03             	movsbl (%ebx),%eax
  104b66:	84 c0                	test   %al,%al
  104b68:	74 17                	je     104b81 <monitor+0x111>
  104b6a:	89 44 24 04          	mov    %eax,0x4(%esp)
  104b6e:	c7 04 24 5a 90 10 00 	movl   $0x10905a,(%esp)
  104b75:	e8 b6 ed ff ff       	call   103930 <strchr>
  104b7a:	85 c0                	test   %eax,%eax
  104b7c:	74 e2                	je     104b60 <monitor+0xf0>
  104b7e:	0f be 03             	movsbl (%ebx),%eax
	argv[argc] = 0;
	while (1)
	{
		// gobble whitespace
		while (*buf && strchr (WHITESPACE, *buf))
			*buf++ = 0;
  104b81:	89 f5                	mov    %esi,%ebp
  104b83:	e9 48 ff ff ff       	jmp    104ad0 <monitor+0x60>
  104b88:	89 ee                	mov    %ebp,%esi
  104b8a:	0f be 43 01          	movsbl 0x1(%ebx),%eax
  104b8e:	83 c3 01             	add    $0x1,%ebx
  104b91:	c6 43 ff 00          	movb   $0x0,-0x1(%ebx)
  104b95:	89 f5                	mov    %esi,%ebp
  104b97:	e9 34 ff ff ff       	jmp    104ad0 <monitor+0x60>
			break;

		// save and scan past next arg
		if (argc == MAXARGS - 1)
		{
			dprintf("Too many arguments (max %d)\n", MAXARGS);
  104b9c:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
  104ba3:	00 
  104ba4:	c7 04 24 5f 90 10 00 	movl   $0x10905f,(%esp)
  104bab:	e8 e0 f0 ff ff       	call   103c90 <dprintf>
  104bb0:	e9 fb fe ff ff       	jmp    104ab0 <monitor+0x40>
	// Lookup and invoke the command
	if (argc == 0)
		return 0;
	for (i = 0; i < NCOMMANDS; i++)
	{
		if (strcmp (argv[0], commands[i].name) == 0)
  104bb5:	31 c0                	xor    %eax,%eax
			return commands[i].func (argc, argv, tf);
  104bb7:	8b 4c 24 70          	mov    0x70(%esp),%ecx
  104bbb:	8d 14 00             	lea    (%eax,%eax,1),%edx
  104bbe:	01 d0                	add    %edx,%eax
  104bc0:	89 7c 24 04          	mov    %edi,0x4(%esp)
  104bc4:	89 2c 24             	mov    %ebp,(%esp)
  104bc7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  104bcb:	ff 14 85 70 91 10 00 	call   *0x109170(,%eax,4)

	while (1)
	{
		buf = (char *) readline ("$> ");
		if (buf != NULL)
			if (runcmd (buf, tf) < 0)
  104bd2:	85 c0                	test   %eax,%eax
  104bd4:	0f 89 d6 fe ff ff    	jns    104ab0 <monitor+0x40>
				break;
	}
}
  104bda:	83 c4 5c             	add    $0x5c,%esp
  104bdd:	5b                   	pop    %ebx
  104bde:	5e                   	pop    %esi
  104bdf:	5f                   	pop    %edi
  104be0:	5d                   	pop    %ebp
  104be1:	c3                   	ret    
	argv[argc] = 0;

	// Lookup and invoke the command
	if (argc == 0)
		return 0;
	for (i = 0; i < NCOMMANDS; i++)
  104be2:	b0 01                	mov    $0x1,%al
  104be4:	eb d1                	jmp    104bb7 <monitor+0x147>
  104be6:	66 90                	xchg   %ax,%ax
  104be8:	66 90                	xchg   %ax,%ax
  104bea:	66 90                	xchg   %ax,%ax
  104bec:	66 90                	xchg   %ax,%ax
  104bee:	66 90                	xchg   %ax,%ax

00104bf0 <pt_copyin>:
extern void alloc_page(unsigned int pid, unsigned int vaddr, unsigned int perm);
extern unsigned int get_ptbl_entry_by_va(unsigned int pid, unsigned int vaddr);

size_t
pt_copyin(uint32_t pmap_id, uintptr_t uva, void *kva, size_t len)
{
  104bf0:	55                   	push   %ebp
	if (!(VM_USERLO <= uva && uva + len <= VM_USERHI))
		return 0;
  104bf1:	31 c0                	xor    %eax,%eax
extern void alloc_page(unsigned int pid, unsigned int vaddr, unsigned int perm);
extern unsigned int get_ptbl_entry_by_va(unsigned int pid, unsigned int vaddr);

size_t
pt_copyin(uint32_t pmap_id, uintptr_t uva, void *kva, size_t len)
{
  104bf3:	57                   	push   %edi
  104bf4:	56                   	push   %esi
  104bf5:	53                   	push   %ebx
  104bf6:	83 ec 1c             	sub    $0x1c,%esp
  104bf9:	8b 74 24 34          	mov    0x34(%esp),%esi
  104bfd:	8b 7c 24 38          	mov    0x38(%esp),%edi
  104c01:	8b 5c 24 3c          	mov    0x3c(%esp),%ebx
	if (!(VM_USERLO <= uva && uva + len <= VM_USERHI))
  104c05:	81 fe ff ff ff 3f    	cmp    $0x3fffffff,%esi
  104c0b:	0f 86 bb 00 00 00    	jbe    104ccc <pt_copyin+0xdc>
  104c11:	8d 14 1e             	lea    (%esi,%ebx,1),%edx
  104c14:	81 fa 00 00 00 f0    	cmp    $0xf0000000,%edx
  104c1a:	0f 87 ac 00 00 00    	ja     104ccc <pt_copyin+0xdc>
		return 0;

	if ((uintptr_t) kva + len > VM_USERHI)
  104c20:	8d 14 1f             	lea    (%edi,%ebx,1),%edx
  104c23:	81 fa 00 00 00 f0    	cmp    $0xf0000000,%edx
  104c29:	0f 87 9d 00 00 00    	ja     104ccc <pt_copyin+0xdc>
		return 0;

	size_t copied = 0;

	while (len) {
  104c2f:	85 db                	test   %ebx,%ebx
  104c31:	0f 84 95 00 00 00    	je     104ccc <pt_copyin+0xdc>
  104c37:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  104c3e:	00 
  104c3f:	eb 42                	jmp    104c83 <pt_copyin+0x93>
  104c41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		if ((uva_pa & PTE_P) == 0) {
			alloc_page(pmap_id, uva, PTE_P | PTE_U | PTE_W);
			uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
		}

		uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);
  104c48:	89 f2                	mov    %esi,%edx

		size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
			len : PAGESIZE - uva_pa % PAGESIZE;
  104c4a:	b9 00 10 00 00       	mov    $0x1000,%ecx
		if ((uva_pa & PTE_P) == 0) {
			alloc_page(pmap_id, uva, PTE_P | PTE_U | PTE_W);
			uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
		}

		uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);
  104c4f:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
  104c55:	25 00 f0 ff ff       	and    $0xfffff000,%eax

		size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
			len : PAGESIZE - uva_pa % PAGESIZE;
  104c5a:	29 d1                	sub    %edx,%ecx
  104c5c:	01 d0                	add    %edx,%eax
			uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
		}

		uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);

		size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  104c5e:	39 d9                	cmp    %ebx,%ecx
			len : PAGESIZE - uva_pa % PAGESIZE;
  104c60:	89 ca                	mov    %ecx,%edx
			uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
		}

		uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);

		size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  104c62:	0f 47 d3             	cmova  %ebx,%edx
  104c65:	89 d5                	mov    %edx,%ebp
			len : PAGESIZE - uva_pa % PAGESIZE;

		memcpy(kva, (void *) uva_pa, size);
  104c67:	89 3c 24             	mov    %edi,(%esp)

		len -= size;
		uva += size;
  104c6a:	01 ee                	add    %ebp,%esi
		kva += size;
  104c6c:	01 ef                	add    %ebp,%edi
		uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);

		size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
			len : PAGESIZE - uva_pa % PAGESIZE;

		memcpy(kva, (void *) uva_pa, size);
  104c6e:	89 54 24 08          	mov    %edx,0x8(%esp)
  104c72:	89 44 24 04          	mov    %eax,0x4(%esp)
  104c76:	e8 a5 eb ff ff       	call   103820 <memcpy>

		len -= size;
		uva += size;
		kva += size;
		copied += size;
  104c7b:	01 6c 24 0c          	add    %ebp,0xc(%esp)
	if ((uintptr_t) kva + len > VM_USERHI)
		return 0;

	size_t copied = 0;

	while (len) {
  104c7f:	29 eb                	sub    %ebp,%ebx
  104c81:	74 45                	je     104cc8 <pt_copyin+0xd8>
		uintptr_t uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
  104c83:	8b 44 24 30          	mov    0x30(%esp),%eax
  104c87:	89 74 24 04          	mov    %esi,0x4(%esp)
  104c8b:	89 04 24             	mov    %eax,(%esp)
  104c8e:	e8 3d 13 00 00       	call   105fd0 <get_ptbl_entry_by_va>

		if ((uva_pa & PTE_P) == 0) {
  104c93:	a8 01                	test   $0x1,%al
  104c95:	75 b1                	jne    104c48 <pt_copyin+0x58>
			alloc_page(pmap_id, uva, PTE_P | PTE_U | PTE_W);
  104c97:	8b 44 24 30          	mov    0x30(%esp),%eax
  104c9b:	c7 44 24 08 07 00 00 	movl   $0x7,0x8(%esp)
  104ca2:	00 
  104ca3:	89 74 24 04          	mov    %esi,0x4(%esp)
  104ca7:	89 04 24             	mov    %eax,(%esp)
  104caa:	e8 01 17 00 00       	call   1063b0 <alloc_page>
			uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
  104caf:	8b 44 24 30          	mov    0x30(%esp),%eax
  104cb3:	89 74 24 04          	mov    %esi,0x4(%esp)
  104cb7:	89 04 24             	mov    %eax,(%esp)
  104cba:	e8 11 13 00 00       	call   105fd0 <get_ptbl_entry_by_va>
  104cbf:	eb 87                	jmp    104c48 <pt_copyin+0x58>
  104cc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		memcpy(kva, (void *) uva_pa, size);

		len -= size;
		uva += size;
		kva += size;
		copied += size;
  104cc8:	8b 44 24 0c          	mov    0xc(%esp),%eax
	}

	return copied;
}
  104ccc:	83 c4 1c             	add    $0x1c,%esp
  104ccf:	5b                   	pop    %ebx
  104cd0:	5e                   	pop    %esi
  104cd1:	5f                   	pop    %edi
  104cd2:	5d                   	pop    %ebp
  104cd3:	c3                   	ret    
  104cd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104cda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00104ce0 <pt_copyout>:

size_t
pt_copyout(void *kva, uint32_t pmap_id, uintptr_t uva, size_t len)
{
  104ce0:	55                   	push   %ebp
	if (!(VM_USERLO <= uva && uva + len <= VM_USERHI))
		return 0;
  104ce1:	31 c0                	xor    %eax,%eax
	return copied;
}

size_t
pt_copyout(void *kva, uint32_t pmap_id, uintptr_t uva, size_t len)
{
  104ce3:	57                   	push   %edi
  104ce4:	56                   	push   %esi
  104ce5:	53                   	push   %ebx
  104ce6:	83 ec 1c             	sub    $0x1c,%esp
  104ce9:	8b 74 24 38          	mov    0x38(%esp),%esi
  104ced:	8b 7c 24 30          	mov    0x30(%esp),%edi
  104cf1:	8b 5c 24 3c          	mov    0x3c(%esp),%ebx
	if (!(VM_USERLO <= uva && uva + len <= VM_USERHI))
  104cf5:	81 fe ff ff ff 3f    	cmp    $0x3fffffff,%esi
  104cfb:	0f 86 bb 00 00 00    	jbe    104dbc <pt_copyout+0xdc>
  104d01:	8d 14 1e             	lea    (%esi,%ebx,1),%edx
  104d04:	81 fa 00 00 00 f0    	cmp    $0xf0000000,%edx
  104d0a:	0f 87 ac 00 00 00    	ja     104dbc <pt_copyout+0xdc>
		return 0;

	if ((uintptr_t) kva + len > VM_USERHI)
  104d10:	8d 14 1f             	lea    (%edi,%ebx,1),%edx
  104d13:	81 fa 00 00 00 f0    	cmp    $0xf0000000,%edx
  104d19:	0f 87 9d 00 00 00    	ja     104dbc <pt_copyout+0xdc>
		return 0;

	size_t copied = 0;

	while (len) {
  104d1f:	85 db                	test   %ebx,%ebx
  104d21:	0f 84 95 00 00 00    	je     104dbc <pt_copyout+0xdc>
  104d27:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  104d2e:	00 
  104d2f:	eb 42                	jmp    104d73 <pt_copyout+0x93>
  104d31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		if ((uva_pa & PTE_P) == 0) {
			alloc_page(pmap_id, uva, PTE_P | PTE_U | PTE_W);
			uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
		}

		uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);
  104d38:	89 f2                	mov    %esi,%edx

		size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
			len : PAGESIZE - uva_pa % PAGESIZE;
  104d3a:	b9 00 10 00 00       	mov    $0x1000,%ecx
		if ((uva_pa & PTE_P) == 0) {
			alloc_page(pmap_id, uva, PTE_P | PTE_U | PTE_W);
			uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
		}

		uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);
  104d3f:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
  104d45:	25 00 f0 ff ff       	and    $0xfffff000,%eax

		size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
			len : PAGESIZE - uva_pa % PAGESIZE;
  104d4a:	29 d1                	sub    %edx,%ecx
  104d4c:	01 d0                	add    %edx,%eax
			uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
		}

		uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);

		size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  104d4e:	39 d9                	cmp    %ebx,%ecx
			len : PAGESIZE - uva_pa % PAGESIZE;
  104d50:	89 ca                	mov    %ecx,%edx
			uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
		}

		uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);

		size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  104d52:	0f 47 d3             	cmova  %ebx,%edx
  104d55:	89 d5                	mov    %edx,%ebp
			len : PAGESIZE - uva_pa % PAGESIZE;

		memcpy((void *) uva_pa, kva, size);
  104d57:	89 7c 24 04          	mov    %edi,0x4(%esp)

		len -= size;
		uva += size;
  104d5b:	01 ee                	add    %ebp,%esi
		kva += size;
  104d5d:	01 ef                	add    %ebp,%edi
		uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);

		size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
			len : PAGESIZE - uva_pa % PAGESIZE;

		memcpy((void *) uva_pa, kva, size);
  104d5f:	89 54 24 08          	mov    %edx,0x8(%esp)
  104d63:	89 04 24             	mov    %eax,(%esp)
  104d66:	e8 b5 ea ff ff       	call   103820 <memcpy>

		len -= size;
		uva += size;
		kva += size;
		copied += size;
  104d6b:	01 6c 24 0c          	add    %ebp,0xc(%esp)
	if ((uintptr_t) kva + len > VM_USERHI)
		return 0;

	size_t copied = 0;

	while (len) {
  104d6f:	29 eb                	sub    %ebp,%ebx
  104d71:	74 45                	je     104db8 <pt_copyout+0xd8>
		uintptr_t uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
  104d73:	8b 44 24 34          	mov    0x34(%esp),%eax
  104d77:	89 74 24 04          	mov    %esi,0x4(%esp)
  104d7b:	89 04 24             	mov    %eax,(%esp)
  104d7e:	e8 4d 12 00 00       	call   105fd0 <get_ptbl_entry_by_va>

		if ((uva_pa & PTE_P) == 0) {
  104d83:	a8 01                	test   $0x1,%al
  104d85:	75 b1                	jne    104d38 <pt_copyout+0x58>
			alloc_page(pmap_id, uva, PTE_P | PTE_U | PTE_W);
  104d87:	8b 44 24 34          	mov    0x34(%esp),%eax
  104d8b:	c7 44 24 08 07 00 00 	movl   $0x7,0x8(%esp)
  104d92:	00 
  104d93:	89 74 24 04          	mov    %esi,0x4(%esp)
  104d97:	89 04 24             	mov    %eax,(%esp)
  104d9a:	e8 11 16 00 00       	call   1063b0 <alloc_page>
			uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
  104d9f:	8b 44 24 34          	mov    0x34(%esp),%eax
  104da3:	89 74 24 04          	mov    %esi,0x4(%esp)
  104da7:	89 04 24             	mov    %eax,(%esp)
  104daa:	e8 21 12 00 00       	call   105fd0 <get_ptbl_entry_by_va>
  104daf:	eb 87                	jmp    104d38 <pt_copyout+0x58>
  104db1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		memcpy((void *) uva_pa, kva, size);

		len -= size;
		uva += size;
		kva += size;
		copied += size;
  104db8:	8b 44 24 0c          	mov    0xc(%esp),%eax
	}

	return copied;
}
  104dbc:	83 c4 1c             	add    $0x1c,%esp
  104dbf:	5b                   	pop    %ebx
  104dc0:	5e                   	pop    %esi
  104dc1:	5f                   	pop    %edi
  104dc2:	5d                   	pop    %ebp
  104dc3:	c3                   	ret    
  104dc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104dca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00104dd0 <pt_memset>:

size_t
pt_memset(uint32_t pmap_id, uintptr_t va, char c, size_t len)
{
  104dd0:	55                   	push   %ebp
  104dd1:	57                   	push   %edi
  104dd2:	56                   	push   %esi
  104dd3:	53                   	push   %ebx
  104dd4:	83 ec 1c             	sub    $0x1c,%esp
  104dd7:	8b 5c 24 3c          	mov    0x3c(%esp),%ebx
  104ddb:	8b 74 24 34          	mov    0x34(%esp),%esi
  104ddf:	8b 44 24 38          	mov    0x38(%esp),%eax
        size_t set = 0;

	while (len) {
  104de3:	85 db                	test   %ebx,%ebx
  104de5:	0f 84 86 00 00 00    	je     104e71 <pt_memset+0xa1>
  104deb:	0f be c0             	movsbl %al,%eax
}

size_t
pt_memset(uint32_t pmap_id, uintptr_t va, char c, size_t len)
{
        size_t set = 0;
  104dee:	31 ff                	xor    %edi,%edi
  104df0:	89 44 24 0c          	mov    %eax,0xc(%esp)
  104df4:	eb 3d                	jmp    104e33 <pt_memset+0x63>
  104df6:	66 90                	xchg   %ax,%ax
		if ((pa & PTE_P) == 0) {
			alloc_page(pmap_id, va, PTE_P | PTE_U | PTE_W);
			pa = get_ptbl_entry_by_va(pmap_id, va);
		}

		pa = (pa & 0xfffff000) + (va % PAGESIZE);
  104df8:	89 f2                	mov    %esi,%edx

		size_t size = (len < PAGESIZE - pa % PAGESIZE) ?
			len : PAGESIZE - pa % PAGESIZE;
  104dfa:	b9 00 10 00 00       	mov    $0x1000,%ecx
		if ((pa & PTE_P) == 0) {
			alloc_page(pmap_id, va, PTE_P | PTE_U | PTE_W);
			pa = get_ptbl_entry_by_va(pmap_id, va);
		}

		pa = (pa & 0xfffff000) + (va % PAGESIZE);
  104dff:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
  104e05:	25 00 f0 ff ff       	and    $0xfffff000,%eax

		size_t size = (len < PAGESIZE - pa % PAGESIZE) ?
			len : PAGESIZE - pa % PAGESIZE;
  104e0a:	29 d1                	sub    %edx,%ecx
  104e0c:	01 d0                	add    %edx,%eax
			pa = get_ptbl_entry_by_va(pmap_id, va);
		}

		pa = (pa & 0xfffff000) + (va % PAGESIZE);

		size_t size = (len < PAGESIZE - pa % PAGESIZE) ?
  104e0e:	39 d9                	cmp    %ebx,%ecx
			len : PAGESIZE - pa % PAGESIZE;
  104e10:	89 ca                	mov    %ecx,%edx

		memset((void *) pa, c, size);
  104e12:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
			pa = get_ptbl_entry_by_va(pmap_id, va);
		}

		pa = (pa & 0xfffff000) + (va % PAGESIZE);

		size_t size = (len < PAGESIZE - pa % PAGESIZE) ?
  104e16:	0f 47 d3             	cmova  %ebx,%edx
  104e19:	89 d5                	mov    %edx,%ebp
			len : PAGESIZE - pa % PAGESIZE;

		memset((void *) pa, c, size);
  104e1b:	89 54 24 08          	mov    %edx,0x8(%esp)

		len -= size;
		va += size;
  104e1f:	01 ee                	add    %ebp,%esi
		set += size;
  104e21:	01 ef                	add    %ebp,%edi
		pa = (pa & 0xfffff000) + (va % PAGESIZE);

		size_t size = (len < PAGESIZE - pa % PAGESIZE) ?
			len : PAGESIZE - pa % PAGESIZE;

		memset((void *) pa, c, size);
  104e23:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  104e27:	89 04 24             	mov    %eax,(%esp)
  104e2a:	e8 21 e9 ff ff       	call   103750 <memset>
size_t
pt_memset(uint32_t pmap_id, uintptr_t va, char c, size_t len)
{
        size_t set = 0;

	while (len) {
  104e2f:	29 eb                	sub    %ebp,%ebx
  104e31:	74 45                	je     104e78 <pt_memset+0xa8>
		uintptr_t pa = get_ptbl_entry_by_va(pmap_id, va);
  104e33:	8b 44 24 30          	mov    0x30(%esp),%eax
  104e37:	89 74 24 04          	mov    %esi,0x4(%esp)
  104e3b:	89 04 24             	mov    %eax,(%esp)
  104e3e:	e8 8d 11 00 00       	call   105fd0 <get_ptbl_entry_by_va>

		if ((pa & PTE_P) == 0) {
  104e43:	a8 01                	test   $0x1,%al
  104e45:	75 b1                	jne    104df8 <pt_memset+0x28>
			alloc_page(pmap_id, va, PTE_P | PTE_U | PTE_W);
  104e47:	8b 44 24 30          	mov    0x30(%esp),%eax
  104e4b:	c7 44 24 08 07 00 00 	movl   $0x7,0x8(%esp)
  104e52:	00 
  104e53:	89 74 24 04          	mov    %esi,0x4(%esp)
  104e57:	89 04 24             	mov    %eax,(%esp)
  104e5a:	e8 51 15 00 00       	call   1063b0 <alloc_page>
			pa = get_ptbl_entry_by_va(pmap_id, va);
  104e5f:	8b 44 24 30          	mov    0x30(%esp),%eax
  104e63:	89 74 24 04          	mov    %esi,0x4(%esp)
  104e67:	89 04 24             	mov    %eax,(%esp)
  104e6a:	e8 61 11 00 00       	call   105fd0 <get_ptbl_entry_by_va>
  104e6f:	eb 87                	jmp    104df8 <pt_memset+0x28>
}

size_t
pt_memset(uint32_t pmap_id, uintptr_t va, char c, size_t len)
{
        size_t set = 0;
  104e71:	31 ff                	xor    %edi,%edi
  104e73:	90                   	nop
  104e74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		va += size;
		set += size;
	}

	return set;
}
  104e78:	83 c4 1c             	add    $0x1c,%esp
  104e7b:	89 f8                	mov    %edi,%eax
  104e7d:	5b                   	pop    %ebx
  104e7e:	5e                   	pop    %esi
  104e7f:	5f                   	pop    %edi
  104e80:	5d                   	pop    %ebp
  104e81:	c3                   	ret    
  104e82:	66 90                	xchg   %ax,%ax
  104e84:	66 90                	xchg   %ax,%ax
  104e86:	66 90                	xchg   %ax,%ax
  104e88:	66 90                	xchg   %ax,%ax
  104e8a:	66 90                	xchg   %ax,%ax
  104e8c:	66 90                	xchg   %ax,%ax
  104e8e:	66 90                	xchg   %ax,%ax

00104e90 <elf_load>:
/*
 * Load elf execution file exe to the virtual address space pmap.
 */
void
elf_load (void *exe_ptr, int pid)
{
  104e90:	55                   	push   %ebp
  104e91:	57                   	push   %edi
  104e92:	56                   	push   %esi
  104e93:	53                   	push   %ebx
  104e94:	83 ec 3c             	sub    $0x3c,%esp
	char *strtab;
	uintptr_t exe = (uintptr_t) exe_ptr;

	eh = (elfhdr *) exe;

	KERN_ASSERT(eh->e_magic == ELF_MAGIC);
  104e97:	8b 44 24 50          	mov    0x50(%esp),%eax
/*
 * Load elf execution file exe to the virtual address space pmap.
 */
void
elf_load (void *exe_ptr, int pid)
{
  104e9b:	8b 7c 24 54          	mov    0x54(%esp),%edi
	char *strtab;
	uintptr_t exe = (uintptr_t) exe_ptr;

	eh = (elfhdr *) exe;

	KERN_ASSERT(eh->e_magic == ELF_MAGIC);
  104e9f:	81 38 7f 45 4c 46    	cmpl   $0x464c457f,(%eax)
  104ea5:	74 24                	je     104ecb <elf_load+0x3b>
  104ea7:	c7 44 24 0c 80 91 10 	movl   $0x109180,0xc(%esp)
  104eae:	00 
  104eaf:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  104eb6:	00 
  104eb7:	c7 44 24 04 1e 00 00 	movl   $0x1e,0x4(%esp)
  104ebe:	00 
  104ebf:	c7 04 24 99 91 10 00 	movl   $0x109199,(%esp)
  104ec6:	e8 b5 eb ff ff       	call   103a80 <debug_panic>
	KERN_ASSERT(eh->e_shstrndx != ELF_SHN_UNDEF);
  104ecb:	8b 44 24 50          	mov    0x50(%esp),%eax
  104ecf:	0f b7 40 32          	movzwl 0x32(%eax),%eax
  104ed3:	66 85 c0             	test   %ax,%ax
  104ed6:	0f 84 dc 01 00 00    	je     1050b8 <elf_load+0x228>

	sh = (sechdr *) ((uintptr_t) eh + eh->e_shoff);
	esh = sh + eh->e_shnum;

	strtab = (char *) (exe + sh[eh->e_shstrndx].sh_offset);
	KERN_ASSERT(sh[eh->e_shstrndx].sh_type == ELF_SHT_STRTAB);
  104edc:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  104ee0:	8d 04 80             	lea    (%eax,%eax,4),%eax
  104ee3:	8d 04 c1             	lea    (%ecx,%eax,8),%eax
  104ee6:	03 41 20             	add    0x20(%ecx),%eax
  104ee9:	83 78 04 03          	cmpl   $0x3,0x4(%eax)
  104eed:	74 24                	je     104f13 <elf_load+0x83>
  104eef:	c7 44 24 0c c8 91 10 	movl   $0x1091c8,0xc(%esp)
  104ef6:	00 
  104ef7:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  104efe:	00 
  104eff:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
  104f06:	00 
  104f07:	c7 04 24 99 91 10 00 	movl   $0x109199,(%esp)
  104f0e:	e8 6d eb ff ff       	call   103a80 <debug_panic>

	ph = (proghdr *) ((uintptr_t) eh + eh->e_phoff);
  104f13:	8b 44 24 50          	mov    0x50(%esp),%eax
  104f17:	8b 68 1c             	mov    0x1c(%eax),%ebp
  104f1a:	01 c5                	add    %eax,%ebp
	eph = ph + eh->e_phnum;
  104f1c:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  104f20:	c1 e0 05             	shl    $0x5,%eax
  104f23:	01 e8                	add    %ebp,%eax

	for (; ph < eph; ph++)
  104f25:	39 c5                	cmp    %eax,%ebp

	strtab = (char *) (exe + sh[eh->e_shstrndx].sh_offset);
	KERN_ASSERT(sh[eh->e_shstrndx].sh_type == ELF_SHT_STRTAB);

	ph = (proghdr *) ((uintptr_t) eh + eh->e_phoff);
	eph = ph + eh->e_phnum;
  104f27:	89 44 24 28          	mov    %eax,0x28(%esp)

	for (; ph < eph; ph++)
  104f2b:	72 18                	jb     104f45 <elf_load+0xb5>
  104f2d:	e9 7e 01 00 00       	jmp    1050b0 <elf_load+0x220>
  104f32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104f38:	83 c5 20             	add    $0x20,%ebp
  104f3b:	39 6c 24 28          	cmp    %ebp,0x28(%esp)
  104f3f:	0f 86 6b 01 00 00    	jbe    1050b0 <elf_load+0x220>
	{
		uintptr_t fa;
		uint32_t va, zva, eva, perm;

		if (ph->p_type != ELF_PROG_LOAD)
  104f45:	83 7d 00 01          	cmpl   $0x1,0x0(%ebp)
  104f49:	75 ed                	jne    104f38 <elf_load+0xa8>
			continue;

		fa = (uintptr_t) eh + rounddown (ph->p_offset, PAGESIZE);
  104f4b:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  104f52:	00 
  104f53:	8b 45 04             	mov    0x4(%ebp),%eax
  104f56:	89 04 24             	mov    %eax,(%esp)
  104f59:	e8 f2 f6 ff ff       	call   104650 <rounddown>
		va = rounddown (ph->p_va, PAGESIZE);
  104f5e:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  104f65:	00 
		uint32_t va, zva, eva, perm;

		if (ph->p_type != ELF_PROG_LOAD)
			continue;

		fa = (uintptr_t) eh + rounddown (ph->p_offset, PAGESIZE);
  104f66:	03 44 24 50          	add    0x50(%esp),%eax
  104f6a:	89 c3                	mov    %eax,%ebx
		va = rounddown (ph->p_va, PAGESIZE);
  104f6c:	8b 45 08             	mov    0x8(%ebp),%eax
  104f6f:	89 04 24             	mov    %eax,(%esp)
  104f72:	e8 d9 f6 ff ff       	call   104650 <rounddown>
		zva = ph->p_va + ph->p_filesz;
  104f77:	8b 55 10             	mov    0x10(%ebp),%edx

		if (ph->p_type != ELF_PROG_LOAD)
			continue;

		fa = (uintptr_t) eh + rounddown (ph->p_offset, PAGESIZE);
		va = rounddown (ph->p_va, PAGESIZE);
  104f7a:	89 c6                	mov    %eax,%esi
		zva = ph->p_va + ph->p_filesz;
  104f7c:	8b 45 08             	mov    0x8(%ebp),%eax
		eva = roundup (ph->p_va + ph->p_memsz, PAGESIZE);
  104f7f:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  104f86:	00 
		if (ph->p_type != ELF_PROG_LOAD)
			continue;

		fa = (uintptr_t) eh + rounddown (ph->p_offset, PAGESIZE);
		va = rounddown (ph->p_va, PAGESIZE);
		zva = ph->p_va + ph->p_filesz;
  104f87:	01 c2                	add    %eax,%edx
		eva = roundup (ph->p_va + ph->p_memsz, PAGESIZE);
  104f89:	03 45 14             	add    0x14(%ebp),%eax
		if (ph->p_type != ELF_PROG_LOAD)
			continue;

		fa = (uintptr_t) eh + rounddown (ph->p_offset, PAGESIZE);
		va = rounddown (ph->p_va, PAGESIZE);
		zva = ph->p_va + ph->p_filesz;
  104f8c:	89 54 24 1c          	mov    %edx,0x1c(%esp)
		eva = roundup (ph->p_va + ph->p_memsz, PAGESIZE);
  104f90:	89 04 24             	mov    %eax,(%esp)
  104f93:	e8 d8 f6 ff ff       	call   104670 <roundup>
  104f98:	89 c1                	mov    %eax,%ecx
  104f9a:	89 44 24 24          	mov    %eax,0x24(%esp)

		perm = PTE_U | PTE_P;
		if (ph->p_flags & ELF_PROG_FLAG_WRITE)
  104f9e:	8b 45 18             	mov    0x18(%ebp),%eax
  104fa1:	83 e0 02             	and    $0x2,%eax
		fa = (uintptr_t) eh + rounddown (ph->p_offset, PAGESIZE);
		va = rounddown (ph->p_va, PAGESIZE);
		zva = ph->p_va + ph->p_filesz;
		eva = roundup (ph->p_va + ph->p_memsz, PAGESIZE);

		perm = PTE_U | PTE_P;
  104fa4:	83 f8 01             	cmp    $0x1,%eax
  104fa7:	19 c0                	sbb    %eax,%eax
  104fa9:	89 44 24 20          	mov    %eax,0x20(%esp)
  104fad:	83 64 24 20 fe       	andl   $0xfffffffe,0x20(%esp)
  104fb2:	83 44 24 20 07       	addl   $0x7,0x20(%esp)
		if (ph->p_flags & ELF_PROG_FLAG_WRITE)
			perm |= PTE_W;

		for (; va < eva; va += PAGESIZE, fa += PAGESIZE)
  104fb7:	39 ce                	cmp    %ecx,%esi
  104fb9:	0f 83 79 ff ff ff    	jae    104f38 <elf_load+0xa8>
  104fbf:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  104fc3:	89 6c 24 2c          	mov    %ebp,0x2c(%esp)
  104fc7:	89 f5                	mov    %esi,%ebp
  104fc9:	29 f2                	sub    %esi,%edx
  104fcb:	89 d6                	mov    %edx,%esi
  104fcd:	eb 4a                	jmp    105019 <elf_load+0x189>
  104fcf:	90                   	nop
			if (va < rounddown (zva, PAGESIZE))
			{
				/* copy a complete page */
				pt_copyout ((void *) fa, pid, va, PAGESIZE);
			}
			else if (va < zva && ph->p_filesz)
  104fd0:	39 6c 24 1c          	cmp    %ebp,0x1c(%esp)
  104fd4:	76 0b                	jbe    104fe1 <elf_load+0x151>
  104fd6:	8b 44 24 2c          	mov    0x2c(%esp),%eax
  104fda:	8b 40 10             	mov    0x10(%eax),%eax
  104fdd:	85 c0                	test   %eax,%eax
  104fdf:	75 7f                	jne    105060 <elf_load+0x1d0>
				pt_copyout ((void *) fa, pid, va, zva - va);
			}
			else
			{
				/* zero a page */
				pt_memset (pid, va, 0, PAGESIZE);
  104fe1:	c7 44 24 0c 00 10 00 	movl   $0x1000,0xc(%esp)
  104fe8:	00 
  104fe9:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  104ff0:	00 
  104ff1:	89 6c 24 04          	mov    %ebp,0x4(%esp)
  104ff5:	89 3c 24             	mov    %edi,(%esp)
  104ff8:	e8 d3 fd ff ff       	call   104dd0 <pt_memset>

		perm = PTE_U | PTE_P;
		if (ph->p_flags & ELF_PROG_FLAG_WRITE)
			perm |= PTE_W;

		for (; va < eva; va += PAGESIZE, fa += PAGESIZE)
  104ffd:	81 c5 00 10 00 00    	add    $0x1000,%ebp
  105003:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  105009:	81 ee 00 10 00 00    	sub    $0x1000,%esi
  10500f:	39 6c 24 24          	cmp    %ebp,0x24(%esp)
  105013:	0f 86 7f 00 00 00    	jbe    105098 <elf_load+0x208>
		{
			alloc_page (pid, va, perm);
  105019:	8b 44 24 20          	mov    0x20(%esp),%eax
  10501d:	89 6c 24 04          	mov    %ebp,0x4(%esp)
  105021:	89 3c 24             	mov    %edi,(%esp)
  105024:	89 44 24 08          	mov    %eax,0x8(%esp)
  105028:	e8 83 13 00 00       	call   1063b0 <alloc_page>

			if (va < rounddown (zva, PAGESIZE))
  10502d:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  105031:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  105038:	00 
  105039:	89 04 24             	mov    %eax,(%esp)
  10503c:	e8 0f f6 ff ff       	call   104650 <rounddown>
  105041:	39 c5                	cmp    %eax,%ebp
  105043:	73 8b                	jae    104fd0 <elf_load+0x140>
			{
				/* copy a complete page */
				pt_copyout ((void *) fa, pid, va, PAGESIZE);
  105045:	c7 44 24 0c 00 10 00 	movl   $0x1000,0xc(%esp)
  10504c:	00 
  10504d:	89 6c 24 08          	mov    %ebp,0x8(%esp)
  105051:	89 7c 24 04          	mov    %edi,0x4(%esp)
  105055:	89 1c 24             	mov    %ebx,(%esp)
  105058:	e8 83 fc ff ff       	call   104ce0 <pt_copyout>
  10505d:	eb 9e                	jmp    104ffd <elf_load+0x16d>
  10505f:	90                   	nop
			}
			else if (va < zva && ph->p_filesz)
			{
				/* copy a partial page */
				pt_memset (pid, va, 0, PAGESIZE);
  105060:	c7 44 24 0c 00 10 00 	movl   $0x1000,0xc(%esp)
  105067:	00 
  105068:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  10506f:	00 
  105070:	89 6c 24 04          	mov    %ebp,0x4(%esp)
  105074:	89 3c 24             	mov    %edi,(%esp)
  105077:	e8 54 fd ff ff       	call   104dd0 <pt_memset>
				pt_copyout ((void *) fa, pid, va, zva - va);
  10507c:	89 74 24 0c          	mov    %esi,0xc(%esp)
  105080:	89 6c 24 08          	mov    %ebp,0x8(%esp)
  105084:	89 7c 24 04          	mov    %edi,0x4(%esp)
  105088:	89 1c 24             	mov    %ebx,(%esp)
  10508b:	e8 50 fc ff ff       	call   104ce0 <pt_copyout>
  105090:	e9 68 ff ff ff       	jmp    104ffd <elf_load+0x16d>
  105095:	8d 76 00             	lea    0x0(%esi),%esi
  105098:	8b 6c 24 2c          	mov    0x2c(%esp),%ebp
	KERN_ASSERT(sh[eh->e_shstrndx].sh_type == ELF_SHT_STRTAB);

	ph = (proghdr *) ((uintptr_t) eh + eh->e_phoff);
	eph = ph + eh->e_phnum;

	for (; ph < eph; ph++)
  10509c:	83 c5 20             	add    $0x20,%ebp
  10509f:	39 6c 24 28          	cmp    %ebp,0x28(%esp)
  1050a3:	0f 87 9c fe ff ff    	ja     104f45 <elf_load+0xb5>
  1050a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
				pt_memset (pid, va, 0, PAGESIZE);
			}
		}
	}

}
  1050b0:	83 c4 3c             	add    $0x3c,%esp
  1050b3:	5b                   	pop    %ebx
  1050b4:	5e                   	pop    %esi
  1050b5:	5f                   	pop    %edi
  1050b6:	5d                   	pop    %ebp
  1050b7:	c3                   	ret    
	uintptr_t exe = (uintptr_t) exe_ptr;

	eh = (elfhdr *) exe;

	KERN_ASSERT(eh->e_magic == ELF_MAGIC);
	KERN_ASSERT(eh->e_shstrndx != ELF_SHN_UNDEF);
  1050b8:	c7 44 24 0c a8 91 10 	movl   $0x1091a8,0xc(%esp)
  1050bf:	00 
  1050c0:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  1050c7:	00 
  1050c8:	c7 44 24 04 1f 00 00 	movl   $0x1f,0x4(%esp)
  1050cf:	00 
  1050d0:	c7 04 24 99 91 10 00 	movl   $0x109199,(%esp)
  1050d7:	e8 a4 e9 ff ff       	call   103a80 <debug_panic>
  1050dc:	8b 44 24 50          	mov    0x50(%esp),%eax
  1050e0:	0f b7 40 32          	movzwl 0x32(%eax),%eax
  1050e4:	e9 f3 fd ff ff       	jmp    104edc <elf_load+0x4c>
  1050e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001050f0 <elf_entry>:

}

uintptr_t
elf_entry (void *exe_ptr)
{
  1050f0:	53                   	push   %ebx
  1050f1:	83 ec 18             	sub    $0x18,%esp
  1050f4:	8b 5c 24 20          	mov    0x20(%esp),%ebx
	uintptr_t exe = (uintptr_t) exe_ptr;
	elfhdr *eh = (elfhdr *) exe;
	KERN_ASSERT(eh->e_magic == ELF_MAGIC);
  1050f8:	81 3b 7f 45 4c 46    	cmpl   $0x464c457f,(%ebx)
  1050fe:	74 24                	je     105124 <elf_entry+0x34>
  105100:	c7 44 24 0c 80 91 10 	movl   $0x109180,0xc(%esp)
  105107:	00 
  105108:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  10510f:	00 
  105110:	c7 44 24 04 59 00 00 	movl   $0x59,0x4(%esp)
  105117:	00 
  105118:	c7 04 24 99 91 10 00 	movl   $0x109199,(%esp)
  10511f:	e8 5c e9 ff ff       	call   103a80 <debug_panic>
	return (uintptr_t) eh->e_entry;
  105124:	8b 43 18             	mov    0x18(%ebx),%eax
}
  105127:	83 c4 18             	add    $0x18,%esp
  10512a:	5b                   	pop    %ebx
  10512b:	c3                   	ret    
  10512c:	66 90                	xchg   %ax,%ax
  10512e:	66 90                	xchg   %ax,%ax

00105130 <get_kstack_pointer>:

#include "kstack.h"

uintptr_t*
get_kstack_pointer(void)
{
  105130:	83 ec 0c             	sub    $0xc,%esp
	struct kstack *ks =
                (struct kstack *) ROUNDDOWN(get_stack_pointer(), KSTACK_SIZE);
  105133:	e8 68 f5 ff ff       	call   1046a0 <get_stack_pointer>
	
	return (uintptr_t *) ks;
}
  105138:	83 c4 0c             	add    $0xc,%esp

uintptr_t*
get_kstack_pointer(void)
{
	struct kstack *ks =
                (struct kstack *) ROUNDDOWN(get_stack_pointer(), KSTACK_SIZE);
  10513b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
	
	return (uintptr_t *) ks;
}
  105140:	c3                   	ret    
  105141:	eb 0d                	jmp    105150 <get_kstack_cpu_idx>
  105143:	90                   	nop
  105144:	90                   	nop
  105145:	90                   	nop
  105146:	90                   	nop
  105147:	90                   	nop
  105148:	90                   	nop
  105149:	90                   	nop
  10514a:	90                   	nop
  10514b:	90                   	nop
  10514c:	90                   	nop
  10514d:	90                   	nop
  10514e:	90                   	nop
  10514f:	90                   	nop

00105150 <get_kstack_cpu_idx>:


int 
get_kstack_cpu_idx(void)
{
  105150:	83 ec 0c             	sub    $0xc,%esp

uintptr_t*
get_kstack_pointer(void)
{
	struct kstack *ks =
                (struct kstack *) ROUNDDOWN(get_stack_pointer(), KSTACK_SIZE);
  105153:	e8 48 f5 ff ff       	call   1046a0 <get_stack_pointer>
  105158:	25 00 f0 ff ff       	and    $0xfffff000,%eax
get_kstack_cpu_idx(void)
{

	struct kstack *ks = (struct kstack *) get_kstack_pointer();
	
	return ks->cpu_idx;
  10515d:	8b 80 1c 01 00 00    	mov    0x11c(%eax),%eax
}
  105163:	83 c4 0c             	add    $0xc,%esp
  105166:	c3                   	ret    
  105167:	66 90                	xchg   %ax,%ax
  105169:	66 90                	xchg   %ax,%ax
  10516b:	66 90                	xchg   %ax,%ax
  10516d:	66 90                	xchg   %ax,%ax
  10516f:	90                   	nop

00105170 <spinlock_init>:
#include "spinlock.h"


void gcc_inline
spinlock_init(spinlock_t *lk)
{
  105170:	8b 44 24 04          	mov    0x4(%esp),%eax
	lk->lock_holder = NUM_CPUS + 1;
  105174:	c7 00 09 00 00 00    	movl   $0x9,(%eax)
	lk->lock = 0;
  10517a:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  105181:	c3                   	ret    
  105182:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105190 <spinlock_holding>:
}


bool gcc_inline
spinlock_holding(spinlock_t *lock)
{
  105190:	56                   	push   %esi
	if(!lock->lock) return FALSE;
  105191:	31 c0                	xor    %eax,%eax
}


bool gcc_inline
spinlock_holding(spinlock_t *lock)
{
  105193:	53                   	push   %ebx
  105194:	83 ec 14             	sub    $0x14,%esp
  105197:	8b 5c 24 20          	mov    0x20(%esp),%ebx
	if(!lock->lock) return FALSE;
  10519b:	8b 53 04             	mov    0x4(%ebx),%edx
  10519e:	85 d2                	test   %edx,%edx
  1051a0:	75 06                	jne    1051a8 <spinlock_holding+0x18>

	struct kstack *kstack =
		(struct kstack *) ROUNDDOWN(get_stack_pointer(), KSTACK_SIZE);
	KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
	return lock->lock_holder == kstack->cpu_idx;
}
  1051a2:	83 c4 14             	add    $0x14,%esp
  1051a5:	5b                   	pop    %ebx
  1051a6:	5e                   	pop    %esi
  1051a7:	c3                   	ret    
spinlock_holding(spinlock_t *lock)
{
	if(!lock->lock) return FALSE;

	struct kstack *kstack =
		(struct kstack *) ROUNDDOWN(get_stack_pointer(), KSTACK_SIZE);
  1051a8:	e8 f3 f4 ff ff       	call   1046a0 <get_stack_pointer>
  1051ad:	89 c6                	mov    %eax,%esi
  1051af:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
	KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  1051b5:	81 be 20 01 00 00 32 	cmpl   $0x98765432,0x120(%esi)
  1051bc:	54 76 98 
  1051bf:	74 24                	je     1051e5 <spinlock_holding+0x55>
  1051c1:	c7 44 24 0c f5 91 10 	movl   $0x1091f5,0xc(%esp)
  1051c8:	00 
  1051c9:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  1051d0:	00 
  1051d1:	c7 44 24 04 18 00 00 	movl   $0x18,0x4(%esp)
  1051d8:	00 
  1051d9:	c7 04 24 13 92 10 00 	movl   $0x109213,(%esp)
  1051e0:	e8 9b e8 ff ff       	call   103a80 <debug_panic>
	return lock->lock_holder == kstack->cpu_idx;
  1051e5:	8b 86 1c 01 00 00    	mov    0x11c(%esi),%eax
  1051eb:	39 03                	cmp    %eax,(%ebx)
  1051ed:	0f 94 c0             	sete   %al
}
  1051f0:	83 c4 14             	add    $0x14,%esp
  1051f3:	5b                   	pop    %ebx
  1051f4:	5e                   	pop    %esi
  1051f5:	c3                   	ret    
  1051f6:	8d 76 00             	lea    0x0(%esi),%esi
  1051f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105200 <spinlock_acquire_A>:

#else

void gcc_inline
spinlock_acquire_A(spinlock_t *lk)
{
  105200:	56                   	push   %esi
  105201:	53                   	push   %ebx
  105202:	83 ec 14             	sub    $0x14,%esp
  105205:	8b 74 24 20          	mov    0x20(%esp),%esi
  105209:	8d 5e 04             	lea    0x4(%esi),%ebx
	while(xchg(&lk->lock, 1) != 0)
  10520c:	eb 07                	jmp    105215 <spinlock_acquire_A+0x15>
  10520e:	66 90                	xchg   %ax,%ax
		pause();
  105210:	e8 0b f5 ff ff       	call   104720 <pause>
#else

void gcc_inline
spinlock_acquire_A(spinlock_t *lk)
{
	while(xchg(&lk->lock, 1) != 0)
  105215:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  10521c:	00 
  10521d:	89 1c 24             	mov    %ebx,(%esp)
  105220:	e8 0b f5 ff ff       	call   104730 <xchg>
  105225:	85 c0                	test   %eax,%eax
  105227:	75 e7                	jne    105210 <spinlock_acquire_A+0x10>
		pause();

	struct kstack *kstack =
		(struct kstack *) ROUNDDOWN(get_stack_pointer(), KSTACK_SIZE);
  105229:	e8 72 f4 ff ff       	call   1046a0 <get_stack_pointer>
  10522e:	89 c3                	mov    %eax,%ebx
  105230:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
	KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  105236:	81 bb 20 01 00 00 32 	cmpl   $0x98765432,0x120(%ebx)
  10523d:	54 76 98 
  105240:	74 24                	je     105266 <spinlock_acquire_A+0x66>
  105242:	c7 44 24 0c f5 91 10 	movl   $0x1091f5,0xc(%esp)
  105249:	00 
  10524a:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  105251:	00 
  105252:	c7 44 24 04 37 00 00 	movl   $0x37,0x4(%esp)
  105259:	00 
  10525a:	c7 04 24 13 92 10 00 	movl   $0x109213,(%esp)
  105261:	e8 1a e8 ff ff       	call   103a80 <debug_panic>
	lk->lock_holder = kstack->cpu_idx;
  105266:	8b 83 1c 01 00 00    	mov    0x11c(%ebx),%eax
  10526c:	89 06                	mov    %eax,(%esi)
}
  10526e:	83 c4 14             	add    $0x14,%esp
  105271:	5b                   	pop    %ebx
  105272:	5e                   	pop    %esi
  105273:	c3                   	ret    
  105274:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10527a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00105280 <spinlock_try_acquire_A>:

#endif

int gcc_inline
spinlock_try_acquire_A(spinlock_t *lk)
{
  105280:	57                   	push   %edi
  105281:	56                   	push   %esi
  105282:	53                   	push   %ebx
  105283:	83 ec 10             	sub    $0x10,%esp
  105286:	8b 74 24 20          	mov    0x20(%esp),%esi
	uint32_t old_val = xchg(&lk->lock, 1);
  10528a:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  105291:	00 
  105292:	8d 46 04             	lea    0x4(%esi),%eax
  105295:	89 04 24             	mov    %eax,(%esp)
  105298:	e8 93 f4 ff ff       	call   104730 <xchg>
	if(old_val == 0) {
  10529d:	85 c0                	test   %eax,%eax
#endif

int gcc_inline
spinlock_try_acquire_A(spinlock_t *lk)
{
	uint32_t old_val = xchg(&lk->lock, 1);
  10529f:	89 c3                	mov    %eax,%ebx
	if(old_val == 0) {
  1052a1:	74 0d                	je     1052b0 <spinlock_try_acquire_A+0x30>
			(struct kstack *) ROUNDDOWN(get_stack_pointer(), KSTACK_SIZE);
		KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
		lk->lock_holder = kstack->cpu_idx;
	}
	return old_val;
}
  1052a3:	83 c4 10             	add    $0x10,%esp
  1052a6:	89 d8                	mov    %ebx,%eax
  1052a8:	5b                   	pop    %ebx
  1052a9:	5e                   	pop    %esi
  1052aa:	5f                   	pop    %edi
  1052ab:	c3                   	ret    
  1052ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
spinlock_try_acquire_A(spinlock_t *lk)
{
	uint32_t old_val = xchg(&lk->lock, 1);
	if(old_val == 0) {
		struct kstack *kstack =
			(struct kstack *) ROUNDDOWN(get_stack_pointer(), KSTACK_SIZE);
  1052b0:	e8 eb f3 ff ff       	call   1046a0 <get_stack_pointer>
  1052b5:	89 c7                	mov    %eax,%edi
  1052b7:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
		KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  1052bd:	81 bf 20 01 00 00 32 	cmpl   $0x98765432,0x120(%edi)
  1052c4:	54 76 98 
  1052c7:	74 24                	je     1052ed <spinlock_try_acquire_A+0x6d>
  1052c9:	c7 44 24 0c f5 91 10 	movl   $0x1091f5,0xc(%esp)
  1052d0:	00 
  1052d1:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  1052d8:	00 
  1052d9:	c7 44 24 04 44 00 00 	movl   $0x44,0x4(%esp)
  1052e0:	00 
  1052e1:	c7 04 24 13 92 10 00 	movl   $0x109213,(%esp)
  1052e8:	e8 93 e7 ff ff       	call   103a80 <debug_panic>
		lk->lock_holder = kstack->cpu_idx;
  1052ed:	8b 87 1c 01 00 00    	mov    0x11c(%edi),%eax
  1052f3:	89 06                	mov    %eax,(%esi)
	}
	return old_val;
}
  1052f5:	83 c4 10             	add    $0x10,%esp
  1052f8:	89 d8                	mov    %ebx,%eax
  1052fa:	5b                   	pop    %ebx
  1052fb:	5e                   	pop    %esi
  1052fc:	5f                   	pop    %edi
  1052fd:	c3                   	ret    
  1052fe:	66 90                	xchg   %ax,%ax

00105300 <spinlock_release_A>:

void gcc_inline
spinlock_release_A(spinlock_t *lk)
{
  105300:	83 ec 1c             	sub    $0x1c,%esp
  105303:	8b 44 24 20          	mov    0x20(%esp),%eax
	lk->lock_holder = NUM_CPUS + 1;
  105307:	c7 00 09 00 00 00    	movl   $0x9,(%eax)
	xchg(&lk->lock, 0);
  10530d:	83 c0 04             	add    $0x4,%eax
  105310:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  105317:	00 
  105318:	89 04 24             	mov    %eax,(%esp)
  10531b:	e8 10 f4 ff ff       	call   104730 <xchg>
}
  105320:	83 c4 1c             	add    $0x1c,%esp
  105323:	c3                   	ret    
  105324:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10532a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00105330 <spinlock_acquire>:

#else

void gcc_inline
spinlock_acquire(spinlock_t *lk)
{
  105330:	56                   	push   %esi
  105331:	53                   	push   %ebx
  105332:	83 ec 14             	sub    $0x14,%esp
  105335:	8b 74 24 20          	mov    0x20(%esp),%esi
  105339:	8d 5e 04             	lea    0x4(%esi),%ebx
  10533c:	eb 07                	jmp    105345 <spinlock_acquire+0x15>
  10533e:	66 90                	xchg   %ax,%ax

void gcc_inline
spinlock_acquire_A(spinlock_t *lk)
{
	while(xchg(&lk->lock, 1) != 0)
		pause();
  105340:	e8 db f3 ff ff       	call   104720 <pause>
#else

void gcc_inline
spinlock_acquire_A(spinlock_t *lk)
{
	while(xchg(&lk->lock, 1) != 0)
  105345:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  10534c:	00 
  10534d:	89 1c 24             	mov    %ebx,(%esp)
  105350:	e8 db f3 ff ff       	call   104730 <xchg>
  105355:	85 c0                	test   %eax,%eax
  105357:	75 e7                	jne    105340 <spinlock_acquire+0x10>
		pause();

	struct kstack *kstack =
		(struct kstack *) ROUNDDOWN(get_stack_pointer(), KSTACK_SIZE);
  105359:	e8 42 f3 ff ff       	call   1046a0 <get_stack_pointer>
  10535e:	89 c3                	mov    %eax,%ebx
  105360:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
	KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  105366:	81 bb 20 01 00 00 32 	cmpl   $0x98765432,0x120(%ebx)
  10536d:	54 76 98 
  105370:	74 24                	je     105396 <spinlock_acquire+0x66>
  105372:	c7 44 24 0c f5 91 10 	movl   $0x1091f5,0xc(%esp)
  105379:	00 
  10537a:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  105381:	00 
  105382:	c7 44 24 04 37 00 00 	movl   $0x37,0x4(%esp)
  105389:	00 
  10538a:	c7 04 24 13 92 10 00 	movl   $0x109213,(%esp)
  105391:	e8 ea e6 ff ff       	call   103a80 <debug_panic>
	lk->lock_holder = kstack->cpu_idx;
  105396:	8b 83 1c 01 00 00    	mov    0x11c(%ebx),%eax
  10539c:	89 06                	mov    %eax,(%esi)

void gcc_inline
spinlock_acquire(spinlock_t *lk)
{
	spinlock_acquire_A(lk);
}
  10539e:	83 c4 14             	add    $0x14,%esp
  1053a1:	5b                   	pop    %ebx
  1053a2:	5e                   	pop    %esi
  1053a3:	c3                   	ret    
  1053a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1053aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001053b0 <spinlock_release>:

void gcc_inline
spinlock_release(spinlock_t *lk)
{
  1053b0:	83 ec 1c             	sub    $0x1c,%esp
  1053b3:	8b 44 24 20          	mov    0x20(%esp),%eax
}

void gcc_inline
spinlock_release_A(spinlock_t *lk)
{
	lk->lock_holder = NUM_CPUS + 1;
  1053b7:	c7 00 09 00 00 00    	movl   $0x9,(%eax)
	xchg(&lk->lock, 0);
  1053bd:	83 c0 04             	add    $0x4,%eax
  1053c0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1053c7:	00 
  1053c8:	89 04 24             	mov    %eax,(%esp)
  1053cb:	e8 60 f3 ff ff       	call   104730 <xchg>

void gcc_inline
spinlock_release(spinlock_t *lk)
{
	spinlock_release_A(lk);
}
  1053d0:	83 c4 1c             	add    $0x1c,%esp
  1053d3:	c3                   	ret    
  1053d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1053da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001053e0 <spinlock_try_acquire>:

int gcc_inline
spinlock_try_acquire(spinlock_t *lk)
{
  1053e0:	57                   	push   %edi
  1053e1:	56                   	push   %esi
  1053e2:	53                   	push   %ebx
  1053e3:	83 ec 10             	sub    $0x10,%esp
  1053e6:	8b 74 24 20          	mov    0x20(%esp),%esi
#endif

int gcc_inline
spinlock_try_acquire_A(spinlock_t *lk)
{
	uint32_t old_val = xchg(&lk->lock, 1);
  1053ea:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  1053f1:	00 
  1053f2:	8d 46 04             	lea    0x4(%esi),%eax
  1053f5:	89 04 24             	mov    %eax,(%esp)
  1053f8:	e8 33 f3 ff ff       	call   104730 <xchg>
	if(old_val == 0) {
  1053fd:	85 c0                	test   %eax,%eax
#endif

int gcc_inline
spinlock_try_acquire_A(spinlock_t *lk)
{
	uint32_t old_val = xchg(&lk->lock, 1);
  1053ff:	89 c3                	mov    %eax,%ebx
	if(old_val == 0) {
  105401:	74 0d                	je     105410 <spinlock_try_acquire+0x30>

int gcc_inline
spinlock_try_acquire(spinlock_t *lk)
{
	return spinlock_try_acquire_A(lk);
}
  105403:	83 c4 10             	add    $0x10,%esp
  105406:	89 d8                	mov    %ebx,%eax
  105408:	5b                   	pop    %ebx
  105409:	5e                   	pop    %esi
  10540a:	5f                   	pop    %edi
  10540b:	c3                   	ret    
  10540c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
spinlock_try_acquire_A(spinlock_t *lk)
{
	uint32_t old_val = xchg(&lk->lock, 1);
	if(old_val == 0) {
		struct kstack *kstack =
			(struct kstack *) ROUNDDOWN(get_stack_pointer(), KSTACK_SIZE);
  105410:	e8 8b f2 ff ff       	call   1046a0 <get_stack_pointer>
  105415:	89 c7                	mov    %eax,%edi
  105417:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
		KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  10541d:	81 bf 20 01 00 00 32 	cmpl   $0x98765432,0x120(%edi)
  105424:	54 76 98 
  105427:	74 24                	je     10544d <spinlock_try_acquire+0x6d>
  105429:	c7 44 24 0c f5 91 10 	movl   $0x1091f5,0xc(%esp)
  105430:	00 
  105431:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  105438:	00 
  105439:	c7 44 24 04 44 00 00 	movl   $0x44,0x4(%esp)
  105440:	00 
  105441:	c7 04 24 13 92 10 00 	movl   $0x109213,(%esp)
  105448:	e8 33 e6 ff ff       	call   103a80 <debug_panic>
		lk->lock_holder = kstack->cpu_idx;
  10544d:	8b 87 1c 01 00 00    	mov    0x11c(%edi),%eax
  105453:	89 06                	mov    %eax,(%esi)

int gcc_inline
spinlock_try_acquire(spinlock_t *lk)
{
	return spinlock_try_acquire_A(lk);
}
  105455:	83 c4 10             	add    $0x10,%esp
  105458:	89 d8                	mov    %ebx,%eax
  10545a:	5b                   	pop    %ebx
  10545b:	5e                   	pop    %esi
  10545c:	5f                   	pop    %edi
  10545d:	c3                   	ret    
  10545e:	66 90                	xchg   %ax,%ax

00105460 <pcpu_set_zero>:

struct pcpu pcpu[NUM_CPUS];

extern int get_kstack_cpu_idx(void);

void pcpu_set_zero(){
  105460:	83 ec 1c             	sub    $0x1c,%esp
    memzero(pcpu, sizeof(struct pcpu) * NUM_CPUS);
  105463:	c7 44 24 04 80 02 00 	movl   $0x280,0x4(%esp)
  10546a:	00 
  10546b:	c7 04 24 c0 88 9b 00 	movl   $0x9b88c0,(%esp)
  105472:	e8 e9 e4 ff ff       	call   103960 <memzero>
}
  105477:	83 c4 1c             	add    $0x1c,%esp
  10547a:	c3                   	ret    
  10547b:	90                   	nop
  10547c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00105480 <pcpu_fields_init>:

void
pcpu_fields_init(int cpu_idx){
  105480:	8b 54 24 04          	mov    0x4(%esp),%edx
    pcpu[cpu_idx].inited = TRUE;
  105484:	8d 04 92             	lea    (%edx,%edx,4),%eax
  105487:	c1 e0 04             	shl    $0x4,%eax
  10548a:	c6 80 c0 88 9b 00 01 	movb   $0x1,0x9b88c0(%eax)
    pcpu[cpu_idx].cpu_idx = cpu_idx;
  105491:	89 90 0c 89 9b 00    	mov    %edx,0x9b890c(%eax)
  105497:	c3                   	ret    
  105498:	90                   	nop
  105499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001054a0 <pcpu_cur>:
}

struct pcpu *
pcpu_cur(void)
{
  1054a0:	83 ec 0c             	sub    $0xc,%esp
    int cpu_idx = get_kstack_cpu_idx();
  1054a3:	e8 a8 fc ff ff       	call   105150 <get_kstack_cpu_idx>
    return &pcpu[cpu_idx];
}
  1054a8:	83 c4 0c             	add    $0xc,%esp

struct pcpu *
pcpu_cur(void)
{
    int cpu_idx = get_kstack_cpu_idx();
    return &pcpu[cpu_idx];
  1054ab:	8d 04 80             	lea    (%eax,%eax,4),%eax
  1054ae:	c1 e0 04             	shl    $0x4,%eax
  1054b1:	05 c0 88 9b 00       	add    $0x9b88c0,%eax
}
  1054b6:	c3                   	ret    
  1054b7:	89 f6                	mov    %esi,%esi
  1054b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001054c0 <get_pcpu_idx>:

int
get_pcpu_idx(void)
{
  1054c0:	83 ec 0c             	sub    $0xc,%esp
}

struct pcpu *
pcpu_cur(void)
{
    int cpu_idx = get_kstack_cpu_idx();
  1054c3:	e8 88 fc ff ff       	call   105150 <get_kstack_cpu_idx>
}

int
get_pcpu_idx(void)
{
    return pcpu_cur()->cpu_idx;
  1054c8:	8d 04 80             	lea    (%eax,%eax,4),%eax
  1054cb:	c1 e0 04             	shl    $0x4,%eax
  1054ce:	8b 80 0c 89 9b 00    	mov    0x9b890c(%eax),%eax
}
  1054d4:	83 c4 0c             	add    $0xc,%esp
  1054d7:	c3                   	ret    
  1054d8:	90                   	nop
  1054d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001054e0 <set_pcpu_idx>:

void
set_pcpu_idx(int index, int cpu_idx)
{
  1054e0:	8b 44 24 04          	mov    0x4(%esp),%eax
    pcpu[index].cpu_idx = cpu_idx;
  1054e4:	8b 54 24 08          	mov    0x8(%esp),%edx
  1054e8:	8d 04 80             	lea    (%eax,%eax,4),%eax
  1054eb:	c1 e0 04             	shl    $0x4,%eax
  1054ee:	89 90 0c 89 9b 00    	mov    %edx,0x9b890c(%eax)
  1054f4:	c3                   	ret    
  1054f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1054f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105500 <get_pcpu_kstack_pointer>:
}

uintptr_t*
get_pcpu_kstack_pointer(int cpu_idx)
{
  105500:	8b 44 24 04          	mov    0x4(%esp),%eax
    return pcpu[cpu_idx].kstack;
  105504:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105507:	c1 e0 04             	shl    $0x4,%eax
  10550a:	8b 80 c4 88 9b 00    	mov    0x9b88c4(%eax),%eax
}
  105510:	c3                   	ret    
  105511:	eb 0d                	jmp    105520 <set_pcpu_kstack_pointer>
  105513:	90                   	nop
  105514:	90                   	nop
  105515:	90                   	nop
  105516:	90                   	nop
  105517:	90                   	nop
  105518:	90                   	nop
  105519:	90                   	nop
  10551a:	90                   	nop
  10551b:	90                   	nop
  10551c:	90                   	nop
  10551d:	90                   	nop
  10551e:	90                   	nop
  10551f:	90                   	nop

00105520 <set_pcpu_kstack_pointer>:

void
set_pcpu_kstack_pointer(int cpu_idx, uintptr_t* ks)
{
  105520:	8b 44 24 04          	mov    0x4(%esp),%eax
    pcpu[cpu_idx].kstack = ks;
  105524:	8b 54 24 08          	mov    0x8(%esp),%edx
  105528:	8d 04 80             	lea    (%eax,%eax,4),%eax
  10552b:	c1 e0 04             	shl    $0x4,%eax
  10552e:	89 90 c4 88 9b 00    	mov    %edx,0x9b88c4(%eax)
  105534:	c3                   	ret    
  105535:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  105539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105540 <get_pcpu_boot_info>:
}

volatile bool
get_pcpu_boot_info(int cpu_idx)
{
  105540:	8b 44 24 04          	mov    0x4(%esp),%eax
    return pcpu[cpu_idx].booted;
  105544:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105547:	c1 e0 04             	shl    $0x4,%eax
  10554a:	05 c0 88 9b 00       	add    $0x9b88c0,%eax
  10554f:	0f b6 40 01          	movzbl 0x1(%eax),%eax
}
  105553:	c3                   	ret    
  105554:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10555a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00105560 <set_pcpu_boot_info>:

void
set_pcpu_boot_info(int cpu_idx, volatile bool boot_info)
{
  105560:	83 ec 04             	sub    $0x4,%esp
  105563:	8b 54 24 0c          	mov    0xc(%esp),%edx
  105567:	8b 44 24 08          	mov    0x8(%esp),%eax
  10556b:	88 14 24             	mov    %dl,(%esp)
    pcpu[cpu_idx].booted = boot_info;
  10556e:	0f b6 14 24          	movzbl (%esp),%edx
  105572:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105575:	c1 e0 04             	shl    $0x4,%eax
  105578:	88 90 c1 88 9b 00    	mov    %dl,0x9b88c1(%eax)
}
  10557e:	83 c4 04             	add    $0x4,%esp
  105581:	c3                   	ret    
  105582:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105590 <get_pcpu_cpu_vendor>:

cpu_vendor
get_pcpu_cpu_vendor(int cpu_idx)
{
  105590:	8b 44 24 04          	mov    0x4(%esp),%eax
    return (pcpu[cpu_idx].arch_info).cpu_vendor;
  105594:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105597:	c1 e0 04             	shl    $0x4,%eax
  10559a:	8b 80 e8 88 9b 00    	mov    0x9b88e8(%eax),%eax
}
  1055a0:	c3                   	ret    
  1055a1:	eb 0d                	jmp    1055b0 <get_pcpu_arch_info_pointer>
  1055a3:	90                   	nop
  1055a4:	90                   	nop
  1055a5:	90                   	nop
  1055a6:	90                   	nop
  1055a7:	90                   	nop
  1055a8:	90                   	nop
  1055a9:	90                   	nop
  1055aa:	90                   	nop
  1055ab:	90                   	nop
  1055ac:	90                   	nop
  1055ad:	90                   	nop
  1055ae:	90                   	nop
  1055af:	90                   	nop

001055b0 <get_pcpu_arch_info_pointer>:

uintptr_t*
get_pcpu_arch_info_pointer(int cpu_idx)
{
  1055b0:	8b 44 24 04          	mov    0x4(%esp),%eax
    return (uintptr_t *) &(pcpu[cpu_idx].arch_info);
  1055b4:	8d 04 80             	lea    (%eax,%eax,4),%eax
  1055b7:	c1 e0 04             	shl    $0x4,%eax
  1055ba:	05 c8 88 9b 00       	add    $0x9b88c8,%eax
}
  1055bf:	c3                   	ret    

001055c0 <get_pcpu_inited_info>:

bool
get_pcpu_inited_info(int cpu_idx)
{
  1055c0:	8b 44 24 04          	mov    0x4(%esp),%eax
    return pcpu[cpu_idx].inited;
  1055c4:	8d 04 80             	lea    (%eax,%eax,4),%eax
  1055c7:	c1 e0 04             	shl    $0x4,%eax
  1055ca:	0f b6 80 c0 88 9b 00 	movzbl 0x9b88c0(%eax),%eax
}
  1055d1:	c3                   	ret    
  1055d2:	66 90                	xchg   %ax,%ax
  1055d4:	66 90                	xchg   %ax,%ax
  1055d6:	66 90                	xchg   %ax,%ax
  1055d8:	66 90                	xchg   %ax,%ax
  1055da:	66 90                	xchg   %ax,%ax
  1055dc:	66 90                	xchg   %ax,%ax
  1055de:	66 90                	xchg   %ax,%ax

001055e0 <pcpu_init>:

static bool pcpu_inited = FALSE;

void
pcpu_init(void)
{
  1055e0:	57                   	push   %edi
  1055e1:	56                   	push   %esi
  1055e2:	53                   	push   %ebx
  1055e3:	83 ec 10             	sub    $0x10,%esp
    struct kstack *ks =
                (struct kstack *) ROUNDDOWN(get_stack_pointer(), KSTACK_SIZE);
  1055e6:	e8 b5 f0 ff ff       	call   1046a0 <get_stack_pointer>
  1055eb:	89 c7                	mov    %eax,%edi
  1055ed:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
	  int cpu_idx = ks->cpu_idx;
  1055f3:	8b b7 1c 01 00 00    	mov    0x11c(%edi),%esi
    int i;

	  if (cpu_idx == 0){
  1055f9:	85 f6                	test   %esi,%esi
  1055fb:	75 32                	jne    10562f <pcpu_init+0x4f>
        if (pcpu_inited == TRUE)
  1055fd:	80 3d 74 ce 12 00 01 	cmpb   $0x1,0x12ce74
  105604:	74 62                	je     105668 <pcpu_init+0x88>
            return;

        pcpu_set_zero();
  105606:	e8 55 fe ff ff       	call   105460 <pcpu_set_zero>
        /*
        * Probe SMP.
        */
        pcpu_mp_init();

        for (i = 0; i < NUM_CPUS; i++) {
  10560b:	31 db                	xor    %ebx,%ebx
        pcpu_set_zero();

        /*
        * Probe SMP.
        */
        pcpu_mp_init();
  10560d:	e8 7e d5 ff ff       	call   102b90 <pcpu_mp_init>
  105612:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

        for (i = 0; i < NUM_CPUS; i++) {
            pcpu_fields_init(i);
  105618:	89 1c 24             	mov    %ebx,(%esp)
        /*
        * Probe SMP.
        */
        pcpu_mp_init();

        for (i = 0; i < NUM_CPUS; i++) {
  10561b:	83 c3 01             	add    $0x1,%ebx
            pcpu_fields_init(i);
  10561e:	e8 5d fe ff ff       	call   105480 <pcpu_fields_init>
        /*
        * Probe SMP.
        */
        pcpu_mp_init();

        for (i = 0; i < NUM_CPUS; i++) {
  105623:	83 fb 08             	cmp    $0x8,%ebx
  105626:	75 f0                	jne    105618 <pcpu_init+0x38>
            pcpu_fields_init(i);
        }

        pcpu_inited = TRUE;
  105628:	c6 05 74 ce 12 00 01 	movb   $0x1,0x12ce74
	  }

    set_pcpu_idx(cpu_idx, cpu_idx);
  10562f:	89 74 24 04          	mov    %esi,0x4(%esp)
  105633:	89 34 24             	mov    %esi,(%esp)
  105636:	e8 a5 fe ff ff       	call   1054e0 <set_pcpu_idx>
    set_pcpu_kstack_pointer(cpu_idx, (uintptr_t *) ks);
  10563b:	89 7c 24 04          	mov    %edi,0x4(%esp)
  10563f:	89 34 24             	mov    %esi,(%esp)
  105642:	e8 d9 fe ff ff       	call   105520 <set_pcpu_kstack_pointer>
    set_pcpu_boot_info(cpu_idx, TRUE);
  105647:	89 34 24             	mov    %esi,(%esp)
  10564a:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  105651:	00 
  105652:	e8 09 ff ff ff       	call   105560 <set_pcpu_boot_info>
    pcpu_init_cpu();
}
  105657:	83 c4 10             	add    $0x10,%esp
  10565a:	5b                   	pop    %ebx
  10565b:	5e                   	pop    %esi
  10565c:	5f                   	pop    %edi
	  }

    set_pcpu_idx(cpu_idx, cpu_idx);
    set_pcpu_kstack_pointer(cpu_idx, (uintptr_t *) ks);
    set_pcpu_boot_info(cpu_idx, TRUE);
    pcpu_init_cpu();
  10565d:	e9 6e da ff ff       	jmp    1030d0 <pcpu_init_cpu>
  105662:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
  105668:	83 c4 10             	add    $0x10,%esp
  10566b:	5b                   	pop    %ebx
  10566c:	5e                   	pop    %esi
  10566d:	5f                   	pop    %edi
  10566e:	c3                   	ret    
  10566f:	90                   	nop

00105670 <kern_main_ap>:
    #endif
}

static void
kern_main_ap(void)
{
  105670:	53                   	push   %ebx
  105671:	83 ec 18             	sub    $0x18,%esp
    int cpu_idx = get_pcpu_idx();
  105674:	e8 47 fe ff ff       	call   1054c0 <get_pcpu_idx>
    unsigned int pid, pid2;

    set_pcpu_boot_info(cpu_idx, TRUE);
  105679:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  105680:	00 
  105681:	89 04 24             	mov    %eax,(%esp)
}

static void
kern_main_ap(void)
{
    int cpu_idx = get_pcpu_idx();
  105684:	89 c3                	mov    %eax,%ebx
    unsigned int pid, pid2;

    set_pcpu_boot_info(cpu_idx, TRUE);
  105686:	e8 d5 fe ff ff       	call   105560 <set_pcpu_boot_info>
  10568b:	90                   	nop
  10568c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

    while (all_ready == FALSE);
  105690:	8b 15 78 ce 12 00    	mov    0x12ce78,%edx
  105696:	85 d2                	test   %edx,%edx
  105698:	74 f6                	je     105690 <kern_main_ap+0x20>

    KERN_INFO("[AP%d KERN] kernel_main_ap\n", cpu_idx);
  10569a:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  10569e:	c7 04 24 27 92 10 00 	movl   $0x109227,(%esp)
  1056a5:	e8 46 e3 ff ff       	call   1039f0 <debug_info>

    cpu_booted ++;
  1056aa:	a1 7c ce 12 00       	mov    0x12ce7c,%eax
  1056af:	83 c0 01             	add    $0x1,%eax

    #ifndef TEST
    if (cpu_idx == 1) {
  1056b2:	83 fb 01             	cmp    $0x1,%ebx

    while (all_ready == FALSE);

    KERN_INFO("[AP%d KERN] kernel_main_ap\n", cpu_idx);

    cpu_booted ++;
  1056b5:	a3 7c ce 12 00       	mov    %eax,0x12ce7c

    #ifndef TEST
    if (cpu_idx == 1) {
  1056ba:	0f 84 c8 00 00 00    	je     105788 <kern_main_ap+0x118>
        pid = proc_create (_binary___obj_user_pingpong_ping_start, 1000);
        KERN_INFO("CPU%d: process ping1 %d is created.\n", cpu_idx, pid);
        pid2 = proc_create (_binary___obj_user_pingpong_ping_start, 1000);
        KERN_INFO("CPU%d: process ping2 %d is created.\n", cpu_idx, pid2);
    }
    else if (cpu_idx == 2) {
  1056c0:	83 fb 02             	cmp    $0x2,%ebx
  1056c3:	74 0b                	je     1056d0 <kern_main_ap+0x60>
    set_curid (pid);
    kctx_switch (0, pid);

    KERN_PANIC("kern_main_ap() should never reach here.\n");
    #endif
}
  1056c5:	83 c4 18             	add    $0x18,%esp
  1056c8:	5b                   	pop    %ebx
  1056c9:	c3                   	ret    
  1056ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        KERN_INFO("CPU%d: process ping1 %d is created.\n", cpu_idx, pid);
        pid2 = proc_create (_binary___obj_user_pingpong_ping_start, 1000);
        KERN_INFO("CPU%d: process ping2 %d is created.\n", cpu_idx, pid2);
    }
    else if (cpu_idx == 2) {
        pid = proc_create (_binary___obj_user_pingpong_pong_start, 1000);
  1056d0:	c7 44 24 04 e8 03 00 	movl   $0x3e8,0x4(%esp)
  1056d7:	00 
  1056d8:	c7 04 24 84 c5 11 00 	movl   $0x11c584,(%esp)
  1056df:	e8 ec 14 00 00       	call   106bd0 <proc_create>
        KERN_INFO("CPU%d: process pong1 %d is created.\n", cpu_idx, pid);
  1056e4:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  1056eb:	00 
  1056ec:	c7 04 24 f4 92 10 00 	movl   $0x1092f4,(%esp)
  1056f3:	89 44 24 08          	mov    %eax,0x8(%esp)
        KERN_INFO("CPU%d: process ping1 %d is created.\n", cpu_idx, pid);
        pid2 = proc_create (_binary___obj_user_pingpong_ping_start, 1000);
        KERN_INFO("CPU%d: process ping2 %d is created.\n", cpu_idx, pid2);
    }
    else if (cpu_idx == 2) {
        pid = proc_create (_binary___obj_user_pingpong_pong_start, 1000);
  1056f7:	89 c3                	mov    %eax,%ebx
        KERN_INFO("CPU%d: process pong1 %d is created.\n", cpu_idx, pid);
  1056f9:	e8 f2 e2 ff ff       	call   1039f0 <debug_info>
        pid2 = proc_create (_binary___obj_user_pingpong_pong_start, 1000);
  1056fe:	c7 44 24 04 e8 03 00 	movl   $0x3e8,0x4(%esp)
  105705:	00 
  105706:	c7 04 24 84 c5 11 00 	movl   $0x11c584,(%esp)
  10570d:	e8 be 14 00 00       	call   106bd0 <proc_create>
        KERN_INFO("CPU%d: process pong2 %d is created.\n", cpu_idx, pid2);
  105712:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  105719:	00 
  10571a:	c7 04 24 1c 93 10 00 	movl   $0x10931c,(%esp)
  105721:	89 44 24 08          	mov    %eax,0x8(%esp)
  105725:	e8 c6 e2 ff ff       	call   1039f0 <debug_info>
    }
    else
        return;
    tqueue_remove (NUM_IDS, pid);
  10572a:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  10572e:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
  105735:	e8 16 11 00 00       	call   106850 <tqueue_remove>
    tcb_set_state (pid, TSTATE_RUN);
  10573a:	89 1c 24             	mov    %ebx,(%esp)
  10573d:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  105744:	00 
  105745:	e8 d6 0d 00 00       	call   106520 <tcb_set_state>
    set_curid (pid);
  10574a:	89 1c 24             	mov    %ebx,(%esp)
  10574d:	e8 0e 12 00 00       	call   106960 <set_curid>
    kctx_switch (0, pid);
  105752:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  105756:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10575d:	e8 fe 0c 00 00       	call   106460 <kctx_switch>

    KERN_PANIC("kern_main_ap() should never reach here.\n");
  105762:	c7 44 24 08 44 93 10 	movl   $0x109344,0x8(%esp)
  105769:	00 
  10576a:	c7 44 24 04 76 00 00 	movl   $0x76,0x4(%esp)
  105771:	00 
  105772:	c7 04 24 43 92 10 00 	movl   $0x109243,(%esp)
  105779:	e8 02 e3 ff ff       	call   103a80 <debug_panic>
    #endif
}
  10577e:	83 c4 18             	add    $0x18,%esp
  105781:	5b                   	pop    %ebx
  105782:	c3                   	ret    
  105783:	90                   	nop
  105784:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

    cpu_booted ++;

    #ifndef TEST
    if (cpu_idx == 1) {
        pid = proc_create (_binary___obj_user_pingpong_ping_start, 1000);
  105788:	c7 44 24 04 e8 03 00 	movl   $0x3e8,0x4(%esp)
  10578f:	00 
  105790:	c7 04 24 68 4d 11 00 	movl   $0x114d68,(%esp)
  105797:	e8 34 14 00 00       	call   106bd0 <proc_create>
        KERN_INFO("CPU%d: process ping1 %d is created.\n", cpu_idx, pid);
  10579c:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  1057a3:	00 
  1057a4:	c7 04 24 a4 92 10 00 	movl   $0x1092a4,(%esp)
  1057ab:	89 44 24 08          	mov    %eax,0x8(%esp)

    cpu_booted ++;

    #ifndef TEST
    if (cpu_idx == 1) {
        pid = proc_create (_binary___obj_user_pingpong_ping_start, 1000);
  1057af:	89 c3                	mov    %eax,%ebx
        KERN_INFO("CPU%d: process ping1 %d is created.\n", cpu_idx, pid);
  1057b1:	e8 3a e2 ff ff       	call   1039f0 <debug_info>
        pid2 = proc_create (_binary___obj_user_pingpong_ping_start, 1000);
  1057b6:	c7 44 24 04 e8 03 00 	movl   $0x3e8,0x4(%esp)
  1057bd:	00 
  1057be:	c7 04 24 68 4d 11 00 	movl   $0x114d68,(%esp)
  1057c5:	e8 06 14 00 00       	call   106bd0 <proc_create>
        KERN_INFO("CPU%d: process ping2 %d is created.\n", cpu_idx, pid2);
  1057ca:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  1057d1:	00 
  1057d2:	c7 04 24 cc 92 10 00 	movl   $0x1092cc,(%esp)
  1057d9:	89 44 24 08          	mov    %eax,0x8(%esp)
  1057dd:	e8 0e e2 ff ff       	call   1039f0 <debug_info>
  1057e2:	e9 43 ff ff ff       	jmp    10572a <kern_main_ap+0xba>
  1057e7:	89 f6                	mov    %esi,%esi
  1057e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001057f0 <kern_init>:
    #endif
}

void
kern_init (uintptr_t mbi_addr)
{
  1057f0:	56                   	push   %esi
  1057f1:	be 00 f0 96 00       	mov    $0x96f000,%esi
  1057f6:	53                   	push   %ebx
    int cpu_idx = get_pcpu_idx();
    int i;
    unsigned int pid;

    all_ready = FALSE;
    for (i = 1; i < pcpu_ncpu(); i++){
  1057f7:	bb 01 00 00 00       	mov    $0x1,%ebx
    #endif
}

void
kern_init (uintptr_t mbi_addr)
{
  1057fc:	83 ec 14             	sub    $0x14,%esp
    thread_init(mbi_addr);
  1057ff:	8b 44 24 20          	mov    0x20(%esp),%eax
  105803:	89 04 24             	mov    %eax,(%esp)
  105806:	e8 75 11 00 00       	call   106980 <thread_init>

    KERN_INFO("[BSP KERN] Kernel initialized.\n");
  10580b:	c7 04 24 70 93 10 00 	movl   $0x109370,(%esp)
  105812:	e8 d9 e1 ff ff       	call   1039f0 <debug_info>
extern uint8_t _binary___obj_user_pingpong_pong_start[];

static void
kern_main (void)
{
    KERN_INFO("[BSP KERN] In kernel main.\n\n");
  105817:	c7 04 24 54 92 10 00 	movl   $0x109254,(%esp)
  10581e:	e8 cd e1 ff ff       	call   1039f0 <debug_info>
    
    KERN_INFO("[BSP KERN] Number of CPUs in this system: %d. \n", pcpu_ncpu());
  105823:	e8 28 dd ff ff       	call   103550 <pcpu_ncpu>
  105828:	c7 04 24 90 93 10 00 	movl   $0x109390,(%esp)
  10582f:	89 44 24 04          	mov    %eax,0x4(%esp)
  105833:	e8 b8 e1 ff ff       	call   1039f0 <debug_info>

    int cpu_idx = get_pcpu_idx();
  105838:	e8 83 fc ff ff       	call   1054c0 <get_pcpu_idx>
    int i;
    unsigned int pid;

    all_ready = FALSE;
  10583d:	c7 05 78 ce 12 00 00 	movl   $0x0,0x12ce78
  105844:	00 00 00 
    for (i = 1; i < pcpu_ncpu(); i++){
  105847:	e8 04 dd ff ff       	call   103550 <pcpu_ncpu>
  10584c:	39 c3                	cmp    %eax,%ebx
  10584e:	7d 5a                	jge    1058aa <kern_init+0xba>
        KERN_INFO("[BSP KERN] Boot CPU %d .... \n", i);
  105850:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  105854:	c7 04 24 71 92 10 00 	movl   $0x109271,(%esp)
  10585b:	e8 90 e1 ff ff       	call   1039f0 <debug_info>

        bsp_kstack[i].cpu_idx = i;
        pcpu_boot_ap(i, kern_main_ap, (uintptr_t) &(bsp_kstack[i]));
  105860:	89 74 24 08          	mov    %esi,0x8(%esp)
  105864:	c7 44 24 04 70 56 10 	movl   $0x105670,0x4(%esp)
  10586b:	00 
  10586c:	89 1c 24             	mov    %ebx,(%esp)

    all_ready = FALSE;
    for (i = 1; i < pcpu_ncpu(); i++){
        KERN_INFO("[BSP KERN] Boot CPU %d .... \n", i);

        bsp_kstack[i].cpu_idx = i;
  10586f:	89 9e 1c 01 00 00    	mov    %ebx,0x11c(%esi)
        pcpu_boot_ap(i, kern_main_ap, (uintptr_t) &(bsp_kstack[i]));
  105875:	e8 76 dd ff ff       	call   1035f0 <pcpu_boot_ap>
  10587a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

        while (get_pcpu_boot_info(i) == FALSE);
  105880:	89 1c 24             	mov    %ebx,(%esp)
  105883:	e8 b8 fc ff ff       	call   105540 <get_pcpu_boot_info>
  105888:	84 c0                	test   %al,%al
  10588a:	74 f4                	je     105880 <kern_init+0x90>

        KERN_INFO("[BSP KERN] done.\n");
  10588c:	c7 04 24 8f 92 10 00 	movl   $0x10928f,(%esp)
    int cpu_idx = get_pcpu_idx();
    int i;
    unsigned int pid;

    all_ready = FALSE;
    for (i = 1; i < pcpu_ncpu(); i++){
  105893:	83 c3 01             	add    $0x1,%ebx
  105896:	81 c6 00 10 00 00    	add    $0x1000,%esi
        bsp_kstack[i].cpu_idx = i;
        pcpu_boot_ap(i, kern_main_ap, (uintptr_t) &(bsp_kstack[i]));

        while (get_pcpu_boot_info(i) == FALSE);

        KERN_INFO("[BSP KERN] done.\n");
  10589c:	e8 4f e1 ff ff       	call   1039f0 <debug_info>
    int cpu_idx = get_pcpu_idx();
    int i;
    unsigned int pid;

    all_ready = FALSE;
    for (i = 1; i < pcpu_ncpu(); i++){
  1058a1:	e8 aa dc ff ff       	call   103550 <pcpu_ncpu>
  1058a6:	39 c3                	cmp    %eax,%ebx
  1058a8:	7c a6                	jl     105850 <kern_init+0x60>

        KERN_INFO("[BSP KERN] done.\n");

    }

    all_ready = TRUE;
  1058aa:	c7 05 78 ce 12 00 01 	movl   $0x1,0x12ce78
  1058b1:	00 00 00 
    thread_init(mbi_addr);

    KERN_INFO("[BSP KERN] Kernel initialized.\n");

    kern_main ();
}
  1058b4:	83 c4 14             	add    $0x14,%esp
  1058b7:	5b                   	pop    %ebx
  1058b8:	5e                   	pop    %esi
  1058b9:	c3                   	ret    
  1058ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001058c0 <kern_init_ap>:

void 
kern_init_ap(void (*f)(void))
{
  1058c0:	53                   	push   %ebx
  1058c1:	83 ec 08             	sub    $0x8,%esp
  1058c4:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	devinit_ap();
  1058c8:	e8 63 b0 ff ff       	call   100930 <devinit_ap>
	f();
}
  1058cd:	83 c4 08             	add    $0x8,%esp

void 
kern_init_ap(void (*f)(void))
{
	devinit_ap();
	f();
  1058d0:	89 d8                	mov    %ebx,%eax
}
  1058d2:	5b                   	pop    %ebx

void 
kern_init_ap(void (*f)(void))
{
	devinit_ap();
	f();
  1058d3:	ff e0                	jmp    *%eax
  1058d5:	66 90                	xchg   %ax,%ax
  1058d7:	90                   	nop
  1058d8:	02 b0 ad 1b 03 00    	add    0x31bad(%eax),%dh
  1058de:	00 00                	add    %al,(%eax)
  1058e0:	fb                   	sti    
  1058e1:	4f                   	dec    %edi
  1058e2:	52                   	push   %edx
  1058e3:	e4 fa                	in     $0xfa,%al

001058e4 <start>:
	.long	CHECKSUM

	/* this is the entry of the kernel */
	.globl	start
start:
  cli
  1058e4:	fa                   	cli    

	/* check whether the bootloader provide multiboot information */
	cmpl    $MULTIBOOT_BOOTLOADER_MAGIC, %eax
  1058e5:	3d 02 b0 ad 2b       	cmp    $0x2badb002,%eax
	jne     spin
  1058ea:	75 27                	jne    105913 <spin>
	movl	%ebx, multiboot_ptr
  1058ec:	89 1d 14 59 10 00    	mov    %ebx,0x105914

	/* tell BIOS to warmboot next time */
	movw	$0x1234,0x472
  1058f2:	66 c7 05 72 04 00 00 	movw   $0x1234,0x472
  1058f9:	34 12 

	/* clear EFLAGS */
	pushl	$0x2
  1058fb:	6a 02                	push   $0x2
	popfl
  1058fd:	9d                   	popf   

	/* prepare the kernel stack  */
	movl	$0x0,%ebp
  1058fe:	bd 00 00 00 00       	mov    $0x0,%ebp
	movl	$(bsp_kstack+4096),%esp
  105903:	bc 00 f0 96 00       	mov    $0x96f000,%esp

	/* jump to the C code */
	push	multiboot_ptr
  105908:	ff 35 14 59 10 00    	pushl  0x105914
	call	kern_init
  10590e:	e8 dd fe ff ff       	call   1057f0 <kern_init>

00105913 <spin>:

	/* should not be here */
spin:
	hlt
  105913:	f4                   	hlt    

00105914 <multiboot_ptr>:
  105914:	00 00                	add    %al,(%eax)
  105916:	00 00                	add    %al,(%eax)
  105918:	66 90                	xchg   %ax,%ax
  10591a:	66 90                	xchg   %ax,%ax
  10591c:	66 90                	xchg   %ax,%ax
  10591e:	66 90                	xchg   %ax,%ax

00105920 <mem_spinlock_init>:
static struct ATStruct AT[1 << 20];



void 
mem_spinlock_init(void){
  105920:	83 ec 1c             	sub    $0x1c,%esp
	spinlock_init(&mem_lk);
  105923:	c7 04 24 84 ce 92 00 	movl   $0x92ce84,(%esp)
  10592a:	e8 41 f8 ff ff       	call   105170 <spinlock_init>
}
  10592f:	83 c4 1c             	add    $0x1c,%esp
  105932:	c3                   	ret    
  105933:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105940 <mem_lock>:

void
mem_lock(void){
  105940:	83 ec 1c             	sub    $0x1c,%esp
	spinlock_acquire(&mem_lk);
  105943:	c7 04 24 84 ce 92 00 	movl   $0x92ce84,(%esp)
  10594a:	e8 e1 f9 ff ff       	call   105330 <spinlock_acquire>
}
  10594f:	83 c4 1c             	add    $0x1c,%esp
  105952:	c3                   	ret    
  105953:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105960 <mem_unlock>:

void
mem_unlock(void){
  105960:	83 ec 1c             	sub    $0x1c,%esp
	spinlock_release(&mem_lk);
  105963:	c7 04 24 84 ce 92 00 	movl   $0x92ce84,(%esp)
  10596a:	e8 41 fa ff ff       	call   1053b0 <spinlock_release>
}
  10596f:	83 c4 1c             	add    $0x1c,%esp
  105972:	c3                   	ret    
  105973:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105980 <get_nps>:
//The getter function for NUM_PAGES.
unsigned int gcc_inline
get_nps(void)
{
	return NUM_PAGES;
}
  105980:	a1 80 ce 92 00       	mov    0x92ce80,%eax
  105985:	c3                   	ret    
  105986:	8d 76 00             	lea    0x0(%esi),%esi
  105989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105990 <set_nps>:

//The setter function for NUM_PAGES.
void gcc_inline
set_nps(unsigned int nps)
{
	NUM_PAGES = nps;
  105990:	8b 44 24 04          	mov    0x4(%esp),%eax
  105994:	a3 80 ce 92 00       	mov    %eax,0x92ce80
  105999:	c3                   	ret    
  10599a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001059a0 <at_is_norm>:
{
	unsigned int tperm;

	tperm = AT[page_index].perm;

	if (tperm == 0) {
  1059a0:	8b 44 24 04          	mov    0x4(%esp),%eax
  1059a4:	83 3c c5 80 ce 12 00 	cmpl   $0x1,0x12ce80(,%eax,8)
  1059ab:	01 
  1059ac:	0f 97 c0             	seta   %al
  1059af:	0f b6 c0             	movzbl %al,%eax
		else
			tperm = 1;
	}

	return tperm;
}
  1059b2:	c3                   	ret    
  1059b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1059b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001059c0 <at_set_perm>:
 * Sets the permission of the page with given index.
 * It also marks the page as unallocated.
 */
void
at_set_perm(unsigned int page_index, unsigned int norm_val)
{
  1059c0:	8b 44 24 04          	mov    0x4(%esp),%eax
	AT[page_index].perm = norm_val;
  1059c4:	8b 54 24 08          	mov    0x8(%esp),%edx
	AT[page_index].allocated = 0;
  1059c8:	c7 04 c5 84 ce 12 00 	movl   $0x0,0x12ce84(,%eax,8)
  1059cf:	00 00 00 00 
 * It also marks the page as unallocated.
 */
void
at_set_perm(unsigned int page_index, unsigned int norm_val)
{
	AT[page_index].perm = norm_val;
  1059d3:	89 14 c5 80 ce 12 00 	mov    %edx,0x12ce80(,%eax,8)
	AT[page_index].allocated = 0;
  1059da:	c3                   	ret    
  1059db:	90                   	nop
  1059dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001059e0 <at_is_allocated>:
at_is_allocated(unsigned int page_index)
{
	unsigned int allocated;

	allocated = AT[page_index].allocated;
	if (allocated == 0)
  1059e0:	8b 44 24 04          	mov    0x4(%esp),%eax
  1059e4:	8b 04 c5 84 ce 12 00 	mov    0x12ce84(,%eax,8),%eax
  1059eb:	85 c0                	test   %eax,%eax
  1059ed:	0f 95 c0             	setne  %al
  1059f0:	0f b6 c0             	movzbl %al,%eax
		allocated = 0;
	else
		allocated = 1;

	return allocated;
}
  1059f3:	c3                   	ret    
  1059f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1059fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00105a00 <at_set_allocated>:
 * Set the flag of the page with given index to the given value.
 */
void
at_set_allocated(unsigned int page_index, unsigned int allocated)
{
	AT[page_index].allocated = allocated;
  105a00:	8b 54 24 08          	mov    0x8(%esp),%edx
  105a04:	8b 44 24 04          	mov    0x4(%esp),%eax
  105a08:	89 14 c5 84 ce 12 00 	mov    %edx,0x12ce84(,%eax,8)
  105a0f:	c3                   	ret    

00105a10 <pmem_init>:
 *    information available in the physical memory map table.
 *    Review import.h in the current directory for the list of avaiable getter and setter functions.
 */
void
pmem_init(unsigned int mbi_addr)
{
  105a10:	55                   	push   %ebp
  105a11:	57                   	push   %edi
  105a12:	56                   	push   %esi
  105a13:	53                   	push   %ebx
  105a14:	83 ec 2c             	sub    $0x2c,%esp
	unsigned int i, j, isnorm, maxs, size, flag;
	unsigned int s, l;

  //Calls the lower layer initializatin primitives.
  //The parameter mbi_addr shell not be used in the further code.
	devinit(mbi_addr);
  105a17:	8b 44 24 40          	mov    0x40(%esp),%eax
  105a1b:	89 04 24             	mov    %eax,(%esp)
  105a1e:	e8 7d ae ff ff       	call   1008a0 <devinit>


	mem_spinlock_init();
  105a23:	e8 f8 fe ff ff       	call   105920 <mem_spinlock_init>
   * Calculate the number of actual number of avaiable physical pages and store it into the local varaible nps.
   * Hint: Think of it as the highest address possible in the ranges of the memory map table,
   *       divided by the page size.
   */
	i = 0;
	size = get_size();
  105a28:	e8 43 b3 ff ff       	call   100d70 <get_size>
	nps = 0;
	while (i < size) {
  105a2d:	85 c0                	test   %eax,%eax
   * Calculate the number of actual number of avaiable physical pages and store it into the local varaible nps.
   * Hint: Think of it as the highest address possible in the ranges of the memory map table,
   *       divided by the page size.
   */
	i = 0;
	size = get_size();
  105a2f:	89 c7                	mov    %eax,%edi
	nps = 0;
	while (i < size) {
  105a31:	74 6e                	je     105aa1 <pmem_init+0x91>
  /**
   * Calculate the number of actual number of avaiable physical pages and store it into the local varaible nps.
   * Hint: Think of it as the highest address possible in the ranges of the memory map table,
   *       divided by the page size.
   */
	i = 0;
  105a33:	31 f6                	xor    %esi,%esi
	size = get_size();
	nps = 0;
  105a35:	31 db                	xor    %ebx,%ebx
  105a37:	90                   	nop
	while (i < size) {
		s = get_mms(i);
  105a38:	89 34 24             	mov    %esi,(%esp)
  105a3b:	e8 40 b3 ff ff       	call   100d80 <get_mms>
		l = get_mml(i);
  105a40:	89 34 24             	mov    %esi,(%esp)
   */
	i = 0;
	size = get_size();
	nps = 0;
	while (i < size) {
		s = get_mms(i);
  105a43:	89 c5                	mov    %eax,%ebp
		l = get_mml(i);
  105a45:	e8 76 b3 ff ff       	call   100dc0 <get_mml>
		maxs = (s + l) / PAGESIZE + 1;
  105a4a:	01 e8                	add    %ebp,%eax
  105a4c:	c1 e8 0c             	shr    $0xc,%eax
  105a4f:	83 c0 01             	add    $0x1,%eax
  105a52:	39 c3                	cmp    %eax,%ebx
  105a54:	0f 42 d8             	cmovb  %eax,%ebx
		if (maxs > nps)
			nps = maxs;
		i++;
  105a57:	83 c6 01             	add    $0x1,%esi
   *       divided by the page size.
   */
	i = 0;
	size = get_size();
	nps = 0;
	while (i < size) {
  105a5a:	39 fe                	cmp    %edi,%esi
  105a5c:	75 da                	jne    105a38 <pmem_init+0x28>
		if (maxs > nps)
			nps = maxs;
		i++;
	}

	set_nps(nps); // Setting the value computed above to NUM_PAGES.
  105a5e:	89 1c 24             	mov    %ebx,(%esp)
  105a61:	bd 01 00 00 00       	mov    $0x1,%ebp
  105a66:	31 f6                	xor    %esi,%esi
  105a68:	e8 23 ff ff ff       	call   105990 <set_nps>
  105a6d:	eb 03                	jmp    105a72 <pmem_init+0x62>
  105a6f:	90                   	nop
   *    But the ranges in the momory map table may not cover the entire available address space.
   *    That means there may be some gaps between the ranges.
   *    You should still set the permission of those pages in allocation table to 0.
   */
	i = 0;
	while (i < nps) {
  105a70:	89 c5                	mov    %eax,%ebp
  105a72:	8d 86 00 00 fc ff    	lea    -0x40000(%esi),%eax
		if (i < VM_USERLO_PI || i >= VM_USERHI_PI) {
  105a78:	3d ff ff 0a 00       	cmp    $0xaffff,%eax
  105a7d:	76 36                	jbe    105ab5 <pmem_init+0xa5>
			at_set_perm(i, 1);
  105a7f:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  105a86:	00 
  105a87:	89 34 24             	mov    %esi,(%esp)
  105a8a:	e8 31 ff ff ff       	call   1059c0 <at_set_perm>
  105a8f:	83 c6 01             	add    $0x1,%esi
   *    But the ranges in the momory map table may not cover the entire available address space.
   *    That means there may be some gaps between the ranges.
   *    You should still set the permission of those pages in allocation table to 0.
   */
	i = 0;
	while (i < nps) {
  105a92:	39 dd                	cmp    %ebx,%ebp
  105a94:	8d 45 01             	lea    0x1(%ebp),%eax
  105a97:	72 d7                	jb     105a70 <pmem_init+0x60>
				at_set_perm(i, 0);
		}
		i++;
	}

}
  105a99:	83 c4 2c             	add    $0x2c,%esp
  105a9c:	5b                   	pop    %ebx
  105a9d:	5e                   	pop    %esi
  105a9e:	5f                   	pop    %edi
  105a9f:	5d                   	pop    %ebp
  105aa0:	c3                   	ret    
		if (maxs > nps)
			nps = maxs;
		i++;
	}

	set_nps(nps); // Setting the value computed above to NUM_PAGES.
  105aa1:	c7 44 24 40 00 00 00 	movl   $0x0,0x40(%esp)
  105aa8:	00 
				at_set_perm(i, 0);
		}
		i++;
	}

}
  105aa9:	83 c4 2c             	add    $0x2c,%esp
  105aac:	5b                   	pop    %ebx
  105aad:	5e                   	pop    %esi
  105aae:	5f                   	pop    %edi
  105aaf:	5d                   	pop    %ebp
		if (maxs > nps)
			nps = maxs;
		i++;
	}

	set_nps(nps); // Setting the value computed above to NUM_PAGES.
  105ab0:	e9 db fe ff ff       	jmp    105990 <set_nps>
  105ab5:	89 f0                	mov    %esi,%eax
  105ab7:	c1 e0 0c             	shl    $0xc,%eax
  105aba:	89 44 24 0c          	mov    %eax,0xc(%esp)
			isnorm = 0;
			while (j < size && flag == 0) {
				s = get_mms(j);
				l = get_mml(j);
				isnorm = is_usable(j);
				if (s <= i * PAGESIZE && l + s >= (i + 1) * PAGESIZE) {
  105abe:	89 e8                	mov    %ebp,%eax
  105ac0:	c1 e0 0c             	shl    $0xc,%eax
  105ac3:	89 44 24 10          	mov    %eax,0x10(%esp)
  105ac7:	31 c0                	xor    %eax,%eax
  105ac9:	89 5c 24 14          	mov    %ebx,0x14(%esp)
  105acd:	89 c3                	mov    %eax,%ebx
  105acf:	89 6c 24 18          	mov    %ebp,0x18(%esp)
  105ad3:	89 74 24 1c          	mov    %esi,0x1c(%esp)
  105ad7:	eb 1c                	jmp    105af5 <pmem_init+0xe5>
  105ad9:	8d 54 35 00          	lea    0x0(%ebp,%esi,1),%edx
  105add:	3b 54 24 10          	cmp    0x10(%esp),%edx
  105ae1:	0f 93 c2             	setae  %dl
  105ae4:	0f b6 ca             	movzbl %dl,%ecx
  105ae7:	83 f2 01             	xor    $0x1,%edx
					flag = 1;
				}
				j++;
  105aea:	83 c3 01             	add    $0x1,%ebx
			at_set_perm(i, 1);
		} else {
			j = 0;
			flag = 0;
			isnorm = 0;
			while (j < size && flag == 0) {
  105aed:	84 d2                	test   %dl,%dl
  105aef:	74 2f                	je     105b20 <pmem_init+0x110>
  105af1:	39 df                	cmp    %ebx,%edi
  105af3:	76 2b                	jbe    105b20 <pmem_init+0x110>
				s = get_mms(j);
  105af5:	89 1c 24             	mov    %ebx,(%esp)
  105af8:	e8 83 b2 ff ff       	call   100d80 <get_mms>
				l = get_mml(j);
  105afd:	89 1c 24             	mov    %ebx,(%esp)
		} else {
			j = 0;
			flag = 0;
			isnorm = 0;
			while (j < size && flag == 0) {
				s = get_mms(j);
  105b00:	89 c6                	mov    %eax,%esi
				l = get_mml(j);
  105b02:	e8 b9 b2 ff ff       	call   100dc0 <get_mml>
				isnorm = is_usable(j);
  105b07:	89 1c 24             	mov    %ebx,(%esp)
			j = 0;
			flag = 0;
			isnorm = 0;
			while (j < size && flag == 0) {
				s = get_mms(j);
				l = get_mml(j);
  105b0a:	89 c5                	mov    %eax,%ebp
				isnorm = is_usable(j);
  105b0c:	e8 ef b2 ff ff       	call   100e00 <is_usable>
				if (s <= i * PAGESIZE && l + s >= (i + 1) * PAGESIZE) {
  105b11:	39 74 24 0c          	cmp    %esi,0xc(%esp)
  105b15:	73 c2                	jae    105ad9 <pmem_init+0xc9>
  105b17:	ba 01 00 00 00       	mov    $0x1,%edx
  105b1c:	31 c9                	xor    %ecx,%ecx
  105b1e:	eb ca                	jmp    105aea <pmem_init+0xda>
					flag = 1;
				}
				j++;
			}
			if (flag == 1 && isnorm == 1)
  105b20:	83 f8 01             	cmp    $0x1,%eax
  105b23:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  105b27:	8b 6c 24 18          	mov    0x18(%esp),%ebp
  105b2b:	8b 74 24 1c          	mov    0x1c(%esp),%esi
  105b2f:	75 19                	jne    105b4a <pmem_init+0x13a>
  105b31:	85 c9                	test   %ecx,%ecx
  105b33:	74 15                	je     105b4a <pmem_init+0x13a>
				at_set_perm(i, 2);
  105b35:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  105b3c:	00 
  105b3d:	89 34 24             	mov    %esi,(%esp)
  105b40:	e8 7b fe ff ff       	call   1059c0 <at_set_perm>
  105b45:	e9 45 ff ff ff       	jmp    105a8f <pmem_init+0x7f>
			else
				at_set_perm(i, 0);
  105b4a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  105b51:	00 
  105b52:	89 34 24             	mov    %esi,(%esp)
  105b55:	e8 66 fe ff ff       	call   1059c0 <at_set_perm>
  105b5a:	e9 30 ff ff ff       	jmp    105a8f <pmem_init+0x7f>
  105b5f:	90                   	nop

00105b60 <palloc>:
 * 2. Optimize the code with the memorization techniques so that you do not have to
 *    scan the allocation table from scratch every time.
 */
unsigned int
palloc()
{
  105b60:	57                   	push   %edi
  105b61:	56                   	push   %esi
  105b62:	53                   	push   %ebx
  105b63:	83 ec 10             	sub    $0x10,%esp
    unsigned int palloc_index;
    unsigned int palloc_cur_at;
    unsigned int palloc_is_norm;
    unsigned int palloc_free_index;

    mem_lock();
  105b66:	e8 d5 fd ff ff       	call   105940 <mem_lock>

    tnps = get_nps();
  105b6b:	e8 10 fe ff ff       	call   105980 <get_nps>
  105b70:	89 c6                	mov    %eax,%esi
    palloc_index = last_palloc_index + 1;
  105b72:	a1 0c d3 10 00       	mov    0x10d30c,%eax
    palloc_free_index = tnps;
    while( palloc_index < tnps && palloc_free_index == tnps )
  105b77:	89 f7                	mov    %esi,%edi
    unsigned int palloc_free_index;

    mem_lock();

    tnps = get_nps();
    palloc_index = last_palloc_index + 1;
  105b79:	8d 58 01             	lea    0x1(%eax),%ebx
    palloc_free_index = tnps;
    while( palloc_index < tnps && palloc_free_index == tnps )
  105b7c:	39 de                	cmp    %ebx,%esi
  105b7e:	77 13                	ja     105b93 <palloc+0x33>
  105b80:	eb 66                	jmp    105be8 <palloc+0x88>
  105b82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        {
            palloc_cur_at = at_is_allocated(palloc_index);
            if (palloc_cur_at == 0)
                palloc_free_index = palloc_index;
        }
        palloc_index ++;
  105b88:	83 c3 01             	add    $0x1,%ebx
    mem_lock();

    tnps = get_nps();
    palloc_index = last_palloc_index + 1;
    palloc_free_index = tnps;
    while( palloc_index < tnps && palloc_free_index == tnps )
  105b8b:	39 f7                	cmp    %esi,%edi
  105b8d:	75 29                	jne    105bb8 <palloc+0x58>
  105b8f:	39 de                	cmp    %ebx,%esi
  105b91:	76 25                	jbe    105bb8 <palloc+0x58>
    {
        palloc_is_norm = at_is_norm(palloc_index);
  105b93:	89 1c 24             	mov    %ebx,(%esp)
  105b96:	e8 05 fe ff ff       	call   1059a0 <at_is_norm>
        if (palloc_is_norm == 1)
  105b9b:	83 f8 01             	cmp    $0x1,%eax
  105b9e:	75 e8                	jne    105b88 <palloc+0x28>
        {
            palloc_cur_at = at_is_allocated(palloc_index);
  105ba0:	89 1c 24             	mov    %ebx,(%esp)
  105ba3:	e8 38 fe ff ff       	call   1059e0 <at_is_allocated>
  105ba8:	85 c0                	test   %eax,%eax
  105baa:	0f 44 fb             	cmove  %ebx,%edi
            if (palloc_cur_at == 0)
                palloc_free_index = palloc_index;
        }
        palloc_index ++;
  105bad:	83 c3 01             	add    $0x1,%ebx
    mem_lock();

    tnps = get_nps();
    palloc_index = last_palloc_index + 1;
    palloc_free_index = tnps;
    while( palloc_index < tnps && palloc_free_index == tnps )
  105bb0:	39 f7                	cmp    %esi,%edi
  105bb2:	74 db                	je     105b8f <palloc+0x2f>
  105bb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            if (palloc_cur_at == 0)
                palloc_free_index = palloc_index;
        }
        palloc_index ++;
    }
    if (palloc_free_index == tnps)
  105bb8:	39 f7                	cmp    %esi,%edi
  105bba:	74 2c                	je     105be8 <palloc+0x88>
      palloc_free_index = 0;
    else
    {
      at_set_allocated(palloc_free_index, 1);
  105bbc:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  105bc3:	00 
  105bc4:	89 3c 24             	mov    %edi,(%esp)
  105bc7:	e8 34 fe ff ff       	call   105a00 <at_set_allocated>
  105bcc:	89 f8                	mov    %edi,%eax
  105bce:	31 d2                	xor    %edx,%edx
  105bd0:	f7 f6                	div    %esi
    }
    last_palloc_index = palloc_free_index % tnps;
  105bd2:	89 15 0c d3 10 00    	mov    %edx,0x10d30c

    mem_unlock();
  105bd8:	e8 83 fd ff ff       	call   105960 <mem_unlock>

    return palloc_free_index;
} 
  105bdd:	83 c4 10             	add    $0x10,%esp
  105be0:	89 f8                	mov    %edi,%eax
  105be2:	5b                   	pop    %ebx
  105be3:	5e                   	pop    %esi
  105be4:	5f                   	pop    %edi
  105be5:	c3                   	ret    
  105be6:	66 90                	xchg   %ax,%ax
  105be8:	31 d2                	xor    %edx,%edx
                palloc_free_index = palloc_index;
        }
        palloc_index ++;
    }
    if (palloc_free_index == tnps)
      palloc_free_index = 0;
  105bea:	31 ff                	xor    %edi,%edi
  105bec:	eb e4                	jmp    105bd2 <palloc+0x72>
  105bee:	66 90                	xchg   %ax,%ax

00105bf0 <pfree>:
 *
 * Hint: Simple.
 */
void
pfree(unsigned int pfree_index)
{
  105bf0:	53                   	push   %ebx
  105bf1:	83 ec 18             	sub    $0x18,%esp
  105bf4:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  mem_lock();
  105bf8:	e8 43 fd ff ff       	call   105940 <mem_lock>
	at_set_allocated(pfree_index, 0);
  105bfd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  105c04:	00 
  105c05:	89 1c 24             	mov    %ebx,(%esp)
  105c08:	e8 f3 fd ff ff       	call   105a00 <at_set_allocated>
  mem_unlock();
}
  105c0d:	83 c4 18             	add    $0x18,%esp
  105c10:	5b                   	pop    %ebx
void
pfree(unsigned int pfree_index)
{
  mem_lock();
	at_set_allocated(pfree_index, 0);
  mem_unlock();
  105c11:	e9 4a fd ff ff       	jmp    105960 <mem_unlock>
  105c16:	66 90                	xchg   %ax,%ax
  105c18:	66 90                	xchg   %ax,%ax
  105c1a:	66 90                	xchg   %ax,%ax
  105c1c:	66 90                	xchg   %ax,%ax
  105c1e:	66 90                	xchg   %ax,%ax

00105c20 <container_init>:
/**
 * Initializes the container data for the root process (the one with index 0).
 * The root process is the one that gets spawned first by the kernel.
 */
void container_init(unsigned int mbi_addr)
{
  105c20:	55                   	push   %ebp
  105c21:	57                   	push   %edi
  105c22:	56                   	push   %esi
  105c23:	53                   	push   %ebx
  105c24:	83 ec 1c             	sub    $0x1c,%esp
  unsigned int real_quota;
  unsigned int nps, i, norm, used;

  pmem_init(mbi_addr);
  105c27:	8b 44 24 30          	mov    0x30(%esp),%eax
  105c2b:	89 04 24             	mov    %eax,(%esp)
  105c2e:	e8 dd fd ff ff       	call   105a10 <pmem_init>
  /**
   * compute the available quota and store it into the variable real_quota.
   * It should be the number of the unallocated pages with the normal permission
   * in the physical memory allocation table.
   */
  nps = get_nps();
  105c33:	e8 48 fd ff ff       	call   105980 <get_nps>
  i = 1;
  while (i < nps) {
  105c38:	83 f8 01             	cmp    $0x1,%eax
  /**
   * compute the available quota and store it into the variable real_quota.
   * It should be the number of the unallocated pages with the normal permission
   * in the physical memory allocation table.
   */
  nps = get_nps();
  105c3b:	89 c5                	mov    %eax,%ebp
  i = 1;
  while (i < nps) {
  105c3d:	0f 86 8d 00 00 00    	jbe    105cd0 <container_init+0xb0>
   * compute the available quota and store it into the variable real_quota.
   * It should be the number of the unallocated pages with the normal permission
   * in the physical memory allocation table.
   */
  nps = get_nps();
  i = 1;
  105c43:	bb 01 00 00 00       	mov    $0x1,%ebx
{
  unsigned int real_quota;
  unsigned int nps, i, norm, used;

  pmem_init(mbi_addr);
  real_quota = 0;
  105c48:	31 ff                	xor    %edi,%edi
  105c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
   * in the physical memory allocation table.
   */
  nps = get_nps();
  i = 1;
  while (i < nps) {
    norm = at_is_norm(i);
  105c50:	89 1c 24             	mov    %ebx,(%esp)
  105c53:	e8 48 fd ff ff       	call   1059a0 <at_is_norm>
    used = at_is_allocated(i);
  105c58:	89 1c 24             	mov    %ebx,(%esp)
   * in the physical memory allocation table.
   */
  nps = get_nps();
  i = 1;
  while (i < nps) {
    norm = at_is_norm(i);
  105c5b:	89 c6                	mov    %eax,%esi
    used = at_is_allocated(i);
  105c5d:	e8 7e fd ff ff       	call   1059e0 <at_is_allocated>
    if (norm == 1 && used == 0)
  105c62:	85 c0                	test   %eax,%eax
  105c64:	75 0b                	jne    105c71 <container_init+0x51>
  105c66:	83 fe 01             	cmp    $0x1,%esi
  105c69:	0f 94 c0             	sete   %al
      real_quota++;
  105c6c:	3c 01                	cmp    $0x1,%al
  105c6e:	83 df ff             	sbb    $0xffffffff,%edi
    i++;
  105c71:	83 c3 01             	add    $0x1,%ebx
   * It should be the number of the unallocated pages with the normal permission
   * in the physical memory allocation table.
   */
  nps = get_nps();
  i = 1;
  while (i < nps) {
  105c74:	39 eb                	cmp    %ebp,%ebx
  105c76:	75 d8                	jne    105c50 <container_init+0x30>
  105c78:	89 fb                	mov    %edi,%ebx
    used = at_is_allocated(i);
    if (norm == 1 && used == 0)
      real_quota++;
    i++;
  }
  KERN_DEBUG("\nreal quota: %d\n\n", real_quota);
  105c7a:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  105c7e:	c7 44 24 08 c0 93 10 	movl   $0x1093c0,0x8(%esp)
  105c85:	00 
  105c86:	c7 44 24 04 2a 00 00 	movl   $0x2a,0x4(%esp)
  105c8d:	00 
  105c8e:	c7 04 24 d4 93 10 00 	movl   $0x1093d4,(%esp)
  105c95:	e8 96 dd ff ff       	call   103a30 <debug_normal>

  CONTAINER[0].quota = real_quota;
  105c9a:	89 1d a0 ce 92 00    	mov    %ebx,0x92cea0
  CONTAINER[0].usage = 0;
  105ca0:	c7 05 a4 ce 92 00 00 	movl   $0x0,0x92cea4
  105ca7:	00 00 00 
  CONTAINER[0].parent = 0;
  105caa:	c7 05 a8 ce 92 00 00 	movl   $0x0,0x92cea8
  105cb1:	00 00 00 
  CONTAINER[0].nchildren = 0;
  105cb4:	c7 05 ac ce 92 00 00 	movl   $0x0,0x92ceac
  105cbb:	00 00 00 
  CONTAINER[0].used = 1;
  105cbe:	c7 05 b0 ce 92 00 01 	movl   $0x1,0x92ceb0
  105cc5:	00 00 00 
}
  105cc8:	83 c4 1c             	add    $0x1c,%esp
  105ccb:	5b                   	pop    %ebx
  105ccc:	5e                   	pop    %esi
  105ccd:	5f                   	pop    %edi
  105cce:	5d                   	pop    %ebp
  105ccf:	c3                   	ret    
   * It should be the number of the unallocated pages with the normal permission
   * in the physical memory allocation table.
   */
  nps = get_nps();
  i = 1;
  while (i < nps) {
  105cd0:	31 db                	xor    %ebx,%ebx
{
  unsigned int real_quota;
  unsigned int nps, i, norm, used;

  pmem_init(mbi_addr);
  real_quota = 0;
  105cd2:	31 ff                	xor    %edi,%edi
  105cd4:	eb a4                	jmp    105c7a <container_init+0x5a>
  105cd6:	8d 76 00             	lea    0x0(%esi),%esi
  105cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105ce0 <container_get_parent>:
}


// get the id of parent process of process # [id]
unsigned int container_get_parent(unsigned int id)
{
  105ce0:	8b 44 24 04          	mov    0x4(%esp),%eax
  return CONTAINER[id].parent;
  105ce4:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105ce7:	8b 04 85 a8 ce 92 00 	mov    0x92cea8(,%eax,4),%eax
}
  105cee:	c3                   	ret    
  105cef:	90                   	nop

00105cf0 <container_get_nchildren>:


// get the number of children of process # [id]
unsigned int container_get_nchildren(unsigned int id)
{
  105cf0:	8b 44 24 04          	mov    0x4(%esp),%eax
  return CONTAINER[id].nchildren;
  105cf4:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105cf7:	8b 04 85 ac ce 92 00 	mov    0x92ceac(,%eax,4),%eax
}
  105cfe:	c3                   	ret    
  105cff:	90                   	nop

00105d00 <container_get_quota>:


// get the maximum memory quota of process # [id]
unsigned int container_get_quota(unsigned int id)
{
  105d00:	8b 44 24 04          	mov    0x4(%esp),%eax
  return CONTAINER[id].quota;
  105d04:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105d07:	8b 04 85 a0 ce 92 00 	mov    0x92cea0(,%eax,4),%eax
}
  105d0e:	c3                   	ret    
  105d0f:	90                   	nop

00105d10 <container_get_usage>:


// get the current memory usage of process # [id]
unsigned int container_get_usage(unsigned int id)
{
  105d10:	8b 44 24 04          	mov    0x4(%esp),%eax
  return CONTAINER[id].usage;
  105d14:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105d17:	8b 04 85 a4 ce 92 00 	mov    0x92cea4(,%eax,4),%eax
}
  105d1e:	c3                   	ret    
  105d1f:	90                   	nop

00105d20 <container_can_consume>:


// determines whether the process # [id] can consume extra
// [n] pages of memory. If so, returns 1, o.w., returns 0.
unsigned int container_can_consume(unsigned int id, unsigned int n)
{
  105d20:	8b 44 24 04          	mov    0x4(%esp),%eax
  if (CONTAINER[id].usage + n > CONTAINER[id].quota) return 0;
  105d24:	8d 14 80             	lea    (%eax,%eax,4),%edx
  105d27:	c1 e2 02             	shl    $0x2,%edx
  105d2a:	8b 82 a4 ce 92 00    	mov    0x92cea4(%edx),%eax
  105d30:	03 44 24 08          	add    0x8(%esp),%eax
  105d34:	3b 82 a0 ce 92 00    	cmp    0x92cea0(%edx),%eax
  105d3a:	0f 96 c0             	setbe  %al
  105d3d:	0f b6 c0             	movzbl %al,%eax
  return 1;
}
  105d40:	c3                   	ret    
  105d41:	eb 0d                	jmp    105d50 <container_split>
  105d43:	90                   	nop
  105d44:	90                   	nop
  105d45:	90                   	nop
  105d46:	90                   	nop
  105d47:	90                   	nop
  105d48:	90                   	nop
  105d49:	90                   	nop
  105d4a:	90                   	nop
  105d4b:	90                   	nop
  105d4c:	90                   	nop
  105d4d:	90                   	nop
  105d4e:	90                   	nop
  105d4f:	90                   	nop

00105d50 <container_split>:
 * dedicates [quota] pages of memory for a new child process.
 * you can assume it is safe to allocate [quota] pages (i.e., the check is already done outside before calling this function)
 * returns the container index for the new child process.
 */
unsigned int container_split(unsigned int id, unsigned int quota)
{
  105d50:	55                   	push   %ebp
  105d51:	57                   	push   %edi
  105d52:	56                   	push   %esi
  105d53:	53                   	push   %ebx
  105d54:	8b 54 24 14          	mov    0x14(%esp),%edx
  105d58:	8b 6c 24 18          	mov    0x18(%esp),%ebp
  unsigned int child, nc;

  nc = CONTAINER[id].nchildren;
  105d5c:	8d 04 92             	lea    (%edx,%edx,4),%eax
  105d5f:	8d 0c 85 a0 ce 92 00 	lea    0x92cea0(,%eax,4),%ecx
  child = id * MAX_CHILDREN + 1 + nc; //container index for the child process
  105d66:	8b 41 0c             	mov    0xc(%ecx),%eax
  105d69:	8d 78 01             	lea    0x1(%eax),%edi
  105d6c:	8d 04 52             	lea    (%edx,%edx,2),%eax
  105d6f:	01 f8                	add    %edi,%eax

  /**
   * update the container structure of both parent and child process appropriately.
   */
  CONTAINER[child].used = 1;
  105d71:	8d 34 80             	lea    (%eax,%eax,4),%esi
  105d74:	c1 e6 02             	shl    $0x2,%esi
  CONTAINER[child].quota = quota;
  105d77:	89 ae a0 ce 92 00    	mov    %ebp,0x92cea0(%esi)
  child = id * MAX_CHILDREN + 1 + nc; //container index for the child process

  /**
   * update the container structure of both parent and child process appropriately.
   */
  CONTAINER[child].used = 1;
  105d7d:	c7 86 b0 ce 92 00 01 	movl   $0x1,0x92ceb0(%esi)
  105d84:	00 00 00 
  CONTAINER[child].quota = quota;
  CONTAINER[child].usage = 0;
  105d87:	c7 86 a4 ce 92 00 00 	movl   $0x0,0x92cea4(%esi)
  105d8e:	00 00 00 
  CONTAINER[child].parent = id;
  105d91:	89 96 a8 ce 92 00    	mov    %edx,0x92cea8(%esi)
  CONTAINER[child].nchildren = 0;
  105d97:	c7 86 ac ce 92 00 00 	movl   $0x0,0x92ceac(%esi)
  105d9e:	00 00 00 

  CONTAINER[id].usage += quota;
  105da1:	01 69 04             	add    %ebp,0x4(%ecx)
  CONTAINER[id].nchildren = nc + 1;
  105da4:	89 79 0c             	mov    %edi,0xc(%ecx)

  return child;
}
  105da7:	5b                   	pop    %ebx
  105da8:	5e                   	pop    %esi
  105da9:	5f                   	pop    %edi
  105daa:	5d                   	pop    %ebp
  105dab:	c3                   	ret    
  105dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00105db0 <container_alloc>:
 * allocates one more page for process # [id], given that its usage would not exceed the quota.
 * the container structure should be updated accordingly after the allocation.
 * returns the page index of the allocated page, or 0 in the case of failure.
 */
unsigned int container_alloc(unsigned int id)
{
  105db0:	8b 44 24 04          	mov    0x4(%esp),%eax
  unsigned int u, q, i;
  u = CONTAINER[id].usage;
  105db4:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105db7:	c1 e0 02             	shl    $0x2,%eax
  105dba:	8b 88 a4 ce 92 00    	mov    0x92cea4(%eax),%ecx
  q = CONTAINER[id].quota;
  if (u == q) return 0;
  105dc0:	3b 88 a0 ce 92 00    	cmp    0x92cea0(%eax),%ecx
  105dc6:	74 10                	je     105dd8 <container_alloc+0x28>

  CONTAINER[id].usage = u + 1;
  105dc8:	83 c1 01             	add    $0x1,%ecx
  105dcb:	89 88 a4 ce 92 00    	mov    %ecx,0x92cea4(%eax)
  i = palloc();
  105dd1:	e9 8a fd ff ff       	jmp    105b60 <palloc>
  105dd6:	66 90                	xchg   %ax,%ax
  return i;
}
  105dd8:	31 c0                	xor    %eax,%eax
  105dda:	c3                   	ret    
  105ddb:	90                   	nop
  105ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00105de0 <container_free>:

// frees the physical page and reduces the usage by 1.
void container_free(unsigned int id, unsigned int page_index)
{
  105de0:	53                   	push   %ebx
  105de1:	83 ec 18             	sub    $0x18,%esp
  105de4:	8b 5c 24 24          	mov    0x24(%esp),%ebx
  if (at_is_allocated(page_index)) {
  105de8:	89 1c 24             	mov    %ebx,(%esp)
  105deb:	e8 f0 fb ff ff       	call   1059e0 <at_is_allocated>
  105df0:	85 c0                	test   %eax,%eax
  105df2:	75 0c                	jne    105e00 <container_free+0x20>
    pfree(page_index);
    if (CONTAINER[id].usage > 0)
      CONTAINER[id].usage -= 1;
  }
}
  105df4:	83 c4 18             	add    $0x18,%esp
  105df7:	5b                   	pop    %ebx
  105df8:	c3                   	ret    
  105df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

// frees the physical page and reduces the usage by 1.
void container_free(unsigned int id, unsigned int page_index)
{
  if (at_is_allocated(page_index)) {
    pfree(page_index);
  105e00:	89 1c 24             	mov    %ebx,(%esp)
  105e03:	e8 e8 fd ff ff       	call   105bf0 <pfree>
    if (CONTAINER[id].usage > 0)
  105e08:	8b 44 24 20          	mov    0x20(%esp),%eax
  105e0c:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105e0f:	8d 04 85 a0 ce 92 00 	lea    0x92cea0(,%eax,4),%eax
  105e16:	8b 50 04             	mov    0x4(%eax),%edx
  105e19:	85 d2                	test   %edx,%edx
  105e1b:	7e d7                	jle    105df4 <container_free+0x14>
      CONTAINER[id].usage -= 1;
  105e1d:	83 ea 01             	sub    $0x1,%edx
  105e20:	89 50 04             	mov    %edx,0x4(%eax)
  }
}
  105e23:	83 c4 18             	add    $0x18,%esp
  105e26:	5b                   	pop    %ebx
  105e27:	c3                   	ret    
  105e28:	66 90                	xchg   %ax,%ax
  105e2a:	66 90                	xchg   %ax,%ax
  105e2c:	66 90                	xchg   %ax,%ax
  105e2e:	66 90                	xchg   %ax,%ax

00105e30 <pt_spinlock_init>:
 */
unsigned int IDPTbl[1024][1024] gcc_aligned(PAGESIZE);



void pt_spinlock_init(){
  105e30:	83 ec 1c             	sub    $0x1c,%esp
	spinlock_init(&pt_lk);
  105e33:	c7 04 24 a0 d3 92 00 	movl   $0x92d3a0,(%esp)
  105e3a:	e8 31 f3 ff ff       	call   105170 <spinlock_init>
}
  105e3f:	83 c4 1c             	add    $0x1c,%esp
  105e42:	c3                   	ret    
  105e43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105e50 <pt_spinlock_acquire>:

void pt_spinlock_acquire(){
  105e50:	83 ec 1c             	sub    $0x1c,%esp
	spinlock_acquire(&pt_lk);
  105e53:	c7 04 24 a0 d3 92 00 	movl   $0x92d3a0,(%esp)
  105e5a:	e8 d1 f4 ff ff       	call   105330 <spinlock_acquire>
}
  105e5f:	83 c4 1c             	add    $0x1c,%esp
  105e62:	c3                   	ret    
  105e63:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105e70 <pt_spinlock_release>:

void pt_spinlock_release(){
  105e70:	83 ec 1c             	sub    $0x1c,%esp
	spinlock_release(&pt_lk);
  105e73:	c7 04 24 a0 d3 92 00 	movl   $0x92d3a0,(%esp)
  105e7a:	e8 31 f5 ff ff       	call   1053b0 <spinlock_release>
}
  105e7f:	83 c4 1c             	add    $0x1c,%esp
  105e82:	c3                   	ret    
  105e83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105e90 <set_pdir_base>:

// sets the CR3 register with the start address of the page structure for process # [index]
void set_pdir_base(unsigned int index)
{
  105e90:	8b 44 24 04          	mov    0x4(%esp),%eax
	  set_cr3(PDirPool[index]);
  105e94:	c1 e0 0c             	shl    $0xc,%eax
  105e97:	05 00 90 db 00       	add    $0xdb9000,%eax
  105e9c:	89 44 24 04          	mov    %eax,0x4(%esp)
  105ea0:	e9 ab af ff ff       	jmp    100e50 <set_cr3>
  105ea5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  105ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105eb0 <get_pdir_entry>:
}

// returns the page directory entry # [pde_index] of the process # [proc_index]
// this can be used to test whether the page directory entry is mapped
unsigned int get_pdir_entry(unsigned int proc_index, unsigned int pde_index)
{
  105eb0:	8b 44 24 04          	mov    0x4(%esp),%eax
    unsigned int pde;
    pde = (unsigned int)PDirPool[proc_index][pde_index];
  105eb4:	c1 e0 0a             	shl    $0xa,%eax
  105eb7:	03 44 24 08          	add    0x8(%esp),%eax
    return pde;
  105ebb:	8b 04 85 00 90 db 00 	mov    0xdb9000(,%eax,4),%eax
}   
  105ec2:	c3                   	ret    
  105ec3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105ed0 <set_pdir_entry>:

// sets specified page directory entry with the start address of physical page # [page_index].
// you should also set the permissions PTE_P, PTE_W, and PTE_U
void set_pdir_entry(unsigned int proc_index, unsigned int pde_index, unsigned int page_index)
{
  105ed0:	8b 44 24 04          	mov    0x4(%esp),%eax
  105ed4:	8b 54 24 0c          	mov    0xc(%esp),%edx
    PDirPool[proc_index][pde_index] = (char *)(page_index * PAGESIZE + PT_PERM_PTU);
  105ed8:	c1 e0 0a             	shl    $0xa,%eax
  105edb:	03 44 24 08          	add    0x8(%esp),%eax
  105edf:	c1 e2 0c             	shl    $0xc,%edx
  105ee2:	83 c2 07             	add    $0x7,%edx
  105ee5:	89 14 85 00 90 db 00 	mov    %edx,0xdb9000(,%eax,4)
  105eec:	c3                   	ret    
  105eed:	8d 76 00             	lea    0x0(%esi),%esi

00105ef0 <set_pdir_entry_identity>:
// sets the page directory entry # [pde_index] for the process # [proc_index]
// with the initial address of page directory # [pde_index] in IDPTbl
// you should also set the permissions PTE_P, PTE_W, and PTE_U
// this will be used to map the page directory entry to identity page table.
void set_pdir_entry_identity(unsigned int proc_index, unsigned int pde_index)
{   
  105ef0:	8b 44 24 04          	mov    0x4(%esp),%eax
  105ef4:	8b 54 24 08          	mov    0x8(%esp),%edx
    PDirPool[proc_index][pde_index] = ((char *)(IDPTbl[pde_index])) + PT_PERM_PTU;
  105ef8:	c1 e0 0a             	shl    $0xa,%eax
  105efb:	01 d0                	add    %edx,%eax
  105efd:	c1 e2 0c             	shl    $0xc,%edx
  105f00:	81 c2 07 90 9b 00    	add    $0x9b9007,%edx
  105f06:	89 14 85 00 90 db 00 	mov    %edx,0xdb9000(,%eax,4)
  105f0d:	c3                   	ret    
  105f0e:	66 90                	xchg   %ax,%ax

00105f10 <rmv_pdir_entry>:
}   

// removes specified page directory entry (set the page directory entry to 0).
// don't forget to cast the value to (char *).
void rmv_pdir_entry(unsigned int proc_index, unsigned int pde_index)
{
  105f10:	8b 44 24 04          	mov    0x4(%esp),%eax
    PDirPool[proc_index][pde_index] = (char *)PT_PERM_UP;
  105f14:	c1 e0 0a             	shl    $0xa,%eax
  105f17:	03 44 24 08          	add    0x8(%esp),%eax
  105f1b:	c7 04 85 00 90 db 00 	movl   $0x0,0xdb9000(,%eax,4)
  105f22:	00 00 00 00 
  105f26:	c3                   	ret    
  105f27:	89 f6                	mov    %esi,%esi
  105f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105f30 <get_ptbl_entry>:
}   

// returns the specified page table entry.
// do not forget that the permission info is also stored in the page directory entries.
unsigned int get_ptbl_entry(unsigned int proc_index, unsigned int pde_index, unsigned int pte_index)
{   
  105f30:	8b 44 24 04          	mov    0x4(%esp),%eax
    unsigned int addr;
    addr = ((unsigned int)PDirPool[proc_index][pde_index] & 0xfffff000) + pte_index * 4;
    return *((unsigned int *) addr);
  105f34:	8b 54 24 0c          	mov    0xc(%esp),%edx
// returns the specified page table entry.
// do not forget that the permission info is also stored in the page directory entries.
unsigned int get_ptbl_entry(unsigned int proc_index, unsigned int pde_index, unsigned int pte_index)
{   
    unsigned int addr;
    addr = ((unsigned int)PDirPool[proc_index][pde_index] & 0xfffff000) + pte_index * 4;
  105f38:	c1 e0 0a             	shl    $0xa,%eax
  105f3b:	03 44 24 08          	add    0x8(%esp),%eax
  105f3f:	8b 04 85 00 90 db 00 	mov    0xdb9000(,%eax,4),%eax
  105f46:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    return *((unsigned int *) addr);
  105f4b:	8b 04 90             	mov    (%eax,%edx,4),%eax
}
  105f4e:	c3                   	ret    
  105f4f:	90                   	nop

00105f50 <set_ptbl_entry>:

// sets specified page table entry with the start address of physical page # [page_index]
// you should also set the given permission
void set_ptbl_entry(unsigned int proc_index, unsigned int pde_index, unsigned int pte_index, unsigned int page_index, unsigned int perm)
{   
  105f50:	8b 54 24 04          	mov    0x4(%esp),%edx
  105f54:	8b 44 24 10          	mov    0x10(%esp),%eax
    unsigned int addr;
    addr = ((unsigned int)PDirPool[proc_index][pde_index] & 0xfffff000) + pte_index * 4;
    *((unsigned int *) addr) = page_index * PAGESIZE + perm;
  105f58:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
// sets specified page table entry with the start address of physical page # [page_index]
// you should also set the given permission
void set_ptbl_entry(unsigned int proc_index, unsigned int pde_index, unsigned int pte_index, unsigned int page_index, unsigned int perm)
{   
    unsigned int addr;
    addr = ((unsigned int)PDirPool[proc_index][pde_index] & 0xfffff000) + pte_index * 4;
  105f5c:	c1 e2 0a             	shl    $0xa,%edx
  105f5f:	03 54 24 08          	add    0x8(%esp),%edx
    *((unsigned int *) addr) = page_index * PAGESIZE + perm;
  105f63:	c1 e0 0c             	shl    $0xc,%eax
  105f66:	03 44 24 14          	add    0x14(%esp),%eax
// sets specified page table entry with the start address of physical page # [page_index]
// you should also set the given permission
void set_ptbl_entry(unsigned int proc_index, unsigned int pde_index, unsigned int pte_index, unsigned int page_index, unsigned int perm)
{   
    unsigned int addr;
    addr = ((unsigned int)PDirPool[proc_index][pde_index] & 0xfffff000) + pte_index * 4;
  105f6a:	8b 14 95 00 90 db 00 	mov    0xdb9000(,%edx,4),%edx
  105f71:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
    *((unsigned int *) addr) = page_index * PAGESIZE + perm;
  105f77:	89 04 8a             	mov    %eax,(%edx,%ecx,4)
  105f7a:	c3                   	ret    
  105f7b:	90                   	nop
  105f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00105f80 <set_ptbl_entry_identity>:
}   

// sets the specified page table entry in IDPTbl as the identity map.
// you should also set the given permission
void set_ptbl_entry_identity(unsigned int pde_index, unsigned int pte_index, unsigned int perm)
{
  105f80:	8b 44 24 04          	mov    0x4(%esp),%eax
    IDPTbl[pde_index][pte_index] = (pde_index * 1024 + pte_index) * PAGESIZE + perm;
  105f84:	c1 e0 0a             	shl    $0xa,%eax
  105f87:	03 44 24 08          	add    0x8(%esp),%eax
  105f8b:	89 c2                	mov    %eax,%edx
  105f8d:	c1 e2 0c             	shl    $0xc,%edx
  105f90:	03 54 24 0c          	add    0xc(%esp),%edx
  105f94:	89 14 85 00 90 9b 00 	mov    %edx,0x9b9000(,%eax,4)
  105f9b:	c3                   	ret    
  105f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00105fa0 <rmv_ptbl_entry>:
}

// sets the specified page table entry to 0
void rmv_ptbl_entry(unsigned int proc_index, unsigned int pde_index, unsigned int pte_index)
{
  105fa0:	8b 44 24 04          	mov    0x4(%esp),%eax
    unsigned int addr;
    addr = ((unsigned int)PDirPool[proc_index][pde_index] & 0xfffff000) + pte_index * 4;
    *((unsigned int *) addr) = 0;
  105fa4:	8b 54 24 0c          	mov    0xc(%esp),%edx

// sets the specified page table entry to 0
void rmv_ptbl_entry(unsigned int proc_index, unsigned int pde_index, unsigned int pte_index)
{
    unsigned int addr;
    addr = ((unsigned int)PDirPool[proc_index][pde_index] & 0xfffff000) + pte_index * 4;
  105fa8:	c1 e0 0a             	shl    $0xa,%eax
  105fab:	03 44 24 08          	add    0x8(%esp),%eax
  105faf:	8b 04 85 00 90 db 00 	mov    0xdb9000(,%eax,4),%eax
  105fb6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    *((unsigned int *) addr) = 0;
  105fbb:	c7 04 90 00 00 00 00 	movl   $0x0,(%eax,%edx,4)
  105fc2:	c3                   	ret    
  105fc3:	66 90                	xchg   %ax,%ax
  105fc5:	66 90                	xchg   %ax,%ax
  105fc7:	66 90                	xchg   %ax,%ax
  105fc9:	66 90                	xchg   %ax,%ax
  105fcb:	66 90                	xchg   %ax,%ax
  105fcd:	66 90                	xchg   %ax,%ax
  105fcf:	90                   	nop

00105fd0 <get_ptbl_entry_by_va>:
 * Returns the page table entry corresponding to the virtual address,
 * according to the page structure of process # [proc_index].
 * Returns 0 if the mapping does not exist.
 */
unsigned int get_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
  105fd0:	57                   	push   %edi
  105fd1:	56                   	push   %esi
  105fd2:	53                   	push   %ebx
  105fd3:	83 ec 10             	sub    $0x10,%esp
  105fd6:	8b 74 24 24          	mov    0x24(%esp),%esi
  105fda:	8b 5c 24 20          	mov    0x20(%esp),%ebx
    unsigned int pde_index;
    unsigned int pte_index;
    unsigned int ptbl_entry;
    unsigned int pde;
    pde_index = vaddr / (4096 * 1024);
  105fde:	89 f7                	mov    %esi,%edi
  105fe0:	c1 ef 16             	shr    $0x16,%edi
    pde = get_pdir_entry(proc_index, pde_index);
  105fe3:	89 7c 24 04          	mov    %edi,0x4(%esp)
  105fe7:	89 1c 24             	mov    %ebx,(%esp)
  105fea:	e8 c1 fe ff ff       	call   105eb0 <get_pdir_entry>
    if (pde == 0)
      return 0;
  105fef:	31 d2                	xor    %edx,%edx
    unsigned int pte_index;
    unsigned int ptbl_entry;
    unsigned int pde;
    pde_index = vaddr / (4096 * 1024);
    pde = get_pdir_entry(proc_index, pde_index);
    if (pde == 0)
  105ff1:	85 c0                	test   %eax,%eax
  105ff3:	74 1b                	je     106010 <get_ptbl_entry_by_va+0x40>
      return 0;
    pte_index = (vaddr / 4096) % 1024;
  105ff5:	c1 ee 0c             	shr    $0xc,%esi
  105ff8:	81 e6 ff 03 00 00    	and    $0x3ff,%esi
    ptbl_entry = get_ptbl_entry(proc_index, pde_index, pte_index);
  105ffe:	89 74 24 08          	mov    %esi,0x8(%esp)
  106002:	89 7c 24 04          	mov    %edi,0x4(%esp)
  106006:	89 1c 24             	mov    %ebx,(%esp)
  106009:	e8 22 ff ff ff       	call   105f30 <get_ptbl_entry>
  10600e:	89 c2                	mov    %eax,%edx
    return ptbl_entry;
}         
  106010:	83 c4 10             	add    $0x10,%esp
  106013:	89 d0                	mov    %edx,%eax
  106015:	5b                   	pop    %ebx
  106016:	5e                   	pop    %esi
  106017:	5f                   	pop    %edi
  106018:	c3                   	ret    
  106019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00106020 <get_pdir_entry_by_va>:
unsigned int get_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
    unsigned int pde_index;
    unsigned int page_index;
    pde_index = vaddr / (4096 * 1024);
    page_index = get_pdir_entry(proc_index, pde_index);
  106020:	c1 6c 24 08 16       	shrl   $0x16,0x8(%esp)
  106025:	e9 86 fe ff ff       	jmp    105eb0 <get_pdir_entry>
  10602a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00106030 <rmv_ptbl_entry_by_va>:
    return page_index;
}

// removes the page table entry for the given virtual address
void rmv_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
  106030:	83 ec 1c             	sub    $0x1c,%esp
  106033:	8b 54 24 24          	mov    0x24(%esp),%edx
    unsigned int pde_index;
    unsigned int pte_index;
    pde_index = vaddr / (4096 * 1024);
    pte_index = (vaddr / 4096) % 1024;
  106037:	89 d0                	mov    %edx,%eax
  106039:	c1 e8 0c             	shr    $0xc,%eax
  10603c:	25 ff 03 00 00       	and    $0x3ff,%eax
    rmv_ptbl_entry(proc_index, pde_index, pte_index);
  106041:	89 44 24 08          	mov    %eax,0x8(%esp)
  106045:	8b 44 24 20          	mov    0x20(%esp),%eax
// removes the page table entry for the given virtual address
void rmv_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
    unsigned int pde_index;
    unsigned int pte_index;
    pde_index = vaddr / (4096 * 1024);
  106049:	c1 ea 16             	shr    $0x16,%edx
    pte_index = (vaddr / 4096) % 1024;
    rmv_ptbl_entry(proc_index, pde_index, pte_index);
  10604c:	89 54 24 04          	mov    %edx,0x4(%esp)
  106050:	89 04 24             	mov    %eax,(%esp)
  106053:	e8 48 ff ff ff       	call   105fa0 <rmv_ptbl_entry>
}
  106058:	83 c4 1c             	add    $0x1c,%esp
  10605b:	c3                   	ret    
  10605c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00106060 <rmv_pdir_entry_by_va>:
// removes the page directory entry for the given virtual address
void rmv_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
    unsigned int pde_index;
    pde_index = vaddr / (4096 * 1024);
    rmv_pdir_entry(proc_index, pde_index);
  106060:	c1 6c 24 08 16       	shrl   $0x16,0x8(%esp)
  106065:	e9 a6 fe ff ff       	jmp    105f10 <rmv_pdir_entry>
  10606a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00106070 <set_ptbl_entry_by_va>:
}

// maps the virtual address [vaddr] to the physical page # [page_index] with permission [perm]
// you do not need to worry about the page directory entry. just map the page table entry.
void set_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr, unsigned int page_index, unsigned int perm)
{
  106070:	83 ec 2c             	sub    $0x2c,%esp
    unsigned int pde_index;
    unsigned int pte_index;
    pde_index = vaddr / (4096 * 1024);
    pte_index = (vaddr / 4096) % 1024;
    set_ptbl_entry(proc_index, pde_index, pte_index, page_index, perm);
  106073:	8b 44 24 3c          	mov    0x3c(%esp),%eax
}

// maps the virtual address [vaddr] to the physical page # [page_index] with permission [perm]
// you do not need to worry about the page directory entry. just map the page table entry.
void set_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr, unsigned int page_index, unsigned int perm)
{
  106077:	8b 54 24 34          	mov    0x34(%esp),%edx
    unsigned int pde_index;
    unsigned int pte_index;
    pde_index = vaddr / (4096 * 1024);
    pte_index = (vaddr / 4096) % 1024;
    set_ptbl_entry(proc_index, pde_index, pte_index, page_index, perm);
  10607b:	89 44 24 10          	mov    %eax,0x10(%esp)
  10607f:	8b 44 24 38          	mov    0x38(%esp),%eax
  106083:	89 44 24 0c          	mov    %eax,0xc(%esp)
void set_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr, unsigned int page_index, unsigned int perm)
{
    unsigned int pde_index;
    unsigned int pte_index;
    pde_index = vaddr / (4096 * 1024);
    pte_index = (vaddr / 4096) % 1024;
  106087:	89 d0                	mov    %edx,%eax
  106089:	c1 e8 0c             	shr    $0xc,%eax
  10608c:	25 ff 03 00 00       	and    $0x3ff,%eax
    set_ptbl_entry(proc_index, pde_index, pte_index, page_index, perm);
  106091:	89 44 24 08          	mov    %eax,0x8(%esp)
  106095:	8b 44 24 30          	mov    0x30(%esp),%eax
// you do not need to worry about the page directory entry. just map the page table entry.
void set_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr, unsigned int page_index, unsigned int perm)
{
    unsigned int pde_index;
    unsigned int pte_index;
    pde_index = vaddr / (4096 * 1024);
  106099:	c1 ea 16             	shr    $0x16,%edx
    pte_index = (vaddr / 4096) % 1024;
    set_ptbl_entry(proc_index, pde_index, pte_index, page_index, perm);
  10609c:	89 54 24 04          	mov    %edx,0x4(%esp)
  1060a0:	89 04 24             	mov    %eax,(%esp)
  1060a3:	e8 a8 fe ff ff       	call   105f50 <set_ptbl_entry>
}
  1060a8:	83 c4 2c             	add    $0x2c,%esp
  1060ab:	c3                   	ret    
  1060ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001060b0 <set_pdir_entry_by_va>:

// registers the mapping from [vaddr] to physical page # [page_index] in the page directory
void set_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr, unsigned int page_index)
{
  1060b0:	8b 44 24 08          	mov    0x8(%esp),%eax
    unsigned int pde_index;
    pde_index = vaddr / (4096 * 1024);
  1060b4:	c1 e8 16             	shr    $0x16,%eax
    set_pdir_entry(proc_index, pde_index, page_index);
  1060b7:	89 44 24 08          	mov    %eax,0x8(%esp)
  1060bb:	e9 10 fe ff ff       	jmp    105ed0 <set_pdir_entry>

001060c0 <idptbl_init>:

// initializes the identity page table
// the permission for the kernel memory should be PTE_P, PTE_W, and PTE_G,
// while the permission for the rest should be PTE_P and PTE_W.
void idptbl_init(unsigned int mbi_adr)
{
  1060c0:	57                   	push   %edi
    unsigned int i, j;
    unsigned int perm;
    container_init(mbi_adr);

    i = 0;
  1060c1:	31 ff                	xor    %edi,%edi

// initializes the identity page table
// the permission for the kernel memory should be PTE_P, PTE_W, and PTE_G,
// while the permission for the rest should be PTE_P and PTE_W.
void idptbl_init(unsigned int mbi_adr)
{
  1060c3:	56                   	push   %esi
  1060c4:	53                   	push   %ebx
  1060c5:	83 ec 10             	sub    $0x10,%esp
    unsigned int i, j;
    unsigned int perm;
    container_init(mbi_adr);
  1060c8:	8b 44 24 20          	mov    0x20(%esp),%eax
  1060cc:	89 04 24             	mov    %eax,(%esp)
  1060cf:	e8 4c fb ff ff       	call   105c20 <container_init>
  1060d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1060d8:	8d 87 00 ff ff ff    	lea    -0x100(%edi),%eax

    i = 0;
    while(i < 1024)
    {
      if (i < 256 || i >= 960)
        perm = PTE_P | PTE_W | PTE_G;
  1060de:	3d c0 02 00 00       	cmp    $0x2c0,%eax
  1060e3:	19 f6                	sbb    %esi,%esi
      else
        perm = PTE_P | PTE_W;
      j = 0;
  1060e5:	31 db                	xor    %ebx,%ebx

    i = 0;
    while(i < 1024)
    {
      if (i < 256 || i >= 960)
        perm = PTE_P | PTE_W | PTE_G;
  1060e7:	81 e6 00 ff ff ff    	and    $0xffffff00,%esi
  1060ed:	81 c6 03 01 00 00    	add    $0x103,%esi
  1060f3:	90                   	nop
  1060f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      else
        perm = PTE_P | PTE_W;
      j = 0;
      while(j < 1024)
      {
        set_ptbl_entry_identity(i, j, perm);
  1060f8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
        j ++;
  1060fc:	83 c3 01             	add    $0x1,%ebx
      else
        perm = PTE_P | PTE_W;
      j = 0;
      while(j < 1024)
      {
        set_ptbl_entry_identity(i, j, perm);
  1060ff:	89 74 24 08          	mov    %esi,0x8(%esp)
  106103:	89 3c 24             	mov    %edi,(%esp)
  106106:	e8 75 fe ff ff       	call   105f80 <set_ptbl_entry_identity>
      if (i < 256 || i >= 960)
        perm = PTE_P | PTE_W | PTE_G;
      else
        perm = PTE_P | PTE_W;
      j = 0;
      while(j < 1024)
  10610b:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
  106111:	75 e5                	jne    1060f8 <idptbl_init+0x38>
      {
        set_ptbl_entry_identity(i, j, perm);
        j ++;
      }
      i ++;
  106113:	83 c7 01             	add    $0x1,%edi
    unsigned int i, j;
    unsigned int perm;
    container_init(mbi_adr);

    i = 0;
    while(i < 1024)
  106116:	81 ff 00 04 00 00    	cmp    $0x400,%edi
  10611c:	75 ba                	jne    1060d8 <idptbl_init+0x18>
        set_ptbl_entry_identity(i, j, perm);
        j ++;
      }
      i ++;
    }
}
  10611e:	83 c4 10             	add    $0x10,%esp
  106121:	5b                   	pop    %ebx
  106122:	5e                   	pop    %esi
  106123:	5f                   	pop    %edi
  106124:	c3                   	ret    
  106125:	66 90                	xchg   %ax,%ax
  106127:	66 90                	xchg   %ax,%ax
  106129:	66 90                	xchg   %ax,%ax
  10612b:	66 90                	xchg   %ax,%ax
  10612d:	66 90                	xchg   %ax,%ax
  10612f:	90                   	nop

00106130 <pdir_init>:
 * For each process from id 0 to NUM_IDS -1,
 * set the page directory entries sothat the kernel portion of the map as identity map,
 * and the rest of page directories are unmmaped.
 */
void pdir_init(unsigned int mbi_adr)
{
  106130:	56                   	push   %esi
    unsigned int i, j;
    idptbl_init(mbi_adr);

    i = 0;
  106131:	31 f6                	xor    %esi,%esi
 * For each process from id 0 to NUM_IDS -1,
 * set the page directory entries sothat the kernel portion of the map as identity map,
 * and the rest of page directories are unmmaped.
 */
void pdir_init(unsigned int mbi_adr)
{
  106133:	53                   	push   %ebx
  106134:	83 ec 14             	sub    $0x14,%esp
    unsigned int i, j;
    idptbl_init(mbi_adr);
  106137:	8b 44 24 20          	mov    0x20(%esp),%eax
  10613b:	89 04 24             	mov    %eax,(%esp)
  10613e:	e8 7d ff ff ff       	call   1060c0 <idptbl_init>
  106143:	90                   	nop
  106144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 * For each process from id 0 to NUM_IDS -1,
 * set the page directory entries sothat the kernel portion of the map as identity map,
 * and the rest of page directories are unmmaped.
 */
void pdir_init(unsigned int mbi_adr)
{
  106148:	31 db                	xor    %ebx,%ebx
  10614a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  106150:	8d 83 00 ff ff ff    	lea    -0x100(%ebx),%eax
    while(i < NUM_IDS)
    {
        j = 0;
        while(j < 1024)    
        {
            if (j < 256 || j >= 960)    
  106156:	3d bf 02 00 00       	cmp    $0x2bf,%eax
              set_pdir_entry_identity(i, j);
  10615b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  10615f:	89 34 24             	mov    %esi,(%esp)
    while(i < NUM_IDS)
    {
        j = 0;
        while(j < 1024)    
        {
            if (j < 256 || j >= 960)    
  106162:	77 1e                	ja     106182 <pdir_init+0x52>
              set_pdir_entry_identity(i, j);
            else
              rmv_pdir_entry(i, j);
  106164:	e8 a7 fd ff ff       	call   105f10 <rmv_pdir_entry>
            j++;
  106169:	83 c3 01             	add    $0x1,%ebx

    i = 0;
    while(i < NUM_IDS)
    {
        j = 0;
        while(j < 1024)    
  10616c:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
  106172:	75 dc                	jne    106150 <pdir_init+0x20>
              set_pdir_entry_identity(i, j);
            else
              rmv_pdir_entry(i, j);
            j++;
        }
        i++;
  106174:	83 c6 01             	add    $0x1,%esi
{
    unsigned int i, j;
    idptbl_init(mbi_adr);

    i = 0;
    while(i < NUM_IDS)
  106177:	83 fe 40             	cmp    $0x40,%esi
  10617a:	75 cc                	jne    106148 <pdir_init+0x18>
              rmv_pdir_entry(i, j);
            j++;
        }
        i++;
    }
}
  10617c:	83 c4 14             	add    $0x14,%esp
  10617f:	5b                   	pop    %ebx
  106180:	5e                   	pop    %esi
  106181:	c3                   	ret    
    {
        j = 0;
        while(j < 1024)    
        {
            if (j < 256 || j >= 960)    
              set_pdir_entry_identity(i, j);
  106182:	e8 69 fd ff ff       	call   105ef0 <set_pdir_entry_identity>
  106187:	eb e0                	jmp    106169 <pdir_init+0x39>
  106189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00106190 <alloc_ptbl>:
 * and clears (set to 0) the whole page table entries for this newly mapped page table.
 * It returns the page index of the newly allocated physical page.
 * In the case when there's no physical page available, it returns 0.
 */
unsigned int alloc_ptbl(unsigned int proc_index, unsigned int vadr)
{
  106190:	55                   	push   %ebp
  106191:	57                   	push   %edi
  106192:	56                   	push   %esi
  106193:	53                   	push   %ebx
  106194:	83 ec 1c             	sub    $0x1c,%esp
  106197:	8b 74 24 30          	mov    0x30(%esp),%esi
  unsigned int i;
  unsigned int pi;
  unsigned int pde_index;
  pi = container_alloc(proc_index);
  10619b:	89 34 24             	mov    %esi,(%esp)
  10619e:	e8 0d fc ff ff       	call   105db0 <container_alloc>
  if (pi != 0)
  1061a3:	85 c0                	test   %eax,%eax
unsigned int alloc_ptbl(unsigned int proc_index, unsigned int vadr)
{
  unsigned int i;
  unsigned int pi;
  unsigned int pde_index;
  pi = container_alloc(proc_index);
  1061a5:	89 c5                	mov    %eax,%ebp
  if (pi != 0)
  1061a7:	75 0f                	jne    1061b8 <alloc_ptbl+0x28>
      rmv_ptbl_entry(proc_index, pde_index, i);
      i ++;
    }     
  }       
  return pi;
}
  1061a9:	83 c4 1c             	add    $0x1c,%esp
  1061ac:	89 e8                	mov    %ebp,%eax
  1061ae:	5b                   	pop    %ebx
  1061af:	5e                   	pop    %esi
  1061b0:	5f                   	pop    %edi
  1061b1:	5d                   	pop    %ebp
  1061b2:	c3                   	ret    
  1061b3:	90                   	nop
  1061b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  unsigned int pi;
  unsigned int pde_index;
  pi = container_alloc(proc_index);
  if (pi != 0)
  {
    set_pdir_entry_by_va(proc_index, vadr, pi);
  1061b8:	89 44 24 08          	mov    %eax,0x8(%esp)
  1061bc:	8b 44 24 34          	mov    0x34(%esp),%eax
    pde_index = vadr / (4096 * 1024);
    i = 0;
  1061c0:	31 db                	xor    %ebx,%ebx
  unsigned int pi;
  unsigned int pde_index;
  pi = container_alloc(proc_index);
  if (pi != 0)
  {
    set_pdir_entry_by_va(proc_index, vadr, pi);
  1061c2:	89 34 24             	mov    %esi,(%esp)
  1061c5:	89 44 24 04          	mov    %eax,0x4(%esp)
  1061c9:	e8 e2 fe ff ff       	call   1060b0 <set_pdir_entry_by_va>
    pde_index = vadr / (4096 * 1024);
  1061ce:	8b 7c 24 34          	mov    0x34(%esp),%edi
  1061d2:	c1 ef 16             	shr    $0x16,%edi
  1061d5:	8d 76 00             	lea    0x0(%esi),%esi
    i = 0;
    while (i < 1024)        
    {
      rmv_ptbl_entry(proc_index, pde_index, i);
  1061d8:	89 5c 24 08          	mov    %ebx,0x8(%esp)
      i ++;
  1061dc:	83 c3 01             	add    $0x1,%ebx
    set_pdir_entry_by_va(proc_index, vadr, pi);
    pde_index = vadr / (4096 * 1024);
    i = 0;
    while (i < 1024)        
    {
      rmv_ptbl_entry(proc_index, pde_index, i);
  1061df:	89 7c 24 04          	mov    %edi,0x4(%esp)
  1061e3:	89 34 24             	mov    %esi,(%esp)
  1061e6:	e8 b5 fd ff ff       	call   105fa0 <rmv_ptbl_entry>
  if (pi != 0)
  {
    set_pdir_entry_by_va(proc_index, vadr, pi);
    pde_index = vadr / (4096 * 1024);
    i = 0;
    while (i < 1024)        
  1061eb:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
  1061f1:	75 e5                	jne    1061d8 <alloc_ptbl+0x48>
      rmv_ptbl_entry(proc_index, pde_index, i);
      i ++;
    }     
  }       
  return pi;
}
  1061f3:	83 c4 1c             	add    $0x1c,%esp
  1061f6:	89 e8                	mov    %ebp,%eax
  1061f8:	5b                   	pop    %ebx
  1061f9:	5e                   	pop    %esi
  1061fa:	5f                   	pop    %edi
  1061fb:	5d                   	pop    %ebp
  1061fc:	c3                   	ret    
  1061fd:	8d 76 00             	lea    0x0(%esi),%esi

00106200 <free_ptbl>:

// Reverse operation of alloc_ptbl.
// Removes corresponding page directory entry,
// and frees the page for the page table entries (with container_free).
void free_ptbl(unsigned int proc_index, unsigned int vadr)
{
  106200:	57                   	push   %edi
  106201:	56                   	push   %esi
  106202:	53                   	push   %ebx
  106203:	83 ec 10             	sub    $0x10,%esp
  106206:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  10620a:	8b 74 24 24          	mov    0x24(%esp),%esi
  unsigned int pde;
  pde = get_pdir_entry_by_va(proc_index, vadr);
  10620e:	89 1c 24             	mov    %ebx,(%esp)
  106211:	89 74 24 04          	mov    %esi,0x4(%esp)
  106215:	e8 06 fe ff ff       	call   106020 <get_pdir_entry_by_va>
  rmv_pdir_entry_by_va(proc_index, vadr);
  10621a:	89 74 24 04          	mov    %esi,0x4(%esp)
  10621e:	89 1c 24             	mov    %ebx,(%esp)
// Removes corresponding page directory entry,
// and frees the page for the page table entries (with container_free).
void free_ptbl(unsigned int proc_index, unsigned int vadr)
{
  unsigned int pde;
  pde = get_pdir_entry_by_va(proc_index, vadr);
  106221:	89 c7                	mov    %eax,%edi
  rmv_pdir_entry_by_va(proc_index, vadr);
  106223:	e8 38 fe ff ff       	call   106060 <rmv_pdir_entry_by_va>
  container_free(proc_index, pde / PAGESIZE);
  106228:	c1 ef 0c             	shr    $0xc,%edi
  10622b:	89 7c 24 24          	mov    %edi,0x24(%esp)
  10622f:	89 5c 24 20          	mov    %ebx,0x20(%esp)
}
  106233:	83 c4 10             	add    $0x10,%esp
  106236:	5b                   	pop    %ebx
  106237:	5e                   	pop    %esi
  106238:	5f                   	pop    %edi
void free_ptbl(unsigned int proc_index, unsigned int vadr)
{
  unsigned int pde;
  pde = get_pdir_entry_by_va(proc_index, vadr);
  rmv_pdir_entry_by_va(proc_index, vadr);
  container_free(proc_index, pde / PAGESIZE);
  106239:	e9 a2 fb ff ff       	jmp    105de0 <container_free>
  10623e:	66 90                	xchg   %ax,%ax

00106240 <pdir_init_kern>:
/**
 * Sets the entire page map for process 0 as identity map.
 * Note that part of the task is already completed by pdir_init.
 */
void pdir_init_kern(unsigned int mbi_adr)
{
  106240:	53                   	push   %ebx
    unsigned int i;
    pdir_init(mbi_adr);
    
    i = 256;
  106241:	bb 00 01 00 00       	mov    $0x100,%ebx
/**
 * Sets the entire page map for process 0 as identity map.
 * Note that part of the task is already completed by pdir_init.
 */
void pdir_init_kern(unsigned int mbi_adr)
{
  106246:	83 ec 18             	sub    $0x18,%esp
    unsigned int i;
    pdir_init(mbi_adr);
  106249:	8b 44 24 20          	mov    0x20(%esp),%eax
  10624d:	89 04 24             	mov    %eax,(%esp)
  106250:	e8 db fe ff ff       	call   106130 <pdir_init>
  106255:	8d 76 00             	lea    0x0(%esi),%esi
    
    i = 256;
    while(i < 960)
    {
        set_pdir_entry_identity(0, i);
  106258:	89 5c 24 04          	mov    %ebx,0x4(%esp)
        i ++;
  10625c:	83 c3 01             	add    $0x1,%ebx
    pdir_init(mbi_adr);
    
    i = 256;
    while(i < 960)
    {
        set_pdir_entry_identity(0, i);
  10625f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  106266:	e8 85 fc ff ff       	call   105ef0 <set_pdir_entry_identity>
{
    unsigned int i;
    pdir_init(mbi_adr);
    
    i = 256;
    while(i < 960)
  10626b:	81 fb c0 03 00 00    	cmp    $0x3c0,%ebx
  106271:	75 e5                	jne    106258 <pdir_init_kern+0x18>
    {
        set_pdir_entry_identity(0, i);
        i ++;
    }
}
  106273:	83 c4 18             	add    $0x18,%esp
  106276:	5b                   	pop    %ebx
  106277:	c3                   	ret    
  106278:	90                   	nop
  106279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00106280 <map_page>:
 * In the case of error (when the allocation fails), it returns the constant MagicNumber defined in lib/x86.h,
 * and when the page table is not set up , it returns the physical page index for the newly alloacted page table,
 * otherwise, it returns 0.
 */
unsigned int map_page(unsigned int proc_index, unsigned int vadr, unsigned int page_index, unsigned int perm)
{   
  106280:	57                   	push   %edi
  unsigned int pdir_entry; 
  unsigned int result;
  pdir_entry = get_pdir_entry_by_va(proc_index, vadr);
  if (pdir_entry != 0)
    result = 0;
  106281:	31 ff                	xor    %edi,%edi
 * In the case of error (when the allocation fails), it returns the constant MagicNumber defined in lib/x86.h,
 * and when the page table is not set up , it returns the physical page index for the newly alloacted page table,
 * otherwise, it returns 0.
 */
unsigned int map_page(unsigned int proc_index, unsigned int vadr, unsigned int page_index, unsigned int perm)
{   
  106283:	56                   	push   %esi
  106284:	53                   	push   %ebx
  106285:	83 ec 10             	sub    $0x10,%esp
  106288:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  10628c:	8b 74 24 24          	mov    0x24(%esp),%esi
  unsigned int pdir_entry; 
  unsigned int result;
  pdir_entry = get_pdir_entry_by_va(proc_index, vadr);
  106290:	89 1c 24             	mov    %ebx,(%esp)
  106293:	89 74 24 04          	mov    %esi,0x4(%esp)
  106297:	e8 84 fd ff ff       	call   106020 <get_pdir_entry_by_va>
  if (pdir_entry != 0)
  10629c:	85 c0                	test   %eax,%eax
  10629e:	74 28                	je     1062c8 <map_page+0x48>
    result = alloc_ptbl(proc_index, vadr);
    if (result == 0)
      result = MagicNumber;
  }
  if (result != MagicNumber)
    set_ptbl_entry_by_va(proc_index, vadr, page_index, perm);
  1062a0:	8b 44 24 2c          	mov    0x2c(%esp),%eax
  1062a4:	89 74 24 04          	mov    %esi,0x4(%esp)
  1062a8:	89 1c 24             	mov    %ebx,(%esp)
  1062ab:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1062af:	8b 44 24 28          	mov    0x28(%esp),%eax
  1062b3:	89 44 24 08          	mov    %eax,0x8(%esp)
  1062b7:	e8 b4 fd ff ff       	call   106070 <set_ptbl_entry_by_va>
  return result;
}
  1062bc:	83 c4 10             	add    $0x10,%esp
  1062bf:	89 f8                	mov    %edi,%eax
  1062c1:	5b                   	pop    %ebx
  1062c2:	5e                   	pop    %esi
  1062c3:	5f                   	pop    %edi
  1062c4:	c3                   	ret    
  1062c5:	8d 76 00             	lea    0x0(%esi),%esi
  pdir_entry = get_pdir_entry_by_va(proc_index, vadr);
  if (pdir_entry != 0)
    result = 0;
  else
  {
    result = alloc_ptbl(proc_index, vadr);
  1062c8:	89 74 24 04          	mov    %esi,0x4(%esp)
  1062cc:	89 1c 24             	mov    %ebx,(%esp)
  1062cf:	e8 bc fe ff ff       	call   106190 <alloc_ptbl>
    if (result == 0)
  1062d4:	85 c0                	test   %eax,%eax
  pdir_entry = get_pdir_entry_by_va(proc_index, vadr);
  if (pdir_entry != 0)
    result = 0;
  else
  {
    result = alloc_ptbl(proc_index, vadr);
  1062d6:	89 c7                	mov    %eax,%edi
    if (result == 0)
  1062d8:	75 0e                	jne    1062e8 <map_page+0x68>
      result = MagicNumber;
  }
  if (result != MagicNumber)
    set_ptbl_entry_by_va(proc_index, vadr, page_index, perm);
  return result;
}
  1062da:	83 c4 10             	add    $0x10,%esp
    result = 0;
  else
  {
    result = alloc_ptbl(proc_index, vadr);
    if (result == 0)
      result = MagicNumber;
  1062dd:	bf 01 00 10 00       	mov    $0x100001,%edi
  }
  if (result != MagicNumber)
    set_ptbl_entry_by_va(proc_index, vadr, page_index, perm);
  return result;
}
  1062e2:	89 f8                	mov    %edi,%eax
  1062e4:	5b                   	pop    %ebx
  1062e5:	5e                   	pop    %esi
  1062e6:	5f                   	pop    %edi
  1062e7:	c3                   	ret    
  {
    result = alloc_ptbl(proc_index, vadr);
    if (result == 0)
      result = MagicNumber;
  }
  if (result != MagicNumber)
  1062e8:	3d 01 00 10 00       	cmp    $0x100001,%eax
  1062ed:	74 cd                	je     1062bc <map_page+0x3c>
  1062ef:	eb af                	jmp    1062a0 <map_page+0x20>
  1062f1:	eb 0d                	jmp    106300 <unmap_page>
  1062f3:	90                   	nop
  1062f4:	90                   	nop
  1062f5:	90                   	nop
  1062f6:	90                   	nop
  1062f7:	90                   	nop
  1062f8:	90                   	nop
  1062f9:	90                   	nop
  1062fa:	90                   	nop
  1062fb:	90                   	nop
  1062fc:	90                   	nop
  1062fd:	90                   	nop
  1062fe:	90                   	nop
  1062ff:	90                   	nop

00106300 <unmap_page>:
 * Nothing should be done if the mapping no longer exists.
 * You do not need to unmap the page table from the page directory.
 * It should return the corresponding page table entry.
 */
unsigned int unmap_page(unsigned int proc_index, unsigned int vadr)
{
  106300:	56                   	push   %esi
  106301:	53                   	push   %ebx
  106302:	83 ec 14             	sub    $0x14,%esp
  106305:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  106309:	8b 74 24 24          	mov    0x24(%esp),%esi
  unsigned int ptbl_entry;
  unsigned int count;
  ptbl_entry = get_ptbl_entry_by_va(proc_index, vadr);
  10630d:	89 1c 24             	mov    %ebx,(%esp)
  106310:	89 74 24 04          	mov    %esi,0x4(%esp)
  106314:	e8 b7 fc ff ff       	call   105fd0 <get_ptbl_entry_by_va>
  if (ptbl_entry != 0)
  106319:	85 c0                	test   %eax,%eax
  10631b:	74 14                	je     106331 <unmap_page+0x31>
    rmv_ptbl_entry_by_va(proc_index, vadr);
  10631d:	89 74 24 04          	mov    %esi,0x4(%esp)
  106321:	89 1c 24             	mov    %ebx,(%esp)
  106324:	89 44 24 0c          	mov    %eax,0xc(%esp)
  106328:	e8 03 fd ff ff       	call   106030 <rmv_ptbl_entry_by_va>
  10632d:	8b 44 24 0c          	mov    0xc(%esp),%eax
  return ptbl_entry;
}   
  106331:	83 c4 14             	add    $0x14,%esp
  106334:	5b                   	pop    %ebx
  106335:	5e                   	pop    %esi
  106336:	c3                   	ret    
  106337:	66 90                	xchg   %ax,%ax
  106339:	66 90                	xchg   %ax,%ax
  10633b:	66 90                	xchg   %ax,%ax
  10633d:	66 90                	xchg   %ax,%ax
  10633f:	90                   	nop

00106340 <paging_init>:
 * Initializes the page structures,
 * move to the page structure # 0 (kernel).
 * and turn on the paging.
 */
void paging_init(unsigned int mbi_addr)
{
  106340:	53                   	push   %ebx
  106341:	83 ec 18             	sub    $0x18,%esp
  106344:	8b 5c 24 20          	mov    0x20(%esp),%ebx
	pt_spinlock_init();
  106348:	e8 e3 fa ff ff       	call   105e30 <pt_spinlock_init>
	pdir_init_kern(mbi_addr);
  10634d:	89 1c 24             	mov    %ebx,(%esp)
  106350:	e8 eb fe ff ff       	call   106240 <pdir_init_kern>
	pt_spinlock_acquire();
  106355:	e8 f6 fa ff ff       	call   105e50 <pt_spinlock_acquire>
	set_pdir_base(0);
  10635a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  106361:	e8 2a fb ff ff       	call   105e90 <set_pdir_base>
	enable_paging();
  106366:	e8 f5 aa ff ff       	call   100e60 <enable_paging>
	pt_spinlock_release();
}
  10636b:	83 c4 18             	add    $0x18,%esp
  10636e:	5b                   	pop    %ebx
	pt_spinlock_init();
	pdir_init_kern(mbi_addr);
	pt_spinlock_acquire();
	set_pdir_base(0);
	enable_paging();
	pt_spinlock_release();
  10636f:	e9 fc fa ff ff       	jmp    105e70 <pt_spinlock_release>
  106374:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10637a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00106380 <paging_init_ap>:
}

void paging_init_ap(void)
{
  106380:	83 ec 1c             	sub    $0x1c,%esp
	pt_spinlock_acquire();
  106383:	e8 c8 fa ff ff       	call   105e50 <pt_spinlock_acquire>
	set_pdir_base(0);
  106388:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10638f:	e8 fc fa ff ff       	call   105e90 <set_pdir_base>
	enable_paging();
  106394:	e8 c7 aa ff ff       	call   100e60 <enable_paging>
	pt_spinlock_release();
}
  106399:	83 c4 1c             	add    $0x1c,%esp
void paging_init_ap(void)
{
	pt_spinlock_acquire();
	set_pdir_base(0);
	enable_paging();
	pt_spinlock_release();
  10639c:	e9 cf fa ff ff       	jmp    105e70 <pt_spinlock_release>
  1063a1:	66 90                	xchg   %ax,%ax
  1063a3:	66 90                	xchg   %ax,%ax
  1063a5:	66 90                	xchg   %ax,%ax
  1063a7:	66 90                	xchg   %ax,%ax
  1063a9:	66 90                	xchg   %ax,%ax
  1063ab:	66 90                	xchg   %ax,%ax
  1063ad:	66 90                	xchg   %ax,%ax
  1063af:	90                   	nop

001063b0 <alloc_page>:
 * It should return the physical page index registered in the page directory, i.e., the
 * return value from map_page.
 * In the case of error, it should return the MagicNumber.
 */
unsigned int alloc_page (unsigned int proc_index, unsigned int vaddr, unsigned int perm)
{
  1063b0:	56                   	push   %esi

	pt_spinlock_acquire();
	pi = container_alloc (proc_index);

	if (pi == 0)
		result = MagicNumber;
  1063b1:	be 01 00 10 00       	mov    $0x100001,%esi
 * It should return the physical page index registered in the page directory, i.e., the
 * return value from map_page.
 * In the case of error, it should return the MagicNumber.
 */
unsigned int alloc_page (unsigned int proc_index, unsigned int vaddr, unsigned int perm)
{
  1063b6:	53                   	push   %ebx
  1063b7:	83 ec 14             	sub    $0x14,%esp
  1063ba:	8b 5c 24 20          	mov    0x20(%esp),%ebx
	unsigned int pi;
	unsigned int result;

	pt_spinlock_acquire();
  1063be:	e8 8d fa ff ff       	call   105e50 <pt_spinlock_acquire>
	pi = container_alloc (proc_index);
  1063c3:	89 1c 24             	mov    %ebx,(%esp)
  1063c6:	e8 e5 f9 ff ff       	call   105db0 <container_alloc>

	if (pi == 0)
  1063cb:	85 c0                	test   %eax,%eax
  1063cd:	75 11                	jne    1063e0 <alloc_page+0x30>
		result = MagicNumber;
	else
		result = map_page (proc_index, vaddr, pi, perm);


	pt_spinlock_release();
  1063cf:	e8 9c fa ff ff       	call   105e70 <pt_spinlock_release>
	return result;
}
  1063d4:	83 c4 14             	add    $0x14,%esp
  1063d7:	89 f0                	mov    %esi,%eax
  1063d9:	5b                   	pop    %ebx
  1063da:	5e                   	pop    %esi
  1063db:	c3                   	ret    
  1063dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	pi = container_alloc (proc_index);

	if (pi == 0)
		result = MagicNumber;
	else
		result = map_page (proc_index, vaddr, pi, perm);
  1063e0:	8b 54 24 28          	mov    0x28(%esp),%edx
  1063e4:	89 44 24 08          	mov    %eax,0x8(%esp)
  1063e8:	8b 44 24 24          	mov    0x24(%esp),%eax
  1063ec:	89 1c 24             	mov    %ebx,(%esp)
  1063ef:	89 54 24 0c          	mov    %edx,0xc(%esp)
  1063f3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1063f7:	e8 84 fe ff ff       	call   106280 <map_page>
  1063fc:	89 c6                	mov    %eax,%esi


	pt_spinlock_release();
  1063fe:	e8 6d fa ff ff       	call   105e70 <pt_spinlock_release>
	return result;
}
  106403:	83 c4 14             	add    $0x14,%esp
  106406:	89 f0                	mov    %esi,%eax
  106408:	5b                   	pop    %ebx
  106409:	5e                   	pop    %esi
  10640a:	c3                   	ret    
  10640b:	90                   	nop
  10640c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00106410 <alloc_mem_quota>:
 * Designate some memory quota for the next child process.
 */
unsigned int alloc_mem_quota (unsigned int id, unsigned int quota)
{
	unsigned int child;
  child = container_split (id, quota);
  106410:	e9 3b f9 ff ff       	jmp    105d50 <container_split>
  106415:	66 90                	xchg   %ax,%ax
  106417:	66 90                	xchg   %ax,%ax
  106419:	66 90                	xchg   %ax,%ax
  10641b:	66 90                	xchg   %ax,%ax
  10641d:	66 90                	xchg   %ax,%ax
  10641f:	90                   	nop

00106420 <kctx_set_esp>:

//places to save the [NUM_IDS] kernel thread states.
struct kctx kctx_pool[NUM_IDS];

void kctx_set_esp(unsigned int pid, void *esp)
{
  106420:	8b 44 24 04          	mov    0x4(%esp),%eax
	kctx_pool[pid].esp = esp;
  106424:	8b 54 24 08          	mov    0x8(%esp),%edx
  106428:	8d 04 40             	lea    (%eax,%eax,2),%eax
  10642b:	89 14 c5 00 90 df 00 	mov    %edx,0xdf9000(,%eax,8)
  106432:	c3                   	ret    
  106433:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  106439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106440 <kctx_set_eip>:
}

void kctx_set_eip(unsigned int pid, void *eip)
{
  106440:	8b 44 24 04          	mov    0x4(%esp),%eax
	kctx_pool[pid].eip = eip;
  106444:	8b 54 24 08          	mov    0x8(%esp),%edx
  106448:	8d 04 40             	lea    (%eax,%eax,2),%eax
  10644b:	89 14 c5 14 90 df 00 	mov    %edx,0xdf9014(,%eax,8)
  106452:	c3                   	ret    
  106453:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  106459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106460 <kctx_switch>:
/**
 * Saves the states for thread # [from_pid] and restores the states
 * for thread # [to_pid].
 */
void kctx_switch(unsigned int from_pid, unsigned int to_pid)
{
  106460:	8b 44 24 04          	mov    0x4(%esp),%eax
  106464:	8b 54 24 08          	mov    0x8(%esp),%edx
	cswitch(&kctx_pool[from_pid], &kctx_pool[to_pid]);
  106468:	8d 04 40             	lea    (%eax,%eax,2),%eax
  10646b:	8d 14 52             	lea    (%edx,%edx,2),%edx
  10646e:	8d 14 d5 00 90 df 00 	lea    0xdf9000(,%edx,8),%edx
  106475:	8d 04 c5 00 90 df 00 	lea    0xdf9000(,%eax,8),%eax
  10647c:	89 54 24 08          	mov    %edx,0x8(%esp)
  106480:	89 44 24 04          	mov    %eax,0x4(%esp)
  106484:	e9 03 00 00 00       	jmp    10648c <cswitch>
  106489:	66 90                	xchg   %ax,%ax
  10648b:	90                   	nop

0010648c <cswitch>:
 * void cswitch(struct kctx *from, struct kctx *to);
 */

	.globl cswitch
cswitch:
	movl	  4(%esp), %eax	/* %eax <- from */
  10648c:	8b 44 24 04          	mov    0x4(%esp),%eax
	movl	  8(%esp), %edx	/* %edx <- to */
  106490:	8b 54 24 08          	mov    0x8(%esp),%edx

	/* save the old kernel context */
  movl    0(%esp), %ecx
  106494:	8b 0c 24             	mov    (%esp),%ecx
  movl    %ecx, 20(%eax)
  106497:	89 48 14             	mov    %ecx,0x14(%eax)
	movl    %ebp, 16(%eax)
  10649a:	89 68 10             	mov    %ebp,0x10(%eax)
	movl    %ebx, 12(%eax)
  10649d:	89 58 0c             	mov    %ebx,0xc(%eax)
	movl    %esi, 8(%eax)
  1064a0:	89 70 08             	mov    %esi,0x8(%eax)
	movl    %edi, 4(%eax)
  1064a3:	89 78 04             	mov    %edi,0x4(%eax)
	movl    %esp, 0(%eax)
  1064a6:	89 20                	mov    %esp,(%eax)

	/* load the new kernel context */
	movl    0(%edx), %esp
  1064a8:	8b 22                	mov    (%edx),%esp
	movl    4(%edx), %edi
  1064aa:	8b 7a 04             	mov    0x4(%edx),%edi
	movl    8(%edx), %esi
  1064ad:	8b 72 08             	mov    0x8(%edx),%esi
	movl    12(%edx), %ebx
  1064b0:	8b 5a 0c             	mov    0xc(%edx),%ebx
	movl    16(%edx), %ebp
  1064b3:	8b 6a 10             	mov    0x10(%edx),%ebp
	movl    20(%edx), %ecx
  1064b6:	8b 4a 14             	mov    0x14(%edx),%ecx
	movl	  %ecx, 0(%esp)
  1064b9:	89 0c 24             	mov    %ecx,(%esp)

	xor     %eax, %eax
  1064bc:	31 c0                	xor    %eax,%eax
	ret
  1064be:	c3                   	ret    
  1064bf:	90                   	nop

001064c0 <kctx_new>:
 * Don't forget the stack is going down from high address to low.
 * We do not care about the rest of states when a new thread starts.
 * The function returns the child thread (process) id.
 */
unsigned int kctx_new(void *entry, unsigned int id, unsigned int quota)
{
  1064c0:	53                   	push   %ebx
  1064c1:	83 ec 18             	sub    $0x18,%esp
	unsigned int pid;
	pid = alloc_mem_quota(id, quota);
  1064c4:	8b 44 24 28          	mov    0x28(%esp),%eax
  1064c8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1064cc:	8b 44 24 24          	mov    0x24(%esp),%eax
  1064d0:	89 04 24             	mov    %eax,(%esp)
  1064d3:	e8 38 ff ff ff       	call   106410 <alloc_mem_quota>
  1064d8:	89 c3                	mov    %eax,%ebx
	kctx_set_esp(pid, proc_kstack[pid].kstack_hi);
  1064da:	c1 e0 0c             	shl    $0xc,%eax
  1064dd:	05 00 70 97 00       	add    $0x977000,%eax
  1064e2:	89 44 24 04          	mov    %eax,0x4(%esp)
  1064e6:	89 1c 24             	mov    %ebx,(%esp)
  1064e9:	e8 32 ff ff ff       	call   106420 <kctx_set_esp>
	kctx_set_eip(pid, entry);
  1064ee:	8b 44 24 20          	mov    0x20(%esp),%eax
  1064f2:	89 1c 24             	mov    %ebx,(%esp)
  1064f5:	89 44 24 04          	mov    %eax,0x4(%esp)
  1064f9:	e8 42 ff ff ff       	call   106440 <kctx_set_eip>

	return pid;
}
  1064fe:	83 c4 18             	add    $0x18,%esp
  106501:	89 d8                	mov    %ebx,%eax
  106503:	5b                   	pop    %ebx
  106504:	c3                   	ret    
  106505:	66 90                	xchg   %ax,%ax
  106507:	66 90                	xchg   %ax,%ax
  106509:	66 90                	xchg   %ax,%ax
  10650b:	66 90                	xchg   %ax,%ax
  10650d:	66 90                	xchg   %ax,%ax
  10650f:	90                   	nop

00106510 <tcb_get_state>:

struct TCB TCBPool[NUM_IDS];


unsigned int tcb_get_state(unsigned int pid)
{
  106510:	8b 44 24 04          	mov    0x4(%esp),%eax
	return TCBPool[pid].state;
  106514:	8d 04 40             	lea    (%eax,%eax,2),%eax
  106517:	8b 04 85 00 96 df 00 	mov    0xdf9600(,%eax,4),%eax
}
  10651e:	c3                   	ret    
  10651f:	90                   	nop

00106520 <tcb_set_state>:

void tcb_set_state(unsigned int pid, unsigned int state)
{
  106520:	8b 44 24 04          	mov    0x4(%esp),%eax
	TCBPool[pid].state = state;
  106524:	8b 54 24 08          	mov    0x8(%esp),%edx
  106528:	8d 04 40             	lea    (%eax,%eax,2),%eax
  10652b:	89 14 85 00 96 df 00 	mov    %edx,0xdf9600(,%eax,4)
  106532:	c3                   	ret    
  106533:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  106539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106540 <tcb_get_prev>:
}

unsigned int tcb_get_prev(unsigned int pid)
{
  106540:	8b 44 24 04          	mov    0x4(%esp),%eax
	return TCBPool[pid].prev;
  106544:	8d 04 40             	lea    (%eax,%eax,2),%eax
  106547:	8b 04 85 04 96 df 00 	mov    0xdf9604(,%eax,4),%eax
}
  10654e:	c3                   	ret    
  10654f:	90                   	nop

00106550 <tcb_set_prev>:

void tcb_set_prev(unsigned int pid, unsigned int prev_pid)
{
  106550:	8b 44 24 04          	mov    0x4(%esp),%eax
	TCBPool[pid].prev = prev_pid;
  106554:	8b 54 24 08          	mov    0x8(%esp),%edx
  106558:	8d 04 40             	lea    (%eax,%eax,2),%eax
  10655b:	89 14 85 04 96 df 00 	mov    %edx,0xdf9604(,%eax,4)
  106562:	c3                   	ret    
  106563:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  106569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106570 <tcb_get_next>:
}

unsigned int tcb_get_next(unsigned int pid)
{
  106570:	8b 44 24 04          	mov    0x4(%esp),%eax
	return TCBPool[pid].next;
  106574:	8d 04 40             	lea    (%eax,%eax,2),%eax
  106577:	8b 04 85 08 96 df 00 	mov    0xdf9608(,%eax,4),%eax
}
  10657e:	c3                   	ret    
  10657f:	90                   	nop

00106580 <tcb_set_next>:

void tcb_set_next(unsigned int pid, unsigned int next_pid)
{
  106580:	8b 44 24 04          	mov    0x4(%esp),%eax
	TCBPool[pid].next = next_pid;
  106584:	8b 54 24 08          	mov    0x8(%esp),%edx
  106588:	8d 04 40             	lea    (%eax,%eax,2),%eax
  10658b:	89 14 85 08 96 df 00 	mov    %edx,0xdf9608(,%eax,4)
  106592:	c3                   	ret    
  106593:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  106599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001065a0 <tcb_init_at_id>:
}

void tcb_init_at_id(unsigned int pid)
{
  1065a0:	8b 44 24 04          	mov    0x4(%esp),%eax
	TCBPool[pid].state = TSTATE_DEAD;
  1065a4:	8d 04 40             	lea    (%eax,%eax,2),%eax
  1065a7:	c1 e0 02             	shl    $0x2,%eax
  1065aa:	c7 80 00 96 df 00 03 	movl   $0x3,0xdf9600(%eax)
  1065b1:	00 00 00 
	TCBPool[pid].prev = NUM_IDS;
  1065b4:	c7 80 04 96 df 00 40 	movl   $0x40,0xdf9604(%eax)
  1065bb:	00 00 00 
	TCBPool[pid].next = NUM_IDS;
  1065be:	c7 80 08 96 df 00 40 	movl   $0x40,0xdf9608(%eax)
  1065c5:	00 00 00 
  1065c8:	c3                   	ret    
  1065c9:	66 90                	xchg   %ax,%ax
  1065cb:	66 90                	xchg   %ax,%ax
  1065cd:	66 90                	xchg   %ax,%ax
  1065cf:	90                   	nop

001065d0 <tcb_init>:
/**
 * Initializes the TCB for all NUM_IDS threads with the
 * state TSTATE_DEAD, and with two indices being NUM_IDS (which represents NULL).
 */
void tcb_init(unsigned int mbi_addr)
{
  1065d0:	53                   	push   %ebx
	unsigned int pid;

	paging_init(mbi_addr);

	pid = 0;
  1065d1:	31 db                	xor    %ebx,%ebx
/**
 * Initializes the TCB for all NUM_IDS threads with the
 * state TSTATE_DEAD, and with two indices being NUM_IDS (which represents NULL).
 */
void tcb_init(unsigned int mbi_addr)
{
  1065d3:	83 ec 18             	sub    $0x18,%esp
	unsigned int pid;

	paging_init(mbi_addr);
  1065d6:	8b 44 24 20          	mov    0x20(%esp),%eax
  1065da:	89 04 24             	mov    %eax,(%esp)
  1065dd:	e8 5e fd ff ff       	call   106340 <paging_init>
  1065e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

	pid = 0;

  while (pid < NUM_IDS) {
    tcb_init_at_id(pid);
  1065e8:	89 1c 24             	mov    %ebx,(%esp)
    pid++;
  1065eb:	83 c3 01             	add    $0x1,%ebx
	paging_init(mbi_addr);

	pid = 0;

  while (pid < NUM_IDS) {
    tcb_init_at_id(pid);
  1065ee:	e8 ad ff ff ff       	call   1065a0 <tcb_init_at_id>

	paging_init(mbi_addr);

	pid = 0;

  while (pid < NUM_IDS) {
  1065f3:	83 fb 40             	cmp    $0x40,%ebx
  1065f6:	75 f0                	jne    1065e8 <tcb_init+0x18>
    tcb_init_at_id(pid);
    pid++;
  }
}
  1065f8:	83 c4 18             	add    $0x18,%esp
  1065fb:	5b                   	pop    %ebx
  1065fc:	c3                   	ret    
  1065fd:	66 90                	xchg   %ax,%ax
  1065ff:	90                   	nop

00106600 <tqueue_get_head>:
 * and are scheduled in a round-robin manner.
 */
struct TQueue TQueuePool[NUM_CPUS][NUM_IDS + 1];

unsigned int tqueue_get_head(unsigned int chid)
{
  106600:	83 ec 0c             	sub    $0xc,%esp
	return TQueuePool[get_pcpu_idx()][chid].head;
  106603:	e8 b8 ee ff ff       	call   1054c0 <get_pcpu_idx>
  106608:	89 c2                	mov    %eax,%edx
  10660a:	c1 e2 06             	shl    $0x6,%edx
  10660d:	01 d0                	add    %edx,%eax
  10660f:	03 44 24 10          	add    0x10(%esp),%eax
  106613:	8b 04 c5 00 99 df 00 	mov    0xdf9900(,%eax,8),%eax
}
  10661a:	83 c4 0c             	add    $0xc,%esp
  10661d:	c3                   	ret    
  10661e:	66 90                	xchg   %ax,%ax

00106620 <tqueue_set_head>:

void tqueue_set_head(unsigned int chid, unsigned int head)
{
  106620:	83 ec 0c             	sub    $0xc,%esp
	TQueuePool[get_pcpu_idx()][chid].head = head;
  106623:	e8 98 ee ff ff       	call   1054c0 <get_pcpu_idx>
  106628:	89 c2                	mov    %eax,%edx
  10662a:	c1 e2 06             	shl    $0x6,%edx
  10662d:	01 d0                	add    %edx,%eax
  10662f:	8b 54 24 14          	mov    0x14(%esp),%edx
  106633:	03 44 24 10          	add    0x10(%esp),%eax
  106637:	89 14 c5 00 99 df 00 	mov    %edx,0xdf9900(,%eax,8)
}
  10663e:	83 c4 0c             	add    $0xc,%esp
  106641:	c3                   	ret    
  106642:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106650 <tqueue_get_tail>:

unsigned int tqueue_get_tail(unsigned int chid)
{
  106650:	83 ec 0c             	sub    $0xc,%esp
	return TQueuePool[get_pcpu_idx()][chid].tail;
  106653:	e8 68 ee ff ff       	call   1054c0 <get_pcpu_idx>
  106658:	89 c2                	mov    %eax,%edx
  10665a:	c1 e2 06             	shl    $0x6,%edx
  10665d:	01 d0                	add    %edx,%eax
  10665f:	03 44 24 10          	add    0x10(%esp),%eax
  106663:	8b 04 c5 04 99 df 00 	mov    0xdf9904(,%eax,8),%eax
}
  10666a:	83 c4 0c             	add    $0xc,%esp
  10666d:	c3                   	ret    
  10666e:	66 90                	xchg   %ax,%ax

00106670 <tqueue_set_tail>:

void tqueue_set_tail(unsigned int chid, unsigned int tail)
{
  106670:	83 ec 0c             	sub    $0xc,%esp
	TQueuePool[get_pcpu_idx()][chid].tail = tail;
  106673:	e8 48 ee ff ff       	call   1054c0 <get_pcpu_idx>
  106678:	89 c2                	mov    %eax,%edx
  10667a:	c1 e2 06             	shl    $0x6,%edx
  10667d:	01 d0                	add    %edx,%eax
  10667f:	8b 54 24 14          	mov    0x14(%esp),%edx
  106683:	03 44 24 10          	add    0x10(%esp),%eax
  106687:	89 14 c5 04 99 df 00 	mov    %edx,0xdf9904(,%eax,8)
}
  10668e:	83 c4 0c             	add    $0xc,%esp
  106691:	c3                   	ret    
  106692:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001066a0 <tqueue_init_at_id>:

void tqueue_init_at_id(unsigned int cpu_idx, unsigned int chid)
{
  1066a0:	8b 44 24 04          	mov    0x4(%esp),%eax
	TQueuePool[cpu_idx][chid].head = NUM_IDS;
  1066a4:	89 c2                	mov    %eax,%edx
  1066a6:	c1 e2 06             	shl    $0x6,%edx
  1066a9:	01 d0                	add    %edx,%eax
  1066ab:	03 44 24 08          	add    0x8(%esp),%eax
  1066af:	c7 04 c5 00 99 df 00 	movl   $0x40,0xdf9900(,%eax,8)
  1066b6:	40 00 00 00 
	TQueuePool[cpu_idx][chid].tail = NUM_IDS;
  1066ba:	c7 04 c5 04 99 df 00 	movl   $0x40,0xdf9904(,%eax,8)
  1066c1:	40 00 00 00 
  1066c5:	c3                   	ret    
  1066c6:	66 90                	xchg   %ax,%ax
  1066c8:	66 90                	xchg   %ax,%ax
  1066ca:	66 90                	xchg   %ax,%ax
  1066cc:	66 90                	xchg   %ax,%ax
  1066ce:	66 90                	xchg   %ax,%ax

001066d0 <tqueue_init>:
/**
 * Initializes all the thread queues with
 * tqueue_init_at_id.
 */
void tqueue_init(unsigned int mbi_addr)
{
  1066d0:	56                   	push   %esi
	unsigned int cpu_idx, chid;

	tcb_init(mbi_addr);

	chid = 0;
	cpu_idx = 0;
  1066d1:	31 f6                	xor    %esi,%esi
/**
 * Initializes all the thread queues with
 * tqueue_init_at_id.
 */
void tqueue_init(unsigned int mbi_addr)
{
  1066d3:	53                   	push   %ebx
  1066d4:	83 ec 14             	sub    $0x14,%esp
	unsigned int cpu_idx, chid;

	tcb_init(mbi_addr);
  1066d7:	8b 44 24 20          	mov    0x20(%esp),%eax
  1066db:	89 04 24             	mov    %eax,(%esp)
  1066de:	e8 ed fe ff ff       	call   1065d0 <tcb_init>
  1066e3:	90                   	nop
  1066e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
/**
 * Initializes all the thread queues with
 * tqueue_init_at_id.
 */
void tqueue_init(unsigned int mbi_addr)
{
  1066e8:	31 db                	xor    %ebx,%ebx
  1066ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

	chid = 0;
	cpu_idx = 0;
	while (cpu_idx < NUM_CPUS) {
		while (chid <= NUM_IDS) {
			tqueue_init_at_id(cpu_idx, chid);
  1066f0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
			chid++;
  1066f4:	83 c3 01             	add    $0x1,%ebx

	chid = 0;
	cpu_idx = 0;
	while (cpu_idx < NUM_CPUS) {
		while (chid <= NUM_IDS) {
			tqueue_init_at_id(cpu_idx, chid);
  1066f7:	89 34 24             	mov    %esi,(%esp)
  1066fa:	e8 a1 ff ff ff       	call   1066a0 <tqueue_init_at_id>
	tcb_init(mbi_addr);

	chid = 0;
	cpu_idx = 0;
	while (cpu_idx < NUM_CPUS) {
		while (chid <= NUM_IDS) {
  1066ff:	83 fb 41             	cmp    $0x41,%ebx
  106702:	75 ec                	jne    1066f0 <tqueue_init+0x20>
			tqueue_init_at_id(cpu_idx, chid);
			chid++;
		}
		chid = 0;
		cpu_idx++;
  106704:	83 c6 01             	add    $0x1,%esi

	tcb_init(mbi_addr);

	chid = 0;
	cpu_idx = 0;
	while (cpu_idx < NUM_CPUS) {
  106707:	83 fe 08             	cmp    $0x8,%esi
  10670a:	75 dc                	jne    1066e8 <tqueue_init+0x18>
			chid++;
		}
		chid = 0;
		cpu_idx++;
	}
}
  10670c:	83 c4 14             	add    $0x14,%esp
  10670f:	5b                   	pop    %ebx
  106710:	5e                   	pop    %esi
  106711:	c3                   	ret    
  106712:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106720 <tqueue_enqueue>:
 * Recall that the doubly linked list is index based.
 * So you only need to insert the index.
 * Hint: there are multiple cases in this function.
 */
void tqueue_enqueue(unsigned int chid, unsigned int pid)
{
  106720:	57                   	push   %edi
  106721:	56                   	push   %esi
  106722:	53                   	push   %ebx
  106723:	83 ec 10             	sub    $0x10,%esp
  106726:	8b 7c 24 20          	mov    0x20(%esp),%edi
  10672a:	8b 5c 24 24          	mov    0x24(%esp),%ebx
	unsigned int tail;

	tail = tqueue_get_tail(chid);
  10672e:	89 3c 24             	mov    %edi,(%esp)
  106731:	e8 1a ff ff ff       	call   106650 <tqueue_get_tail>

	if (tail == NUM_IDS) {
  106736:	83 f8 40             	cmp    $0x40,%eax
 */
void tqueue_enqueue(unsigned int chid, unsigned int pid)
{
	unsigned int tail;

	tail = tqueue_get_tail(chid);
  106739:	89 c6                	mov    %eax,%esi

	if (tail == NUM_IDS) {
  10673b:	74 3b                	je     106778 <tqueue_enqueue+0x58>
		tcb_set_prev(pid, NUM_IDS);
		tcb_set_next(pid, NUM_IDS);
		tqueue_set_head(chid, pid);
		tqueue_set_tail(chid, pid);
	} else {
		tcb_set_next(tail, pid);
  10673d:	89 04 24             	mov    %eax,(%esp)
  106740:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  106744:	e8 37 fe ff ff       	call   106580 <tcb_set_next>
		tcb_set_prev(pid, tail);
  106749:	89 74 24 04          	mov    %esi,0x4(%esp)
  10674d:	89 1c 24             	mov    %ebx,(%esp)
  106750:	e8 fb fd ff ff       	call   106550 <tcb_set_prev>
		tcb_set_next(pid, NUM_IDS);
  106755:	c7 44 24 04 40 00 00 	movl   $0x40,0x4(%esp)
  10675c:	00 
  10675d:	89 1c 24             	mov    %ebx,(%esp)
  106760:	e8 1b fe ff ff       	call   106580 <tcb_set_next>
		tqueue_set_tail(chid, pid);
  106765:	89 5c 24 24          	mov    %ebx,0x24(%esp)
  106769:	89 7c 24 20          	mov    %edi,0x20(%esp)
	}
}
  10676d:	83 c4 10             	add    $0x10,%esp
  106770:	5b                   	pop    %ebx
  106771:	5e                   	pop    %esi
  106772:	5f                   	pop    %edi
		tqueue_set_tail(chid, pid);
	} else {
		tcb_set_next(tail, pid);
		tcb_set_prev(pid, tail);
		tcb_set_next(pid, NUM_IDS);
		tqueue_set_tail(chid, pid);
  106773:	e9 f8 fe ff ff       	jmp    106670 <tqueue_set_tail>
	unsigned int tail;

	tail = tqueue_get_tail(chid);

	if (tail == NUM_IDS) {
		tcb_set_prev(pid, NUM_IDS);
  106778:	c7 44 24 04 40 00 00 	movl   $0x40,0x4(%esp)
  10677f:	00 
  106780:	89 1c 24             	mov    %ebx,(%esp)
  106783:	e8 c8 fd ff ff       	call   106550 <tcb_set_prev>
		tcb_set_next(pid, NUM_IDS);
  106788:	c7 44 24 04 40 00 00 	movl   $0x40,0x4(%esp)
  10678f:	00 
  106790:	89 1c 24             	mov    %ebx,(%esp)
  106793:	e8 e8 fd ff ff       	call   106580 <tcb_set_next>
		tqueue_set_head(chid, pid);
  106798:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  10679c:	89 3c 24             	mov    %edi,(%esp)
  10679f:	e8 7c fe ff ff       	call   106620 <tqueue_set_head>
  1067a4:	eb bf                	jmp    106765 <tqueue_enqueue+0x45>
  1067a6:	8d 76 00             	lea    0x0(%esi),%esi
  1067a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001067b0 <tqueue_dequeue>:
 * Reverse action of tqueue_enqueue, i.g., pops a TCB from the head of specified queue.
 * It returns the poped thread's id, or NUM_IDS if the queue is empty.
 * Hint: there are mutiple cases in this function.
 */
unsigned int tqueue_dequeue(unsigned int chid)
{
  1067b0:	57                   	push   %edi
  1067b1:	56                   	push   %esi
  1067b2:	53                   	push   %ebx
  1067b3:	83 ec 10             	sub    $0x10,%esp
  1067b6:	8b 74 24 20          	mov    0x20(%esp),%esi
	unsigned int head, next, pid;

	pid = NUM_IDS;
	head = tqueue_get_head(chid);
  1067ba:	89 34 24             	mov    %esi,(%esp)
  1067bd:	e8 3e fe ff ff       	call   106600 <tqueue_get_head>

	if (head != NUM_IDS) {
  1067c2:	83 f8 40             	cmp    $0x40,%eax
unsigned int tqueue_dequeue(unsigned int chid)
{
	unsigned int head, next, pid;

	pid = NUM_IDS;
	head = tqueue_get_head(chid);
  1067c5:	89 c3                	mov    %eax,%ebx

	if (head != NUM_IDS) {
  1067c7:	75 0f                	jne    1067d8 <tqueue_dequeue+0x28>
    tcb_set_prev(pid, NUM_IDS);
    tcb_set_next(pid, NUM_IDS);
	}

	return pid;
}
  1067c9:	83 c4 10             	add    $0x10,%esp
  1067cc:	89 d8                	mov    %ebx,%eax
  1067ce:	5b                   	pop    %ebx
  1067cf:	5e                   	pop    %esi
  1067d0:	5f                   	pop    %edi
  1067d1:	c3                   	ret    
  1067d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	pid = NUM_IDS;
	head = tqueue_get_head(chid);

	if (head != NUM_IDS) {
		pid = head;
		next = tcb_get_next(head);
  1067d8:	89 04 24             	mov    %eax,(%esp)
  1067db:	e8 90 fd ff ff       	call   106570 <tcb_get_next>

		if(next == NUM_IDS) {
			tqueue_set_head(chid, NUM_IDS);
  1067e0:	c7 44 24 04 40 00 00 	movl   $0x40,0x4(%esp)
  1067e7:	00 

	if (head != NUM_IDS) {
		pid = head;
		next = tcb_get_next(head);

		if(next == NUM_IDS) {
  1067e8:	83 f8 40             	cmp    $0x40,%eax
	pid = NUM_IDS;
	head = tqueue_get_head(chid);

	if (head != NUM_IDS) {
		pid = head;
		next = tcb_get_next(head);
  1067eb:	89 c7                	mov    %eax,%edi

		if(next == NUM_IDS) {
  1067ed:	74 41                	je     106830 <tqueue_dequeue+0x80>
			tqueue_set_head(chid, NUM_IDS);
			tqueue_set_tail(chid, NUM_IDS);
		} else {
			tcb_set_prev(next, NUM_IDS);
  1067ef:	89 04 24             	mov    %eax,(%esp)
  1067f2:	e8 59 fd ff ff       	call   106550 <tcb_set_prev>
			tqueue_set_head(chid, next);
  1067f7:	89 7c 24 04          	mov    %edi,0x4(%esp)
  1067fb:	89 34 24             	mov    %esi,(%esp)
  1067fe:	e8 1d fe ff ff       	call   106620 <tqueue_set_head>
		}
    tcb_set_prev(pid, NUM_IDS);
  106803:	89 1c 24             	mov    %ebx,(%esp)
  106806:	c7 44 24 04 40 00 00 	movl   $0x40,0x4(%esp)
  10680d:	00 
  10680e:	e8 3d fd ff ff       	call   106550 <tcb_set_prev>
    tcb_set_next(pid, NUM_IDS);
  106813:	89 1c 24             	mov    %ebx,(%esp)
  106816:	c7 44 24 04 40 00 00 	movl   $0x40,0x4(%esp)
  10681d:	00 
  10681e:	e8 5d fd ff ff       	call   106580 <tcb_set_next>
	}

	return pid;
}
  106823:	83 c4 10             	add    $0x10,%esp
  106826:	89 d8                	mov    %ebx,%eax
  106828:	5b                   	pop    %ebx
  106829:	5e                   	pop    %esi
  10682a:	5f                   	pop    %edi
  10682b:	c3                   	ret    
  10682c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if (head != NUM_IDS) {
		pid = head;
		next = tcb_get_next(head);

		if(next == NUM_IDS) {
			tqueue_set_head(chid, NUM_IDS);
  106830:	89 34 24             	mov    %esi,(%esp)
  106833:	e8 e8 fd ff ff       	call   106620 <tqueue_set_head>
			tqueue_set_tail(chid, NUM_IDS);
  106838:	c7 44 24 04 40 00 00 	movl   $0x40,0x4(%esp)
  10683f:	00 
  106840:	89 34 24             	mov    %esi,(%esp)
  106843:	e8 28 fe ff ff       	call   106670 <tqueue_set_tail>
  106848:	eb b9                	jmp    106803 <tqueue_dequeue+0x53>
  10684a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00106850 <tqueue_remove>:
/**
 * Removes the TCB #pid from the queue #chid.
 * Hint: there are many cases in this function.
 */
void tqueue_remove(unsigned int chid, unsigned int pid)
{
  106850:	55                   	push   %ebp
  106851:	57                   	push   %edi
  106852:	56                   	push   %esi
  106853:	53                   	push   %ebx
  106854:	83 ec 1c             	sub    $0x1c,%esp
  106857:	8b 5c 24 34          	mov    0x34(%esp),%ebx
  10685b:	8b 6c 24 30          	mov    0x30(%esp),%ebp
	unsigned int prev, next;

	prev = tcb_get_prev(pid);
  10685f:	89 1c 24             	mov    %ebx,(%esp)
  106862:	e8 d9 fc ff ff       	call   106540 <tcb_get_prev>
	next = tcb_get_next(pid);
  106867:	89 1c 24             	mov    %ebx,(%esp)
 */
void tqueue_remove(unsigned int chid, unsigned int pid)
{
	unsigned int prev, next;

	prev = tcb_get_prev(pid);
  10686a:	89 c7                	mov    %eax,%edi
	next = tcb_get_next(pid);
  10686c:	e8 ff fc ff ff       	call   106570 <tcb_get_next>

	if (prev == NUM_IDS) {
  106871:	83 ff 40             	cmp    $0x40,%edi
void tqueue_remove(unsigned int chid, unsigned int pid)
{
	unsigned int prev, next;

	prev = tcb_get_prev(pid);
	next = tcb_get_next(pid);
  106874:	89 c6                	mov    %eax,%esi

	if (prev == NUM_IDS) {
  106876:	74 50                	je     1068c8 <tqueue_remove+0x78>
		} else {
			tcb_set_prev(next, NUM_IDS);
			tqueue_set_head(chid, next);
		}
	} else {
		if (next == NUM_IDS) {
  106878:	83 f8 40             	cmp    $0x40,%eax
  10687b:	0f 84 8f 00 00 00    	je     106910 <tqueue_remove+0xc0>
			tcb_set_next(prev, NUM_IDS);
			tqueue_set_tail(chid, prev);
		} else {
			if (prev != next)
  106881:	39 c7                	cmp    %eax,%edi
  106883:	74 0c                	je     106891 <tqueue_remove+0x41>
				tcb_set_next(prev, next);
  106885:	89 44 24 04          	mov    %eax,0x4(%esp)
  106889:	89 3c 24             	mov    %edi,(%esp)
  10688c:	e8 ef fc ff ff       	call   106580 <tcb_set_next>
			tcb_set_prev(next, prev);
  106891:	89 7c 24 04          	mov    %edi,0x4(%esp)
  106895:	89 34 24             	mov    %esi,(%esp)
  106898:	e8 b3 fc ff ff       	call   106550 <tcb_set_prev>
		}
	}
  tcb_set_prev(pid, NUM_IDS);
  10689d:	89 1c 24             	mov    %ebx,(%esp)
  1068a0:	c7 44 24 04 40 00 00 	movl   $0x40,0x4(%esp)
  1068a7:	00 
  1068a8:	e8 a3 fc ff ff       	call   106550 <tcb_set_prev>
  tcb_set_next(pid, NUM_IDS);
  1068ad:	89 5c 24 30          	mov    %ebx,0x30(%esp)
  1068b1:	c7 44 24 34 40 00 00 	movl   $0x40,0x34(%esp)
  1068b8:	00 
}
  1068b9:	83 c4 1c             	add    $0x1c,%esp
  1068bc:	5b                   	pop    %ebx
  1068bd:	5e                   	pop    %esi
  1068be:	5f                   	pop    %edi
  1068bf:	5d                   	pop    %ebp
				tcb_set_next(prev, next);
			tcb_set_prev(next, prev);
		}
	}
  tcb_set_prev(pid, NUM_IDS);
  tcb_set_next(pid, NUM_IDS);
  1068c0:	e9 bb fc ff ff       	jmp    106580 <tcb_set_next>
  1068c5:	8d 76 00             	lea    0x0(%esi),%esi

	prev = tcb_get_prev(pid);
	next = tcb_get_next(pid);

	if (prev == NUM_IDS) {
		if (next == NUM_IDS) {
  1068c8:	83 f8 40             	cmp    $0x40,%eax
			tqueue_set_head(chid, NUM_IDS);
  1068cb:	c7 44 24 04 40 00 00 	movl   $0x40,0x4(%esp)
  1068d2:	00 

	prev = tcb_get_prev(pid);
	next = tcb_get_next(pid);

	if (prev == NUM_IDS) {
		if (next == NUM_IDS) {
  1068d3:	74 1b                	je     1068f0 <tqueue_remove+0xa0>
			tqueue_set_head(chid, NUM_IDS);
			tqueue_set_tail(chid, NUM_IDS);
		} else {
			tcb_set_prev(next, NUM_IDS);
  1068d5:	89 04 24             	mov    %eax,(%esp)
  1068d8:	e8 73 fc ff ff       	call   106550 <tcb_set_prev>
			tqueue_set_head(chid, next);
  1068dd:	89 74 24 04          	mov    %esi,0x4(%esp)
  1068e1:	89 2c 24             	mov    %ebp,(%esp)
  1068e4:	e8 37 fd ff ff       	call   106620 <tqueue_set_head>
  1068e9:	eb b2                	jmp    10689d <tqueue_remove+0x4d>
  1068eb:	90                   	nop
  1068ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	prev = tcb_get_prev(pid);
	next = tcb_get_next(pid);

	if (prev == NUM_IDS) {
		if (next == NUM_IDS) {
			tqueue_set_head(chid, NUM_IDS);
  1068f0:	89 2c 24             	mov    %ebp,(%esp)
  1068f3:	e8 28 fd ff ff       	call   106620 <tqueue_set_head>
			tqueue_set_tail(chid, NUM_IDS);
  1068f8:	c7 44 24 04 40 00 00 	movl   $0x40,0x4(%esp)
  1068ff:	00 
  106900:	89 2c 24             	mov    %ebp,(%esp)
  106903:	e8 68 fd ff ff       	call   106670 <tqueue_set_tail>
  106908:	eb 93                	jmp    10689d <tqueue_remove+0x4d>
  10690a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			tcb_set_prev(next, NUM_IDS);
			tqueue_set_head(chid, next);
		}
	} else {
		if (next == NUM_IDS) {
			tcb_set_next(prev, NUM_IDS);
  106910:	c7 44 24 04 40 00 00 	movl   $0x40,0x4(%esp)
  106917:	00 
  106918:	89 3c 24             	mov    %edi,(%esp)
  10691b:	e8 60 fc ff ff       	call   106580 <tcb_set_next>
			tqueue_set_tail(chid, prev);
  106920:	89 7c 24 04          	mov    %edi,0x4(%esp)
  106924:	89 2c 24             	mov    %ebp,(%esp)
  106927:	e8 44 fd ff ff       	call   106670 <tqueue_set_tail>
  10692c:	e9 6c ff ff ff       	jmp    10689d <tqueue_remove+0x4d>
  106931:	66 90                	xchg   %ax,%ax
  106933:	66 90                	xchg   %ax,%ax
  106935:	66 90                	xchg   %ax,%ax
  106937:	66 90                	xchg   %ax,%ax
  106939:	66 90                	xchg   %ax,%ax
  10693b:	66 90                	xchg   %ax,%ax
  10693d:	66 90                	xchg   %ax,%ax
  10693f:	90                   	nop

00106940 <get_curid>:
#include <pcpu/PCPUIntro/export.h>

unsigned int CURID[NUM_CPUS];

unsigned int get_curid(void)
{
  106940:	83 ec 0c             	sub    $0xc,%esp
	return CURID[get_pcpu_idx()];
  106943:	e8 78 eb ff ff       	call   1054c0 <get_pcpu_idx>
  106948:	8b 04 85 40 a9 df 00 	mov    0xdfa940(,%eax,4),%eax
}
  10694f:	83 c4 0c             	add    $0xc,%esp
  106952:	c3                   	ret    
  106953:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  106959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106960 <set_curid>:

void set_curid(unsigned int curid)
{
  106960:	83 ec 0c             	sub    $0xc,%esp
	CURID[get_pcpu_idx()] = curid;
  106963:	e8 58 eb ff ff       	call   1054c0 <get_pcpu_idx>
  106968:	8b 54 24 10          	mov    0x10(%esp),%edx
  10696c:	89 14 85 40 a9 df 00 	mov    %edx,0xdfa940(,%eax,4)
}
  106973:	83 c4 0c             	add    $0xc,%esp
  106976:	c3                   	ret    
  106977:	66 90                	xchg   %ax,%ax
  106979:	66 90                	xchg   %ax,%ax
  10697b:	66 90                	xchg   %ax,%ax
  10697d:	66 90                	xchg   %ax,%ax
  10697f:	90                   	nop

00106980 <thread_init>:

#include "import.h"
static int intrCounts[NUM_CPUS];
void initIntrCounts(void);
void thread_init(unsigned int mbi_addr)
{
  106980:	83 ec 1c             	sub    $0x1c,%esp
	tqueue_init(mbi_addr);
  106983:	8b 44 24 20          	mov    0x20(%esp),%eax
  106987:	89 04 24             	mov    %eax,(%esp)
  10698a:	e8 41 fd ff ff       	call   1066d0 <tqueue_init>
	set_curid(0);
  10698f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  106996:	e8 c5 ff ff ff       	call   106960 <set_curid>
	tcb_set_state(0, TSTATE_RUN);
  10699b:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  1069a2:	00 
  1069a3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1069aa:	e8 71 fb ff ff       	call   106520 <tcb_set_state>
	spinlock_init(&intrCountsLock);
  1069af:	c7 04 24 58 d4 96 00 	movl   $0x96d458,(%esp)
  1069b6:	e8 b5 e7 ff ff       	call   105170 <spinlock_init>
	spinlock_init(&tqueueLock);
  1069bb:	c7 04 24 60 d4 96 00 	movl   $0x96d460,(%esp)
  1069c2:	e8 a9 e7 ff ff       	call   105170 <spinlock_init>
	spinlock_init(&curidLock);
  1069c7:	c7 04 24 50 d4 96 00 	movl   $0x96d450,(%esp)
  1069ce:	e8 9d e7 ff ff       	call   105170 <spinlock_init>
	initIntrCounts();
}
void initIntrCounts(void)
{
	int i;
	for (i = 0; i < NUM_CPUS; i++)
  1069d3:	31 c0                	xor    %eax,%eax
  1069d5:	8d 76 00             	lea    0x0(%esi),%esi
	{
		intrCounts[i] = 0;
  1069d8:	c7 04 85 c0 d3 92 00 	movl   $0x0,0x92d3c0(,%eax,4)
  1069df:	00 00 00 00 
	initIntrCounts();
}
void initIntrCounts(void)
{
	int i;
	for (i = 0; i < NUM_CPUS; i++)
  1069e3:	83 c0 01             	add    $0x1,%eax
  1069e6:	83 f8 08             	cmp    $0x8,%eax
  1069e9:	75 ed                	jne    1069d8 <thread_init+0x58>
	tcb_set_state(0, TSTATE_RUN);
	spinlock_init(&intrCountsLock);
	spinlock_init(&tqueueLock);
	spinlock_init(&curidLock);
	initIntrCounts();
}
  1069eb:	83 c4 1c             	add    $0x1c,%esp
  1069ee:	c3                   	ret    
  1069ef:	90                   	nop

001069f0 <initIntrCounts>:
void initIntrCounts(void)
{
	int i;
	for (i = 0; i < NUM_CPUS; i++)
  1069f0:	31 c0                	xor    %eax,%eax
  1069f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	{
		intrCounts[i] = 0;
  1069f8:	c7 04 85 c0 d3 92 00 	movl   $0x0,0x92d3c0(,%eax,4)
  1069ff:	00 00 00 00 
	initIntrCounts();
}
void initIntrCounts(void)
{
	int i;
	for (i = 0; i < NUM_CPUS; i++)
  106a03:	83 c0 01             	add    $0x1,%eax
  106a06:	83 f8 08             	cmp    $0x8,%eax
  106a09:	75 ed                	jne    1069f8 <initIntrCounts+0x8>
	{
		intrCounts[i] = 0;
	}	
}
  106a0b:	f3 c3                	repz ret 
  106a0d:	8d 76 00             	lea    0x0(%esi),%esi

00106a10 <thread_spawn>:
 * Allocates new child thread context, set the state of the new child thread
 * as ready, and pushes it to the ready queue.
 * It returns the child thread id.
 */
unsigned int thread_spawn(void *entry, unsigned int id, unsigned int quota)
{
  106a10:	53                   	push   %ebx
  106a11:	83 ec 18             	sub    $0x18,%esp
	unsigned int pid;

	pid = kctx_new(entry, id, quota);
  106a14:	8b 44 24 28          	mov    0x28(%esp),%eax
  106a18:	89 44 24 08          	mov    %eax,0x8(%esp)
  106a1c:	8b 44 24 24          	mov    0x24(%esp),%eax
  106a20:	89 44 24 04          	mov    %eax,0x4(%esp)
  106a24:	8b 44 24 20          	mov    0x20(%esp),%eax
  106a28:	89 04 24             	mov    %eax,(%esp)
  106a2b:	e8 90 fa ff ff       	call   1064c0 <kctx_new>
	tcb_set_state(pid, TSTATE_READY);
  106a30:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  106a37:	00 
  106a38:	89 04 24             	mov    %eax,(%esp)
 */
unsigned int thread_spawn(void *entry, unsigned int id, unsigned int quota)
{
	unsigned int pid;

	pid = kctx_new(entry, id, quota);
  106a3b:	89 c3                	mov    %eax,%ebx
	tcb_set_state(pid, TSTATE_READY);
  106a3d:	e8 de fa ff ff       	call   106520 <tcb_set_state>
	
	spinlock_acquire(&tqueueLock);
  106a42:	c7 04 24 60 d4 96 00 	movl   $0x96d460,(%esp)
  106a49:	e8 e2 e8 ff ff       	call   105330 <spinlock_acquire>
	tqueue_enqueue(NUM_IDS, pid);
  106a4e:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  106a52:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
  106a59:	e8 c2 fc ff ff       	call   106720 <tqueue_enqueue>
	spinlock_release(&tqueueLock);
  106a5e:	c7 04 24 60 d4 96 00 	movl   $0x96d460,(%esp)
  106a65:	e8 46 e9 ff ff       	call   1053b0 <spinlock_release>
	return pid;
}
  106a6a:	83 c4 18             	add    $0x18,%esp
  106a6d:	89 d8                	mov    %ebx,%eax
  106a6f:	5b                   	pop    %ebx
  106a70:	c3                   	ret    
  106a71:	eb 0d                	jmp    106a80 <thread_yield>
  106a73:	90                   	nop
  106a74:	90                   	nop
  106a75:	90                   	nop
  106a76:	90                   	nop
  106a77:	90                   	nop
  106a78:	90                   	nop
  106a79:	90                   	nop
  106a7a:	90                   	nop
  106a7b:	90                   	nop
  106a7c:	90                   	nop
  106a7d:	90                   	nop
  106a7e:	90                   	nop
  106a7f:	90                   	nop

00106a80 <thread_yield>:
 * current thread id, then switches to the new kernel context.
 * Hint: if you are the only thread that is ready to run,
 * do you need to switch to yourself?
 */
void thread_yield(void)
{
  106a80:	56                   	push   %esi
  106a81:	53                   	push   %ebx
  106a82:	83 ec 14             	sub    $0x14,%esp
	unsigned int old_cur_pid;
	unsigned int new_cur_pid;
	int curCPU = get_pcpu_idx();
  106a85:	e8 36 ea ff ff       	call   1054c0 <get_pcpu_idx>
  106a8a:	89 c6                	mov    %eax,%esi

	old_cur_pid = get_curid();
  106a8c:	e8 af fe ff ff       	call   106940 <get_curid>
	prevID[curCPU] = old_cur_pid;
	tcb_set_state(old_cur_pid, TSTATE_READY);
  106a91:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  106a98:	00 
  106a99:	89 04 24             	mov    %eax,(%esp)
{
	unsigned int old_cur_pid;
	unsigned int new_cur_pid;
	int curCPU = get_pcpu_idx();

	old_cur_pid = get_curid();
  106a9c:	89 c3                	mov    %eax,%ebx
	prevID[curCPU] = old_cur_pid;
  106a9e:	89 04 b5 20 d4 96 00 	mov    %eax,0x96d420(,%esi,4)
	tcb_set_state(old_cur_pid, TSTATE_READY);
  106aa5:	e8 76 fa ff ff       	call   106520 <tcb_set_state>
	spinlock_acquire(&tqueueLock);
  106aaa:	c7 04 24 60 d4 96 00 	movl   $0x96d460,(%esp)
  106ab1:	e8 7a e8 ff ff       	call   105330 <spinlock_acquire>
	tqueue_enqueue(NUM_IDS, old_cur_pid);
  106ab6:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  106aba:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
  106ac1:	e8 5a fc ff ff       	call   106720 <tqueue_enqueue>

	new_cur_pid = tqueue_dequeue(NUM_IDS);
  106ac6:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
  106acd:	e8 de fc ff ff       	call   1067b0 <tqueue_dequeue>
	spinlock_release(&tqueueLock);
  106ad2:	c7 04 24 60 d4 96 00 	movl   $0x96d460,(%esp)
	prevID[curCPU] = old_cur_pid;
	tcb_set_state(old_cur_pid, TSTATE_READY);
	spinlock_acquire(&tqueueLock);
	tqueue_enqueue(NUM_IDS, old_cur_pid);

	new_cur_pid = tqueue_dequeue(NUM_IDS);
  106ad9:	89 c6                	mov    %eax,%esi
	spinlock_release(&tqueueLock);
  106adb:	e8 d0 e8 ff ff       	call   1053b0 <spinlock_release>
	tcb_set_state(new_cur_pid, TSTATE_RUN);
  106ae0:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  106ae7:	00 
  106ae8:	89 34 24             	mov    %esi,(%esp)
  106aeb:	e8 30 fa ff ff       	call   106520 <tcb_set_state>

	spinlock_acquire(&curidLock);
  106af0:	c7 04 24 50 d4 96 00 	movl   $0x96d450,(%esp)
  106af7:	e8 34 e8 ff ff       	call   105330 <spinlock_acquire>
	set_curid(new_cur_pid);
  106afc:	89 34 24             	mov    %esi,(%esp)
  106aff:	e8 5c fe ff ff       	call   106960 <set_curid>
	spinlock_release(&curidLock);
  106b04:	c7 04 24 50 d4 96 00 	movl   $0x96d450,(%esp)
  106b0b:	e8 a0 e8 ff ff       	call   1053b0 <spinlock_release>
	if (old_cur_pid != new_cur_pid){
  106b10:	39 f3                	cmp    %esi,%ebx
  106b12:	74 0c                	je     106b20 <thread_yield+0xa0>
		kctx_switch(old_cur_pid, new_cur_pid);
  106b14:	89 74 24 04          	mov    %esi,0x4(%esp)
  106b18:	89 1c 24             	mov    %ebx,(%esp)
  106b1b:	e8 40 f9 ff ff       	call   106460 <kctx_switch>
	}
}
  106b20:	83 c4 14             	add    $0x14,%esp
  106b23:	5b                   	pop    %ebx
  106b24:	5e                   	pop    %esi
  106b25:	c3                   	ret    
  106b26:	8d 76 00             	lea    0x0(%esi),%esi
  106b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106b30 <sched_update>:
void sched_update()
{
  106b30:	53                   	push   %ebx
  106b31:	83 ec 18             	sub    $0x18,%esp
	int curCPU = get_pcpu_idx();
  106b34:	e8 87 e9 ff ff       	call   1054c0 <get_pcpu_idx>
	int maxCount = LAPIC_TIMER_INTR_FREQ * SCHED_SLICE / 1000;

	spinlock_acquire(&intrCountsLock);
  106b39:	c7 04 24 58 d4 96 00 	movl   $0x96d458,(%esp)
		kctx_switch(old_cur_pid, new_cur_pid);
	}
}
void sched_update()
{
	int curCPU = get_pcpu_idx();
  106b40:	89 c3                	mov    %eax,%ebx
	int maxCount = LAPIC_TIMER_INTR_FREQ * SCHED_SLICE / 1000;

	spinlock_acquire(&intrCountsLock);
  106b42:	e8 e9 e7 ff ff       	call   105330 <spinlock_acquire>
	intrCounts[curCPU] ++;
  106b47:	8b 04 9d c0 d3 92 00 	mov    0x92d3c0(,%ebx,4),%eax
  106b4e:	83 c0 01             	add    $0x1,%eax
	if(intrCounts[curCPU] >= maxCount) {
  106b51:	83 f8 04             	cmp    $0x4,%eax
{
	int curCPU = get_pcpu_idx();
	int maxCount = LAPIC_TIMER_INTR_FREQ * SCHED_SLICE / 1000;

	spinlock_acquire(&intrCountsLock);
	intrCounts[curCPU] ++;
  106b54:	89 04 9d c0 d3 92 00 	mov    %eax,0x92d3c0(,%ebx,4)
	if(intrCounts[curCPU] >= maxCount) {
  106b5b:	7f 13                	jg     106b70 <sched_update+0x40>
		intrCounts[curCPU] = 0;
		spinlock_release(&intrCountsLock);
		thread_yield();
	}
	else {
		spinlock_release(&intrCountsLock);
  106b5d:	c7 04 24 58 d4 96 00 	movl   $0x96d458,(%esp)
  106b64:	e8 47 e8 ff ff       	call   1053b0 <spinlock_release>
	}
}
  106b69:	83 c4 18             	add    $0x18,%esp
  106b6c:	5b                   	pop    %ebx
  106b6d:	c3                   	ret    
  106b6e:	66 90                	xchg   %ax,%ax

	spinlock_acquire(&intrCountsLock);
	intrCounts[curCPU] ++;
	if(intrCounts[curCPU] >= maxCount) {
		intrCounts[curCPU] = 0;
		spinlock_release(&intrCountsLock);
  106b70:	c7 04 24 58 d4 96 00 	movl   $0x96d458,(%esp)
	int maxCount = LAPIC_TIMER_INTR_FREQ * SCHED_SLICE / 1000;

	spinlock_acquire(&intrCountsLock);
	intrCounts[curCPU] ++;
	if(intrCounts[curCPU] >= maxCount) {
		intrCounts[curCPU] = 0;
  106b77:	c7 04 9d c0 d3 92 00 	movl   $0x0,0x92d3c0(,%ebx,4)
  106b7e:	00 00 00 00 
		spinlock_release(&intrCountsLock);
  106b82:	e8 29 e8 ff ff       	call   1053b0 <spinlock_release>
		thread_yield();
	}
	else {
		spinlock_release(&intrCountsLock);
	}
}
  106b87:	83 c4 18             	add    $0x18,%esp
  106b8a:	5b                   	pop    %ebx
	spinlock_acquire(&intrCountsLock);
	intrCounts[curCPU] ++;
	if(intrCounts[curCPU] >= maxCount) {
		intrCounts[curCPU] = 0;
		spinlock_release(&intrCountsLock);
		thread_yield();
  106b8b:	e9 f0 fe ff ff       	jmp    106a80 <thread_yield>

00106b90 <proc_start_user>:
#include "import.h"

extern tf_t uctx_pool[NUM_IDS];

void proc_start_user(void)
{
  106b90:	53                   	push   %ebx
  106b91:	83 ec 18             	sub    $0x18,%esp
	unsigned int cur_pid = get_curid();
  106b94:	e8 a7 fd ff ff       	call   106940 <get_curid>
  106b99:	89 c3                	mov    %eax,%ebx
	kstack_switch(cur_pid);
  106b9b:	89 04 24             	mov    %eax,(%esp)
  106b9e:	e8 6d d6 ff ff       	call   104210 <kstack_switch>
	set_pdir_base(cur_pid);
  106ba3:	89 1c 24             	mov    %ebx,(%esp)
  106ba6:	e8 e5 f2 ff ff       	call   105e90 <set_pdir_base>

	trap_return((void *) &uctx_pool[cur_pid]);
  106bab:	89 d8                	mov    %ebx,%eax
  106bad:	c1 e0 06             	shl    $0x6,%eax
  106bb0:	8d 84 98 60 a9 df 00 	lea    0xdfa960(%eax,%ebx,4),%eax
  106bb7:	89 04 24             	mov    %eax,(%esp)
  106bba:	e8 81 b4 ff ff       	call   102040 <trap_return>
}
  106bbf:	83 c4 18             	add    $0x18,%esp
  106bc2:	5b                   	pop    %ebx
  106bc3:	c3                   	ret    
  106bc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  106bca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00106bd0 <proc_create>:

unsigned int proc_create(void *elf_addr, unsigned int quota)
{
  106bd0:	57                   	push   %edi
  106bd1:	56                   	push   %esi
  106bd2:	53                   	push   %ebx
  106bd3:	83 ec 10             	sub    $0x10,%esp
  106bd6:	8b 7c 24 20          	mov    0x20(%esp),%edi
	unsigned int pid, id;

  id = get_curid();
  106bda:	e8 61 fd ff ff       	call   106940 <get_curid>
	pid = thread_spawn((void *) proc_start_user, id, quota);
  106bdf:	8b 54 24 24          	mov    0x24(%esp),%edx
  106be3:	c7 04 24 90 6b 10 00 	movl   $0x106b90,(%esp)
  106bea:	89 54 24 08          	mov    %edx,0x8(%esp)
  106bee:	89 44 24 04          	mov    %eax,0x4(%esp)
  106bf2:	e8 19 fe ff ff       	call   106a10 <thread_spawn>

	elf_load(elf_addr, pid);
  106bf7:	89 3c 24             	mov    %edi,(%esp)
unsigned int proc_create(void *elf_addr, unsigned int quota)
{
	unsigned int pid, id;

  id = get_curid();
	pid = thread_spawn((void *) proc_start_user, id, quota);
  106bfa:	89 c6                	mov    %eax,%esi

	elf_load(elf_addr, pid);
  106bfc:	89 44 24 04          	mov    %eax,0x4(%esp)
  106c00:	e8 8b e2 ff ff       	call   104e90 <elf_load>

  uctx_pool[pid].es = CPU_GDT_UDATA | 3;
  106c05:	89 f0                	mov    %esi,%eax
  uctx_pool[pid].ds = CPU_GDT_UDATA | 3;
  106c07:	ba 23 00 00 00       	mov    $0x23,%edx
  id = get_curid();
	pid = thread_spawn((void *) proc_start_user, id, quota);

	elf_load(elf_addr, pid);

  uctx_pool[pid].es = CPU_GDT_UDATA | 3;
  106c0c:	c1 e0 06             	shl    $0x6,%eax
  uctx_pool[pid].ds = CPU_GDT_UDATA | 3;
  uctx_pool[pid].cs = CPU_GDT_UCODE | 3;
  106c0f:	b9 1b 00 00 00       	mov    $0x1b,%ecx
  id = get_curid();
	pid = thread_spawn((void *) proc_start_user, id, quota);

	elf_load(elf_addr, pid);

  uctx_pool[pid].es = CPU_GDT_UDATA | 3;
  106c14:	8d 1c b0             	lea    (%eax,%esi,4),%ebx
  106c17:	b8 23 00 00 00       	mov    $0x23,%eax
  106c1c:	66 89 83 80 a9 df 00 	mov    %ax,0xdfa980(%ebx)
  uctx_pool[pid].ds = CPU_GDT_UDATA | 3;
  uctx_pool[pid].cs = CPU_GDT_UCODE | 3;
  uctx_pool[pid].ss = CPU_GDT_UDATA | 3;
  106c23:	b8 23 00 00 00       	mov    $0x23,%eax
  uctx_pool[pid].esp = VM_USERHI;
  uctx_pool[pid].eflags = FL_IF;
  uctx_pool[pid].eip = elf_entry(elf_addr);
  106c28:	89 3c 24             	mov    %edi,(%esp)
	pid = thread_spawn((void *) proc_start_user, id, quota);

	elf_load(elf_addr, pid);

  uctx_pool[pid].es = CPU_GDT_UDATA | 3;
  uctx_pool[pid].ds = CPU_GDT_UDATA | 3;
  106c2b:	66 89 93 84 a9 df 00 	mov    %dx,0xdfa984(%ebx)
  uctx_pool[pid].cs = CPU_GDT_UCODE | 3;
  106c32:	66 89 8b 94 a9 df 00 	mov    %cx,0xdfa994(%ebx)
  uctx_pool[pid].ss = CPU_GDT_UDATA | 3;
  106c39:	66 89 83 a0 a9 df 00 	mov    %ax,0xdfa9a0(%ebx)
  uctx_pool[pid].esp = VM_USERHI;
  106c40:	c7 83 9c a9 df 00 00 	movl   $0xf0000000,0xdfa99c(%ebx)
  106c47:	00 00 f0 
  uctx_pool[pid].eflags = FL_IF;
  106c4a:	c7 83 98 a9 df 00 00 	movl   $0x200,0xdfa998(%ebx)
  106c51:	02 00 00 
  uctx_pool[pid].eip = elf_entry(elf_addr);
  106c54:	e8 97 e4 ff ff       	call   1050f0 <elf_entry>
  106c59:	89 83 90 a9 df 00    	mov    %eax,0xdfa990(%ebx)

	seg_init_proc(get_pcpu_idx(), pid);
  106c5f:	e8 5c e8 ff ff       	call   1054c0 <get_pcpu_idx>
  106c64:	89 74 24 04          	mov    %esi,0x4(%esp)
  106c68:	89 04 24             	mov    %eax,(%esp)
  106c6b:	e8 30 d8 ff ff       	call   1044a0 <seg_init_proc>

	return pid;
}
  106c70:	83 c4 10             	add    $0x10,%esp
  106c73:	89 f0                	mov    %esi,%eax
  106c75:	5b                   	pop    %ebx
  106c76:	5e                   	pop    %esi
  106c77:	5f                   	pop    %edi
  106c78:	c3                   	ret    
  106c79:	66 90                	xchg   %ax,%ax
  106c7b:	66 90                	xchg   %ax,%ax
  106c7d:	66 90                	xchg   %ax,%ax
  106c7f:	90                   	nop

00106c80 <syscall_get_arg1>:
#include <lib/x86.h>

#include "import.h"

unsigned int syscall_get_arg1(tf_t *tf)
{
  106c80:	83 ec 0c             	sub    $0xc,%esp
	unsigned int cur_pid;
	unsigned int arg1;

	cur_pid = get_curid();
  106c83:	e8 b8 fc ff ff       	call   106940 <get_curid>
	arg1 = tf -> regs.eax;

	return arg1;
  106c88:	8b 44 24 10          	mov    0x10(%esp),%eax
  106c8c:	8b 40 1c             	mov    0x1c(%eax),%eax
}
  106c8f:	83 c4 0c             	add    $0xc,%esp
  106c92:	c3                   	ret    
  106c93:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  106c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106ca0 <syscall_get_arg2>:

unsigned int syscall_get_arg2(tf_t *tf)
{
  106ca0:	83 ec 0c             	sub    $0xc,%esp
	unsigned int cur_pid;
	unsigned int arg2;

	cur_pid = get_curid();
  106ca3:	e8 98 fc ff ff       	call   106940 <get_curid>
	arg2 = tf -> regs.ebx;

	return arg2;
  106ca8:	8b 44 24 10          	mov    0x10(%esp),%eax
  106cac:	8b 40 10             	mov    0x10(%eax),%eax
}
  106caf:	83 c4 0c             	add    $0xc,%esp
  106cb2:	c3                   	ret    
  106cb3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  106cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106cc0 <syscall_get_arg3>:

unsigned int syscall_get_arg3(tf_t *tf)
{
  106cc0:	83 ec 0c             	sub    $0xc,%esp
	unsigned int cur_pid;
	unsigned int arg3;

	cur_pid = get_curid();
  106cc3:	e8 78 fc ff ff       	call   106940 <get_curid>
	arg3 = tf -> regs.ecx;

	return arg3;
  106cc8:	8b 44 24 10          	mov    0x10(%esp),%eax
  106ccc:	8b 40 18             	mov    0x18(%eax),%eax
}
  106ccf:	83 c4 0c             	add    $0xc,%esp
  106cd2:	c3                   	ret    
  106cd3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  106cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106ce0 <syscall_get_arg4>:

unsigned int syscall_get_arg4(tf_t *tf)
{
  106ce0:	83 ec 0c             	sub    $0xc,%esp
	unsigned int cur_pid;
	unsigned int arg4;

	cur_pid = get_curid();
  106ce3:	e8 58 fc ff ff       	call   106940 <get_curid>
	arg4 = tf -> regs.edx;

	return arg4;
  106ce8:	8b 44 24 10          	mov    0x10(%esp),%eax
  106cec:	8b 40 14             	mov    0x14(%eax),%eax
}
  106cef:	83 c4 0c             	add    $0xc,%esp
  106cf2:	c3                   	ret    
  106cf3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  106cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106d00 <syscall_get_arg5>:

unsigned int syscall_get_arg5(tf_t *tf)
{
  106d00:	83 ec 0c             	sub    $0xc,%esp
	unsigned int cur_pid;
	unsigned int arg5;

	cur_pid = get_curid();
  106d03:	e8 38 fc ff ff       	call   106940 <get_curid>
	arg5 = tf -> regs.esi;

	return arg5;
  106d08:	8b 44 24 10          	mov    0x10(%esp),%eax
  106d0c:	8b 40 04             	mov    0x4(%eax),%eax
}
  106d0f:	83 c4 0c             	add    $0xc,%esp
  106d12:	c3                   	ret    
  106d13:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  106d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106d20 <syscall_get_arg6>:

unsigned int syscall_get_arg6(tf_t *tf)
{
  106d20:	83 ec 0c             	sub    $0xc,%esp
	unsigned int cur_pid;
	unsigned int arg6;

	cur_pid = get_curid();
  106d23:	e8 18 fc ff ff       	call   106940 <get_curid>
	arg6 = tf -> regs.edi;

	return arg6;
  106d28:	8b 44 24 10          	mov    0x10(%esp),%eax
  106d2c:	8b 00                	mov    (%eax),%eax
}
  106d2e:	83 c4 0c             	add    $0xc,%esp
  106d31:	c3                   	ret    
  106d32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106d40 <syscall_set_errno>:

void syscall_set_errno(tf_t *tf, unsigned int errno)
{
  106d40:	83 ec 0c             	sub    $0xc,%esp
	unsigned int cur_pid;

	cur_pid = get_curid();
  106d43:	e8 f8 fb ff ff       	call   106940 <get_curid>
  tf -> regs.eax = errno;
  106d48:	8b 54 24 14          	mov    0x14(%esp),%edx
  106d4c:	8b 44 24 10          	mov    0x10(%esp),%eax
  106d50:	89 50 1c             	mov    %edx,0x1c(%eax)
}
  106d53:	83 c4 0c             	add    $0xc,%esp
  106d56:	c3                   	ret    
  106d57:	89 f6                	mov    %esi,%esi
  106d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106d60 <syscall_set_retval1>:

void syscall_set_retval1(tf_t *tf, unsigned int retval)
{
  106d60:	83 ec 0c             	sub    $0xc,%esp
	unsigned int cur_pid;

	cur_pid = get_curid();
  106d63:	e8 d8 fb ff ff       	call   106940 <get_curid>
  tf -> regs.ebx = retval;
  106d68:	8b 54 24 14          	mov    0x14(%esp),%edx
  106d6c:	8b 44 24 10          	mov    0x10(%esp),%eax
  106d70:	89 50 10             	mov    %edx,0x10(%eax)
}
  106d73:	83 c4 0c             	add    $0xc,%esp
  106d76:	c3                   	ret    
  106d77:	89 f6                	mov    %esi,%esi
  106d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106d80 <syscall_set_retval2>:

void syscall_set_retval2(tf_t *tf, unsigned int retval)
{
  106d80:	83 ec 0c             	sub    $0xc,%esp
	unsigned int cur_pid;

	cur_pid = get_curid();
  106d83:	e8 b8 fb ff ff       	call   106940 <get_curid>
  tf -> regs.ecx = retval;
  106d88:	8b 54 24 14          	mov    0x14(%esp),%edx
  106d8c:	8b 44 24 10          	mov    0x10(%esp),%eax
  106d90:	89 50 18             	mov    %edx,0x18(%eax)
}
  106d93:	83 c4 0c             	add    $0xc,%esp
  106d96:	c3                   	ret    
  106d97:	89 f6                	mov    %esi,%esi
  106d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106da0 <syscall_set_retval3>:

void syscall_set_retval3(tf_t *tf, unsigned int retval)
{
  106da0:	83 ec 0c             	sub    $0xc,%esp
	unsigned int cur_pid;

	cur_pid = get_curid();
  106da3:	e8 98 fb ff ff       	call   106940 <get_curid>
  tf -> regs.edx = retval;
  106da8:	8b 54 24 14          	mov    0x14(%esp),%edx
  106dac:	8b 44 24 10          	mov    0x10(%esp),%eax
  106db0:	89 50 14             	mov    %edx,0x14(%eax)
}
  106db3:	83 c4 0c             	add    $0xc,%esp
  106db6:	c3                   	ret    
  106db7:	89 f6                	mov    %esi,%esi
  106db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106dc0 <syscall_set_retval4>:

void syscall_set_retval4(tf_t *tf, unsigned int retval)
{
  106dc0:	83 ec 0c             	sub    $0xc,%esp
	unsigned int cur_pid;

	cur_pid = get_curid();
  106dc3:	e8 78 fb ff ff       	call   106940 <get_curid>
  tf -> regs.esi = retval;
  106dc8:	8b 54 24 14          	mov    0x14(%esp),%edx
  106dcc:	8b 44 24 10          	mov    0x10(%esp),%eax
  106dd0:	89 50 04             	mov    %edx,0x4(%eax)
}
  106dd3:	83 c4 0c             	add    $0xc,%esp
  106dd6:	c3                   	ret    
  106dd7:	89 f6                	mov    %esi,%esi
  106dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00106de0 <syscall_set_retval5>:

void syscall_set_retval5(tf_t *tf, unsigned int retval)
{
  106de0:	83 ec 0c             	sub    $0xc,%esp
	unsigned int cur_pid;

	cur_pid = get_curid();
  106de3:	e8 58 fb ff ff       	call   106940 <get_curid>
  tf -> regs.edi = retval;
  106de8:	8b 54 24 14          	mov    0x14(%esp),%edx
  106dec:	8b 44 24 10          	mov    0x10(%esp),%eax
  106df0:	89 10                	mov    %edx,(%eax)
}
  106df2:	83 c4 0c             	add    $0xc,%esp
  106df5:	c3                   	ret    
  106df6:	66 90                	xchg   %ax,%ax
  106df8:	66 90                	xchg   %ax,%ax
  106dfa:	66 90                	xchg   %ax,%ax
  106dfc:	66 90                	xchg   %ax,%ax
  106dfe:	66 90                	xchg   %ax,%ax

00106e00 <sys_puts>:
/**
 * Copies a string from user into buffer and prints it to the screen.
 * This is called by the user level "printf" library as a system call.
 */
void sys_puts(tf_t *tf)
{
  106e00:	55                   	push   %ebp
  106e01:	57                   	push   %edi
  106e02:	56                   	push   %esi
  106e03:	53                   	push   %ebx
  106e04:	83 ec 2c             	sub    $0x2c,%esp
	unsigned int cur_pid;
	unsigned int str_uva, str_len;
	unsigned int remain, cur_pos, nbytes;

	cur_pid = get_curid();
  106e07:	e8 34 fb ff ff       	call   106940 <get_curid>
  106e0c:	89 44 24 18          	mov    %eax,0x18(%esp)
  106e10:	89 c7                	mov    %eax,%edi
	str_uva = syscall_get_arg2(tf);
  106e12:	8b 44 24 40          	mov    0x40(%esp),%eax
  106e16:	89 04 24             	mov    %eax,(%esp)
  106e19:	e8 82 fe ff ff       	call   106ca0 <syscall_get_arg2>
  106e1e:	89 c6                	mov    %eax,%esi
	str_len = syscall_get_arg3(tf);
  106e20:	8b 44 24 40          	mov    0x40(%esp),%eax
  106e24:	89 04 24             	mov    %eax,(%esp)
  106e27:	e8 94 fe ff ff       	call   106cc0 <syscall_get_arg3>

	if (!(VM_USERLO <= str_uva && str_uva + str_len <= VM_USERHI)) {
  106e2c:	81 fe ff ff ff 3f    	cmp    $0x3fffffff,%esi
  106e32:	0f 86 a8 00 00 00    	jbe    106ee0 <sys_puts+0xe0>
  106e38:	89 c3                	mov    %eax,%ebx
  106e3a:	8d 04 30             	lea    (%eax,%esi,1),%eax
  106e3d:	3d 00 00 00 f0       	cmp    $0xf0000000,%eax
  106e42:	0f 87 98 00 00 00    	ja     106ee0 <sys_puts+0xe0>
  106e48:	89 f8                	mov    %edi,%eax
  106e4a:	c1 e0 0c             	shl    $0xc,%eax
	}

	remain = str_len;
	cur_pos = str_uva;

	while (remain) {
  106e4d:	85 db                	test   %ebx,%ebx
  106e4f:	8d b8 e0 d3 92 00    	lea    0x92d3e0(%eax),%edi
			      cur_pos, sys_buf[cur_pid], nbytes) != nbytes) {
			syscall_set_errno(tf, E_MEM);
			return;
		}

		sys_buf[cur_pid][nbytes] = '\0';
  106e55:	89 44 24 1c          	mov    %eax,0x1c(%esp)
	}

	remain = str_len;
	cur_pos = str_uva;

	while (remain) {
  106e59:	75 30                	jne    106e8b <sys_puts+0x8b>
  106e5b:	e9 a0 00 00 00       	jmp    106f00 <sys_puts+0x100>
			      cur_pos, sys_buf[cur_pid], nbytes) != nbytes) {
			syscall_set_errno(tf, E_MEM);
			return;
		}

		sys_buf[cur_pid][nbytes] = '\0';
  106e60:	8b 44 24 1c          	mov    0x1c(%esp),%eax
		KERN_INFO("From cpu %d: %s", get_pcpu_idx(), sys_buf[cur_pid]);

		remain -= nbytes;
		cur_pos += nbytes;
  106e64:	01 ee                	add    %ebp,%esi
			      cur_pos, sys_buf[cur_pid], nbytes) != nbytes) {
			syscall_set_errno(tf, E_MEM);
			return;
		}

		sys_buf[cur_pid][nbytes] = '\0';
  106e66:	c6 84 05 e0 d3 92 00 	movb   $0x0,0x92d3e0(%ebp,%eax,1)
  106e6d:	00 
		KERN_INFO("From cpu %d: %s", get_pcpu_idx(), sys_buf[cur_pid]);
  106e6e:	e8 4d e6 ff ff       	call   1054c0 <get_pcpu_idx>
  106e73:	89 7c 24 08          	mov    %edi,0x8(%esp)
  106e77:	c7 04 24 f5 93 10 00 	movl   $0x1093f5,(%esp)
  106e7e:	89 44 24 04          	mov    %eax,0x4(%esp)
  106e82:	e8 69 cb ff ff       	call   1039f0 <debug_info>
	}

	remain = str_len;
	cur_pos = str_uva;

	while (remain) {
  106e87:	29 eb                	sub    %ebp,%ebx
  106e89:	74 75                	je     106f00 <sys_puts+0x100>
		if (remain < PAGESIZE - 1)
			nbytes = remain;
		else
			nbytes = PAGESIZE - 1;

		if (pt_copyin(cur_pid,
  106e8b:	8b 44 24 18          	mov    0x18(%esp),%eax

	while (remain) {
		if (remain < PAGESIZE - 1)
			nbytes = remain;
		else
			nbytes = PAGESIZE - 1;
  106e8f:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
  106e95:	b9 ff 0f 00 00       	mov    $0xfff,%ecx
  106e9a:	0f 42 cb             	cmovb  %ebx,%ecx

		if (pt_copyin(cur_pid,
  106e9d:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  106ea1:	89 7c 24 08          	mov    %edi,0x8(%esp)
  106ea5:	89 74 24 04          	mov    %esi,0x4(%esp)
  106ea9:	89 04 24             	mov    %eax,(%esp)
  106eac:	89 4c 24 14          	mov    %ecx,0x14(%esp)
  106eb0:	e8 3b dd ff ff       	call   104bf0 <pt_copyin>
  106eb5:	8b 4c 24 14          	mov    0x14(%esp),%ecx
  106eb9:	39 c8                	cmp    %ecx,%eax
  106ebb:	89 c5                	mov    %eax,%ebp
  106ebd:	74 a1                	je     106e60 <sys_puts+0x60>
			      cur_pos, sys_buf[cur_pid], nbytes) != nbytes) {
			syscall_set_errno(tf, E_MEM);
  106ebf:	8b 44 24 40          	mov    0x40(%esp),%eax
  106ec3:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  106eca:	00 
  106ecb:	89 04 24             	mov    %eax,(%esp)
  106ece:	e8 6d fe ff ff       	call   106d40 <syscall_set_errno>
		remain -= nbytes;
		cur_pos += nbytes;
	}

	syscall_set_errno(tf, E_SUCC);
}
  106ed3:	83 c4 2c             	add    $0x2c,%esp
  106ed6:	5b                   	pop    %ebx
  106ed7:	5e                   	pop    %esi
  106ed8:	5f                   	pop    %edi
  106ed9:	5d                   	pop    %ebp
  106eda:	c3                   	ret    
  106edb:	90                   	nop
  106edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	cur_pid = get_curid();
	str_uva = syscall_get_arg2(tf);
	str_len = syscall_get_arg3(tf);

	if (!(VM_USERLO <= str_uva && str_uva + str_len <= VM_USERHI)) {
		syscall_set_errno(tf, E_INVAL_ADDR);
  106ee0:	8b 44 24 40          	mov    0x40(%esp),%eax
  106ee4:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
  106eeb:	00 
  106eec:	89 04 24             	mov    %eax,(%esp)
  106eef:	e8 4c fe ff ff       	call   106d40 <syscall_set_errno>
		remain -= nbytes;
		cur_pos += nbytes;
	}

	syscall_set_errno(tf, E_SUCC);
}
  106ef4:	83 c4 2c             	add    $0x2c,%esp
  106ef7:	5b                   	pop    %ebx
  106ef8:	5e                   	pop    %esi
  106ef9:	5f                   	pop    %edi
  106efa:	5d                   	pop    %ebp
  106efb:	c3                   	ret    
  106efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

		remain -= nbytes;
		cur_pos += nbytes;
	}

	syscall_set_errno(tf, E_SUCC);
  106f00:	8b 44 24 40          	mov    0x40(%esp),%eax
  106f04:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  106f0b:	00 
  106f0c:	89 04 24             	mov    %eax,(%esp)
  106f0f:	e8 2c fe ff ff       	call   106d40 <syscall_set_errno>
}
  106f14:	83 c4 2c             	add    $0x2c,%esp
  106f17:	5b                   	pop    %ebx
  106f18:	5e                   	pop    %esi
  106f19:	5f                   	pop    %edi
  106f1a:	5d                   	pop    %ebp
  106f1b:	c3                   	ret    
  106f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00106f20 <sys_spawn>:
 * NUM_IDS with the error number E_INVAL_PID. The same error case apply
 * when the proc_create fails.
 * Otherwise, you mark it as successful, and return the new child process id.
 */
void sys_spawn(tf_t *tf)
{
  106f20:	55                   	push   %ebp
  106f21:	57                   	push   %edi
  106f22:	56                   	push   %esi
  106f23:	53                   	push   %ebx
  106f24:	83 ec 1c             	sub    $0x1c,%esp
  106f27:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  //TODO: improve the implementation by adding the missing argument checks to
  //make sure the calll to sys_spawn never goes wrong.
	unsigned int new_pid;
	unsigned int elf_id, quota;
	void *elf_addr;
	unsigned int cur_id = get_curid();
  106f2b:	e8 10 fa ff ff       	call   106940 <get_curid>
	elf_id = syscall_get_arg2(tf);
  106f30:	89 1c 24             	mov    %ebx,(%esp)
  //TODO: improve the implementation by adding the missing argument checks to
  //make sure the calll to sys_spawn never goes wrong.
	unsigned int new_pid;
	unsigned int elf_id, quota;
	void *elf_addr;
	unsigned int cur_id = get_curid();
  106f33:	89 c5                	mov    %eax,%ebp
	elf_id = syscall_get_arg2(tf);
  106f35:	e8 66 fd ff ff       	call   106ca0 <syscall_get_arg2>
	quota = syscall_get_arg3(tf);
  106f3a:	89 1c 24             	mov    %ebx,(%esp)
  //make sure the calll to sys_spawn never goes wrong.
	unsigned int new_pid;
	unsigned int elf_id, quota;
	void *elf_addr;
	unsigned int cur_id = get_curid();
	elf_id = syscall_get_arg2(tf);
  106f3d:	89 c6                	mov    %eax,%esi
	quota = syscall_get_arg3(tf);
  106f3f:	e8 7c fd ff ff       	call   106cc0 <syscall_get_arg3>
	if (!container_can_consume(cur_id, quota))
  106f44:	89 2c 24             	mov    %ebp,(%esp)
  106f47:	89 44 24 04          	mov    %eax,0x4(%esp)
	unsigned int new_pid;
	unsigned int elf_id, quota;
	void *elf_addr;
	unsigned int cur_id = get_curid();
	elf_id = syscall_get_arg2(tf);
	quota = syscall_get_arg3(tf);
  106f4b:	89 c7                	mov    %eax,%edi
	if (!container_can_consume(cur_id, quota))
  106f4d:	e8 ce ed ff ff       	call   105d20 <container_can_consume>
  106f52:	85 c0                	test   %eax,%eax
  106f54:	74 62                	je     106fb8 <sys_spawn+0x98>
	{
		syscall_set_errno(tf, E_EXCEEDS_QUOTA);
		syscall_set_retval1(tf, NUM_IDS);
		return;
	}
	if (container_get_nchildren(elf_id) >= MAX_CHILDREN)
  106f56:	89 34 24             	mov    %esi,(%esp)
  106f59:	e8 92 ed ff ff       	call   105cf0 <container_get_nchildren>
  106f5e:	83 f8 02             	cmp    $0x2,%eax
  106f61:	77 7d                	ja     106fe0 <sys_spawn+0xc0>
	{
		syscall_set_errno(tf, E_MAX_NUM_CHILDEN_REACHED);
        syscall_set_retval1(tf, NUM_IDS);
        return;
	}
	if (elf_id == 1) {
  106f63:	83 fe 01             	cmp    $0x1,%esi
  106f66:	0f 84 b4 00 00 00    	je     107020 <sys_spawn+0x100>
		elf_addr = _binary___obj_user_pingpong_ping_start;
	} else if (elf_id == 2) {
  106f6c:	83 fe 02             	cmp    $0x2,%esi
  106f6f:	90                   	nop
  106f70:	0f 84 8a 00 00 00    	je     107000 <sys_spawn+0xe0>
		elf_addr = _binary___obj_user_pingpong_pong_start;
	} else if (elf_id == 3) {
  106f76:	83 fe 03             	cmp    $0x3,%esi
    elf_addr = _binary___obj_user_pingpong_ding_start;
  106f79:	b8 58 3d 12 00       	mov    $0x123d58,%eax
	}
	if (elf_id == 1) {
		elf_addr = _binary___obj_user_pingpong_ping_start;
	} else if (elf_id == 2) {
		elf_addr = _binary___obj_user_pingpong_pong_start;
	} else if (elf_id == 3) {
  106f7e:	75 70                	jne    106ff0 <sys_spawn+0xd0>
		syscall_set_errno(tf, E_INVAL_PID);
		syscall_set_retval1(tf, NUM_IDS);
		return;
	}
	
	new_pid = proc_create(elf_addr, quota);
  106f80:	89 7c 24 04          	mov    %edi,0x4(%esp)
  106f84:	89 04 24             	mov    %eax,(%esp)
  106f87:	e8 44 fc ff ff       	call   106bd0 <proc_create>
	
	if (new_pid == NUM_IDS) {
  106f8c:	83 f8 40             	cmp    $0x40,%eax
		syscall_set_errno(tf, E_INVAL_PID);
		syscall_set_retval1(tf, NUM_IDS);
		return;
	}
	
	new_pid = proc_create(elf_addr, quota);
  106f8f:	89 c6                	mov    %eax,%esi
	
	if (new_pid == NUM_IDS) {
  106f91:	74 7d                	je     107010 <sys_spawn+0xf0>
		syscall_set_errno(tf, E_INVAL_CHILD_ID);
		syscall_set_retval1(tf, NUM_IDS);
	} else {
		syscall_set_errno(tf, E_SUCC);
  106f93:	89 1c 24             	mov    %ebx,(%esp)
  106f96:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  106f9d:	00 
  106f9e:	e8 9d fd ff ff       	call   106d40 <syscall_set_errno>
		syscall_set_retval1(tf, new_pid);
  106fa3:	89 74 24 04          	mov    %esi,0x4(%esp)
  106fa7:	89 1c 24             	mov    %ebx,(%esp)
  106faa:	e8 b1 fd ff ff       	call   106d60 <syscall_set_retval1>
	}
}
  106faf:	83 c4 1c             	add    $0x1c,%esp
  106fb2:	5b                   	pop    %ebx
  106fb3:	5e                   	pop    %esi
  106fb4:	5f                   	pop    %edi
  106fb5:	5d                   	pop    %ebp
  106fb6:	c3                   	ret    
  106fb7:	90                   	nop
	unsigned int cur_id = get_curid();
	elf_id = syscall_get_arg2(tf);
	quota = syscall_get_arg3(tf);
	if (!container_can_consume(cur_id, quota))
	{
		syscall_set_errno(tf, E_EXCEEDS_QUOTA);
  106fb8:	c7 44 24 04 17 00 00 	movl   $0x17,0x4(%esp)
  106fbf:	00 
	}
	
	new_pid = proc_create(elf_addr, quota);
	
	if (new_pid == NUM_IDS) {
		syscall_set_errno(tf, E_INVAL_CHILD_ID);
  106fc0:	89 1c 24             	mov    %ebx,(%esp)
  106fc3:	e8 78 fd ff ff       	call   106d40 <syscall_set_errno>
		syscall_set_retval1(tf, NUM_IDS);
  106fc8:	89 1c 24             	mov    %ebx,(%esp)
  106fcb:	c7 44 24 04 40 00 00 	movl   $0x40,0x4(%esp)
  106fd2:	00 
  106fd3:	e8 88 fd ff ff       	call   106d60 <syscall_set_retval1>
	} else {
		syscall_set_errno(tf, E_SUCC);
		syscall_set_retval1(tf, new_pid);
	}
}
  106fd8:	83 c4 1c             	add    $0x1c,%esp
  106fdb:	5b                   	pop    %ebx
  106fdc:	5e                   	pop    %esi
  106fdd:	5f                   	pop    %edi
  106fde:	5d                   	pop    %ebp
  106fdf:	c3                   	ret    
		syscall_set_retval1(tf, NUM_IDS);
		return;
	}
	if (container_get_nchildren(elf_id) >= MAX_CHILDREN)
	{
		syscall_set_errno(tf, E_MAX_NUM_CHILDEN_REACHED);
  106fe0:	c7 44 24 04 18 00 00 	movl   $0x18,0x4(%esp)
  106fe7:	00 
  106fe8:	eb d6                	jmp    106fc0 <sys_spawn+0xa0>
  106fea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	} else if (elf_id == 2) {
		elf_addr = _binary___obj_user_pingpong_pong_start;
	} else if (elf_id == 3) {
    elf_addr = _binary___obj_user_pingpong_ding_start;
	} else {
		syscall_set_errno(tf, E_INVAL_PID);
  106ff0:	c7 44 24 04 05 00 00 	movl   $0x5,0x4(%esp)
  106ff7:	00 
  106ff8:	eb c6                	jmp    106fc0 <sys_spawn+0xa0>
  106ffa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return;
	}
	if (elf_id == 1) {
		elf_addr = _binary___obj_user_pingpong_ping_start;
	} else if (elf_id == 2) {
		elf_addr = _binary___obj_user_pingpong_pong_start;
  107000:	b8 84 c5 11 00       	mov    $0x11c584,%eax
  107005:	e9 76 ff ff ff       	jmp    106f80 <sys_spawn+0x60>
  10700a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	}
	
	new_pid = proc_create(elf_addr, quota);
	
	if (new_pid == NUM_IDS) {
		syscall_set_errno(tf, E_INVAL_CHILD_ID);
  107010:	c7 44 24 04 19 00 00 	movl   $0x19,0x4(%esp)
  107017:	00 
  107018:	eb a6                	jmp    106fc0 <sys_spawn+0xa0>
  10701a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		syscall_set_errno(tf, E_MAX_NUM_CHILDEN_REACHED);
        syscall_set_retval1(tf, NUM_IDS);
        return;
	}
	if (elf_id == 1) {
		elf_addr = _binary___obj_user_pingpong_ping_start;
  107020:	b8 68 4d 11 00       	mov    $0x114d68,%eax
  107025:	e9 56 ff ff ff       	jmp    106f80 <sys_spawn+0x60>
  10702a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00107030 <sys_yield>:
 * The user level library function sys_yield (defined in user/include/syscall.h)
 * does not take any argument and does not have any return values.
 * Do not forget to set the error number as E_SUCC.
 */
void sys_yield(tf_t *tf)
{
  107030:	83 ec 1c             	sub    $0x1c,%esp
	thread_yield();
  107033:	e8 48 fa ff ff       	call   106a80 <thread_yield>
	syscall_set_errno(tf, E_SUCC);
  107038:	8b 44 24 20          	mov    0x20(%esp),%eax
  10703c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  107043:	00 
  107044:	89 04 24             	mov    %eax,(%esp)
  107047:	e8 f4 fc ff ff       	call   106d40 <syscall_set_errno>
}
  10704c:	83 c4 1c             	add    $0x1c,%esp
  10704f:	c3                   	ret    

00107050 <sys_produce>:

void sys_produce(tf_t *tf)
{
  107050:	56                   	push   %esi
  107051:	53                   	push   %ebx
  unsigned int i;
  for(i = 0; i < 5; i++) {
  107052:	31 db                	xor    %ebx,%ebx
	thread_yield();
	syscall_set_errno(tf, E_SUCC);
}

void sys_produce(tf_t *tf)
{
  107054:	83 ec 24             	sub    $0x24,%esp
  unsigned int i;
  for(i = 0; i < 5; i++) {
	intr_local_disable();
  107057:	e8 44 a7 ff ff       	call   1017a0 <intr_local_disable>
    KERN_DEBUG("CPU %d: Process %d: Produced %d\n", get_pcpu_idx(), get_curid(), i);
  10705c:	e8 df f8 ff ff       	call   106940 <get_curid>
  107061:	89 c6                	mov    %eax,%esi
  107063:	e8 58 e4 ff ff       	call   1054c0 <get_pcpu_idx>
  107068:	89 5c 24 14          	mov    %ebx,0x14(%esp)
}

void sys_produce(tf_t *tf)
{
  unsigned int i;
  for(i = 0; i < 5; i++) {
  10706c:	83 c3 01             	add    $0x1,%ebx
	intr_local_disable();
    KERN_DEBUG("CPU %d: Process %d: Produced %d\n", get_pcpu_idx(), get_curid(), i);
  10706f:	89 74 24 10          	mov    %esi,0x10(%esp)
  107073:	c7 44 24 08 24 94 10 	movl   $0x109424,0x8(%esp)
  10707a:	00 
  10707b:	c7 44 24 04 8c 00 00 	movl   $0x8c,0x4(%esp)
  107082:	00 
  107083:	c7 04 24 05 94 10 00 	movl   $0x109405,(%esp)
  10708a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10708e:	e8 9d c9 ff ff       	call   103a30 <debug_normal>
  	intr_local_enable();
  107093:	e8 f8 a6 ff ff       	call   101790 <intr_local_enable>
}

void sys_produce(tf_t *tf)
{
  unsigned int i;
  for(i = 0; i < 5; i++) {
  107098:	83 fb 05             	cmp    $0x5,%ebx
  10709b:	75 ba                	jne    107057 <sys_produce+0x7>
	intr_local_disable();
    KERN_DEBUG("CPU %d: Process %d: Produced %d\n", get_pcpu_idx(), get_curid(), i);
  	intr_local_enable();
  }
	syscall_set_errno(tf, E_SUCC);
  10709d:	8b 44 24 30          	mov    0x30(%esp),%eax
  1070a1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1070a8:	00 
  1070a9:	89 04 24             	mov    %eax,(%esp)
  1070ac:	e8 8f fc ff ff       	call   106d40 <syscall_set_errno>
}
  1070b1:	83 c4 24             	add    $0x24,%esp
  1070b4:	5b                   	pop    %ebx
  1070b5:	5e                   	pop    %esi
  1070b6:	c3                   	ret    
  1070b7:	89 f6                	mov    %esi,%esi
  1070b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001070c0 <sys_consume>:

void sys_consume(tf_t *tf)
{
  1070c0:	56                   	push   %esi
  1070c1:	53                   	push   %ebx
  unsigned int i;
  for(i = 0; i < 5; i++) {
  1070c2:	31 db                	xor    %ebx,%ebx
  }
	syscall_set_errno(tf, E_SUCC);
}

void sys_consume(tf_t *tf)
{
  1070c4:	83 ec 24             	sub    $0x24,%esp
  unsigned int i;
  for(i = 0; i < 5; i++) {
	intr_local_disable();
  1070c7:	e8 d4 a6 ff ff       	call   1017a0 <intr_local_disable>
    KERN_DEBUG("CPU %d: Process %d: Consumed %d\n", get_pcpu_idx(), get_curid(), i);
  1070cc:	e8 6f f8 ff ff       	call   106940 <get_curid>
  1070d1:	89 c6                	mov    %eax,%esi
  1070d3:	e8 e8 e3 ff ff       	call   1054c0 <get_pcpu_idx>
  1070d8:	89 5c 24 14          	mov    %ebx,0x14(%esp)
}

void sys_consume(tf_t *tf)
{
  unsigned int i;
  for(i = 0; i < 5; i++) {
  1070dc:	83 c3 01             	add    $0x1,%ebx
	intr_local_disable();
    KERN_DEBUG("CPU %d: Process %d: Consumed %d\n", get_pcpu_idx(), get_curid(), i);
  1070df:	89 74 24 10          	mov    %esi,0x10(%esp)
  1070e3:	c7 44 24 08 48 94 10 	movl   $0x109448,0x8(%esp)
  1070ea:	00 
  1070eb:	c7 44 24 04 97 00 00 	movl   $0x97,0x4(%esp)
  1070f2:	00 
  1070f3:	c7 04 24 05 94 10 00 	movl   $0x109405,(%esp)
  1070fa:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1070fe:	e8 2d c9 ff ff       	call   103a30 <debug_normal>
  	intr_local_enable();
  107103:	e8 88 a6 ff ff       	call   101790 <intr_local_enable>
}

void sys_consume(tf_t *tf)
{
  unsigned int i;
  for(i = 0; i < 5; i++) {
  107108:	83 fb 05             	cmp    $0x5,%ebx
  10710b:	75 ba                	jne    1070c7 <sys_consume+0x7>
	intr_local_disable();
    KERN_DEBUG("CPU %d: Process %d: Consumed %d\n", get_pcpu_idx(), get_curid(), i);
  	intr_local_enable();
  }
	syscall_set_errno(tf, E_SUCC);
  10710d:	8b 44 24 30          	mov    0x30(%esp),%eax
  107111:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  107118:	00 
  107119:	89 04 24             	mov    %eax,(%esp)
  10711c:	e8 1f fc ff ff       	call   106d40 <syscall_set_errno>
}
  107121:	83 c4 24             	add    $0x24,%esp
  107124:	5b                   	pop    %ebx
  107125:	5e                   	pop    %esi
  107126:	c3                   	ret    
  107127:	66 90                	xchg   %ax,%ax
  107129:	66 90                	xchg   %ax,%ax
  10712b:	66 90                	xchg   %ax,%ax
  10712d:	66 90                	xchg   %ax,%ax
  10712f:	90                   	nop

00107130 <syscall_dispatch>:
#include <pcpu/PCPUIntro/export.h>

#include "import.h"

void syscall_dispatch(tf_t *tf)
{
  107130:	53                   	push   %ebx
  107131:	83 ec 18             	sub    $0x18,%esp
  107134:	8b 5c 24 20          	mov    0x20(%esp),%ebx
	unsigned int nr;

	nr = syscall_get_arg1(tf);
  107138:	89 1c 24             	mov    %ebx,(%esp)
  10713b:	e8 40 fb ff ff       	call   106c80 <syscall_get_arg1>

	switch (nr) {
  107140:	83 f8 04             	cmp    $0x4,%eax
  107143:	77 6b                	ja     1071b0 <syscall_dispatch+0x80>
  107145:	ff 24 85 6c 94 10 00 	jmp    *0x10946c(,%eax,4)
  10714c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		 *   None.
		 */
		sys_yield(tf);
		break;
  case SYS_produce:
    intr_local_enable();
  107150:	e8 3b a6 ff ff       	call   101790 <intr_local_enable>
	sys_produce(tf);
  107155:	89 1c 24             	mov    %ebx,(%esp)
  107158:	e8 f3 fe ff ff       	call   107050 <sys_produce>
	intr_local_disable();
    break;
	default:
		syscall_set_errno(E_INVAL_CALLNR);
	}
}
  10715d:	83 c4 18             	add    $0x18,%esp
  107160:	5b                   	pop    %ebx
		sys_yield(tf);
		break;
  case SYS_produce:
    intr_local_enable();
	sys_produce(tf);
	intr_local_disable();
  107161:	e9 3a a6 ff ff       	jmp    1017a0 <intr_local_disable>
  107166:	66 90                	xchg   %ax,%ax
    break;
  case SYS_consume:
    intr_local_enable();
  107168:	e8 23 a6 ff ff       	call   101790 <intr_local_enable>
	sys_consume(tf);
  10716d:	89 1c 24             	mov    %ebx,(%esp)
  107170:	e8 4b ff ff ff       	call   1070c0 <sys_consume>
	intr_local_disable();
    break;
	default:
		syscall_set_errno(E_INVAL_CALLNR);
	}
}
  107175:	83 c4 18             	add    $0x18,%esp
  107178:	5b                   	pop    %ebx
	intr_local_disable();
    break;
  case SYS_consume:
    intr_local_enable();
	sys_consume(tf);
	intr_local_disable();
  107179:	e9 22 a6 ff ff       	jmp    1017a0 <intr_local_disable>
  10717e:	66 90                	xchg   %ax,%ax
		 *   None.
		 *
		 * Error:
		 *   E_MEM
		 */
		sys_puts(tf);
  107180:	89 5c 24 20          	mov    %ebx,0x20(%esp)
	intr_local_disable();
    break;
	default:
		syscall_set_errno(E_INVAL_CALLNR);
	}
}
  107184:	83 c4 18             	add    $0x18,%esp
  107187:	5b                   	pop    %ebx
		 *   None.
		 *
		 * Error:
		 *   E_MEM
		 */
		sys_puts(tf);
  107188:	e9 73 fc ff ff       	jmp    106e00 <sys_puts>
  10718d:	8d 76 00             	lea    0x0(%esi),%esi
		 *   the process ID of the process
		 *
		 * Error:
		 *   E_INVAL_ADDR, E_INVAL_PID
		 */
		sys_spawn(tf);
  107190:	89 5c 24 20          	mov    %ebx,0x20(%esp)
	intr_local_disable();
    break;
	default:
		syscall_set_errno(E_INVAL_CALLNR);
	}
}
  107194:	83 c4 18             	add    $0x18,%esp
  107197:	5b                   	pop    %ebx
		 *   the process ID of the process
		 *
		 * Error:
		 *   E_INVAL_ADDR, E_INVAL_PID
		 */
		sys_spawn(tf);
  107198:	e9 83 fd ff ff       	jmp    106f20 <sys_spawn>
  10719d:	8d 76 00             	lea    0x0(%esi),%esi
		 *   None.
		 *
		 * Error:
		 *   None.
		 */
		sys_yield(tf);
  1071a0:	89 5c 24 20          	mov    %ebx,0x20(%esp)
	intr_local_disable();
    break;
	default:
		syscall_set_errno(E_INVAL_CALLNR);
	}
}
  1071a4:	83 c4 18             	add    $0x18,%esp
  1071a7:	5b                   	pop    %ebx
		 *   None.
		 *
		 * Error:
		 *   None.
		 */
		sys_yield(tf);
  1071a8:	e9 83 fe ff ff       	jmp    107030 <sys_yield>
  1071ad:	8d 76 00             	lea    0x0(%esi),%esi
    intr_local_enable();
	sys_consume(tf);
	intr_local_disable();
    break;
	default:
		syscall_set_errno(E_INVAL_CALLNR);
  1071b0:	c7 44 24 20 03 00 00 	movl   $0x3,0x20(%esp)
  1071b7:	00 
	}
}
  1071b8:	83 c4 18             	add    $0x18,%esp
  1071bb:	5b                   	pop    %ebx
    intr_local_enable();
	sys_consume(tf);
	intr_local_disable();
    break;
	default:
		syscall_set_errno(E_INVAL_CALLNR);
  1071bc:	e9 7f fb ff ff       	jmp    106d40 <syscall_set_errno>
  1071c1:	66 90                	xchg   %ax,%ax
  1071c3:	66 90                	xchg   %ax,%ax
  1071c5:	66 90                	xchg   %ax,%ax
  1071c7:	66 90                	xchg   %ax,%ax
  1071c9:	66 90                	xchg   %ax,%ax
  1071cb:	66 90                	xchg   %ax,%ax
  1071cd:	66 90                	xchg   %ax,%ax
  1071cf:	90                   	nop

001071d0 <default_exception_handler>:
	KERN_DEBUG("\t%08x:\tesp:   \t\t%08x\n", &tf->esp, tf->esp);
	KERN_DEBUG("\t%08x:\tss:    \t\t%08x\n", &tf->ss, tf->ss);
}

void default_exception_handler(tf_t *tf)
{
  1071d0:	53                   	push   %ebx
  1071d1:	83 ec 28             	sub    $0x28,%esp
  1071d4:	8b 5c 24 30          	mov    0x30(%esp),%ebx
	unsigned int cur_pid;

	cur_pid = get_curid();
  1071d8:	e8 63 f7 ff ff       	call   106940 <get_curid>

#include "import.h"

static void trap_dump(tf_t *tf)
{
	if (tf == NULL)
  1071dd:	85 db                	test   %ebx,%ebx
  1071df:	0f 84 ea 02 00 00    	je     1074cf <default_exception_handler+0x2ff>
		return;

	uintptr_t base = (uintptr_t) tf;

	KERN_DEBUG("trapframe at %x\n", base);
  1071e5:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  1071e9:	c7 44 24 08 80 94 10 	movl   $0x109480,0x8(%esp)
  1071f0:	00 
  1071f1:	c7 44 24 04 15 00 00 	movl   $0x15,0x4(%esp)
  1071f8:	00 
  1071f9:	c7 04 24 04 96 10 00 	movl   $0x109604,(%esp)
  107200:	e8 2b c8 ff ff       	call   103a30 <debug_normal>
	KERN_DEBUG("\t%08x:\tedi:   \t\t%08x\n", &tf->regs.edi, tf->regs.edi);
  107205:	8b 03                	mov    (%ebx),%eax
  107207:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  10720b:	c7 44 24 08 91 94 10 	movl   $0x109491,0x8(%esp)
  107212:	00 
  107213:	c7 44 24 04 16 00 00 	movl   $0x16,0x4(%esp)
  10721a:	00 
  10721b:	89 44 24 10          	mov    %eax,0x10(%esp)
  10721f:	c7 04 24 04 96 10 00 	movl   $0x109604,(%esp)
  107226:	e8 05 c8 ff ff       	call   103a30 <debug_normal>
	KERN_DEBUG("\t%08x:\tesi:   \t\t%08x\n", &tf->regs.esi, tf->regs.esi);
  10722b:	8b 43 04             	mov    0x4(%ebx),%eax
  10722e:	c7 44 24 08 a7 94 10 	movl   $0x1094a7,0x8(%esp)
  107235:	00 
  107236:	c7 44 24 04 17 00 00 	movl   $0x17,0x4(%esp)
  10723d:	00 
  10723e:	c7 04 24 04 96 10 00 	movl   $0x109604,(%esp)
  107245:	89 44 24 10          	mov    %eax,0x10(%esp)
  107249:	8d 43 04             	lea    0x4(%ebx),%eax
  10724c:	89 44 24 0c          	mov    %eax,0xc(%esp)
  107250:	e8 db c7 ff ff       	call   103a30 <debug_normal>
	KERN_DEBUG("\t%08x:\tebp:   \t\t%08x\n", &tf->regs.ebp, tf->regs.ebp);
  107255:	8b 43 08             	mov    0x8(%ebx),%eax
  107258:	c7 44 24 08 bd 94 10 	movl   $0x1094bd,0x8(%esp)
  10725f:	00 
  107260:	c7 44 24 04 18 00 00 	movl   $0x18,0x4(%esp)
  107267:	00 
  107268:	c7 04 24 04 96 10 00 	movl   $0x109604,(%esp)
  10726f:	89 44 24 10          	mov    %eax,0x10(%esp)
  107273:	8d 43 08             	lea    0x8(%ebx),%eax
  107276:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10727a:	e8 b1 c7 ff ff       	call   103a30 <debug_normal>
	KERN_DEBUG("\t%08x:\tesp:   \t\t%08x\n", &tf->regs.oesp, tf->regs.oesp);
  10727f:	8b 43 0c             	mov    0xc(%ebx),%eax
  107282:	c7 44 24 08 d3 94 10 	movl   $0x1094d3,0x8(%esp)
  107289:	00 
  10728a:	c7 44 24 04 19 00 00 	movl   $0x19,0x4(%esp)
  107291:	00 
  107292:	c7 04 24 04 96 10 00 	movl   $0x109604,(%esp)
  107299:	89 44 24 10          	mov    %eax,0x10(%esp)
  10729d:	8d 43 0c             	lea    0xc(%ebx),%eax
  1072a0:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1072a4:	e8 87 c7 ff ff       	call   103a30 <debug_normal>
	KERN_DEBUG("\t%08x:\tebx:   \t\t%08x\n", &tf->regs.ebx, tf->regs.ebx);
  1072a9:	8b 43 10             	mov    0x10(%ebx),%eax
  1072ac:	c7 44 24 08 e9 94 10 	movl   $0x1094e9,0x8(%esp)
  1072b3:	00 
  1072b4:	c7 44 24 04 1a 00 00 	movl   $0x1a,0x4(%esp)
  1072bb:	00 
  1072bc:	c7 04 24 04 96 10 00 	movl   $0x109604,(%esp)
  1072c3:	89 44 24 10          	mov    %eax,0x10(%esp)
  1072c7:	8d 43 10             	lea    0x10(%ebx),%eax
  1072ca:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1072ce:	e8 5d c7 ff ff       	call   103a30 <debug_normal>
	KERN_DEBUG("\t%08x:\tedx:   \t\t%08x\n", &tf->regs.edx, tf->regs.edx);
  1072d3:	8b 43 14             	mov    0x14(%ebx),%eax
  1072d6:	c7 44 24 08 ff 94 10 	movl   $0x1094ff,0x8(%esp)
  1072dd:	00 
  1072de:	c7 44 24 04 1b 00 00 	movl   $0x1b,0x4(%esp)
  1072e5:	00 
  1072e6:	c7 04 24 04 96 10 00 	movl   $0x109604,(%esp)
  1072ed:	89 44 24 10          	mov    %eax,0x10(%esp)
  1072f1:	8d 43 14             	lea    0x14(%ebx),%eax
  1072f4:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1072f8:	e8 33 c7 ff ff       	call   103a30 <debug_normal>
	KERN_DEBUG("\t%08x:\tecx:   \t\t%08x\n", &tf->regs.ecx, tf->regs.ecx);
  1072fd:	8b 43 18             	mov    0x18(%ebx),%eax
  107300:	c7 44 24 08 15 95 10 	movl   $0x109515,0x8(%esp)
  107307:	00 
  107308:	c7 44 24 04 1c 00 00 	movl   $0x1c,0x4(%esp)
  10730f:	00 
  107310:	c7 04 24 04 96 10 00 	movl   $0x109604,(%esp)
  107317:	89 44 24 10          	mov    %eax,0x10(%esp)
  10731b:	8d 43 18             	lea    0x18(%ebx),%eax
  10731e:	89 44 24 0c          	mov    %eax,0xc(%esp)
  107322:	e8 09 c7 ff ff       	call   103a30 <debug_normal>
	KERN_DEBUG("\t%08x:\teax:   \t\t%08x\n", &tf->regs.eax, tf->regs.eax);
  107327:	8b 43 1c             	mov    0x1c(%ebx),%eax
  10732a:	c7 44 24 08 2b 95 10 	movl   $0x10952b,0x8(%esp)
  107331:	00 
  107332:	c7 44 24 04 1d 00 00 	movl   $0x1d,0x4(%esp)
  107339:	00 
  10733a:	c7 04 24 04 96 10 00 	movl   $0x109604,(%esp)
  107341:	89 44 24 10          	mov    %eax,0x10(%esp)
  107345:	8d 43 1c             	lea    0x1c(%ebx),%eax
  107348:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10734c:	e8 df c6 ff ff       	call   103a30 <debug_normal>
	KERN_DEBUG("\t%08x:\tes:    \t\t%08x\n", &tf->es, tf->es);
  107351:	0f b7 43 20          	movzwl 0x20(%ebx),%eax
  107355:	c7 44 24 08 41 95 10 	movl   $0x109541,0x8(%esp)
  10735c:	00 
  10735d:	c7 44 24 04 1e 00 00 	movl   $0x1e,0x4(%esp)
  107364:	00 
  107365:	c7 04 24 04 96 10 00 	movl   $0x109604,(%esp)
  10736c:	89 44 24 10          	mov    %eax,0x10(%esp)
  107370:	8d 43 20             	lea    0x20(%ebx),%eax
  107373:	89 44 24 0c          	mov    %eax,0xc(%esp)
  107377:	e8 b4 c6 ff ff       	call   103a30 <debug_normal>
	KERN_DEBUG("\t%08x:\tds:    \t\t%08x\n", &tf->ds, tf->ds);
  10737c:	0f b7 43 24          	movzwl 0x24(%ebx),%eax
  107380:	c7 44 24 08 57 95 10 	movl   $0x109557,0x8(%esp)
  107387:	00 
  107388:	c7 44 24 04 1f 00 00 	movl   $0x1f,0x4(%esp)
  10738f:	00 
  107390:	c7 04 24 04 96 10 00 	movl   $0x109604,(%esp)
  107397:	89 44 24 10          	mov    %eax,0x10(%esp)
  10739b:	8d 43 24             	lea    0x24(%ebx),%eax
  10739e:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1073a2:	e8 89 c6 ff ff       	call   103a30 <debug_normal>
	KERN_DEBUG("\t%08x:\ttrapno:\t\t%08x\n", &tf->trapno, tf->trapno);
  1073a7:	8b 43 28             	mov    0x28(%ebx),%eax
  1073aa:	c7 44 24 08 6d 95 10 	movl   $0x10956d,0x8(%esp)
  1073b1:	00 
  1073b2:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  1073b9:	00 
  1073ba:	c7 04 24 04 96 10 00 	movl   $0x109604,(%esp)
  1073c1:	89 44 24 10          	mov    %eax,0x10(%esp)
  1073c5:	8d 43 28             	lea    0x28(%ebx),%eax
  1073c8:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1073cc:	e8 5f c6 ff ff       	call   103a30 <debug_normal>
	KERN_DEBUG("\t%08x:\terr:   \t\t%08x\n", &tf->err, tf->err);
  1073d1:	8b 43 2c             	mov    0x2c(%ebx),%eax
  1073d4:	c7 44 24 08 83 95 10 	movl   $0x109583,0x8(%esp)
  1073db:	00 
  1073dc:	c7 44 24 04 21 00 00 	movl   $0x21,0x4(%esp)
  1073e3:	00 
  1073e4:	c7 04 24 04 96 10 00 	movl   $0x109604,(%esp)
  1073eb:	89 44 24 10          	mov    %eax,0x10(%esp)
  1073ef:	8d 43 2c             	lea    0x2c(%ebx),%eax
  1073f2:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1073f6:	e8 35 c6 ff ff       	call   103a30 <debug_normal>
	KERN_DEBUG("\t%08x:\teip:   \t\t%08x\n", &tf->eip, tf->eip);
  1073fb:	8b 43 30             	mov    0x30(%ebx),%eax
  1073fe:	c7 44 24 08 99 95 10 	movl   $0x109599,0x8(%esp)
  107405:	00 
  107406:	c7 44 24 04 22 00 00 	movl   $0x22,0x4(%esp)
  10740d:	00 
  10740e:	c7 04 24 04 96 10 00 	movl   $0x109604,(%esp)
  107415:	89 44 24 10          	mov    %eax,0x10(%esp)
  107419:	8d 43 30             	lea    0x30(%ebx),%eax
  10741c:	89 44 24 0c          	mov    %eax,0xc(%esp)
  107420:	e8 0b c6 ff ff       	call   103a30 <debug_normal>
	KERN_DEBUG("\t%08x:\tcs:    \t\t%08x\n", &tf->cs, tf->cs);
  107425:	0f b7 43 34          	movzwl 0x34(%ebx),%eax
  107429:	c7 44 24 08 af 95 10 	movl   $0x1095af,0x8(%esp)
  107430:	00 
  107431:	c7 44 24 04 23 00 00 	movl   $0x23,0x4(%esp)
  107438:	00 
  107439:	c7 04 24 04 96 10 00 	movl   $0x109604,(%esp)
  107440:	89 44 24 10          	mov    %eax,0x10(%esp)
  107444:	8d 43 34             	lea    0x34(%ebx),%eax
  107447:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10744b:	e8 e0 c5 ff ff       	call   103a30 <debug_normal>
	KERN_DEBUG("\t%08x:\teflags:\t\t%08x\n", &tf->eflags, tf->eflags);
  107450:	8b 43 38             	mov    0x38(%ebx),%eax
  107453:	c7 44 24 08 c5 95 10 	movl   $0x1095c5,0x8(%esp)
  10745a:	00 
  10745b:	c7 44 24 04 24 00 00 	movl   $0x24,0x4(%esp)
  107462:	00 
  107463:	c7 04 24 04 96 10 00 	movl   $0x109604,(%esp)
  10746a:	89 44 24 10          	mov    %eax,0x10(%esp)
  10746e:	8d 43 38             	lea    0x38(%ebx),%eax
  107471:	89 44 24 0c          	mov    %eax,0xc(%esp)
  107475:	e8 b6 c5 ff ff       	call   103a30 <debug_normal>
	KERN_DEBUG("\t%08x:\tesp:   \t\t%08x\n", &tf->esp, tf->esp);
  10747a:	8b 43 3c             	mov    0x3c(%ebx),%eax
  10747d:	c7 44 24 08 d3 94 10 	movl   $0x1094d3,0x8(%esp)
  107484:	00 
  107485:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
  10748c:	00 
  10748d:	c7 04 24 04 96 10 00 	movl   $0x109604,(%esp)
  107494:	89 44 24 10          	mov    %eax,0x10(%esp)
  107498:	8d 43 3c             	lea    0x3c(%ebx),%eax
  10749b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10749f:	e8 8c c5 ff ff       	call   103a30 <debug_normal>
	KERN_DEBUG("\t%08x:\tss:    \t\t%08x\n", &tf->ss, tf->ss);
  1074a4:	0f b7 43 40          	movzwl 0x40(%ebx),%eax
  1074a8:	c7 44 24 08 db 95 10 	movl   $0x1095db,0x8(%esp)
  1074af:	00 
  1074b0:	c7 44 24 04 26 00 00 	movl   $0x26,0x4(%esp)
  1074b7:	00 
  1074b8:	c7 04 24 04 96 10 00 	movl   $0x109604,(%esp)
  1074bf:	89 44 24 10          	mov    %eax,0x10(%esp)
  1074c3:	8d 43 40             	lea    0x40(%ebx),%eax
  1074c6:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1074ca:	e8 61 c5 ff ff       	call   103a30 <debug_normal>
	unsigned int cur_pid;

	cur_pid = get_curid();
	trap_dump(tf);

	KERN_PANIC("Trap %d @ 0x%08x.\n", tf -> trapno, tf -> eip);
  1074cf:	8b 43 30             	mov    0x30(%ebx),%eax
  1074d2:	89 44 24 10          	mov    %eax,0x10(%esp)
  1074d6:	8b 43 28             	mov    0x28(%ebx),%eax
  1074d9:	c7 44 24 08 f1 95 10 	movl   $0x1095f1,0x8(%esp)
  1074e0:	00 
  1074e1:	c7 44 24 04 30 00 00 	movl   $0x30,0x4(%esp)
  1074e8:	00 
  1074e9:	c7 04 24 04 96 10 00 	movl   $0x109604,(%esp)
  1074f0:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1074f4:	e8 87 c5 ff ff       	call   103a80 <debug_panic>
}
  1074f9:	83 c4 28             	add    $0x28,%esp
  1074fc:	5b                   	pop    %ebx
  1074fd:	c3                   	ret    
  1074fe:	66 90                	xchg   %ax,%ax

00107500 <pgflt_handler>:

void pgflt_handler(tf_t *tf)
{
  107500:	57                   	push   %edi
  107501:	56                   	push   %esi
  107502:	53                   	push   %ebx
  107503:	83 ec 20             	sub    $0x20,%esp
	unsigned int cur_pid;
	unsigned int errno;
	unsigned int fault_va;

	cur_pid = get_curid();
  107506:	e8 35 f4 ff ff       	call   106940 <get_curid>
	errno = tf -> err;
  10750b:	8b 54 24 30          	mov    0x30(%esp),%edx
  10750f:	8b 5a 2c             	mov    0x2c(%edx),%ebx
{
	unsigned int cur_pid;
	unsigned int errno;
	unsigned int fault_va;

	cur_pid = get_curid();
  107512:	89 c7                	mov    %eax,%edi
	errno = tf -> err;
	fault_va = rcr2();
  107514:	e8 b7 d3 ff ff       	call   1048d0 <rcr2>

  //Uncomment this line if you need to see the information of the sequence of page faults occured.
	//KERN_DEBUG("Page fault: VA 0x%08x, errno 0x%08x, process %d, EIP 0x%08x.\n", fault_va, errno, cur_pid, tf -> eip);

	if (errno & PFE_PR) {
  107519:	f6 c3 01             	test   $0x1,%bl
	unsigned int errno;
	unsigned int fault_va;

	cur_pid = get_curid();
	errno = tf -> err;
	fault_va = rcr2();
  10751c:	89 c6                	mov    %eax,%esi

  //Uncomment this line if you need to see the information of the sequence of page faults occured.
	//KERN_DEBUG("Page fault: VA 0x%08x, errno 0x%08x, process %d, EIP 0x%08x.\n", fault_va, errno, cur_pid, tf -> eip);

	if (errno & PFE_PR) {
  10751e:	75 28                	jne    107548 <pgflt_handler+0x48>
		KERN_PANIC("Permission denied: va = 0x%08x, errno = 0x%08x.\n", fault_va, errno);
		return;
	}

	if (alloc_page(cur_pid, fault_va, PTE_W | PTE_U | PTE_P) == MagicNumber)
  107520:	c7 44 24 08 07 00 00 	movl   $0x7,0x8(%esp)
  107527:	00 
  107528:	89 44 24 04          	mov    %eax,0x4(%esp)
  10752c:	89 3c 24             	mov    %edi,(%esp)
  10752f:	e8 7c ee ff ff       	call   1063b0 <alloc_page>
  107534:	3d 01 00 10 00       	cmp    $0x100001,%eax
  107539:	74 3d                	je     107578 <pgflt_handler+0x78>
    KERN_PANIC("Page allocation failed: va = 0x%08x, errno = 0x%08x.\n", fault_va, errno);

}
  10753b:	83 c4 20             	add    $0x20,%esp
  10753e:	5b                   	pop    %ebx
  10753f:	5e                   	pop    %esi
  107540:	5f                   	pop    %edi
  107541:	c3                   	ret    
  107542:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  //Uncomment this line if you need to see the information of the sequence of page faults occured.
	//KERN_DEBUG("Page fault: VA 0x%08x, errno 0x%08x, process %d, EIP 0x%08x.\n", fault_va, errno, cur_pid, tf -> eip);

	if (errno & PFE_PR) {
		KERN_PANIC("Permission denied: va = 0x%08x, errno = 0x%08x.\n", fault_va, errno);
  107548:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  10754c:	89 44 24 0c          	mov    %eax,0xc(%esp)
  107550:	c7 44 24 08 2c 96 10 	movl   $0x10962c,0x8(%esp)
  107557:	00 
  107558:	c7 44 24 04 41 00 00 	movl   $0x41,0x4(%esp)
  10755f:	00 
  107560:	c7 04 24 04 96 10 00 	movl   $0x109604,(%esp)
  107567:	e8 14 c5 ff ff       	call   103a80 <debug_panic>
	}

	if (alloc_page(cur_pid, fault_va, PTE_W | PTE_U | PTE_P) == MagicNumber)
    KERN_PANIC("Page allocation failed: va = 0x%08x, errno = 0x%08x.\n", fault_va, errno);

}
  10756c:	83 c4 20             	add    $0x20,%esp
  10756f:	5b                   	pop    %ebx
  107570:	5e                   	pop    %esi
  107571:	5f                   	pop    %edi
  107572:	c3                   	ret    
  107573:	90                   	nop
  107574:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		KERN_PANIC("Permission denied: va = 0x%08x, errno = 0x%08x.\n", fault_va, errno);
		return;
	}

	if (alloc_page(cur_pid, fault_va, PTE_W | PTE_U | PTE_P) == MagicNumber)
    KERN_PANIC("Page allocation failed: va = 0x%08x, errno = 0x%08x.\n", fault_va, errno);
  107578:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  10757c:	89 74 24 0c          	mov    %esi,0xc(%esp)
  107580:	c7 44 24 08 60 96 10 	movl   $0x109660,0x8(%esp)
  107587:	00 
  107588:	c7 44 24 04 46 00 00 	movl   $0x46,0x4(%esp)
  10758f:	00 
  107590:	c7 04 24 04 96 10 00 	movl   $0x109604,(%esp)
  107597:	e8 e4 c4 ff ff       	call   103a80 <debug_panic>

}
  10759c:	83 c4 20             	add    $0x20,%esp
  10759f:	5b                   	pop    %ebx
  1075a0:	5e                   	pop    %esi
  1075a1:	5f                   	pop    %edi
  1075a2:	c3                   	ret    
  1075a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1075a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001075b0 <exception_handler>:
/**
 * We currently only handle the page fault exception.
 * All other exceptions should be routed to the default exception handler.
 */
void exception_handler(tf_t *tf)
{
  1075b0:	53                   	push   %ebx
  1075b1:	83 ec 08             	sub    $0x8,%esp
  1075b4:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	unsigned int cur_pid;
	unsigned int trapno;

	cur_pid = get_curid();
  1075b8:	e8 83 f3 ff ff       	call   106940 <get_curid>
	trapno = tf -> trapno;

	if (trapno == T_PGFLT)
  1075bd:	83 7b 28 0e          	cmpl   $0xe,0x28(%ebx)
		pgflt_handler(tf);
  1075c1:	89 5c 24 10          	mov    %ebx,0x10(%esp)
	unsigned int trapno;

	cur_pid = get_curid();
	trapno = tf -> trapno;

	if (trapno == T_PGFLT)
  1075c5:	74 09                	je     1075d0 <exception_handler+0x20>
		pgflt_handler(tf);
	else
		default_exception_handler(tf);
}
  1075c7:	83 c4 08             	add    $0x8,%esp
  1075ca:	5b                   	pop    %ebx
	trapno = tf -> trapno;

	if (trapno == T_PGFLT)
		pgflt_handler(tf);
	else
		default_exception_handler(tf);
  1075cb:	e9 00 fc ff ff       	jmp    1071d0 <default_exception_handler>
}
  1075d0:	83 c4 08             	add    $0x8,%esp
  1075d3:	5b                   	pop    %ebx

	cur_pid = get_curid();
	trapno = tf -> trapno;

	if (trapno == T_PGFLT)
		pgflt_handler(tf);
  1075d4:	e9 27 ff ff ff       	jmp    107500 <pgflt_handler>
  1075d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001075e0 <interrupt_handler>:
/**
 * Any interrupt request except the spurious or timer should be
 * routed to the default interrupt handler.
 */
void interrupt_handler (tf_t *tf)
{
  1075e0:	53                   	push   %ebx
  1075e1:	83 ec 08             	sub    $0x8,%esp
  1075e4:	8b 5c 24 10          	mov    0x10(%esp),%ebx
    unsigned int cur_pid;
    unsigned int trapno;

    cur_pid = get_curid ();
  1075e8:	e8 53 f3 ff ff       	call   106940 <get_curid>

    trapno = tf -> trapno;

    switch (trapno)
  1075ed:	8b 43 28             	mov    0x28(%ebx),%eax
  1075f0:	83 f8 20             	cmp    $0x20,%eax
  1075f3:	74 1b                	je     107610 <interrupt_handler+0x30>
  1075f5:	83 f8 27             	cmp    $0x27,%eax
  1075f8:	75 06                	jne    107600 <interrupt_handler+0x20>
          timer_intr_handler ();
          break;
      default:
          default_intr_handler ();
    }
}
  1075fa:	83 c4 08             	add    $0x8,%esp
  1075fd:	5b                   	pop    %ebx
  1075fe:	c3                   	ret    
  1075ff:	90                   	nop
  107600:	83 c4 08             	add    $0x8,%esp
  107603:	5b                   	pop    %ebx
    return 0;
}

static int default_intr_handler (void)
{
    intr_eoi ();
  107604:	e9 67 a1 ff ff       	jmp    101770 <intr_eoi>
  107609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return 0;
}

static int timer_intr_handler (void)
{
    intr_eoi ();
  107610:	e8 5b a1 ff ff       	call   101770 <intr_eoi>
          timer_intr_handler ();
          break;
      default:
          default_intr_handler ();
    }
}
  107615:	83 c4 08             	add    $0x8,%esp
  107618:	5b                   	pop    %ebx
}

static int timer_intr_handler (void)
{
    intr_eoi ();
	sched_update();
  107619:	e9 12 f5 ff ff       	jmp    106b30 <sched_update>
  10761e:	66 90                	xchg   %ax,%ax

00107620 <trap>:
          default_intr_handler ();
    }
}

void trap (tf_t *tf)
{
  107620:	57                   	push   %edi
  107621:	56                   	push   %esi
  107622:	53                   	push   %ebx
  107623:	83 ec 20             	sub    $0x20,%esp
  107626:	8b 74 24 30          	mov    0x30(%esp),%esi
    unsigned int cur_pid;
    unsigned int in_kernel;

    cur_pid = get_curid ();
  10762a:	e8 11 f3 ff ff       	call   106940 <get_curid>
    set_pdir_base (0); //switch to the kernel's page table.
  10762f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
void trap (tf_t *tf)
{
    unsigned int cur_pid;
    unsigned int in_kernel;

    cur_pid = get_curid ();
  107636:	89 c3                	mov    %eax,%ebx
    set_pdir_base (0); //switch to the kernel's page table.
  107638:	e8 53 e8 ff ff       	call   105e90 <set_pdir_base>
    int cpuID = get_pcpu_idx();
  10763d:	e8 7e de ff ff       	call   1054c0 <get_pcpu_idx>
  107642:	89 c7                	mov    %eax,%edi
    trap_cb_t f;

    f = TRAP_HANDLER[get_pcpu_idx()][tf->trapno];
  107644:	e8 77 de ff ff       	call   1054c0 <get_pcpu_idx>
  107649:	8b 4e 28             	mov    0x28(%esi),%ecx
  10764c:	c1 e0 08             	shl    $0x8,%eax
  10764f:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  107652:	8b 04 95 00 60 9b 00 	mov    0x9b6000(,%edx,4),%eax

    if (f){
  107659:	85 c0                	test   %eax,%eax
  10765b:	74 3b                	je     107698 <trap+0x78>
            f(tf);
  10765d:	89 34 24             	mov    %esi,(%esp)
  107660:	ff d0                	call   *%eax
    } else {
            KERN_WARN("No handler for user trap 0x%x, process %d, eip 0x%08x. \n",
                            tf->trapno, cur_pid, tf->eip);
    }
    if (prevID[cpuID] != cur_pid) {
  107662:	39 1c bd 20 d4 96 00 	cmp    %ebx,0x96d420(,%edi,4)
  107669:	74 17                	je     107682 <trap+0x62>
    prevID[cpuID] = cur_pid;
    kstack_switch(cur_pid);
  10766b:	89 1c 24             	mov    %ebx,(%esp)
    } else {
            KERN_WARN("No handler for user trap 0x%x, process %d, eip 0x%08x. \n",
                            tf->trapno, cur_pid, tf->eip);
    }
    if (prevID[cpuID] != cur_pid) {
    prevID[cpuID] = cur_pid;
  10766e:	89 1c bd 20 d4 96 00 	mov    %ebx,0x96d420(,%edi,4)
    kstack_switch(cur_pid);
  107675:	e8 96 cb ff ff       	call   104210 <kstack_switch>
    set_pdir_base(cur_pid);
  10767a:	89 1c 24             	mov    %ebx,(%esp)
  10767d:	e8 0e e8 ff ff       	call   105e90 <set_pdir_base>
	}
	  trap_return((void *) tf);
  107682:	89 74 24 30          	mov    %esi,0x30(%esp)
}
  107686:	83 c4 20             	add    $0x20,%esp
  107689:	5b                   	pop    %ebx
  10768a:	5e                   	pop    %esi
  10768b:	5f                   	pop    %edi
    if (prevID[cpuID] != cur_pid) {
    prevID[cpuID] = cur_pid;
    kstack_switch(cur_pid);
    set_pdir_base(cur_pid);
	}
	  trap_return((void *) tf);
  10768c:	e9 af a9 ff ff       	jmp    102040 <trap_return>
  107691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    f = TRAP_HANDLER[get_pcpu_idx()][tf->trapno];

    if (f){
            f(tf);
    } else {
            KERN_WARN("No handler for user trap 0x%x, process %d, eip 0x%08x. \n",
  107698:	8b 46 30             	mov    0x30(%esi),%eax
  10769b:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  10769f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  1076a3:	c7 44 24 08 98 96 10 	movl   $0x109698,0x8(%esp)
  1076aa:	00 
  1076ab:	89 44 24 14          	mov    %eax,0x14(%esp)
  1076af:	c7 44 24 04 9a 00 00 	movl   $0x9a,0x4(%esp)
  1076b6:	00 
  1076b7:	c7 04 24 04 96 10 00 	movl   $0x109604,(%esp)
  1076be:	e8 8d c4 ff ff       	call   103b50 <debug_warn>
  1076c3:	eb 9d                	jmp    107662 <trap+0x42>
  1076c5:	66 90                	xchg   %ax,%ax
  1076c7:	66 90                	xchg   %ax,%ax
  1076c9:	66 90                	xchg   %ax,%ax
  1076cb:	66 90                	xchg   %ax,%ax
  1076cd:	66 90                	xchg   %ax,%ax
  1076cf:	90                   	nop

001076d0 <trap_init_array>:

int inited = FALSE;

void
trap_init_array(void)
{
  1076d0:	83 ec 1c             	sub    $0x1c,%esp
  KERN_ASSERT(inited == FALSE);
  1076d3:	a1 e0 d3 96 00       	mov    0x96d3e0,%eax
  1076d8:	85 c0                	test   %eax,%eax
  1076da:	74 24                	je     107700 <trap_init_array+0x30>
  1076dc:	c7 44 24 0c d1 96 10 	movl   $0x1096d1,0xc(%esp)
  1076e3:	00 
  1076e4:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  1076eb:	00 
  1076ec:	c7 44 24 04 0b 00 00 	movl   $0xb,0x4(%esp)
  1076f3:	00 
  1076f4:	c7 04 24 4c 97 10 00 	movl   $0x10974c,(%esp)
  1076fb:	e8 80 c3 ff ff       	call   103a80 <debug_panic>
  memzero(&(TRAP_HANDLER), sizeof(trap_cb_t) * 8 * 256);
  107700:	c7 44 24 04 00 20 00 	movl   $0x2000,0x4(%esp)
  107707:	00 
  107708:	c7 04 24 00 60 9b 00 	movl   $0x9b6000,(%esp)
  10770f:	e8 4c c2 ff ff       	call   103960 <memzero>
  inited = TRUE;
  107714:	c7 05 e0 d3 96 00 01 	movl   $0x1,0x96d3e0
  10771b:	00 00 00 
}
  10771e:	83 c4 1c             	add    $0x1c,%esp
  107721:	c3                   	ret    
  107722:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  107729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00107730 <trap_handler_register>:

void
trap_handler_register(int cpu_idx, int trapno, trap_cb_t cb)
{
  107730:	57                   	push   %edi
  107731:	56                   	push   %esi
  107732:	53                   	push   %ebx
  107733:	83 ec 10             	sub    $0x10,%esp
  107736:	8b 7c 24 20          	mov    0x20(%esp),%edi
  10773a:	8b 74 24 24          	mov    0x24(%esp),%esi
  10773e:	8b 5c 24 28          	mov    0x28(%esp),%ebx
  KERN_ASSERT(0 <= cpu_idx && cpu_idx < 8);
  107742:	83 ff 07             	cmp    $0x7,%edi
  107745:	77 21                	ja     107768 <trap_handler_register+0x38>
  KERN_ASSERT(0 <= trapno && trapno < 256);
  107747:	81 fe ff 00 00 00    	cmp    $0xff,%esi
  10774d:	77 45                	ja     107794 <trap_handler_register+0x64>
  KERN_ASSERT(cb != NULL);
  10774f:	85 db                	test   %ebx,%ebx
  107751:	74 69                	je     1077bc <trap_handler_register+0x8c>

  TRAP_HANDLER[cpu_idx][trapno] = cb;
  107753:	c1 e7 08             	shl    $0x8,%edi
  107756:	01 fe                	add    %edi,%esi
  107758:	89 1c b5 00 60 9b 00 	mov    %ebx,0x9b6000(,%esi,4)
}
  10775f:	83 c4 10             	add    $0x10,%esp
  107762:	5b                   	pop    %ebx
  107763:	5e                   	pop    %esi
  107764:	5f                   	pop    %edi
  107765:	c3                   	ret    
  107766:	66 90                	xchg   %ax,%ax
}

void
trap_handler_register(int cpu_idx, int trapno, trap_cb_t cb)
{
  KERN_ASSERT(0 <= cpu_idx && cpu_idx < 8);
  107768:	c7 44 24 0c e1 96 10 	movl   $0x1096e1,0xc(%esp)
  10776f:	00 
  107770:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  107777:	00 
  107778:	c7 44 24 04 13 00 00 	movl   $0x13,0x4(%esp)
  10777f:	00 
  107780:	c7 04 24 4c 97 10 00 	movl   $0x10974c,(%esp)
  107787:	e8 f4 c2 ff ff       	call   103a80 <debug_panic>
  KERN_ASSERT(0 <= trapno && trapno < 256);
  10778c:	81 fe ff 00 00 00    	cmp    $0xff,%esi
  107792:	76 bb                	jbe    10774f <trap_handler_register+0x1f>
  107794:	c7 44 24 0c fd 96 10 	movl   $0x1096fd,0xc(%esp)
  10779b:	00 
  10779c:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  1077a3:	00 
  1077a4:	c7 44 24 04 14 00 00 	movl   $0x14,0x4(%esp)
  1077ab:	00 
  1077ac:	c7 04 24 4c 97 10 00 	movl   $0x10974c,(%esp)
  1077b3:	e8 c8 c2 ff ff       	call   103a80 <debug_panic>
  KERN_ASSERT(cb != NULL);
  1077b8:	85 db                	test   %ebx,%ebx
  1077ba:	75 97                	jne    107753 <trap_handler_register+0x23>
  1077bc:	c7 44 24 0c 19 97 10 	movl   $0x109719,0xc(%esp)
  1077c3:	00 
  1077c4:	c7 44 24 08 df 7e 10 	movl   $0x107edf,0x8(%esp)
  1077cb:	00 
  1077cc:	c7 44 24 04 15 00 00 	movl   $0x15,0x4(%esp)
  1077d3:	00 
  1077d4:	c7 04 24 4c 97 10 00 	movl   $0x10974c,(%esp)
  1077db:	e8 a0 c2 ff ff       	call   103a80 <debug_panic>
  1077e0:	e9 6e ff ff ff       	jmp    107753 <trap_handler_register+0x23>
  1077e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1077e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001077f0 <trap_init>:

  TRAP_HANDLER[cpu_idx][trapno] = cb;
}

void
trap_init(unsigned int cpu_idx){
  1077f0:	56                   	push   %esi
  1077f1:	53                   	push   %ebx
  1077f2:	83 ec 14             	sub    $0x14,%esp
  1077f5:	8b 74 24 20          	mov    0x20(%esp),%esi
	int i;
	
	prevID[cpu_idx] = -1;
	if (cpu_idx == 0){
  1077f9:	85 f6                	test   %esi,%esi

void
trap_init(unsigned int cpu_idx){
	int i;
	
	prevID[cpu_idx] = -1;
  1077fb:	c7 04 b5 20 d4 96 00 	movl   $0xffffffff,0x96d420(,%esi,4)
  107802:	ff ff ff ff 
	if (cpu_idx == 0){
  107806:	0f 84 2a 01 00 00    	je     107936 <trap_init+0x146>
	}

	if (cpu_idx == 0){
		KERN_INFO("[BSP KERN] Register trap handlers ... \n");
	} else {
		KERN_INFO("[AP%d KERN] Register trap handlers ... \n", cpu_idx);
  10780c:	89 74 24 04          	mov    %esi,0x4(%esp)
  107810:	c7 04 24 e4 97 10 00 	movl   $0x1097e4,(%esp)
  107817:	e8 d4 c1 ff ff       	call   1039f0 <debug_info>

  TRAP_HANDLER[cpu_idx][trapno] = cb;
}

void
trap_init(unsigned int cpu_idx){
  10781c:	31 db                	xor    %ebx,%ebx
  10781e:	eb 25                	jmp    107845 <trap_init+0x55>
	{
		if (i < 32) 
		{
			trap_handler_register(cpu_idx, i, exception_handler);
		}
		else if (i == 48)
  107820:	83 fb 30             	cmp    $0x30,%ebx
  107823:	0f 84 23 01 00 00    	je     10794c <trap_init+0x15c>
		{
			trap_handler_register(cpu_idx, i, syscall_dispatch);
		}
		else 
		{
			trap_handler_register(cpu_idx, i, interrupt_handler);
  107829:	89 5c 24 04          	mov    %ebx,0x4(%esp)
		KERN_INFO("[AP%d KERN] Register trap handlers ... \n", cpu_idx);
	}

  // TODO: for CPU # [cpu_idx], register appropriate trap handler for each trap number,
  // with trap_handler_register function defined above.
    for (i = 0; i <= 48; i++) 
  10782d:	83 c3 01             	add    $0x1,%ebx
		{
			trap_handler_register(cpu_idx, i, syscall_dispatch);
		}
		else 
		{
			trap_handler_register(cpu_idx, i, interrupt_handler);
  107830:	c7 44 24 08 e0 75 10 	movl   $0x1075e0,0x8(%esp)
  107837:	00 
  107838:	89 34 24             	mov    %esi,(%esp)
  10783b:	e8 f0 fe ff ff       	call   107730 <trap_handler_register>
		KERN_INFO("[AP%d KERN] Register trap handlers ... \n", cpu_idx);
	}

  // TODO: for CPU # [cpu_idx], register appropriate trap handler for each trap number,
  // with trap_handler_register function defined above.
    for (i = 0; i <= 48; i++) 
  107840:	83 fb 31             	cmp    $0x31,%ebx
  107843:	74 21                	je     107866 <trap_init+0x76>
	{
		if (i < 32) 
  107845:	83 fb 1f             	cmp    $0x1f,%ebx
  107848:	7f d6                	jg     107820 <trap_init+0x30>
		{
			trap_handler_register(cpu_idx, i, exception_handler);
  10784a:	89 5c 24 04          	mov    %ebx,0x4(%esp)
		KERN_INFO("[AP%d KERN] Register trap handlers ... \n", cpu_idx);
	}

  // TODO: for CPU # [cpu_idx], register appropriate trap handler for each trap number,
  // with trap_handler_register function defined above.
    for (i = 0; i <= 48; i++) 
  10784e:	83 c3 01             	add    $0x1,%ebx
	{
		if (i < 32) 
		{
			trap_handler_register(cpu_idx, i, exception_handler);
  107851:	c7 44 24 08 b0 75 10 	movl   $0x1075b0,0x8(%esp)
  107858:	00 
  107859:	89 34 24             	mov    %esi,(%esp)
  10785c:	e8 cf fe ff ff       	call   107730 <trap_handler_register>
		KERN_INFO("[AP%d KERN] Register trap handlers ... \n", cpu_idx);
	}

  // TODO: for CPU # [cpu_idx], register appropriate trap handler for each trap number,
  // with trap_handler_register function defined above.
    for (i = 0; i <= 48; i++) 
  107861:	83 fb 31             	cmp    $0x31,%ebx
  107864:	75 df                	jne    107845 <trap_init+0x55>
		else 
		{
			trap_handler_register(cpu_idx, i, interrupt_handler);
		}
	}
	if (cpu_idx == 0){
  107866:	85 f6                	test   %esi,%esi
  107868:	75 66                	jne    1078d0 <trap_init+0xe0>
		KERN_INFO("[BSP KERN] Done.\n");
  10786a:	c7 04 24 24 97 10 00 	movl   $0x109724,(%esp)
  107871:	e8 7a c1 ff ff       	call   1039f0 <debug_info>
	} else {
		KERN_INFO("[AP%d KERN] Done.\n", cpu_idx);
	}

	if (cpu_idx == 0){
		KERN_INFO("[BSP KERN] Enabling interrupts ... \n");
  107876:	c7 04 24 94 97 10 00 	movl   $0x109794,(%esp)
  10787d:	e8 6e c1 ff ff       	call   1039f0 <debug_info>
	} else {
		KERN_INFO("[AP%d KERN] Enabling interrupts ... \n", cpu_idx);
	}

	/* enable interrupts */
  intr_enable (IRQ_TIMER, cpu_idx);
  107882:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  107889:	00 
  10788a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  107891:	e8 4a 9d ff ff       	call   1015e0 <intr_enable>
  intr_enable (IRQ_KBD, cpu_idx);
  107896:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10789d:	00 
  10789e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1078a5:	e8 36 9d ff ff       	call   1015e0 <intr_enable>
 	intr_enable (IRQ_SERIAL13, cpu_idx);
  1078aa:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1078b1:	00 
  1078b2:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  1078b9:	e8 22 9d ff ff       	call   1015e0 <intr_enable>

	if (cpu_idx == 0){
		KERN_INFO("[BSP KERN] Done.\n");
  1078be:	c7 44 24 20 24 97 10 	movl   $0x109724,0x20(%esp)
  1078c5:	00 
	} else {
		KERN_INFO("[AP%d KERN] Done.\n", cpu_idx);
	}

}
  1078c6:	83 c4 14             	add    $0x14,%esp
  1078c9:	5b                   	pop    %ebx
  1078ca:	5e                   	pop    %esi
  intr_enable (IRQ_TIMER, cpu_idx);
  intr_enable (IRQ_KBD, cpu_idx);
 	intr_enable (IRQ_SERIAL13, cpu_idx);

	if (cpu_idx == 0){
		KERN_INFO("[BSP KERN] Done.\n");
  1078cb:	e9 20 c1 ff ff       	jmp    1039f0 <debug_info>
		}
	}
	if (cpu_idx == 0){
		KERN_INFO("[BSP KERN] Done.\n");
	} else {
		KERN_INFO("[AP%d KERN] Done.\n", cpu_idx);
  1078d0:	89 74 24 04          	mov    %esi,0x4(%esp)
  1078d4:	c7 04 24 36 97 10 00 	movl   $0x109736,(%esp)
  1078db:	e8 10 c1 ff ff       	call   1039f0 <debug_info>
	}

	if (cpu_idx == 0){
		KERN_INFO("[BSP KERN] Enabling interrupts ... \n");
	} else {
		KERN_INFO("[AP%d KERN] Enabling interrupts ... \n", cpu_idx);
  1078e0:	89 74 24 04          	mov    %esi,0x4(%esp)
  1078e4:	c7 04 24 bc 97 10 00 	movl   $0x1097bc,(%esp)
  1078eb:	e8 00 c1 ff ff       	call   1039f0 <debug_info>
	}

	/* enable interrupts */
  intr_enable (IRQ_TIMER, cpu_idx);
  1078f0:	89 74 24 04          	mov    %esi,0x4(%esp)
  1078f4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1078fb:	e8 e0 9c ff ff       	call   1015e0 <intr_enable>
  intr_enable (IRQ_KBD, cpu_idx);
  107900:	89 74 24 04          	mov    %esi,0x4(%esp)
  107904:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  10790b:	e8 d0 9c ff ff       	call   1015e0 <intr_enable>
 	intr_enable (IRQ_SERIAL13, cpu_idx);
  107910:	89 74 24 04          	mov    %esi,0x4(%esp)
  107914:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  10791b:	e8 c0 9c ff ff       	call   1015e0 <intr_enable>

	if (cpu_idx == 0){
		KERN_INFO("[BSP KERN] Done.\n");
	} else {
		KERN_INFO("[AP%d KERN] Done.\n", cpu_idx);
  107920:	89 74 24 04          	mov    %esi,0x4(%esp)
  107924:	c7 04 24 36 97 10 00 	movl   $0x109736,(%esp)
  10792b:	e8 c0 c0 ff ff       	call   1039f0 <debug_info>
	}

}
  107930:	83 c4 14             	add    $0x14,%esp
  107933:	5b                   	pop    %ebx
  107934:	5e                   	pop    %esi
  107935:	c3                   	ret    
trap_init(unsigned int cpu_idx){
	int i;
	
	prevID[cpu_idx] = -1;
	if (cpu_idx == 0){
		trap_init_array();
  107936:	e8 95 fd ff ff       	call   1076d0 <trap_init_array>
	}

	if (cpu_idx == 0){
		KERN_INFO("[BSP KERN] Register trap handlers ... \n");
  10793b:	c7 04 24 6c 97 10 00 	movl   $0x10976c,(%esp)
  107942:	e8 a9 c0 ff ff       	call   1039f0 <debug_info>
  107947:	e9 d0 fe ff ff       	jmp    10781c <trap_init+0x2c>
		{
			trap_handler_register(cpu_idx, i, exception_handler);
		}
		else if (i == 48)
		{
			trap_handler_register(cpu_idx, i, syscall_dispatch);
  10794c:	c7 44 24 08 30 71 10 	movl   $0x107130,0x8(%esp)
  107953:	00 
  107954:	c7 44 24 04 30 00 00 	movl   $0x30,0x4(%esp)
  10795b:	00 
  10795c:	89 34 24             	mov    %esi,(%esp)
  10795f:	e8 cc fd ff ff       	call   107730 <trap_handler_register>
  107964:	e9 fd fe ff ff       	jmp    107866 <trap_init+0x76>
  107969:	66 90                	xchg   %ax,%ax
  10796b:	66 90                	xchg   %ax,%ax
  10796d:	66 90                	xchg   %ax,%ax
  10796f:	90                   	nop

00107970 <__udivdi3>:
  107970:	55                   	push   %ebp
  107971:	57                   	push   %edi
  107972:	56                   	push   %esi
  107973:	83 ec 0c             	sub    $0xc,%esp
  107976:	8b 44 24 28          	mov    0x28(%esp),%eax
  10797a:	8b 7c 24 1c          	mov    0x1c(%esp),%edi
  10797e:	8b 6c 24 20          	mov    0x20(%esp),%ebp
  107982:	8b 4c 24 24          	mov    0x24(%esp),%ecx
  107986:	85 c0                	test   %eax,%eax
  107988:	89 7c 24 04          	mov    %edi,0x4(%esp)
  10798c:	89 ea                	mov    %ebp,%edx
  10798e:	89 0c 24             	mov    %ecx,(%esp)
  107991:	75 2d                	jne    1079c0 <__udivdi3+0x50>
  107993:	39 e9                	cmp    %ebp,%ecx
  107995:	77 61                	ja     1079f8 <__udivdi3+0x88>
  107997:	85 c9                	test   %ecx,%ecx
  107999:	89 ce                	mov    %ecx,%esi
  10799b:	75 0b                	jne    1079a8 <__udivdi3+0x38>
  10799d:	b8 01 00 00 00       	mov    $0x1,%eax
  1079a2:	31 d2                	xor    %edx,%edx
  1079a4:	f7 f1                	div    %ecx
  1079a6:	89 c6                	mov    %eax,%esi
  1079a8:	31 d2                	xor    %edx,%edx
  1079aa:	89 e8                	mov    %ebp,%eax
  1079ac:	f7 f6                	div    %esi
  1079ae:	89 c5                	mov    %eax,%ebp
  1079b0:	89 f8                	mov    %edi,%eax
  1079b2:	f7 f6                	div    %esi
  1079b4:	89 ea                	mov    %ebp,%edx
  1079b6:	83 c4 0c             	add    $0xc,%esp
  1079b9:	5e                   	pop    %esi
  1079ba:	5f                   	pop    %edi
  1079bb:	5d                   	pop    %ebp
  1079bc:	c3                   	ret    
  1079bd:	8d 76 00             	lea    0x0(%esi),%esi
  1079c0:	39 e8                	cmp    %ebp,%eax
  1079c2:	77 24                	ja     1079e8 <__udivdi3+0x78>
  1079c4:	0f bd e8             	bsr    %eax,%ebp
  1079c7:	83 f5 1f             	xor    $0x1f,%ebp
  1079ca:	75 3c                	jne    107a08 <__udivdi3+0x98>
  1079cc:	8b 74 24 04          	mov    0x4(%esp),%esi
  1079d0:	39 34 24             	cmp    %esi,(%esp)
  1079d3:	0f 86 9f 00 00 00    	jbe    107a78 <__udivdi3+0x108>
  1079d9:	39 d0                	cmp    %edx,%eax
  1079db:	0f 82 97 00 00 00    	jb     107a78 <__udivdi3+0x108>
  1079e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1079e8:	31 d2                	xor    %edx,%edx
  1079ea:	31 c0                	xor    %eax,%eax
  1079ec:	83 c4 0c             	add    $0xc,%esp
  1079ef:	5e                   	pop    %esi
  1079f0:	5f                   	pop    %edi
  1079f1:	5d                   	pop    %ebp
  1079f2:	c3                   	ret    
  1079f3:	90                   	nop
  1079f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1079f8:	89 f8                	mov    %edi,%eax
  1079fa:	f7 f1                	div    %ecx
  1079fc:	31 d2                	xor    %edx,%edx
  1079fe:	83 c4 0c             	add    $0xc,%esp
  107a01:	5e                   	pop    %esi
  107a02:	5f                   	pop    %edi
  107a03:	5d                   	pop    %ebp
  107a04:	c3                   	ret    
  107a05:	8d 76 00             	lea    0x0(%esi),%esi
  107a08:	89 e9                	mov    %ebp,%ecx
  107a0a:	8b 3c 24             	mov    (%esp),%edi
  107a0d:	d3 e0                	shl    %cl,%eax
  107a0f:	89 c6                	mov    %eax,%esi
  107a11:	b8 20 00 00 00       	mov    $0x20,%eax
  107a16:	29 e8                	sub    %ebp,%eax
  107a18:	89 c1                	mov    %eax,%ecx
  107a1a:	d3 ef                	shr    %cl,%edi
  107a1c:	89 e9                	mov    %ebp,%ecx
  107a1e:	89 7c 24 08          	mov    %edi,0x8(%esp)
  107a22:	8b 3c 24             	mov    (%esp),%edi
  107a25:	09 74 24 08          	or     %esi,0x8(%esp)
  107a29:	89 d6                	mov    %edx,%esi
  107a2b:	d3 e7                	shl    %cl,%edi
  107a2d:	89 c1                	mov    %eax,%ecx
  107a2f:	89 3c 24             	mov    %edi,(%esp)
  107a32:	8b 7c 24 04          	mov    0x4(%esp),%edi
  107a36:	d3 ee                	shr    %cl,%esi
  107a38:	89 e9                	mov    %ebp,%ecx
  107a3a:	d3 e2                	shl    %cl,%edx
  107a3c:	89 c1                	mov    %eax,%ecx
  107a3e:	d3 ef                	shr    %cl,%edi
  107a40:	09 d7                	or     %edx,%edi
  107a42:	89 f2                	mov    %esi,%edx
  107a44:	89 f8                	mov    %edi,%eax
  107a46:	f7 74 24 08          	divl   0x8(%esp)
  107a4a:	89 d6                	mov    %edx,%esi
  107a4c:	89 c7                	mov    %eax,%edi
  107a4e:	f7 24 24             	mull   (%esp)
  107a51:	39 d6                	cmp    %edx,%esi
  107a53:	89 14 24             	mov    %edx,(%esp)
  107a56:	72 30                	jb     107a88 <__udivdi3+0x118>
  107a58:	8b 54 24 04          	mov    0x4(%esp),%edx
  107a5c:	89 e9                	mov    %ebp,%ecx
  107a5e:	d3 e2                	shl    %cl,%edx
  107a60:	39 c2                	cmp    %eax,%edx
  107a62:	73 05                	jae    107a69 <__udivdi3+0xf9>
  107a64:	3b 34 24             	cmp    (%esp),%esi
  107a67:	74 1f                	je     107a88 <__udivdi3+0x118>
  107a69:	89 f8                	mov    %edi,%eax
  107a6b:	31 d2                	xor    %edx,%edx
  107a6d:	e9 7a ff ff ff       	jmp    1079ec <__udivdi3+0x7c>
  107a72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  107a78:	31 d2                	xor    %edx,%edx
  107a7a:	b8 01 00 00 00       	mov    $0x1,%eax
  107a7f:	e9 68 ff ff ff       	jmp    1079ec <__udivdi3+0x7c>
  107a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  107a88:	8d 47 ff             	lea    -0x1(%edi),%eax
  107a8b:	31 d2                	xor    %edx,%edx
  107a8d:	83 c4 0c             	add    $0xc,%esp
  107a90:	5e                   	pop    %esi
  107a91:	5f                   	pop    %edi
  107a92:	5d                   	pop    %ebp
  107a93:	c3                   	ret    
  107a94:	66 90                	xchg   %ax,%ax
  107a96:	66 90                	xchg   %ax,%ax
  107a98:	66 90                	xchg   %ax,%ax
  107a9a:	66 90                	xchg   %ax,%ax
  107a9c:	66 90                	xchg   %ax,%ax
  107a9e:	66 90                	xchg   %ax,%ax

00107aa0 <__umoddi3>:
  107aa0:	55                   	push   %ebp
  107aa1:	57                   	push   %edi
  107aa2:	56                   	push   %esi
  107aa3:	83 ec 14             	sub    $0x14,%esp
  107aa6:	8b 44 24 28          	mov    0x28(%esp),%eax
  107aaa:	8b 4c 24 24          	mov    0x24(%esp),%ecx
  107aae:	8b 74 24 2c          	mov    0x2c(%esp),%esi
  107ab2:	89 c7                	mov    %eax,%edi
  107ab4:	89 44 24 04          	mov    %eax,0x4(%esp)
  107ab8:	8b 44 24 30          	mov    0x30(%esp),%eax
  107abc:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  107ac0:	89 34 24             	mov    %esi,(%esp)
  107ac3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  107ac7:	85 c0                	test   %eax,%eax
  107ac9:	89 c2                	mov    %eax,%edx
  107acb:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  107acf:	75 17                	jne    107ae8 <__umoddi3+0x48>
  107ad1:	39 fe                	cmp    %edi,%esi
  107ad3:	76 4b                	jbe    107b20 <__umoddi3+0x80>
  107ad5:	89 c8                	mov    %ecx,%eax
  107ad7:	89 fa                	mov    %edi,%edx
  107ad9:	f7 f6                	div    %esi
  107adb:	89 d0                	mov    %edx,%eax
  107add:	31 d2                	xor    %edx,%edx
  107adf:	83 c4 14             	add    $0x14,%esp
  107ae2:	5e                   	pop    %esi
  107ae3:	5f                   	pop    %edi
  107ae4:	5d                   	pop    %ebp
  107ae5:	c3                   	ret    
  107ae6:	66 90                	xchg   %ax,%ax
  107ae8:	39 f8                	cmp    %edi,%eax
  107aea:	77 54                	ja     107b40 <__umoddi3+0xa0>
  107aec:	0f bd e8             	bsr    %eax,%ebp
  107aef:	83 f5 1f             	xor    $0x1f,%ebp
  107af2:	75 5c                	jne    107b50 <__umoddi3+0xb0>
  107af4:	8b 7c 24 08          	mov    0x8(%esp),%edi
  107af8:	39 3c 24             	cmp    %edi,(%esp)
  107afb:	0f 87 e7 00 00 00    	ja     107be8 <__umoddi3+0x148>
  107b01:	8b 7c 24 04          	mov    0x4(%esp),%edi
  107b05:	29 f1                	sub    %esi,%ecx
  107b07:	19 c7                	sbb    %eax,%edi
  107b09:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  107b0d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  107b11:	8b 44 24 08          	mov    0x8(%esp),%eax
  107b15:	8b 54 24 0c          	mov    0xc(%esp),%edx
  107b19:	83 c4 14             	add    $0x14,%esp
  107b1c:	5e                   	pop    %esi
  107b1d:	5f                   	pop    %edi
  107b1e:	5d                   	pop    %ebp
  107b1f:	c3                   	ret    
  107b20:	85 f6                	test   %esi,%esi
  107b22:	89 f5                	mov    %esi,%ebp
  107b24:	75 0b                	jne    107b31 <__umoddi3+0x91>
  107b26:	b8 01 00 00 00       	mov    $0x1,%eax
  107b2b:	31 d2                	xor    %edx,%edx
  107b2d:	f7 f6                	div    %esi
  107b2f:	89 c5                	mov    %eax,%ebp
  107b31:	8b 44 24 04          	mov    0x4(%esp),%eax
  107b35:	31 d2                	xor    %edx,%edx
  107b37:	f7 f5                	div    %ebp
  107b39:	89 c8                	mov    %ecx,%eax
  107b3b:	f7 f5                	div    %ebp
  107b3d:	eb 9c                	jmp    107adb <__umoddi3+0x3b>
  107b3f:	90                   	nop
  107b40:	89 c8                	mov    %ecx,%eax
  107b42:	89 fa                	mov    %edi,%edx
  107b44:	83 c4 14             	add    $0x14,%esp
  107b47:	5e                   	pop    %esi
  107b48:	5f                   	pop    %edi
  107b49:	5d                   	pop    %ebp
  107b4a:	c3                   	ret    
  107b4b:	90                   	nop
  107b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  107b50:	8b 04 24             	mov    (%esp),%eax
  107b53:	be 20 00 00 00       	mov    $0x20,%esi
  107b58:	89 e9                	mov    %ebp,%ecx
  107b5a:	29 ee                	sub    %ebp,%esi
  107b5c:	d3 e2                	shl    %cl,%edx
  107b5e:	89 f1                	mov    %esi,%ecx
  107b60:	d3 e8                	shr    %cl,%eax
  107b62:	89 e9                	mov    %ebp,%ecx
  107b64:	89 44 24 04          	mov    %eax,0x4(%esp)
  107b68:	8b 04 24             	mov    (%esp),%eax
  107b6b:	09 54 24 04          	or     %edx,0x4(%esp)
  107b6f:	89 fa                	mov    %edi,%edx
  107b71:	d3 e0                	shl    %cl,%eax
  107b73:	89 f1                	mov    %esi,%ecx
  107b75:	89 44 24 08          	mov    %eax,0x8(%esp)
  107b79:	8b 44 24 10          	mov    0x10(%esp),%eax
  107b7d:	d3 ea                	shr    %cl,%edx
  107b7f:	89 e9                	mov    %ebp,%ecx
  107b81:	d3 e7                	shl    %cl,%edi
  107b83:	89 f1                	mov    %esi,%ecx
  107b85:	d3 e8                	shr    %cl,%eax
  107b87:	89 e9                	mov    %ebp,%ecx
  107b89:	09 f8                	or     %edi,%eax
  107b8b:	8b 7c 24 10          	mov    0x10(%esp),%edi
  107b8f:	f7 74 24 04          	divl   0x4(%esp)
  107b93:	d3 e7                	shl    %cl,%edi
  107b95:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  107b99:	89 d7                	mov    %edx,%edi
  107b9b:	f7 64 24 08          	mull   0x8(%esp)
  107b9f:	39 d7                	cmp    %edx,%edi
  107ba1:	89 c1                	mov    %eax,%ecx
  107ba3:	89 14 24             	mov    %edx,(%esp)
  107ba6:	72 2c                	jb     107bd4 <__umoddi3+0x134>
  107ba8:	39 44 24 0c          	cmp    %eax,0xc(%esp)
  107bac:	72 22                	jb     107bd0 <__umoddi3+0x130>
  107bae:	8b 44 24 0c          	mov    0xc(%esp),%eax
  107bb2:	29 c8                	sub    %ecx,%eax
  107bb4:	19 d7                	sbb    %edx,%edi
  107bb6:	89 e9                	mov    %ebp,%ecx
  107bb8:	89 fa                	mov    %edi,%edx
  107bba:	d3 e8                	shr    %cl,%eax
  107bbc:	89 f1                	mov    %esi,%ecx
  107bbe:	d3 e2                	shl    %cl,%edx
  107bc0:	89 e9                	mov    %ebp,%ecx
  107bc2:	d3 ef                	shr    %cl,%edi
  107bc4:	09 d0                	or     %edx,%eax
  107bc6:	89 fa                	mov    %edi,%edx
  107bc8:	83 c4 14             	add    $0x14,%esp
  107bcb:	5e                   	pop    %esi
  107bcc:	5f                   	pop    %edi
  107bcd:	5d                   	pop    %ebp
  107bce:	c3                   	ret    
  107bcf:	90                   	nop
  107bd0:	39 d7                	cmp    %edx,%edi
  107bd2:	75 da                	jne    107bae <__umoddi3+0x10e>
  107bd4:	8b 14 24             	mov    (%esp),%edx
  107bd7:	89 c1                	mov    %eax,%ecx
  107bd9:	2b 4c 24 08          	sub    0x8(%esp),%ecx
  107bdd:	1b 54 24 04          	sbb    0x4(%esp),%edx
  107be1:	eb cb                	jmp    107bae <__umoddi3+0x10e>
  107be3:	90                   	nop
  107be4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  107be8:	3b 44 24 0c          	cmp    0xc(%esp),%eax
  107bec:	0f 82 0f ff ff ff    	jb     107b01 <__umoddi3+0x61>
  107bf2:	e9 1a ff ff ff       	jmp    107b11 <__umoddi3+0x71>
