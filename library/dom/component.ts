import Element from './element';
import Events from './events';
import Storage from '../stores/local';
import onDOMContentLoaded from './dom-content-loaded';

export interface ComponentArgs {
  element: Element;
  events: Events;
  local: Storage;
}

export const component = (selector: string, callback: (args: ComponentArgs) => void) => {
  onDOMContentLoaded(() => {
    const element = new Element(selector);
    const events = new Events(element);
    const local = new Storage('local');

    callback({ element, events, local });
  });
};

export default { component };
