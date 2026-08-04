import Events from '../patterns/events';
import { STORE_EVENTS_LIST } from './constants';
import { StoreInterface } from './interface';
import Storage from './local'; // To reuse getDefaultEmptyValue

export default class MemoryStorage extends Events implements StoreInterface {
  private prefix: string;
  private separator: string;
  private store: Map<string, any>;

  constructor(prefix: string = '', separator: string = '') {
    super(STORE_EVENTS_LIST);
    this.prefix = prefix;
    this.separator = separator;
    this.store = new Map();
  }

  getPrefix(): string {
    return this.prefix;
  }

  getSeparator(): string {
    return this.separator;
  }

  getFullKey(key: string = ''): string {
    return `${this.prefix}${this.separator}${key}`;
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

  clear(): this {
    this.store.clear();
    this.emit('clear');
    return this;
  }

  empty(key: string): void {
    const oldValue = this.get<any>(key);
    let newValue = Storage.getDefaultEmptyValue(oldValue);

    if (newValue !== undefined) {
      this.set(key, newValue);
      this.emit('empty', [key, newValue]);
    }
  }
}
