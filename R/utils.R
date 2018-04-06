################################################################################

system_glue <- function(...) {
  system(glue::glue(..., .envir = parent.frame()))
}

print_glue <- function(...) {
  print(glue::glue(..., .envir = parent.frame()))
}

################################################################################

dir_create <- function(dir) if (!dir.exists(dir)) dir.create(dir)

################################################################################

#' Unzip files
#' 
#' Unzip all files in a directory.
#'
#' @param dir Directory where to get the files to unzip.
#' @inheritParams utils::unzip
#'
#' @return `NULL`, invisibly.
#' @export
#'
unzip_files <- function(dir = "data", overwrite = FALSE) {
  
  dir_create(dir)
  
  zip_files <- list.files(dir, pattern = "\\.zip$", full.names = TRUE)
  purrr::walk(zip_files, ~{
    print_glue("Unzipping {.x}")
    utils::unzip(.x, exdir = dir, overwrite = overwrite)
  })
  
  invisible()
}

################################################################################

#' @inheritDotParams data.table::fread -data.table
#'
#' @inherit data.table::fread title description
#' 
#' @return A `data.frame`.
#' @export
#'
fread2 <- function(...) {
  tibble::as_tibble(
    data.table::fread(..., data.table = FALSE)
  )
}

################################################################################

#' Write CSV
#' 
#' Write CSV file for submission.
#' 
#' @param x A named data frame.
#' @param file CSV file to write.
#'
#' @return Return input `file`, invisibly.
#' @export
#'
to_csv <- function(x, file) {
  
  if (is.data.frame(x) && (names(x) != paste0("V", seq_along(x)))) {
    utils::write.csv(x, file = file, quote = FALSE, row.names = FALSE)
  } else {
    stop("'x' must be a named data frame.", call. = FALSE) 
  }
  
  invisible(file)
}
  
################################################################################
