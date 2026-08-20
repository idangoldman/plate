import LocalStore from './local';

export default class SessionStore extends LocalStore {
  constructor(prefix: string = '', separator: string = '') {
    super('session', prefix, separator);
  }
}
