@ignore
Feature: Home Work

    Background: Preconditions
        # * url '
        * def tokenResponse = callonce read('classpath:Helpers/createToken.feature') {"email": "kara101@test.com","password": "kara101"}
        * def authToken = tokenResponse.token1
    @home 
    Scenario: Favorite articles
        # Step 1: Get atricles of the global feed
        # Step 2: Get the favorites count and slug ID for the first arice, save it to variables
        # Step 3: Make POST request to increse favorites count for the first article
        # Step 4: Verify response schema
        # Step 5: Verify that favorites article incremented by 1
            #Example
            
            
        
                       
            Given url 'https://conduit-api.bondaracademy.com/api/articles'
            When method GET
            Then def favoritesCount = response.articles[0].favoritesCount
            * print favoritesCount
            And def slugID = response.articles[0].slug
            * print slugID
            
            Given url 'https://conduit-api.bondaracademy.com/api/articles/Lorren-24541/favorite'
            And header Authorization = 'Token '+ authToken
            And request
            """
                {
                    "article": {
                        "id": 185234,
                        "slug": "Lorren-24541",
                        "title": "Lorren",
                        "description": "Tyria"
                    }
                }
            """
            When method POST
            Then status 200
            And match response ==
            """
                {
                    "article": {
                        "id": '#number',
                        "slug": "#string",
                        "title": "#string",
                        "description": "#string",
                        "body": "#string",
                        "createdAt": "#string",
                        "updatedAt": "#string",
                        "authorId": '#number',
                        "tagList": [],
                        "author": {
                            "username": "#string",
                            "bio": null,
                            "image": "#string",
                            "following": false
                        },
                        "favoritedBy": [
                            {
                                "id": '#number',
                                "email": "#string",
                                "username": "#string",
                                "password": "$2a$10$72GcwpWmnT9/kVwvKy.0DOdnGuqayxybpTsLtNaXiNxbo/xndpQG6",
                                "image": "#string",
                                "bio": null,
                                "demo": false
                            }
                        ],
                        "favorited": true,
                        "favoritesCount": '#number'
                    }
                }

            """
                * def initialCount = 0
                * def response = {"favoritesCount": 1}
                * match response.favoritesCount == initialCount + 1 
                              
            Given url 'https://conduit-api.bondaracademy.com/api/articles?limit=10&offset=0'
            And header Authorization = 'Token '+ authToken
            When method get
            Then match response.articles[0] ==
            """
            {
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "tagList": [],
            "createdAt": "#string",
            "updatedAt": "#string",
            "favorited": true,
            "favoritesCount": 1,
            "author": {
                "username": "#string",
                "bio": null,
                "image": "#string",
                "following": false
            }
            } 
            
            """
            And match response.articles[0].slug contains 'Lorren-24541' 

        # Step 6: Get all favorite articles
        # Step 7: Verify response schema
        # Step 8: Verify that slug ID from Step 2 exist in one of the favorite articles    
            @Scenario2
    Scenario: Comment articles
        # Step 1: Get atricles of the global feed
        # Step 2: Get the slug ID for the first arice, save it to variable
        # Step 3: Make a GET call to 'comments' end-point to get all comments
        # Step 4: Verify response schema
        # Step 5: Get the count of the comments array lentgh and save to variable
            #Example
            * def responseWithComments = [{"article": "first"}, {article: "second"}]
            * def articlesCount = responseWithComments.length
        # Step 6: Make a POST request to publish a new comment
        # Step 7: Verify response schema that should contain posted comment text
        # Step 8: Get the list of all comments for this article one more time
        # Step 9: Verify number of comments increased by 1 (similar like we did with favorite counts)
        # Step 10: Make a DELETE request to delete comment
        # Step 11: Get all comments again and verify number of comments decreased by 1
            Given url 'https://conduit-api.bondaracademy.com/api/articles?limit=10&offset=0'
            When method GET
            And def slugID = response.articles[0].slug
            * print slugID

            Given url 'https://conduit-api.bondaracademy.com/api/articles/Ebben-24541/comments'
            When method GET
            Then status 200
            And match response == 
            """
                {
                    "comments": '#array'
                }
            """
            * def commentsLength = response.comments.length
            
            #post call
            Given url 'https://conduit-api.bondaracademy.com/api/articles/Ebben-24541/comments'
            And header Authorization = 'Token '+ authToken
            And request
            """
                {"comment": 
                    {
                    "body": "lastResponse"
                    }
                }
            
            """
            
            When method POST
            Then status 200
            And match response == 
            """
            {
            "comment": {
            "id": '#number',
            "createdAt": "#string",
            "updatedAt": "#string",
            "body": "#string",
            "author": {
                "username": "#string",
                "bio": null,
                "image": "#string",
                "following": false
                    }
            }
            }
            """
            * def id = response.comment.id

            Given url 'https://conduit-api.bondaracademy.com/api/articles/Ebben-24541/comments'
            When method get
            Then status 200
            And match response.comments[*].body contains 'lastResponse'
            * def initialCount = commentsLength
            * def response = response.comments.length
            * match response == initialCount + 1 
            

            Given url 'https://conduit-api.bondaracademy.com/api/articles/Ebben-24541/comments'
            Given path id
            When method delete
            Then status 200

            Given url 'https://conduit-api.bondaracademy.com/api/articles/Ebben-24541/comments'
            When method get
            Then status 200
            * def response = response.comments.length
            * match response == commentsLength




