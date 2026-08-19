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
- `ch01/` — 第1章「Rで何ができるのか」のスクリプト
- `ch02/` — 第2章「ggplot2で描く」の仕上げ例
- `tools/generate_sales.py` — sales.csv の再生成スクリプト（乱数不使用・毎回同じ内容を生成）
- `tools/generate_ch03_files.py` — sales.xlsx / sales.db の再生成スクリプト（sales.csv から導出・乱数不使用）

章のスクリプトは、リポジトリのルートを作業ディレクトリにして実行してください。

```r
source("ch01/monthly_report.R")
```

## 正誤・不具合

お気づきの点は [Issues](../../issues) からお知らせください。
