#include <lib/gcc.h>
#include <lib/x86.h>

#include "import.h"

extern char STACK_LOC[NUM_IDS][PAGESIZE] gcc_aligned(PAGESIZE);

/**
 * Allocates memory for the new child thread, then sets the eip, and esp
 * of the thread states. The eip should be set to [entry], and the
 * esp should be set to the corresponding stack TOP in STACK_LOC.
 * Don't forget the stack is going down from high address to low.
 * We do not care about the rest of states when a new thread starts.
 * The function returns the child thread (process) id.
 */
unsigned int kctx_new(void *entry, unsigned int id, unsigned int quota)
{
	if (entry < 0 || id > NUM_IDS) 
    {
        // fail on set up new child thread
		return 0;
	}
    unsigned int child = alloc_mem_quota(id, quota);  
    kctx_set_eip(child, entry);
    kctx_set_esp(child, (void*)&STACK_LOC[id][PAGESIZE - 1]);
	return child;
}
