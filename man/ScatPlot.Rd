\name{scatplot}
\alias{scatplot}
\title{Creating scatter plots with ggplot2}
\usage{
  scatplot(xfile, yfile, xdescript, ydescript, filename =
  NULL)
}
\arguments{
  \item{xfile}{path/to/matrix1}

  \item{yfile}{path/to/matrix2}

  \item{xdescript}{description of \code{xfile}; don't
  include whitespace}

  \item{ydescript}{description of \code{yfile}; don't
  include whitespace}
}
\description{
  Creating scatter plots with ggplot2
}
\details{
  \code{scatplot}

  The purpose of this function is to directly compare -- by
  scatterplotting -- the values of corresponding column(s)
  in two matrices. The matrices from \code{xfile} and
  \code{yfile} should therefore contain the same row and
  column names. Results will be send to a pdf file.
}
\examples{
scatplot(xfile = "m1_wholegen.txt.", yfile = "m1_custom.txt", xdescript = "wholegen", ydescript = "custom")
}

