# 第5章　テーブル結合 joins
#
# 『Rによるデータ分析 入門から実践』の第5章のサンプルコードです。
# リポジトリのルートを作業ディレクトリにして、上から順に実行してください。
#
# ※ 本文には、わざと失敗させてエラーメッセージを読むコードも載せています。
#    それらはこのファイルには含めていません（上から実行して止まらないようにするため）。
#    エラー例は本文を参照してください。

# ── block 01 ────────────────────────────────────────
library(tidyverse)

sales  <- read_csv("sales.csv",  show_col_types = FALSE)
stores <- read_csv("stores.csv", show_col_types = FALSE)

# ── block 02 ────────────────────────────────────────
stores

# ── block 03 ────────────────────────────────────────
sales_by_store <- sales |>
  summarise(売上合計 = sum(売上), .by = 店舗)

sales_by_store

# ── block 04 ────────────────────────────────────────
left_join(sales_by_store, stores, by = join_by(店舗))

# ── block 05 ────────────────────────────────────────
left_join(sales_by_store, stores)

# ── block 06 ────────────────────────────────────────
left_join(sales_by_store, stores, by = "店舗")

# ── block 07 ────────────────────────────────────────
stores_renamed <- stores |> rename(店舗名 = 店舗)

left_join(sales_by_store, stores_renamed, by = join_by(店舗 == 店舗名))

# ── block 08 ────────────────────────────────────────
inner_join(sales_by_store, stores, by = join_by(店舗))

# ── block 09 ────────────────────────────────────────
right_join(sales_by_store, stores, by = join_by(店舗))

# ── block 10 ────────────────────────────────────────
full_join(sales_by_store, stores, by = join_by(店舗))

# ── block 11 ────────────────────────────────────────
sales_with_area <- left_join(sales, stores, by = join_by(店舗))

nrow(sales)
nrow(sales_with_area)

# ── block 12 ────────────────────────────────────────
targets <- read_csv("targets.csv", show_col_types = FALSE)

targets

# ── block 13 ────────────────────────────────────────
quarterly <- sales |>
  mutate(四半期 = quarter(日付)) |>
  summarise(売上合計 = sum(売上), .by = c(店舗, 四半期))

left_join(quarterly, targets, by = join_by(店舗, 四半期))

# ── block 14 ────────────────────────────────────────
left_join(quarterly, targets, by = join_by(四半期))

# ── block 15 ────────────────────────────────────────
left_join(quarterly, targets,
          by = join_by(店舗, 四半期),
          relationship = "many-to-one")

# ── block 17 ────────────────────────────────────────
before <- nrow(sales)
after  <- nrow(left_join(sales, stores, by = join_by(店舗)))

c(before = before, after = after)

# ── block 18 ────────────────────────────────────────
anti_join(sales_by_store, stores, by = join_by(店舗))

# ── block 19 ────────────────────────────────────────
anti_join(stores, sales_by_store, by = join_by(店舗))

# ── block 20 ────────────────────────────────────────
semi_join(sales_by_store, stores, by = join_by(店舗))

# ── block 21 ────────────────────────────────────────
a <- tibble(id = c("1", "2"), v = 1:2)
b <- tibble(id = c(1, 2), w = c("x", "y"))
# （このあと本文では、わざと失敗する例を実行しています）

# ── block 22 ────────────────────────────────────────
dirty <- stores |>
  mutate(店舗 = if_else(店舗 == "新宿店", "新宿店　", 店舗))

left_join(sales_by_store, dirty, by = join_by(店舗))

# ── block 23 ────────────────────────────────────────
left_join(sales_by_store,
          mutate(dirty, 店舗 = str_trim(店舗)),
          by = join_by(店舗))

# ── block 24 ────────────────────────────────────────
x <- tibble(k = c("a", NA), v = 1:2)
y <- tibble(k = c("a", NA), w = c("X", "Y"))

left_join(x, y, by = join_by(k))

# ── block 25 ────────────────────────────────────────
left_join(x, y, by = join_by(k), na_matches = "never")

# ── block 27 ────────────────────────────────────────
stores_dup <- stores |> mutate(売上合計 = 0)

left_join(sales_by_store, stores_dup, by = join_by(店舗))

# ── block 28 ────────────────────────────────────────
left_join(sales_by_store, stores_dup, by = join_by(店舗),
          suffix = c("_実績", "_マスタ"))

# ── block 29 ────────────────────────────────────────
left_join(sales_by_store, select(stores_dup, 店舗, 地域), by = join_by(店舗))

# ── block 30 ────────────────────────────────────────
h1 <- sales |> filter(店舗 == "新宿店") |> slice_head(n = 2)
h2 <- sales |> filter(店舗 == "大阪店") |> slice_head(n = 2)

bind_rows(h1, h2)

# ── block 31 ────────────────────────────────────────
bind_rows(新宿 = h1, 大阪 = h2, .id = "出典")

