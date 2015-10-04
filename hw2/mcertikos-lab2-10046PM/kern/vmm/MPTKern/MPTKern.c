#include <lib/x86.h>
#include <lib/debug.h>

#include "import.h"

/**
 * Sets the entire page map for process 0 as identity map.
 * Note that part of the task is already completed by pdir_init.
 */
void pdir_init_kern(unsigned int mbi_adr)
{
    unsigned int pde_index;
    pdir_init(mbi_adr);
    for (pde_index = 0; pde_index < 1024; pde_index ++)
    {
        set_pdir_entry_identity(0, pde_index);    
    }
}

/**
 * Maps the physical page # [page_index] for the given virtual address with the given permission.
 * In the case, when the page table for the page directory entry is not set up, you need to allocate the page table first.
 * In the case of error, it returns the constant MagicNumber defined in lib/x86.h,
 * otherwise, it returns the physical page index registered in the page directory,
 * e.g., the return value of get_pdir_entry_by_va or alloc_ptbl.
 */
unsigned int map_page(unsigned int proc_index, unsigned int vadr, unsigned int page_index, unsigned int perm)
{   
  // TODO
  unsigned int pdir_entry = get_pdir_entry_by_va(proc_index, vadr);
  if (pdir_entry == 0) 
  {
      // page not set up
      int page_id = alloc_ptbl(proc_index, vadr);
      if (page_id != 0) {
          set_ptbl_entry_by_va(proc_index, vadr, page_index, perm);
          return page_id;
      } 
  }
  else 
  {
      // page set up already
      set_ptbl_entry_by_va(proc_index, vadr, page_index, perm);
      return pdir_entry;
  } 
  return MagicNumber;
}

/**
 * Remove the mapping for the given virtual address (with rmv_ptbl_entry_by_va).
 * You need to first make sure that the mapping is still valid,
 * e.g., by reading the page table entry for the virtual address.
 * Nothing should be done if the mapping no longer exists.
 * You do not need to unmap the page table from the page directory.
 * It should return the corresponding page table entry.
 */
unsigned int unmap_page(unsigned int proc_index, unsigned int vadr)
{
    unsigned int ptbl_entry = get_ptbl_entry_by_va(proc_index, vadr);
    if (ptbl_entry == 0) 
    {
        return 0;
    }
    else 
    {
        rmv_ptbl_entry_by_va(proc_index, vadr);
        return ptbl_entry;
    }
}   
