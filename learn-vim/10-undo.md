## Undo

我们都会犯各种打字错误。 这就是为什么撤消是任何现代软件的基本功能。 Vim 的撤消系统不仅能够撤消和重做简单的错误，还可以访问不同的文本状态，让您可以控制您曾经键入的所有文本。 在本章中，您将学习如何撤消、重做、导航撤消分支、持久化撤消以及穿越时间。

### Undo, Redo, and UNDO

How is U different from u? First, U removes all the changes on the latest changed line, while u only removes one change at a time. Second, while doing u does not count as a change, doing U counts as a change.

```sh
u
U
```

### Breaking the Blocks(😅)

```sh
Ctrl-G u
```

### Undo Tree

```sh
# u、Ctrl-R、g+和g-的区别在于u和Ctrl-R都只遍历undo树中的主节点，而g+和g-遍历undo树中的所有节点。
u
Ctrl-R
g+
g-
```

### Persistent Undo(持久化撤销)

```sh
# create undo file
:wundo! {my-undo-file}
# load history
:rundo mynumbers.undo
```

### Time Travel

```sh
:earlier 10s    Go to the state 10 seconds before
:earlier 10m    Go to the state 10 minutes before
:earlier 10h    Go to the state 10 hours before
:earlier 10d    Go to the state 10 days before

:later 10s    go to the state 10 seconds later
:later 10m    go to the state 10 minutes later
:later 10h    go to the state 10 hours later
:later 10d    go to the state 10 days later
:later 10     go to the newer state 10 times
:later 10f    go to the state 10 saves later
```
