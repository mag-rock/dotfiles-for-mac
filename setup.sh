#!/bin/bash

set -e

echo "======================================"
echo "  dotfiles セットアップスクリプト"
echo "======================================"
echo ""

# 現在のディレクトリを取得
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# カラー設定
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Homebrewのチェック
if ! command -v brew &> /dev/null; then
    echo -e "${RED}エラー: Homebrewがインストールされていません${NC}"
    echo "以下のコマンドでHomebrewをインストールしてください:"
    echo '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
    exit 1
fi

echo -e "${GREEN}✓ Homebrewが見つかりました${NC}"
echo ""

# バックアップディレクトリの作成
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
echo -e "${YELLOW}既存の設定ファイルは $BACKUP_DIR にバックアップされます${NC}"
echo ""

# 設定ファイルのコピー
copy_dotfile() {
    local file=$1
    local target=$2

    if [ -f "$target" ]; then
        echo "  バックアップ: $target -> $BACKUP_DIR/"
        cp "$target" "$BACKUP_DIR/"
    fi

    echo "  コピー: $file -> $target"
    cp "$DOTFILES_DIR/$file" "$target"
}

echo "設定ファイルをコピーしています..."
copy_dotfile ".gitconfig" "$HOME/.gitconfig"
copy_dotfile ".zshrc" "$HOME/.zshrc"
copy_dotfile ".zshrc.darwin" "$HOME/.zshrc.darwin"
echo -e "${GREEN}✓ 設定ファイルのコピーが完了しました${NC}"
echo ""

# Karabiner Elementsの設定
if [ -d "$DOTFILES_DIR/karabiner" ]; then
    echo "Karabiner Elementsの設定をコピーしています..."
    mkdir -p "$HOME/.config/karabiner"

    if [ -d "$HOME/.config/karabiner" ]; then
        cp -r "$HOME/.config/karabiner" "$BACKUP_DIR/" 2>/dev/null || true
    fi

    cp -r "$DOTFILES_DIR/karabiner"/* "$HOME/.config/karabiner/"
    echo -e "${GREEN}✓ Karabiner Elementsの設定が完了しました${NC}"
    echo ""
fi

# Brewfileからパッケージをインストール
echo "Homebrewパッケージをインストールしています..."
echo "（この処理には時間がかかる場合があります）"
brew bundle --file="$DOTFILES_DIR/Brewfile"
echo -e "${GREEN}✓ Homebrewパッケージのインストールが完了しました${NC}"
echo ""

# zsh-completion用のパーミッション設定
echo "zsh-completionのパーミッションを設定しています..."
if [ -d "/opt/homebrew/share" ]; then
    chmod -R go-w '/opt/homebrew/share' 2>/dev/null || true
    echo -e "${GREEN}✓ パーミッション設定が完了しました${NC}"
fi
echo ""

# zcompのキャッシュをクリア
echo "zsh補完キャッシュをクリアしています..."
rm -f "$HOME/.zcompdump"
echo -e "${GREEN}✓ キャッシュクリアが完了しました${NC}"
echo ""

echo "======================================"
echo -e "${GREEN}セットアップが完了しました！${NC}"
echo "======================================"
echo ""
echo "次のコマンドで設定を反映してください:"
echo "  source ~/.zshrc"
echo ""
echo "または、ターミナルを再起動してください。"
echo ""
echo -e "${YELLOW}注意事項:${NC}"
echo "- Gitのユーザー名とメールアドレスは必要に応じて変更してください"
echo "  ~/.gitconfig を編集するか、以下のコマンドを実行してください:"
echo '  git config --global user.name "Your Name"'
echo '  git config --global user.email "your.email@example.com"'
