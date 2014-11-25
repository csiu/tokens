library(MASS)
#Exercise 3.3.3

## part (a)
#Setup
m_i = matrix(c(0,1,0,1,
               0,1,0,0,
               1,0,0,1,
               0,0,1,0,
               0,0,1,1,
               1,0,0,0), 
             nrow=6, 
             byrow=TRUE)

h_1 <- function(x){(2*x+1) %% 6}
h_2 <- function(x){(3*x+2) %% 6}
h_3 <- function(x){(5*x+2) %% 6}

numHash = 3
inputRows = dim(m_i)[1]
inputCols = dim(m_i)[2]

#Signature Matrix
m_s = matrix(rep(NA, inputCols * numHash), nrow=numHash)
for (r in 1:inputRows){
  hash = c(h_1(r), 
           h_2(r),
           h_3(r))
  for (c in 1:inputCols){
    if (m_i[r,c] == 1) {
      for (h in 1:numHash) {
        if (is.na(m_s[h,c]) || (hash[h] < m_s[h,c])){
          m_s[h,c] = hash[h]
        }       
      }
    }
  }
  message(sprintf('Row: %d', r))
  print(m_s)
}

## Result for (a)
###########################
# Row: 1
#      [,1] [,2] [,3] [,4]
# [1,]   NA    3   NA    3
# [2,]   NA    5   NA    5
# [3,]   NA    1   NA    1
# Row: 2
#      [,1] [,2] [,3] [,4]
# [1,]   NA    3   NA    3
# [2,]   NA    2   NA    5
# [3,]   NA    0   NA    1
# Row: 3
#      [,1] [,2] [,3] [,4]
# [1,]    1    3   NA    1
# [2,]    5    2   NA    5
# [3,]    5    0   NA    1
# Row: 4
#      [,1] [,2] [,3] [,4]
# [1,]    1    3    3    1
# [2,]    5    2    2    5
# [3,]    5    0    4    1
# Row: 5
#      [,1] [,2] [,3] [,4]
# [1,]    1    3    3    1
# [2,]    5    2    2    5
# [3,]    5    0    3    1
#==========================
# Row: 6 ## Signature here:
#      [,1] [,2] [,3] [,4]
# [1,]    1    3    3    1
# [2,]    2    2    2    5
# [3,]    2    0    3    1


## part (b)
permutations = NULL
for (r in 1:inputRows){
  hash = c(h_1(r), 
           h_2(r),
           h_3(r))
  permutations <- rbind(permutations, hash)
}
rownames(permutations)<-1:inputRows
colnames(permutations)<-c("h_1(x)", "h_2(x)", "h_3(x)")
# > permutations
#   h_1(x) h_2(x) h_3(x)
# 1      3      5      1
# 2      5      2      0
# 3      1      5      5
# 4      3      2      4
# 5      5      5      3
# 6      1      2      2


## part (c)
jacard.sim <- function(X,Y,considerZero=FALSE){
  df <- cbind(X,Y)
  if (!considerZero) {
    df <- df[!apply(df, 1, function(r){all(r==0)}),]  
  }
  df_intersect = sum(apply(df, 1, function(x){x[1]==x[2]}))
  df_union = dim(df)[1]
  return (df_intersect/df_union)
}
jacard_true = c(
  jacard.sim(m_i[,1], m_i[,2]), #0
  jacard.sim(m_i[,1], m_i[,3]), #0
  jacard.sim(m_i[,1], m_i[,4]), #0.25
  jacard.sim(m_i[,2], m_i[,3]), #0
  jacard.sim(m_i[,2], m_i[,4]), #0.25
  jacard.sim(m_i[,3], m_i[,4])  #0.25
)
jacard_estimate = c(
  jacard.sim(m_s[,1], m_s[,2], TRUE), #0.33
  jacard.sim(m_s[,1], m_s[,3], TRUE), #0.33
  jacard.sim(m_s[,1], m_s[,4], TRUE), #0.33
  jacard.sim(m_s[,2], m_s[,3], TRUE), #0.67
  jacard.sim(m_s[,2], m_s[,4], TRUE), #0
  jacard.sim(m_s[,3], m_i[,4], TRUE)  #0
)
jacard_diff = jacard_estimate - jacard_true
jacard_summary = data.frame(Estimate=jacard_estimate,
                            True=jacard_true, 
                            Diff=jacard_diff,
                            row.names=c("[S1,S2]",
                                        "[S1,S3]",
                                        "[S1,S4]",
                                        "[S2,S3]",
                                        "[S2,S4]",
                                        "[S3,S4]"))

fractions(as.matrix(jacard_summary))
#         Estimate True Diff
# [S1,S2]  1/3        0  1/3
# [S1,S3]  1/3        0  1/3
# [S1,S4]  1/3      1/4 1/12
# [S2,S3]  2/3        0  2/3
# [S2,S4]    0      1/4 -1/4
# [S3,S4]    0      1/4 -1/4

# > apply(jacard_summary,2,function(x){round(x,4)})
#         Estimate True    Diff
# [S1,S2]   0.3333 0.00  0.3333
# [S1,S3]   0.3333 0.00  0.3333
# [S1,S4]   0.3333 0.25  0.0833
# [S2,S3]   0.6667 0.00  0.6667
# [S2,S4]   0.0000 0.25 -0.2500
# [S3,S4]   0.0000 0.25 -0.2500
