## Linux如何获取所有设备信息？

### Linux设备信息
### 数据结构
### 总线

**总线不仅仅是组织设备和驱动的容器，还是同类设备的共有功能的抽象层**

### 设备
### 驱动
### 文件操作函数

### 驱动程序实例
### 驱动程序框架
### 建立设备
### 打开、关闭和读写函数
### 测试驱动
### 思考题
### question


```sh
关于驱动程序Demo
一、miscdrv是一个内核模块
1、四个操作函数，封装在file_operations结构中，包括：
misc_open在打开设备文件时执行
misc_release在关闭设备文件时执行
misc_read在读取设备时执行
misc_write在写入设备时执行
file_operations又被封装在miscdevice中，在注册设备时传入

2、devicesinfo_bus_match函数用于总线设备的过滤，被封装在bus_type结构中
bus_type描述了总线结构，在总线注册时传入

3、module_init和module_exit声明入口和出口函数：
miscdrv_init注册设备和总线，在安装内核模块时执行
miscdrv_exit反注册设备和总线，在卸载内核模块时执行

4、只有misc_read比较复杂：
A、通过注册时的devicesinfo_bus获取kset，枚举kset中的每一个kobj
B、对于每个kobj，通过container_of转换为subsys_private
C、对于每个subsys_private，枚举其bus中每个设备，并通过misc_find_match函数进行处理
D、misc_find_match会在kmsg中输出设备名称

二、app.c
就是打开设备，写一下，读一下，关闭设备，主要是触发设备输出

三、执行顺序，需要两个Terminal，T1和T2
1、T1：make
2、T1：sudo insmod miscdrv.ko
3、T2：sudo cat /proc/kmsg
4、T1：sudo ./app
5、T2：ctrl+c
6、T1：sudo rmmod miscdrv.ko
```


```sh
关于数据结构
一、目录组织相关结构
kobject结构表示sysfs一个目录或者文件节点，同时提供了引用计数或生命周期管理相关功能；
kset结构，可以看作一类特殊的kobject，可以作为kobject的集合；同时承担了发送用户消息的功能；

Linux通过kobject和 kset来组织sysfs下的目录结构。但两者之间关系，却并非简单的文件和目录的关系。每个kobject的父节点，需要通过parent和kset两个属性来决定：
A、无parent、无kset，则将在sysfs的根目录（即/sys/）下创建目录；
B、无parent、有kset，则将在kset下创建目录；并将kobj加入kset.list；
C、有parent、无kset，则将在parent下创建目录；
D、有parent、有kset，则将在parent下创建目录，并将kobj加入kset.list；

kobject和kset并不会单独被使用，而是嵌入到其他结构中发挥作用。

二、总线与设备结构
bus_type结构，表示一个总线，其中 subsys_private中包括了kset；
device结构，表示一个设备，包括驱动指针、总线指针和kobject；
device_driver结构，表示一个驱动，其中 driver_private包括了kobject；
上面说的kset和kobject的目录组织关系，起始就是存在于这些数据结构中的；
通过kset和kobject就可以实现总线查找、设备查找等功能；

三、初始化
全局kset指针devices_kset管理所有设备
全局kset指针bus_kset管理所有总线

初始化调用链路：
kernel_init->kernel_init_freeable->do_basic_setup->driver_init
->devices_init设备初始化
->buses_init总线初始化

四、设备功能函数调用
miscdevice结构，表示一个杂项设备；
其中 file_operations包含了全部功能函数指针；

以打开一个设备文件为例，其调用链路为：
filp_open->file_open_name->do_filp_open->path_openat->do_o_path->vfs_open->do_dentry_open
通过file_operations获取了open函数指针，并进行了调用
```