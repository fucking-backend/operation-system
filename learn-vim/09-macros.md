## Macros

编辑文件时，您可能会发现自己在重复相同的操作。 如果您可以一次执行这些操作并在需要时重播它们，那不是很好吗？ 使用 Vim 宏，您可以记录操作并将它们存储在 Vim 寄存器中，以便在需要时执行。

### Basic Macros

```sh
qa                     Start recording a macro in register a
q (while recording)    Stop recording macro
# 您可以选择任何小写字母 (a-z) 来存储宏。以下是执行宏的方法：
@a    Execute macro from register a
@@    Execute the last executed macros


# 例1: 假设你有这个文本并且你想把每一行的所有内容都大写
hello
vim
macros
are
awesome

# With your cursor at the start of the line "hello", run:
qa0gU$jq
# 动作分解
qa starts recording a macro in the a register.
0 goes to beginning of the line.
gU$ uppercases the text from your current location to the end of the line.
j goes down one line.
q stops recording.

To replay it, run @a. Just like many other Vim commands, you can pass a count argument to macros. For example, running 3@a executes the macro three times.
```

### Safety Guard

```sh
# 将每行的第一个单词大写
a. chocolate donut
b. mochi donut
c. powdered sugar donut
d. plain donut

# this macro should work:
qa0W~jq
# 动作分解
qa starts recording a macro in the a register.
0 goes to the beginning of the line.
W goes to the next WORD.
~ toggles the case of the character under the cursor.
j goes down one line.
q stops recording.

To replay it, run @a. Just like many other Vim commands, you can pass a count argument to macros. For example, running 3@a executes the macro three times.
```

### Command Line Macro

```sh
在普通模式下运行 @a 并不是在 Vim 中执行宏的唯一方法。 您还可以运行 :normal @a 命令行。 :normal 允许用户执行作为参数传递的任何正常模式命令。 在上述情况下，它与从正常模式运行 @a 相同。

:normal 命令接受范围作为参数。 您可以使用它在选定范围内运行宏。 如果要在第 2 行和第 3 行之间执行宏，可以运行 :2,3 normal @a。

```

### Executing a Macro Across Multiple Files

```sh

```

### Recursive Macro（递归执行）

```sh

```

### Appending a Macro （附加）

```sh

```

### Amending a Macro（修改）

```sh

```

### Macro Redundancy（冗余）

```sh

```

### Series vs Parallel Macro（串行和并行）

```sh

```