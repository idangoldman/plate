import Events from '../patterns/events';
import { STORE_EVENTS_LIST } from './constants';
import { StoreInterface } from './interface';

export default abstract class BaseStore extends Events implements StoreInterface {
  protected prefix: string;
  protected separator: string;

  constructor(prefix: string = '', separator: string = '') {
    super(STORE_EVENTS_LIST);
    this.prefix = prefix;
    this.separator = separator;
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

  empty(key: string): void | Promise<void> {
    const oldValueOrPromise = this.get<any>(key);

    const handleNewValue = (oldValue: any) => {
      const newValue = BaseStore.getDefaultEmptyValue(oldValue);
      if (newValue !== undefined) {
        const setResult = this.set(key, newValue);
        if (setResult instanceof Promise) {
          return setResult.then(() => {
            this.emit('empty', [key, newValue]);
          });
        } else {
          this.emit('empty', [key, newValue]);
        }
      }
    };

    if (oldValueOrPromise instanceof Promise) {
      return oldValueOrPromise.then(handleNewValue);
    } else {
      handleNewValue(oldValueOrPromise);
    }
  }

  // Abstract methods that must be implemented by subclasses
  abstract get<T>(key?: string): T | null | Promise<T | null>;
  abstract set<T>(key: string | undefined, value: T, options?: any): void | Promise<void>;

  // @ts-ignore
  abstract has(key?: string): boolean | Promise<boolean>;
  abstract remove(key?: string): void | Promise<void>;

  // @ts-ignore
  abstract clear(): this | Promise<this>;
}
