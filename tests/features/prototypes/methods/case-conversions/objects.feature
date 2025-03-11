Feature: Object Key Case Conversions
  As a developer
  I want to convert all keys in an object to different cases
  So that I can maintain consistent object property naming

  Scenario Outline: Converting nested object keys to different cases
    Given I have an object
      """
      {
        "<key1>": "John",
        "<key2>": "Doe",
        "<key3>": {
          "<key4>": "123-456-7890",
          "<key5>": "john@example.com"
        }
      }
      """
    When I convert all keys to "<case_type>"
    Then I should get an object
      """
      {
        "<expected_key1>": "John",
        "<expected_key2>": "Doe",
        "<expected_key3>": {
          "<expected_key4>": "123-456-7890",
          "<expected_key5>": "john@example.com"
        }
      }
      """

    Examples:
      | key1       | key2      | key3         | key4         | key5           | case_type   | expected_key1 | expected_key2 | expected_key3 | expected_key4 | expected_key5 |
      | first_name | last_name | contact_info | phone_number | email_address  | Camel       | firstName     | lastName      | contactInfo   | phoneNumber   | emailAddress  |
      | firstName  | lastName  | contactInfo  | phoneNumber  | emailAddress   | Snake       | first_name    | last_name     | contact_info  | phone_number  | email_address |
      | first_name | last_name | contact_info | phone_number | email_address  | Pascal      | FirstName     | LastName      | ContactInfo   | PhoneNumber   | EmailAddress  |
      | firstName  | lastName  | contactInfo  | phoneNumber  | emailAddress   | Kebab       | first-name    | last-name     | contact-info  | phone-number  | email-address |
      | first_name | last_name | contact_info | phone_number | email_address  | Constant    | FIRST_NAME    | LAST_NAME     | CONTACT_INFO  | PHONE_NUMBER  | EMAIL_ADDRESS |
