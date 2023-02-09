### 链接

1. 链接可以用在三个时期： 编译期，加载期，运行时
2. 链接期存在的理由，分离编译
3. 为什么要学习链接过程
4. 连接器作用：符号解析，重定位
5. 目标文件（编译器汇编器产生）：可重定位文件，可执行文件，共享文件 
6. ELF格式：.text, .rodata, .data, .bss, .symtab, .rel.text, .rel.data, .debug, .line, .strtab
7. 符号和符号表，symtab中没有【本地局部变量】
8. c语言中作用域最小原则
9. symtab的数据结构 Elf64_Symbol；
10. 特殊的section： ABS，UND，COM
11. COMMON和.bss区别
12. 符号解析，undefined reference 链接期错误
13. 解析多重定义的情况，强、弱、类型， multiple definition
14. gee -fno-common（或者werror） 暴露重名问题，
15. extern定义变量

16. 与静态库链接，为什么有库（模块化），【.a】文件，静态库来源，
17. 静态链接器工作原理，需求先行（将库放在命令行结尾），循环引用的问题；连接器主要任务：重定位和符号解析
18. 重定位，计算内存的位置，相同的section合并，rela.data, rela.text
19. relocation entry， objdump -xd hello.o ，00占位符 objdump -reloc hello.o
20. Elf64_Rela， 绝对偏移，相对偏移
21. 重定位符号引用，将占位符修正为正确的引用地址，算法过程

22. 三种格式的ELF文件： 可执行目标文件，Executable的ELF文件（设计易加载到内存）；Relocation object file格式的ELF文件；共享文件
23. 段头表，为什么要有段，加载到内存中；entry point
24. readelf -l hello readelf -lW hello
25. 文件中的位置 filezs,off,  内存中的位置 vaddr,memsz, paddr, flags,align
26. 加载可执行目标文件，【加载过程】，memeory layout，懒处理懒加载 

27. 静态库静态链接存在的问题 
28. -shared控制链接过程， -fpic控制编译过程
29. 连接器ld是link editor，动态链接器是c语言解释器
30. dlopen 运行时修改依赖库，-rdynamic
31. 位置无关PIC代码如何实现
32. 【GOT】，【PLT】
33. 库打桩机制，类似dlopen；编译期打桩，链接期打桩，运行时打桩
34. 处理目标文件的工具  rpm -ql binutils