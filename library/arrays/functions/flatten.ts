import unique from '~/library/arrays/functions/unique';

export default function flatten<T>(arr: any[]): T[] {
  return unique(arr.flat(Infinity)) as T[];
}
