#' Download data
#' 
#' Download data of a Kaggle competition.
#'
#' @param competition Name of the competition from which to download the data
#'   (e.g. `"data-science-bowl-2018"`). Default lists all of them.
#' @param dir Directory where to put these data (default is `"data"`).
#' @param cmd_add If you want to add something to the command.
#'
#' @return `NULL`, invisibly.
#' @export
#'
#' @examples
#' kaggler::kaggle_data()
#' 
#' # You must accept this competition before
#' kaggler::kaggle_data("titanic", dir = tempdir())
#' kaggler::kaggle_data("titanic", dir = tempdir(), cmd_add = "--force")
kaggle_data <- function(competition = NULL, dir = "data", cmd_add = "") {
  
  if (is.null(competition)) {
    system_glue("kaggle competitions list {cmd_add}")
  } else {
    system_glue("kaggle competitions download -c {competition} -p {dir} {cmd_add}")
  }
  
  invisible()
}
