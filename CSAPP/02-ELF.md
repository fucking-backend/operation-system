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
2. Executable，Shared library，Object file
3. Segments（为执行runtime，执行视图，会被真正加载到内存），Sections（为link做准备，库文件）
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

【ELF Header】、【Program Header】

