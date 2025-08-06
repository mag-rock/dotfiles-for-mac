# Google Cloud CLI (gcloud) インストール手順（macOS）

2025年8月時点、Homebrew経由でのインストールに不具合があるため、公式手順によるインストールを推奨します。

## 1. アーカイブのダウンロード
Apple Silicon (M1/M2/M3等) の場合:

```
curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-darwin-arm.tar.gz
```

Intel Macの場合:

```
curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-darwin-x86_64.tar.gz
```

## 2. 展開
```
tar -xf google-cloud-cli-darwin-*.tar.gz
```

## 3. インストールスクリプトの実行
```
./google-cloud-sdk/install.sh
```

プロンプトに従い、PATH追加や補完設定を有効化してください。

**注意: google-cloud-sdkディレクトリはホームディレクトリ（~/）に配置することを推奨します。**


## 4. シェル設定ファイルへの追記（PATH・補完）
`~/.zshrc.darwin` などに以下を追記してください（本リポジトリでは自動追記済み）。

```
# Google Cloud CLI
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
  source "$HOME/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then
  source "$HOME/google-cloud-sdk/completion.zsh.inc"
fi
```

## 5. 初期化
新しいターミナルで
```
gcloud init
```
を実行し、Googleアカウントで認証・初期設定を行います。

---

参考: https://cloud.google.com/sdk/docs/install?hl=ja
