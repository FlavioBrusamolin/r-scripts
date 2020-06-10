# Roteiro do Estudo Dirigido 

# Limpeza, Formatacao e Manipulacao de Dados em R 

# Este Estudo Dirigido e o arquivo sono estao disponiveis no Portal Academico. 

# Caros(as) Alunos(as), SIGAM O ROTEIRO, sequencialmente!

# Primeiramente, sete o seu diretorio de trabalho, onde voce colocou 
# este Script e arquivo Excel sono.
  
# Manipulacao de dados = Data Wrangling, pode ter varias definicoes diferentes, mas eh
# preparar os dados para o processo de analise, pois dificilmente os dados virao no
# formato ideal, prontos para uso.

# Outros termos.....Data Preprocessing, Data Scrubbing, Data Munging, Data Fold....

# Eh necessario, para o seu processo de analise, apos fazer a carga dos dados... 
# fazer limpeza, transformacao, preprocessamento, trazer mais dados, 
# remover algumas colunas..., manipulacao, etc.

# Vamos conhecer algumas ferramentas, processos e tecnicas de Data Wrangling para 
# aplicar nos dados para que eles estejam prontos para o processo de analise

#  dados         dados           dados        
# brutos       organizados   consistentes     analise           resultados
# <--------- Data Wrangling ------------>               (modelo preditivo, relatorio)
 
# Analogia: vamos pensar num prato de um chef que vai para a mesa do cliente
#
# Antes de finalizar a "peca gastronomica", o que o chefe de cozinha fez:
#    a) comprou os ingredientes
#    b) limpou os legumes
#    c) preparou o tempero
#    d) cortou os elementos que compoem o prato
#    e) fez o cozimento
#
# Boa parte do trabalho como cientista de dados sera feito na preparacao dos dados:
# na conversao e no mapeamento dos dados em outro formato mais conveniente

# O que fazemos essencialmente durante a etapa de manipulacao dos dados?
# Principalmente 2 tarefas, identificar o que uma variavel, uma observacao e 
#    1) cada variavel (atributo/caracteristica) deve ser colocada em uma coluna e 
#    2) cada registro (observacao) deve ser colocada em uma linha
 
# Pacotes para manipulacao de dados em R: dplyr e tidyr que possuem funcoes para 
# selecionar, filtrar, espalhar, separar, unir os dados, tudo o que voce
# precisa fazer com o seu conjunto de dados


# Pacote dplyr: para fazer transformacao nos dados

# select() - selecionar parte dos dados
# filter() - usar uma regra (filtro) para selecionar
# group_by() - agrupar os dados
# summarise() - sumarizar os dados (fazer um resumo)
# arrange() - reorganizar as linhas em uma ou mais colunas 
# mutate() - realizar calculos dentro de uma mesma coluna
# join() -  unir 2 ou mais datasets, extrair uma coluna de um dataset
#        -  extrair uma coluna de outro dataset para compor um dataset final

# Operador de concatenacao: %>%, para nao repetir o conjunto de dados e usar mais funcoes
#
# filter(data, variable == numeric_value)
#               ou
# data %>% filter(variable == numeric_value)

# Vamos instalar os pacotes readr (para leitura de conjunto de dados) e dplyr
install.packages("readr")
install.packages("dplyr")
library(readr)
library(dplyr)

# Vamos carregar o dataset sono disponibilizado
sono_df <- read_csv("sono.csv")
# imprime na tela um resumo do que ele fez para carregar os dados (caracter e double)

# Vamos explorar um pouco esse conjunto de dados para transformar, formatar e modificar
View(sono_df)
head(sono_df)
# Para ver as primeiras linhas, o read_csv importa e ja colona no formato tible
# formato de tabela. A 2a. linha mosra o tipo dos dados conforme o resumo e o
# ~ indica que tem mais caracteres nesta palavra e esta faltando a coluna peso.
# Ampliar o painel da console e usar o head novamente.
head(sono_df)

# Funcao glimpse() pode ser usada para mostrar um resumo completo com todos os tipos
glimpse(sono_df)

# Vamos aplicar a funcao mutate (pacote dplyr) junto com a funcao glimpse
# Gera uma nova coluna (peso_libras) no dataframe. Ela nao existe.
# Para calcular a coluna peso_libras, a funcao faz uma operacao
glimpse(mutate(sono_df, peso_libras = sono_total / 0.45359237))

# Nao criou necessariamente uma nova coluna, apenas preparou para visualizar
View(sono_df)

# Vamos contar e fazer um histograma
count(sono_df, cidade)
# Quantos registros relacionados a coluna cidade. Contou por cidade

hist(sono_df$sono_total)
# Distribuicao de frequencia da variavel sono_total

# Vamos fazer uma amostragem de tamanho 10, coleta uma amostra aleatoria do conjunto
sample_n(sono_df, size = 10)

# Vamos fazer uma selecao usando a funcao select() do pacote dplyr
dadosono <- select(sono_df, nome, sono_total)
# Vou selecionar do dataframe as colunas nome e sono_total

head(dadosono)
# Retornou apenas nome e sono_total

# Podemos fazer o select de apenas uma coluna
select(sono_df, nome)

# Podemos também selecionar um range de colunas
select(sono_df, nome:cidade)

# Ver o dataframe e estabelecer outro range
# Nao preciso especificar o nome da cada coluna que eu quero retornar
select(sono_df, nome:sono_total)

# Vamos filtrar com a funcao filter()
filter(sono_df, sono_total >= 16)
# Retornar dados do dataframe somente quanto sono_total for maior ou igual a 16

# Incluir outra condicao com o separador virgula..... Identificar o registro.. Raisa
filter(sono_df, sono_total >= 16, peso >= 80)

# Podemos tambem incluir o operador in (igual da linguagem SQL)
# Retornar do conjunto de dados, na coluna cidade onde os valores forem
# Recife e Curitiba
filter(sono_df, cidade %in% c("Recife", "Curitiba"))

# Estamos aplicando o SQL de maneira modificada (no padrao da Linguagem R)

# Funcao arrange() do pacote dplyr
# Vamos aplicar o operador de concatenacao que simplifica a sintaxe
sono_df %>% arrange(cidade) %>% head

# A coluna cidade esta ordenada por ordem alfabetica e nao mostrou
# tudo porque concatenamos com a funcao head que imprime as primeiras linhas.

# Pegamos o dataframe, concatenamos com a operacao de ordenacao pela coluna
# cidade e concatenamos com a funcao head.

# Mais concatenacoes, vamos unir diferentes funcoes

# a partir do dataset, vamos concatenar uma operacao de select retornando 
# apenas as colunas nome, cidade e sono_total. Vamos concatenar com uma funcao
# arrange para ordenar por cidade e depois por sono_total e nao quero todos
# os registros, concatenando com a funcao head
sono_df %>% 
  select(nome, cidade, sono_total) %>%
  arrange(cidade, sono_total) %>% 
  head

# Podemos aplicar um filtro com coluna sono_total >= 16
# Uma instrucao, em linhas diferentes para melhorar legibilidade
sono_df %>% 
  select(nome, cidade, sono_total) %>%
  arrange(cidade, sono_total) %>% 
  filter(sono_total >= 16)


# Podemos aplicar a funcao desc que ordem decrescentemente sono_total.
# Veja a diferenca do mostrado anteriormente
sono_df %>% 
  select(nome, cidade, sono_total) %>%
  arrange(cidade, desc(sono_total)) %>% 
  filter(sono_total >= 16)

head(sono_df)
# O dataset esta intacto

# Vamos realizar um calculo com a funcao mutate().
# Novo campo... novo_indice que eh sono_total dividido por peso.
# E concateno com a funcao head.
sono_df %>% 
  mutate(novo_indice = sono_total / peso) %>%
  head
# Tentar ver nova coluna..... aumentando o painel da Console.

head(sono_df)
# Verifique que esta nova coluna nao foi incluida no dataset.
# O dataset esta original.
# Ela foi calculada e mostrada apenas em tempo de execucao,
# para avaliar se isto eh util ou nao.


# Podemos também fazer mais de um calculo  de maneira
# simultanea com a funcao mutate.
sono_df %>% 
  mutate(novo_indice = sono_total / peso, 
         peso_libras = peso / 0.45359237) %>%
  head

# Podemos fazer um resumo com a funcao summarize()
# Vai sumarizar pela media do sono com mean()
sono_df %>% 
  summarise(media_sono = mean(sono_total))

# Podemos tambem sumarizar com os valores minimo,
# maximo e total
sono_df %>% 
  summarise(media_sono = mean(sono_total), 
            min_sono = min(sono_total),
            max_sono = max(sono_total),
            total = n())
# Temos um belo resumo do nosso conjunto de dados:  a media, o minimo
# e o maximo valor de sono_total e, tambem o total de registros.

# Vamos fazer agrupamento usando a funcao group_by()
# Teremos o mesmo resumo, mas agrupado por cidade
sono_df %>% 
  group_by(cidade) %>%
  summarise(avg_sono = mean(sono_total), 
            min_sono = min(sono_total), 
            max_sono = max(sono_total),
            total = n())

View(sono_df)
# O dataset continua intacto, nao acrescentamos nenhuma linha,
# nenhuma coluna. Estamos apenas olhando para os dados, manipulando-os,
# verificando aquilo que pode ser feito em termos de limpeza, 
# transformacao, etc....
#
# Podemos gravar os resultados de uma determinada operacao 
# em outro dataframe.....por exemplo....

sono_df2 <- sono_df %>%
  mutate(novo_indice = round(sono_total * peso)) %>%
  arrange(desc(novo_indice)) %>%
  select(cidade, novo_indice)

View(sono_df2)
# Eh outro dataset completamente diferente.

# Dica: uma boa pratica eh nunca alterar o seu dataset original.
# Porque durante o processo de limpeza, transformacao, podemos 
# cometer erros, temos como comparar o dataset resultante com o
# o original sem ter que carregar os dados novamente.

# Mostrei uma serie de operacoes para limpeza, transformacao e
# manipulacao de dados: select, filter, group_by, mutate....
# Mas, temos ainda uma outra operacao durante esta fase de
# preprocessamento dos dados: operacao de remodelagem dos dados.
# Quando voce muda o shape (formato) dos dados, para que eles fiquem 
# aderentes as necessidades do seu processo de analise

# Pacote tidyr: para fazer remodelagem de dados, para modificacao de formato (shape).
# Mudar o formato dos dados pode fazer muita diferenca no processo de analise

# gather() - transforma linha em coluna
# spread() - transforma coluna em linha
# separate() - separar uma coluna em mais colunas (data em dia mes ano)
# unite() - unir colunas em um unica coluna

# Vamos instalar os pacotes tidyr e ggplot2
install.packages("tidyr")
install.packages("ggplot2")
library(tidyr)
library(ggplot2)

# Vamos criar um dataset simples para mostrar o conceito...
# Dados de medias em disciplinas: 3 colunas (nome, turmas A e B),
# com vetores que representam medias das turmas nas disciplinas
dados <- data.frame(
  Nome = c("Topicos", "Automacao", "Analise"),
  Turma_A = c(67, 71, 64),
  Turma_B = c(59, 90, 78)
)
dados

# Um dataset simples: 3 linhas e 3 colunas.
# Quantas variaveis temos neste dataset?
# Se associarmos as variaveis a coluna, neste caso 3 colunas, 3 variaveis
# Os dados estao confusos.... Na forma que o dataframe foi construido,
# teriamos Nome, Turma_A e Turma_B, mas, na verdade, as 3 variaveis sao
# Nome, Turma, Media (3 informacoes diferentes)

# Iremos gerar 2 novas colunas a partir das colunas Turma_A:Turma_B
dados %>%
  gather(Turma, MediaFinal, Turma_A:Turma_B)
# Agora temos 3 variaveis diferentes.
# A disciplina nao esta duplicada, pois tempos Topicos com nota 67 e 59
# Sao 2 observacoes (registros) diferentes:
#   Topicos Turma_A         67
#   Topicos Turma_B         59
# O que fizemos foi separar as variaveis e coloca-las em colunas especificas.
# Nao iria conseguir criar o modelo preditivo: cada variavel em uma coluna e
# cada registro em uma linha. 
# Remodelamos (fizemos) um reshape dos dados, ou seja, mudamos o formato.
# O dataset tinha informacoes distribuidas e tivemos que organizar
# em variaveis independentes para que possamos avancar no processo de analise


# Vamos criar mais um dataframe para remodelagem (reshape)
set.seed(1)
df2 <- data.frame(
  participante = c("p1", "p2", "p3", "p4", "p5", "p6"), 
  info = c("g1m", "g1m", "g1f", "g2m", "g2m", "g2m"),
  pontuacaodia1 = rnorm(n = 6, mean = 80, sd = 15), 
  pontuacaodia2 = rnorm(n = 6, mean = 88, sd = 8)
)
# Vamos imprimir esse conjunto na tela
print(df2)

# Reshape dos dados: criar as colunas dia e pontuacao
df2 %>%
  gather(dia, pontuacao, c(pontuacaodia1, pontuacaodia2))
# Criou uma coluna para o dia (1/2) e outra para a pontuacao
# O trabalho do Cientista de dados eh justamente identificar
# a necessidade de fazer a divisao, separacao.

df2 %>%
  gather(dia, pontuacao, c(pontuacaodia1, pontuacaodia2)) %>%
  spread(dia, pontuacao)
# Aqui separamos e voltamos para o original, pois a mudanca pode
# nao ter surtido efeito que esperavamos, voltamos para o original.
# O spread eh o oposto do gather.

df2 %>%
  gather(dia, pontuacao, c(pontuacaodia1, pontuacaodia2)) %>%
  separate(col = info, into = c("grupo", "genero"), sep = 2)
# A coluna info foi separada em 2 colunas: grupo e genero.
# Mais uma vez mudamos o chape do nosso conjunto de dados.


df2 %>%
  gather(day, score, c(pontuacaodia1, pontuacaodia2)) %>%
  separate(col = info, into = c("grupo", "genero"), sep = 2) %>%
  unite(infodenovo, grupo, genero)
# Decidimos unificar de novo, voltar ao original

# Por ultimo, vamos lembrar que podemos fazer tudo junto sem modificar o df2
df2 %>%
  gather(dia, pontuacao, c(pontuacaodia1, pontuacaodia2)) %>%
# Para modificar o shape (de linha e coluna).
  separate(col = info, into = c("grupo", "genero"), sep = 2) %>%
# Para separar as colunas.
  ggplot(aes(x = dia, y = pontuacao)) + 
# Para desenhar o grafico (dia x pontuacao).
  geom_point() + 
# Grafico de pontos.
  facet_wrap(~ grupo) +
# Para separar em 2 graficos na mesma area de plotagem.
  geom_smooth(method = "lm", aes(group = 1), se = F)
# Para colocar um modelo (linha) de regressao.


# Isso tudo demonstra o poder da Linguagem R para manipulacao de dados. 
# Outra linguagem que faz algo similar como o R eh o Python.
# Tentar fazer isso com Java, Scala teremos muito trabalho.










