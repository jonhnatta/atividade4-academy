Feature: Atualizar usuário
  Como uma pessoa qualquer
  Desejo atualizar as informações de determinado usuário
  Para ter o registro de suas informações atualizadas

  Background: Base Url
    Given url baseUrl
    * def peyloadUpdate = read("usuarioSecundario.json")

  Scenario: Atualizar usuário por id
    # Cria um usuário para atualizar por id
    * def payload = read("usuarioPrincipal.json")
    And request payload
    And path "/users"
    When method post
    * def res = response

    #Atualiza um usuário por id
    Given path "/users", res.id
    And request peyloadUpdate
    When method put
    Then status 200
    * def resAt = response
    And match response contains {id: "#(resAt.id)",name: "#(resAt.name)", email:"#(resAt.email)", updatedAt: "#(resAt.updatedAt)", createdAt:"#(resAt.createdAt)"}

    #Deletar usuário para não deixar sujeito no banco de dados
    Given path "/users", res.id
    When method delete