## sed


### 基本使用

```bash
# case-1 删除第2行
nl 24test.txt | sed '2d'

# case-2 删除 [2,5] 左右闭合区间之间的行
nl 24test.txt | sed '2,5d'

# case-3 删除 第3行之后(包括第3行)的行
nl 24test.txt | sed '2,$d'

# case-4 在第4行之后加上 “drink tea” 字样(新添加一行)
nl 24test.txt | sed '4a drink tea' 

# case-5 在第4行之前加上 “drink tea” 字样(新添加一行)
nl 24test.txt | sed '4i drink tea'

# case-6 在第4行之后加上 “drink tea” 字样(新添加多行行)
nl 24test.txt | sed '4a drink tea \
又是 tea'

# case-7 第[2,5]行换成 "No 2~5 number"
nl 24test.txt | sed '2,5c No 2~5 number'


# case-8 列出[7~9]行
nl 24test.txt | sed -n '7,9p'

# case-9 查找并替换 p359 😅😅😅😅😅😅

# case-10 sed 与正则表达式配合 p360  😅😅😅😅😅😅
# 只要存在MAN字样的行，删除#在内的批注，删除空白行
cat /etc/manpath.config | grep 'MAN' | sed 's/#.$//g' | sed '/^$/d'

# case-11 直接修改文件内容 $:最后一行 a:新增操作 i: 直接修改文件内容
sed -i '$a # this is a test' 24test.txt

# case-12 直接修改文件内容 将文件最后的 . 替换陈 !
sed -i 's/\.$/\!/g' 24test.txt

```