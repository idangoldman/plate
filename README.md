# PLATE a Web Framework

Opinionated web development framework built upon principles and practices everyone already knows and use daily.

Inspired by work done on jQuery, Rails, YAML, and Python, and many other projects.

Code should be joyful to write and easily read thus understandable to maintain. This is the promise upon PLATE web framework created on. Like modern day poetry blocks of a poem if you will.

We say "best tool for the job" and mostly I think we don't mean that or know what it really means. What if there are several tools we should use to complete the job?

Ok, enough with the Chinese cookie placebo. What is the framework all about? The easiest way for me to explain would be to go over the folder structure of the project and dive into each one. Please take the following explanation with a grain of salt because the codebase in it's early stages and everything in it might move/change/disappear/improve.

## Core Principles

- Code should be joyful to write and easily read thus understandable to maintain.
- Indention first codebase
- Apply best tools with-in their domain to complete the job.

## Getting Started

To get started with PLATE, run the follow installment command in your project folder with `pnpm` package manager.

```shell
pnpm add blah-ink/plate
```

Once installed, you're ready to dive into the world of PLATE and experiment with it's powerful capabilities.

## CLI

The main point of interaction with the framework, it's the `plate` command.

```shell
plate [command] [arguments...]
```

You can start here and explore the functionality of it by typing `plate help` into the terminal of your choice.

The command itself is a wrapper of `process-compose` with predefined or runtime set of environment variables. As any other framework uses a task runner for automating it's infrastructure work. PLATE is not any different in this aspect and by choosing `process-compose` as the task runner it takes the advantage of managing the process of the tasks ran by it as well and not only the sequence of the tasks ran in.

## Environment Variables

As all framework have environment variables, PLATE is no different. Those variables used to help manage processes and empower the codebase with additional information.

| Name                | Default                            | Availability         | Description                                                                 |
| ------------------- | ---------------------------------- | -------------------- | --------------------------------------------------------------------------- |
| `PLATE_ENV`         | `development`                      | `process`, `runtime` | Used for conditioning functionality.                                        |
| `PLATE_CONF`        | `PLATE_CONF_PATH/environment.yml`  | `process`, `runtime` | Used for accessing configurations set in a `configs/environment.yml` files. |
| `PLATE_PKG_PATH`    | `./` -> `@/`                       | `process`, `runtime` |                                                                             |
| `PLATE_PRJ_PATH`    | `./` -> `~/`                       | `process`, `runtime` |                                                                             |
| `PLATE_BIN_PATH`    | `PLATE_PKG_PATH/node_modules/.bin` | `process`, `runtime` | Path to the package's `node_nodules/.bin` folder.                           |
| `PLATE_CONF_PATH`   | `PLATE_PKG_PATH/configs`           | `process`, `runtime` | Path to the current `configs` folder.                                       |
| `PLATE_CLI_COMMAND` | `help`                             | `process`            |                                                                             |
| `PLATE_CLI_ARGS`    |                                    | `process`            |                                                                             |

## Configurations

The center of opinions for framework and it's dependencies configuration files. Run the following command to take a look at the list of configuration files the framework use to shape it's codebase.

```shell
ls -la ./configs/**/*
```

### Presets (WIP)

Basically, the preset files store initial `key: value` YAML structured variables to be used across the codebase.

Contents of presets can be accessed across the codebase by referencing `$PLATE_CONFIG['KEY']`.

### Dependencies (WIP)

The configuration files of PLATE's dependencies are located in this folder with the exception of stubborn dependencies that enforce it's configuration file be in the root folder of the project they are part of.

### Override (IDEA)

All configuration files can be overridden by placing a config file in your project's folder in the same path the config file is located in PLATE's folder.

For ease of use, run the following command to override a configuration file:

```shell
plate config override presets/website.yml
```

### Extend (WIP)

All configuration files can be extended by placing a config file in your project's folder in the same path the config file is located in PLATE's folder with a suffix of a `PLATE_ENV` to run in.

For ease of use, run the following command to override a configuration file:

```shell
plate config extend production presets/website.yml
```

Extend is basically doing a deep merge between PLATE's core config and project's config file with `PLATE_ENV` suffix.

## Library

### Imports

#### Paths

| Prefix | Description |
| ------ | ----------- |
| `~/`   |             |
| `@/`   |             |

#### Formats

| Extension    | Description |
| ------------ | ----------- |
| `coffee`     |             |
| `yml`,`yaml` |             |

#### Globs (IDEA)

#### Attributes (WIP)

### Patterns

Are the core structures upon PLATE's functionality and behavior extended from.

#### Prototypes

##### Natives (WIP)

###### Objects

| Method  | Description |
| ------- | ----------- |
| `keys`  |             |
| `print` |             |

###### Arrays

| Method     | Description |
| ---------- | ----------- |
| `excludes` |             |
| `first`    |             |
| `last`     |             |

###### Strings

| Method       | Description |
| ------------ | ----------- |
| `capitalize` |             |
| `times`      |             |

##### Methods (WIP)

###### Is

| Method     | Description |
| ---------- | ----------- |
| `isArray`  |             |
| `isObject` |             |
| `isString` |             |
| `isEmpty`  |             |

###### To

| Method      | Description |
| ----------- | ----------- |
| `toArray`   |             |
| `toObject`  |             |
| `toBoolean` |             |
| `toNumber`  |             |

###### Naming Conventions

| Case     | Example |
| -------- | ------- |
| Camel    |         |
| Constant |         |
| Dot      |         |
| Kebab    |         |
| Pascal   |         |
| Snake    |         |
| Title    |         |

#### Hooks (WIP)

| Hook     | Description |
| -------- | ----------- |
| `before` |             |
| `around` |             |
| `after`  |             |

#### Events (IDEA)

| Handler | Description |
| ------- | ----------- |
| `on`    |             |
| `once`  |             |
| `emit`  |             |
| `off`   |             |

#### Missing Methods (IDEA)

## Testing

Our main believe is in testing our code in a behavioral driven development where everyone can think of a way the code should act and write a pseudo code example of it. Then write the first iteration of the internal behavior of code block, see it works on a happy path. Now write an essay about that piece of code with usage examples testing various ways of using and not using the piece of code that was only in our imagination before. Cool.

## Dependencies

As an opinionated framework, it's built upon unique set of tech tools and libraries, some of which are self-built from previous projects. Let's go over the list:

| Name              | Job                 | Reason                                                                                                                |
| ----------------- | ------------------- | --------------------------------------------------------------------------------------------------------------------- |
| Fish & cmdfile    | Shell               | Easiest to read and write shell scripts in with extended set of functions library via `cmdfile` plugin.               |
| Node.js           | Runtime environment | JavaScript runtime of use, no special reason.                                                                         |
| PNPM              | Package Manager     | Simply because it's the fastest of them 3.                                                                            |
| process-compose   | Task Runner         | A process manager that can be used as a task runner and configured similar to docker compose file. Has a TUI as well. |
| CoffeeScript      | Language            | No the most efficient JavaScript compiled language, yet the easiest and pleasant to read and write.                   |
| Cucumber.js       | Tests               | `Gherkin` language is the most readable and reusable way to write use-cases and test them.                            |
| ESBuild           | Bundle              | Current bundler of choice, optimize the CoffeeScript compiled code.                                                   |
| ESLint & Prettier | Code Quality        | Set of tools configured to automate codebase coherence structure.                                                     |
| YAML              | Configuration       | Default config files format.                                                                                          |

The above dependencies aren't set in stone and might be replaced by a better suited tool for the job along the way. Feel free to suggest a better tool for the job with valid points of why.

## What's on the Plate Right Now?

### Components Pattern

This is a major update for the framework and might be an easy one because most of the _work-in-theory_ codebase already written and been testishly used as part of `fmwk` (`feature.js`) which by the end of this implementation be obsolete and archived.

- [ ] Implement `component("selector", callback)`
- [ ] Implement supporting pattern objects
  - [ ] Base element
  - [ ] DOM Events
  - [ ] Local and Session Storage
- [ ] Migrate and extend tests for those of the above

#### In the Next Iteration

- [ ] Inputs (form too?)
- [ ] Keyboard events as shortcut combos
- [ ] Keyboard navigation helpers built in
- [ ] Implementation of `interval` and `timeout` in a form of `delay:1s` and `iterate:200ms`
- [ ] Page/Route
- [ ] Advanced Element
- [ ] Cache via service worker
- [ ] Implement "HTML over the Wire" page and template loading pattern.
- [ ] Implement an `analytics` object for `async` interaction with a stats server.
- [ ] Implementation of the 3 acronyms - `i18n`, `l10n`, and `a11y`.

### Hooks Pattern and Functions Prototype Implementation

- [ ] Implement `Hooks` pattern into `Prototypes` pattern.
- [ ] Implement `before`, `around`, and `after` wrappers of `Hooks.addHook` in `Functions` prototype.
- [ ] Transform `lib/helpers/safe.coffee` file functions into `Functions` prototype as a `safe`, `safeReturn` `safeOrFailure` methods, might be even used with `Hooks.around` method.

### Prototypes Enhancements

- [ ] Implement `Objects.inspect` printing the `object` in a human readable format.
- [ ] Implement `Objects.merge` method with deep merge by default, and remove `lodash.merge` dependency.
- [ ] Implement `Objects.freeze` method to freeze the object and all nested objects.
- [ ] Implement `Objects.keys` method to get the keys of the object.
- [ ] Implement `Objects.values` method to get the values of the object.
- [ ] Implement `Objects.each` method to iterate over the object.
- [ ] Implement `Objects.is` method to check if the object is equal to another object <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/is>.
- [ ] Implement `Objects.get` method to get the value of the object by the key.
- [ ] Implement `Objects.has` method to check if the object has the key.
- [ ] Implement `Strings.times` method to repeat the string `n` times.
- [ ] Implement `prototypes/methods/to.coffee` with `to` method to convert the object to a specific type.
- [ ] Move `toCase` and `toCaseKeys` into `prototypes/methods/naming-casing.coffee`. Extending `Object` with `strings` and `keys` methods combined.
- [ ] Implement `Numbers.toHuman([size, weight, dimension, distance, etc...])` method to convert the numbers to a human readable formats.
- [ ] Test `yaml` file loading and using `Objects.keyCase` method.

### MissingMethod Pattern Upgrade

- [ ] Implement `MissingMethod` (`respond_to_missing` and `method_is_missing`) pattern for `Prototypes` pattern be based on?
- [ ] Implement `getter` and `setter` methods in `Objects` prototype to use `MissingMethod` pattern routing prototype methods to use static methods of the same name.
- [ ] Replace the use of `export methods = Objects.methods()` in prototypes files with `Objects::methodName` pattern.
- [ ] Rewrite `Objects::methods` method to list all methods names in an array of an object.
- [ ] Further more, Let's say trying to use `Strings.capitalize` method in `Functions.after` method, and it's not defined, it should first try and import the `Strings` prototype and then call the method again. Well, maybe for now it's going to be better to just use `Strings.capitalize` method in the `Functions.after` method, and if it's not defined, it should throw an error. Because it's for internal use only and for external use all the `Prototypes` should be imported by the time of use.

### Infrastructure Upgrades

- [ ] Implement `glob` transformer and register as node.js loader in `lib/transformers/glob.coffee`.
- [ ] Implement `main` as an `importAttributes` of imported files, to be used like main in Python.
- [ ] Create defaults loader class for prototypes and methods loading.
- [ ] Implement `plate help` using the example in `bin/help.fish`.
- [ ] Restructure `lib/` folder:
  - [ ] Migrate some of the functionality out of the `lib/helpers` folder and into `Prototypes` or `Transformers`, the rest into `lib/utils`.
  - [ ] Rename `lib/plugins` to `lib/esbuild`
  - [ ] Create a folder for node specific code `lib/node` and move all related folders and files of code into it.
  - [ ] Create a `plate` task to copy a config file to extend or override the PLATE's config file in the current project.
  - [ ] Create a Singleton class pattern, just because? No, because it's overly copy-paste piece of code pattern that can be capsulated into a base class and extended from.
  - [ ] Implement `esbuild.icons.coffee` transformer to load icons from the `icons` folder and register as node.js loader in `lib/transformers/esbuild/icons.coffee`.
