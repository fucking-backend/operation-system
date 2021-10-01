## awk\gawk

将一行分成数个字段处理

### awk

```bash
# case-1  通过print将每一行的第一列和第三列打印
nl 24test.txt | awk '{print $1 "\t" $3}'

# case-2 awk 内置变量 NR当前第几行， NF当前行有几个字段， FS指定分隔符（默认为空格）
nl 24test.txt | awk '{print $1 "\t lines:" NR "\t columns: " NF }'

# case-3 awk运算符
cat /etc/passwd | awk '{FS=":"} $3<10 {print $1 "\t" $3}'

# case-4 预先设置awk 变量  😅😅😅😅😅😅
cat /etc/passwd | awk 'BEGIN {FS=":"} $3<10 {print $1 "\t" $3}'


# case-5 多个辅助命令用 "；" 隔开
 cat pay.txt | awk 'NR==1{printf "%10s  %10s  %10s  %10s %10s\n",$1,$2,$3,$4,"Total"}; NR>=2{total=$2+$3+$4;  printf "%10s  %10d  %10d  %10d %10.2f\n",$1,$2,$3,$4,total}'

# case-1 
# case-1 
# case-1 
```

### 初识awk

```bash
# 使用数字字段变量
echo "this is Leborn James" | awk '{print $3 "\t" $4}'

# -F 指定分隔符
awk -F: '{print $1}' /etc/passwd

# 脚本中使用多个命令
echo "this is Leborn James" | awk '{$1="THIS"; print $0}'

# 从文件中读取脚本 -f指定文件
# script.wak：  {print $1 "'s home dict is" $6}  
awk -F: -f script.wak /etc/passwd

# 文件中制定多条命令，无须分号分割
# {
#	desc = "'s home dict is"
#	print $1 desc $6
# }
awk -F: -f script.wak /etc/passwd

# 处理数据前后运行脚本（BEGIN END关键字）
 echo "this is Leborn James" | awk 'BEGIN{print "hello world"} {print $3 "\t" $4} END{print "完结撒花"}'

```

### awk进阶( TODO )

```bash

```