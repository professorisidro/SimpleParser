# Simple Parser

Pequeno exemplo de um parser usando ANTLR. Nossa gramática permite:
- declarar variáveis de 2 tipos (NUMBER ou TEXT)
- expressões aritméticas com 4 operadores + - * /
- não tratamos precedência (ainda)


## como usar

- você precisa baixa o Antlr no site oficial (https://www.antlr.org/download/antlr-4.13.2-complete.jar)
- você deve referenciar este JAR como biblioteca do seu projeto
- para gerar os arquivos JAVA a partir do arquivo G4, o comando é este:
``` java -cp antlr-4.13.2-complete.jar org.antlr.v4.Tool [sua gramatica] -o [pasta onde voce quer gerar os arquivos] -package [nome do pacote java que ira no cabecalho]```