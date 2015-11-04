#include <lib/x86.h>
#include <lib/thread.h>
#include <lib/spinlock.h>
#include <lib/debug.h>
#include <dev/lapic.h>
#include <pcpu/PCPUIntro/export.h>

#include "import.h"

static int intrCounts[NUM_CPUS];

void initIntrCounts(void);

void thread_init(unsigned int mbi_addr)
{
	tqueue_init(mbi_addr);
	set_curid(0);
	tcb_set_state(0, TSTATE_RUN);
	spinlock_init(&intrCountsLock);
	spinlock_init(&tqueueLock);
	spinlock_init(&curidLock);
	initIntrCounts();
}

void initIntrCounts(void)
{
	int i;

	for(i = 0; i < NUM_CPUS; i ++)
	{
		intrCounts[i] = 0;
	}
}

/**
 * Allocates new child thread context, set the state of the new child thread
 * as ready, and pushes it to the ready queue.
 * It returns the child thread id.
 */
unsigned int thread_spawn(void *entry, unsigned int id, unsigned int quota)
{
	unsigned int pid;

	pid = kctx_new(entry, id, quota);
	tcb_set_state(pid, TSTATE_READY);
	
	spinlock_acquire(&tqueueLock);
	tqueue_enqueue(NUM_IDS, pid);
	spinlock_release(&tqueueLock);

	return pid;
}

/**
 * Yield to the next thread in the ready queue.
 * You should set the currently running thread state as ready,
 * and push it back to the ready queue.
 * And set the state of the poped thread as running, set the
 * current thread id, then switches to the new kernel context.
 * Hint: if you are the only thread that is ready to run,
 * do you need to switch to yourself?
 */
void thread_yield(void)
{
	unsigned int old_cur_pid;
	unsigned int new_cur_pid;

	old_cur_pid = get_curid();
	tcb_set_state(old_cur_pid, TSTATE_READY);

	spinlock_acquire(&tqueueLock);
	tqueue_enqueue(NUM_IDS, old_cur_pid);
	new_cur_pid = tqueue_dequeue(NUM_IDS);
	spinlock_release(&tqueueLock);
	
	tcb_set_state(new_cur_pid, TSTATE_RUN);
	
	spinlock_acquire(&curidLock);
	set_curid(new_cur_pid);
	spinlock_release(&curidLock);

	if (old_cur_pid != new_cur_pid){
		//spinlock_acquire(&kctxLock);
		kctx_switch(old_cur_pid, new_cur_pid);
		//spinlock_release(&kctxLock);
	}
}

void sched_update() {
	int curCPU = get_pcpu_idx();
	int maxCount = LAPIC_TIMER_INTR_FREQ * SCHED_SLICE / 1000;

	spinlock_acquire(&intrCountsLock);
	intrCounts[curCPU] ++;
	if(intrCounts[curCPU] >= maxCount) {
		intrCounts[curCPU] = 0;
		spinlock_release(&intrCountsLock);
		thread_yield();
		//intrCounts[curCPU] = 0;
	}
	else {
		spinlock_release(&intrCountsLock);
	}
}
