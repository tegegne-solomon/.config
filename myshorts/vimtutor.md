# Vim & Neovim Mastery Guide

> *“Vim is not just a text editor; it is a modal language for manipulating text at the speed of thought.”*

---

## 📌 Executive Summary
This repository tracks the complete journey of mastering **Vim** and **Neovim**, progressing from fundamental modal navigation (`hjkl`) and textual grammar (`operator + count + motion`) to building a modern, high-performance IDE with Lua plugins, LSP code intelligence, and Treesitter syntax processing.

---

## 📑 VimTutor Core Cheatsheet

Start with the interactive tutor shipped with Vim:

```sh
vimtutor
```

The official Vim project includes this hands-on course. Repeat it until the
basic movements, editing, and save/quit commands no longer require thought.
For the installed tutor and its documentation, use `:help tutor` inside Vim.

### 1. Basic Navigation & Modes
* `h` / `j` / `k` / `l` : Move Left / Down / Up / Right (Keep hands on home row)
* `i` : Enter **Insert Mode** before cursor
* `a` / `A` : Append text after cursor / Append at the end of line
* `o` / `O` : Open new line below / above cursor and enter Insert Mode
* `Esc` : Return to **Normal Mode**
* `v` / `V` / `CTRL-V` : Character-wise / line-wise / block-wise **Visual Mode**

### 2. File Operations & Quitting
* `:w` : Save file (Write)
* `:q!` : Quit without saving (Discard changes)
* `:wq` : Save and quit
* `:w {file}` : Save a copy as `{file}`
* `:r FILENAME` : Read/insert file contents below cursor
* `:!command` : Execute external shell command (e.g., `:!ls`)

### 3. Text Editing & Deletion
* `x` : Delete character under cursor
* `dw` : Delete from cursor to start of next word
* `de` : Delete to end of current word
* `d$` : Delete from cursor to end of line
* `dd` : Delete entire line
* `r{char}` : Replace character under cursor with `{char}`
* `R` : Enter Replace Mode
* `u` / `CTRL-R` : Undo / redo
* `.` : Repeat the last change

### 4. Search, Navigation & Substitution
* `0` / `$` : Jump to start / end of line
* `gg` / `G` : Jump to first / last line of file
* `CTRL-G` : Show file location and status
* `/pattern` : Search forward (`n` next match, `N` previous match)
* `?pattern` : Search backward
* `%` : Jump to matching parenthesis `()`, bracket `[]`, or brace `{}`
* `:%s/old/new/g` : Substitute all occurrences of `old` with `new` in whole file
* `:%s/old/new/gc` : Substitute with confirmation for every match
* `:set ignorecase smartcase` : Case-insensitive search, unless the pattern has capitals

### 5. Grammar & Operators
Vim commands follow a powerful grammar: **`[operator] [count] [motion]`**
* **Operators**: `d` (delete), `c` (change), `y` (yank/copy), `v` (visual select)
* **Motions**: `w` (word), `e` (end of word), `b` (previous word), `0` (start),
  `^` (first non-blank), `$` (end of line), `f{char}` (find on line), and `%`
* **Examples**:
  * `2w` : Move forward 2 words
  * `d2w` : Delete 2 words
  * `ce` : Change to end of word (deletes and enters Insert Mode)
  * `yw` / `yy` then `p` : Yank a word / line, then put (paste) it
  * `ciw` : Change the word under the cursor
  * `dap` : Delete a paragraph (a text object)

> Use `:help {topic}` whenever you want the built-in reference—for example,
> `:help motion`, `:help text-objects`, or `:help :substitute`.

---

## 🏫 From Basics to Advanced

### Official Vimtutor: complete usage order

Run `vimtutor` from a terminal. It opens a disposable copy of the lesson, so
make the requested edits directly in it. Do not merely read: each lesson is
designed to be practiced. Complete the tutor in this order:

1. **Lesson 1 — survive in Vim:** `hjkl`, `:q!`, `x`, `i`, `A`, and `:wq`.
2. **Lesson 2 — edit with a grammar:** `dw`, `d$`, `dd`, counts such as `2w`
   and `d2w`, then `u`, `U`, and `CTRL-R`.
3. **Lesson 3 — put, replace, and change:** `p`, `r{char}`, `ce`, and `c$`.
4. **Lesson 4 — find and transform:** `CTRL-G`, `gg`, `G`, `{count}G`,
   `/`, `?`, `n`, `N`, `%`, and `:s/old/new/gc`.
5. **Lesson 5 — use files and the shell:** `:!{command}`, `:w {file}`, Visual
   selection plus `:w {file}`, `:r {file}`, and `:r !{command}`.
6. **Lesson 6 — complete everyday editing:** `o`, `O`, `a`, `R`, Visual yank
   and put (`v…y`, `p`), plus `:set ignorecase`, `incsearch`, and `hlsearch`.
7. **Lesson 7 — become self-sufficient:** `:help {topic}`, `CTRL-W CTRL-W`,
   `:help vimrc-intro`, and command-line completion with `CTRL-D` and `Tab`.

When that first chapter feels natural, open the follow-up lesson using
`:Tutor` and select Chapter 2 when your Vim version provides it. Otherwise,
continue with the official User Manual: `:help user-manual`.

### 1. Build reliable basics

Practice in **Normal mode** first; insert text only when you need to. Combine
counts, operators, and motions (`3dw`, `c$`, `yG`) instead of holding a movement
key. Add these high-value movements once `hjkl` is comfortable:

* `w`, `b`, `e`, `ge` : move by word and word end
* `f{char}`, `t{char}`, `;`, `,` : find within a line and repeat/reverse it
* `gg`, `G`, `{count}G` : go to the beginning, end, or a line number
* `CTRL-U`, `CTRL-D`, `zz` : scroll up/down and center the cursor
* `*` / `#` : search forward/backward for the word under the cursor

### 2. Select, copy, and work with text objects

Visual mode is useful for seeing a selection; operator + text object is usually
faster once learned. Text objects work *inside* (`i`) or *around* (`a`) a unit:

* `viw`, `diw`, `ciw` : select, delete, or change inside a word
* `ci"`, `da(`, `yi]` : work inside quotes, around parentheses, or inside brackets
* `vip`, `dap` : select or delete a paragraph
* `"{register}y`, `"{register}p` : yank to and put from a named register
* `CTRL-V` then `I` or `A` : insert or append on several selected lines; press `Esc` to apply

### 3. Search and replace safely

Use `/pattern` followed by `n` and `N`; press `:nohlsearch` to clear highlighting.
For substitutions, start with a range and add confirmation while learning:

```vim
:s/old/new/gc       " current line, all matches, confirm each
:%s/old/new/gc      " entire file
:10,20s/old/new/gc  " lines 10 through 20
```

### 4. Navigate files without losing your place

* `:e {file}` / `:find {file}` : edit a file / find using `'path'`
* `:ls`, `:b {number}`, `:bn`, `:bp` : list and switch buffers
* `:split`, `:vsplit`, `CTRL-W h/j/k/l` : split windows and move between them
* `ma` and `'a` : set mark `a` and jump to its line; use `` `a `` for its exact position
* `CTRL-O` / `CTRL-I` : move backward/forward through the jump list

### 5. Advanced editing habits

* `q{register}` … `q` : record a macro; `@{register}` runs it and `@@` repeats it
* `:set foldmethod=indent`, `za`, `zM`, `zR` : create and control code folds
* `:set spell spelllang=en_us`, `]s`, `z=` : enable spell-check, find the next error, choose a correction
* `:!{command}` and `:read !{command}` : run a command or insert its output
* `:w !sudo tee % >/dev/null` : write a protected file only when you understand and trust the command

### 6. Customize deliberately, then extend

Keep Vim configuration in `~/.vimrc` (or `~/.config/vim/vimrc`) and Neovim
configuration in `~/.config/nvim/init.lua`. Begin with options that make the
editor comfortable; do not install a large plugin distribution before the core
commands feel natural.

```vim
set number
set relativenumber
set expandtab
set shiftwidth=2
set smartindent
set ignorecase smartcase
```

For Neovim, add plugins only to solve a recurring workflow need: a fuzzy finder,
LSP completion/diagnostics, syntax parsing, Git signs, or a file explorer. Learn
the built-in command or mapping each plugin improves, so your workflow remains
portable to plain Vim and remote servers.

---

## 🚀 Practice Roadmap

```
Level 1: Core Muscle Memory ➔ Level 2: Text Grammar ➔ Level 3: File Workflows ➔ Level 4: Custom Neovim IDE
```

1. **Level 1 (Days 1–3)**: Complete `vimtutor`; master `hjkl`, modes (`i`, `Esc`), saving, quitting, and `u`.
2. **Level 2 (Weeks 1–2)**: Internalize operators, motions, text objects, visual mode, repeat (`.`), and search/replace.
3. **Level 3 (Weeks 3–4)**: Use buffers, splits, marks, macros, folds, and spell-check in real files.
4. **Level 4 (Week 5+)**: Move to **Neovim** configuration with Lua and add `Telescope`, Treesitter, and built-in LSP support as real needs arise.

## Official references

* [Official Vim Tutor source](https://github.com/vim/vim/blob/master/runtime/tutor/en/vim-01-beginner.tutor) — the lesson sequence summarized above.
* [Official Vim documentation](https://www.vim.org/docs.php) — start with `:help tutor` and `:help user-manual`.
* [Official Vim repository](https://github.com/vim/vim) — includes the tutor and user manual with every Vim distribution.
