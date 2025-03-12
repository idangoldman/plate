Feature: Hooks Pattern Implementation
  As a developer
  I want to use the Hooks pattern to modify method behavior
  So that I can implement cross-cutting concerns without modifying original code

  Background:
    Given a simple test object with methods

  Scenario: Adding before hooks to a method
    When I add a "before" hook to the "greet" method
    And I call the "greet" method with "World"
    Then the "before" hook should be executed
    And the method should return "Hello, World"

  Scenario: Adding after hooks to a method
    When I add an "after" hook to the "greet" method that modifies the result
    And I call the "greet" method with "World"
    Then the "after" hook should be executed
    And the method should return "Hello, World!!!"

  Scenario: Adding around hooks to a method
    When I add an "around" hook to the "greet" method that executes code before and after
    And I call the "greet" method with "World"
    Then the "around" hook should be executed
    And the method should return "HELLO, WORLD"

  Scenario: Chaining multiple hooks on a method
    When I add a "before" hook to the "greet" method
    And I add an "after" hook to the "greet" method
    And I add an "around" hook to the "greet" method
    And I call the "greet" method with "World"
    Then all hooks should be executed in the correct order
    And the method should return the correctly modified result

  Scenario: Adding hooks to multiple methods at once
    When I add a "before" hook to both "greet" and "farewell" methods
    And I call the "greet" method with "World"
    And I call the "farewell" method with "World"
    Then the "before" hook should be executed for both methods
