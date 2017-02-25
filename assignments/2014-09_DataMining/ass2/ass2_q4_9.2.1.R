#Exercise 9.2.1
#Values for alpha and beta scaling factors
a = 0.01
b = 0.5

#Setup
A = c(3.06, 500, 6)
B = c(2.68, 320, 4)
C = c(2.92, 640, 6)

if (!exists('a')) {a=1}
if (!exists('b')) {b=1}
scale = c(1, a, b)
A_scaled <- A * scale
B_scaled <- B * scale
C_scaled <- C * scale

#Comparing A-B
m_1 = A_scaled %*% t(B_scaled)
m_2 = A_scaled^2 %*% t(B_scaled^2)

#Comparing B-C
m_1 = B_scaled %*% t(C_scaled)
m_2 = B_scaled^2 %*% t(C_scaled^2)

#Comparing A-C
m_1 = A_scaled %*% t(C_scaled)
m_2 = A_scaled^2 %*% t(C_scaled^2)

# #Pulling answers from above comparisons here
# m_1
# m_2[1,1]
# m_2[1,2] + m_2[2,1]
# m_2[1,3] + m_2[3,1]
# m_2[2,3] + m_2[3,2]
# m_2[2,2]
# m_2[3,3]
# 
# (m_1[1,1] + m_1[2,2] + m_1[3,3]) /
#   sqrt((m_2[1,1] 
#         + m_2[1,2] + m_2[2,1] 
#         + m_2[1,3] + m_2[3,1]
#         + m_2[2,3] + m_2[3,2]
#         + m_2[2,2]
#         + m_2[3,3]
#         ))

#Cosine similarity 
sum(diag(m_1)) / sqrt(sum(m_2))

## Another way to compute cosine similarity
cos.sim <- function(X, Y){
  return(sum(X*Y)/sqrt(sum(X^2)*sum(Y^2)))  
}
cos.sim(A_scaled, B_scaled) #0.9908815
cos.sim(B_scaled, C_scaled) #0.9691779
cos.sim(A_scaled, C_scaled) #0.9915547