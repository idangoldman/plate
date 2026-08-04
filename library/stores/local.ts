import BaseStore from './base';

export default class LocalStore extends BaseStore {
  private store: globalThis.Storage;

  constructor(type: 'local' | 'session' = 'local', prefix: string = '', separator: string = '') {
    super(prefix, separator);

    if (type === 'local') {
      this.store = window.localStorage;
    } else if (type === 'session') {
      this.store = window.sessionStorage;
    } else {
      throw new Error(`Unsupported storage type "${type}"`);
    }
  }

  get<T>(key: string = ''): T | null {
    try {
      const fullKey = this.getFullKey(key);
      const item = this.store.getItem(fullKey);
      if (item === null) return null;
      const value = JSON.parse(item) as T;
      this.emit('get', [key, value]);
      return value;
    } catch (error: any) {
      console.error(`Error getting key "${key}": ${error.message}`);
      return null;
    }
  }

  set<T>(key: string = '', value: T): void {
    try {
      const fullKey = this.getFullKey(key);
      this.store.setItem(fullKey, JSON.stringify(value));
      this.emit('set', [key, value]);
    } catch (error: any) {
      console.error(`Error setting key "${key}": ${error.message}`);
      throw error;
    }
  }

  // @ts-ignore
  has(key: string = ''): boolean {
    try {
      const fullKey = this.getFullKey(key);
      const hasValue = this.store.getItem(fullKey) !== null;
      this.emit('has', [key, hasValue]);
      return hasValue;
    } catch (error: any) {
      console.error(`Error checking key "${key}": ${error.message}`);
      return false;
    }
  }

  remove(key: string = ''): void {
    const fullKey = this.getFullKey(key);
    this.store.removeItem(fullKey);
    this.emit('remove', [key, null]);
  }

  // @ts-ignore
  clear(): this {
    this.store.clear();
    this.emit('clear');
    return this;
  }
}
