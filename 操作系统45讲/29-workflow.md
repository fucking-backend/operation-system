```sh
一、数据结构
有一个全局的drventyexit_t数组变量osdrvetytabl，用于保存全部驱动程序入口函数
主要是为了便于理解，通过全局数组方式枚举并加载驱动，不需要涉及动态加载内核模块的相关内容

二、初始化
init_krl->init_krldriver
遍历驱动程序表中的每个驱动程序入口，并把它作为参数传给 krlrun_driverentry 函数

在krlrun_driverentry函数中
->new_driver_dsc->driver_t_init，初始化驱动结构，驱动处理函数默认指向drv_defalt_func
->drventry，调用驱动入口函数
->krldriver_add_system只需要将驱动加入设备表的驱动链表就好了

其中，在驱动入口函数drventry中【systick_entry为例】：
->建立设备描述符结构
->将驱动程序的功能函数指针，设置到driver_t结构中的drv_dipfun数组中
->将设备挂载到驱动中
->调用krlnew_device向内核注册设备
->->确认没有相同设备ID，注册到对应设备类型的列表以及全局设备列表

->调用krlnew_devhandle->krladd_irqhandle，安装中断回调函数systick_handle
->->获取设备中断phyiline对应的中断异常描述符intfltdsc_t结构中
->->新建一个intserdsc_t结构体
->->初始化结构体，并设置好回调函数
->->将新的intserdsc_t结构体挂载到对应的intfltdsc_t结构中
->->也就是把驱动程序的中断处理回到函数，加入到了对应中断处理回调函数链表中

->初始化物理设备
->启用中断
```