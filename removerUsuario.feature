Feature: Remover usuário
  Como uma pessoa qualquer
  Desejo remover um usuário
  Para que suas informações não estejam mais registradas

  Background: Base Url
    Given url baseUrl

  Scenario: Remover um usuário
    # Cria um usuário para remover
    * def payload = read("usuarioPrincipal.json")
    And request payload
    And path "/users"
    When method post
    * def res = response

    #Remover Usuário
    Given path "/users", res.id
    When method delete
    Then status 204

  Scenario: Remover um usuário com id inválido
    * def id = "12354665546456546"
    Given path "/users", id
    When method delete
    Then status 400
