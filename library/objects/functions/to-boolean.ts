import isArray from '~/library/objects/functions/is-array';
import isObject from '~/library/objects/functions/is-object';
import isString from '~/library/objects/functions/is-string';
import isEmptyString from '~/library/strings/functions/is-empty';
import isEmptyArray from '~/library/arrays/functions/is-empty';
import isEmptyObject from '~/library/objects/functions/is-empty';

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
