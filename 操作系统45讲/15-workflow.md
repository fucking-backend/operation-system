```sh

Grub在/boot目录下找到的linux内核，是bzImage格式
1、bzImage格式生成：
1.1、head_64.S+其他源文件->编译-> vmlinux【A】
1.2、objcopy工具拷贝【 拷贝时，删除了文件中“.comment”段，符号表和重定位表】->vmlinux.bin【A】
1.3、gzib压缩->vmlinux.bin.gz
1.4、piggy打包，附加解压信息->piggy.o->其他.o文件一起链接->vmlinux【B】
1.5、objcopy工具拷贝【 拷贝时，删除了文件中“.comment”段，符号表和重定位表】->vmlinux【B】
1.6、head.S +main.c+其他->setup.bin
1.7、setup.bin+vmlinux.bin【B】->bzImage合并->bzImage

2、GRUB加载bzImage文件
2.1、会将bzImage的setup.bin加载到内存地址0x90000 处
2.2、把vmlinuz中的vmlinux.bin部分，加载到1MB 开始的内存地址

3、GRUB会继续执行setup.bin代码，入口在header.S【arch/x86/boot/header.S】
GRUB会填充linux内核的一个setup_header结构，将内核启动需要的信息，写入到内核中对应位置，而且GRUB自身也维护了一个相似的结构。
Header.S文件中从start_of_setup开始，其实就是这个setup_header的结构。
此外， bootparam.h有这个结构的C语言定义，会从Header.S中把数据拷贝到结构体中，方便后续使用。

4、GRUB然后会跳转到 0x90200开始执行【恰好跳过了最开始512 字节的 bootsector】，正好是head.S的_start这个位置；

5、在head.S最后，调用main函数继续执行

6、main函数【 arch/x86/boot/main.c】【16 位实模式】
6.1、拷贝header.S中setup_header结构，到boot_params【arch\x86\include\uapi\asm\bootparam.h】
6.2、调用BIOS中断，进行初始化设置，包括console、堆、CPU模式、内存、键盘、APM、显卡模式等
6.3、调用go_to_protected_mode进入保护模式

7、 go_to_protected_mode函数【 arch/x86/boot/pm.c】
7.1、安装实模式切换钩子
7.2、启用1M以上内存
7.3、设置中断描述符表IDT
7.4、设置全局描述符表GDT
7.4、protected_mode_jump，跳转到boot_params.hdr.code32_start【保护模式下，长跳转，地址为 0x100000】

8、恰好是vmlinux.bin在内存中的位置，通过这一跳转，正式进入vmlinux.bin

9、startup_32【 arch/x86/boot/compressed/head64.S】
全局描述符GDT
加载段描述符
设置栈
检查CPU是否支持长模式
开启PAE
建立MMU【4级，4G】
开启长模式
段描述符和startup_64地址入栈
开启分页和保护模式
弹出段描述符和startup_64地址到CS：RIP中，进入长模式

10、 startup_64【 arch/x86/boot/compressed/head64.S】
初始化寄存器
初始化栈
调准给MMU级别
压缩内核移动到Buffer最后
调用.Lrelocated

11、.Lrelocated
申请内存
被解压数据开始地址
被解压数据长度
解压数据开始地址
解压后数据长度
调用 extract_kernel解压内核

12、extract_kernel解压内核【 arch/x86/boot/compressed/misc.c】
保存boot_params
解压内核
解析ELF，处理重定向， 把 vmlinux 中的指令段、数据段、BSS 段，根据 elf 中信息和要求放入特定的内存空间
返回了解压后内核地址，保存到%rax

13、返回到.Lrelocated继续执行
跳转到%rax【解压后内核地址】，继续执行
解压后的内核文件，入口函数为【arch/x86/kernel/head_64.S】



14、SYM_CODE_START_NOALIGN(startup_64)【arch/x86/kernel/head_64.S】
SMP 系统加电之后，总线仲裁机制会选出多个 CPU 中的一个 CPU，称为 BSP，也叫第一个 CPU。它负责让 BSP CPU 先启动，其它 CPU 则等待 BSP CPU 的唤醒。
第一个启动的 CPU，会跳转 secondary_startup_64 函数中 1 标号处，对于其它被唤醒的 CPU 则会直接执行 secondary_startup_64 函数。

15、secondary_startup_64 函数【arch/x86/kernel/head_64.S】
各类初始化工作，gdt、描述符等
跳转到initial_code，也就是x86_64_start_kernel

16、 x86_64_start_kernel【 arch/x86/kernel/head64.c】
各类初始化工作，清理bss段，清理页目录，复制引导信息等
调用x86_64_start_reservations

17、x86_64_start_reservations【 arch/x86/kernel/head64.c】
调用start_kernel();

18、start_kernel【 init/main.c】
各类初始化：ARCH、日志、陷阱门、内存、调度器、工作队列、RCU锁、Trace事件、IRQ中断、定时器、软中断、ACPI、fork、缓存、安全、pagecache、信号量、cpuset、cgroup等等
调用 arch_call_rest_init，调用到rest_init

19、rest_init【 init/main.c】
kernel_thread，调用_do_fork，创建了kernel_init进程，pid=1 . 是系统中所有其它用户进程的祖先
kernel_thread，调用_do_fork，创建了 kernel_thread进程，pid=2， 负责所有内核线程的调度和管理
【最后当前的进程， 会变成idle进程，pid=0】

20、kernel_init
根据内核启动参数，调用run_init_process，创建对应进程
调用try_to_run_init_process函数，尝试以 /sbin/init、/etc/init、/bin/init、/bin/sh 这些文件为可执行文件建立init进程，只要其中之一成功就可以

调用链如下：
try_to_run_init_process
run_init_process
kernel_execve
bprm_execve
exec_binprm
search_binary_handler-》依次尝试按各种可执行文件格式进行加载，而ELF的处理函数为 load_elf_binary
load_elf_binary
start_thread
start_thread_common，会将寄存器地址，设置为ELF启动地址
当从系统调用返回用户态时，init进程【1号进程】，就从ELF执行了

到此为止，系统的启动过程结束。
```