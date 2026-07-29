import toCase from '~/library/strings/functions/to-case';
import capitalize from '~/library/strings/functions/capitalize';

export default function toPascalCase(value: string = ""): string {
  const parts = toCase(value);
  if (!parts || parts.length === 0 || parts[0] === "") return "";
  return parts.map(capitalize).join('');
}
