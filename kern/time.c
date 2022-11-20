#include <type.h>

#include <kern/syscall.h>
#include <kern/time.h>

static size_t timecounter;

/*
 * 时间戳加一
 */
void
timecounter_inc(void)
{
	timecounter++;
}

/*
 * 获取内核当前的时间戳
 */
size_t
kern_get_ticks(void)
{
	return timecounter;
}

ssize_t
do_get_ticks(void)
{
	return (ssize_t)kern_get_ticks();
}

ssize_t
do_delay_ticks(size_t ticks)
{
	size_t timecounter1;
	size_t timecounter0 = kern_get_ticks();
	while(true)
	{
		timecounter1 = kern_get_ticks();
		if(timecounter1 - timecounter0 >= ticks)
		{
			break;
		}
	}
	return 0;
}