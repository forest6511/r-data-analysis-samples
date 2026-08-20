#!/usr/bin/env python3
"""第8章（文字コードと文字化け）用サンプルの決定的生成（乱数不使用）

同じ内容の売上表を、エンコーディングだけ変えて4通り書き出す。
本文は「中身が同じでも読み方が違う」ことを見せるので、
CP932 と UTF-8 の差以外の違いが入らないようにする。

- uriage_cp932.csv     : CP932（Windows の Excel が既定で書き出す形）
- uriage_utf8.csv      : UTF-8（BOM なし）
- uriage_utf8_bom.csv  : UTF-8（BOM 付き。Excel で「CSV UTF-8」を選ぶとこれ）
- uriage_utf16le.csv   : UTF-16LE + タブ区切り（Excel「Unicode テキスト」の形）
- t_short.csv          : CP932。日本語が1行しかない短いファイル
                         （guess_encoding が外す例。8.2節）
"""
from pathlib import Path

HERE = Path(__file__).parent
CH08 = HERE / "ch08"

ROWS = [
    ("日付", "店舗", "商品分類", "売上", "備考"),
    ("2026-04-01", "新宿店", "飲料", "128000", "定番"),
    ("2026-04-01", "大阪店", "菓子", "94500", ""),
    ("2026-04-02", "新宿店", "菓子", "76300", "雨天"),
    ("2026-04-02", "オンライン", "飲料", "152800", ""),
    ("2026-04-03", "大阪店", "飲料", "88100", "特売"),
]


def as_text(rows, sep=","):
    return "".join(sep.join(r) + "\r\n" for r in rows)


def main():
    CH08.mkdir(exist_ok=True)
    body = as_text(ROWS)
    targets = {
        "uriage_cp932.csv": body.encode("cp932"),
        "uriage_utf8.csv": body.encode("utf-8"),
        "uriage_utf8_bom.csv": b"\xef\xbb\xbf" + body.encode("utf-8"),
        "uriage_utf16le.csv": as_text(ROWS, sep="\t").encode("utf-16-le"),
    }
    # UTF-16LE は BOM 付きで書き出す（Excel の「Unicode テキスト」と同じ）
    targets["uriage_utf16le.csv"] = b"\xff\xfe" + targets["uriage_utf16le.csv"]

    # 判断材料が少ないと guess_encoding が外すことを示すための短いファイル。
    # 日本語は「店舗」「新宿店」の 5 文字だけ。
    targets["t_short.csv"] = "店舗,売上\r\n新宿店,100\r\n".encode("cp932")

    for name, data in targets.items():
        for d in (HERE, CH08):
            (d / name).write_bytes(data)
        print(f"{name}: {len(data)} bytes")


if __name__ == "__main__":
    main()
