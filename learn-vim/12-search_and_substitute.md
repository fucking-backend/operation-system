## Search and Substitute

## Search

As a side note, in this chapter, I will use / when talking about search. Everything you can do with / can also be done with ?.

### Smart Case Sensitivity(区分大小写)

```sh
#
set ignorecase smartcase

#  如何忽略大小写，如何严格匹配
```

当你输入 /hello 时，Vim 现在会进行不区分大小写的搜索。 你可以在搜索词的任何地方使用 \C 模式来告诉 Vim 后面的搜索词将区分大小写。 如果你做/\Chello，它将严格匹配“hello”，而不是“HELLO”或“Hello”。

### First and Last Character in a Line

```sh
# ^ 匹配第一个
# $ 匹配最后一个
# You can use ^ to match the first character in a line and $ to match the last character in a line.
```

### Repeating Search

```sh
# 重复之前的搜索
# 向前向后重复之前的搜索
# 向上向下找到搜多内容
```

### Searching for Alternative Words

```sh

```

### Setting the Start and End of a Match

```sh

```

### Searching Character Ranges

```sh

```

### Searching for Repeating Characters

```sh

```

### Predefined Character Ranges

```sh

```

### Search Example: Capturing a Text Between a Pair of Similar Characters

```sh

```

### Search Example: Capturing a Phone Number

```sh

```
## Substitute

### Basic Substitution

```sh

```

### Repeating the Last Substitution

```sh

```

### Substitution Range

```sh

```

### Pattern Matching

```sh

```

### Substitution Flags

```sh

```

### Changing the Delimiter

```sh

```

### Special Replace

```sh

```

### Alternative Patterns

```sh

```

### Substituting the Start and the End of a Pattern

```sh

```

### Greedy and Non-greedy

```sh

```

### Substituting Across Multiple Files

```sh

```

### Substituting Across Multiple Files With Macros

```sh

```
