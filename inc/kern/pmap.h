#ifndef MINIOS_KERN_PMAP_H
#define MINIOS_KERN_PMAP_H

#include <type.h>
#include <kern/process.h>

void	map_kern(u32 cr3, struct page_node **page_list);
void	map_elf(PROCESS_0 *p_proc, void *elf_addr);
void	map_stack(PROCESS_0 *p_proc);
void	recycle_pages(struct page_node *page_list);
void
lin_mapping_phy(u32			cr3,
		struct page_node	**page_list,
		uintptr_t		laddr,
		phyaddr_t		paddr,
		u32			pte_flag);
		phyaddr_t
alloc_phy_page(struct page_node **page_list);
#endif /* MINIOS_KERN_PMAP_H */