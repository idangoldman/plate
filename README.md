# PLATE

## TODOs

### Hooks upgrades

- [ ] Implement `Hooks` pattern into `Prototypes` pattern.
- [ ] Implement `before`, `around`, and `after` wrappers of `Hooks.addHook` in `Functions` prototype.

### MissingMethod pattern upgrade

- [ ] Implement `MissingMethod` (`respond_to_missing` and `method_is_missing`) pattern into`Prototypes` pattern.
- [ ] Implement `getter` and `setter` methods in `Objects` prototype to use `MissingMethod` pattern routing prototype methods to use static methods of the same name.
- [ ] Replace the use of `export methods = Objects.methods()` in prototypes files with `Objects::methodName` pattern.
- [ ] Rewrite `Objects::methods` method to list all methods names in an array of an object.

### Prototypes methods enhancements

- [ ] Move `toCase` and `toCaseKeys` into `prototypes/methods/naming-casing.coffee`. Extending `Object` with `strings` and `keys` methods combined.
- [ ] Implement `Objects.inspect` printing the `object` in a human readable format.
- [ ] Implement `Objects.merge` method with deep merge.
- [ ] Implement `Objects.methods` method to list all methods of an object.
- [ ] Transform `lib/helpers/safe.coffee` file functions into `Functions` prototype as a `safe`, `safeReturn` `safeOrFailure` methods, might be even used with `Hooks.around` method.

### Infrastructure upgrades

- [ ] Implement `glob` transformer and register as node.js loader in `lib/transformers/glob.coffee`.
- [ ] Implement `main` as an `importAttributes` of imported files, to be used like main in Python.
- [ ] Create defaults loader class for prototypes and methods loading.
- [ ] Implement `plate help` using the example in `bin/help.fish`.
- [ ] Restructure `lib/` folder:
  - [ ] Migrate some of the functionality out of the `lib/helpers` folder and into `Prototypes` or `Transformers`, the rest into `lib/utils`.
  - [ ] Rename `lib/plugins` to `lib/esbuild`
  - [ ] Create a folder for node specific code `lib/node` and move all related folders and files of code into it.

## Testing

- [ ] Test `yaml` file loading and using `Objects.keyCase` method.