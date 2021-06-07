#!/bin/sh

if [ -f ~/.zshrc ] || [ -h ~/.zshrc ] || [ -f ~/.zshenv ] || [ -h ~/.zshenv ]
then
  echo "You already have a Zsh configuration installed..."
  BACKUP_DIR="$HOME/zsh-config-backup-$(date +%Y%m%d%H%M)"
  if ! mkdir $BACKUP_DIR; then
      echo "Backup failed! (Backup directory $BACKUP_DIR already existing?) Exiting... :-("
      exit 1
  fi
  mv ~/.zsh.d  $BACKUP_DIR
  mv ~/.zshenv $BACKUP_DIR
  mv ~/.zshrc  $BACKUP_DIR
fi


echo "Creating symlinks..."
ln -s ~/.zsh/zshenv ~/.zshenv
ln -s ~/.zsh/zshrc ~/.zshrc

echo "Changing default shell to Zsh (will require password)..."
chsh -s `which zsh`

echo "\n \033[0;32mConfiguration installed. (Remember to set your PATH in ~/.zsh.d/10_exports.zsh.)"

echo "\n \033[0;32mStarting Zsh."
/usr/bin/env zsh
