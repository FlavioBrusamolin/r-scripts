# Question 1
list.files()
ls()
installed.packages()

# Question 2
animals =  c('Leão', 'Jacaré', 'Cobra', 'Galinha', 'Galinha')
animals
fac_animals <- factor(animals)
fac_animals
levels(fac_animals)
summary(fac_animals)

# Question 3
roles = c("Bacharelado", "Bacharelado", "Bacharelado", "Especialização", "Mestrado", "Mestrado")
roles
fac_roles <- factor(roles, order = TRUE, levels = c("Mestrado" , "Especialização", "Bacharelado"))
fac_roles
summary(fac_roles)
levels(fac_roles) <- c("Stricto Sensu", "Lato Sensu", "Graduação")

# Question 4
disciplines = c("EC214", "EC020", "AC309", "EC020LAB")
difficulties = c(FALSE, TRUE, TRUE, FALSE)
expected_grades = c(80.0, 90.0, 90.0, 80.0)
data_frame = data.frame(disciplines, difficulties, expected_grades)
colnames(data_frame) <- c("Disciplina", "Dificuldade", "Nota")
str(data_frame)
str(data_frame$Disciplina)

# Question 5
check <- function(vec) {
  flag = FALSE
  
  for (el in vec) {
    if (el > 10 && el %% 2 == 0) {
      print(el)
      flag = TRUE
    }
  }
  
  if (!flag) {
    print("Não tem nesse vetor números pares maiores que 10")
  }
}

vec1 = c(12, 3, 14, 19, 34, 2, 25)
check(vec1)

vec2 <- c(21, 3, 15, 19, 37, 2, 25)
check(vec2)

# Question 6
list1 <- list(1, 1, 2, 3, 5, 8, 13, 21)
for (el in list1) {
  print(el)
}

# Question 7
mat1 <- matrix(c(1:50), nrow = 5, ncol = 5, byrow = T)
mat2 <- t(mat1)
mat4 <- mat1 %*% mat2 

vec <- c(0:4)
vec %*% mat2

rowSums(mat1)
colSums(mat2)
mat4[order(mat4)]

for (el in mat1) {
  if (el > 15) {
    print(el)
  }
}