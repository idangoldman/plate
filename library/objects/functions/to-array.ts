import isArray from '~/library/objects/functions/is-array';
import isObject from '~/library/objects/functions/is-object';
import isString from '~/library/objects/functions/is-string';
import isEmpty from '~/library/strings/functions/is-empty';

export default function toArray(value: any, separator: string | RegExp = ""): any[] {
  if (isArray(value)) {
    return value.slice();
  }

  if (isObject(value)) {
    return Object.entries(value);
  }

  if (isString(value)) {
    if (value.length === 0) {
      return [];
    } else if (!isEmpty(separator as string)) {
      return value.trim().split(separator);
    } else {
      return [value];
    }
  }

  return [value];
}
