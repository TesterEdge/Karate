@ignore
Feature:
    Background:
        Before hooks can be given in background and karate config.js
        Background - If you want your feature to run some default attributes before the scenario, use background
        karate config.js - If you want your feature to run some default attributes before running any features or 
                            at the start of test execution, use karate config.js
        afterFeature - run the script after scenarios are run
        afterScenario - run the script after each scenario
    Given def callName = call read('classpath:Helpers/Dummy.feature')
    * def name = callName
    * configure afterFeature = function(){karate.call('classpath:Helpers/Dummy.feature')}
    Scenario:    Concepts -> Before Hooks and After Hooks

    * print name
    * print 'This is the first scenario'

    Scenario:Concepts -> Before Hooks and After Hooks

    * print name

