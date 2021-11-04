## workflow

1. grub启动后，选择对应的启动菜单项，grub会通过自带文件系统驱动，定位到对应的eki文件

2. grub会尝试加载eki文件【eki文件需要满足grub多协议引导头的格式要求】

这些是在imginithead.asm中实现的，所以要包括：

    A、grub文件头，包括魔数、grub1和grub2支持等
    B、定位的_start符号等

3. grub校验成功后，会调用_start，然跳转到_entry

    A、_entry中:关闭中断
    B、加载GDT
    C、然后进入_32bits_mode，清理寄存器，设置栈顶
    D、调用inithead_entry【C】

4. inithead_entry.c。 

    A、从imginithead.asm进入后，首先进入函数调用inithead_entry
    B、初始化光标，清屏
    C、从eki文件内部，找到initldrsve.bin文件，并分别拷贝到内存的指定物理地址
    D、从eki文件内部，找到initldrkrl.bin文件，并分别拷贝到内存的指定物理地址
    E、返回imginithead.asm

5. imginithead.asm中继续执行

    jmp 0x200000
    而这个位置，就是initldrkrl.bin在内存的位置ILDRKRL_PHYADR
    所以后面要执行initldrkrl.bin的内容

6. 这样就到了ldrkrl32.asm的_entry（C 语言环境下调用 BIOS 中断）

    A、将GDT加载到GDTR寄存器【内存】
    B、将IDT加载到IDTR寄存器【中断】
    C、跳转到_32bits_mode
    初始寄存器
    初始化栈
    调用 ldrkrl_entry【C】方法，在ldrkrlentry.c中

7. ldrkrlentry.c

    A、初始化光标，清屏
    B、收集机器参数init_bstartparm【C】

8. bstartparm.c

    A、初始化machbstart_t
    B、各类初始化函数，填充machbstart_t的内容
    C、返回

9. ldrkrlentry.c

    A、返回

10. ldrkrl32.asm

    A、跳转到0x2000000地址继续执行


### question

    1. 这个inithead_entry后来为什么没有了
    2. initldrkrl.bin 做了些什么工作
