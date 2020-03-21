# Operacoes com Matrizes e Matrizes Nomeados

# Configurando o diretorio de trabalho
# Coloque entre aspas o diretorio de trabalho que voce esta. Nao use nome com espacos

setwd("C:/projects/r-scripts/scripts")
getwd()

# zerar os ambientes!

# Criando Matrizes para suportar 2 dimensões de dados

# Numero de Linhas (nr = numero de rows, no. de colunas? Depende do no. de dados)
matrix (c(1,2,3,4,5,6), nr = 2)     # preenchimento por coluna
matrix (c(1,2,3,4,5,6), nr = 3)
matrix (c(1,2,3,4,5,6), nr = 6)

# sempre com 2 dimensões

# Numero de Colunas (nc = numero de colunas, no. de linhas? Depende do no. de dados)
matrix(c(1,2,3,4,5,6), nc = 2)

matrix(c(1,2,3,4), nc = 2)      # Veja!


# Help
?matrix       # descrição com todos os parâmetros e exemplos


# Matrizes precisam ter um no. de elementos que seja multiplo do no. de linhas/colunas
matrix (c(1,2,3,4,5), nc = 2)      # ??? 5 nao eh multiplo de 3


# Criando matrizes a partir de vetores e preenchendo a partir das linhas
meus_dados = c(1:10)
matrix(data = meus_dados, nrow = 5, ncol = 2, byrow = T) # preendhimento por linha
matrix(data = meus_dados, nrow = 5, ncol = 2)    # default: preenchimento por coluna


# Indexacao da Matriz
mat = matrix(c(2,3,4,5), nr = 2)
mat

mat[2,2]
mat[1,3]     # nao existe coluna 3, fora do limite
mat[,2]      # todas as linhas da 2a. coluna


# Criando uma matriz diagonal 
vetor = 1:3     # criar um vetor para coloca-lo emm uma matriz
diag(vetor)     # todos os elementos são iguais a zero, exceto a diagonal principal


# Extraindo vetor de uma matriz diagonal com os elementos da diagonal
matrizdiag = diag(vetor)
vetor1 = diag(matrizdiag)


# Transposta da matriz
w <- matrix(c(2,4,8,12 ), nr=2, ncol=2)  # vetor para preencher os elementos da matriz
w
 
u <- t(w)     # funcao t cria a matriz transposta, transforma linhas em colunas
u             # e colunas em linhas


# Obtendo uma matriz inversa
solve(w)


# Nomeando a Matriz
mat3 <- matrix(c('Terra', 'Marte', 'Saturno', 'Netuno'), nr = 2)
mat3

# nome das dimensoes,; no vetor a funcao era names
dimnames(mat3) = (list(c("Linha1","Linha2"),c("Coluna1","Coluna2")))
mat3
# pode-se usar os titulos definidos na nomeacao


# Identificando linhas e colunas no momento de criaÃ§Ã£o da Matriz
matrix(c(1,2,3,4), nr=2, nc=2, dimname =list(c("Linha 1","Linha 2" ),c("Coluna 1"," Coluna 2")))


# Combinando Matrizes
mat4 <- matrix(c(2,3,4,5),nr=2)
mat4
mat5 <- matrix(c(6,7,8,9),nr=2)
mat5
cbind(mat4, mat5)    # faz-se ligacao por coluna e passa-se as matrizes como parametros
rbind(mat5, mat4)    # faz-se ligacao por linha e passa-se as matrizes como parametros


# Imprimindo a desconstrucao de uma Matriz, transformando essa matriz em um vetor
vetor1 = c(mat4)
mat4
vetor1

