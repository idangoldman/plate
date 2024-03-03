Feature: String Case Conversion

  As a developer, I want to convert strings between different cases (camelCase, snake_case, kebab-case, PascalCase, CONSTANT_CASE, dot.case, path/case, sentence case, and title case) so that I can easily manipulate and utilize strings in various contexts.

  Background: Given the string conversion functions are implemented on the String prototype

  Scenario: Convert string to camelCase
    Given I have the string "Hello world example"
    When I convert it to camelCase
    Then the result should be "helloWorldExample"

  Scenario: Convert string to snake_case
    Given I have the string "Hello world example"
    When I convert it to snake_case
    Then the result should be "hello_world_example"

  Scenario: Convert string to kebab-case
    Given I have the string "Hello world example"
    When I convert it to kebab-case
    Then the result should be "hello-world-example"

  Scenario: Convert string to PascalCase
    Given I have the string "hello world example"
    When I convert it to PascalCase
    Then the result should be "HelloWorldExample"

  Scenario: Convert string to CONSTANT_CASE
    Given I have the string "hello world example"
    When I convert it to CONSTANT_CASE
    Then the result should be "HELLO_WORLD_EXAMPLE"

  Scenario: Convert string to dot.case
    Given I have the string "hello world example"
    When I convert it to dot.case
    Then the result should be "hello.world.example"

  Scenario: Convert string to path/case
    Given I have the string "hello world example"
    When I convert it to path/case
    Then the result should be "hello/world/example"

  Scenario: Convert string to sentence case
    Given I have the string "HELLO WORLD EXAMPLE"
    When I convert it to sentence case
    Then the result should be "Hello world example"

  Scenario: Convert string to Title Case
    Given I have the string "hello world example"
    When I convert it to Title Case
    Then the result should be "Hello World Example"

  Scenario Outline: Convert strings between different cases dynamically
    Given I have the string "<inputString>"
    When I convert it to <targetCase> case
    Then the result should be "<expectedResult>"

    Examples:
      | inputString          | targetCase    | expectedResult        |
      | example string here  | constant      | EXAMPLE_STRING_HERE   |
      | example string here  | dot           | example.string.here   |
      | example string here  | pascal        | ExampleStringHere     |
      | example string here  | path          | example/string/here   |
      | EXAMPLE STRING HERE  | sentence      | Example string here   |
      | example string here  | title         | Example String Here   |
      | example_string_here  | snake         | example_string_here   |
      | example-string-here  | kebab         | example-string-here   |
      | exampleStringHere    | camel         | exampleStringHere     |

  Scenario: Attempt to convert string to an unsupported case
    Given I have the string "exampleStringHere"
    When I attempt to convert it to "unsupported" case
    Then I should receive an error message "Case type unsupported is not supported"
