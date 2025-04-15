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

Abra o terminal na raiz do projeto e execute:

```bash
docker-compose build
docker-compose up
```

Isso irá iniciar três serviços:

- **Jupyter Notebook**: Ambiente interativo para análise de dados.
- **PostGIS**: Banco de dados PostgreSQL com suporte a dados geoespaciais.
- **PgAdmin**: Interface web para gerenciar o banco de dados.

---

### 3. 💾 Restaurar o backup do banco

Com os containers rodando, execute o comando abaixo para restaurar o backup SQL para o banco:

```bash
docker exec -i $(docker ps -qf "ancestor=postgis/postgis") psql -U postgres < backup/database_backup.sql
```

Isso irá importar os dados para o banco `postgres`.


Caso o comando não funcione realize o Backup a partir do PgAdmin
---

### 4. 📊 Acessar o Jupyter Notebook

Acesse no navegador:

```
http://localhost:8888
```

Use o token fornecido no terminal para acessar. Dentro do Jupyter, acesse a pasta `work/notebooks` e abra o notebook `analise_acessibilidade_sp_simples.ipynb`.

---

### 5. 🛠️ Acessar o banco via PgAdmin (opcional)

Acesse:

```
http://localhost/browser
```

Login:

- **Email:** t1-cic901@imt.br  
- **Senha:** t1-cic901

Adicione uma nova conexão ao banco com os dados:

- **Host:** db  
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