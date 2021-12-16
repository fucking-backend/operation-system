```sh
一、数据结构
有一个全局devtable_t结构变量osdevtable，用于管理全部驱动程序及设备，其中包括：
A、全局驱动程序链表，保存全部驱动【driver_t结构】
B、全局设备链表，包括各种设备类型的链表【devtlst_t结构】，每个devtlst_t中包括了某一类型的全部设备链表【device_t结构】

device_t用于描述一个设备，其中包括：
A、devid_t用于描述设备ID【包括设备类型、设备子类型、设备序列号等】
B、driver_t指针用于指向设备驱动程序，从设备可以找到驱动

driver_t用于描述一个驱动程序，其中包括：
A、驱动功能函数指针数组drivcallfun_t[]
B、包括使用该驱动程序的全部设备的列表，从驱动可以找到设备

二、驱动程序，函数有三类
设备中断处理函数
驱动入口和退出函数
驱动功能函数

三、初始化
init_krl->init_krldevice->devtable_t_init
->初始化全局设备列表
->初始化全局驱动列表
->对于每类设备，初始化devtlst_t结构
```