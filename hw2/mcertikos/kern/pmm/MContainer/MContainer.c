#include <lib/debug.h>
#include <lib/x86.h>
#include "import.h"

struct SContainer {
  int quota;      //maximum memory quota of the process
  int usage;      //the current memory usage of the process
  int parent;     //the id of the parent process
  int nchildren;  //the number of child processes
  int used;       //whether current container is used by a process
};

// mCertiKOS supports up to NUM_IDS processes
static struct SContainer CONTAINER[NUM_IDS]; 

/**
 * Initializes the container data for the root process (the one with index 0).
 * The root process is the one that gets spawned first by the kernel.
 */
void container_init(unsigned int mbi_addr)
{
  unsigned int real_quota;
  int max_nps;
  int i;
  pmem_init(mbi_addr);
  real_quota = 0;
  max_nps = get_nps();
  /**
   * TODO: compute the available quota and store it into the variable real_quota.
   * It should be the number of the unallocated pages with the normal permission
   * in the physical memory allocation table.
   */
  for (i = 0; i < max_nps; i++) 
  {
    if (at_is_norm(i) == 1 && at_is_allocated(i) == 0)
    {
      real_quota += 1;
    }
  }
  KERN_DEBUG("\nreal quota: %d\n\n", real_quota);

  CONTAINER[0].quota = real_quota;
  CONTAINER[0].usage = 0;
  CONTAINER[0].parent = 0;
  CONTAINER[0].nchildren = 0;
  CONTAINER[0].used = 1;
}


// get the id of parent process of process # [id]
unsigned int container_get_parent(unsigned int id)
{
  // TODO
  if (id >= NUM_IDS) 
  {
      return 0;
  }
  return CONTAINER[id].parent;
}


// get the number of children of process # [id]
unsigned int container_get_nchildren(unsigned int id)
{
  // TODO
  if (id < NUM_IDS && id >= 0) 
  {
      return CONTAINER[id].nchildren;
  }
  return 0;
}


// get the maximum memory quota of process # [id]
unsigned int container_get_quota(unsigned int id)
{
  // TODO
  return CONTAINER[id].quota;
}


// get the current memory usage of process # [id]
unsigned int container_get_usage(unsigned int id)
{
  // TODO
  return CONTAINER[id].usage;
}


// determines whether the process # [id] can consume extra
// [n] pages of memory. If so, returns 1, o.w., returns 0.
unsigned int container_can_consume(unsigned int id, unsigned int n)
{
  // TODO
  return CONTAINER[id].quota - CONTAINER[id].usage >= n ? 1 : 0;
}


/**
 * dedicates [quota] pages of memory for a new child process.
 * you can assume it is safe to allocate [quota] pages (i.e., the check is already done outside before calling this function)
 * returns the container index for the new child process.
 */
unsigned int container_split(unsigned int id, unsigned int quota)
{
  unsigned int child, nc;

  nc = CONTAINER[id].nchildren;
  child = id * MAX_CHILDREN + 1 + nc; //container index for the child process

  /**
   * TODO: update the container structure of both parent and child process appropriately.
   */
  while(CONTAINER[child].used)
  {
    child++;
  }
  // modify parent(id) info
  CONTAINER[id].usage += quota;
  CONTAINER[id].nchildren += 1;
  // modify child info
  CONTAINER[child].quota = quota;
  CONTAINER[child].usage = 0;
  CONTAINER[child].parent = id;
  CONTAINER[child].nchildren = 0;
  CONTAINER[child].used = 1;
  return child;
}


/**
 * allocates one more page for process # [id], given that its usage would not exceed the quota.
 * the container structure should be updated accordingly after the allocation.
 * returns the page index of the allocated page, or 0 in the case of failure.
 */
unsigned int container_alloc(unsigned int id)
{
  /*
   * TODO: implement the function here.
   */
  int page_id = palloc();
  if (page_id == 0) {
    return 0;
  }
  CONTAINER[id].usage += 1;
  CONTAINER[id].used = 1;
  return page_id;
}

// frees the physical page and reduces the usage by 1.
void container_free(unsigned int id, unsigned int page_index)
{
  // TODO
  pfree(page_index);
  CONTAINER[id].usage -= 1;
}
