import Events from '../patterns/events';
import { STORE_EVENTS_LIST } from './constants';

import { StoreInterface } from "./interface";

export default class CookieStore extends Events implements StoreInterface {
  private prefix: string;
  private separator: string;

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

  get<T>(key: string = ''): T | null {
    const fullKey = this.getFullKey(key);
    const nameEQ = fullKey + "=";
    const ca = document.cookie.split(';');
    for (let i = 0; i < ca.length; i++) {
      let c = ca[i];
      while (c.charAt(0) === ' ') c = c.substring(1, c.length);
      if (c.indexOf(nameEQ) === 0) {
        const rawValue = c.substring(nameEQ.length, c.length);
        // Fix bug by using decodeURIComponent instead of split('=')
        try {
          const value = JSON.parse(decodeURIComponent(rawValue)) as T;
          this.emit('get', [key, value]);
          return value;
        } catch (e) {
          try {
             // Fallback for non-json
            const value = decodeURIComponent(rawValue) as unknown as T;
            this.emit('get', [key, value]);
            return value;
          } catch (e) {
            return null;
          }
        }
      }
    }
    return null;
  }

  set<T>(key: string = '', value: T, days?: number): void {
    const fullKey = this.getFullKey(key);
    let expires = "";
    if (days) {
      const date = new Date();
      date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
      expires = "; expires=" + date.toUTCString();
    }

    let stringValue = typeof value === 'string' ? value : JSON.stringify(value);

    document.cookie = fullKey + "=" + encodeURIComponent(stringValue) + expires + "; path=/";
    this.emit('set', [key, value]);
  }

  has(key: string = ''): boolean {
    const hasValue = this.get(key) !== null;
    this.emit('has', [key, hasValue]);
    return hasValue;
  }

  remove(key: string = ''): void {
    this.set(key, "", -1);
    this.emit('remove', [key, null]);
  }

  clear(): this {
    const cookies = document.cookie.split(";");
    for (let i = 0; i < cookies.length; i++) {
      const cookie = cookies[i];
      const eqPos = cookie.indexOf("=");
      const name = eqPos > -1 ? cookie.substr(0, eqPos) : cookie;
      document.cookie = name + "=;expires=Thu, 01 Jan 1970 00:00:00 GMT;path=/";
    }
    this.emit('clear');
    return this;
  }
}
