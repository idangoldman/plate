Feature: Array Methods
  As a developer
  I want to easily access first and last elements of arrays
  So that I can write more readable code

  Scenario Outline: Accessing array elements
    Given an array "<input>"
    When call the "<method>" method on the array
    Then return "<expected>" as the result

    Examples:
      | input           | method | expected  |
      | [1, 2, 3, 4, 5] | first  | 1         |
      | [1, 2, 3, 4, 5] | last   | 5         |
      | []              | first  | undefined |
      | []              | last   | undefined |
