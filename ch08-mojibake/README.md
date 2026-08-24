# 第8章　文字コードと文字化け

『Rによるデータ分析 入門から実践』の第8章のサンプルコードです。

## この章で使うデータ

- [`uriage_cp932.csv`](../uriage_cp932.csv)
- [`uriage_utf8.csv`](../uriage_utf8.csv)
- [`uriage_utf8_bom.csv`](../uriage_utf8_bom.csv)
- [`uriage_utf16le.csv`](../uriage_utf16le.csv)
- [`t_short.csv`](../t_short.csv)

## 章の構成

- **8.1** 同じ中身のファイルが読めない
- **8.2** 届いたファイルの文字コードを調べる
- **8.3** 正しく読み込む
- **8.4** エラーにならずに行が消える場合
- **8.5** 書き出すときの文字コード
- **8.6** 現在の環境を確認する
- **8.7** 実務での手順

## 実行のしかた

リポジトリのルートを作業ディレクトリにして実行してください（RStudio の Session → Set Working Directory → Choose Directory...）。

```r
source("ch08-mojibake/chapter08.R")
```

1行ずつ試したいときは、[`chapter08.R`](./chapter08.R) を開いて上から順に実行してください。

> **エラー例について**
> 本文の第8章には、わざと失敗させてエラーメッセージを読むコードが4箇所あります。
> このファイルには含めていません（上から実行して止まらないようにするため）。本文を参照してください。

[← 章の一覧に戻る](../README.md)
