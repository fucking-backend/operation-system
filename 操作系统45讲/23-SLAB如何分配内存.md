## SLAB如何分配内存

Linux 系统中，比页更小的内存对象要怎样分配呢？

### 什么是SLAB

何为 SLAB 对象？在 SLAB 分配器中，它把一个内存页面或者一组连续的内存页面，划分成大小相同的块，其中这一个小的内存块就是 SLAB 对象，但是这一组连续的内存页面中不只是 SLAB 对象，还有 SLAB 管理头和着色区。

### 第一个 kmem_cache
### 管理 kmem_cache
### SLAB 分配对象的过程
### SLAB 分配接口
### 如何查找 kmem_cache 结构
### 分配对象
### 思考题

Linux 的 SLAB，使用 kmalloc 函数能分配多大的内存对象呢？

### question

为什么SLAB这么设计

```sh
一、数据结构
系统有一个全局kmem_cache_node数组，每一个kmem_cache_node结构，对应一个内存节点

kmem_cache_node结构，用三个链表管理内存节点的全部kmem_cache【slab管理结构】，包括：
slabs_partial，对象部分已分配的kmem_cache结构；
slabs_full，对象全部已分配的kmem_cache结构；
slabs_free ，对象全部空闲kmem_cache结构；

kmem_cache结构，slab管理头，包括：
array_cache，每个CPU一个，用于管理空闲对象。 array_cache的entry数组，用于管理这些空闲对象，出入遵循LIFO原则；
num，表示对象个数；
gfporder，表示页面的大小 (2^n)；
colour，表示着色区大小。着色区，主要利用SLAB划分对象剩余的空间，让SLAB前面的几个对象，根据cache line大小进行偏移，以缓解缓存过热的问题，防止Cache地址争用，防止引起Cache抖动；

此外，全局有一个slab_caches链表中，记录了系统中全部的slab

二、初始化
全局有一个kmem_cache结构，kmem_cache_boot，用于初始化
全局有一个kmem_cache_node数组结构init_kmem_cache_node，用于初始化

x86_64_start_kernel->x86_64_start_reservations->start_kernel->mm_init -> kmem_cache_init
1、将变量kmem_cache指向静态变量kmem_cache_boot
2、初始化全局的init_kmem_cache_node结构
3、调用create_boot_cache，初始化kmem_cache_boot结构
4、将kmem_cache_boot其加入全局slab_caches链表中
5、调用create_kmalloc_cache，建立第一个kmem_cache，供kmalloc函数使用
6、调用init_list函数，将静态init_kmem_cache_node，替换为用kmalloc生成的kmem_cache_node
7、 调用create_kmalloc_caches，创建并初始化了全部 kmalloc_caches中的kmem_cache
路径为：kmem_cache_init->create_kmalloc_caches-> new_kmalloc_cache-> create_kmalloc_cache

三、对象分配
kmalloc->__kmalloc->__do_kmalloc
->kmalloc_slab
从kmalloc_caches中，根据类型和大小，找到对应的 kmem_cache
->slab_alloc->__do_cache_alloc->____cache_alloc
1、第一级分配，如果array_cache.entry中有空闲对象，直接分配
2、如果一级分配失败，调用cache_alloc_refill，进行第二级分配
->->cache_alloc_refill从全局的slab中进行refill
1、如果没有空闲对象，而且shared arry没有共享对象可用，需要扩容
2、如果shared arry有空闲对象，直接分配，否则继续
3、尝试从kmem_cache_node结构中其它kmem_cache获取slab页面
4、如果都失败了就扩容

如果一、二级分配都失败了，那就扩容，并进行第三级分配：
1、再次尝试在不扩容情况下，分配新的kmem_cache并初始化，如果成功就返回
2、调用cache_grow_begin 函数，找伙伴系统分配新的内存页面，找第一个 kmem_cache 分配新的对象，来存放 kmem_cache 结构的实例变量，并进行必要的初始化
3、调用 cache_grow_end 函数，把这页面挂载到 kmem_cache_node 结构的空闲链表中
4、返回一个空闲对象

四、对象回收
kfree->__cache_free->___cache_free->__free_one
将对象清空后，还给了CPU的对应的array_cache
```
