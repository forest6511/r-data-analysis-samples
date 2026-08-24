# 第3章　データ読み込み（CSV / Excel / DB）
#
# 『Rによるデータ分析 入門から実践』の第3章のサンプルコードです。
# リポジトリのルートを作業ディレクトリにして、上から順に実行してください。
#
# ※ 本文には、わざと失敗させてエラーメッセージを読むコードも載せています。
#    それらはこのファイルには含めていません（上から実行して止まらないようにするため）。
#    エラー例は本文を参照してください。

# ── block 01 ────────────────────────────────────────
library(tidyverse)

# ── block 02 ────────────────────────────────────────
sales <- read_csv("sales.csv")

# ── block 03 ────────────────────────────────────────
spec(sales)

# ── block 04 ────────────────────────────────────────
sales <- read_csv(
  "sales.csv",
  col_types = cols(
    日付 = col_date(),
    店舗 = col_character(),
    カテゴリ = col_character(),
    売上 = col_double()
  )
)
sales

# ── block 05 ────────────────────────────────────────
writeLines(c(
  "商品,価格",
  "りんご,120",
  "みかん,不明",
  "ばなな,98"
), "kakaku.csv")

kakaku <- read_csv("kakaku.csv", col_types = cols(価格 = col_double()))

# ── block 06 ────────────────────────────────────────
kakaku

# ── block 07 ────────────────────────────────────────
problems(kakaku)

# ── block 08 ────────────────────────────────────────
library(readxl)

# ── block 09 ────────────────────────────────────────
excel_sheets("sales.xlsx")

# ── block 10 ────────────────────────────────────────
uriage <- read_excel("sales.xlsx")
uriage

# ── block 11 ────────────────────────────────────────
uriage <- uriage |> mutate(日付 = as.Date(日付))
uriage

# ── block 12 ────────────────────────────────────────
read_excel("sales.xlsx", sheet = "店舗マスタ")

# ── block 13 ────────────────────────────────────────
read_excel("sales.xlsx", sheet = "月次報告")

# ── block 14 ────────────────────────────────────────
read_excel("sales.xlsx", sheet = "月次報告", skip = 3)

# ── block 15 ────────────────────────────────────────
read_excel("sales.xlsx", sheet = "月次報告", range = "A4:B16")

# ── block 16 ────────────────────────────────────────
read_excel("sales.xlsx", col_types = "text")

# ── block 17 ────────────────────────────────────────
install.packages("RSQLite")

# ── block 18 ────────────────────────────────────────
library(DBI)
con <- dbConnect(RSQLite::SQLite(), "sales.db")
dbListTables(con)

# ── block 19 ────────────────────────────────────────
dbGetQuery(con, "SELECT * FROM sales LIMIT 5")

# ── block 20 ────────────────────────────────────────
str(dbGetQuery(con, "SELECT * FROM sales LIMIT 5"))

# ── block 21 ────────────────────────────────────────
dbGetQuery(con, "
  SELECT 店舗, SUM(売上) AS 売上合計
  FROM sales
  GROUP BY 店舗
")

# ── block 22 ────────────────────────────────────────
zenken <- dbReadTable(con, "sales")
nrow(zenken)

# ── block 23 ────────────────────────────────────────
dbDisconnect(con)

# ── block 24 ────────────────────────────────────────
con <- dbConnect(RSQLite::SQLite(), "sales.db")
db_sales <- dbGetQuery(con, "SELECT * FROM sales") |>
  as_tibble() |>
  mutate(日付 = as.Date(日付))
dbDisconnect(con)
db_sales

# ── block 27 ────────────────────────────────────────
sales_base <- read.csv("sales.csv")
head(sales_base)

