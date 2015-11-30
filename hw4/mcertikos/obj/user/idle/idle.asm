
obj/user/idle/idle:     file format elf32-i386


Disassembly of section .text:

40000000 <main>:
#include <stdio.h>
#include <syscall.h>
#include <x86.h>

int main (int argc, char **argv)
{
40000000:	55                   	push   %ebp
40000001:	89 e5                	mov    %esp,%ebp
40000003:	83 e4 f0             	and    $0xfffffff0,%esp
40000006:	83 ec 10             	sub    $0x10,%esp
    printf ("idle\n");
40000009:	c7 04 24 4c 13 00 40 	movl   $0x4000134c,(%esp)
40000010:	e8 ab 02 00 00       	call   400002c0 <printf>

    pid_t ping_pid, pong_pid, ding_pid;

    if ((ping_pid = spawn (1, 1000)) != -1)
40000015:	c7 44 24 04 e8 03 00 	movl   $0x3e8,0x4(%esp)
4000001c:	00 
4000001d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
40000024:	e8 47 09 00 00       	call   40000970 <spawn>
40000029:	83 f8 ff             	cmp    $0xffffffff,%eax
4000002c:	0f 84 82 00 00 00    	je     400000b4 <main+0xb4>
        printf ("ping in process %d.\n", ping_pid);
40000032:	89 44 24 04          	mov    %eax,0x4(%esp)
40000036:	c7 04 24 52 13 00 40 	movl   $0x40001352,(%esp)
4000003d:	e8 7e 02 00 00       	call   400002c0 <printf>
    else
        printf ("Failed to launch ping.\n");

    if ((pong_pid = spawn (2, 1000)) != -1)
40000042:	c7 44 24 04 e8 03 00 	movl   $0x3e8,0x4(%esp)
40000049:	00 
4000004a:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
40000051:	e8 1a 09 00 00       	call   40000970 <spawn>
40000056:	83 f8 ff             	cmp    $0xffffffff,%eax
40000059:	74 4b                	je     400000a6 <main+0xa6>
        printf ("pong in process %d.\n", pong_pid);
4000005b:	89 44 24 04          	mov    %eax,0x4(%esp)
4000005f:	c7 04 24 7f 13 00 40 	movl   $0x4000137f,(%esp)
40000066:	e8 55 02 00 00       	call   400002c0 <printf>
    else
        printf ("Failed to launch pong.\n");

    if ((ding_pid = spawn (3, 1000)) != -1)
4000006b:	c7 44 24 04 e8 03 00 	movl   $0x3e8,0x4(%esp)
40000072:	00 
40000073:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
4000007a:	e8 f1 08 00 00       	call   40000970 <spawn>
4000007f:	83 f8 ff             	cmp    $0xffffffff,%eax
40000082:	74 14                	je     40000098 <main+0x98>
        printf ("ding in process %d.\n", ding_pid);
40000084:	89 44 24 04          	mov    %eax,0x4(%esp)
40000088:	c7 04 24 ac 13 00 40 	movl   $0x400013ac,(%esp)
4000008f:	e8 2c 02 00 00       	call   400002c0 <printf>
    else
        printf ("Failed to launch ding.\n");

    return 0;
}
40000094:	31 c0                	xor    %eax,%eax
40000096:	c9                   	leave  
40000097:	c3                   	ret    
        printf ("Failed to launch pong.\n");

    if ((ding_pid = spawn (3, 1000)) != -1)
        printf ("ding in process %d.\n", ding_pid);
    else
        printf ("Failed to launch ding.\n");
40000098:	c7 04 24 c1 13 00 40 	movl   $0x400013c1,(%esp)
4000009f:	e8 1c 02 00 00       	call   400002c0 <printf>
400000a4:	eb ee                	jmp    40000094 <main+0x94>
        printf ("Failed to launch ping.\n");

    if ((pong_pid = spawn (2, 1000)) != -1)
        printf ("pong in process %d.\n", pong_pid);
    else
        printf ("Failed to launch pong.\n");
400000a6:	c7 04 24 94 13 00 40 	movl   $0x40001394,(%esp)
400000ad:	e8 0e 02 00 00       	call   400002c0 <printf>
400000b2:	eb b7                	jmp    4000006b <main+0x6b>
    pid_t ping_pid, pong_pid, ding_pid;

    if ((ping_pid = spawn (1, 1000)) != -1)
        printf ("ping in process %d.\n", ping_pid);
    else
        printf ("Failed to launch ping.\n");
400000b4:	c7 04 24 67 13 00 40 	movl   $0x40001367,(%esp)
400000bb:	e8 00 02 00 00       	call   400002c0 <printf>
400000c0:	eb 80                	jmp    40000042 <main+0x42>
400000c2:	66 90                	xchg   %ax,%ax

400000c4 <_start>:
_start:
	/*
	 * If there are arguments on the stack, then the current stack will not
	 * be aligned to a nice big power-of-two boundary/
	 */
	testl	$0x0fffffff, %esp
400000c4:	f7 c4 ff ff ff 0f    	test   $0xfffffff,%esp
	jnz	args_exist
400000ca:	75 04                	jne    400000d0 <args_exist>

400000cc <noargs>:

noargs:
	/* If no arguments are on the stack, push two dummy zero. */
	pushl	$0
400000cc:	6a 00                	push   $0x0
	pushl	$0
400000ce:	6a 00                	push   $0x0

400000d0 <args_exist>:

args_exist:
	/* Jump to the C part. */
	call	main
400000d0:	e8 2b ff ff ff       	call   40000000 <main>

	/* When returning, push the return value on the stack. */
	pushl	%eax
400000d5:	50                   	push   %eax

400000d6 <spin>:
spin:
	//call	yield
	jmp	spin
400000d6:	eb fe                	jmp    400000d6 <spin>
400000d8:	66 90                	xchg   %ax,%ax
400000da:	66 90                	xchg   %ax,%ax
400000dc:	66 90                	xchg   %ax,%ax
400000de:	66 90                	xchg   %ax,%ax

400000e0 <debug>:
#include <stdarg.h>
#include <stdio.h>

void
debug(const char *file, int line, const char *fmt, ...)
{
400000e0:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	va_start(ap, fmt);
	printf("[D] %s:%d: ", file, line);
400000e3:	8b 44 24 24          	mov    0x24(%esp),%eax
400000e7:	c7 04 24 b8 11 00 40 	movl   $0x400011b8,(%esp)
400000ee:	89 44 24 08          	mov    %eax,0x8(%esp)
400000f2:	8b 44 24 20          	mov    0x20(%esp),%eax
400000f6:	89 44 24 04          	mov    %eax,0x4(%esp)
400000fa:	e8 c1 01 00 00       	call   400002c0 <printf>
	vcprintf(fmt, ap);
400000ff:	8d 44 24 2c          	lea    0x2c(%esp),%eax
40000103:	89 44 24 04          	mov    %eax,0x4(%esp)
40000107:	8b 44 24 28          	mov    0x28(%esp),%eax
4000010b:	89 04 24             	mov    %eax,(%esp)
4000010e:	e8 4d 01 00 00       	call   40000260 <vcprintf>
	va_end(ap);
}
40000113:	83 c4 1c             	add    $0x1c,%esp
40000116:	c3                   	ret    
40000117:	89 f6                	mov    %esi,%esi
40000119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000120 <warn>:

void
warn(const char *file, int line, const char *fmt, ...)
{
40000120:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	va_start(ap, fmt);
	printf("[W] %s:%d: ", file, line);
40000123:	8b 44 24 24          	mov    0x24(%esp),%eax
40000127:	c7 04 24 c4 11 00 40 	movl   $0x400011c4,(%esp)
4000012e:	89 44 24 08          	mov    %eax,0x8(%esp)
40000132:	8b 44 24 20          	mov    0x20(%esp),%eax
40000136:	89 44 24 04          	mov    %eax,0x4(%esp)
4000013a:	e8 81 01 00 00       	call   400002c0 <printf>
	vcprintf(fmt, ap);
4000013f:	8d 44 24 2c          	lea    0x2c(%esp),%eax
40000143:	89 44 24 04          	mov    %eax,0x4(%esp)
40000147:	8b 44 24 28          	mov    0x28(%esp),%eax
4000014b:	89 04 24             	mov    %eax,(%esp)
4000014e:	e8 0d 01 00 00       	call   40000260 <vcprintf>
	va_end(ap);
}
40000153:	83 c4 1c             	add    $0x1c,%esp
40000156:	c3                   	ret    
40000157:	89 f6                	mov    %esi,%esi
40000159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000160 <panic>:

void
panic(const char *file, int line, const char *fmt, ...)
{
40000160:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	va_start(ap, fmt);
	printf("[P] %s:%d: ", file, line);
40000163:	8b 44 24 24          	mov    0x24(%esp),%eax
40000167:	c7 04 24 d0 11 00 40 	movl   $0x400011d0,(%esp)
4000016e:	89 44 24 08          	mov    %eax,0x8(%esp)
40000172:	8b 44 24 20          	mov    0x20(%esp),%eax
40000176:	89 44 24 04          	mov    %eax,0x4(%esp)
4000017a:	e8 41 01 00 00       	call   400002c0 <printf>
	vcprintf(fmt, ap);
4000017f:	8d 44 24 2c          	lea    0x2c(%esp),%eax
40000183:	89 44 24 04          	mov    %eax,0x4(%esp)
40000187:	8b 44 24 28          	mov    0x28(%esp),%eax
4000018b:	89 04 24             	mov    %eax,(%esp)
4000018e:	e8 cd 00 00 00       	call   40000260 <vcprintf>
40000193:	90                   	nop
40000194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	va_end(ap);

	while (1)
		yield();
40000198:	e8 f3 07 00 00       	call   40000990 <yield>
4000019d:	eb f9                	jmp    40000198 <panic+0x38>
4000019f:	90                   	nop

400001a0 <atoi>:
#include <stdlib.h>

int
atoi(const char *buf, int *i)
{
400001a0:	55                   	push   %ebp
400001a1:	57                   	push   %edi
400001a2:	56                   	push   %esi
400001a3:	53                   	push   %ebx
400001a4:	8b 74 24 14          	mov    0x14(%esp),%esi
	int loc = 0;
	int numstart = 0;
	int acc = 0;
	int negative = 0;
	if (buf[loc] == '+')
400001a8:	0f b6 06             	movzbl (%esi),%eax
400001ab:	3c 2b                	cmp    $0x2b,%al
400001ad:	74 51                	je     40000200 <atoi+0x60>
		loc++;
	else if (buf[loc] == '-') {
400001af:	3c 2d                	cmp    $0x2d,%al
400001b1:	0f 94 c0             	sete   %al
400001b4:	0f b6 c0             	movzbl %al,%eax
400001b7:	89 c5                	mov    %eax,%ebp
400001b9:	89 c7                	mov    %eax,%edi
		negative = 1;
		loc++;
	}
	numstart = loc;
	// no grab the numbers
	while ('0' <= buf[loc] && buf[loc] <= '9') {
400001bb:	0f be 0c 06          	movsbl (%esi,%eax,1),%ecx
400001bf:	8d 41 d0             	lea    -0x30(%ecx),%eax
400001c2:	3c 09                	cmp    $0x9,%al
400001c4:	77 4a                	ja     40000210 <atoi+0x70>
400001c6:	89 f8                	mov    %edi,%eax
int
atoi(const char *buf, int *i)
{
	int loc = 0;
	int numstart = 0;
	int acc = 0;
400001c8:	31 d2                	xor    %edx,%edx
400001ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	}
	numstart = loc;
	// no grab the numbers
	while ('0' <= buf[loc] && buf[loc] <= '9') {
		acc = acc*10 + (buf[loc]-'0');
		loc++;
400001d0:	83 c0 01             	add    $0x1,%eax
		loc++;
	}
	numstart = loc;
	// no grab the numbers
	while ('0' <= buf[loc] && buf[loc] <= '9') {
		acc = acc*10 + (buf[loc]-'0');
400001d3:	8d 14 92             	lea    (%edx,%edx,4),%edx
400001d6:	8d 54 51 d0          	lea    -0x30(%ecx,%edx,2),%edx
		negative = 1;
		loc++;
	}
	numstart = loc;
	// no grab the numbers
	while ('0' <= buf[loc] && buf[loc] <= '9') {
400001da:	0f be 0c 06          	movsbl (%esi,%eax,1),%ecx
400001de:	8d 59 d0             	lea    -0x30(%ecx),%ebx
400001e1:	80 fb 09             	cmp    $0x9,%bl
400001e4:	76 ea                	jbe    400001d0 <atoi+0x30>
		acc = acc*10 + (buf[loc]-'0');
		loc++;
	}
	if (numstart == loc) {
400001e6:	39 c7                	cmp    %eax,%edi
400001e8:	74 26                	je     40000210 <atoi+0x70>
		// no numbers have actually been scanned
		return 0;
	}
	if (negative)
		acc = - acc;
400001ea:	89 d1                	mov    %edx,%ecx
400001ec:	f7 d9                	neg    %ecx
400001ee:	85 ed                	test   %ebp,%ebp
400001f0:	0f 45 d1             	cmovne %ecx,%edx
	*i = acc;
400001f3:	8b 4c 24 18          	mov    0x18(%esp),%ecx
400001f7:	89 11                	mov    %edx,(%ecx)
	return loc;
}
400001f9:	5b                   	pop    %ebx
400001fa:	5e                   	pop    %esi
400001fb:	5f                   	pop    %edi
400001fc:	5d                   	pop    %ebp
400001fd:	c3                   	ret    
400001fe:	66 90                	xchg   %ax,%ax
40000200:	b8 01 00 00 00       	mov    $0x1,%eax
atoi(const char *buf, int *i)
{
	int loc = 0;
	int numstart = 0;
	int acc = 0;
	int negative = 0;
40000205:	31 ed                	xor    %ebp,%ebp
	if (buf[loc] == '+')
		loc++;
40000207:	bf 01 00 00 00       	mov    $0x1,%edi
4000020c:	eb ad                	jmp    400001bb <atoi+0x1b>
4000020e:	66 90                	xchg   %ax,%ax
	}
	if (negative)
		acc = - acc;
	*i = acc;
	return loc;
}
40000210:	5b                   	pop    %ebx
		acc = acc*10 + (buf[loc]-'0');
		loc++;
	}
	if (numstart == loc) {
		// no numbers have actually been scanned
		return 0;
40000211:	31 c0                	xor    %eax,%eax
	}
	if (negative)
		acc = - acc;
	*i = acc;
	return loc;
}
40000213:	5e                   	pop    %esi
40000214:	5f                   	pop    %edi
40000215:	5d                   	pop    %ebp
40000216:	c3                   	ret    
40000217:	66 90                	xchg   %ax,%ax
40000219:	66 90                	xchg   %ax,%ax
4000021b:	66 90                	xchg   %ax,%ax
4000021d:	66 90                	xchg   %ax,%ax
4000021f:	90                   	nop

40000220 <putch>:
	char buf[MAX_BUF];
};

static void
putch(int ch, struct printbuf *b)
{
40000220:	53                   	push   %ebx
40000221:	8b 54 24 0c          	mov    0xc(%esp),%edx
	b->buf[b->idx++] = ch;
40000225:	0f b6 5c 24 08       	movzbl 0x8(%esp),%ebx
4000022a:	8b 0a                	mov    (%edx),%ecx
4000022c:	8d 41 01             	lea    0x1(%ecx),%eax
	if (b->idx == MAX_BUF-1) {
4000022f:	3d ff 0f 00 00       	cmp    $0xfff,%eax
};

static void
putch(int ch, struct printbuf *b)
{
	b->buf[b->idx++] = ch;
40000234:	89 02                	mov    %eax,(%edx)
40000236:	88 5c 0a 08          	mov    %bl,0x8(%edx,%ecx,1)
	if (b->idx == MAX_BUF-1) {
4000023a:	75 1a                	jne    40000256 <putch+0x36>
		b->buf[b->idx] = 0;
4000023c:	c6 82 07 10 00 00 00 	movb   $0x0,0x1007(%edx)
		puts(b->buf, b->idx);
40000243:	8d 5a 08             	lea    0x8(%edx),%ebx


static gcc_inline void
sys_puts(const char *s, size_t len)
{
	asm volatile("int %0" :
40000246:	b9 ff 0f 00 00       	mov    $0xfff,%ecx
4000024b:	66 31 c0             	xor    %ax,%ax
4000024e:	cd 30                	int    $0x30
		b->idx = 0;
40000250:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
	}
	b->cnt++;
40000256:	83 42 04 01          	addl   $0x1,0x4(%edx)
}
4000025a:	5b                   	pop    %ebx
4000025b:	c3                   	ret    
4000025c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000260 <vcprintf>:

int
vcprintf(const char *fmt, va_list ap)
{
40000260:	53                   	push   %ebx
40000261:	81 ec 28 10 00 00    	sub    $0x1028,%esp
	struct printbuf b;

	b.idx = 0;
	b.cnt = 0;
	vprintfmt((void*)putch, &b, fmt, ap);
40000267:	8b 84 24 34 10 00 00 	mov    0x1034(%esp),%eax
4000026e:	8d 5c 24 20          	lea    0x20(%esp),%ebx
40000272:	c7 04 24 20 02 00 40 	movl   $0x40000220,(%esp)
int
vcprintf(const char *fmt, va_list ap)
{
	struct printbuf b;

	b.idx = 0;
40000279:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
40000280:	00 
	b.cnt = 0;
40000281:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
40000288:	00 
	vprintfmt((void*)putch, &b, fmt, ap);
40000289:	89 44 24 0c          	mov    %eax,0xc(%esp)
4000028d:	8b 84 24 30 10 00 00 	mov    0x1030(%esp),%eax
40000294:	89 44 24 08          	mov    %eax,0x8(%esp)
40000298:	8d 44 24 18          	lea    0x18(%esp),%eax
4000029c:	89 44 24 04          	mov    %eax,0x4(%esp)
400002a0:	e8 7b 01 00 00       	call   40000420 <vprintfmt>

	b.buf[b.idx] = 0;
400002a5:	8b 4c 24 18          	mov    0x18(%esp),%ecx
400002a9:	31 c0                	xor    %eax,%eax
400002ab:	c6 44 0c 20 00       	movb   $0x0,0x20(%esp,%ecx,1)
400002b0:	cd 30                	int    $0x30
	puts(b.buf, b.idx);

	return b.cnt;
}
400002b2:	8b 44 24 1c          	mov    0x1c(%esp),%eax
400002b6:	81 c4 28 10 00 00    	add    $0x1028,%esp
400002bc:	5b                   	pop    %ebx
400002bd:	c3                   	ret    
400002be:	66 90                	xchg   %ax,%ax

400002c0 <printf>:

int
printf(const char *fmt, ...)
{
400002c0:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	int cnt;

	va_start(ap, fmt);
	cnt = vcprintf(fmt, ap);
400002c3:	8d 44 24 24          	lea    0x24(%esp),%eax
400002c7:	89 44 24 04          	mov    %eax,0x4(%esp)
400002cb:	8b 44 24 20          	mov    0x20(%esp),%eax
400002cf:	89 04 24             	mov    %eax,(%esp)
400002d2:	e8 89 ff ff ff       	call   40000260 <vcprintf>
	va_end(ap);

	return cnt;
}
400002d7:	83 c4 1c             	add    $0x1c,%esp
400002da:	c3                   	ret    
400002db:	66 90                	xchg   %ax,%ax
400002dd:	66 90                	xchg   %ax,%ax
400002df:	90                   	nop

400002e0 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
400002e0:	55                   	push   %ebp
400002e1:	57                   	push   %edi
400002e2:	89 d7                	mov    %edx,%edi
400002e4:	56                   	push   %esi
400002e5:	89 c6                	mov    %eax,%esi
400002e7:	53                   	push   %ebx
400002e8:	83 ec 3c             	sub    $0x3c,%esp
400002eb:	8b 44 24 50          	mov    0x50(%esp),%eax
400002ef:	8b 4c 24 58          	mov    0x58(%esp),%ecx
400002f3:	8b 5c 24 5c          	mov    0x5c(%esp),%ebx
400002f7:	8b 6c 24 60          	mov    0x60(%esp),%ebp
400002fb:	89 44 24 20          	mov    %eax,0x20(%esp)
400002ff:	8b 44 24 54          	mov    0x54(%esp),%eax
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
40000303:	89 ca                	mov    %ecx,%edx
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
40000305:	89 4c 24 28          	mov    %ecx,0x28(%esp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
40000309:	31 c9                	xor    %ecx,%ecx
4000030b:	89 54 24 18          	mov    %edx,0x18(%esp)
4000030f:	39 c1                	cmp    %eax,%ecx
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
40000311:	89 44 24 24          	mov    %eax,0x24(%esp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
40000315:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
40000319:	0f 83 a9 00 00 00    	jae    400003c8 <printnum+0xe8>
		printnum(putch, putdat, num / base, base, width - 1, padc);
4000031f:	8b 44 24 28          	mov    0x28(%esp),%eax
40000323:	83 eb 01             	sub    $0x1,%ebx
40000326:	8b 54 24 1c          	mov    0x1c(%esp),%edx
4000032a:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
4000032e:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
40000332:	89 6c 24 10          	mov    %ebp,0x10(%esp)
40000336:	89 44 24 08          	mov    %eax,0x8(%esp)
4000033a:	8b 44 24 18          	mov    0x18(%esp),%eax
4000033e:	8b 4c 24 08          	mov    0x8(%esp),%ecx
40000342:	89 54 24 0c          	mov    %edx,0xc(%esp)
40000346:	89 5c 24 2c          	mov    %ebx,0x2c(%esp)
4000034a:	89 44 24 08          	mov    %eax,0x8(%esp)
4000034e:	8b 44 24 20          	mov    0x20(%esp),%eax
40000352:	89 4c 24 28          	mov    %ecx,0x28(%esp)
40000356:	89 04 24             	mov    %eax,(%esp)
40000359:	8b 44 24 24          	mov    0x24(%esp),%eax
4000035d:	89 44 24 04          	mov    %eax,0x4(%esp)
40000361:	e8 ca 0b 00 00       	call   40000f30 <__udivdi3>
40000366:	8b 4c 24 28          	mov    0x28(%esp),%ecx
4000036a:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
4000036e:	89 4c 24 08          	mov    %ecx,0x8(%esp)
40000372:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
40000376:	89 04 24             	mov    %eax,(%esp)
40000379:	89 f0                	mov    %esi,%eax
4000037b:	89 54 24 04          	mov    %edx,0x4(%esp)
4000037f:	89 fa                	mov    %edi,%edx
40000381:	e8 5a ff ff ff       	call   400002e0 <printnum>
		while (--width > 0)
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
40000386:	8b 44 24 18          	mov    0x18(%esp),%eax
4000038a:	8b 54 24 1c          	mov    0x1c(%esp),%edx
4000038e:	89 7c 24 54          	mov    %edi,0x54(%esp)
40000392:	89 44 24 08          	mov    %eax,0x8(%esp)
40000396:	8b 44 24 20          	mov    0x20(%esp),%eax
4000039a:	89 54 24 0c          	mov    %edx,0xc(%esp)
4000039e:	89 04 24             	mov    %eax,(%esp)
400003a1:	8b 44 24 24          	mov    0x24(%esp),%eax
400003a5:	89 44 24 04          	mov    %eax,0x4(%esp)
400003a9:	e8 b2 0c 00 00       	call   40001060 <__umoddi3>
400003ae:	0f be 80 dc 11 00 40 	movsbl 0x400011dc(%eax),%eax
400003b5:	89 44 24 50          	mov    %eax,0x50(%esp)
}
400003b9:	83 c4 3c             	add    $0x3c,%esp
		while (--width > 0)
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
400003bc:	89 f0                	mov    %esi,%eax
}
400003be:	5b                   	pop    %ebx
400003bf:	5e                   	pop    %esi
400003c0:	5f                   	pop    %edi
400003c1:	5d                   	pop    %ebp
		while (--width > 0)
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
400003c2:	ff e0                	jmp    *%eax
400003c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
400003c8:	76 1e                	jbe    400003e8 <printnum+0x108>
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
400003ca:	83 eb 01             	sub    $0x1,%ebx
400003cd:	85 db                	test   %ebx,%ebx
400003cf:	7e b5                	jle    40000386 <printnum+0xa6>
400003d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			putch(padc, putdat);
400003d8:	89 7c 24 04          	mov    %edi,0x4(%esp)
400003dc:	89 2c 24             	mov    %ebp,(%esp)
400003df:	ff d6                	call   *%esi
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
400003e1:	83 eb 01             	sub    $0x1,%ebx
400003e4:	75 f2                	jne    400003d8 <printnum+0xf8>
400003e6:	eb 9e                	jmp    40000386 <printnum+0xa6>
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
400003e8:	8b 44 24 20          	mov    0x20(%esp),%eax
400003ec:	39 44 24 28          	cmp    %eax,0x28(%esp)
400003f0:	0f 86 29 ff ff ff    	jbe    4000031f <printnum+0x3f>
400003f6:	eb d2                	jmp    400003ca <printnum+0xea>
400003f8:	90                   	nop
400003f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000400 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
40000400:	8b 44 24 08          	mov    0x8(%esp),%eax
	b->cnt++;
	if (b->buf < b->ebuf)
40000404:	8b 10                	mov    (%eax),%edx
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
	b->cnt++;
40000406:	83 40 08 01          	addl   $0x1,0x8(%eax)
	if (b->buf < b->ebuf)
4000040a:	3b 50 04             	cmp    0x4(%eax),%edx
4000040d:	73 0b                	jae    4000041a <sprintputch+0x1a>
		*b->buf++ = ch;
4000040f:	8d 4a 01             	lea    0x1(%edx),%ecx
40000412:	89 08                	mov    %ecx,(%eax)
40000414:	8b 44 24 04          	mov    0x4(%esp),%eax
40000418:	88 02                	mov    %al,(%edx)
4000041a:	f3 c3                	repz ret 
4000041c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000420 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
40000420:	55                   	push   %ebp
40000421:	57                   	push   %edi
40000422:	56                   	push   %esi
40000423:	53                   	push   %ebx
40000424:	83 ec 3c             	sub    $0x3c,%esp
40000427:	8b 6c 24 50          	mov    0x50(%esp),%ebp
4000042b:	8b 74 24 54          	mov    0x54(%esp),%esi
4000042f:	8b 7c 24 58          	mov    0x58(%esp),%edi
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
40000433:	0f b6 07             	movzbl (%edi),%eax
40000436:	8d 5f 01             	lea    0x1(%edi),%ebx
40000439:	83 f8 25             	cmp    $0x25,%eax
4000043c:	75 17                	jne    40000455 <vprintfmt+0x35>
4000043e:	eb 28                	jmp    40000468 <vprintfmt+0x48>
40000440:	83 c3 01             	add    $0x1,%ebx
			if (ch == '\0')
				return;
			putch(ch, putdat);
40000443:	89 04 24             	mov    %eax,(%esp)
40000446:	89 74 24 04          	mov    %esi,0x4(%esp)
4000044a:	ff d5                	call   *%ebp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
4000044c:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
40000450:	83 f8 25             	cmp    $0x25,%eax
40000453:	74 13                	je     40000468 <vprintfmt+0x48>
			if (ch == '\0')
40000455:	85 c0                	test   %eax,%eax
40000457:	75 e7                	jne    40000440 <vprintfmt+0x20>
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
40000459:	83 c4 3c             	add    $0x3c,%esp
4000045c:	5b                   	pop    %ebx
4000045d:	5e                   	pop    %esi
4000045e:	5f                   	pop    %edi
4000045f:	5d                   	pop    %ebp
40000460:	c3                   	ret    
40000461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			if (width < 0)
				width = 0;
			goto reswitch;

		case '#':
			altflag = 1;
40000468:	c6 44 24 24 20       	movb   $0x20,0x24(%esp)
4000046d:	ba ff ff ff ff       	mov    $0xffffffff,%edx
40000472:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
40000479:	00 
4000047a:	c7 44 24 20 ff ff ff 	movl   $0xffffffff,0x20(%esp)
40000481:	ff 
40000482:	c7 44 24 28 00 00 00 	movl   $0x0,0x28(%esp)
40000489:	00 
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
4000048a:	0f b6 03             	movzbl (%ebx),%eax
4000048d:	8d 7b 01             	lea    0x1(%ebx),%edi
40000490:	0f b6 c8             	movzbl %al,%ecx
40000493:	83 e8 23             	sub    $0x23,%eax
40000496:	3c 55                	cmp    $0x55,%al
40000498:	0f 87 69 02 00 00    	ja     40000707 <vprintfmt+0x2e7>
4000049e:	0f b6 c0             	movzbl %al,%eax
400004a1:	ff 24 85 f4 11 00 40 	jmp    *0x400011f4(,%eax,4)
400004a8:	89 fb                	mov    %edi,%ebx
			padc = '-';
			goto reswitch;

			// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
400004aa:	c6 44 24 24 30       	movb   $0x30,0x24(%esp)
400004af:	eb d9                	jmp    4000048a <vprintfmt+0x6a>
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
				precision = precision * 10 + ch - '0';
				ch = *fmt;
400004b1:	0f be 43 01          	movsbl 0x1(%ebx),%eax
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
				precision = precision * 10 + ch - '0';
400004b5:	8d 51 d0             	lea    -0x30(%ecx),%edx
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
400004b8:	89 fb                	mov    %edi,%ebx
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
400004ba:	8d 48 d0             	lea    -0x30(%eax),%ecx
400004bd:	83 f9 09             	cmp    $0x9,%ecx
400004c0:	0f 87 02 02 00 00    	ja     400006c8 <vprintfmt+0x2a8>
400004c6:	66 90                	xchg   %ax,%ax
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
400004c8:	83 c3 01             	add    $0x1,%ebx
				precision = precision * 10 + ch - '0';
400004cb:	8d 14 92             	lea    (%edx,%edx,4),%edx
400004ce:	8d 54 50 d0          	lea    -0x30(%eax,%edx,2),%edx
				ch = *fmt;
400004d2:	0f be 03             	movsbl (%ebx),%eax
				if (ch < '0' || ch > '9')
400004d5:	8d 48 d0             	lea    -0x30(%eax),%ecx
400004d8:	83 f9 09             	cmp    $0x9,%ecx
400004db:	76 eb                	jbe    400004c8 <vprintfmt+0xa8>
400004dd:	e9 e6 01 00 00       	jmp    400006c8 <vprintfmt+0x2a8>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
400004e2:	8b 44 24 5c          	mov    0x5c(%esp),%eax
			lflag++;
			goto reswitch;

			// character
		case 'c':
			putch(va_arg(ap, int), putdat);
400004e6:	89 74 24 04          	mov    %esi,0x4(%esp)
400004ea:	83 44 24 5c 04       	addl   $0x4,0x5c(%esp)
400004ef:	8b 00                	mov    (%eax),%eax
400004f1:	89 04 24             	mov    %eax,(%esp)
400004f4:	ff d5                	call   *%ebp
			break;
400004f6:	e9 38 ff ff ff       	jmp    40000433 <vprintfmt+0x13>
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, long long);
400004fb:	8b 44 24 5c          	mov    0x5c(%esp),%eax
// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
400004ff:	83 7c 24 28 01       	cmpl   $0x1,0x28(%esp)
		return va_arg(*ap, long long);
40000504:	8b 08                	mov    (%eax),%ecx
// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
40000506:	0f 8e e7 02 00 00    	jle    400007f3 <vprintfmt+0x3d3>
		return va_arg(*ap, long long);
4000050c:	8b 58 04             	mov    0x4(%eax),%ebx
4000050f:	83 c0 08             	add    $0x8,%eax
40000512:	89 44 24 5c          	mov    %eax,0x5c(%esp)
				putch(' ', putdat);
			break;

			// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
40000516:	89 ca                	mov    %ecx,%edx
40000518:	89 d9                	mov    %ebx,%ecx
			if ((long long) num < 0) {
4000051a:	85 c9                	test   %ecx,%ecx
4000051c:	bb 0a 00 00 00       	mov    $0xa,%ebx
40000521:	0f 88 dd 02 00 00    	js     40000804 <vprintfmt+0x3e4>
			// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
			base = 16;
		number:
			printnum(putch, putdat, num, base, width, padc);
40000527:	0f be 44 24 24       	movsbl 0x24(%esp),%eax
4000052c:	89 14 24             	mov    %edx,(%esp)
4000052f:	89 f2                	mov    %esi,%edx
40000531:	89 5c 24 08          	mov    %ebx,0x8(%esp)
40000535:	89 4c 24 04          	mov    %ecx,0x4(%esp)
40000539:	89 44 24 10          	mov    %eax,0x10(%esp)
4000053d:	8b 44 24 20          	mov    0x20(%esp),%eax
40000541:	89 44 24 0c          	mov    %eax,0xc(%esp)
40000545:	89 e8                	mov    %ebp,%eax
40000547:	e8 94 fd ff ff       	call   400002e0 <printnum>
			break;
4000054c:	e9 e2 fe ff ff       	jmp    40000433 <vprintfmt+0x13>
				width = precision, precision = -1;
			goto reswitch;

			// long flag (doubled for long long)
		case 'l':
			lflag++;
40000551:	83 44 24 28 01       	addl   $0x1,0x28(%esp)
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
40000556:	89 fb                	mov    %edi,%ebx
			goto reswitch;

			// long flag (doubled for long long)
		case 'l':
			lflag++;
			goto reswitch;
40000558:	e9 2d ff ff ff       	jmp    4000048a <vprintfmt+0x6a>
			num = getuint(&ap, lflag);
			base = 8;
			goto number;
#else
			// Replace this with your code.
			putch('X', putdat);
4000055d:	89 74 24 04          	mov    %esi,0x4(%esp)
40000561:	c7 04 24 58 00 00 00 	movl   $0x58,(%esp)
40000568:	ff d5                	call   *%ebp
			putch('X', putdat);
4000056a:	89 74 24 04          	mov    %esi,0x4(%esp)
4000056e:	c7 04 24 58 00 00 00 	movl   $0x58,(%esp)
40000575:	ff d5                	call   *%ebp
			putch('X', putdat);
40000577:	89 74 24 04          	mov    %esi,0x4(%esp)
4000057b:	c7 04 24 58 00 00 00 	movl   $0x58,(%esp)
40000582:	ff d5                	call   *%ebp
			break;
40000584:	e9 aa fe ff ff       	jmp    40000433 <vprintfmt+0x13>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
40000589:	8b 5c 24 5c          	mov    0x5c(%esp),%ebx
			break;
#endif

			// pointer
		case 'p':
			putch('0', putdat);
4000058d:	89 74 24 04          	mov    %esi,0x4(%esp)
40000591:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
40000598:	ff d5                	call   *%ebp
			putch('x', putdat);
4000059a:	89 74 24 04          	mov    %esi,0x4(%esp)
4000059e:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
400005a5:	ff d5                	call   *%ebp
			num = (unsigned long long)
400005a7:	8b 13                	mov    (%ebx),%edx
400005a9:	31 c9                	xor    %ecx,%ecx
				(uintptr_t) va_arg(ap, void *);
400005ab:	83 44 24 5c 04       	addl   $0x4,0x5c(%esp)
			base = 16;
			goto number;
400005b0:	bb 10 00 00 00       	mov    $0x10,%ebx
400005b5:	e9 6d ff ff ff       	jmp    40000527 <vprintfmt+0x107>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
400005ba:	8b 44 24 5c          	mov    0x5c(%esp),%eax
			putch(va_arg(ap, int), putdat);
			break;

			// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
400005be:	83 44 24 5c 04       	addl   $0x4,0x5c(%esp)
400005c3:	8b 08                	mov    (%eax),%ecx
				p = "(null)";
400005c5:	b8 ed 11 00 40       	mov    $0x400011ed,%eax
400005ca:	85 c9                	test   %ecx,%ecx
400005cc:	0f 44 c8             	cmove  %eax,%ecx
			if (width > 0 && padc != '-')
400005cf:	80 7c 24 24 2d       	cmpb   $0x2d,0x24(%esp)
400005d4:	0f 85 a9 01 00 00    	jne    40000783 <vprintfmt+0x363>
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
400005da:	0f be 01             	movsbl (%ecx),%eax
400005dd:	8d 59 01             	lea    0x1(%ecx),%ebx
400005e0:	85 c0                	test   %eax,%eax
400005e2:	0f 84 52 01 00 00    	je     4000073a <vprintfmt+0x31a>
400005e8:	89 74 24 54          	mov    %esi,0x54(%esp)
400005ec:	89 de                	mov    %ebx,%esi
400005ee:	89 d3                	mov    %edx,%ebx
400005f0:	89 7c 24 58          	mov    %edi,0x58(%esp)
400005f4:	8b 7c 24 20          	mov    0x20(%esp),%edi
400005f8:	eb 25                	jmp    4000061f <vprintfmt+0x1ff>
400005fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
40000600:	8b 4c 24 54          	mov    0x54(%esp),%ecx
40000604:	89 04 24             	mov    %eax,(%esp)
40000607:	89 4c 24 04          	mov    %ecx,0x4(%esp)
4000060b:	ff d5                	call   *%ebp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
4000060d:	83 c6 01             	add    $0x1,%esi
40000610:	0f be 46 ff          	movsbl -0x1(%esi),%eax
40000614:	83 ef 01             	sub    $0x1,%edi
40000617:	85 c0                	test   %eax,%eax
40000619:	0f 84 0f 01 00 00    	je     4000072e <vprintfmt+0x30e>
4000061f:	85 db                	test   %ebx,%ebx
40000621:	78 0c                	js     4000062f <vprintfmt+0x20f>
40000623:	83 eb 01             	sub    $0x1,%ebx
40000626:	83 fb ff             	cmp    $0xffffffff,%ebx
40000629:	0f 84 ff 00 00 00    	je     4000072e <vprintfmt+0x30e>
				if (altflag && (ch < ' ' || ch > '~'))
4000062f:	8b 54 24 18          	mov    0x18(%esp),%edx
40000633:	85 d2                	test   %edx,%edx
40000635:	74 c9                	je     40000600 <vprintfmt+0x1e0>
40000637:	8d 48 e0             	lea    -0x20(%eax),%ecx
4000063a:	83 f9 5e             	cmp    $0x5e,%ecx
4000063d:	76 c1                	jbe    40000600 <vprintfmt+0x1e0>
					putch('?', putdat);
4000063f:	8b 44 24 54          	mov    0x54(%esp),%eax
40000643:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
4000064a:	89 44 24 04          	mov    %eax,0x4(%esp)
4000064e:	ff d5                	call   *%ebp
40000650:	eb bb                	jmp    4000060d <vprintfmt+0x1ed>
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, unsigned long long);
40000652:	8b 44 24 5c          	mov    0x5c(%esp),%eax
// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
40000656:	83 7c 24 28 01       	cmpl   $0x1,0x28(%esp)
		return va_arg(*ap, unsigned long long);
4000065b:	8b 10                	mov    (%eax),%edx
// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
4000065d:	0f 8e 04 01 00 00    	jle    40000767 <vprintfmt+0x347>
		return va_arg(*ap, unsigned long long);
40000663:	8b 48 04             	mov    0x4(%eax),%ecx
40000666:	83 c0 08             	add    $0x8,%eax
40000669:	89 44 24 5c          	mov    %eax,0x5c(%esp)

			// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
			base = 10;
			goto number;
4000066d:	bb 0a 00 00 00       	mov    $0xa,%ebx
40000672:	e9 b0 fe ff ff       	jmp    40000527 <vprintfmt+0x107>
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, unsigned long long);
40000677:	8b 44 24 5c          	mov    0x5c(%esp),%eax
// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
4000067b:	83 7c 24 28 01       	cmpl   $0x1,0x28(%esp)
		return va_arg(*ap, unsigned long long);
40000680:	8b 10                	mov    (%eax),%edx
// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
40000682:	0f 8e ed 00 00 00    	jle    40000775 <vprintfmt+0x355>
		return va_arg(*ap, unsigned long long);
40000688:	8b 48 04             	mov    0x4(%eax),%ecx
4000068b:	83 c0 08             	add    $0x8,%eax
4000068e:	89 44 24 5c          	mov    %eax,0x5c(%esp)
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
				(uintptr_t) va_arg(ap, void *);
			base = 16;
			goto number;
40000692:	bb 10 00 00 00       	mov    $0x10,%ebx
40000697:	e9 8b fe ff ff       	jmp    40000527 <vprintfmt+0x107>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
4000069c:	89 fb                	mov    %edi,%ebx
			if (width < 0)
				width = 0;
			goto reswitch;

		case '#':
			altflag = 1;
4000069e:	c7 44 24 18 01 00 00 	movl   $0x1,0x18(%esp)
400006a5:	00 
			goto reswitch;
400006a6:	e9 df fd ff ff       	jmp    4000048a <vprintfmt+0x6a>
			printnum(putch, putdat, num, base, width, padc);
			break;

			// escaped '%' character
		case '%':
			putch(ch, putdat);
400006ab:	89 74 24 04          	mov    %esi,0x4(%esp)
400006af:	89 0c 24             	mov    %ecx,(%esp)
400006b2:	ff d5                	call   *%ebp
			break;
400006b4:	e9 7a fd ff ff       	jmp    40000433 <vprintfmt+0x13>
					break;
			}
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
400006b9:	8b 44 24 5c          	mov    0x5c(%esp),%eax
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
400006bd:	89 fb                	mov    %edi,%ebx
					break;
			}
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
400006bf:	8b 10                	mov    (%eax),%edx
400006c1:	83 c0 04             	add    $0x4,%eax
400006c4:	89 44 24 5c          	mov    %eax,0x5c(%esp)
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
400006c8:	8b 7c 24 20          	mov    0x20(%esp),%edi
400006cc:	85 ff                	test   %edi,%edi
400006ce:	0f 89 b6 fd ff ff    	jns    4000048a <vprintfmt+0x6a>
				width = precision, precision = -1;
400006d4:	89 54 24 20          	mov    %edx,0x20(%esp)
400006d8:	ba ff ff ff ff       	mov    $0xffffffff,%edx
400006dd:	e9 a8 fd ff ff       	jmp    4000048a <vprintfmt+0x6a>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
400006e2:	89 fb                	mov    %edi,%ebx

			// flag to pad on the right
		case '-':
			padc = '-';
400006e4:	c6 44 24 24 2d       	movb   $0x2d,0x24(%esp)
400006e9:	e9 9c fd ff ff       	jmp    4000048a <vprintfmt+0x6a>
400006ee:	8b 4c 24 20          	mov    0x20(%esp),%ecx
400006f2:	b8 00 00 00 00       	mov    $0x0,%eax
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
400006f7:	89 fb                	mov    %edi,%ebx
400006f9:	85 c9                	test   %ecx,%ecx
400006fb:	0f 49 c1             	cmovns %ecx,%eax
400006fe:	89 44 24 20          	mov    %eax,0x20(%esp)
40000702:	e9 83 fd ff ff       	jmp    4000048a <vprintfmt+0x6a>
			putch(ch, putdat);
			break;

			// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
40000707:	89 74 24 04          	mov    %esi,0x4(%esp)
			for (fmt--; fmt[-1] != '%'; fmt--)
4000070b:	89 df                	mov    %ebx,%edi
			putch(ch, putdat);
			break;

			// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
4000070d:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
40000714:	ff d5                	call   *%ebp
			for (fmt--; fmt[-1] != '%'; fmt--)
40000716:	80 7b ff 25          	cmpb   $0x25,-0x1(%ebx)
4000071a:	0f 84 13 fd ff ff    	je     40000433 <vprintfmt+0x13>
40000720:	83 ef 01             	sub    $0x1,%edi
40000723:	80 7f ff 25          	cmpb   $0x25,-0x1(%edi)
40000727:	75 f7                	jne    40000720 <vprintfmt+0x300>
40000729:	e9 05 fd ff ff       	jmp    40000433 <vprintfmt+0x13>
4000072e:	89 7c 24 20          	mov    %edi,0x20(%esp)
40000732:	8b 74 24 54          	mov    0x54(%esp),%esi
40000736:	8b 7c 24 58          	mov    0x58(%esp),%edi
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
4000073a:	8b 4c 24 20          	mov    0x20(%esp),%ecx
4000073e:	8b 5c 24 20          	mov    0x20(%esp),%ebx
40000742:	85 c9                	test   %ecx,%ecx
40000744:	0f 8e e9 fc ff ff    	jle    40000433 <vprintfmt+0x13>
4000074a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
				putch(' ', putdat);
40000750:	89 74 24 04          	mov    %esi,0x4(%esp)
40000754:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
4000075b:	ff d5                	call   *%ebp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
4000075d:	83 eb 01             	sub    $0x1,%ebx
40000760:	75 ee                	jne    40000750 <vprintfmt+0x330>
40000762:	e9 cc fc ff ff       	jmp    40000433 <vprintfmt+0x13>
getuint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, unsigned long long);
	else if (lflag)
		return va_arg(*ap, unsigned long);
40000767:	83 c0 04             	add    $0x4,%eax
4000076a:	31 c9                	xor    %ecx,%ecx
4000076c:	89 44 24 5c          	mov    %eax,0x5c(%esp)
40000770:	e9 f8 fe ff ff       	jmp    4000066d <vprintfmt+0x24d>
40000775:	83 c0 04             	add    $0x4,%eax
40000778:	31 c9                	xor    %ecx,%ecx
4000077a:	89 44 24 5c          	mov    %eax,0x5c(%esp)
4000077e:	e9 0f ff ff ff       	jmp    40000692 <vprintfmt+0x272>

			// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
40000783:	8b 5c 24 20          	mov    0x20(%esp),%ebx
40000787:	85 db                	test   %ebx,%ebx
40000789:	0f 8e 4b fe ff ff    	jle    400005da <vprintfmt+0x1ba>
				for (width -= strnlen(p, precision); width > 0; width--)
4000078f:	89 54 24 04          	mov    %edx,0x4(%esp)
40000793:	89 0c 24             	mov    %ecx,(%esp)
40000796:	89 54 24 2c          	mov    %edx,0x2c(%esp)
4000079a:	89 4c 24 28          	mov    %ecx,0x28(%esp)
4000079e:	e8 ad 02 00 00       	call   40000a50 <strnlen>
400007a3:	8b 4c 24 28          	mov    0x28(%esp),%ecx
400007a7:	8b 54 24 2c          	mov    0x2c(%esp),%edx
400007ab:	29 44 24 20          	sub    %eax,0x20(%esp)
400007af:	8b 44 24 20          	mov    0x20(%esp),%eax
400007b3:	85 c0                	test   %eax,%eax
400007b5:	0f 8e 1f fe ff ff    	jle    400005da <vprintfmt+0x1ba>
400007bb:	0f be 5c 24 24       	movsbl 0x24(%esp),%ebx
400007c0:	89 7c 24 58          	mov    %edi,0x58(%esp)
400007c4:	89 c7                	mov    %eax,%edi
400007c6:	89 4c 24 20          	mov    %ecx,0x20(%esp)
400007ca:	89 54 24 24          	mov    %edx,0x24(%esp)
400007ce:	66 90                	xchg   %ax,%ax
					putch(padc, putdat);
400007d0:	89 74 24 04          	mov    %esi,0x4(%esp)
400007d4:	89 1c 24             	mov    %ebx,(%esp)
400007d7:	ff d5                	call   *%ebp
			// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
400007d9:	83 ef 01             	sub    $0x1,%edi
400007dc:	75 f2                	jne    400007d0 <vprintfmt+0x3b0>
400007de:	8b 4c 24 20          	mov    0x20(%esp),%ecx
400007e2:	8b 54 24 24          	mov    0x24(%esp),%edx
400007e6:	89 7c 24 20          	mov    %edi,0x20(%esp)
400007ea:	8b 7c 24 58          	mov    0x58(%esp),%edi
400007ee:	e9 e7 fd ff ff       	jmp    400005da <vprintfmt+0x1ba>
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
		return va_arg(*ap, long long);
	else if (lflag)
		return va_arg(*ap, long);
400007f3:	89 cb                	mov    %ecx,%ebx
400007f5:	83 c0 04             	add    $0x4,%eax
400007f8:	c1 fb 1f             	sar    $0x1f,%ebx
400007fb:	89 44 24 5c          	mov    %eax,0x5c(%esp)
400007ff:	e9 12 fd ff ff       	jmp    40000516 <vprintfmt+0xf6>
40000804:	89 54 24 18          	mov    %edx,0x18(%esp)
40000808:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)

			// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
			if ((long long) num < 0) {
				putch('-', putdat);
4000080c:	89 74 24 04          	mov    %esi,0x4(%esp)
40000810:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
40000817:	ff d5                	call   *%ebp
				num = -(long long) num;
40000819:	8b 54 24 18          	mov    0x18(%esp),%edx
4000081d:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
40000821:	f7 da                	neg    %edx
40000823:	83 d1 00             	adc    $0x0,%ecx
40000826:	f7 d9                	neg    %ecx
40000828:	e9 fa fc ff ff       	jmp    40000527 <vprintfmt+0x107>
4000082d:	8d 76 00             	lea    0x0(%esi),%esi

40000830 <printfmt>:
	}
}

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
40000830:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;

	va_start(ap, fmt);
	vprintfmt(putch, putdat, fmt, ap);
40000833:	8d 44 24 2c          	lea    0x2c(%esp),%eax
40000837:	89 44 24 0c          	mov    %eax,0xc(%esp)
4000083b:	8b 44 24 28          	mov    0x28(%esp),%eax
4000083f:	89 44 24 08          	mov    %eax,0x8(%esp)
40000843:	8b 44 24 24          	mov    0x24(%esp),%eax
40000847:	89 44 24 04          	mov    %eax,0x4(%esp)
4000084b:	8b 44 24 20          	mov    0x20(%esp),%eax
4000084f:	89 04 24             	mov    %eax,(%esp)
40000852:	e8 c9 fb ff ff       	call   40000420 <vprintfmt>
	va_end(ap);
}
40000857:	83 c4 1c             	add    $0x1c,%esp
4000085a:	c3                   	ret    
4000085b:	90                   	nop
4000085c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000860 <vsprintf>:
		*b->buf++ = ch;
}

int
vsprintf(char *buf, const char *fmt, va_list ap)
{
40000860:	83 ec 2c             	sub    $0x2c,%esp
	//assert(buf != NULL);
	struct sprintbuf b = {buf, (char*)(intptr_t)~0, 0};
40000863:	8b 44 24 30          	mov    0x30(%esp),%eax

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
40000867:	c7 04 24 00 04 00 40 	movl   $0x40000400,(%esp)

int
vsprintf(char *buf, const char *fmt, va_list ap)
{
	//assert(buf != NULL);
	struct sprintbuf b = {buf, (char*)(intptr_t)~0, 0};
4000086e:	c7 44 24 18 ff ff ff 	movl   $0xffffffff,0x18(%esp)
40000875:	ff 
40000876:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
4000087d:	00 
4000087e:	89 44 24 14          	mov    %eax,0x14(%esp)

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
40000882:	8b 44 24 38          	mov    0x38(%esp),%eax
40000886:	89 44 24 0c          	mov    %eax,0xc(%esp)
4000088a:	8b 44 24 34          	mov    0x34(%esp),%eax
4000088e:	89 44 24 08          	mov    %eax,0x8(%esp)
40000892:	8d 44 24 14          	lea    0x14(%esp),%eax
40000896:	89 44 24 04          	mov    %eax,0x4(%esp)
4000089a:	e8 81 fb ff ff       	call   40000420 <vprintfmt>

	// null terminate the buffer
	*b.buf = '\0';
4000089f:	8b 44 24 14          	mov    0x14(%esp),%eax
400008a3:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
}
400008a6:	8b 44 24 1c          	mov    0x1c(%esp),%eax
400008aa:	83 c4 2c             	add    $0x2c,%esp
400008ad:	c3                   	ret    
400008ae:	66 90                	xchg   %ax,%ax

400008b0 <sprintf>:

int
sprintf(char *buf, const char *fmt, ...)
{
400008b0:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
	rc = vsprintf(buf, fmt, ap);
400008b3:	8d 44 24 28          	lea    0x28(%esp),%eax
400008b7:	89 44 24 08          	mov    %eax,0x8(%esp)
400008bb:	8b 44 24 24          	mov    0x24(%esp),%eax
400008bf:	89 44 24 04          	mov    %eax,0x4(%esp)
400008c3:	8b 44 24 20          	mov    0x20(%esp),%eax
400008c7:	89 04 24             	mov    %eax,(%esp)
400008ca:	e8 91 ff ff ff       	call   40000860 <vsprintf>
	va_end(ap);

	return rc;
}
400008cf:	83 c4 1c             	add    $0x1c,%esp
400008d2:	c3                   	ret    
400008d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
400008d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

400008e0 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
400008e0:	83 ec 2c             	sub    $0x2c,%esp
400008e3:	8b 44 24 30          	mov    0x30(%esp),%eax
	//assert(buf != NULL && n > 0);
	struct sprintbuf b = {buf, buf+n-1, 0};
400008e7:	8b 54 24 34          	mov    0x34(%esp),%edx

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
400008eb:	c7 04 24 00 04 00 40 	movl   $0x40000400,(%esp)

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
	//assert(buf != NULL && n > 0);
	struct sprintbuf b = {buf, buf+n-1, 0};
400008f2:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
400008f9:	00 
400008fa:	89 44 24 14          	mov    %eax,0x14(%esp)
400008fe:	8d 44 10 ff          	lea    -0x1(%eax,%edx,1),%eax
40000902:	89 44 24 18          	mov    %eax,0x18(%esp)

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
40000906:	8b 44 24 3c          	mov    0x3c(%esp),%eax
4000090a:	89 44 24 0c          	mov    %eax,0xc(%esp)
4000090e:	8b 44 24 38          	mov    0x38(%esp),%eax
40000912:	89 44 24 08          	mov    %eax,0x8(%esp)
40000916:	8d 44 24 14          	lea    0x14(%esp),%eax
4000091a:	89 44 24 04          	mov    %eax,0x4(%esp)
4000091e:	e8 fd fa ff ff       	call   40000420 <vprintfmt>

	// null terminate the buffer
	*b.buf = '\0';
40000923:	8b 44 24 14          	mov    0x14(%esp),%eax
40000927:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
}
4000092a:	8b 44 24 1c          	mov    0x1c(%esp),%eax
4000092e:	83 c4 2c             	add    $0x2c,%esp
40000931:	c3                   	ret    
40000932:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000940 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
40000940:	83 ec 1c             	sub    $0x1c,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
	rc = vsnprintf(buf, n, fmt, ap);
40000943:	8d 44 24 2c          	lea    0x2c(%esp),%eax
40000947:	89 44 24 0c          	mov    %eax,0xc(%esp)
4000094b:	8b 44 24 28          	mov    0x28(%esp),%eax
4000094f:	89 44 24 08          	mov    %eax,0x8(%esp)
40000953:	8b 44 24 24          	mov    0x24(%esp),%eax
40000957:	89 44 24 04          	mov    %eax,0x4(%esp)
4000095b:	8b 44 24 20          	mov    0x20(%esp),%eax
4000095f:	89 04 24             	mov    %eax,(%esp)
40000962:	e8 79 ff ff ff       	call   400008e0 <vsnprintf>
	va_end(ap);

	return rc;
}
40000967:	83 c4 1c             	add    $0x1c,%esp
4000096a:	c3                   	ret    
4000096b:	66 90                	xchg   %ax,%ax
4000096d:	66 90                	xchg   %ax,%ax
4000096f:	90                   	nop

40000970 <spawn>:
#include <syscall.h>
#include <types.h>

pid_t
spawn(uintptr_t exec, unsigned int quota)
{
40000970:	53                   	push   %ebx
sys_spawn(uintptr_t exec, unsigned int quota)
{
	int errno;
	pid_t pid;

	asm volatile("int %2"
40000971:	b8 01 00 00 00       	mov    $0x1,%eax
40000976:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
4000097a:	8b 5c 24 08          	mov    0x8(%esp),%ebx
4000097e:	cd 30                	int    $0x30
		       "a" (SYS_spawn),
		       "b" (exec),
		       "c" (quota)
		     : "cc", "memory");

	return errno ? -1 : pid;
40000980:	ba ff ff ff ff       	mov    $0xffffffff,%edx
40000985:	85 c0                	test   %eax,%eax
40000987:	0f 44 d3             	cmove  %ebx,%edx
	return sys_spawn(exec, quota);
}
4000098a:	89 d0                	mov    %edx,%eax
4000098c:	5b                   	pop    %ebx
4000098d:	c3                   	ret    
4000098e:	66 90                	xchg   %ax,%ax

40000990 <yield>:
}

static gcc_inline void
sys_yield(void)
{
	asm volatile("int %0" :
40000990:	b8 02 00 00 00       	mov    $0x2,%eax
40000995:	cd 30                	int    $0x30
40000997:	c3                   	ret    
40000998:	90                   	nop
40000999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

400009a0 <produce>:
}

static gcc_inline void
sys_produce(void)
{
	asm volatile("int %0" :
400009a0:	b8 03 00 00 00       	mov    $0x3,%eax
400009a5:	cd 30                	int    $0x30
400009a7:	c3                   	ret    
400009a8:	90                   	nop
400009a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

400009b0 <consume>:
}

static gcc_inline void
sys_consume(void)
{
	asm volatile("int %0" :
400009b0:	b8 04 00 00 00       	mov    $0x4,%eax
400009b5:	cd 30                	int    $0x30
400009b7:	c3                   	ret    
400009b8:	66 90                	xchg   %ax,%ax
400009ba:	66 90                	xchg   %ax,%ax
400009bc:	66 90                	xchg   %ax,%ax
400009be:	66 90                	xchg   %ax,%ax

400009c0 <spinlock_init>:
}

void
spinlock_init(spinlock_t *lk)
{
	*lk = 0;
400009c0:	8b 44 24 04          	mov    0x4(%esp),%eax
400009c4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
400009ca:	c3                   	ret    
400009cb:	90                   	nop
400009cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

400009d0 <spinlock_acquire>:
}

void
spinlock_acquire(spinlock_t *lk)
{
400009d0:	8b 54 24 04          	mov    0x4(%esp),%edx
static inline uint32_t
xchg(volatile uint32_t *addr, uint32_t newval)
{
	uint32_t result;

	asm volatile("lock; xchgl %0, %1" :
400009d4:	b8 01 00 00 00       	mov    $0x1,%eax
400009d9:	f0 87 02             	lock xchg %eax,(%edx)
}

void
spinlock_acquire(spinlock_t *lk)
{
	while(xchg(lk, 1) != 0)
400009dc:	85 c0                	test   %eax,%eax
static inline uint32_t
xchg(volatile uint32_t *addr, uint32_t newval)
{
	uint32_t result;

	asm volatile("lock; xchgl %0, %1" :
400009de:	b9 01 00 00 00       	mov    $0x1,%ecx
}

void
spinlock_acquire(spinlock_t *lk)
{
	while(xchg(lk, 1) != 0)
400009e3:	74 0e                	je     400009f3 <spinlock_acquire+0x23>
400009e5:	8d 76 00             	lea    0x0(%esi),%esi
		asm volatile("pause");
400009e8:	f3 90                	pause  
static inline uint32_t
xchg(volatile uint32_t *addr, uint32_t newval)
{
	uint32_t result;

	asm volatile("lock; xchgl %0, %1" :
400009ea:	89 c8                	mov    %ecx,%eax
400009ec:	f0 87 02             	lock xchg %eax,(%edx)
}

void
spinlock_acquire(spinlock_t *lk)
{
	while(xchg(lk, 1) != 0)
400009ef:	85 c0                	test   %eax,%eax
400009f1:	75 f5                	jne    400009e8 <spinlock_acquire+0x18>
400009f3:	f3 c3                	repz ret 
400009f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
400009f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000a00 <spinlock_release>:
}

// Release the lock.
void
spinlock_release(spinlock_t *lk)
{
40000a00:	8b 54 24 04          	mov    0x4(%esp),%edx

// Check whether this cpu is holding the lock.
bool
spinlock_holding(spinlock_t *lock)
{
	return *lock;
40000a04:	8b 02                	mov    (%edx),%eax

// Release the lock.
void
spinlock_release(spinlock_t *lk)
{
	if (spinlock_holding(lk) == FALSE)
40000a06:	84 c0                	test   %al,%al
40000a08:	74 05                	je     40000a0f <spinlock_release+0xf>
static inline uint32_t
xchg(volatile uint32_t *addr, uint32_t newval)
{
	uint32_t result;

	asm volatile("lock; xchgl %0, %1" :
40000a0a:	31 c0                	xor    %eax,%eax
40000a0c:	f0 87 02             	lock xchg %eax,(%edx)
40000a0f:	f3 c3                	repz ret 
40000a11:	eb 0d                	jmp    40000a20 <spinlock_holding>
40000a13:	90                   	nop
40000a14:	90                   	nop
40000a15:	90                   	nop
40000a16:	90                   	nop
40000a17:	90                   	nop
40000a18:	90                   	nop
40000a19:	90                   	nop
40000a1a:	90                   	nop
40000a1b:	90                   	nop
40000a1c:	90                   	nop
40000a1d:	90                   	nop
40000a1e:	90                   	nop
40000a1f:	90                   	nop

40000a20 <spinlock_holding>:

// Check whether this cpu is holding the lock.
bool
spinlock_holding(spinlock_t *lock)
{
	return *lock;
40000a20:	8b 44 24 04          	mov    0x4(%esp),%eax
40000a24:	8b 00                	mov    (%eax),%eax
}
40000a26:	c3                   	ret    
40000a27:	66 90                	xchg   %ax,%ax
40000a29:	66 90                	xchg   %ax,%ax
40000a2b:	66 90                	xchg   %ax,%ax
40000a2d:	66 90                	xchg   %ax,%ax
40000a2f:	90                   	nop

40000a30 <strlen>:
#include <string.h>
#include <types.h>

int
strlen(const char *s)
{
40000a30:	8b 54 24 04          	mov    0x4(%esp),%edx
	int n;

	for (n = 0; *s != '\0'; s++)
40000a34:	31 c0                	xor    %eax,%eax
40000a36:	80 3a 00             	cmpb   $0x0,(%edx)
40000a39:	74 10                	je     40000a4b <strlen+0x1b>
40000a3b:	90                   	nop
40000a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		n++;
40000a40:	83 c0 01             	add    $0x1,%eax
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
40000a43:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
40000a47:	75 f7                	jne    40000a40 <strlen+0x10>
40000a49:	f3 c3                	repz ret 
		n++;
	return n;
}
40000a4b:	f3 c3                	repz ret 
40000a4d:	8d 76 00             	lea    0x0(%esi),%esi

40000a50 <strnlen>:

int
strnlen(const char *s, size_t size)
{
40000a50:	53                   	push   %ebx
40000a51:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000a55:	8b 5c 24 08          	mov    0x8(%esp),%ebx
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
40000a59:	85 c9                	test   %ecx,%ecx
40000a5b:	74 25                	je     40000a82 <strnlen+0x32>
40000a5d:	80 3b 00             	cmpb   $0x0,(%ebx)
40000a60:	74 20                	je     40000a82 <strnlen+0x32>
40000a62:	ba 01 00 00 00       	mov    $0x1,%edx
40000a67:	eb 11                	jmp    40000a7a <strnlen+0x2a>
40000a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000a70:	83 c2 01             	add    $0x1,%edx
40000a73:	80 7c 13 ff 00       	cmpb   $0x0,-0x1(%ebx,%edx,1)
40000a78:	74 06                	je     40000a80 <strnlen+0x30>
40000a7a:	39 ca                	cmp    %ecx,%edx
		n++;
40000a7c:	89 d0                	mov    %edx,%eax
int
strnlen(const char *s, size_t size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
40000a7e:	75 f0                	jne    40000a70 <strnlen+0x20>
		n++;
	return n;
}
40000a80:	5b                   	pop    %ebx
40000a81:	c3                   	ret    
int
strnlen(const char *s, size_t size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
40000a82:	31 c0                	xor    %eax,%eax
		n++;
	return n;
}
40000a84:	5b                   	pop    %ebx
40000a85:	c3                   	ret    
40000a86:	8d 76 00             	lea    0x0(%esi),%esi
40000a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000a90 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
40000a90:	53                   	push   %ebx
40000a91:	8b 44 24 08          	mov    0x8(%esp),%eax
40000a95:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
	char *ret;

	ret = dst;
	while ((*dst++ = *src++) != '\0')
40000a99:	89 c2                	mov    %eax,%edx
40000a9b:	90                   	nop
40000a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000aa0:	83 c1 01             	add    $0x1,%ecx
40000aa3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
40000aa7:	83 c2 01             	add    $0x1,%edx
40000aaa:	84 db                	test   %bl,%bl
40000aac:	88 5a ff             	mov    %bl,-0x1(%edx)
40000aaf:	75 ef                	jne    40000aa0 <strcpy+0x10>
		/* do nothing */;
	return ret;
}
40000ab1:	5b                   	pop    %ebx
40000ab2:	c3                   	ret    
40000ab3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000ac0 <strncpy>:

char *
strncpy(char *dst, const char *src, size_t size)
{
40000ac0:	57                   	push   %edi
40000ac1:	56                   	push   %esi
40000ac2:	53                   	push   %ebx
40000ac3:	8b 74 24 18          	mov    0x18(%esp),%esi
40000ac7:	8b 7c 24 10          	mov    0x10(%esp),%edi
40000acb:	8b 4c 24 14          	mov    0x14(%esp),%ecx
	size_t i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
40000acf:	85 f6                	test   %esi,%esi
40000ad1:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
40000ad4:	89 fa                	mov    %edi,%edx
40000ad6:	74 13                	je     40000aeb <strncpy+0x2b>
		*dst++ = *src;
40000ad8:	0f b6 01             	movzbl (%ecx),%eax
40000adb:	83 c2 01             	add    $0x1,%edx
40000ade:	88 42 ff             	mov    %al,-0x1(%edx)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
40000ae1:	80 39 01             	cmpb   $0x1,(%ecx)
40000ae4:	83 d9 ff             	sbb    $0xffffffff,%ecx
{
	size_t i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
40000ae7:	39 da                	cmp    %ebx,%edx
40000ae9:	75 ed                	jne    40000ad8 <strncpy+0x18>
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
}
40000aeb:	89 f8                	mov    %edi,%eax
40000aed:	5b                   	pop    %ebx
40000aee:	5e                   	pop    %esi
40000aef:	5f                   	pop    %edi
40000af0:	c3                   	ret    
40000af1:	eb 0d                	jmp    40000b00 <strlcpy>
40000af3:	90                   	nop
40000af4:	90                   	nop
40000af5:	90                   	nop
40000af6:	90                   	nop
40000af7:	90                   	nop
40000af8:	90                   	nop
40000af9:	90                   	nop
40000afa:	90                   	nop
40000afb:	90                   	nop
40000afc:	90                   	nop
40000afd:	90                   	nop
40000afe:	90                   	nop
40000aff:	90                   	nop

40000b00 <strlcpy>:

size_t
strlcpy(char *dst, const char *src, size_t size)
{
40000b00:	56                   	push   %esi
40000b01:	31 c0                	xor    %eax,%eax
40000b03:	53                   	push   %ebx
40000b04:	8b 74 24 14          	mov    0x14(%esp),%esi
40000b08:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
40000b0c:	85 f6                	test   %esi,%esi
40000b0e:	74 36                	je     40000b46 <strlcpy+0x46>
		while (--size > 0 && *src != '\0')
40000b10:	83 fe 01             	cmp    $0x1,%esi
40000b13:	74 34                	je     40000b49 <strlcpy+0x49>
40000b15:	0f b6 0b             	movzbl (%ebx),%ecx
40000b18:	84 c9                	test   %cl,%cl
40000b1a:	74 2d                	je     40000b49 <strlcpy+0x49>
40000b1c:	83 ee 02             	sub    $0x2,%esi
40000b1f:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000b23:	eb 0e                	jmp    40000b33 <strlcpy+0x33>
40000b25:	8d 76 00             	lea    0x0(%esi),%esi
40000b28:	83 c0 01             	add    $0x1,%eax
40000b2b:	0f b6 0c 03          	movzbl (%ebx,%eax,1),%ecx
40000b2f:	84 c9                	test   %cl,%cl
40000b31:	74 0a                	je     40000b3d <strlcpy+0x3d>
			*dst++ = *src++;
40000b33:	83 c2 01             	add    $0x1,%edx
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
40000b36:	39 f0                	cmp    %esi,%eax
			*dst++ = *src++;
40000b38:	88 4a ff             	mov    %cl,-0x1(%edx)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
40000b3b:	75 eb                	jne    40000b28 <strlcpy+0x28>
40000b3d:	89 d0                	mov    %edx,%eax
40000b3f:	2b 44 24 0c          	sub    0xc(%esp),%eax
			*dst++ = *src++;
		*dst = '\0';
40000b43:	c6 02 00             	movb   $0x0,(%edx)
	}
	return dst - dst_in;
}
40000b46:	5b                   	pop    %ebx
40000b47:	5e                   	pop    %esi
40000b48:	c3                   	ret    
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
40000b49:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000b4d:	eb f4                	jmp    40000b43 <strlcpy+0x43>
40000b4f:	90                   	nop

40000b50 <strcmp>:
	return dst - dst_in;
}

int
strcmp(const char *p, const char *q)
{
40000b50:	53                   	push   %ebx
40000b51:	8b 54 24 08          	mov    0x8(%esp),%edx
40000b55:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
	while (*p && *p == *q)
40000b59:	0f b6 02             	movzbl (%edx),%eax
40000b5c:	84 c0                	test   %al,%al
40000b5e:	74 2d                	je     40000b8d <strcmp+0x3d>
40000b60:	0f b6 19             	movzbl (%ecx),%ebx
40000b63:	38 d8                	cmp    %bl,%al
40000b65:	74 0f                	je     40000b76 <strcmp+0x26>
40000b67:	eb 2b                	jmp    40000b94 <strcmp+0x44>
40000b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000b70:	38 c8                	cmp    %cl,%al
40000b72:	75 15                	jne    40000b89 <strcmp+0x39>
		p++, q++;
40000b74:	89 d9                	mov    %ebx,%ecx
40000b76:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
40000b79:	0f b6 02             	movzbl (%edx),%eax
		p++, q++;
40000b7c:	8d 59 01             	lea    0x1(%ecx),%ebx
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
40000b7f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
40000b83:	84 c0                	test   %al,%al
40000b85:	75 e9                	jne    40000b70 <strcmp+0x20>
40000b87:	31 c0                	xor    %eax,%eax
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
40000b89:	29 c8                	sub    %ecx,%eax
}
40000b8b:	5b                   	pop    %ebx
40000b8c:	c3                   	ret    
40000b8d:	0f b6 09             	movzbl (%ecx),%ecx
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
40000b90:	31 c0                	xor    %eax,%eax
40000b92:	eb f5                	jmp    40000b89 <strcmp+0x39>
40000b94:	0f b6 cb             	movzbl %bl,%ecx
40000b97:	eb f0                	jmp    40000b89 <strcmp+0x39>
40000b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000ba0 <strncmp>:
	return (int) ((unsigned char) *p - (unsigned char) *q);
}

int
strncmp(const char *p, const char *q, size_t n)
{
40000ba0:	56                   	push   %esi
40000ba1:	53                   	push   %ebx
40000ba2:	8b 74 24 14          	mov    0x14(%esp),%esi
40000ba6:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000baa:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	while (n > 0 && *p && *p == *q)
40000bae:	85 f6                	test   %esi,%esi
40000bb0:	74 30                	je     40000be2 <strncmp+0x42>
40000bb2:	0f b6 01             	movzbl (%ecx),%eax
40000bb5:	84 c0                	test   %al,%al
40000bb7:	74 2e                	je     40000be7 <strncmp+0x47>
40000bb9:	0f b6 13             	movzbl (%ebx),%edx
40000bbc:	38 d0                	cmp    %dl,%al
40000bbe:	75 3e                	jne    40000bfe <strncmp+0x5e>
40000bc0:	8d 51 01             	lea    0x1(%ecx),%edx
40000bc3:	01 ce                	add    %ecx,%esi
40000bc5:	eb 14                	jmp    40000bdb <strncmp+0x3b>
40000bc7:	90                   	nop
40000bc8:	0f b6 02             	movzbl (%edx),%eax
40000bcb:	84 c0                	test   %al,%al
40000bcd:	74 29                	je     40000bf8 <strncmp+0x58>
40000bcf:	0f b6 19             	movzbl (%ecx),%ebx
40000bd2:	83 c2 01             	add    $0x1,%edx
40000bd5:	38 d8                	cmp    %bl,%al
40000bd7:	75 17                	jne    40000bf0 <strncmp+0x50>
		n--, p++, q++;
40000bd9:	89 cb                	mov    %ecx,%ebx
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
40000bdb:	39 f2                	cmp    %esi,%edx
		n--, p++, q++;
40000bdd:	8d 4b 01             	lea    0x1(%ebx),%ecx
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
40000be0:	75 e6                	jne    40000bc8 <strncmp+0x28>
		n--, p++, q++;
	if (n == 0)
		return 0;
40000be2:	31 c0                	xor    %eax,%eax
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
}
40000be4:	5b                   	pop    %ebx
40000be5:	5e                   	pop    %esi
40000be6:	c3                   	ret    
40000be7:	0f b6 1b             	movzbl (%ebx),%ebx
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
40000bea:	31 c0                	xor    %eax,%eax
40000bec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		n--, p++, q++;
	if (n == 0)
		return 0;
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
40000bf0:	0f b6 d3             	movzbl %bl,%edx
40000bf3:	29 d0                	sub    %edx,%eax
}
40000bf5:	5b                   	pop    %ebx
40000bf6:	5e                   	pop    %esi
40000bf7:	c3                   	ret    
40000bf8:	0f b6 5b 01          	movzbl 0x1(%ebx),%ebx
40000bfc:	eb f2                	jmp    40000bf0 <strncmp+0x50>
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
40000bfe:	89 d3                	mov    %edx,%ebx
40000c00:	eb ee                	jmp    40000bf0 <strncmp+0x50>
40000c02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000c10 <strchr>:
		return (int) ((unsigned char) *p - (unsigned char) *q);
}

char *
strchr(const char *s, char c)
{
40000c10:	53                   	push   %ebx
40000c11:	8b 44 24 08          	mov    0x8(%esp),%eax
40000c15:	8b 54 24 0c          	mov    0xc(%esp),%edx
	for (; *s; s++)
40000c19:	0f b6 18             	movzbl (%eax),%ebx
40000c1c:	84 db                	test   %bl,%bl
40000c1e:	74 16                	je     40000c36 <strchr+0x26>
		if (*s == c)
40000c20:	38 d3                	cmp    %dl,%bl
40000c22:	89 d1                	mov    %edx,%ecx
40000c24:	75 06                	jne    40000c2c <strchr+0x1c>
40000c26:	eb 10                	jmp    40000c38 <strchr+0x28>
40000c28:	38 ca                	cmp    %cl,%dl
40000c2a:	74 0c                	je     40000c38 <strchr+0x28>
}

char *
strchr(const char *s, char c)
{
	for (; *s; s++)
40000c2c:	83 c0 01             	add    $0x1,%eax
40000c2f:	0f b6 10             	movzbl (%eax),%edx
40000c32:	84 d2                	test   %dl,%dl
40000c34:	75 f2                	jne    40000c28 <strchr+0x18>
		if (*s == c)
			return (char *) s;
	return 0;
40000c36:	31 c0                	xor    %eax,%eax
}
40000c38:	5b                   	pop    %ebx
40000c39:	c3                   	ret    
40000c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000c40 <strfind>:

char *
strfind(const char *s, char c)
{
40000c40:	53                   	push   %ebx
40000c41:	8b 44 24 08          	mov    0x8(%esp),%eax
40000c45:	8b 54 24 0c          	mov    0xc(%esp),%edx
	for (; *s; s++)
40000c49:	0f b6 18             	movzbl (%eax),%ebx
40000c4c:	84 db                	test   %bl,%bl
40000c4e:	74 16                	je     40000c66 <strfind+0x26>
		if (*s == c)
40000c50:	38 d3                	cmp    %dl,%bl
40000c52:	89 d1                	mov    %edx,%ecx
40000c54:	75 06                	jne    40000c5c <strfind+0x1c>
40000c56:	eb 0e                	jmp    40000c66 <strfind+0x26>
40000c58:	38 ca                	cmp    %cl,%dl
40000c5a:	74 0a                	je     40000c66 <strfind+0x26>
}

char *
strfind(const char *s, char c)
{
	for (; *s; s++)
40000c5c:	83 c0 01             	add    $0x1,%eax
40000c5f:	0f b6 10             	movzbl (%eax),%edx
40000c62:	84 d2                	test   %dl,%dl
40000c64:	75 f2                	jne    40000c58 <strfind+0x18>
		if (*s == c)
			break;
	return (char *) s;
}
40000c66:	5b                   	pop    %ebx
40000c67:	c3                   	ret    
40000c68:	90                   	nop
40000c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000c70 <strtol>:


long
strtol(const char *s, char **endptr, int base)
{
40000c70:	55                   	push   %ebp
40000c71:	57                   	push   %edi
40000c72:	56                   	push   %esi
40000c73:	53                   	push   %ebx
40000c74:	8b 54 24 14          	mov    0x14(%esp),%edx
40000c78:	8b 74 24 18          	mov    0x18(%esp),%esi
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
40000c7c:	0f b6 0a             	movzbl (%edx),%ecx
40000c7f:	80 f9 20             	cmp    $0x20,%cl
40000c82:	0f 85 e6 00 00 00    	jne    40000d6e <strtol+0xfe>
		s++;
40000c88:	83 c2 01             	add    $0x1,%edx
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
40000c8b:	0f b6 0a             	movzbl (%edx),%ecx
40000c8e:	80 f9 09             	cmp    $0x9,%cl
40000c91:	74 f5                	je     40000c88 <strtol+0x18>
40000c93:	80 f9 20             	cmp    $0x20,%cl
40000c96:	74 f0                	je     40000c88 <strtol+0x18>
		s++;

	// plus/minus sign
	if (*s == '+')
40000c98:	80 f9 2b             	cmp    $0x2b,%cl
40000c9b:	0f 84 8f 00 00 00    	je     40000d30 <strtol+0xc0>


long
strtol(const char *s, char **endptr, int base)
{
	int neg = 0;
40000ca1:	31 ff                	xor    %edi,%edi
		s++;

	// plus/minus sign
	if (*s == '+')
		s++;
	else if (*s == '-')
40000ca3:	80 f9 2d             	cmp    $0x2d,%cl
40000ca6:	0f 84 94 00 00 00    	je     40000d40 <strtol+0xd0>
		s++, neg = 1;

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000cac:	f7 44 24 1c ef ff ff 	testl  $0xffffffef,0x1c(%esp)
40000cb3:	ff 
40000cb4:	0f be 0a             	movsbl (%edx),%ecx
40000cb7:	75 19                	jne    40000cd2 <strtol+0x62>
40000cb9:	80 f9 30             	cmp    $0x30,%cl
40000cbc:	0f 84 8a 00 00 00    	je     40000d4c <strtol+0xdc>
		s += 2, base = 16;
	else if (base == 0 && s[0] == '0')
40000cc2:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
40000cc6:	85 db                	test   %ebx,%ebx
40000cc8:	75 08                	jne    40000cd2 <strtol+0x62>
		s++, base = 8;
	else if (base == 0)
		base = 10;
40000cca:	c7 44 24 1c 0a 00 00 	movl   $0xa,0x1c(%esp)
40000cd1:	00 
		s++;
	else if (*s == '-')
		s++, neg = 1;

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000cd2:	31 db                	xor    %ebx,%ebx
40000cd4:	eb 18                	jmp    40000cee <strtol+0x7e>
40000cd6:	66 90                	xchg   %ax,%ax
	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
			dig = *s - '0';
40000cd8:	83 e9 30             	sub    $0x30,%ecx
			dig = *s - 'a' + 10;
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
40000cdb:	3b 4c 24 1c          	cmp    0x1c(%esp),%ecx
40000cdf:	7d 28                	jge    40000d09 <strtol+0x99>
			break;
		s++, val = (val * base) + dig;
40000ce1:	0f af 5c 24 1c       	imul   0x1c(%esp),%ebx
40000ce6:	83 c2 01             	add    $0x1,%edx
40000ce9:	01 cb                	add    %ecx,%ebx
40000ceb:	0f be 0a             	movsbl (%edx),%ecx

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
40000cee:	8d 69 d0             	lea    -0x30(%ecx),%ebp
40000cf1:	89 e8                	mov    %ebp,%eax
40000cf3:	3c 09                	cmp    $0x9,%al
40000cf5:	76 e1                	jbe    40000cd8 <strtol+0x68>
			dig = *s - '0';
		else if (*s >= 'a' && *s <= 'z')
40000cf7:	8d 69 9f             	lea    -0x61(%ecx),%ebp
40000cfa:	89 e8                	mov    %ebp,%eax
40000cfc:	3c 19                	cmp    $0x19,%al
40000cfe:	77 20                	ja     40000d20 <strtol+0xb0>
			dig = *s - 'a' + 10;
40000d00:	83 e9 57             	sub    $0x57,%ecx
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
40000d03:	3b 4c 24 1c          	cmp    0x1c(%esp),%ecx
40000d07:	7c d8                	jl     40000ce1 <strtol+0x71>
			break;
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
40000d09:	85 f6                	test   %esi,%esi
40000d0b:	74 02                	je     40000d0f <strtol+0x9f>
		*endptr = (char *) s;
40000d0d:	89 16                	mov    %edx,(%esi)
	return (neg ? -val : val);
40000d0f:	89 d8                	mov    %ebx,%eax
40000d11:	f7 d8                	neg    %eax
40000d13:	85 ff                	test   %edi,%edi
40000d15:	0f 44 c3             	cmove  %ebx,%eax
}
40000d18:	5b                   	pop    %ebx
40000d19:	5e                   	pop    %esi
40000d1a:	5f                   	pop    %edi
40000d1b:	5d                   	pop    %ebp
40000d1c:	c3                   	ret    
40000d1d:	8d 76 00             	lea    0x0(%esi),%esi

		if (*s >= '0' && *s <= '9')
			dig = *s - '0';
		else if (*s >= 'a' && *s <= 'z')
			dig = *s - 'a' + 10;
		else if (*s >= 'A' && *s <= 'Z')
40000d20:	8d 69 bf             	lea    -0x41(%ecx),%ebp
40000d23:	89 e8                	mov    %ebp,%eax
40000d25:	3c 19                	cmp    $0x19,%al
40000d27:	77 e0                	ja     40000d09 <strtol+0x99>
			dig = *s - 'A' + 10;
40000d29:	83 e9 37             	sub    $0x37,%ecx
40000d2c:	eb ad                	jmp    40000cdb <strtol+0x6b>
40000d2e:	66 90                	xchg   %ax,%ax
	while (*s == ' ' || *s == '\t')
		s++;

	// plus/minus sign
	if (*s == '+')
		s++;
40000d30:	83 c2 01             	add    $0x1,%edx


long
strtol(const char *s, char **endptr, int base)
{
	int neg = 0;
40000d33:	31 ff                	xor    %edi,%edi
40000d35:	e9 72 ff ff ff       	jmp    40000cac <strtol+0x3c>
40000d3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

	// plus/minus sign
	if (*s == '+')
		s++;
	else if (*s == '-')
		s++, neg = 1;
40000d40:	83 c2 01             	add    $0x1,%edx
40000d43:	66 bf 01 00          	mov    $0x1,%di
40000d47:	e9 60 ff ff ff       	jmp    40000cac <strtol+0x3c>

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000d4c:	80 7a 01 78          	cmpb   $0x78,0x1(%edx)
40000d50:	74 2a                	je     40000d7c <strtol+0x10c>
		s += 2, base = 16;
	else if (base == 0 && s[0] == '0')
40000d52:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000d56:	85 c0                	test   %eax,%eax
40000d58:	75 36                	jne    40000d90 <strtol+0x120>
40000d5a:	0f be 4a 01          	movsbl 0x1(%edx),%ecx
		s++, base = 8;
40000d5e:	83 c2 01             	add    $0x1,%edx
40000d61:	c7 44 24 1c 08 00 00 	movl   $0x8,0x1c(%esp)
40000d68:	00 
40000d69:	e9 64 ff ff ff       	jmp    40000cd2 <strtol+0x62>
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
40000d6e:	80 f9 09             	cmp    $0x9,%cl
40000d71:	0f 84 11 ff ff ff    	je     40000c88 <strtol+0x18>
40000d77:	e9 1c ff ff ff       	jmp    40000c98 <strtol+0x28>
40000d7c:	0f be 4a 02          	movsbl 0x2(%edx),%ecx
	else if (*s == '-')
		s++, neg = 1;

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
		s += 2, base = 16;
40000d80:	83 c2 02             	add    $0x2,%edx
40000d83:	c7 44 24 1c 10 00 00 	movl   $0x10,0x1c(%esp)
40000d8a:	00 
40000d8b:	e9 42 ff ff ff       	jmp    40000cd2 <strtol+0x62>
		s++;
	else if (*s == '-')
		s++, neg = 1;

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000d90:	b9 30 00 00 00       	mov    $0x30,%ecx
40000d95:	e9 38 ff ff ff       	jmp    40000cd2 <strtol+0x62>
40000d9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000da0 <memset>:
	return (neg ? -val : val);
}

void *
memset(void *v, int c, size_t n)
{
40000da0:	57                   	push   %edi
40000da1:	56                   	push   %esi
40000da2:	53                   	push   %ebx
40000da3:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000da7:	8b 7c 24 10          	mov    0x10(%esp),%edi
	if (n == 0)
40000dab:	85 c9                	test   %ecx,%ecx
40000dad:	74 14                	je     40000dc3 <memset+0x23>
		return v;
	if ((int)v%4 == 0 && n%4 == 0) {
40000daf:	f7 c7 03 00 00 00    	test   $0x3,%edi
40000db5:	75 05                	jne    40000dbc <memset+0x1c>
40000db7:	f6 c1 03             	test   $0x3,%cl
40000dba:	74 14                	je     40000dd0 <memset+0x30>
		c = (c<<24)|(c<<16)|(c<<8)|c;
		asm volatile("cld; rep stosl\n"
			     :: "D" (v), "a" (c), "c" (n/4)
			     : "cc", "memory");
	} else
		asm volatile("cld; rep stosb\n"
40000dbc:	8b 44 24 14          	mov    0x14(%esp),%eax
40000dc0:	fc                   	cld    
40000dc1:	f3 aa                	rep stos %al,%es:(%edi)
			     :: "D" (v), "a" (c), "c" (n)
			     : "cc", "memory");
	return v;
}
40000dc3:	89 f8                	mov    %edi,%eax
40000dc5:	5b                   	pop    %ebx
40000dc6:	5e                   	pop    %esi
40000dc7:	5f                   	pop    %edi
40000dc8:	c3                   	ret    
40000dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
memset(void *v, int c, size_t n)
{
	if (n == 0)
		return v;
	if ((int)v%4 == 0 && n%4 == 0) {
		c &= 0xFF;
40000dd0:	0f b6 54 24 14       	movzbl 0x14(%esp),%edx
		c = (c<<24)|(c<<16)|(c<<8)|c;
		asm volatile("cld; rep stosl\n"
			     :: "D" (v), "a" (c), "c" (n/4)
40000dd5:	c1 e9 02             	shr    $0x2,%ecx
{
	if (n == 0)
		return v;
	if ((int)v%4 == 0 && n%4 == 0) {
		c &= 0xFF;
		c = (c<<24)|(c<<16)|(c<<8)|c;
40000dd8:	89 d0                	mov    %edx,%eax
40000dda:	89 d6                	mov    %edx,%esi
40000ddc:	c1 e0 18             	shl    $0x18,%eax
40000ddf:	89 d3                	mov    %edx,%ebx
40000de1:	c1 e6 10             	shl    $0x10,%esi
40000de4:	09 f0                	or     %esi,%eax
40000de6:	c1 e3 08             	shl    $0x8,%ebx
40000de9:	09 d0                	or     %edx,%eax
40000deb:	09 d8                	or     %ebx,%eax
		asm volatile("cld; rep stosl\n"
40000ded:	fc                   	cld    
40000dee:	f3 ab                	rep stos %eax,%es:(%edi)
	} else
		asm volatile("cld; rep stosb\n"
			     :: "D" (v), "a" (c), "c" (n)
			     : "cc", "memory");
	return v;
}
40000df0:	89 f8                	mov    %edi,%eax
40000df2:	5b                   	pop    %ebx
40000df3:	5e                   	pop    %esi
40000df4:	5f                   	pop    %edi
40000df5:	c3                   	ret    
40000df6:	8d 76 00             	lea    0x0(%esi),%esi
40000df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000e00 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
40000e00:	57                   	push   %edi
40000e01:	56                   	push   %esi
40000e02:	8b 44 24 0c          	mov    0xc(%esp),%eax
40000e06:	8b 74 24 10          	mov    0x10(%esp),%esi
40000e0a:	8b 4c 24 14          	mov    0x14(%esp),%ecx
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
40000e0e:	39 c6                	cmp    %eax,%esi
40000e10:	73 26                	jae    40000e38 <memmove+0x38>
40000e12:	8d 14 0e             	lea    (%esi,%ecx,1),%edx
40000e15:	39 d0                	cmp    %edx,%eax
40000e17:	73 1f                	jae    40000e38 <memmove+0x38>
		s += n;
		d += n;
40000e19:	8d 3c 08             	lea    (%eax,%ecx,1),%edi
40000e1c:	89 d6                	mov    %edx,%esi
40000e1e:	09 fe                	or     %edi,%esi
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
40000e20:	83 e6 03             	and    $0x3,%esi
40000e23:	74 33                	je     40000e58 <memmove+0x58>
			asm volatile("std; rep movsl\n"
				     :: "D" (d-4), "S" (s-4), "c" (n/4)
				     : "cc", "memory");
		else
			asm volatile("std; rep movsb\n"
				     :: "D" (d-1), "S" (s-1), "c" (n)
40000e25:	83 ef 01             	sub    $0x1,%edi
40000e28:	8d 72 ff             	lea    -0x1(%edx),%esi
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
			asm volatile("std; rep movsl\n"
				     :: "D" (d-4), "S" (s-4), "c" (n/4)
				     : "cc", "memory");
		else
			asm volatile("std; rep movsb\n"
40000e2b:	fd                   	std    
40000e2c:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
				     :: "D" (d-1), "S" (s-1), "c" (n)
				     : "cc", "memory");
		// Some versions of GCC rely on DF being clear
		asm volatile("cld" ::: "cc");
40000e2e:	fc                   	cld    
			asm volatile("cld; rep movsb\n"
				     :: "D" (d), "S" (s), "c" (n)
				     : "cc", "memory");
	}
	return dst;
}
40000e2f:	5e                   	pop    %esi
40000e30:	5f                   	pop    %edi
40000e31:	c3                   	ret    
40000e32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000e38:	89 f2                	mov    %esi,%edx
40000e3a:	09 c2                	or     %eax,%edx
				     :: "D" (d-1), "S" (s-1), "c" (n)
				     : "cc", "memory");
		// Some versions of GCC rely on DF being clear
		asm volatile("cld" ::: "cc");
	} else {
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
40000e3c:	83 e2 03             	and    $0x3,%edx
40000e3f:	75 0f                	jne    40000e50 <memmove+0x50>
40000e41:	f6 c1 03             	test   $0x3,%cl
40000e44:	75 0a                	jne    40000e50 <memmove+0x50>
			asm volatile("cld; rep movsl\n"
				     :: "D" (d), "S" (s), "c" (n/4)
40000e46:	c1 e9 02             	shr    $0x2,%ecx
				     : "cc", "memory");
		// Some versions of GCC rely on DF being clear
		asm volatile("cld" ::: "cc");
	} else {
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
			asm volatile("cld; rep movsl\n"
40000e49:	89 c7                	mov    %eax,%edi
40000e4b:	fc                   	cld    
40000e4c:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40000e4e:	eb 05                	jmp    40000e55 <memmove+0x55>
				     :: "D" (d), "S" (s), "c" (n/4)
				     : "cc", "memory");
		else
			asm volatile("cld; rep movsb\n"
40000e50:	89 c7                	mov    %eax,%edi
40000e52:	fc                   	cld    
40000e53:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
				     :: "D" (d), "S" (s), "c" (n)
				     : "cc", "memory");
	}
	return dst;
}
40000e55:	5e                   	pop    %esi
40000e56:	5f                   	pop    %edi
40000e57:	c3                   	ret    
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
40000e58:	f6 c1 03             	test   $0x3,%cl
40000e5b:	75 c8                	jne    40000e25 <memmove+0x25>
			asm volatile("std; rep movsl\n"
				     :: "D" (d-4), "S" (s-4), "c" (n/4)
40000e5d:	83 ef 04             	sub    $0x4,%edi
40000e60:	8d 72 fc             	lea    -0x4(%edx),%esi
40000e63:	c1 e9 02             	shr    $0x2,%ecx
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
			asm volatile("std; rep movsl\n"
40000e66:	fd                   	std    
40000e67:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40000e69:	eb c3                	jmp    40000e2e <memmove+0x2e>
40000e6b:	90                   	nop
40000e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000e70 <memcpy>:
}

void *
memcpy(void *dst, const void *src, size_t n)
{
	return memmove(dst, src, n);
40000e70:	e9 8b ff ff ff       	jmp    40000e00 <memmove>
40000e75:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

40000e80 <memcmp>:
}

int
memcmp(const void *v1, const void *v2, size_t n)
{
40000e80:	57                   	push   %edi
40000e81:	56                   	push   %esi
40000e82:	53                   	push   %ebx
40000e83:	8b 44 24 18          	mov    0x18(%esp),%eax
40000e87:	8b 5c 24 10          	mov    0x10(%esp),%ebx
40000e8b:	8b 74 24 14          	mov    0x14(%esp),%esi
	const uint8_t *s1 = (const uint8_t *) v1;
	const uint8_t *s2 = (const uint8_t *) v2;

	while (n-- > 0) {
40000e8f:	85 c0                	test   %eax,%eax
40000e91:	8d 78 ff             	lea    -0x1(%eax),%edi
40000e94:	74 26                	je     40000ebc <memcmp+0x3c>
		if (*s1 != *s2)
40000e96:	0f b6 03             	movzbl (%ebx),%eax
40000e99:	31 d2                	xor    %edx,%edx
40000e9b:	0f b6 0e             	movzbl (%esi),%ecx
40000e9e:	38 c8                	cmp    %cl,%al
40000ea0:	74 16                	je     40000eb8 <memcmp+0x38>
40000ea2:	eb 24                	jmp    40000ec8 <memcmp+0x48>
40000ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000ea8:	0f b6 44 13 01       	movzbl 0x1(%ebx,%edx,1),%eax
40000ead:	83 c2 01             	add    $0x1,%edx
40000eb0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
40000eb4:	38 c8                	cmp    %cl,%al
40000eb6:	75 10                	jne    40000ec8 <memcmp+0x48>
memcmp(const void *v1, const void *v2, size_t n)
{
	const uint8_t *s1 = (const uint8_t *) v1;
	const uint8_t *s2 = (const uint8_t *) v2;

	while (n-- > 0) {
40000eb8:	39 fa                	cmp    %edi,%edx
40000eba:	75 ec                	jne    40000ea8 <memcmp+0x28>
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
}
40000ebc:	5b                   	pop    %ebx
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
40000ebd:	31 c0                	xor    %eax,%eax
}
40000ebf:	5e                   	pop    %esi
40000ec0:	5f                   	pop    %edi
40000ec1:	c3                   	ret    
40000ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000ec8:	5b                   	pop    %ebx
	const uint8_t *s1 = (const uint8_t *) v1;
	const uint8_t *s2 = (const uint8_t *) v2;

	while (n-- > 0) {
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
40000ec9:	29 c8                	sub    %ecx,%eax
		s1++, s2++;
	}

	return 0;
}
40000ecb:	5e                   	pop    %esi
40000ecc:	5f                   	pop    %edi
40000ecd:	c3                   	ret    
40000ece:	66 90                	xchg   %ax,%ax

40000ed0 <memchr>:

void *
memchr(const void *s, int c, size_t n)
{
40000ed0:	53                   	push   %ebx
40000ed1:	8b 44 24 08          	mov    0x8(%esp),%eax
	const void *ends = (const char *) s + n;
40000ed5:	8b 54 24 10          	mov    0x10(%esp),%edx
	return 0;
}

void *
memchr(const void *s, int c, size_t n)
{
40000ed9:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
	const void *ends = (const char *) s + n;
40000edd:	01 c2                	add    %eax,%edx
	for (; s < ends; s++)
40000edf:	39 d0                	cmp    %edx,%eax
40000ee1:	73 18                	jae    40000efb <memchr+0x2b>
		if (*(const unsigned char *) s == (unsigned char) c)
40000ee3:	38 18                	cmp    %bl,(%eax)
40000ee5:	89 d9                	mov    %ebx,%ecx
40000ee7:	75 0b                	jne    40000ef4 <memchr+0x24>
40000ee9:	eb 12                	jmp    40000efd <memchr+0x2d>
40000eeb:	90                   	nop
40000eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000ef0:	38 08                	cmp    %cl,(%eax)
40000ef2:	74 09                	je     40000efd <memchr+0x2d>

void *
memchr(const void *s, int c, size_t n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
40000ef4:	83 c0 01             	add    $0x1,%eax
40000ef7:	39 d0                	cmp    %edx,%eax
40000ef9:	75 f5                	jne    40000ef0 <memchr+0x20>
		if (*(const unsigned char *) s == (unsigned char) c)
			return (void *) s;
	return NULL;
40000efb:	31 c0                	xor    %eax,%eax
}
40000efd:	5b                   	pop    %ebx
40000efe:	c3                   	ret    
40000eff:	90                   	nop

40000f00 <memzero>:

void *
memzero(void *v, size_t n)
{
40000f00:	83 ec 0c             	sub    $0xc,%esp
	return memset(v, 0, n);
40000f03:	8b 44 24 14          	mov    0x14(%esp),%eax
40000f07:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
40000f0e:	00 
40000f0f:	89 44 24 08          	mov    %eax,0x8(%esp)
40000f13:	8b 44 24 10          	mov    0x10(%esp),%eax
40000f17:	89 04 24             	mov    %eax,(%esp)
40000f1a:	e8 81 fe ff ff       	call   40000da0 <memset>
}
40000f1f:	83 c4 0c             	add    $0xc,%esp
40000f22:	c3                   	ret    
40000f23:	90                   	nop
40000f24:	66 90                	xchg   %ax,%ax
40000f26:	66 90                	xchg   %ax,%ax
40000f28:	66 90                	xchg   %ax,%ax
40000f2a:	66 90                	xchg   %ax,%ax
40000f2c:	66 90                	xchg   %ax,%ax
40000f2e:	66 90                	xchg   %ax,%ax

40000f30 <__udivdi3>:
40000f30:	55                   	push   %ebp
40000f31:	57                   	push   %edi
40000f32:	56                   	push   %esi
40000f33:	83 ec 0c             	sub    $0xc,%esp
40000f36:	8b 44 24 28          	mov    0x28(%esp),%eax
40000f3a:	8b 7c 24 1c          	mov    0x1c(%esp),%edi
40000f3e:	8b 6c 24 20          	mov    0x20(%esp),%ebp
40000f42:	8b 4c 24 24          	mov    0x24(%esp),%ecx
40000f46:	85 c0                	test   %eax,%eax
40000f48:	89 7c 24 04          	mov    %edi,0x4(%esp)
40000f4c:	89 ea                	mov    %ebp,%edx
40000f4e:	89 0c 24             	mov    %ecx,(%esp)
40000f51:	75 2d                	jne    40000f80 <__udivdi3+0x50>
40000f53:	39 e9                	cmp    %ebp,%ecx
40000f55:	77 61                	ja     40000fb8 <__udivdi3+0x88>
40000f57:	85 c9                	test   %ecx,%ecx
40000f59:	89 ce                	mov    %ecx,%esi
40000f5b:	75 0b                	jne    40000f68 <__udivdi3+0x38>
40000f5d:	b8 01 00 00 00       	mov    $0x1,%eax
40000f62:	31 d2                	xor    %edx,%edx
40000f64:	f7 f1                	div    %ecx
40000f66:	89 c6                	mov    %eax,%esi
40000f68:	31 d2                	xor    %edx,%edx
40000f6a:	89 e8                	mov    %ebp,%eax
40000f6c:	f7 f6                	div    %esi
40000f6e:	89 c5                	mov    %eax,%ebp
40000f70:	89 f8                	mov    %edi,%eax
40000f72:	f7 f6                	div    %esi
40000f74:	89 ea                	mov    %ebp,%edx
40000f76:	83 c4 0c             	add    $0xc,%esp
40000f79:	5e                   	pop    %esi
40000f7a:	5f                   	pop    %edi
40000f7b:	5d                   	pop    %ebp
40000f7c:	c3                   	ret    
40000f7d:	8d 76 00             	lea    0x0(%esi),%esi
40000f80:	39 e8                	cmp    %ebp,%eax
40000f82:	77 24                	ja     40000fa8 <__udivdi3+0x78>
40000f84:	0f bd e8             	bsr    %eax,%ebp
40000f87:	83 f5 1f             	xor    $0x1f,%ebp
40000f8a:	75 3c                	jne    40000fc8 <__udivdi3+0x98>
40000f8c:	8b 74 24 04          	mov    0x4(%esp),%esi
40000f90:	39 34 24             	cmp    %esi,(%esp)
40000f93:	0f 86 9f 00 00 00    	jbe    40001038 <__udivdi3+0x108>
40000f99:	39 d0                	cmp    %edx,%eax
40000f9b:	0f 82 97 00 00 00    	jb     40001038 <__udivdi3+0x108>
40000fa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000fa8:	31 d2                	xor    %edx,%edx
40000faa:	31 c0                	xor    %eax,%eax
40000fac:	83 c4 0c             	add    $0xc,%esp
40000faf:	5e                   	pop    %esi
40000fb0:	5f                   	pop    %edi
40000fb1:	5d                   	pop    %ebp
40000fb2:	c3                   	ret    
40000fb3:	90                   	nop
40000fb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000fb8:	89 f8                	mov    %edi,%eax
40000fba:	f7 f1                	div    %ecx
40000fbc:	31 d2                	xor    %edx,%edx
40000fbe:	83 c4 0c             	add    $0xc,%esp
40000fc1:	5e                   	pop    %esi
40000fc2:	5f                   	pop    %edi
40000fc3:	5d                   	pop    %ebp
40000fc4:	c3                   	ret    
40000fc5:	8d 76 00             	lea    0x0(%esi),%esi
40000fc8:	89 e9                	mov    %ebp,%ecx
40000fca:	8b 3c 24             	mov    (%esp),%edi
40000fcd:	d3 e0                	shl    %cl,%eax
40000fcf:	89 c6                	mov    %eax,%esi
40000fd1:	b8 20 00 00 00       	mov    $0x20,%eax
40000fd6:	29 e8                	sub    %ebp,%eax
40000fd8:	89 c1                	mov    %eax,%ecx
40000fda:	d3 ef                	shr    %cl,%edi
40000fdc:	89 e9                	mov    %ebp,%ecx
40000fde:	89 7c 24 08          	mov    %edi,0x8(%esp)
40000fe2:	8b 3c 24             	mov    (%esp),%edi
40000fe5:	09 74 24 08          	or     %esi,0x8(%esp)
40000fe9:	89 d6                	mov    %edx,%esi
40000feb:	d3 e7                	shl    %cl,%edi
40000fed:	89 c1                	mov    %eax,%ecx
40000fef:	89 3c 24             	mov    %edi,(%esp)
40000ff2:	8b 7c 24 04          	mov    0x4(%esp),%edi
40000ff6:	d3 ee                	shr    %cl,%esi
40000ff8:	89 e9                	mov    %ebp,%ecx
40000ffa:	d3 e2                	shl    %cl,%edx
40000ffc:	89 c1                	mov    %eax,%ecx
40000ffe:	d3 ef                	shr    %cl,%edi
40001000:	09 d7                	or     %edx,%edi
40001002:	89 f2                	mov    %esi,%edx
40001004:	89 f8                	mov    %edi,%eax
40001006:	f7 74 24 08          	divl   0x8(%esp)
4000100a:	89 d6                	mov    %edx,%esi
4000100c:	89 c7                	mov    %eax,%edi
4000100e:	f7 24 24             	mull   (%esp)
40001011:	39 d6                	cmp    %edx,%esi
40001013:	89 14 24             	mov    %edx,(%esp)
40001016:	72 30                	jb     40001048 <__udivdi3+0x118>
40001018:	8b 54 24 04          	mov    0x4(%esp),%edx
4000101c:	89 e9                	mov    %ebp,%ecx
4000101e:	d3 e2                	shl    %cl,%edx
40001020:	39 c2                	cmp    %eax,%edx
40001022:	73 05                	jae    40001029 <__udivdi3+0xf9>
40001024:	3b 34 24             	cmp    (%esp),%esi
40001027:	74 1f                	je     40001048 <__udivdi3+0x118>
40001029:	89 f8                	mov    %edi,%eax
4000102b:	31 d2                	xor    %edx,%edx
4000102d:	e9 7a ff ff ff       	jmp    40000fac <__udivdi3+0x7c>
40001032:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40001038:	31 d2                	xor    %edx,%edx
4000103a:	b8 01 00 00 00       	mov    $0x1,%eax
4000103f:	e9 68 ff ff ff       	jmp    40000fac <__udivdi3+0x7c>
40001044:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40001048:	8d 47 ff             	lea    -0x1(%edi),%eax
4000104b:	31 d2                	xor    %edx,%edx
4000104d:	83 c4 0c             	add    $0xc,%esp
40001050:	5e                   	pop    %esi
40001051:	5f                   	pop    %edi
40001052:	5d                   	pop    %ebp
40001053:	c3                   	ret    
40001054:	66 90                	xchg   %ax,%ax
40001056:	66 90                	xchg   %ax,%ax
40001058:	66 90                	xchg   %ax,%ax
4000105a:	66 90                	xchg   %ax,%ax
4000105c:	66 90                	xchg   %ax,%ax
4000105e:	66 90                	xchg   %ax,%ax

40001060 <__umoddi3>:
40001060:	55                   	push   %ebp
40001061:	57                   	push   %edi
40001062:	56                   	push   %esi
40001063:	83 ec 14             	sub    $0x14,%esp
40001066:	8b 44 24 28          	mov    0x28(%esp),%eax
4000106a:	8b 4c 24 24          	mov    0x24(%esp),%ecx
4000106e:	8b 74 24 2c          	mov    0x2c(%esp),%esi
40001072:	89 c7                	mov    %eax,%edi
40001074:	89 44 24 04          	mov    %eax,0x4(%esp)
40001078:	8b 44 24 30          	mov    0x30(%esp),%eax
4000107c:	89 4c 24 10          	mov    %ecx,0x10(%esp)
40001080:	89 34 24             	mov    %esi,(%esp)
40001083:	89 4c 24 08          	mov    %ecx,0x8(%esp)
40001087:	85 c0                	test   %eax,%eax
40001089:	89 c2                	mov    %eax,%edx
4000108b:	89 7c 24 0c          	mov    %edi,0xc(%esp)
4000108f:	75 17                	jne    400010a8 <__umoddi3+0x48>
40001091:	39 fe                	cmp    %edi,%esi
40001093:	76 4b                	jbe    400010e0 <__umoddi3+0x80>
40001095:	89 c8                	mov    %ecx,%eax
40001097:	89 fa                	mov    %edi,%edx
40001099:	f7 f6                	div    %esi
4000109b:	89 d0                	mov    %edx,%eax
4000109d:	31 d2                	xor    %edx,%edx
4000109f:	83 c4 14             	add    $0x14,%esp
400010a2:	5e                   	pop    %esi
400010a3:	5f                   	pop    %edi
400010a4:	5d                   	pop    %ebp
400010a5:	c3                   	ret    
400010a6:	66 90                	xchg   %ax,%ax
400010a8:	39 f8                	cmp    %edi,%eax
400010aa:	77 54                	ja     40001100 <__umoddi3+0xa0>
400010ac:	0f bd e8             	bsr    %eax,%ebp
400010af:	83 f5 1f             	xor    $0x1f,%ebp
400010b2:	75 5c                	jne    40001110 <__umoddi3+0xb0>
400010b4:	8b 7c 24 08          	mov    0x8(%esp),%edi
400010b8:	39 3c 24             	cmp    %edi,(%esp)
400010bb:	0f 87 e7 00 00 00    	ja     400011a8 <__umoddi3+0x148>
400010c1:	8b 7c 24 04          	mov    0x4(%esp),%edi
400010c5:	29 f1                	sub    %esi,%ecx
400010c7:	19 c7                	sbb    %eax,%edi
400010c9:	89 4c 24 08          	mov    %ecx,0x8(%esp)
400010cd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
400010d1:	8b 44 24 08          	mov    0x8(%esp),%eax
400010d5:	8b 54 24 0c          	mov    0xc(%esp),%edx
400010d9:	83 c4 14             	add    $0x14,%esp
400010dc:	5e                   	pop    %esi
400010dd:	5f                   	pop    %edi
400010de:	5d                   	pop    %ebp
400010df:	c3                   	ret    
400010e0:	85 f6                	test   %esi,%esi
400010e2:	89 f5                	mov    %esi,%ebp
400010e4:	75 0b                	jne    400010f1 <__umoddi3+0x91>
400010e6:	b8 01 00 00 00       	mov    $0x1,%eax
400010eb:	31 d2                	xor    %edx,%edx
400010ed:	f7 f6                	div    %esi
400010ef:	89 c5                	mov    %eax,%ebp
400010f1:	8b 44 24 04          	mov    0x4(%esp),%eax
400010f5:	31 d2                	xor    %edx,%edx
400010f7:	f7 f5                	div    %ebp
400010f9:	89 c8                	mov    %ecx,%eax
400010fb:	f7 f5                	div    %ebp
400010fd:	eb 9c                	jmp    4000109b <__umoddi3+0x3b>
400010ff:	90                   	nop
40001100:	89 c8                	mov    %ecx,%eax
40001102:	89 fa                	mov    %edi,%edx
40001104:	83 c4 14             	add    $0x14,%esp
40001107:	5e                   	pop    %esi
40001108:	5f                   	pop    %edi
40001109:	5d                   	pop    %ebp
4000110a:	c3                   	ret    
4000110b:	90                   	nop
4000110c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40001110:	8b 04 24             	mov    (%esp),%eax
40001113:	be 20 00 00 00       	mov    $0x20,%esi
40001118:	89 e9                	mov    %ebp,%ecx
4000111a:	29 ee                	sub    %ebp,%esi
4000111c:	d3 e2                	shl    %cl,%edx
4000111e:	89 f1                	mov    %esi,%ecx
40001120:	d3 e8                	shr    %cl,%eax
40001122:	89 e9                	mov    %ebp,%ecx
40001124:	89 44 24 04          	mov    %eax,0x4(%esp)
40001128:	8b 04 24             	mov    (%esp),%eax
4000112b:	09 54 24 04          	or     %edx,0x4(%esp)
4000112f:	89 fa                	mov    %edi,%edx
40001131:	d3 e0                	shl    %cl,%eax
40001133:	89 f1                	mov    %esi,%ecx
40001135:	89 44 24 08          	mov    %eax,0x8(%esp)
40001139:	8b 44 24 10          	mov    0x10(%esp),%eax
4000113d:	d3 ea                	shr    %cl,%edx
4000113f:	89 e9                	mov    %ebp,%ecx
40001141:	d3 e7                	shl    %cl,%edi
40001143:	89 f1                	mov    %esi,%ecx
40001145:	d3 e8                	shr    %cl,%eax
40001147:	89 e9                	mov    %ebp,%ecx
40001149:	09 f8                	or     %edi,%eax
4000114b:	8b 7c 24 10          	mov    0x10(%esp),%edi
4000114f:	f7 74 24 04          	divl   0x4(%esp)
40001153:	d3 e7                	shl    %cl,%edi
40001155:	89 7c 24 0c          	mov    %edi,0xc(%esp)
40001159:	89 d7                	mov    %edx,%edi
4000115b:	f7 64 24 08          	mull   0x8(%esp)
4000115f:	39 d7                	cmp    %edx,%edi
40001161:	89 c1                	mov    %eax,%ecx
40001163:	89 14 24             	mov    %edx,(%esp)
40001166:	72 2c                	jb     40001194 <__umoddi3+0x134>
40001168:	39 44 24 0c          	cmp    %eax,0xc(%esp)
4000116c:	72 22                	jb     40001190 <__umoddi3+0x130>
4000116e:	8b 44 24 0c          	mov    0xc(%esp),%eax
40001172:	29 c8                	sub    %ecx,%eax
40001174:	19 d7                	sbb    %edx,%edi
40001176:	89 e9                	mov    %ebp,%ecx
40001178:	89 fa                	mov    %edi,%edx
4000117a:	d3 e8                	shr    %cl,%eax
4000117c:	89 f1                	mov    %esi,%ecx
4000117e:	d3 e2                	shl    %cl,%edx
40001180:	89 e9                	mov    %ebp,%ecx
40001182:	d3 ef                	shr    %cl,%edi
40001184:	09 d0                	or     %edx,%eax
40001186:	89 fa                	mov    %edi,%edx
40001188:	83 c4 14             	add    $0x14,%esp
4000118b:	5e                   	pop    %esi
4000118c:	5f                   	pop    %edi
4000118d:	5d                   	pop    %ebp
4000118e:	c3                   	ret    
4000118f:	90                   	nop
40001190:	39 d7                	cmp    %edx,%edi
40001192:	75 da                	jne    4000116e <__umoddi3+0x10e>
40001194:	8b 14 24             	mov    (%esp),%edx
40001197:	89 c1                	mov    %eax,%ecx
40001199:	2b 4c 24 08          	sub    0x8(%esp),%ecx
4000119d:	1b 54 24 04          	sbb    0x4(%esp),%edx
400011a1:	eb cb                	jmp    4000116e <__umoddi3+0x10e>
400011a3:	90                   	nop
400011a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
400011a8:	3b 44 24 0c          	cmp    0xc(%esp),%eax
400011ac:	0f 82 0f ff ff ff    	jb     400010c1 <__umoddi3+0x61>
400011b2:	e9 1a ff ff ff       	jmp    400010d1 <__umoddi3+0x71>
