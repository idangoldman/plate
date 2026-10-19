/**
 * Opt-in prototype extension.
 *
 *   import "@idangoldman/plate/globals";
 *
 * Importing this module does two things at once, on purpose:
 *   1. Applies every function to its native prototype at runtime.
 *   2. Declares the matching ambient types.
 *
 * Both live here so the types can never claim a method the runtime has not
 * installed. Previously the declarations sat in `library/global.d.ts`, an input
 * declaration file — `tsc` does not copy those to `outDir`, so published
 * consumers got no prototype typings at all, and every consumer was told these
 * methods existed whether or not they ever called `applyAll()`.
 */
import { applyAll } from "~/library/index";

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

applyAll();
