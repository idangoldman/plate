import isEmpty from '~/library/arrays/functions/is-empty';

export default function last<T>(arr: T[]): T | undefined {
  if (!isEmpty(arr)) {
    return arr[arr.length - 1];
  }
  return undefined;
}
