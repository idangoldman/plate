import capitalize from '~/library/strings/functions/capitalize';
import toCamelCase from '~/library/strings/functions/to-camel-case';
import toConstantCase from '~/library/strings/functions/to-constant-case';
import toDotCase from '~/library/strings/functions/to-dot-case';
import toKebabCase from '~/library/strings/functions/to-kebab-case';
import toPascalCase from '~/library/strings/functions/to-pascal-case';
import toSnakeCase from '~/library/strings/functions/to-snake-case';
import toTitleCase from '~/library/strings/functions/to-title-case';

const formatters: Record<string, (v: string) => string> = {
  toCamelCase,
  toConstantCase,
  toDotCase,
  toKebabCase,
  toPascalCase,
  toSnakeCase,
  toTitleCase
};

export default function toCaseKeys(obj: Record<string, any>, caseType: string = ""): Record<string, any> {
  const functionName = `to${capitalize(caseType)}Case`;
  const result: Record<string, any> = {};

  for (const key of Object.keys(obj)) {
    const value = obj[key];

    let newKey = key;
    if (typeof (key as any)[functionName] === 'function') {
      newKey = (key as any)[functionName]();
    } else if (formatters[functionName]) {
      newKey = formatters[functionName](key);
    }

    result[newKey] = typeof value === "object" && Array.isArray(value) === false && value !== null
      ? toCaseKeys(value, caseType)
      : value;
  }

  return result;
}
