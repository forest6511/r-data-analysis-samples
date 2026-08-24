# 第20章　統計的検定と回帰分析
#
# 『Rによるデータ分析 入門から実践』の第20章のサンプルコードです。
# リポジトリのルートを作業ディレクトリにして、上から順に実行してください。

# ── block 01 ────────────────────────────────────────
library(tidyverse)
u <- read_csv("uriage_2y.csv", show_col_types = FALSE) |>
  mutate(売上 = if_else(店舗 == "福岡店" & 年 == 2024 & 月 == 11,
                        売上 / 10, 売上))

# ── block 02 ────────────────────────────────────────
t.test(売上 ~ 区分, data = u)

# ── block 03 ────────────────────────────────────────
t.test(売上 ~ 区分, data = u, var.equal = TRUE)

# ── block 04 ────────────────────────────────────────
set.seed(7)
for (n in c(20, 200, 2000)) {
  x <- rnorm(n, 100, 15)
  y <- rnorm(n, 101, 15)
  cat(sprintf("n=%4d  差=%.2f  p=%.4f\n", n, mean(y) - mean(x), t.test(x, y)$p.value))
}

# ── block 05 ────────────────────────────────────────
set.seed(42)
kekka <- replicate(20, {
  x <- rnorm(50)
  y <- rnorm(50)
  t.test(x, y)$p.value < 0.05
})
sum(kekka)

# ── block 06 ────────────────────────────────────────
p <- c(0.01, 0.03, 0.04)
p.adjust(p, method = "bonferroni")

# ── block 07 ────────────────────────────────────────
tb <- table(u$区分, u$売上 > 1000000)
tb

# ── block 08 ────────────────────────────────────────
chisq.test(tb)

# ── block 09 ────────────────────────────────────────
chisq.test(tb)$expected

# ── block 10 ────────────────────────────────────────
m <- lm(売上 ~ 客数, data = u)
summary(m)

# ── block 11 ────────────────────────────────────────
nobs(m)

# ── block 12 ────────────────────────────────────────
broom::tidy(m)

# ── block 13 ────────────────────────────────────────
broom::glance(m) |> select(r.squared, adj.r.squared, sigma, nobs)

# ── block 14 ────────────────────────────────────────
u |> mutate(残差 = residuals(m)[match(row_number(), which(!is.na(売上)))]) |>
  slice_max(abs(残差), n = 2) |>
  select(店舗, 年, 月, 売上, 客数, 残差)

# ── block 15 ────────────────────────────────────────
u2 <- u |> filter(客数 > 0)
summary(lm(売上 ~ 客数, data = u2))

# ── block 16 ────────────────────────────────────────
m3 <- lm(売上 ~ 客数 + 店舗, data = u2)
broom::tidy(m3) |> select(term, estimate, p.value)

# ── block 17 ────────────────────────────────────────
levels(factor(u2$店舗))

# ── block 18 ────────────────────────────────────────
predict(m, newdata = tibble(客数 = c(300, 500)))

# ── block 19 ────────────────────────────────────────
predict(m, newdata = tibble(客数 = c(0, 10000)))

# ── block 20 ────────────────────────────────────────
range(u2$客数)

# ── block 21 ────────────────────────────────────────
cor(u2$月, u2$売上, use = "complete.obs")

