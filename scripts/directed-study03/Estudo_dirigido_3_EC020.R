# Roteiro do Estudo Dirigido III de Topicos Avancados I (EC020): 
# Graficos mais profissionais em R com ggplot2 e lattice

# Este Estudo Dirigido tambem esta disponivel no Portal Academico. 

# Caros(as) Alunos(as), SIGAM O ROTEIRO, sequencialmente!

# Primeiramente, sete o seu diretorio de trabalho, coloque esse Script nele.
  
# Voces puderam perceber que dah para fazer muita coisa utilizando apenas
# o pacote basico de plotagem da Linguagem R, mas eh batante basico

# Existem alguns pacotes em R que permitem criar graficos bem mais completos e 
# visualmente muito mais profissionais e bonitos

# GGPLOT2
# O "queridinho" da comunidade Data Sciense eh o ggplot2 (versão para R e Python)
# totalmente gratuito

# ggplot2 eh um sistema grafico completo, alternativo ao sistema basico de graficos do R
# que oferece mais opcoes de modificacao, legendas prontas e formatacao mais solida.
# Como ele eh mais poderoso, ele tem um nivel de complexidade maior

# Estou colocando 2 links com 2 arquivos .pdf:
# 1o.) https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf

# Eh uma especie de folha de cola: CheatSheet do ggplot2 que tem um resumo
# das principais funções e seus parametros, com varios exemplos
# Eh uma folha bastante poluida porque eh um universo de possibilidades

# 2o.) https://cran.r-project.org/web/packages/ggplot2/ggplot2.pdf

# Eh um livro oficial do Cran de 277 paginas explicando tudo sobre o ggplot2

# Neste estudo dirigido irei mostrar alguns graficos com ggplot2, mas não sera 
# nem 20% do que o pacote oferece. O pacote oferece uma quantidade enorme de
# possibilidades. Pouco material em portugues, mas uma vasta documentacao em ingles

# Vamos instalar e carregar o pacote ggplot2
install.packages("ggplot2")
library(ggplot2)

# Vamos gerar uma massa de dados com o dataset tips
data(tips, package = 'reshape2')  # massa de dados com o pacote reshape2 para ajustar os dados

# Vamos visualizar este dataset. Qual o comando? Mostrar as variaveis do dataset.


# Vamos plotar um grafico simples com qplot(), funcao do pacote ggplot2
# Plotar 2 variáveis do conjunto de dados com a geometria de pontos

qplot(total_bill, tip, data = tips, geom = "point")
# Esse grafico eh de dispersao, Scatterplot, relacao entre 2 variaveis

# Versao mais otimizada com a funcao ggplot do pacote ggplot2
# Gerar um ScatterPlot (2 variaveis) com linha de regressao

ggplot(tips, aes(x = total_bill, y = tip)) +  # aes funcao de estetica
  geom_point(aes(color = sex)) +     # com pontos e color para diferenciar a coluna sex
  geom_smooth(method = 'lm')         # criar uma faixa em torno do modelo de regressão linear
                                     # a legenda foi incluida automaticamente, padrao ggplot2       

# A linha azul é o modelo preditivo
# A faixa cinza é um limite de confianca (margem de erro) 
# A qualquer momento posso pegar um totalbill (valor x) e olhar para a linha azul
# e pego qual o tip (gorjeta) correspondente, ou seja, quanto de gorjeta um garcon vai 
# ganhar em uma noite de trabalho

# Vamos gravar um grafico em um objeto, ver a classe e plotar
myplot <- ggplot(tips, aes(x = total_bill, y = tip)) +
  geom_point(aes(color = time)) +     # color para diferenciar a coluna time: almoco/janta
  geom_smooth(method = 'lm')

class(myplot)
print(myplot)

# Exercicio - Usando o dataset mtcars, crie um grafico com ggplot do tipo 
# ScatterPlot. Use as colunas disp e mpg nos eixos x e y respectivamente

# Primeiro vamos visualizar o cabecalho deste dataset. Qual funcao para visualizar?
head(mtcars)

# Colunas/variaveis deste dataset:
# mpg = milhas/galao 
# cyl = numero de cilindros
# disp =  deslocamento 
# hp = numero de cavalos
# drat = relacao do eixo traseiro
# peso = peso em libras
# qsec = 1/4 milha tempo
# vs = motor (0=V, 1=reto)
# am = Transmissão (0=automático, 1=manual)
# gear = numero de marchas a frente
# carb = numero de carburadores

# Grafico ScatterPlot do exercicio

# A orientacao dos pontos segue um formato de correlacao negativa

# Outro aspecto que pode ser mapeado nesse grafico eh a cor dos pontos
# Inserir colour = cyl na funcao
# A legenda eh inserida no grafico automaticamente
ggplot(mtcars, aes(x = disp, y = mpg, colour = cyl)) + geom_point()

# Tambem podemos mapear o tamanho dos pontos a uma variavel de interesse
# Inserir size =  wt (que eh o peso em libras)
ggplot(mtcars, aes(x = disp, y = mpg, colour = cyl, size = wt)) + geom_point()

# Para histogramas
ggplot(mtcars, aes(x = hp), binwidth = 40) + geom_histogram()
# hp = numero de cavalos
# bindwidth = largura

# Facets sao varios graficos do mesmo tipo na mesma area de plotagem
ggplot(mtcars, aes(x = mpg, y = disp, colour = as.factor(cyl))) + 
  geom_point() + 
  facet_grid(am~.)  
# am = 0 automatico e 1 manual (relacionando am ~.com todas as outras)
# na horizontal

ggplot(mtcars, aes(x = mpg, y = disp, colour = as.factor(cyl))) +
  geom_point() + 
  facet_grid(.~am)
# na vertical mudando o am de posicao

# Vamos gerar um BarPlot com os dados abaixo, criando este dataframe
data = data.frame(grupo = c("A ","B ","C ","D ") , 
                  valor = c(33,62,56,67) , 
                  num_obs = c(100,500,459,342))

# Trabalhar essa massa de dados
data$right = cumsum(data$num_obs)     # soma acumulada em nova coluna
data$left = data$right - data$num_obs # diferenca da soma acumulada pelo no. observacoes

# Vamos visualizar este dataframe. Qual o comando? Mostrar as variaveis desse dataframe.


ggplot(data, aes(ymin = 0)) + 
  geom_rect(aes(xmin = left, xmax = right,                      # para criar barras
                ymax = valor, colour = grupo, fill = grupo)) +  # com preenchimento em uma cor
  xlab("Numero de observacoes") + ylab("Valor")   # para cada grupo

# O geom_bar() tambem faz grafico de barras


# Grafico de densidade com geom_density
ggplot(data = tips, aes(x = tip, group = total_bill, fill = total_bill)) + 
  geom_density(adjust = 1.5)

ggplot(data = tips, aes(x = tip, group = total_bill, fill = total_bill)) + 
  geom_density(adjust = 1.5, position = "fill")
# ajustar alguns parametros para dar a aparencia necessaria

# LATTICE
# Pacote que permite trabalhar com analise multivariada
# Nao tem a elegancia do ggplot2 mas eh mais complexo do que o pacote basico de plotagem
# Eh considerado um pacote intermediario

# O conceito do Lattice eh agrupar os dados e criar visualizacoes
# de forma que fique mais facil a busca de padroes de comportamento

# Vamos instalar e carregar o pacote lattice
 

# Excelente pacote, muito util em analise de dados; se voce tiver 
# que comparar diversas variaveis de maneira simultanea, com o lattice
# eh melhor e mais facil do que usar o ggplot ou o pacote basico

# ScatterPlot com Lattice utilizando o dataset iris
# Vamos visualizar o dataset iris
 
# Dataset de plantas
# Species= setosa, versicolor, virginica
# sepal length = comprimento da sepala
# petal length = comprimento da petala

xyplot(data = iris, groups = Species, Sepal.Length ~ Petal.Length)
# colocou as 2 variaveis com 3 especies diferentes 
# temos varios dados em um unico grafico


# BarPlots com lattice utilizando o dataset Titanic
# Vamos visualizar o dataset titanic
 
# Dataset de sobreviventes do Titanic
# classe, sexo, faixa etaria, sobrevivente ou nao e frequencia

barchart(Class ~ Freq | Sex + Age, data = as.data.frame(Titanic),
         groups = Survived, stack = T, layout = c(4, 1),
         auto.key = list(title = "Dados Titanic", columns = 2))
# Para criar um barplot que coloca varias informacoes em apenas uma area de plotagem
# isto eh util para detectar os padroes: crianca x adulto, masculino x feminino 
# e a frequencia de sobreviventes
# O simbolo de pipe, | , eh usado de um lado, classe e frequencia,
# e de outro lado, faixa etaria e sexo. Eu quero unir todas estas 
# variaveis em uma unica area de plotagem. Usamos o pipe para isso

# O agrupamento eh por Survived, stack para colocar graficos juntos ou nao (testar F)
# e o layout para estabelecer como vai agrupar as caixas, titulo e quantas colunas


# Histogramas com lattice utilizando o dataset iris

histogram(~Sepal.Length | Species, xlab = "",
          data = iris, layout=c(3,1), type = "density",
          main = "Histograma Lattice", sub = "Iris Dataset, Sepal Length")
# Criamos 3 histogramas e podemos comparar as variaveis todas em uma unica area


# Criar um ViolinPlot = grafico de violino bastante usado em estatistica
# que nos mostra melhor como os dados estao distribuidos

bwplot(Species~Sepal.Length, data = iris,
       panel = panel.violin)
