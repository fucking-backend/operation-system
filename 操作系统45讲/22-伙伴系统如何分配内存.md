## 伙伴系统如何分配内存

Linux 系统中，用来管理物理内存页面的**伙伴系统**，以及负责分配比页更小的内存对象的 **SLAB 分配器**了。

### 怎么表示一个页
### 怎么表示一个区
### 怎么表示一个内存节点
### 数据结构之间的关系
### 什么是伙伴
### 如何分配页面

    通过接口找到内存节点
    开始分配
    准备分配页面的参数
    快速分配路径
    慢速分配路径
    如何分配内存页面

### 思考题

在默认配置下，Linux 伙伴系统能分配多大的连续物理内存？

### question

```sh
一、整理一下思路
NUMA体系下，每个CPU都有自己直接管理的一部分内存，叫做内存节点【node】，CPU访问自己的内存节点速度，快于访问其他CPU的内存节点；
每个内存节点，按内存的迁移类型，被划分为多个内存区域【zone】；迁移类型包括ZONE_DMA、ZONE_DMA32、ZONE_NORMAL 、ZONE_HIGHMEM、ZONE_MOVABLE、ZONE_DEVICE等；
每个内存区域中，是一段逻辑上的连续内存，包括多个可用页面；但在这个连续内存中，同样有不能使用的地方，叫做内存空洞；在处理内存操作时，要避免掉到洞里；

二、整理一下结构
每个内存节点由一个pg_data_t结构来描述其内存布局；
每个pg_data_t有一个zone数组，包括了内存节点下的全部内存区域zone；
每个zone里有一个free_area数组【0-10】，其序号n的元素下面，挂载了全部的连续2^n页面【page】，也就是free_area【0-10】分别挂载了【1个页面，2个页面，直到1024个页面】
每个free_area，都有一个链表数组，按不同迁移类型，对所属页面【page】再次进行了划分

三、分配内存【只能按2^n页面申请】
alloc_pages->alloc_pages_current->__alloc_pages_nodemask
->get_page_from_freelist，快速分配路径，尝试直接分配内存
->__alloc_pages_slowpath，慢速分配路径，尝试回收、压缩后，再分配内存，如果有OOM风险则杀死进程->实际分配时仍会调用get_page_from_freelist
->->所以无论快慢路径，都会到rmqueue
->->->如果申请一个页面rmqueue_pcplist->__rmqueue_pcplist
1、如果pcplist不为空，则返回一个页面
2、如果pcplist为空，则申请一块内存后，再返回一个页面
->->->如果申请多个页面__rmqueue_smallest
1、首先要取得 current_order【指定页面长度】 对应的 free_area 区中 page
2、若没有，就继续增加 current_order【去找一个更大的页面】，直到最大的 MAX_ORDER
3、要是得到一组连续 page 的首地址，就对其脱链，然后调用expand函数对内存进行分割
->->->->expand 函数分割内存
1、expand分割内存时，也是从大到小的顺序去分割的
2、每一次都对半分割，挂载到对应的free_area，也就加入了伙伴系统
3、直到得到所需大小的页面，就是我们申请到的页面了

四、此外
1、在整个过程中，有一个水位_watermark的概念，其实就是用于控制内存区是否需要进行内存回收
2、申请内存时，会先按请求的 migratetype 从对应类型的page结构块中寻找，如果不成功，才会从其他 migratetype 的 page 结构块中分配， 降低内存碎片【rmqueue->__rmqueue->__rmqueue_fallback】
3、申请内存时，一般先在CPU所属内存节点申请；如果失败，再去其他内存节点申请；具体顺序，和NUMA memory policy有关；
```