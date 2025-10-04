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
pnpm add @idangoldman/plate
```

Once installed, you're ready to dive into the world of PLATE and experiment with it's powerful capabilities.

## CLI

The main point of interaction with the framework, it's the `plate` command.

```shell
plate [namespace:]command [arguments...]
```

PLATE provides a dual binary system:

- **`plate-dev`** - Development binary that runs CoffeeScript directly for instant execution
- **`plate`** - Production binary that runs compiled JavaScript for distribution

You can start here and explore the functionality by typing `plate help` or `plate-dev help` into the terminal of your choice.

The command itself is a CoffeeScript bootstrap that routes to `Taskfile` (go-task) with predefined environment variables and namespace organization. By choosing Taskfile as the task runner, PLATE takes advantage of intelligent dependency management, cross-platform consistency, and advanced build conditions that only rebuild when source files change.

## Environment Variables

As all framework have environment variables, PLATE is no different. Those variables used to help manage processes and empower the codebase with additional information.

| Name              | Scope     | Description                                                                        |
| ----------------- | --------- | ---------------------------------------------------------------------------------- |
| `PLATE_PKG_PATH`  | Bootstrap | Path to PLATE package installation; DEFAULT: `./`, USED AS `@/`                    |
| `PLATE_PRJ_PATH`  | Bootstrap | Path to current project (switches with `pkg` command); DEFAULT: `./`, USED AS `~/` |
| `PLATE_ENV`       | Runtime   | Environment mode (development, production, etc.); DEFAULT: `development`           |
| `PLATE_BIN_PATH`  | Computed  | Path to node_modules/.bin (via Taskfile templating)                                |
| `PLATE_CONF_PATH` | Computed  | Path to configuration files                                                        |
| `PLATE_LOG_PATH`  | Computed  | Path to log files                                                                  |
| `PLATE_TMP_PATH`  | Computed  | Path to temporary files                                                            |

**Bootstrap variables** are set by the CoffeeScript entry point, while **computed variables** are templated in the main Taskfile and inherited by all namespace files.

## Configurations

The center of opinions for framework and it's dependencies configuration files. Run the following command to take a look at the list of configuration files the framework use to shape it's codebase.

```shell
ls -la ./configs/**/*
```

## Library

### Imports

#### Paths

| Prefix | Description              |
| ------ | ------------------------ |
| `~/`   | Package-relative imports |
| `@/`   | Project-relative imports |

#### Formats

| Extension    | Description                         |
| ------------ | ----------------------------------- |
| `coffee`     | CoffeeScript files with compilation |
| `yml`,`yaml` | YAML files with transformation      |

#### Globs (IDEA)

#### Attributes (WIP)

### Patterns

Are the core structures upon PLATE's functionality and behavior extended from.

| Pattern    | Description                    |
| ---------- | ------------------------------ |
| Prototypes |                                |
| Hooks      |                                |
| Components |                                |
| Events     |                                |
| Stores     | local, session, cookie, memory |

#### Prototypes

##### Natives (WIP)

| Native       | Status | Description |
| ------------ | ------ | ----------- |
| Objects      | WIP    |             |
| Arrays       | WIP    |             |
| Strings      | WIP    |             |
| Functions    | IDEA   |             |
| Regexp       | IDEA   |             |
| Numbers      | IDEA   |             |
| HTMLElements | IDEA   |             |

##### Methods (WIP)

| Methods           | Description |
| ----------------- | ----------- |
| Is                |             |
| To                |             |
| Naming Conversion |             |

#### Hooks (IDEA)

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

## Testing

Our main believe is in testing our code in a behavioral driven development where everyone can think of a way the code should act and write a pseudo code example of it. Then write the first iteration of the internal behavior of code block, see it works on a happy path. Now write an essay about that piece of code with usage examples testing various ways of using and not using the piece of code that was only in our imagination before. Cool.

## Dependencies

As an opinionated framework, it's built upon unique set of tech tools and libraries, some of which are self-built from previous projects. Let's go over the list:

| Name         | Job                 | Reason                                                                                                     |
| ------------ | ------------------- | ---------------------------------------------------------------------------------------------------------- |
| Node.js      | Runtime environment | JavaScript runtime of use, no special reason.                                                              |
| PNPM         | Package Manager     | Simply because it's the fastest of them 3.                                                                 |
| Taskfile     | Task Runner         | Advanced task runner with intelligent rebuilds, cross-platform support, and dependency management via YAML |
| CoffeeScript | Language            | No the most efficient JavaScript compiled language, yet the easiest and pleasant to read and write.        |
| Cucumber.js  | Tests               | `Gherkin` language is the most readable and reusable way to write use-cases and test them.                 |
| ESBuild      | Bundle              | Current bundler of choice, optimize the CoffeeScript compiled code.                                        |
| Prettier     | Code Quality        | Set of tools configured to automate codebase coherence structure.                                          |
| YAML         | Configuration       | Default config files format.                                                                               |

The above dependencies aren't set in stone and might be replaced by a better suited tool for the job along the way. Feel free to suggest a better tool for the job with valid points of why.

## What's on the Plate Right Now?

See [ROADMAP.md](ROADMAP.md) for current and future plans.
