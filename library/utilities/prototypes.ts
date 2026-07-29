export default function isNativeFunction(method: any): boolean {
  try {
    return Function.prototype.toString.call(method).includes("[native code]");
  } catch (error) {
    return false;
  }
}

export function applyFunctions(functions: Record<string, Function>, prototypeName: string): void {
  const prototype = (globalThis as any)[prototypeName]?.prototype;
  if (!prototype) return;

  for (const [name, method] of Object.entries(functions)) {
    if (typeof method !== 'function') continue; // important to skip default exports or other non-functions

    if (isNativeFunction(prototype[name])) {
      prototype[`___${name}`] = prototype[name];
    }

    Object.defineProperty(prototype, name, {
      value: function(this: any, ...args: any[]) {
        return method(this, ...args);
      },
      enumerable: false, // critical for Object.prototype
      configurable: true,
      writable: true
    });
  }
}

export function removeFunctions(functionNames: string[], prototypeName: string): void {
  const prototype = (globalThis as any)[prototypeName]?.prototype;
  if (!prototype) return;

  for (const name of functionNames) {
    if (prototype[`___${name}`]) {
      Object.defineProperty(prototype, name, {
        value: prototype[`___${name}`],
        enumerable: false,
        configurable: true,
        writable: true
      });
      delete prototype[`___${name}`];
    } else {
      delete prototype[name];
    }
  }
}
