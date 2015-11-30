#include <lib/trap.h>
#include <lib/x86.h>

#include "import.h"

extern tf_t uctx_pool[NUM_IDS];

/**
 * Retrieves the system call arguments from uctx_pool that gets
 * passed in from the current running process's system call.
 */

unsigned int syscall_get_arg1(void)
{
  // TODO
	unsigned int cur_id = get_curid();
	return uctx_pool[cur_id].regs.eax;
}

unsigned int syscall_get_arg2(void)
{
  // TODO
	unsigned int cur_id = get_curid();
	return uctx_pool[cur_id].regs.ebx; 
}

unsigned int syscall_get_arg3(void)
{
  // TODO
	unsigned int cur_id = get_curid();
	return uctx_pool[cur_id].regs.ecx;
}

unsigned int syscall_get_arg4(void)
{
  // TODO
	unsigned int cur_id = get_curid();
	return uctx_pool[cur_id].regs.edx;
}

unsigned int syscall_get_arg5(void)
{
  // TODO
	unsigned int cur_id = get_curid();
	return uctx_pool[cur_id].regs.edi;
}

unsigned int syscall_get_arg6(void)
{
  // TODO
	unsigned int cur_id = get_curid();
	return uctx_pool[cur_id].regs.esi;
}

/**
 * Sets the error number in uctx_pool which gets passed
 * to the current running process when we return to it.
 */
void syscall_set_errno(unsigned int errno)
{
  // TODO
	unsigned int cur_id = get_curid();
	uctx_pool[cur_id].err = errno;
}

/**
 * Sets the return values in uctx_pool which gets passed
 * to the current running process when we return to it.
 */

void syscall_set_retval1(unsigned int retval)
{
  // TODO
	unsigned int cur_id = get_curid();
	uctx_pool[cur_id].regs.ebx = retval;
}

void syscall_set_retval2(unsigned int retval)
{
  // TODO
	unsigned int cur_id = get_curid();
	uctx_pool[cur_id].regs.ecx = retval;
}

void syscall_set_retval3(unsigned int retval)
{
  // TODO
	unsigned int cur_id = get_curid();
	uctx_pool[cur_id].regs.edx = retval;
}

void syscall_set_retval4(unsigned int retval)
{
  // TODO
	unsigned int cur_id = get_curid();
	uctx_pool[cur_id].regs.edi = retval;
}

void syscall_set_retval5(unsigned int retval)
{
  // TODO
	unsigned int cur_id = get_curid();
	uctx_pool[cur_id].regs.esi = retval;
}