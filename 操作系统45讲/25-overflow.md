```sh

一、数据结构
全局有一个osschedcls变量，其数据结构为schedclass_t，用于管理所有cpu的所有进程。
schedclass_t包括一个 schdata_t数组，每个cpu对应一个。schedclass_t[i]，用于管理第i个cpu的全部进程。
schedclass_t[i]包括一个thrdlst_t数组，每个进程优先级对应一个。schedclass_t[i].schdata_t[j]中，管理了第i个cpu的，优先级为j的全部进程。

二、初始化
进程结构初始化：
init_krl->init_krlsched->schedclass_t_init
->对于每个cpu，调用schdata_t_init，进行初始化
->对于每个cpu的每个进程优先级，调用thrdlst_t_init初始化列表

idel进程初始化：
init_krl->init_krlcpuidle
->new_cpuidle->new_cpuidle_thread->krlthread_kernstack_init【krlcpuidle_main传参】->krlschedul
->krlcpuidle_start->retnfrom_first_sched启动idel进程

三、进程调度
init_krl->init_krlcpuidle->new_cpuidle->new_cpuidle_thread->krlthread_kernstack_init【krlcpuidle_main传参】->krlschedul
->krlsched_retn_currthread根据当前cpuid，获取正在运行的进程
->krlsched_select_thread，获取下一个运行的进程
A、根据当前cpuid，选择优先级最高进程列表中的第一个进程
B、并将该优先级的当前进程，重新放回进程列表
C、如果没有进程要运行，则返回idel进程
->save_to_new_context，进行进程切换
A、保存当前进程的寄存器状态，到当前寄存器的栈
B、切换栈寄存器，指“向下一进程”的栈
C、调用__to_new_context
D、从“下一进程”的栈，恢复寄存器状态
E、而上面这些保存的状态，都是“下一进程”在释放CPU时保存好的
F、当CPU再次回到这个所谓的“下一进程”时，又会用同样的方式还原现场，继续执行
->->__to_new_context
A、更新当前运行进程为“下一个进程”
B、设置“下一进程”的tss为当前CPU的tss
C、设置“下一进程”的内核栈
D、装载“下一进程“的MMU页表
E、如果“下一个进程”没有运行过，调用retnfrom_first_sched，进行第一次运行初始化
->->-> retnfrom_first_sched
设置好新进程的相关寄存器和栈，直接运行新建进程的相关代码

```