Feature: Listar Usuário
  Como uma pessoa qualquer
  Desejo consultar todos os usuários cadastrados
  Para ter as informações de todos os usuários

  Scenario: Listar todos os Usuários
    Given url baseUrl
    And path "/users"
    When method get
    Then status 200
    And match response == "#array"