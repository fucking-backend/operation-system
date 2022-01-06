```sh

二、文件系统初始化
1、文件系统本身是个驱动，同样需要把驱动放到全局驱动列表中
osdrvetytabl={systick_entry,rfs_entry,NULL}

2、从而，让系统启动时自动加载驱动
hal_start->init_krl->init_krldriver->rfs_entry
new_device_dsc，分配内存
new_rfsdevext_mmblk，分配设备内存
krldev_add_driver，处理驱动
krlnew_device，处理设备
init_rfs->rfs_fmat，初始化文件系统

3、其中，主要逻辑是在rfs_fmat中实现的：
A、create_superblk->rfssublk_t_init->rfsdir_t_init，创建超级块。其中初始化超级块时可以看到：
超级块在第0个逻辑块，位图在第1个逻辑块，根目录为空
B、create_bitmap
标记前3个逻辑块为已占用，后续逻辑块为可用
C、create_rootdir
一方面在超级块中标明，根目录在第2块
另一方面，对根目录进行初始化，写入 fimgrhd_t文件管理头，后续有文件就要在这个文件管理头后面依次增加rfsdir_t结构

三、逻辑块使用
1、申请逻辑块
A、读取超级块，从而定位到位图块
B、读取位图块
C、位图中找到第一个可用逻辑块，并设置为使用，并返回该字节对应的逻辑块号

2、归还逻辑块
A、读取超级块，从而定位到位图块
B、读取位图块
C、位图中找到对应的逻辑块，并设置为空闲

```