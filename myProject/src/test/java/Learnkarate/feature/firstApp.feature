@aae
Feature: 
    Test the home page
    Background:
     Given url 'https://conduit-api.bondaracademy.com/api'
    * def tokenResponse = callonce read('classpath:Helpers/createToken.feature')
    * def authToken = tokenResponse.token1
        
@ignore    
Scenario:    
    Validate if the application has tags
    Given url 'https://conduit-api.bondaracademy.com/api/tags'
    When method get
    Then status 200
    And match response.tags == '#array'
    And match response.tags contains ['Test','YouTube']
    And match response.tags !contains 'bottles'
    # And match response.tags contains only []
    And match response.tags contains any ['Bondar Academy','Value-Focused','Live Sessions']
    And match each response.tags == '#string'

@ignore @checkarticles
Scenario:
    Validate if the articles are present
    
    Given url 'https://conduit-api.bondaracademy.com/api/articles'
    Given params {limit:10, offset:0}
    When method get
    Then status 200
    And karate.log (response)
    #* def timeValidator = read ('classpath:/Helpers/timeValidator.js')
    # And match response.articles == '#array'
    # And match response.articles =='#[10]'
    # And match response.articlesCount != 10
    # And match response.articlesCount == 18
    # And match response.articles[*].favouritesCount !contains '10'
    # And match response..bio contains null
    # # And match each response..following == 'false'
    # And match each response.articles contains {title :'##string', favoritesCount : '#number'}
    # And match each response..following == '#boolean'
    # And match each response..favoritesCount == '#number'
    # And match each response..bio == '##string'
    And match response == { "articles": '#[10]', "articlesCount":"#number" }
    And match each response.articles ==
    
        """
            {
                "slug": "#string",
                "title": "#string",
                "description": "#string",
                "body": "#string",
                "tagList": '#array',
                "createdAt": "#string",
                "updatedAt": "#string",
                "favorited": '#boolean',
                "favoritesCount": '#number',
                "author": {
                    "username": "#string",
                    "bio": "##string",
                    "image": "#string",
                    "following": '#boolean'
                }
            }
                
    """
    @ignore
    Scenario: Conditional loops
        Given path 'articles'
        And params {limit: 10 , offset: 0}
        And header Authorization = authToken
        When method get
        Then status 200
        * def favCount = response.articles[0].favoritesCount
        * def article = response.articles[0]
        # using if statement
        # * if (favCount == 0) karate.call('classpath:Helpers/AddLikes.feature', article)
        # using js for writing conditions
        * def result = favCount == 0 ? karate.call('classpath:Helpers/AddLikes.feature', article).likesCount : favCount
        Given path 'articles'
        And params {limit: 10 , offset: 0}
        When method get
        And match response.articles[0].favoritesCount == result
        
@debug
    Scenario: Retry call
        * configure retry = {count: 10, interval: 5000}
        Given path 'articles'
        And params {limit: 10 , offset: 0}
        And retry until response.articles[0].favoritesCount == 1
        When method get
        Then status 200

    Scenario: Sleep
        Given def sleep = function(pause){java.lang.Thread.sleep(pause)}
        Given path 'articles'
        And params {limit: 10 , offset: 0}        
        When method get
        And sleep(5000)
        Then status 200
    
    Scenario: Number to String conversion
        * def numb = 10
        * def obj = {"no":1, "nextno":#(numb+'')}
        * match obj.nextno == '10'
    Scenario: String to Number conversion
        * def nm = '10'
        * def obj = {"no": #(~~parseInt(nm))}
        * def obj1 = {"no": #(nm*1)}
        * match obj == {"no": 10}
        * match obj1 == {"no": 10}