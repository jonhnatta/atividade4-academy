Feature: Criar Usuário
  Como uma pessoa qualquer
  Desejo registrar informações de usuário
  Para poder manipular estas informações livremente

  Scenario: Criar um Usuário
    * def payload = read("usuarioPrincipal.json")
    Given url baseUrl
    And request payload
    And path "/users"
    When method post
    Then status 201
    * def resp = response
    And match response contains {id: "#(resp.id)",name: "#(resp.name)", email:"#(resp.email)", updatedAt: "#(resp.updatedAt)", createdAt:"#(resp.createdAt)"}

    Given url baseUrl
    And path "/users", resp.id
    When method delete