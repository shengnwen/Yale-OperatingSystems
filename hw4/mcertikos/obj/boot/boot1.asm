
obj/boot/boot1.elf:     file format elf32-i386


Disassembly of section .text:

00007e00 <start>:
	.set SMAP_SIG, 0x0534D4150	# "SMAP"

	.globl start
start:
	.code16
	cli
    7e00:	fa                   	cli    
	cld
    7e01:	fc                   	cld    

00007e02 <seta20.1>:

	/* enable A20 */
seta20.1:
	inb	$0x64, %al
    7e02:	e4 64                	in     $0x64,%al
	testb	$0x2, %al
    7e04:	a8 02                	test   $0x2,%al
	jnz	seta20.1
    7e06:	75 fa                	jne    7e02 <seta20.1>
	movb	$0xd1, %al
    7e08:	b0 d1                	mov    $0xd1,%al
	outb	%al, $0x64
    7e0a:	e6 64                	out    %al,$0x64

00007e0c <seta20.2>:
seta20.2:
	inb	$0x64, %al
    7e0c:	e4 64                	in     $0x64,%al
	testb	$0x2, %al
    7e0e:	a8 02                	test   $0x2,%al
	jnz	seta20.2
    7e10:	75 fa                	jne    7e0c <seta20.2>
	movb	$0xdf, %al
    7e12:	b0 df                	mov    $0xdf,%al
	outb	%al, $0x60
    7e14:	e6 60                	out    %al,$0x60

00007e16 <set_video_mode.2>:

	/*
	 * print starting message
	 */
set_video_mode.2:
	movw	$STARTUP_MSG, %si
    7e16:	be ab 7e e8 81       	mov    $0x81e87eab,%esi
	call	putstr
    7e1b:	00 66 31             	add    %ah,0x31(%esi)

00007e1c <e820>:

	/*
	 * detect the physical memory map
	 */
e820:
	xorl	%ebx, %ebx		# ebx must be 0 when first calling e820
    7e1c:	66 31 db             	xor    %bx,%bx
	movl	$SMAP_SIG, %edx		# edx must be 'SMAP' when calling e820
    7e1f:	66 ba 50 41          	mov    $0x4150,%dx
    7e23:	4d                   	dec    %ebp
    7e24:	53                   	push   %ebx
	movw	$(smap+4), %di		# set the address of the output buffer
    7e25:	bf 2a 7f 66 b9       	mov    $0xb9667f2a,%edi

00007e28 <e820.1>:
e820.1:
	movl	$20, %ecx		# set the size of the output buffer
    7e28:	66 b9 14 00          	mov    $0x14,%cx
    7e2c:	00 00                	add    %al,(%eax)
	movl	$0xe820, %eax		# set the BIOS service code
    7e2e:	66 b8 20 e8          	mov    $0xe820,%ax
    7e32:	00 00                	add    %al,(%eax)
	int	$0x15			# call BIOS service e820h
    7e34:	cd 15                	int    $0x15

00007e36 <e820.2>:
e820.2:
	jc	e820.fail		# error during e820h
    7e36:	72 24                	jb     7e5c <e820.fail>
	cmpl	$SMAP_SIG, %eax		# check eax, which should be 'SMAP'
    7e38:	66 3d 50 41          	cmp    $0x4150,%ax
    7e3c:	4d                   	dec    %ebp
    7e3d:	53                   	push   %ebx
	jne	e820.fail
    7e3e:	75 1c                	jne    7e5c <e820.fail>

00007e40 <e820.3>:
e820.3:
	movl	$20, -4(%di)
    7e40:	66 c7 45 fc 14 00    	movw   $0x14,-0x4(%ebp)
    7e46:	00 00                	add    %al,(%eax)
	addw	$24, %di
    7e48:	83 c7 18             	add    $0x18,%edi
	cmpl	$0x0, %ebx		# whether it's the last descriptor
    7e4b:	66 83 fb 00          	cmp    $0x0,%bx
	je	e820.4
    7e4f:	74 02                	je     7e53 <e820.4>
	jmp	e820.1
    7e51:	eb d5                	jmp    7e28 <e820.1>

00007e53 <e820.4>:
e820.4:					# zero the descriptor after the last one
	xorb	%al, %al
    7e53:	30 c0                	xor    %al,%al
	movw	$20, %cx
    7e55:	b9 14 00 f3 aa       	mov    $0xaaf30014,%ecx
	rep	stosb
	jmp	switch_prot
    7e5a:	eb 09                	jmp    7e65 <switch_prot>

00007e5c <e820.fail>:
e820.fail:
	movw	$E820_FAIL_MSG, %si
    7e5c:	be bd 7e e8 3b       	mov    $0x3be87ebd,%esi
	call	putstr
    7e61:	00 eb                	add    %ch,%bl
	jmp	spin16
    7e63:	00 f4                	add    %dh,%ah

00007e64 <spin16>:

spin16:
	hlt
    7e64:	f4                   	hlt    

00007e65 <switch_prot>:

	/*
	 * load the bootstrap GDT
	 */
switch_prot:
	lgdt	gdtdesc
    7e65:	0f 01 16             	lgdtl  (%esi)
    7e68:	20 7f 0f             	and    %bh,0xf(%edi)
	movl	%cr0, %eax
    7e6b:	20 c0                	and    %al,%al
	orl	$CR0_PE_ON, %eax
    7e6d:	66 83 c8 01          	or     $0x1,%ax
	movl	%eax, %cr0
    7e71:	0f 22 c0             	mov    %eax,%cr0
	/*
	 * switch to the protected mode
	 */
	ljmp	$PROT_MODE_CSEG, $protcseg
    7e74:	ea 79 7e 08 00 66 b8 	ljmp   $0xb866,$0x87e79

00007e79 <protcseg>:

	.code32
protcseg:
	movw	$PROT_MODE_DSEG, %ax
    7e79:	66 b8 10 00          	mov    $0x10,%ax
	movw	%ax, %ds
    7e7d:	8e d8                	mov    %eax,%ds
	movw	%ax, %es
    7e7f:	8e c0                	mov    %eax,%es
	movw	%ax, %fs
    7e81:	8e e0                	mov    %eax,%fs
	movw	%ax, %gs
    7e83:	8e e8                	mov    %eax,%gs
	movw	%ax, %ss
    7e85:	8e d0                	mov    %eax,%ss

	/*
	 * jump to the C part
	 * (dev, lba, smap)
	 */
	pushl	$smap
    7e87:	68 26 7f 00 00       	push   $0x7f26
	pushl	$BOOT0
    7e8c:	68 00 7c 00 00       	push   $0x7c00
	movl	(BOOT0-4), %eax
    7e91:	a1 fc 7b 00 00       	mov    0x7bfc,%eax
	pushl	%eax
    7e96:	50                   	push   %eax
	call	boot1main
    7e97:	e8 b1 0f 00 00       	call   8e4d <boot1main>

00007e9c <spin>:

spin:
	hlt
    7e9c:	f4                   	hlt    

00007e9d <putstr>:
/*
 * print a string (@ %si) to the screen
 */
	.globl putstr
putstr:
	pusha
    7e9d:	60                   	pusha  
	movb	$0xe, %ah
    7e9e:	b4 0e                	mov    $0xe,%ah

00007ea0 <putstr.1>:
putstr.1:
	lodsb
    7ea0:	ac                   	lods   %ds:(%esi),%al
	cmp	$0, %al
    7ea1:	3c 00                	cmp    $0x0,%al
	je	putstr.2
    7ea3:	74 04                	je     7ea9 <putstr.2>
	int	$0x10
    7ea5:	cd 10                	int    $0x10
	jmp	putstr.1
    7ea7:	eb f7                	jmp    7ea0 <putstr.1>

00007ea9 <putstr.2>:
putstr.2:
	popa
    7ea9:	61                   	popa   
	ret
    7eaa:	c3                   	ret    

00007eab <STARTUP_MSG>:
    7eab:	53                   	push   %ebx
    7eac:	74 61                	je     7f0f <gdt+0x17>
    7eae:	72 74                	jb     7f24 <gdtdesc+0x4>
    7eb0:	20 62 6f             	and    %ah,0x6f(%edx)
    7eb3:	6f                   	outsl  %ds:(%esi),(%dx)
    7eb4:	74 31                	je     7ee7 <NO_BOOTABLE_MSG+0x8>
    7eb6:	20 2e                	and    %ch,(%esi)
    7eb8:	2e                   	cs
    7eb9:	2e                   	cs
    7eba:	0d 0a 00 65 72       	or     $0x7265000a,%eax

00007ebd <E820_FAIL_MSG>:
    7ebd:	65                   	gs
    7ebe:	72 72                	jb     7f32 <smap+0xc>
    7ec0:	6f                   	outsl  %ds:(%esi),(%dx)
    7ec1:	72 20                	jb     7ee3 <NO_BOOTABLE_MSG+0x4>
    7ec3:	77 68                	ja     7f2d <smap+0x7>
    7ec5:	65 6e                	outsb  %gs:(%esi),(%dx)
    7ec7:	20 64 65 74          	and    %ah,0x74(%ebp,%eiz,2)
    7ecb:	65 63 74 69 6e       	arpl   %si,%gs:0x6e(%ecx,%ebp,2)
    7ed0:	67 20 6d 65          	and    %ch,0x65(%di)
    7ed4:	6d                   	insl   (%dx),%es:(%edi)
    7ed5:	6f                   	outsl  %ds:(%esi),(%dx)
    7ed6:	72 79                	jb     7f51 <smap+0x2b>
    7ed8:	20 6d 61             	and    %ch,0x61(%ebp)
    7edb:	70 0d                	jo     7eea <NO_BOOTABLE_MSG+0xb>
    7edd:	0a 00                	or     (%eax),%al

00007edf <NO_BOOTABLE_MSG>:
    7edf:	4e                   	dec    %esi
    7ee0:	6f                   	outsl  %ds:(%esi),(%dx)
    7ee1:	20 62 6f             	and    %ah,0x6f(%edx)
    7ee4:	6f                   	outsl  %ds:(%esi),(%dx)
    7ee5:	74 61                	je     7f48 <smap+0x22>
    7ee7:	62 6c 65 20          	bound  %ebp,0x20(%ebp,%eiz,2)
    7eeb:	70 61                	jo     7f4e <smap+0x28>
    7eed:	72 74                	jb     7f63 <smap+0x3d>
    7eef:	69 74 69 6f 6e 2e 0d 	imul   $0xa0d2e6e,0x6f(%ecx,%ebp,2),%esi
    7ef6:	0a 
    7ef7:	00 00                	add    %al,(%eax)

00007ef8 <gdt>:
    7ef8:	00 00                	add    %al,(%eax)
    7efa:	00 00                	add    %al,(%eax)
    7efc:	00 00                	add    %al,(%eax)
    7efe:	00 00                	add    %al,(%eax)
    7f00:	ff                   	(bad)  
    7f01:	ff 00                	incl   (%eax)
    7f03:	00 00                	add    %al,(%eax)
    7f05:	9a cf 00 ff ff 00 00 	lcall  $0x0,$0xffff00cf
    7f0c:	00 92 cf 00 ff ff    	add    %dl,-0xff31(%edx)
    7f12:	00 00                	add    %al,(%eax)
    7f14:	00 9e 00 00 ff ff    	add    %bl,-0x10000(%esi)
    7f1a:	00 00                	add    %al,(%eax)
    7f1c:	00 92 00 00 27 00    	add    %dl,0x270000(%edx)

00007f20 <gdtdesc>:
    7f20:	27                   	daa    
    7f21:	00 f8                	add    %bh,%al
    7f23:	7e 00                	jle    7f25 <gdtdesc+0x5>
    7f25:	00 00                	add    %al,(%eax)

00007f26 <smap>:
    7f26:	00 00                	add    %al,(%eax)
    7f28:	00 00                	add    %al,(%eax)
    7f2a:	00 00                	add    %al,(%eax)
    7f2c:	00 00                	add    %al,(%eax)
    7f2e:	00 00                	add    %al,(%eax)
    7f30:	00 00                	add    %al,(%eax)
    7f32:	00 00                	add    %al,(%eax)
    7f34:	00 00                	add    %al,(%eax)
    7f36:	00 00                	add    %al,(%eax)
    7f38:	00 00                	add    %al,(%eax)
    7f3a:	00 00                	add    %al,(%eax)
    7f3c:	00 00                	add    %al,(%eax)
    7f3e:	00 00                	add    %al,(%eax)
    7f40:	00 00                	add    %al,(%eax)
    7f42:	00 00                	add    %al,(%eax)
    7f44:	00 00                	add    %al,(%eax)
    7f46:	00 00                	add    %al,(%eax)
    7f48:	00 00                	add    %al,(%eax)
    7f4a:	00 00                	add    %al,(%eax)
    7f4c:	00 00                	add    %al,(%eax)
    7f4e:	00 00                	add    %al,(%eax)
    7f50:	00 00                	add    %al,(%eax)
    7f52:	00 00                	add    %al,(%eax)
    7f54:	00 00                	add    %al,(%eax)
    7f56:	00 00                	add    %al,(%eax)
    7f58:	00 00                	add    %al,(%eax)
    7f5a:	00 00                	add    %al,(%eax)
    7f5c:	00 00                	add    %al,(%eax)
    7f5e:	00 00                	add    %al,(%eax)
    7f60:	00 00                	add    %al,(%eax)
    7f62:	00 00                	add    %al,(%eax)
    7f64:	00 00                	add    %al,(%eax)
    7f66:	00 00                	add    %al,(%eax)
    7f68:	00 00                	add    %al,(%eax)
    7f6a:	00 00                	add    %al,(%eax)
    7f6c:	00 00                	add    %al,(%eax)
    7f6e:	00 00                	add    %al,(%eax)
    7f70:	00 00                	add    %al,(%eax)
    7f72:	00 00                	add    %al,(%eax)
    7f74:	00 00                	add    %al,(%eax)
    7f76:	00 00                	add    %al,(%eax)
    7f78:	00 00                	add    %al,(%eax)
    7f7a:	00 00                	add    %al,(%eax)
    7f7c:	00 00                	add    %al,(%eax)
    7f7e:	00 00                	add    %al,(%eax)
    7f80:	00 00                	add    %al,(%eax)
    7f82:	00 00                	add    %al,(%eax)
    7f84:	00 00                	add    %al,(%eax)
    7f86:	00 00                	add    %al,(%eax)
    7f88:	00 00                	add    %al,(%eax)
    7f8a:	00 00                	add    %al,(%eax)
    7f8c:	00 00                	add    %al,(%eax)
    7f8e:	00 00                	add    %al,(%eax)
    7f90:	00 00                	add    %al,(%eax)
    7f92:	00 00                	add    %al,(%eax)
    7f94:	00 00                	add    %al,(%eax)
    7f96:	00 00                	add    %al,(%eax)
    7f98:	00 00                	add    %al,(%eax)
    7f9a:	00 00                	add    %al,(%eax)
    7f9c:	00 00                	add    %al,(%eax)
    7f9e:	00 00                	add    %al,(%eax)
    7fa0:	00 00                	add    %al,(%eax)
    7fa2:	00 00                	add    %al,(%eax)
    7fa4:	00 00                	add    %al,(%eax)
    7fa6:	00 00                	add    %al,(%eax)
    7fa8:	00 00                	add    %al,(%eax)
    7faa:	00 00                	add    %al,(%eax)
    7fac:	00 00                	add    %al,(%eax)
    7fae:	00 00                	add    %al,(%eax)
    7fb0:	00 00                	add    %al,(%eax)
    7fb2:	00 00                	add    %al,(%eax)
    7fb4:	00 00                	add    %al,(%eax)
    7fb6:	00 00                	add    %al,(%eax)
    7fb8:	00 00                	add    %al,(%eax)
    7fba:	00 00                	add    %al,(%eax)
    7fbc:	00 00                	add    %al,(%eax)
    7fbe:	00 00                	add    %al,(%eax)
    7fc0:	00 00                	add    %al,(%eax)
    7fc2:	00 00                	add    %al,(%eax)
    7fc4:	00 00                	add    %al,(%eax)
    7fc6:	00 00                	add    %al,(%eax)
    7fc8:	00 00                	add    %al,(%eax)
    7fca:	00 00                	add    %al,(%eax)
    7fcc:	00 00                	add    %al,(%eax)
    7fce:	00 00                	add    %al,(%eax)
    7fd0:	00 00                	add    %al,(%eax)
    7fd2:	00 00                	add    %al,(%eax)
    7fd4:	00 00                	add    %al,(%eax)
    7fd6:	00 00                	add    %al,(%eax)
    7fd8:	00 00                	add    %al,(%eax)
    7fda:	00 00                	add    %al,(%eax)
    7fdc:	00 00                	add    %al,(%eax)
    7fde:	00 00                	add    %al,(%eax)
    7fe0:	00 00                	add    %al,(%eax)
    7fe2:	00 00                	add    %al,(%eax)
    7fe4:	00 00                	add    %al,(%eax)
    7fe6:	00 00                	add    %al,(%eax)
    7fe8:	00 00                	add    %al,(%eax)
    7fea:	00 00                	add    %al,(%eax)
    7fec:	00 00                	add    %al,(%eax)
    7fee:	00 00                	add    %al,(%eax)
    7ff0:	00 00                	add    %al,(%eax)
    7ff2:	00 00                	add    %al,(%eax)
    7ff4:	00 00                	add    %al,(%eax)
    7ff6:	00 00                	add    %al,(%eax)
    7ff8:	00 00                	add    %al,(%eax)
    7ffa:	00 00                	add    %al,(%eax)
    7ffc:	00 00                	add    %al,(%eax)
    7ffe:	00 00                	add    %al,(%eax)
    8000:	00 00                	add    %al,(%eax)
    8002:	00 00                	add    %al,(%eax)
    8004:	00 00                	add    %al,(%eax)
    8006:	00 00                	add    %al,(%eax)
    8008:	00 00                	add    %al,(%eax)
    800a:	00 00                	add    %al,(%eax)
    800c:	00 00                	add    %al,(%eax)
    800e:	00 00                	add    %al,(%eax)
    8010:	00 00                	add    %al,(%eax)
    8012:	00 00                	add    %al,(%eax)
    8014:	00 00                	add    %al,(%eax)
    8016:	00 00                	add    %al,(%eax)
    8018:	00 00                	add    %al,(%eax)
    801a:	00 00                	add    %al,(%eax)
    801c:	00 00                	add    %al,(%eax)
    801e:	00 00                	add    %al,(%eax)
    8020:	00 00                	add    %al,(%eax)
    8022:	00 00                	add    %al,(%eax)
    8024:	00 00                	add    %al,(%eax)
    8026:	00 00                	add    %al,(%eax)
    8028:	00 00                	add    %al,(%eax)
    802a:	00 00                	add    %al,(%eax)
    802c:	00 00                	add    %al,(%eax)
    802e:	00 00                	add    %al,(%eax)
    8030:	00 00                	add    %al,(%eax)
    8032:	00 00                	add    %al,(%eax)
    8034:	00 00                	add    %al,(%eax)
    8036:	00 00                	add    %al,(%eax)
    8038:	00 00                	add    %al,(%eax)
    803a:	00 00                	add    %al,(%eax)
    803c:	00 00                	add    %al,(%eax)
    803e:	00 00                	add    %al,(%eax)
    8040:	00 00                	add    %al,(%eax)
    8042:	00 00                	add    %al,(%eax)
    8044:	00 00                	add    %al,(%eax)
    8046:	00 00                	add    %al,(%eax)
    8048:	00 00                	add    %al,(%eax)
    804a:	00 00                	add    %al,(%eax)
    804c:	00 00                	add    %al,(%eax)
    804e:	00 00                	add    %al,(%eax)
    8050:	00 00                	add    %al,(%eax)
    8052:	00 00                	add    %al,(%eax)
    8054:	00 00                	add    %al,(%eax)
    8056:	00 00                	add    %al,(%eax)
    8058:	00 00                	add    %al,(%eax)
    805a:	00 00                	add    %al,(%eax)
    805c:	00 00                	add    %al,(%eax)
    805e:	00 00                	add    %al,(%eax)
    8060:	00 00                	add    %al,(%eax)
    8062:	00 00                	add    %al,(%eax)
    8064:	00 00                	add    %al,(%eax)
    8066:	00 00                	add    %al,(%eax)
    8068:	00 00                	add    %al,(%eax)
    806a:	00 00                	add    %al,(%eax)
    806c:	00 00                	add    %al,(%eax)
    806e:	00 00                	add    %al,(%eax)
    8070:	00 00                	add    %al,(%eax)
    8072:	00 00                	add    %al,(%eax)
    8074:	00 00                	add    %al,(%eax)
    8076:	00 00                	add    %al,(%eax)
    8078:	00 00                	add    %al,(%eax)
    807a:	00 00                	add    %al,(%eax)
    807c:	00 00                	add    %al,(%eax)
    807e:	00 00                	add    %al,(%eax)
    8080:	00 00                	add    %al,(%eax)
    8082:	00 00                	add    %al,(%eax)
    8084:	00 00                	add    %al,(%eax)
    8086:	00 00                	add    %al,(%eax)
    8088:	00 00                	add    %al,(%eax)
    808a:	00 00                	add    %al,(%eax)
    808c:	00 00                	add    %al,(%eax)
    808e:	00 00                	add    %al,(%eax)
    8090:	00 00                	add    %al,(%eax)
    8092:	00 00                	add    %al,(%eax)
    8094:	00 00                	add    %al,(%eax)
    8096:	00 00                	add    %al,(%eax)
    8098:	00 00                	add    %al,(%eax)
    809a:	00 00                	add    %al,(%eax)
    809c:	00 00                	add    %al,(%eax)
    809e:	00 00                	add    %al,(%eax)
    80a0:	00 00                	add    %al,(%eax)
    80a2:	00 00                	add    %al,(%eax)
    80a4:	00 00                	add    %al,(%eax)
    80a6:	00 00                	add    %al,(%eax)
    80a8:	00 00                	add    %al,(%eax)
    80aa:	00 00                	add    %al,(%eax)
    80ac:	00 00                	add    %al,(%eax)
    80ae:	00 00                	add    %al,(%eax)
    80b0:	00 00                	add    %al,(%eax)
    80b2:	00 00                	add    %al,(%eax)
    80b4:	00 00                	add    %al,(%eax)
    80b6:	00 00                	add    %al,(%eax)
    80b8:	00 00                	add    %al,(%eax)
    80ba:	00 00                	add    %al,(%eax)
    80bc:	00 00                	add    %al,(%eax)
    80be:	00 00                	add    %al,(%eax)
    80c0:	00 00                	add    %al,(%eax)
    80c2:	00 00                	add    %al,(%eax)
    80c4:	00 00                	add    %al,(%eax)
    80c6:	00 00                	add    %al,(%eax)
    80c8:	00 00                	add    %al,(%eax)
    80ca:	00 00                	add    %al,(%eax)
    80cc:	00 00                	add    %al,(%eax)
    80ce:	00 00                	add    %al,(%eax)
    80d0:	00 00                	add    %al,(%eax)
    80d2:	00 00                	add    %al,(%eax)
    80d4:	00 00                	add    %al,(%eax)
    80d6:	00 00                	add    %al,(%eax)
    80d8:	00 00                	add    %al,(%eax)
    80da:	00 00                	add    %al,(%eax)
    80dc:	00 00                	add    %al,(%eax)
    80de:	00 00                	add    %al,(%eax)
    80e0:	00 00                	add    %al,(%eax)
    80e2:	00 00                	add    %al,(%eax)
    80e4:	00 00                	add    %al,(%eax)
    80e6:	00 00                	add    %al,(%eax)
    80e8:	00 00                	add    %al,(%eax)
    80ea:	00 00                	add    %al,(%eax)
    80ec:	00 00                	add    %al,(%eax)
    80ee:	00 00                	add    %al,(%eax)
    80f0:	00 00                	add    %al,(%eax)
    80f2:	00 00                	add    %al,(%eax)
    80f4:	00 00                	add    %al,(%eax)
    80f6:	00 00                	add    %al,(%eax)
    80f8:	00 00                	add    %al,(%eax)
    80fa:	00 00                	add    %al,(%eax)
    80fc:	00 00                	add    %al,(%eax)
    80fe:	00 00                	add    %al,(%eax)
    8100:	00 00                	add    %al,(%eax)
    8102:	00 00                	add    %al,(%eax)
    8104:	00 00                	add    %al,(%eax)
    8106:	00 00                	add    %al,(%eax)
    8108:	00 00                	add    %al,(%eax)
    810a:	00 00                	add    %al,(%eax)
    810c:	00 00                	add    %al,(%eax)
    810e:	00 00                	add    %al,(%eax)
    8110:	00 00                	add    %al,(%eax)
    8112:	00 00                	add    %al,(%eax)
    8114:	00 00                	add    %al,(%eax)
    8116:	00 00                	add    %al,(%eax)
    8118:	00 00                	add    %al,(%eax)
    811a:	00 00                	add    %al,(%eax)
    811c:	00 00                	add    %al,(%eax)
    811e:	00 00                	add    %al,(%eax)
    8120:	00 00                	add    %al,(%eax)
    8122:	00 00                	add    %al,(%eax)
    8124:	00 00                	add    %al,(%eax)
    8126:	00 00                	add    %al,(%eax)
    8128:	00 00                	add    %al,(%eax)
    812a:	00 00                	add    %al,(%eax)
    812c:	00 00                	add    %al,(%eax)
    812e:	00 00                	add    %al,(%eax)
    8130:	00 00                	add    %al,(%eax)
    8132:	00 00                	add    %al,(%eax)
    8134:	00 00                	add    %al,(%eax)
    8136:	00 00                	add    %al,(%eax)
    8138:	00 00                	add    %al,(%eax)
    813a:	00 00                	add    %al,(%eax)
    813c:	00 00                	add    %al,(%eax)
    813e:	00 00                	add    %al,(%eax)
    8140:	00 00                	add    %al,(%eax)
    8142:	00 00                	add    %al,(%eax)
    8144:	00 00                	add    %al,(%eax)
    8146:	00 00                	add    %al,(%eax)
    8148:	00 00                	add    %al,(%eax)
    814a:	00 00                	add    %al,(%eax)
    814c:	00 00                	add    %al,(%eax)
    814e:	00 00                	add    %al,(%eax)
    8150:	00 00                	add    %al,(%eax)
    8152:	00 00                	add    %al,(%eax)
    8154:	00 00                	add    %al,(%eax)
    8156:	00 00                	add    %al,(%eax)
    8158:	00 00                	add    %al,(%eax)
    815a:	00 00                	add    %al,(%eax)
    815c:	00 00                	add    %al,(%eax)
    815e:	00 00                	add    %al,(%eax)
    8160:	00 00                	add    %al,(%eax)
    8162:	00 00                	add    %al,(%eax)
    8164:	00 00                	add    %al,(%eax)
    8166:	00 00                	add    %al,(%eax)
    8168:	00 00                	add    %al,(%eax)
    816a:	00 00                	add    %al,(%eax)
    816c:	00 00                	add    %al,(%eax)
    816e:	00 00                	add    %al,(%eax)
    8170:	00 00                	add    %al,(%eax)
    8172:	00 00                	add    %al,(%eax)
    8174:	00 00                	add    %al,(%eax)
    8176:	00 00                	add    %al,(%eax)
    8178:	00 00                	add    %al,(%eax)
    817a:	00 00                	add    %al,(%eax)
    817c:	00 00                	add    %al,(%eax)
    817e:	00 00                	add    %al,(%eax)
    8180:	00 00                	add    %al,(%eax)
    8182:	00 00                	add    %al,(%eax)
    8184:	00 00                	add    %al,(%eax)
    8186:	00 00                	add    %al,(%eax)
    8188:	00 00                	add    %al,(%eax)
    818a:	00 00                	add    %al,(%eax)
    818c:	00 00                	add    %al,(%eax)
    818e:	00 00                	add    %al,(%eax)
    8190:	00 00                	add    %al,(%eax)
    8192:	00 00                	add    %al,(%eax)
    8194:	00 00                	add    %al,(%eax)
    8196:	00 00                	add    %al,(%eax)
    8198:	00 00                	add    %al,(%eax)
    819a:	00 00                	add    %al,(%eax)
    819c:	00 00                	add    %al,(%eax)
    819e:	00 00                	add    %al,(%eax)
    81a0:	00 00                	add    %al,(%eax)
    81a2:	00 00                	add    %al,(%eax)
    81a4:	00 00                	add    %al,(%eax)
    81a6:	00 00                	add    %al,(%eax)
    81a8:	00 00                	add    %al,(%eax)
    81aa:	00 00                	add    %al,(%eax)
    81ac:	00 00                	add    %al,(%eax)
    81ae:	00 00                	add    %al,(%eax)
    81b0:	00 00                	add    %al,(%eax)
    81b2:	00 00                	add    %al,(%eax)
    81b4:	00 00                	add    %al,(%eax)
    81b6:	00 00                	add    %al,(%eax)
    81b8:	00 00                	add    %al,(%eax)
    81ba:	00 00                	add    %al,(%eax)
    81bc:	00 00                	add    %al,(%eax)
    81be:	00 00                	add    %al,(%eax)
    81c0:	00 00                	add    %al,(%eax)
    81c2:	00 00                	add    %al,(%eax)
    81c4:	00 00                	add    %al,(%eax)
    81c6:	00 00                	add    %al,(%eax)
    81c8:	00 00                	add    %al,(%eax)
    81ca:	00 00                	add    %al,(%eax)
    81cc:	00 00                	add    %al,(%eax)
    81ce:	00 00                	add    %al,(%eax)
    81d0:	00 00                	add    %al,(%eax)
    81d2:	00 00                	add    %al,(%eax)
    81d4:	00 00                	add    %al,(%eax)
    81d6:	00 00                	add    %al,(%eax)
    81d8:	00 00                	add    %al,(%eax)
    81da:	00 00                	add    %al,(%eax)
    81dc:	00 00                	add    %al,(%eax)
    81de:	00 00                	add    %al,(%eax)
    81e0:	00 00                	add    %al,(%eax)
    81e2:	00 00                	add    %al,(%eax)
    81e4:	00 00                	add    %al,(%eax)
    81e6:	00 00                	add    %al,(%eax)
    81e8:	00 00                	add    %al,(%eax)
    81ea:	00 00                	add    %al,(%eax)
    81ec:	00 00                	add    %al,(%eax)
    81ee:	00 00                	add    %al,(%eax)
    81f0:	00 00                	add    %al,(%eax)
    81f2:	00 00                	add    %al,(%eax)
    81f4:	00 00                	add    %al,(%eax)
    81f6:	00 00                	add    %al,(%eax)
    81f8:	00 00                	add    %al,(%eax)
    81fa:	00 00                	add    %al,(%eax)
    81fc:	00 00                	add    %al,(%eax)
    81fe:	00 00                	add    %al,(%eax)
    8200:	00 00                	add    %al,(%eax)
    8202:	00 00                	add    %al,(%eax)
    8204:	00 00                	add    %al,(%eax)
    8206:	00 00                	add    %al,(%eax)
    8208:	00 00                	add    %al,(%eax)
    820a:	00 00                	add    %al,(%eax)
    820c:	00 00                	add    %al,(%eax)
    820e:	00 00                	add    %al,(%eax)
    8210:	00 00                	add    %al,(%eax)
    8212:	00 00                	add    %al,(%eax)
    8214:	00 00                	add    %al,(%eax)
    8216:	00 00                	add    %al,(%eax)
    8218:	00 00                	add    %al,(%eax)
    821a:	00 00                	add    %al,(%eax)
    821c:	00 00                	add    %al,(%eax)
    821e:	00 00                	add    %al,(%eax)
    8220:	00 00                	add    %al,(%eax)
    8222:	00 00                	add    %al,(%eax)
    8224:	00 00                	add    %al,(%eax)
    8226:	00 00                	add    %al,(%eax)
    8228:	00 00                	add    %al,(%eax)
    822a:	00 00                	add    %al,(%eax)
    822c:	00 00                	add    %al,(%eax)
    822e:	00 00                	add    %al,(%eax)
    8230:	00 00                	add    %al,(%eax)
    8232:	00 00                	add    %al,(%eax)
    8234:	00 00                	add    %al,(%eax)
    8236:	00 00                	add    %al,(%eax)
    8238:	00 00                	add    %al,(%eax)
    823a:	00 00                	add    %al,(%eax)
    823c:	00 00                	add    %al,(%eax)
    823e:	00 00                	add    %al,(%eax)
    8240:	00 00                	add    %al,(%eax)
    8242:	00 00                	add    %al,(%eax)
    8244:	00 00                	add    %al,(%eax)
    8246:	00 00                	add    %al,(%eax)
    8248:	00 00                	add    %al,(%eax)
    824a:	00 00                	add    %al,(%eax)
    824c:	00 00                	add    %al,(%eax)
    824e:	00 00                	add    %al,(%eax)
    8250:	00 00                	add    %al,(%eax)
    8252:	00 00                	add    %al,(%eax)
    8254:	00 00                	add    %al,(%eax)
    8256:	00 00                	add    %al,(%eax)
    8258:	00 00                	add    %al,(%eax)
    825a:	00 00                	add    %al,(%eax)
    825c:	00 00                	add    %al,(%eax)
    825e:	00 00                	add    %al,(%eax)
    8260:	00 00                	add    %al,(%eax)
    8262:	00 00                	add    %al,(%eax)
    8264:	00 00                	add    %al,(%eax)
    8266:	00 00                	add    %al,(%eax)
    8268:	00 00                	add    %al,(%eax)
    826a:	00 00                	add    %al,(%eax)
    826c:	00 00                	add    %al,(%eax)
    826e:	00 00                	add    %al,(%eax)
    8270:	00 00                	add    %al,(%eax)
    8272:	00 00                	add    %al,(%eax)
    8274:	00 00                	add    %al,(%eax)
    8276:	00 00                	add    %al,(%eax)
    8278:	00 00                	add    %al,(%eax)
    827a:	00 00                	add    %al,(%eax)
    827c:	00 00                	add    %al,(%eax)
    827e:	00 00                	add    %al,(%eax)
    8280:	00 00                	add    %al,(%eax)
    8282:	00 00                	add    %al,(%eax)
    8284:	00 00                	add    %al,(%eax)
    8286:	00 00                	add    %al,(%eax)
    8288:	00 00                	add    %al,(%eax)
    828a:	00 00                	add    %al,(%eax)
    828c:	00 00                	add    %al,(%eax)
    828e:	00 00                	add    %al,(%eax)
    8290:	00 00                	add    %al,(%eax)
    8292:	00 00                	add    %al,(%eax)
    8294:	00 00                	add    %al,(%eax)
    8296:	00 00                	add    %al,(%eax)
    8298:	00 00                	add    %al,(%eax)
    829a:	00 00                	add    %al,(%eax)
    829c:	00 00                	add    %al,(%eax)
    829e:	00 00                	add    %al,(%eax)
    82a0:	00 00                	add    %al,(%eax)
    82a2:	00 00                	add    %al,(%eax)
    82a4:	00 00                	add    %al,(%eax)
    82a6:	00 00                	add    %al,(%eax)
    82a8:	00 00                	add    %al,(%eax)
    82aa:	00 00                	add    %al,(%eax)
    82ac:	00 00                	add    %al,(%eax)
    82ae:	00 00                	add    %al,(%eax)
    82b0:	00 00                	add    %al,(%eax)
    82b2:	00 00                	add    %al,(%eax)
    82b4:	00 00                	add    %al,(%eax)
    82b6:	00 00                	add    %al,(%eax)
    82b8:	00 00                	add    %al,(%eax)
    82ba:	00 00                	add    %al,(%eax)
    82bc:	00 00                	add    %al,(%eax)
    82be:	00 00                	add    %al,(%eax)
    82c0:	00 00                	add    %al,(%eax)
    82c2:	00 00                	add    %al,(%eax)
    82c4:	00 00                	add    %al,(%eax)
    82c6:	00 00                	add    %al,(%eax)
    82c8:	00 00                	add    %al,(%eax)
    82ca:	00 00                	add    %al,(%eax)
    82cc:	00 00                	add    %al,(%eax)
    82ce:	00 00                	add    %al,(%eax)
    82d0:	00 00                	add    %al,(%eax)
    82d2:	00 00                	add    %al,(%eax)
    82d4:	00 00                	add    %al,(%eax)
    82d6:	00 00                	add    %al,(%eax)
    82d8:	00 00                	add    %al,(%eax)
    82da:	00 00                	add    %al,(%eax)
    82dc:	00 00                	add    %al,(%eax)
    82de:	00 00                	add    %al,(%eax)
    82e0:	00 00                	add    %al,(%eax)
    82e2:	00 00                	add    %al,(%eax)
    82e4:	00 00                	add    %al,(%eax)
    82e6:	00 00                	add    %al,(%eax)
    82e8:	00 00                	add    %al,(%eax)
    82ea:	00 00                	add    %al,(%eax)
    82ec:	00 00                	add    %al,(%eax)
    82ee:	00 00                	add    %al,(%eax)
    82f0:	00 00                	add    %al,(%eax)
    82f2:	00 00                	add    %al,(%eax)
    82f4:	00 00                	add    %al,(%eax)
    82f6:	00 00                	add    %al,(%eax)
    82f8:	00 00                	add    %al,(%eax)
    82fa:	00 00                	add    %al,(%eax)
    82fc:	00 00                	add    %al,(%eax)
    82fe:	00 00                	add    %al,(%eax)
    8300:	00 00                	add    %al,(%eax)
    8302:	00 00                	add    %al,(%eax)
    8304:	00 00                	add    %al,(%eax)
    8306:	00 00                	add    %al,(%eax)
    8308:	00 00                	add    %al,(%eax)
    830a:	00 00                	add    %al,(%eax)
    830c:	00 00                	add    %al,(%eax)
    830e:	00 00                	add    %al,(%eax)
    8310:	00 00                	add    %al,(%eax)
    8312:	00 00                	add    %al,(%eax)
    8314:	00 00                	add    %al,(%eax)
    8316:	00 00                	add    %al,(%eax)
    8318:	00 00                	add    %al,(%eax)
    831a:	00 00                	add    %al,(%eax)
    831c:	00 00                	add    %al,(%eax)
    831e:	00 00                	add    %al,(%eax)
    8320:	00 00                	add    %al,(%eax)
    8322:	00 00                	add    %al,(%eax)
    8324:	00 00                	add    %al,(%eax)
    8326:	00 00                	add    %al,(%eax)
    8328:	00 00                	add    %al,(%eax)
    832a:	00 00                	add    %al,(%eax)
    832c:	00 00                	add    %al,(%eax)
    832e:	00 00                	add    %al,(%eax)
    8330:	00 00                	add    %al,(%eax)
    8332:	00 00                	add    %al,(%eax)
    8334:	00 00                	add    %al,(%eax)
    8336:	00 00                	add    %al,(%eax)
    8338:	00 00                	add    %al,(%eax)
    833a:	00 00                	add    %al,(%eax)
    833c:	00 00                	add    %al,(%eax)
    833e:	00 00                	add    %al,(%eax)
    8340:	00 00                	add    %al,(%eax)
    8342:	00 00                	add    %al,(%eax)
    8344:	00 00                	add    %al,(%eax)
    8346:	00 00                	add    %al,(%eax)
    8348:	00 00                	add    %al,(%eax)
    834a:	00 00                	add    %al,(%eax)
    834c:	00 00                	add    %al,(%eax)
    834e:	00 00                	add    %al,(%eax)
    8350:	00 00                	add    %al,(%eax)
    8352:	00 00                	add    %al,(%eax)
    8354:	00 00                	add    %al,(%eax)
    8356:	00 00                	add    %al,(%eax)
    8358:	00 00                	add    %al,(%eax)
    835a:	00 00                	add    %al,(%eax)
    835c:	00 00                	add    %al,(%eax)
    835e:	00 00                	add    %al,(%eax)
    8360:	00 00                	add    %al,(%eax)
    8362:	00 00                	add    %al,(%eax)
    8364:	00 00                	add    %al,(%eax)
    8366:	00 00                	add    %al,(%eax)
    8368:	00 00                	add    %al,(%eax)
    836a:	00 00                	add    %al,(%eax)
    836c:	00 00                	add    %al,(%eax)
    836e:	00 00                	add    %al,(%eax)
    8370:	00 00                	add    %al,(%eax)
    8372:	00 00                	add    %al,(%eax)
    8374:	00 00                	add    %al,(%eax)
    8376:	00 00                	add    %al,(%eax)
    8378:	00 00                	add    %al,(%eax)
    837a:	00 00                	add    %al,(%eax)
    837c:	00 00                	add    %al,(%eax)
    837e:	00 00                	add    %al,(%eax)
    8380:	00 00                	add    %al,(%eax)
    8382:	00 00                	add    %al,(%eax)
    8384:	00 00                	add    %al,(%eax)
    8386:	00 00                	add    %al,(%eax)
    8388:	00 00                	add    %al,(%eax)
    838a:	00 00                	add    %al,(%eax)
    838c:	00 00                	add    %al,(%eax)
    838e:	00 00                	add    %al,(%eax)
    8390:	00 00                	add    %al,(%eax)
    8392:	00 00                	add    %al,(%eax)
    8394:	00 00                	add    %al,(%eax)
    8396:	00 00                	add    %al,(%eax)
    8398:	00 00                	add    %al,(%eax)
    839a:	00 00                	add    %al,(%eax)
    839c:	00 00                	add    %al,(%eax)
    839e:	00 00                	add    %al,(%eax)
    83a0:	00 00                	add    %al,(%eax)
    83a2:	00 00                	add    %al,(%eax)
    83a4:	00 00                	add    %al,(%eax)
    83a6:	00 00                	add    %al,(%eax)
    83a8:	00 00                	add    %al,(%eax)
    83aa:	00 00                	add    %al,(%eax)
    83ac:	00 00                	add    %al,(%eax)
    83ae:	00 00                	add    %al,(%eax)
    83b0:	00 00                	add    %al,(%eax)
    83b2:	00 00                	add    %al,(%eax)
    83b4:	00 00                	add    %al,(%eax)
    83b6:	00 00                	add    %al,(%eax)
    83b8:	00 00                	add    %al,(%eax)
    83ba:	00 00                	add    %al,(%eax)
    83bc:	00 00                	add    %al,(%eax)
    83be:	00 00                	add    %al,(%eax)
    83c0:	00 00                	add    %al,(%eax)
    83c2:	00 00                	add    %al,(%eax)
    83c4:	00 00                	add    %al,(%eax)
    83c6:	00 00                	add    %al,(%eax)
    83c8:	00 00                	add    %al,(%eax)
    83ca:	00 00                	add    %al,(%eax)
    83cc:	00 00                	add    %al,(%eax)
    83ce:	00 00                	add    %al,(%eax)
    83d0:	00 00                	add    %al,(%eax)
    83d2:	00 00                	add    %al,(%eax)
    83d4:	00 00                	add    %al,(%eax)
    83d6:	00 00                	add    %al,(%eax)
    83d8:	00 00                	add    %al,(%eax)
    83da:	00 00                	add    %al,(%eax)
    83dc:	00 00                	add    %al,(%eax)
    83de:	00 00                	add    %al,(%eax)
    83e0:	00 00                	add    %al,(%eax)
    83e2:	00 00                	add    %al,(%eax)
    83e4:	00 00                	add    %al,(%eax)
    83e6:	00 00                	add    %al,(%eax)
    83e8:	00 00                	add    %al,(%eax)
    83ea:	00 00                	add    %al,(%eax)
    83ec:	00 00                	add    %al,(%eax)
    83ee:	00 00                	add    %al,(%eax)
    83f0:	00 00                	add    %al,(%eax)
    83f2:	00 00                	add    %al,(%eax)
    83f4:	00 00                	add    %al,(%eax)
    83f6:	00 00                	add    %al,(%eax)
    83f8:	00 00                	add    %al,(%eax)
    83fa:	00 00                	add    %al,(%eax)
    83fc:	00 00                	add    %al,(%eax)
    83fe:	00 00                	add    %al,(%eax)
    8400:	00 00                	add    %al,(%eax)
    8402:	00 00                	add    %al,(%eax)
    8404:	00 00                	add    %al,(%eax)
    8406:	00 00                	add    %al,(%eax)
    8408:	00 00                	add    %al,(%eax)
    840a:	00 00                	add    %al,(%eax)
    840c:	00 00                	add    %al,(%eax)
    840e:	00 00                	add    %al,(%eax)
    8410:	00 00                	add    %al,(%eax)
    8412:	00 00                	add    %al,(%eax)
    8414:	00 00                	add    %al,(%eax)
    8416:	00 00                	add    %al,(%eax)
    8418:	00 00                	add    %al,(%eax)
    841a:	00 00                	add    %al,(%eax)
    841c:	00 00                	add    %al,(%eax)
    841e:	00 00                	add    %al,(%eax)
    8420:	00 00                	add    %al,(%eax)
    8422:	00 00                	add    %al,(%eax)
    8424:	00 00                	add    %al,(%eax)
    8426:	00 00                	add    %al,(%eax)
    8428:	00 00                	add    %al,(%eax)
    842a:	00 00                	add    %al,(%eax)
    842c:	00 00                	add    %al,(%eax)
    842e:	00 00                	add    %al,(%eax)
    8430:	00 00                	add    %al,(%eax)
    8432:	00 00                	add    %al,(%eax)
    8434:	00 00                	add    %al,(%eax)
    8436:	00 00                	add    %al,(%eax)
    8438:	00 00                	add    %al,(%eax)
    843a:	00 00                	add    %al,(%eax)
    843c:	00 00                	add    %al,(%eax)
    843e:	00 00                	add    %al,(%eax)
    8440:	00 00                	add    %al,(%eax)
    8442:	00 00                	add    %al,(%eax)
    8444:	00 00                	add    %al,(%eax)
    8446:	00 00                	add    %al,(%eax)
    8448:	00 00                	add    %al,(%eax)
    844a:	00 00                	add    %al,(%eax)
    844c:	00 00                	add    %al,(%eax)
    844e:	00 00                	add    %al,(%eax)
    8450:	00 00                	add    %al,(%eax)
    8452:	00 00                	add    %al,(%eax)
    8454:	00 00                	add    %al,(%eax)
    8456:	00 00                	add    %al,(%eax)
    8458:	00 00                	add    %al,(%eax)
    845a:	00 00                	add    %al,(%eax)
    845c:	00 00                	add    %al,(%eax)
    845e:	00 00                	add    %al,(%eax)
    8460:	00 00                	add    %al,(%eax)
    8462:	00 00                	add    %al,(%eax)
    8464:	00 00                	add    %al,(%eax)
    8466:	00 00                	add    %al,(%eax)
    8468:	00 00                	add    %al,(%eax)
    846a:	00 00                	add    %al,(%eax)
    846c:	00 00                	add    %al,(%eax)
    846e:	00 00                	add    %al,(%eax)
    8470:	00 00                	add    %al,(%eax)
    8472:	00 00                	add    %al,(%eax)
    8474:	00 00                	add    %al,(%eax)
    8476:	00 00                	add    %al,(%eax)
    8478:	00 00                	add    %al,(%eax)
    847a:	00 00                	add    %al,(%eax)
    847c:	00 00                	add    %al,(%eax)
    847e:	00 00                	add    %al,(%eax)
    8480:	00 00                	add    %al,(%eax)
    8482:	00 00                	add    %al,(%eax)
    8484:	00 00                	add    %al,(%eax)
    8486:	00 00                	add    %al,(%eax)
    8488:	00 00                	add    %al,(%eax)
    848a:	00 00                	add    %al,(%eax)
    848c:	00 00                	add    %al,(%eax)
    848e:	00 00                	add    %al,(%eax)
    8490:	00 00                	add    %al,(%eax)
    8492:	00 00                	add    %al,(%eax)
    8494:	00 00                	add    %al,(%eax)
    8496:	00 00                	add    %al,(%eax)
    8498:	00 00                	add    %al,(%eax)
    849a:	00 00                	add    %al,(%eax)
    849c:	00 00                	add    %al,(%eax)
    849e:	00 00                	add    %al,(%eax)
    84a0:	00 00                	add    %al,(%eax)
    84a2:	00 00                	add    %al,(%eax)
    84a4:	00 00                	add    %al,(%eax)
    84a6:	00 00                	add    %al,(%eax)
    84a8:	00 00                	add    %al,(%eax)
    84aa:	00 00                	add    %al,(%eax)
    84ac:	00 00                	add    %al,(%eax)
    84ae:	00 00                	add    %al,(%eax)
    84b0:	00 00                	add    %al,(%eax)
    84b2:	00 00                	add    %al,(%eax)
    84b4:	00 00                	add    %al,(%eax)
    84b6:	00 00                	add    %al,(%eax)
    84b8:	00 00                	add    %al,(%eax)
    84ba:	00 00                	add    %al,(%eax)
    84bc:	00 00                	add    %al,(%eax)
    84be:	00 00                	add    %al,(%eax)
    84c0:	00 00                	add    %al,(%eax)
    84c2:	00 00                	add    %al,(%eax)
    84c4:	00 00                	add    %al,(%eax)
    84c6:	00 00                	add    %al,(%eax)
    84c8:	00 00                	add    %al,(%eax)
    84ca:	00 00                	add    %al,(%eax)
    84cc:	00 00                	add    %al,(%eax)
    84ce:	00 00                	add    %al,(%eax)
    84d0:	00 00                	add    %al,(%eax)
    84d2:	00 00                	add    %al,(%eax)
    84d4:	00 00                	add    %al,(%eax)
    84d6:	00 00                	add    %al,(%eax)
    84d8:	00 00                	add    %al,(%eax)
    84da:	00 00                	add    %al,(%eax)
    84dc:	00 00                	add    %al,(%eax)
    84de:	00 00                	add    %al,(%eax)
    84e0:	00 00                	add    %al,(%eax)
    84e2:	00 00                	add    %al,(%eax)
    84e4:	00 00                	add    %al,(%eax)
    84e6:	00 00                	add    %al,(%eax)
    84e8:	00 00                	add    %al,(%eax)
    84ea:	00 00                	add    %al,(%eax)
    84ec:	00 00                	add    %al,(%eax)
    84ee:	00 00                	add    %al,(%eax)
    84f0:	00 00                	add    %al,(%eax)
    84f2:	00 00                	add    %al,(%eax)
    84f4:	00 00                	add    %al,(%eax)
    84f6:	00 00                	add    %al,(%eax)
    84f8:	00 00                	add    %al,(%eax)
    84fa:	00 00                	add    %al,(%eax)
    84fc:	00 00                	add    %al,(%eax)
    84fe:	00 00                	add    %al,(%eax)
    8500:	00 00                	add    %al,(%eax)
    8502:	00 00                	add    %al,(%eax)
    8504:	00 00                	add    %al,(%eax)
    8506:	00 00                	add    %al,(%eax)
    8508:	00 00                	add    %al,(%eax)
    850a:	00 00                	add    %al,(%eax)
    850c:	00 00                	add    %al,(%eax)
    850e:	00 00                	add    %al,(%eax)
    8510:	00 00                	add    %al,(%eax)
    8512:	00 00                	add    %al,(%eax)
    8514:	00 00                	add    %al,(%eax)
    8516:	00 00                	add    %al,(%eax)
    8518:	00 00                	add    %al,(%eax)
    851a:	00 00                	add    %al,(%eax)
    851c:	00 00                	add    %al,(%eax)
    851e:	00 00                	add    %al,(%eax)
    8520:	00 00                	add    %al,(%eax)
    8522:	00 00                	add    %al,(%eax)
    8524:	00 00                	add    %al,(%eax)
    8526:	00 00                	add    %al,(%eax)
    8528:	00 00                	add    %al,(%eax)
    852a:	00 00                	add    %al,(%eax)
    852c:	00 00                	add    %al,(%eax)
    852e:	00 00                	add    %al,(%eax)
    8530:	00 00                	add    %al,(%eax)
    8532:	00 00                	add    %al,(%eax)
    8534:	00 00                	add    %al,(%eax)
    8536:	00 00                	add    %al,(%eax)
    8538:	00 00                	add    %al,(%eax)
    853a:	00 00                	add    %al,(%eax)
    853c:	00 00                	add    %al,(%eax)
    853e:	00 00                	add    %al,(%eax)
    8540:	00 00                	add    %al,(%eax)
    8542:	00 00                	add    %al,(%eax)
    8544:	00 00                	add    %al,(%eax)
    8546:	00 00                	add    %al,(%eax)
    8548:	00 00                	add    %al,(%eax)
    854a:	00 00                	add    %al,(%eax)
    854c:	00 00                	add    %al,(%eax)
    854e:	00 00                	add    %al,(%eax)
    8550:	00 00                	add    %al,(%eax)
    8552:	00 00                	add    %al,(%eax)
    8554:	00 00                	add    %al,(%eax)
    8556:	00 00                	add    %al,(%eax)
    8558:	00 00                	add    %al,(%eax)
    855a:	00 00                	add    %al,(%eax)
    855c:	00 00                	add    %al,(%eax)
    855e:	00 00                	add    %al,(%eax)
    8560:	00 00                	add    %al,(%eax)
    8562:	00 00                	add    %al,(%eax)
    8564:	00 00                	add    %al,(%eax)
    8566:	00 00                	add    %al,(%eax)
    8568:	00 00                	add    %al,(%eax)
    856a:	00 00                	add    %al,(%eax)
    856c:	00 00                	add    %al,(%eax)
    856e:	00 00                	add    %al,(%eax)
    8570:	00 00                	add    %al,(%eax)
    8572:	00 00                	add    %al,(%eax)
    8574:	00 00                	add    %al,(%eax)
    8576:	00 00                	add    %al,(%eax)
    8578:	00 00                	add    %al,(%eax)
    857a:	00 00                	add    %al,(%eax)
    857c:	00 00                	add    %al,(%eax)
    857e:	00 00                	add    %al,(%eax)
    8580:	00 00                	add    %al,(%eax)
    8582:	00 00                	add    %al,(%eax)
    8584:	00 00                	add    %al,(%eax)
    8586:	00 00                	add    %al,(%eax)
    8588:	00 00                	add    %al,(%eax)
    858a:	00 00                	add    %al,(%eax)
    858c:	00 00                	add    %al,(%eax)
    858e:	00 00                	add    %al,(%eax)
    8590:	00 00                	add    %al,(%eax)
    8592:	00 00                	add    %al,(%eax)
    8594:	00 00                	add    %al,(%eax)
    8596:	00 00                	add    %al,(%eax)
    8598:	00 00                	add    %al,(%eax)
    859a:	00 00                	add    %al,(%eax)
    859c:	00 00                	add    %al,(%eax)
    859e:	00 00                	add    %al,(%eax)
    85a0:	00 00                	add    %al,(%eax)
    85a2:	00 00                	add    %al,(%eax)
    85a4:	00 00                	add    %al,(%eax)
    85a6:	00 00                	add    %al,(%eax)
    85a8:	00 00                	add    %al,(%eax)
    85aa:	00 00                	add    %al,(%eax)
    85ac:	00 00                	add    %al,(%eax)
    85ae:	00 00                	add    %al,(%eax)
    85b0:	00 00                	add    %al,(%eax)
    85b2:	00 00                	add    %al,(%eax)
    85b4:	00 00                	add    %al,(%eax)
    85b6:	00 00                	add    %al,(%eax)
    85b8:	00 00                	add    %al,(%eax)
    85ba:	00 00                	add    %al,(%eax)
    85bc:	00 00                	add    %al,(%eax)
    85be:	00 00                	add    %al,(%eax)
    85c0:	00 00                	add    %al,(%eax)
    85c2:	00 00                	add    %al,(%eax)
    85c4:	00 00                	add    %al,(%eax)
    85c6:	00 00                	add    %al,(%eax)
    85c8:	00 00                	add    %al,(%eax)
    85ca:	00 00                	add    %al,(%eax)
    85cc:	00 00                	add    %al,(%eax)
    85ce:	00 00                	add    %al,(%eax)
    85d0:	00 00                	add    %al,(%eax)
    85d2:	00 00                	add    %al,(%eax)
    85d4:	00 00                	add    %al,(%eax)
    85d6:	00 00                	add    %al,(%eax)
    85d8:	00 00                	add    %al,(%eax)
    85da:	00 00                	add    %al,(%eax)
    85dc:	00 00                	add    %al,(%eax)
    85de:	00 00                	add    %al,(%eax)
    85e0:	00 00                	add    %al,(%eax)
    85e2:	00 00                	add    %al,(%eax)
    85e4:	00 00                	add    %al,(%eax)
    85e6:	00 00                	add    %al,(%eax)
    85e8:	00 00                	add    %al,(%eax)
    85ea:	00 00                	add    %al,(%eax)
    85ec:	00 00                	add    %al,(%eax)
    85ee:	00 00                	add    %al,(%eax)
    85f0:	00 00                	add    %al,(%eax)
    85f2:	00 00                	add    %al,(%eax)
    85f4:	00 00                	add    %al,(%eax)
    85f6:	00 00                	add    %al,(%eax)
    85f8:	00 00                	add    %al,(%eax)
    85fa:	00 00                	add    %al,(%eax)
    85fc:	00 00                	add    %al,(%eax)
    85fe:	00 00                	add    %al,(%eax)
    8600:	00 00                	add    %al,(%eax)
    8602:	00 00                	add    %al,(%eax)
    8604:	00 00                	add    %al,(%eax)
    8606:	00 00                	add    %al,(%eax)
    8608:	00 00                	add    %al,(%eax)
    860a:	00 00                	add    %al,(%eax)
    860c:	00 00                	add    %al,(%eax)
    860e:	00 00                	add    %al,(%eax)
    8610:	00 00                	add    %al,(%eax)
    8612:	00 00                	add    %al,(%eax)
    8614:	00 00                	add    %al,(%eax)
    8616:	00 00                	add    %al,(%eax)
    8618:	00 00                	add    %al,(%eax)
    861a:	00 00                	add    %al,(%eax)
    861c:	00 00                	add    %al,(%eax)
    861e:	00 00                	add    %al,(%eax)
    8620:	00 00                	add    %al,(%eax)
    8622:	00 00                	add    %al,(%eax)
    8624:	00 00                	add    %al,(%eax)
    8626:	00 00                	add    %al,(%eax)
    8628:	00 00                	add    %al,(%eax)
    862a:	00 00                	add    %al,(%eax)
    862c:	00 00                	add    %al,(%eax)
    862e:	00 00                	add    %al,(%eax)
    8630:	00 00                	add    %al,(%eax)
    8632:	00 00                	add    %al,(%eax)
    8634:	00 00                	add    %al,(%eax)
    8636:	00 00                	add    %al,(%eax)
    8638:	00 00                	add    %al,(%eax)
    863a:	00 00                	add    %al,(%eax)
    863c:	00 00                	add    %al,(%eax)
    863e:	00 00                	add    %al,(%eax)
    8640:	00 00                	add    %al,(%eax)
    8642:	00 00                	add    %al,(%eax)
    8644:	00 00                	add    %al,(%eax)
    8646:	00 00                	add    %al,(%eax)
    8648:	00 00                	add    %al,(%eax)
    864a:	00 00                	add    %al,(%eax)
    864c:	00 00                	add    %al,(%eax)
    864e:	00 00                	add    %al,(%eax)
    8650:	00 00                	add    %al,(%eax)
    8652:	00 00                	add    %al,(%eax)
    8654:	00 00                	add    %al,(%eax)
    8656:	00 00                	add    %al,(%eax)
    8658:	00 00                	add    %al,(%eax)
    865a:	00 00                	add    %al,(%eax)
    865c:	00 00                	add    %al,(%eax)
    865e:	00 00                	add    %al,(%eax)
    8660:	00 00                	add    %al,(%eax)
    8662:	00 00                	add    %al,(%eax)
    8664:	00 00                	add    %al,(%eax)
    8666:	00 00                	add    %al,(%eax)
    8668:	00 00                	add    %al,(%eax)
    866a:	00 00                	add    %al,(%eax)
    866c:	00 00                	add    %al,(%eax)
    866e:	00 00                	add    %al,(%eax)
    8670:	00 00                	add    %al,(%eax)
    8672:	00 00                	add    %al,(%eax)
    8674:	00 00                	add    %al,(%eax)
    8676:	00 00                	add    %al,(%eax)
    8678:	00 00                	add    %al,(%eax)
    867a:	00 00                	add    %al,(%eax)
    867c:	00 00                	add    %al,(%eax)
    867e:	00 00                	add    %al,(%eax)
    8680:	00 00                	add    %al,(%eax)
    8682:	00 00                	add    %al,(%eax)
    8684:	00 00                	add    %al,(%eax)
    8686:	00 00                	add    %al,(%eax)
    8688:	00 00                	add    %al,(%eax)
    868a:	00 00                	add    %al,(%eax)
    868c:	00 00                	add    %al,(%eax)
    868e:	00 00                	add    %al,(%eax)
    8690:	00 00                	add    %al,(%eax)
    8692:	00 00                	add    %al,(%eax)
    8694:	00 00                	add    %al,(%eax)
    8696:	00 00                	add    %al,(%eax)
    8698:	00 00                	add    %al,(%eax)
    869a:	00 00                	add    %al,(%eax)
    869c:	00 00                	add    %al,(%eax)
    869e:	00 00                	add    %al,(%eax)
    86a0:	00 00                	add    %al,(%eax)
    86a2:	00 00                	add    %al,(%eax)
    86a4:	00 00                	add    %al,(%eax)
    86a6:	00 00                	add    %al,(%eax)
    86a8:	00 00                	add    %al,(%eax)
    86aa:	00 00                	add    %al,(%eax)
    86ac:	00 00                	add    %al,(%eax)
    86ae:	00 00                	add    %al,(%eax)
    86b0:	00 00                	add    %al,(%eax)
    86b2:	00 00                	add    %al,(%eax)
    86b4:	00 00                	add    %al,(%eax)
    86b6:	00 00                	add    %al,(%eax)
    86b8:	00 00                	add    %al,(%eax)
    86ba:	00 00                	add    %al,(%eax)
    86bc:	00 00                	add    %al,(%eax)
    86be:	00 00                	add    %al,(%eax)
    86c0:	00 00                	add    %al,(%eax)
    86c2:	00 00                	add    %al,(%eax)
    86c4:	00 00                	add    %al,(%eax)
    86c6:	00 00                	add    %al,(%eax)
    86c8:	00 00                	add    %al,(%eax)
    86ca:	00 00                	add    %al,(%eax)
    86cc:	00 00                	add    %al,(%eax)
    86ce:	00 00                	add    %al,(%eax)
    86d0:	00 00                	add    %al,(%eax)
    86d2:	00 00                	add    %al,(%eax)
    86d4:	00 00                	add    %al,(%eax)
    86d6:	00 00                	add    %al,(%eax)
    86d8:	00 00                	add    %al,(%eax)
    86da:	00 00                	add    %al,(%eax)
    86dc:	00 00                	add    %al,(%eax)
    86de:	00 00                	add    %al,(%eax)
    86e0:	00 00                	add    %al,(%eax)
    86e2:	00 00                	add    %al,(%eax)
    86e4:	00 00                	add    %al,(%eax)
    86e6:	00 00                	add    %al,(%eax)
    86e8:	00 00                	add    %al,(%eax)
    86ea:	00 00                	add    %al,(%eax)
    86ec:	00 00                	add    %al,(%eax)
    86ee:	00 00                	add    %al,(%eax)
    86f0:	00 00                	add    %al,(%eax)
    86f2:	00 00                	add    %al,(%eax)
    86f4:	00 00                	add    %al,(%eax)
    86f6:	00 00                	add    %al,(%eax)
    86f8:	00 00                	add    %al,(%eax)
    86fa:	00 00                	add    %al,(%eax)
    86fc:	00 00                	add    %al,(%eax)
    86fe:	00 00                	add    %al,(%eax)
    8700:	00 00                	add    %al,(%eax)
    8702:	00 00                	add    %al,(%eax)
    8704:	00 00                	add    %al,(%eax)
    8706:	00 00                	add    %al,(%eax)
    8708:	00 00                	add    %al,(%eax)
    870a:	00 00                	add    %al,(%eax)
    870c:	00 00                	add    %al,(%eax)
    870e:	00 00                	add    %al,(%eax)
    8710:	00 00                	add    %al,(%eax)
    8712:	00 00                	add    %al,(%eax)
    8714:	00 00                	add    %al,(%eax)
    8716:	00 00                	add    %al,(%eax)
    8718:	00 00                	add    %al,(%eax)
    871a:	00 00                	add    %al,(%eax)
    871c:	00 00                	add    %al,(%eax)
    871e:	00 00                	add    %al,(%eax)
    8720:	00 00                	add    %al,(%eax)
    8722:	00 00                	add    %al,(%eax)
    8724:	00 00                	add    %al,(%eax)
    8726:	00 00                	add    %al,(%eax)
    8728:	00 00                	add    %al,(%eax)
    872a:	00 00                	add    %al,(%eax)
    872c:	00 00                	add    %al,(%eax)
    872e:	00 00                	add    %al,(%eax)
    8730:	00 00                	add    %al,(%eax)
    8732:	00 00                	add    %al,(%eax)
    8734:	00 00                	add    %al,(%eax)
    8736:	00 00                	add    %al,(%eax)
    8738:	00 00                	add    %al,(%eax)
    873a:	00 00                	add    %al,(%eax)
    873c:	00 00                	add    %al,(%eax)
    873e:	00 00                	add    %al,(%eax)
    8740:	00 00                	add    %al,(%eax)
    8742:	00 00                	add    %al,(%eax)
    8744:	00 00                	add    %al,(%eax)
    8746:	00 00                	add    %al,(%eax)
    8748:	00 00                	add    %al,(%eax)
    874a:	00 00                	add    %al,(%eax)
    874c:	00 00                	add    %al,(%eax)
    874e:	00 00                	add    %al,(%eax)
    8750:	00 00                	add    %al,(%eax)
    8752:	00 00                	add    %al,(%eax)
    8754:	00 00                	add    %al,(%eax)
    8756:	00 00                	add    %al,(%eax)
    8758:	00 00                	add    %al,(%eax)
    875a:	00 00                	add    %al,(%eax)
    875c:	00 00                	add    %al,(%eax)
    875e:	00 00                	add    %al,(%eax)
    8760:	00 00                	add    %al,(%eax)
    8762:	00 00                	add    %al,(%eax)
    8764:	00 00                	add    %al,(%eax)
    8766:	00 00                	add    %al,(%eax)
    8768:	00 00                	add    %al,(%eax)
    876a:	00 00                	add    %al,(%eax)
    876c:	00 00                	add    %al,(%eax)
    876e:	00 00                	add    %al,(%eax)
    8770:	00 00                	add    %al,(%eax)
    8772:	00 00                	add    %al,(%eax)
    8774:	00 00                	add    %al,(%eax)
    8776:	00 00                	add    %al,(%eax)
    8778:	00 00                	add    %al,(%eax)
    877a:	00 00                	add    %al,(%eax)
    877c:	00 00                	add    %al,(%eax)
    877e:	00 00                	add    %al,(%eax)
    8780:	00 00                	add    %al,(%eax)
    8782:	00 00                	add    %al,(%eax)
    8784:	00 00                	add    %al,(%eax)
    8786:	00 00                	add    %al,(%eax)
    8788:	00 00                	add    %al,(%eax)
    878a:	00 00                	add    %al,(%eax)
    878c:	00 00                	add    %al,(%eax)
    878e:	00 00                	add    %al,(%eax)
    8790:	00 00                	add    %al,(%eax)
    8792:	00 00                	add    %al,(%eax)
    8794:	00 00                	add    %al,(%eax)
    8796:	00 00                	add    %al,(%eax)
    8798:	00 00                	add    %al,(%eax)
    879a:	00 00                	add    %al,(%eax)
    879c:	00 00                	add    %al,(%eax)
    879e:	00 00                	add    %al,(%eax)
    87a0:	00 00                	add    %al,(%eax)
    87a2:	00 00                	add    %al,(%eax)
    87a4:	00 00                	add    %al,(%eax)
    87a6:	00 00                	add    %al,(%eax)
    87a8:	00 00                	add    %al,(%eax)
    87aa:	00 00                	add    %al,(%eax)
    87ac:	00 00                	add    %al,(%eax)
    87ae:	00 00                	add    %al,(%eax)
    87b0:	00 00                	add    %al,(%eax)
    87b2:	00 00                	add    %al,(%eax)
    87b4:	00 00                	add    %al,(%eax)
    87b6:	00 00                	add    %al,(%eax)
    87b8:	00 00                	add    %al,(%eax)
    87ba:	00 00                	add    %al,(%eax)
    87bc:	00 00                	add    %al,(%eax)
    87be:	00 00                	add    %al,(%eax)
    87c0:	00 00                	add    %al,(%eax)
    87c2:	00 00                	add    %al,(%eax)
    87c4:	00 00                	add    %al,(%eax)
    87c6:	00 00                	add    %al,(%eax)
    87c8:	00 00                	add    %al,(%eax)
    87ca:	00 00                	add    %al,(%eax)
    87cc:	00 00                	add    %al,(%eax)
    87ce:	00 00                	add    %al,(%eax)
    87d0:	00 00                	add    %al,(%eax)
    87d2:	00 00                	add    %al,(%eax)
    87d4:	00 00                	add    %al,(%eax)
    87d6:	00 00                	add    %al,(%eax)
    87d8:	00 00                	add    %al,(%eax)
    87da:	00 00                	add    %al,(%eax)
    87dc:	00 00                	add    %al,(%eax)
    87de:	00 00                	add    %al,(%eax)
    87e0:	00 00                	add    %al,(%eax)
    87e2:	00 00                	add    %al,(%eax)
    87e4:	00 00                	add    %al,(%eax)
    87e6:	00 00                	add    %al,(%eax)
    87e8:	00 00                	add    %al,(%eax)
    87ea:	00 00                	add    %al,(%eax)
    87ec:	00 00                	add    %al,(%eax)
    87ee:	00 00                	add    %al,(%eax)
    87f0:	00 00                	add    %al,(%eax)
    87f2:	00 00                	add    %al,(%eax)
    87f4:	00 00                	add    %al,(%eax)
    87f6:	00 00                	add    %al,(%eax)
    87f8:	00 00                	add    %al,(%eax)
    87fa:	00 00                	add    %al,(%eax)
    87fc:	00 00                	add    %al,(%eax)
    87fe:	00 00                	add    %al,(%eax)
    8800:	00 00                	add    %al,(%eax)
    8802:	00 00                	add    %al,(%eax)
    8804:	00 00                	add    %al,(%eax)
    8806:	00 00                	add    %al,(%eax)
    8808:	00 00                	add    %al,(%eax)
    880a:	00 00                	add    %al,(%eax)
    880c:	00 00                	add    %al,(%eax)
    880e:	00 00                	add    %al,(%eax)
    8810:	00 00                	add    %al,(%eax)
    8812:	00 00                	add    %al,(%eax)
    8814:	00 00                	add    %al,(%eax)
    8816:	00 00                	add    %al,(%eax)
    8818:	00 00                	add    %al,(%eax)
    881a:	00 00                	add    %al,(%eax)
    881c:	00 00                	add    %al,(%eax)
    881e:	00 00                	add    %al,(%eax)
    8820:	00 00                	add    %al,(%eax)
    8822:	00 00                	add    %al,(%eax)
    8824:	00 00                	add    %al,(%eax)
    8826:	00 00                	add    %al,(%eax)
    8828:	00 00                	add    %al,(%eax)
    882a:	00 00                	add    %al,(%eax)
    882c:	00 00                	add    %al,(%eax)
    882e:	00 00                	add    %al,(%eax)
    8830:	00 00                	add    %al,(%eax)
    8832:	00 00                	add    %al,(%eax)
    8834:	00 00                	add    %al,(%eax)
    8836:	00 00                	add    %al,(%eax)
    8838:	00 00                	add    %al,(%eax)
    883a:	00 00                	add    %al,(%eax)
    883c:	00 00                	add    %al,(%eax)
    883e:	00 00                	add    %al,(%eax)
    8840:	00 00                	add    %al,(%eax)
    8842:	00 00                	add    %al,(%eax)
    8844:	00 00                	add    %al,(%eax)
    8846:	00 00                	add    %al,(%eax)
    8848:	00 00                	add    %al,(%eax)
    884a:	00 00                	add    %al,(%eax)
    884c:	00 00                	add    %al,(%eax)
    884e:	00 00                	add    %al,(%eax)
    8850:	00 00                	add    %al,(%eax)
    8852:	00 00                	add    %al,(%eax)
    8854:	00 00                	add    %al,(%eax)
    8856:	00 00                	add    %al,(%eax)
    8858:	00 00                	add    %al,(%eax)
    885a:	00 00                	add    %al,(%eax)
    885c:	00 00                	add    %al,(%eax)
    885e:	00 00                	add    %al,(%eax)
    8860:	00 00                	add    %al,(%eax)
    8862:	00 00                	add    %al,(%eax)
    8864:	00 00                	add    %al,(%eax)
    8866:	00 00                	add    %al,(%eax)
    8868:	00 00                	add    %al,(%eax)
    886a:	00 00                	add    %al,(%eax)
    886c:	00 00                	add    %al,(%eax)
    886e:	00 00                	add    %al,(%eax)
    8870:	00 00                	add    %al,(%eax)
    8872:	00 00                	add    %al,(%eax)
    8874:	00 00                	add    %al,(%eax)
    8876:	00 00                	add    %al,(%eax)
    8878:	00 00                	add    %al,(%eax)
    887a:	00 00                	add    %al,(%eax)
    887c:	00 00                	add    %al,(%eax)
    887e:	00 00                	add    %al,(%eax)
    8880:	00 00                	add    %al,(%eax)
    8882:	00 00                	add    %al,(%eax)
    8884:	00 00                	add    %al,(%eax)
    8886:	00 00                	add    %al,(%eax)
    8888:	00 00                	add    %al,(%eax)
    888a:	00 00                	add    %al,(%eax)
    888c:	00 00                	add    %al,(%eax)
    888e:	00 00                	add    %al,(%eax)
    8890:	00 00                	add    %al,(%eax)
    8892:	00 00                	add    %al,(%eax)
    8894:	00 00                	add    %al,(%eax)
    8896:	00 00                	add    %al,(%eax)
    8898:	00 00                	add    %al,(%eax)
    889a:	00 00                	add    %al,(%eax)
    889c:	00 00                	add    %al,(%eax)
    889e:	00 00                	add    %al,(%eax)
    88a0:	00 00                	add    %al,(%eax)
    88a2:	00 00                	add    %al,(%eax)
    88a4:	00 00                	add    %al,(%eax)
    88a6:	00 00                	add    %al,(%eax)
    88a8:	00 00                	add    %al,(%eax)
    88aa:	00 00                	add    %al,(%eax)
    88ac:	00 00                	add    %al,(%eax)
    88ae:	00 00                	add    %al,(%eax)
    88b0:	00 00                	add    %al,(%eax)
    88b2:	00 00                	add    %al,(%eax)
    88b4:	00 00                	add    %al,(%eax)
    88b6:	00 00                	add    %al,(%eax)
    88b8:	00 00                	add    %al,(%eax)
    88ba:	00 00                	add    %al,(%eax)
    88bc:	00 00                	add    %al,(%eax)
    88be:	00 00                	add    %al,(%eax)
    88c0:	00 00                	add    %al,(%eax)
    88c2:	00 00                	add    %al,(%eax)
    88c4:	00 00                	add    %al,(%eax)
    88c6:	00 00                	add    %al,(%eax)
    88c8:	00 00                	add    %al,(%eax)
    88ca:	00 00                	add    %al,(%eax)
    88cc:	00 00                	add    %al,(%eax)
    88ce:	00 00                	add    %al,(%eax)
    88d0:	00 00                	add    %al,(%eax)
    88d2:	00 00                	add    %al,(%eax)
    88d4:	00 00                	add    %al,(%eax)
    88d6:	00 00                	add    %al,(%eax)
    88d8:	00 00                	add    %al,(%eax)
    88da:	00 00                	add    %al,(%eax)
    88dc:	00 00                	add    %al,(%eax)
    88de:	00 00                	add    %al,(%eax)
    88e0:	00 00                	add    %al,(%eax)
    88e2:	00 00                	add    %al,(%eax)
    88e4:	00 00                	add    %al,(%eax)
    88e6:	00 00                	add    %al,(%eax)
    88e8:	00 00                	add    %al,(%eax)
    88ea:	00 00                	add    %al,(%eax)
    88ec:	00 00                	add    %al,(%eax)
    88ee:	00 00                	add    %al,(%eax)
    88f0:	00 00                	add    %al,(%eax)
    88f2:	00 00                	add    %al,(%eax)
    88f4:	00 00                	add    %al,(%eax)
    88f6:	00 00                	add    %al,(%eax)
    88f8:	00 00                	add    %al,(%eax)
    88fa:	00 00                	add    %al,(%eax)
    88fc:	00 00                	add    %al,(%eax)
    88fe:	00 00                	add    %al,(%eax)
    8900:	00 00                	add    %al,(%eax)
    8902:	00 00                	add    %al,(%eax)
    8904:	00 00                	add    %al,(%eax)
    8906:	00 00                	add    %al,(%eax)
    8908:	00 00                	add    %al,(%eax)
    890a:	00 00                	add    %al,(%eax)
    890c:	00 00                	add    %al,(%eax)
    890e:	00 00                	add    %al,(%eax)
    8910:	00 00                	add    %al,(%eax)
    8912:	00 00                	add    %al,(%eax)
    8914:	00 00                	add    %al,(%eax)
    8916:	00 00                	add    %al,(%eax)
    8918:	00 00                	add    %al,(%eax)
    891a:	00 00                	add    %al,(%eax)
    891c:	00 00                	add    %al,(%eax)
    891e:	00 00                	add    %al,(%eax)
    8920:	00 00                	add    %al,(%eax)
    8922:	00 00                	add    %al,(%eax)
    8924:	00 00                	add    %al,(%eax)
    8926:	00 00                	add    %al,(%eax)
    8928:	00 00                	add    %al,(%eax)
    892a:	00 00                	add    %al,(%eax)
    892c:	00 00                	add    %al,(%eax)
    892e:	00 00                	add    %al,(%eax)
    8930:	00 00                	add    %al,(%eax)
    8932:	00 00                	add    %al,(%eax)
    8934:	00 00                	add    %al,(%eax)
    8936:	00 00                	add    %al,(%eax)
    8938:	00 00                	add    %al,(%eax)
    893a:	00 00                	add    %al,(%eax)
    893c:	00 00                	add    %al,(%eax)
    893e:	00 00                	add    %al,(%eax)
    8940:	00 00                	add    %al,(%eax)
    8942:	00 00                	add    %al,(%eax)
    8944:	00 00                	add    %al,(%eax)
    8946:	00 00                	add    %al,(%eax)
    8948:	00 00                	add    %al,(%eax)
    894a:	00 00                	add    %al,(%eax)
    894c:	00 00                	add    %al,(%eax)
    894e:	00 00                	add    %al,(%eax)
    8950:	00 00                	add    %al,(%eax)
    8952:	00 00                	add    %al,(%eax)
    8954:	00 00                	add    %al,(%eax)
    8956:	00 00                	add    %al,(%eax)
    8958:	00 00                	add    %al,(%eax)
    895a:	00 00                	add    %al,(%eax)
    895c:	00 00                	add    %al,(%eax)
    895e:	00 00                	add    %al,(%eax)
    8960:	00 00                	add    %al,(%eax)
    8962:	00 00                	add    %al,(%eax)
    8964:	00 00                	add    %al,(%eax)
    8966:	00 00                	add    %al,(%eax)
    8968:	00 00                	add    %al,(%eax)
    896a:	00 00                	add    %al,(%eax)
    896c:	00 00                	add    %al,(%eax)
    896e:	00 00                	add    %al,(%eax)
    8970:	00 00                	add    %al,(%eax)
    8972:	00 00                	add    %al,(%eax)
    8974:	00 00                	add    %al,(%eax)
    8976:	00 00                	add    %al,(%eax)
    8978:	00 00                	add    %al,(%eax)
    897a:	00 00                	add    %al,(%eax)
    897c:	00 00                	add    %al,(%eax)
    897e:	00 00                	add    %al,(%eax)
    8980:	00 00                	add    %al,(%eax)
    8982:	00 00                	add    %al,(%eax)
    8984:	00 00                	add    %al,(%eax)
    8986:	00 00                	add    %al,(%eax)
    8988:	00 00                	add    %al,(%eax)
    898a:	00 00                	add    %al,(%eax)
    898c:	00 00                	add    %al,(%eax)
    898e:	00 00                	add    %al,(%eax)
    8990:	00 00                	add    %al,(%eax)
    8992:	00 00                	add    %al,(%eax)
    8994:	00 00                	add    %al,(%eax)
    8996:	00 00                	add    %al,(%eax)
    8998:	00 00                	add    %al,(%eax)
    899a:	00 00                	add    %al,(%eax)
    899c:	00 00                	add    %al,(%eax)
    899e:	00 00                	add    %al,(%eax)
    89a0:	00 00                	add    %al,(%eax)
    89a2:	00 00                	add    %al,(%eax)
    89a4:	00 00                	add    %al,(%eax)
    89a6:	00 00                	add    %al,(%eax)
    89a8:	00 00                	add    %al,(%eax)
    89aa:	00 00                	add    %al,(%eax)
    89ac:	00 00                	add    %al,(%eax)
    89ae:	00 00                	add    %al,(%eax)
    89b0:	00 00                	add    %al,(%eax)
    89b2:	00 00                	add    %al,(%eax)
    89b4:	00 00                	add    %al,(%eax)
    89b6:	00 00                	add    %al,(%eax)
    89b8:	00 00                	add    %al,(%eax)
    89ba:	00 00                	add    %al,(%eax)
    89bc:	00 00                	add    %al,(%eax)
    89be:	00 00                	add    %al,(%eax)
    89c0:	00 00                	add    %al,(%eax)
    89c2:	00 00                	add    %al,(%eax)
    89c4:	00 00                	add    %al,(%eax)
    89c6:	00 00                	add    %al,(%eax)
    89c8:	00 00                	add    %al,(%eax)
    89ca:	00 00                	add    %al,(%eax)
    89cc:	00 00                	add    %al,(%eax)
    89ce:	00 00                	add    %al,(%eax)
    89d0:	00 00                	add    %al,(%eax)
    89d2:	00 00                	add    %al,(%eax)
    89d4:	00 00                	add    %al,(%eax)
    89d6:	00 00                	add    %al,(%eax)
    89d8:	00 00                	add    %al,(%eax)
    89da:	00 00                	add    %al,(%eax)
    89dc:	00 00                	add    %al,(%eax)
    89de:	00 00                	add    %al,(%eax)
    89e0:	00 00                	add    %al,(%eax)
    89e2:	00 00                	add    %al,(%eax)
    89e4:	00 00                	add    %al,(%eax)
    89e6:	00 00                	add    %al,(%eax)
    89e8:	00 00                	add    %al,(%eax)
    89ea:	00 00                	add    %al,(%eax)
    89ec:	00 00                	add    %al,(%eax)
    89ee:	00 00                	add    %al,(%eax)
    89f0:	00 00                	add    %al,(%eax)
    89f2:	00 00                	add    %al,(%eax)
    89f4:	00 00                	add    %al,(%eax)
    89f6:	00 00                	add    %al,(%eax)
    89f8:	00 00                	add    %al,(%eax)
    89fa:	00 00                	add    %al,(%eax)
    89fc:	00 00                	add    %al,(%eax)
    89fe:	00 00                	add    %al,(%eax)
    8a00:	00 00                	add    %al,(%eax)
    8a02:	00 00                	add    %al,(%eax)
    8a04:	00 00                	add    %al,(%eax)
    8a06:	00 00                	add    %al,(%eax)
    8a08:	00 00                	add    %al,(%eax)
    8a0a:	00 00                	add    %al,(%eax)
    8a0c:	00 00                	add    %al,(%eax)
    8a0e:	00 00                	add    %al,(%eax)
    8a10:	00 00                	add    %al,(%eax)
    8a12:	00 00                	add    %al,(%eax)
    8a14:	00 00                	add    %al,(%eax)
    8a16:	00 00                	add    %al,(%eax)
    8a18:	00 00                	add    %al,(%eax)
    8a1a:	00 00                	add    %al,(%eax)
    8a1c:	00 00                	add    %al,(%eax)
    8a1e:	00 00                	add    %al,(%eax)
    8a20:	00 00                	add    %al,(%eax)
    8a22:	00 00                	add    %al,(%eax)
    8a24:	00 00                	add    %al,(%eax)
    8a26:	00 00                	add    %al,(%eax)
    8a28:	00 00                	add    %al,(%eax)
    8a2a:	00 00                	add    %al,(%eax)
    8a2c:	00 00                	add    %al,(%eax)
    8a2e:	00 00                	add    %al,(%eax)
    8a30:	00 00                	add    %al,(%eax)
    8a32:	00 00                	add    %al,(%eax)
    8a34:	00 00                	add    %al,(%eax)
    8a36:	00 00                	add    %al,(%eax)
    8a38:	00 00                	add    %al,(%eax)
    8a3a:	00 00                	add    %al,(%eax)
    8a3c:	00 00                	add    %al,(%eax)
    8a3e:	00 00                	add    %al,(%eax)
    8a40:	00 00                	add    %al,(%eax)
    8a42:	00 00                	add    %al,(%eax)
    8a44:	00 00                	add    %al,(%eax)
    8a46:	00 00                	add    %al,(%eax)
    8a48:	00 00                	add    %al,(%eax)
    8a4a:	00 00                	add    %al,(%eax)
    8a4c:	00 00                	add    %al,(%eax)
    8a4e:	00 00                	add    %al,(%eax)
    8a50:	00 00                	add    %al,(%eax)
    8a52:	00 00                	add    %al,(%eax)
    8a54:	00 00                	add    %al,(%eax)
    8a56:	00 00                	add    %al,(%eax)
    8a58:	00 00                	add    %al,(%eax)
    8a5a:	00 00                	add    %al,(%eax)
    8a5c:	00 00                	add    %al,(%eax)
    8a5e:	00 00                	add    %al,(%eax)
    8a60:	00 00                	add    %al,(%eax)
    8a62:	00 00                	add    %al,(%eax)
    8a64:	00 00                	add    %al,(%eax)
    8a66:	00 00                	add    %al,(%eax)
    8a68:	00 00                	add    %al,(%eax)
    8a6a:	00 00                	add    %al,(%eax)
    8a6c:	00 00                	add    %al,(%eax)
    8a6e:	00 00                	add    %al,(%eax)
    8a70:	00 00                	add    %al,(%eax)
    8a72:	00 00                	add    %al,(%eax)
    8a74:	00 00                	add    %al,(%eax)
    8a76:	00 00                	add    %al,(%eax)
    8a78:	00 00                	add    %al,(%eax)
    8a7a:	00 00                	add    %al,(%eax)
    8a7c:	00 00                	add    %al,(%eax)
    8a7e:	00 00                	add    %al,(%eax)
    8a80:	00 00                	add    %al,(%eax)
    8a82:	00 00                	add    %al,(%eax)
    8a84:	00 00                	add    %al,(%eax)
    8a86:	00 00                	add    %al,(%eax)
    8a88:	00 00                	add    %al,(%eax)
    8a8a:	00 00                	add    %al,(%eax)
    8a8c:	00 00                	add    %al,(%eax)
    8a8e:	00 00                	add    %al,(%eax)
    8a90:	00 00                	add    %al,(%eax)
    8a92:	00 00                	add    %al,(%eax)
    8a94:	00 00                	add    %al,(%eax)
    8a96:	00 00                	add    %al,(%eax)
    8a98:	00 00                	add    %al,(%eax)
    8a9a:	00 00                	add    %al,(%eax)
    8a9c:	00 00                	add    %al,(%eax)
    8a9e:	00 00                	add    %al,(%eax)
    8aa0:	00 00                	add    %al,(%eax)
    8aa2:	00 00                	add    %al,(%eax)
    8aa4:	00 00                	add    %al,(%eax)
    8aa6:	00 00                	add    %al,(%eax)
    8aa8:	00 00                	add    %al,(%eax)
    8aaa:	00 00                	add    %al,(%eax)
    8aac:	00 00                	add    %al,(%eax)
    8aae:	00 00                	add    %al,(%eax)
    8ab0:	00 00                	add    %al,(%eax)
    8ab2:	00 00                	add    %al,(%eax)
    8ab4:	00 00                	add    %al,(%eax)
    8ab6:	00 00                	add    %al,(%eax)
    8ab8:	00 00                	add    %al,(%eax)
    8aba:	00 00                	add    %al,(%eax)
    8abc:	00 00                	add    %al,(%eax)
    8abe:	00 00                	add    %al,(%eax)
    8ac0:	00 00                	add    %al,(%eax)
    8ac2:	00 00                	add    %al,(%eax)
    8ac4:	00 00                	add    %al,(%eax)
    8ac6:	00 00                	add    %al,(%eax)
    8ac8:	00 00                	add    %al,(%eax)
    8aca:	00 00                	add    %al,(%eax)
    8acc:	00 00                	add    %al,(%eax)
    8ace:	00 00                	add    %al,(%eax)
    8ad0:	00 00                	add    %al,(%eax)
    8ad2:	00 00                	add    %al,(%eax)
    8ad4:	00 00                	add    %al,(%eax)
    8ad6:	00 00                	add    %al,(%eax)
    8ad8:	00 00                	add    %al,(%eax)
    8ada:	00 00                	add    %al,(%eax)
    8adc:	00 00                	add    %al,(%eax)
    8ade:	00 00                	add    %al,(%eax)
    8ae0:	00 00                	add    %al,(%eax)
    8ae2:	00 00                	add    %al,(%eax)
    8ae4:	00 00                	add    %al,(%eax)
    8ae6:	00 00                	add    %al,(%eax)
    8ae8:	00 00                	add    %al,(%eax)
    8aea:	00 00                	add    %al,(%eax)
    8aec:	00 00                	add    %al,(%eax)
    8aee:	00 00                	add    %al,(%eax)
    8af0:	00 00                	add    %al,(%eax)
    8af2:	00 00                	add    %al,(%eax)
    8af4:	00 00                	add    %al,(%eax)
    8af6:	00 00                	add    %al,(%eax)
    8af8:	00 00                	add    %al,(%eax)
    8afa:	00 00                	add    %al,(%eax)
    8afc:	00 00                	add    %al,(%eax)
    8afe:	00 00                	add    %al,(%eax)
    8b00:	00 00                	add    %al,(%eax)
    8b02:	00 00                	add    %al,(%eax)
    8b04:	00 00                	add    %al,(%eax)
    8b06:	00 00                	add    %al,(%eax)
    8b08:	00 00                	add    %al,(%eax)
    8b0a:	00 00                	add    %al,(%eax)
    8b0c:	00 00                	add    %al,(%eax)
    8b0e:	00 00                	add    %al,(%eax)
    8b10:	00 00                	add    %al,(%eax)
    8b12:	00 00                	add    %al,(%eax)
    8b14:	00 00                	add    %al,(%eax)
    8b16:	00 00                	add    %al,(%eax)
    8b18:	00 00                	add    %al,(%eax)
    8b1a:	00 00                	add    %al,(%eax)
    8b1c:	00 00                	add    %al,(%eax)
    8b1e:	00 00                	add    %al,(%eax)
    8b20:	00 00                	add    %al,(%eax)
    8b22:	00 00                	add    %al,(%eax)
    8b24:	00 00                	add    %al,(%eax)
    8b26:	66 90                	xchg   %ax,%ax

00008b28 <putc>:
 */
volatile char *video = (volatile char*) 0xB8000;

void
putc (int l, int color, char ch)
{
    8b28:	55                   	push   %ebp
    8b29:	89 e5                	mov    %esp,%ebp
    8b2b:	8b 45 08             	mov    0x8(%ebp),%eax
	volatile char * p = video + l * 2;
	* p = ch;
    8b2e:	8b 55 10             	mov    0x10(%ebp),%edx
volatile char *video = (volatile char*) 0xB8000;

void
putc (int l, int color, char ch)
{
	volatile char * p = video + l * 2;
    8b31:	01 c0                	add    %eax,%eax
    8b33:	03 05 84 92 00 00    	add    0x9284,%eax
	* p = ch;
    8b39:	88 10                	mov    %dl,(%eax)
	* (p + 1) = color;
    8b3b:	8b 55 0c             	mov    0xc(%ebp),%edx
    8b3e:	88 50 01             	mov    %dl,0x1(%eax)
}
    8b41:	5d                   	pop    %ebp
    8b42:	c3                   	ret    

00008b43 <puts>:


int
puts (int r, int c, int color, const char *string)
{
    8b43:	55                   	push   %ebp
    8b44:	89 e5                	mov    %esp,%ebp
    8b46:	56                   	push   %esi
    8b47:	53                   	push   %ebx
    8b48:	8b 5d 14             	mov    0x14(%ebp),%ebx
	int l = r * 80 + c;
    8b4b:	6b 45 08 50          	imul   $0x50,0x8(%ebp),%eax
    8b4f:	03 45 0c             	add    0xc(%ebp),%eax
    8b52:	29 c3                	sub    %eax,%ebx
	while (*string != 0)
    8b54:	0f be 14 03          	movsbl (%ebx,%eax,1),%edx
    8b58:	84 d2                	test   %dl,%dl
    8b5a:	74 14                	je     8b70 <puts+0x2d>
	{
		putc (l++, color, *string++);
    8b5c:	52                   	push   %edx
    8b5d:	ff 75 10             	pushl  0x10(%ebp)
    8b60:	8d 70 01             	lea    0x1(%eax),%esi
    8b63:	50                   	push   %eax
    8b64:	e8 bf ff ff ff       	call   8b28 <putc>
    8b69:	83 c4 0c             	add    $0xc,%esp
    8b6c:	89 f0                	mov    %esi,%eax
    8b6e:	eb e4                	jmp    8b54 <puts+0x11>
	}
	return l;
}
    8b70:	8d 65 f8             	lea    -0x8(%ebp),%esp
    8b73:	5b                   	pop    %ebx
    8b74:	5e                   	pop    %esi
    8b75:	5d                   	pop    %ebp
    8b76:	c3                   	ret    

00008b77 <putline>:
char * blank =
"                                                                                ";

void
putline (char * s)
{
    8b77:	55                   	push   %ebp
	puts (row = (row >= CRT_ROWS) ? 0 : row + 1, 0, VGA_CLR_BLACK, blank);
    8b78:	a1 10 93 00 00       	mov    0x9310,%eax
char * blank =
"                                                                                ";

void
putline (char * s)
{
    8b7d:	89 e5                	mov    %esp,%ebp
    8b7f:	53                   	push   %ebx
	puts (row = (row >= CRT_ROWS) ? 0 : row + 1, 0, VGA_CLR_BLACK, blank);
    8b80:	31 db                	xor    %ebx,%ebx
    8b82:	ff 35 80 92 00 00    	pushl  0x9280
    8b88:	83 f8 18             	cmp    $0x18,%eax
    8b8b:	8d 50 01             	lea    0x1(%eax),%edx
    8b8e:	0f 4e da             	cmovle %edx,%ebx
    8b91:	6a 00                	push   $0x0
    8b93:	6a 00                	push   $0x0
    8b95:	53                   	push   %ebx
    8b96:	89 1d 10 93 00 00    	mov    %ebx,0x9310
    8b9c:	e8 a2 ff ff ff       	call   8b43 <puts>
	puts (row, 0, VGA_CLR_WHITE, s);
    8ba1:	ff 75 08             	pushl  0x8(%ebp)
    8ba4:	6a 0f                	push   $0xf
    8ba6:	6a 00                	push   $0x0
    8ba8:	53                   	push   %ebx
    8ba9:	e8 95 ff ff ff       	call   8b43 <puts>
    8bae:	83 c4 20             	add    $0x20,%esp
}
    8bb1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    8bb4:	c9                   	leave  
    8bb5:	c3                   	ret    

00008bb6 <roll>:

void
roll (int r)
{
    8bb6:	55                   	push   %ebp
    8bb7:	89 e5                	mov    %esp,%ebp
	row = r;
    8bb9:	8b 45 08             	mov    0x8(%ebp),%eax
}
    8bbc:	5d                   	pop    %ebp
}

void
roll (int r)
{
	row = r;
    8bbd:	a3 10 93 00 00       	mov    %eax,0x9310
}
    8bc2:	c3                   	ret    

00008bc3 <panic>:

void
panic (char * m)
{
    8bc3:	55                   	push   %ebp
    8bc4:	89 e5                	mov    %esp,%ebp
	puts (0, 0, VGA_CLR_RED, m);
    8bc6:	ff 75 08             	pushl  0x8(%ebp)
    8bc9:	6a 04                	push   $0x4
    8bcb:	6a 00                	push   $0x0
    8bcd:	6a 00                	push   $0x0
    8bcf:	e8 6f ff ff ff       	call   8b43 <puts>
    8bd4:	83 c4 10             	add    $0x10,%esp
	while (1)
	{
		asm volatile("hlt");
    8bd7:	f4                   	hlt    
    8bd8:	eb fd                	jmp    8bd7 <panic+0x14>

00008bda <strlen>:
 * string
 */

int
strlen (const char *s)
{
    8bda:	55                   	push   %ebp
	int n;

	for (n = 0; *s != '\0'; s++)
    8bdb:	31 c0                	xor    %eax,%eax
 * string
 */

int
strlen (const char *s)
{
    8bdd:	89 e5                	mov    %esp,%ebp
    8bdf:	8b 55 08             	mov    0x8(%ebp),%edx
	int n;

	for (n = 0; *s != '\0'; s++)
    8be2:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    8be6:	74 03                	je     8beb <strlen+0x11>
		n++;
    8be8:	40                   	inc    %eax
    8be9:	eb f7                	jmp    8be2 <strlen+0x8>
	return n;
}
    8beb:	5d                   	pop    %ebp
    8bec:	c3                   	ret    

00008bed <reverse>:

/* reverse:  reverse string s in place */
void
reverse (char s[])
{
    8bed:	55                   	push   %ebp
    8bee:	89 e5                	mov    %esp,%ebp
    8bf0:	56                   	push   %esi
    8bf1:	53                   	push   %ebx
    8bf2:	8b 5d 08             	mov    0x8(%ebp),%ebx
	int i, j;
	char c;

	for (i = 0, j = strlen (s) - 1; i < j; i++, j--)
    8bf5:	53                   	push   %ebx
    8bf6:	e8 df ff ff ff       	call   8bda <strlen>
    8bfb:	5a                   	pop    %edx
    8bfc:	31 d2                	xor    %edx,%edx
    8bfe:	48                   	dec    %eax
    8bff:	39 c2                	cmp    %eax,%edx
    8c01:	7d 13                	jge    8c16 <reverse+0x29>
	{
		c = s[i];
    8c03:	0f b6 34 13          	movzbl (%ebx,%edx,1),%esi
		s[i] = s[j];
    8c07:	8a 0c 03             	mov    (%ebx,%eax,1),%cl
    8c0a:	88 0c 13             	mov    %cl,(%ebx,%edx,1)
		s[j] = c;
    8c0d:	89 f1                	mov    %esi,%ecx
reverse (char s[])
{
	int i, j;
	char c;

	for (i = 0, j = strlen (s) - 1; i < j; i++, j--)
    8c0f:	42                   	inc    %edx
	{
		c = s[i];
		s[i] = s[j];
		s[j] = c;
    8c10:	88 0c 03             	mov    %cl,(%ebx,%eax,1)
reverse (char s[])
{
	int i, j;
	char c;

	for (i = 0, j = strlen (s) - 1; i < j; i++, j--)
    8c13:	48                   	dec    %eax
    8c14:	eb e9                	jmp    8bff <reverse+0x12>
	{
		c = s[i];
		s[i] = s[j];
		s[j] = c;
	}
}
    8c16:	8d 65 f8             	lea    -0x8(%ebp),%esp
    8c19:	5b                   	pop    %ebx
    8c1a:	5e                   	pop    %esi
    8c1b:	5d                   	pop    %ebp
    8c1c:	c3                   	ret    

00008c1d <itox>:

/* itoa:  convert n to characters in s */
void
itox (int n, char s[], int root, char * table)
{
    8c1d:	55                   	push   %ebp
    8c1e:	89 e5                	mov    %esp,%ebp
    8c20:	57                   	push   %edi
    8c21:	56                   	push   %esi
    8c22:	31 f6                	xor    %esi,%esi
    8c24:	53                   	push   %ebx
    8c25:	83 ec 08             	sub    $0x8,%esp
    8c28:	8b 45 08             	mov    0x8(%ebp),%eax
    8c2b:	8b 7d 10             	mov    0x10(%ebp),%edi
    8c2e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    8c31:	89 c2                	mov    %eax,%edx
    8c33:	89 7d ec             	mov    %edi,-0x14(%ebp)
    8c36:	8b 7d 14             	mov    0x14(%ebp),%edi
    8c39:	c1 fa 1f             	sar    $0x1f,%edx
    8c3c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    8c3f:	31 d0                	xor    %edx,%eax
    8c41:	29 d0                	sub    %edx,%eax
	if ((sign = n) < 0) /* record sign */
		n = -n; /* make n positive */
	i = 0;
	do
	{ /* generate digits in reverse order */
		s[i++] = table[n % root]; /* get next digit */
    8c43:	99                   	cltd   
    8c44:	f7 7d ec             	idivl  -0x14(%ebp)
    8c47:	8d 4e 01             	lea    0x1(%esi),%ecx
    8c4a:	8a 14 17             	mov    (%edi,%edx,1),%dl
	} while ((n /= root) > 0); /* delete it */
    8c4d:	85 c0                	test   %eax,%eax
	if ((sign = n) < 0) /* record sign */
		n = -n; /* make n positive */
	i = 0;
	do
	{ /* generate digits in reverse order */
		s[i++] = table[n % root]; /* get next digit */
    8c4f:	88 54 0b ff          	mov    %dl,-0x1(%ebx,%ecx,1)
	} while ((n /= root) > 0); /* delete it */
    8c53:	7e 04                	jle    8c59 <itox+0x3c>
	if ((sign = n) < 0) /* record sign */
		n = -n; /* make n positive */
	i = 0;
	do
	{ /* generate digits in reverse order */
		s[i++] = table[n % root]; /* get next digit */
    8c55:	89 ce                	mov    %ecx,%esi
    8c57:	eb ea                	jmp    8c43 <itox+0x26>
	} while ((n /= root) > 0); /* delete it */
	if (sign < 0)
    8c59:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
	if ((sign = n) < 0) /* record sign */
		n = -n; /* make n positive */
	i = 0;
	do
	{ /* generate digits in reverse order */
		s[i++] = table[n % root]; /* get next digit */
    8c5d:	89 c8                	mov    %ecx,%eax
	} while ((n /= root) > 0); /* delete it */
	if (sign < 0)
    8c5f:	79 07                	jns    8c68 <itox+0x4b>
		s[i++] = '-';
    8c61:	8d 4e 02             	lea    0x2(%esi),%ecx
    8c64:	c6 04 03 2d          	movb   $0x2d,(%ebx,%eax,1)
	s[i] = '\0';
    8c68:	c6 04 0b 00          	movb   $0x0,(%ebx,%ecx,1)
	reverse (s);
    8c6c:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
    8c6f:	58                   	pop    %eax
    8c70:	5a                   	pop    %edx
    8c71:	5b                   	pop    %ebx
    8c72:	5e                   	pop    %esi
    8c73:	5f                   	pop    %edi
    8c74:	5d                   	pop    %ebp
		s[i++] = table[n % root]; /* get next digit */
	} while ((n /= root) > 0); /* delete it */
	if (sign < 0)
		s[i++] = '-';
	s[i] = '\0';
	reverse (s);
    8c75:	e9 73 ff ff ff       	jmp    8bed <reverse>

00008c7a <itoa>:
}

void
itoa (int n, char s[])
{
    8c7a:	55                   	push   %ebp
    8c7b:	89 e5                	mov    %esp,%ebp
	static char dec[] = "0123456789";
	itox(n, s, 10, dec);
    8c7d:	68 74 92 00 00       	push   $0x9274
    8c82:	6a 0a                	push   $0xa
    8c84:	ff 75 0c             	pushl  0xc(%ebp)
    8c87:	ff 75 08             	pushl  0x8(%ebp)
    8c8a:	e8 8e ff ff ff       	call   8c1d <itox>
    8c8f:	83 c4 10             	add    $0x10,%esp
}
    8c92:	c9                   	leave  
    8c93:	c3                   	ret    

00008c94 <itoh>:


void
itoh (int n, char* s)
{
    8c94:	55                   	push   %ebp
    8c95:	89 e5                	mov    %esp,%ebp
	static char hex[] = "0123456789abcdef";
	itox(n, s, 16, hex);
    8c97:	68 60 92 00 00       	push   $0x9260
    8c9c:	6a 10                	push   $0x10
    8c9e:	ff 75 0c             	pushl  0xc(%ebp)
    8ca1:	ff 75 08             	pushl  0x8(%ebp)
    8ca4:	e8 74 ff ff ff       	call   8c1d <itox>
    8ca9:	83 c4 10             	add    $0x10,%esp
}
    8cac:	c9                   	leave  
    8cad:	c3                   	ret    

00008cae <puti>:

static char puti_str[40];

void
puti (int32_t i)
{
    8cae:	55                   	push   %ebp
    8caf:	89 e5                	mov    %esp,%ebp
	itoh (i, puti_str);
    8cb1:	68 e8 92 00 00       	push   $0x92e8
    8cb6:	ff 75 08             	pushl  0x8(%ebp)
    8cb9:	e8 d6 ff ff ff       	call   8c94 <itoh>
	putline (puti_str);
    8cbe:	58                   	pop    %eax
    8cbf:	c7 45 08 e8 92 00 00 	movl   $0x92e8,0x8(%ebp)
    8cc6:	5a                   	pop    %edx
}
    8cc7:	c9                   	leave  

void
puti (int32_t i)
{
	itoh (i, puti_str);
	putline (puti_str);
    8cc8:	e9 aa fe ff ff       	jmp    8b77 <putline>

00008ccd <readsector>:
		/* do nothing */;
}

void
readsector (void *dst, uint32_t offset)
{
    8ccd:	55                   	push   %ebp

static inline uint8_t
inb(int port)
{
	uint8_t data;
	__asm __volatile("inb %w1,%0" : "=a" (data) : "d" (port));
    8cce:	ba f7 01 00 00       	mov    $0x1f7,%edx
    8cd3:	89 e5                	mov    %esp,%ebp
    8cd5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    8cd8:	57                   	push   %edi
    8cd9:	ec                   	in     (%dx),%al
 */
static void
waitdisk (void)
{
	// wait for disk reaady
	while ((inb (0x1F7) & 0xC0) != 0x40)
    8cda:	83 e0 c0             	and    $0xffffffc0,%eax
    8cdd:	3c 40                	cmp    $0x40,%al
    8cdf:	75 f8                	jne    8cd9 <readsector+0xc>
 * x86 instructions
 */
static inline void
outb(int port, uint8_t data)
{
	__asm __volatile("outb %0,%w1" : : "a" (data), "d" (port));
    8ce1:	ba f2 01 00 00       	mov    $0x1f2,%edx
    8ce6:	b0 01                	mov    $0x1,%al
    8ce8:	ee                   	out    %al,(%dx)
    8ce9:	0f b6 c1             	movzbl %cl,%eax
    8cec:	b2 f3                	mov    $0xf3,%dl
    8cee:	ee                   	out    %al,(%dx)
    8cef:	0f b6 c5             	movzbl %ch,%eax
    8cf2:	b2 f4                	mov    $0xf4,%dl
    8cf4:	ee                   	out    %al,(%dx)
	waitdisk ();

	outb (0x1F2, 1);		// count = 1
	outb (0x1F3, offset);
	outb (0x1F4, offset >> 8);
	outb (0x1F5, offset >> 16);
    8cf5:	89 c8                	mov    %ecx,%eax
    8cf7:	b2 f5                	mov    $0xf5,%dl
    8cf9:	c1 e8 10             	shr    $0x10,%eax
    8cfc:	0f b6 c0             	movzbl %al,%eax
    8cff:	ee                   	out    %al,(%dx)
	outb (0x1F6, (offset >> 24) | 0xE0);
    8d00:	c1 e9 18             	shr    $0x18,%ecx
    8d03:	b2 f6                	mov    $0xf6,%dl
    8d05:	88 c8                	mov    %cl,%al
    8d07:	83 c8 e0             	or     $0xffffffe0,%eax
    8d0a:	ee                   	out    %al,(%dx)
    8d0b:	b0 20                	mov    $0x20,%al
    8d0d:	b2 f7                	mov    $0xf7,%dl
    8d0f:	ee                   	out    %al,(%dx)

static inline uint8_t
inb(int port)
{
	uint8_t data;
	__asm __volatile("inb %w1,%0" : "=a" (data) : "d" (port));
    8d10:	ec                   	in     (%dx),%al
 */
static void
waitdisk (void)
{
	// wait for disk reaady
	while ((inb (0x1F7) & 0xC0) != 0x40)
    8d11:	83 e0 c0             	and    $0xffffffc0,%eax
    8d14:	3c 40                	cmp    $0x40,%al
    8d16:	75 f8                	jne    8d10 <readsector+0x43>
}

static inline void
insl(int port, void *addr, int cnt)
{
	__asm __volatile("cld\n\trepne\n\tinsl"			:
    8d18:	8b 7d 08             	mov    0x8(%ebp),%edi
    8d1b:	b9 80 00 00 00       	mov    $0x80,%ecx
    8d20:	ba f0 01 00 00       	mov    $0x1f0,%edx
    8d25:	fc                   	cld    
    8d26:	f2 6d                	repnz insl (%dx),%es:(%edi)
	// wait for disk to be ready
	waitdisk ();

	// read a sector
	insl (0x1F0, dst, SECTOR_SIZE / 4);
}
    8d28:	5f                   	pop    %edi
    8d29:	5d                   	pop    %ebp
    8d2a:	c3                   	ret    

00008d2b <readsection>:

// Read 'count' bytes at 'offset' from kernel into virtual address 'va'.
// Might copy more than asked
void
readsection (uint32_t va, uint32_t count, uint32_t offset, uint32_t lba)
{
    8d2b:	55                   	push   %ebp
    8d2c:	89 e5                	mov    %esp,%ebp
    8d2e:	57                   	push   %edi
    8d2f:	56                   	push   %esi
    8d30:	8b 75 08             	mov    0x8(%ebp),%esi
    8d33:	53                   	push   %ebx
    8d34:	8b 5d 10             	mov    0x10(%ebp),%ebx
	uint32_t end_va;

	va &= 0xFFFFFF;
    8d37:	89 f7                	mov    %esi,%edi
	end_va = va + count;
	// round down to sector boundary
	va &= ~(SECTOR_SIZE - 1);
    8d39:	81 e6 00 fe ff 00    	and    $0xfffe00,%esi
void
readsection (uint32_t va, uint32_t count, uint32_t offset, uint32_t lba)
{
	uint32_t end_va;

	va &= 0xFFFFFF;
    8d3f:	81 e7 ff ff ff 00    	and    $0xffffff,%edi
	end_va = va + count;
	// round down to sector boundary
	va &= ~(SECTOR_SIZE - 1);

	// translate from bytes to sectors, and kernel starts at sector 1
	offset = (offset / SECTOR_SIZE) + lba;
    8d45:	c1 eb 09             	shr    $0x9,%ebx
readsection (uint32_t va, uint32_t count, uint32_t offset, uint32_t lba)
{
	uint32_t end_va;

	va &= 0xFFFFFF;
	end_va = va + count;
    8d48:	03 7d 0c             	add    0xc(%ebp),%edi
	// round down to sector boundary
	va &= ~(SECTOR_SIZE - 1);

	// translate from bytes to sectors, and kernel starts at sector 1
	offset = (offset / SECTOR_SIZE) + lba;
    8d4b:	03 5d 14             	add    0x14(%ebp),%ebx

	// If this is too slow, we could read lots of sectors at a time.
	// We'd write more to memory than asked, but it doesn't matter --
	// we load in increasing order.
	while (va < end_va)
    8d4e:	39 fe                	cmp    %edi,%esi
    8d50:	73 12                	jae    8d64 <readsection+0x39>
	{
		readsector ((uint8_t*) va, offset);
    8d52:	53                   	push   %ebx
		va += SECTOR_SIZE;
		offset++;
    8d53:	43                   	inc    %ebx
	// If this is too slow, we could read lots of sectors at a time.
	// We'd write more to memory than asked, but it doesn't matter --
	// we load in increasing order.
	while (va < end_va)
	{
		readsector ((uint8_t*) va, offset);
    8d54:	56                   	push   %esi
		va += SECTOR_SIZE;
    8d55:	81 c6 00 02 00 00    	add    $0x200,%esi
	// If this is too slow, we could read lots of sectors at a time.
	// We'd write more to memory than asked, but it doesn't matter --
	// we load in increasing order.
	while (va < end_va)
	{
		readsector ((uint8_t*) va, offset);
    8d5b:	e8 6d ff ff ff       	call   8ccd <readsector>
		va += SECTOR_SIZE;
		offset++;
    8d60:	58                   	pop    %eax
    8d61:	5a                   	pop    %edx
    8d62:	eb ea                	jmp    8d4e <readsection+0x23>
	}
}
    8d64:	8d 65 f4             	lea    -0xc(%ebp),%esp
    8d67:	5b                   	pop    %ebx
    8d68:	5e                   	pop    %esi
    8d69:	5f                   	pop    %edi
    8d6a:	5d                   	pop    %ebp
    8d6b:	c3                   	ret    

00008d6c <load_kernel>:

#define ELFHDR		((elfhdr *) 0x20000)

uint32_t
load_kernel(uint32_t dkernel)
{
    8d6c:	55                   	push   %ebp
    8d6d:	89 e5                	mov    %esp,%ebp
    8d6f:	57                   	push   %edi
    8d70:	56                   	push   %esi
    8d71:	53                   	push   %ebx
    8d72:	83 ec 0c             	sub    $0xc,%esp
    8d75:	8b 75 08             	mov    0x8(%ebp),%esi
	// load kernel from the beginning of the first bootable partition
	proghdr *ph, *eph;

	readsection((uint32_t) ELFHDR, SECTOR_SIZE * 8, 0, dkernel);
    8d78:	56                   	push   %esi
    8d79:	6a 00                	push   $0x0
    8d7b:	68 00 10 00 00       	push   $0x1000
    8d80:	68 00 00 02 00       	push   $0x20000
    8d85:	e8 a1 ff ff ff       	call   8d2b <readsection>

	// is this a valid ELF?
	if (ELFHDR->e_magic != ELF_MAGIC)
    8d8a:	83 c4 10             	add    $0x10,%esp
    8d8d:	81 3d 00 00 02 00 7f 	cmpl   $0x464c457f,0x20000
    8d94:	45 4c 46 
    8d97:	74 10                	je     8da9 <load_kernel+0x3d>
		panic ("Kernel is not a valid elf.");
    8d99:	83 ec 0c             	sub    $0xc,%esp
    8d9c:	68 55 8f 00 00       	push   $0x8f55
    8da1:	e8 1d fe ff ff       	call   8bc3 <panic>
    8da6:	83 c4 10             	add    $0x10,%esp

	// load each program segment (ignores ph flags)
	ph = (proghdr *) ((uint8_t *) ELFHDR + ELFHDR->e_phoff);
    8da9:	a1 1c 00 02 00       	mov    0x2001c,%eax
    8dae:	8d 98 00 00 02 00    	lea    0x20000(%eax),%ebx
	eph = ph + ELFHDR->e_phnum;
    8db4:	0f b7 05 2c 00 02 00 	movzwl 0x2002c,%eax
    8dbb:	c1 e0 05             	shl    $0x5,%eax
    8dbe:	8d 3c 03             	lea    (%ebx,%eax,1),%edi

	for (; ph < eph; ph++)
    8dc1:	39 fb                	cmp    %edi,%ebx
    8dc3:	73 17                	jae    8ddc <load_kernel+0x70>
	{
		readsection(ph->p_va, ph->p_memsz, ph->p_offset, dkernel);
    8dc5:	56                   	push   %esi

	// load each program segment (ignores ph flags)
	ph = (proghdr *) ((uint8_t *) ELFHDR + ELFHDR->e_phoff);
	eph = ph + ELFHDR->e_phnum;

	for (; ph < eph; ph++)
    8dc6:	83 c3 20             	add    $0x20,%ebx
	{
		readsection(ph->p_va, ph->p_memsz, ph->p_offset, dkernel);
    8dc9:	ff 73 e4             	pushl  -0x1c(%ebx)
    8dcc:	ff 73 f4             	pushl  -0xc(%ebx)
    8dcf:	ff 73 e8             	pushl  -0x18(%ebx)
    8dd2:	e8 54 ff ff ff       	call   8d2b <readsection>

	// load each program segment (ignores ph flags)
	ph = (proghdr *) ((uint8_t *) ELFHDR + ELFHDR->e_phoff);
	eph = ph + ELFHDR->e_phnum;

	for (; ph < eph; ph++)
    8dd7:	83 c4 10             	add    $0x10,%esp
    8dda:	eb e5                	jmp    8dc1 <load_kernel+0x55>
	{
		readsection(ph->p_va, ph->p_memsz, ph->p_offset, dkernel);
	}

	return (ELFHDR->e_entry & 0xFFFFFF);
    8ddc:	a1 18 00 02 00       	mov    0x20018,%eax
}
    8de1:	8d 65 f4             	lea    -0xc(%ebp),%esp
    8de4:	5b                   	pop    %ebx
    8de5:	5e                   	pop    %esi
    8de6:	5f                   	pop    %edi
	for (; ph < eph; ph++)
	{
		readsection(ph->p_va, ph->p_memsz, ph->p_offset, dkernel);
	}

	return (ELFHDR->e_entry & 0xFFFFFF);
    8de7:	25 ff ff ff 00       	and    $0xffffff,%eax
}
    8dec:	5d                   	pop    %ebp
    8ded:	c3                   	ret    

00008dee <parse_e820>:

mboot_info_t *
parse_e820 (bios_smap_t *smap)
{
    8dee:	55                   	push   %ebp
    8def:	89 e5                	mov    %esp,%ebp
    8df1:	56                   	push   %esi
    8df2:	8b 75 08             	mov    0x8(%ebp),%esi
    8df5:	53                   	push   %ebx
	bios_smap_t *p;
	uint32_t mmap_len;
	p = smap;
	mmap_len = 0;
	putline ("* E820 Memory Map *");
    8df6:	83 ec 0c             	sub    $0xc,%esp
    8df9:	68 70 8f 00 00       	push   $0x8f70
    8dfe:	e8 74 fd ff ff       	call   8b77 <putline>
mboot_info_t *
parse_e820 (bios_smap_t *smap)
{
	bios_smap_t *p;
	uint32_t mmap_len;
	p = smap;
    8e03:	89 f3                	mov    %esi,%ebx
	mmap_len = 0;
	putline ("* E820 Memory Map *");
	while (p->base_addr != 0 || p->length != 0 || p->type != 0)
    8e05:	83 c4 10             	add    $0x10,%esp
    8e08:	8b 43 04             	mov    0x4(%ebx),%eax
    8e0b:	89 da                	mov    %ebx,%edx
    8e0d:	29 f2                	sub    %esi,%edx
    8e0f:	89 c1                	mov    %eax,%ecx
    8e11:	0b 4b 08             	or     0x8(%ebx),%ecx
    8e14:	74 11                	je     8e27 <parse_e820+0x39>
	{
		puti (p->base_addr);
    8e16:	83 ec 0c             	sub    $0xc,%esp
		p ++;
    8e19:	83 c3 18             	add    $0x18,%ebx
	p = smap;
	mmap_len = 0;
	putline ("* E820 Memory Map *");
	while (p->base_addr != 0 || p->length != 0 || p->type != 0)
	{
		puti (p->base_addr);
    8e1c:	50                   	push   %eax
    8e1d:	e8 8c fe ff ff       	call   8cae <puti>
		p ++;
    8e22:	83 c4 10             	add    $0x10,%esp
    8e25:	eb e1                	jmp    8e08 <parse_e820+0x1a>
	bios_smap_t *p;
	uint32_t mmap_len;
	p = smap;
	mmap_len = 0;
	putline ("* E820 Memory Map *");
	while (p->base_addr != 0 || p->length != 0 || p->type != 0)
    8e27:	8b 4b 10             	mov    0x10(%ebx),%ecx
    8e2a:	0b 4b 0c             	or     0xc(%ebx),%ecx
    8e2d:	75 e7                	jne    8e16 <parse_e820+0x28>
    8e2f:	83 7b 14 00          	cmpl   $0x0,0x14(%ebx)
    8e33:	75 e1                	jne    8e16 <parse_e820+0x28>
		puti (p->base_addr);
		p ++;
		mmap_len += sizeof(bios_smap_t);
	}
	mboot_info.mmap_length = mmap_len;
	mboot_info.mmap_addr = (uint32_t) smap;
    8e35:	89 35 b8 92 00 00    	mov    %esi,0x92b8
	return &mboot_info;
}
    8e3b:	b8 88 92 00 00       	mov    $0x9288,%eax
	{
		puti (p->base_addr);
		p ++;
		mmap_len += sizeof(bios_smap_t);
	}
	mboot_info.mmap_length = mmap_len;
    8e40:	89 15 b4 92 00 00    	mov    %edx,0x92b4
	mboot_info.mmap_addr = (uint32_t) smap;
	return &mboot_info;
}
    8e46:	8d 65 f8             	lea    -0x8(%ebp),%esp
    8e49:	5b                   	pop    %ebx
    8e4a:	5e                   	pop    %esi
    8e4b:	5d                   	pop    %ebp
    8e4c:	c3                   	ret    

00008e4d <boot1main>:
mboot_info_t mboot_info =
	{ .flags = (1 << 6), };

void
boot1main (uint32_t dev, mbr_t * mbr, bios_smap_t *smap)
{
    8e4d:	55                   	push   %ebp
    8e4e:	89 e5                	mov    %esp,%ebp
    8e50:	56                   	push   %esi
    8e51:	8b 75 0c             	mov    0xc(%ebp),%esi
    8e54:	53                   	push   %ebx
    8e55:	8b 5d 10             	mov    0x10(%ebp),%ebx
	roll(3); putline("Start boot1 main ...");
    8e58:	83 ec 0c             	sub    $0xc,%esp
    8e5b:	6a 03                	push   $0x3
    8e5d:	e8 54 fd ff ff       	call   8bb6 <roll>
    8e62:	c7 04 24 84 8f 00 00 	movl   $0x8f84,(%esp)
    8e69:	e8 09 fd ff ff       	call   8b77 <putline>
    8e6e:	83 c4 10             	add    $0x10,%esp

	// search bootable partition
	int i;
	uint32_t bootable_lba = 0;
	for (i = 0; i < 4; i++)
    8e71:	31 c0                	xor    %eax,%eax
    8e73:	89 c2                	mov    %eax,%edx
    8e75:	c1 e2 04             	shl    $0x4,%edx
	{
		if ( mbr->partition[i].bootable == BOOTABLE_PARTITION)
    8e78:	80 bc 16 be 01 00 00 	cmpb   $0x80,0x1be(%esi,%edx,1)
    8e7f:	80 
    8e80:	75 0c                	jne    8e8e <boot1main+0x41>
		{
			bootable_lba = mbr->partition[i].first_lba;
    8e82:	83 c0 1b             	add    $0x1b,%eax
    8e85:	c1 e0 04             	shl    $0x4,%eax
    8e88:	8b 74 06 16          	mov    0x16(%esi,%eax,1),%esi
    8e8c:	eb 18                	jmp    8ea6 <boot1main+0x59>
	roll(3); putline("Start boot1 main ...");

	// search bootable partition
	int i;
	uint32_t bootable_lba = 0;
	for (i = 0; i < 4; i++)
    8e8e:	40                   	inc    %eax
    8e8f:	83 f8 04             	cmp    $0x4,%eax
    8e92:	75 df                	jne    8e73 <boot1main+0x26>
			break;
		}
	}

	if (i == 4)
		panic ("Cannot find bootable partition!");
    8e94:	83 ec 0c             	sub    $0xc,%esp
{
	roll(3); putline("Start boot1 main ...");

	// search bootable partition
	int i;
	uint32_t bootable_lba = 0;
    8e97:	31 f6                	xor    %esi,%esi
			break;
		}
	}

	if (i == 4)
		panic ("Cannot find bootable partition!");
    8e99:	68 d1 8f 00 00       	push   $0x8fd1
    8e9e:	e8 20 fd ff ff       	call   8bc3 <panic>
    8ea3:	83 c4 10             	add    $0x10,%esp

	parse_e820 (smap);
    8ea6:	83 ec 0c             	sub    $0xc,%esp
    8ea9:	53                   	push   %ebx
    8eaa:	e8 3f ff ff ff       	call   8dee <parse_e820>

	putline ("Load kernel ...\n");
    8eaf:	c7 04 24 99 8f 00 00 	movl   $0x8f99,(%esp)
    8eb6:	e8 bc fc ff ff       	call   8b77 <putline>
	uint32_t entry = load_kernel(bootable_lba);
    8ebb:	89 34 24             	mov    %esi,(%esp)
    8ebe:	e8 a9 fe ff ff       	call   8d6c <load_kernel>

	putline ("Start kernel ...\n");
    8ec3:	c7 04 24 aa 8f 00 00 	movl   $0x8faa,(%esp)
		panic ("Cannot find bootable partition!");

	parse_e820 (smap);

	putline ("Load kernel ...\n");
	uint32_t entry = load_kernel(bootable_lba);
    8eca:	89 c3                	mov    %eax,%ebx

	putline ("Start kernel ...\n");
    8ecc:	e8 a6 fc ff ff       	call   8b77 <putline>

	exec_kernel (entry, &mboot_info);
    8ed1:	58                   	pop    %eax
    8ed2:	5a                   	pop    %edx
    8ed3:	68 88 92 00 00       	push   $0x9288
    8ed8:	53                   	push   %ebx
    8ed9:	e8 16 00 00 00       	call   8ef4 <exec_kernel>

	panic ("Fail to load kernel.");
    8ede:	83 c4 10             	add    $0x10,%esp
    8ee1:	c7 45 08 bc 8f 00 00 	movl   $0x8fbc,0x8(%ebp)

}
    8ee8:	8d 65 f8             	lea    -0x8(%ebp),%esp
    8eeb:	5b                   	pop    %ebx
    8eec:	5e                   	pop    %esi
    8eed:	5d                   	pop    %ebp

	putline ("Start kernel ...\n");

	exec_kernel (entry, &mboot_info);

	panic ("Fail to load kernel.");
    8eee:	e9 d0 fc ff ff       	jmp    8bc3 <panic>
    8ef3:	90                   	nop

00008ef4 <exec_kernel>:
	.set  MBOOT_INFO_MAGIC, 0x2badb002

	.globl	exec_kernel
	.code32
exec_kernel:
	cli
    8ef4:	fa                   	cli    
	movl	$MBOOT_INFO_MAGIC, %eax
    8ef5:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
	movl	8(%esp), %ebx
    8efa:	8b 5c 24 08          	mov    0x8(%esp),%ebx
	movl	4(%esp), %edx
    8efe:	8b 54 24 04          	mov    0x4(%esp),%edx
	jmp	*%edx
    8f02:	ff e2                	jmp    *%edx

Disassembly of section .rodata:

00008f04 <.rodata>:
    8f04:	20 20                	and    %ah,(%eax)
    8f06:	20 20                	and    %ah,(%eax)
    8f08:	20 20                	and    %ah,(%eax)
    8f0a:	20 20                	and    %ah,(%eax)
    8f0c:	20 20                	and    %ah,(%eax)
    8f0e:	20 20                	and    %ah,(%eax)
    8f10:	20 20                	and    %ah,(%eax)
    8f12:	20 20                	and    %ah,(%eax)
    8f14:	20 20                	and    %ah,(%eax)
    8f16:	20 20                	and    %ah,(%eax)
    8f18:	20 20                	and    %ah,(%eax)
    8f1a:	20 20                	and    %ah,(%eax)
    8f1c:	20 20                	and    %ah,(%eax)
    8f1e:	20 20                	and    %ah,(%eax)
    8f20:	20 20                	and    %ah,(%eax)
    8f22:	20 20                	and    %ah,(%eax)
    8f24:	20 20                	and    %ah,(%eax)
    8f26:	20 20                	and    %ah,(%eax)
    8f28:	20 20                	and    %ah,(%eax)
    8f2a:	20 20                	and    %ah,(%eax)
    8f2c:	20 20                	and    %ah,(%eax)
    8f2e:	20 20                	and    %ah,(%eax)
    8f30:	20 20                	and    %ah,(%eax)
    8f32:	20 20                	and    %ah,(%eax)
    8f34:	20 20                	and    %ah,(%eax)
    8f36:	20 20                	and    %ah,(%eax)
    8f38:	20 20                	and    %ah,(%eax)
    8f3a:	20 20                	and    %ah,(%eax)
    8f3c:	20 20                	and    %ah,(%eax)
    8f3e:	20 20                	and    %ah,(%eax)
    8f40:	20 20                	and    %ah,(%eax)
    8f42:	20 20                	and    %ah,(%eax)
    8f44:	20 20                	and    %ah,(%eax)
    8f46:	20 20                	and    %ah,(%eax)
    8f48:	20 20                	and    %ah,(%eax)
    8f4a:	20 20                	and    %ah,(%eax)
    8f4c:	20 20                	and    %ah,(%eax)
    8f4e:	20 20                	and    %ah,(%eax)
    8f50:	20 20                	and    %ah,(%eax)
    8f52:	20 20                	and    %ah,(%eax)
    8f54:	00 4b 65             	add    %cl,0x65(%ebx)
    8f57:	72 6e                	jb     8fc7 <exec_kernel+0xd3>
    8f59:	65                   	gs
    8f5a:	6c                   	insb   (%dx),%es:(%edi)
    8f5b:	20 69 73             	and    %ch,0x73(%ecx)
    8f5e:	20 6e 6f             	and    %ch,0x6f(%esi)
    8f61:	74 20                	je     8f83 <exec_kernel+0x8f>
    8f63:	61                   	popa   
    8f64:	20 76 61             	and    %dh,0x61(%esi)
    8f67:	6c                   	insb   (%dx),%es:(%edi)
    8f68:	69 64 20 65 6c 66 2e 	imul   $0x2e666c,0x65(%eax,%eiz,1),%esp
    8f6f:	00 
    8f70:	2a 20                	sub    (%eax),%ah
    8f72:	45                   	inc    %ebp
    8f73:	38 32                	cmp    %dh,(%edx)
    8f75:	30 20                	xor    %ah,(%eax)
    8f77:	4d                   	dec    %ebp
    8f78:	65                   	gs
    8f79:	6d                   	insl   (%dx),%es:(%edi)
    8f7a:	6f                   	outsl  %ds:(%esi),(%dx)
    8f7b:	72 79                	jb     8ff6 <exec_kernel+0x102>
    8f7d:	20 4d 61             	and    %cl,0x61(%ebp)
    8f80:	70 20                	jo     8fa2 <exec_kernel+0xae>
    8f82:	2a 00                	sub    (%eax),%al
    8f84:	53                   	push   %ebx
    8f85:	74 61                	je     8fe8 <exec_kernel+0xf4>
    8f87:	72 74                	jb     8ffd <exec_kernel+0x109>
    8f89:	20 62 6f             	and    %ah,0x6f(%edx)
    8f8c:	6f                   	outsl  %ds:(%esi),(%dx)
    8f8d:	74 31                	je     8fc0 <exec_kernel+0xcc>
    8f8f:	20 6d 61             	and    %ch,0x61(%ebp)
    8f92:	69 6e 20 2e 2e 2e 00 	imul   $0x2e2e2e,0x20(%esi),%ebp
    8f99:	4c                   	dec    %esp
    8f9a:	6f                   	outsl  %ds:(%esi),(%dx)
    8f9b:	61                   	popa   
    8f9c:	64 20 6b 65          	and    %ch,%fs:0x65(%ebx)
    8fa0:	72 6e                	jb     9010 <exec_kernel+0x11c>
    8fa2:	65                   	gs
    8fa3:	6c                   	insb   (%dx),%es:(%edi)
    8fa4:	20 2e                	and    %ch,(%esi)
    8fa6:	2e 2e 0a 00          	cs or  %cs:(%eax),%al
    8faa:	53                   	push   %ebx
    8fab:	74 61                	je     900e <exec_kernel+0x11a>
    8fad:	72 74                	jb     9023 <exec_kernel+0x12f>
    8faf:	20 6b 65             	and    %ch,0x65(%ebx)
    8fb2:	72 6e                	jb     9022 <exec_kernel+0x12e>
    8fb4:	65                   	gs
    8fb5:	6c                   	insb   (%dx),%es:(%edi)
    8fb6:	20 2e                	and    %ch,(%esi)
    8fb8:	2e 2e 0a 00          	cs or  %cs:(%eax),%al
    8fbc:	46                   	inc    %esi
    8fbd:	61                   	popa   
    8fbe:	69 6c 20 74 6f 20 6c 	imul   $0x6f6c206f,0x74(%eax,%eiz,1),%ebp
    8fc5:	6f 
    8fc6:	61                   	popa   
    8fc7:	64 20 6b 65          	and    %ch,%fs:0x65(%ebx)
    8fcb:	72 6e                	jb     903b <exec_kernel+0x147>
    8fcd:	65                   	gs
    8fce:	6c                   	insb   (%dx),%es:(%edi)
    8fcf:	2e 00 43 61          	add    %al,%cs:0x61(%ebx)
    8fd3:	6e                   	outsb  %ds:(%esi),(%dx)
    8fd4:	6e                   	outsb  %ds:(%esi),(%dx)
    8fd5:	6f                   	outsl  %ds:(%esi),(%dx)
    8fd6:	74 20                	je     8ff8 <exec_kernel+0x104>
    8fd8:	66 69 6e 64 20 62    	imul   $0x6220,0x64(%esi),%bp
    8fde:	6f                   	outsl  %ds:(%esi),(%dx)
    8fdf:	6f                   	outsl  %ds:(%esi),(%dx)
    8fe0:	74 61                	je     9043 <exec_kernel+0x14f>
    8fe2:	62 6c 65 20          	bound  %ebp,0x20(%ebp,%eiz,2)
    8fe6:	70 61                	jo     9049 <exec_kernel+0x155>
    8fe8:	72 74                	jb     905e <exec_kernel+0x16a>
    8fea:	69                   	.byte 0x69
    8feb:	74 69                	je     9056 <exec_kernel+0x162>
    8fed:	6f                   	outsl  %ds:(%esi),(%dx)
    8fee:	6e                   	outsb  %ds:(%esi),(%dx)
    8fef:	21 00                	and    %eax,(%eax)

Disassembly of section .eh_frame:

00008ff4 <.eh_frame>:
    8ff4:	14 00                	adc    $0x0,%al
    8ff6:	00 00                	add    %al,(%eax)
    8ff8:	00 00                	add    %al,(%eax)
    8ffa:	00 00                	add    %al,(%eax)
    8ffc:	01 7a 52             	add    %edi,0x52(%edx)
    8fff:	00 01                	add    %al,(%ecx)
    9001:	7c 08                	jl     900b <exec_kernel+0x117>
    9003:	01 1b                	add    %ebx,(%ebx)
    9005:	0c 04                	or     $0x4,%al
    9007:	04 88                	add    $0x88,%al
    9009:	01 00                	add    %eax,(%eax)
    900b:	00 1c 00             	add    %bl,(%eax,%eax,1)
    900e:	00 00                	add    %al,(%eax)
    9010:	1c 00                	sbb    $0x0,%al
    9012:	00 00                	add    %al,(%eax)
    9014:	14 fb                	adc    $0xfb,%al
    9016:	ff                   	(bad)  
    9017:	ff 1b                	lcall  *(%ebx)
    9019:	00 00                	add    %al,(%eax)
    901b:	00 00                	add    %al,(%eax)
    901d:	41                   	inc    %ecx
    901e:	0e                   	push   %cs
    901f:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    9025:	57                   	push   %edi
    9026:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    9029:	04 00                	add    $0x0,%al
    902b:	00 24 00             	add    %ah,(%eax,%eax,1)
    902e:	00 00                	add    %al,(%eax)
    9030:	3c 00                	cmp    $0x0,%al
    9032:	00 00                	add    %al,(%eax)
    9034:	0f fb ff             	psubq  %mm7,%mm7
    9037:	ff 34 00             	pushl  (%eax,%eax,1)
    903a:	00 00                	add    %al,(%eax)
    903c:	00 41 0e             	add    %al,0xe(%ecx)
    903f:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    9045:	42                   	inc    %edx
    9046:	86 03                	xchg   %al,(%ebx)
    9048:	83 04 6c c3          	addl   $0xffffffc3,(%esp,%ebp,2)
    904c:	41                   	inc    %ecx
    904d:	c6 41 c5 0c          	movb   $0xc,-0x3b(%ecx)
    9051:	04 04                	add    $0x4,%al
    9053:	00 20                	add    %ah,(%eax)
    9055:	00 00                	add    %al,(%eax)
    9057:	00 64 00 00          	add    %ah,0x0(%eax,%eax,1)
    905b:	00 1b                	add    %bl,(%ebx)
    905d:	fb                   	sti    
    905e:	ff                   	(bad)  
    905f:	ff                   	(bad)  
    9060:	3f                   	aas    
    9061:	00 00                	add    %al,(%eax)
    9063:	00 00                	add    %al,(%eax)
    9065:	41                   	inc    %ecx
    9066:	0e                   	push   %cs
    9067:	08 85 02 47 0d 05    	or     %al,0x50d4702(%ebp)
    906d:	41                   	inc    %ecx
    906e:	83 03 75             	addl   $0x75,(%ebx)
    9071:	c5 c3 0c             	(bad)  
    9074:	04 04                	add    $0x4,%al
    9076:	00 00                	add    %al,(%eax)
    9078:	1c 00                	sbb    $0x0,%al
    907a:	00 00                	add    %al,(%eax)
    907c:	88 00                	mov    %al,(%eax)
    907e:	00 00                	add    %al,(%eax)
    9080:	36                   	ss
    9081:	fb                   	sti    
    9082:	ff                   	(bad)  
    9083:	ff 0d 00 00 00 00    	decl   0x0
    9089:	41                   	inc    %ecx
    908a:	0e                   	push   %cs
    908b:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    9091:	44                   	inc    %esp
    9092:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    9095:	04 00                	add    $0x0,%al
    9097:	00 18                	add    %bl,(%eax)
    9099:	00 00                	add    %al,(%eax)
    909b:	00 a8 00 00 00 23    	add    %ch,0x23000000(%eax)
    90a1:	fb                   	sti    
    90a2:	ff                   	(bad)  
    90a3:	ff 17                	call   *(%edi)
    90a5:	00 00                	add    %al,(%eax)
    90a7:	00 00                	add    %al,(%eax)
    90a9:	41                   	inc    %ecx
    90aa:	0e                   	push   %cs
    90ab:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    90b1:	00 00                	add    %al,(%eax)
    90b3:	00 1c 00             	add    %bl,(%eax,%eax,1)
    90b6:	00 00                	add    %al,(%eax)
    90b8:	c4 00                	les    (%eax),%eax
    90ba:	00 00                	add    %al,(%eax)
    90bc:	1e                   	push   %ds
    90bd:	fb                   	sti    
    90be:	ff                   	(bad)  
    90bf:	ff 13                	call   *(%ebx)
    90c1:	00 00                	add    %al,(%eax)
    90c3:	00 00                	add    %al,(%eax)
    90c5:	41                   	inc    %ecx
    90c6:	0e                   	push   %cs
    90c7:	08 85 02 44 0d 05    	or     %al,0x50d4402(%ebp)
    90cd:	4d                   	dec    %ebp
    90ce:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    90d1:	04 00                	add    $0x0,%al
    90d3:	00 24 00             	add    %ah,(%eax,%eax,1)
    90d6:	00 00                	add    %al,(%eax)
    90d8:	e4 00                	in     $0x0,%al
    90da:	00 00                	add    %al,(%eax)
    90dc:	11 fb                	adc    %edi,%ebx
    90de:	ff                   	(bad)  
    90df:	ff 30                	pushl  (%eax)
    90e1:	00 00                	add    %al,(%eax)
    90e3:	00 00                	add    %al,(%eax)
    90e5:	41                   	inc    %ecx
    90e6:	0e                   	push   %cs
    90e7:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    90ed:	42                   	inc    %edx
    90ee:	86 03                	xchg   %al,(%ebx)
    90f0:	83 04 68 c3          	addl   $0xffffffc3,(%eax,%ebp,2)
    90f4:	41                   	inc    %ecx
    90f5:	c6 41 c5 0c          	movb   $0xc,-0x3b(%ecx)
    90f9:	04 04                	add    $0x4,%al
    90fb:	00 2c 00             	add    %ch,(%eax,%eax,1)
    90fe:	00 00                	add    %al,(%eax)
    9100:	0c 01                	or     $0x1,%al
    9102:	00 00                	add    %al,(%eax)
    9104:	19 fb                	sbb    %edi,%ebx
    9106:	ff                   	(bad)  
    9107:	ff 5d 00             	lcall  *0x0(%ebp)
    910a:	00 00                	add    %al,(%eax)
    910c:	00 41 0e             	add    %al,0xe(%ecx)
    910f:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    9115:	42                   	inc    %edx
    9116:	87 03                	xchg   %eax,(%ebx)
    9118:	86 04 46             	xchg   %al,(%esi,%eax,2)
    911b:	83 05 02 4a c3 41 c6 	addl   $0xffffffc6,0x41c34a02
    9122:	41                   	inc    %ecx
    9123:	c7 41 c5 0c 04 04 00 	movl   $0x4040c,-0x3b(%ecx)
    912a:	00 00                	add    %al,(%eax)
    912c:	1c 00                	sbb    $0x0,%al
    912e:	00 00                	add    %al,(%eax)
    9130:	3c 01                	cmp    $0x1,%al
    9132:	00 00                	add    %al,(%eax)
    9134:	46                   	inc    %esi
    9135:	fb                   	sti    
    9136:	ff                   	(bad)  
    9137:	ff 1a                	lcall  *(%edx)
    9139:	00 00                	add    %al,(%eax)
    913b:	00 00                	add    %al,(%eax)
    913d:	41                   	inc    %ecx
    913e:	0e                   	push   %cs
    913f:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    9145:	56                   	push   %esi
    9146:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    9149:	04 00                	add    $0x0,%al
    914b:	00 1c 00             	add    %bl,(%eax,%eax,1)
    914e:	00 00                	add    %al,(%eax)
    9150:	5c                   	pop    %esp
    9151:	01 00                	add    %eax,(%eax)
    9153:	00 40 fb             	add    %al,-0x5(%eax)
    9156:	ff                   	(bad)  
    9157:	ff 1a                	lcall  *(%edx)
    9159:	00 00                	add    %al,(%eax)
    915b:	00 00                	add    %al,(%eax)
    915d:	41                   	inc    %ecx
    915e:	0e                   	push   %cs
    915f:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    9165:	56                   	push   %esi
    9166:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    9169:	04 00                	add    $0x0,%al
    916b:	00 1c 00             	add    %bl,(%eax,%eax,1)
    916e:	00 00                	add    %al,(%eax)
    9170:	7c 01                	jl     9173 <exec_kernel+0x27f>
    9172:	00 00                	add    %al,(%eax)
    9174:	3a fb                	cmp    %bl,%bh
    9176:	ff                   	(bad)  
    9177:	ff 1f                	lcall  *(%edi)
    9179:	00 00                	add    %al,(%eax)
    917b:	00 00                	add    %al,(%eax)
    917d:	41                   	inc    %ecx
    917e:	0e                   	push   %cs
    917f:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    9185:	57                   	push   %edi
    9186:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    9189:	04 00                	add    $0x0,%al
    918b:	00 20                	add    %ah,(%eax)
    918d:	00 00                	add    %al,(%eax)
    918f:	00 9c 01 00 00 39 fb 	add    %bl,-0x4c70000(%ecx,%eax,1)
    9196:	ff                   	(bad)  
    9197:	ff 5e 00             	lcall  *0x0(%esi)
    919a:	00 00                	add    %al,(%eax)
    919c:	00 41 0e             	add    %al,0xe(%ecx)
    919f:	08 85 02 47 0d 05    	or     %al,0x50d4702(%ebp)
    91a5:	44                   	inc    %esp
    91a6:	87 03                	xchg   %eax,(%ebx)
    91a8:	02 50 c7             	add    -0x39(%eax),%dl
    91ab:	41                   	inc    %ecx
    91ac:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    91af:	04 28                	add    $0x28,%al
    91b1:	00 00                	add    %al,(%eax)
    91b3:	00 c0                	add    %al,%al
    91b5:	01 00                	add    %eax,(%eax)
    91b7:	00 73 fb             	add    %dh,-0x5(%ebx)
    91ba:	ff                   	(bad)  
    91bb:	ff 41 00             	incl   0x0(%ecx)
    91be:	00 00                	add    %al,(%eax)
    91c0:	00 41 0e             	add    %al,0xe(%ecx)
    91c3:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    91c9:	42                   	inc    %edx
    91ca:	87 03                	xchg   %eax,(%ebx)
    91cc:	86 04 44             	xchg   %al,(%esp,%eax,2)
    91cf:	83 05 74 c3 41 c6 41 	addl   $0x41,0xc641c374
    91d6:	c7 41 c5 0c 04 04 28 	movl   $0x2804040c,-0x3b(%ecx)
    91dd:	00 00                	add    %al,(%eax)
    91df:	00 ec                	add    %ch,%ah
    91e1:	01 00                	add    %eax,(%eax)
    91e3:	00 88 fb ff ff 82    	add    %cl,-0x7d000005(%eax)
    91e9:	00 00                	add    %al,(%eax)
    91eb:	00 00                	add    %al,(%eax)
    91ed:	41                   	inc    %ecx
    91ee:	0e                   	push   %cs
    91ef:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    91f5:	46                   	inc    %esi
    91f6:	87 03                	xchg   %eax,(%ebx)
    91f8:	86 04 83             	xchg   %al,(%ebx,%eax,4)
    91fb:	05 02 70 c3 41       	add    $0x41c37002,%eax
    9200:	c6 41 c7 46          	movb   $0x46,-0x39(%ecx)
    9204:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    9207:	04 28                	add    $0x28,%al
    9209:	00 00                	add    %al,(%eax)
    920b:	00 18                	add    %bl,(%eax)
    920d:	02 00                	add    (%eax),%al
    920f:	00 de                	add    %bl,%dh
    9211:	fb                   	sti    
    9212:	ff                   	(bad)  
    9213:	ff 5f 00             	lcall  *0x0(%edi)
    9216:	00 00                	add    %al,(%eax)
    9218:	00 41 0e             	add    %al,0xe(%ecx)
    921b:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    9221:	41                   	inc    %ecx
    9222:	86 03                	xchg   %al,(%ebx)
    9224:	44                   	inc    %esp
    9225:	83 04 02 54          	addl   $0x54,(%edx,%eax,1)
    9229:	c3                   	ret    
    922a:	41                   	inc    %ecx
    922b:	c6 41 c5 0c          	movb   $0xc,-0x3b(%ecx)
    922f:	04 04                	add    $0x4,%al
    9231:	00 00                	add    %al,(%eax)
    9233:	00 28                	add    %ch,(%eax)
    9235:	00 00                	add    %al,(%eax)
    9237:	00 44 02 00          	add    %al,0x0(%edx,%eax,1)
    923b:	00 11                	add    %dl,(%ecx)
    923d:	fc                   	cld    
    923e:	ff                   	(bad)  
    923f:	ff a6 00 00 00 00    	jmp    *0x0(%esi)
    9245:	41                   	inc    %ecx
    9246:	0e                   	push   %cs
    9247:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    924d:	41                   	inc    %ecx
    924e:	86 03                	xchg   %al,(%ebx)
    9250:	44                   	inc    %esp
    9251:	83 04 02 97          	addl   $0xffffff97,(%edx,%eax,1)
    9255:	c3                   	ret    
    9256:	41                   	inc    %ecx
    9257:	c6 41 c5 0c          	movb   $0xc,-0x3b(%ecx)
    925b:	04 04                	add    $0x4,%al
    925d:	00 00                	add    %al,(%eax)
    925f:	00                   	.byte 0x0

Disassembly of section .data:

00009260 <hex.1455>:
    9260:	30 31                	xor    %dh,(%ecx)
    9262:	32 33                	xor    (%ebx),%dh
    9264:	34 35                	xor    $0x35,%al
    9266:	36                   	ss
    9267:	37                   	aaa    
    9268:	38 39                	cmp    %bh,(%ecx)
    926a:	61                   	popa   
    926b:	62 63 64             	bound  %esp,0x64(%ebx)
    926e:	65                   	gs
    926f:	66                   	data16
    9270:	00 00                	add    %al,(%eax)
    9272:	00 00                	add    %al,(%eax)

00009274 <dec.1450>:
    9274:	30 31                	xor    %dh,(%ecx)
    9276:	32 33                	xor    (%ebx),%dh
    9278:	34 35                	xor    $0x35,%al
    927a:	36                   	ss
    927b:	37                   	aaa    
    927c:	38 39                	cmp    %bh,(%ecx)
    927e:	00 00                	add    %al,(%eax)

00009280 <blank>:
    9280:	04 8f                	add    $0x8f,%al
    9282:	00 00                	add    %al,(%eax)

00009284 <video>:
    9284:	00 80 0b 00 40 00    	add    %al,0x40000b(%eax)

00009288 <mboot_info>:
    9288:	40                   	inc    %eax
    9289:	00 00                	add    %al,(%eax)
    928b:	00 00                	add    %al,(%eax)
    928d:	00 00                	add    %al,(%eax)
    928f:	00 00                	add    %al,(%eax)
    9291:	00 00                	add    %al,(%eax)
    9293:	00 00                	add    %al,(%eax)
    9295:	00 00                	add    %al,(%eax)
    9297:	00 00                	add    %al,(%eax)
    9299:	00 00                	add    %al,(%eax)
    929b:	00 00                	add    %al,(%eax)
    929d:	00 00                	add    %al,(%eax)
    929f:	00 00                	add    %al,(%eax)
    92a1:	00 00                	add    %al,(%eax)
    92a3:	00 00                	add    %al,(%eax)
    92a5:	00 00                	add    %al,(%eax)
    92a7:	00 00                	add    %al,(%eax)
    92a9:	00 00                	add    %al,(%eax)
    92ab:	00 00                	add    %al,(%eax)
    92ad:	00 00                	add    %al,(%eax)
    92af:	00 00                	add    %al,(%eax)
    92b1:	00 00                	add    %al,(%eax)
    92b3:	00 00                	add    %al,(%eax)
    92b5:	00 00                	add    %al,(%eax)
    92b7:	00 00                	add    %al,(%eax)
    92b9:	00 00                	add    %al,(%eax)
    92bb:	00 00                	add    %al,(%eax)
    92bd:	00 00                	add    %al,(%eax)
    92bf:	00 00                	add    %al,(%eax)
    92c1:	00 00                	add    %al,(%eax)
    92c3:	00 00                	add    %al,(%eax)
    92c5:	00 00                	add    %al,(%eax)
    92c7:	00 00                	add    %al,(%eax)
    92c9:	00 00                	add    %al,(%eax)
    92cb:	00 00                	add    %al,(%eax)
    92cd:	00 00                	add    %al,(%eax)
    92cf:	00 00                	add    %al,(%eax)
    92d1:	00 00                	add    %al,(%eax)
    92d3:	00 00                	add    %al,(%eax)
    92d5:	00 00                	add    %al,(%eax)
    92d7:	00 00                	add    %al,(%eax)
    92d9:	00 00                	add    %al,(%eax)
    92db:	00 00                	add    %al,(%eax)
    92dd:	00 00                	add    %al,(%eax)
    92df:	00 00                	add    %al,(%eax)
    92e1:	00 00                	add    %al,(%eax)
    92e3:	00 00                	add    %al,(%eax)
    92e5:	00 00                	add    %al,(%eax)
    92e7:	00                   	.byte 0x0

Disassembly of section .bss:

000092e8 <__bss_start>:
    92e8:	00 00                	add    %al,(%eax)
    92ea:	00 00                	add    %al,(%eax)
    92ec:	00 00                	add    %al,(%eax)
    92ee:	00 00                	add    %al,(%eax)
    92f0:	00 00                	add    %al,(%eax)
    92f2:	00 00                	add    %al,(%eax)
    92f4:	00 00                	add    %al,(%eax)
    92f6:	00 00                	add    %al,(%eax)
    92f8:	00 00                	add    %al,(%eax)
    92fa:	00 00                	add    %al,(%eax)
    92fc:	00 00                	add    %al,(%eax)
    92fe:	00 00                	add    %al,(%eax)
    9300:	00 00                	add    %al,(%eax)
    9302:	00 00                	add    %al,(%eax)
    9304:	00 00                	add    %al,(%eax)
    9306:	00 00                	add    %al,(%eax)
    9308:	00 00                	add    %al,(%eax)
    930a:	00 00                	add    %al,(%eax)
    930c:	00 00                	add    %al,(%eax)
    930e:	00 00                	add    %al,(%eax)

00009310 <row>:
    9310:	00 00                	add    %al,(%eax)
    9312:	00 00                	add    %al,(%eax)

Disassembly of section .comment:

00000000 <.comment>:
   0:	47                   	inc    %edi
   1:	43                   	inc    %ebx
   2:	43                   	inc    %ebx
   3:	3a 20                	cmp    (%eax),%ah
   5:	28 47 4e             	sub    %al,0x4e(%edi)
   8:	55                   	push   %ebp
   9:	29 20                	sub    %esp,(%eax)
   b:	34 2e                	xor    $0x2e,%al
   d:	38 2e                	cmp    %ch,(%esi)
   f:	32 20                	xor    (%eax),%ah
  11:	32 30                	xor    (%eax),%dh
  13:	31 34 30             	xor    %esi,(%eax,%esi,1)
  16:	31 32                	xor    %esi,(%edx)
  18:	30 20                	xor    %ah,(%eax)
  1a:	28 52 65             	sub    %dl,0x65(%edx)
  1d:	64 20 48 61          	and    %cl,%fs:0x61(%eax)
  21:	74 20                	je     43 <PROT_MODE_DSEG+0x33>
  23:	34 2e                	xor    $0x2e,%al
  25:	38 2e                	cmp    %ch,(%esi)
  27:	32 2d 31 36 29 00    	xor    0x293631,%ch

Disassembly of section .debug_aranges:

00000000 <.debug_aranges>:
   0:	1c 00                	sbb    $0x0,%al
   2:	00 00                	add    %al,(%eax)
   4:	02 00                	add    (%eax),%al
   6:	00 00                	add    %al,(%eax)
   8:	00 00                	add    %al,(%eax)
   a:	04 00                	add    $0x0,%al
   c:	00 00                	add    %al,(%eax)
   e:	00 00                	add    %al,(%eax)
  10:	00 7e 00             	add    %bh,0x0(%esi)
  13:	00 26                	add    %ah,(%esi)
  15:	0d 00 00 00 00       	or     $0x0,%eax
  1a:	00 00                	add    %al,(%eax)
  1c:	00 00                	add    %al,(%eax)
  1e:	00 00                	add    %al,(%eax)
  20:	1c 00                	sbb    $0x0,%al
  22:	00 00                	add    %al,(%eax)
  24:	02 00                	add    (%eax),%al
  26:	62 00                	bound  %eax,(%eax)
  28:	00 00                	add    %al,(%eax)
  2a:	04 00                	add    $0x0,%al
  2c:	00 00                	add    %al,(%eax)
  2e:	00 00                	add    %al,(%eax)
  30:	28 8b 00 00 44 02    	sub    %cl,0x2440000(%ebx)
  36:	00 00                	add    %al,(%eax)
  38:	00 00                	add    %al,(%eax)
  3a:	00 00                	add    %al,(%eax)
  3c:	00 00                	add    %al,(%eax)
  3e:	00 00                	add    %al,(%eax)
  40:	1c 00                	sbb    $0x0,%al
  42:	00 00                	add    %al,(%eax)
  44:	02 00                	add    (%eax),%al
  46:	08 07                	or     %al,(%edi)
  48:	00 00                	add    %al,(%eax)
  4a:	04 00                	add    $0x0,%al
  4c:	00 00                	add    %al,(%eax)
  4e:	00 00                	add    %al,(%eax)
  50:	6c                   	insb   (%dx),%es:(%edi)
  51:	8d 00                	lea    (%eax),%eax
  53:	00 87 01 00 00 00    	add    %al,0x1(%edi)
  59:	00 00                	add    %al,(%eax)
  5b:	00 00                	add    %al,(%eax)
  5d:	00 00                	add    %al,(%eax)
  5f:	00 1c 00             	add    %bl,(%eax,%eax,1)
  62:	00 00                	add    %al,(%eax)
  64:	02 00                	add    (%eax),%al
  66:	29 0e                	sub    %ecx,(%esi)
  68:	00 00                	add    %al,(%eax)
  6a:	04 00                	add    $0x0,%al
  6c:	00 00                	add    %al,(%eax)
  6e:	00 00                	add    %al,(%eax)
  70:	f4                   	hlt    
  71:	8e 00                	mov    (%eax),%es
  73:	00 10                	add    %dl,(%eax)
  75:	00 00                	add    %al,(%eax)
  77:	00 00                	add    %al,(%eax)
  79:	00 00                	add    %al,(%eax)
  7b:	00 00                	add    %al,(%eax)
  7d:	00 00                	add    %al,(%eax)
  7f:	00                   	.byte 0x0

Disassembly of section .debug_info:

00000000 <.debug_info>:
   0:	5e                   	pop    %esi
   1:	00 00                	add    %al,(%eax)
   3:	00 02                	add    %al,(%edx)
   5:	00 00                	add    %al,(%eax)
   7:	00 00                	add    %al,(%eax)
   9:	00 04 01             	add    %al,(%ecx,%eax,1)
   c:	00 00                	add    %al,(%eax)
   e:	00 00                	add    %al,(%eax)
  10:	00 7e 00             	add    %bh,0x0(%esi)
  13:	00 26                	add    %ah,(%esi)
  15:	8b 00                	mov    (%eax),%eax
  17:	00 62 6f             	add    %ah,0x6f(%edx)
  1a:	6f                   	outsl  %ds:(%esi),(%dx)
  1b:	74 2f                	je     4c <PROT_MODE_DSEG+0x3c>
  1d:	62 6f 6f             	bound  %ebp,0x6f(%edi)
  20:	74 31                	je     53 <PROT_MODE_DSEG+0x43>
  22:	2f                   	das    
  23:	62 6f 6f             	bound  %ebp,0x6f(%edi)
  26:	74 31                	je     59 <PROT_MODE_DSEG+0x49>
  28:	2e                   	cs
  29:	53                   	push   %ebx
  2a:	00 2f                	add    %ch,(%edi)
  2c:	68 6f 6d 65 2f       	push   $0x2f656d6f
  31:	61                   	popa   
  32:	63 63 74             	arpl   %sp,0x74(%ebx)
  35:	73 2f                	jae    66 <PROT_MODE_DSEG+0x56>
  37:	77 73                	ja     ac <PR_BOOTABLE+0x2c>
  39:	33 36                	xor    (%esi),%esi
  3b:	32 2f                	xor    (%edi),%ch
  3d:	63 73 34             	arpl   %si,0x34(%ebx)
  40:	32 32                	xor    (%edx),%dh
  42:	2f                   	das    
  43:	6d                   	insl   (%dx),%es:(%edi)
  44:	63 65 72             	arpl   %sp,0x72(%ebp)
  47:	74 69                	je     b2 <PR_BOOTABLE+0x32>
  49:	6b 6f 73 00          	imul   $0x0,0x73(%edi),%ebp
  4d:	47                   	inc    %edi
  4e:	4e                   	dec    %esi
  4f:	55                   	push   %ebp
  50:	20 41 53             	and    %al,0x53(%ecx)
  53:	20 32                	and    %dh,(%edx)
  55:	2e 32 33             	xor    %cs:(%ebx),%dh
  58:	2e                   	cs
  59:	35 32 2e 30 2e       	xor    $0x2e302e32,%eax
  5e:	31 00                	xor    %eax,(%eax)
  60:	01 80 a2 06 00 00    	add    %eax,0x6a2(%eax)
  66:	04 00                	add    $0x0,%al
  68:	14 00                	adc    $0x0,%al
  6a:	00 00                	add    %al,(%eax)
  6c:	04 01                	add    $0x1,%al
  6e:	28 00                	sub    %al,(%eax)
  70:	00 00                	add    %al,(%eax)
  72:	01 b5 00 00 00 50    	add    %esi,0x50000000(%ebp)
  78:	01 00                	add    %eax,(%eax)
  7a:	00 28                	add    %ch,(%eax)
  7c:	8b 00                	mov    (%eax),%eax
  7e:	00 44 02 00          	add    %al,0x0(%edx,%eax,1)
  82:	00 80 00 00 00 02    	add    %al,0x2000000(%eax)
  88:	01 06                	add    %eax,(%esi)
  8a:	00 01                	add    %al,(%ecx)
  8c:	00 00                	add    %al,(%eax)
  8e:	03 cb                	add    %ebx,%ecx
  90:	00 00                	add    %al,(%eax)
  92:	00 02                	add    %al,(%edx)
  94:	0d 37 00 00 00       	or     $0x37,%eax
  99:	02 01                	add    (%ecx),%al
  9b:	08 fe                	or     %bh,%dh
  9d:	00 00                	add    %al,(%eax)
  9f:	00 02                	add    %al,(%edx)
  a1:	02 05 10 00 00 00    	add    0x10,%al
  a7:	02 02                	add    (%edx),%al
  a9:	07                   	pop    %es
  aa:	72 01                	jb     ad <PR_BOOTABLE+0x2d>
  ac:	00 00                	add    %al,(%eax)
  ae:	03 33                	add    (%ebx),%esi
  b0:	01 00                	add    %eax,(%eax)
  b2:	00 02                	add    %al,(%edx)
  b4:	10 57 00             	adc    %dl,0x0(%edi)
  b7:	00 00                	add    %al,(%eax)
  b9:	04 04                	add    $0x4,%al
  bb:	05 69 6e 74 00       	add    $0x746e69,%eax
  c0:	03 32                	add    (%edx),%esi
  c2:	01 00                	add    %eax,(%eax)
  c4:	00 02                	add    %al,(%edx)
  c6:	11 69 00             	adc    %ebp,0x0(%ecx)
  c9:	00 00                	add    %al,(%eax)
  cb:	02 04 07             	add    (%edi,%eax,1),%al
  ce:	20 01                	and    %al,(%ecx)
  d0:	00 00                	add    %al,(%eax)
  d2:	02 08                	add    (%eax),%cl
  d4:	05 dd 00 00 00       	add    $0xdd,%eax
  d9:	02 08                	add    (%eax),%cl
  db:	07                   	pop    %es
  dc:	16                   	push   %ss
  dd:	01 00                	add    %eax,(%eax)
  df:	00 02                	add    %al,(%edx)
  e1:	04 07                	add    $0x7,%al
  e3:	1a 00                	sbb    (%eax),%al
  e5:	00 00                	add    %al,(%eax)
  e7:	05 69 6e 62 00       	add    $0x626e69,%eax
  ec:	02 25 2c 00 00 00    	add    0x2c,%ah
  f2:	03 ac 00 00 00 06 91 	add    -0x6efa0000(%eax,%eax,1),%ebp
  f9:	01 00                	add    %eax,(%eax)
  fb:	00 02                	add    %al,(%edx)
  fd:	25 57 00 00 00       	and    $0x57,%eax
 102:	07                   	pop    %es
 103:	8c 01                	mov    %es,(%ecx)
 105:	00 00                	add    %al,(%eax)
 107:	02 27                	add    (%edi),%ah
 109:	2c 00                	sub    $0x0,%al
 10b:	00 00                	add    %al,(%eax)
 10d:	00 08                	add    %cl,(%eax)
 10f:	d3 00                	roll   %cl,(%eax)
 111:	00 00                	add    %al,(%eax)
 113:	02 19                	add    (%ecx),%bl
 115:	03 cf                	add    %edi,%ecx
 117:	00 00                	add    %al,(%eax)
 119:	00 06                	add    %al,(%esi)
 11b:	91                   	xchg   %eax,%ecx
 11c:	01 00                	add    %eax,(%eax)
 11e:	00 02                	add    %al,(%edx)
 120:	19 57 00             	sbb    %edx,0x0(%edi)
 123:	00 00                	add    %al,(%eax)
 125:	06                   	push   %es
 126:	8c 01                	mov    %es,(%ecx)
 128:	00 00                	add    %al,(%eax)
 12a:	02 19                	add    (%ecx),%bl
 12c:	2c 00                	sub    $0x0,%al
 12e:	00 00                	add    %al,(%eax)
 130:	00 08                	add    %cl,(%eax)
 132:	d8 00                	fadds  (%eax)
 134:	00 00                	add    %al,(%eax)
 136:	02 2d 03 fd 00 00    	add    0xfd03,%ch
 13c:	00 06                	add    %al,(%esi)
 13e:	91                   	xchg   %eax,%ecx
 13f:	01 00                	add    %eax,(%eax)
 141:	00 02                	add    %al,(%edx)
 143:	2d 57 00 00 00       	sub    $0x57,%eax
 148:	06                   	push   %es
 149:	da 03                	fiaddl (%ebx)
 14b:	00 00                	add    %al,(%eax)
 14d:	02 2d fd 00 00 00    	add    0xfd,%ch
 153:	09 63 6e             	or     %esp,0x6e(%ebx)
 156:	74 00                	je     158 <PR_BOOTABLE+0xd8>
 158:	02 2d 57 00 00 00    	add    0x57,%ch
 15e:	00 0a                	add    %cl,(%edx)
 160:	04 0b                	add    $0xb,%al
 162:	11 01                	adc    %eax,(%ecx)
 164:	00 00                	add    %al,(%eax)
 166:	01 09                	add    %ecx,(%ecx)
 168:	28 8b 00 00 1b 00    	sub    %cl,0x1b0000(%ebx)
 16e:	00 00                	add    %al,(%eax)
 170:	01 9c 47 01 00 00 0c 	add    %ebx,0xc000001(%edi,%eax,2)
 177:	6c                   	insb   (%dx),%es:(%edi)
 178:	00 01                	add    %al,(%ecx)
 17a:	09 57 00             	or     %edx,0x0(%edi)
 17d:	00 00                	add    %al,(%eax)
 17f:	02 91 00 0d 3b 01    	add    0x13b0d00(%ecx),%dl
 185:	00 00                	add    %al,(%eax)
 187:	01 09                	add    %ecx,(%ecx)
 189:	57                   	push   %edi
 18a:	00 00                	add    %al,(%eax)
 18c:	00 02                	add    %al,(%edx)
 18e:	91                   	xchg   %eax,%ecx
 18f:	04 0c                	add    $0xc,%al
 191:	63 68 00             	arpl   %bp,0x0(%eax)
 194:	01 09                	add    %ecx,(%ecx)
 196:	47                   	inc    %edi
 197:	01 00                	add    %eax,(%eax)
 199:	00 02                	add    %al,(%edx)
 19b:	91                   	xchg   %eax,%ecx
 19c:	08 0e                	or     %cl,(%esi)
 19e:	70 00                	jo     1a0 <PR_BOOTABLE+0x120>
 1a0:	01 0b                	add    %ecx,(%ebx)
 1a2:	4e                   	dec    %esi
 1a3:	01 00                	add    %eax,(%eax)
 1a5:	00 01                	add    %al,(%ecx)
 1a7:	50                   	push   %eax
 1a8:	00 02                	add    %al,(%edx)
 1aa:	01 06                	add    %eax,(%esi)
 1ac:	07                   	pop    %es
 1ad:	01 00                	add    %eax,(%eax)
 1af:	00 0f                	add    %cl,(%edi)
 1b1:	04 54                	add    $0x54,%al
 1b3:	01 00                	add    %eax,(%eax)
 1b5:	00 10                	add    %dl,(%eax)
 1b7:	47                   	inc    %edi
 1b8:	01 00                	add    %eax,(%eax)
 1ba:	00 11                	add    %dl,(%ecx)
 1bc:	46                   	inc    %esi
 1bd:	01 00                	add    %eax,(%eax)
 1bf:	00 01                	add    %al,(%ecx)
 1c1:	12 57 00             	adc    0x0(%edi),%dl
 1c4:	00 00                	add    %al,(%eax)
 1c6:	43                   	inc    %ebx
 1c7:	8b 00                	mov    (%eax),%eax
 1c9:	00 34 00             	add    %dh,(%eax,%eax,1)
 1cc:	00 00                	add    %al,(%eax)
 1ce:	01 9c be 01 00 00 0c 	add    %ebx,0xc000001(%esi,%edi,4)
 1d5:	72 00                	jb     1d7 <PR_BOOTABLE+0x157>
 1d7:	01 12                	add    %edx,(%edx)
 1d9:	57                   	push   %edi
 1da:	00 00                	add    %al,(%eax)
 1dc:	00 02                	add    %al,(%edx)
 1de:	91                   	xchg   %eax,%ecx
 1df:	00 0c 63             	add    %cl,(%ebx,%eiz,2)
 1e2:	00 01                	add    %al,(%ecx)
 1e4:	12 57 00             	adc    0x0(%edi),%dl
 1e7:	00 00                	add    %al,(%eax)
 1e9:	02 91 04 0d 3b 01    	add    0x13b0d04(%ecx),%dl
 1ef:	00 00                	add    %al,(%eax)
 1f1:	01 12                	add    %edx,(%edx)
 1f3:	57                   	push   %edi
 1f4:	00 00                	add    %al,(%eax)
 1f6:	00 02                	add    %al,(%edx)
 1f8:	91                   	xchg   %eax,%ecx
 1f9:	08 12                	or     %dl,(%edx)
 1fb:	eb 00                	jmp    1fd <PR_BOOTABLE+0x17d>
 1fd:	00 00                	add    %al,(%eax)
 1ff:	01 12                	add    %edx,(%edx)
 201:	be 01 00 00 00       	mov    $0x1,%esi
 206:	00 00                	add    %al,(%eax)
 208:	00 13                	add    %dl,(%ebx)
 20a:	6c                   	insb   (%dx),%es:(%edi)
 20b:	00 01                	add    %al,(%ecx)
 20d:	14 57                	adc    $0x57,%al
 20f:	00 00                	add    %al,(%eax)
 211:	00 86 00 00 00 14    	add    %al,0x14000000(%esi)
 217:	69 8b 00 00 ff 00 00 	imul   $0xf000000,0xff0000(%ebx),%ecx
 21e:	00 00 0f 
 221:	04 c4                	add    $0xc4,%al
 223:	01 00                	add    %eax,(%eax)
 225:	00 15 47 01 00 00    	add    %dl,0x147
 22b:	0b 96 01 00 00 01    	or     0x1000001(%esi),%edx
 231:	22 77 8b             	and    -0x75(%edi),%dh
 234:	00 00                	add    %al,(%eax)
 236:	3f                   	aas    
 237:	00 00                	add    %al,(%eax)
 239:	00 01                	add    %al,(%ecx)
 23b:	9c                   	pushf  
 23c:	fd                   	std    
 23d:	01 00                	add    %eax,(%eax)
 23f:	00 0c 73             	add    %cl,(%ebx,%esi,2)
 242:	00 01                	add    %al,(%ecx)
 244:	22 fd                	and    %ch,%bh
 246:	01 00                	add    %eax,(%eax)
 248:	00 02                	add    %al,(%edx)
 24a:	91                   	xchg   %eax,%ecx
 24b:	00 14 a1             	add    %dl,(%ecx,%eiz,4)
 24e:	8b 00                	mov    (%eax),%eax
 250:	00 59 01             	add    %bl,0x1(%ecx)
 253:	00 00                	add    %al,(%eax)
 255:	14 ae                	adc    $0xae,%al
 257:	8b 00                	mov    (%eax),%eax
 259:	00 59 01             	add    %bl,0x1(%ecx)
 25c:	00 00                	add    %al,(%eax)
 25e:	00 0f                	add    %cl,(%edi)
 260:	04 47                	add    $0x47,%al
 262:	01 00                	add    %eax,(%eax)
 264:	00 0b                	add    %cl,(%ebx)
 266:	23 00                	and    (%eax),%eax
 268:	00 00                	add    %al,(%eax)
 26a:	01 29                	add    %ebp,(%ecx)
 26c:	b6 8b                	mov    $0x8b,%dh
 26e:	00 00                	add    %al,(%eax)
 270:	0d 00 00 00 01       	or     $0x1000000,%eax
 275:	9c                   	pushf  
 276:	25 02 00 00 0c       	and    $0xc000002,%eax
 27b:	72 00                	jb     27d <PR_BOOTABLE+0x1fd>
 27d:	01 29                	add    %ebp,(%ecx)
 27f:	57                   	push   %edi
 280:	00 00                	add    %al,(%eax)
 282:	00 02                	add    %al,(%edx)
 284:	91                   	xchg   %eax,%ecx
 285:	00 00                	add    %al,(%eax)
 287:	0b 9f 00 00 00 01    	or     0x1000000(%edi),%ebx
 28d:	2f                   	das    
 28e:	c3                   	ret    
 28f:	8b 00                	mov    (%eax),%eax
 291:	00 17                	add    %dl,(%edi)
 293:	00 00                	add    %al,(%eax)
 295:	00 01                	add    %al,(%ecx)
 297:	9c                   	pushf  
 298:	50                   	push   %eax
 299:	02 00                	add    (%eax),%al
 29b:	00 0c 6d 00 01 2f fd 	add    %cl,-0x2d0ff00(,%ebp,2)
 2a2:	01 00                	add    %eax,(%eax)
 2a4:	00 02                	add    %al,(%edx)
 2a6:	91                   	xchg   %eax,%ecx
 2a7:	00 14 d4             	add    %dl,(%esp,%edx,8)
 2aa:	8b 00                	mov    (%eax),%eax
 2ac:	00 59 01             	add    %bl,0x1(%ecx)
 2af:	00 00                	add    %al,(%eax)
 2b1:	00 11                	add    %dl,(%ecx)
 2b3:	85 01                	test   %eax,(%ecx)
 2b5:	00 00                	add    %al,(%eax)
 2b7:	01 47 57             	add    %eax,0x57(%edi)
 2ba:	00 00                	add    %al,(%eax)
 2bc:	00 da                	add    %bl,%dl
 2be:	8b 00                	mov    (%eax),%eax
 2c0:	00 13                	add    %dl,(%ebx)
 2c2:	00 00                	add    %al,(%eax)
 2c4:	00 01                	add    %al,(%ecx)
 2c6:	9c                   	pushf  
 2c7:	84 02                	test   %al,(%edx)
 2c9:	00 00                	add    %al,(%eax)
 2cb:	16                   	push   %ss
 2cc:	73 00                	jae    2ce <PR_BOOTABLE+0x24e>
 2ce:	01 47 be             	add    %eax,-0x42(%edi)
 2d1:	01 00                	add    %eax,(%eax)
 2d3:	00 c0                	add    %al,%al
 2d5:	00 00                	add    %al,(%eax)
 2d7:	00 13                	add    %dl,(%ebx)
 2d9:	6e                   	outsb  %ds:(%esi),(%dx)
 2da:	00 01                	add    %al,(%ecx)
 2dc:	49                   	dec    %ecx
 2dd:	57                   	push   %edi
 2de:	00 00                	add    %al,(%eax)
 2e0:	00 e5                	add    %ah,%ch
 2e2:	00 00                	add    %al,(%eax)
 2e4:	00 00                	add    %al,(%eax)
 2e6:	0b 9e 01 00 00 01    	or     0x1000001(%esi),%ebx
 2ec:	52                   	push   %edx
 2ed:	ed                   	in     (%dx),%eax
 2ee:	8b 00                	mov    (%eax),%eax
 2f0:	00 30                	add    %dh,(%eax)
 2f2:	00 00                	add    %al,(%eax)
 2f4:	00 01                	add    %al,(%ecx)
 2f6:	9c                   	pushf  
 2f7:	d4 02                	aam    $0x2
 2f9:	00 00                	add    %al,(%eax)
 2fb:	0c 73                	or     $0x73,%al
 2fd:	00 01                	add    %al,(%ecx)
 2ff:	52                   	push   %edx
 300:	fd                   	std    
 301:	01 00                	add    %eax,(%eax)
 303:	00 02                	add    %al,(%edx)
 305:	91                   	xchg   %eax,%ecx
 306:	00 13                	add    %dl,(%ebx)
 308:	69 00 01 54 57 00    	imul   $0x575401,(%eax),%eax
 30e:	00 00                	add    %al,(%eax)
 310:	04 01                	add    $0x1,%al
 312:	00 00                	add    %al,(%eax)
 314:	0e                   	push   %cs
 315:	6a 00                	push   $0x0
 317:	01 54 57 00          	add    %edx,0x0(%edi,%edx,2)
 31b:	00 00                	add    %al,(%eax)
 31d:	01 50 13             	add    %edx,0x13(%eax)
 320:	63 00                	arpl   %ax,(%eax)
 322:	01 55 47             	add    %edx,0x47(%ebp)
 325:	01 00                	add    %eax,(%eax)
 327:	00 23                	add    %ah,(%ebx)
 329:	01 00                	add    %eax,(%eax)
 32b:	00 14 fb             	add    %dl,(%ebx,%edi,8)
 32e:	8b 00                	mov    (%eax),%eax
 330:	00 50 02             	add    %dl,0x2(%eax)
 333:	00 00                	add    %al,(%eax)
 335:	00 0b                	add    %cl,(%ebx)
 337:	41                   	inc    %ecx
 338:	01 00                	add    %eax,(%eax)
 33a:	00 01                	add    %al,(%ecx)
 33c:	61                   	popa   
 33d:	1d 8c 00 00 5d       	sbb    $0x5d00008c,%eax
 342:	00 00                	add    %al,(%eax)
 344:	00 01                	add    %al,(%ecx)
 346:	9c                   	pushf  
 347:	44                   	inc    %esp
 348:	03 00                	add    (%eax),%eax
 34a:	00 16                	add    %dl,(%esi)
 34c:	6e                   	outsb  %ds:(%esi),(%dx)
 34d:	00 01                	add    %al,(%ecx)
 34f:	61                   	popa   
 350:	57                   	push   %edi
 351:	00 00                	add    %al,(%eax)
 353:	00 36                	add    %dh,(%esi)
 355:	01 00                	add    %eax,(%eax)
 357:	00 0c 73             	add    %cl,(%ebx,%esi,2)
 35a:	00 01                	add    %al,(%ecx)
 35c:	61                   	popa   
 35d:	fd                   	std    
 35e:	01 00                	add    %eax,(%eax)
 360:	00 02                	add    %al,(%edx)
 362:	91                   	xchg   %eax,%ecx
 363:	04 0d                	add    $0xd,%al
 365:	b5 01                	mov    $0x1,%ch
 367:	00 00                	add    %al,(%eax)
 369:	01 61 57             	add    %esp,0x57(%ecx)
 36c:	00 00                	add    %al,(%eax)
 36e:	00 02                	add    %al,(%edx)
 370:	91                   	xchg   %eax,%ecx
 371:	08 0d be 03 00 00    	or     %cl,0x3be
 377:	01 61 fd             	add    %esp,-0x3(%ecx)
 37a:	01 00                	add    %eax,(%eax)
 37c:	00 02                	add    %al,(%edx)
 37e:	91                   	xchg   %eax,%ecx
 37f:	0c 13                	or     $0x13,%al
 381:	69 00 01 63 57 00    	imul   $0x576301,(%eax),%eax
 387:	00 00                	add    %al,(%eax)
 389:	60                   	pusha  
 38a:	01 00                	add    %eax,(%eax)
 38c:	00 17                	add    %dl,(%edi)
 38e:	4b                   	dec    %ebx
 38f:	01 00                	add    %eax,(%eax)
 391:	00 01                	add    %al,(%ecx)
 393:	63 57 00             	arpl   %dx,0x0(%edi)
 396:	00 00                	add    %al,(%eax)
 398:	94                   	xchg   %eax,%esp
 399:	01 00                	add    %eax,(%eax)
 39b:	00 18                	add    %bl,(%eax)
 39d:	7a 8c                	jp     32b <PR_BOOTABLE+0x2ab>
 39f:	00 00                	add    %al,(%eax)
 3a1:	84 02                	test   %al,(%edx)
 3a3:	00 00                	add    %al,(%eax)
 3a5:	00 0b                	add    %cl,(%ebx)
 3a7:	2d 01 00 00 01       	sub    $0x1000001,%eax
 3ac:	73 7a                	jae    428 <PR_BOOTABLE+0x3a8>
 3ae:	8c 00                	mov    %es,(%eax)
 3b0:	00 1a                	add    %bl,(%edx)
 3b2:	00 00                	add    %al,(%eax)
 3b4:	00 01                	add    %al,(%ecx)
 3b6:	9c                   	pushf  
 3b7:	8c 03                	mov    %es,(%ebx)
 3b9:	00 00                	add    %al,(%eax)
 3bb:	0c 6e                	or     $0x6e,%al
 3bd:	00 01                	add    %al,(%ecx)
 3bf:	73 57                	jae    418 <PR_BOOTABLE+0x398>
 3c1:	00 00                	add    %al,(%eax)
 3c3:	00 02                	add    %al,(%edx)
 3c5:	91                   	xchg   %eax,%ecx
 3c6:	00 0c 73             	add    %cl,(%ebx,%esi,2)
 3c9:	00 01                	add    %al,(%ecx)
 3cb:	73 fd                	jae    3ca <PR_BOOTABLE+0x34a>
 3cd:	01 00                	add    %eax,(%eax)
 3cf:	00 02                	add    %al,(%edx)
 3d1:	91                   	xchg   %eax,%ecx
 3d2:	04 0e                	add    $0xe,%al
 3d4:	64 65 63 00          	fs arpl %ax,%fs:%gs:(%eax)
 3d8:	01 75 8c             	add    %esi,-0x74(%ebp)
 3db:	03 00                	add    (%eax),%eax
 3dd:	00 05 03 74 92 00    	add    %al,0x927403
 3e3:	00 14 8f             	add    %dl,(%edi,%ecx,4)
 3e6:	8c 00                	mov    %es,(%eax)
 3e8:	00 d4                	add    %dl,%ah
 3ea:	02 00                	add    (%eax),%al
 3ec:	00 00                	add    %al,(%eax)
 3ee:	19 47 01             	sbb    %eax,0x1(%edi)
 3f1:	00 00                	add    %al,(%eax)
 3f3:	9c                   	pushf  
 3f4:	03 00                	add    (%eax),%eax
 3f6:	00 1a                	add    %bl,(%edx)
 3f8:	7e 00                	jle    3fa <PR_BOOTABLE+0x37a>
 3fa:	00 00                	add    %al,(%eax)
 3fc:	0a 00                	or     (%eax),%al
 3fe:	0b 0c 01             	or     (%ecx,%eax,1),%ecx
 401:	00 00                	add    %al,(%eax)
 403:	01 7b 94             	add    %edi,-0x6c(%ebx)
 406:	8c 00                	mov    %es,(%eax)
 408:	00 1a                	add    %bl,(%edx)
 40a:	00 00                	add    %al,(%eax)
 40c:	00 01                	add    %al,(%ecx)
 40e:	9c                   	pushf  
 40f:	e4 03                	in     $0x3,%al
 411:	00 00                	add    %al,(%eax)
 413:	0c 6e                	or     $0x6e,%al
 415:	00 01                	add    %al,(%ecx)
 417:	7b 57                	jnp    470 <PR_BOOTABLE+0x3f0>
 419:	00 00                	add    %al,(%eax)
 41b:	00 02                	add    %al,(%edx)
 41d:	91                   	xchg   %eax,%ecx
 41e:	00 0c 73             	add    %cl,(%ebx,%esi,2)
 421:	00 01                	add    %al,(%ecx)
 423:	7b fd                	jnp    422 <PR_BOOTABLE+0x3a2>
 425:	01 00                	add    %eax,(%eax)
 427:	00 02                	add    %al,(%edx)
 429:	91                   	xchg   %eax,%ecx
 42a:	04 0e                	add    $0xe,%al
 42c:	68 65 78 00 01       	push   $0x1007865
 431:	7d e4                	jge    417 <PR_BOOTABLE+0x397>
 433:	03 00                	add    (%eax),%eax
 435:	00 05 03 60 92 00    	add    %al,0x926003
 43b:	00 14 a9             	add    %dl,(%ecx,%ebp,4)
 43e:	8c 00                	mov    %es,(%eax)
 440:	00 d4                	add    %dl,%ah
 442:	02 00                	add    (%eax),%al
 444:	00 00                	add    %al,(%eax)
 446:	19 47 01             	sbb    %eax,0x1(%edi)
 449:	00 00                	add    %al,(%eax)
 44b:	f4                   	hlt    
 44c:	03 00                	add    (%eax),%eax
 44e:	00 1a                	add    %bl,(%edx)
 450:	7e 00                	jle    452 <PR_BOOTABLE+0x3d2>
 452:	00 00                	add    %al,(%eax)
 454:	10 00                	adc    %al,(%eax)
 456:	0b a5 00 00 00 01    	or     0x1000000(%ebp),%esp
 45c:	3b ae 8c 00 00 1f    	cmp    0x1f00008c(%esi),%ebp
 462:	00 00                	add    %al,(%eax)
 464:	00 01                	add    %al,(%ecx)
 466:	9c                   	pushf  
 467:	28 04 00             	sub    %al,(%eax,%eax,1)
 46a:	00 0c 69             	add    %cl,(%ecx,%ebp,2)
 46d:	00 01                	add    %al,(%ecx)
 46f:	3b 4c 00 00          	cmp    0x0(%eax,%eax,1),%ecx
 473:	00 02                	add    %al,(%edx)
 475:	91                   	xchg   %eax,%ecx
 476:	00 14 be             	add    %dl,(%esi,%edi,4)
 479:	8c 00                	mov    %es,(%eax)
 47b:	00 9c 03 00 00 18 cd 	add    %bl,-0x32e80000(%ebx,%eax,1)
 482:	8c 00                	mov    %es,(%eax)
 484:	00 c9                	add    %cl,%cl
 486:	01 00                	add    %eax,(%eax)
 488:	00 00                	add    %al,(%eax)
 48a:	1b 07                	sbb    (%edi),%eax
 48c:	00 00                	add    %al,(%eax)
 48e:	00 01                	add    %al,(%ecx)
 490:	86 01                	xchg   %al,(%ecx)
 492:	0b aa 00 00 00 01    	or     0x1000000(%edx),%ebp
 498:	8e cd                	mov    %ebp,%cs
 49a:	8c 00                	mov    %es,(%eax)
 49c:	00 5e 00             	add    %bl,0x0(%esi)
 49f:	00 00                	add    %al,(%eax)
 4a1:	01 9c ea 05 00 00 0c 	add    %ebx,0xc000005(%edx,%ebp,8)
 4a8:	64                   	fs
 4a9:	73 74                	jae    51f <PR_BOOTABLE+0x49f>
 4ab:	00 01                	add    %al,(%ecx)
 4ad:	8e fd                	mov    %ebp,%?
 4af:	00 00                	add    %al,(%eax)
 4b1:	00 02                	add    %al,(%edx)
 4b3:	91                   	xchg   %eax,%ecx
 4b4:	00 0d 25 02 00 00    	add    %cl,0x225
 4ba:	01 8e 5e 00 00 00    	add    %ecx,0x5e(%esi)
 4c0:	02 91 04 1c 28 04    	add    0x4281c04(%ecx),%dl
 4c6:	00 00                	add    %al,(%eax)
 4c8:	ce                   	into   
 4c9:	8c 00                	mov    %es,(%eax)
 4cb:	00 00                	add    %al,(%eax)
 4cd:	00 00                	add    %al,(%eax)
 4cf:	00 01                	add    %al,(%ecx)
 4d1:	91                   	xchg   %eax,%ecx
 4d2:	9b                   	fwait
 4d3:	04 00                	add    $0x0,%al
 4d5:	00 1d 85 00 00 00    	add    %bl,0x85
 4db:	ce                   	into   
 4dc:	8c 00                	mov    %es,(%eax)
 4de:	00 18                	add    %bl,(%eax)
 4e0:	00 00                	add    %al,(%eax)
 4e2:	00 01                	add    %al,(%ecx)
 4e4:	89 1e                	mov    %ebx,(%esi)
 4e6:	95                   	xchg   %eax,%ebp
 4e7:	00 00                	add    %al,(%eax)
 4e9:	00 f7                	add    %dh,%bh
 4eb:	01 1f                	add    %ebx,(%edi)
 4ed:	18 00                	sbb    %al,(%eax)
 4ef:	00 00                	add    %al,(%eax)
 4f1:	20 a0 00 00 00 bf    	and    %ah,-0x41000000(%eax)
 4f7:	01 00                	add    %eax,(%eax)
 4f9:	00 00                	add    %al,(%eax)
 4fb:	00 00                	add    %al,(%eax)
 4fd:	21 ac 00 00 00 e1 8c 	and    %ebp,-0x731f0000(%eax,%eax,1)
 504:	00 00                	add    %al,(%eax)
 506:	0b 00                	or     (%eax),%eax
 508:	00 00                	add    %al,(%eax)
 50a:	01 93 bc 04 00 00    	add    %edx,0x4bc(%ebx)
 510:	22 c3                	and    %bl,%al
 512:	00 00                	add    %al,(%eax)
 514:	00 01                	add    %al,(%ecx)
 516:	1e                   	push   %ds
 517:	b8 00 00 00 f2       	mov    $0xf2000000,%eax
 51c:	01 00                	add    %eax,(%eax)
 51e:	21 ac 00 00 00 ec 8c 	and    %ebp,-0x73140000(%eax,%eax,1)
 525:	00 00                	add    %al,(%eax)
 527:	06                   	push   %es
 528:	00 00                	add    %al,(%eax)
 52a:	00 01                	add    %al,(%ecx)
 52c:	94                   	xchg   %eax,%esp
 52d:	e4 04                	in     $0x4,%al
 52f:	00 00                	add    %al,(%eax)
 531:	23 c3                	and    %ebx,%eax
 533:	00 00                	add    %al,(%eax)
 535:	00 07                	add    %al,(%edi)
 537:	91                   	xchg   %eax,%ecx
 538:	04 06                	add    $0x6,%al
 53a:	08 ff                	or     %bh,%bh
 53c:	1a 9f 1e b8 00 00    	sbb    0xb81e(%edi),%bl
 542:	00 f3                	add    %dh,%bl
 544:	01 00                	add    %eax,(%eax)
 546:	21 ac 00 00 00 f2 8c 	and    %ebp,-0x730e0000(%eax,%eax,1)
 54d:	00 00                	add    %al,(%eax)
 54f:	03 00                	add    (%eax),%eax
 551:	00 00                	add    %al,(%eax)
 553:	01 95 0e 05 00 00    	add    %edx,0x50e(%ebp)
 559:	23 c3                	and    %ebx,%eax
 55b:	00 00                	add    %al,(%eax)
 55d:	00 09                	add    %cl,(%ecx)
 55f:	91                   	xchg   %eax,%ecx
 560:	04 06                	add    $0x6,%al
 562:	38 25 08 ff 1a 9f    	cmp    %ah,0x9f1aff08
 568:	1e                   	push   %ds
 569:	b8 00 00 00 f4       	mov    $0xf4000000,%eax
 56e:	01 00                	add    %eax,(%eax)
 570:	1c ac                	sbb    $0xac,%al
 572:	00 00                	add    %al,(%eax)
 574:	00 f7                	add    %dh,%bh
 576:	8c 00                	mov    %es,(%eax)
 578:	00 30                	add    %dh,(%eax)
 57a:	00 00                	add    %al,(%eax)
 57c:	00 01                	add    %al,(%ecx)
 57e:	96                   	xchg   %eax,%esi
 57f:	38 05 00 00 23 c3    	cmp    %al,0xc3230000
 585:	00 00                	add    %al,(%eax)
 587:	00 09                	add    %cl,(%ecx)
 589:	91                   	xchg   %eax,%ecx
 58a:	04 06                	add    $0x6,%al
 58c:	40                   	inc    %eax
 58d:	25 08 ff 1a 9f       	and    $0x9f1aff08,%eax
 592:	1e                   	push   %ds
 593:	b8 00 00 00 f5       	mov    $0xf5000000,%eax
 598:	01 00                	add    %eax,(%eax)
 59a:	1c ac                	sbb    $0xac,%al
 59c:	00 00                	add    %al,(%eax)
 59e:	00 03                	add    %al,(%ebx)
 5a0:	8d 00                	lea    (%eax),%eax
 5a2:	00 48 00             	add    %cl,0x0(%eax)
 5a5:	00 00                	add    %al,(%eax)
 5a7:	01 97 61 05 00 00    	add    %edx,0x561(%edi)
 5ad:	23 c3                	and    %ebx,%eax
 5af:	00 00                	add    %al,(%eax)
 5b1:	00 08                	add    %cl,(%eax)
 5b3:	91                   	xchg   %eax,%ecx
 5b4:	07                   	pop    %es
 5b5:	94                   	xchg   %eax,%esp
 5b6:	01 09                	add    %ecx,(%ecx)
 5b8:	e0 21                	loopne 5db <PR_BOOTABLE+0x55b>
 5ba:	9f                   	lahf   
 5bb:	1e                   	push   %ds
 5bc:	b8 00 00 00 f6       	mov    $0xf6000000,%eax
 5c1:	01 00                	add    %eax,(%eax)
 5c3:	21 ac 00 00 00 0b 8d 	and    %ebp,-0x72f50000(%eax,%eax,1)
 5ca:	00 00                	add    %al,(%eax)
 5cc:	05 00 00 00 01       	add    $0x1000000,%eax
 5d1:	98                   	cwtl   
 5d2:	82                   	(bad)  
 5d3:	05 00 00 22 c3       	add    $0xc3220000,%eax
 5d8:	00 00                	add    %al,(%eax)
 5da:	00 20                	add    %ah,(%eax)
 5dc:	1e                   	push   %ds
 5dd:	b8 00 00 00 f7       	mov    $0xf7000000,%eax
 5e2:	01 00                	add    %eax,(%eax)
 5e4:	21 28                	and    %ebp,(%eax)
 5e6:	04 00                	add    $0x0,%al
 5e8:	00 10                	add    %dl,(%eax)
 5ea:	8d 00                	lea    (%eax),%eax
 5ec:	00 08                	add    %cl,(%eax)
 5ee:	00 00                	add    %al,(%eax)
 5f0:	00 01                	add    %al,(%ecx)
 5f2:	9b                   	fwait
 5f3:	c0 05 00 00 24 85 00 	rolb   $0x0,0x85240000
 5fa:	00 00                	add    %al,(%eax)
 5fc:	10 8d 00 00 01 00    	adc    %cl,0x10000(%ebp)
 602:	00 00                	add    %al,(%eax)
 604:	01 89 1e 95 00 00    	add    %ecx,0x951e(%ecx)
 60a:	00 f7                	add    %dh,%bh
 60c:	01 25 10 8d 00 00    	add    %esp,0x8d10
 612:	01 00                	add    %eax,(%eax)
 614:	00 00                	add    %al,(%eax)
 616:	20 a0 00 00 00 d2    	and    %ah,-0x2e000000(%eax)
 61c:	01 00                	add    %eax,(%eax)
 61e:	00 00                	add    %al,(%eax)
 620:	00 00                	add    %al,(%eax)
 622:	24 cf                	and    $0xcf,%al
 624:	00 00                	add    %al,(%eax)
 626:	00 18                	add    %bl,(%eax)
 628:	8d 00                	lea    (%eax),%eax
 62a:	00 10                	add    %dl,(%eax)
 62c:	00 00                	add    %al,(%eax)
 62e:	00 01                	add    %al,(%ecx)
 630:	9e                   	sahf   
 631:	26                   	es
 632:	f1                   	icebp  
 633:	00 00                	add    %al,(%eax)
 635:	00 e5                	add    %ah,%ch
 637:	01 00                	add    %eax,(%eax)
 639:	00 26                	add    %ah,(%esi)
 63b:	e6 00                	out    %al,$0x0
 63d:	00 00                	add    %al,(%eax)
 63f:	fa                   	cli    
 640:	01 00                	add    %eax,(%eax)
 642:	00 1e                	add    %bl,(%esi)
 644:	db 00                	fildl  (%eax)
 646:	00 00                	add    %al,(%eax)
 648:	f0 01 00             	lock add %eax,(%eax)
 64b:	00 0b                	add    %cl,(%ebx)
 64d:	f2 00 00             	repnz add %al,(%eax)
 650:	00 01                	add    %al,(%ecx)
 652:	a4                   	movsb  %ds:(%esi),%es:(%edi)
 653:	2b 8d 00 00 41 00    	sub    0x410000(%ebp),%ecx
 659:	00 00                	add    %al,(%eax)
 65b:	01 9c 51 06 00 00 16 	add    %ebx,0x16000006(%ecx,%edx,2)
 662:	76 61                	jbe    6c5 <PR_BOOTABLE+0x645>
 664:	00 01                	add    %al,(%ecx)
 666:	a4                   	movsb  %ds:(%esi),%es:(%edi)
 667:	5e                   	pop    %esi
 668:	00 00                	add    %al,(%eax)
 66a:	00 0e                	add    %cl,(%esi)
 66c:	02 00                	add    (%eax),%al
 66e:	00 0d 79 04 00 00    	add    %cl,0x479
 674:	01 a4 5e 00 00 00 02 	add    %esp,0x2000000(%esi,%ebx,2)
 67b:	91                   	xchg   %eax,%ecx
 67c:	04 12                	add    $0x12,%al
 67e:	25 02 00 00 01       	and    $0x1000002,%eax
 683:	a4                   	movsb  %ds:(%esi),%es:(%edi)
 684:	5e                   	pop    %esi
 685:	00 00                	add    %al,(%eax)
 687:	00 71 02             	add    %dh,0x2(%ecx)
 68a:	00 00                	add    %al,(%eax)
 68c:	0c 6c                	or     $0x6c,%al
 68e:	62 61 00             	bound  %esp,0x0(%ecx)
 691:	01 a4 5e 00 00 00 02 	add    %esp,0x2000000(%esi,%ebx,2)
 698:	91                   	xchg   %eax,%ecx
 699:	0c 17                	or     $0x17,%al
 69b:	00 00                	add    %al,(%eax)
 69d:	00 00                	add    %al,(%eax)
 69f:	01 a6 5e 00 00 00    	add    %esp,0x5e(%esi)
 6a5:	c0 02 00             	rolb   $0x0,(%edx)
 6a8:	00 14 60             	add    %dl,(%eax,%eiz,2)
 6ab:	8d 00                	lea    (%eax),%eax
 6ad:	00 30                	add    %dh,(%eax)
 6af:	04 00                	add    $0x0,%al
 6b1:	00 00                	add    %al,(%eax)
 6b3:	0e                   	push   %cs
 6b4:	72 6f                	jb     725 <PR_BOOTABLE+0x6a5>
 6b6:	77 00                	ja     6b8 <PR_BOOTABLE+0x638>
 6b8:	01 1c 57             	add    %ebx,(%edi,%edx,2)
 6bb:	00 00                	add    %al,(%eax)
 6bd:	00 05 03 10 93 00    	add    %al,0x931003
 6c3:	00 19                	add    %bl,(%ecx)
 6c5:	47                   	inc    %edi
 6c6:	01 00                	add    %eax,(%eax)
 6c8:	00 72 06             	add    %dh,0x6(%edx)
 6cb:	00 00                	add    %al,(%eax)
 6cd:	1a 7e 00             	sbb    0x0(%esi),%bh
 6d0:	00 00                	add    %al,(%eax)
 6d2:	27                   	daa    
 6d3:	00 27                	add    %ah,(%edi)
 6d5:	a6                   	cmpsb  %es:(%edi),%ds:(%esi)
 6d6:	01 00                	add    %eax,(%eax)
 6d8:	00 01                	add    %al,(%ecx)
 6da:	38 62 06             	cmp    %ah,0x6(%edx)
 6dd:	00 00                	add    %al,(%eax)
 6df:	05 03 e8 92 00       	add    $0x92e803,%eax
 6e4:	00 28                	add    %ch,(%eax)
 6e6:	ba 01 00 00 01       	mov    $0x1000001,%edx
 6eb:	06                   	push   %es
 6ec:	4e                   	dec    %esi
 6ed:	01 00                	add    %eax,(%eax)
 6ef:	00 05 03 84 92 00    	add    %al,0x928403
 6f5:	00 28                	add    %ch,(%eax)
 6f7:	af                   	scas   %es:(%edi),%eax
 6f8:	01 00                	add    %eax,(%eax)
 6fa:	00 01                	add    %al,(%ecx)
 6fc:	1e                   	push   %ds
 6fd:	fd                   	std    
 6fe:	01 00                	add    %eax,(%eax)
 700:	00 05 03 80 92 00    	add    %al,0x928003
 706:	00 00                	add    %al,(%eax)
 708:	1d 07 00 00 04       	sbb    $0x4000007,%eax
 70d:	00 2a                	add    %ch,(%edx)
 70f:	02 00                	add    (%eax),%al
 711:	00 04 01             	add    %al,(%ecx,%eax,1)
 714:	28 00                	sub    %al,(%eax)
 716:	00 00                	add    %al,(%eax)
 718:	01 5d 04             	add    %ebx,0x4(%ebp)
 71b:	00 00                	add    %al,(%eax)
 71d:	50                   	push   %eax
 71e:	01 00                	add    %eax,(%eax)
 720:	00 6c 8d 00          	add    %ch,0x0(%ebp,%ecx,4)
 724:	00 87 01 00 00 e0    	add    %al,-0x1fffffff(%edi)
 72a:	01 00                	add    %eax,(%eax)
 72c:	00 02                	add    %al,(%edx)
 72e:	01 06                	add    %eax,(%esi)
 730:	00 01                	add    %al,(%ecx)
 732:	00 00                	add    %al,(%eax)
 734:	03 cb                	add    %ebx,%ecx
 736:	00 00                	add    %al,(%eax)
 738:	00 02                	add    %al,(%edx)
 73a:	0d 37 00 00 00       	or     $0x37,%eax
 73f:	02 01                	add    (%ecx),%al
 741:	08 fe                	or     %bh,%dh
 743:	00 00                	add    %al,(%eax)
 745:	00 02                	add    %al,(%edx)
 747:	02 05 10 00 00 00    	add    0x10,%al
 74d:	03 4c 03 00          	add    0x0(%ebx,%eax,1),%ecx
 751:	00 02                	add    %al,(%edx)
 753:	0f 50                	(bad)  
 755:	00 00                	add    %al,(%eax)
 757:	00 02                	add    %al,(%edx)
 759:	02 07                	add    (%edi),%al
 75b:	72 01                	jb     75e <PR_BOOTABLE+0x6de>
 75d:	00 00                	add    %al,(%eax)
 75f:	03 33                	add    (%ebx),%esi
 761:	01 00                	add    %eax,(%eax)
 763:	00 02                	add    %al,(%edx)
 765:	10 62 00             	adc    %ah,0x0(%edx)
 768:	00 00                	add    %al,(%eax)
 76a:	04 04                	add    $0x4,%al
 76c:	05 69 6e 74 00       	add    $0x746e69,%eax
 771:	03 32                	add    (%edx),%esi
 773:	01 00                	add    %eax,(%eax)
 775:	00 02                	add    %al,(%edx)
 777:	11 74 00 00          	adc    %esi,0x0(%eax,%eax,1)
 77b:	00 02                	add    %al,(%edx)
 77d:	04 07                	add    $0x7,%al
 77f:	20 01                	and    %al,(%ecx)
 781:	00 00                	add    %al,(%eax)
 783:	02 08                	add    (%eax),%cl
 785:	05 dd 00 00 00       	add    $0xdd,%eax
 78a:	03 06                	add    (%esi),%eax
 78c:	02 00                	add    (%eax),%al
 78e:	00 02                	add    %al,(%edx)
 790:	13 8d 00 00 00 02    	adc    0x2000000(%ebp),%ecx
 796:	08 07                	or     %al,(%edi)
 798:	16                   	push   %ss
 799:	01 00                	add    %eax,(%eax)
 79b:	00 05 10 02 65 e4    	add    %al,0xe4650210
 7a1:	00 00                	add    %al,(%eax)
 7a3:	00 06                	add    %al,(%esi)
 7a5:	3e 03 00             	add    %ds:(%eax),%eax
 7a8:	00 02                	add    %al,(%edx)
 7aa:	67 2c 00             	addr16 sub $0x0,%al
 7ad:	00 00                	add    %al,(%eax)
 7af:	00 06                	add    %al,(%esi)
 7b1:	20 03                	and    %al,(%ebx)
 7b3:	00 00                	add    %al,(%eax)
 7b5:	02 6a e4             	add    -0x1c(%edx),%ch
 7b8:	00 00                	add    %al,(%eax)
 7ba:	00 01                	add    %al,(%ecx)
 7bc:	07                   	pop    %es
 7bd:	69 64 00 02 6b 2c 00 	imul   $0x2c6b,0x2(%eax,%eax,1),%esp
 7c4:	00 
 7c5:	00 04 06             	add    %al,(%esi,%eax,1)
 7c8:	cc                   	int3   
 7c9:	03 00                	add    (%eax),%eax
 7cb:	00 02                	add    %al,(%edx)
 7cd:	6f                   	outsl  %ds:(%esi),(%dx)
 7ce:	e4 00                	in     $0x0,%al
 7d0:	00 00                	add    %al,(%eax)
 7d2:	05 06 10 04 00       	add    $0x41006,%eax
 7d7:	00 02                	add    %al,(%edx)
 7d9:	70 69                	jo     844 <PR_BOOTABLE+0x7c4>
 7db:	00 00                	add    %al,(%eax)
 7dd:	00 08                	add    %cl,(%eax)
 7df:	06                   	push   %es
 7e0:	cc                   	int3   
 7e1:	04 00                	add    $0x0,%al
 7e3:	00 02                	add    %al,(%edx)
 7e5:	71 69                	jno    850 <PR_BOOTABLE+0x7d0>
 7e7:	00 00                	add    %al,(%eax)
 7e9:	00 0c 00             	add    %cl,(%eax,%eax,1)
 7ec:	08 2c 00             	or     %ch,(%eax,%eax,1)
 7ef:	00 00                	add    %al,(%eax)
 7f1:	f4                   	hlt    
 7f2:	00 00                	add    %al,(%eax)
 7f4:	00 09                	add    %cl,(%ecx)
 7f6:	f4                   	hlt    
 7f7:	00 00                	add    %al,(%eax)
 7f9:	00 02                	add    %al,(%edx)
 7fb:	00 02                	add    %al,(%edx)
 7fd:	04 07                	add    $0x7,%al
 7ff:	1a 00                	sbb    (%eax),%al
 801:	00 00                	add    %al,(%eax)
 803:	0a 6d 62             	or     0x62(%ebp),%ch
 806:	72 00                	jb     808 <PR_BOOTABLE+0x788>
 808:	00 02                	add    %al,(%edx)
 80a:	02 61 3c             	add    0x3c(%ecx),%ah
 80d:	01 00                	add    %eax,(%eax)
 80f:	00 06                	add    %al,(%esi)
 811:	2c 02                	sub    $0x2,%al
 813:	00 00                	add    %al,(%eax)
 815:	02 63 3c             	add    0x3c(%ebx),%ah
 818:	01 00                	add    %eax,(%eax)
 81a:	00 00                	add    %al,(%eax)
 81c:	0b c0                	or     %eax,%eax
 81e:	01 00                	add    %eax,(%eax)
 820:	00 02                	add    %al,(%edx)
 822:	64                   	fs
 823:	4d                   	dec    %ebp
 824:	01 00                	add    %eax,(%eax)
 826:	00 b4 01 0b c9 02 00 	add    %dh,0x2c90b(%ecx,%eax,1)
 82d:	00 02                	add    %al,(%edx)
 82f:	72 5d                	jb     88e <PR_BOOTABLE+0x80e>
 831:	01 00                	add    %eax,(%eax)
 833:	00 be 01 0b 39 04    	add    %bh,0x4390b01(%esi)
 839:	00 00                	add    %al,(%eax)
 83b:	02 73 6d             	add    0x6d(%ebx),%dh
 83e:	01 00                	add    %eax,(%eax)
 840:	00 fe                	add    %bh,%dh
 842:	01 00                	add    %eax,(%eax)
 844:	08 2c 00             	or     %ch,(%eax,%eax,1)
 847:	00 00                	add    %al,(%eax)
 849:	4d                   	dec    %ebp
 84a:	01 00                	add    %eax,(%eax)
 84c:	00 0c f4             	add    %cl,(%esp,%esi,8)
 84f:	00 00                	add    %al,(%eax)
 851:	00 b3 01 00 08 2c    	add    %dh,0x2c080001(%ebx)
 857:	00 00                	add    %al,(%eax)
 859:	00 5d 01             	add    %bl,0x1(%ebp)
 85c:	00 00                	add    %al,(%eax)
 85e:	09 f4                	or     %esi,%esp
 860:	00 00                	add    %al,(%eax)
 862:	00 09                	add    %cl,(%ecx)
 864:	00 08                	add    %cl,(%eax)
 866:	94                   	xchg   %eax,%esp
 867:	00 00                	add    %al,(%eax)
 869:	00 6d 01             	add    %ch,0x1(%ebp)
 86c:	00 00                	add    %al,(%eax)
 86e:	09 f4                	or     %esi,%esp
 870:	00 00                	add    %al,(%eax)
 872:	00 03                	add    %al,(%ebx)
 874:	00 08                	add    %cl,(%eax)
 876:	2c 00                	sub    $0x0,%al
 878:	00 00                	add    %al,(%eax)
 87a:	7d 01                	jge    87d <PR_BOOTABLE+0x7fd>
 87c:	00 00                	add    %al,(%eax)
 87e:	09 f4                	or     %esi,%esp
 880:	00 00                	add    %al,(%eax)
 882:	00 01                	add    %al,(%ecx)
 884:	00 03                	add    %al,(%ebx)
 886:	a7                   	cmpsl  %es:(%edi),%ds:(%esi)
 887:	02 00                	add    (%eax),%al
 889:	00 02                	add    %al,(%edx)
 88b:	74 fb                	je     888 <PR_BOOTABLE+0x808>
 88d:	00 00                	add    %al,(%eax)
 88f:	00 0d 2a 03 00 00    	add    %cl,0x32a
 895:	18 02                	sbb    %al,(%edx)
 897:	7e c5                	jle    85e <PR_BOOTABLE+0x7de>
 899:	01 00                	add    %eax,(%eax)
 89b:	00 06                	add    %al,(%esi)
 89d:	0b 04 00             	or     (%eax,%eax,1),%eax
 8a0:	00 02                	add    %al,(%edx)
 8a2:	7f 69                	jg     90d <PR_BOOTABLE+0x88d>
 8a4:	00 00                	add    %al,(%eax)
 8a6:	00 00                	add    %al,(%eax)
 8a8:	06                   	push   %es
 8a9:	d5 03                	aad    $0x3
 8ab:	00 00                	add    %al,(%eax)
 8ad:	02 80 82 00 00 00    	add    0x82(%eax),%al
 8b3:	04 06                	add    $0x6,%al
 8b5:	5a                   	pop    %edx
 8b6:	03 00                	add    (%eax),%eax
 8b8:	00 02                	add    %al,(%edx)
 8ba:	81 82 00 00 00 0c 06 	addl   $0x2af06,0xc000000(%edx)
 8c1:	af 02 00 
 8c4:	00 02                	add    %al,(%edx)
 8c6:	82                   	(bad)  
 8c7:	69 00 00 00 14 00    	imul   $0x140000,(%eax),%eax
 8cd:	03 d3                	add    %ebx,%edx
 8cf:	02 00                	add    (%eax),%al
 8d1:	00 02                	add    %al,(%edx)
 8d3:	83 88 01 00 00 0d c9 	orl    $0xffffffc9,0xd000001(%eax)
 8da:	01 00                	add    %eax,(%eax)
 8dc:	00 34 02             	add    %dh,(%edx,%eax,1)
 8df:	8b 91 02 00 00 06    	mov    0x6000002(%ecx),%edx
 8e5:	c4 03                	les    (%ebx),%eax
 8e7:	00 00                	add    %al,(%eax)
 8e9:	02 8c 69 00 00 00 00 	add    0x0(%ecx,%ebp,2),%cl
 8f0:	06                   	push   %es
 8f1:	95                   	xchg   %eax,%ebp
 8f2:	03 00                	add    (%eax),%eax
 8f4:	00 02                	add    %al,(%edx)
 8f6:	8d 91 02 00 00 04    	lea    0x4000002(%ecx),%edx
 8fc:	06                   	push   %es
 8fd:	ad                   	lods   %ds:(%esi),%eax
 8fe:	02 00                	add    (%eax),%al
 900:	00 02                	add    %al,(%edx)
 902:	8e 45 00             	mov    0x0(%ebp),%es
 905:	00 00                	add    %al,(%eax)
 907:	10 06                	adc    %al,(%esi)
 909:	47                   	inc    %edi
 90a:	02 00                	add    (%eax),%al
 90c:	00 02                	add    %al,(%edx)
 90e:	8f 45 00             	popl   0x0(%ebp)
 911:	00 00                	add    %al,(%eax)
 913:	12 06                	adc    (%esi),%al
 915:	03 03                	add    (%ebx),%eax
 917:	00 00                	add    %al,(%eax)
 919:	02 90 69 00 00 00    	add    0x69(%eax),%dl
 91f:	14 06                	adc    $0x6,%al
 921:	fe 01                	incb   (%ecx)
 923:	00 00                	add    %al,(%eax)
 925:	02 91 69 00 00 00    	add    0x69(%ecx),%dl
 92b:	18 06                	sbb    %al,(%esi)
 92d:	af                   	scas   %es:(%edi),%eax
 92e:	03 00                	add    (%eax),%eax
 930:	00 02                	add    %al,(%edx)
 932:	92                   	xchg   %eax,%edx
 933:	69 00 00 00 1c 06    	imul   $0x61c0000,(%eax),%eax
 939:	e8 03 00 00 02       	call   2000941 <_end+0x1ff762d>
 93e:	93                   	xchg   %eax,%ebx
 93f:	69 00 00 00 20 06    	imul   $0x6200000,(%eax),%eax
 945:	37                   	aaa    
 946:	02 00                	add    (%eax),%al
 948:	00 02                	add    %al,(%edx)
 94a:	94                   	xchg   %eax,%esp
 94b:	69 00 00 00 24 06    	imul   $0x6240000,(%eax),%eax
 951:	c0 02 00             	rolb   $0x0,(%edx)
 954:	00 02                	add    %al,(%edx)
 956:	95                   	xchg   %eax,%ebp
 957:	45                   	inc    %ebp
 958:	00 00                	add    %al,(%eax)
 95a:	00 28                	add    %ch,(%eax)
 95c:	06                   	push   %es
 95d:	51                   	push   %ecx
 95e:	02 00                	add    (%eax),%al
 960:	00 02                	add    %al,(%edx)
 962:	96                   	xchg   %eax,%esi
 963:	45                   	inc    %ebp
 964:	00 00                	add    %al,(%eax)
 966:	00 2a                	add    %ch,(%edx)
 968:	06                   	push   %es
 969:	31 04 00             	xor    %eax,(%eax,%eax,1)
 96c:	00 02                	add    %al,(%edx)
 96e:	97                   	xchg   %eax,%edi
 96f:	45                   	inc    %ebp
 970:	00 00                	add    %al,(%eax)
 972:	00 2c 06             	add    %ch,(%esi,%eax,1)
 975:	95                   	xchg   %eax,%ebp
 976:	02 00                	add    (%eax),%al
 978:	00 02                	add    %al,(%edx)
 97a:	98                   	cwtl   
 97b:	45                   	inc    %ebp
 97c:	00 00                	add    %al,(%eax)
 97e:	00 2e                	add    %ch,(%esi)
 980:	06                   	push   %es
 981:	43                   	inc    %ebx
 982:	04 00                	add    $0x0,%al
 984:	00 02                	add    %al,(%edx)
 986:	99                   	cltd   
 987:	45                   	inc    %ebp
 988:	00 00                	add    %al,(%eax)
 98a:	00 30                	add    %dh,(%eax)
 98c:	06                   	push   %es
 98d:	d0 01                	rolb   (%ecx)
 98f:	00 00                	add    %al,(%eax)
 991:	02 9a 45 00 00 00    	add    0x45(%edx),%bl
 997:	32 00                	xor    (%eax),%al
 999:	08 2c 00             	or     %ch,(%eax,%eax,1)
 99c:	00 00                	add    %al,(%eax)
 99e:	a1 02 00 00 09       	mov    0x9000002,%eax
 9a3:	f4                   	hlt    
 9a4:	00 00                	add    %al,(%eax)
 9a6:	00 0b                	add    %cl,(%ebx)
 9a8:	00 03                	add    %al,(%ebx)
 9aa:	e5 01                	in     $0x1,%eax
 9ac:	00 00                	add    %al,(%eax)
 9ae:	02 9b d0 01 00 00    	add    0x1d0(%ebx),%bl
 9b4:	0d 8d 02 00 00       	or     $0x28d,%eax
 9b9:	20 02                	and    %al,(%edx)
 9bb:	9e                   	sahf   
 9bc:	19 03                	sbb    %eax,(%ebx)
 9be:	00 00                	add    %al,(%eax)
 9c0:	06                   	push   %es
 9c1:	86 02                	xchg   %al,(%edx)
 9c3:	00 00                	add    %al,(%eax)
 9c5:	02 9f 69 00 00 00    	add    0x69(%edi),%bl
 9cb:	00 06                	add    %al,(%esi)
 9cd:	23 02                	and    (%edx),%eax
 9cf:	00 00                	add    %al,(%eax)
 9d1:	02 a0 69 00 00 00    	add    0x69(%eax),%ah
 9d7:	04 06                	add    $0x6,%al
 9d9:	6c                   	insb   (%dx),%es:(%edi)
 9da:	03 00                	add    (%eax),%eax
 9dc:	00 02                	add    %al,(%edx)
 9de:	a1 69 00 00 00       	mov    0x69,%eax
 9e3:	08 06                	or     %al,(%esi)
 9e5:	c7 04 00 00 02 a2 69 	movl   $0x69a20200,(%eax,%eax,1)
 9ec:	00 00                	add    %al,(%eax)
 9ee:	00 0c 06             	add    %cl,(%esi,%eax,1)
 9f1:	28 04 00             	sub    %al,(%eax,%eax,1)
 9f4:	00 02                	add    %al,(%edx)
 9f6:	a3 69 00 00 00       	mov    %eax,0x69
 9fb:	10 06                	adc    %al,(%esi)
 9fd:	1b 02                	sbb    (%edx),%eax
 9ff:	00 00                	add    %al,(%eax)
 a01:	02 a4 69 00 00 00 14 	add    0x14000000(%ecx,%ebp,2),%ah
 a08:	06                   	push   %es
 a09:	82                   	(bad)  
 a0a:	03 00                	add    (%eax),%eax
 a0c:	00 02                	add    %al,(%edx)
 a0e:	a5                   	movsl  %ds:(%esi),%es:(%edi)
 a0f:	69 00 00 00 18 06    	imul   $0x6180000,(%eax),%eax
 a15:	b5 04                	mov    $0x4,%ch
 a17:	00 00                	add    %al,(%eax)
 a19:	02 a6 69 00 00 00    	add    0x69(%esi),%ah
 a1f:	1c 00                	sbb    $0x0,%al
 a21:	03 8d 02 00 00 02    	add    0x2000002(%ebp),%ecx
 a27:	a7                   	cmpsl  %es:(%edi),%ds:(%esi)
 a28:	ac                   	lods   %ds:(%esi),%al
 a29:	02 00                	add    (%eax),%al
 a2b:	00 05 04 02 b6 5d    	add    %al,0x5db60204
 a31:	03 00                	add    (%eax),%eax
 a33:	00 06                	add    %al,(%esi)
 a35:	19 03                	sbb    %eax,(%ebx)
 a37:	00 00                	add    %al,(%eax)
 a39:	02 b7 2c 00 00 00    	add    0x2c(%edi),%dh
 a3f:	00 06                	add    %al,(%esi)
 a41:	0d 03 00 00 02       	or     $0x2000003,%eax
 a46:	b8 2c 00 00 00       	mov    $0x2c,%eax
 a4b:	01 06                	add    %eax,(%esi)
 a4d:	13 03                	adc    (%ebx),%eax
 a4f:	00 00                	add    %al,(%eax)
 a51:	02 b9 2c 00 00 00    	add    0x2c(%ecx),%bh
 a57:	02 06                	add    (%esi),%al
 a59:	80 02 00             	addb   $0x0,(%edx)
 a5c:	00 02                	add    %al,(%edx)
 a5e:	ba 2c 00 00 00       	mov    $0x2c,%edx
 a63:	03 00                	add    (%eax),%eax
 a65:	05 10 02 c7 96       	add    $0x96c70210,%eax
 a6a:	03 00                	add    (%eax),%eax
 a6c:	00 06                	add    %al,(%esi)
 a6e:	08 04 00             	or     %al,(%eax,%eax,1)
 a71:	00 02                	add    %al,(%edx)
 a73:	c8 69 00 00          	enter  $0x69,$0x0
 a77:	00 00                	add    %al,(%eax)
 a79:	06                   	push   %es
 a7a:	78 02                	js     a7e <PR_BOOTABLE+0x9fe>
 a7c:	00 00                	add    %al,(%eax)
 a7e:	02 c9                	add    %cl,%cl
 a80:	69 00 00 00 04 06    	imul   $0x6040000,(%eax),%eax
 a86:	da 03                	fiaddl (%ebx)
 a88:	00 00                	add    %al,(%eax)
 a8a:	02 ca                	add    %dl,%cl
 a8c:	69 00 00 00 08 06    	imul   $0x6080000,(%eax),%eax
 a92:	7f 04                	jg     a98 <PR_BOOTABLE+0xa18>
 a94:	00 00                	add    %al,(%eax)
 a96:	02 cb                	add    %bl,%cl
 a98:	69 00 00 00 0c 00    	imul   $0xc0000,(%eax),%eax
 a9e:	05 10 02 cd cf       	add    $0xcfcd0210,%eax
 aa3:	03 00                	add    (%eax),%eax
 aa5:	00 07                	add    %al,(%edi)
 aa7:	6e                   	outsb  %ds:(%esi),(%dx)
 aa8:	75 6d                	jne    b17 <PR_BOOTABLE+0xa97>
 aaa:	00 02                	add    %al,(%edx)
 aac:	ce                   	into   
 aad:	69 00 00 00 00 06    	imul   $0x6000000,(%eax),%eax
 ab3:	0b 04 00             	or     (%eax,%eax,1),%eax
 ab6:	00 02                	add    %al,(%edx)
 ab8:	cf                   	iret   
 ab9:	69 00 00 00 04 06    	imul   $0x6040000,(%eax),%eax
 abf:	da 03                	fiaddl (%ebx)
 ac1:	00 00                	add    %al,(%eax)
 ac3:	02 d0                	add    %al,%dl
 ac5:	69 00 00 00 08 06    	imul   $0x6080000,(%eax),%eax
 acb:	a1 02 00 00 02       	mov    0x2000002,%eax
 ad0:	d1 69 00             	shrl   0x0(%ecx)
 ad3:	00 00                	add    %al,(%eax)
 ad5:	0c 00                	or     $0x0,%al
 ad7:	0e                   	push   %cs
 ad8:	10 02                	adc    %al,(%edx)
 ada:	c6                   	(bad)  
 adb:	ee                   	out    %al,(%dx)
 adc:	03 00                	add    (%eax),%eax
 ade:	00 0f                	add    %cl,(%edi)
 ae0:	73 02                	jae    ae4 <PR_BOOTABLE+0xa64>
 ae2:	00 00                	add    %al,(%eax)
 ae4:	02 cc                	add    %ah,%cl
 ae6:	5d                   	pop    %ebp
 ae7:	03 00                	add    (%eax),%eax
 ae9:	00 10                	add    %dl,(%eax)
 aeb:	65                   	gs
 aec:	6c                   	insb   (%dx),%es:(%edi)
 aed:	66                   	data16
 aee:	00 02                	add    %al,(%edx)
 af0:	d2 96 03 00 00 00    	rclb   %cl,0x3(%esi)
 af6:	0d 61 03 00 00       	or     $0x361,%eax
 afb:	60                   	pusha  
 afc:	02 ae f7 04 00 00    	add    0x4f7(%esi),%ch
 b02:	06                   	push   %es
 b03:	39 02                	cmp    %eax,(%edx)
 b05:	00 00                	add    %al,(%eax)
 b07:	02 af 69 00 00 00    	add    0x69(%edi),%ch
 b0d:	00 06                	add    %al,(%esi)
 b0f:	34 03                	xor    $0x3,%al
 b11:	00 00                	add    %al,(%eax)
 b13:	02 b2 69 00 00 00    	add    0x69(%edx),%dh
 b19:	04 06                	add    $0x6,%al
 b1b:	f0 03 00             	lock add (%eax),%eax
 b1e:	00 02                	add    %al,(%edx)
 b20:	b3 69                	mov    $0x69,%bl
 b22:	00 00                	add    %al,(%eax)
 b24:	00 08                	add    %cl,(%eax)
 b26:	06                   	push   %es
 b27:	9b                   	fwait
 b28:	03 00                	add    (%eax),%eax
 b2a:	00 02                	add    %al,(%edx)
 b2c:	bb 24 03 00 00       	mov    $0x324,%ebx
 b31:	0c 06                	or     $0x6,%al
 b33:	3f                   	aas    
 b34:	02 00                	add    (%eax),%al
 b36:	00 02                	add    %al,(%edx)
 b38:	be 69 00 00 00       	mov    $0x69,%esi
 b3d:	10 06                	adc    %al,(%esi)
 b3f:	74 04                	je     b45 <PR_BOOTABLE+0xac5>
 b41:	00 00                	add    %al,(%eax)
 b43:	02 c2                	add    %dl,%al
 b45:	69 00 00 00 14 06    	imul   $0x6140000,(%eax),%eax
 b4b:	69 02 00 00 02 c3    	imul   $0xc3020000,(%edx),%eax
 b51:	69 00 00 00 18 06    	imul   $0x6180000,(%eax),%eax
 b57:	47                   	inc    %edi
 b58:	03 00                	add    (%eax),%eax
 b5a:	00 02                	add    %al,(%edx)
 b5c:	d3 cf                	ror    %cl,%edi
 b5e:	03 00                	add    (%eax),%eax
 b60:	00 1c 06             	add    %bl,(%esi,%eax,1)
 b63:	55                   	push   %ebp
 b64:	03 00                	add    (%eax),%eax
 b66:	00 02                	add    %al,(%edx)
 b68:	d6                   	(bad)  
 b69:	69 00 00 00 2c 06    	imul   $0x62c0000,(%eax),%eax
 b6f:	db 01                	fildl  (%ecx)
 b71:	00 00                	add    %al,(%eax)
 b73:	02 d8                	add    %al,%bl
 b75:	69 00 00 00 30 06    	imul   $0x6300000,(%eax),%eax
 b7b:	1a 04 00             	sbb    (%eax,%eax,1),%al
 b7e:	00 02                	add    %al,(%edx)
 b80:	dc 69 00             	fsubrl 0x0(%ecx)
 b83:	00 00                	add    %al,(%eax)
 b85:	34 06                	xor    $0x6,%al
 b87:	b4 02                	mov    $0x2,%ah
 b89:	00 00                	add    %al,(%eax)
 b8b:	02 dd                	add    %ch,%bl
 b8d:	69 00 00 00 38 06    	imul   $0x6380000,(%eax),%eax
 b93:	b7 03                	mov    $0x3,%bh
 b95:	00 00                	add    %al,(%eax)
 b97:	02 e0                	add    %al,%ah
 b99:	69 00 00 00 3c 06    	imul   $0x63c0000,(%eax),%eax
 b9f:	89 04 00             	mov    %eax,(%eax,%eax,1)
 ba2:	00 02                	add    %al,(%edx)
 ba4:	e3 69                	jecxz  c0f <PR_BOOTABLE+0xb8f>
 ba6:	00 00                	add    %al,(%eax)
 ba8:	00 40 06             	add    %al,0x6(%eax)
 bab:	bd 04 00 00 02       	mov    $0x2000004,%ebp
 bb0:	e6 69                	out    %al,$0x69
 bb2:	00 00                	add    %al,(%eax)
 bb4:	00 44 06 71          	add    %al,0x71(%esi,%eax,1)
 bb8:	03 00                	add    (%eax),%eax
 bba:	00 02                	add    %al,(%edx)
 bbc:	e9 69 00 00 00       	jmp    c2a <PR_BOOTABLE+0xbaa>
 bc1:	48                   	dec    %eax
 bc2:	06                   	push   %es
 bc3:	fa                   	cli    
 bc4:	03 00                	add    (%eax),%eax
 bc6:	00 02                	add    %al,(%edx)
 bc8:	ea 69 00 00 00 4c 06 	ljmp   $0x64c,$0x69
 bcf:	df 03                	fild   (%ebx)
 bd1:	00 00                	add    %al,(%eax)
 bd3:	02 eb                	add    %bl,%ch
 bd5:	69 00 00 00 50 06    	imul   $0x6500000,(%eax),%eax
 bdb:	9a 04 00 00 02 ec 69 	lcall  $0x69ec,$0x2000004
 be2:	00 00                	add    %al,(%eax)
 be4:	00 54 06 ec          	add    %dl,-0x14(%esi,%eax,1)
 be8:	01 00                	add    %eax,(%eax)
 bea:	00 02                	add    %al,(%edx)
 bec:	ed                   	in     (%dx),%eax
 bed:	69 00 00 00 58 06    	imul   $0x6580000,(%eax),%eax
 bf3:	4b                   	dec    %ebx
 bf4:	04 00                	add    $0x0,%al
 bf6:	00 02                	add    %al,(%edx)
 bf8:	ee                   	out    %al,(%dx)
 bf9:	69 00 00 00 5c 00    	imul   $0x5c0000,(%eax),%eax
 bff:	03 df                	add    %edi,%ebx
 c01:	02 00                	add    (%eax),%al
 c03:	00 02                	add    %al,(%edx)
 c05:	ef                   	out    %eax,(%dx)
 c06:	ee                   	out    %al,(%dx)
 c07:	03 00                	add    (%eax),%eax
 c09:	00 11                	add    %dl,(%ecx)
 c0b:	0f 02 00             	lar    (%eax),%eax
 c0e:	00 01                	add    %al,(%ecx)
 c10:	2f                   	das    
 c11:	69 00 00 00 6c 8d    	imul   $0x8d6c0000,(%eax),%eax
 c17:	00 00                	add    %al,(%eax)
 c19:	82                   	(bad)  
 c1a:	00 00                	add    %al,(%eax)
 c1c:	00 01                	add    %al,(%ecx)
 c1e:	9c                   	pushf  
 c1f:	62 05 00 00 12 a7    	bound  %eax,0xa7120000
 c25:	03 00                	add    (%eax),%eax
 c27:	00 01                	add    %al,(%ecx)
 c29:	2f                   	das    
 c2a:	69 00 00 00 02 91    	imul   $0x91020000,(%eax),%eax
 c30:	00 13                	add    %dl,(%ebx)
 c32:	70 68                	jo     c9c <PR_BOOTABLE+0xc1c>
 c34:	00 01                	add    %al,(%ecx)
 c36:	32 62 05             	xor    0x5(%edx),%ah
 c39:	00 00                	add    %al,(%eax)
 c3b:	eb 02                	jmp    c3f <PR_BOOTABLE+0xbbf>
 c3d:	00 00                	add    %al,(%eax)
 c3f:	13 65 70             	adc    0x70(%ebp),%esp
 c42:	68 00 01 32 62       	push   $0x62320100
 c47:	05 00 00 16 03       	add    $0x3160000,%eax
 c4c:	00 00                	add    %al,(%eax)
 c4e:	14 8a                	adc    $0x8a,%al
 c50:	8d 00                	lea    (%eax),%eax
 c52:	00 9d 06 00 00 14    	add    %bl,0x14000006(%ebp)
 c58:	a6                   	cmpsb  %es:(%edi),%ds:(%esi)
 c59:	8d 00                	lea    (%eax),%eax
 c5b:	00 bd 06 00 00 14    	add    %bh,0x14000006(%ebp)
 c61:	d7                   	xlat   %ds:(%ebx)
 c62:	8d 00                	lea    (%eax),%eax
 c64:	00 9d 06 00 00 00    	add    %bl,0x6(%ebp)
 c6a:	15 04 19 03 00       	adc    $0x31904,%eax
 c6f:	00 11                	add    %dl,(%ecx)
 c71:	8a 03                	mov    (%ebx),%al
 c73:	00 00                	add    %al,(%eax)
 c75:	01 47 be             	add    %eax,-0x42(%edi)
 c78:	05 00 00 ee 8d       	add    $0x8dee0000,%eax
 c7d:	00 00                	add    %al,(%eax)
 c7f:	5f                   	pop    %edi
 c80:	00 00                	add    %al,(%eax)
 c82:	00 01                	add    %al,(%ecx)
 c84:	9c                   	pushf  
 c85:	be 05 00 00 12       	mov    $0x12000005,%esi
 c8a:	2f                   	das    
 c8b:	03 00                	add    (%eax),%eax
 c8d:	00 01                	add    %al,(%ecx)
 c8f:	47                   	inc    %edi
 c90:	c4 05 00 00 02 91    	les    0x91020000,%eax
 c96:	00 13                	add    %dl,(%ebx)
 c98:	70 00                	jo     c9a <PR_BOOTABLE+0xc1a>
 c9a:	01 49 c4             	add    %ecx,-0x3c(%ecx)
 c9d:	05 00 00 29 03       	add    $0x3290000,%eax
 ca2:	00 00                	add    %al,(%eax)
 ca4:	16                   	push   %ss
 ca5:	ac                   	lods   %ds:(%esi),%al
 ca6:	04 00                	add    $0x0,%al
 ca8:	00 01                	add    %al,(%ecx)
 caa:	4a                   	dec    %edx
 cab:	69 00 00 00 60 03    	imul   $0x3600000,(%eax),%eax
 cb1:	00 00                	add    %al,(%eax)
 cb3:	14 03                	adc    $0x3,%al
 cb5:	8e 00                	mov    (%eax),%es
 cb7:	00 db                	add    %bl,%bl
 cb9:	06                   	push   %es
 cba:	00 00                	add    %al,(%eax)
 cbc:	14 22                	adc    $0x22,%al
 cbe:	8e 00                	mov    (%eax),%es
 cc0:	00 ec                	add    %ch,%ah
 cc2:	06                   	push   %es
 cc3:	00 00                	add    %al,(%eax)
 cc5:	00 15 04 f7 04 00    	add    %dl,0x4f704
 ccb:	00 15 04 c5 01 00    	add    %dl,0x1c504
 cd1:	00 17                	add    %dl,(%edi)
 cd3:	f9                   	stc    
 cd4:	02 00                	add    (%eax),%al
 cd6:	00 01                	add    %al,(%ecx)
 cd8:	0c 4d                	or     $0x4d,%al
 cda:	8e 00                	mov    (%eax),%es
 cdc:	00 a6 00 00 00 01    	add    %ah,0x1000000(%esi)
 ce2:	9c                   	pushf  
 ce3:	86 06                	xchg   %al,(%esi)
 ce5:	00 00                	add    %al,(%eax)
 ce7:	18 64 65 76          	sbb    %ah,0x76(%ebp,%eiz,2)
 ceb:	00 01                	add    %al,(%ecx)
 ced:	0c 69                	or     $0x69,%al
 cef:	00 00                	add    %al,(%eax)
 cf1:	00 02                	add    %al,(%edx)
 cf3:	91                   	xchg   %eax,%ecx
 cf4:	00 18                	add    %bl,(%eax)
 cf6:	6d                   	insl   (%dx),%es:(%edi)
 cf7:	62 72 00             	bound  %esi,0x0(%edx)
 cfa:	01 0c 86             	add    %ecx,(%esi,%eax,4)
 cfd:	06                   	push   %es
 cfe:	00 00                	add    %al,(%eax)
 d00:	02 91 04 12 2f 03    	add    0x32f1204(%ecx),%dl
 d06:	00 00                	add    %al,(%eax)
 d08:	01 0c c4             	add    %ecx,(%esp,%eax,8)
 d0b:	05 00 00 02 91       	add    $0x91020000,%eax
 d10:	08 13                	or     %dl,(%ebx)
 d12:	69 00 01 11 62 00    	imul   $0x621101,(%eax),%eax
 d18:	00 00                	add    %al,(%eax)
 d1a:	ac                   	lods   %ds:(%esi),%al
 d1b:	03 00                	add    (%eax),%eax
 d1d:	00 16                	add    %dl,(%esi)
 d1f:	ec                   	in     (%dx),%al
 d20:	02 00                	add    (%eax),%al
 d22:	00 01                	add    %al,(%ecx)
 d24:	12 69 00             	adc    0x0(%ecx),%ch
 d27:	00 00                	add    %al,(%eax)
 d29:	e3 03                	jecxz  d2e <PR_BOOTABLE+0xcae>
 d2b:	00 00                	add    %al,(%eax)
 d2d:	16                   	push   %ss
 d2e:	00 02                	add    %al,(%edx)
 d30:	00 00                	add    %al,(%eax)
 d32:	01 22                	add    %esp,(%edx)
 d34:	69 00 00 00 0e 04    	imul   $0x40e0000,(%eax),%eax
 d3a:	00 00                	add    %al,(%eax)
 d3c:	14 62                	adc    $0x62,%al
 d3e:	8e 00                	mov    (%eax),%es
 d40:	00 fd                	add    %bh,%ch
 d42:	06                   	push   %es
 d43:	00 00                	add    %al,(%eax)
 d45:	14 6e                	adc    $0x6e,%al
 d47:	8e 00                	mov    (%eax),%es
 d49:	00 db                	add    %bl,%bl
 d4b:	06                   	push   %es
 d4c:	00 00                	add    %al,(%eax)
 d4e:	14 a3                	adc    $0xa3,%al
 d50:	8e 00                	mov    (%eax),%es
 d52:	00 bd 06 00 00 14    	add    %bh,0x14000006(%ebp)
 d58:	af                   	scas   %es:(%edi),%eax
 d59:	8e 00                	mov    (%eax),%es
 d5b:	00 68 05             	add    %ch,0x5(%eax)
 d5e:	00 00                	add    %al,(%eax)
 d60:	14 bb                	adc    $0xbb,%al
 d62:	8e 00                	mov    (%eax),%es
 d64:	00 db                	add    %bl,%bl
 d66:	06                   	push   %es
 d67:	00 00                	add    %al,(%eax)
 d69:	14 c3                	adc    $0xc3,%al
 d6b:	8e 00                	mov    (%eax),%es
 d6d:	00 02                	add    %al,(%edx)
 d6f:	05 00 00 14 d1       	add    $0xd1140000,%eax
 d74:	8e 00                	mov    (%eax),%es
 d76:	00 db                	add    %bl,%bl
 d78:	06                   	push   %es
 d79:	00 00                	add    %al,(%eax)
 d7b:	14 de                	adc    $0xde,%al
 d7d:	8e 00                	mov    (%eax),%es
 d7f:	00 0e                	add    %cl,(%esi)
 d81:	07                   	pop    %es
 d82:	00 00                	add    %al,(%eax)
 d84:	19 f3                	sbb    %esi,%ebx
 d86:	8e 00                	mov    (%eax),%es
 d88:	00 bd 06 00 00 00    	add    %bh,0x6(%ebp)
 d8e:	15 04 7d 01 00       	adc    $0x17d04,%eax
 d93:	00 1a                	add    %bl,(%edx)
 d95:	61                   	popa   
 d96:	03 00                	add    (%eax),%eax
 d98:	00 01                	add    %al,(%ecx)
 d9a:	08 f7                	or     %dh,%bh
 d9c:	04 00                	add    $0x0,%al
 d9e:	00 05 03 88 92 00    	add    %al,0x928803
 da4:	00 1b                	add    %bl,(%ebx)
 da6:	f2 00 00             	repnz add %al,(%eax)
 da9:	00 02                	add    %al,(%edx)
 dab:	78 bd                	js     d6a <PR_BOOTABLE+0xcea>
 dad:	06                   	push   %es
 dae:	00 00                	add    %al,(%eax)
 db0:	1c 69                	sbb    $0x69,%al
 db2:	00 00                	add    %al,(%eax)
 db4:	00 1c 69             	add    %bl,(%ecx,%ebp,2)
 db7:	00 00                	add    %al,(%eax)
 db9:	00 1c 69             	add    %bl,(%ecx,%ebp,2)
 dbc:	00 00                	add    %al,(%eax)
 dbe:	00 1c 69             	add    %bl,(%ecx,%ebp,2)
 dc1:	00 00                	add    %al,(%eax)
 dc3:	00 00                	add    %al,(%eax)
 dc5:	1b 9f 00 00 00 02    	sbb    0x2000000(%edi),%ebx
 dcb:	52                   	push   %edx
 dcc:	ce                   	into   
 dcd:	06                   	push   %es
 dce:	00 00                	add    %al,(%eax)
 dd0:	1c ce                	sbb    $0xce,%al
 dd2:	06                   	push   %es
 dd3:	00 00                	add    %al,(%eax)
 dd5:	00 15 04 d4 06 00    	add    %dl,0x6d404
 ddb:	00 02                	add    %al,(%edx)
 ddd:	01 06                	add    %eax,(%esi)
 ddf:	07                   	pop    %es
 de0:	01 00                	add    %eax,(%eax)
 de2:	00 1b                	add    %bl,(%ebx)
 de4:	96                   	xchg   %eax,%esi
 de5:	01 00                	add    %eax,(%eax)
 de7:	00 02                	add    %al,(%edx)
 de9:	4f                   	dec    %edi
 dea:	ec                   	in     (%dx),%al
 deb:	06                   	push   %es
 dec:	00 00                	add    %al,(%eax)
 dee:	1c ce                	sbb    $0xce,%al
 df0:	06                   	push   %es
 df1:	00 00                	add    %al,(%eax)
 df3:	00 1b                	add    %bl,(%ebx)
 df5:	a5                   	movsl  %ds:(%esi),%es:(%edi)
 df6:	00 00                	add    %al,(%eax)
 df8:	00 02                	add    %al,(%edx)
 dfa:	50                   	push   %eax
 dfb:	fd                   	std    
 dfc:	06                   	push   %es
 dfd:	00 00                	add    %al,(%eax)
 dff:	1c 57                	sbb    $0x57,%al
 e01:	00 00                	add    %al,(%eax)
 e03:	00 00                	add    %al,(%eax)
 e05:	1b 23                	sbb    (%ebx),%esp
 e07:	00 00                	add    %al,(%eax)
 e09:	00 02                	add    %al,(%edx)
 e0b:	51                   	push   %ecx
 e0c:	0e                   	push   %cs
 e0d:	07                   	pop    %es
 e0e:	00 00                	add    %al,(%eax)
 e10:	1c 62                	sbb    $0x62,%al
 e12:	00 00                	add    %al,(%eax)
 e14:	00 00                	add    %al,(%eax)
 e16:	1d 5d 02 00 00       	sbb    $0x25d,%eax
 e1b:	01 06                	add    %eax,(%esi)
 e1d:	1c 69                	sbb    $0x69,%al
 e1f:	00 00                	add    %al,(%eax)
 e21:	00 1c be             	add    %bl,(%esi,%edi,4)
 e24:	05 00 00 00 00       	add    $0x0,%eax
 e29:	64 00 00             	add    %al,%fs:(%eax)
 e2c:	00 02                	add    %al,(%edx)
 e2e:	00 cb                	add    %cl,%bl
 e30:	03 00                	add    (%eax),%eax
 e32:	00 04 01             	add    %al,(%ecx,%eax,1)
 e35:	95                   	xchg   %eax,%ebp
 e36:	02 00                	add    (%eax),%al
 e38:	00 f4                	add    %dh,%ah
 e3a:	8e 00                	mov    (%eax),%es
 e3c:	00 04 8f             	add    %al,(%edi,%ecx,4)
 e3f:	00 00                	add    %al,(%eax)
 e41:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 e44:	74 2f                	je     e75 <PR_BOOTABLE+0xdf5>
 e46:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 e49:	74 31                	je     e7c <PR_BOOTABLE+0xdfc>
 e4b:	2f                   	das    
 e4c:	65                   	gs
 e4d:	78 65                	js     eb4 <PR_BOOTABLE+0xe34>
 e4f:	63 5f 6b             	arpl   %bx,0x6b(%edi)
 e52:	65                   	gs
 e53:	72 6e                	jb     ec3 <PR_BOOTABLE+0xe43>
 e55:	65                   	gs
 e56:	6c                   	insb   (%dx),%es:(%edi)
 e57:	2e                   	cs
 e58:	53                   	push   %ebx
 e59:	00 2f                	add    %ch,(%edi)
 e5b:	68 6f 6d 65 2f       	push   $0x2f656d6f
 e60:	61                   	popa   
 e61:	63 63 74             	arpl   %sp,0x74(%ebx)
 e64:	73 2f                	jae    e95 <PR_BOOTABLE+0xe15>
 e66:	77 73                	ja     edb <PR_BOOTABLE+0xe5b>
 e68:	33 36                	xor    (%esi),%esi
 e6a:	32 2f                	xor    (%edi),%ch
 e6c:	63 73 34             	arpl   %si,0x34(%ebx)
 e6f:	32 32                	xor    (%edx),%dh
 e71:	2f                   	das    
 e72:	6d                   	insl   (%dx),%es:(%edi)
 e73:	63 65 72             	arpl   %sp,0x72(%ebp)
 e76:	74 69                	je     ee1 <PR_BOOTABLE+0xe61>
 e78:	6b 6f 73 00          	imul   $0x0,0x73(%edi),%ebp
 e7c:	47                   	inc    %edi
 e7d:	4e                   	dec    %esi
 e7e:	55                   	push   %ebp
 e7f:	20 41 53             	and    %al,0x53(%ecx)
 e82:	20 32                	and    %dh,(%edx)
 e84:	2e 32 33             	xor    %cs:(%ebx),%dh
 e87:	2e                   	cs
 e88:	35 32 2e 30 2e       	xor    $0x2e302e32,%eax
 e8d:	31 00                	xor    %eax,(%eax)
 e8f:	01                   	.byte 0x1
 e90:	80                   	.byte 0x80

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	01 11                	add    %edx,(%ecx)
   2:	00 10                	add    %dl,(%eax)
   4:	06                   	push   %es
   5:	11 01                	adc    %eax,(%ecx)
   7:	12 01                	adc    (%ecx),%al
   9:	03 08                	add    (%eax),%ecx
   b:	1b 08                	sbb    (%eax),%ecx
   d:	25 08 13 05 00       	and    $0x51308,%eax
  12:	00 00                	add    %al,(%eax)
  14:	01 11                	add    %edx,(%ecx)
  16:	01 25 0e 13 0b 03    	add    %esp,0x30b130e
  1c:	0e                   	push   %cs
  1d:	1b 0e                	sbb    (%esi),%ecx
  1f:	11 01                	adc    %eax,(%ecx)
  21:	12 06                	adc    (%esi),%al
  23:	10 17                	adc    %dl,(%edi)
  25:	00 00                	add    %al,(%eax)
  27:	02 24 00             	add    (%eax,%eax,1),%ah
  2a:	0b 0b                	or     (%ebx),%ecx
  2c:	3e 0b 03             	or     %ds:(%ebx),%eax
  2f:	0e                   	push   %cs
  30:	00 00                	add    %al,(%eax)
  32:	03 16                	add    (%esi),%edx
  34:	00 03                	add    %al,(%ebx)
  36:	0e                   	push   %cs
  37:	3a 0b                	cmp    (%ebx),%cl
  39:	3b 0b                	cmp    (%ebx),%ecx
  3b:	49                   	dec    %ecx
  3c:	13 00                	adc    (%eax),%eax
  3e:	00 04 24             	add    %al,(%esp)
  41:	00 0b                	add    %cl,(%ebx)
  43:	0b 3e                	or     (%esi),%edi
  45:	0b 03                	or     (%ebx),%eax
  47:	08 00                	or     %al,(%eax)
  49:	00 05 2e 01 03 08    	add    %al,0x803012e
  4f:	3a 0b                	cmp    (%ebx),%cl
  51:	3b 0b                	cmp    (%ebx),%ecx
  53:	27                   	daa    
  54:	19 49 13             	sbb    %ecx,0x13(%ecx)
  57:	20 0b                	and    %cl,(%ebx)
  59:	01 13                	add    %edx,(%ebx)
  5b:	00 00                	add    %al,(%eax)
  5d:	06                   	push   %es
  5e:	05 00 03 0e 3a       	add    $0x3a0e0300,%eax
  63:	0b 3b                	or     (%ebx),%edi
  65:	0b 49 13             	or     0x13(%ecx),%ecx
  68:	00 00                	add    %al,(%eax)
  6a:	07                   	pop    %es
  6b:	34 00                	xor    $0x0,%al
  6d:	03 0e                	add    (%esi),%ecx
  6f:	3a 0b                	cmp    (%ebx),%cl
  71:	3b 0b                	cmp    (%ebx),%ecx
  73:	49                   	dec    %ecx
  74:	13 00                	adc    (%eax),%eax
  76:	00 08                	add    %cl,(%eax)
  78:	2e 01 03             	add    %eax,%cs:(%ebx)
  7b:	0e                   	push   %cs
  7c:	3a 0b                	cmp    (%ebx),%cl
  7e:	3b 0b                	cmp    (%ebx),%ecx
  80:	27                   	daa    
  81:	19 20                	sbb    %esp,(%eax)
  83:	0b 01                	or     (%ecx),%eax
  85:	13 00                	adc    (%eax),%eax
  87:	00 09                	add    %cl,(%ecx)
  89:	05 00 03 08 3a       	add    $0x3a080300,%eax
  8e:	0b 3b                	or     (%ebx),%edi
  90:	0b 49 13             	or     0x13(%ecx),%ecx
  93:	00 00                	add    %al,(%eax)
  95:	0a 0f                	or     (%edi),%cl
  97:	00 0b                	add    %cl,(%ebx)
  99:	0b 00                	or     (%eax),%eax
  9b:	00 0b                	add    %cl,(%ebx)
  9d:	2e 01 3f             	add    %edi,%cs:(%edi)
  a0:	19 03                	sbb    %eax,(%ebx)
  a2:	0e                   	push   %cs
  a3:	3a 0b                	cmp    (%ebx),%cl
  a5:	3b 0b                	cmp    (%ebx),%ecx
  a7:	27                   	daa    
  a8:	19 11                	sbb    %edx,(%ecx)
  aa:	01 12                	add    %edx,(%edx)
  ac:	06                   	push   %es
  ad:	40                   	inc    %eax
  ae:	18 97 42 19 01 13    	sbb    %dl,0x13011942(%edi)
  b4:	00 00                	add    %al,(%eax)
  b6:	0c 05                	or     $0x5,%al
  b8:	00 03                	add    %al,(%ebx)
  ba:	08 3a                	or     %bh,(%edx)
  bc:	0b 3b                	or     (%ebx),%edi
  be:	0b 49 13             	or     0x13(%ecx),%ecx
  c1:	02 18                	add    (%eax),%bl
  c3:	00 00                	add    %al,(%eax)
  c5:	0d 05 00 03 0e       	or     $0xe030005,%eax
  ca:	3a 0b                	cmp    (%ebx),%cl
  cc:	3b 0b                	cmp    (%ebx),%ecx
  ce:	49                   	dec    %ecx
  cf:	13 02                	adc    (%edx),%eax
  d1:	18 00                	sbb    %al,(%eax)
  d3:	00 0e                	add    %cl,(%esi)
  d5:	34 00                	xor    $0x0,%al
  d7:	03 08                	add    (%eax),%ecx
  d9:	3a 0b                	cmp    (%ebx),%cl
  db:	3b 0b                	cmp    (%ebx),%ecx
  dd:	49                   	dec    %ecx
  de:	13 02                	adc    (%edx),%eax
  e0:	18 00                	sbb    %al,(%eax)
  e2:	00 0f                	add    %cl,(%edi)
  e4:	0f 00 0b             	str    (%ebx)
  e7:	0b 49 13             	or     0x13(%ecx),%ecx
  ea:	00 00                	add    %al,(%eax)
  ec:	10 35 00 49 13 00    	adc    %dh,0x134900
  f2:	00 11                	add    %dl,(%ecx)
  f4:	2e 01 3f             	add    %edi,%cs:(%edi)
  f7:	19 03                	sbb    %eax,(%ebx)
  f9:	0e                   	push   %cs
  fa:	3a 0b                	cmp    (%ebx),%cl
  fc:	3b 0b                	cmp    (%ebx),%ecx
  fe:	27                   	daa    
  ff:	19 49 13             	sbb    %ecx,0x13(%ecx)
 102:	11 01                	adc    %eax,(%ecx)
 104:	12 06                	adc    (%esi),%al
 106:	40                   	inc    %eax
 107:	18 97 42 19 01 13    	sbb    %dl,0x13011942(%edi)
 10d:	00 00                	add    %al,(%eax)
 10f:	12 05 00 03 0e 3a    	adc    0x3a0e0300,%al
 115:	0b 3b                	or     (%ebx),%edi
 117:	0b 49 13             	or     0x13(%ecx),%ecx
 11a:	02 17                	add    (%edi),%dl
 11c:	00 00                	add    %al,(%eax)
 11e:	13 34 00             	adc    (%eax,%eax,1),%esi
 121:	03 08                	add    (%eax),%ecx
 123:	3a 0b                	cmp    (%ebx),%cl
 125:	3b 0b                	cmp    (%ebx),%ecx
 127:	49                   	dec    %ecx
 128:	13 02                	adc    (%edx),%eax
 12a:	17                   	pop    %ss
 12b:	00 00                	add    %al,(%eax)
 12d:	14 89                	adc    $0x89,%al
 12f:	82                   	(bad)  
 130:	01 00                	add    %eax,(%eax)
 132:	11 01                	adc    %eax,(%ecx)
 134:	31 13                	xor    %edx,(%ebx)
 136:	00 00                	add    %al,(%eax)
 138:	15 26 00 49 13       	adc    $0x13490026,%eax
 13d:	00 00                	add    %al,(%eax)
 13f:	16                   	push   %ss
 140:	05 00 03 08 3a       	add    $0x3a080300,%eax
 145:	0b 3b                	or     (%ebx),%edi
 147:	0b 49 13             	or     0x13(%ecx),%ecx
 14a:	02 17                	add    (%edi),%dl
 14c:	00 00                	add    %al,(%eax)
 14e:	17                   	pop    %ss
 14f:	34 00                	xor    $0x0,%al
 151:	03 0e                	add    (%esi),%ecx
 153:	3a 0b                	cmp    (%ebx),%cl
 155:	3b 0b                	cmp    (%ebx),%ecx
 157:	49                   	dec    %ecx
 158:	13 02                	adc    (%edx),%eax
 15a:	17                   	pop    %ss
 15b:	00 00                	add    %al,(%eax)
 15d:	18 89 82 01 00 11    	sbb    %cl,0x11000182(%ecx)
 163:	01 95 42 19 31 13    	add    %edx,0x13311942(%ebp)
 169:	00 00                	add    %al,(%eax)
 16b:	19 01                	sbb    %eax,(%ecx)
 16d:	01 49 13             	add    %ecx,0x13(%ecx)
 170:	01 13                	add    %edx,(%ebx)
 172:	00 00                	add    %al,(%eax)
 174:	1a 21                	sbb    (%ecx),%ah
 176:	00 49 13             	add    %cl,0x13(%ecx)
 179:	2f                   	das    
 17a:	0b 00                	or     (%eax),%eax
 17c:	00 1b                	add    %bl,(%ebx)
 17e:	2e 00 03             	add    %al,%cs:(%ebx)
 181:	0e                   	push   %cs
 182:	3a 0b                	cmp    (%ebx),%cl
 184:	3b 0b                	cmp    (%ebx),%ecx
 186:	27                   	daa    
 187:	19 20                	sbb    %esp,(%eax)
 189:	0b 00                	or     (%eax),%eax
 18b:	00 1c 1d 01 31 13 52 	add    %bl,0x52133101(,%ebx,1)
 192:	01 55 17             	add    %edx,0x17(%ebp)
 195:	58                   	pop    %eax
 196:	0b 59 0b             	or     0xb(%ecx),%ebx
 199:	01 13                	add    %edx,(%ebx)
 19b:	00 00                	add    %al,(%eax)
 19d:	1d 1d 01 31 13       	sbb    $0x1331011d,%eax
 1a2:	52                   	push   %edx
 1a3:	01 55 17             	add    %edx,0x17(%ebp)
 1a6:	58                   	pop    %eax
 1a7:	0b 59 0b             	or     0xb(%ecx),%ebx
 1aa:	00 00                	add    %al,(%eax)
 1ac:	1e                   	push   %ds
 1ad:	05 00 31 13 1c       	add    $0x1c133100,%eax
 1b2:	05 00 00 1f 0b       	add    $0xb1f0000,%eax
 1b7:	01 55 17             	add    %edx,0x17(%ebp)
 1ba:	00 00                	add    %al,(%eax)
 1bc:	20 34 00             	and    %dh,(%eax,%eax,1)
 1bf:	31 13                	xor    %edx,(%ebx)
 1c1:	02 17                	add    (%edi),%dl
 1c3:	00 00                	add    %al,(%eax)
 1c5:	21 1d 01 31 13 11    	and    %ebx,0x11133101
 1cb:	01 12                	add    %edx,(%edx)
 1cd:	06                   	push   %es
 1ce:	58                   	pop    %eax
 1cf:	0b 59 0b             	or     0xb(%ecx),%ebx
 1d2:	01 13                	add    %edx,(%ebx)
 1d4:	00 00                	add    %al,(%eax)
 1d6:	22 05 00 31 13 1c    	and    0x1c133100,%al
 1dc:	0b 00                	or     (%eax),%eax
 1de:	00 23                	add    %ah,(%ebx)
 1e0:	05 00 31 13 02       	add    $0x2133100,%eax
 1e5:	18 00                	sbb    %al,(%eax)
 1e7:	00 24 1d 01 31 13 11 	add    %ah,0x11133101(,%ebx,1)
 1ee:	01 12                	add    %edx,(%edx)
 1f0:	06                   	push   %es
 1f1:	58                   	pop    %eax
 1f2:	0b 59 0b             	or     0xb(%ecx),%ebx
 1f5:	00 00                	add    %al,(%eax)
 1f7:	25 0b 01 11 01       	and    $0x111010b,%eax
 1fc:	12 06                	adc    (%esi),%al
 1fe:	00 00                	add    %al,(%eax)
 200:	26                   	es
 201:	05 00 31 13 02       	add    $0x2133100,%eax
 206:	17                   	pop    %ss
 207:	00 00                	add    %al,(%eax)
 209:	27                   	daa    
 20a:	34 00                	xor    $0x0,%al
 20c:	03 0e                	add    (%esi),%ecx
 20e:	3a 0b                	cmp    (%ebx),%cl
 210:	3b 0b                	cmp    (%ebx),%ecx
 212:	49                   	dec    %ecx
 213:	13 02                	adc    (%edx),%eax
 215:	18 00                	sbb    %al,(%eax)
 217:	00 28                	add    %ch,(%eax)
 219:	34 00                	xor    $0x0,%al
 21b:	03 0e                	add    (%esi),%ecx
 21d:	3a 0b                	cmp    (%ebx),%cl
 21f:	3b 0b                	cmp    (%ebx),%ecx
 221:	49                   	dec    %ecx
 222:	13 3f                	adc    (%edi),%edi
 224:	19 02                	sbb    %eax,(%edx)
 226:	18 00                	sbb    %al,(%eax)
 228:	00 00                	add    %al,(%eax)
 22a:	01 11                	add    %edx,(%ecx)
 22c:	01 25 0e 13 0b 03    	add    %esp,0x30b130e
 232:	0e                   	push   %cs
 233:	1b 0e                	sbb    (%esi),%ecx
 235:	11 01                	adc    %eax,(%ecx)
 237:	12 06                	adc    (%esi),%al
 239:	10 17                	adc    %dl,(%edi)
 23b:	00 00                	add    %al,(%eax)
 23d:	02 24 00             	add    (%eax,%eax,1),%ah
 240:	0b 0b                	or     (%ebx),%ecx
 242:	3e 0b 03             	or     %ds:(%ebx),%eax
 245:	0e                   	push   %cs
 246:	00 00                	add    %al,(%eax)
 248:	03 16                	add    (%esi),%edx
 24a:	00 03                	add    %al,(%ebx)
 24c:	0e                   	push   %cs
 24d:	3a 0b                	cmp    (%ebx),%cl
 24f:	3b 0b                	cmp    (%ebx),%ecx
 251:	49                   	dec    %ecx
 252:	13 00                	adc    (%eax),%eax
 254:	00 04 24             	add    %al,(%esp)
 257:	00 0b                	add    %cl,(%ebx)
 259:	0b 3e                	or     (%esi),%edi
 25b:	0b 03                	or     (%ebx),%eax
 25d:	08 00                	or     %al,(%eax)
 25f:	00 05 13 01 0b 0b    	add    %al,0xb0b0113
 265:	3a 0b                	cmp    (%ebx),%cl
 267:	3b 0b                	cmp    (%ebx),%ecx
 269:	01 13                	add    %edx,(%ebx)
 26b:	00 00                	add    %al,(%eax)
 26d:	06                   	push   %es
 26e:	0d 00 03 0e 3a       	or     $0x3a0e0300,%eax
 273:	0b 3b                	or     (%ebx),%edi
 275:	0b 49 13             	or     0x13(%ecx),%ecx
 278:	38 0b                	cmp    %cl,(%ebx)
 27a:	00 00                	add    %al,(%eax)
 27c:	07                   	pop    %es
 27d:	0d 00 03 08 3a       	or     $0x3a080300,%eax
 282:	0b 3b                	or     (%ebx),%edi
 284:	0b 49 13             	or     0x13(%ecx),%ecx
 287:	38 0b                	cmp    %cl,(%ebx)
 289:	00 00                	add    %al,(%eax)
 28b:	08 01                	or     %al,(%ecx)
 28d:	01 49 13             	add    %ecx,0x13(%ecx)
 290:	01 13                	add    %edx,(%ebx)
 292:	00 00                	add    %al,(%eax)
 294:	09 21                	or     %esp,(%ecx)
 296:	00 49 13             	add    %cl,0x13(%ecx)
 299:	2f                   	das    
 29a:	0b 00                	or     (%eax),%eax
 29c:	00 0a                	add    %cl,(%edx)
 29e:	13 01                	adc    (%ecx),%eax
 2a0:	03 08                	add    (%eax),%ecx
 2a2:	0b 05 3a 0b 3b 0b    	or     0xb3b0b3a,%eax
 2a8:	01 13                	add    %edx,(%ebx)
 2aa:	00 00                	add    %al,(%eax)
 2ac:	0b 0d 00 03 0e 3a    	or     0x3a0e0300,%ecx
 2b2:	0b 3b                	or     (%ebx),%edi
 2b4:	0b 49 13             	or     0x13(%ecx),%ecx
 2b7:	38 05 00 00 0c 21    	cmp    %al,0x210c0000
 2bd:	00 49 13             	add    %cl,0x13(%ecx)
 2c0:	2f                   	das    
 2c1:	05 00 00 0d 13       	add    $0x130d0000,%eax
 2c6:	01 03                	add    %eax,(%ebx)
 2c8:	0e                   	push   %cs
 2c9:	0b 0b                	or     (%ebx),%ecx
 2cb:	3a 0b                	cmp    (%ebx),%cl
 2cd:	3b 0b                	cmp    (%ebx),%ecx
 2cf:	01 13                	add    %edx,(%ebx)
 2d1:	00 00                	add    %al,(%eax)
 2d3:	0e                   	push   %cs
 2d4:	17                   	pop    %ss
 2d5:	01 0b                	add    %ecx,(%ebx)
 2d7:	0b 3a                	or     (%edx),%edi
 2d9:	0b 3b                	or     (%ebx),%edi
 2db:	0b 01                	or     (%ecx),%eax
 2dd:	13 00                	adc    (%eax),%eax
 2df:	00 0f                	add    %cl,(%edi)
 2e1:	0d 00 03 0e 3a       	or     $0x3a0e0300,%eax
 2e6:	0b 3b                	or     (%ebx),%edi
 2e8:	0b 49 13             	or     0x13(%ecx),%ecx
 2eb:	00 00                	add    %al,(%eax)
 2ed:	10 0d 00 03 08 3a    	adc    %cl,0x3a080300
 2f3:	0b 3b                	or     (%ebx),%edi
 2f5:	0b 49 13             	or     0x13(%ecx),%ecx
 2f8:	00 00                	add    %al,(%eax)
 2fa:	11 2e                	adc    %ebp,(%esi)
 2fc:	01 3f                	add    %edi,(%edi)
 2fe:	19 03                	sbb    %eax,(%ebx)
 300:	0e                   	push   %cs
 301:	3a 0b                	cmp    (%ebx),%cl
 303:	3b 0b                	cmp    (%ebx),%ecx
 305:	27                   	daa    
 306:	19 49 13             	sbb    %ecx,0x13(%ecx)
 309:	11 01                	adc    %eax,(%ecx)
 30b:	12 06                	adc    (%esi),%al
 30d:	40                   	inc    %eax
 30e:	18 97 42 19 01 13    	sbb    %dl,0x13011942(%edi)
 314:	00 00                	add    %al,(%eax)
 316:	12 05 00 03 0e 3a    	adc    0x3a0e0300,%al
 31c:	0b 3b                	or     (%ebx),%edi
 31e:	0b 49 13             	or     0x13(%ecx),%ecx
 321:	02 18                	add    (%eax),%bl
 323:	00 00                	add    %al,(%eax)
 325:	13 34 00             	adc    (%eax,%eax,1),%esi
 328:	03 08                	add    (%eax),%ecx
 32a:	3a 0b                	cmp    (%ebx),%cl
 32c:	3b 0b                	cmp    (%ebx),%ecx
 32e:	49                   	dec    %ecx
 32f:	13 02                	adc    (%edx),%eax
 331:	17                   	pop    %ss
 332:	00 00                	add    %al,(%eax)
 334:	14 89                	adc    $0x89,%al
 336:	82                   	(bad)  
 337:	01 00                	add    %eax,(%eax)
 339:	11 01                	adc    %eax,(%ecx)
 33b:	31 13                	xor    %edx,(%ebx)
 33d:	00 00                	add    %al,(%eax)
 33f:	15 0f 00 0b 0b       	adc    $0xb0b000f,%eax
 344:	49                   	dec    %ecx
 345:	13 00                	adc    (%eax),%eax
 347:	00 16                	add    %dl,(%esi)
 349:	34 00                	xor    $0x0,%al
 34b:	03 0e                	add    (%esi),%ecx
 34d:	3a 0b                	cmp    (%ebx),%cl
 34f:	3b 0b                	cmp    (%ebx),%ecx
 351:	49                   	dec    %ecx
 352:	13 02                	adc    (%edx),%eax
 354:	17                   	pop    %ss
 355:	00 00                	add    %al,(%eax)
 357:	17                   	pop    %ss
 358:	2e 01 3f             	add    %edi,%cs:(%edi)
 35b:	19 03                	sbb    %eax,(%ebx)
 35d:	0e                   	push   %cs
 35e:	3a 0b                	cmp    (%ebx),%cl
 360:	3b 0b                	cmp    (%ebx),%ecx
 362:	27                   	daa    
 363:	19 11                	sbb    %edx,(%ecx)
 365:	01 12                	add    %edx,(%edx)
 367:	06                   	push   %es
 368:	40                   	inc    %eax
 369:	18 97 42 19 01 13    	sbb    %dl,0x13011942(%edi)
 36f:	00 00                	add    %al,(%eax)
 371:	18 05 00 03 08 3a    	sbb    %al,0x3a080300
 377:	0b 3b                	or     (%ebx),%edi
 379:	0b 49 13             	or     0x13(%ecx),%ecx
 37c:	02 18                	add    (%eax),%bl
 37e:	00 00                	add    %al,(%eax)
 380:	19 89 82 01 00 11    	sbb    %ecx,0x11000182(%ecx)
 386:	01 95 42 19 31 13    	add    %edx,0x13311942(%ebp)
 38c:	00 00                	add    %al,(%eax)
 38e:	1a 34 00             	sbb    (%eax,%eax,1),%dh
 391:	03 0e                	add    (%esi),%ecx
 393:	3a 0b                	cmp    (%ebx),%cl
 395:	3b 0b                	cmp    (%ebx),%ecx
 397:	49                   	dec    %ecx
 398:	13 3f                	adc    (%edi),%edi
 39a:	19 02                	sbb    %eax,(%edx)
 39c:	18 00                	sbb    %al,(%eax)
 39e:	00 1b                	add    %bl,(%ebx)
 3a0:	2e 01 3f             	add    %edi,%cs:(%edi)
 3a3:	19 03                	sbb    %eax,(%ebx)
 3a5:	0e                   	push   %cs
 3a6:	3a 0b                	cmp    (%ebx),%cl
 3a8:	3b 0b                	cmp    (%ebx),%ecx
 3aa:	27                   	daa    
 3ab:	19 3c 19             	sbb    %edi,(%ecx,%ebx,1)
 3ae:	01 13                	add    %edx,(%ebx)
 3b0:	00 00                	add    %al,(%eax)
 3b2:	1c 05                	sbb    $0x5,%al
 3b4:	00 49 13             	add    %cl,0x13(%ecx)
 3b7:	00 00                	add    %al,(%eax)
 3b9:	1d 2e 01 3f 19       	sbb    $0x193f012e,%eax
 3be:	03 0e                	add    (%esi),%ecx
 3c0:	3a 0b                	cmp    (%ebx),%cl
 3c2:	3b 0b                	cmp    (%ebx),%ecx
 3c4:	27                   	daa    
 3c5:	19 3c 19             	sbb    %edi,(%ecx,%ebx,1)
 3c8:	00 00                	add    %al,(%eax)
 3ca:	00 01                	add    %al,(%ecx)
 3cc:	11 00                	adc    %eax,(%eax)
 3ce:	10 06                	adc    %al,(%esi)
 3d0:	11 01                	adc    %eax,(%ecx)
 3d2:	12 01                	adc    (%ecx),%al
 3d4:	03 08                	add    (%eax),%ecx
 3d6:	1b 08                	sbb    (%eax),%ecx
 3d8:	25 08 13 05 00       	and    $0x51308,%eax
 3dd:	00 00                	add    %al,(%eax)

Disassembly of section .debug_line:

00000000 <.debug_line>:
   0:	7c 00                	jl     2 <CR0_PE_ON+0x1>
   2:	00 00                	add    %al,(%eax)
   4:	02 00                	add    (%eax),%al
   6:	29 00                	sub    %eax,(%eax)
   8:	00 00                	add    %al,(%eax)
   a:	01 01                	add    %eax,(%ecx)
   c:	fb                   	sti    
   d:	0e                   	push   %cs
   e:	0d 00 01 01 01       	or     $0x1010100,%eax
  13:	01 00                	add    %eax,(%eax)
  15:	00 00                	add    %al,(%eax)
  17:	01 00                	add    %eax,(%eax)
  19:	00 01                	add    %al,(%ecx)
  1b:	62 6f 6f             	bound  %ebp,0x6f(%edi)
  1e:	74 2f                	je     4f <PROT_MODE_DSEG+0x3f>
  20:	62 6f 6f             	bound  %ebp,0x6f(%edi)
  23:	74 31                	je     56 <PROT_MODE_DSEG+0x46>
  25:	00 00                	add    %al,(%eax)
  27:	62 6f 6f             	bound  %ebp,0x6f(%edi)
  2a:	74 31                	je     5d <PROT_MODE_DSEG+0x4d>
  2c:	2e                   	cs
  2d:	53                   	push   %ebx
  2e:	00 01                	add    %al,(%ecx)
  30:	00 00                	add    %al,(%eax)
  32:	00 00                	add    %al,(%eax)
  34:	05 02 00 7e 00       	add    $0x7e0002,%eax
  39:	00 03                	add    %al,(%ebx)
  3b:	2a 01                	sub    (%ecx),%al
  3d:	21 24 2f             	and    %esp,(%edi,%ebp,1)
  40:	2f                   	das    
  41:	2f                   	das    
  42:	2f                   	das    
  43:	30 2f                	xor    %ch,(%edi)
  45:	2f                   	das    
  46:	2f                   	das    
  47:	2f                   	das    
  48:	34 3d                	xor    $0x3d,%al
  4a:	42                   	inc    %edx
  4b:	3d 67 3e 67 67       	cmp    $0x67673e67,%eax
  50:	30 2f                	xor    %ch,(%edi)
  52:	67 30 83 3d 4b       	xor    %al,0x4b3d(%bp,%di)
  57:	2f                   	das    
  58:	30 2f                	xor    %ch,(%edi)
  5a:	3d 2f 30 3d 3d       	cmp    $0x3d3d302f,%eax
  5f:	31 26                	xor    %esp,(%esi)
  61:	59                   	pop    %ecx
  62:	3d 4b 40 5c 4b       	cmp    $0x4b5c404b,%eax
  67:	2f                   	das    
  68:	2f                   	das    
  69:	2f                   	das    
  6a:	2f                   	das    
  6b:	34 59                	xor    $0x59,%al
  6d:	59                   	pop    %ecx
  6e:	59                   	pop    %ecx
  6f:	21 5b 27             	and    %ebx,0x27(%ebx)
  72:	21 30                	and    %esi,(%eax)
  74:	21 2f                	and    %ebp,(%edi)
  76:	2f                   	das    
  77:	2f                   	das    
  78:	30 21                	xor    %ah,(%ecx)
  7a:	02 fc                	add    %ah,%bh
  7c:	18 00                	sbb    %al,(%eax)
  7e:	01 01                	add    %eax,(%ecx)
  80:	5c                   	pop    %esp
  81:	01 00                	add    %eax,(%eax)
  83:	00 02                	add    %al,(%edx)
  85:	00 3a                	add    %bh,(%edx)
  87:	00 00                	add    %al,(%eax)
  89:	00 01                	add    %al,(%ecx)
  8b:	01 fb                	add    %edi,%ebx
  8d:	0e                   	push   %cs
  8e:	0d 00 01 01 01       	or     $0x1010100,%eax
  93:	01 00                	add    %eax,(%eax)
  95:	00 00                	add    %al,(%eax)
  97:	01 00                	add    %eax,(%eax)
  99:	00 01                	add    %al,(%ecx)
  9b:	62 6f 6f             	bound  %ebp,0x6f(%edi)
  9e:	74 2f                	je     cf <PR_BOOTABLE+0x4f>
  a0:	62 6f 6f             	bound  %ebp,0x6f(%edi)
  a3:	74 31                	je     d6 <PR_BOOTABLE+0x56>
  a5:	00 00                	add    %al,(%eax)
  a7:	62 6f 6f             	bound  %ebp,0x6f(%edi)
  aa:	74 31                	je     dd <PR_BOOTABLE+0x5d>
  ac:	6c                   	insb   (%dx),%es:(%edi)
  ad:	69 62 2e 63 00 01 00 	imul   $0x10063,0x2e(%edx),%esp
  b4:	00 62 6f             	add    %ah,0x6f(%edx)
  b7:	6f                   	outsl  %ds:(%esi),(%dx)
  b8:	74 31                	je     eb <PR_BOOTABLE+0x6b>
  ba:	6c                   	insb   (%dx),%es:(%edi)
  bb:	69 62 2e 68 00 01 00 	imul   $0x10068,0x2e(%edx),%esp
  c2:	00 00                	add    %al,(%eax)
  c4:	00 05 02 28 8b 00    	add    %al,0x8b2802
  ca:	00 03                	add    %al,(%ebx)
  cc:	09 01                	or     %eax,(%ecx)
  ce:	3c 3e                	cmp    $0x3e,%al
  d0:	3b 83 2f 67 33 58    	cmp    0x5833672f(%ebx),%eax
  d6:	3d 00 02 04 01       	cmp    $0x1040200,%eax
  db:	91                   	xchg   %eax,%ecx
  dc:	84 08                	test   %cl,(%eax)
  de:	3f                   	aas    
  df:	03 09                	add    (%ecx),%ecx
  e1:	74 21                	je     104 <PR_BOOTABLE+0x84>
  e3:	57                   	push   %edi
  e4:	3d 08 f3 f3 5c       	cmp    $0x5cf3f308,%eax
  e9:	3d 3d 1f 59 24       	cmp    $0x24591f3d,%eax
  ee:	3d 00 02 04 01       	cmp    $0x1040200,%eax
  f3:	08 15 03 14 3c 23    	or     %dl,0x233c1403
  f9:	2b 2e                	sub    (%esi),%ebp
  fb:	00 02                	add    %al,(%edx)
  fd:	04 01                	add    $0x1,%al
  ff:	3f                   	aas    
 100:	00 02                	add    %al,(%edx)
 102:	04 02                	add    $0x2,%al
 104:	67 3e 33 58 40       	xor    %ds:0x40(%bx,%si),%ebx
 109:	00 02                	add    %al,(%edx)
 10b:	04 01                	add    $0x1,%al
 10d:	06                   	push   %es
 10e:	9e                   	sahf   
 10f:	00 02                	add    %al,(%edx)
 111:	04 02                	add    $0x2,%al
 113:	06                   	push   %es
 114:	4c                   	dec    %esp
 115:	00 02                	add    %al,(%edx)
 117:	04 02                	add    $0x2,%al
 119:	4b                   	dec    %ebx
 11a:	00 02                	add    %al,(%edx)
 11c:	04 02                	add    $0x2,%al
 11e:	67 00 02             	add    %al,(%bp,%si)
 121:	04 02                	add    $0x2,%al
 123:	2a 00                	sub    (%eax),%al
 125:	02 04 02             	add    (%edx,%eax,1),%al
 128:	24 00                	and    $0x0,%al
 12a:	02 04 02             	add    (%edx,%eax,1),%al
 12d:	38 42 79             	cmp    %al,0x79(%edx)
 130:	ac                   	lods   %ds:(%esi),%al
 131:	00 02                	add    %al,(%edx)
 133:	04 01                	add    $0x1,%al
 135:	08 a6 00 02 04 01    	or     %ah,0x1040200(%esi)
 13b:	9f                   	lahf   
 13c:	00 02                	add    %al,(%edx)
 13e:	04 01                	add    $0x1,%al
 140:	2d 00 02 04 01       	sub    $0x1040200,%eax
 145:	4b                   	dec    %ebx
 146:	2d 4c 48 30 2f       	sub    $0x2f30484c,%eax
 14b:	75 4b                	jne    198 <PR_BOOTABLE+0x118>
 14d:	3d 65 5d 3e 08       	cmp    $0x83e5d65,%eax
 152:	4b                   	dec    %ebx
 153:	33 3e                	xor    (%esi),%edi
 155:	08 4b 03             	or     %cl,0x3(%ebx)
 158:	bd 7f 2e 3d c9       	mov    $0xc93d2e7f,%ebp
 15d:	91                   	xchg   %eax,%ecx
 15e:	1f                   	pop    %ds
 15f:	03 d1                	add    %ecx,%edx
 161:	00 58 04             	add    %bl,0x4(%eax)
 164:	02 03                	add    (%ebx),%al
 166:	99                   	cltd   
 167:	7f 20                	jg     189 <PR_BOOTABLE+0x109>
 169:	04 01                	add    $0x1,%al
 16b:	03 e7                	add    %edi,%esp
 16d:	00 58 04             	add    %bl,0x4(%eax)
 170:	02 03                	add    (%ebx),%al
 172:	99                   	cltd   
 173:	7f 66                	jg     1db <PR_BOOTABLE+0x15b>
 175:	04 01                	add    $0x1,%al
 177:	03 e1                	add    %ecx,%esp
 179:	00 20                	add    %ah,(%eax)
 17b:	04 02                	add    $0x2,%al
 17d:	03 92 7f 74 04 01    	add    0x104747f(%edx),%edx
 183:	03 fb                	add    %ebx,%edi
 185:	00 08                	add    %cl,(%eax)
 187:	3c 04                	cmp    $0x4,%al
 189:	02 03                	add    (%ebx),%al
 18b:	85 7f 2e             	test   %edi,0x2e(%edi)
 18e:	04 01                	add    $0x1,%al
 190:	03 fb                	add    %ebx,%edi
 192:	00 2e                	add    %ch,(%esi)
 194:	04 02                	add    $0x2,%al
 196:	03 85 7f 66 04 01    	add    0x104667f(%ebp),%eax
 19c:	03 fc                	add    %esp,%edi
 19e:	00 20                	add    %ah,(%eax)
 1a0:	04 02                	add    $0x2,%al
 1a2:	03 84 7f 3c 04 01 03 	add    0x301043c(%edi,%edi,2),%eax
 1a9:	fc                   	cld    
 1aa:	00 2e                	add    %ch,(%esi)
 1ac:	04 02                	add    $0x2,%al
 1ae:	03 84 7f 58 03 0d 66 	add    0x660d0358(%edi,%edi,2),%eax
 1b5:	04 01                	add    $0x1,%al
 1b7:	03 e1                	add    %ecx,%esp
 1b9:	00 20                	add    %ah,(%eax)
 1bb:	04 02                	add    $0x2,%al
 1bd:	03 a6 7f 74 04 01    	add    0x104747f(%esi),%esp
 1c3:	03 f0                	add    %eax,%esi
 1c5:	00 f2                	add    %dh,%dl
 1c7:	42                   	inc    %edx
 1c8:	90                   	nop
 1c9:	3f                   	aas    
 1ca:	31 63 6c             	xor    %esp,0x6c(%ebx)
 1cd:	37                   	aaa    
 1ce:	41                   	inc    %ecx
 1cf:	00 02                	add    %al,(%edx)
 1d1:	04 01                	add    $0x1,%al
 1d3:	41                   	inc    %ecx
 1d4:	4c                   	dec    %esp
 1d5:	22 1e                	and    (%esi),%bl
 1d7:	21 65 5a             	and    %esp,0x5a(%ebp)
 1da:	4c                   	dec    %esp
 1db:	02 08                	add    (%eax),%cl
 1dd:	00 01                	add    %al,(%ecx)
 1df:	01 b1 00 00 00 02    	add    %esi,0x2000000(%ecx)
 1e5:	00 3b                	add    %bh,(%ebx)
 1e7:	00 00                	add    %al,(%eax)
 1e9:	00 01                	add    %al,(%ecx)
 1eb:	01 fb                	add    %edi,%ebx
 1ed:	0e                   	push   %cs
 1ee:	0d 00 01 01 01       	or     $0x1010100,%eax
 1f3:	01 00                	add    %eax,(%eax)
 1f5:	00 00                	add    %al,(%eax)
 1f7:	01 00                	add    %eax,(%eax)
 1f9:	00 01                	add    %al,(%ecx)
 1fb:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 1fe:	74 2f                	je     22f <PR_BOOTABLE+0x1af>
 200:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 203:	74 31                	je     236 <PR_BOOTABLE+0x1b6>
 205:	00 00                	add    %al,(%eax)
 207:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 20a:	74 31                	je     23d <PR_BOOTABLE+0x1bd>
 20c:	6d                   	insl   (%dx),%es:(%edi)
 20d:	61                   	popa   
 20e:	69 6e 2e 63 00 01 00 	imul   $0x10063,0x2e(%esi),%ebp
 215:	00 62 6f             	add    %ah,0x6f(%edx)
 218:	6f                   	outsl  %ds:(%esi),(%dx)
 219:	74 31                	je     24c <PR_BOOTABLE+0x1cc>
 21b:	6c                   	insb   (%dx),%es:(%edi)
 21c:	69 62 2e 68 00 01 00 	imul   $0x10068,0x2e(%edx),%esp
 223:	00 00                	add    %al,(%eax)
 225:	00 05 02 6c 8d 00    	add    %al,0x8d6c02
 22b:	00 03                	add    %al,(%ebx)
 22d:	2f                   	das    
 22e:	01 90 40 08 23 e5    	add    %edx,-0x1adcf7c0(%eax)
 234:	f5                   	cmc    
 235:	ad                   	lods   %ds:(%esi),%eax
 236:	00 02                	add    %al,(%edx)
 238:	04 01                	add    $0x1,%al
 23a:	ca 00 02             	lret   $0x200
 23d:	04 02                	add    $0x2,%al
 23f:	4c                   	dec    %esp
 240:	00 02                	add    %al,(%edx)
 242:	04 02                	add    $0x2,%al
 244:	1e                   	push   %ds
 245:	00 02                	add    %al,(%edx)
 247:	04 02                	add    $0x2,%al
 249:	3e 00 02             	add    %al,%ds:(%edx)
 24c:	04 02                	add    $0x2,%al
 24e:	d4 5d                	aam    $0x5d
 250:	59                   	pop    %ecx
 251:	65                   	gs
 252:	59                   	pop    %ecx
 253:	32 87 c6 31 00 02    	xor    0x20031c6(%edi),%al
 259:	04 01                	add    $0x1,%al
 25b:	06                   	push   %es
 25c:	3c 06                	cmp    $0x6,%al
 25e:	d8 3d 3b 67 00 02    	fdivrs 0x200673b
 264:	04 02                	add    $0x2,%al
 266:	55                   	push   %ebp
 267:	00 02                	add    %al,(%edx)
 269:	04 01                	add    $0x1,%al
 26b:	06                   	push   %es
 26c:	82                   	(bad)  
 26d:	06                   	push   %es
 26e:	6d                   	insl   (%dx),%es:(%edi)
 26f:	68 55 69 03 b6       	push   $0xb6036955
 274:	7f 74                	jg     2ea <PR_BOOTABLE+0x26a>
 276:	82                   	(bad)  
 277:	3d 08 87 76 a0       	cmp    $0xa0768708,%eax
 27c:	b6 03                	mov    $0x3,%dh
 27e:	0a 66 03             	or     0x3(%esi),%ah
 281:	75 3c                	jne    2bf <PR_BOOTABLE+0x23f>
 283:	03 0b                	add    (%ebx),%ecx
 285:	2e                   	cs
 286:	ca 92 bb             	lret   $0xbb92
 289:	84 72 30             	test   %dh,0x30(%edx)
 28c:	5a                   	pop    %edx
 28d:	ca a0 64             	lret   $0x64a0
 290:	02 05 00 01 01 46    	add    0x46010100,%al
 296:	00 00                	add    %al,(%eax)
 298:	00 02                	add    %al,(%edx)
 29a:	00 2f                	add    %ch,(%edi)
 29c:	00 00                	add    %al,(%eax)
 29e:	00 01                	add    %al,(%ecx)
 2a0:	01 fb                	add    %edi,%ebx
 2a2:	0e                   	push   %cs
 2a3:	0d 00 01 01 01       	or     $0x1010100,%eax
 2a8:	01 00                	add    %eax,(%eax)
 2aa:	00 00                	add    %al,(%eax)
 2ac:	01 00                	add    %eax,(%eax)
 2ae:	00 01                	add    %al,(%ecx)
 2b0:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 2b3:	74 2f                	je     2e4 <PR_BOOTABLE+0x264>
 2b5:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 2b8:	74 31                	je     2eb <PR_BOOTABLE+0x26b>
 2ba:	00 00                	add    %al,(%eax)
 2bc:	65                   	gs
 2bd:	78 65                	js     324 <PR_BOOTABLE+0x2a4>
 2bf:	63 5f 6b             	arpl   %bx,0x6b(%edi)
 2c2:	65                   	gs
 2c3:	72 6e                	jb     333 <PR_BOOTABLE+0x2b3>
 2c5:	65                   	gs
 2c6:	6c                   	insb   (%dx),%es:(%edi)
 2c7:	2e                   	cs
 2c8:	53                   	push   %ebx
 2c9:	00 01                	add    %al,(%ecx)
 2cb:	00 00                	add    %al,(%eax)
 2cd:	00 00                	add    %al,(%eax)
 2cf:	05 02 f4 8e 00       	add    $0x8ef402,%eax
 2d4:	00 17                	add    %dl,(%edi)
 2d6:	21 59 4b             	and    %ebx,0x4b(%ecx)
 2d9:	4b                   	dec    %ebx
 2da:	02 02                	add    (%edx),%al
 2dc:	00 01                	add    %al,(%ecx)
 2de:	01                   	.byte 0x1

Disassembly of section .debug_str:

00000000 <.debug_str>:
   0:	65 6e                	outsb  %gs:(%esi),(%dx)
   2:	64                   	fs
   3:	5f                   	pop    %edi
   4:	76 61                	jbe    67 <PROT_MODE_DSEG+0x57>
   6:	00 77 61             	add    %dh,0x61(%edi)
   9:	69 74 64 69 73 6b 00 	imul   $0x73006b73,0x69(%esp,%eiz,2),%esi
  10:	73 
  11:	68 6f 72 74 20       	push   $0x2074726f
  16:	69 6e 74 00 73 69 7a 	imul   $0x7a697300,0x74(%esi),%ebp
  1d:	65                   	gs
  1e:	74 79                	je     99 <PR_BOOTABLE+0x19>
  20:	70 65                	jo     87 <PR_BOOTABLE+0x7>
  22:	00 72 6f             	add    %dh,0x6f(%edx)
  25:	6c                   	insb   (%dx),%es:(%edi)
  26:	6c                   	insb   (%dx),%es:(%edi)
  27:	00 47 4e             	add    %al,0x4e(%edi)
  2a:	55                   	push   %ebp
  2b:	20 43 20             	and    %al,0x20(%ebx)
  2e:	34 2e                	xor    $0x2e,%al
  30:	38 2e                	cmp    %ch,(%esi)
  32:	32 20                	xor    (%eax),%ah
  34:	32 30                	xor    (%eax),%dh
  36:	31 34 30             	xor    %esi,(%eax,%esi,1)
  39:	31 32                	xor    %esi,(%edx)
  3b:	30 20                	xor    %ah,(%eax)
  3d:	28 52 65             	sub    %dl,0x65(%edx)
  40:	64 20 48 61          	and    %cl,%fs:0x61(%eax)
  44:	74 20                	je     66 <PROT_MODE_DSEG+0x56>
  46:	34 2e                	xor    $0x2e,%al
  48:	38 2e                	cmp    %ch,(%esi)
  4a:	32 2d 31 36 29 20    	xor    0x20293631,%ch
  50:	2d 6d 33 32 20       	sub    $0x2032336d,%eax
  55:	2d 6d 74 75 6e       	sub    $0x6e75746d,%eax
  5a:	65                   	gs
  5b:	3d 67 65 6e 65       	cmp    $0x656e6567,%eax
  60:	72 69                	jb     cb <PR_BOOTABLE+0x4b>
  62:	63 20                	arpl   %sp,(%eax)
  64:	2d 6d 61 72 63       	sub    $0x6372616d,%eax
  69:	68 3d 78 38 36       	push   $0x3638783d
  6e:	2d 36 34 20 2d       	sub    $0x2d203436,%eax
  73:	67 20 2d             	and    %ch,(%di)
  76:	4f                   	dec    %edi
  77:	73 20                	jae    99 <PR_BOOTABLE+0x19>
  79:	2d 4f 73 20 2d       	sub    $0x2d20734f,%eax
  7e:	66                   	data16
  7f:	6e                   	outsb  %ds:(%esi),(%dx)
  80:	6f                   	outsl  %ds:(%esi),(%dx)
  81:	2d 62 75 69 6c       	sub    $0x6c697562,%eax
  86:	74 69                	je     f1 <PR_BOOTABLE+0x71>
  88:	6e                   	outsb  %ds:(%esi),(%dx)
  89:	20 2d 66 6e 6f 2d    	and    %ch,0x2d6f6e66
  8f:	73 74                	jae    105 <PR_BOOTABLE+0x85>
  91:	61                   	popa   
  92:	63 6b 2d             	arpl   %bp,0x2d(%ebx)
  95:	70 72                	jo     109 <PR_BOOTABLE+0x89>
  97:	6f                   	outsl  %ds:(%esi),(%dx)
  98:	74 65                	je     ff <PR_BOOTABLE+0x7f>
  9a:	63 74 6f 72          	arpl   %si,0x72(%edi,%ebp,2)
  9e:	00 70 61             	add    %dh,0x61(%eax)
  a1:	6e                   	outsb  %ds:(%esi),(%dx)
  a2:	69 63 00 70 75 74 69 	imul   $0x69747570,0x0(%ebx),%esp
  a9:	00 72 65             	add    %dh,0x65(%edx)
  ac:	61                   	popa   
  ad:	64                   	fs
  ae:	73 65                	jae    115 <PR_BOOTABLE+0x95>
  b0:	63 74 6f 72          	arpl   %si,0x72(%edi,%ebp,2)
  b4:	00 62 6f             	add    %ah,0x6f(%edx)
  b7:	6f                   	outsl  %ds:(%esi),(%dx)
  b8:	74 2f                	je     e9 <PR_BOOTABLE+0x69>
  ba:	62 6f 6f             	bound  %ebp,0x6f(%edi)
  bd:	74 31                	je     f0 <PR_BOOTABLE+0x70>
  bf:	2f                   	das    
  c0:	62 6f 6f             	bound  %ebp,0x6f(%edi)
  c3:	74 31                	je     f6 <PR_BOOTABLE+0x76>
  c5:	6c                   	insb   (%dx),%es:(%edi)
  c6:	69 62 2e 63 00 75 69 	imul   $0x69750063,0x2e(%edx),%esp
  cd:	6e                   	outsb  %ds:(%esi),(%dx)
  ce:	74 38                	je     108 <PR_BOOTABLE+0x88>
  d0:	5f                   	pop    %edi
  d1:	74 00                	je     d3 <PR_BOOTABLE+0x53>
  d3:	6f                   	outsl  %ds:(%esi),(%dx)
  d4:	75 74                	jne    14a <PR_BOOTABLE+0xca>
  d6:	62 00                	bound  %eax,(%eax)
  d8:	69 6e 73 6c 00 6c 6f 	imul   $0x6f6c006c,0x73(%esi),%ebp
  df:	6e                   	outsb  %ds:(%esi),(%dx)
  e0:	67 20 6c 6f          	and    %ch,0x6f(%si)
  e4:	6e                   	outsb  %ds:(%esi),(%dx)
  e5:	67 20 69 6e          	and    %ch,0x6e(%bx,%di)
  e9:	74 00                	je     eb <PR_BOOTABLE+0x6b>
  eb:	73 74                	jae    161 <PR_BOOTABLE+0xe1>
  ed:	72 69                	jb     158 <PR_BOOTABLE+0xd8>
  ef:	6e                   	outsb  %ds:(%esi),(%dx)
  f0:	67 00 72 65          	add    %dh,0x65(%bp,%si)
  f4:	61                   	popa   
  f5:	64                   	fs
  f6:	73 65                	jae    15d <PR_BOOTABLE+0xdd>
  f8:	63 74 69 6f          	arpl   %si,0x6f(%ecx,%ebp,2)
  fc:	6e                   	outsb  %ds:(%esi),(%dx)
  fd:	00 75 6e             	add    %dh,0x6e(%ebp)
 100:	73 69                	jae    16b <PR_BOOTABLE+0xeb>
 102:	67 6e                	outsb  %ds:(%si),(%dx)
 104:	65 64 20 63 68       	gs and %ah,%fs:%gs:0x68(%ebx)
 109:	61                   	popa   
 10a:	72 00                	jb     10c <PR_BOOTABLE+0x8c>
 10c:	69 74 6f 68 00 70 75 	imul   $0x74757000,0x68(%edi,%ebp,2),%esi
 113:	74 
 114:	63 00                	arpl   %ax,(%eax)
 116:	6c                   	insb   (%dx),%es:(%edi)
 117:	6f                   	outsl  %ds:(%esi),(%dx)
 118:	6e                   	outsb  %ds:(%esi),(%dx)
 119:	67 20 6c 6f          	and    %ch,0x6f(%si)
 11d:	6e                   	outsb  %ds:(%esi),(%dx)
 11e:	67 20 75 6e          	and    %dh,0x6e(%di)
 122:	73 69                	jae    18d <PR_BOOTABLE+0x10d>
 124:	67 6e                	outsb  %ds:(%si),(%dx)
 126:	65 64 20 69 6e       	gs and %ch,%fs:%gs:0x6e(%ecx)
 12b:	74 00                	je     12d <PR_BOOTABLE+0xad>
 12d:	69 74 6f 61 00 75 69 	imul   $0x6e697500,0x61(%edi,%ebp,2),%esi
 134:	6e 
 135:	74 33                	je     16a <PR_BOOTABLE+0xea>
 137:	32 5f 74             	xor    0x74(%edi),%bl
 13a:	00 63 6f             	add    %ah,0x6f(%ebx)
 13d:	6c                   	insb   (%dx),%es:(%edi)
 13e:	6f                   	outsl  %ds:(%esi),(%dx)
 13f:	72 00                	jb     141 <PR_BOOTABLE+0xc1>
 141:	69 74 6f 78 00 70 75 	imul   $0x74757000,0x78(%edi,%ebp,2),%esi
 148:	74 
 149:	73 00                	jae    14b <PR_BOOTABLE+0xcb>
 14b:	73 69                	jae    1b6 <PR_BOOTABLE+0x136>
 14d:	67 6e                	outsb  %ds:(%si),(%dx)
 14f:	00 2f                	add    %ch,(%edi)
 151:	68 6f 6d 65 2f       	push   $0x2f656d6f
 156:	61                   	popa   
 157:	63 63 74             	arpl   %sp,0x74(%ebx)
 15a:	73 2f                	jae    18b <PR_BOOTABLE+0x10b>
 15c:	77 73                	ja     1d1 <PR_BOOTABLE+0x151>
 15e:	33 36                	xor    (%esi),%esi
 160:	32 2f                	xor    (%edi),%ch
 162:	63 73 34             	arpl   %si,0x34(%ebx)
 165:	32 32                	xor    (%edx),%dh
 167:	2f                   	das    
 168:	6d                   	insl   (%dx),%es:(%edi)
 169:	63 65 72             	arpl   %sp,0x72(%ebp)
 16c:	74 69                	je     1d7 <PR_BOOTABLE+0x157>
 16e:	6b 6f 73 00          	imul   $0x0,0x73(%edi),%ebp
 172:	73 68                	jae    1dc <PR_BOOTABLE+0x15c>
 174:	6f                   	outsl  %ds:(%esi),(%dx)
 175:	72 74                	jb     1eb <PR_BOOTABLE+0x16b>
 177:	20 75 6e             	and    %dh,0x6e(%ebp)
 17a:	73 69                	jae    1e5 <PR_BOOTABLE+0x165>
 17c:	67 6e                	outsb  %ds:(%si),(%dx)
 17e:	65 64 20 69 6e       	gs and %ch,%fs:%gs:0x6e(%ecx)
 183:	74 00                	je     185 <PR_BOOTABLE+0x105>
 185:	73 74                	jae    1fb <PR_BOOTABLE+0x17b>
 187:	72 6c                	jb     1f5 <PR_BOOTABLE+0x175>
 189:	65 6e                	outsb  %gs:(%esi),(%dx)
 18b:	00 64 61 74          	add    %ah,0x74(%ecx,%eiz,2)
 18f:	61                   	popa   
 190:	00 70 6f             	add    %dh,0x6f(%eax)
 193:	72 74                	jb     209 <PR_BOOTABLE+0x189>
 195:	00 70 75             	add    %dh,0x75(%eax)
 198:	74 6c                	je     206 <PR_BOOTABLE+0x186>
 19a:	69 6e 65 00 72 65 76 	imul   $0x76657200,0x65(%esi),%ebp
 1a1:	65                   	gs
 1a2:	72 73                	jb     217 <PR_BOOTABLE+0x197>
 1a4:	65 00 70 75          	add    %dh,%gs:0x75(%eax)
 1a8:	74 69                	je     213 <PR_BOOTABLE+0x193>
 1aa:	5f                   	pop    %edi
 1ab:	73 74                	jae    221 <PR_BOOTABLE+0x1a1>
 1ad:	72 00                	jb     1af <PR_BOOTABLE+0x12f>
 1af:	62 6c 61 6e          	bound  %ebp,0x6e(%ecx,%eiz,2)
 1b3:	6b 00 72             	imul   $0x72,(%eax),%eax
 1b6:	6f                   	outsl  %ds:(%esi),(%dx)
 1b7:	6f                   	outsl  %ds:(%esi),(%dx)
 1b8:	74 00                	je     1ba <PR_BOOTABLE+0x13a>
 1ba:	76 69                	jbe    225 <PR_BOOTABLE+0x1a5>
 1bc:	64 65 6f             	fs outsl %fs:%gs:(%esi),(%dx)
 1bf:	00 64 69 73          	add    %ah,0x73(%ecx,%ebp,2)
 1c3:	6b 5f 73 69          	imul   $0x69,0x73(%edi),%ebx
 1c7:	67 00 65 6c          	add    %ah,0x6c(%di)
 1cb:	66 68 64 66          	pushw  $0x6664
 1cf:	00 65 5f             	add    %ah,0x5f(%ebp)
 1d2:	73 68                	jae    23c <PR_BOOTABLE+0x1bc>
 1d4:	73 74                	jae    24a <PR_BOOTABLE+0x1ca>
 1d6:	72 6e                	jb     246 <PR_BOOTABLE+0x1c6>
 1d8:	64                   	fs
 1d9:	78 00                	js     1db <PR_BOOTABLE+0x15b>
 1db:	6d                   	insl   (%dx),%es:(%edi)
 1dc:	6d                   	insl   (%dx),%es:(%edi)
 1dd:	61                   	popa   
 1de:	70 5f                	jo     23f <PR_BOOTABLE+0x1bf>
 1e0:	61                   	popa   
 1e1:	64                   	fs
 1e2:	64                   	fs
 1e3:	72 00                	jb     1e5 <PR_BOOTABLE+0x165>
 1e5:	65                   	gs
 1e6:	6c                   	insb   (%dx),%es:(%edi)
 1e7:	66 68 64 72          	pushw  $0x7264
 1eb:	00 76 62             	add    %dh,0x62(%esi)
 1ee:	65                   	gs
 1ef:	5f                   	pop    %edi
 1f0:	69 6e 74 65 72 66 61 	imul   $0x61667265,0x74(%esi),%ebp
 1f7:	63 65 5f             	arpl   %sp,0x5f(%ebp)
 1fa:	6f                   	outsl  %ds:(%esi),(%dx)
 1fb:	66                   	data16
 1fc:	66                   	data16
 1fd:	00 65 5f             	add    %ah,0x5f(%ebp)
 200:	65 6e                	outsb  %gs:(%esi),(%dx)
 202:	74 72                	je     276 <PR_BOOTABLE+0x1f6>
 204:	79 00                	jns    206 <PR_BOOTABLE+0x186>
 206:	75 69                	jne    271 <PR_BOOTABLE+0x1f1>
 208:	6e                   	outsb  %ds:(%esi),(%dx)
 209:	74 36                	je     241 <PR_BOOTABLE+0x1c1>
 20b:	34 5f                	xor    $0x5f,%al
 20d:	74 00                	je     20f <PR_BOOTABLE+0x18f>
 20f:	6c                   	insb   (%dx),%es:(%edi)
 210:	6f                   	outsl  %ds:(%esi),(%dx)
 211:	61                   	popa   
 212:	64                   	fs
 213:	5f                   	pop    %edi
 214:	6b 65 72 6e          	imul   $0x6e,0x72(%ebp),%esp
 218:	65                   	gs
 219:	6c                   	insb   (%dx),%es:(%edi)
 21a:	00 70 5f             	add    %dh,0x5f(%eax)
 21d:	6d                   	insl   (%dx),%es:(%edi)
 21e:	65                   	gs
 21f:	6d                   	insl   (%dx),%es:(%edi)
 220:	73 7a                	jae    29c <PR_BOOTABLE+0x21c>
 222:	00 70 5f             	add    %dh,0x5f(%eax)
 225:	6f                   	outsl  %ds:(%esi),(%dx)
 226:	66                   	data16
 227:	66                   	data16
 228:	73 65                	jae    28f <PR_BOOTABLE+0x20f>
 22a:	74 00                	je     22c <PR_BOOTABLE+0x1ac>
 22c:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 22f:	74 6c                	je     29d <PR_BOOTABLE+0x21d>
 231:	6f                   	outsl  %ds:(%esi),(%dx)
 232:	61                   	popa   
 233:	64                   	fs
 234:	65                   	gs
 235:	72 00                	jb     237 <PR_BOOTABLE+0x1b7>
 237:	65                   	gs
 238:	5f                   	pop    %edi
 239:	66                   	data16
 23a:	6c                   	insb   (%dx),%es:(%edi)
 23b:	61                   	popa   
 23c:	67 73 00             	addr16 jae 23f <PR_BOOTABLE+0x1bf>
 23f:	63 6d 64             	arpl   %bp,0x64(%ebp)
 242:	6c                   	insb   (%dx),%es:(%edi)
 243:	69 6e 65 00 65 5f 6d 	imul   $0x6d5f6500,0x65(%esi),%ebp
 24a:	61                   	popa   
 24b:	63 68 69             	arpl   %bp,0x69(%eax)
 24e:	6e                   	outsb  %ds:(%esi),(%dx)
 24f:	65 00 65 5f          	add    %ah,%gs:0x5f(%ebp)
 253:	70 68                	jo     2bd <PR_BOOTABLE+0x23d>
 255:	65 6e                	outsb  %gs:(%esi),(%dx)
 257:	74 73                	je     2cc <PR_BOOTABLE+0x24c>
 259:	69 7a 65 00 65 78 65 	imul   $0x65786500,0x65(%edx),%edi
 260:	63 5f 6b             	arpl   %bx,0x6b(%edi)
 263:	65                   	gs
 264:	72 6e                	jb     2d4 <PR_BOOTABLE+0x254>
 266:	65                   	gs
 267:	6c                   	insb   (%dx),%es:(%edi)
 268:	00 6d 6f             	add    %ch,0x6f(%ebp)
 26b:	64                   	fs
 26c:	73 5f                	jae    2cd <PR_BOOTABLE+0x24d>
 26e:	61                   	popa   
 26f:	64                   	fs
 270:	64                   	fs
 271:	72 00                	jb     273 <PR_BOOTABLE+0x1f3>
 273:	61                   	popa   
 274:	6f                   	outsl  %ds:(%esi),(%dx)
 275:	75 74                	jne    2eb <PR_BOOTABLE+0x26b>
 277:	00 73 74             	add    %dh,0x74(%ebx)
 27a:	72 73                	jb     2ef <PR_BOOTABLE+0x26f>
 27c:	69 7a 65 00 70 61 72 	imul   $0x72617000,0x65(%edx),%edi
 283:	74 33                	je     2b8 <PR_BOOTABLE+0x238>
 285:	00 70 5f             	add    %dh,0x5f(%eax)
 288:	74 79                	je     303 <PR_BOOTABLE+0x283>
 28a:	70 65                	jo     2f1 <PR_BOOTABLE+0x271>
 28c:	00 70 72             	add    %dh,0x72(%eax)
 28f:	6f                   	outsl  %ds:(%esi),(%dx)
 290:	67 68 64 72 00 65    	addr16 push $0x65007264
 296:	5f                   	pop    %edi
 297:	73 68                	jae    301 <PR_BOOTABLE+0x281>
 299:	65 6e                	outsb  %gs:(%esi),(%dx)
 29b:	74 73                	je     310 <PR_BOOTABLE+0x290>
 29d:	69 7a 65 00 73 68 6e 	imul   $0x6e687300,0x65(%edx),%edi
 2a4:	64                   	fs
 2a5:	78 00                	js     2a7 <PR_BOOTABLE+0x227>
 2a7:	6d                   	insl   (%dx),%es:(%edi)
 2a8:	62 72 5f             	bound  %esi,0x5f(%edx)
 2ab:	74 00                	je     2ad <PR_BOOTABLE+0x22d>
 2ad:	65                   	gs
 2ae:	5f                   	pop    %edi
 2af:	74 79                	je     32a <PR_BOOTABLE+0x2aa>
 2b1:	70 65                	jo     318 <PR_BOOTABLE+0x298>
 2b3:	00 64 72 69          	add    %ah,0x69(%edx,%esi,2)
 2b7:	76 65                	jbe    31e <PR_BOOTABLE+0x29e>
 2b9:	73 5f                	jae    31a <PR_BOOTABLE+0x29a>
 2bb:	61                   	popa   
 2bc:	64                   	fs
 2bd:	64                   	fs
 2be:	72 00                	jb     2c0 <PR_BOOTABLE+0x240>
 2c0:	65                   	gs
 2c1:	5f                   	pop    %edi
 2c2:	65                   	gs
 2c3:	68 73 69 7a 65       	push   $0x657a6973
 2c8:	00 70 61             	add    %dh,0x61(%eax)
 2cb:	72 74                	jb     341 <PR_BOOTABLE+0x2c1>
 2cd:	69 74 69 6f 6e 00 62 	imul   $0x6962006e,0x6f(%ecx,%ebp,2),%esi
 2d4:	69 
 2d5:	6f                   	outsl  %ds:(%esi),(%dx)
 2d6:	73 5f                	jae    337 <PR_BOOTABLE+0x2b7>
 2d8:	73 6d                	jae    347 <PR_BOOTABLE+0x2c7>
 2da:	61                   	popa   
 2db:	70 5f                	jo     33c <PR_BOOTABLE+0x2bc>
 2dd:	74 00                	je     2df <PR_BOOTABLE+0x25f>
 2df:	6d                   	insl   (%dx),%es:(%edi)
 2e0:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 2e3:	74 5f                	je     344 <PR_BOOTABLE+0x2c4>
 2e5:	69 6e 66 6f 5f 74 00 	imul   $0x745f6f,0x66(%esi),%ebp
 2ec:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 2ef:	74 61                	je     352 <PR_BOOTABLE+0x2d2>
 2f1:	62 6c 65 5f          	bound  %ebp,0x5f(%ebp,%eiz,2)
 2f5:	6c                   	insb   (%dx),%es:(%edi)
 2f6:	62 61 00             	bound  %esp,0x0(%ecx)
 2f9:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 2fc:	74 31                	je     32f <PR_BOOTABLE+0x2af>
 2fe:	6d                   	insl   (%dx),%es:(%edi)
 2ff:	61                   	popa   
 300:	69 6e 00 65 5f 76 65 	imul   $0x65765f65,0x0(%esi),%ebp
 307:	72 73                	jb     37c <PR_BOOTABLE+0x2fc>
 309:	69 6f 6e 00 70 61 72 	imul   $0x72617000,0x6e(%edi),%ebp
 310:	74 31                	je     343 <PR_BOOTABLE+0x2c3>
 312:	00 70 61             	add    %dh,0x61(%eax)
 315:	72 74                	jb     38b <PR_BOOTABLE+0x30b>
 317:	32 00                	xor    (%eax),%al
 319:	64                   	fs
 31a:	72 69                	jb     385 <PR_BOOTABLE+0x305>
 31c:	76 65                	jbe    383 <PR_BOOTABLE+0x303>
 31e:	72 00                	jb     320 <PR_BOOTABLE+0x2a0>
 320:	66 69 72 73 74 5f    	imul   $0x5f74,0x73(%edx),%si
 326:	63 68 73             	arpl   %bp,0x73(%eax)
 329:	00 62 69             	add    %ah,0x69(%edx)
 32c:	6f                   	outsl  %ds:(%esi),(%dx)
 32d:	73 5f                	jae    38e <PR_BOOTABLE+0x30e>
 32f:	73 6d                	jae    39e <PR_BOOTABLE+0x31e>
 331:	61                   	popa   
 332:	70 00                	jo     334 <PR_BOOTABLE+0x2b4>
 334:	6d                   	insl   (%dx),%es:(%edi)
 335:	65                   	gs
 336:	6d                   	insl   (%dx),%es:(%edi)
 337:	5f                   	pop    %edi
 338:	6c                   	insb   (%dx),%es:(%edi)
 339:	6f                   	outsl  %ds:(%esi),(%dx)
 33a:	77 65                	ja     3a1 <PR_BOOTABLE+0x321>
 33c:	72 00                	jb     33e <PR_BOOTABLE+0x2be>
 33e:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 341:	74 61                	je     3a4 <PR_BOOTABLE+0x324>
 343:	62 6c 65 00          	bound  %ebp,0x0(%ebp,%eiz,2)
 347:	73 79                	jae    3c2 <PR_BOOTABLE+0x342>
 349:	6d                   	insl   (%dx),%es:(%edi)
 34a:	73 00                	jae    34c <PR_BOOTABLE+0x2cc>
 34c:	75 69                	jne    3b7 <PR_BOOTABLE+0x337>
 34e:	6e                   	outsb  %ds:(%esi),(%dx)
 34f:	74 31                	je     382 <PR_BOOTABLE+0x302>
 351:	36                   	ss
 352:	5f                   	pop    %edi
 353:	74 00                	je     355 <PR_BOOTABLE+0x2d5>
 355:	6d                   	insl   (%dx),%es:(%edi)
 356:	6d                   	insl   (%dx),%es:(%edi)
 357:	61                   	popa   
 358:	70 5f                	jo     3b9 <PR_BOOTABLE+0x339>
 35a:	6c                   	insb   (%dx),%es:(%edi)
 35b:	65 6e                	outsb  %gs:(%esi),(%dx)
 35d:	67 74 68             	addr16 je 3c8 <PR_BOOTABLE+0x348>
 360:	00 6d 62             	add    %ch,0x62(%ebp)
 363:	6f                   	outsl  %ds:(%esi),(%dx)
 364:	6f                   	outsl  %ds:(%esi),(%dx)
 365:	74 5f                	je     3c6 <PR_BOOTABLE+0x346>
 367:	69 6e 66 6f 00 70 5f 	imul   $0x5f70006f,0x66(%esi),%ebp
 36e:	76 61                	jbe    3d1 <PR_BOOTABLE+0x351>
 370:	00 76 62             	add    %dh,0x62(%esi)
 373:	65                   	gs
 374:	5f                   	pop    %edi
 375:	63 6f 6e             	arpl   %bp,0x6e(%edi)
 378:	74 72                	je     3ec <PR_BOOTABLE+0x36c>
 37a:	6f                   	outsl  %ds:(%esi),(%dx)
 37b:	6c                   	insb   (%dx),%es:(%edi)
 37c:	5f                   	pop    %edi
 37d:	69 6e 66 6f 00 70 5f 	imul   $0x5f70006f,0x66(%esi),%ebp
 384:	66                   	data16
 385:	6c                   	insb   (%dx),%es:(%edi)
 386:	61                   	popa   
 387:	67 73 00             	addr16 jae 38a <PR_BOOTABLE+0x30a>
 38a:	70 61                	jo     3ed <PR_BOOTABLE+0x36d>
 38c:	72 73                	jb     401 <PR_BOOTABLE+0x381>
 38e:	65                   	gs
 38f:	5f                   	pop    %edi
 390:	65 38 32             	cmp    %dh,%gs:(%edx)
 393:	30 00                	xor    %al,(%eax)
 395:	65                   	gs
 396:	5f                   	pop    %edi
 397:	65                   	gs
 398:	6c                   	insb   (%dx),%es:(%edi)
 399:	66                   	data16
 39a:	00 62 6f             	add    %ah,0x6f(%edx)
 39d:	6f                   	outsl  %ds:(%esi),(%dx)
 39e:	74 5f                	je     3ff <PR_BOOTABLE+0x37f>
 3a0:	64                   	fs
 3a1:	65                   	gs
 3a2:	76 69                	jbe    40d <PR_BOOTABLE+0x38d>
 3a4:	63 65 00             	arpl   %sp,0x0(%ebp)
 3a7:	64 6b 65 72 6e       	imul   $0x6e,%fs:0x72(%ebp),%esp
 3ac:	65                   	gs
 3ad:	6c                   	insb   (%dx),%es:(%edi)
 3ae:	00 65 5f             	add    %ah,0x5f(%ebp)
 3b1:	70 68                	jo     41b <PR_BOOTABLE+0x39b>
 3b3:	6f                   	outsl  %ds:(%esi),(%dx)
 3b4:	66                   	data16
 3b5:	66                   	data16
 3b6:	00 63 6f             	add    %ah,0x6f(%ebx)
 3b9:	6e                   	outsb  %ds:(%esi),(%dx)
 3ba:	66 69 67 5f 74 61    	imul   $0x6174,0x5f(%edi),%sp
 3c0:	62 6c 65 00          	bound  %ebp,0x0(%ebp,%eiz,2)
 3c4:	65                   	gs
 3c5:	5f                   	pop    %edi
 3c6:	6d                   	insl   (%dx),%es:(%edi)
 3c7:	61                   	popa   
 3c8:	67 69 63 00 6c 61 73 	imul   $0x7473616c,0x0(%bp,%di),%esp
 3cf:	74 
 3d0:	5f                   	pop    %edi
 3d1:	63 68 73             	arpl   %bp,0x73(%eax)
 3d4:	00 62 61             	add    %ah,0x61(%edx)
 3d7:	73 65                	jae    43e <PR_BOOTABLE+0x3be>
 3d9:	5f                   	pop    %edi
 3da:	61                   	popa   
 3db:	64                   	fs
 3dc:	64                   	fs
 3dd:	72 00                	jb     3df <PR_BOOTABLE+0x35f>
 3df:	76 62                	jbe    443 <PR_BOOTABLE+0x3c3>
 3e1:	65                   	gs
 3e2:	5f                   	pop    %edi
 3e3:	6d                   	insl   (%dx),%es:(%edi)
 3e4:	6f                   	outsl  %ds:(%esi),(%dx)
 3e5:	64 65 00 65 5f       	fs add %ah,%fs:%gs:0x5f(%ebp)
 3ea:	73 68                	jae    454 <PR_BOOTABLE+0x3d4>
 3ec:	6f                   	outsl  %ds:(%esi),(%dx)
 3ed:	66                   	data16
 3ee:	66                   	data16
 3ef:	00 6d 65             	add    %ch,0x65(%ebp)
 3f2:	6d                   	insl   (%dx),%es:(%edi)
 3f3:	5f                   	pop    %edi
 3f4:	75 70                	jne    466 <PR_BOOTABLE+0x3e6>
 3f6:	70 65                	jo     45d <PR_BOOTABLE+0x3dd>
 3f8:	72 00                	jb     3fa <PR_BOOTABLE+0x37a>
 3fa:	76 62                	jbe    45e <PR_BOOTABLE+0x3de>
 3fc:	65                   	gs
 3fd:	5f                   	pop    %edi
 3fe:	6d                   	insl   (%dx),%es:(%edi)
 3ff:	6f                   	outsl  %ds:(%esi),(%dx)
 400:	64                   	fs
 401:	65                   	gs
 402:	5f                   	pop    %edi
 403:	69 6e 66 6f 00 74 61 	imul   $0x6174006f,0x66(%esi),%ebp
 40a:	62 73 69             	bound  %esi,0x69(%ebx)
 40d:	7a 65                	jp     474 <PR_BOOTABLE+0x3f4>
 40f:	00 66 69             	add    %ah,0x69(%esi)
 412:	72 73                	jb     487 <PR_BOOTABLE+0x407>
 414:	74 5f                	je     475 <PR_BOOTABLE+0x3f5>
 416:	6c                   	insb   (%dx),%es:(%edi)
 417:	62 61 00             	bound  %esp,0x0(%ecx)
 41a:	64                   	fs
 41b:	72 69                	jb     486 <PR_BOOTABLE+0x406>
 41d:	76 65                	jbe    484 <PR_BOOTABLE+0x404>
 41f:	73 5f                	jae    480 <PR_BOOTABLE+0x400>
 421:	6c                   	insb   (%dx),%es:(%edi)
 422:	65 6e                	outsb  %gs:(%esi),(%dx)
 424:	67 74 68             	addr16 je 48f <PR_BOOTABLE+0x40f>
 427:	00 70 5f             	add    %dh,0x5f(%eax)
 42a:	66 69 6c 65 73 7a 00 	imul   $0x7a,0x73(%ebp,%eiz,2),%bp
 431:	65                   	gs
 432:	5f                   	pop    %edi
 433:	70 68                	jo     49d <PR_BOOTABLE+0x41d>
 435:	6e                   	outsb  %ds:(%esi),(%dx)
 436:	75 6d                	jne    4a5 <PR_BOOTABLE+0x425>
 438:	00 73 69             	add    %dh,0x69(%ebx)
 43b:	67 6e                	outsb  %ds:(%si),(%dx)
 43d:	61                   	popa   
 43e:	74 75                	je     4b5 <PR_BOOTABLE+0x435>
 440:	72 65                	jb     4a7 <PR_BOOTABLE+0x427>
 442:	00 65 5f             	add    %ah,0x5f(%ebp)
 445:	73 68                	jae    4af <PR_BOOTABLE+0x42f>
 447:	6e                   	outsb  %ds:(%esi),(%dx)
 448:	75 6d                	jne    4b7 <PR_BOOTABLE+0x437>
 44a:	00 76 62             	add    %dh,0x62(%esi)
 44d:	65                   	gs
 44e:	5f                   	pop    %edi
 44f:	69 6e 74 65 72 66 61 	imul   $0x61667265,0x74(%esi),%ebp
 456:	63 65 5f             	arpl   %sp,0x5f(%ebp)
 459:	6c                   	insb   (%dx),%es:(%edi)
 45a:	65 6e                	outsb  %gs:(%esi),(%dx)
 45c:	00 62 6f             	add    %ah,0x6f(%edx)
 45f:	6f                   	outsl  %ds:(%esi),(%dx)
 460:	74 2f                	je     491 <PR_BOOTABLE+0x411>
 462:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 465:	74 31                	je     498 <PR_BOOTABLE+0x418>
 467:	2f                   	das    
 468:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 46b:	74 31                	je     49e <PR_BOOTABLE+0x41e>
 46d:	6d                   	insl   (%dx),%es:(%edi)
 46e:	61                   	popa   
 46f:	69 6e 2e 63 00 6d 6f 	imul   $0x6f6d0063,0x2e(%esi),%ebp
 476:	64                   	fs
 477:	73 5f                	jae    4d8 <PR_BOOTABLE+0x458>
 479:	63 6f 75             	arpl   %bp,0x75(%edi)
 47c:	6e                   	outsb  %ds:(%esi),(%dx)
 47d:	74 00                	je     47f <PR_BOOTABLE+0x3ff>
 47f:	5f                   	pop    %edi
 480:	72 65                	jb     4e7 <PR_BOOTABLE+0x467>
 482:	73 65                	jae    4e9 <PR_BOOTABLE+0x469>
 484:	72 76                	jb     4fc <PR_BOOTABLE+0x47c>
 486:	65 64 00 62 6f       	gs add %ah,%fs:%gs:0x6f(%edx)
 48b:	6f                   	outsl  %ds:(%esi),(%dx)
 48c:	74 5f                	je     4ed <PR_BOOTABLE+0x46d>
 48e:	6c                   	insb   (%dx),%es:(%edi)
 48f:	6f                   	outsl  %ds:(%esi),(%dx)
 490:	61                   	popa   
 491:	64                   	fs
 492:	65                   	gs
 493:	72 5f                	jb     4f4 <PR_BOOTABLE+0x474>
 495:	6e                   	outsb  %ds:(%esi),(%dx)
 496:	61                   	popa   
 497:	6d                   	insl   (%dx),%es:(%edi)
 498:	65 00 76 62          	add    %dh,%gs:0x62(%esi)
 49c:	65                   	gs
 49d:	5f                   	pop    %edi
 49e:	69 6e 74 65 72 66 61 	imul   $0x61667265,0x74(%esi),%ebp
 4a5:	63 65 5f             	arpl   %sp,0x5f(%ebp)
 4a8:	73 65                	jae    50f <PR_BOOTABLE+0x48f>
 4aa:	67 00 6d 6d          	add    %ch,0x6d(%di)
 4ae:	61                   	popa   
 4af:	70 5f                	jo     510 <PR_BOOTABLE+0x490>
 4b1:	6c                   	insb   (%dx),%es:(%edi)
 4b2:	65 6e                	outsb  %gs:(%esi),(%dx)
 4b4:	00 70 5f             	add    %dh,0x5f(%eax)
 4b7:	61                   	popa   
 4b8:	6c                   	insb   (%dx),%es:(%edi)
 4b9:	69 67 6e 00 61 70 6d 	imul   $0x6d706100,0x6e(%edi),%esp
 4c0:	5f                   	pop    %edi
 4c1:	74 61                	je     524 <PR_BOOTABLE+0x4a4>
 4c3:	62 6c 65 00          	bound  %ebp,0x0(%ebp,%eiz,2)
 4c7:	70 5f                	jo     528 <PR_BOOTABLE+0x4a8>
 4c9:	70 61                	jo     52c <PR_BOOTABLE+0x4ac>
 4cb:	00 73 65             	add    %dh,0x65(%ebx)
 4ce:	63 74 6f 72          	arpl   %si,0x72(%edi,%ebp,2)
 4d2:	73 5f                	jae    533 <PR_BOOTABLE+0x4b3>
 4d4:	63 6f 75             	arpl   %bp,0x75(%edi)
 4d7:	6e                   	outsb  %ds:(%esi),(%dx)
 4d8:	74 00                	je     4da <PR_BOOTABLE+0x45a>

Disassembly of section .debug_loc:

00000000 <.debug_loc>:
   0:	1b 00                	sbb    (%eax),%eax
   2:	00 00                	add    %al,(%eax)
   4:	2c 00                	sub    $0x0,%al
   6:	00 00                	add    %al,(%eax)
   8:	02 00                	add    (%eax),%al
   a:	91                   	xchg   %eax,%ecx
   b:	0c 2c                	or     $0x2c,%al
   d:	00 00                	add    %al,(%eax)
   f:	00 34 00             	add    %dh,(%eax,%eax,1)
  12:	00 00                	add    %al,(%eax)
  14:	12 00                	adc    (%eax),%al
  16:	91                   	xchg   %eax,%ecx
  17:	0c 06                	or     $0x6,%al
  19:	91                   	xchg   %eax,%ecx
  1a:	00 06                	add    %al,(%esi)
  1c:	08 50 1e             	or     %dl,0x1e(%eax)
  1f:	1c 70                	sbb    $0x70,%al
  21:	00 22                	add    %ah,(%edx)
  23:	91                   	xchg   %eax,%ecx
  24:	04 06                	add    $0x6,%al
  26:	1c 9f                	sbb    $0x9f,%al
  28:	34 00                	xor    $0x0,%al
  2a:	00 00                	add    %al,(%eax)
  2c:	40                   	inc    %eax
  2d:	00 00                	add    %al,(%eax)
  2f:	00 14 00             	add    %dl,(%eax,%eax,1)
  32:	91                   	xchg   %eax,%ecx
  33:	0c 06                	or     $0x6,%al
  35:	91                   	xchg   %eax,%ecx
  36:	00 06                	add    %al,(%esi)
  38:	08 50 1e             	or     %dl,0x1e(%eax)
  3b:	1c 91                	sbb    $0x91,%al
  3d:	04 06                	add    $0x6,%al
  3f:	1c 70                	sbb    $0x70,%al
  41:	00 22                	add    %ah,(%edx)
  43:	23 01                	and    (%ecx),%eax
  45:	9f                   	lahf   
  46:	40                   	inc    %eax
  47:	00 00                	add    %al,(%eax)
  49:	00 48 00             	add    %cl,0x0(%eax)
  4c:	00 00                	add    %al,(%eax)
  4e:	12 00                	adc    (%eax),%al
  50:	91                   	xchg   %eax,%ecx
  51:	0c 06                	or     $0x6,%al
  53:	91                   	xchg   %eax,%ecx
  54:	00 06                	add    %al,(%esi)
  56:	08 50 1e             	or     %dl,0x1e(%eax)
  59:	1c 91                	sbb    $0x91,%al
  5b:	04 06                	add    $0x6,%al
  5d:	1c 76                	sbb    $0x76,%al
  5f:	00 22                	add    %ah,(%edx)
  61:	9f                   	lahf   
  62:	48                   	dec    %eax
  63:	00 00                	add    %al,(%eax)
  65:	00 4f 00             	add    %cl,0x0(%edi)
  68:	00 00                	add    %al,(%eax)
  6a:	12 00                	adc    (%eax),%al
  6c:	91                   	xchg   %eax,%ecx
  6d:	0c 06                	or     $0x6,%al
  6f:	91                   	xchg   %eax,%ecx
  70:	00 06                	add    %al,(%esi)
  72:	08 50 1e             	or     %dl,0x1e(%eax)
  75:	1c 70                	sbb    $0x70,%al
  77:	00 22                	add    %ah,(%edx)
  79:	91                   	xchg   %eax,%ecx
  7a:	04 06                	add    $0x6,%al
  7c:	1c 9f                	sbb    $0x9f,%al
  7e:	00 00                	add    %al,(%eax)
  80:	00 00                	add    %al,(%eax)
  82:	00 00                	add    %al,(%eax)
  84:	00 00                	add    %al,(%eax)
  86:	27                   	daa    
  87:	00 00                	add    %al,(%eax)
  89:	00 2a                	add    %ch,(%edx)
  8b:	00 00                	add    %al,(%eax)
  8d:	00 07                	add    %al,(%edi)
  8f:	00 70 00             	add    %dh,0x0(%eax)
  92:	91                   	xchg   %eax,%ecx
  93:	04 06                	add    $0x6,%al
  95:	22 9f 2a 00 00 00    	and    0x2a(%edi),%bl
  9b:	3b 00                	cmp    (%eax),%eax
  9d:	00 00                	add    %al,(%eax)
  9f:	01 00                	add    %eax,(%eax)
  a1:	50                   	push   %eax
  a2:	3b 00                	cmp    (%eax),%eax
  a4:	00 00                	add    %al,(%eax)
  a6:	48                   	dec    %eax
  a7:	00 00                	add    %al,(%eax)
  a9:	00 01                	add    %al,(%ecx)
  ab:	00 56 48             	add    %dl,0x48(%esi)
  ae:	00 00                	add    %al,(%eax)
  b0:	00 4f 00             	add    %cl,0x0(%edi)
  b3:	00 00                	add    %al,(%eax)
  b5:	01 00                	add    %eax,(%eax)
  b7:	50                   	push   %eax
  b8:	00 00                	add    %al,(%eax)
  ba:	00 00                	add    %al,(%eax)
  bc:	00 00                	add    %al,(%eax)
  be:	00 00                	add    %al,(%eax)
  c0:	b2 00                	mov    $0x0,%dl
  c2:	00 00                	add    %al,(%eax)
  c4:	ba 00 00 00 02       	mov    $0x2000000,%edx
  c9:	00 91 00 ba 00 00    	add    %dl,0xba00(%ecx)
  cf:	00 c5                	add    %al,%ch
  d1:	00 00                	add    %al,(%eax)
  d3:	00 07                	add    %al,(%edi)
  d5:	00 91 00 06 70 00    	add    %dl,0x700600(%ecx)
  db:	22 9f 00 00 00 00    	and    0x0(%edi),%bl
  e1:	00 00                	add    %al,(%eax)
  e3:	00 00                	add    %al,(%eax)
  e5:	b2 00                	mov    $0x0,%dl
  e7:	00 00                	add    %al,(%eax)
  e9:	ba 00 00 00 02       	mov    $0x2000000,%edx
  ee:	00 30                	add    %dh,(%eax)
  f0:	9f                   	lahf   
  f1:	ba 00 00 00 c5       	mov    $0xc5000000,%edx
  f6:	00 00                	add    %al,(%eax)
  f8:	00 01                	add    %al,(%ecx)
  fa:	00 50 00             	add    %dl,0x0(%eax)
  fd:	00 00                	add    %al,(%eax)
  ff:	00 00                	add    %al,(%eax)
 101:	00 00                	add    %al,(%eax)
 103:	00 c5                	add    %al,%ch
 105:	00 00                	add    %al,(%eax)
 107:	00 d7                	add    %dl,%bh
 109:	00 00                	add    %al,(%eax)
 10b:	00 02                	add    %al,(%edx)
 10d:	00 30                	add    %dh,(%eax)
 10f:	9f                   	lahf   
 110:	d7                   	xlat   %ds:(%ebx)
 111:	00 00                	add    %al,(%eax)
 113:	00 f5                	add    %dh,%ch
 115:	00 00                	add    %al,(%eax)
 117:	00 01                	add    %al,(%ecx)
 119:	00 52 00             	add    %dl,0x0(%edx)
 11c:	00 00                	add    %al,(%eax)
 11e:	00 00                	add    %al,(%eax)
 120:	00 00                	add    %al,(%eax)
 122:	00 df                	add    %bl,%bh
 124:	00 00                	add    %al,(%eax)
 126:	00 ee                	add    %ch,%dh
 128:	00 00                	add    %al,(%eax)
 12a:	00 01                	add    %al,(%ecx)
 12c:	00 56 00             	add    %dl,0x0(%esi)
 12f:	00 00                	add    %al,(%eax)
 131:	00 00                	add    %al,(%eax)
 133:	00 00                	add    %al,(%eax)
 135:	00 f5                	add    %dh,%ch
 137:	00 00                	add    %al,(%eax)
 139:	00 1b                	add    %bl,(%ebx)
 13b:	01 00                	add    %eax,(%eax)
 13d:	00 02                	add    %al,(%edx)
 13f:	00 91 00 1b 01 00    	add    %dl,0x11b00(%ecx)
 145:	00 1f                	add    %bl,(%edi)
 147:	01 00                	add    %eax,(%eax)
 149:	00 01                	add    %al,(%ecx)
 14b:	00 50 2b             	add    %dl,0x2b(%eax)
 14e:	01 00                	add    %eax,(%eax)
 150:	00 37                	add    %dh,(%edi)
 152:	01 00                	add    %eax,(%eax)
 154:	00 01                	add    %al,(%ecx)
 156:	00 50 00             	add    %dl,0x0(%eax)
 159:	00 00                	add    %al,(%eax)
 15b:	00 00                	add    %al,(%eax)
 15d:	00 00                	add    %al,(%eax)
 15f:	00 1b                	add    %bl,(%ebx)
 161:	01 00                	add    %eax,(%eax)
 163:	00 22                	add    %ah,(%edx)
 165:	01 00                	add    %eax,(%eax)
 167:	00 01                	add    %al,(%ecx)
 169:	00 56 22             	add    %dl,0x22(%esi)
 16c:	01 00                	add    %eax,(%eax)
 16e:	00 39                	add    %bh,(%ecx)
 170:	01 00                	add    %eax,(%eax)
 172:	00 01                	add    %al,(%ecx)
 174:	00 51 39             	add    %dl,0x39(%ecx)
 177:	01 00                	add    %eax,(%eax)
 179:	00 3c 01             	add    %bh,(%ecx,%eax,1)
 17c:	00 00                	add    %al,(%eax)
 17e:	01 00                	add    %eax,(%eax)
 180:	50                   	push   %eax
 181:	3c 01                	cmp    $0x1,%al
 183:	00 00                	add    %al,(%eax)
 185:	51                   	push   %ecx
 186:	01 00                	add    %eax,(%eax)
 188:	00 01                	add    %al,(%ecx)
 18a:	00 51 00             	add    %dl,0x0(%ecx)
 18d:	00 00                	add    %al,(%eax)
 18f:	00 00                	add    %al,(%eax)
 191:	00 00                	add    %al,(%eax)
 193:	00 03                	add    %al,(%ebx)
 195:	01 00                	add    %eax,(%eax)
 197:	00 19                	add    %bl,(%ecx)
 199:	01 00                	add    %eax,(%eax)
 19b:	00 01                	add    %al,(%ecx)
 19d:	00 50 19             	add    %dl,0x19(%eax)
 1a0:	01 00                	add    %eax,(%eax)
 1a2:	00 47 01             	add    %al,0x1(%edi)
 1a5:	00 00                	add    %al,(%eax)
 1a7:	02 00                	add    (%eax),%al
 1a9:	91                   	xchg   %eax,%ecx
 1aa:	00 47 01             	add    %al,0x1(%edi)
 1ad:	00 00                	add    %al,(%eax)
 1af:	52                   	push   %edx
 1b0:	01 00                	add    %eax,(%eax)
 1b2:	00 02                	add    %al,(%edx)
 1b4:	00 91 68 00 00 00    	add    %dl,0x68(%ecx)
 1ba:	00 00                	add    %al,(%eax)
 1bc:	00 00                	add    %al,(%eax)
 1be:	00 b2 01 00 00 b5    	add    %dh,-0x4affffff(%edx)
 1c4:	01 00                	add    %eax,(%eax)
 1c6:	00 01                	add    %al,(%ecx)
 1c8:	00 50 00             	add    %dl,0x0(%eax)
 1cb:	00 00                	add    %al,(%eax)
 1cd:	00 00                	add    %al,(%eax)
 1cf:	00 00                	add    %al,(%eax)
 1d1:	00 e9                	add    %ch,%cl
 1d3:	01 00                	add    %eax,(%eax)
 1d5:	00 ec                	add    %ch,%ah
 1d7:	01 00                	add    %eax,(%eax)
 1d9:	00 01                	add    %al,(%ecx)
 1db:	00 50 00             	add    %dl,0x0(%eax)
 1de:	00 00                	add    %al,(%eax)
 1e0:	00 00                	add    %al,(%eax)
 1e2:	00 00                	add    %al,(%eax)
 1e4:	00 f0                	add    %dh,%al
 1e6:	01 00                	add    %eax,(%eax)
 1e8:	00 00                	add    %al,(%eax)
 1ea:	02 00                	add    (%eax),%al
 1ec:	00 03                	add    %al,(%ebx)
 1ee:	00 08                	add    %cl,(%eax)
 1f0:	80 9f 00 00 00 00 00 	sbbb   $0x0,0x0(%edi)
 1f7:	00 00                	add    %al,(%eax)
 1f9:	00 f0                	add    %dh,%al
 1fb:	01 00                	add    %eax,(%eax)
 1fd:	00 00                	add    %al,(%eax)
 1ff:	02 00                	add    (%eax),%al
 201:	00 02                	add    %al,(%edx)
 203:	00 91 00 00 00 00    	add    %dl,0x0(%ecx)
 209:	00 00                	add    %al,(%eax)
 20b:	00 00                	add    %al,(%eax)
 20d:	00 03                	add    %al,(%ebx)
 20f:	02 00                	add    (%eax),%al
 211:	00 0b                	add    %cl,(%ebx)
 213:	02 00                	add    (%eax),%al
 215:	00 02                	add    %al,(%edx)
 217:	00 91 00 0b 02 00    	add    %dl,0x20b00(%ecx)
 21d:	00 1d 02 00 00 0a    	add    %bl,0xa000002
 223:	00 91 00 06 0c ff    	add    %dl,-0xf3fa00(%ecx)
 229:	ff                   	(bad)  
 22a:	ff 00                	incl   (%eax)
 22c:	1a 9f 1d 02 00 00    	sbb    0x21d(%edi),%bl
 232:	23 02                	and    (%edx),%eax
 234:	00 00                	add    %al,(%eax)
 236:	01 00                	add    %eax,(%eax)
 238:	57                   	push   %edi
 239:	23 02                	and    (%edx),%eax
 23b:	00 00                	add    %al,(%eax)
 23d:	33 02                	xor    (%edx),%eax
 23f:	00 00                	add    %al,(%eax)
 241:	01 00                	add    %eax,(%eax)
 243:	56                   	push   %esi
 244:	33 02                	xor    (%edx),%eax
 246:	00 00                	add    %al,(%eax)
 248:	37                   	aaa    
 249:	02 00                	add    (%eax),%al
 24b:	00 02                	add    %al,(%edx)
 24d:	00 74 00 37          	add    %dh,0x37(%eax,%eax,1)
 251:	02 00                	add    (%eax),%al
 253:	00 38                	add    %bh,(%eax)
 255:	02 00                	add    (%eax),%al
 257:	00 04 00             	add    %al,(%eax,%eax,1)
 25a:	76 80                	jbe    1dc <PR_BOOTABLE+0x15c>
 25c:	7c 9f                	jl     1fd <PR_BOOTABLE+0x17d>
 25e:	38 02                	cmp    %al,(%edx)
 260:	00 00                	add    %al,(%eax)
 262:	41                   	inc    %ecx
 263:	02 00                	add    (%eax),%al
 265:	00 01                	add    %al,(%ecx)
 267:	00 56 00             	add    %dl,0x0(%esi)
 26a:	00 00                	add    %al,(%eax)
 26c:	00 00                	add    %al,(%eax)
 26e:	00 00                	add    %al,(%eax)
 270:	00 03                	add    %al,(%ebx)
 272:	02 00                	add    (%eax),%al
 274:	00 26                	add    %ah,(%esi)
 276:	02 00                	add    (%eax),%al
 278:	00 02                	add    %al,(%edx)
 27a:	00 91 08 26 02 00    	add    %dl,0x22608(%ecx)
 280:	00 2c 02             	add    %ch,(%edx,%eax,1)
 283:	00 00                	add    %al,(%eax)
 285:	01 00                	add    %eax,(%eax)
 287:	53                   	push   %ebx
 288:	2c 02                	sub    $0x2,%al
 28a:	00 00                	add    %al,(%eax)
 28c:	2d 02 00 00 02       	sub    $0x2000002,%eax
 291:	00 74 00 2d          	add    %dh,0x2d(%eax,%eax,1)
 295:	02 00                	add    (%eax),%al
 297:	00 37                	add    %dh,(%edi)
 299:	02 00                	add    (%eax),%al
 29b:	00 02                	add    %al,(%edx)
 29d:	00 74 04 37          	add    %dh,0x37(%esp,%eax,1)
 2a1:	02 00                	add    (%eax),%al
 2a3:	00 38                	add    %bh,(%eax)
 2a5:	02 00                	add    (%eax),%al
 2a7:	00 03                	add    %al,(%ebx)
 2a9:	00 73 7f             	add    %dh,0x7f(%ebx)
 2ac:	9f                   	lahf   
 2ad:	38 02                	cmp    %al,(%edx)
 2af:	00 00                	add    %al,(%eax)
 2b1:	40                   	inc    %eax
 2b2:	02 00                	add    (%eax),%al
 2b4:	00 01                	add    %al,(%ecx)
 2b6:	00 53 00             	add    %dl,0x0(%ebx)
 2b9:	00 00                	add    %al,(%eax)
 2bb:	00 00                	add    %al,(%eax)
 2bd:	00 00                	add    %al,(%eax)
 2bf:	00 23                	add    %ah,(%ebx)
 2c1:	02 00                	add    (%eax),%al
 2c3:	00 42 02             	add    %al,0x2(%edx)
 2c6:	00 00                	add    %al,(%eax)
 2c8:	01 00                	add    %eax,(%eax)
 2ca:	57                   	push   %edi
 2cb:	42                   	inc    %edx
 2cc:	02 00                	add    (%eax),%al
 2ce:	00 44 02 00          	add    %al,0x0(%edx,%eax,1)
 2d2:	00 0e                	add    %cl,(%esi)
 2d4:	00 91 00 06 0c ff    	add    %dl,-0xf3fa00(%ecx)
 2da:	ff                   	(bad)  
 2db:	ff 00                	incl   (%eax)
 2dd:	1a 91 04 06 22 9f    	sbb    -0x60ddf9fc(%ecx),%dl
 2e3:	00 00                	add    %al,(%eax)
 2e5:	00 00                	add    %al,(%eax)
 2e7:	00 00                	add    %al,(%eax)
 2e9:	00 00                	add    %al,(%eax)
 2eb:	48                   	dec    %eax
 2ec:	00 00                	add    %al,(%eax)
 2ee:	00 5d 00             	add    %bl,0x0(%ebp)
 2f1:	00 00                	add    %al,(%eax)
 2f3:	01 00                	add    %eax,(%eax)
 2f5:	53                   	push   %ebx
 2f6:	5d                   	pop    %ebp
 2f7:	00 00                	add    %al,(%eax)
 2f9:	00 6b 00             	add    %ch,0x0(%ebx)
 2fc:	00 00                	add    %al,(%eax)
 2fe:	03 00                	add    (%eax),%eax
 300:	73 60                	jae    362 <PR_BOOTABLE+0x2e2>
 302:	9f                   	lahf   
 303:	6b 00 00             	imul   $0x0,(%eax),%eax
 306:	00 79 00             	add    %bh,0x0(%ecx)
 309:	00 00                	add    %al,(%eax)
 30b:	01 00                	add    %eax,(%eax)
 30d:	53                   	push   %ebx
 30e:	00 00                	add    %al,(%eax)
 310:	00 00                	add    %al,(%eax)
 312:	00 00                	add    %al,(%eax)
 314:	00 00                	add    %al,(%eax)
 316:	55                   	push   %ebp
 317:	00 00                	add    %al,(%eax)
 319:	00 7b 00             	add    %bh,0x0(%ebx)
 31c:	00 00                	add    %al,(%eax)
 31e:	01 00                	add    %eax,(%eax)
 320:	57                   	push   %edi
 321:	00 00                	add    %al,(%eax)
 323:	00 00                	add    %al,(%eax)
 325:	00 00                	add    %al,(%eax)
 327:	00 00                	add    %al,(%eax)
 329:	89 00                	mov    %eax,(%eax)
 32b:	00 00                	add    %al,(%eax)
 32d:	9c                   	pushf  
 32e:	00 00                	add    %al,(%eax)
 330:	00 02                	add    %al,(%edx)
 332:	00 91 00 9c 00 00    	add    %dl,0x9c00(%ecx)
 338:	00 b0 00 00 00 01    	add    %dh,0x1000000(%eax)
 33e:	00 53 b0             	add    %dl,-0x50(%ebx)
 341:	00 00                	add    %al,(%eax)
 343:	00 b6 00 00 00 03    	add    %dh,0x3000000(%esi)
 349:	00 73 68             	add    %dh,0x68(%ebx)
 34c:	9f                   	lahf   
 34d:	b6 00                	mov    $0x0,%dh
 34f:	00 00                	add    %al,(%eax)
 351:	de 00                	fiadd  (%eax)
 353:	00 00                	add    %al,(%eax)
 355:	01 00                	add    %eax,(%eax)
 357:	53                   	push   %ebx
 358:	00 00                	add    %al,(%eax)
 35a:	00 00                	add    %al,(%eax)
 35c:	00 00                	add    %al,(%eax)
 35e:	00 00                	add    %al,(%eax)
 360:	89 00                	mov    %eax,(%eax)
 362:	00 00                	add    %al,(%eax)
 364:	9c                   	pushf  
 365:	00 00                	add    %al,(%eax)
 367:	00 02                	add    %al,(%edx)
 369:	00 30                	add    %dh,(%eax)
 36b:	9f                   	lahf   
 36c:	a3 00 00 00 b5       	mov    %eax,0xb5000000
 371:	00 00                	add    %al,(%eax)
 373:	00 01                	add    %al,(%ecx)
 375:	00 52 b5             	add    %dl,-0x4b(%edx)
 378:	00 00                	add    %al,(%eax)
 37a:	00 b6 00 00 00 08    	add    %dh,0x8000000(%esi)
 380:	00 73 00             	add    %dh,0x0(%ebx)
 383:	76 00                	jbe    385 <PR_BOOTABLE+0x305>
 385:	1c 48                	sbb    $0x48,%al
 387:	1c 9f                	sbb    $0x9f,%al
 389:	b6 00                	mov    $0x0,%dh
 38b:	00 00                	add    %al,(%eax)
 38d:	bb 00 00 00 06       	mov    $0x6000000,%ebx
 392:	00 73 00             	add    %dh,0x0(%ebx)
 395:	76 00                	jbe    397 <PR_BOOTABLE+0x317>
 397:	1c 9f                	sbb    $0x9f,%al
 399:	bb 00 00 00 e1       	mov    $0xe1000000,%ebx
 39e:	00 00                	add    %al,(%eax)
 3a0:	00 01                	add    %al,(%ecx)
 3a2:	00 52 00             	add    %dl,0x0(%edx)
 3a5:	00 00                	add    %al,(%eax)
 3a7:	00 00                	add    %al,(%eax)
 3a9:	00 00                	add    %al,(%eax)
 3ab:	00 02                	add    %al,(%edx)
 3ad:	01 00                	add    %eax,(%eax)
 3af:	00 07                	add    %al,(%edi)
 3b1:	01 00                	add    %eax,(%eax)
 3b3:	00 02                	add    %al,(%edx)
 3b5:	00 30                	add    %dh,(%eax)
 3b7:	9f                   	lahf   
 3b8:	07                   	pop    %es
 3b9:	01 00                	add    %eax,(%eax)
 3bb:	00 19                	add    %bl,(%ecx)
 3bd:	01 00                	add    %eax,(%eax)
 3bf:	00 01                	add    %al,(%ecx)
 3c1:	00 50 19             	add    %dl,0x19(%eax)
 3c4:	01 00                	add    %eax,(%eax)
 3c6:	00 1c 01             	add    %bl,(%ecx,%eax,1)
 3c9:	00 00                	add    %al,(%eax)
 3cb:	03 00                	add    (%eax),%eax
 3cd:	70 65                	jo     434 <PR_BOOTABLE+0x3b4>
 3cf:	9f                   	lahf   
 3d0:	22 01                	and    (%ecx),%al
 3d2:	00 00                	add    %al,(%eax)
 3d4:	36 01 00             	add    %eax,%ss:(%eax)
 3d7:	00 01                	add    %al,(%ecx)
 3d9:	00 50 00             	add    %dl,0x0(%eax)
 3dc:	00 00                	add    %al,(%eax)
 3de:	00 00                	add    %al,(%eax)
 3e0:	00 00                	add    %al,(%eax)
 3e2:	00 02                	add    %al,(%edx)
 3e4:	01 00                	add    %eax,(%eax)
 3e6:	00 20                	add    %ah,(%eax)
 3e8:	01 00                	add    %eax,(%eax)
 3ea:	00 02                	add    %al,(%edx)
 3ec:	00 30                	add    %dh,(%eax)
 3ee:	9f                   	lahf   
 3ef:	20 01                	and    %al,(%ecx)
 3f1:	00 00                	add    %al,(%eax)
 3f3:	22 01                	and    (%ecx),%al
 3f5:	00 00                	add    %al,(%eax)
 3f7:	01 00                	add    %eax,(%eax)
 3f9:	56                   	push   %esi
 3fa:	22 01                	and    (%ecx),%al
 3fc:	00 00                	add    %al,(%eax)
 3fe:	3a 01                	cmp    (%ecx),%al
 400:	00 00                	add    %al,(%eax)
 402:	02 00                	add    (%eax),%al
 404:	30 9f 00 00 00 00    	xor    %bl,0x0(%edi)
 40a:	00 00                	add    %al,(%eax)
 40c:	00 00                	add    %al,(%eax)
 40e:	60                   	pusha  
 40f:	01 00                	add    %eax,(%eax)
 411:	00 64 01 00          	add    %ah,0x0(%ecx,%eax,1)
 415:	00 01                	add    %al,(%ecx)
 417:	00 50 64             	add    %dl,0x64(%eax)
 41a:	01 00                	add    %eax,(%eax)
 41c:	00 80 01 00 00 01    	add    %al,0x1000001(%eax)
 422:	00 53 00             	add    %dl,0x0(%ebx)
 425:	00 00                	add    %al,(%eax)
 427:	00 00                	add    %al,(%eax)
 429:	00 00                	add    %al,(%eax)
 42b:	00                   	.byte 0x0

Disassembly of section .debug_ranges:

00000000 <.debug_ranges>:
   0:	a6                   	cmpsb  %es:(%edi),%ds:(%esi)
   1:	01 00                	add    %eax,(%eax)
   3:	00 ab 01 00 00 b1    	add    %ch,-0x4effffff(%ebx)
   9:	01 00                	add    %eax,(%eax)
   b:	00 b9 01 00 00 00    	add    %bh,0x1(%ecx)
  11:	00 00                	add    %al,(%eax)
  13:	00 00                	add    %al,(%eax)
  15:	00 00                	add    %al,(%eax)
  17:	00 a6 01 00 00 ab    	add    %ah,-0x54ffffff(%esi)
  1d:	01 00                	add    %eax,(%eax)
  1f:	00 b1 01 00 00 b2    	add    %dh,-0x4dffffff(%ecx)
  25:	01 00                	add    %eax,(%eax)
  27:	00 00                	add    %al,(%eax)
  29:	00 00                	add    %al,(%eax)
  2b:	00 00                	add    %al,(%eax)
  2d:	00 00                	add    %al,(%eax)
  2f:	00 cf                	add    %cl,%bh
  31:	01 00                	add    %eax,(%eax)
  33:	00 d1                	add    %dl,%cl
  35:	01 00                	add    %eax,(%eax)
  37:	00 d7                	add    %dl,%bh
  39:	01 00                	add    %eax,(%eax)
  3b:	00 d8                	add    %bl,%al
  3d:	01 00                	add    %eax,(%eax)
  3f:	00 00                	add    %al,(%eax)
  41:	00 00                	add    %al,(%eax)
  43:	00 00                	add    %al,(%eax)
  45:	00 00                	add    %al,(%eax)
  47:	00 db                	add    %bl,%bl
  49:	01 00                	add    %eax,(%eax)
  4b:	00 dd                	add    %bl,%ch
  4d:	01 00                	add    %eax,(%eax)
  4f:	00 e2                	add    %ah,%dl
  51:	01 00                	add    %eax,(%eax)
  53:	00 e3                	add    %ah,%bl
  55:	01 00                	add    %eax,(%eax)
  57:	00 00                	add    %al,(%eax)
  59:	00 00                	add    %al,(%eax)
  5b:	00 00                	add    %al,(%eax)
  5d:	00 00                	add    %al,(%eax)
  5f:	00                   	.byte 0x0
