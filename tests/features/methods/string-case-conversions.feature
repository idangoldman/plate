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
      | hello_World | camel    | helloWorld  |
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

  # Scenario: Attempt to convert string to an unsupported case
  #   Given I have a string "<input>"
  #   When I convert it to "<case_type>" case
  #   Then I should get an error message "Case type unsupported is not supported"
