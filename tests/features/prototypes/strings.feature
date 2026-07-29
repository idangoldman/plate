@prototypes @natives @strings
Feature: String Prototype Methods
  As a developer
  I want to use enhanced String methods
  So that I can manipulate strings more effectively

  Scenario Outline: Using capitalize method
    Given the string "<input>"
    When I call the "capitalize" method on the string
    Then I should get "<expected>" as the result

    Examples:
      | input         | expected      |
      | hello         | Hello         |
      | world         | World         |
      | hello world   | Hello world   | # Only first word
      | HELLO         | Hello         | # Corrected expectation
      | ""            | ""            | # Empty string

  Scenario Outline: Using times method
    Given the string "<input_string>"
    When I multiply the string by "<n_value>"
    Then I should get "<expected_string>" as the result

    Examples:
      | input_string | n_value   | expected_string |
      | abc          | 3         | abcabcabc       | # Basic case
      | abc          | 1         | abc             | # n = 1
      | abc          | 0         | ""              | # n = 0
      | abc          | -2        | ""              | # n is negative
      | abc          | hello     | ""              | # n is not a number
      | ""           | 5         | ""              | # Empty input string
      | test         | 2.5       | testtest        | # n is a float, parseInt will take 2
      | xyz          | NaN       | ""              | # n is NaN string
      | xyz          | undefined | ""              | # n_value is the string "undefined"
      | undefined    | 3         | ""              | # input_string is special keyword "undefined"

# Note: "undefined" as input_string will be handled as empty string by step def.
# "undefined" for n_value will be passed as the string "undefined" which parseInt will make NaN.
# NaN for n_value will be passed as string "NaN" which parseInt will make NaN.
