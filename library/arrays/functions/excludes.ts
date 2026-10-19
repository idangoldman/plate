export default function excludes<T>(arr: T[], item: T): boolean {
  return !arr.includes(item);
}
