export interface StoreInterface {
  getPrefix(): string;
  getSeparator(): string;
  getFullKey(key?: string): string;

  get<T>(key?: string): T | null | Promise<T | null>;
  set<T>(key: string | undefined, value: T, options?: any): void | Promise<void>;
  has(key?: string): boolean | Promise<boolean>;
  remove(key?: string): void | Promise<void>;
  clear(): this | Promise<this>;
  empty?(key: string): void | Promise<void>;
}
