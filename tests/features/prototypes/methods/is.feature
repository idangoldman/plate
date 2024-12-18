Feature: Is methods
  As a developer
  I want to use the Is methods to easily check objects

  Scenario Outline: Checking if a input is of a specific type
    Given an instance of "<input>"
    When call the "<method>" method on the it
    Then return "<expected>" as the result

    Examples:
      | input            | method   | expected |
      | [1, 2, 3]        | isArray  | true     |
      | 'hello'          | isArray  | false    |
      | { key: 'value' } | isObject | true     |
      | 123              | isObject | false    |
      | 'hello'          | isString | true     |
      | [1, 2, 3]        | isString | false    |

  Scenario Outline: Checking if an input is empty
    Given an instance of "<input>"
    When call the "isEmpty" method on the it
    Then return "<expected>" as the result

    Examples:
      | input            | expected |
      | []               | true     |
      | [1, 2, 3]        | false    |
      | {}               | true     |
      | { key: 'value' } | false    |
      | ''               | true     |
      | 'hello'          | false    |
