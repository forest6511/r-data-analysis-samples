# 第10章　日付・時刻・和暦・年度
#
# 『Rによるデータ分析 入門から実践』の第10章のサンプルコードです。
# リポジトリのルートを作業ディレクトリにして、上から順に実行してください。

# ── block 01 ────────────────────────────────────────
library(tidyverse)
keiyaku <- read_csv("keiyaku.csv", show_col_types = FALSE)
keiyaku

# ── block 02 ────────────────────────────────────────
class(keiyaku$契約日)

# ── block 03 ────────────────────────────────────────
ymd(keiyaku$契約日)

# ── block 04 ────────────────────────────────────────
tibble(元 = keiyaku$契約日, 変換後 = suppressWarnings(ymd(keiyaku$契約日)))

# ── block 05 ────────────────────────────────────────
wareki_to_date <- function(x) {
  kiten <- c("令和" = 2018L, "平成" = 1988L, "昭和" = 1925L)
  m <- str_match(x, "^(令和|平成|昭和)(元|[0-9]+)年([0-9]+)月([0-9]+)日$")
  nen <- if_else(m[, 3] == "元", 1L, suppressWarnings(as.integer(m[, 3])))
  make_date(kiten[m[, 2]] + nen, as.integer(m[, 4]), as.integer(m[, 5]))
}

wareki_to_date(keiyaku$契約日)

# ── block 06 ────────────────────────────────────────
seiki <- function(x) {
  w <- wareki_to_date(x)
  y <- suppressWarnings(ymd(str_replace_all(x, "[./]", "-")))
  coalesce(w, y)
}

seiki(keiyaku$契約日)

# ── block 07 ────────────────────────────────────────
make_date(1988L + 31L, 5, 1)

# ── block 08 ────────────────────────────────────────
d <- as.Date(c("2026-03-31", "2026-04-01", "2026-12-31", "2027-01-01"))
tibble(日付 = d, 年 = year(d), 年度 = if_else(month(d) >= 4, year(d), year(d) - 1L))

# ── block 09 ────────────────────────────────────────
keiyaku |>
  mutate(契約日 = seiki(契約日),
         年度 = if_else(month(契約日) >= 4, year(契約日), year(契約日) - 1L)) |>
  count(年度)

# ── block 10 ────────────────────────────────────────
d <- as.Date(c("2026-04-01", "2026-07-01", "2026-10-01", "2027-01-01"))
tibble(日付 = d, 四半期 = (month(d) - 4L) %/% 3L %% 4L + 1L)

# ── block 11 ────────────────────────────────────────
as.Date("2026-01-31") + months(1)

# ── block 12 ────────────────────────────────────────
as.Date("2026-01-31") %m+% months(1)

# ── block 13 ────────────────────────────────────────
as.Date("2024-02-29") %m+% years(1)

# ── block 14 ────────────────────────────────────────
as.Date("2026-04-10") - as.Date("2026-04-01")

# ── block 15 ────────────────────────────────────────
as.numeric(as.Date("2026-04-10") - as.Date("2026-04-01"))

# ── block 16 ────────────────────────────────────────
access <- read_csv("access.csv", show_col_types = FALSE)
access

# ── block 17 ────────────────────────────────────────
tz(access$発生日時)

# ── block 18 ────────────────────────────────────────
head(access$発生日時, 2)

# ── block 19 ────────────────────────────────────────
access <- read_csv("access.csv", show_col_types = FALSE,
                   locale = locale(tz = "Asia/Tokyo"))
tz(access$発生日時)

# ── block 20 ────────────────────────────────────────
head(access$発生日時, 2)

