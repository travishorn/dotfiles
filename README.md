# Dotfiles

My configuration files for Arch Linux systems.

## Prerequisites

- [alacritty](https://github.com/alacritty/alacritty)
- [alsa-utils](https://github.com/alsa-project/alsa-utils)
- [dmenu](https://tools.suckless.org/dmenu/)
- [feh](https://feh.finalrewind.org/)
- [git](https://git-scm.com/)
- [numlockx](https://archlinux.org/packages/community/x86_64/numlockx/)
- [picom](https://github.com/yshui/picom)
- [ttf-fira-mono](https://github.com/mozilla/Fira)
- [vim](https://www.vim.org/)
- [xmobar](https://xmobar.org/)
- [xmonad](https://xmonad.org/)
- [xmonad-contrib](https://hackage.haskell.org/package/xmonad-contrib)
- [xorg-server](https://www.x.org/wiki/)
- [xorg-xinit](https://www.x.org/releases/X11R7.6/doc/man/man1/xinit.1.xhtml)

```bash
sudo pacman -S alacritty alsa-utils dmenu feh git numlockx picom ttf-fira-mono vim xmobar xmonad xmonad-contrib xorg-server xorg-xinit
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

git will tell you what files are about to be overwritten. Back up those files if
you wish, then force the checkout.

```bash
config checkout -f
```

Configure git to ignore untracked files in your home directory

```bash
config config --local status.showUntrackedFiles no
```

You'll probably need to recompile xmonad.

```bash
xmonad --recompile
```

## Usage

Run the window manager

```bash
startx
```

You can run it automatically on login, too. Add this to your `.bash_profile`

```bash
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
```

## Updating

When the configuration files change, you can update your system by pulling from
the remote repository.

```bash
config pull
```

## Modifying configuration files

When you change a configuration file, make sure to commit changes to the
repository. Use the `config` alias.

```bash
config add .vimrc
config commit -m "Description of changes"
config push
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

