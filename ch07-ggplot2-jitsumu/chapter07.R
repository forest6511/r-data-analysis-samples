# 第7章　ggplot2を実務品質に
#
# 『Rによるデータ分析 入門から実践』の第7章のサンプルコードです。
# リポジトリのルートを作業ディレクトリにして、上から順に実行してください。
#
# ※ 本文には、わざと失敗させてエラーメッセージを読むコードも載せています。
#    それらはこのファイルには含めていません（上から実行して止まらないようにするため）。
#    エラー例は本文を参照してください。

# ── block 01 ────────────────────────────────────────
library(tidyverse)
sales <- read_csv("sales.csv")

# ── block 02 ────────────────────────────────────────
monthly_store <- sales |>
  group_by(日付, 店舗) |>
  summarise(売上合計 = sum(売上), .groups = "drop")

monthly_store

# ── block 03 ────────────────────────────────────────
ggplot(monthly_store, aes(x = 日付, y = 売上合計, color = 店舗)) +
  geom_line()

# ── block 04 ────────────────────────────────────────
ggplot(monthly_store, aes(x = 日付, y = 売上合計, color = 店舗)) +
  geom_line() +
  scale_y_continuous(labels = scales::label_comma())

# ── block 05 ────────────────────────────────────────
f <- scales::label_comma()
f(c(3494000, 8147000))

# ── block 06 ────────────────────────────────────────
man <- scales::label_number(scale = 1/10000, suffix = "万円",
                            accuracy = 1, big.mark = ",")
man(c(12340000, 45678900))

# ── block 07 ────────────────────────────────────────
ggplot(monthly_store, aes(x = 日付, y = 売上合計, color = 店舗)) +
  geom_line() +
  scale_y_continuous(labels = man)

# ── block 08 ────────────────────────────────────────
man0 <- scales::label_number(scale = 1/10000, suffix = "万円", accuracy = 1)
man0(c(12340000, 45678900))

# ── block 09 ────────────────────────────────────────
options(scales.big.mark = ",")

# ── block 10 ────────────────────────────────────────
scales::label_currency(prefix = "¥", big.mark = ",")(1234000)

# ── block 11 ────────────────────────────────────────
ggplot(monthly_store, aes(x = 日付, y = 売上合計, color = 店舗)) +
  geom_line() +
  scale_y_continuous(labels = man) +
  labs(
    title = "店舗別の月次売上",
    subtitle = "2025年1月〜12月",
    x = NULL,
    y = "売上合計",
    color = "店舗",
    caption = "出典: 売上明細（sales.csv）"
  )

# ── block 12 ────────────────────────────────────────
sort(unique(sales$店舗))

# ── block 13 ────────────────────────────────────────
by_store <- sales |>
  group_by(店舗) |>
  summarise(売上合計 = sum(売上), .groups = "drop")

by_store

# ── block 14 ────────────────────────────────────────
levels(fct_reorder(by_store$店舗, by_store$売上合計))

# ── block 15 ────────────────────────────────────────
levels(fct_reorder(by_store$店舗, by_store$売上合計, .desc = TRUE))

# ── block 16 ────────────────────────────────────────
by_store |>
  mutate(店舗 = fct_reorder(店舗, 売上合計)) |>
  ggplot(aes(x = 売上合計, y = 店舗)) +
  geom_col() +
  scale_x_continuous(labels = man) +
  labs(title = "店舗別の年間売上", x = NULL, y = NULL)

# ── block 17 ────────────────────────────────────────
monthly_store |>
  mutate(店舗 = fct_reorder(店舗, 売上合計, .desc = TRUE)) |>
  ggplot(aes(x = 日付, y = 売上合計, color = 店舗)) +
  geom_line() +
  scale_y_continuous(labels = man) +
  labs(title = "店舗別の月次売上", x = NULL, y = "売上合計", color = NULL)

# ── block 18 ────────────────────────────────────────
monthly_store |>
  mutate(店舗 = fct_reorder(店舗, 売上合計, .desc = TRUE)) |>
  ggplot(aes(x = 日付, y = 売上合計, color = 店舗)) +
  geom_line() +
  scale_y_continuous(labels = man) +
  labs(title = "店舗別の月次売上", x = NULL, y = "売上合計", color = NULL) +
  theme_minimal()

# ── block 19 ────────────────────────────────────────
theme_minimal(base_size = 14)

# ── block 20 ────────────────────────────────────────
theme_set(theme_minimal(base_size = 12))

# ── block 21 ────────────────────────────────────────
# base_family は環境によって変えます（macOS: "Hiragino Sans" / Windows: "Yu Gothic"）。
# 本文は macOS の名前で書いています。ここでは環境にあるものを自動で選びます。
jp_font <- if ("Hiragino Sans" %in% systemfonts::system_fonts()$family) {
  "Hiragino Sans"
} else if ("Yu Gothic" %in% systemfonts::system_fonts()$family) {
  "Yu Gothic"
} else {
  ""   # 見つからなければ既定のフォント
}
theme_set(theme_minimal(base_size = 12, base_family = jp_font))

# ── block 22 ────────────────────────────────────────
monthly_store |>
  mutate(店舗 = fct_reorder(店舗, 売上合計, .desc = TRUE)) |>
  ggplot(aes(x = 日付, y = 売上合計, color = 店舗)) +
  geom_line() +
  scale_y_continuous(labels = man) +
  labs(title = "店舗別の月次売上", x = NULL, y = "売上合計", color = NULL) +
  theme_minimal() +
  theme(
    legend.position = "top",
    plot.title = element_text(face = "bold")
  )

# ── block 23 ────────────────────────────────────────
ggplot(monthly_store, aes(x = 日付, y = 売上合計, color = 店舗)) +
  geom_line() +
  theme(legend.postion = "top")

# ── block 24 ────────────────────────────────────────
g <- monthly_store |>
  mutate(店舗 = fct_reorder(店舗, 売上合計, .desc = TRUE)) |>
  ggplot(aes(x = 日付, y = 売上合計, color = 店舗)) +
  geom_line() +
  scale_y_continuous(labels = man) +
  labs(title = "店舗別の月次売上", x = NULL, y = "売上合計", color = NULL) +
  theme_minimal()

ggsave("monthly_store.png", g, width = 7, height = 4, dpi = 150)

# ── block 25 ────────────────────────────────────────
ggsave("monthly_store.png", g, width = 1050, height = 600,
       units = "px", dpi = 150)

# ── block 26 ────────────────────────────────────────
ggsave("monthly_store.png", g)

# ── block 30 ────────────────────────────────────────
ggsave("figures/monthly_store.png", g, width = 7, height = 4,
       create.dir = TRUE)

# ── block 31 ────────────────────────────────────────
theme_set(theme_minimal(base_size = 12))
man <- scales::label_number(scale = 1/10000, suffix = "万円",
                            accuracy = 1, big.mark = ",")

