% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/kaggle-api.R
\name{kaggle_data}
\alias{kaggle_data}
\title{Download data}
\usage{
kaggle_data(competition = NULL, dir = "data", cmd_add = "")
}
\arguments{
\item{competition}{Name of the competition from which to download the data
(e.g. \code{"data-science-bowl-2018"}). Default lists all of them.}

\item{dir}{Directory where to put these data (default is \code{"data"}).}

\item{cmd_add}{If you want to add something to the command.}
}
\value{
\code{NULL}, invisibly.
}
\description{
Download data of a Kaggle competition.
}
\examples{
kaggler::kaggle_data()

# You must accept this competition before
kaggler::kaggle_data("titanic", dir = tempdir())
kaggler::kaggle_data("titanic", dir = tempdir(), cmd_add = "--force")
}