# 第8章　文字コードと文字化け
#
# 『Rによるデータ分析 入門から実践』の第8章のサンプルコードです。
# リポジトリのルートを作業ディレクトリにして、上から順に実行してください。
#
# ※ 本文には、わざと失敗させてエラーメッセージを読むコードも載せています。
#    それらはこのファイルには含めていません（上から実行して止まらないようにするため）。
#    エラー例は本文を参照してください。

# ── block 02 ────────────────────────────────────────
read.csv("uriage_cp932.csv", fileEncoding = "CP932")

# ── block 03 ────────────────────────────────────────
library(tidyverse)
guess_encoding("uriage_cp932.csv")

# ── block 04 ────────────────────────────────────────
guess_encoding("t_short.csv")

# ── block 06 ────────────────────────────────────────
readBin("uriage_utf8_bom.csv", "raw", 8)

# ── block 07 ────────────────────────────────────────
read.csv("uriage_cp932.csv", fileEncoding = "CP932")

# ── block 08 ────────────────────────────────────────
read_csv("uriage_cp932.csv", locale = locale(encoding = "CP932"),
         show_col_types = FALSE)

# ── block 09 ────────────────────────────────────────
read_csv("uriage_utf8_bom.csv", show_col_types = FALSE) |> names()

# ── block 10 ────────────────────────────────────────
read.csv("uriage_utf8_bom.csv") |> names()

# ── block 12 ────────────────────────────────────────
read_csv("uriage_utf16le.csv", locale = locale(encoding = "UTF-16LE"),
         show_col_types = FALSE)

# ── block 13 ────────────────────────────────────────
read_tsv("uriage_utf16le.csv", locale = locale(encoding = "UTF-16LE"),
         show_col_types = FALSE)

# ── block 14 ────────────────────────────────────────
read.csv("uriage_utf8.csv", fileEncoding = "CP932")

# ── block 16 ────────────────────────────────────────
x <- "\x93\xfa\x95t"
Encoding(x)

# ── block 17 ────────────────────────────────────────
iconv(x, from = "CP932", to = "UTF-8")

# ── block 18 ────────────────────────────────────────
iconv("譌.莉", from = "UTF-8", to = "UTF-8")

# ── block 19 ────────────────────────────────────────
d <- read_csv("uriage_cp932.csv", locale = locale(encoding = "CP932"),
              show_col_types = FALSE)

write.csv(d, "out_default.csv", row.names = FALSE)
write.csv(d, "out_cp932.csv", row.names = FALSE, fileEncoding = "CP932")
write_excel_csv(d, "out_excel.csv")

# ── block 20 ────────────────────────────────────────
for (f in c("out_default.csv", "out_cp932.csv", "out_excel.csv")) {
  cat(f, ":", paste(readBin(f, "raw", 8), collapse = " "), "\n")
}

# ── block 21 ────────────────────────────────────────
d <- tibble(a = c("正常", "\U0001F600", "次の行"))
write.csv(d, "e.csv", row.names = FALSE, fileEncoding = "CP932")

# ── block 22 ────────────────────────────────────────
read.csv("e.csv", fileEncoding = "CP932")

# ── block 23 ────────────────────────────────────────
Sys.getlocale("LC_CTYPE")

# ── block 24 ────────────────────────────────────────
l10n_info()

