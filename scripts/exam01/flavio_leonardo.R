#
# Atividade Avaliativa de EC020 (Tópicos Avançados 1)

# Consideracoes gerais desta avaliacao:

# a) Os itens desta avaliacao deverao ser desenvolvidos em dupla ou individual,
# nesse Script mesmo, mas renomeado com (nomealuno1_nomealuno2.R, 
# se for em dupla ou nome_aluno.R, se individual) e enviado por e-mail para mim, 
# rosannas@inatel.br, ate o dia 27/abril/20, 2a.-feira, 10h. 

# b) A interpretacao dos itens faz parte da avaliacao.
# c) Coloque abaixo das letras a)b)c)...dos itens, os comandos adequados para resolucao.
# d) Avaliacoes entregues fora do prazo serao desconsideradas.
# e) Esta avaliacao ira corresponder a nota da NP1 da disciplina

# Boa avaliacao!! Profa. Rosanna.

# VETORES
# Diversas funcoes matematicas e estatisticas podem ser facilmente aplicadas 
# a vetores numericos. Vimos algumas no decorrer do curso, mas para fazer
# este item, pesquise outras também!

# Item 1) vamos gerar um vetor (vetor01) que possui 1.000 observacoes 
# referentes as notas dos candidatos do concurso público para o cargo
# de dentista da Prefeitura de Sao Longuinho. Essas notas variam de 0 a 10.

vetor01<- round(10 * runif(1000), digits = 2)

# 1a) Coloque o vetor01 em ordem decrescente das notas e salve o resultado no 
# proprio vetor01 (sobrescrever). 

vetor01 <- sort(vetor01, decreasing = TRUE)

# 1b) Calcule a media e a mediana das notas.

mean(vetor01)
median(vetor01)

# 1c) Calcule o desvio padrao das notas.

sd(vetor01)

# 1d) Calcule quantos candidatos obtiveram notas >= 8,50.

sum(vetor01 > 8.5)

# 1e) Calcule o percentual de candidatos que obtiveram notas abaixo de 8,5.

(sum(vetor01 < 8.5) / length(vetor01)) * 100

# 1f) Selecione as 500 maiores notas do vetor01 e guarde o resultado no vetor02.

vetor02 <- vetor01[c(1:500)]

# GRAFICOS
# Para os itens de construir graficos (de 2 a 5): barra, dispersao,
# histograma, pizza, voce pode usar as funções do pacote basico de plotagem
# da Linguagem R ou usar as funções dos Pacotes ggplot2 e lattice vistosno curso.

# Item 2) a) Crie a matriz abaixo:

mat1 <- matrix(c(652,1537,598,242,36,46,38,21,218,327,106,67), nrow = 3, byrow = T)
mat1

# b) Nomeie as linhas e colunas desta matriz com os nomes da sua escolha.
# Gráfico vendas x Produtos

rownames(mat1) <- c("Janeiro", "Fevereiro", "Março")
colnames(mat1) <- c("Perfumes", "Brincos", "Anéis", "Esmaltes")

# c) Crie um barplot que represente os dados desta matriz em barras individuais, 
# com representacao de cores, legendas e labels nos 2 eixos.

barplot(mat1,
        main = "Vendas no mês de Janeiro",
        xlab = "Objeto",
        ylab = "Quantidade",
        names.arg = c("Perfume", "Brinco", "Anel", "Esmalte"),
        col = c("green", "blue", "yellow"))

legend("topleft", fill = c("green", "blue", "yellow"), legend = rownames(mat1))

# Item 3) Plote um gráfico de dispersao entre as variaveis Girth e Heigth, ambas
# do dataset trees (circunferência e altura de cerejeiras) do pacote datasets
# O grafico deve ter as seguintes caracteristicas:
# um titulo, labels nos eixos x e y, grafico de linha e pontos numa cor de sua
# escolha e escolha tambem um codigo para o simbolo dos pontos.

install.packages("ggplot2")
library(ggplot2)

ggplot(trees, aes(x = Girth, y = Height)) +
  labs(title = "Girth x Height", x = "Girth Axis", y = "Height Axis") +
  geom_point(color = "darkblue", shape = 8) +
  geom_line(color = "darkgray")

# Item 4) Crie um histograma "profissional: com legenda, titulo, labels, cores, etc" 
# usando a variável Girth do mesmo dataset (trees) do Item anterior.

ggplot(trees, aes(Girth)) +
  labs(title = "Girth Histogram", x = "Girth", y = "Frequency") +
  geom_histogram(color = "purple", bins = 250)

# Item 5) Crie um grafico de pizza em 3D para definir as quantidades (fatias)
# de alunos em cada curso de Engenharia do Inatel e crie os labels para
# informar as etiquetas do grafico (percentual).
# Hoje o Inatel tem aproximadamente 1200 alunos e 7 Cursos de Engenharia.
#
# a) Crie um vetor com a quantidade de alunos em cada Curso.

install.packages("plotrix")
library(plotrix)

quantidade <- c(133, 103, 186, 202, 142, 132, 302)

# b) Crie um vetor com os nomes desses 7 Cursos.

cursos <- c("Eng. Automação", "Eng. Biomédica", "Eng. Computação", "Eng. Software", "Eng. Produção", "Eng. Elétrica", "Eng. Teleco")

# c) Crie o grafico de pizza 3D para mostrar o percentual de cada curso sobre o total.
#    Para calcular este percentual, faça um loop!

pct <- c(0, 0, 0, 0, 0, 0, 0)
for (i in 1:7) {
  pct[i] <- round((quantidade[i] / 1200) * 100)
}

label <- paste(cursos, pct)

pie3D(quantidade, labels = label, explode = 0.1, main = "Percentual dos Cursos")
