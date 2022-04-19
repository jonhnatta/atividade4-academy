Feature: Atualizar usuário
  Como uma pessoa qualquer
  Desejo atualizar as informações de determinado usuário
  Para ter o registro de suas informações atualizadas

  Background: Base Url
    Given url baseUrl

  Scenario: Atualizar usuário por id
    # Cria um usuário para atualizar por id
    * def payload = read("usuarioPrincipal.json")
    And request payload
    And path "/users"
    When method post
    * def res = response

    #Atualiza um usuário por id
    Given path "/users", res.id
    * def peyloadUpdate = read("usuarioSecundario.json")
    And request peyloadUpdate
    When method put
    Then status 200
    * def resAt = response
    And match response contains {id: "#(resAt.id)",name: "#(resAt.name)", email:"#(resAt.email)", updatedAt: "#(resAt.updatedAt)", createdAt:"#(resAt.createdAt)"}

    #Deletar usuário para não deixar sujeito no banco de dados
    Given path "/users", res.id
    When method delete

  Scenario: Atualizar usuário com email já existente
    * def payload = {name:"Couve", email: "email_couve@gmail.com"}
    And request payload
    And path "/users"
    When method post
    * def id = response.id

    * def payload = {name:"Couve", email: "email_couve_2@gmail.com"}
    And request payload
    And path "/users"
    When method post
    * def id2 = response.id

    Given path "/users", id
    * def peyloadUpdate = {name:"Couve_atu", email: "email_couve_2@gmail.com"}
    And request peyloadUpdate
    When method put
    Then status 422

    #Deletar usuário para não deixar sujeito no banco de dados
    Given path "/users", id
    When method delete

    Given path "/users", id2
    When method delete

  Scenario: Atualizar usuário nome com mais de 100 caracteres
    * def payload = {name:"Abacate Doce", email: "abacate_doce@gmail.com"}
    And request payload
    And path "/users"
    When method post
    * def id = response.id

    Given path "/users", id
    * def peyloadUpdate = {name:"loremipsumdolorsitametconsecteturadipisicingelitDoloremdignissimosveniamexquaeametveicingelitDoalorem", email: "abacate_doce@gmail.com"}
    And request peyloadUpdate
    When method put
    Then status 400

    Given path "/users", id
    When method delete

  Scenario: Atualizar usuário email com mais de 60 caracteres
    * def payload = {name:"Abacate Azedo", email: "abacate_doce@gmail.com"}
    And request payload
    And path "/users"
    When method post
    * def id = response.id

    Given path "/users", id
    * def peyloadUpdate = {name:"Abacate Azedo", email: "laagremipsumasddsassasdasdasdasasjkisdddaasdsasddol@gmail.com"}
    And request peyloadUpdate
    When method put
    Then status 400

    Given path "/users", id
    When method delete