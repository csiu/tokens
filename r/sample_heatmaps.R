normalize_df <- function(df, melt = FALSE) {
  df <- apply(df, c(1,2), function(x) {
    if (is.na(x)) {
      x = -1
    } else if (x == 0) {
      x = 0
    } else if (x != 0) {
      x = 1
    }
  })
  df <- as.data.frame(df)
  
  if (melt) {
    df2 <- NULL
    n.rep <- dim(df)[1]
    for (i in 1:dim(df)[2]) {
      c.name <- colnames(df[i])
      df2<-rbind(df2, 
                 cbind(df[,i], rownames(df[i]), rep(c.name, n.rep))
      )
    }
    df2 <- as.data.frame(df2)
    return(df2)  
  } else {
    return(df)
  }
}
##==========================================================================
## Generating random data 
rand_df <- function(nrow, ncol) {
  df <- NULL
  for (i in 1:ncol) {
    df <- cbind(df, 
                sample(c(airquality$Ozone, rep(0, 10)), nrow))
  }
  df <- as.data.frame(df)
  rownames(df) <- letters[0:nrow]
  return(df)
}
w <- rand_df(10, 3)
c <- rand_df(10, 3)
col_names <- c("N", "T", "X1")
colnames(w) <- col_names
colnames(c) <- col_names

w.melt <- normalize_df(w, melt = TRUE)
w.norm <- normalize_df(w)

##==========================================================================
## heatmap with ggplot
library(ggplot2)
ggplot(w.melt, aes(x = as.factor(w.melt[[2]]),
                   y = w.melt[[3]],
                   group = w.melt[[3]])) +
  xlab(label="") + 
  ylab(label="") +
  geom_tile(aes(fill = w.melt[[1]]), colour = "white", show_guide = FALSE) +
  #geom_text(aes(fill = w.melt$V1, label = w.melt$V1)) +
  theme(panel.background = element_blank())


## heatmap with heatmap.2
plot_heatmap2 <- function(df, sort.rows = FALSE, ...) {
  if (require('gplots', quietly=TRUE)){
    library(gplots)
    if (sort.rows) {
      df <- df[order(df[,1], df[,2], df[,3], decreasing=FALSE),]
    }
    
    heatmap.2(as.matrix(t(df)), Rowv=FALSE, Colv=FALSE, dendrogram="none",
              scale="none", trace="none", sepwidth=c(0.02,0.01),
              colsep=1:dim(df)[1], rowsep=1:dim(df)[2], 
              key=FALSE, col=c("black", "grey", "chartreuse3"), 
              ...)
  } else {
    warning('error -- package "gplots" is not available')
  }
}
plot_heatmap2(w.norm, sort.rows=TRUE)