
commas <- function(...) paste0(..., collapse = ", ")

compact_null <- function(x) {
  Filter(function(elt) !is.null(elt), x)
}

paste_line <- function(...) {
  paste(chr(...), collapse = "\n")
}

# Until vctrs::new_data_frame() forwards row names automatically
dplyr_new_data_frame <- function(x = data.frame(),
                                 n = NULL,
                                 ...,
                                 row.names = NULL,
                                 class = NULL) {
  row.names <- row.names %||% .row_names_info(x, type = 0L)

  new_data_frame(
    x,
    n = n,
    ...,
    row.names = row.names,
    class = class
  )
}

# Strips a list-like vector down to just names
dplyr_new_list <- function(x) {
  if (!is_list(x)) {
    abort("`x` must be a VECSXP.", .internal = TRUE)
  }

  names <- names(x)

  if (is.null(names)) {
    attributes(x) <- NULL
  } else {
    attributes(x) <- list(names = names)
  }

  x
}

dplyr_new_tibble <- function(x, size) {
  # ~9x faster than `tibble::new_tibble()` for internal usage
  new_data_frame(x = x, n = size, class = c("tbl_df", "tbl"))
}

maybe_restart <- function(restart) {
  if (!is_null(findRestart(restart))) {
    invokeRestart(restart)
  }
}

expr_substitute <- function(expr, old, new) {
  expr <- duplicate(expr)
  switch(typeof(expr),
    language = node_walk_replace(node_cdr(expr), old, new),
    symbol = if (identical(expr, old)) return(new)
  )
  expr
}
node_walk_replace <- function(node, old, new) {
  while (!is_null(node)) {
    switch(typeof(node_car(node)),
      language = if (!is_call(node_car(node), c("~", "function")) || is_call(node_car(node), "~", n = 2)) node_walk_replace(node_cdar(node), old, new),
      symbol = if (identical(node_car(node), old)) node_poke_car(node, new)
    )
    node <- node_cdr(node)
  }
}

cli_collapse <- function(x, last = " and ") {
  cli::cli_vec(x, style = list("vec-last" = last))
}

with_no_rlang_infix_labeling <- function(expr) {
  # TODO: Temporary patch for a slowdown seen with `rlang::as_label()` and infix
  # operators. A real solution likely involves lazy ALTREP vectors (#6681).
  # https://github.com/r-lib/rlang/commit/33db700d556b0b85a1fe78e14a53f95ac9248004
  with_options("rlang:::use_as_label_infix" = FALSE, expr)
}
