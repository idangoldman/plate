# Changelog

<!--
  [Added]      for new features.
  [Changed]    for changes in existing functionality.
  [Deprecated] for soon-to-be removed features.
  [Fixed]      for any bug fixes.
  [Removed]    for now removed features.
  [Security]   in case of vulnerabilities.
-->

## [0.9.0] - YYYY-MM-DD

### Added

- This `CHANGELOG.md` file.
- A `___` prefix added to overriden native JavaScript methods in Prototypes pattern to still be able to access the original method if needed, yet still need to be tested and verified.
- `class To extends Prototypes` on `Object` with `toArray`, `toObject`, and `toBoolean` methods as a proof of concept for `to*` methods and Prototypes pattern with tests coverage.
- Moved case conversion from `Strings` and `Objects` into `class CaseConversion extends Prototypes` with `toCase`, `toCamelCase`, `toConstantCase`, `toDotCase`, `toKebabCase`, `toPascalCase`, `toSnakeCase`, `toTitleCase`, and tests coverage.
- Use of `@tags` in `gherkin` feature files to be able to run specific tests by tags.
- `expectedValueParser` support helper in `cucumber` steps to parse expected values from `string` to their real type, like `boolean`, `number`, `object`, and `array`.
- New parameter types `expectedValue` and `envVar` for `cucumber` steps to be able to parse expected values and environment variables in steps definitions.
- Support for `gherkin` feature files formatting with `prettier-plugin-gherkin` plugin.

### Changed

- `README.md` - it's still a work in progress and not complete
- Minor updates to `REGEX` helpers
- Refactor `isNativeMethod` helper
- Formatted CoffeeScript files
- Updated dependencies

### Fixed

- `isObject` method to return `true` for `array` type.
- Tests always passing on `GitHub Actions` workflow due to `ignore_errors: true` on `test` step.

### Removed

- ESLint will be reintroduced in the future
- Hooks pattern and Functions Prototypes extensions
- Taskfile's cache for test, format, and format-fix tasks
- Default camel case keys for YAML files loader

## [0.8.1] - 2025-08-24

### Fixed

- NPM publish workflow
- CLI args passing to the taskfile tasks and not to the taskfile itself

## [0.8.0] - 2025-08-24

- Migrated from process-compose to taskfile for clearer and better task expression
- Remove the use of Fish Shell for the benefit of simple coffee cli code.
- improved cucumber config file with merge settings of profiles
- improved coffee lint file with yaml syntax
- created build and test github action to be ran on git push
- updated format and lint tasks
- package deps were updated as well and pnpm workspace was added
- made test coverage for capitalize function as well
- readme file was updated with the general changes as well

## [0.7.0] - 2025-03-07

- Wrote an initial README file draft for the project, including TODOs roadmap.
- Moved from a `Makefile` to a `proccess-compose.yml` file to manage the project's lifecycle.
- Added `./bin/help.fish` to provide a help command for the project, which basically lists processes by namespace with their name and description in a CLI help command format.
- Updated `capitalize` helper and `regex` constants.
- Created `isNativeMethod` helper and variations of `Safe` function execution helpers.
- Updated the folder and file structure to better organize the project.
  - Moved prototypes of Native methods to `./lib/prototypes` folder.
  - Renamed Native Class extensions into plural form, like `Array` to `Arrays`.
  - Created a `./lib/patterns` folder to store general code patterns. Like `prototypes` and `hooks` patterns.
  - Tests were moved and updated as well.
  - Also filename changes with-in transformers and plugins folders.
- Added `hooks` pattern, `functions` prototypes, and `to*` methods as proof of concept and work in progress, to be implemented into use in the future.
- Added `is*` methods to check if a value is of a specific type or empty with tests coverage.
- Updated outdated NPM packages.

P.S. 120 days later and I forgot the main reason for this branch's initial start, Although I'm happy with it and the progress made as a whole in it.

## [0.6.0] - 2024-10-29

- update cucumber config
- created capitalizate helper method
- removed mappings helpers to be replaces by extending base objects via prototypes
- updated yaml loader and transformer with import attributes support for key case transformation
- added Array, Object and String prototype methods to extend base objects
- added cucumber tests coverage for prototypes extensions
- refactored resolver transformer for simplicity and updated tests
- updated makefiles with `@` to avoid echoing commands
- upgraded dependencies and removed engine version from package.json
- introduced support folder with hooks, world, and import methods files for cucumber
- added a github action workflow for publishing to npm

## [0.5.0] - 2024-10-19

- Converted the project to use `coffee` instead of `mjs` as primary style of code writing.
- Removal of `Gulp` and use of it as the primary task manager of the project.
- Introduced `Makefile` as the primary way of managing project's tasks. Yet, all the tasks are under `WIP` status and still being tested with a thought of migrating some of them to be used as processes with `process-compose`.
- Enforced `bin/plate.fish` to use a specific `node` and `pnpm` versions.
- Updated `plate` command to be a mirror of `Makefile` and it's extension `*.mk` files.
- Renamed `config => configs` folder and added `[coffeelint, cucumber, eslint, prettier]` configuration files to be base setup and use of these tools for the project and as a package in other projects.
- Restructured `[imports, tools]` folders into `lib/` folder, where the package's `coffee` code lives and built into `src/` folder to be published.
- Removed support for `.cjs` loader for now.
- Created a `lib/helpers/` folder for better manage supportive functions that being used across the codebase.
- `BDD` tests are introduced in this version and they are still under `WIP` label, and will be expand and test upon in the next version.

[0.9.0]: https://github.com/idangoldman/plate/compare/0.8.1...0.9.0
[0.8.1]: https://github.com/idangoldman/plate/compare/0.8.0...0.8.1
[0.8.0]: https://github.com/idangoldman/plate/compare/0.7.0...0.8.0
[0.7.0]: https://github.com/idangoldman/plate/compare/0.6.0...0.7.0
[0.6.0]: https://github.com/idangoldman/plate/compare/0.5.0...0.6.0
[0.5.0]: https://github.com/idangoldman/plate/compare/0.4.2...0.5.0

0.4.2: <https://github.com/idangoldman/plate/compare/0.4.1...0.4.2>
0.4.1: <https://github.com/idangoldman/plate/compare/0.4.0...0.4.1>
0.4.0: <https://github.com/idangoldman/plate/compare/0.3.1...0.4.0>
0.3.1: <https://github.com/idangoldman/plate/compare/0.3.0...0.3.1>
0.3.0: <https://github.com/idangoldman/plate/compare/0.2.1...0.3.0>
0.2.1: <https://github.com/idangoldman/plate/compare/0.2.0...0.2.1>
0.2.0: <https://github.com/idangoldman/plate/compare/0.1.0...0.2.0>
0.1.0: <https://github.com/idangoldman/plate/compare/6df3280...0.1.0>
