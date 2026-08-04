import Events from '../patterns/events';
import { STORE_EVENTS_LIST } from './constants';

import { StoreInterface } from "./interface";

export default class Storage extends Events implements StoreInterface {
  private prefix: string;
  private separator: string;
  private store: globalThis.Storage;

  constructor(type: 'local' | 'session' = 'local', prefix: string = '', separator: string = '') {
    super(STORE_EVENTS_LIST);

    this.prefix = prefix;
    this.separator = separator;

    if (type === 'local') {
      this.store = window.localStorage;
    } else if (type === 'session') {
      this.store = window.sessionStorage;
    } else {
      throw new Error(`Unsupported storage type "${type}"`);
    }
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

  clear(): this {
    this.store.clear();
    this.emit('clear');
    return this;
  }

  empty(key: string): void {
    const oldValue = this.get<any>(key);
    let newValue = (this.constructor as typeof Storage).getDefaultEmptyValue(oldValue);

    if (newValue !== undefined) {
      this.set(key, newValue);
      this.emit('empty', [key, newValue]);
    }
  }

  static getDefaultEmptyValue(value: any): any {
    switch (typeof value) {
      case 'string':
        return '';
      case 'number':
        return 0;
      case 'boolean':
        return false;
      case 'object':
        if (value === null) return null;
        if (Array.isArray(value)) return [];
        return {};
      default:
        return null;
    }
  }
}
