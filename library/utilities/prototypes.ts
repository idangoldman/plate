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
    if (isNativeFunction(prototype[name])) {
      prototype[`___${name}`] = prototype[name];
    }

    prototype[name] = function(this: any, ...args: any[]) {
      return method(this, ...args);
    };
  }
}

export function removeFunctions(functionNames: string[], prototypeName: string): void {
  const prototype = (globalThis as any)[prototypeName]?.prototype;
  if (!prototype) return;

  for (const name of functionNames) {
    if (prototype[`___${name}`]) {
      prototype[name] = prototype[`___${name}`];
      delete prototype[`___${name}`];
    } else {
      delete prototype[name];
    }
  }
}
