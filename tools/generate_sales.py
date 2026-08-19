#!/usr/bin/env python3
"""第1章用サンプル sales.csv の決定的生成（乱数不使用・再実行しても同一出力）"""
stores = ["新宿店", "大阪店", "オンライン"]
cats = {"家電": 1800, "食品": 950, "日用品": 620, "衣料品": 1100}
store_mult = {"新宿店": 1.0, "大阪店": 0.85, "オンライン": 1.25}
seasonal = [0.95, 0.90, 1.05, 1.00, 0.98, 1.02, 1.10, 1.08, 0.97, 1.03, 1.12, 1.30]
rows = ["日付,店舗,カテゴリ,売上"]
for m in range(1, 13):
    for s in stores:
        for c, base in cats.items():
            v = int(base * store_mult[s] * seasonal[m-1] * (1 + 0.01*m)) * 1000
            v += (sum(ord(ch) for ch in s+c) % 7) * 1000  # 決定的な端数
            rows.append(f"2025-{m:02d}-01,{s},{c},{v}")
open("sales.csv", "w", encoding="utf-8").write("\n".join(rows) + "\n")
print(f"{len(rows)-1} rows -> sales.csv")
