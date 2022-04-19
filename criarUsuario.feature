Feature: Criar Usuário
  Como uma pessoa qualquer
  Desejo registrar informações de usuário
  Para poder manipular estas informações livremente

  Background: Base Url
    Given url baseUrl

  Scenario: Criar um Usuário
    * def payload = read("usuarioPrincipal.json")
    And request payload
    And path "/users"
    When method post
    Then status 201
    * def res = response
    And match response contains {id: "#(res.id)",name: "#(res.name)", email:"#(res.email)", updatedAt: "#(res.updatedAt)", createdAt:"#(res.createdAt)"}

    #Deletar usuário para não deixar sujeito no banco de dados
    Given path "/users", res.id
    When method delete

  Scenario: Criar usuario com email inválido
    * def payload = {name:"Email Errado", email: "email.gmail.com"}
    And request payload
    And path "/users"
    When method post
    Then status 400

  Scenario: Criar usuario já existente
    * def payload = {name:"Couve", email: "email_couve@gmail.com"}
    * def payloadNew = {name:"Alface", email: "email_couve@gmail.com"}
    And request payload
    And path "/users"
    When method post
    Then status 201
    * def id = response.id

    And request payloadNew
    And path "/users"
    When method post
    Then status 422

    Given path "/users", id
    When method delete

  Scenario: Criar um Usuário com 100 caracteres
    * def payload = {name:"loremipsumdolorsitametconsecteturadipisicingelitDoloremdignissimosveniamexquaeametveicingelitDolorem", email: "jonhnatta.teste@gmail.com"}
    And request payload
    And path "/users"
    When method post
    Then status 201
    * def res = response
    And match response contains {id: "#(res.id)",name: "#(res.name)", email:"#(res.email)", updatedAt: "#(res.updatedAt)", createdAt:"#(res.createdAt)"}

    #Deletar usuário para não deixar sujeito no banco de dados
    Given path "/users", res.id
    When method delete

  Scenario: Criar um Usuário com 101 caracteres
    * def payload = {name:"loremipsumdolorsitametconsecteturadipisicingelitDoloremdignissimosveniamexquaeametveicingelitDoalorem", email: "jonhnatta.teste@gmail.com"}
    And request payload
    And path "/users"
    When method post
    Then status 400

  Scenario: Criar um Usuário email de 60 caracteres
    * def payload = {name:"Jonh Mail", email: "lagremipsumasddsassasdasdasdasasjkisdddaasdsasddol@gmail.com"}
    And request payload
    And path "/users"
    When method post
    Then status 201
    * def res = response
    And match response contains {id: "#(res.id)",name: "#(res.name)", email:"#(res.email)", updatedAt: "#(res.updatedAt)", createdAt:"#(res.createdAt)"}

    #Deletar usuário para não deixar sujeito no banco de dados
    Given path "/users", res.id
    When method delete

  Scenario: Criar um Usuário email de 61 caracteres
    * def payload = {name:"Jonh Mail", email: "laagremipsumasddsassasdasdasdasasjkisdddaasdsasddol@gmail.com"}
    And request payload
    And path "/users"
    When method post
    Then status 400
