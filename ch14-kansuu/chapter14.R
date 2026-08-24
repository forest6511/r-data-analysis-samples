# 第14章　関数を書く
#
# 『Rによるデータ分析 入門から実践』の第14章のサンプルコードです。
# リポジトリのルートを作業ディレクトリにして、上から順に実行してください。

# ── block 01 ────────────────────────────────────────
library(tidyverse)

# ── block 02 ────────────────────────────────────────
uriage <- tibble(
  店舗 = c("札幌", "那覇", "札幌", "那覇"),
  売上 = c(100, 200, 300, 150),
  費用 = c(60, 90, 150, 80)
)
sapporo <- uriage |> filter(店舗 == "札幌")
sum(sapporo$売上) - sum(sapporo$費用)

# ── block 03 ────────────────────────────────────────
naha <- uriage |> filter(店舗 == "那覇")
sum(naha$売上) - sum(naha$費用)

# ── block 04 ────────────────────────────────────────
rieki <- function(df, tenpo) {
  d <- df |> filter(店舗 == tenpo)
  sum(d$売上) - sum(d$費用)
}
rieki(uriage, "札幌")

# ── block 05 ────────────────────────────────────────
rieki(uriage, "那覇")

# ── block 06 ────────────────────────────────────────
関数名 <- function(引数1, 引数2) {
  処理
}

# ── block 07 ────────────────────────────────────────
baisu <- function(x) {
  x * 2
}
baisu(5)

# ── block 08 ────────────────────────────────────────
baisu2 <- function(x) {
  return(x * 2)
}
baisu2(5)

# ── block 09 ────────────────────────────────────────
anzen_rieki <- function(df, tenpo) {
  d <- df |> filter(店舗 == tenpo)
  if (nrow(d) == 0) {
    return(NA)
  }
  sum(d$売上) - sum(d$費用)
}
anzen_rieki(uriage, "存在しない店舗")

# ── block 10 ────────────────────────────────────────
youyaku <- function(x) {
  list(平均 = mean(x), 件数 = length(x))
}
r <- youyaku(c(100, 200, 300))
r$平均

# ── block 11 ────────────────────────────────────────
r$件数

# ── block 12 ────────────────────────────────────────
youyaku2 <- function(df) {
  df |> summarise(平均 = mean(売上), 件数 = n())
}
uriage |> youyaku2()

# ── block 13 ────────────────────────────────────────
zeikomi <- function(x, rate = 0.1) {
  x * (1 + rate)
}
zeikomi(100)

# ── block 14 ────────────────────────────────────────
zeikomi(100, 0.08)

# ── block 15 ────────────────────────────────────────
kensuu <- function(x, n = length(x)) {
  n
}
kensuu(c(1, 2, 3))

# ── block 16 ────────────────────────────────────────
kakikae <- function(x, n = length(x)) {
  x <- c(1, 2, 3, 4, 5)
  n
}
kakikae(c(1, 2, 3))

# ── block 17 ────────────────────────────────────────
tsukawanai <- function(a, b) {
  a
}
tsukawanai(1, stop("これは評価されない"))

# ── block 18 ────────────────────────────────────────
zeikomi(rate = 0.08, x = 100)

# ── block 19 ────────────────────────────────────────
shousai <- function(verbose = FALSE) {
  verbose
}
shousai(verb = TRUE)

# ── block 20 ────────────────────────────────────────
tanjun_rieki <- function(uriage, hiyou) {
  uriage - hiyou
}
tanjun_rieki(c(100, 200), 60)

# ── block 23 ────────────────────────────────────────
shukei <- function(x, type = c("mean", "median")) {
  type <- match.arg(type)
  if (type == "mean") mean(x) else median(x)
}
shukei(c(1, 2, 10))

# ── block 24 ────────────────────────────────────────
shukei(c(1, 2, 10), "median")

# ── block 26 ────────────────────────────────────────
gokei <- function(...) {
  sum(...)
}
gokei(1, 2, 3)

# ── block 27 ────────────────────────────────────────
shirabe <- function(...) {
  list(個数 = ...length(), 名前 = ...names())
}
shirabe(a = 1, b = 2)

# ── block 28 ────────────────────────────────────────
zeikomi2 <- function(x, rate = 0.1, ...) {
  x * (1 + rate)
}
zeikomi2(100, rat = 0.5)

# ── block 29 ────────────────────────────────────────
zeikomi3 <- function(x, ..., rate = 0.1) {
  x * (1 + rate)
}
zeikomi3(100, rat = 0.5)

# ── block 30 ────────────────────────────────────────
zeikomi3(100, rate = 0.5)

# ── block 32 ────────────────────────────────────────
x <- 1
kaeru <- function() {
  x <- 99
  x
}
kaeru()

# ── block 33 ────────────────────────────────────────
x

# ── block 34 ────────────────────────────────────────
y <- 5
yomu <- function() {
  y * 2
}
yomu()

# ── block 35 ────────────────────────────────────────
zeiritsu <- 0.1
kingaku <- function(x) {
  x * (1 + zeiritsu)
}
kingaku(100)

# ── block 36 ────────────────────────────────────────
zeiritsu <- 0.5
kingaku(100)

# ── block 37 ────────────────────────────────────────
kingaku2 <- function(x, zeiritsu) {
  x * (1 + zeiritsu)
}
kingaku2(100, 0.1)

# ── block 39 ────────────────────────────────────────
shukei <- function(df, col) {
  df |> group_by({{ col }}) |> summarise(合計 = sum(売上))
}
shukei(uriage, 店舗)

# ── block 40 ────────────────────────────────────────
shukei2 <- function(df, colname) {
  df |> group_by(.data[[colname]]) |> summarise(合計 = sum(売上))
}
shukei2(uriage, "店舗")

# ── block 41 ────────────────────────────────────────
for (nm in c("店舗")) {
  print(shukei2(uriage, nm))
}

# ── block 42 ────────────────────────────────────────
shukei3 <- function(df, col, name) {
  df |> summarise("{{ name }}" := sum({{ col }}))
}
shukei3(uriage, 売上, 総額)

# ── block 43 ────────────────────────────────────────
uriage |> summarise("総額" = sum(売上))

# ── block 44 ────────────────────────────────────────
nm <- "総額"
uriage |> summarise("{nm}" = sum(売上))

# ── block 45 ────────────────────────────────────────
uriage |> summarise("{nm}" := sum(売上))

# ── block 46 ────────────────────────────────────────
shukei3(uriage, 売上, "総額")

# ── block 47 ────────────────────────────────────────
shukei4 <- function(df, ...) {
  df |> group_by(...) |> summarise(合計 = sum(売上), .groups = "drop")
}
shukei4(uriage, 店舗)

# ── block 49 ────────────────────────────────────────
futatsu <- function() {
  on.exit(cat("1つ目の片付け\n"))
  on.exit(cat("2つ目の片付け\n"))
  cat("本体の処理\n")
}
futatsu()

# ── block 50 ────────────────────────────────────────
ryouhou <- function() {
  on.exit(cat("1つ目の片付け\n"))
  on.exit(cat("2つ目の片付け\n"), add = TRUE)
  cat("本体の処理\n")
}
ryouhou()

