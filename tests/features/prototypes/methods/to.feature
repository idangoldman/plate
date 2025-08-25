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

  @to-array
  Scenario Outline: Converting values to arrays
    When toArray method is called on <name>
    Then I should get <expected> as the result

    Examples:
      | name           | expected                    |
      | stringValue    | ["hello"]                   |
      | emptyString    | []                          |
      | arrayValue     | [1,2,3]                     |
      | emptyArray     | []                          |
      | objectValue    | [["a",1],["b",2]]           |
      | emptyObject    | []                          |
      | numberValue    | [42]                        |
      | booleanTrue    | [true]                      |

  @to-object
  Scenario Outline: Converting values to objects
    When toObject method is called on <name>
    Then I should get <expected> as the result

    Examples:
      | name           | expected                    |
      | stringValue    | {"0":"hello"}               |
      | emptyString    | {}                          |
      | arrayValue     | {"0":1,"1":2,"2":3}         |
      | emptyArray     | {}                          |
      | objectValue    | {"a":1,"b":2}               |
      | emptyObject    | {}                          |
      | numberValue    | {"0": 42}                   |
      | booleanTrue    | {"0": true}                 |
      | booleanFalse   | {"0": false}                |

  @to-boolean
  Scenario Outline: Converting values to booleans
    When toBoolean method is called on <name>
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
