Feature: Is methods
  As a developer
  I want to use the Is methods to easily check objects

  Scenario Outline: Checking if a input is of a specific type
    Given an instance of "<input>"
    When check all prototype methods
    Then the results should be isArray: <isArray>, isObject: <isObject>, and isString: <isString>

    Examples:
      | input                        | isString | isArray | isObject |
      | " "                          | true     | false   | false    |
      | ""                           | true     | false   | false    |
      | "123"                        | true     | false   | false    |
      | "hello"                      | true     | false   | false    |
      | "not an array"               | true     | false   | false    |
      | []                           | false    | true    | true     |
      | [1, 2, 3]                    | false    | true    | true     |
      | ["a", "b", "c"]              | false    | true    | true     |
      | [null, undefined]            | false    | true    | true     |
      | {}                           | false    | false   | true     |
      | {"key": "value"}             | false    | false   | true     |
      | {"nested": {"key": "value"}} | false    | false   | true     |
      | 42                           | false    | false   | false    |
      | null                         | false    | false   | false    |
      | undefined                    | false    | false   | false    |

  Scenario Outline: Checking if an input is empty
    Given an instance of "<input>"
    When call the "isEmpty" method on the it
    Then return "<expected>" as the result

    Examples:
      | input               | expected |
      | []                  | true     |
      | {}                  | true     |
      | ""                  | true     |
      | [1, 2, 3]           | false    |
      | {"key": "value"}    | false    |
      | "hello"             | false    |
      | [undefined]         | false    |
      | {"key": undefined}  | false    |
      | " "                 | false    |
      | [null]              | false    |
      | {"toString": null}  | false    |
      | {"__proto__": null} | false    |
      | {"length": 0}       | false    |
      | [,,,]               | false    |
      | Object.create(null) | true     |
      | new Map()           | true     |
      | new Set()           | true     |
