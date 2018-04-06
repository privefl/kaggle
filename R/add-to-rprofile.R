################################################################################

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
#' kaggler::add_pkg_to_rprofile("kaggler")
add_pkg_to_rprofile <- function(pkg, global = FALSE) {
  
  file <- `if`(global, "~/.Rprofile", ".Rprofile")
  
  if (file.exists(file)) {
    already_there <- any(grepl(glue::glue("({pkg})"), readLines(file), fixed = TRUE))
    if (already_there) return(invisible())
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

################################################################################

#' Add a global variable to the .Rprofile file
#' 
#' After calling this function, you will get a global variable named
#' `KAGGLE_COMPETITION` everytime you launch your  current R project.
#'
#' @param competition Name of the competition to be stored in the global variable.
#'
#' @export
#' 
add_competition_to_rprofile <- function(competition) {
  
  file <- ".Rprofile"
  
  if (file.exists(file)) {
    already_there <- any(grepl("KAGGLE_COMPETITION", readLines(file), fixed = TRUE))
    if (already_there) return(invisible())
  }
  
  expr <- glue::glue("KAGGLE_COMPETITION <- '{competition}'")
  eval(parse(text = expr), envir = parent.frame())
  
  to_add <- glue::glue(
    "\n",
    "if (interactive()) {{",
    "  {expr}",
    "}}",
    "\n", .sep = "\n"
  )
  cat(to_add, file = file, append = TRUE)
}

################################################################################
