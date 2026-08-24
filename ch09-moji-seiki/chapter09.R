# 第9章　文字列処理と正規表現
#
# 『Rによるデータ分析 入門から実践』の第9章のサンプルコードです。
# リポジトリのルートを作業ディレクトリにして、上から順に実行してください。

# ── block 01 ────────────────────────────────────────
library(tidyverse)
juchu <- read_csv("juchu.csv", show_col_types = FALSE)
juchu

# ── block 02 ────────────────────────────────────────
count(juchu, 商品コード)

# ── block 03 ────────────────────────────────────────
x <- c("03-1234-5678", "０３－２２２２－３３３３")
nchar(x)

# ── block 04 ────────────────────────────────────────
str_detect(x, "^0")

# ── block 05 ────────────────────────────────────────
kokyaku <- read_csv("kokyaku.csv", show_col_types = FALSE)
str_detect(kokyaku$顧客名, " ")

# ── block 06 ────────────────────────────────────────
str_detect(kokyaku$顧客名, "　")

# ── block 07 ────────────────────────────────────────
str_squish(kokyaku$顧客名)

# ── block 08 ────────────────────────────────────────
stringi::stri_trans_general(x, "Fullwidth-Halfwidth")

# ── block 09 ────────────────────────────────────────
stringi::stri_trans_general("株式会社ヤマダ商事", "Fullwidth-Halfwidth")

# ── block 10 ────────────────────────────────────────
stringi::stri_trans_general("ABC123-x", "Halfwidth-Fullwidth")

# ── block 11 ────────────────────────────────────────
kokyaku$郵便番号

# ── block 12 ────────────────────────────────────────
str_replace_all(kokyaku$郵便番号, "[^0-9]", "")

# ── block 13 ────────────────────────────────────────
str_extract(kokyaku$電話番号, "[0-9]+")

# ── block 14 ────────────────────────────────────────
seiki <- function(x) {
  x |>
    stringi::stri_trans_general("Fullwidth-Halfwidth") |>
    str_to_upper() |>
    str_replace_all("[^A-Z0-9]", "")
}

juchu |>
  mutate(コード = seiki(商品コード)) |>
  count(コード)

# ── block 15 ────────────────────────────────────────
code <- stringi::stri_trans_general(juchu$商品コード, "Fullwidth-Halfwidth")
str_match(code, "^([A-Za-z]+)-?([0-9]+)$")

# ── block 16 ────────────────────────────────────────
d <- tibble(code = c("AB-0012", "CD-0034"))
separate_wider_regex(d, code, patterns = c(区分 = "[A-Z]+", "-", 番号 = "[0-9]+"))

# ── block 17 ────────────────────────────────────────
str_split_1("飲料|菓子|日用品", fixed("|"))

# ── block 18 ────────────────────────────────────────
str_detect(kokyaku$メモ, "変更")

# ── block 19 ────────────────────────────────────────
kokyaku |> filter(str_detect(メモ, "変更"))

# ── block 20 ────────────────────────────────────────
kokyaku |> filter(!str_detect(メモ, "変更"))

# ── block 21 ────────────────────────────────────────
kokyaku |> filter(!str_detect(replace_na(メモ, ""), "変更"))

# ── block 22 ────────────────────────────────────────
str_c(kokyaku$顧客ID, ":", kokyaku$メモ)

# ── block 23 ────────────────────────────────────────
paste(kokyaku$顧客ID, ":", kokyaku$メモ)

# ── block 24 ────────────────────────────────────────
str_length(kokyaku$顧客名)

# ── block 25 ────────────────────────────────────────
str_detect(c("A.B", "AXB"), fixed("A.B"))

# ── block 26 ────────────────────────────────────────
str_detect(c("A.B", "AXB"), "A.B")

