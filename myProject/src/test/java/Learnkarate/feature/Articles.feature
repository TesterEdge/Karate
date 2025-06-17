@articles
Feature: Get articles

Background:
    Using the json feature file request or response can be stored and all other feature file can read the schema for any validation
    Given url 'https://conduit-api.bondaracademy.com/api'
    * def tokenResponse = callonce read('classpath:Helpers/createToken.feature')
    * def authToken = tokenResponse.token1
    * def randomData = Java.type('Helpers.DataGenerator')
    * def articleRequest = read('classpath:Learnkarate/json/newarticlesrequest.json')
    Given set articleRequest.article.title = randomData.getRandomArticlesData().title;
    Given set articleRequest.article.description = randomData.getRandomArticlesData().description;
    Given set articleRequest.article.body = randomData.getRandomArticlesData().body;
@ignore
Scenario:
    
    #Given header Authorization = 'Token '+ token
    And request articleRequest
    When method Post
    Then status 201
    And match response.article.description == articleRequest.article.description
    And match response.article.title == articleRequest.article.title
    And match response.article.body == articleRequest.article.body



