Feature: Array Methods
  As a developer
  I want to use the Array methods to easily work with arrays
  So that I can write more readable code

  Scenario Outline: Accessing array elements
    Given an array "<input>"
    When call the "<method>" method on the array
    Then return "<expected>" as the result

    Examples:
      | input     | method  | expected  |
      | [1, 2, 3] | first   | 1         |
      | [1, 2, 3] | last    | 3         |
      | []        | first   | undefined |
      | []        | last    | undefined |

  Scenario Outline: Accessing array elements with arguments
    Given an array "<input>"
    When call the "<method>" method with "<arguments>" on the array
    Then return "<expected>" as the result

  Examples:
      | input     | method   | arguments | expected  |
      | [1, 2, 3] | excludes | 5         | true      |
      | [1, 2, 3] | excludes | 2         | false     |
