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
    * def res = response
    And match response contains {id: "#(res.id)",name: "#(res.name)", email:"#(res.email)", updatedAt: "#(res.updatedAt)", createdAt:"#(res.createdAt)"}

    Given path "/users", res.id
    When method delete