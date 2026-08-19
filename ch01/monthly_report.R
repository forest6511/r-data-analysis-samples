# 月次売上レポート
library(tidyverse)

sales <- read_csv("sales.csv")

# 月別売上の集計
monthly <- sales |>
  group_by(日付) |>
  summarise(売上合計 = sum(売上))

# グラフを描いて保存
ggplot(monthly, aes(x = 日付, y = 売上合計)) +
  geom_line() +
  geom_point() +
  scale_y_continuous(labels = scales::label_comma()) +
  labs(x = NULL, y = "売上合計（円）")

ggsave("monthly_sales.png", width = 7, height = 4)
