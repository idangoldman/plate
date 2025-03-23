# @prototypes @natives @functions
Feature: Function Prototype Methods
  As a developer
  I want to use the Function prototype methods
  So that I can safely handle function execution and error handling

  Background:
    Given the Functions prototype is applied

  Scenario: Using safely method with a successful function
    Given I have a function that calculates a value
    When I call the function using the "safely" method
    Then I should receive an array with [null, result]

  Scenario: Using safely method with a failing function
    Given I have a function that throws an error
    When I call the function using the "safely" method
    Then I should receive an array with [error, null]

  Scenario: Using safelyReturnValue method with a successful function
    Given I have a function that calculates a value
    When I call the function using the "safelyReturnValue" method
    Then I should receive only the result

  Scenario: Using safelyReturnValue method with a failing function
    Given I have a function that throws an error
    When I call the function using the "safelyReturnValue" method
    Then I should receive null

  Scenario: Using safelyOrFail method with a successful function
    Given I have a function that calculates a value
    When I call the function using the "safelyOrFail" method
    Then I should receive the result

  Scenario: Using safelyOrFail method with a failing function
    Given I have a function that throws an error
    When I call the function using the "safelyOrFail" method
    Then the error should be thrown

  Scenario: Using returnTrueOrFalse method with a successful function
    Given I have a function that calculates a value
    When I call the function using the "returnTrueOrFalse" method
    Then I should receive true

  Scenario: Using returnTrueOrFalse method with a failing function
    Given I have a function that throws an error
    When I call the function using the "returnTrueOrFalse" method
    Then I should receive false

  Scenario: Using these methods with an asynchronous function
    Given I have an asynchronous function that returns a promise
    When I call the async function using the "safely" method
    Then I should receive a promise that resolves to [null, result]
