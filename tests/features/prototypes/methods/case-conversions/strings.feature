Feature: String Case Conversions
  As a developer
  I want to convert strings between different case formats
  So that I can maintain consistent naming conventions in my codebase

  Scenario Outline: Converting strings to different cases
    Given I have a string "<input>"
    When I convert it to "<case_type>" case
    Then I should get "<expected>"

    Examples:
      | input       | case_type | expected    |
      | hello_World | camel     | helloWorld  |
      | hello_world | camel     | helloWorld  |
      | hello-world | camel     | helloWorld  |
      | hello.world | camel     | helloWorld  |
      | helloWorld  | constant  | HELLO_WORLD |
      | hello_world | constant  | HELLO_WORLD |
      | HelloWorld  | kebab     | hello-world |
      | hello_world | kebab     | hello-world |
      | helloWorld  | pascal    | HelloWorld  |
      | hello_world | pascal    | HelloWorld  |
      | helloWorld  | snake     | hello_world |
      | HelloWorld  | snake     | hello_world |
      | helloWorld  | title     | Hello World |
      | hello_world | title     | Hello World |
      | hello.world | dot       | hello.world |
      | hello_world | dot       | hello.world |

  Scenario Outline: Capitalizing strings with different formats
    Given I have a string "<input>"
    When I call the capitalize method on it
    Then I should get "<expected>"

    Examples:
      | input          | expected       |
      | hello          | Hello          |
      | WORLD          | World          |
      | already_done   | Already_done   |
      | camelCase      | CamelCase      |
      | PascalCase     | PascalCase     |
      | snake_case     | Snake_case     |
      | kebab-case     | Kebab-case     |
      | multiple words | Multiple words |
      | 123test        | 123test        |
      | _private       | _private       |
      | a              | A              |
      | $special       | $special       |
      | über           | Über           |
      | café           | Café           |
      | españa         | España         |
