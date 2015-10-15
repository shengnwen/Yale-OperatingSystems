#include "lib/x86.h"

#include "import.h"

/**
 * Initializes all the thread queues with
 * tqueue_init_at_id.
 */
void tqueue_init(unsigned int mbi_addr)
{
  // TODO: define your local variables here.
	unsigned int chid;
	tcb_init(mbi_addr);
	for (chid = 0; chid < NUM_IDS + 1; chid++) 
	{
		tqueue_init_at_id(chid);
	}
}

/**
 * Insert the TCB #pid into the tail of the thread queue #chid.
 * Recall that the doubly linked list is index based.
 * So you only need to insert the index.
 * Hint: there are multiple cases in this function.
 */
void tqueue_enqueue(unsigned int chid, unsigned int pid)
{
	if (chid > NUM_IDS || pid >= NUM_IDS) 
	{
		return;
	}
	//case 1: insert into empty
	if (tqueue_get_head(chid) == NUM_IDS && tqueue_get_tail(chid) == NUM_IDS)
	{
		tqueue_set_head(chid, pid);
	} 
	else 
	{
	//case 2: insert into 
		unsigned int tail = tqueue_get_tail(chid);
		tcb_set_next(tail, pid);
		tcb_set_prev(pid, tail);
		tcb_set_next(pid, NUM_IDS);
	}
	tqueue_set_tail(chid, pid);
}

/**
 * Reverse action of tqueue_enqueue, i.g., pops a TCB from the head of specified queue.
 * It returns the poped thread's id, or NUM_IDS if the queue is empty.
 * Hint: there are mutiple cases in this function.
 */
unsigned int tqueue_dequeue(unsigned int chid)
{
  // TODO
    unsigned int head = tqueue_get_head(chid);
	unsigned int tail = tqueue_get_tail(chid);
	
	if (head == NUM_IDS && tail == NUM_IDS)
	{
		// case 1 empty
		return NUM_IDS;
	}
	if (head == tail)
	{
		tqueue_set_head(chid, NUM_IDS);
		tqueue_set_tail(chid, NUM_IDS);
	}
	else
	{
  		//case 3 >= 2 element
		unsigned int next = tcb_get_next(head);
		tcb_set_prev(next, NUM_IDS);
		tqueue_set_head(chid, next);
  	}
	tcb_set_next(head, NUM_IDS);		
	tcb_set_prev(head, NUM_IDS);
  	return head;
}

/**
 * Removes the TCB #pid from the queue #chid.
 * Hint: there are many cases in this function.
 */
void tqueue_remove(unsigned int chid, unsigned int pid)
{
  // TODO
  // case 1: not found
  	unsigned int head = tqueue_get_head(chid);
	unsigned int tail = tqueue_get_tail(chid);
  	if (head == NUM_IDS && tail == NUM_IDS)
	{
		return;	 
	}
  // case 2: only one element
    if (head == tail)
	{
		if (head == pid) 
		{
			// find pid
			tqueue_set_tail(chid, NUM_IDS);
			tqueue_set_head(chid, NUM_IDS);
		}
		tcb_set_next(pid, NUM_IDS);
		tcb_set_prev(pid, NUM_IDS);
		return;
	}
	while(head != NUM_IDS)
	{
		if (head == pid)
		{
			if (head == tqueue_get_head(chid))
			{
				unsigned new_head = tcb_get_next(head);
				tqueue_set_head(chid, new_head);
				tcb_set_prev(new_head, NUM_IDS);
				
			}
			else 
			{
				unsigned int pre = tcb_get_prev(head);
				unsigned int next = tcb_get_next(head);
				tcb_set_next(pre, next);
				if (next != NUM_IDS)
				{
					tcb_set_prev(next, pre);
				}
				else 
				{
					tqueue_set_tail(chid, pre);
				}
			}
			tcb_set_next(pid, NUM_IDS);
			tcb_set_prev(pid, NUM_IDS);
			return;
		}
		head = tcb_get_next(head);
	}
	
 // case 3: only 2 element
  // case 4: in the middle
}
