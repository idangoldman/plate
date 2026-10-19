# Composition Over Inheritance for Events

Event-capable modules (`BaseStore`, `DOMEvents`) compose or adapt event mechanisms rather than subclassing the base `Events` emitter.

## Context
In early CoffeeScript iterations, `BaseStore` and `DOMEvents` extended `Events`. This created severe Liskov Substitution violations:
- `BaseStore.has(key)` and `BaseStore.clear()` collided with `Events.has(eventName)` and `Events.clear()`, necessitating `@ts-ignore` hacks across every store subclass.
- `DOMEvents` threw an error in `emit()` (`"DOM events cannot be emitted manually"`), breaking the emitter contract.

## Decision
We decouple both classes from `Events` inheritance:
1. `BaseStore` holds an internal `Events` instance and delegates `on`/`off`/`once` while isolating `store.has(key)` and `store.clear()` without collisions.
2. `DOMEvents` implements a dedicated DOM listener interface (`on`, `off`, `once`, `clear`) binding directly to `HTMLElement.addEventListener` without inheriting `emit()` or emitter state.
