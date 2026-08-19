# 店舗別の月次売上（第2章の仕上げの例）
library(tidyverse)

sales <- read_csv("sales.csv")

# 日付×店舗で集計
monthly_store <- sales |>
  group_by(日付, 店舗) |>
  summarise(売上合計 = sum(売上))

# 店舗別の折れ線グラフを描いて保存
ggplot(monthly_store, aes(x = 日付, y = 売上合計, color = 店舗)) +
  geom_line() +
  geom_point() +
  scale_y_continuous(labels = scales::label_comma()) +
  labs(title = "店舗別の月次売上", x = NULL, y = "売上合計（円）")

ggsave("store_sales.png", width = 7, height = 4)
