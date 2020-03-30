# Roteiro do Estudo Dirigido II de Topicos Avancados I (EC020): Graficos em Linguagem R

# Este Estudo Dirigido tambem esta disponivel no Portal Academico. 

# Caros(as) Alunos(as), SIGAM O ROTEIRO, sequencialmente!

# Primeiramente, sete o seu diretorio de trabalho, coloque o seu Script nele.
  
# Os exercicios (de 1 a 9) no final desse Estudo deverao ser desenvolvidos em dupla
# ou individual, nesse Script mesmo, mas renomeado com (nomealuno1_nomealuno2.R) e
# enviado por e-mail para mim, rosannas@inatel.br, ate o dia 6/abril/20, 
# segunda-feira, 10h. Este exercicio esta valendo pontos.

# Os graficos fazem parte de todo o processo de Data Science, desde a analise 
# exploratoria (eh mais facil analisar um grafico do que uma tabela com numeros)
# ate a apresentacao do resultado final

# Existem diversas ferramentas de visualizacao de dados (que eh representar os dados de
# forma grafica) para construcao de graficos:
# Linguagens R e Python, Tableau, Power BI, Qlik Sense .... e outras

# A Linguagem R ja vem com o pacote basico de plotagem:
# graphics: contem as funcoes graficas basicas, incluindo plot, hist, barplot e piechart
# grDevices - contem as implementacoes de dispositivos graficos como X11, pdf, 
#             PostScript, png, etc.
# Com este pacote basico conseguimos construir graficos basicos de:  Colunas / Barras 
# Linha / Dispersao / Area / Bolhas / Superficie / Cone e Pizza
#
# Para construir graficos mais completos e profissionais, podemos utilizar os pacotes
# ggplot2, lattice e outros pacotes R.

# funcao Demo = demonstra como utilizar as funcoes de um determinado pacote,
# ela mostra todos os passos necessarios para se construir um plot
demo("graphics")

# aperte o <return> 12 vezes para voce ver 11 graficos
# e observe as sintaxes para se criar todos esses tipos de 11 graficos
# se aparecer a mensagem..... Error in plot.new() : figure margins too large
# eh porque a sua area para desenhar o grafico esta pequena. Amplie o painel
# inferior direito para melhor esta visualizacao (painel de Files / Plots / .....)

# Para se construir um plot generico, unir informacoes de 2 variaveis
# em um unico grafico, usa-se a funcao plot (na duvida de seus parametros
# consulte o help ?plot). Esta funcao plot pertence ao pacote graphics
?plot

# Plot basico de 2 vetores, grafico mais simples que se pode criar
# apenas para verificar como 2 variaveis estao relacionadas
altura <- c(155, 167, 176, 153, 170, 159, 164)
peso <- c(51, 63, 84, 77, 55, 65, 66)

plot(altura, peso)

# Vamos plotar o dataframe lynx que apresenta o número de peles de linces 
# cacados no Canada de 1821 a 1934 com 114 registros
View(lynx)

# Vamos passar o dataframe inteiro como parametro do plot
# O dataframe tem que estar formatado para ser plotado
plot(lynx)

# Posso ir montando as camadas desse grafico colocando alguns parametros
# Colocar Labels dos eixos y e x
plot(lynx, ylab = "Observacoes", xlab = "Anos")

# Colocar titulo, cor do grafico e alterar tamanho e cor do titulo
plot(lynx, main = "DataFrame lynx", col = 'red', col.main = 52, cex.main = 1.5,
     ylab = "Observações", xlab = "Anos")

# Se você quiser ver os graficos gerados anteriormente, clique na setinha para
# a esquerda (em Plots no painel abaixo) para ver os anteriores gerados

plot(lynx)
# se quiser alterar alguns padroes, altera o type
plot(lynx, type="p", main="Type pontos") # grafico com pontos
plot(lynx, type="l", main="Type linha")  # grafico com linha (default)
plot(lynx, type="b", main="Type linha com alguns pontos") # com linha e pontos
plot(lynx, type="h", main="Type linhas verticais")# com linhas verticais
plot(lynx, type="s", main="Type preenchimento")   # com preenchimento

# Para ver a distribuicao de frequencia de um conjunto de dados, onde cada barra
# demonstra a quantidade de ocorrencias desta variavel. Para se ver como os
# dados estao organizados, usa-se a funcao hist
?hist
hist(lynx)

# Quero mudar este histograma, dividindo em mais classes, mais colunas
# para distribuir melhor a informacao, ter uma dist. mais espalhada
# um break com valor unico, usando o parametro breaks = 12
hist(lynx, breaks = 12, main = "Histograma do numero de peles")

# Posso tambem usar um vetor de tamanho para os breaks
hist(lynx, breaks = c(0,1000,3000,5000,7000), main = "Hist. do no. de peles")

# Posso mostrar o total de frequencias para cada uma das classes no histograma
# usando o parametro labels = True e definir os limites do eixo y, para delimitar
# um tamanho para as caixinhas (classes)
# 
hist(lynx, labels = T, ylim = c(0,50), breaks = 12, main = "Hist. do no. de peles")

# Grafico de barras, que nao eh o histograma
?barplot

# Preparando os dados - numero de casamentos civis no cartorio de Santa 
# Rita durante os 4 trimestres do ano de 2019
dados <- matrix(c(15,6,37,12,58,6,16,3,4,18,27,10), nrow = 3, byrow = T)
dados

# Nomeando linhas e colunas desta matriz
colnames(dados) <- c("1o.Tri","2o.Tri","3o.Tri","4o.Tri")
rownames(dados) <- c("Jovem","Adulto","Idoso")
dados

# Construindo um Barplot
# Grafico de barras empilhado (Stacked Bar)
# onde cada barra contem mais de uma informacao, varias faixas em cada uma das barras
# e uma barra por trimestre
barplot(dados)

# Grafico de barras utilizando uma barra para cada faixa de idade
# e um grupo de 3 barras para cada trimestre 
barplot(dados, beside = T)

# Vamos dar uma customizada neste grafico, a cor muda bem o aspecto 
# a combinacao de cores eh determinante para o sucesso do grafico
# Veja como a cor deu mais vida ao grafico!
barplot(dados, col = c("steelblue1", "tan3", "seagreen3"), beside = T,
        ylab = "no. de casamentos")

# Vamos criar uma legenda no canto superior direito para o grafico anterior
# colocando as cores para os titulos das faixas etarias 

# Para escolher cores, temos uma infinidade de opcoes. Veja!
colors()

# Legenda à direita "right" com pch = 15 para simbolo de quadradinho, 
# vetor de cores usado nas barras do grafico e os labels com o vetor de legendas

legend("right", pch = 15, col = c("steelblue1", "tan3", "seagreen3"), 
       legend = c("Jovem","Adulto","Idoso"))

# Para se construir um grafico de pizza usa-se a função pie
?pie

# Criando as fatias da pizza
fatias = c(40, 20, 40)

# Nomeando os labels para cada fatia
paises = c("Brasil", "Argentina", "Chile")

# Unindo paises e fatias
paises = paste(paises, fatias)

# Incluindo mais detalhes no label, colocar o % apos o numero da fatia sem espaco
paises = paste(paises, "%", sep = "")
paises

# Construindo o grafico de pizza
pie(fatias, labels = paises,
    col = c("darksalmon", "gainsboro", "lemonchiffon4"), 
    main ="Distribuicao de Vendas")

# Para fazer o grafico de pizza em 3D eh preciso instalar e carregar o pacote plotrix
install.packages("plotrix")
library(plotrix)

pie3D(fatias, labels = paises, explode = 0.05,  
      # explode eh o quanto as fatias irao ficar separadas
      # separacao entre elas, mais proximas ou nao
      col = c("steelblue1", "tomato2", "tan3"), 
      main = "Distribuicao de Vendas")

pie3D(fatias, labels = paises, explode = 0.55,  
      # aumentando o explode para 0.55
      col = c("steelblue1", "tomato2", "tan3"), 
      main = "Distribuicao de Vendas")

 
# Especificando os parametros para as funcoes plot, hist, barplot e piechart

# col - cor do plot (nome da cor entre aspas ou codigo da cor)
# lty - tipo de linha
# lwd - largura de linha
# type - ponto, linha, ponto e linha, linha vertical...
# pch - simbolo no plot, tipo de ponto (de 0 a 25)
# xlab - label do eixo x
# ylab - label do eixo y
# las - como os labels dos eixos sao orientados (vertical / horizontal)
# bg - background color (cor de fundo)


# EXERCICIOS
# 1) Carregue o pacote datasets que disponibiliza varios datasets
# Coloque aqui a funcao que carrega o pacote datasets
library(datasets)

# 2) Coloque aqui a funcao que visualiza os dados em forma de planilha do
# dataset airquality que eh referente a medicoes de qualidade do ar em 
# Nova Iorque realizadas entre maio e setembro de 1973
View(airquality)

# 3) Quantas linhas e colunas temos neste dataset airquality?
nrow(airquality)
ncol(airquality)

# 4) Faça um gráfico "elegante/customizado" sobre este dataset, plotando vento x 
# temperatura, use as colunas vento e temperatura nos eixos x e y respectivamente
# e apresente neste gráfico pelo menos 5 parametros descritos acima (col, xlab...)
plot(airquality$Wind, airquality$Temp, xlab = "Wind", ylab = "Temperature",
     main = "Wind x Temperature", col = "blue", type = "p")

# 5) Elimine os valores NA existentes neste dataset, salvando-o com outo nome.
new_airquality = na.omit(airquality)

# 6) Quantas linhas e colunas temos agora neste novo dataset?
nrow(new_airquality)
ncol(new_airquality)

# 7) Faça um histograma, "também elegante", a respeito da coluna Solar.R, com 
# no mínimo 5 parametros descritos acima (col, main....)
hist(airquality$Solar.R,  ylim = c(0,50), breaks = 12, main = "Hist. Solar.R", 
     ylab = "Freq.", xlab = "Value")

# 8) Prepare uma matriz (4x3) que represente algum conjunto de dados (livre escolha).
# Nomeie as linhas e colunas desta matriz de acordo com os dados criados. 
# Crie um barplot que represente esses dados em stacked bar, com representacao
# de cores, legendas e label no eixo y.
grades <- matrix(c(90, 87, 66, 98, 54, 58, 68, 100, 30, 47, 71, 22), nrow = 4, byrow = T)

colnames(grades) <- c("EC020", "EC019", "EC206")
rownames(grades) <- c("Leonardo", "Flavio", "Bruno", "Heitor")

barplot(grades, col = c("red", "green", "black", "yellow"), xlab = "Disciplines", ylab = "Grades")

# 9) Faca um grafico de pizza para mostraa a distribuicao de especies do dataframe
# iris. Temos 3 especies: setosa, versicilor e virginica. 
# A especie esta na coluna $Species do dataframe
# Dica para saber a quantidade de cada especie, gere um factor desta coluna e
# faca o summary dele. E para os labels, faça um vetor de nomes.
pie(summary(factor(iris$Species)))
