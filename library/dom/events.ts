import DOMEvents from '../events/dom';
import Element from './element';

export default class Events extends DOMEvents {
  constructor(element: Element) {
    // DOMEvents takes { raw: HTMLElement }
    super({ raw: element.raw });
  }
}
