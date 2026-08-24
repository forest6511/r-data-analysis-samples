# Rによるデータ分析の入門から実践 — サンプルコード

書籍『Rによるデータ分析の入門から実践 — データの読み込みから再現できる分析基盤まで』（森川 陽介）のサンプルコードとデータです。

## 動作環境

- R 4.6 以降
- tidyverse（dplyr 1.2 以降）

## 使い方

1. このリポジトリをダウンロードします（緑色の「Code」ボタン → 「Download ZIP」、または `git clone`）
2. 展開したフォルダを RStudio の作業ディレクトリに設定します（Session → Set Working Directory → Choose Directory...）
3. Files タブに `sales.csv` が見えていれば準備完了です

## 章の一覧

- [第1章　Rで何ができるのか — 最初の30分](./ch01-hajimete/)
- [第2章　ggplot2で描く](./ch02-ggplot2/)
- [第3章　データ読み込み（CSV / Excel / DB）](./ch03-yomikomi/)
- [第4章　dplyrで絞る・作る・集計する](./ch04-dplyr/)
- [第5章　テーブル結合 joins](./ch05-joins/)
- [第6章　tidyrで構造を変える](./ch06-tidyr/)
- [第7章　ggplot2を実務品質に](./ch07-ggplot2-jitsumu/)
- [第8章　文字コードと文字化け](./ch08-mojibake/)
- [第9章　文字列処理と正規表現](./ch09-moji-seiki/)
- [第10章　日付・時刻・和暦・年度](./ch10-hiduke-wareki/)
- [第11章　欠損値NAの伝播と型変換の事故](./ch11-na-kata/)
- [第12章　データ構造の正体](./ch12-data-kouzou/)
- [第13章　ネイティブパイプ |>](./ch13-native-pipe/)
- [第14章　関数を書く](./ch14-kansuu/)
- [第15章　反復処理 purrr/map](./ch15-purrr/)
- [第16章　エラーを設計する tryCatch](./ch16-trycatch/)
- [第17章　S3クラスとジェネリック関数](./ch17-s3-class/)
- [第18章　エラーの読み方とデバッグ](./ch18-debug/)
- [第19章　探索的データ分析（EDA）](./ch19-eda/)
- [第20章　統計的検定と回帰分析](./ch20-kentei-kaiki/)
- [第21章　Quartoでレポート自動化](./ch21-quarto/)（コードなし・本文の手順で進めます）
- [第22章　再現性（renv / プロジェクト構成）](./ch22-renv/)（コードなし・本文の手順で進めます）

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
- `uriage.csv` — 第11章で使う3店舗の月次売上（売上が空欄の行と `-` と書かれた行がある）
- `kokyaku.csv` — 第9章で使う顧客マスタ（名前・電話番号・郵便番号に全角と半角が混在）
- `juchu.csv` — 第9章で使う受注明細（同じ商品の商品コードが5通りの体裁）
- `keiyaku.csv` — 第10章で使う契約台帳（契約日が和暦・スラッシュ・ドット表記）
- `access.csv` — 第10章で使うアクセスログ（日時に時差の記載がない）
- `uriage_2y.csv` — 第19〜22章で使う5店舗 × 24か月の売上と客数（外れ値1件・欠損2件を含む）
- `ch01-hajimete/` 〜 `ch22-renv/` — 章ごとのサンプルコードと README
- `tools/generate_sales.py` — sales.csv の再生成スクリプト（乱数不使用・毎回同じ内容を生成）
- `tools/generate_ch03_files.py` — sales.xlsx / sales.db の再生成スクリプト（sales.csv から導出・乱数不使用）
- `tools/generate_ch05_files.py` — stores.csv / targets.csv の再生成スクリプト（乱数不使用）
- `tools/generate_ch08_files.py` — 第8章の文字コード違いのファイル群の再生成スクリプト（乱数不使用）
- `tools/generate_ch09_files.py` — kokyaku.csv / juchu.csv の再生成スクリプト（乱数不使用）
- `tools/generate_ch10_files.py` — keiyaku.csv / access.csv の再生成スクリプト（乱数不使用）

`uriage_2y.csv` には再生成スクリプトがありません。本文の出力・図と1対1で対応する数値を
含むため、ファイルそのものを配布しています（内容を変更すると第19〜22章の記述と図が合わなくなります）。

章のスクリプトは、リポジトリのルートを作業ディレクトリにして実行してください。

```r
source("ch01/monthly_report.R")
```

## データの検証

配布データが書籍の記述どおりかを確認できます。

```
docker run --rm -v "$PWD":/w -w /w rocker/tidyverse:4.6.1 Rscript tools/verify_data.R
```

## 正誤・不具合

お気づきの点は [Issues](../../issues) からお知らせください。
