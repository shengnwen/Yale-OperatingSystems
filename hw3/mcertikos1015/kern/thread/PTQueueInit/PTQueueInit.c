#include "lib/x86.h"

#include "import.h"

/**
 * Initializes all the thread queues with
 * tqueue_init_at_id.
 */
void tqueue_init(unsigned int mbi_addr)
{
	unsigned int id;

	tcb_init(mbi_addr);

	for(id = 0; id <= NUM_IDS; id ++) {
		tqueue_init_at_id(id);
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
	unsigned int head_id = tqueue_get_head(chid);
	unsigned int last_in_queue;

	if(head_id == NUM_IDS) {
		tqueue_set_head(chid, pid);
	}
	else {
		last_in_queue = tqueue_get_tail(chid);
		tcb_set_next(last_in_queue, pid);
		tcb_set_prev(pid, last_in_queue);
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
  unsigned int head_id = tqueue_get_head(chid);
  unsigned int tail_id = tqueue_get_tail(chid);
  unsigned int new_head;

  if(head_id != NUM_IDS) {
	if(tail_id != head_id) {
		new_head = tcb_get_next(head_id);
		tqueue_set_head(chid, new_head);
		tcb_set_prev(new_head, NUM_IDS);
		tcb_set_next(head_id, NUM_IDS);
		return head_id;
	}
	else {
		tqueue_set_tail(chid, NUM_IDS);
		tqueue_set_head(chid, NUM_IDS);
		return head_id;
	}
  }

  return NUM_IDS;
}

/**
 * Removes the TCB #pid from the queue #chid.
 * Hint: there are many cases in this function.
 */
void tqueue_remove(unsigned int chid, unsigned int pid)
{
	unsigned int head_id = tqueue_get_head(chid);
	unsigned int id_pointer = head_id;
	unsigned int next_pointer;
	unsigned int prev_pointer;

	while(id_pointer != NUM_IDS && id_pointer != pid){
		id_pointer = tcb_get_next(id_pointer);
	}

	if(id_pointer == NUM_IDS) {
		return ;
	}

	next_pointer = tcb_get_next(pid);
	prev_pointer = tcb_get_prev(pid);

	if(next_pointer != NUM_IDS) {
		tcb_set_prev(next_pointer, prev_pointer);
	}
	else {
		tqueue_set_tail(chid, prev_pointer);
	}

	if(prev_pointer != NUM_IDS) {
		tcb_set_next(prev_pointer, next_pointer);
	}
	else {
		tqueue_set_head(chid, next_pointer);
	}

	tcb_set_next(pid, NUM_IDS);
	tcb_set_prev(pid, NUM_IDS);
}
