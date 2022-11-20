#ifndef MINIOS_KERN_PMAP_H
#define MINIOS_KERN_PMAP_H

#include <type.h>


void    map_user_proc(phyaddr_t cr3, u32 addr_to_map);
void	map_kern(phyaddr_t cr3);
void    map_user_stack(phyaddr_t cr3);

#endif