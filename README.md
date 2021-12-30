# Dotfiles

## Prerequisites

- alacritty
- feh
- git
- picom
- ttf-fira-mono
- vim
- xmobar
- xmonad
- xmonad-contrib
- xorg-server
- xorg-xinit

```bash
sudo pacman -S alacritty feh git picom ttf-fira-mono vim xmobar xmonad xmonad-contrib xorg-server xorg-xinit
```

## Installation

Add alias to `.bashrc`

```bash
echo "alias config='/usr/bin/git --git-dir=$HOME/.config/dotfiles --work-tree=$HOME'" >> ~/.bashrc
```

Reload `.bashrc`

```bash
. ~/.bashrc
```

Tell git to ignore the incoming repo files to avoid recursion problems

```bash
echo ".config/dotfiles" >> .gitignore
```

Clone into a bare repository

```bash
git clone --bare https://github.com/travishorn/dotfiles $HOME/.config/dotfiles
```

Check out the dotfiles

```bash
config checkout
```

If git complains that files would be overwritten, simply back them up and
remove them from your system. Re-run the checkout when you've removed them.

Configure git to ignore untracked files in your home directory

```bash
config config --local status.showUntrackedFiles no
```

## License

The MIT License

Copyright 2021 Travis Horn

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

