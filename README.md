📊 Analize Create Data PostgreSQL

Este projeto é uma aplicação Python que analisa o esquema de um banco de dados PostgreSQL e gera um dicionário de dados em formatos JSON e CSV. Ele é útil para documentar e entender a estrutura de tabelas, colunas, tipos de dados, chaves primárias e estrangeiras, além de outras informações relevantes do banco de dados.

---

🚀 Funcionalidades

🔌 Conexão com um banco de dados PostgreSQL.

📋 Extração automática do esquema do banco de dados, incluindo:

- Tabelas
- Colunas
- Tipos de dados
- Nulabilidade
- Chaves primárias
- Chaves estrangeiras

---

🧾 Geração de um dicionário de dados em dois formatos:

JSON: output/data_dictionary.json

CSV: output/data_dictionary.csv

---

📁 Estrutura do Projeto
.
├── ai/
│   └── describer.py             # (Em desenvolvimento)
├── core/
│   ├── dictionary_builder.py    # Constrói o dicionário de dados a partir do esquema extraído.
│   ├── exporter.py              # Exporta o dicionário de dados para JSON e CSV.
│   └── extractor.py             # Extrai o esquema do banco de dados.
├── db/
│   └── postgres.py              # Gerencia a conexão com o banco de dados PostgreSQL.
├── output/
│   ├── data_dictionary.csv      # Dicionário de dados gerado em formato CSV.
│   └── data_dictionary.json     # Dicionário de dados gerado em formato JSON.
├── utils/
│   └── config.py                # Gerencia as configurações do banco de dados.
├── db_base.sql                  # Script SQL para criar e popular o banco de dados.
├── docker-compose.yaml          # Configuração do Docker Compose para o banco de dados e a aplicação.
├── Dockerfile                   # Dockerfile para criar a imagem da aplicação.
├── main.py                      # Arquivo principal que orquestra a execução do projeto.
├── requirements.txt             # Dependências do projeto.
└── .env                         # Configurações de ambiente.

---

⚙️ Pré-requisitos

- Python 3.11 ou superior
- Docker e Docker Compose
- PostgreSQL

---

🛠️ Configuração

1. Clone o repositório:
> git clone <url-do-repositorio>
> cd analize-create-data-postgresql

2.Configure o arquivo .env com as credenciais do banco de dados:

``` .env
DB_HOST=postgres-db
DB_PORT=5432
DB_NAME=db_base
DB_USER=user_access
DB_PASSWORD=password_access
``` 

3. Instale as dependências:

> pip install -r requirements.txt

4. (Opcional) Configure o banco de dados usando o Docker Compose:
> docker-compose up -d

---

▶️ Uso

Execute o script principal:

> python main.py

Após a execução, os arquivos data_dictionary.json e data_dictionary.csv serão gerados no diretório output/.

---

🗃️ Estrutura do Banco de Dados

O banco de dados é definido no arquivo db_base.sql e inclui tabelas como:

- usuarios
- produtos
- pedidos

Com relacionamentos bem definidos entre elas.

---

🧰 Tecnologias Utilizadas

- Python: Linguagem principal do projeto
- PostgreSQL: Banco de dados relacional
- Docker: Para facilitar a configuração e execução do ambiente
- psycopg2: Biblioteca para conexão com o PostgreSQL
- python-dotenv: Gerenciamento de variáveis de ambiente

---

🤝 Contribuição

Contribuições são bem-vindas!Sinta-se à vontade para abrir issues ou enviar pull requests.

---

📄 Licença

Este projeto está licenciado sob a licença MIT.

---
