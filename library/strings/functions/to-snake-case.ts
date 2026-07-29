import toCase from '../../strings/functions/to-case';

export default function toSnakeCase(value: string = ""): string {
  const parts = toCase(value);
  if (!parts || parts.length === 0 || parts[0] === "") return "";
  return parts.join("_");
}
