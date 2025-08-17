@prototypes @methods @to
Feature: To conversion methods
  As a developer
  I want to convert values between different types using to methods
  So that I can transform data structures easily and consistently

  Background:
    Given the following inputs:
      | name           | value                    |
      | stringValue    | "hello"                  |
      | emptyString    | ""                       |
      | arrayValue     | [1, 2, 3]                |
      | emptyArray     | []                       |
      | objectValue    | {"a": 1, "b": 2}         |
      | emptyObject    | {}                       |
      | numberValue    | 42                       |
      | zeroValue      | 0                        |
      | booleanTrue    | true                     |
      | booleanFalse   | false                    |
      | nullValue      | null                     |

  @to-array
  Scenario Outline: Converting values to arrays
    When I call the "toArray" method on the "<name>" value
    Then I should get <expected> as the result

    Examples:
      | name           | expected                    |
      | stringValue    | ["h","e","l","l","o"]       |
      | emptyString    | []                          |
      | arrayValue     | [1,2,3]                     |
      | emptyArray     | []                          |
      | objectValue    | [["a",1],["b",2]]           |
      | emptyObject    | []                          |
      | numberValue    | []                          |
      | booleanTrue    | []                          |
      | nullValue      | []                          |

  @to-object
  Scenario Outline: Converting values to objects
    When I call the "toObject" method on the "<name>" value
    Then I should get <expected> as the result

    Examples:
      | name           | expected                    |
      | stringValue    | {"0":"h","1":"e","2":"l","3":"l","4":"o"} |
      | emptyString    | {}                          |
      | arrayValue     | {"0":1,"1":2,"2":3}         |
      | emptyArray     | {}                          |
      | objectValue    | {"a":1,"b":2}               |
      | emptyObject    | {}                          |
      | numberValue    | {}                          |
      | booleanTrue    | {}                          |
      | nullValue      | {}                          |

  @to-boolean
  Scenario Outline: Converting values to booleans
    When I call the "toBoolean" method on the "<name>" value
    Then I should get <expected> as the result

    Examples:
      | name           | expected |
      | stringValue    | true     |
      | emptyString    | false    |
      | arrayValue     | true     |
      | emptyArray     | false    |
      | objectValue    | true     |
      | emptyObject    | false    |
      | numberValue    | true     |
      | zeroValue      | false    |
      | booleanTrue    | true     |
      | booleanFalse   | false    |
      | nullValue      | false    |

  @to-number
  Scenario Outline: Converting values to numbers
    When I call the "toNumber" method on the "<name>" value
    Then I should get <expected> as the result

    Examples:
      | name           | expected |
      | stringValue    | 5        |
      | emptyString    | 0        |
      | arrayValue     | 3        |
      | emptyArray     | 0        |
      | objectValue    | 2        |
      | emptyObject    | 0        |
      | numberValue    | 42       |
      | zeroValue      | 0        |
      | booleanTrue    | 1        |
      | booleanFalse   | 0        |
      | nullValue      | 0        |
