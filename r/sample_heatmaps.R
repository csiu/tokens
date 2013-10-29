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
index_by_chr <- function(v, sep.delim = "_"){
  ord <- c("^0?[0-9]", "^1[0-9]", "^2[0-9]", "^[Xx]", "^[Yy]")
  ord <- sapply(ord, function(o){paste(o, sep.delim, sep="")}, USE.NAMES=FALSE)
  new_v <- NULL
  for (i in ord) {
    new_v <- c(new_v, sort(grep(i, v, value=TRUE)))
  }
  if (length(v) == length(new_v)) {
    return(match(new_v, v))
  } else {
    warning('Error in sorting; returning old list')
    return(1:length(v))
  }
}
merge_df <- function(x, y, suffix.x, suffix.y) {
  df <- merge(x, y, by=0, suffixes=c(suffix.x, suffix.y))
  rownames(df) <- df[,1]
  df <- df[,-1]
  return(df)
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
w <- rand_df(26, 3)
c <- rand_df(26, 3)
col_names <- c("N", "T", "X1")
colnames(w) <- col_names
colnames(c) <- col_names
# rownames(w) <- c("1_a", "1_b", "10_c", "10_d", "11_e", "11_f", "12_g", "X_h", "13_i", "13_j", "14_k", 
#                  "15_l", "16_m", "16_n", "2_o", "2_p", "21_q", "22_r", "3_s", "5_t", "2_u", "9_V",
#                  "X_w", "X_x", "X_y", "Y_z")
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
plot_heatmap2 <- function(df, sort.rows = NULL, col.chr = FALSE, ...) {
  if (require('gplots', quietly=TRUE)){
    library(gplots)
    
    if (is.null(sort.rows)) {sort.rows = FALSE}
    if (sort.rows == "data") {
      for (i in dim(df)[2]:1) { df <- df[order(df[,i], decreasing=FALSE),] }
    } else if (sort.rows == "chr") {
      df <- df[index_by_chr(v=rownames(df)),]
    }
    
    if (col.chr) {
      c.col <- c("#FF0000", #red
                 "#00FFFF", #cyan
                 "#0000FF", #blue
                 "#3090C7", #Blue Ivy
                 "#ADD8E6", #lightblue
                 "#800080", #purple
                 "#FFFF00", #yellow
                 "#00FF00", #lime
                 "#FF00FF", #magenta
                 "#C0C0C0", #silver
                 "#808080", #gray
                 "#000000", #black
                 "#FFA500", #orange
                 "#F87217", #Pumpkin Orange
                 "#800000", #maroon
                 "#008000", #green 
                 "#808000", #olive
                 "#3B9C9C", #Dark Turquoise
                 "#89C35C", #green peas
                 "#EDDA74", #Goldenrod
                 "#DEB887", #BurlyWood
                 "#C48189", #Pink Bow
                 "#F9B7FF", #Blossom Pink
                 "#0000A0" #darkblue
      )
      chr <- sub("_.*", "", rownames(df))
      chr.col <- sapply(chr, function(c){
        if ((c == "X") | (c == "x")) { c <- 23 }
        if ((c == "Y") | (c == "y")) { c <- 24 }
        c.col[as.integer(c)]}, 
                        USE.NAMES=FALSE)
      
      heatmap.2(as.matrix(t(df)), Rowv=FALSE, Colv=FALSE, dendrogram="none",
                ColSideColors=chr.col,
                scale="none", trace="none", sepwidth=c(0.02,0.01),
                colsep=1:dim(df)[1], rowsep=1:dim(df)[2], 
                key=FALSE, col=c("black", "grey", "chartreuse3"),
                ...)
      legend("left", legend=c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,
                                 16,17,18,19,20,21,22,"X","Y"), 
             fill=c.col, border=FALSE, bty="n", y.intersp = 0.7, cex=0.7)
    } else {
      heatmap.2(as.matrix(t(df)), Rowv=FALSE, Colv=FALSE, dendrogram="none",
                scale="none", trace="none", sepwidth=c(0.02,0.01),
                colsep=1:dim(df)[1], rowsep=1:dim(df)[2], 
                key=FALSE, col=c("black", "grey", "chartreuse3"),
                ...)
    }
  } else {
    warning('error -- package "gplots" is not available')
  }
}
plot_heatmap2(w.norm)                   #unordered
plot_heatmap2(w.norm, sort.rows="data") #order by data
plot_heatmap2(w.norm, sort.rows="chr")  #order by chr
plot_heatmap2(w.norm, sort.rows="data", col.chr=TRUE)
