# Operacoes com Listas e Listas Nomeadas

# Configurando o diretorio de trabalho
# Coloque entre aspas o diretorio de trabalho que voce esta. Nao use nome com espacos

setwd("C:/projects/r-scripts/scripts")
getwd()

# zerar os ambientes

# Use list() para criar listas

# Lista de strings
lista_caracter1 = list('A', 'B', 'C')          # ver o tipo em Environment
lista_caracter1
lista_caracter2 = list(c("A", "A"), 'B', 'C')  # tenho como 1o. elemento, um vetor
lista_caracter2
lista_caracter3 = list(matrix(c("A", "A", "A", "A"), nr = 2), 'B', 'C')
lista_caracter3                                # o 1o. elemento é uma matriz
# o primeiro número [[1]] é a dimensao


# Lista de numeros inteiros
lista_inteiros = list(2, 3, 4)
lista_inteiros


# Lista de floats
lista_numerico = list(1.90, 45.3, 300.5)
lista_numerico


# Lista de numeros complexos
lista_complexos = list(5.2+3i, 2.4+8i)
lista_complexos


# Lista de valores logicos
lista_logicos = list(TRUE, FALSE, FALSE)
lista_logicos


# Listas Compostas sao listas com tipos de dados diferentes. No vetor nao eh possivel
lista_composta1 = list("A", 3, TRUE)
lista_composta1
# com caracter, com numero e com valor logico

lista1 <- list(1:10, c("Brigadeiro", "Beijinho", "Cajuzinho"), rnorm(10))
lista1
# um vetor de numeros, um vetor de strings e uma distribuicao normal

?rnorm      # permite representar uma distribuicao normal

# Slicing (fatiamento / indexacao) da Lista; dimensao vem entre [[ ]]
lista1[1]                 # a 1a. dimensao eh um vetor
lista1[2]                 # eh o vetor de strings da 2a. dimensao
lista1[[2]][1]            # o 1o. elemento na dimensao 2
lista1[[2]][1] = "Trufa"  # alterar este elemento para Trufa 
lista1

# Para nomear os elementos - Listas Nomeadas
names(lista1) <- c("inteiros", "caracteres", "distrib.normal")
lista1
# um titulo para cada uma das dimensoes apos criacao da lista

vec_num <- 1:4
vec_char <- c("A", "B", "C", "D")
lista2 <- list(Numeros = vec_num, Letras = vec_char)
lista2
# para nomear no momento da criacao da lista


# Nomear os elementos diretamente
lista2 <- list(elemento1 = 3:5, elemento2 = c(7.2,3.5)) # posso criar diretamente
lista2


# Trabalhando com elementos especificos da lista
lista1$caracteres       # vai retornar os elementos da dimensão "caracteres"
length(lista1$inteiros) # vai retornar o comprimento da dimensao "inteiros"


# Verificar o comprimento da lista
length(lista1)          # 3 = 3 dimensoes


# Podemos extrair um elemento especifico dentro de cada nivel/dimensao da lista
lista1$caracteres[2]


# Mode dos elementos - uma lista pode cmportar diferentes tipos de dados
mode(lista1$distrib.normal)
mode(lista1$caracteres)


# Combinando 2 listas - a funcao c eh muito mais do que para criar vetores, posso unir
lista3 <- c(lista1, lista2)
lista3


# Transformando um vetor em lista
v = c(1:3)
v
l  = as.list(v)
l


# Unindo 2 elementos em uma lista (2 dimensoes)
mat = matrix(1:4, nrow = 2)
mat
vec = c(1:9)
vec
lst1 = list(mat, vec)
lst1



