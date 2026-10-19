# PLATE 0.11.0 — migration fixes

Drop these files over the repo root, preserving paths.

## 1. Delete one file

```bash
git rm library/global.d.ts
```

Its contents moved into `library/globals.ts`. `tsc` does not copy input `.d.ts`
files to `outDir`, so the old file never reached `dist` and published consumers
got zero prototype typings.

## 2. Files in this bundle

| File | Fix |
|---|---|
| `package.json` | `dist` now published; `"."` export key added; illegal `**` wildcard and dead `src/` path removed; ESM; `sideEffects` list; `engines`; `ts-node` dropped |
| `tsconfig.json` | ESM emit, `sourceMap`, `declarationMap`, `isolatedModules` |
| `library/globals.ts` | **new** — opt-in prototype extension, runtime + types in one module |
| `library/index.ts` | no `as any`; no implicit global augmentation; adds `removeAll` |
| `library/utilities/prototypes.ts` | enumerable-backup bug fixed; typed to remove call-site casts |
| `library/arrays/index.ts` | consistent imports, named prototype imports |
| `library/strings/index.ts` | same |
| `library/objects/index.ts` | same, `as any` removed |
| `library/arrays/apply.ts` | consistent import style |
| `library/arrays/functions/flatten.ts` | no longer calls `unique()` |
| `library/patterns/events.ts` | `EventCallback` exported; `apply(null, data)` replaced with spread |
| `library/events/dom.ts` | own typed listener map; four `as any` removed |
| `library/stores/base.ts` | composes `Events` instead of extending it; two `@ts-ignore` removed |
| `library/stores/local.ts` | two `@ts-ignore` removed |
| `tests/support/hooks.ts` | imports `library/globals` instead of calling `applyAll()` |
| `tests/features/prototypes/arrays.feature` | flatten expectations updated |

## 3. Breaking changes

- **`flatten()` no longer de-duplicates.** `[1,[2,2]].flatten()` is now
  `[1,2,2]`. Chain `.unique()` where the old behaviour is wanted.
- **Prototype methods are opt-in.** `import "@idangoldman/plate"` no longer
  declares `Array.prototype.first` in the type system. Add
  `import "@idangoldman/plate/globals";` once, at the app entry point.
- **`BaseStore` is no longer an `Events` subclass.** `store.on/off/once` still
  work by delegation. `store.emit` is now `protected`. The emitter-side
  `has`/`clear` are now `hasListeners()` / `clearListeners()`; `store.has(key)`
  and `store.clear()` are unambiguously the store methods.
- **Package is ESM.** `"type": "module"` is set.

## 4. Verified

```
tsc --noEmit                          clean
tsc && tsc-alias --resolve-full-paths clean, dist/library/globals.d.ts emitted
node dist smoke test:
  for...in over {a:1}                 ["a"]        (was ["a","___isEmpty",...])
  [1,[2,2],[3,[3]]].flatten()         [1,2,2,3,3]
  removeAll() restores natives        true
```

## 5. Not verified — check on your machine

Four files were not in the material I reviewed and may need the same treatment:

1. `library/stores/{cookie,memory,session,indexeddb}.ts` — if any calls
   `super.clear()`, references `this.listeners`, or carries its own
   `@ts-ignore` on `has`/`clear`, adjust for the composition change.
2. `library/arrays/class.ts` — if `Arrays` relied on `flatten()` de-duplicating,
   update it.
3. `library/dom/index.ts` — the `"./*"` export subpath maps
   `@idangoldman/plate/dom` to `dist/library/dom/index.js`. Create that barrel
   if it does not exist.
4. `configs/cucumber.yml` — `"type": "module"` may require ESM-style paths.

## 6. Then

```bash
pnpm build
pnpm pack --dry-run   # confirm dist/ is listed
pnpm test
```
