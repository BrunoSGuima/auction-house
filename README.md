<h1>Titulo ou Arte do Projeto</h1> 

<p align="center">

  <img src="http://img.shields.io/static/v1?label=Ruby&message=2.6.3&color=red&style=for-the-badge&logo=ruby"/>
  <img src="http://img.shields.io/static/v1?label=Ruby%20On%20Rails%20&message=6.0.2.2&color=red&style=for-the-badge&logo=ruby"/>
  <img src="http://img.shields.io/static/v1?label=TESTES&message=%3E100&color=GREEN&style=for-the-badge"/>
   <img src="http://img.shields.io/static/v1?label=STATUS&message=EM%20DESENVOLVIMENTO&color=RED&style=for-the-badge"/>
</p>

> Status do Projeto: :warning: em desenvolvimento

### Tópicos 

:small_blue_diamond: [Descrição do projeto](#descrição-do-projeto)

:small_blue_diamond: [Funcionalidades](#funcionalidades)

:small_blue_diamond: [Pré-requisitos](#pré-requisitos)

:small_blue_diamond: [Como rodar a aplicação](#como-rodar-a-aplicação-arrow_forward)

... 

Insira os tópicos do README em links para facilitar a navegação do leitor

## Descrição do projeto 

<p align="justify">
  Projeto Leilão do Galpão é um sistema web que permite a criação de lotes de leilão. Os usuários podem fazer lances, acompanhar outros lances, acessar página de lotes vencedores, ver quais produtos estão vinculados nos lotes, favoritar/desfavoritar os lotes, enviar uma pergunta aos administradores, buscar por produtos ou lotes especificos.
  Os administradores podem cadastrar/excluir lotes, cadastrar modelos de produtos, criar novos produtos, inserir e remover produtos dos lotes, responder ou ocultar a perguntas feitas por usuários, bloquear usuários, bloquear CPF de usuários e não usuários, acessar página de lotes expirados, encerrar/cancelar lotes expirados, criar novas categorias para os modelos de produtos, etc...
</p>

## Funcionalidades

:heavy_check_mark: Bloqueio de CPF 

:heavy_check_mark: Dúvidas sobre um lote 

:heavy_check_mark: Lotes Favoritos  

:heavy_check_mark: Busca de Produtos  


![tela de produtos](https://github.com/BrunoSGuima/auction-house/assets/105590450/a9e7cddd-c392-4242-9fd8-711e693a5b53)

![tela de bloqueio](https://github.com/BrunoSGuima/auction-house/assets/105590450/d3b637b7-c0df-4dee-97bb-50022a7846b7)

## Pré-requisitos

Ruby 2.7.0 ou superior
Rails 6.0.0 ou superior
Gem Devise
Bootstrap

## Como rodar a aplicação :arrow_forward:

1. Clone o repositório para o seu local de trabalho:

git clone https://github.com/BrunoSGuima/auction-house.git

2. Navegue até a pasta do projeto:

cd auction-house

3. Instale as dependências do projeto:

bundle install

4. Crie o banco de dados e execute as migrações:

rails db:create
rails db:migrate

5. Execute o comando:

rails db:seed

6. Inicie o servidor:

rails server



## Como rodar os testes

Este projeto utiliza o RSpec como sua principal ferramenta de testes. Siga os passos abaixo para executar os testes:

1. Certifique-se de que você instalou todas as dependências do projeto com bundle install.

2. Configure o banco de dados de teste com RAILS_ENV=test rails db:create db:migrate. Este comando cria o banco de dados de teste e executa todas as migrações.

3. Agora você pode executar todos os testes com o comando rspec

4. Os resultados dos testes serão exibidos no terminal.



## :floppy_disk:

<iframe src="https://giphy.com/embed/1oDsJobSjjdHxoLxZv" width="480" height="480" frameBorder="0" class="giphy-embed" allowFullScreen></iframe><p><a href="https://giphy.com/gifs/nowapocalypse-season-1-starz-now-apocalypse-1oDsJobSjjdHxoLxZv">via GIPHY</a></p>

### Usuários:

|email|password|
| -------- |-------- |
|user@email.com|password|
|admin@leilaodogalpao.com.br|password|
|joao@leilaodogalpao.com.br|password|
|user2@email.com|password|
|user3@email.com|password|
|user4@email.com|password|
|user5@email.com|password|


... 

Se quiser, coloque uma amostra do banco de dados 

## Iniciando/Configurando banco de dados

O projeto já possui um seeds construido.



## Licença 

The [MIT License]() (MIT)

Copyright :copyright: 2023 - Leilão do Galpão


<iframe src="https://giphy.com/embed/lD76yTC5zxZPG" width="480" height="352" frameBorder="0" class="giphy-embed" allowFullScreen></iframe><p><a href="https://giphy.com/gifs/the-end-thats-all-folks-lD76yTC5zxZPG">via GIPHY</a></p>
