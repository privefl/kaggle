#' Add a package to the .Rprofile file
#' 
#' After calling this function, the package will be launched everytime you 
#' launch your  current R project 
#' (or any project if you use option `global = TRUE`).
#' 
#' @param pkg Name of the package to be added to .Rprofile file.
#' @param global Whether to add it to the global .Rprofile (`TRUE`) or just 
#'   to the .Rprofile file of your current project (`FALSE`, the default).
#' 
#' @export
#' @examples
#' kaggle::add_pkg_to_rprofile("kaggle")
add_pkg_to_rprofile <- function(pkg, global = FALSE) {
  
  file <- `if`(global, "~/.Rprofile", ".Rprofile")
  
  if (file.exists(file)) {
    already_there <- any(grepl(glue::glue("({pkg})"), readLines(file), fixed = TRUE))
    if (already_there) return(invisible(NULL))
  }
  
  to_add <- glue::glue(
    "\n",
    "if (interactive()) {{",
    "  suppressMessages(require({pkg}))",
    "}}",
    "\n", .sep = "\n"
  )
  cat(to_add, file = file, append = TRUE)
}