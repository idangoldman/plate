import isArray from '../../objects/functions/is-array';
import isObject from '../../objects/functions/is-object';
import isString from '../../objects/functions/is-string';
import isEmptyString from '../../strings/functions/is-empty';
import isEmptyArray from '../../arrays/functions/is-empty';
import isEmptyObject from '../../objects/functions/is-empty';

export default function toBoolean(value: any): boolean {
  if (isArray(value)) {
    return !isEmptyArray(value);
  }

  if (isObject(value)) {
    return !isEmptyObject(value);
  }

  if (isString(value)) {
    return !isEmptyString(value);
  }

  return Boolean(value);
}
