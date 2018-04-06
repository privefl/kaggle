################################################################################

#' Download data
#' 
#' Download data of a Kaggle competition.
#'
#' @param dir Directory where to put these data (default is `"data"`).
#' @param cmd_add If you want to add something to the command.
#'
#' @export
#'
kaggle_data <- function(dir = "data", cmd_add = "") {
  
  if (exists("KAGGLE_COMPETITION")) {
    system_glue("kaggle competitions download",
                " -c {KAGGLE_COMPETITION}",
                " -p {dir}",
                " {cmd_add}")
    unzip_files(dir)
  } else {
    system_glue("kaggle competitions list {cmd_add}")
    cat("\nPlease register your competition with 'add_competition_to_rprofile()'.\n")
  }
  
  invisible()
}

################################################################################

#' Submit
#' 
#' Submit a file to a Kaggle competition.
#'
#' @param file Submission file to upload.
#' @param message Message describing this submission.
#'
#' @return Input `file`, invisibly.
#' @export
#' 
kaggle_submit <- function(file, message) {
  
  if (exists("KAGGLE_COMPETITION")) {
    system_glue("kaggle competitions submit",
                " -c {KAGGLE_COMPETITION}",
                " -f {file}",
                " -m '{message}'")
    browseURL(glue::glue(
      "https://www.kaggle.com/c/{KAGGLE_COMPETITION}/leaderboard"
    ))
  } else {
    stop("Please register your competition with 'add_competition_to_rprofile()'.")
  }
  
  invisible(file)
}

################################################################################
