## history


### 基本命令

```bash
# case-1 列出目前内存里所有history记忆
hsitory 

# case-2 列出最近的n条记录
history n


# case-3 立刻将当前的数据写入histfile中
history -w 

# case-4 输出系统存储的history命令行数1000
echo $HISTSIZE 

# case-5 系统存储的history命令
cat ./bash_history

# case-6 执行第几条命令 
!number 

# case-7 执行上一条命令
!!

# case-8 执行最近以×××开头的命令。比如刚执行 touch test.txt 命令
!tou

```

### 进阶

```bash

# case-1 使用 HISTTIMEFORMAT 显示时间戳
export HISTTIMEFORMAT='%F %T '
history | more


# case-2 搜索历史
使用 Ctrl+R 搜索历史


# case-3 快速重复执行上一条命令，【有四种方法】
1.使用上方向键，并回车执行。
2.按 !! 并回车执行。
3.输入 !-1 并回车执行。
4.按 Ctrl+P 并回车执行。


# case-4 从命令历史中执行一个指定的命令
!n #执行第n条命令

# case-5 通过指定关键字来执行以前的命令
!ps # 执行以ps开头的命令

# case-6 使用 HISTSIZE 控制历史命令记录的总行数
vi ~/.bash_profile
HISTSIZE=450
HISTFILESIZE=450


# case-7 使用 HISTFILE 更改历史文件名称
vi ~/.bash_profile
HISTFILE=/root/.commandline_warrior

# case-8 使用 HISTCONTROL 从命令历史中剔除连续重复的条目
export HISTCONTROL=ignoredups


# case-9 使用 HISTCONTROL 清除整个命令历史中的重复条目。 ignoredups 只能剔除连续的重复条目，要清除整个命令历史中的重复条目，可以将 HISTCONTROL 设置成 erasedups
export HISTCONTROL=erasedups

# case-10 使用 HISTCONTROL 强制 history 不记住特定的命令。将 HISTCONTROL 设置为 ignorespace，并在不想被记住的命令前面输入一个空格
export HISTCONTROL=ignorespace

# case-11 使用 -c 选项清除所有的命令历史（轻易不要执行 ！！！）
history -c

# case-12 命令替换 。（ !!:$ ）将为当前的命令获得上一条命令的参数
ls anaconda-ks.cfg
anaconda-ks.cfg
vi !!:$
vi anaconda-ks.cfg

# case-13 为特定的命令替换指定的参数 ( !cp:2  )  从命令历史中搜索以 cp 开头的命令，并获取它的第二项参数
cp ~/longname.txt /really/a/very/long/path/long-filename.txt
ls -l !cp:2
ls -l /really/a/very/long/path/long-filename.txt


# case-14 使用 HISTSIZE 禁用 history。 如果你想禁用 history，可以将 HISTSIZE 设置为 0


# case-15 使用 HISTIGNORE 忽略历史中的特定命令。例子，将忽略 pwd、ls、ls -ltr 等命令：
export HISTIGNORE=”pwd:ls:ls -ltr:”

```



### 问题

[mac 中 history 命令使用与配置](https://blog.csdn.net/testcs_dn/article/details/79970635)
