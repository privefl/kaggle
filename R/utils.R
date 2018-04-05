#' Title
#'
#' @inheritDotParams glue::glue
#'
#' @return
#' @export
#'
#' @examples
system_glue <- function(...) {
  system(glue::glue(..., .envir = parent.frame()))
}
