#include <lib/x86.h>

#include "import.h"

/**
 * For each process from id 0 to NUM_IDS -1,
 * set the page directory entries sothat the kernel portion of the map as identity map,
 * and the rest of page directories are unmmaped.
 */
void pdir_init(unsigned int mbi_adr)
{
    // TODO: define your local variables here.
    unsigned int proc_index, pde_index;
    idptbl_init(mbi_adr);
    unsigned int PG_LO = (0x40000000 >> 22);
    unsigned int PG_HI = (0xF0000000 >> 22);
    //unsigned int PG_LO = 256, PG_HI = 960;
    // TODO
    for (proc_index = 0; proc_index < NUM_IDS; proc_index++)
    {
       for (pde_index = 0; pde_index < 1024; pde_index++)
       {
          if (pde_index < PG_LO || pde_index >= PG_HI) 
          {
              // reserve for kernel
              set_pdir_entry_identity(proc_index, pde_index);
          }
       }
    }
}

/**
 * Allocates a page (with container_alloc) for the page table,
 * and registers it in page directory for the given virtual address,
 * and clears (set to 0) the whole page table entries for this newly mapped page table.
 * It returns the page index of the newly allocated physical page.
 * In the case when there's no physical page available, it returns 0.
 */
unsigned int alloc_ptbl(unsigned int proc_index, unsigned int vadr)
{
  unsigned int page_id, pde_index, pte_index;
  if (proc_index <= NUM_IDS && proc_index > 0)
  {
    page_id = container_alloc(proc_index);
    if (page_id == 0) {
        return 0;
    }
    set_pdir_entry_by_va(proc_index, vadr, page_id);
    pde_index = vadr >> 22;
    for (pte_index = 0; pte_index < 1024; pte_index ++)
    {
      rmv_ptbl_entry(proc_index, pde_index, pte_index);
    }
    return page_id;    
  }
  return 0;
}

// Reverse operation of alloc_ptbl.
// Removes corresponding page directory entry,
// and frees the page for the page table entries (with container_free).
void free_ptbl(unsigned int proc_index, unsigned int vadr)
{
    unsigned int pde_address = vadr >> 22;
    unsigned int pte_index;
    pde_address = get_pdir_entry_by_va(proc_index, vadr);
    for (pte_index = 0; pte_index < 1024; pte_index++)
    {
       container_free(proc_index, ((unsigned int *)pde_address)[pte_index]);
    }
    rmv_pdir_entry_by_va(proc_index, vadr);
}
