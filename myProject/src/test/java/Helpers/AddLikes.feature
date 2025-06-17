Feature: AddLikes
Background:
    Given url 'https://conduit-api.bondaracademy.com/api'
Scenario:
    Given path 'articles',slug,'favorite'
    And request {}
    When method POST
    Then status 200
    * def likesCount = response.articles[0].favoritesCount