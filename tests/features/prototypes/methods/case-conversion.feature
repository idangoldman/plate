@prototypes
@methods
@case-conversion
Feature: Case Conversions
  As a developer
  I want to convert strings between different case formats
  So that I can maintain consistent naming conversion in my codebase

  @strings
  Scenario Outline: Converting strings to different case formats
    Given I have a <input> string
    When I convert it to <caseType> case
    Then I should get <expected> as the result

    Examples:
      | input         | caseType | expected      |
      | "hello_World" | camel    | "helloWorld"  |
      | "helloWorld"  | constant | "HELLO_WORLD" |
      | "HelloWorld"  | kebab    | "hello-world" |
      | "helloWorld"  | pascal   | "HelloWorld"  |
      | "helloWorld"  | snake    | "hello_world" |
      | "hello.World" | title    | "Hello World" |
      | "HELLO_WORLD" | dot      | "hello.world" |

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
    Then Result should be an object with keys
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
