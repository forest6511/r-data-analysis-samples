# 第6章　tidyrで構造を変える
#
# 『Rによるデータ分析 入門から実践』の第6章のサンプルコードです。
# リポジトリのルートを作業ディレクトリにして、上から順に実行してください。
#
# ※ 本文には、わざと失敗させてエラーメッセージを読むコードも載せています。
#    それらはこのファイルには含めていません（上から実行して止まらないようにするため）。
#    エラー例は本文を参照してください。

# ── block 01 ────────────────────────────────────────
library(tidyverse)

sales <- read_csv("sales.csv", show_col_types = FALSE)

quarterly <- sales |>
  mutate(四半期 = quarter(日付)) |>
  summarise(売上合計 = sum(売上), .by = c(店舗, 四半期))

# ── block 02 ────────────────────────────────────────
quarterly

# ── block 03 ────────────────────────────────────────
quarterly |>
  pivot_wider(names_from = 四半期, values_from = 売上合計)

# ── block 04 ────────────────────────────────────────
wide <- quarterly |>
  pivot_wider(names_from = 四半期, values_from = 売上合計, names_prefix = "Q")

wide

# ── block 05 ────────────────────────────────────────
明細 <- sales |>
  mutate(四半期 = quarter(日付)) |>
  select(店舗, 四半期, 売上)

明細

# ── block 06 ────────────────────────────────────────
明細 |>
  pivot_wider(names_from = 四半期, values_from = 売上)

# ── block 07 ────────────────────────────────────────
明細 |>
  summarise(n = n(), .by = c(店舗, 四半期)) |>
  filter(n > 1L)

# ── block 08 ────────────────────────────────────────
明細 |>
  pivot_wider(names_from = 四半期, values_from = 売上,
              names_prefix = "Q", values_fn = sum)

# ── block 09 ────────────────────────────────────────
wide |>
  pivot_longer(cols = Q1:Q4, names_to = "四半期", values_to = "売上合計")

# ── block 10 ────────────────────────────────────────
long <- wide |>
  pivot_longer(cols = starts_with("Q"), names_to = "四半期",
               names_prefix = "Q", values_to = "売上合計",
               names_transform = list(四半期 = as.integer))

long

# ── block 11 ────────────────────────────────────────
identical(quarterly, long)

# ── block 12 ────────────────────────────────────────
identical(arrange(quarterly, 店舗, 四半期), arrange(long, 店舗, 四半期))

# ── block 13 ────────────────────────────────────────
欠損あり <- quarterly |>
  filter(!(店舗 == "大阪店" & 四半期 == 3))

欠損あり |>
  pivot_wider(names_from = 四半期, values_from = 売上合計, names_prefix = "Q")

# ── block 14 ────────────────────────────────────────
欠損あり |>
  pivot_wider(names_from = 四半期, values_from = 売上合計,
              names_prefix = "Q", values_fill = 0)

# ── block 15 ────────────────────────────────────────
欠損あり |>
  complete(店舗, 四半期)

# ── block 16 ────────────────────────────────────────
欠損あり |>
  complete(店舗, 四半期, fill = list(売上合計 = 0))

# ── block 17 ────────────────────────────────────────
w <- 欠損あり |>
  pivot_wider(names_from = 四半期, values_from = 売上合計, names_prefix = "Q")

w |>
  mutate(Q3 = replace_na(Q3, 0))

# ── block 18 ────────────────────────────────────────
w |>
  drop_na()

# ── block 19 ────────────────────────────────────────
報告 <- tibble(
  店舗   = c("新宿店", NA, NA, "大阪店", NA),
  四半期 = c(1, 2, 3, 1, 2),
  売上   = c(10, 11, 12, 20, 21)
)

報告 |>
  fill(店舗)

# ── block 20 ────────────────────────────────────────
コード表 <- tibble(
  コード = c("13-新宿店-A", "27-大阪店-A", "99-オンライン-B"),
  売上   = c(59715000, 50766000, 74673000)
)

コード表 |>
  separate_wider_delim(コード, delim = "-",
                       names = c("都道府県", "店舗", "区分"))

# ── block 21 ────────────────────────────────────────
不揃い <- tibble(コード = c("13-新宿店-A", "27-大阪店-A-旧"))
# （このあと本文では、わざと失敗する例を実行しています）

# ── block 22 ────────────────────────────────────────
不揃い |>
  separate_wider_delim(コード, delim = "-",
                       names = c("都道府県", "店舗", "区分"),
                       too_many = "merge")

# ── block 23 ────────────────────────────────────────
コード表 |>
  separate_wider_delim(コード, delim = "-",
                       names = c("都道府県", "店舗", "区分")) |>
  unite("コード", 都道府県, 店舗, 区分, sep = "-")

# ── block 24 ────────────────────────────────────────
?separate

