# Laboratorio de Big Data no.1: carregar 8.5 milhoes de registros em menos de 7 segundos

# Mostrar como realmente se analisa um Big Data

# Objetivos desta aula:
# 1) mostrar um projeto simplificado do inicio ao fim
# 2) compreender o processo com as suas etapas
# 3) analisar o Big Data com Big Data Analytics

# Objetivo deste laboratorio: analisar a temperatura media em algumas cidades brasileiras

# Nao se analisa dados de maneira aleatoria 
# Voce analisa para resolver um problema (de negocio)

# Definicao do problema: quero fazer uma analise da temperatura media nas cidades brasileiras,
# para ajudar, por exemplo, a definir uma politica publica, para ajudar a definir como sera o
# abastecimento de alimentos e de agua em uma determinada cidade

# Etapas:
# 1a.) definir o problema
# 2a.) coletar os dados
# 3a.) carregar e processar estes dados
# 4a.) realizar o processo de analise: analisar e olhar para o passado (o que ja aconteceu) ou
#      trabalhar em modelagem preditiva (tentar prever o que vai acontecer); posso tanto
#      analisar o passado quanto tentar prever o futuro (emprego de machine learning)

# 1) Problema: analise das temperaturas medias em cidades brasileiras
#
# 2) Coleta dos dados: usaremos o site Berkeley Earth que contem a coleta das temperaturas de varias
#                      cidades ao redor do mundo nos ultimos 100 anos. Usado por cientistas para 
#                      realizar analise de aquecimento global
# http://berkeleyearth.org/data
#
# Esse website possui varias informacoes uteis caso esteja trabalhando em projeto de analise
# de clima e de aquecimento global. Possui varios datasets para o processo de analise.
#
# Para simplificar, eu ja baixei o conjunto de dados com o nome
# TemperaturasGlobais.csv,descompactado tem quase 500 MBytes (~496 MB unzip) e
#                         com compactacao formato .zip tem 78 MBytes
#
# Faca o download do arquivo zip no link abaixo e descompacte na mesma pasta onde esta este Script 
# https://drive.google.com/open?id=1nSwP3Y0V7gncbnG_DccNhrTRxmUNqMqa
#
# Vamos entrar no diretorio e ver o arquivo .csv, com 520.000 KBytes (~498 MBytes)
# Este diretorio deve estar no mesmo local onde esta este Script

# Vamos instalar e carregar alguns pacotes:
# "readr"..... para leitura de bases de dados
# "data.table" para manipular/criar bases de dados mais rapidamente
# "scales".... apenas carregar, ja esta instalado
# "dplyr"..... esse ja foi instalado, apenas carregar.... para manipulacao de dados
# "ggplot2"... esse tambem ja foi instalado, apenas carregar....para visualizacao de dados

# Obs: os pacotes precisam ser instalados apenas uma vez. 
# Se ja foram instalados em outro Script, nao eh necessario instalar novamente!

# Colocar aqui as funcoes de instalacao dos pacotes "readr" e "data.table"

install.packages("readr")
install.packages("data.table")
install.packages("scales")
install.packages("dplyr")
install.packages("ggplot2")

# Colocar aqui as funcoes de carregamento dos 5 pacotes acima

library(readr)
library(data.table)
library(scales)
library(dplyr)
library(ggplot2)

# 3) Carregamento dos dados
# Mostrar performance das funcoes read.table() e fread()
# Elas carregam os arquivos na memoria para o processamento com R, mas em tempos diferentes
#
# Vamos usar a funcao system.time() para comparar o tempo de carregamento das 2 funcoes
#
# Usar read.table(), colocar o diretorio e o nome do arquivo
# gravar no dataframe df_teste e usar a funcao system.time() para medir o tempo

system.time(df_teste <- read.table("TemperaturasGlobais.csv"))

# funcao read.table() mais antiga, lenta e não atende as necessidades de tempo e processamento atuais
# levou aproximadamente 372 segundos ~6 minutos para carregar 8,5 milhoes de registros
# o data frame foi carregado e tem um tamanho de 1.1 GB na memoria
# e tem um numero de registros > 8.5M porque requer a inclusao de separador para as colunas

# Usar fread(), colocar o diretorio e o nome do arquivo
# gravar no dataframe df e usar a funcao system.time() tambem para medir o tempo

?fread # do pacote data.table, rapido e amigavel

system.time(df <- fread("TemperaturasGlobais.csv"))

# funcao fread() mais nova, eh similar a read.table(), mas muito mais rapida e conveniente
# levou aproximadamente 7 segundos para carregar 8,5 milhoes de registros
# o tamanho ocupado em memoria eh menos da metade do carregamento da outra funcao
# e tem um numero de registros = 8.5 milhoes
# saimos de 6.2 minutos para 6.9 segundos
# funcao fread() mais otimizada

# Conclusao: Eh importante voce otimizar o seu processo de carga... hoje 8 milhoes x 8 bilhoes
#            esses tempos de carregamento vao variar de acordo com o seu hardware
#            dependendo da sua configuracao vai levar mais ou menos tempo para carregar
#            quantidade de memoria RAM, tipo do processador e disco (SSD x HD)
#
#            A maquina que rodou a funcao system.time() tem 8GB de Ram e Processador Core I5


# Vamos criar subsets dos dados que foram carregados

# Primeiro vamos identificar a quantidade de registros deste dataframe df
# qual a funcao para ver a quantidade de linhas (registros) desse dataframe?

nrow(df)

# Vamos identificar os nomes das colunas desse dataframe 
# qual a funcao para ver as 6 primeiras linhas desse dataframe?

head(df)

# Vamos filtrar as temperaturas das cidades do Brasil
# qual o nome do titulo da coluna pais?
#
# colocar a funcao subset (da lista de exercicios) para criar um novo dataframe 
# informar o data frame e fazer um filtro pelo pais (Country == 'Brazil') e
# carregar em brazil_cities

brazil_cities <- subset(df, Country == 'Brazil')

# Vamos eliminar os valor NA deste dataframe, presentes nas linhas e colunas
# aplicar a funcao na.omit ( NA: not available, valor missing, valor nao preenchido)
# os valores NA afetam a analise do data set

brazil_cities <- na.omit(brazil_cities)

# Qual a funcao para ver as 6 primeiras linhas do dataframe brazil_cities? Ver colunas!

head(brazil_cities) 

# Qual a funcao para ver a quantidade de registros desse novo dataframe?

nrow(brazil_cities) 

# Qual a funcao para ver a dimensao desse comjunto de dados (no. linhas e no. colunas)?

dim(brazil_cities)   

# 4) Processamento dos dados: preparacao e organizacao
# Vamos converter as datas: transformar o formato de uma coluna e atualizar ela mesma
#                           para extrair mes e ano

brazil_cities$dt <- as.POSIXct(brazil_cities$dt, format='%Y-%m-%d')
brazil_cities$Month <- month(brazil_cities$dt)   # para extrair o mes deste formato
brazil_cities$Year <- year(brazil_cities$dt)     # para extrair o ano deste formato

# Qual a funcao para ver as 6 primeiras linhas do dataframe brazil_cities? Ver novas colunas!

head(brazil_cities) 

# Vamos criar outros 3 subsets, com as temperaturas de algumas cidades apenas
#
# Ao inves de criar um grafico com todas as cidades do Brasil, vamos escolher 3
# especificas: Palmas, Curitiba e Varginha
# Vamos criar subsets do dataset brazil_cities para essas 3 cidades

# colocar a funcao subset para criar um novo dataset
# informar o data set e fazer um filtro pela cidade (City == 'Palmas') e
# carregar em palmas

palmas <- subset(brazil_cities, City == 'Palmas')

# Qual a funcao para ver a dimensao desse subconjunto palmas?

dim(palmas) 

# colocar a funcao subset para criar um novo dataset
# informar o data frame e fazer um filtro pela cidade (City == 'Curitiba') e
# carregar em curitiba

curitiba <- subset(brazil_cities, City == 'Curitiba') 

# Qual a funcao para ver a dimensao desse subconjunto curitiba?
 
dim(curitiba)

# colocar a funcao subset para criar um novo dataset
# informar o data frame e fazer um filtro pela cidade (City == 'Varginha') e
# carregar em varginha 

varginha <- subset(brazil_cities, City == 'Varginha') 

# Qual a funcao para ver a dimensao desse subconjunto varginha?

dim(varginha)

# Vamos fazer um filtro por ano, ao inves de pegar todos os anos
# vamos pegar alguns anos especificos: 1900, 1925, 1950, 1975, 2000 e 2010
# para o nosso processo de analise

palmas <- subset(palmas, Year %in% c(1900,1925,1950,1975,2000,2010))

# Como fariamos isso para os datasets curitiba e varginha?

curitiba <- subset(curitiba, Year %in% c(1900,1925,1950,1975,2000,2010))
varginha <- subset(varginha, Year %in% c(1900,1925,1950,1975,2000,2010))

# O que fizemos : definimos o problema, coletamos os dados, carregamos os dados e 
# estamos pre-processando esses dados, trabalhando com amostras.
# Na sequencia iremos plotar...

# Poderia ainda transformar os dados, pré-processar novamente, de acordo com a 
# necessidade, alimentar o modelo de machine learning, etc...

# Esse primeiro laboratorio esta sendo uma pequena amostra.
# Data Science eh muito mais complexo. Hoje esta sendo o 1o. passo.

# Construindo os Plots

# construindo o plot de Palmas com a funcao ggplot do pacote ggplot2
# o grafico com ggplot2 Eh bem profissional e com um bom nivel de qualidade

plot_palmas <- ggplot(palmas, aes(x = (Month), y = AverageTemperature, color = as.factor(Year))) +
  geom_smooth(se = FALSE,fill = NA, size = 2) +
  theme_light(base_size = 20) +
  xlab("Mes")+
  ylab("Temperatura Media") +
  scale_color_discrete("") +
  ggtitle("Temperatura Media ao longo dos anos em Palmas") +
  theme(plot.title = element_text(size = 18))

# plotando palmas

plot_palmas

# dar zoom, ver titulo, eixo y, eixo x, as linhas com os anos correspondentes
# veja que existe um padrao de comportamento das temperaturas medias para Palmas

# vamos construir o plot de Curitiba
 
plot_curitiba <- ggplot(curitiba, aes(x = (Month), y = AverageTemperature, color = as.factor(Year))) +
  geom_smooth(se = FALSE,fill = NA, size = 2) +
  theme_light(base_size = 20) +
  xlab("Mes")+
  ylab("Temperatura Media") +
  scale_color_discrete("") +
  ggtitle("Temperatura Media ao longo dos anos em Curitiba") +
  theme(plot.title = element_text(size = 18))

# plotando curitiba

plot_curitiba 

# vamos construir o plot de Varginha
 
plot_varginha <- ggplot(varginha, aes(x = (Month), y = AverageTemperature, color = as.factor(Year))) +
  geom_smooth(se = FALSE,fill = NA, size = 2) +
  theme_light(base_size = 20) +
  xlab("Mes")+
  ylab("Temperatura Media") +
  scale_color_discrete("") +
  ggtitle("Temperatura Media ao longo dos anos em Varginha") +
  theme(plot.title = element_text(size = 18))

# plotando varginha

plot_varginha 

# Ate aqui estabelecemos um processo simples de analise. Agora podemos entregar 
# este material para um tomador de decisao que pode criar uma politica publica,
# vai definir abastecimento de alimentos, de agua, familias carentes, etc.
#
# Isso aqui foi olhar para o passado. Podemos pegar este mesmo processo de analise
# e dar um passo adiante, ou seja, alimentar um modelo de aprendizado de maquina para que 
# ele possa fazer previsoes. Por exemplo, se eu quiser prever qual sera a temperatura media 
# em 2025. Nos podemos fazer isso aplicando machine learning. Pegamos esses dados, 
# alimento um algoritmo, faco treinamento e entrego o modelo preditivo.
#
# Podemos ainda implementar uma analise de series temporais para saber o comportamento de 
# cada periodo de tempo especifico
