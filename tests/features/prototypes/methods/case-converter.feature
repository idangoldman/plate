@prototypes @methods @case-converter
Feature: Case Conversions
  As a developer
  I want to convert strings between different case formats
  So that I can maintain consistent naming conventions in my codebase

  @strings
  Scenario Outline: Converting strings to different case formats
    Given the string "<input>"
    When I call the "<methodName>" method on the string
    Then I should get "<expected>" as the result

    Examples:
      | input       | methodName      | expected    |
      | hello_World | toCamelCase     | helloWorld  |
      | helloWorld  | toConstantCase  | HELLO_WORLD |
      | HelloWorld  | toKebabCase     | hello-world |
      | helloWorld  | toPascalCase    | HelloWorld  |
      | helloWorld  | toSnakeCase     | hello_world |
      | hello.World | toTitleCase     | Hello World |
      | HELLO_WORLD | toDotCase       | hello.world |

  @objects
  Scenario: Converting nested object keys from different case formats to PascalCase
    Given I have an object
      """json
      {
        "firstName": "John",
        "last_name": "Doe",
        "contact-info": {
          "EmailAddress": "john@example.com",
          "home.address": "1st Main Street",
          "PHONE_NUMBER": "123-456-7890"
        }
      }
      """
    When I convert all keys of the object to PascalCase format
    Then I should get an object
      """json
      {
        "FirstName": "John",
        "LastName": "Doe",
        "ContactInfo": {
          "EmailAddress": "john@example.com",
          "HomeAddress": "1st Main Street",
          "PhoneNumber": "123-456-7890"
        }
      }
      """
