# 第19章　探索的データ分析（EDA）
#
# 『Rによるデータ分析 入門から実践』の第19章のサンプルコードです。
# リポジトリのルートを作業ディレクトリにして、上から順に実行してください。

# ── block 01 ────────────────────────────────────────
library(tidyverse)
u <- read_csv("uriage_2y.csv", show_col_types = FALSE)
u

# ── block 02 ────────────────────────────────────────
glimpse(u)

# ── block 03 ────────────────────────────────────────
summary(u)

# ── block 04 ────────────────────────────────────────
u |> filter(if_any(everything(), is.na))

# ── block 05 ────────────────────────────────────────
u |> slice_max(売上, n = 3)

# ── block 06 ────────────────────────────────────────
q <- quantile(u$売上, c(0.25, 0.75), na.rm = TRUE)
iqr <- IQR(u$売上, na.rm = TRUE)
u |> filter(売上 > q[2] + 1.5 * iqr)

# ── block 07 ────────────────────────────────────────
u |> filter(客数 == 0)

# ── block 08 ────────────────────────────────────────
u |> mutate(客単価 = 売上 / 客数) |>
  summarise(最小 = min(客単価, na.rm = TRUE), 最大 = max(客単価, na.rm = TRUE))

# ── block 09 ────────────────────────────────────────
u |> count(店舗)

# ── block 10 ────────────────────────────────────────
u |> count(区分, 年)

# ── block 11 ────────────────────────────────────────
u |> group_by(店舗) |>
  summarise(合計 = sum(売上, na.rm = TRUE), 欠損 = sum(is.na(売上))) |>
  arrange(desc(合計))

# ── block 12 ────────────────────────────────────────
u |> filter(!is.na(売上)) |>
  group_by(店舗, 年) |>
  summarise(計 = sum(売上), .groups = "drop") |>
  pivot_wider(names_from = 年, values_from = 計) |>
  mutate(前年比 = round(`2025` / `2024`, 3))

# ── block 13 ────────────────────────────────────────
cor(u$売上, u$客数, use = "complete.obs")

# ── block 14 ────────────────────────────────────────
u2 <- u |> filter(売上 < 5000000)
cor(u2$売上, u2$客数, use = "complete.obs")

# ── block 15 ────────────────────────────────────────
u |> ggplot(aes(x = 売上)) +
  geom_histogram(bins = 30)

# ── block 16 ────────────────────────────────────────
u |> ggplot(aes(x = 店舗, y = 売上)) +
  geom_boxplot()

# ── block 17 ────────────────────────────────────────
u |> mutate(年月 = make_date(年, 月, 1)) |>
  ggplot(aes(x = 年月, y = 売上, colour = 店舗)) +
  geom_line()

# ── block 18 ────────────────────────────────────────
u_clean <- u |>
  mutate(売上 = if_else(店舗 == "福岡店" & 年 == 2024 & 月 == 11,
                        売上 / 10, 売上))
u_clean |> slice_max(売上, n = 2)

