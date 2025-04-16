# 🗺️ Projeto de Análise Geoespacial de Unidades de Saúde em São Paulo

Este projeto tem como objetivo mapear e analisar a distribuição de unidades de saúde pública na cidade de São Paulo. Utiliza bibliotecas de geolocalização em Python (como GeoPandas, Folium, KeplerGl, OSMNX) e armazena os dados geográficos em um banco de dados PostgreSQL com extensão PostGIS.

## 📦 Estrutura do Projeto

```
.
├── backup/
│   └── database_backup.sql            # Backup do banco de dados com os dados geoespaciais
├── notebooks/
│   └── analise_acessibilidade_sp_simples.ipynb # Notebook com a análise e visualizações
├── Dockerfile              # Imagem personalizada com bibliotecas geoespaciais
├── docker-compose.yaml     # Orquestração do Jupyter, PostgreSQL/PostGIS e PgAdmin
└── README.md               # Este arquivo
```

---

## 🚀 Como Executar o Projeto

### 1. 🔧 Pré-requisitos

Certifique-se de ter instalado:

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

---

### 2. 📥 Construir e iniciar os containers

Antes de tudo é necessário criar a imagem do Container Docker contendo a imagem do Jupyter com as dependências instaladas, a partir da Dockerfile. Isto pode ser feito a partir da execução do comando:

```bash
docker build -t t1-cic901 .
```

OBS: Caso queira alterar o nome da imagem `t1-cic901`, lembre de alterar `no docker-compose.yaml`


Execução do arquivo `docker-compose.yaml` - Abra o terminal na raiz do projeto e execute:

```bash
docker-compose up
```

Isso irá iniciar três serviços:

- **Jupyter Notebook**: Ambiente interativo para análise de dados.
- **PostGIS**: Banco de dados PostgreSQL com suporte a dados geoespaciais.
- **PgAdmin**: Interface web para gerenciar o banco de dados.

---

### 3. 💾 Restaurar o backup do banco

Com os containers rodando, execute os comandos abaixo para restaurar o backup SQL para o banco:

```bash
docker cp ./backup/database_backup.sql $(docker ps -qf "ancestor=postgis/postgis:17-3.5"):/
docker exec -i $(docker ps -qf "ancestor=postgis/postgis:17-3.5") pg_restore -U postgres -d postgres /database_backup.sql
```

Isso irá importar os dados para o banco `postgres`.


Caso o comando não funcione realize o Backup a partir do PgAdmin. Explicação de acesso na seção  6.

- [Backup PgAdmin](https://www.youtube.com/watch?v=4HJwrXclC3A)

---

### 4. 📊 Acessar o Jupyter Notebook

Ao executar o comando de `docker-compose up`, dentro do terminal, procure nos logs do conteiner dos Notebooks
Jupyter algum link, semelhante ao de baixo:

```
http://127.0.0.1:8888/lab?token=<token> 

OU

http://localhost:8888/lab?token=<token> 

```

Use o token fornecido no terminal para acessar. Dentro do Jupyter, acesse a pasta `work/notebooks` e abra o notebook `analise_acessibilidade_sp_simples.ipynb`.

---

---

### 5. 🌐 Obter o IP do container PostGIS

Se quiser acessar o banco diretamente obtenha o endereço IPv4 do container do PostGIS com:

```bash
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -qf "ancestor=postgis/postgis:17-3.5")
```

Esse IP pode ser usado como **host** ao conectar no banco. Os demais dados de acesso são:

- **Porta:** 5432  
- **Usuário:** postgres  
- **Senha:** passwd  
- **Banco:** postgres

---


### 6. 🛠️ Acessar o banco via PgAdmin (opcional)

Acesse:

```
http://localhost/browser
```

Login:

- **Email:** t1-cic901@imt.br  
- **Senha:** t1-cic901

Adicione uma nova conexão ao banco com os dados:

- **Host:** IP do container  
- **Porta:** 5432  
- **Usuário:** postgres  
- **Senha:** passwd  

---

## 🧪 Funcionalidades

- Coleta de dados geoespaciais via OSM
- Armazenamento e consulta de dados com PostGIS
- Visualizações com Folium e KeplerGl
- Análise de cobertura de saúde com buffers e interseções geográficas
- Propostas de melhoria na infraestrutura de saúde pública

---

## 📚 Bibliotecas Utilizadas

- Python 3.11+
- GeoPandas
- OSMnx
- OSMPythonTools
- SQLAlchemy + GeoAlchemy2
- psycopg2-binary
- Folium
- KeplerGl
- PostGIS (PostgreSQL com suporte geoespacial)
