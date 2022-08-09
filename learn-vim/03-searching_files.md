## Searching Files

本章的目的是向你介绍如何在 Vim 中快速搜索。 能够快速搜索是提高 Vim 生产力的好方法。 当我弄清楚如何快速搜索文件时，我转而全职使用 Vim。 本章分为两部分：如何不使用插件进行搜索和如何使用 fzf.vim 插件进行搜索。

### Opening and Editing Files

```sh
# 要在 Vim 中打开文件，可以使用 :edit
:edit file.txt

# :edit 接受通配符参数。 * 匹配当前目录中的任何文件。如果您只在当前目录中查找扩展名为 .yml 的文件
:edit *.yml<Tab>

# Vim 将为您提供当前目录中所有 .yml 文件的列表以供您选择。 您可以使用 ** 进行递归搜索。如果要查找项目中的所有 *.md 文件，但不确定在哪些目录中，可以这样做：
:edit **/*.md<Tab>

# :edit 可用于运行 netrw，Vim 的内置文件浏览器。为此，请给 :edit 一个目录参数而不是文件：
:edit .
:edit test/unit/

```

### Searching Files With Find

```sh

# 可以使用 :find 查找文件
:find package.json
:find app/controllers/users_controller.rb

```

【You may notice that :find looks like :edit. What's the difference?】，不同之处在于 :find 在路径中查找文件， :edit 没有。

### Find and Path

```sh
# 要检查您的路径是什么，请执行以下操作：
:set path?
# 默认path
path=.,/usr/include,,

### todo
# 
:set path+=app/controllers/
# 
:set path+=$PWD/**
# vimrc
set path+={your-path-here}

```

### Searching in Files With Grep

```sh
# 如果需要在文件中查找（在文件中查找短语），可以使用 grep。 Vim 有两种方法可以做到这一点：
Internal grep (:vim. Yes, it is spelled :vim. It is short for :vimgrep).
External grep (:grep).

# Internal grep 
# Vim 将每个匹配的文件加载到内存中，就好像它正在被编辑一样。 如果 Vim 找到大量与您的搜索匹配的文件，它将全部加载，因此会消耗大量内存。
:vim /pattern/ file
# 
:vim /breakfast/ app/controllers/**/*.rb

# External grep
# 要在 app/controllers/ 目录中的 ruby​​ 文件中搜索“lunch”，您可以执行以下操作
:grep -R "lunch" app/controllers/

```

### quickfix

```sh
# :h quickfix
:copen        Open the quickfix window
:cclose       Close the quickfix window
:cnext        Go to the next error
:cprevious    Go to the previous error
:colder       Go to the older error list
:cnewer       Go to the newer error list

```

### Browsing Files With Netrw

> :h netrw

```sh
# netrw 是 Vim 的内置文件浏览器。查看项目的层次结构很有用。要运行 netrw，您需要在 .vimrc 中进行这两个设置
set nocp
filetype plugin on


# 您可以在启动 Vim 时启动 netrw，方法是将目录作为参数而不是文件传递给它。
vim .
vim src/client/
vim app/controllers/

# 要从 Vim 内部启动 netrw，可以使用 :edit 命令并传递一个目录参数而不是文件名
:edit .
:edit src/client/
:edit app/controllers/

# 还有其他方法可以在不传递目录的情况下启动 netrw 窗口
:Explore     Starts netrw on current file
:Sexplore    No kidding. Starts netrw on split top half of the screen
:Vexplore    Starts netrw on split left half of the screen

# 如果您需要创建、删除或重命名文件或目录，以下是有用的 netrw 命令列表：
%    Create a new file
d    Create a new directory
R    Rename a file or directory
D    Delete a file or directory

```

如果你觉得 netrw 太乏味并且需要更多的味道，vim-vinegar 是一个很好的插件来改进 netrw。如果您正在寻找不同的文件资源管理器，NERDTree 是一个不错的选择

### fzf.vim 插件 （TODO）

```sh

```


