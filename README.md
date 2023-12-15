# Biblivre CSV Importer

## Sobre a Aplicação
Esta aplicação foi criada com o objetivo de simplificar e agilizar o processo de adição de obras, exemplares e autoridades ao sistema Biblivre 5 a partir de arquivos CSV. O Biblivre é um sistema amplamente utilizado por bibliotecas, e a digitalização de acervos é um desafio comum. Esta ferramenta visa facilitar a transição de bibliotecas não digitalizadas para o formato digital, aproveitando dados fornecidos em planilhas.

## Funcionalidade
A aplicação permite a importação de dados de obras, exemplares e autoridades para o Biblivre 5, lendo informações diretamente de um arquivo CSV. Para cada linha do CSV será criada uma obra e um exemplar. O formato esperado do arquivo CSV deve ser como o seguinte:


## Tecnologia Utilizada
A aplicação é desenvolvida utilizando Ruby on Rails 7.

### Backup e Preparação

Antes de executar a importação, é recomendável fazer um backup completo do banco de dados do Biblivre. Além disso, pode ser benéfico criar uma biblioteca limpa no sistema Biblivre para garantir que a importação seja feita sem problemas.

## Como Usar

### 1. Clonar o Repositório

Clone o repositório da aplicação para o seu sistema local.

### 2. Configurar o Banco de Dados

Configure o arquivo `database.yml` com as credenciais do seu banco de dados Biblivre. Este arquivo se encontra no diretório `config` da aplicação.

Modifique o arquivo para refletir as configurações corretas do seu banco de dados, como no exemplo abaixo:

```yaml
# config/database.yml
default: &default
  adapter: postgresql
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  timeout: 5000
  host: localhost
  schema_search_path: single

development:
  <<: *default
  database: biblivre4

test:
  <<: *default
  database: biblivre4_test
```

### 3. Preparar o Arquivo CSV

Coloque o arquivo CSV a ser importado no diretório específico da aplicação. O arquivo deve ser nomeado como `exemplares.csv` e colocado dentro do diretório `app/services`.

Certifique-se de que o arquivo CSV esteja no formato correto para importação. Um exemplo de formato válido é:

```csv
NRO TOMBO,CHAMADA,AUTOR,TITULO,LOCAL,EST/PAIS,EDITORA,ANO,OBS,CONFERÊNCIA
6352,641B43A,CAROLINE BERGEROT,"COZINHA VEGETARIANA: ARROZ, RISOTOS",SAO PAULO,SP,CULTRIX,2014,,
```

### 4. Executar a Importação

Após configurar o banco de dados e preparar o arquivo CSV, execute a importação através do console do Rails. Siga os passos abaixo para realizar a importação:

1. Abra o terminal e navegue até o diretório da aplicação.
2. Inicie o console do Rails com o comando:

   ```bash
   rails c
   ```
3. Dentro do console do Rails, inicie o processo de importação executando:
    ```bash
   ImporterService.new.call
   ```

### 5. Verificar os Resultados

Após a execução do serviço de importação, é importante verificar os resultados. A aplicação gera dois arquivos CSV para facilitar este processo:

- `successes.csv`: Contém todos os registros que foram importados com sucesso para o sistema Biblivre.
- `failures.csv`: Lista os registros que falharam durante o processo de importação.

Esses arquivos podem ser encontrados no diretório `app/services`. Analise-os para garantir que a importação atendeu às expectativas e para resolver quaisquer problemas com os registros que não foram importados corretamente.

### 6. Reindexar as Bases de Dados no Biblivre

Após a importação dos dados, é recomendável reindexar as bases de dados bibliográfica e de autoridades no Biblivre. Isso garante que todos os novos registros sejam devidamente indexados e possam ser encontrados nas buscas dentro do sistema. Para fazer isso:

1. Acesse a interface administrativa do Biblivre.
2. Navegue até a aba Administração -> Manutenção.
3. Selecione as opções para reindexar as bases de dados e execute a operação.

Essa etapa final é crucial para a integração completa dos novos dados no sistema Biblivre.




## Suporte e Contato

Em caso de dúvidas, problemas ou sugestões, não hesite em entrar em contato comigo.

## Licença

Esta aplicação está sob a licença MIT, o que significa que você é livre para copiar, modificar e distribuir a aplicação como desejar, sem restrições.
