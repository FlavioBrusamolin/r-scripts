# Operacoes com DataFrames

# Configurando o diretorio de trabalho
# Coloque entre aspas o diretorio de trabalho que voce esta. Nao use nome com espacos

setwd("C:/projects/r-scripts/scripts")
getwd()

# zerar os ambientes

# Criando um dataframe vazio
df <- data.frame()      # como eh vazia, nao preciso passar nenhum parametro
class(df)               
df                      # nao vai imprimir nada porque nao tem nenhuma linha e coluna


# Criando vetores vazios para montar estrutura num dataframe
nomes <- character()   # vetor de nomes vazio
idades <- numeric()    # vetor de double vazio
itens <- numeric()     # vetor de double vazio
codigos <- integer()   # vetor de inteiros vazio

df <- data.frame(c(nomes, idades, itens, codigos))
# passo para a funcao dataframe um vetor de vetores
df
# posso usar vetores vazios para montara a estrutura do dataframe
# cada vetor representara uma coluna no dataframe


# Criando vetores
cidade = c("Santa Rita", "Santa Rita", "Pouso Alegre", "Careaçu", "Valença")
nome = c("Amanda", "Flavio", "Milena", "Willer", "Heitor")
altura = c(1.56, 1.82, 1.69, 1.68, 1.80)
matricula = c(1247, 1249, 1240, 1287, 1241)


# Criando um dataframe de diversos vetores
pesquisa = data.frame(cidade, nome, altura, matricula) # passo direto os nomes dos vetores
pesquisa
# 1a e 2a. colunas caracter, 3a. double e 4a. inteiro
# dataframe eh uma matriz que suporta diferentes tipos de dados


# Adicionando um novo vetor a um dataframe existente - adicionar novas colunas
olhos = c("castanho", "azul", "castanho", "castanho", "castanho")
pesq = cbind(pesquisa, olhos)   # faz uma ligacao de 2 objetos pela coluna
pesq


# Coletar informacoes sobre o dataframe
str(pesq)        # resumo sobre os tipos de dados dentro dentro deste dataframe
# tipo fator, ordenacao automatica do R
dim(pesq)        # no. dimensoes 5 linhas e 5 colunas
length(pesq)


# Obtendo um vetor de um dataframe
pesq$cidade      # nome do dataframe $ nome da coluna
pesq$nome


# Extraindo um unico valor
pesq[1,1]
pesq[3,2]    # Milenaeh um dos niveis nesta coluna


# Numero de Linhas e Colunas
nrow(pesq)
ncol(pesq)

# Primeiros elementos do dataframe
head(pesq)       # retorna as 6 primeiras linhas
head(mtcars)


# ultimos elementos do dataframe
tail(pesq)       # retorna as 6 ultimas linhas
tail(mtcars)


# Data frames built-in do R
?mtcars         # dataset que traz informacoes sobre automoveis, pronto para uso
mtcars
View(mtcars)

# Filtro para um subset de dados que atendem a um criterio
pesq[altura < 1.60,]     # para retornar um indice do dataframe com uma regra
                         # apenas um registro atende a esta regra
pesq[altura < 1.60, c('nome', 'altura')] # retorna um conjunto especifico
pesq                     # nao se alterou o dataframe


# Dataframes Nomeados   - muda os titulos das linhas e colunas do dataframe
colnames(pesq) <- c("Var 1", "Var 2", "Var 3", "Var 4", "Var 5")
rownames(pesq) <- c("Obs 1", "Obs 2", "Obs 3", "Obs 4", "Obs 5")
pesq


# Carregando um arquivo csv 
# O formato csv é um tipo de arquivo de texto para transferência de 
# informações entre aplicativos diferentes (formato: colunas separadas por ,)

?read.csv        # le arquivo csv com os argumentos necessarios

# File / New File / Text File / salvar com pacientes.csv
pacientes <- data.frame(read.csv(file = 'pacientes.csv', header = TRUE, sep = ","))


# Visualizando o dataset
View(pacientes)    # funcao View com V maiusculo
head(pacientes)    # para visualizar as 5 primeiras linhas
summary(pacientes) # para mostrar resumos estatisticos (media, mediana, quartis...)


# Visualizando as variaveis
pacientes$Diabete
pacientes$status      # case sensitive
pacientes$Status


# Histograma
hist(pacientes$Idade)   # mostra a distribuicao de frequencias das idades desse dataset


# Combinando dataframes
dataset_final <- merge(pesq, pacientes)  # faz um produto cartesiano dos 2 datasets
dataset_final


