#include <lib/x86.h>

/**
 * Kernel thread context.
 * When you switch to another kernel thread, you need to save
 * the current thread's states and restore the new thread's states.
 */
struct kctx {
	void	*esp; // top address of stack
	unsigned int edi; // destination index
	unsigned int esi;// source index pointer
	unsigned int ebx; // general registers, base registers
	unsigned int ebp;// stack base address
	void	*eip; // ofset of next instruction
};

//places to save the [NUM_IDS] kernel thread states.
struct kctx kctx_pool[NUM_IDS];

void kctx_set_esp(unsigned int pid, void *esp)
{
	kctx_pool[pid].esp = esp;
}

void kctx_set_eip(unsigned int pid, void *eip)
{
	kctx_pool[pid].eip = eip;
}

extern void cswitch(struct kctx *from_kctx, struct kctx *to_kctx);

/**
 * Saves the states for thread # [from_pid] and restores the states
 * for thread # [to_pid].
 */
void kctx_switch(unsigned int from_pid, unsigned int to_pid)
{
	cswitch(&kctx_pool[from_pid], &kctx_pool[to_pid]);
}
