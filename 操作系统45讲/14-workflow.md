```sh

操作系统的启动分为两个阶段：引导boot和启动startup，本节主要还是boot过程：
BIOS->GRUG1->GRUB1.5->GRUB2->Linux内核【环境硬盘引导、MBR分区】

1、按电源键，系统加电

2、主板通电
CPU加电时，会默认设置[CS:IP]为[0XF000:0XFFF0]，根据实模式下寻址规则，CPU指向0XFFFF0
这个地址正是BIOS启动程序位置，而BIOS访问方式与内存一致，所以CPU可以直接读取命令并执行

3、BIOS执行
3.1、BIOS首先执行POST自检，包括主板、内存、外设等，遇到问题则报警并停止引导

3.2、BIOS对设备执行简单的初始化工作

3.3、BIOS 会在内存中：
建立中断表（0x00000~0x003FF）
构建 BIOS 数据区（0x00400~0x004FF）
加载了中断服务程序（0x0e05b~0x1005A）

3.4、BIOS根据设备启动顺序，依次判断是否可以启动
比如先检查光驱能否启动
然后依次检查硬盘是否可以启动【硬盘分区的时候，设置为活动分区】

4、硬盘引导
4.1、先说下寻址方式，与扇区编号的事情
最传统的磁盘寻址方式为CHS，由三个参数决定读取哪个扇区：磁头（Heads）、柱面(Cylinder)、扇区(Sector)
磁头数【8位】，从0开始，最大255【微软DOS系统，只能用255个】，决定了读取哪个盘片的哪个面【一盘两面】
柱面数【10位】，从0开始，最大1023【决定了读取哪个磁道，磁道无论长短都会划分为相同扇区数】
扇区数【6位】，从1开始，最大数 63【CHS中扇区从1开始，而逻辑划分中扇区从0开始，经常会造成很多误解】
每个扇区为512字节

4.2、然后说下引导方式
BIOS在发现硬盘启动标志后，BIOS会引发INT 19H中断
这个操作，会将MBR【逻辑0扇区】，也就是磁盘CHS【磁头0，柱面0，扇区1】，读取到内存[0:7C00h]，然后执行其代码【GRUB1阶段】，至此BIOS把主动权交给了GRUB1阶段代码
MBR扇区为512字节，扇区最后分区表至少需要66字节【64字节DPT+2字节引导标志】，所以这段代码最多只能有446字节，grub中对应的就是引导镜像boot.img
boot.img的任务就是，定位，并通过BIOS INT13中断读取1.5阶段代码，并运行

5、Grub1.5阶段
5.1、先说一下MBR GAP
据说微软DOS系统原因，第一个分区的起始逻辑扇区是63扇区，在MBR【0扇区】和分布表之间【63扇区】，存在62个空白扇区，共 31KB。
Grub1.5阶段代码就安装在这里。

5.2、上面提到，boot.img主要功能就是找到并加载Grub1.5阶段代码，并切换执行。
Grub1.5阶段代码是core.img，其主要功能就是加载文件系统驱动，挂载文件系统， 位加载并运行GRUB2阶段代码。
core.img包括多个映像和模块：
diskboot.img【1.5阶段引导程序】，存在于MBR GAP第一个扇区；【这里是硬盘启动的情况，如果是cd启动就会是cdboot.img】
lzma_decompress.img【解压程序】
kernel.img【grub核心代码】，会【压缩存放】
biosdisk.mod【磁盘驱动】、Part_msdos.mod【MBR分区支持】、Ext2.mod【EXT文件系统】等，会【压缩存放】

其实boot.img只加载了core.img的第一个扇区【存放diskboot.img】，然后控制权就交出去了，grub阶段1代码使命结束。
diskboot.img知道后续每个文件的位置，会继续通过BIOS中断读取扇区，加载余下的部分并转交控制权，包括：
加载lzma_decompress.img，从而可以解压被压缩的模块
加载kernel.img，并转交控制权给kernel.img
kernel.img的grub_main函数会调用grub_load_modules函数加载各个mod模块
加载各个mod后，grub就支持文件系统了，访问磁盘不需要再依靠BIOS的中断以扇区为单位读取了，终于可以使用文件系统了


6、GRUB2阶段
现在grub就能访问boot/grub及其子目录了
kernel.img接着调用grub_load_normal_mode加载normal模块
normal模块读取解析文件grub.cfg，查看有哪些命令，比如发现了linux、initrd这几个命令，需要linux模块
normal模块会根据command.lst，定位并加载用到的linux模块【一般在/boot/grub2/i386-pc目录】
当然，同时需要完成初始化显示、载入字体等工作
接下来Grub就会给咱们展示启动菜单了

7、选择启动菜单
7.1、引导协议
引导程序加载内核，前提是确定好数据交换方式，叫做引导协议，内核中引导协议相关部分的代码在arch/x86/boot/header.S中，内核会在这个文件中标明自己的对齐要求、是否可以重定位以及希望的加载地址等信息。同时也会预留空位，由引导加载程序在加载内核时填充，比如initramfs的加载位置和大小等信息。
引导加载程序和内核均为此定义了一个结构体linux_kernel_params，称为引导参数，用于参数设定。Grub会在把控制权移交给内核之前，填充好linux_kernel_params结构体。如果用户要通过grub向内核传递启动参数，即grub.cfg中linux后面的命令行参数。Grub也会把这部分信息关联到引导参数结构体中。

7.2、开始引导
Linux内核的相关文件位于/boot 目录下，文件名均带有前缀 vmlinuz。
咱们选择对应的菜单后，Grub会开始执行对应命令，定位、加载、初始化内核，并移交到内核继续执行。
调用linux模块中的linux命令，加载linux内核
调用linux模块中的initrd命令，填充initramfs信息，然后Grub会把控制权移交给内核。
内核此时开始执行，同时也就可以读取linux_kernel_params结构体的数据了
boot阶段结束，开始进入startup阶段。

```