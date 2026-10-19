import toCase from '~/library/strings/functions/to-case';
import capitalize from '~/library/strings/functions/capitalize';

export default function toCamelCase(value: string = ""): string {
  const parts = toCase(value);
  if (!parts || parts.length === 0 || parts[0] === "") return "";
  return parts[0].toLowerCase() + parts.slice(1).map(capitalize).join('');
}
