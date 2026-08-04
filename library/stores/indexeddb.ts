import Events from '../patterns/events';
import { STORE_EVENTS_LIST } from './constants';
import { StoreInterface } from './interface';
import Storage from './local';

export default class IndexedDBStorage extends Events implements StoreInterface {
  private prefix: string;
  private separator: string;
  private dbName: string;
  private storeName: string;
  private dbPromise: Promise<IDBDatabase>;

  constructor(dbName: string = 'app-db', storeName: string = 'keyval', prefix: string = '', separator: string = '') {
    super(STORE_EVENTS_LIST);
    this.prefix = prefix;
    this.separator = separator;
    this.dbName = dbName;
    this.storeName = storeName;

    this.dbPromise = new Promise((resolve, reject) => {
      // In SSR or non-browser environments, indexedDB might not exist.
      if (typeof globalThis.indexedDB === 'undefined') {
        return reject(new Error('IndexedDB is not available in this environment'));
      }

      const request = globalThis.indexedDB.open(this.dbName);

      request.onupgradeneeded = (event: IDBVersionChangeEvent) => {
        const db = (event.target as IDBOpenDBRequest).result;
        if (!db.objectStoreNames.contains(this.storeName)) {
          db.createObjectStore(this.storeName);
        }
      };

      request.onsuccess = (event: Event) => {
        resolve((event.target as IDBOpenDBRequest).result);
      };

      request.onerror = (event: Event) => {
        reject((event.target as IDBOpenDBRequest).error);
      };
    });
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

  async get<T>(key: string = ''): Promise<T | null> {
    try {
      const db = await this.dbPromise;
      return new Promise((resolve, reject) => {
        const fullKey = this.getFullKey(key);
        const transaction = db.transaction(this.storeName, 'readonly');
        const store = transaction.objectStore(this.storeName);
        const request = store.get(fullKey);

        request.onsuccess = () => {
          const value = request.result !== undefined ? request.result : null;
          this.emit('get', [key, value]);
          resolve(value as T);
        };

        request.onerror = () => reject(request.error);
      });
    } catch (e) {
      console.error(e);
      return null;
    }
  }

  async set<T>(key: string = '', value: T): Promise<void> {
    const db = await this.dbPromise;
    return new Promise((resolve, reject) => {
      const fullKey = this.getFullKey(key);
      const transaction = db.transaction(this.storeName, 'readwrite');
      const store = transaction.objectStore(this.storeName);
      const request = store.put(value, fullKey);

      request.onsuccess = () => {
        this.emit('set', [key, value]);
        resolve();
      };

      request.onerror = () => reject(request.error);
    });
  }

  // @ts-ignore
  async has(key: string = ''): Promise<boolean> {
    try {
      const db = await this.dbPromise;
      return new Promise((resolve, reject) => {
        const fullKey = this.getFullKey(key);
        const transaction = db.transaction(this.storeName, 'readonly');
        const store = transaction.objectStore(this.storeName);

        // Use count() to check existence without fetching data
        const request = store.count(fullKey);

        request.onsuccess = () => {
          const exists = request.result > 0;
          this.emit('has', [key, exists]);
          resolve(exists);
        };

        request.onerror = () => reject(request.error);
      });
    } catch(e) {
      return false;
    }
  }

  async remove(key: string = ''): Promise<void> {
    const db = await this.dbPromise;
    return new Promise((resolve, reject) => {
      const fullKey = this.getFullKey(key);
      const transaction = db.transaction(this.storeName, 'readwrite');
      const store = transaction.objectStore(this.storeName);
      const request = store.delete(fullKey);

      request.onsuccess = () => {
        this.emit('remove', [key, null]);
        resolve();
      };

      request.onerror = () => reject(request.error);
    });
  }

  // @ts-ignore
  async clear(): Promise<this> {
    const db = await this.dbPromise;
    return new Promise((resolve, reject) => {
      const transaction = db.transaction(this.storeName, 'readwrite');
      const store = transaction.objectStore(this.storeName);
      const request = store.clear();

      request.onsuccess = () => {
        this.emit('clear');
        resolve(this);
      };

      request.onerror = () => reject(request.error);
    });
  }

  async empty(key: string): Promise<void> {
    const oldValue = await this.get<any>(key);
    let newValue = Storage.getDefaultEmptyValue(oldValue);

    if (newValue !== undefined) {
      await this.set(key, newValue);
      this.emit('empty', [key, newValue]);
    }
  }
}
