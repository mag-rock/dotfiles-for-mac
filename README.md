# dotfiles

macOS用の個人的なdotfilesリポジトリ

## 前提条件

- macOS (Apple Silicon推奨)
- [Homebrew](https://brew.sh/)がインストールされていること

## セットアップ

### 自動セットアップ（推奨）

```bash
git clone https://github.com/ytk/dotfiles.git ~/workspace/dotfiles
cd ~/workspace/dotfiles
./setup.sh
```

### 手動セットアップ

```bash
# 設定ファイルのコピー
cp ./.gitconfig ~/
cp ./.zshrc ~/
cp ./.zshrc.darwin ~/

# Homebrewパッケージのインストール
brew bundle --file=./Brewfile

# zsh-completion用のパーミッション設定
chmod -R go-w '/opt/homebrew/share'

# zsh設定の読み込み
source ~/.zshrc
```

## 含まれる設定

### Git ([.gitconfig](.gitconfig))
- ユーザー設定
- エイリアス（st, co, br, lg など）
- デフォルトブランチ: main
- カラー設定

### Zsh ([.zshrc](.zshrc), [.zshrc.darwin](.zshrc.darwin))
- zsh-completions
- zsh-autosuggestions
- zsh-syntax-highlighting
- Git promptの表示
- カスタムエイリアス
- キーバインディング（⌥←/→でワード移動、cmd+←/→で行頭/行末）

### Brewfile ([Brewfile](Brewfile))
インストールされるアプリケーション：
- 開発ツール: git, volta, uv, google-cloud-sdk
- エディタ/IDE: Visual Studio Code, WebStorm, IntelliJ IDEA
- データベースツール: DBeaver, TablePlus
- コミュニケーション: Slack, Zoom, Discord, LINE
- ユーティリティ: Docker, Alfred, Karabiner Elements, Obsidian

## トラブルシューティング

### zsh-completion関連のエラー

```bash
chmod -R go-w '/opt/homebrew/share'
rm -f ~/.zcompdump
autoload -Uz compinit && compinit
```

### git-prompt.shが見つからない

Gitのバージョンを確認し、[.zshrc.darwin](.zshrc.darwin:114)のパスを調整してください。

```bash
ls /opt/homebrew/Cellar/git/
```

### Google Cloud SDKのパス

[.zshrc.darwin](.zshrc.darwin:2)でGoogle Cloud SDKのパスを確認し、必要に応じて調整してください。

## カスタマイズ

個人情報（Gitのユーザー名・メールアドレスなど）は使用前に変更してください。

## 参考資料

- [gcloud_install_memo.md](gcloud_install_memo.md) - Google Cloud SDKのインストール手順