import toCase from '~/library/strings/functions/to-case';

export default function toConstantCase(value: string = ""): string {
  const parts = toCase(value);
  if (!parts || parts.length === 0 || parts[0] === "") return "";
  return parts.join("_").toUpperCase();
}
