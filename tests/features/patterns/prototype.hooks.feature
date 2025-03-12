Feature: Class-Level Hooks
  As a developer
  I want to apply hooks at the class definition level
  So that I can implement cross-cutting concerns for multiple methods at once

  Background:
    Given a prototype class with class-level hooks is defined

  Scenario: Applying a before hook to multiple methods in a class
    When I instantiate the class
    And I call the method "firstMethod" with argument "test"
    Then the before hook should execute
    And the method should return the expected result
    When I call the method "secondMethod" with argument "test"
    Then the before hook should execute again
    And the method should return the expected result

  Scenario: Applying an after hook to multiple methods in a class
    When I instantiate the class
    And I call the method "firstMethod" with argument "test"
    Then the after hook should execute
    And the method should return the result modified by the after hook
    When I call the method "secondMethod" with argument "test"
    Then the after hook should execute again
    And the method should return the result modified by the after hook

  Scenario: Applying an around hook to multiple methods in a class
    When I instantiate the class
    And I call the method "firstMethod" with argument "test"
    Then the around hook should execute before and after the method
    And the method should return the result modified by the around hook
    When I call the method "secondMethod" with argument "test"
    Then the around hook should execute before and after the method again
    And the method should return the result modified by the around hook

  Scenario: Around hook that conditionally executes methods
    When I instantiate the class
    And I call the method "validateMethod" with invalid argument ""
    Then the around hook should prevent the method execution
    And the method should return "Invalid"
    When I call the method "validateMethod" with valid argument "valid"
    Then the around hook should allow the method execution
    And the method should return the processed result

  Scenario: Multiple hooks applied to the same class methods
    When I instantiate the class with multiple hooks
    And I call the method "compositMethod"
    Then all class-level hooks should execute in the correct order
    And the method should return the result processed by all hooks
