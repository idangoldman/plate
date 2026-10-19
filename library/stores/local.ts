import BaseStore from "~/library/stores/base";

export default class LocalStore extends BaseStore {
  private store: globalThis.Storage;

  constructor(
    type: "local" | "session" = "local",
    prefix: string = "",
    separator: string = "",
  ) {
    super(prefix, separator);

    if (type === "local") {
      this.store = window.localStorage;
    } else if (type === "session") {
      this.store = window.sessionStorage;
    } else {
      throw new Error(`Unsupported storage type "${type}"`);
    }
  }

  get<T>(key: string = ""): T | null {
    try {
      const item = this.store.getItem(this.getFullKey(key));
      if (item === null) return null;

      const value = JSON.parse(item) as T;
      this.emit("get", [key, value]);
      return value;
    } catch (error) {
      console.error(`Error getting key "${key}": ${(error as Error).message}`);
      return null;
    }
  }

  set<T>(key: string = "", value: T): void {
    try {
      this.store.setItem(this.getFullKey(key), JSON.stringify(value));
      this.emit("set", [key, value]);
    } catch (error) {
      console.error(`Error setting key "${key}": ${(error as Error).message}`);
      throw error;
    }
  }

  has(key: string = ""): boolean {
    try {
      const hasValue = this.store.getItem(this.getFullKey(key)) !== null;
      this.emit("has", [key, hasValue]);
      return hasValue;
    } catch (error) {
      console.error(`Error checking key "${key}": ${(error as Error).message}`);
      return false;
    }
  }

  remove(key: string = ""): void {
    this.store.removeItem(this.getFullKey(key));
    this.emit("remove", [key, null]);
  }

  clear(): this {
    this.store.clear();
    this.emit("clear");
    return this;
  }
}
