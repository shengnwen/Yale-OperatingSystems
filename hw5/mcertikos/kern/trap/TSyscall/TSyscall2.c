#include <lib/debug.h>
#include <lib/types.h>
#include <lib/x86.h>
#include <lib/trap.h>
#include <lib/syscall.h>
#include <dev/intr.h>
#include <pcpu/PCPUIntro/export.h>
#include <lib/spinlock.h>
#include "import.h"

#define MAX_BUFFER_SIZE 4

static char sys_buf[NUM_IDS][PAGESIZE];
static int currentBuffer;
/**
 * Copies a string from user into buffer and prints it to the screen.
 * This is called by the user level "printf" library as a system call.
 */
void sys_puts(tf_t *tf)
{
	unsigned int cur_pid;
	unsigned int str_uva, str_len;
	unsigned int remain, cur_pos, nbytes;

	cur_pid = get_curid();
	str_uva = syscall_get_arg2(tf);
	str_len = syscall_get_arg3(tf);

	if (!(VM_USERLO <= str_uva && str_uva + str_len <= VM_USERHI)) {
		syscall_set_errno(tf, E_INVAL_ADDR);
		return;
	}

	remain = str_len;
	cur_pos = str_uva;

	while (remain) {
		if (remain < PAGESIZE - 1)
			nbytes = remain;
		else
			nbytes = PAGESIZE - 1;

		if (pt_copyin(cur_pid,
			      cur_pos, sys_buf[cur_pid], nbytes) != nbytes) {
			syscall_set_errno(tf, E_MEM);
			return;
		}

		sys_buf[cur_pid][nbytes] = '\0';
		KERN_INFO("From cpu %d: %s", get_pcpu_idx(), sys_buf[cur_pid]);

		remain -= nbytes;
		cur_pos += nbytes;
	}

	syscall_set_errno(tf, E_SUCC);
}

extern uint8_t _binary___obj_user_pingpong_ping_start[];
extern uint8_t _binary___obj_user_pingpong_pong_start[];
extern uint8_t _binary___obj_user_pingpong_ding_start[];

/**
 * Spawns a new child process.
 * The user level library function sys_spawn (defined in user/include/syscall.h)
 * takes two arguments [elf_id] and [quota], and returns the new child process id
 * or NUM_IDS (as failure), with appropriate error number.
 * Currently, we have three user processes defined in user/pingpong/ directory,
 * ping, pong, and ding.
 * The linker ELF addresses for those compiled binaries are defined above.
 * Since we do not yet have a file system implemented in mCertiKOS,
 * we statically loading the ELF binraries in to the memory based on the
 * first parameter [elf_id], i.e., ping, pong, and ding corresponds to
 * the elf_id of 1, 2, and 3, respectively.
 * If the parameter [elf_id] is none of those three, then it should return
 * NUM_IDS with the error number E_INVAL_PID. The same error case apply
 * when the proc_create fails.
 * Otherwise, you mark it as successful, and return the new child process id.
 */
void sys_spawn(tf_t *tf)
{
	unsigned int new_pid;
	unsigned int elf_id, quota;
	void *elf_addr;
	unsigned int curid;

	curid = get_curid();

	elf_id = syscall_get_arg2(tf);
	quota = syscall_get_arg3(tf);

	if(!container_can_consume(curid, quota)) {
		syscall_set_errno(tf, E_EXCEEDS_QUOTA);
		syscall_set_retval1(tf, NUM_IDS);
	}
	if(container_get_nchildren(curid) >= MAX_CHILDREN) {
		syscall_set_errno(tf, E_MAX_NUM_CHILDEN_REACHED);
		syscall_set_retval1(tf, NUM_IDS);
	}



	if (elf_id == 1) {
		elf_addr = _binary___obj_user_pingpong_ping_start;
	} else if (elf_id == 2) {
		elf_addr = _binary___obj_user_pingpong_pong_start;
	} else if (elf_id == 3) {
    elf_addr = _binary___obj_user_pingpong_ding_start;
	} else {
		syscall_set_errno(tf, E_INVAL_PID);
		syscall_set_retval1(tf, NUM_IDS);
		return;
	}

	new_pid = proc_create(elf_addr, quota);

	if (new_pid == NUM_IDS) {
		syscall_set_errno(tf, E_INVAL_CHILD_ID);
		syscall_set_retval1(tf, NUM_IDS);
	} else {
		syscall_set_errno(tf, E_SUCC);
		syscall_set_retval1(tf, new_pid);
	}
}

/**
 * Yields to another thread/process.
 * The user level library function sys_yield (defined in user/include/syscall.h)
 * does not take any argument and does not have any return values.
 * Do not forget to set the error number as E_SUCC.
 */
void sys_yield(tf_t *tf)
{
	thread_yield();
	syscall_set_errno(tf, E_SUCC);
}

int bufferFull(void) {
  spinlock_acquire(&proconLock);
  if(currentBuffer >= MAX_BUFFER_SIZE) {
	spinlock_release(&proconLock);
	return 1;
  }
  else {
	spinlock_release(&proconLock);
	return 0;
  }
}

void doProduce(void) {
  currentBuffer ++;
 
 intr_local_disable();
  KERN_DEBUG("CPU %d: Process %d: Produced, Current:%d\n", get_pcpu_idx(), get_curid(), currentBuffer);
  intr_local_enable();
}

void sys_produce(tf_t *tf)
{
	spinlock_acquire(&producerLock);
	while(bufferFull()){
		pause();
	}
	spinlock_acquire(&proconLock);
	doProduce();
	spinlock_release(&proconLock);
	spinlock_release(&producerLock);
	syscall_set_errno(tf, E_SUCC);
}

int bufferEmpty(void) {
  spinlock_acquire(&proconLock);
  if(currentBuffer == 0) {
	spinlock_release(&proconLock);
	return 1;
  }
  else {
	spinlock_release(&proconLock);
	return 0;
  }
}

void doConsume(void) {
  currentBuffer --;

  intr_local_disable();
  KERN_DEBUG("CPU %d: Process %d: Consumed, Current:%d\n", get_pcpu_idx()
	, get_curid(), currentBuffer);
  intr_local_enable();
}

void sys_consume(tf_t *tf)
{
	spinlock_acquire(&consumerLock);
	while(bufferEmpty()){
		pause();
	}
	spinlock_acquire(&proconLock);
	doConsume();
	spinlock_release(&proconLock);
	spinlock_release(&consumerLock);
	syscall_set_errno(tf, E_SUCC);
}
