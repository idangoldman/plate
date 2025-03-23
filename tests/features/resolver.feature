@runtime @resolver
Feature: Path Resolver
  As a developer
  I want to resolve path specifiers correctly
  So that I can properly import modules from different locations

  Background:
    Given the environment variables are set to:
      | PLATE_PRJ_PATH | /project/path |
      | PLATE_PKG_PATH | /package/path |

  Scenario Outline: Resolving different types of path specifiers
    When I resolve the path specifier "<input>"
    Then the result should be "<expected>"

    Examples:
      | input             | expected                      |
      | lodash/merge.js   | lodash/merge.js               |
      | ~/lib/globals.js  | /package/path/lib/globals.js  |
      | @/src/utils.js    | /project/path/src/utils.js    |
      | ~/config/dev.json | /package/path/config/dev.json |
      | @/tests/main.js   | /project/path/tests/main.js   |

  Scenario: Missing environment variables
    Given the environment variables are not set
    When I resolve the path specifier "@/config/dev.json"
    Then it should throw an error containing "Environment variables PLATE_PRJ_PATH and PLATE_PKG_PATH are not set"
