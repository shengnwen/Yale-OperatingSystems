#include <kern/lib/types.h>
#include <kern/lib/debug.h>
#include <kern/lib/string.h>
#include "inode.h"
#include "dir.h"

// Directories

int
dir_namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
}

/**
 * Look for a directory entry in a directory.
 * If found, set *poff to byte offset of entry.
 */
struct inode*
dir_lookup(struct inode *dp, char *name, uint32_t *poff)
{
  uint32_t off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    KERN_PANIC("dir_lookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)) {
	if(inode_read(dp, (char*)&de, off, sizeof(de)) != sizeof(de)) {
	  KERN_PANIC("isdirempty: readi");
	}
	if(!dir_namecmp(name, de.name)){
		*poff = off;
		return(inode_get(dp->dev, de.inum));
	}
  }

  return NULL;
}

// Write a new directory entry (name, inum) into the directory dp.
int
dir_link(struct inode *dp, char *name, uint32_t inum)
{
  struct inode* newDP;
  uint32_t* offset;
  struct dirent de;
  int off;

  newDP = dir_lookup(dp, name, offset);

  if(newDP != NULL) {
	inode_put(newDP);
	return -1;
  }

  for(off = 0; off < dp->size; off += sizeof(de)) {
	if(inode_read(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
	  KERN_PANIC("oh yeah");
	if(de.inum == 0) {
		strncpy(de.name, name, DIRSIZ);
		de.inum = inum;
		if(inode_write(dp, (char*)&de, off, sizeof(de)) == -1){
			return 1;
		}
		return 0;
	}
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(inode_write(dp, (char*)&de, off, sizeof(de)) == -1) {
	return 1;
  }
  return 0;
}
