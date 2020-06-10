
# Este Estudo Dirigido esta disponivel tambem no Portal Academico. 

# Caros(as) Alunos(as), SIGAM O ROTEIRO, sequencialmente!

# Primeiramente, sete o seu diretorio de trabalho, onde voce colocou 
# este Script e os datasets que serao utilizados neste estudo:
# arquivos despesas.csv e despesas-teste.csv

# Estudo dirigido: Machine Learning (Regressao) - Despesas hospitalares

# Vamos contruir um modelo de machine learning para um problema de regressao.
# Iremos desenvolver um miniprojeto realizando passo a passo esse trabalho:
  # 1) definir o problema de negocio
  # 2) coletar e analisar os dados
  # 3) construir e treinar o modelo
  # 4) avaliar e interpretar o modelo
  # 5) realizar otimizacao do modelo


# Etapa 1) Problema de negocio: Previsao de despesas hospitalares (imagine
# uma clinica medica, uma companhia que vende plano de saude ou uma empresa que 
# forneca plano de saude para os colaboradores e que gostaria de fazer uma previsao 
# de despesas hospitalares. Ou seja, qual o custo envolvido com despesas com medicos,
# clinicas e exames.

# Para esta analise, vamos usar um conjunto de dados simulando despesas medicas
# hipoteticas para um conjunto de pacientes espalhados por 4 regioes do Brasil.
# Esse dataset possui 1.338 observacoes e 7 variaveis.

# Para criar um modelo preditivo, precisamos de dados historicos. Sem dados
# historicos, nao tem como alimentar o modelo. Precisamos ensinar o modelo
# o que ja aconteceu no passado para que ele possa encontrar a formulacao
# matematica que representa a relacao entre as variaveis e depois ser capaz
# de fazer previsoes. 

# Para resolver esse problema de negocio, precisamos de dados historicos.
# Isso vale para qualquer estudo. Machine learning nao eh magica. Eh matematica,
# estatistica, programacao, computacao. Sem dados historicos nao eh possivel
# criar um modelo preditivo, e, especificamente para este problema.
# Existem outras tecnicas que podem ser usadas como inferencia bayesiana. Mas eh
# outro universo, uma outra situacao. 
# Na grande maioria dos casos, precisamos de dados historicos para treinar um 
# modelo. 

# Este eh o tipo de problema de aprendizagem supervisionada. Vamos apresentar os
# dados de entrada e os dados de saida. O modelo vai aprender a relacao matematica
# e quando apresentarmos novos dados de entrada, ele sera capaz de prever as saidas.


# Etapa 2) Vamos coletar os dados, explorar e preparar os dados:
despesas <- read.csv("despesas.csv")
View(despesas) # verificar variaveis

# Vamos visualizar as variaveis:
str(despesas)  # verificar os tipos que o interpretador criou para elas

# Medias de tendencia central da variavel gastos, que eh o que queremos prever.
# idade, sexo, bmi, filhos, fumante, regiao sao variaveis preditoras,
# variaveis independentes. A variavel gastos eh a variavel alvo, target.
# Ela eh a variavel dependente. O valor do gasto depende das outras variaveis.
summary(despesas$gastos) # ver medidas....

# Pela diferenca da mediana e da media, nao temos uma distribuicao normal.

# Vamos confirmar isso, construindo um histograma da variavel gastos:
hist(despesas$gastos, main = 'Histograma', xlab = 'Gastos')

# Temos uma grande ocorrencia de gastos medicos com valores ate 15.000 e 
# temos pouquissimos casos de gastos acima de 50.000 reais.

# Vamos agora criar uma tabela de contingencia das regioes que vai nos
# dar a frequencia dos valores das observacoes com uma linha de codigo:
table(despesas$regiao)

# Vamos agora calcular o coeficiente de correlacao das variaveis numericas
# (ver no str, quais sao), para explorar o relacionamento entre elas.
# funcao cor e extrair com a funcao c, as 4 variaveis do dataset:
cor(despesas[c("idade", "bmi", "filhos", "gastos")])

# Esse coeficiente (indice) eh um numero que vai de -1 a +1. 
# O zero indica que nao ha correlacao. +1, forte relacao positiva.
# -1, forte correlacao negativa. Ver diagonal com numeros 1's.
# A diagonal apresenta a correlacaco de uma variavel com ela mesma.
# A variavel idade correlacionada com ela mesma, tem-se alta 
# correlacao. 

# Nenhuma das correlacoes na matriz eh considerada forte, mas existem algumas 
# associacoes interessantes. Por exemplo, a idade e o bmi (IMC) parecem ter uma
# correlacao positiva fraca, o que significa que com o aumento da idade, a massa 
# corporal tende a aumentar. Ha tambem uma correlacao positiva moderada entre a 
# idade e os gastos, alem do numero de filhos e os gastos. Estas associacoes implicam 
# que, a medida que idade, massa corporal e no.de filhos aumentam, o custo esperado sobe. 

# Vamos visualizar o relacionamento entre as variaveis com Scatterplot na mesma
# area de plotagem, usando a funcao pairs que cria o grafico.
# Este grafico fornece mais informacoes sobre o relacionamento entre as variaveis.
# Vamos usar uma matriz de Scatterplots
install.packages("psych")
library(psych)

pairs.panels(despesas[c("idade", "bmi", "filhos", "gastos")])

# ESta matriz mostra os indices de correlacao, a distribuicao da variavel, a media.
# Perceba que nao existe um claro relacionamento entre as variaveis, veja os indices...


# Etapa 3) Agora vamos construir e treinar o modelo de machine learning
# Sera que precisamos usar todas as variaveis no meu modelo?
# Mesmo que as correlacoes sejam fracas ou altas, eu posso criar
# quantas versoes para o meu modelo, que eu quiser: uma com todas as
# variaveis, uma com apenas 2 variaveis, etc.

# A construcao do modelo preditivo eh simples, a parte complexa eh compreender 
# os dados, voce compreender como usar os dados para criar o modelo.
?lm
# funcao linear model para construcao de um modelo linear (criar modelo de regressao)
modelo <- lm(gastos ~ idade + filhos + bmi + sexo + fumante + regiao, data = despesas)

# A sintaxe da funcao lm eh a variavel alvo a esquerda do til, o que quero prever;
# do lado direito do til estao as variaveis preditoras; se uso mais de uma, coloco +.
# Nao eh para somar, eh para indicar para a funcao que estou usando mais variaveis
# Til (~) representa uma formula para a variavel de saida, gastos, usando as demais
# como entrada. O data =.... indica o dataset a ser usado na funcao.

# Para simplificar a sintase acima e eh identica a sintaxe anterior; apenas
# substitui as variaveis de entrada (preditoras) por um ponto (.)
# Mostrar regressao linear simples ou mais.... idade + bmi + ...
# O exemplo abaixo eh de regressao linear multipla: com diversas variaveis
# preditoras (2 ou +).

modelo <- lm(gastos ~ ., data = despesas)
# O modelo foi recriado identicamente.

# Vamos imprimir o modelo (seus coeficientes):
modelo

# Este eh o modelo de machine learning. Ele ja foi construido e treinado.
# Foi rapido porque o nosso dataset eh pequeno. O que aconteceu quando a
# funcao lm foi executada? Dentro desta funcao lm existe um codigo em R
# com todo o procedimento para construir o modelo de regressao.
# Voce ate poderia desenvolver um codigo completo a partir do zero. 
# Mas se existem os frameworks, os codigos ja foram desenvolvidos.
# lm eh um resultado de um trabalho de varios voluntarios de data science.

# Depois de criar e treinar o modelo, precisamos fazer as previsoes.
# Vamos prever despesas medicas com o modelo contruido e treinado.
# Usa-se a funcao lm para treinar o modelo.
# Usa-se a funcao predict para fazer as previsoes.
?predict

# Aqui verificamos os gastos previstos pelo modelo que devem ser iguais 
# aos dados de treino.
# Vamos atribuir ao objeto previsao1, as previsoes dos dados de treino.
previsao1 <- predict(modelo)
View(previsao1)

# 1338 linhas de previsao que o nosso modelo fez. Em despesas/gastos temos os dados reais.
# A diferenca entre os 2 eh o erro do modelo. E o nosso trabalho eh minimizar este erro
# o tanto quanto possivel. Quando a taxa de erro for a menor possivel, ai estamos prontos
# para fazer as previsoes.

# Nos nao podemos usar os dados de treino para testar o modelo. Porque estariamos
# apresentando dados que o modelo ja viu. Vamos prever os gastos com o dataset de teste,
# com dados que o modelo ainda nao viu.
despesasteste <- read.csv("despesas-teste.csv")
View(despesasteste)

# Aqui neste dataset esta faltando a coluna gastos e temos 20 linhas. Ver dataset original.
# No original temos as variaveis preditoras e a variavel de saida que usamos para treinar.
# Agora que temos o modelo treinado, nao precisamos apresentar os dados de saida. Isso
# eh o que eu quero que o modelo me entrega. Apresentamos novos dados de entrada e o 
# modelo tera que fazer as previsoes. Por exemplo, uma mulher de 52 anos, imc 26.6, sem
# filhos, não fumante, da regiao nordeste; qual seria a sua estimativa de gasto?

previsao2 <- predict(modelo, despesasteste)
View(previsao2)
# Aqui temos as previsoes com os dados de teste.


# Etapa 4) Vamos avaliar e interpretar a performance/resultado do modelo
# Vamos ver os detalhes (resumo) sobre o modelo:
summary(modelo)
#

# **********************************************
# *** Estas informacoes abaixo farao de voce ***
# *** um bom conhecedor de Machine Learning  ***
# **********************************************

# Eu coloquei abaixo em comentarios, uma descricao completa do resumo do modelo.
# Faca uma leitura detalhada do texto abaixo para entender melhor o modelo
# de regressao. Ver resumo do modelo!

# O sumario coloca no cabecalho exatamente o modelo que foi criado... lm(...)
# A linha de codigo que usamos para construir o modelo.
# Ele apresenta tambem os residuos, os coeficientes, algumas variaveis e 
# algumas colunas, sinais de asterisco (importantissimos), alguns codigos
# de significancia e entao alguns resumos com outros coeficientes.

# Quando criamos o modelo de regressao, uma das primeiras coisas que temos
# que observar eh o Multiple R-squared:  0.7509 (coeficiente de determinacao),
# que vai de zero a 1. Quanto maior, melhor.. Assim, 0.75 eh bastante razoavel.
# Precisamos fazer alguma coisa depois para melhor este coeficiente.

# Equacao de regressao
# y = a + bx (simples)  
# y eh a nossa previsao (coluna gastos), a eh um dos coeficientes (intercepto)
# b eh outro coeficiente (slope) que eh a inclinacao da reta de regressao e x 
# representa as variaveis de entrada, as preditoras (ver despesasteste)

# y = a + b0x0 + b1x1...(multipla) com varios valores de b multiplicados por x's
# No nosso modelo exemplo fizemos a regressao multipla.

# Residuos
# Diferenca entre os valores observados de uma variavel e seus valores previstos.
# Ver em dataset despesas, a coluna gastos (dados observados, históricos).
# Ver em previsao1 (resultado do treinamento do modelo). A diferenca entre esses
# 2 eh o que chamamos de residuo.

# Coeficiente - Intercept - a (alfa) eh o ponto onde a reta de regressao corta y

# Coeficientes - valores de b (beta) - iguais aos nomes das variaveis.
# Ao inves de escrever slope1 (b0), slope2 (b1)... usa-se o nome da variavel.
# Temos diversos coeficientes b porque temos varias variaveis de entrada.
# Cada coeficiente para cada variavel.
# Se fosse apenas uma variavel preditora, seria apenas um coeficiente b (simples).

# Erro Padrao
# Medida de variabilidade na estimativa do coeficiente a (alfa). O ideal eh que 
# este valor seja menor que o valor do coeficiente, mas nem sempre isso acontece.
# Veja!

# Asteriscos (estrelas)
# Os asteriscos representam os niveis de significancia de acordo com o p-value.
# Quanto mais estrelas (asteriscos), maior a significancia.
# Atencao --> Muitos astericos indicam que ha relacionamento entre as variaveis.

# Existem outros itens como Valor t, Pr... Mas estou descrevendo apenas alguns.

# Codigos de significancia
# Sao aquelas legendas proximas das variaveis:

# Espaco em branco - ruim 
# (por exemplo, sexomulher, nao representativa, nao tem influencia na construcao do modelo)
# Eh importante colocar as variaveis que sao relevantes para o seu modelo....
# Pode-se criar uma nova versao do modelo removendo as variaveis irrelevantes.

# Pontos - razoavel
# Asteriscos - bom

# Muitos asteriscos - muito bom
# (intercepto, idade, bmi, filhos e se eh fumante são de relevancia para o modelo)

# R-squared (coeficiente de determinacao - R^2)
# Ajuda a avaliar o nivel de precisao do nosso modelo. 
# Quanto maior, melhor, sendo 1 o valor ideal. Ver o 0.75 do modelo.
# E podemos otimizar o modelo... (incluir, remover variaveis)...
# tentar chegar o R-squared mais proximo de 1.


# Etapa 5) Vamos otimizar a performance do modelo

# Ate aqui fizemos a primeira versao do modelo, mas agora precisamos otimizar
# o nosso modelo. Nos nao podemos nos contentar com o 0.75 no R-squared. Se 
# podemos chegar a 1, que eh o ideal, precisamos otimiza-lo.

# Vamos adicionar uma variavel com o dobro do valor da idade, porque a 
# a variavel idade tem uma significancia forte para o modelo (***). Adicionar
# o dobro de um valor significante tem um impacto positivo na criacao do modelo.
# Vamos fazer este experimento.... Se nao surtir efeito positivo, eu removo
# a variavel e crio outra, ou tiro uma das que ja existem.
despesas$idade2 <- despesas$idade ^ 2

# Vamos adicionar também uma variavel com um indicador para massa corporea >= 30
despesas$bmi30 <- ifelse(despesas$bmi >= 30, 1, 0)

View(despesas)
# Temos agora mais 2 variaveis: idade2 e bmi30

# Vamos criar a versao 2 do nosso modelo (mais otimizado)
modelo_v2 <- lm(gastos ~ idade + idade2 + filhos + bmi + sexo +
                  bmi30 * fumante + regiao, data = despesas)
# Funcao lm, Variavel target gastos e as variaveis preditoras usadas, mais 
# idade2 e mais uma alteracao na variavel fumante .

# Criar o modelo preditivo em si eh a parte mais facil (uma linha de codigo), 
# o problema/dificil eh saber o que colocar e/ou retirar dentro desta funcao lm.
 
summary(modelo_v2)

# Verifique mais variaveis. O R-square esta 0.87, comparado ao que tinhamos 
# antes de 0.75, isso mostra que conseguimos uma melhora. O nivel de precisao
# do modelo foi maior. O modelo errou menos. Melhor que a versao anterior.

# Vamos fazer testes com esse novo modelo. Carregar novas variaveis (idade2 e
# bmi30) para o arquivo de testes.
despesasteste$idade2 <- despesasteste$idade ^2
despesasteste$bmi30 <- ifelse(despesasteste$bmi >= 30, 1, 0)
View(despesasteste)
# Para comprovar que nao temos a variavel gastos

# Vamos fazer as previsoes e visualizar os resultados
previsao <- predict(modelo_v2, despesasteste)
View(previsao)

# Poderiamos continuar criando outras versoes do modelo. Criar mais variaveis.
# Retirar outras... Fazer algum pre-processamento (normalizacao)...etc....

# Eh preciso definir um nivel de precisao com o R-square. Quando chegar no
# nivel desejado, faz-se o necessario com o resultado das previsoes. Por
# exemplo, entregarmos o arquivo.csv das previsoes para um tomador de decisao. 
# Poderiamos levar para uma ferramenta de dashboard, criar graficos, apresentar
# relatorios, etc.

