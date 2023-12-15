# Biblivre CSV Importer

## Sobre a Aplicação
Esta aplicação foi criada com o objetivo de simplificar e agilizar o processo de adição de obras, exemplares e autoridades ao sistema Biblivre 5 a partir de arquivos CSV. O Biblivre é um sistema amplamente utilizado por bibliotecas, e a digitalização de acervos é um desafio comum. Esta ferramenta visa facilitar a transição de bibliotecas não digitalizadas para o formato digital, aproveitando dados fornecidos em planilhas.

## Funcionalidade
A aplicação permite a importação de dados de obras, exemplares e autoridades para o Biblivre 5, lendo informações diretamente de um arquivo CSV. Para cada linha do CSV será criada uma obra e um exemplar. O formato esperado do arquivo CSV deve ser como o seguinte:

## Exemplo de Formato CSV
```csv
NRO TOMBO,CHAMADA,AUTOR,TITULO,LOCAL,EST/PAIS,EDITORA,ANO,OBS,CONFERÊNCIA
1,641B43A,CAROLINE BERGEROT,"COZINHA VEGETARIANA: ARROZ, RISOTOS",SAO PAULO,SP,CULTRIX,2014,,
2,1581M59C,WILSON MILERIS,O CLICK DO EXITO,SAO PAULO,SP,PRESTIGIO,2006,,
```

## Tecnologia Utilizada
A aplicação é desenvolvida utilizando Ruby on Rails 7, oferecendo robustez e facilidade de expansão e manutenção.

## Configuração

### Configuração do Banco de Dados

É necessário configurar o `database.yml` para se conectar ao banco de dados do Biblivre. Siga as instruções padrão do Rails para a configuração do banco de dados.

### Backup e Preparação

Antes de executar a importação, é recomendável fazer um backup completo do banco de dados do Biblivre. Além disso, pode ser benéfico criar uma biblioteca limpa no sistema Biblivre para garantir que a importação seja feita sem problemas.

## Como Usar

1. Clone o repositório da aplicação.
2. Configure o `database.yml` com as credenciais do seu banco de dados Biblivre.
3. Coloque o arquivo CSV no diretório especificado pela aplicação.
4. Execute a aplicação para iniciar a importação.

## Suporte e Contato

Em caso de dúvidas, problemas ou sugestões, não hesite em entrar em contato comigo.

## Licença

Esta aplicação está sob a licença MIT, o que significa que você é livre para copiar, modificar e distribuir a aplicação como desejar, sem restrições.
