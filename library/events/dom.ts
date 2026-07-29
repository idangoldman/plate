import Events from '~/library/patterns/events';
// import { DOM_EVENTS_LIST } from '#root/src/events/lists.json'

const DOM_EVENTS_LIST: string[] = ['click', 'hover']; // Placeholder

export default class DOMEvents extends Events {
  private element: { raw: HTMLElement };

  constructor(element: { raw: HTMLElement }) {
    super(DOM_EVENTS_LIST, 'dom');
    this.element = element;
    // We override the type of listeners here to match the CoffeeScript implementation
    // which stored an object with { eventName, callback } instead of just callbacks
    this.listeners = new Map() as any;
  }

  emit(): this {
    throw new Error('DOM events cannot be emitted manually');
  }

  clear(): this {
    for (const [key, { eventName, callback }] of (this.listeners as any).entries()) {
      this.element.raw.removeEventListener(eventName, callback, false);
    }

    return super.clear();
  }

  protected _bind(eventName: string, callback: EventListener, once: boolean = false): void {
    const eventKey = `${eventName}_${callback.toString()}`;

    if (!this.listeners.has(eventKey)) {
      this.element.raw.addEventListener(eventName, callback, { once });
      (this.listeners as any).set(eventKey, { eventName, callback });
    }
  }

  protected _unbind(eventName: string, callback: EventListener): void {
    const eventKey = `${eventName}_${callback.toString()}`;

    if (this.listeners.has(eventKey)) {
      this.element.raw.removeEventListener(eventName, callback, false);
      this.listeners.delete(eventKey);
    }
  }
}
