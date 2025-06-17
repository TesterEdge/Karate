@ignore
#@randomuser
Feature:
New user signup
Background: Preconditions -  calling datagenerator java class
    Given url 'https://conduit-api.bondaracademy.com/api/users'
    * def randomData = Java.type('Helpers.DataGenerator');

Scenario:    
    #* def signUp = {"email":"rajesh102@abt.com", "password":"rajesh102", "username": "rajesh102"}
        * def randomEmailId = randomData.getEmailId();
        * def randomuserName = randomData.getUserName();
        Given request 
        """
        {
        user: 
        {
        email: #(randomEmailId), 
        password: #('Karate1k'),
        username: #(randomuserName)    
        }
        }
        """
    When method POST
    Then status 201
    And match response ==
    """
        {
            "user": {
                "id":"#number",
                "email": "#(randomEmailId)",
                "username": "#(randomuserName)",
                "bio": null,
                "image": "#string",
                "token": "#string"
            }
        }
    """

@datadriven    
    
Scenario Outline:    Data driven testing
    #* def signUp = {"email":"rajesh102@abt.com", "password":"rajesh102", "username": "rajesh102"}
        * def randomEmailId = randomData.getEmailId();
        * def randomuserName = randomData.getUserName();
        Given request 
        """
        {
            "user": {
                
                "email": "<email>",
                "username": "<username>",
                "password": "<password>"
            }
        }
        """
    When method POST
    Then status 422
    And match response == <errorResponse>

    Examples:
    |email             |password  |username            |errorResponse                                  |
    |kara101@test.com  |kara101   |kara101             |{"errors":{"email":["has already been taken"],"username":["has already been taken"]}}|
    |#(randomEmailId)  |abc1234   |kara1012            |{"errors":{"username":["has already been taken"]}}|  


