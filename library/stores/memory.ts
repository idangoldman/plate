import BaseStore from './base';

export default class MemoryStore extends BaseStore {
  private store: Map<string, any>;

  constructor(prefix: string = '', separator: string = '') {
    super(prefix, separator);
    this.store = new Map();
  }

  get<T>(key: string = ''): T | null {
    const fullKey = this.getFullKey(key);
    if (!this.store.has(fullKey)) return null;
    const value = this.store.get(fullKey) as T;
    this.emit('get', [key, value]);
    return value;
  }

  set<T>(key: string = '', value: T): void {
    const fullKey = this.getFullKey(key);
    this.store.set(fullKey, value);
    this.emit('set', [key, value]);
  }

  // @ts-ignore
  has(key: string = ''): boolean {
    const fullKey = this.getFullKey(key);
    const hasValue = this.store.has(fullKey);
    this.emit('has', [key, hasValue]);
    return hasValue;
  }

  remove(key: string = ''): void {
    const fullKey = this.getFullKey(key);
    this.store.delete(fullKey);
    this.emit('remove', [key, null]);
  }

  // @ts-ignore
  clear(): this {
    this.store.clear();
    this.emit('clear');
    return this;
  }
}
