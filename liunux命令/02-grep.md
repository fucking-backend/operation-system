## grep

### 基本使用

```bash

# case-1 在文件中查找模式（单词）
grep linuxtechi /etc/passwd

# case-2 在多个文件中查找模式
grep linuxtechi /etc/passwd /etc/shadow /etc/gshadow

# case-3 使用-L参数列出包含指定模式的文件的文件名
grep -l linuxtechi /etc/passwd /etc/shadow /etc/fstab

# case-4 使用-N参数，在文件中查找指定模式并显示匹配行的行号
grep -n linuxtechi /etc/passwd

# case-5 使用-V参数输出不包含指定模式的行
grep -v linuxtechi /etc/passwd

# case-6 使用 ^ 符号输出所有以某指定模式开头的行
grep ^root /etc/passwd

# case-7 使用 $ 符号输出所有以指定模式结尾的行
grep bash$ /etc/passwd

# case-8 使用 -R 参数递归地查找特定模式
grep -r linuxtechi /etc/

# case-9  使用 Grep 查找文件中所有的空行
grep ^$ /etc/shadow

# case-10 使用 -i 参数查找模式。grep命令的-i参数在查找时忽略字符的大小写
grep -i LinuxTechi /etc/passwd

# case-11 使用 -E 参数查找多个模式
grep -e "linuxtechi" -e "root" /etc/passwd

# case-12 使用 -F 用文件指定待查找的模式
grep -f grep_pattern /etc/passwd

# case-13 使用 -C 参数计算模式匹配到的数量 question 😅😅😅😅 有问题
grep -c -f grep_pattern /etc/passwd

# case-14 输出匹配指定模式行的前或者后面N行
grep -B 4"games" /etc/passwd # 使用-B参数输出匹配行的前4行
grep -A 4"games" /etc/passwd # 使用-A参数输出匹配行的后4行
grep -C 4"games" /etc/passwd # 使用-C参数输出匹配行的前后各4行

```