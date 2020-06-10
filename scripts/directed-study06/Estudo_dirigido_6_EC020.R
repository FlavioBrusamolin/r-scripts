# Este Estudo Dirigido esta disponivel tambem no Portal Academico. 

# Caros(as) Alunos(as), SIGAM O ROTEIRO, sequencialmente!

# Primeiramente, sete o seu diretorio de trabalho, onde voce colocou 
# este Script e o arquivo carros-usados


# Estudo Dirigido: Analise exploratoria de dados.

# O objetivo deste estudo eh mostrar como a analise exploratoria dos dados eh importante.
# Independentemente do modelo de machine learning que voce vai construir, a analise
# exploratoria eh fundamental.

# Analise exploratoria eh voce conhecer os dados. Voce nao pode comecar um processo de
# limpeza, transformacao, de pre-processamento se voce nao conhece os dados: a media, 
# a mediana, como os dados estao distribuidos, se as variaveis sao numericas ou
# categoricas. Se sera necessario fazer algum tipo de transformacao nessas variaveis.
# Ou seja, as etapas seguintes de pre-processamento dependem de uma analise exploratoria.

# Depois que carregamos os dados, a analise eh a primeira etapa, independentemente do tipo
# de modelo de machine learning que voce vai criar.

# Neste estudo, vamos primeiramente carregar o conjunto de dados. Faremos uma breve
# exploracao. E vamos trabalhar com variaveis numericas e tambem com variaveis categoricas.

# Irei colocar varias dicas, varios exemplos de interpretacao dos resultados da analise
# exploratoria. Nao existe uma unica formula para analise exploratoria. Depende do problema
# de negocio, depende do conjunto de dados, etc.

# Vamos carregar o pacote readr, considerando que ele ja esteja instalado
library(readr)

# Vamos carregar o nosso arquivo csv utilizando a funcao read_csv
carros <- read_csv("carros-usados.csv")

# Vamos dar um View em nosso conjunto de dados
View(carros)

# Temos aqui informacoes sobre automoveis: ano, modelo, preco, kilometragem, cor e
# transmissao: automatico ou manual. Com 150 linhas e 6 colunas.
# A partir desse conjunto de dados, iremos fazer algumas exploracoes.
# Porque vamos compreender os dados. E isso eh analise exploratoria. 
# Se voce nao conhecer os dados, como ira conhecer as tecnicas de limpeza, 
# transformacao e pre-processamento? Temos que saber o que temos no nosso dataset.

# Vamos apresentar um resumo das variaveis desse dataset. Ver os tipos!
str(carros)

# O interpretador da linguagem R decidiu qual tipo eh de cada variavel ao carregar o
# dataset. Veja o tipo de ano, eh numerico. Mas sera que utilizaremos este conteudo
# numerico? Nao iremos fazer calculos com o ano, certo? Nao iremos somar 2011 com 2012...
# Na pratica, esta eh uma variavel que eu poderia colocar como sendo categorica,
# do tipo fator para ter as categorias bem definidas.

# Vamos inicialmente verificar as medidas de tendencia central... limpando a console....
# Inicialmente para a variavel ano do conjunto, temos o resumo basico da variavel ano:
summary(carros$ano)
# media... 2009, minimo, maximo, 1o. quartil, 3o. quartil e mediana,
# na media os carros que constam desse dataset sao do ano de 2009,
# mediana 2009 como a media, isto indica, provavelmente, ano tem dist. normal.

# Agora vamos mostrar o summary de 2 variaveis: preco e kilometragem.
# Passo como um vetor usando a funcao c que sera usada como um indice 
# para trazer 2 colunas do dataset carros:
summary(carros[c('preco', 'kilometragem')])
# Conseguimos retornar os resumos de 2 variaveis: minimo, 1o. quartil, mediana, media
# .... etc. E assim temos uma ideia de como os dados estao distribuidos


##### Analise exploratoria de dados para variaveis numericas ##### 

# Vamos usar algumas funcoes estatisticas
mean(carros$preco)
median(carros$preco)
# Aparentemente a variavel preco nao esta com uma distribuicao normal porque
# media e mediana estao com valores diferentes

##### O que sao os Quartis e Percentis? #####

# Se o numero de observacoes eh grande, eh interessante calcular algumas outras 
# medidas de posicao. E essas medidas sao uma extensao do conceito de mediana.

# Suponha que estamos conduzindo um experimento com animais. 
# Eles recebem uma droga e medimos o tempo de vida (em dias) 
# apos a ingestao dessa droga. Poderiamos fazer a seguinte pergunta: 

# Qual eh o tempo em que 50% dos animais ainda estao vivos? 
# Obviamente esse valor sera a mediana. 

# Poderiamos estar interessados em saber qual eh o tempo em que 75% dos 
# animais estao vivos. Ou 25%. 

# Esses valores sao chamados de Quartis da distribuicao (dividem a distribuicao
# em quarto partes) e sao representados por Q1  (1o. quartil 25%) e Q3 (3o. quartil 75%). 
# O segundo quartil, Q2, que corresponde a 50%, eh a mediana.

?quantile

# Esse conceito pode ser estendido um pouco mais, e em lugar de 25%, 50% e 75%, 
# podemos querer calcular percentis (5%, 10%, 90%).

# Os percentis sao os valores que separam um conjunto de dados em 100 partes iguais. 
# O percentil 10 representa o decimo percentil e tera 10% dos dados antes dele, 
# a logica se segue para todo percentil.

# Exemplo: para calcular o percentil 10, 80 e 98, usa-se a funcao quantile..
# quantile(......, c(.10))
# quantile(......, c(.80))
# quantile(......, c(.98))

# Vamos calcular os quartis
quantile(carros$preco)

# Podemos calcular os percentis de 1% e 99%
quantile(carros$preco, probs = c(0.01, 0.99))

# Podemos tambem definir alguns percentis especificos
quantile(carros$preco, seq( from = 0, to = 1, by = 0.20))

# Podemos calcular a diferenca inter-quartil (entre Q3 e Q1)
IQR(carros$preco) 

# Podemos verificar o range: valores minimo e maximo
range(carros$preco)

# Podemos ainda calcular a diferenca entre o valor minimo e o valor maximo de preco
diff(range(carros$preco))

# Fizemos esta exploracao apenas para a variavel preco. Esta exploracao poderia
# se estendar para as demais variaveis numericas do conjunto

# Eh sempre mais facil analisar um grafico do que numeros e tabelas
# Vamos fazer algumas exploracoes com alguns graficos ....

# Boxplot: grafico que apresenta a mediana (linha preta continua no meio do quadrado) e 
# outras medidas: minimo, 1o. quartil, mediana, 3o. quartil e maximo de baixo para cima.
# E ainda os outliers (valores extremos) inferiores e superiores em um mesmo grafico.
# Esses outliers estao muito distantes da media, o que pode impactar na construcao
# do modelo preditivo. Outliers devem ser tratados (retirados ou analisados).

# O outlier pode ser uma fraude. Analise de fraudes em uso de cartao de credito:
# buscar os outliers e nao deleta-los eh uma analise importante. Isso depende do objetivo.

boxplot(carros$preco, main = "Boxplot para os Precos de Carros Usados", ylab = "Preco (R$)")

boxplot(carros$kilometragem, main = "Boxplot para a Km de Carros Usados", ylab = "Kilometragem (Km)")

# Histograma: indica a frequencia de valores dentro de cada bin/break (classe de valores)
hist(carros$preco, main = "Histograma para os Precos de Carros Usados", xlab = "Preco (R$)")
# A maioria dos automoveis esta no preco de 12.000, 13.000 reais; com poucos carros abaixo de
# 5.000 e poucos acima de 20.000 reais. A ultima classe mostra que temos alguns outliers.

# Vamos criar um histograma para a variavel kilometragem
hist(carros$kilometragem, main = "Histograma para a Km de Carros Usados", ylab = "Kilometragem (Km)")
# Veja que boa parte dos automoveis estao com kilometragem abaixo de 50.000. Eh a maior frequencia.

# Caso a visualizacao nao esteja facil, podemos mudar a quantidade de breaks....
# Compactamos um pouco mais o histograma para visualizar melhor a informacao.
# 5 breaks (ou 4)? ou 6 (7)?
hist(carros$kilometragem, main = "Histograma para a Km de Carros Usados", breaks = 6, ylab = "Kilometragem (Km)")

# Boxplot e Histograma servem para analisar apenas uma unica variavel. Mas em alguns casos
# queremos fazer um analise multivariada, ou seja, queremos analisar mais de uma variavel.
# Para isso usamos o grafico de dispersao, o Scatterplot.

# Scatterplot Preco x Km: quero visualizar a relacao entre a variavel preco e a variavel kilometragem,
# usando o preco como variavel dependente (y) da kilometragem (x)
plot(x = carros$kilometragem, y = carros$preco,
     main = "Scatterplot - Preco x Km",
     xlab = "Kilometragem (Km)",
     ylab = "Preco (R$)")

# Pergunta para voces! Interpretem..... 
# Observem o grafico... a medida que aumenta a kilometragem, o que acontece com o preco? 
# Deem um pause no video por um minuto, para responder!

# Observando o grafico, a medida que se aumenta a kilometragem, diminui-se o preco.
# Com um automovel de alta kilometragem, tem-se um preco bem abaixo da media.
# Isto eh obvio porque estamos olhando para o grafico. Mas se olharmos apenas
# para o dataset, talvez eu nao tenha esta informacao de maneira tao simples como
# estamos visualizando.

# Medidas de Dispersao:
# ao interpretar a variancia e o desvio padrao, numeros altos indicam que 
# os dados estao espalhados mais amplamente em torno da media. 
mean(carros$preco)
var(carros$preco)
sd(carros$preco)  # aproximadamente 24%

mean(carros$kilometragem)
sd(carros$kilometragem) # aproximadamente 60%

# Ate aqui tivemos alguns exemplos de como explorar variaveis numericas:
# criar graficos, coletar metricas e analisar as informacoes.


##### Analise exploratoria de dados para variaveis categoricas ##### 

# Criando tabelas de contingencia para representar variavel categorica.

# O que sao variaveis categoricas? Sao as variaveis que nao possuem valores 
# quantitativos, mas, ao contrario, sao definidas por varias categorias, ou seja, 
# representam uma classificacao dos individuos. Podem ser nominais ou ordinais.

# Variaveis nominais: nao existe ordenacao entre as categorias. Exemplos: sexo, cor dos olhos, 
# fumante/nao fumante, doente/sadio.

# Variaveis ordinais: existe uma ordenacao entre as categorias. Exemplos: escolaridade
# (1o, 2o, 3o graus), estagio da doenca (inicial, intermediario, terminal), 
# mes de observacao (janeiro, fevereiro,..., dezembro).

# Vamos listar as categorias de variaveis nominais.
# A funcao table cria uma tabulacao cruzada, ou seja, uma tabela de contingencia.
# Ela calcula as ocorrencias para cada um dos valores da variavel categorica.
?table

str(carros)
# Percebam que as variaveis cor e modelo sao categoricas, do tipo character.

table(carros$cor)
# Temos 9 cores de automoveis e um numero maior na cor preta.

table(carros$modelo)
# Temos apenas 3 modelos de automoveis (SE, SEL e SES). A funcao table contabilizou 
# a quantidade de registros (linhas) que tem cada um desses modelos.

# Isto eh fazer exploracao das variaveis categoricas

# A funcao table nao altera nada no tipo de dado. Apenas faz a tabulacao.
str(carros) 

# Podemos tambem calcular a proporcao de cada categoria
# Calculamos a tabela de contingencia da variavel modelo e colocando em um objeto
model_table <- table(carros$modelo)

# A funcao prop.table calcula a proporcao de cada categoria em valores percentuais
prop.table(model_table)

# Vamos arredondar os valores para um digito decimal
model_table <- prop.table(model_table) * 100
round(model_table, digits = 1)
# Temos 52% dos automoveis SE, 15.3 do SEL e o restante do SES.
# Com 3 linhas de codigo, conseguimos buscar esta informacao.

# Vamos imaginar que se queira saber quais as cores que as pessoas mais compram?
# Olhando o View eh dificil coletar esta resposta......Mas usando linguagem R, eh possivel.

# Vamos criar uma nova variavel indicando cores que as pessoas compram com mais frequencia
# Vamos buscar o valor da variavel cor que estiver dentro deste vetor de cores.
carros$conserv <- carros$cor %in% c("Preto", "Cinza", "Prata", "Branco")
# O resultado disso eh um valor logico: FALSE ou TRUE. Cada valor da variavel
# cor que estiver dentro deste vetor, retornara TRUE, se nao, FALSE.
head(carros)

# Vamos fazer uma tabulacao, checando esta nova variavel...
table(carros$conserv)
# 51 automoveis nao estao com cores conservadoras, 99 estao.
round(prop.table(table(carros$conserv))*100,digits = 1)
# 66% com cores conservadoras e 34% nao

# Verificando o relacionamento entre 2 variaveis categoricas

# Vamos criar uma crosstable: tabela cruzada de contingencia

# Tabelas de contingencia fornecem uma maneira de exibir 
# as frequencias e frequencias relativas das observacoes

# Os elementos de uma categoria sao exibidos atraves das colunas; 
# e os elementos de outra categoria sao exibidos atraves das linhas.

# Vamos instalar o pacote gmodels
install.packages("gmodels")

# vamos carrega-lo
library(gmodels)

?CrossTable
CrossTable(x = carros$modelo, y = carros$conserv)
# x eh a variavel modelo e y eh a variavel das cores
# conservadoras (que esta com False ou True)
# Ver tabela gerada!








