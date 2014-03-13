\name{scatplot}
\alias{scatplot}
\title{Creating scatter plots with ggplot2}
\usage{
  scatplot(xfile, yfile, xdescript, ydescript, filename =
  NULL, ignorecolname = FALSE)
}
\arguments{
  \item{xfile}{path/to/matrix1}

  \item{yfile}{path/to/matrix2}

  \item{xdescript}{description of \code{xfile}; don't
  include whitespace}

  \item{ydescript}{description of \code{yfile}; don't
  include whitespace}

  \item{filename}{specify output filename}

  \item{ignorecolname}{logical; ignore colname matching of
  \code{xfile, yfile}? If \code{TRUE}, the number of
  columns between the two files should equal}
}
\description{
  Creating scatter plots with ggplot2
}
\details{
  \code{scatplot}

  The purpose of this function is to directly compare -- by
  scatterplotting -- the values of corresponding column(s)
  in two matrices. The matrices from \code{xfile} and
  \code{yfile} (when \code{ignorecolname = FALSE}) should
  therefore contain at least 1 column with the same row and
  column name. Results will be send to a pdf file.
}
\examples{
scatplot(xfile = "m1_wholegen.txt.", yfile = "m1_custom.txt", xdescript = "wholegen", ydescript = "custom")
}

