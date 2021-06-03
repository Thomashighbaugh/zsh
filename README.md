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


## Structure
This reposiotry conforms to an organization method often seen in larger system configurations, like fontconfig, which are composed of numbered files, the numbers not indicating their ordinal ranking but instead being the indicator, primarily, of general pole position (to use an analogy) or the batch of files being looped through by the statement grafting them on to the shell, loops contained within the `rc` and `env` files. 

Looping as means of sourcing these files has the orimary advantage of liberating the author from having to maintain a list of manually sourced files that one can easily forget some member there of, or leave a deleted member on prompting various errors of a particular order of painful to debug. 

It works as such: 
- the `sh` and `env` files point to the configuration's components via loops, which are pointed to by `.zshrc` ad `.zshenv` files in their typical locations to tthis repos location
- shell will start at 0 and work its way through the numbers (never exceeding 100, at least not yet).
- Cases with multiple files per number will be sourced alphabetically 

### Topical Files

Additionally, the *topical* focus of the files is more in line with the idea of modularity that makes object oreintation such a particular favorite of mine, and also files from repositories conforming to this style should lend themselves to being easily grafted unto your own configuation. 

This is in direct contrast to the functionality > topical means I had used prior and while the taxonomy is arbitrary, so far it has proven much easier to conceptualize (thus easier to piece together in one's head) and is more easily examined when debugging is necessary. 

### Twilight of My Multishell Configuration
Due to differences in how the shells I use (`sh`, `bash`, `zsh`) render various commands and handle various structures, I am moving away from a more multishell configuration and towards one specific to `zsh` (and soon likely a specific `bash` configuration even if it means reusing the code) primarily to enable access to the zsh specific features more reliably and due to the ease of sharing files between separate configurations enabled by the *modular*, *topical* method herein expressed. 

## Credit Where Its Due

[inspired by zshkit](http://wiki.github.com/bkerley/zshkit)
