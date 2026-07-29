export {};

declare global {
  interface Array<T> {
    excludes(item: T): boolean;
    first(): T | undefined;
    flatten(): T[];
    isEmpty(): boolean;
    last(): T | undefined;
    unique(): T[];
  }

  interface String {
    capitalize(): string;
    isEmpty(): boolean;
    toCamelCase(): string;
    toCase(): string[];
    toConstantCase(): string;
    toDotCase(): string;
    toKebabCase(): string;
    toPascalCase(): string;
    toSnakeCase(): string;
    toTitleCase(): string;
  }

  interface Object {
    isArray(): boolean;
    isEmpty(): boolean;
    isObject(): boolean;
    isString(): boolean;
    keys(): string[];
    toArray(separator?: string | RegExp): any[];
    toBoolean(): boolean;
    toCaseKeys(caseType?: string): Record<string, any>;
    toObject(): Record<string, any>;
    values(): any[];
  }
}
