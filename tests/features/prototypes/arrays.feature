@prototypes
@arrays
Feature: Array Prototype Methods
  As a developer
  I want to use the Array methods to easily work with arrays
  So that I can write more readable and consistent code

  Background:
    Given the following inputs:
      | name      | value                     |
      | deep      | [1, [2, [3, [4]], 5]]     |
      | duplicate | [1, 2, 2, 3, 3, 3]        |
      | empty     | []                        |
      | mixed     | [1, [2, 3], 4, [4, 5, 6]] |
      | nested    | [1, [2, 3], 4]            |
      | standard  | [1, 2, 3]                 |

  @first-last
  Scenario Outline: Using first and last methods
    When <method> method is called on <array>
    Then I should get <expected> as the result

    Examples:
      | array    | method | expected  |
      | standard | first  | 1         |
      | standard | last   | 3         |
      | empty    | first  | undefined |
      | empty    | last   | undefined |

  @excludes
  Scenario Outline: Using excludes method
    When excludes method is called on <array> with <argument>
    Then I should get <expected> as the result

    Examples:
      | array    | argument | expected |
      | standard | 1        | false    |
      | standard | 4        | true     |
      | empty    | 1        | true     |

  @flatten
  Scenario Outline: Using flatten method
    When flatten method is called on <array>
    Then I should get <expected> as the result

    Examples:
      | array     | expected           |
      | deep      | [1, 2, 3, 4, 5]    |
      | duplicate | [1, 2, 3]          |
      | empty     | []                 |
      | mixed     | [1, 2, 3, 4, 5, 6] |
      | nested    | [1, 2, 3, 4]       |
      | standard  | [1, 2, 3]          |
