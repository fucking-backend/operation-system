## Linux如何实现进程与进程调度?

### Linux如何表示进程
### Linux进程数据结构
### 创建 task_struct 结构
### Linux进程地址空间
### Linux进程文件表
### Linux进程调度
### 进程调度实体
### 进程运行队列
### 调度实体和运行队列的关系
### 调度器实体
### Linux 的 CFS 调度器
### 普通进程的权重
### 进程调度延迟
### 虚拟时间
### CFS进程调度
### 定时周期调度
### 调度器入口
### 挑选下一个进程
### 思考题

想一想，Linux 进程的优先级和 Linux 调度类的优先级是一回事儿吗？

### question

```sh
一、进程数据结构
每个CPU有一个rq结构，描述进程运行队列，其中：
A、cfs_rq、rt_rq、dl_rq，分别包含了公平调度、实时调度、最早截至时间调度算法相关的队列
B、记录了当前CPU的，正在运行的进程、空转进程、停止进程等；
C、每个进程用一个task_struct结构描述；

task_struct结构包括：
sched_entity结构，描述调度实体；
files_struct 结构，描述进程打开的文件；
mm_struct结构，描述一个进程的地址空间的数据结构；其中包括，vm_area_struct 结构，描述一段虚拟地址空间

二、fork创建一个进程
调用fork
->_do_fork
->->_do_fork首先调用复制进程copy_process
->->->调用了一系列的copy和初始化函数：dup_task_struct、copy_creds、copy_semundo、copy_files、copy_fs、copy_sighand、copy_signal、copy_mm、copy_namespaces、copy_io、copy_thread、copy_seccomp
->->_do_fork然后调用wake_up_new_task，初始化并准备好第一次启动，进入runqueue

其中，_do_fork->copy_process->dup_task_struct
A、alloc_task_struct_node，分配结构体
alloc_task_struct_node->kmem_cache_alloc_node->kmem_cache_alloc->slab_alloc->接上了之前的内容
B、alloc_thread_stack_node，分配内核栈
alloc_thread_stack_node->alloc_pages_node->__alloc_pages_node->__alloc_pages->__alloc_pages_nodemask->接上了之前的内容
C、arch_dup_task_struct复制task_struct
D、setup_thread_stack设置内核栈

其中，_do_fork->copy_process->copy_mm->dup_mm
A、allocate_mm，分配内存
B、memcpy，结构拷贝
C、mm_init，mm初始化
D、dup_mmap，mmap拷贝

其中，_do_fork->copy_files->dup_fd
kmem_cache_alloc，分配内存
copy_fd_bitmaps，拷贝fd位图数据

三、调度器数据结构
sched_class结构，通过一组函数指针描述了调度器；
__end_sched_classes，优先级最高
stop_sched_class，停止调度类
dl_sched_class，最早截至时间调度类
rt_sched_class，实时调度类
fair_sched_class，公平调度调度类
idle_sched_class，空转调度类
__begin_sched_classes，优先级最低

调度器的优先级，是编译时指定的，通过__begin_sched_classes和__end_sched_classes进行定位；

四、CFS调度
cfs调度算法，调度队列为cfs_rq，其整体是一个红黑树，树根记录在tasks_timeline中；
cfs调度器，根据一个进程权重占总体权重的比例，确定每个进程的CPU时间分配比例；而这个权重，开放给程序员的是一个nice值，数值越小，权重越大；

同时，即不能让进程切换过于频繁，也不能让进程长期饥饿，需要保证调度时间：
当进程数小于8个时，进程调度延迟为6ms，也就是每6ms保证每个进程至少运行一次；
当进程数大于8个时，进程延迟无法保证，需要确保程序至少运行一段时间才被调度，这个时间称为最小调度粒度时间，默认为0.75ms；

cfs中，由于每个进程的权重不同，所以无法单纯的通过进程运行时间来对进程优先级进行排序。所以将进程运行时间，通过权重换算，得到了一个进程运行的虚拟时间，然后通过虚拟时间，来对进程优先级进行排序。此时，红黑树的排序特性就充分发挥了，哪个进程的虚拟时间最小，就会来到红黑树的最左子节点，进行调度时，从左到右进行判断就好了。

这个时间又是如何刷新呢：
Linux会有一个scheduler_tick定时器，给调度器提供机会，刷新CFS队列虚拟时间
scheduler_tick->rq.curr.sched_class.task_tick，对应到CFS调度器，就是task_tick_fair
task_tick_fair->entity_tick
->update_curr，更新当前进程调度时间
->check_preempt_tick，根据实际运行时间、最小调度时间、虚拟时间是否最小等，判断是否要进行调度，如果需要调度则打标记

Linux进行进程调度时，调用schedule->__schedule
->pick_next_task
A、首先尝试pick_next_task_fair，获取下一个进程
B、如果获取失败，就按调取器优先级，依次尝试获取下一个进程
C、如果全部获取失败，就返回idel进程
->context_switch，如果获取到了新的进程，进行进程切换

其中，pick_next_task_fair->pick_next_entity，其实就是按红黑树从左到右尝试反馈优先级最高的进程；
然后，当前进程被切换时，也会更新虚拟时间，会在CFS红黑数中比较右侧的地方找到自己的位置，然后一直向左，向左，直到再次被调度。
```