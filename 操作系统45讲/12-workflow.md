## workflow


```sh
1、bstartparm.c从init_bstartparm函数开始
    A、初始化machbstart_t

2、检查CPU。跳转到chkcpmm.c的init_chkcpu函数，检查是否支持CPUID功能
    A、init_chkcpu函数
        CPU自带检查方式：无法反转 Eflags第21位，表示CPU支持CPUID功能
        如果反转成功，说明不支持CPUID，打印内核错误并退出
    B、然后调用CPUID功能，判断是否支持长模式
        先通过通过0x80000000参数，调用cpuid命令，判断CPU是否支持扩展处理器信息【返回值比0x80000000大】
        如果支持，通过0x80000001参数，调用cpuid命令，获取扩展处理器信息，然后检测第29位，判断是否支持长模式
        如果不支持，打印内核错误并退出
    C、设置mbsp中cpumode为64位

3、获取内存布局。返回chkcpmm.c，继续检测内存信息
    A、跳转到chkcpmm.c的init_mem函数
    B、通过mmap调用realadr_call_entry(RLINTNR(0),0,0)
    C、实际会执行ldrkrl32.asm的realadr_call_entry
    D、跳转到save_eip_jmp
    E、最后在cpmty_mode处，把 0x18：0x1000 [段描述索引：段内的偏移]，装入到 CS：EIP 寄存器中
    F、而EIP这个地址恰恰是内存中initldrsve.bin的位置，因为之前write_realintsvefile把数据加载到了REALDRV_PHYADR 0x1000【而且在initldrsve.lds好像也指定了段内偏移0x1000】
    同时CS中段描述符为k16cd_dsc，说明是16位代码段，可以执行，CPU继续从EIP地址执行
    G、而initldrsve.bin是由realintsve.asm编译得到的，所以实际会继续执行realintsve.asm中代码
    H、然后到real_entry这里，通过传入的参数ax，判断调用func_table哪个方法
    当前参数位0，ax就是0，也就是调用了func_table的第一个函数_getmmap
    I、_getmmap中，通过BIOS的15h中断，获取内存信息
    J、检查内存信息，如果小于128M，打印内核错误并退出
    K、设置machbstart_t内存相关参数
    L、然后调用了init_acpi

4、在init_acpi中
    通过“RSD PTR ”及校验，判断是否支持ACPI功能
    不支持则 打印内核错误并退出

5、返回到bstartparm.c
    好像是确认了一下initldrsve.bin的状态，获取了一下文件内存地址及大小

6、返回到bstartparm.c，继续调用到chkcpmm.c的init_krlinitstack函数（初始化内核栈）

7、然后调用到了fs.c的move_krlimg函数
    首先判断新申请的地址，是否可用
    -》如果可用直接使用
    -》如果不可用，则判断申请的内存大小是否超出设备物理大小
    -》-》如果超出大小，系统打印内核错误并退出
    -》-》如果不超出大小，系统会将内存对齐到0x1000后，将initldrsve.bin移动到新位置，并修正地址
    整体来说move_krlimg更像是申请内存，但不知道为何要不断驱赶initldrsve.bin文件

8、返回到chkcpmm.c
    初始化栈顶和栈大小

9、返回到bstartparm.c
    调用fs.c的init_krlfile函数（放置内核文件与字库文件），将Cosmos.eki加载到了IMGKRNL_PHYADR
    并填写了mbsp相关内容

10、返回到bstartparm.c
    调用了chkcpmm.c的init_meme820函数
    然后调用到了fs.c的move_krlimg函数申请了内存，拷贝了一份e820map_t到Cosmos.eki之后的地址，并修正mbsp指向新地址
    感觉和内存保护 或 物理地址与虚拟地址之间转换有一定关系


11、返回到bstartparm.c
    调用了chkcpmm.c的init_bstartpages（建立MMU页表数据）

12、然后调用到了fs.c的move_krlimg函数申请了内存，建立了MMU页表：
    顶级页目录，开始于0x1000000
    页目录指针目录，开始于0x1001000，，共16项 ，其中每一项都指向一个页目录
    页目录，开始于0x1002000， 每页指向512 个物理页，每页2MB【 0x200000】

    让物理地址p[0]和虚拟地址p[((KRNL_VIRTUAL_ADDRESS_START) >> KPML4_SHIFT) & 0x1ff]，指向同一个页目录指针页，确保内核在启动初期，虚拟地址和物理地址要保持相同
    没搞清楚为什么虚拟地址是这个，也暂时没搞清楚为何要指向(u64_t)((u32_t)pdpte | KPML4_RW | KPML4_P)

    最后，把页表首地址保存在机器信息结构中

13、返回到bstartparm.c
    调用了graph.c的init_graph（设置图形模式）
    A、初始化了数据结构

    B、调用init_bgadevice
    首先获取GBA设备ID
    检查设备最大分辨率
    设置显示参数，并将参数保存到mbsp结构中

    C、如果不是图形模式，要通过BIOS中断进行切换，设置显示参数，并将参数保存到mbsp结构中：
    获取VBE模式，通过BIOS中断
    获取一个具体VBE模式的信息，通过BIOS中断
    设置VBE模式，通过BIOS中断
    这三个方法同样用到了realadr_call_entry，调用路径与上面_getmmap类似，不再展开

    D、初始化了一块儿内存
    感觉会与物理地址与虚拟地址之间转换由一定关系

    E、进行logo显示
    调用get_file_rpadrandsz定位到位图文件
    调用bmp_print，读入像素点，BGRA转换
    最后调用write_pixcolor，写入到mbsp->mb_ghparm正确的位置，图像就显示出来了

14、然后一路返回
    到bstartparm.c的init_bstartparm
    到ldrkrlentry.c的ldrkrl_entry
    到ldrkrl32.asm的call ldrkrl_entry
    再往下是jmp 0x2000000
    这个地址就是IMGKRNL_PHYADR，就是刚才放Cosmos.eki的位置

15、然后就接上了本节最后一部分内容了，不容易啊！哈哈哈！
    Cosmos.bin中【前面写错为Cosmos.eki了】，ld设置的程序入口为init_entry.asm的_start:

16、 init_entry.asm中_start:
    A、关闭中断
    B、通过LGDT命令，指定长度和初始位置，加载GDT
    C、设置页表，开启PAE【CR4第五位设置为1】，将页表顶级目录放入CR3
    D、读取EFER，将第八位设置为1，写回EFER，设置为长模式
    E、开启保护模式【CR0第0位设置为1】，开启分页【CR0第31位设置为1】，开启CACHE【CR0第30位设置为0】，开启WriteThrough【CR0第29位设置为0】
    F、初始化寄存器们
    G、将之前复制到Cosmos.bin之后的mbsp地址，放入rsp
    H、0入栈，0x8入栈， hal_start 函数地址入栈
    I、调用机器指令“0xcb48”，做一个“返回”操作，同时从栈中弹出两个数据[0x8：hal_start 函数地址]，到[CS：RIP]
    长模式下，指令寄存器为RIP，也就是说下一个指令为hal_start 函数地址
    CS中为0x8，对应到ekrnl_c64_dsc，对应到内核代码段，可以执行，CPU继续冲RIP地址执行

17、hal_start.c
    A、执行hal_start函数

```