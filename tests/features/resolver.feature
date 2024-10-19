Feature: Path Resolver

  Background:
    Given the environment variables are set as follows:
      | PLATE_PRJ_PATH | /project/path |
      | PLATE_PKG_PATH | /package/path |

  Scenario Outline: Resolve paths based on environment variables and file existence
    When I resolve the path "<specifier>" does <file_exists> in a project
    Then the resolved path should be "<expected_resolved_path>"

    Examples:
      | specifier                  | file_exists | expected_resolved_path     |
      | some/path                  | not exist   | some/path                  |
      | random/path                | not exist   | random/path                |
      | ~/some/file.js             | exists      | /project/path/some/file.js |
      | ~/path/some/file.js        | not exist   | /package/path/some/file.js |
      | @/some/file.js             | not exist   | /project/path/some/file.js |
