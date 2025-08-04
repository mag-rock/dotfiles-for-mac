# dotfiles
cp ./.gitconfig ~/
cp ./.zshrc ~/
cp ./.zshrc.darwin ~/
source ~/.zshrc
brew bundle --file=./Brewfile

# zsh-completion用
chmod -R go-w '/opt/homebrew/share'