Feature: Access the database using Java and check POST, GET methods
Background:
    * def dbHandler = Java.type ('Helpers.DbHandler')
Scenario:
    Given def description = 'QA1'
    When eval dbHandler.addNewJobWithName('description')
    And def insert = dbHandler.getMinAndMaxLevelsForJob('description')
    Then match insert.min_lvl == '80'
    And match insert.max_Lvl == '120'
