export default expectedValueParser = (value) ->
  # Boolean check
  if value in ["true", "false"]
    return { type: "boolean", value: value is "true" }

  # Null check
  if value is "null"
    return { type: "null", value: null }

  # Undefined check
  if value is "undefined"
    return { type: "undefined", value: undefined }

  # Number check
  if /^-?\d+(?:\.\d+)?$/.test(value)
    return { type: "number", value: parseFloat(value) }

  # String check (quoted)
  if /^".*"$/.test(value)
    return { type: "string", value: value.slice(1, -1) }

  # Array check
  if /^\[.*\]$/.test(value)
    try
      parsed = JSON.parse(value)

      if Array.isArray(parsed)
        return { type: "array", value: parsed }

      throw new Error("Parsed value is not an array: #{value}")
    catch error
      throw new Error("Invalid array format: #{value}")

  # Object check
  if /^\{.*\}$/.test(value)
    try
      parsed = JSON.parse(value)

      if typeof parsed is "object" and not Array.isArray(parsed) and parsed isnt null
        return { type: "object", value: parsed }

      throw new Error("Parsed value is not an object: #{value}")
    catch error
      throw new Error("Invalid object format: #{value}")

  # If we reach here, we don't know the type
  throw new Error("Unable to determine expected type for: #{value}")
