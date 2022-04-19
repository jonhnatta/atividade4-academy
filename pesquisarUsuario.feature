Feature: Pesquisar Usuário
  Como uma pessoa qualquer
  Desejo atualizar as informações de determinado usuário
  Para ter o registro de suas informações atualizadas

  Background: Base Url
    Given url baseUrl

  Scenario: Pesquisar um usuário
    Cria um usuário para pesquisar por nome
    * def payload = read("usuarioPrincipal.json")
    And request payload
    And path "/users"
    When method post
    * def id = response.id
    * def name = response.name

    #pesquisar um usuário por nome
    Given path "/search"
    And param value = name
    When method get
    Then status 200
   
    #Deletar usuário para não deixar sujeito no banco de dados
    Given path "/users", id 
    * print id 
    When method delete