# ZSH

My zsh configuration, part of my [dotfiles](https://github.com/dotfiles) but too big and expansive to symlink from the install script/deserves its own repository.

## Plugins

I have included plugins as submodules (see I can use them fine, just having my dotfiles pull in repos like this and still symlink them makes zero sense). The included plugins are listed below:

| Name                         | Function                                                                   |
| ---------------------------- | -------------------------------------------------------------------------- |
| alias-tips                   | reminds you of aliases you've made                                         |
| almostontop                  | clears the terminal with new command output                                |
| auto-ls                      | shows the directory's content you just `cd`'ed into                        |
| colorize                     | provides color to the output of various programs                           |
| zsh-256color                 | enables 256 format in zsh                                                  |
| zsh-async                    | async operations in zsh                                                    |
| zsh-auto-nvm                 | if `.nvmrc` is present, it automatically switches to the specified version |
| zsh-autoenv                  | `.env` file configuration automatically!                                   |
| zsh-autosuggestions          | suggests the command you are typing, politely                              |
| zsh-history-substring-search | makes finding commands you've entered faster                               |
| zsh-mouse                    | mouse support for zsh                                                      |
| zsh-syntax-highlighting      | syntax highlighting                                                        |

## Credit Where Its Due

[inspired by zshkit](http://wiki.github.com/bkerley/zshkit)
