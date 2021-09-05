### find基本使用

```bash
# 查找文件夹
find /path/to/search -type d -name "name-of-dir"

# 查找隐藏文件
find /path/to/search -name ".*"

# 查找特定大小的文件，或者大于某个大小，或者处于某个区间
# question 单位该怎么写
find /path/to/search -size +10M # 大于
find /path/to/search -size -10M # 小于
find /path/to/search -size +100M -size -1G # 某个区间

# 查找文件列表
find /path/to/search | grep -f filelist.txt
# 查找不在文件列表中的文件
find /path/to/search | grep -vf filelist.txt

# 设置最大查找深度
find . -maxdepth 0 -name "myfile.txt"

# 查找空文件和空文件夹
find /path/to/search -type f -empty
find /path/to/search -type d -empty
# 查找空文件夹并删除
find /path/to/search -type f -empty -delete  

# 查找最大一个或者文件或者文件夹。查找之后排序然后取开头或者末尾。 question printf什么作用
# 查找最大的文件
find /path/to/search -type f -printf "%s\t%p\n" | sort -n | tail -1
# 查找最小的五个文件夹 
find /path/to/search -type f -printf "%s\t%p\n" | sort -n | tail -5
# 查找最大的文件夹 
find /path/to/search -type d -printf "%s\t%p\n" | sort -n | tail -1


# 查找特殊权限的文件 question
find /path/to/search -user root -perm /4000
find /path/to/search -perm /2000
find /path/to/search -perm /6000


# List files without permission denied
# stderr 输出重定向到 stdout
find / -name "myfile.txt" 2>%1 | grep -v "Permission denied" 

# 查找最近 X 天内修改过的文件。和文件大小类似
find /path/to/search -type f -mtime -30
find /path/to/search -type f -mtime +30
find /path/to/search -type f -mtime 30
find /path/to/search -type f -mtime -30 -exec ls -l {} \;


# 要按文件的修改时间对 find 的结果进行排序
# 可以使用 -printf 选项以可排序的方式列出时间，并将该输出通过管道传输到排序实用程序。
find /path/to/search -printf "%T+\t%p\n" | sort
find /path/to/search -printf "%T+\t%p\n" | sort -r

```

### locate和find区别

locate 命令的工作原理是搜索包含系统上所有文件名称的数据库。 updatedb 命令更新此数据库。

由于 locate 命令不必对系统上的所有文件进行实时搜索，因此它比 find 命令高效得多。 但除了缺乏选项之外，还有另一个缺点：文件数据库每天只更新一次。


### find性能问题

在搜索大量目录时，find 命令可能会占用大量资源。 它本质上应该允许更重要的系统进程具有优先级，但是如果您需要确保 find 命令在生产服务器上占用更少的资源，则可以使用 ionice 或 nice 命令。 

```bash
# Reduce the Input/Output priority of find command:
ionice -c3 -n7 find /path/to/search -name "myfile.txt"

# Reduce the CPU priority of find command:
nice -n 19 find /path/to/search -name "myfile.txt"


# Or combine both utilities to really ensure low I/O and low CPU priority:
nice -n 19 ionice -c2 -n7 find /path/to/search -name "myfile.txt"
```