## Insert Mode

### Ways to Go to Insert Mode

```sh

i    Insert text before the cursor
I    Insert text before the first non-blank character of the line
a    Append text after the cursor
A    Append text at the end of line
o    Starts a new line below the cursor and insert text
O    Starts a new line above the cursor and insert text
s    Delete the character under the cursor and insert text
S    Delete the current line and insert text, synonym for "cc"
gi   Insert text in same position where the last insert mode was stopped
gI   Insert text at the start of line (column 1)

```

### Different Ways to Exit Insert Mode

```sh

<Esc>     Exits insert mode and go to normal mode
Ctrl-[    Exits insert mode and go to normal mode
Ctrl-C    Like Ctrl-[ and <Esc>, but does not check for abbreviation

```

### Repeating Insert Mode

```sh
# 如果你输入“你好世界！” 并退出插入模式，Vim 将重复文本 10 次。 这适用于任何插入模式方法（例如：10I、11a、12o）。
10i

```

### Deleting Chunks in Insert Mode

```sh

Ctrl-h    Delete one character
Ctrl-w    Delete one word
Ctrl-u    Delete the entire line

```

### Insert From Register（🐷🐷🐷）

```sh

# 注册
"ayiw

# 使用
Ctrl-R a

```

### Scrolling

您知道在插入模式下可以滚动吗？在插入模式下，如果你进入 Ctrl-X 子模式，你可以做额外的操作。滚动就是其中之一

```sh

Ctrl-X Ctrl-Y    Scroll up
Ctrl-X Ctrl-E    Scroll down

```

### Autocompletion（🐷🐷🐷）

> :h ins-completion

```sh

Ctrl-X Ctrl-L	   Insert a whole line
Ctrl-X Ctrl-N	   Insert a text from current file
Ctrl-X Ctrl-I	   Insert a text from included files
Ctrl-X Ctrl-F	   Insert a file name

Ctrl-N             Find the next word match
Ctrl-P             Find the previous word match
```

### Executing a Normal Mode Command

```sh

# Centering and jumping
Ctrl-O zz       Center window
Ctrl-O H/M/L    Jump to top/middle/bottom window
Ctrl-O 'a       Jump to mark a

# Repeating text
Ctrl-O 100ihello    Insert "hello" 100 times

# Executing terminal commands
Ctrl-O !! curl https://google.com    Run curl
Ctrl-O !! pwd                        Run pwd

# Deleting faster
Ctrl-O dtz    Delete from current location till the letter "z"
Ctrl-O D      Delete from current location to the end of the line

```