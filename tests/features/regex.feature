@utilities
@regex
Feature: Regular Expression Patterns
  As a developer
  I want to use compiled regex patterns from YAML definitions
  So that I can validate and match strings consistently across the framework

  Background:
    Given the regex utility is loaded

  @content-types
  Scenario Outline: Matching content types
    When I test "<input>" against REGEX.CONTENT_TYPES_<type>
    Then the result should be <expected>

    Examples:
      | type      | input                | expected |
      | ARRAY     | [1, 2, 3]            | true     |
      | ARRAY     | {"key": "value"}     | false    |
      | OBJECT    | {"key": "value"}     | true     |
      | OBJECT    | [1, 2, 3]            | false    |
      | STRING    | "hello world"        | true     |
      | STRING    | hello world          | false    |
      | NUMBER    | 42                   | true     |
      | NUMBER    | 3.14                 | true     |
      | NUMBER    | abc                  | false    |
      | COMMON_JS | module.exports = {}  | true     |
      | COMMON_JS | export default {}    | false    |

  @file-extensions
  Scenario Outline: Matching file extensions
    When I test "<filename>" against REGEX.FILE_EXTENSIONS_<type>
    Then the result should be <expected>

    Examples:
      | type      | filename           | expected |
      | COFFEE    | app.coffee         | true     |
      | COFFEE    | readme.litcoffee   | true     |
      | COFFEE    | doc.coffee.md      | true     |
      | COFFEE    | script.js          | false    |
      | YAML      | config.yml         | true     |
      | YAML      | settings.yaml      | true     |
      | YAML      | data.json          | false    |
      | EXTENSION | file.txt           | true     |
      | EXTENSION | archive.tar.gz     | true     |

  @path-starters
  Scenario Outline: Matching path prefixes
    When I test "<path>" against REGEX.PATH_STARTERS_<type>
    Then the result should be <expected>

    Examples:
      | type    | path              | expected |
      | BASE    | ~/library/utils   | true     |
      | BASE    | @/src/main        | true     |
      | BASE    | ./relative/path   | false    |
      | PACKAGE | ~/configs/env.yml | true     |
      | PACKAGE | @/tests/spec.js   | false    |
      | PROJECT | @/src/index.js    | true     |
      | PROJECT | ~/lib/helpers.js  | false    |

  @placeholders
  Scenario Outline: Matching placeholder patterns
    When I test "<input>" against REGEX.PLACEHOLDERS_<type>
    Then the result should be <expected>

    Examples:
      | type    | input                  | expected |
      | SIMPLE  | {{variable}}           | true     |
      | SIMPLE  | {{ spaced_var }}       | true     |
      | SIMPLE  | {single}               | false    |
      | PATTERN | {{pattern_name}}       | true     |
      | PATTERN | text {{var}} more text | true     |

  @case
  Scenario Outline: Matching case patterns
    When I test "<input>" against REGEX.CASE_<type>
    Then the result should be <expected>

    Examples:
      | type       | input          | expected |
      | SEPARATORS | HelloWorld     | true     |
      | SEPARATORS | hello_world    | true     |
      | SEPARATORS | hello-world    | true     |
      | SEPARATORS | hello.world    | true     |
      | WHITESPACE | hello world    | true     |
      | WHITESPACE | multiple  gaps | true     |

  @validators
  Scenario Outline: Validating data formats
    When I test "<input>" against REGEX.VALIDATORS_<validator>
    Then the result should be <expected>

    Examples:
      | validator        | input                              | expected |
      | EMAIL            | user@example.com                   | true     |
      | EMAIL            | invalid.email                      | false    |
      | URL              | https://example.com                | true     |
      | URL              | www.example.com                    | true     |
      | URL              | not a url                          | false    |
      | UUID             | 550e8400-e29b-41d4-a716-446655440000 | true   |
      | UUID             | not-a-uuid                         | false    |
      | IPV4             | 192.168.1.1                        | true     |
      | IPV4             | 256.1.1.1                          | false    |
      | IPV6             | 2001:0db8:85a3:0000:0000:8a2e:0370:7334 | true |
      | HEX_COLOR        | #FF5733                            | true     |
      | HEX_COLOR        | #F00                               | true     |
      | HEX_COLOR        | FF5733                             | true     |
      | HEX_COLOR        | #GG0000                            | false    |
      | ISO_DATE         | 2024-12-31                         | true     |
      | ISO_DATE         | 12/31/2024                         | false    |
      | SLUG             | my-blog-post                       | true     |
      | SLUG             | My Blog Post                       | false    |
      | USERNAME         | john_doe123                        | true     |
      | USERNAME         | ab                                 | false    |
      | BINARY           | 101010                             | true     |
      | BINARY           | 102                                | false    |
      | JSON             | {"key":"value"}                    | true     |
      | JSON             | {key:value}                        | false    |
      | MAC_ADDRESS      | 00:1B:44:11:3A:B7                  | true     |
      | MAC_ADDRESS      | 00-1B-44-11-3A-B7                  | true     |
      | PERCENTAGE       | 99.5%                              | true     |
      | PERCENTAGE       | 100%                               | true     |
      | PERCENTAGE       | 150%                               | false    |
      | STRONG_PASSWORD  | MyP@ssw0rd123                      | true     |
      | STRONG_PASSWORD  | weak                               | false    |
      | TIME_12_HOUR     | 03:45PM                            | true     |
      | TIME_12_HOUR     | 15:45                              | false    |
      | TIME_24_HOUR     | 15:45                              | true     |
      | TIME_24_HOUR     | 15:45:30                           | true     |
      | TIME_24_HOUR     | 25:00                              | false    |
      | UNIX_PATH        | /usr/local/bin                     | true     |
      | UNIX_PATH        | C:\Windows\System32                | false    |
      | WINDOWS_PATH     | C:\Windows\System32\cmd.exe        | true     |
      | WINDOWS_PATH     | /usr/local/bin                     | false    |
      | INTL_PHONE       | +14155552671                       | true     |
      | INTL_PHONE       | 4155552671                         | false    |
      | HTML_TAG         | <div>                              | true     |
      | HTML_TAG         | </span>                            | true     |
      | HTML_TAG         | <p class="text">                   | true     |
      | HTML_TAG         | plain text                         | false    |

  @caching
  Scenario: Regex patterns are cached after first access
    When I access REGEX.VALIDATORS_EMAIL for the first time
    And I access REGEX.VALIDATORS_EMAIL for the second time
    Then both accesses should return the same RegExp instance
