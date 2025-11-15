# JavaScript on a Plate Roadmap

## Released (0.9.0)

See [CHANGELOG.md](CHANGELOG.md) file for what is already done and available for use.

## WIP Release (0.10.0)

- [x] Creation of a clear [ROADMAP.md](ROADMAP.md) instead of a TODOs puke.
- [ ] Clean up of runtime functionality and tests.
- [x] Rename of lib to library.
- [x] Taskfile for binaries of plate and transpile.
- [ ] Migrate to ESBuild as the codebase transpiler
  - [x] Transpile CoffeeScript to JavaScript files
  - [x] Resolve aliases #library, #tests. Might not need them when setting the absWorkingDir parameter.
  - [x] Source maps should be true 
  - [x] Minified as well true
  - [x] Correct resolution for format, platform, and target of library, and tests.
  - [x] Manage configuration settings in the transpile.yml file.
  - [ ] Optimize the npm package to reflect the package in its production state and not development. Meaning removing all folders and files that aren't used in production settings, and update the package json according, after bin/plate compilation as well.
- [ ] Simplification of package vs project paths into just absolute package path.

## Next Release (0.11.0)

- Rewrite of the [README.md](README.md) file for clarity.
- Create Events pattern with on, off, once, emit.
- Implement DOM Events based of Events pattern.
  - trigger - should trigger custom Dom events.
  - disable emit method of Events pattern.
- Create definitions folder with YAML files for regex and events names.
- Transpile YAML to JavaScript Object files.
- Refactor regex utility file into a dynamic object loader of regex expressions.

## Backlog

- Implement `component("selector", callback)` function pattern.
- Implement `HTMLElements` as prototype of native `HTMLElement`.
- Create `Stores` pattern with `local`, `session`, `cookie`, and `memory` storage options.
- Create Hooks pattern to support Functions extensions and Prototypes pattern.
- Refactor library into tree-shakable structure for smaller footprint.

### Prototype Enhancements

- Applying prototypes by direct import vs importing specific method or prototype.
- Create Functions Prototypes
- Create Numbers Prototypes
- `CaseConversion.hasCase` - check if the string has the specific case
- `Numbers.toHuman` - convert the number to a human readable format

#### Objects

- `each` - iterate over the object
- `freeze` - freeze the object and all nested objects
- `get` - get the value of the object by the key, with support for nested keys using dot notation
- `has` - check if the object has the key, with support for nested keys using dot notation
- `inspect` - print the object in a human readable format
- `is` - check if the object is equal to another object <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/is>
- `keys` - get the keys of the object
- `merge` - deep merge by default, and remove `lodash.merge` dependency
- `set` - set the value of the object by the key, with support for nested keys using dot notation
- `values` - get the values of the object

#### Strings

- `clean` - remove extra spaces, new lines, and tabs from the string
- `sanitize` - remove any potentially harmful code from the string (XSS protection)
- `times` - repeat the string `n` times
- `toDataUrl` - convert the string to a data URL
- `truncate` - truncate the string to a specific length with ellipsis

### Advocacy

- GitHub repository with code usage examples.
- API and functionality documentation website based on Gherkin feture files generated with [cukedoctor](https://github.com/rmpestano/cukedoctor) or similar tool.
- Create a CDN publishing GitHub Action.

### Ideas

- Implement `MissingMethod` pattern
  - acts as a router for multiple tree shakable and lazy loadable functionalities.
  - `respond_to_missing` and `method_is_missing` methods in `Objects` prototype
  - Proxying method calls to static methods of the same name in the prototype class.
  - `getter` and `setter` methods in `Objects` prototype to use `MissingMethod` pattern routing prototype methods to use static methods of the same name.
  - Refactor all prototypes to use `MissingMethod` pattern instead of exporting methods array.
  - Replace the use of `export methods = Objects.methods()` in prototypes files with `Objects::methodName` pattern.
  - Rewrite `Objects::methods` method to list all methods names in an array of an object.
  - Further more, Let's say trying to use `Strings.capitalize` method in `Functions.after` method, and it's not defined, it should first try and import the `Strings` prototype and then call the method again. Well, maybe for now it's going to be better to just use `Strings.capitalize` method in the `Functions.after` method, and if it's not defined, it should throw an error. Because it's for internal use only and for external use all the `Prototypes` should be imported by the time of use.
- Extend events pattern with Keyboard events
- Implement Locations prototype extending page route navigation
- Implement Templates pattern for loading html and css files on the fly over http or websocket.
- Implementation of the 3 acronyms - `i18n`, `l10n`, and `a11y`.
- Implement Timers pattern with every (interval), delay (timeout), clear, clearAll.
- Implement wait, waitFor, sleep, debounce, throttle and utils functions.
- Implement Messages pattern as a wrapper for Broadcast API.
- Implement Clipboard pattern with copy and paste functionality.
- Extend HTMLElements with update (with observers),empty, append, prepend, find, html, css, create functionality.
- Implement component.isolate functionality.
