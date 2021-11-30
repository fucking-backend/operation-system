## workflow

```sh
[ hal_start ] --> [ init_hal ] --> [ init_krl ]
[ init_hal ] --> [ init_halplaltform ] --> [ move_img2maxpadr ] --> [ init_halmm ] --> [ init_halintupt ]
[ init_krl ] --> [ die ]
[ init_halplaltform ] --> [ init_machbstart ] --> [ init_bdvideo ]
[ init_halmm ] --> [ init_phymmarge ]
[ init_halintupt ] --> [ init_descriptor ] --> [ init_idt_descriptor ] --> [ init_intfltdsc ] --> [ init_i8259 ] --> [ i8259_enabled_line ]
```


```sh
一、HAL层调用链
hal_start()

A、先去处理HAL层的初始化
->init_hal()

->->init_halplaltform()初始化平台
->->->init_machbstart()
主要是把二级引导器建立的机器信息结构，复制到了hal层一份给内核使用，同时也为释放二级引导器占用内存做好准备。
其做法就是拷贝了一份mbsp到kmbsp，其中用到了虚拟地址转换hyadr_to_viradr
->->->init_bdvideo()
初始化图形机构
初始化BGA显卡 或 VBE图形显卡信息【函数指针的使用】
清空屏幕
找到"background.bmp"，并显示背景图片
->->->->hal_dspversion（）
输出版本号等信息【vsprintfk】
其中，用ret_charsinfo根据字体文件获取字符像素信息

->->move_img2maxpadr()
将移动initldrsve.bin到最大地址

->->init_halmm()初始化内存
->->->init_phymmarge
申请phymmarge_t内存
根据 e820map_t 结构数组，复制数据到phymmarge_t 结构数组
按内存开始地址进行排序

->->init_halintupt();初始化中断
->->->init_descriptor();初始化GDT描述符x64_gdt
->->->init_idt_descriptor();初始化IDT描述符x64_idt，绑定了中断编号及中断处理函数
->->->init_intfltdsc();初始化中断异常表machintflt，拷贝了中断相关信息
->->->init_i8259();初始化8529芯片中断
->->->i8259_enabled_line(0);好像是取消mask，开启中断请求

最后，跳转去处理内核初始化
->init_krl()

二、中断调用链，以硬件中断为例
A、kernel.inc中，通过宏定义，进行了中断定义。以硬件中断为例，可以在kernel.inc中看到：
宏为HARWINT，硬件中断分发器函数为hal_hwint_allocator
%macro HARWINT 1
    保存现场......
    mov rdi, %1
    mov rsi,rsp
    call hal_hwint_allocator
    恢复现场......
%endmacro

B、而在kernel.asm中，定义了各种硬件中断编号，比如hxi_hwint00，作为中断处理入口
ALIGN 16
hxi_hwint00:
    HARWINT (INT_VECTOR_IRQ0+0)

C、有硬件中断时，会先到达中断处理入口，然后调用到硬件中断分发器函数hal_hwint_allocator
第一个参数为中断编号，在rdi
第二个参数为中断发生时的栈指针，在rsi
然后调用异常处理函数hal_do_hwint

D、hal_do_hwint
加锁
调用中断回调函数hal_run_intflthandle
释放锁

E、hal_run_intflthandle
先获取中断异常表machintflt
然后调用i_serlist 链表上所有挂载intserdsc_t 结构中的中断处理的回调函数，是否处理由函数自己判断

F、中断处理完毕

G、异常处理类似，只是触发源头不太一样而已
```