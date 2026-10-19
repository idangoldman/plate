# Migration to Native Node Test Runner

Replace Cucumber BDD with Node.js built-in `node:test` runner.

## Context
Tests were previously written in Cucumber BDD with Gherkin `.feature` files. While functional, Cucumber introduced significant indirection:
- Step definitions shared mutable global `PlateWorld` state.
- Regex step matching added maintenance friction.
- Only the global prototype tier was tested; pure functions and wrapper classes had zero isolated unit tests.
- Required heavy external runtime dependencies (`@cucumber/cucumber`, `@cucumber/pretty-formatter`).

## Decision
Migrate the test suite entirely to Node.js's native `node:test` + `node:assert` (or `chai` assertions) running via `tsx --test`:
- Zero external test runner dependencies.
- Blazing-fast execution with native TypeScript and ESM support.
- Full support for DOM and event testing using existing `jsdom` helpers.
- Comprehensive test coverage for all tiers: pure functions, wrapper classes, stores, DOM adapters, and opt-in globals.
