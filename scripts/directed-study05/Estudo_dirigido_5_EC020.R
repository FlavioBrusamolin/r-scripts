# Este Estudo Dirigido esta disponivel tambem no Portal Academico. 

# Caros(as) Alunos(as), SIGAM O ROTEIRO, sequencialmente!

# Primeiramente, sete o seu diretorio de trabalho, onde voce colocou 
# este Script e onde vai gravar um arquivo resultante.


# Estudo Dirigido: Extraindo Dados da Web com Web Scraping em R.

# O objetivo deste Estudo eh mostrar como obter dados da Web e como manipular 
# esses dados para entregar um resultado, ou seja, um relatorio com todo o conteudo 
# que foi extraido de maneira organizada, limpa, de forma que possamos entregar 
# isso para um analista e, posteriormente, para um tomador de decisao).

# Para fazermos este estudo, precisamos saber o que eh HTML e CSS. Voce sabe, correto?

# Qualquer pagina Web que voce acessa na Internet, ela eh contruida com HTML e CSS, e
# algumas, com JavaScript para criar algum tipo de animacao, interatividade, etc.

# HTML eh uma especie de esqueleto de uma pagina Web, com uma linguagem baseada
# em tags. Organizando-se as tags tem-se uma pagina HTML.
# Colocando-se uma casca sobre o HTML, tem-se o CSS.

# Fazendo uma analogia....
# O HTML eh como se fosse o esqueleto humano.
# O CSS eh como se fosse a pele e as roupas que voce coloca no esqueleto.
# As paginas podem ter o mesmo esqueleto, mas podem ficar completamente diferentes,
# embora todas tenham o mesmo esqueleto (podendo ser maior ou menor).
# O CSS permite voce colocar cores, tamanhos, fontes, etc.

# Quase toda pagina das mais de 3 bilhões de paginas Web existentes
# sao formadas por HTML, CSS e algumas utilizam o JavaScript.

# Eh preciso aprender HTML e CSS para fazer Web Scraping??
# Voce nao precisa ser um especialista, mas voce precisa conhecer o minimo
# de sua fonte de dados. Se nao conhecer, como voce vai saber extrair os seus 
# dados e comecar uma organizacao....

# Com o botao direto do mouse, visualize o codigo fonte da sua pagina Web.
# Tudo isso eh criado por um ser humano, um programador de front-end.
# Esse documento eh considerado semi-estruturado. Voce pode extrair
# dados desse documento. Isso se chama Web Scraping.

#               Crawling x Scraping
# Web Crawling - "rastejar" por uma web page ou site buscando dados. Voce
# cria um programa, percorre uma pagina destino ou um Website inteiro e busca
# tudo que voce colocou como criterio. Este estudo nao eh de Web Crawling.
#
# Web Scraping - "raspar" os dados de uma web page.
# Vou olhar para uma pagina HTML, extrair os dados que sao do meu interesse
# para realizar o meu processo de analise.

# Para este estudo iremos acessar uma pagina do New York Times de 2017 com as 
# mentiras do atual presidente Donald Trump (sem nenhum cunho politico aqui, ok??)
#
# https://www.nytimes.com/interactive/2017/06/23/opinion/trumps-lies.html
#
# Nao estamos aqui discutindo se o Trump eh melhor ou pior...
# Queremos apenas analisar dados....
# Com base neste artigo, o autor listou varias mentiras do Trump.... o que 
# ele considera mentira, nao necessariamente seja uma mentira...
# com data, aquilo que o Trump falou, uma explicacao/observacao do autor e 
# onde ele falou (link da materia onde foi coletada)
#
# O nosso trabalho aqui neste estudo eh transformar isto em dados e levar para o RStudio,
# ou seja, o nosso objetivo eh acessar uma pagina Web, raspar os dados que nos interessam,
# organizar estes dados e prepara-los para o processo de analise.
 
# Pacotes R para Web Scraping
# RCurl
# httr
# XML
# rvest

# O pacote rvest eh muito util para quem nao conhece HTML e CSS
install.packages('rvest')
library(rvest)

library(stringr)
library(dplyr)
library(lubridate)   # para tratar com datas
library(readr)       # para fazer a leitura

# Vamos carregar a web page e gravar em um objeto em R 
paginaweb <- read_html("https://www.nytimes.com/interactive/2017/06/23/opinion/trumps-lies.html")
paginaweb
# O retorno eh um documento do tipo xml, semi-estruturado.
# A pagina veio cheia de coisas que nao nos interessa.

# Vamos comecar o processo de limpeza, vamos extrair os registros
# Cada elemento na web page acima tem o seguinte formato em html:
# <span class="short-desc"><strong> DATE </strong> LIE <span class="short-truth"><a href="URL"> EXPLANATION </a></span></span>

# Precisamos extrair tudo que tiver a classe "short-desc" (data, mentira e explicacao)
# Esta classe ..."short-truth" ... retorna apenas a explicacao

?html_nodes
# Esta funcao seleciona nodes de um documento HTML e eh do pacote rvest
# A funcao html_nodes vai buscar pelo .short-desc

resultados <- paginaweb %>% html_nodes(".short-desc")
resultados
# Vejam como ja melhorou de maneira consideravel. Transformamos o texto todo 
# baguncado em uma lista de tags: span.... class....strong. Isto permite
# que trabalhemos de forma mais organizada. Esta mais facil buscar os padroes
# para que eu possa extrair a data, o texto da mentira, a explicacao e o link.
# Temos uma lista de tags.

# Agora vamos executar a parte mais inteligente do processo que eh limpar 
# as tags de forma que possamos extrair os registros que interessam 

# Vamos construir um novo dataset
registros <- vector("list", length = length(resultados))
registros
# Criamos uma lista vazia do comprimento do objeto resultados (que 
# contem todas as tags que extraimos = 180) para receber todas as 
# alteracoes que vamos processar a partir de agora

for (i in seq_along(resultados)) 
# repeticao de 180x
  {
  datas <- str_c(resultados[i] %>% 
                  html_nodes("strong") %>% 
                  html_text(trim = TRUE), ', 2017')
  # para extrair a data, entre as tags strong, extrair o texto sem espacos adicionais
  # antes/depois e trabalhar com o ano de 2017
  
  mentira <- str_sub(xml_contents(resultados[i])[2] %>% html_text(trim = TRUE), 2, -2)
  # para extrair a mentira com str_sub que extrai um string
  
  explicacao <- str_sub(resultados[i] %>% 
                           html_nodes(".short-truth") %>% 
                           html_text(trim = TRUE), 2, -2)
  # para extrair a explicacao com a mesma regra da data, apenas com short-truth
  
  url <- resultados[i] %>% html_nodes("a") %>% html_attr("href")
  # para extrair o link, usa-se a tag href que aponta para um linl HTML
  
  registros[[i]] <- data_frame(datas = datas, mentira = mentira, explicacao = explicacao, url = url)
  # e gravamos tudo como um dataframe; tudo que extraimos vamos gravar de volta
  # ao objeto registros que eh uma lista
  
}

# Apresenta um warning de que o dataframe pode nao ser mais utilizado, para usar o tiblle


# Dataset final: um bind-rows para juntar todas as linhas do meu objeto (porque eh lista)
df <- bind_rows(registros)


# Vamos ajustar a data, porque quando extraimos, ficou como caracter, assim,
# transformamos o campo datas para o formato do tipo Date em R
df$datas <- mdy(df$datas)


# Vamos salvar o resultado em um arquivo CSV. Acabamos de fazer um Web Scraping.
# Nos nao iremos fazer a analise desses dados neste estudo.
# O objetivo aqui foi como extrair dados da Web.
write_csv(df, "mentiras_trump.csv")


# Vamos ler o arquivo e ver como ficou: temos a data, a mentira contada pelo Trump,
# a explicacao do autor que justifica que aquilo eh uma mentira e a 
# url da materia original de onde ele extraiu a informacao
df <- read_csv("mentiras_trump.csv")
View(df)

# Isto eh bem diferente do que temos na pagina HTML, pegamos
# todo o texto e convertemos no dataframe df.

# A partir daqui voce pode:
# a) alimentar um modelo de processamento de linguagem natural
# b) um modelo de analise de sentimentos
# c) extrair padroes 
# d) pode identificar como as mentiras se relacionam..... etc..

# As possibilidades são muitas. Agora voce ja sabe fazer o
#                WEB SCRAPING....



  
# 