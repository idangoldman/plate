/**
 * Flattens an array to any depth. Duplicates are preserved.
 *
 * It used to pipe the result through `unique()`, which meant "flatten" quietly
 * did two things. Chain them when you want both: flatten first, then `unique()`.
 */
export default function flatten<T>(arr: readonly unknown[]): T[] {
  return arr.flat(Infinity) as T[];
}
