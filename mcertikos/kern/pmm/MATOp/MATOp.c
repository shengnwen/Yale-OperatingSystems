#include <lib/debug.h>
#include "import.h"

#define PAGESIZE	4096
#define VM_USERLO	0x40000000
#define VM_USERHI	0xF0000000
#define VM_USERLO_PI	(VM_USERLO / PAGESIZE)
#define VM_USERHI_PI	(VM_USERHI / PAGESIZE)
/**
 * Allocation of a physical page.
 *
 * 1. First, implement a naive page allocator that scans the allocation table (AT) 
 *    using the functions defined in import.h to find the first unallocated page
 *    with usable permission.
 *    (Q: Do you have to scan allocation table from index 0? Recall how you have
 *    initialized the table in pmem_init.)
 *    Then mark the page as allocated in the allocation table and return the page
 *    index of the page found. In the case when there is no avaiable page found,
 *    return 0.
 * 2. Optimize the code with the memorization techniques so that you do not have to
 *    scan the allocation table from scratch every time.
 */

unsigned int naive_palloc() {
     //unsigned int nps = get_nps() - 1 > VM_USERHI_PI ? VM_USERHI_PI : get_nps() - 1;
     unsigned int i;
     for (i = VM_USERLO_PI; i <  VM_USERHI_PI; i++) {
//         dprintf("%u:is_allocated %u, is_norm %u", at_is_allocated(i), at_is_norm(i));
     if (at_is_allocated(i) == 0 && at_is_norm(i)) {
             at_set_allocated(i, 1);
             return i;
         }
     }
     dprintf("find nothing!");
     return 0;
}

unsigned int
palloc()
{
  // TODO
  static unsigned int start = VM_USERLO_PI;
  for (; start < VM_USERHI_PI; start++) {
    if (at_is_allocated(start) == 0 && at_is_norm(start)) {
      at_set_allocated(start, 1);
      return start;
    }
  }     
  //return 0;
  //return naive_palloc();
} 

/**
 * Free of a physical page.
 *
 * This function marks the page with given index as unallocated
 * in the allocation table.
 *
 * Hint: Simple.
 */
void
pfree(unsigned int pfree_index)
{
  // TODO
  if (pfree_index < get_nps()) {
      at_set_allocated(pfree_index, 0);
  } 
}
