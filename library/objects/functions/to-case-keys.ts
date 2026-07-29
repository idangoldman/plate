import capitalize from '~/library/strings/functions/capitalize';

export default function toCaseKeys(obj: Record<string, any>, caseType: string = ""): Record<string, any> {
  const prototypeName = `to${capitalize(caseType)}Case`;
  const result: Record<string, any> = {};

  for (const key of Object.keys(obj)) {
    const value = obj[key];
    // Need to cast key to any to call the prototype method dynamically (or use the string function if it exists)
    const newKey = (key as any)[prototypeName] ? (key as any)[prototypeName]() : key;

    result[newKey] = typeof value === "object" && Array.isArray(value) === false && value !== null
      ? toCaseKeys(value, caseType)
      : value;
  }

  return result;
}
