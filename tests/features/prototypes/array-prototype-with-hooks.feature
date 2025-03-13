Feature: Array Prototype with Hooks
  As a developer
  I want to use the Array prototype with hooks
  So that I can handle edge cases like empty arrays consistently

  Background:
    Given the Array prototype with hooks is applied

  Scenario Outline: Using first and last methods with non-empty arrays
    Given I have an array "<array>"
    When I call the "<method>" method
    Then I should get "<expected>"

    Examples:
      | array     | method | expected |
      | [1, 2, 3] | first  | 1        |
      | [1, 2, 3] | last   | 3        |
      | [5]       | first  | 5        |
      | [5]       | last   | 5        |

  Scenario Outline: Using first and last methods with empty arrays
    Given I have an array "[]"
    When I call the "<method>" method
    Then I should get undefined

    Examples:
      | method |
      | first  |
      | last   |

  Scenario Outline: Using excludes method
    Given I have an array "<array>"
    When I call the "excludes" method with "<value>"
    Then I should get "<expected>"

    Examples:
      | array     | value | expected |
      | [1, 2, 3] | 1     | false    |
      | [1, 2, 3] | 4     | true     |
      | []        | 1     | true     |

  Scenario: Verifying that array hooks are working for first and last methods
    Given I have an empty array
    When I check the hooks applied to "first"
    Then the array hook should handle empty arrays
    When I check the hooks applied to "last"
    Then the array hook should handle empty arrays
