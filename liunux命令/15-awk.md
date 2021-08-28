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
```
### awk进阶

```bash
```