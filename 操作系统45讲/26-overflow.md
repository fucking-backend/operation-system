```sh

一、数据结构
全局有一个osschedcls变量，其数据结构为schedclass_t，用于管理所有cpu的所有进程。

schedclass_t包括一个 schdata_t数组，每个cpu对应一个。
schedclass_t.schdata_t[i]，用于管理第i个cpu的全部进程。

schedclass_t.schdata_t[i]包括一个thrdlst_t数组，每个进程优先级对应一个。
schedclass_t.schdata_t[i].thrdlst_t[j]中，管理了第i个cpu的，优先级为j的全部进程。

二、idel进程
idel进程初始化及启动：
init_krl->init_krlcpuidle->new_cpuidle->new_cpuidle_thread->krlthread_kernstack_init【krlcpuidle_main传参】->krlschedul->krlcpuidle_start->retnfrom_first_sched启动idel进程

idel进程调度：
idel进程启动后，会不停的在krlcpuidle_main函数中循环调用krlschedul，只要有其他进程可以运行，就让渡CPU使用权给到其他进程；
其他进程调用krlschedul让渡CPU使用权时，如果找不到”下一进程“，会将CPU使用权给回到idel进程；

三、进程的等待与唤醒【信号量为例】
信号量sem_t，有一个等待进程列表kwlst_t，保存了等待获取信号量的全部进程列表

获取信号量：
进程调用krlsem_down->当信号量不足时krlwlst_wait->主动调用krlsched_wait让渡CPU使用权，让其他进程优先运行
即使其他进程把CPU使用权又还回来，也会继续循环，不断尝试获取信号量

释放信号量：
进程调用krlsem_up->krlwlst_allup->对kwlst_t中全部等待进程，依次调用krlsched_up->被给与CPU使用权的进程，会立即唤醒并尝试获取信号量

最后，有一个问题没想清楚，还请老师帮忙解答一下：
系统的idel进程只有一个，如果多个cpu同时空闲，会不会有问题啊？空闲进程不用per_cpu吗？

```