import Storage from './local';

export default class SessionStorage extends Storage {
  constructor(prefix: string = '', separator: string = '') {
    super('session', prefix, separator);
  }
}
