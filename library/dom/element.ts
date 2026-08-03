export default class Element {
  public selector: string;
  public element: HTMLElement | null;

  constructor(selector: string = '') {
    if (!selector.length) {
      throw new Error('No query selector passed');
    }

    this.selector = selector;
    this.element = document.querySelector<HTMLElement>(selector);

    if (this.element === null) {
      throw new Error(`No HTML element was found with "${selector}" selector`);
    }
  }

  get raw(): HTMLElement {
    return this.element as HTMLElement;
  }

  get toString(): string {
    return this.selector;
  }
}
