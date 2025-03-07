Feature: Is methods type checking
  As a developer
  I want to use the Is methods to check value types

  Scenario: Checking simple value types
    Given I have the following values:
      | name      | value     | specialType |
      | string    | "hello"   |             |
      | emptyStr  | ""        |             |
      | number    | 42        |             |
      | array     | [1,2,3]   |             |
      | emptyArr  | []        |             |
      | object    | {"a":1}   |             |
      | emptyObj  | {}        |             |
    When I check their types
    Then the results should be:
      | name      | isArray | isObject | isString | isEmpty |
      | string    | false   | false    | true     | false   |
      | emptyStr  | false   | false    | true     | true    |
      | number    | false   | false    | false    | false   |
      | array     | true    | true     | false    | false   |
      | emptyArr  | true    | true     | false    | true    |
      | object    | false   | true     | false    | false   |
      | emptyObj  | false   | true     | false    | true    |
