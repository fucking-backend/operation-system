
```sh

一、数据结构
thread_t表示一个线程，包括：
锁【并发】、链表
进程标志、进程状态、进程编号【内存地址】、CPU编号【当前全是0】、CPU时间片、进程权限【内核or用户】、优先级【越小越高】、运行模式
栈信息【内核栈、应用栈】，每个进程的栈是独立的，向下生长
内存地址空间信息virmemadrs_t，每个进程的内核部分是共用的，应用部分是独立的，通过页表实现
上下文信息，用于进程切换
进程打开资源的描述符，最多TD_HAND_MAX个

二、新建进程
init_krl->init_krlcpuidle->new_cpuidle->new_cpuidle_thread->krlnew_thread
->krlnew_kern_thread_core新建内核进程
->krlnew_user_thread_core新建用户进程

krlnew_kern_thread_core：
A、krlnew分配内核栈空间
B、krlnew_thread_dsc建立thread_t结构体的实例变量，并初始化
C、设置进程权限，优先级，进程的内核栈顶和内核栈开始地址
D、初始化进程的内核栈
E、加入进程调度系统，sschedcls.scls_schda[cpuid].sda_thdlst[td_priority].tdl_lsth

krlnew_user_thread_core：
A、krlnew分配应用程序栈空间
B、krlnew分配内核栈空间
C、krlnew_thread_dsc建立thread_t结构体的实例变量，并初始化
D、设置进程权限，优先级，进程的内核栈顶和内核栈开始地址，进程用户栈顶和内核栈开始地址
E、初始化进程的应用栈
F、加入进程调度系统，sschedcls.scls_schda[cpuid].sda_thdlst[td_priority].tdl_lsth

三、中断进程切换【以硬件中断为例】
A、定义了宏HARWINT，其中硬件中断分发器函数为hal_hwint_allocator
%macro HARWINT 1
    保存现场......
    mov rdi, %1
    mov rsi,rsp
    call hal_hwint_allocator
    恢复现场......
%endmacro

B、定义了各种硬件中断编号，比如hxi_hwint00，作为中断处理入口
ALIGN 16
hxi_hwint00:
    HARWINT (INT_VECTOR_IRQ0+0)

C、有硬件中断时
CPU 会根据中断门描述里的目标段选择子，进行必要的特权级切换；
特权级的切换就必须要切换栈，CPU 硬件会自己把当前 rsp 寄存器保存到内部的临时寄存器 tmprsp；
然后从 x64tss_t 结构体 【地址在GDT表，由 CPU 的 tr 寄存器指向】中找出对应的栈地址，装入 rsp 寄存器中；
接着，再把当前的 ss、tmprsp、rflags、cs、rip，依次压入当前 rsp 指向的栈中。

D、然后会先到达中断处理入口
保护现场
调用到硬件中断分发器函数hal_hwint_allocator
第一个参数为中断编号，在rdi
第二个参数为中断发生时的栈指针，在rsi
然后调用异常处理函数hal_do_hwint

E、hal_do_hwint
->调用中断回调函数hal_run_intflthandle
先获取中断异常表intfltdsc_t
然后调用intfltdsc_t.i_serlist 链表上，所有挂载intserdsc_t 结构中的，中断处理的回调函数，让函数自行判断是否处理中断
->中断处理完毕后调用krlsched_chkneed_pmptsched
->->一路返回，直到中断处理入口，还原现场，继续执行
->->或者调用krlschedul，继续进行调度，其实就可以返回用户态了

```