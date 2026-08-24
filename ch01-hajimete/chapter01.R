# 第1章　Rで何ができるのか — 最初の30分
#
# 『Rによるデータ分析 入門から実践』の第1章のサンプルコードです。
# リポジトリのルートを作業ディレクトリにして、上から順に実行してください。
#
# ※ 本文には、わざと失敗させてエラーメッセージを読むコードも載せています。
#    それらはこのファイルには含めていません（上から実行して止まらないようにするため）。
#    エラー例は本文を参照してください。

# ── block 01 ────────────────────────────────────────
R.version.string

# ── block 02 ────────────────────────────────────────
(1980 - 1200) * 350

# ── block 03 ────────────────────────────────────────
uriage <- 1980 * 350
uriage

# ── block 04 ────────────────────────────────────────
uriage * 12

# ── block 05 ────────────────────────────────────────
kingaku <- c(1980, 2480, 980)
kingaku

# ── block 06 ────────────────────────────────────────
kingaku * 1.1

# ── block 07 ────────────────────────────────────────
mean(kingaku)

# ── block 08 ────────────────────────────────────────
length(kingaku)

# ── block 09 ────────────────────────────────────────
install.packages("tidyverse")

# ── block 10 ────────────────────────────────────────
library(tidyverse)

# ── block 11 ────────────────────────────────────────
sales <- read_csv("sales.csv")

# ── block 12 ────────────────────────────────────────
sales

# ── block 13 ────────────────────────────────────────
glimpse(sales)

# ── block 14 ────────────────────────────────────────
monthly <- sales |>
  group_by(日付) |>
  summarise(売上合計 = sum(売上))
monthly

# ── block 15 ────────────────────────────────────────
ggplot(monthly, aes(x = 日付, y = 売上合計)) +
  geom_line() +
  geom_point()

# ── block 16 ────────────────────────────────────────
ggplot(monthly, aes(x = 日付, y = 売上合計)) +
  geom_line() +
  geom_point() +
  scale_y_continuous(labels = scales::label_comma()) +
  labs(x = NULL, y = "売上合計（円）")

# ── block 17 ────────────────────────────────────────
ggsave("monthly_sales.png", width = 7, height = 4)

# ── block 18 ────────────────────────────────────────
sales |>
  group_by(店舗) |>
  summarise(年間売上 = sum(売上)) |>
  arrange(desc(年間売上))

# ── block 19 ────────────────────────────────────────
sales |>
  filter(店舗 == "オンライン", カテゴリ == "家電")

# ── block 20 ────────────────────────────────────────
# 月次売上レポート
library(tidyverse)

sales <- read_csv("sales.csv")

# 月別売上の集計
monthly <- sales |>
  group_by(日付) |>
  summarise(売上合計 = sum(売上))

# グラフを描いて保存
ggplot(monthly, aes(x = 日付, y = 売上合計)) +
  geom_line() +
  geom_point() +
  scale_y_continuous(labels = scales::label_comma()) +
  labs(x = NULL, y = "売上合計（円）")

ggsave("monthly_sales.png", width = 7, height = 4)

