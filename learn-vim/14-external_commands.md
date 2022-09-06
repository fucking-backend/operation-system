## External Commands

如何扩展 Vim 以与外部命令无缝协作。

### The Bang Command

```sh
1. Read the STDOUT of an external command into the current buffer.
2. Write the content of your buffer as the STDIN to an external command.
3. Execute an external command from inside Vim.
```

### Reading the STDOUT of a Command Into Vim

```sh
:r !cmd
:r file1.txt
:r !ls
:r !curl -s 'https://jsonplaceholder.typicode.com/todos/1'
#
:10r !cat file1.txt
```

### Writing the Buffer Content Into an External Command

```sh
:w !cmd

```

### Executing an External Command

```sh

```

### Filtering Texts

```sh

```

### Normal Mode Command

```sh

```

### 

```sh

```

### 

```sh

```