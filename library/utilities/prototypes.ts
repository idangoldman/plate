type AnyFunction = (...args: any[]) => any;

/**
 * Original native implementations, keyed by prototype name then method name.
 *
 * Kept in module scope on purpose. The previous implementation stashed them as
 * `prototype["___" + name]` via plain assignment, which creates an *enumerable*
 * own property. On `Object.prototype` that surfaces in every `for...in` loop in
 * every consuming application.
 */
const originals = new Map<string, Map<string, AnyFunction>>();

function getPrototype(prototypeName: string): Record<string, any> | undefined {
  return (globalThis as Record<string, any>)[prototypeName]?.prototype;
}

function getBackups(prototypeName: string): Map<string, AnyFunction> {
  let backups = originals.get(prototypeName);

  if (!backups) {
    backups = new Map<string, AnyFunction>();
    originals.set(prototypeName, backups);
  }

  return backups;
}

export function isNativeFunction(method: unknown): boolean {
  try {
    return Function.prototype.toString.call(method).includes("[native code]");
  } catch {
    return false;
  }
}

export default isNativeFunction;

/**
 * Extends a native prototype with `functions`, forwarding the receiver as the
 * first argument so the pure functions stay pure.
 *
 * Accepts `Record<string, unknown>` so an `import * as functions` namespace
 * object passes without a cast at the call site.
 */
export function applyFunctions(
  functions: Record<string, unknown>,
  prototypeName: string,
): void {
  const prototype = getPrototype(prototypeName);
  if (!prototype) return;

  const backups = getBackups(prototypeName);

  for (const [name, method] of Object.entries(functions)) {
    if (typeof method !== "function") continue;

    const existing = prototype[name];

    if (isNativeFunction(existing) && !backups.has(name)) {
      backups.set(name, existing as AnyFunction);
    }

    Object.defineProperty(prototype, name, {
      value: function (this: unknown, ...args: unknown[]) {
        return (method as AnyFunction)(this, ...args);
      },
      enumerable: false,
      configurable: true,
      writable: true,
    });
  }
}

/** Reverses `applyFunctions`, restoring any native method that was shadowed. */
export function removeFunctions(
  functionNames: string[],
  prototypeName: string,
): void {
  const prototype = getPrototype(prototypeName);
  if (!prototype) return;

  const backups = getBackups(prototypeName);

  for (const name of functionNames) {
    const original = backups.get(name);

    if (original) {
      Object.defineProperty(prototype, name, {
        value: original,
        enumerable: false,
        configurable: true,
        writable: true,
      });
      backups.delete(name);
    } else {
      delete prototype[name];
    }
  }
}
