const CASE_SEPARATORS_UNICODE = new RegExp("[^\\p{L}\\p{N}]+", "gu");
const CASE_WHITESPACE = new RegExp("\\s+", "g");

export default function toCase(value: string = ""): string[] {
  // Insert space between lowercase and uppercase letters to handle camelCase/PascalCase properly
  const decamelized = value.replace(/([a-z])([A-Z])/g, "$1 $2");
  const separated = decamelized.replace(CASE_SEPARATORS_UNICODE, " ");
  const trimmed = separated.trim();

  if (!trimmed) return [];

  return trimmed.toLowerCase().split(CASE_WHITESPACE);
}
