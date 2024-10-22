Feature: Array Methods
  As a developer
  I want to easily access first and last elements of arrays
  So that I can write more readable code

  Background:
    Given I have imported the array prototype methods

  Scenario Outline: Accessing array elements
    Given I have an array <input>
    When I call the <method> method
    Then I should get <expected>

    Examples:
      | input           | method | expected  |
      | [1, 2, 3, 4, 5] | first  | 1         |
      | [1, 2, 3, 4, 5] | last   | 5         |
      | []              | first  | undefined |
      | []              | last   | undefined |
      | ["a", "b", "c"] | first  | "a"       |
      | ["a", "b", "c"] | last   | "c"       |
