## awk\gawk

将一行分成数个字段处理

### 30 Examples for Awk Command in Text Processing

```bash
# 1. Awk Options
awk options program file

# 2. Read AWK Scripts. 
# To define an awk script, use braces surrounded by single quotation marks
# question 这句不能执行，没有任何输出，为啥？
awk '{print "Welcome to awk command tutorial "}'


# 3. Using Variables。$0,$1,$2......
# The whitespace character like space or tab is the default separator between fields in awk.
# Sometimes the separator in some files is not space nor tab but something else. You can specify it using –F option:
awk -F: '{print $1}' /etc/passwd


# 4. Using Multiple Commands
# To run multiple commands, separate them with a semicolon
echo "hello world" | awk '{$2="mino";print $0}'


# 5. Reading The Script From a File
# You can type your awk script in a file and specify that file using the -f option.
awk -F: -f testfile /etc/passwd


# 6.  Awk Preprocessing
# If you need to create a title or a header for your result or so. You can use the BEGIN keyword to achieve this. It runs before processing the data
awk 'BEGIN {print "mino早呀"} {print $1 " home at " $6}' /etc/passwd


# 7. Awk Postprocessing
# To run a script after processing the data, use the END keyword:
awk 'BEGIN {print "mino早呀"} {print $1 " home at " $6} END {print "打完收工！"}' /etc/passwd

# F外部指定
awk -F: 'BEGIN { print "Users and thier corresponding home"; print " UserName \t HomePath"; print "___________ \t __________";}{ print $1 "  \t  " $6} END {print "The end"}' /etc/passwd

# F在BEGIN中指定
awk  'BEGIN {F=":"; print "Users and thier corresponding home"; print " UserName \t HomePath"; print "___________ \t __________";}{ print $1 "  \t  " $6} END {print "The end"}' /etc/passwd


# 8. Built-in Variables.内置变量
## （1）FIELDWIDTHS Specifies the field width.
## （2）RS Specifies the record separator.
## （3）FS Specifies the field separator.
## （4）OFS Specifies the Output separator.
## （5）ORS Specifies the Output separator.
awk 'BEGIN{FS=":"; OFS="======"} {print $1,$6,$7}' /etc/passwd
## question 这个FIELDWIDTHS没有效果
awk 'BEGIN{FIELDWIDTHS="3 4 3"}{print $1,$2,$3}' testfile


# 9. More Variables
## （1）ARGC Retrieves the number of passed parameters.
## （2）ARGV Retrieves the command line parameters.
## （3）ENVIRON Array of the shell environment variables and corresponding values.
## （4）FILENAME The file name that is processed by awk.
## （5）NF Fields count of the line being processed.
## （6）NR Retrieves total count of processed records.
## （7）FNR The record which is processed.
## （8）IGNORECASE To ignore the character case.



# 10. User Defined Variables

# 11. Structured Commands
# The awk scripting language supports if conditional statement


# 12. While Loop
# You can use the while loop to iterate over data with a condition.

# 13. The for Loop
# The awk scripting language supports the for loops:

# 14. Formatted Printing
# The printf command in awk allows you to print formatted output using format specifiers.
## （1）%[modifier]control-letter
## （2）This list shows the format specifiers you can use with printf:
## （3）c Prints numeric output as a string.
## （4）d Prints an integer value.
## （5）e Prints scientific numbers.
## （6）f Prints float values.
## （7）o Prints an octal value.
## （8）s Prints a text string.


# 15. Built-In Functions
# Mathematical Functions
# If you love math, you can use these functions in your awk scripts


# 16. String Functions


# 17. User Defined Functions


```

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