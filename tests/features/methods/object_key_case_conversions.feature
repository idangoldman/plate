Feature: Object Key Case Conversions
  As a developer
  I want to convert all keys in an object to different cases
  So that I can maintain consistent object property naming

  Background:
    Given I have imported the object prototype methods

  Scenario Outline: Converting nested object keys to different cases
    Given I have an object
      """
      {
        "<key1>": "John",
        "<key2>": "Doe",
        "<nested_key>": {
          "<nested_key1>": "123-456-7890",
          "<nested_key2>": "john@example.com"
        }
      }
      """
    When I convert all keys to "<target_case>"
    Then I should get an object
      """
      {
        "<expected_key1>": "John",
        "<expected_key2>": "Doe",
        "<expected_nested_key>": {
          "<expected_nested_key1>": "123-456-7890",
          "<expected_nested_key2>": "john@example.com"
        }
      }
      """

    Examples:
      | key1       | key2      | nested_key   | nested_key1  | nested_key2    | target_case | expected_key1 | expected_key2 | expected_nested_key | expected_nested_key1 | expected_nested_key2 |
      | first_name | last_name | contact_info | phone_number | email_address  | camel       | firstName     | lastName      | contactInfo        | phoneNumber         | emailAddress        |
      | firstName  | lastName  | contactInfo  | phoneNumber  | emailAddress   | snake       | first_name    | last_name     | contact_info       | phone_number        | email_address       |
      | first_name | last_name | contact_info | phone_number | email_address  | pascal      | FirstName     | LastName      | ContactInfo        | PhoneNumber         | EmailAddress        |
      | firstName  | lastName  | contactInfo  | phoneNumber  | emailAddress   | kebab       | first-name    | last-name     | contact-info       | phone-number        | email-address       |
      | first_name | last_name | contact_info | phone_number | email_address  | constant    | FIRST_NAME    | LAST_NAME     | CONTACT_INFO       | PHONE_NUMBER        | EMAIL_ADDRESS       |
