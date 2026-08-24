# 第17章　S3クラスとジェネリック関数
#
# 『Rによるデータ分析 入門から実践』の第17章のサンプルコードです。
# リポジトリのルートを作業ディレクトリにして、上から順に実行してください。

# ── block 01 ────────────────────────────────────────
library(tidyverse)

# ── block 02 ────────────────────────────────────────
print(1:3)
print(factor(c("a", "b")))
print(as.Date("2026-01-01"))

# ── block 03 ────────────────────────────────────────
print

# ── block 04 ────────────────────────────────────────
d <- as.Date("2026-01-01")
class(d)
typeof(d)

# ── block 05 ────────────────────────────────────────
unclass(d)

# ── block 06 ────────────────────────────────────────
class(factor("a"))
typeof(factor("a"))
class(tibble(a = 1))
typeof(tibble(a = 1))

# ── block 07 ────────────────────────────────────────
class(tibble(a = 1))

# ── block 08 ────────────────────────────────────────
inherits(tibble(a = 1), "data.frame")
inherits(1:3, "data.frame")

# ── block 09 ────────────────────────────────────────
x <- structure(1, class = c("kodomo", "oya"))
print.oya <- function(x, ...) cat("oya のメソッド\n")
x

# ── block 10 ────────────────────────────────────────
print.kodomo <- function(x, ...) {
  cat("kodomo のメソッド → ")
  NextMethod()
}
x

# ── block 11 ────────────────────────────────────────
y <- structure(1:3, class = "shiranai")
y

# ── block 12 ────────────────────────────────────────
z <- 1:3
class(z) <- "Date"
z

# ── block 13 ────────────────────────────────────────
as.Date(1:3, origin = "2026-01-01")

# ── block 14 ────────────────────────────────────────
length(methods(print))

# ── block 15 ────────────────────────────────────────
length(methods(class = "Date"))

# ── block 16 ────────────────────────────────────────
head(deparse(getS3method("print", "difftime")), 4)

# ── block 17 ────────────────────────────────────────
str(structure(list(a = 1), class = "mine"))

# ── block 18 ────────────────────────────────────────
m <- lm(mpg ~ wt, mtcars)
class(m)
typeof(m)

# ── block 19 ────────────────────────────────────────
head(names(m), 4)

# ── block 20 ────────────────────────────────────────
round(coef(m), 3)
round(m$coefficients, 3)

# ── block 21 ────────────────────────────────────────
n <- nls(mpg ~ a * wt + b, data = mtcars, start = list(a = -5, b = 37))
is.null(n$coefficients)
round(coef(n), 3)

# ── block 22 ────────────────────────────────────────
uriage <- list(店舗 = "札幌", 金額 = 100, 件数 = 5)
uriage

# ── block 23 ────────────────────────────────────────
uriage2 <- structure(
  list(店舗 = "札幌", 金額 = 100, 件数 = 5),
  class = "uriage_data"
)
print.uriage_data <- function(x, ...) {
  cat("売上データ [", x$店舗, "]\n", sep = "")
  cat("  金額: ", x$金額, "万円 / 件数: ", x$件数, "件\n", sep = "")
  invisible(x)
}
uriage2

# ── block 24 ────────────────────────────────────────
summary.uriage_data <- function(object, ...) {
  cat("1件あたり平均: ", x <- object$金額 / object$件数, "万円\n", sep = "")
  invisible(object)
}
summary(uriage2)

# ── block 25 ────────────────────────────────────────
kingaku <- function(v) structure(list(v = v), class = "money")
print.money <- function(x, ...) {
  cat(format(x$v, big.mark = ","), "円\n")
  invisible(x)
}
"+.money" <- function(e1, e2) kingaku(e1$v + e2$v)
kingaku(1000) + kingaku(2000)

# ── block 26 ────────────────────────────────────────
p <- ggplot(mtcars, aes(wt, mpg)) + geom_point()
class(p)

# ── block 27 ────────────────────────────────────────
inherits(p, "ggplot")

# ── block 28 ────────────────────────────────────────
f <- function() {
  tibble(a = 1)
  tibble(b = 2)
}
f()

