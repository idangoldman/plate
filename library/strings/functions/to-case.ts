const CASE_SEPARATORS_UNICODE = new RegExp("[^\\p{L}\\p{N}]+", "gu");
const CASE_WHITESPACE = new RegExp("\\s+", "g");

export default function toCase(value: string = ""): string[] {
  return value
    .replace(CASE_SEPARATORS_UNICODE, " ")
    .trim()
    .toLowerCase()
    .split(CASE_WHITESPACE);
}
