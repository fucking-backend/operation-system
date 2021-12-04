```sh
一、整理一下内存结构
1、memmgrob_t中有kmsobmgrhed_t
2、kmsobmgrhed_t中有一个koblst_t数组【KOBLST_MAX个】，序号为n的koblst_t，存储全部实际长度为长度为32*（n+1）内存对象
3、每个koblst_t，都包括一个kmsob_t链表
4、kmsob_t结构如下：
结构体描述部分【
双向链表
扩展结构链表【kmbext_t】
空闲对象链表【freobjh_t】
已分配对象链表【freobjh_t】
占用内存页面管理结构【msomdc_t】
kmsob_t结构体页面链表【so_mc.mc_kmobinlst】
全部kmbext_t结构体页面链表【so_mc.mc_lst】
结构体起止地址
......
】
除结构体描述部分，都按相同大小划分为了内存对象【freobjh_t】

5、扩展管理kmbext_t，用于扩容
结构体描述部分{
双向链表
结构体起止地址
......
}
除结构体描述部分，都按相同大小划分为了内存对象【freobjh_t】

6、链表处理部分做的真漂亮！

二、分配内存
1、从memmgrob_t获取kmsobmgrhed_t，也就找到了koblst_t数组
2、根据申请内存对象大小，找到对应的koblst_t【第一个内存对象比需求大的koblst_t】
3、如果koblst_t中没有找到kmsob_t，则要初始化
A、按页申请内存【1、2或4页】
B、进行kmsob_t初始化工作，首先初始化描述部分
C、将之后的空间，按固定大小全部初始化为freobjh_t结构
D、把全部freobjh_t挂载到koblst_t的空闲列表中
E、然后将kmsob_t挂载到koblst_t结构中去

4、在kmsob_t中分配内存对象
4.1、首先判断kmsob_t是否有空闲对象可以分配
4.2、如果没有空闲对象可以分配，则尝试扩容，创建新的kmbext_t：：
A、申请内存【1、2或4页】
B、并进行初始化工作kmbext_t，首先初始化描述部分
C、将之后的空间，按固定大小全部初始化为freobjh_t结构
D、把内存页面记录到kmsob_t的页面列表中
E、把freobjh_t挂载到koblst_t的空闲列表中
F、把kmbext_t挂载到kmsob_t的扩展结构链表中
4.3、最后返回一个空闲内存对象，并从空闲列表中移除

5、更新kmsobmgrhed_t结构的信息
6、代码中还有各种加速，加锁解锁、校验代码，可以看下

三、释放内存
1、从memmgrob_t获取kmsobmgrhed_t，也就找到了koblst_t数组
2、根据申请内存对象大小，找到对应的koblst_t【第一个内存对象比需求大的koblst_t】
3、查找内存对象所属的kmsob_t结构
对于koblst_t中的每一个kmsob_t结构：
A、先检查内存对象的地址是否落在kmsob_t结构的地址区间
B、然后依次检测内存对象的地址是否落在kmsob_t的各个kmbext_t扩展结构的地址区间

4、释放内存对象，也就是将内存对象添加到空闲列表中

5、尝试销毁内存对象所在 kmsob_t结构
4.1、首先判断该kmsob_t全部内存对象都已释放
4.2、如果全部内存对象都已释放，则释放kmsob_t
A、将kmsob_t脱链
B、更新kmsobmgrhed_t结构的信息
C、遍历释放kmsob_t中全部扩展结构占用的内存页面【先脱链，再释放】
D、释放kmsob_t自身占用的全部页面【先脱链，再释放】

6、代码中还有各种加速，加锁解锁、校验代码，可以看下

最后，想问一下，koblst_t在什么情况下，会挂载多个kmsob_t呢？感觉内存对象不够用，就去补充kmbext_t了吧？
```