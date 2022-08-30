## Visual Mode(视觉模式 😄😄😄 )

### The Three Types of Visual Modes

```sh
v         Character-wise visual mode
V         Line-wise visual mode
Ctrl-V    Block-wise visual mode

gv    Go to the previous visual mode
```

Character-wise visual mode works with individual characters. Press v on the first character. Then go down to the next line with j. It highlights all texts from "one" up to your cursor location. If you press gU, Vim uppercases the highlighted characters.

Line-wise visual mode works with lines. Press V and watch Vim selects the entire line your cursor is on. Just like character-wise visual mode, if you run gU, Vim uppercases the highlighted characters.

Block-wise visual mode works with rows and columns. It gives you more freedom of movement than the other two modes. If you press Ctrl-V, Vim highlights the character under the cursor just like character-wise visual mode, except instead of highlighting each character until the end of the line before going down to the next line, it goes to the next line with minimal highlighting. Try moving around with h/j/k/l and watch the cursor moves.

退出可视模式有三种方法：<Esc>、Ctrl-C 和与当前可视模式相同的键。后者的意思是，如果您当前处于逐行可视模式 (V)，您可以再次按 V 退出它。如果您处于逐字符视觉模式，您可以按 v 退出它。

### Visual Mode Navigation

> :h visual-operators

```sh

```

### Visual Mode Grammar

```sh
# x 删除光标下的单个字符，r 替换光标下的字符（rx 将光标下的字符替换为“x”）

Chapter One
# copy the text with yy, then paste it with p
Chapter One
Chapter One
# Now go to the second line, select it with line-wise visual mode:
Chapter One
[Chapter One]
# A first-level header is a series of "=" below a text. Run r=, voila! This saves you from typing "=" manually.
Chapter One
===========


```

### Visual Mode and Command-line Commands

```sh
# 如果您有这些语句，并且只想在前两行将“const”替换为“let”：
const one = "one";
const two = "two";
const three = "three";

# :s/const/let/g 如何重复执行呢 😅
```

### Adding Text on Multiple Lines

```sh
# 给每一行添加;
const one = "one"
const two = "two"
const three = "three"

# 方法1:
Run block-wise visual mode and go down two lines (Ctrl-V jj).
Highlight to the end of the line ($).
Append (A) then type ";".
Exit visual mode (<Esc>).

# 方法2:
Highlight all 3 lines (vjj).
Type :normal! A;.
```

There are two ways to enter the insert mode from block-wise visual mode: A to enter the text after the cursor or I to enter the text before the cursor. Do not confuse them with A (append text at the end of the line) and I (insert text before the first non-blank line) from normal mode.

### Incrementing Numbers

Vim has Ctrl-X and Ctrl-A commands to decrement and increment numbers. When used with visual mode, you can increment numbers across multiple lines.


```sh

```

### Selecting the Last Visual Mode Area

```sh

```

### Entering Visual Mode From Insert Mode

```sh

```

### Select Mode

```sh

```