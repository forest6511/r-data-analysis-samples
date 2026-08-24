# 第15章　反復処理 purrr/map
#
# 『Rによるデータ分析 入門から実践』の第15章のサンプルコードです。
# リポジトリのルートを作業ディレクトリにして、上から順に実行してください。

# ── block 01 ────────────────────────────────────────
library(tidyverse)

# ── block 02 ────────────────────────────────────────
kekka <- c()
for (i in 1:3) {
  kekka <- c(kekka, i * 2)
}
kekka

# ── block 03 ────────────────────────────────────────
map_dbl(1:3, \(x) x * 2)

# ── block 04 ────────────────────────────────────────
map_dbl(1:3, \(x) x * 2)
map_dbl(1:3, ~ .x * 2)

# ── block 05 ────────────────────────────────────────
map_dbl(c(1, 4, 9), sqrt)

# ── block 06 ────────────────────────────────────────
g <- function(n) seq_len(n)
class(sapply(c(1, 1), g))
class(sapply(c(2, 2), g))
class(sapply(2:3, g))

# ── block 07 ────────────────────────────────────────
sapply(c(2, 2), g)

# ── block 08 ────────────────────────────────────────
class(map(c(1, 1), g))
class(map(2:3, g))

# ── block 09 ────────────────────────────────────────
map_chr(c("札幌", "仙台"), \(x) paste0(x, "店"))
map_lgl(c(1, 5, 3), \(x) x > 2)

# ── block 12 ────────────────────────────────────────
map_dbl(1:2, \(i) as.Date("2026-01-01") + i)

# ── block 13 ────────────────────────────────────────
map_vec(1:2, \(i) as.Date("2026-01-01") + i)

# ── block 14 ────────────────────────────────────────
map2_chr(c("札幌", "仙台"), c(100, 200), \(x, y) paste0(x, "：", y, "万円"))

# ── block 16 ────────────────────────────────────────
pmap_chr(list(c("A", "B"), c(1, 2), c("x", "y")), \(a, b, c) paste0(a, b, c))

# ── block 17 ────────────────────────────────────────
imap_chr(c(a = 1, b = 2), \(x, nm) paste0(nm, "=", x))

# ── block 18 ────────────────────────────────────────
d <- tibble(金額 = c(100, NA, 300), 数量 = c(1, 2, NA))
imap_chr(d, \(col, nm) paste0(nm, "の欠損: ", sum(is.na(col)), "件"))

# ── block 19 ────────────────────────────────────────
map(1:3, \(i) tibble(id = i, 値 = i * 10)) |> list_rbind()

# ── block 20 ────────────────────────────────────────
map(1:3, \(i) rep(i, i)) |> list_c()

# ── block 21 ────────────────────────────────────────
dir.create("uriage", showWarnings = FALSE)
write_csv(tibble(商品 = "A", 金額 = 100), "uriage/2026-01.csv")
write_csv(tibble(商品 = "B", 金額 = 200), "uriage/2026-02.csv")
write_csv(tibble(商品 = "C", 金額 = 300), "uriage/2026-03.csv")
list.files("uriage", pattern = "\\.csv$", full.names = TRUE)

# ── block 22 ────────────────────────────────────────
files <- list.files("uriage", pattern = "\\.csv$", full.names = TRUE)
files |>
  set_names(basename) |>
  map(read_csv, show_col_types = FALSE) |>
  list_rbind(names_to = "ファイル")

# ── block 23 ────────────────────────────────────────
read_csv(files, id = "path", show_col_types = FALSE)

# ── block 24 ────────────────────────────────────────
d <- tibble(a = c(1, 5, 3), b = c(4, 2, 6), c = c(7, 8, 9))
d |> mutate(m = max(c(a, b, c)))

# ── block 25 ────────────────────────────────────────
d |> mutate(m = pmap_dbl(list(a, b, c), max))

# ── block 26 ────────────────────────────────────────
d |> rowwise() |> mutate(m = max(a, b, c)) |> ungroup()

# ── block 27 ────────────────────────────────────────
d |> mutate(m = pmax(a, b, c))

# ── block 28 ────────────────────────────────────────
kekka <- walk(1:2, \(x) cat("処理:", x, "\n"))
kekka

# ── block 29 ────────────────────────────────────────
dir.create("tenpo", showWarnings = FALSE)
d2 <- tibble(店舗 = c("札幌", "仙台"), 金額 = c(100, 200))
d2 |>
  split(d2$店舗) |>
  iwalk(\(x, nm) write_csv(x, paste0("tenpo/", nm, ".csv")))
list.files("tenpo")

# ── block 30 ────────────────────────────────────────
安全な平方根 <- possibly(\(x) if (x < 0) stop("負です") else sqrt(x),
                        otherwise = NA_real_)
map_dbl(c(4, -1, 9), 安全な平方根)

# ── block 31 ────────────────────────────────────────
安全な処理 <- safely(\(x) if (x < 0) stop("負です") else sqrt(x))
kekka2 <- map(c(4, -1), 安全な処理)
kekka2[[2]]$error$message

# ── block 32 ────────────────────────────────────────
keep(1:10, \(x) x %% 3 == 0)

# ── block 33 ────────────────────────────────────────
reduce(1:5, `+`)

# ── block 34 ────────────────────────────────────────
accumulate(1:5, `+`)

# ── block 35 ────────────────────────────────────────
list(
  tibble(id = 1:2, a = c("x", "y")),
  tibble(id = 1:2, b = c(10, 20)),
  tibble(id = 1:2, c = c(TRUE, FALSE))
) |> reduce(left_join, by = "id")

# ── block 36 ────────────────────────────────────────
map(1:2, \(i) map_dbl(1:3, \(j) i * j))

# ── block 37 ────────────────────────────────────────
expand_grid(i = 1:2, j = 1:3) |> mutate(積 = i * j)

