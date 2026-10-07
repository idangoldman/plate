import eventNamesValidation from '../events/helpers/event-names-validation';
import { DOM_EVENTS_LIST } from './lists';

export default class DOMEvents {
  private element: { raw: HTMLElement };
  private listeners: Map<string, { eventName: string; callback: EventListener }>;

  constructor(element: { raw: HTMLElement }) {
    this.element = element;
    this.listeners = new Map();
  }

  on(eventNames: string, callback: EventListener, once: boolean = false): this {
    const validEventNames = eventNamesValidation(eventNames, DOM_EVENTS_LIST);

    for (const eventName of validEventNames) {
      this._bind(eventName, callback, once);
    }

    return this;
  }

  off(eventNames?: string, callback?: EventListener): this {
    if (eventNames) {
      const validEventNames = eventNamesValidation(eventNames, DOM_EVENTS_LIST);

      for (const eventName of validEventNames) {
        this._unbind(eventName, callback);
      }
    } else {
      this._unbind();
    }

    return this;
  }

  once(eventNames: string, callback: EventListener): this {
    return this.on(eventNames, callback, true);
  }

  has(eventNames: string): boolean {
    const validEventNames = eventNamesValidation(eventNames, DOM_EVENTS_LIST);

    for (const eventName of validEventNames) {
      for (const listener of this.listeners.values()) {
        if (listener.eventName === eventName) {
          return true;
        }
      }
    }
    
    return false;
  }

  clear(): this {
    for (const [key, { eventName, callback }] of this.listeners.entries()) {
      this.element.raw.removeEventListener(eventName, callback, false);
    }
    this.listeners.clear();
    return this;
  }

  protected _bind(eventName: string, callback: EventListener, once: boolean = false): void {
    const eventKey = `${eventName}_${callback.toString()}`;

    if (!this.listeners.has(eventKey)) {
      this.element.raw.addEventListener(eventName, callback, { once });
      this.listeners.set(eventKey, { eventName, callback });
    }
  }

  protected _unbind(eventName?: string, callback?: EventListener): void {
    if (!eventName) {
      this.clear();
      return;
    }

    if (callback) {
      const eventKey = `${eventName}_${callback.toString()}`;
      if (this.listeners.has(eventKey)) {
        this.element.raw.removeEventListener(eventName, callback, false);
        this.listeners.delete(eventKey);
      }
    } else {
      for (const [key, listener] of this.listeners.entries()) {
        if (listener.eventName === eventName) {
          this.element.raw.removeEventListener(listener.eventName, listener.callback, false);
          this.listeners.delete(key);
        }
      }
    }
  }
}
