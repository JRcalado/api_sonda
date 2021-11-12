# SONDA API
 Uma sonda exploradora da NASA pousou em marte. O pouso se deu em uma área retangular, na qual a sonda pode navegar usando uma interface web. 


## Linguagem e Framework

- Elixir
- Phoenix

Api foi construida com a linguagem de programação funcional Elixir e foi ultilizado o framawork Phoenix

## Instalação
Para rodar localmente esta aplicação, os seguintes software precisam serem instalados
- Docker
- Docker Compose
- Git

comandos para instalação 
```bash
docker-composer up --build
```
Assim que aplicação subir poderá acessar o seguinte o host: 
```http
localhost:4000
```
Para saber como usar a aplicação o swagger esta disponivél no seguinte host:
```http
http://localhost:4000/api/swagger
```
## Teste
Para executar os testes bastar rodar o seguinte comando
```bash
docker-composer up --build
```
## Deploy e acesso
subimos a aplicação no heroku e caso queira acessar basta acessar a seguinte URL:
```http
https://sondas-api-elixir-phx.herokuapp.com/api/swagger
```
Alem das configuração do heroku a aplicação tem as configuração para subir no GCP  dentro do GKE as configurações estão no seguinte arquivo
```http
cr/prod/cloudbuild.yaml
```

Em casos de duvidas segue meus contatos [calado.dev](https://calado.dev).
