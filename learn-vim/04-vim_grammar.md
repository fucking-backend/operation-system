## Vim Grammar

### Grammar Rule

```sh
# Vim 语言中只有一个语法规则
verb + noun
```

### Nouns (Motions)

```sh
# 名词是 Vim 动作。 Motions 用于在 Vim 中移动。下面是一些 Vim 动作的列表：
h    Left
j    Down
k    Up
l    Right
w    Move forward to the beginning of the next word
}    Jump to the next paragraph
$    Go to the end of the line

```

### Verbs (Operators)

```sh
# According to :h operator, Vim has 16 operators. However, in my experience, learning these 3 operators is enough for 80% of my editing needs:
y    Yank text (copy)
d    Delete text and save to register
c    Delete text, save to register, and start insert mode
```

### Verb and Noun

```sh
To yank everything from your current location to the end of the line: y$.
To delete from your current location to the beginning of the next word: dw.
To change from your current location to the end of the current paragraph, say c}.
To yank two characters to the left: y2h.
To delete the next two words: d2w.
To change the next two lines: c2j.
dd
yy
cc
```

### More Nouns (Text Objects)

> :h text-objects

```sh
# 文本对象与运算符一起使用。有两种类型的文本对象：内部文本对象和外部文本对象
i + object    Inner text object
a + object    Outer text object


# 
To delete the text inside the parentheses without deleting the parentheses: di(.
To delete the parentheses and the text inside: da(.


# TODO
const hello = function() {
  console.log("Hello Vim");
  return true;
}

To delete the entire "Hello Vim": di(.
To delete the content of function (surrounded by {}): di{.
To delete the "Hello" string: diw.


# TODO
<div>
  <h1>Header1</h1>
  <p>Paragraph1</p>
  <p>Paragraph2</p>
</div>

# If your cursor is on "Header1" text:
To delete "Header1": dit.
To delete <h1>Header1</h1>: dat.

# If your cursor is on "div":
To delete h1 and both p lines: dit.
To delete everything: dat.
To delete "div": di<.


# TODO
w         A word
p         A paragraph
s         A sentence
( or )    A pair of ( )
{ or }    A pair of { }
[ or ]    A pair of [ ]
< or >    A pair of < >
t         XML tags
"         A pair of " "
'         A Pair of ' '
`         A pair of ` `
```

### Composability and Grammar(🐷🐷🐷)

```sh
# Vim 有一个过滤器操作符 (!) 来使用外部程序作为我们文本的过滤器。假设您在下面有这个凌乱的文本，并且您想将其表格化
Id|Name|Cuteness
01|Puppy|Very
02|Kitten|Ok
03|Bunny|Ok
# 🐷🐷🐷
!}column -t -s "|"


# 假设您不仅要对文本进行表格化，而且只显示带有“Ok”的行。 您知道 awk 可以轻松完成这项工作。 你可以这样做：
!}column -t -s "|" | awk 'NR > 1 && /Ok/ {print $0}'

```

### 🐷

```sh
gUiw 将单词转大写

```
