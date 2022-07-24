## Buffers, Windows, and Tabs

如果您以前使用过现代文本编辑器，那么您可能熟悉窗口和选项卡。 Vim 使用三个显示抽象而不是两个：缓冲区、窗口和选项卡。 在本章中，我将解释缓冲区、窗口和选项卡是什么以及它们在 Vim 中的工作方式。 在开始之前，请确保您在 vimrc 中有设置 set hidden 。 没有它，当你切换缓冲区并且当前缓冲区没有保存时，Vim 会提示你保存文件（如果你想快速移动，你不希望这样）。

### Buffers

缓冲区是一个内存空间，您可以在其中编写和编辑一些文本。 当你在 Vim 中打开一个文件时，数据被绑定到一个缓冲区。 当你在 Vim 中打开 3 个文件时，你有 3 个缓冲区。

```sh

# 创建buffer
# 切换buffer
# 删除buffer
# 退出所有buffer
:qall 退出
:qall! 退出不保存
:wqall 退出并保存

```

### Windows 【窗口是您查看缓冲区的方式】

窗口是缓冲区上的视口。 如果您来自主流编辑器，您可能对这个概念很熟悉。 大多数文本编辑器都能够显示多个窗口。 在 Vim 中，你也可以有多个窗口。

```sh

vim file1.js
# 在file1.js窗口上方新开一个窗口
:split file2.js 
:vsplit file3.js
# 两个窗口展示一个buffer 😄
:buffer file2.js

Ctrl-W H    Moves the cursor to the left window
Ctrl-W J    Moves the cursor to the window below
Ctrl-W K    Moves the cursor to the window upper
Ctrl-W L    Moves the cursor to the right window

Ctrl-W V    Opens a new vertical split
Ctrl-W S    Opens a new horizontal split
Ctrl-W C    Closes a window
Ctrl-W O    Makes the current window the only one on screen and closes other windows

:vsplit filename    Split window vertically
:split filename     Split window horizontally
:new filename       Create new window

# 帮助文档
:h window

```

### Tabs 😅😅😅

```sh

:tabnew file.txt    Open file.txt in a new tab
:tabclose           Close the current tab
:tabnext            Go to next tab
:tabprevious        Go to previous tab
:tablast            Go to last tab
:tabfirst           Go to first tab

```

### Moving in 3D 😅😅😅