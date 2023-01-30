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


### symbol数据结构

1. Elf64_Symbol (name,type,binding,section,value,size)

### 链接器工作原理

1. linker链接多个资源文件时，主要查symbols表
