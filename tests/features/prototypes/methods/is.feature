@prototypes
@methods
@is
Feature: Is methods type checking
  As a developer
  I want to use the Is methods to check value types

  Background:
    Given the following inputs:
      | name     | value   |
      | string   | "hello" |
      | emptyStr | ""      |
      | number   | 42      |
      | array    | [1,2,3] |
      | emptyArr | []      |
      | object   | {"a":1} |
      | emptyObj | {}      |

  @arrays
  @objects
  @strings
  Scenario Outline: Checking the data types of inputs
    When I check the type of "<name>"
    Then it should be one of:
      | isArray  | <isArray>  |
      | isObject | <isObject> |
      | isString | <isString> |

    Examples:
      | name     | isArray | isObject | isString |
      | string   | false   | false    | true     |
      | emptyStr | false   | false    | true     |
      | number   | false   | false    | false    |
      | array    | true    | false    | false    |
      | emptyArr | true    | false    | false    |
      | object   | false   | true     | false    |
      | emptyObj | false   | true     | false    |

  @empty
  Scenario Outline: Checking if values are empty
    When I check if "<name>" is empty
    Then it should be "<isEmpty>"

    Examples:
      | name     | isEmpty |
      | string   | false   |
      | emptyStr | true    |
      | number   | false   |
      | array    | false   |
      | emptyArr | true    |
      | object   | false   |
      | emptyObj | true    |
