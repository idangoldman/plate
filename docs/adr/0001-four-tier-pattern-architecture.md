# Four-Tier Pattern Architecture

Plate's data-structure utilities follow a strict four-tier pattern: pure functions, subclass wrappers, module index, and opt-in globals.

## Context
Previously, Plate only provided prototype extensions imported implicitly, causing unexpected `for...in` enumeration leaks and global prototype pollution. When migrating to TypeScript, we designed four distinct consumption tiers to accommodate different architectural preferences:
1. **Pure Functions** (`library/*/functions/*`): Tree-shakeable, stateless functions.
2. **Subclass Wrappers** (`library/*/class.ts`): Subclasses of native constructors (`class Arrays extends Array {}`) with utility methods attached to their own prototype (`new Arrays(1,2).first()`), leaving native built-ins untouched.
3. **Module Barrels** (`library/*/index.ts`): Cohesive exports combining functions, wrapper classes, and individual `apply`/`remove` hooks.
4. **Opt-in Globals** (`library/globals.ts`): Explicit ambient typings and prototype extensions (`import "@idangoldman/plate/globals"`).

## Decision
We rejected static namespace classes (`Arrays.first(...)`) and dual static+instance APIs to eliminate redundancy with Tier 1 pure functions. `applyFunctions` directly binds methods to the wrapper's prototype (`applyFunctions(functions, Arrays.prototype)`), guaranteeing instances have methods attached without global pollution.
