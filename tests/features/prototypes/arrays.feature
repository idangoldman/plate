@prototypes
@arrays
Feature: Array Prototype Methods
  As a developer
  I want to use the Array methods to easily work with arrays
  So that I can write more readable and consistent code

  Background:
    Given the following inputs:
      | name     | value     |
      | standard | [1, 2, 3] |
      | empty    | []        |

  Scenario Outline: Using first and last methods
    When <method> method is called on <array>
    Then I should get <expected> as the result

    Examples:
      | array    | method | expected  |
      | standard | first  | 1         |
      | standard | last   | 3         |
      | empty    | first  | undefined |
      | empty    | last   | undefined |

  Scenario Outline: Using excludes method
    When excludes method is called on <array> with <argument>
    Then I should get <expected> as the result

    Examples:
      | array    | argument | expected |
      | standard | 1        | false    |
      | standard | 4        | true     |
      | empty    | 1        | true     |
