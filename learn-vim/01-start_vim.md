### 基本操作

```sh

# 退出vim
:quit (:q)

# 保存文件
:write (:w)

# 保存并退出
:wq

# 强制退出不保存任何修改
:q!

# 帮助文档
:h + 命令

# 打开一个或者多个文档
vim+files

# 查看vim版本
vim --version
:version

```

### Arguments

```sh
# 打开文件 并立即执行 Vim 命令，可以将 +{cmd} 选项传递给 vim 命令。
vim +%s/pancake/bagel/g hello.txt

# 也可以传递 -c 选项后跟 Vim 命令而不是语法
vim -c %s/pancake/bagel/g hello.txt

```

### Opening Multiple Windows

```sh

# 您可以分别使用 -o 和 -O 选项在拆分的水平和垂直窗口上启动 Vim。
vim -o5 hello1.txt hello2.txt

```

### Suspending

```sh

# 如果在编辑过程中需要暂停 Vim，可以按 Ctrl-z。 您也可以运行 :stop 或 :suspend 命令。 要返回暂停的 Vim，请从终端运行 fg。

```