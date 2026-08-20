import eventNamesValidation from "~/library/events/helpers/event-names-validation";
import findReverseBranch from "~/library/events/helpers/find-reverse-branch";

export type EventCallback = (...args: any[]) => void;

export default class Events {
  protected EVENTS_LIST: any[];
  public namespace: string;
  protected listeners: Map<string, Set<EventCallback>>;

  constructor(eventsList: any[] | string = [], namespace: string = "") {
    this.EVENTS_LIST = ([] as any[]).concat(eventsList as any);
    this.namespace = namespace;
    this.listeners = new Map();
  }

  on(eventNames: string, callback: EventCallback, once: boolean = false): this {
    const validEventNames = this._validateEventNames(eventNames);

    for (const eventName of validEventNames) {
      this._bind(eventName, callback, once);
    }

    return this;
  }

  off(eventNames?: string, callback?: EventCallback): this {
    if (eventNames) {
      const validEventNames = this._validateEventNames(eventNames);

      for (const eventName of validEventNames) {
        this._unbind(eventName, callback);
      }
    } else {
      this._unbind();
    }

    return this;
  }

  once(eventNames: string, callback: EventCallback): this {
    return this.on(eventNames, callback, true);
  }

  emit(eventNames: string, data?: any[]): this {
    const validEventNames = this._validateEventNames(eventNames);

    const eventsList = validEventNames.flatMap((eventName) =>
      findReverseBranch(eventName, this.EVENTS_LIST),
    );

    for (let storedEvent of eventsList) {
      storedEvent = this._createNamespacedEvent(storedEvent);
      const callbacks = this.listeners.get(storedEvent);

      if (callbacks && callbacks.size > 0) {
        for (const callback of callbacks) {
          if (data) {
            callback(...data);
          } else {
            callback();
          }
        }
      }
    }

    return this;
  }

  has(eventNames: string): boolean | this {
    const validEventNames = this._validateEventNames(eventNames);

    for (const eventName of validEventNames) {
      const storedEvent = this._createNamespacedEvent(eventName);
      const callbacks = this.listeners.get(storedEvent);

      if (callbacks && callbacks.size > 0) {
        return this;
      }
    }

    return false;
  }

  clear(): this {
    this.listeners.clear();
    return this;
  }

  protected _validateEventNames(eventNames: string): string[] {
    return eventNamesValidation(eventNames, this.EVENTS_LIST);
  }

  protected _createNamespacedEvent(eventName: string = ""): string {
    return this.namespace ? `${this.namespace}:${eventName}` : eventName;
  }

  protected _bind(
    eventName: string,
    callback: EventCallback,
    once: boolean = false,
  ): void {
    const namespacedEventName = this._createNamespacedEvent(eventName);
    const callbacks =
      this.listeners.get(namespacedEventName) || new Set<EventCallback>();

    if (!callbacks.has(callback)) {
      if (once) {
        const callbackOnce = (...args: any[]) => {
          callback(...args);
          this._unbind(eventName, callbackOnce);
        };
        callbacks.add(callbackOnce);
      } else {
        callbacks.add(callback);
      }

      this.listeners.set(namespacedEventName, callbacks);
    }
  }

  protected _unbind(eventName?: string, callback?: EventCallback): void {
    if (!eventName) {
      this.listeners.clear();
      return;
    }

    const namespacedEventName = this._createNamespacedEvent(eventName);

    if (callback) {
      const callbacks = this.listeners.get(namespacedEventName);

      if (callbacks && callbacks.has(callback)) {
        callbacks.delete(callback);
      }
    } else {
      this.listeners.set(namespacedEventName, new Set<EventCallback>());
    }
  }
}
