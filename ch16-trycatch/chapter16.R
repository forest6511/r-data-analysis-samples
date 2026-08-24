# 第16章　エラーを設計する tryCatch
#
# 『Rによるデータ分析 入門から実践』の第16章のサンプルコードです。
# リポジトリのルートを作業ディレクトリにして、上から順に実行してください。

# ── block 01 ────────────────────────────────────────
library(tidyverse)

# ── block 02 ────────────────────────────────────────
shirase <- function() {
  message("これは message です")
  warning("これは warning です")
  cat("warning の次の行は実行されます\n")
  stop("これは stop です")
  cat("stop の次の行は実行されません\n")
}

# ── block 04 ────────────────────────────────────────
as.numeric(c("1", "x", "3"))

# ── block 05 ────────────────────────────────────────
kekka <- capture.output(message("これは捕まらない"))
kekka

# ── block 06 ────────────────────────────────────────
capture.output(message("これは捕まる"), type = "message")

# ── block 07 ────────────────────────────────────────
kekka2 <- tryCatch(
  stop("失敗しました"),
  error = function(e) "エラーを捕まえました"
)
kekka2

# ── block 08 ────────────────────────────────────────
tryCatch(
  sqrt("a"),
  error = function(e) paste("捕まえた内容:", conditionMessage(e))
)

# ── block 09 ────────────────────────────────────────
e <- tryCatch(sqrt("a"), error = function(e) e)
class(e)

# ── block 10 ────────────────────────────────────────
tryCatch(
  {
    warning("注意してください")
    "警告のあとの行まで来た"
  },
  warning = function(w) paste("捕まえた:", conditionMessage(w))
)

# ── block 11 ────────────────────────────────────────
yomu_ng <- function(path) {
  tryCatch(
    read_csv(path, show_col_types = FALSE),
    warning = function(w) {
      message("警告あり: ", conditionMessage(w))
      NULL
    }
  )
}

# ── block 12 ────────────────────────────────────────
kiroku <- character()
kekka3 <- withCallingHandlers(
  {
    warning("注意してください")
    "警告のあとの行まで来た"
  },
  warning = function(w) {
    kiroku <<- c(kiroku, conditionMessage(w))
    invokeRestart("muffleWarning")
  }
)
kekka3
kiroku

# ── block 13 ────────────────────────────────────────
kiroku2 <- character()
suuchi <- withCallingHandlers(
  as.numeric(c("1", "x", "3")),
  warning = function(w) {
    kiroku2 <<- c(kiroku2, conditionMessage(w))
    invokeRestart("muffleWarning")
  }
)
suuchi
kiroku2

# ── block 14 ────────────────────────────────────────
tryCatch(
  stop("失敗"),
  error = function(e) cat("error 節を実行\n"),
  finally = cat("finally 節を実行\n")
)

# ── block 15 ────────────────────────────────────────
tryCatch(
  cat("本体を実行\n"),
  error = function(e) cat("error 節を実行\n"),
  finally = cat("finally 節を実行\n")
)

# ── block 16 ────────────────────────────────────────
kekka4 <- try(stop("失敗"), silent = TRUE)
class(kekka4)

# ── block 19 ────────────────────────────────────────
yomu <- function(path) {
  d <- read_csv(path, show_col_types = FALSE)
  if (!"金額" %in% names(d)) {
    stop(errorCondition(
      paste0("金額列がありません: ", basename(path)),
      class = "retsu_error",
      path = path
    ))
  }
  d
}

# ── block 20 ────────────────────────────────────────
dir.create("data", showWarnings = FALSE)
writeLines(c("商品,金額", "A,100"), "data/ok1.csv")
writeLines(c("商品;金額", "C;300"), "data/ng.csv")
tryCatch(
  yomu("data/ng.csv"),
  retsu_error = function(e) paste("列の問題です。対象:", e$path)
)

# ── block 21 ────────────────────────────────────────
tryCatch(
  tryCatch(yomu("data/ng.csv"), betsu_error = function(e) "別のクラスで捕まえた"),
  error = function(e) "外側の error で捕まえた"
)

# ── block 22 ────────────────────────────────────────
sqrt2 <- function(x) {
  if (x < 0) rlang::abort("負の値です", class = "fu_error")
  sqrt(x)
}
tryCatch(sqrt2(-1), fu_error = function(e) paste("捕まえた:", conditionMessage(e)))

# ── block 23 ────────────────────────────────────────
writeLines(c("商品,金額", "B,200"), "data/ok2.csv")
files <- list.files("data", full.names = TRUE)
files

# ── block 24 ────────────────────────────────────────
tryCatch(map(files, yomu), error = function(e) "途中で止まった")

# ── block 25 ────────────────────────────────────────
map(files, possibly(yomu, otherwise = NULL)) |>
  compact() |>
  list_rbind()

# ── block 26 ────────────────────────────────────────
res <- map(files, safely(yomu))
seikou <- res |> map("result") |> compact() |> list_rbind()
shippai <- res |> map("error") |> compact()
nrow(seikou)
map_chr(shippai, conditionMessage)

# ── block 27 ────────────────────────────────────────
kekka5 <- tryCatch(
  yomu("data/sonzai_shinai.csv"),
  error = function(e) NULL
)
is.null(kekka5)

