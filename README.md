# PLATE

## TODOs

- [ ] Implement `before`, `around`, and `after` wrappers of `Hooks.addHook` in `Functions` prototype.
- [ ] Implement `glob` transformer and register as node.js loader in `lib/transformers/glob.coffee`.
- [ ] Implement `Hooks` pattern into `Prototypes` pattern.
- [ ] Implement `MissingMethod` (`respond_to_missing` and `method_is_missing`) pattern into`Prototypes` pattern.
- [ ] Implement `Objects.inspect` printing the `object` in a human readable format.
- [ ] Implement `Objects.merge` method with deep merge.
- [ ] Implement `Objects.methods` method to list all methods of an object.
- [ ] Implement `plate help` using the example in `bin/help.fish`.
- [ ] Remove the use of `export methods = Functions.methods()` in prototypes.
- [ ] Transform `lib/helpers/safe.coffee` file functions into `Functions` prototype as a `safe`, `safeReturn` `safeOrFailure` methods, might be even used with `Hooks.around` method.
- [ ] Move `toCase` and `toCaseKeys` into `prototypes/methods/naming-casing.coffee`. Extending `Object` with `strings` and `keys` methods combined.

### Testing

How to test this?

```coffeescript
if process.mainModule is require.main
  Prototypes.initilize()
```
