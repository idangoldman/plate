export parseBoolean = (value) ->
  if value in ["true", "false"]
    { type: "boolean", value: value is "true" }

export parseNull = (value) ->
  if value is "null"
    { type: "null", value: null }

export parseUndefined = (value) ->
  if value is "undefined"
    { type: "undefined", value: undefined }

export parseNumber = (value) ->
  if /^-?\d+(?:\.\d+)?$/.test(value)
    { type: "number", value: parseFloat(value) }

export parseString = (value) ->
  if /^".*"$/.test(value)
    { type: "string", value: value.slice(1, -1) }

export parseArray = (value) ->
  if /^\[.*\]$/.test(value)
    try
      parsed = JSON.parse(value)

      if Array.isArray(parsed)
        return { type: "array", value: parsed }

      throw new Error("Parsed value is not an array: #{value}")
    catch error
      throw new Error("Invalid array format: #{value}")

export parseObject = (value) ->
  if /^\{.*\}$/.test(value)
    try
      parsed = JSON.parse(value)

      if typeof parsed is "object" and not Array.isArray(parsed) and parsed isnt null
        return { type: "object", value: parsed }

      throw new Error("Parsed value is not an object: #{value}")
    catch error
      throw new Error("Invalid object format: #{value}")

export default expectedValueParser = (value) ->
  parsers = [
    parseBoolean,
    parseNull,
    parseUndefined,
    parseNumber,
    parseString,
    parseArray,
    parseObject
  ]

  for parser in parsers
    result = parser(value)

    if result?
      return result

  throw new Error("Unable to determine expected type for: #{value}")
