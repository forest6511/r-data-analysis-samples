# 配布データが書籍の記述どおりかを検証する
#
#   docker run --rm -v "$PWD":/w -w /w rocker/tidyverse:4.6.1 Rscript tools/verify_data.R
#
# 本文の出力・図と1対1で対応する値を検査する。データを差し替えたときに
# 書籍と食い違っていないかを確認するためのもの。NG が1件でも出たら終了コード 1。
suppressMessages(library(tidyverse))
ok <- 0; ng <- 0
chk <- function(label, actual, expected) {
  hit <- isTRUE(all.equal(actual, expected))
  cat(if (hit) "OK  " else "NG  ", label, " 実測=", format(actual), " 本文=", format(expected), "\n", sep="")
  if (hit) ok <<- ok+1 else ng <<- ng+1
}

# ── 第9章 kokyaku.csv / juchu.csv（本文: 顧客マスタ・受注明細）
k <- read_csv("kokyaku.csv", show_col_types = FALSE)
chk("ch09 kokyaku 列名", paste(names(k), collapse=","), "顧客ID,顧客名,電話番号,郵便番号,メモ")
j <- read_csv("juchu.csv", show_col_types = FALSE)
chk("ch09 juchu 商品コード5通り", length(unique(j$商品コード)), 5L)

# ── 第10章 keiyaku.csv（本文: 契約日が和暦・スラッシュ・ドット）
ke <- read_csv("keiyaku.csv", show_col_types = FALSE)
chk("ch10 keiyaku 契約日は文字列", class(ke$契約日)[1], "character")
a <- read_csv("access.csv", show_col_types = FALSE)
chk("ch10 access 列名", paste(names(a), collapse=","), "記録ID,発生日時,画面,秒数")

# ── 第11章 uriage.csv（本文11.1: 売上が数値にならない）
u11 <- read_csv("uriage.csv", show_col_types = FALSE)
chk("ch11 売上が character", class(u11$売上)[1], "character")
u11b <- read_csv("uriage.csv", na = c("", "NA", "-"), show_col_types = FALSE)
chk("ch11 na指定で numeric", class(u11b$売上)[1], "numeric")

# ── 第19〜22章 uriage_2y.csv（verified_facts と照合）
u <- read_csv("uriage_2y.csv", show_col_types = FALSE)
chk("ch19 行数(5店舗x24か月)", nrow(u), 120L)
chk("ch19 店舗数", length(unique(u$店舗)), 5L)
chk("ch19 欠損2件", sum(is.na(u$売上)), 2L)
chk("ch19 売上の最大", max(u$売上, na.rm=TRUE), 8500000)
chk("ch19 次点", sort(u$売上, decreasing=TRUE)[2], 2236000)
na_rows <- u |> filter(is.na(売上))
chk("ch19 欠損は仙台店", paste(unique(na_rows$店舗), collapse=","), "仙台店")
chk("ch19 欠損は2025年6-7月", paste(na_rows$年, na_rows$月, collapse=" "), "2025 6 2025 7")

cat("\n== 合計: OK", ok, "/ NG", ng, "==\n")
quit(status = if (ng > 0) 1 else 0)
