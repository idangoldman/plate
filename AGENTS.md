# 🤖 Agent Instructions for @idangoldman/plate

**Welcome!** This document outlines the mandatory rules, style guidelines, and technical setup for AI agents working in this repository.

**Adherence to this file is mandatory** for all codebase modifications.

## 🏗️ Architecture & Code Style

- **TypeScript Only:** This project is entirely written in TypeScript (migrated from CoffeeScript). **Do not use or introduce CoffeeScript.**
- **Module System:** The project compiles to **CommonJS**.
- **Imports:** We use standard extensionless imports and utilize `~/` for absolute path aliases.
- **Design Pattern:**
  - The project extends native prototypes (`Array`, `Object`, `String`).
  - **Keep pure functions strictly separate from mutation logic.**
  - Global typings are used alongside an `applyAll()` hook.

## 🧪 Testing Guidelines

- **BDD with Cucumber:** Tests are written in Behavior-Driven Development (BDD) style using **Cucumber**.
- **Test Location:** All tests are located in `.feature` files within the `tests/features` directory.
- **Execution Runtime:** Tests run TypeScript using `tsx`.
  - _Configuration:_ Located at `configs/cucumber.yml`.
  - _Under the hood command:_ `NODE_OPTIONS="--import tsx" cucumber-js`

## 🛠️ Build & Package Management

- **Package Manager:** We use **pnpm**.
  - _Requirement:_ Node.js >= as specified in `.node-version`.
- **Build Tools:** The library is built using `tsc && tsc-alias`.
- **Task Runner:** We use `go-task` (Taskfile). Configurations are located in the `tasks/` directory (e.g., `Taskfile.build.yml`, `Taskfile.tests.yml`).

## 🛑 Mandatory Pre-Commit Checks

Before you finalize your work or conclude any task, **you MUST successfully run the following commands and ensure they pass:**

1.  **Run Tests:** Check for regressions or test failures.
    ```bash
    task tests:run
    ```
2.  **Run Build:** Ensure the project compiles successfully.
    ```bash
    task build:run
    ```

**If any of these commands fail, you must fix the issues before proceeding.**
