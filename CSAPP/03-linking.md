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
12. 