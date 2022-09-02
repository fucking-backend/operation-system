## the Global Command

So far you have learned how to repeat the last change with the dot command (.), to replay actions with macros (q), and to store texts in the registers (").

In this chapter, you will learn how to repeat a command-line command with the global command.

### Global Command Overview

> :h ex-cmd-index

```sh
# 全局命令具有以下语法：
:g/pattern/command


# 例1
const one = 1;
console.log("one: ", one);
const two = 2;
console.log("two: ", two);
const three = 3;
console.log("three: ", three);

# 删除所有包含console的行 
:g/console/d
# 删除所有包含const的行 
:g/const/d

```

当运行 g 命令时，Vim 对文件进行两次扫描。 在第一次运行时，它会扫描每一行并标记与 /console/ 模式匹配的行。 一旦标记了所有匹配的行，它会第二次执行并在标记的行上执行 d 命令。

### Inverse Match

```sh
#
:g!/pattern/command
# 
:v/pattern/command

```

### Pattern

```sh

```

### Passing a Range

```sh

```

### Normal Command

```sh
# 例子
const one = 1
console.log("one: ", one)

const two = 2
console.log("two: ", two)

const three = 3
console.log("three: ", three)

# To add a ";" to the end of each line, run:
:g/./normal A;

```
- :g is the global command.
- /./ is a pattern for "non-empty lines". It matches the lines with at least one character, so it matches the lines with "const" and "console" and it does not match empty lines.
- normal A; runs the :normal command-line command. A; is the normal mode command to insert a ";" at the end of the line.

### Executing a Macro （😅）

```sh

```

### Recursive Global Command



### Changing the Delimiter

您可以像替换命令一样更改全局命令的分隔符。 规则是相同的：您可以使用任何单字节字符，除了字母、数字、"、| 和 \。

```sh
#
:g@console@d
# 
g@one@s+const+let+g

```

### The Default Command

What happens if you don't specify any command-line command in the global command?

```sh
# 
:g/console
# the default command used by the global command is p
:g/re/p

g = the global command
re = the regex pattern
p = the print command

```

It spells "grep", the same grep from the command line. This is not a coincidence. The g/re/p command originally came from the Ed Editor, one of the original line text editors. The grep command got its name from Ed.

Your computer probably still has the Ed editor. Run ed from the terminal (hint: to quit, type q).

### Reversing the Entire Buffer

> :h :move

```sh
# To reverse the entire file
:g/^/m 0
# If you need to reverse only a few lines, pass it a range
:5,10g/^/m 0
```

### Aggregating All Todos （聚合所有待办事项 😅）

```sh

```

### Black Hole Delete （😅）

```sh

```

### Reduce Multiple Empty Lines to One Empty Line

```sh

```

### Advanced Sort（😅）

```sh

```
