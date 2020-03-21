#Question 1
var1 = 50;
var2 = 12;
result = var1 %% var2
result

#Question 2
vector = c(0:29)
vector

#Question 3
matrix1 = matrix(seq(from = 10, to = 100, by = 10), nr = 5, nc = 2, byrow = T)
matrix1

#Question 4
vector2 = as.vector(matriz)
vector2

#Question 5
list1 = list(vector, matriz)
list1

#Question 6
names = c("Leonardo", "Flavio", "Bruno", "Danilo")
ages = c(22, 21, 21, 22)
name_x_age = cbind(names, ages)

#Question 7
View(iris)
dim(iris)
summary(iris)

#Question 8
path = file.path(getwd(), "effort.dat")
table = read.table(path)

#Question 9
colnames(table) <- c("Configuração", "Esforço", "Mudança")

#Question 10
dataframe = subset(iris, Sepal.Length > 7)
dataframe