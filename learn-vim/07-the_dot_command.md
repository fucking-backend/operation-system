## the Dot Command

一般来说，你应该尽量避免重做你刚刚做过的事情。在本章中，您将学习如何使用 dot 命令轻松重做之前的更改。这是一个用于减少简单重复的通用命令。

> :h .

### Usage

```sh
let one = "1";
let two = "2";
let three = "3";
```

- Search with /let to go to the match.
- Change with cwconst<Esc> to replace "let" with "const".
- Navigate with n to find the next match using the previous search.
- Repeat what you just did with the dot command (.).
- Continue pressing n . n . until you replace every word.

### What Is a Change? 🐷🐷🐷

如果您查看点命令 (:h .) 的定义，它会说点命令重复上一次更改。 什么是变化？

每当您更新（添加、修改或删除）当前缓冲区的内容时，您就是在进行更改。 例外情况是由命令行命令（以 : 开头的命令）完成的更新不计为更改。

```sh
# 1. 删除从行首到下一个逗号出现的文本 【df,..】 🐷
# 2. 删除逗号 【f,x;.;.】 🐷
pancake, potatoes, fruit-juice,

# 3. 在每一行的末尾添加一个逗号 【A,<Esc>j.j.】 🐷
pancake
potatoes
fruit-juice
```

### Multi-line Repeat

```sh
# 删除除“foo”行之外的所有行 【d2jj..】
let one = "1";
let two = "2";
let three = "3";
const foo = "bar';
let four = "4";
let five = "5";
let six = "6";
let seven = "7";
let eight = "8";
let nine = "9";

```

```sh
# 删除所有的z 【Ctrl-vjjdw..】 🐷🐷
# 使用分块视觉模式 (Ctrl-Vjj) 从前三行中仅视觉选择第一个 z。一旦您在视觉上选择了三个 z，请使用删除运算符 (d) 删除它们。 然后移动到下一个单词 (w) 到下一个 z。 再重复两次更改 (..)
zlet zzone = "1";
zlet zztwo = "2";
zlet zzthree = "3";
let four = "4";
```

### Including a Motion in a Change

```sh
# replaced all "let" with "const".
# After you searched /let, run cgnconst<Esc> then . .
let one = "1";
let two = "2";
let three = "3";
```

### 

```sh

```

### 

```sh

```

### 

```sh

```