# ZSH

My zsh configuration, part of my [dotfiles](https://github.com/dotfiles) but too big and expansive to symlink from the install script/deserves its own repository.

## Plugins

No longer feeling the need or desire to prove I can use submodules effectively (if jobs don't believe me, they can be pleasantly surprized) I am going to eliminate most of these and rewrite the functionality of them I want or need locally because:
- stability - I don't mess with code, it doesn't change or break
- neatness - submodules work well enough, but its not a neat process. 
- performance - rewriting these will give me a chance to consider the necessity of the plugin, eliminating stupid additions

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
- the `sh` and `env` files point to the configuration's components via loops, which are pointed to by `.zshrc` ad `.zshenv` files in their typical locations to this repos location
- shell will start at 0 and work its way through the numbers (never exceeding 100, at least not yet).
- Cases with multiple files per number will be sourced alphabetically 

## Multishell Returns

While I had been moving away from a multishell configuration due to specific items, I have found that actually for the vast majority of things, it simply makes more sense tp make these available across several shells (especially aliases) and can roll in here whatever specific things require this shell's features vs. the features available via posix or bash and vice versa in other contexts because: 

- maintaining parity of aliases across shells makes absolutely no sense
- there are relatively few features that are specific to these shells I end up using often, those that do come up can be successfully nested in that shell's configuration. Generally they are zsh shell specific and generally they are in this repo. 


## Credit Where Its Due

[inspired by zshkit](http://wiki.github.com/bkerley/zshkit)
