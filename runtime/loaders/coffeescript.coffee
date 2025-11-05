import { COFFEE_EXTENSION } from "#library/utilities/regex.coffee"
import transformCoffee from "#runtime/transformers/coffeescript.coffee"

export load = (url, context, nextLoad) ->
  unless COFFEE_EXTENSION.test url
    return nextLoad(url, context, nextLoad)

  format = "module"

  { source } = await nextLoad url, { ...context, format }
  result = await transformCoffee source, url

  if result.errors
    syntaxError = new SyntaxError(result.errors[0].text)
    syntaxError.code = 'ERR_INVALID_MODULE'
    syntaxError.column = result.errors[0].location.column
    syntaxError.length = result.errors[0].location.length
    syntaxError.line = result.errors[0].location.line
    syntaxError.lineText = result.errors[0].location.lineText
    syntaxError.url = result.errors[0].location.file
    syntaxError.stack = null

    throw syntaxError

  return {
    format: format
    shortCircuit: true
    source: result.contents
  }
