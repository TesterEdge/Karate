Feature:
Test new user login and get token
Background:Get token
Scenario:
    Given url 'https://conduit-api.bondaracademy.com/api/users/login'
    And request { "user": {"email": "#(username)","password": "#(userpassword)"}}
    And karate.log('email',username)
    When method Post
    Then status 200
    * def token1 = response.user.token
    And karate.log('Token',token1)
    And print token1

