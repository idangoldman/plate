export default function isObject(value: any): value is Record<string, any> {
  return typeof value === 'object' && Array.isArray(value) === false && value !== null;
}
