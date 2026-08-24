# 第2章　ggplot2で描く
#
# 『Rによるデータ分析 入門から実践』の第2章のサンプルコードです。
# リポジトリのルートを作業ディレクトリにして、上から順に実行してください。
#
# ※ 本文には、わざと失敗させてエラーメッセージを読むコードも載せています。
#    それらはこのファイルには含めていません（上から実行して止まらないようにするため）。
#    エラー例は本文を参照してください。

# ── block 01 ────────────────────────────────────────
library(tidyverse)
sales <- read_csv("sales.csv")

# ── block 02 ────────────────────────────────────────
ggplot(sales, aes(x = 日付, y = 売上)) +
  geom_point()

# ── block 03 ────────────────────────────────────────
ggplot(sales, aes(x = 日付, y = 売上, color = 店舗)) +
  geom_point()

# ── block 04 ────────────────────────────────────────
monthly_store <- sales |>
  group_by(日付, 店舗) |>
  summarise(売上合計 = sum(売上))

# ── block 05 ────────────────────────────────────────
monthly_store

# ── block 06 ────────────────────────────────────────
ggplot(monthly_store, aes(x = 日付, y = 売上合計)) +
  geom_line()

# ── block 07 ────────────────────────────────────────
ggplot(monthly_store, aes(x = 日付, y = 売上合計, color = 店舗)) +
  geom_line()

# ── block 08 ────────────────────────────────────────
by_cat <- sales |>
  group_by(カテゴリ) |>
  summarise(売上合計 = sum(売上))
by_cat

# ── block 09 ────────────────────────────────────────
ggplot(by_cat, aes(x = カテゴリ, y = 売上合計)) +
  geom_col()

# ── block 10 ────────────────────────────────────────
ggplot(sales, aes(x = カテゴリ)) +
  geom_bar()

# ── block 11 ────────────────────────────────────────
store_cat <- sales |>
  group_by(店舗, カテゴリ) |>
  summarise(売上合計 = sum(売上))

ggplot(store_cat, aes(x = 店舗, y = 売上合計, fill = カテゴリ)) +
  geom_col()

# ── block 12 ────────────────────────────────────────
ggplot(store_cat, aes(x = 店舗, y = 売上合計, fill = カテゴリ)) +
  geom_col(position = "dodge")

# ── block 13 ────────────────────────────────────────
ggplot(sales, aes(x = 売上)) +
  geom_histogram()

# ── block 14 ────────────────────────────────────────
ggplot(sales, aes(x = 店舗, y = 売上)) +
  geom_boxplot()

# ── block 15 ────────────────────────────────────────
monthly_cat <- sales |>
  group_by(日付, カテゴリ) |>
  summarise(売上合計 = sum(売上))

ggplot(monthly_cat, aes(x = 日付, y = 売上合計)) +
  geom_line() +
  facet_wrap(~ カテゴリ)

# ── block 16 ────────────────────────────────────────
ggplot(monthly_store, aes(x = 日付, y = 売上合計, color = 店舗)) +
  geom_line() +
  geom_point() +
  scale_y_continuous(labels = scales::label_comma()) +
  labs(title = "店舗別の月次売上", x = NULL, y = "売上合計（円）")

ggsave("store_sales.png", width = 7, height = 4)

# ── block 18 ────────────────────────────────────────
ggplot(sales, aes(x = 日付, y = 売上, color = "blue")) +
  geom_point()

# ── block 19 ────────────────────────────────────────
ggplot(sales, aes(x = 日付, y = 売上)) +
  geom_point(color = "blue")

# ── block 21 ────────────────────────────────────────
sales |>
  filter(店舗 == "オンライン") |>
  ggplot(aes(x = 日付, y = 売上)) +
  geom_point()

# ── block 22 ────────────────────────────────────────
ggplot(monthly_store, aes(x = 日付, y = 売上合計, color = 店舗)) +
  geom_line(size = 1.2)

