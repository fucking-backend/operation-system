```sh
一、整理一下结构
1、进程的内存地址空间用一个 mmadrsdsc_t结构表示
2、mmadrsdsc_t结构中包括一个virmemadrs_t结构，管理了进程全部kmvarsdsc_t结构【虚拟地址空间】
3、每个kmvarsdsc_t【虚拟地址空间】，都包括一个kvmemcbox_t结构【页面盒子】
4、每个kvmemcbox_t【页面盒子】，管理虚拟地址空间与物理内存页面的关系，并记录了物理内存页面对应的 msadsc_t 结构【页面】
5、每个msadsc_t结构，是一个页面
6、为了管理方便，操作系统有一个全局kvmemcboxmgr_t结构，统一管理全部kvmemcbox_t

二、虚拟地址空间分配
vma_new_vadrs
-> vma_new_vadrs_core
->-> vma_find_kmvarsdsc
1、查找合适的 kmvarsdsc_t结构
2、如果可以复用找到的kmvarsdsc_t结构，扩容
3、如果无法复用，创建新的kmvarsdsc_t结构，加入到 virmemadrs_t【按地址有序】

其中，vma_find_kmvarsdsc->vma_find_kmvarsdsc_is_ok的查找过程为
依次检查virmemadrs_t中全部 kmvarsdsc_t结构：
1、如果没有指定起始地址，则判断当前kmvarsdsc_t与下一个kmvarsdsc_t之间，是否有未分配的虚拟地址，长度满足要求
2、如果制定了起始地址，则判断当前kmvarsdsc_t与 下一个kmvarsdsc_t之间，，是否有未分配的虚拟地址，起始地址和长度都满足要求

三、虚拟地址空间释放
vma_del_vadrs
->vma_del_vadrs_core
->->vma_del_find_kmvarsdsc
根据起始地址，查找要释放虚拟地址空间的kmvarsdsc_t结构；
根据要释放的空间与kmvarsdsc_t结构起始地址有四种情况：
A、首位都相等，砍掉kmvarsdsc_t结构
B、开始相等，砍掉kmvarsdsc_t开始
C、结尾相等，砍掉kmvarsdsc_t结尾
D、首尾都不相等，砍掉中间部分，两边拆分为两个kmvarsdsc_t结构

四、缺页中断
应用程序访问没有分配页面的虚拟地址，触发缺页中断
SRFTFAULT_ECODE 14
->hal_fault_allocator异常分发
->->krluserspace_accessfailed->vma_map_fairvadrs->vma_map_fairvadrs_core缺页中断处理：
1、vma_map_find_kmvarsdsc找到对应的kmvarsdsc_t结构
2、vma_map_retn_kvmemcbox返回 kmvarsdsc_t 结构的 kvmemcbox_t 结构，没有就新建一个
3、vma_map_phyadrs->vma_map_msa_fault分配物理内存页面，并建立 MMU 页表映射关系
4、此时，应用程序就可以访问该虚拟地址了
```