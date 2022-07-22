### Character Navigation

1. 上下左右键
2. hjkl（左下上右）

### Relative Numbering

1. d12j 向下删除12行

### Count Your Move

1. 12j 9l

### Word Navigation

您可以移动到下一个单词的开头 (w)、下一个单词的结尾 (e)、上一个单词的开头 (b) 以及上一个单词的结尾 (ge)。

```sh

w     Move forward to the beginning of the next word
W     Move forward to the beginning of the next WORD
e     Move forward one word to the end of the next word
E     Move forward one word to the end of the next WORD
b     Move backward to beginning of the previous word
B     Move backward to beginning of the previous WORD
ge    Move backward to end of the previous word
gE    Move backward to end of the previous WORD

```

### Current Line Navigation

要跳转到当前行的第一个字符，使用 0。要跳转到当前行的最后一个字符，使用 $。 此外，您可以使用 ^ 转到当前行中的第一个非空白字符，使用 g_ 转到当前行中的最后一个非空白字符。 如果要转到当前行的第 n 列，可以使用 n|。

```sh

0     Go to the first character in the current line
^     Go to the first nonblank char in the current line
g_    Go to the last non-blank char in the current line
$     Go to the last char in the current line
n|    Go the column n in the current line

```

( question 😅😅😅 )

您可以使用 f 和 t 进行当前行搜索。 f 和 t 之间的区别在于 f 将您带到匹配的第一个字母，而 t 将您带到（就在之前）匹配的第一个字母。 因此，如果您想搜索“h”并降落在“h”上，请使用 fh。 如果您想搜索第一个“h”并在比赛前降落，请使用 th。 如果要转到最后一个当前行搜索的下一个匹配项，请使用 ;。 要转到最后一个当前行匹配的上一个匹配项，请使用 ,。

F 和 T 是 f 和 t 的反向对应物。 要向后搜索“h”，请运行 Fh。 要继续在同一方向搜索“h”，请使用 ;。 注意 ; 在 a Fh 向后搜索和 , 在 fh 向前搜索之后。

```sh

f    Search forward for a match in the same line
F    Search backward for a match in the same line
t    Search forward for a match in the same line, stopping before match
T    Search backward for a match in the same line, stopping before match
;    Repeat the last search in the same line using the same direction
,    Repeat the last search in the same line using the opposite direction

```

### Sentence and Paragraph Navigation

```sh

(    Jump to the previous sentence
)    Jump to the next sentence
{    Jump to the previous paragraph
}    Jump to the next paragraph

```

### Match Navigation

程序员编写和编辑代码。 代码通常使用圆括号、大括号和方括号。 你很容易迷失在其中。 如果您在其中一个，您可以使用 % 跳转到另一对（如果存在）。 您还可以使用它来确定是否有匹配的括号、大括号和方括号。

### Line Number Navigation

```sh

gg    Go to the first line
G     Go to the last line
nG    Go to line n
n%    Go to n% in file
Ctrl-g total lines in a file

```

### Window Navigation

```sh

H     Go to top of screen
M     Go to medium screen
L     Go to bottom of screen
nH    Go n line from top
nL    Go n line from bottom

```

### Scrolling

```sh

Ctrl-E    Scroll down a line
Ctrl-D    Scroll down half screen
Ctrl-F    Scroll down whole screen
Ctrl-Y    Scroll up a line
Ctrl-U    Scroll up half screen
Ctrl-B    Scroll up whole screen

# 相对于当前行滚动（缩放屏幕视线）：
zt    Bring the current line near the top of your screen
zz    Bring the current line to the middle of your screen
zb    Bring the current line near the bottom of your screen
```

### Search Navigation

通常你知道一个短语存在于文件中。 您可以使用搜索导航非常快速地到达您的目标。 要搜索短语，您可以使用 / 向前搜索和 ? 向后搜索。 要重复上次搜索，您可以使用 n。 要重复上一次反向搜索，您可以使用 N。

```sh

/    Search forward for a match
?    Search backward for a match
n    Repeat last search in same direction of previous search
N    Repeat last search in opposite direction of previous search

( question 😅😅😅 )

*     Search for whole word under cursor forward
#     Search for whole word under cursor backward
g*    Search for word under cursor forward
g#    Search for word under cursor backward

```

### Marking Position

您可以使用标记保存当前位置并稍后返回该位置。 它就像一个用于文本编辑的书签。 您可以使用 mx 设置标记，其中 x 可以是任何字母 a-zA-Z。 返回标记有两种方法：精确（行和列）与`x和逐行（'x）。

```sh

ma    Mark position with mark "a"
`a    Jump to line and column "a"
'a    Jump to line "a"

( question 😅😅😅 )

''    Jump back to the last line in current buffer before jump
``    Jump back to the last position in current buffer before jump
`[    Jump to beginning of previously changed / yanked text
`]    Jump to the ending of previously changed / yanked text
`<    Jump to the beginning of last visual selection
`>    Jump to the ending of last visual selection
`0    Jump back to the last edited file when exiting vim
```


### Jump

```sh

'       Go to the marked line
`       Go to the marked position
G       Go to the line
/       Search forward
?       Search backward
n       Repeat the last search, same direction
N       Repeat the last search, opposite direction
%       Find match
(       Go to the last sentence
)       Go to the next sentence
{       Go to the last paragraph
}       Go to the next paragraph
L       Go to the the last line of displayed window
M       Go to the middle line of displayed window
H       Go to the top line of displayed window
[[      Go to the previous section
]]      Go to the next section
:s      Substitute
:tag    Jump to tag definition

```

### Learn Navigation the Smart Way

If you are new to Vim, this is a lot to learn. I do not expect anyone to remember everything immediately. It takes time before you can execute them without thinking.

I think the best way to get started is to memorize a few essential motions. I recommend starting out with these 10 motions: h, j, k, l, w, b, G, /, ?, n. Repeat them sufficiently until you can use them without thinking.

To improve your navigation skill, here are my suggestions:

Watch for repeated actions. If you find yourself doing l repeatedly, look for a motion that will take you forward faster. You will find that you can use w. If you catch yourself repeatedly doing w, look if there is a motion that will take you across the current line quickly. You will find that you can use the f. If you can describe your need succinctly, there is a good chance Vim has a way to do it.

Whenever you learn a new move, spend some time until you can do it without thinking.
Finally, realize that you do not need to know every single Vim command to be productive. Most Vim users don't. I don't. Learn the commands that will help you accomplish your task at that moment.

Take your time. Navigation skill is a very important skill in Vim. Learn one small thing every day and learn it well.