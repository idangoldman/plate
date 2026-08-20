import Events, { type EventCallback } from "~/library/patterns/events";
import { STORE_EVENTS_LIST } from "~/library/stores/constants";
import { type StoreInterface } from "~/library/stores/interface";

/**
 * A store *has* an emitter; it is not one.
 *
 * `BaseStore extends Events` collided on two method names: `Events.has(eventNames)`
 * versus `Store.has(key)`, and `Events.clear()` versus `Store.clear()`. Both
 * collisions were being silenced with `@ts-ignore` in this file and again in
 * every subclass. Composition removes the collision instead of hiding it, and
 * the emitter API stays available through delegation.
 */
export default abstract class BaseStore implements StoreInterface {
  protected prefix: string;
  protected separator: string;
  protected readonly events: Events;

  constructor(prefix: string = "", separator: string = "") {
    this.prefix = prefix;
    this.separator = separator;
    this.events = new Events(STORE_EVENTS_LIST);
  }

  getPrefix(): string {
    return this.prefix;
  }

  getSeparator(): string {
    return this.separator;
  }

  getFullKey(key: string = ""): string {
    return `${this.prefix}${this.separator}${key}`;
  }

  // --- Emitter delegation -------------------------------------------------

  on(eventNames: string, callback: EventCallback, once: boolean = false): this {
    this.events.on(eventNames, callback, once);
    return this;
  }

  once(eventNames: string, callback: EventCallback): this {
    this.events.once(eventNames, callback);
    return this;
  }

  off(eventNames?: string, callback?: EventCallback): this {
    this.events.off(eventNames, callback);
    return this;
  }

  hasListeners(eventNames: string): boolean {
    return Boolean(this.events.has(eventNames));
  }

  clearListeners(): this {
    this.events.clear();
    return this;
  }

  protected emit(eventNames: string, data?: any[]): this {
    this.events.emit(eventNames, data);
    return this;
  }

  // --- Store behaviour ----------------------------------------------------

  static getDefaultEmptyValue(value: unknown): unknown {
    switch (typeof value) {
      case "string":
        return "";
      case "number":
        return 0;
      case "boolean":
        return false;
      case "object":
        if (value === null) return null;
        if (Array.isArray(value)) return [];
        return {};
      default:
        return null;
    }
  }

  empty(key: string): void | Promise<void> {
    const oldValueOrPromise = this.get<any>(key);

    const handleNewValue = (oldValue: unknown) => {
      const newValue = BaseStore.getDefaultEmptyValue(oldValue);
      if (newValue === undefined) return;

      const setResult = this.set(key, newValue);

      if (setResult instanceof Promise) {
        return setResult.then(() => {
          this.emit("empty", [key, newValue]);
        });
      }

      this.emit("empty", [key, newValue]);
    };

    if (oldValueOrPromise instanceof Promise) {
      return oldValueOrPromise.then(handleNewValue);
    }

    handleNewValue(oldValueOrPromise);
  }

  abstract get<T>(key?: string): T | null | Promise<T | null>;
  abstract set<T>(
    key: string | undefined,
    value: T,
    options?: any,
  ): void | Promise<void>;
  abstract has(key?: string): boolean | Promise<boolean>;
  abstract remove(key?: string): void | Promise<void>;
  abstract clear(): this | Promise<this>;
}
