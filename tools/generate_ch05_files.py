#!/usr/bin/env python3
"""第5章用サンプル stores.csv / targets.csv の決定的生成（乱数不使用）

- stores.csv : 店舗マスタ。sales.csv の3店舗のうち「オンライン」を欠く（結合で行が消える題材）。
               逆に sales.csv に売上のない「福岡店」を含む（右側にだけある行の題材）。
- targets.csv: 店舗 × 四半期の売上目標。1店舗に複数行あり、一対多結合の題材になる。
"""
import csv
import shutil
from pathlib import Path

HERE = Path(__file__).parent
CH05 = HERE / "ch05"

stores = [
    ("新宿店", "東京", 2008, "直営"),
    ("大阪店", "大阪", 2012, "直営"),
    ("福岡店", "福岡", 2024, "直営"),
]

targets = [
    ("新宿店", 1, 14000000),
    ("新宿店", 2, 14500000),
    ("新宿店", 3, 15000000),
    ("新宿店", 4, 16000000),
    ("大阪店", 1, 11000000),
    ("大阪店", 2, 11500000),
    ("大阪店", 3, 12000000),
    ("大阪店", 4, 13000000),
    ("オンライン", 1, 9000000),
    ("オンライン", 2, 9500000),
    ("オンライン", 3, 10000000),
    ("オンライン", 4, 11000000),
]

with open(HERE / "stores.csv", "w", encoding="utf-8", newline="\n") as f:
    w = csv.writer(f, lineterminator="\n")
    w.writerow(["店舗", "地域", "開店年", "区分"])
    w.writerows(stores)

with open(HERE / "targets.csv", "w", encoding="utf-8", newline="\n") as f:
    w = csv.writer(f, lineterminator="\n")
    w.writerow(["店舗", "四半期", "目標"])
    w.writerows(targets)

if CH05.is_dir():
    for name in ("sales.csv", "stores.csv", "targets.csv"):
        shutil.copy2(HERE / name, CH05 / name)
    synced = " (ch05/ へ同期済み)"
else:
    synced = ""

print(f"stores.csv {len(stores)} rows / targets.csv {len(targets)} rows{synced}")
