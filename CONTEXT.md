# PLATE

A lightweight utility foundation for JavaScript and TypeScript providing four modular consumption patterns for data structures, storage adapters, and DOM interaction.

## Language

**Pure Function**:
A stateless, side-effect-free function operating on primitive data structures, located under `library/*/functions/`.
_Avoid_: Static method, utility class.

**Wrapper Class**:
An instance-based subclass (`Arrays`, `Objects`, `Strings`) extending native JavaScript constructors, exposing utility methods on its own prototype without altering global runtime prototypes.
_Avoid_: Static helper, static namespace, utility container.

**Opt-in Globals**:
Ambient TypeScript interface augmentations and runtime prototype bindings activated strictly via explicit import (`import "@idangoldman/plate/globals"`).
_Avoid_: Automatic monkey patching, implicit global pollution.

**Store**:
A persistent or in-memory key-value adapter implementing `StoreInterface`, providing asynchronous or synchronous storage with delegated event emission.
_Avoid_: State container, cache, database model.

**DOM Adapter**:
A wrapper (`Element`, `DOMEvents`) encapsulating native browser DOM nodes and event listeners with safe execution fallbacks for non-browser environments.
_Avoid_: Virtual DOM, component framework.
