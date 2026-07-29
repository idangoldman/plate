import isArray from '../../objects/functions/is-array';
import isEmptyArray from '../../arrays/functions/is-empty';
import isEmptyString from '../../strings/functions/is-empty';
import isObject from '../../objects/functions/is-object';
import isString from '../../objects/functions/is-string';

export default function isEmpty(value: any): boolean {
  if (isArray(value)) {
    return isEmptyArray(value);
  }

  if (isObject(value)) {
    return Object.keys(value).length === 0;
  }

  if (isString(value)) {
    return isEmptyString(value);
  }

  if (value instanceof Map || value instanceof Set) {
    return value.size === 0;
  }

  return false;
}
