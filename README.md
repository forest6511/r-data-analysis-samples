# Rによるデータ分析の入門から実践 — サンプルコード

書籍『Rによるデータ分析の入門から実践 — データの読み込みから再現できる分析基盤まで』（森川 陽介）のサンプルコードとデータです。

## 動作環境

- R 4.6 以降
- tidyverse（dplyr 1.2 以降）

## 使い方

1. このリポジトリをダウンロードします（緑色の「Code」ボタン → 「Download ZIP」、または `git clone`）
2. 展開したフォルダを RStudio の作業ディレクトリに設定します（Session → Set Working Directory → Choose Directory...）
3. Files タブに `sales.csv` が見えていれば準備完了です

## ファイル構成

- `sales.csv` — 本書全体で使う売上データ（3店舗 × 4カテゴリ × 12か月 = 144行）
- `sales.xlsx` — 第3章で使う Excel 版の売上データ（シート: 売上データ / 店舗マスタ / 月次報告）
- `sales.db` — 第3章で使う SQLite 版の売上データ（テーブル: sales / stores）
- `stores.csv` — 第5章で使う店舗マスタ（3行。sales.csv とは店舗の顔ぶれが一致しない）
- `targets.csv` — 第5章で使う店舗 × 四半期の売上目標（12行）
- `uriage_cp932.csv` — 第8章で使う売上表。CP932（Windows の Excel が既定で書き出す形）
- `uriage_utf8.csv` — 同じ中身を UTF-8（BOM なし）で書いたもの
- `uriage_utf8_bom.csv` — 同じ中身を UTF-8（BOM 付き。Excel の「CSV UTF-8」）で書いたもの
- `uriage_utf16le.csv` — 同じ中身を UTF-16LE のタブ区切り（Excel の「Unicode テキスト」）で書いたもの
- `t_short.csv` — 第8章で使う短い CP932 のファイル（guess_encoding が外す例）
- `ch01/` — 第1章「Rで何ができるのか」のスクリプト
- `ch02/` — 第2章「ggplot2で描く」の仕上げ例
- `tools/generate_sales.py` — sales.csv の再生成スクリプト（乱数不使用・毎回同じ内容を生成）
- `tools/generate_ch03_files.py` — sales.xlsx / sales.db の再生成スクリプト（sales.csv から導出・乱数不使用）
- `tools/generate_ch05_files.py` — stores.csv / targets.csv の再生成スクリプト（乱数不使用）
- `tools/generate_ch08_files.py` — 第8章の文字コード違いのファイル群の再生成スクリプト（乱数不使用）

章のスクリプトは、リポジトリのルートを作業ディレクトリにして実行してください。

```r
source("ch01/monthly_report.R")
```

## 正誤・不具合

お気づきの点は [Issues](../../issues) からお知らせください。
