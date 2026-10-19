import isArray from '~/library/objects/functions/is-array';
import isObject from '~/library/objects/functions/is-object';
import isString from '~/library/objects/functions/is-string';

export default function toObject(value: any): Record<string, any> {
  if (isArray(value)) {
    return value.reduce((obj: Record<string, any>, val: any, index: number) => {
      obj[index] = val;
      return obj;
    }, {});
  }

  if (isObject(value)) {
    return Object.assign({}, value);
  }

  if (isString(value)) {
    return value.length === 0 ? {} : { 0: value };
  }

  return { 0: value };
}
