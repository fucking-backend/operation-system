## Command-line Mode

In the last three chapters, you learned how to use the search commands (/, ?), substitute command (:s), global command (:g), and external command (!). These are examples of command-line mode commands.

### Entering and Exiting the Command-line Mode

命令行模式本身就是一种模式，就像普通模式、插入模式和可视模式一样。当您处于此模式时，光标会转到屏幕底部，您可以在其中键入不同的命令。

- Search patterns (/, ?)
- Command-line commands (:)
- External commands (!)

```sh
# To leave the command-line mode, you can use
<Esc>, Ctrl-C, or Ctrl-[
```

> Other literatures might refer the "Command-line command" as "Ex command" and the "External command" as "filter command" or "bang operator".

### Repeating the Previous Command

You can repeat the previous command-line command or external command with @:.

If you just ran :s/foo/bar/g, running @: repeats that substitution. If you just ran :.!tr '[a-z]' '[A-Z]', running @: repeats the last external command translation filter.

### Command-line Mode Shortcuts

While in the command-line mode, you can move to the left or to the right, one character at a time, with the Left or Right arrow.

If you need to move word-wise, use Shift-Left or Shift-Right (in some OS, you might have to use Ctrl instead of Shift).

To go to the start of the line, use Ctrl-B. To go to the end of the line, use Ctrl-E.

Similar to the insert mode, inside the command-line mode, you have three ways to delete characters:

```sh
Ctrl-H    Delete one character
Ctrl-W    Delete one word
Ctrl-U    Delete the entire line
```

Finally, if you want to edit the command like you would a normal textfile use Ctrl-F.

This also allows you to search through the previous commands, edit them and rerun them by pressing <Enter> in "command-line editing normal mode".

### Register and Autocomplete(😅)

```sh

```

### History Window and Command-line Window(😅😅😅)

```sh

```

### More Command-line Commands

```sh

```
