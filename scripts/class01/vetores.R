# Operacoes com Vetores e Vetores Nomeados

# Configurando o diretorio de trabalho
# Coloque entre aspas o diretorio de trabalho que voce esta. Nao use nome com espacos
 
setwd("C:/projects/r-scripts/scripts")
getwd()

# zerar os ambientes

# Vetor de strings
vetor_caracter = c("dados", "ciencia", "academia")
vetor_caracter


# Vetor de floats
vetor_numerico = c(1.90, 45.3, 300.5) 
vetor_numerico             # colocou como numerico mas do tipo double


# Vetor de valores complexos
vetor_complexo = c(5.2+3i, 3.8+4i)
vetor_complexo


# Vetor de valores logicos
vetor_logico = c(TRUE, FALSE, TRUE, FALSE, FALSE) 
vetor_logico


# Vetor de numeros inteiros
vetor_integer  = c(2, 4, 6)
vetor_integer


# alem da funcao c, podemos criar um vetor utilizando as funcoes seq() e rep()
vetor1 = seq(1:10)     # passa-se os elementos de 1 a 10
vetor1
is.vector(vetor1)

vetor2 = rep(1:5)      # passa-se os elementos de 1 a 5
vetor2
is.vector(vetor2)


# Indexacao de vetores
a = vetor1
a
a[3]
a[11]    # nao tem indice 11    

b = vetor_caracter
b
b[2]
b[4]     # nao tem indice 4
# nao retorna erro, retorna NA. Cuidado com um dataset com NA's!!


# Combinando vetores
v1 = c(2, 3, 5)          # vetor de valores numericos
v2 = c("aa", "bb", "cc", "dd", "ee")  # vetor de strings
c(v1, v2) 
# um unico vetor de strings, o vetor tem apenas um tipo de dado


# Operacoes com Vetores de mesmo comprimento
x = c(1, 3, 5, 7) 
y = c(2, 4, 6, 8)

x * 5
x + y
x - y
x * y
x / y


# Somando vetores com numeros diferentes de elementos (comprimentos diferentes)
alfa = c(10, 20, 30)                 # com 3 elementos
beta = c(1, 2, 3, 4, 5, 6, 7, 8, 9)  # com 9 elementos
alfa + beta             # a partir do 4o. elemento de beta, pega novamente o 1o. de alfa


# Vetor Nomeado, dar nomes para os elementos dos vetores
v = c("Carlos", "Nazareth") 
v
names(v) = c("Nome", "Sobrenome")  # vai nomear os 2 elementos do vetor v

v
# nome como titulo da 1a. coluna e sobrenome no titulo da 2a. coluna

v["Nome"] 
# nomear um vetor eh importante porque posso acessar os elementos do vetor por este nome
# facilita para fazer pesquisa a um determinado elemento do vetor ou matriz


