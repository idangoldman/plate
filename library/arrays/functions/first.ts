import isEmpty from '../../arrays/functions/is-empty';

export default function first<T>(arr: T[]): T | undefined {
  if (!isEmpty(arr)) {
    return arr[0];
  }
  return undefined;
}
