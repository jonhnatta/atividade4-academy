Feature: Encontrar um usuário
  Como uma pessoa qualquer
  Desejo consultar os dados de um usuário
  Para visualizar as informações deste usuário

  Background: Base Url
    Given url baseUrl

  Scenario: Encontrar usuário por Id
    # Cria um usuário para pesquisar por id
    * def payload = read("usuarioPrincipal.json")
    And request payload
    And path "/users"
    When method post
    * def res = response

    #Realiza a pesquisa por id
    Given path "/users", res.id
    When method get
    Then status 200
    And match response contains {id: "#(res.id)",name: "#(res.name)", email:"#(res.email)", updatedAt: "#(res.updatedAt)", createdAt:"#(res.createdAt)"}

    #Deletar usuário para não deixar sujeito no banco de dados
    Given path "/users", res.id
    When method delete