#' Creating scatter plots with ggplot2
#'
#' @param xfile path/to/matrix1
#' @param yfile path/to/matrix2
#' @param xdescript description of \code{xfile}; don't include whitespace
#' @param ydescript description of \code{yfile}; don't include whitespace
#' 
#' @details \code{scatplot}
#' The purpose of this function is to directly compare -- by scatterplotting -- 
#' the values of corresponding column(s) in two matrices.
#' The matrices from \code{xfile} and \code{yfile} 
#' should therefore contain the same row and column names. 
#' Results will be send to a pdf file.
#' 
#' @examples scatplot(xfile = "m1_wholegen.txt.", yfile = "m1_custom.txt", xdescript = "wholegen", ydescript = "custom")
#' 
#' @export
scatplot <- function(xfile, yfile, xdescript, ydescript, filename = NULL){
  ## dependencies
  require(ggplot2)
  
  ## naive check to ensure line does not end with white space
  for (infile in c(xfile, yfile)) {
    inline <- readLines(infile, n=2)[2]
    if (grepl('\t$', inline)) {
      stop(sprintf("FormatError: Remove tab(s) at the end of '%s'", infile))
      q("no")
    }
  }
  
  ## load data
  xdat <- read.delim(file=xfile, row.names=1)
  ydat <- read.delim(file=yfile, row.names=1)

  ## individual run data -> 'run.pairs'
  runs <- intersect(colnames(xdat), colnames(ydat))
  runs.pairs <- list()
  for (r in runs) {
    runs.pairs[[r]] <- data.frame(merge(xdat[r], ydat[r], by=0, 
                                        suffixes=c(sprintf(".%s", xdescript), 
                                                   sprintf(".%s", ydescript))), 
                                  row.names=1)
  }
  
  ## overall run data -> 'dat.all'
  dat <- runs.pairs
  dat.all <- NULL
  for (id in runs) {
    names(dat[[id]]) <- NULL
    dat.all <- rbind(dat.all, cbind(dat[[id]], id))
  }
  names(dat.all) <- c(xdescript, ydescript, "id")
  
  ## plotting 
  create_ScatPlot <- function(pdat, ...){
    pdat <<- pdat
    ggplot(pdat, aes(x=pdat[[1]], y=pdat[[2]])) +
      xlab(label=colnames(pdat)[1]) +
      ylab(label=colnames(pdat)[2]) +
      geom_point(na.rm=TRUE, ...) +
      opts(title=sprintf("N = %d/%d, Spearman's rank correlation rho: %0.4f", 
                         sum(complete.cases(pdat)), 
                         dim(pdat)[1], 
                         suppressWarnings(cor.test(pdat[[1]], pdat[[2]], method="spearman", na.rm=T)$estimate))) +
      geom_abline(intercept=0, slope=1, colour="red", linetype=3)
  }
  
  if (is.null(filename)){
    filename <- sprintf('Sample_%s_Run_%s-%s_NRun_%d_ScatPlot.pdf',
                        sub('.*?([A-Z]+[0-9]+).*', '\\1', xfile),
                        xdescript, ydescript,
                        length(runs.pairs))  
  }
  
  pdf(filename)
  print(create_ScatPlot(dat.all, alpha = 1/5))
  print(create_ScatPlot(dat.all, alpha = 1/3, aes(colour = id)))
  for (r in runs) {
    print(create_ScatPlot(runs.pairs[[r]], alpha = 1/3))
  }
  dev.off()
  
}
