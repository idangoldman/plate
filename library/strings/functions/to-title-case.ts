import toCase from '../../strings/functions/to-case';
import capitalize from '../../strings/functions/capitalize';

export default function toTitleCase(value: string = ""): string {
  const parts = toCase(value);
  if (!parts || parts.length === 0 || parts[0] === "") return "";
  return parts.map(capitalize).join(" ");
}
