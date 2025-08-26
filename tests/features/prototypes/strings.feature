@prototypes
@strings
Feature: Strings Prototype Methods
  As a developer
  I want to change the case of strings using prototype methods
  So that I can format text consistently

  Scenario Outline: Capitalizing strings with different formats
    Given I have a <input> string
    When capitalize method applied to it
    Then I should get <expected> as the result

    Examples:
      | input            | expected         |
      | "hello"          | "Hello"          |
      | "WORLD"          | "World"          |
      | "already_done"   | "Already_done"   |
      | "camelCase"      | "Camelcase"      |
      | "PascalCase"     | "Pascalcase"     |
      | "snake_case"     | "Snake_case"     |
      | "kebab-case"     | "Kebab-case"     |
      | "multiple words" | "Multiple words" |
      | "123test"        | "123test"        |
      | "_private"       | "_private"       |
      | "a"              | "A"              |
      | "$special"       | "$special"       |
      | "über"           | "Über"           |
      | "café"           | "Café"           |
      | "españa"         | "España"         |
