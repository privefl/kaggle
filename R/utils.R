system_glue <- function(...) {
  system(glue::glue(..., .envir = parent.frame()))
}

print_glue <- function(...) {
  print(glue::glue(..., .envir = parent.frame()))
}

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
  
  zip_files <- list.files(dir, pattern = "\\.zip$", full.names = TRUE)
  purrr::walk(zip_files, ~{
    print_glue("Unzipping {.x}")
    utils::unzip(.x, exdir = dir, overwrite = overwrite)
  })
  
  invisible()
}
