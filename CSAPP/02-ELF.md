### Executable and Linkable Format

1. c program memory layout
2. 如何得到 memory layout
3. 源码 -> 二进制 -> 加载
4. 编译链接的过程

### c program memory layout（内存中）

1. system
2. env argc argv
3. main
4. func
5. stack
6. 库文件
7. heap
8. 全局变量
9. 代码

### 编译链接过程

1. 《程序员的自我修养》
2. 链接器，加载，运行
3. 链接的过程，合并什么东西，symbols，谁找谁怎么找
4. symbols是什么
5. memory address，symbols，veriable/function
6. 局部变量和栈上的东西不能称之为symbol
7. 连接器基于symbol来合并文件 
8. symbol提供一种抽象，充当内存和变量之间的桥梁作用 

### elf格式（硬盘中）

1. text 代码
2. rodata 只读数据
3. data
4. bss （better save space 、block starting symbol），管理一些初始化且未赋值的值（int i ；bool b）
5. symtab 
6. rel.text 动态链接，解决函数symbol问题（placeholder）
7. rel.data 解决变量symbol问题
8. debug 调试用 gcc -g
9. line
10. strtab 字符串常量

11. symbol数据结构 Elf64_Symbol (name,type,binding,section,value,size)

### 链接器工作原理

1. linker链接多个资源文件时，主要查symbols表
2. 找到symbol
3. 运行时链接symbol

### ELF(Executable and Linkable Format)【磁盘文件】

1. 微软用exe,dll格式
2. Executable，Shared library动态链接库，Object file，coredump
3. Segments（【为执行runtime，执行视图，会被真正加载到内存】），Sections（【为link做准备，库文件】）
4. 可执行的文件，一定有Segments，可以没有Sections
5. 对于只能链接不能执行的文件，只有Sections，没有Segments
6. 静态链接（go，rust把所有的库文件依赖都打包），动态链接（打包必须的，其他以来部分引用library function of dynamically linked）
7. ldd命令
8. gcc -static 纯静态编译；gcc -shared
9. gcc -fno-pie -no-pie 固定入口pc位置

10. ELF Header 数据结构；Magic魔数，SYSV版本，GUN/Linux版本；e_type
11. readelf 命令
12. c语言解释器，解决load，link(类似于python解释器，不过作用不一样)

13. Program Header 数据结构（类似tcp头），用以描述Segments
14. readelf --segments； readelf -lW
15. Section to Segment mapping

16. Section Header 数据结构
17. SymbolTableEntry
18. Address指内存位置，Offset指elf文件中（硬盘中）的位置
19. readelf --sections

20. elf文件内容，物理上连续的片段，一些头（Program Header，Section Header），elf类似数据库，存储链接需要的信息
21. main函数之前做了哪些事，源码怎么变成可执行文件

【ELF Header】、【Program Header】、【Section Header】

### Symbol Resolution

1. [Executable and Linkable Format](https://en.wikipedia.org/wiki/Executable_and_Linkable_Format)
2. Program Header， Segment；【为执行runtime，执行视图，会被真正加载到内存】
3. Section Header； 【为link做准备，库文件】
4. ELF a Linux executable walkthrough
5. coredump文件
6. make 编译可执行文件、o文件、静态链接的文件、动态链接的文件； file查看文件；readelf -S -h -l -all -w； ldd查看依赖
7. Section Header
8. 为什么要静态依赖，分发部署方便
9. Dynamic Section作用；RPATH；init，main，fini；
10. Relocation Section；rela 
11. Symbol Table；dymsym（Dynamic symbol）
13. bss
14. 标准的可执行文件hello elf内容
15. objdump命令； -d(反汇编) -s -t
16. 文件中叫【偏移】，内存中叫【地址】
17. readelf，objdump


###  Symbol Resolution （没懂）

1. 什么是symbol: function，全局/局部变量
2. 函数名的意义
3. link editor
4. rela section
5. ls -lthr
6. 【rel.text】,【rel.data】 留白
7. 特殊的section类型：COMMON，UNDEF
8. 一个函数由一个lib提供（一对一）；一个函数多个lib提供（一对多）；
9. extern 类型
10. 弱symbol，强symbol
11. *((int*)&x) 
12. symbol中，一个强类型遇到一个弱类型的坑
13. dynamic


### linker连接器顺序问题

1. 程序生成阶段：compile编译，link链接，load装载和relocation，runtime
2. symbol供需关系。 
3. resolve解决匹配问题； relocation重定位
4. https://stackoverflow.com/questions/45135/why-does-the-order-in-which-libraries-are-linked-sometimes-cause-errors-in-gcc
5. link order: static; 
6. ar命令； gcc -L 编译的时候在当前目录搜索； ld ; gcc -Wl,as-needed; ld verbose; ld -T;gcc -Wl,-T; ldd 查看依赖； 
7. 【静态链接库】：需求在前main（rel.text中标记），供给在后sum
8. dynamic object，dynamic lib
9. gcc -fpic -shared, pic类似pie（编译器产生跟位置无关的代码）
10. ld --help | grep shared 
11. 编译期，链接期，运行期；不同的文件格式（o文件，c文件）处于不同的阶段
12. ld 环境变量 rpath rpath-link RD_RUN_PATH LD_LIBRARY_PATH
13. LD_LIBRARY_PATH=. ./main 当前命令生效; export LD_LIBRARY_PATH=. 当前shell生效 
14. 直接依赖和间接依赖的关系
15. ldd main; readelf -d main
16. rpath rpath-link(只在link期起作用)
17. patchelf --print-rpath
18. 学思想设计理念出发点（为什么这么做，有什么好处），看文档，读代码
19. [ELF_Format!!!!!!](http://www.skyfree.org/linux/references/ELF_Format.pdf)  【思想设计理念】
20. relocatable，executable，shared object; Linking View，Execution View; ELF Header，Section Header，Symbol Table，Relocation(rela)
21. /usr/include/elf.h 【代码】
22. man elf
23. objdump -d main.o，readelf -add main.o, rela在【静态链接】中的作用 解决占位符问题
24.  rela在【动态链接】中的作用， Dynamic Section 动态链接库是供给方；  rela.plt rela.dym rela表是需求方



### 可执行文件重定位 relocation

1. symbol resolution 知道供需关系
2. relocation 定位
3. creating an Executable，merge section；update symbol references to their correct runtime address
4. relocating code and data；Relocatable object file；Executable object file；
5. main 函数作用 ，start要引用main
6. readelf -s main.o 打印symbol； readelf -SW main.o; readelf -SW main；
7. objdump -d main.o 有占位符；readelf -r main.o； objdump -dx main.o
8. 在main.o中找变量array和函数sum （没懂）
9. 静态relocation问题

### 动态链接 dynamic link

1. static linking， link everything at build time
2. dynamic link， keep libraries in different files
3. 动态链接为什么存在有什么优势，部分更新、内存中只需要一份。fast、good、cheap三者只能取二
4. 动态链接需要三部分配合，编译链接时要提供足够的辅助信息，执行时需要装载器，动态调用时再去加载函数
5. 动态链接劣势，文件打碎分散开后，库找不到，库版本不对，符号不对
6. [cs361 UIC](https://www.cs.uic.edu/~ckanich/cs361/f20/)
7. Executable on disk(ELF),Executable in memory（memory layout）
8. Program header（加载到内存中时用到，是section的组合） ， Section header(elf中的最小单位，编译链接期用)
9. readelf -lW hello.out | less
10. .bss 

11. ELF header中Entry point address代表程序入口，第一条指令_start, 再执行libc_start_main
12. readelf -h hello ; objdump -Sd hello
13. [glibc](https://github.com/bminor/glibc), 启动流程，追踪如何调用main， call_init, atexit(fini)
14. init,fini,text构成代码区
15. libc_start_main -> _init -> main, init和fini的作用，profiling衡量性能
16. glibc在main启动之前做了哪些工作， ld过程，_start 

17. Shared vs Static
18. dynamic link challenge：shared memory如何放置shared library，此过程高度动态（position independent code）； 
19. 动态链接需要两步：linking（三步），理清供需关系；load time（三步）
20. 库之间symbol的问题分为变量和函数。Variables 临时变量【GOT表】，加一层解决问题； Functions 懒加载，第一次运行的时候加载，后续直接使用缓存， PLT（procedure Linkage Table过程链接表），代码区只读数据去可变

21. PTL过程：(1) 跳转到GOT (2) 将function ID压栈 (3) 跳转到PTL[0]
22. PTL[0]作用, dynamic linker
23. plt, got.plt
24. 

