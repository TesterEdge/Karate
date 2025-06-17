@ignore
Feature: Validate creation and deletion of records
Background:
     Get token from another feature file
* def tokenResponse = callonce read('classpath:Helpers/createToken.feature') {"email": "kara101@test.com","password": "kara101"}
* def authToken = tokenResponse.token1
# And karate.log(authToken)
@ignore
Scenario:
    
    Given url 'https://conduit-api.bondaracademy.com/api/users/login'
    Given request { "user": {"email": "kara101@test.com","password": "kara101"}}
    When method Post
    Then status 200
    And def token = response.user.token 
    And karate.log(token)
    And match response.user.email contains 'kara101@test.com'
    
    Given url 'https://conduit-api.bondaracademy.com/api/articles'
    Given header Authorization = 'Token '+ token
    And request { "article": {"title": "abcdefg", "description": "This is second test automation", "body": "I love automation","tagList": []}}
    When method Post
    Then status 201
    And match response.article.description == 'This is second test automation'


Scenario: Delete the last created article
    Given url articleapi
    And request {"article": {"title": "Record to be deleted6","description": "new article to check delete request","body": "new article to check delete request","tagList": [] }}
    When method Post
    Then status 201
    * def articleId = response.article.slug

    Given path articleId
    When method get
    Then status 200
    

    Given path articleId
    When method Delete
    Then status 204

    Given url articleapi
    Given params {limit:10, offset:0}
    When method get
    Then status 200
    And match response.articles[0].title !contains ('Record to be deleted6')