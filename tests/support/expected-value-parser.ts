export interface ParsedValue {
  type: string;
  value: any;
}

export function parseBoolean(value: string): ParsedValue | undefined {
  if (value === "true" || value === "false") {
    return { type: "boolean", value: value === "true" };
  }
}

export function parseNull(value: string): ParsedValue | undefined {
  if (value === "null") {
    return { type: "null", value: null };
  }
}

export function parseUndefined(value: string): ParsedValue | undefined {
  if (value === "undefined") {
    return { type: "undefined", value: undefined };
  }
}

export function parseNumber(value: string): ParsedValue | undefined {
  if (/^-?\d+(?:\.\d+)?$/.test(value)) {
    return { type: "number", value: parseFloat(value) };
  }
}

export function parseString(value: string): ParsedValue | undefined {
  if (/^".*"$/.test(value)) {
    return { type: "string", value: value.slice(1, -1) };
  }
}

export function parseArray(value: string): ParsedValue | undefined {
  if (/^\[.*\]$/.test(value)) {
    try {
      const parsed = JSON.parse(value);
      if (Array.isArray(parsed)) {
        return { type: "array", value: parsed };
      }
      throw new Error(`Parsed value is not an array: ${value}`);
    } catch (error) {
      throw new Error(`Invalid array format: ${value}`);
    }
  }
}

export function parseObject(value: string): ParsedValue | undefined {
  if (/^\{.*\}$/.test(value)) {
    try {
      const parsed = JSON.parse(value);
      if (typeof parsed === "object" && !Array.isArray(parsed) && parsed !== null) {
        return { type: "object", value: parsed };
      }
      throw new Error(`Parsed value is not an object: ${value}`);
    } catch (error) {
      throw new Error(`Invalid object format: ${value}`);
    }
  }
}

export default function expectedValueParser(value: string): ParsedValue {
  const parsers = [
    parseBoolean,
    parseNull,
    parseUndefined,
    parseNumber,
    parseString,
    parseArray,
    parseObject
  ];

  for (const parser of parsers) {
    const result = parser(value);
    if (result !== undefined) {
      return result;
    }
  }

  throw new Error(`Unable to determine expected type for: ${value}`);
}
