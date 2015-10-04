#include <lib/x86.h>

#include "import.h"

/**
 * Returns the page table entry corresponding to the virtual address,
 * according to the page structure of process # [proc_index].
 * Returns 0 if the mapping does not exist.
 */
unsigned int get_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
    // TODO
    if (proc_index >= NUM_IDS) 
    {
        return 0;
    }
    unsigned int pde_index = vaddr >> 22;
    unsigned int pte_index = (vaddr>>12) & (0b1111111111);
    if (get_pdir_entry(proc_index, pde_index) == 0) 
    {
        return 0;
    } 
    return get_ptbl_entry(proc_index, pde_index, pte_index);
}         

// returns the page directory entry corresponding to the given virtual address
unsigned int get_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
    // TODO
    unsigned int pde_index = vaddr >> 22;
    return get_pdir_entry(proc_index, pde_index);
}

// removes the page table entry for the given virtual address
void rmv_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
    // TODO
    unsigned int pde_index = vaddr >> 22;
    unsigned int pte_index = (vaddr>>12) & (0b1111111111); 
    rmv_ptbl_entry(proc_index, pde_index, pte_index);
}

// removes the page directory entry for the given virtual address
void rmv_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
    // TODO
    unsigned int pde_index = vaddr >> 22;
    rmv_pdir_entry(proc_index, pde_index);
}

// maps the virtual address [vaddr] to the physical page # [page_index] with permission [perm]
// you do not need to worry about the page directory entry. just map the page table entry.
void set_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr, unsigned int page_index, unsigned int perm)
{
    // TODO
    unsigned int pde_index = vaddr >> 22;
    unsigned int pte_index = (vaddr>>12) & (0b1111111111); 
    set_ptbl_entry(proc_index, pde_index, pte_index, page_index, perm);
}

// registers the mapping from [vaddr] to physical page # [page_index] in the page directory
void set_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr, unsigned int page_index)
{
    // TODO
    unsigned int pde_index = vaddr >> 22;
    set_pdir_entry(proc_index, pde_index, page_index);    
}   

// initializes the identity page table
// the permission for the kernel memory should be PTE_P, PTE_W, and PTE_G,
// while the permission for the rest should be PTE_P and PTE_W.
void idptbl_init(unsigned int mbi_adr)
{
    // TODO: define your local variables here.
    //
    container_init(mbi_adr);
    // TODO
    int pde_index, ptb_index;
    for (pde_index = 0; pde_index < 1024; pde_index ++)
    {
        for (ptb_index = 0; ptb_index < 1024; ptb_index++) 
        {
            unsigned int ph_address = pde_index << 22 + ptb_index << 12;
            if (ph_address < 0x40000000 || ph_address >= 0xF0000000) 
            {
                // reserved by kernel
                * (unsigned int *)ph_address = ph_address | 0b111;
            }
            else
            {
                * (unsigned int *)ph_address = ph_address | 0b11;
            }
        }
    } 
}
