## sed

作用于一整行的处理

### 基本使用

```bash
# case-6 在第4行之后加上 “drink tea” 字样(新添加多行行)
nl 24test.txt | sed '4a drink tea \
又是 tea'

# case-7 第[2,5]行换成 "No 2~5 number"
nl 24test.txt | sed '2,5c No 2~5 number'

# case s命令，替换内容
echo "this is a dog" | sed 's/dog/cat/'

# case 从文件中读取编辑命令
sed -f script.sed target.txt

# case 命令行执行多个命令 -e参数和";"分隔符
echo "this is a dog" | sed -e 's/dog/cat/ ; s/this/that/'

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

### 初识sed

```bash

# ************************* 替换（substitute） *************************

# 四种替换标记：  数字，g，p，w file
cat 28test.txt | sed 's/半年/未来一年/'  # 默认替换第一个
cat 28test.txt | sed 's/半年/未来一年/2'  # 替换第二个
cat 28test.txt | sed 's/半年/未来一年/g'  # 替换所有
cat 28test.txt | sed 's/格力/特斯拉/p'    # 打印原先行内容
cat 28test.txt | sed -n 's/格力/特斯拉/p'  # 只输出被替换修改过的行
cat 28test.txt | sed 's/格力/特斯拉/w 28output.txt' # 将包含匹配模式的行输出到指定文件

# 替换字符 没懂 question

# 使用地址（行寻址）： 用数字表示行区间，用文本模式(可以用正则表达式 ！！！！！ question)来过滤行
cat 28test.txt  | sed '2s/2021/2222/' # 只修改第二行
cat 28test.txt  | sed '1,2s/2021/2222/' # 修改第一行到第二行
cat 28test.txt  | sed '2,$s/2021/2222/' # 修改第二行开始的所有行

cat 28test.txt | sed '/格力/s/2021/22222/'

# 命令组合
 cat 28test.txt | sed '2,${s/格力/苹果/;s/特斯拉/亚马逊/}' # 用花括号将多条命令组合，在一组命令前制定一个地址区间


# ************************* 删除 *************************
cat 28test.txt | sed 'd'  # 删除所有行
cat 28test.txt | sed '2d'  # 删除某一行
cat 28test.txt | sed '2,3d'  # 删除区间
cat 28test.txt | sed '3,$d'  # 删除某一行开始到结尾
cat 28test.txt | sed '/number 1/d' # 模式匹配
cat 28test.txt | sed '/2/,/3/d'  # 匹配模式删除某个区间范围内的。第一个模式匹配开始，第二个模式匹配结束。若匹配不到结尾，直接删除后面所有
cat 28test.txt | sed '/2/,/6/d'  # 匹配模式删除某个区间范围内的。匹配不到结尾，直接删除后面所有


# ************************* 插入（inset）和附加（append） 注意反斜线指定新行 *************************
cat 28test.txt | sed 'i\你好'  # 每一行之前插入内容
cat 28test.txt | sed '2i\你好'  # 某一行之前插入内容
cat 28test.txt | sed '$i\你好'
cat 28test.txt | sed 'a\你好'  # 每一行之后附加内容
cat 28test.txt | sed '2a\你好'  # 某一行之后附加内容
cat 28test.txt | sed '$a\你好'

 # 多行操作 
cat 28test.txt | sed '1i\你好\   
hello?\
haha'


# ************************* 修改行（change） *************************
cat 28test.txt | sed '$c\你好'  # 修改最后一行
cat 28test.txt | sed '/number 1/c\你好' # 用文本模式来寻址。修改任意匹配文本行（匹配了就修改）
cat 28test.txt | sed '2,3c\你好' # 用一行替换匹配的所有数据，而不是逐一修改

# ************************* 转换命令（transform） *************************
cat 28test.txt | sed 'y/123/abc/' # 进行一一映射，会全局替换


# ************************* 打印命令（print） （三个命令：p，=，l） *************************
cat 28test.txt | sed -n '/number 3/p'  # 只打印匹配的行
cat 28test.txt | sed -n '2,3p'
cat 28test.txt | sed -n '/3/{p;s/number/NUMBER/}' # 文本模式寻址，在执行两条命令（p，s）
cat 28test.txt | sed '=' # 打印行号
cat 28test.txt | sed -n '/number 3/{=;p}' # 文本模式寻址，在执行两条命令（p，=）

cat 28test.txt | sed 'l'  # 显示制表符换行符转义字符等


# ************************* sed处理文件 *************************
cat 28test.txt | sed '2,3w test.txt' # 写入文件，显示到STDOUT
cat 28test.txt | sed -n '2,3w test.txt' # 写入文件，不显示到STDOUT
cat 28test.txt | sed '3r test.txt' # 读取文件，插入到某指定地址之后
cat 28test.txt | sed '/number 3/r test.txt' # 文本模式寻址
cat 28test.txt | sed '$r test.txt' # 尾巴插入


cat 28test.txt | sed '/LIST/{r test.txt; d}' # question 删除替换 命令有问题
cat 28test.txt | sed '/LIST/r test.txt; d' # 这样就对了。用花括号将多条命令组合（应该是这个问题） 

```


### sed进阶

```bash

# ************************* 多行命令（P，N，D） *************************

# 单行版next命令 *************************
cat 28test.txt | sed '/^$/d' # 删除空白行
cat 28test.txt | sed '/header/{n;d}' # 删除首行之后的空白行，保留其他空白行
 
# 多行版next命令 ************************* 
# question 如何查看 文件中所有的字符 包括不可显示的内容
cat 28test.txt  | sed '/first/{N; s/\n/ /}' # 找到目标行，将下一行合并，然后用空格替换换行
cat 28test.txt | sed 'N; s/Leborn.James/Keven Durant/' # question 替换跨行出现的内容 有问题（可能Leborn.James有问题， 大小写问题？）

# 多行删除命令 *******************
cat 28test.txt | sed '/^$/{N; /header/D}'  # 删除第一行前的空白行

# 多行打印命令 *******************
cat 28test.txt | sed -n 'N; /line\nfirst/P'


# ************************* 保持空间（还有模式空间） question 难理解 *************************
cat 28test.txt | sed -n '/first/{h;p;n;p;g;p}'  # question 不好理解 缓冲区？
cat 28test.txt | sed -n '/first/{h;n;p;g;p}'  # question 不好理解 缓冲区？

# 排除命令 ( ! ) *******************
cat 28test.txt | sed -n '/header/!p'
cat 28test.txt | sed '$!N; s/chang zheng/tang ping/; s/chang\nzheng/tang ping/' # 和之前（多行版next命令）的问题一样


# ************************* 翻转文本行的顺序 *************************
cat 28test.txt | sed -n '{1!G; h; $p}' # question 不好理解


# ************************* 改变流 *************************
# 分支（b）： 基于地址、模式、区间排除一整块命令 *******************
cat 28test.txt | sed '2,3b; s/this/That/; s/line/Test/' # 排除区间
# 使用标签跳转
cat 28test.txt | sed '/first/b jump1; s/this is/No jump on/; :jump1; s/this is/jump Here/' 

# 删除逗号，会无线循环 
echo "this, is, a, test, to, remove, commas." | sed -n '{:start; s/,//1p; b start}'
# 难以理解
echo "this, is, a, test, to, remove, commas." | sed -n '{:start; s/,//1p; /,/b start}'

# 测试（t） if-else *******************
cat 28test.txt | sed '{s/first/MATCHED/; t; s/this is/No match on/}'
# 用分支结束无限循环
echo "this, is, a, test, to, remove, commas." | sed -n '{:start; s/,//1p; t start}'

# 模式替代 *******************
echo "the cat sleep in his hat." | sed 's/.at/"&"/g'

# 替代单独的单词 *******************
echo "this System Admin manual" | sed 's/\(System\) Admin/\1 User/'
echo "that furry cat is pretty" | sed 's/furry \(.at\)/\1/'



# ************************* 在脚本中使用sed *************************
# ************************* sed实用工具 *************************






｀｀｀