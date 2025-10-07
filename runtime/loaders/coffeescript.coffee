import { COFFEE_EXTENSION } from "#library/utilities/regex.coffee"
import transformCoffee from "#runtime/transformers/coffeescript.coffee"

export load = (url, context, nextLoad) ->
  if COFFEE_EXTENSION.test url
    format = "module"

    { source } = await nextLoad url, { ...context, format }

    transformedSource = await transformCoffee source, url

    return {
      format: format
      shortCircuit: true
      source: transformedSource
    }

  nextLoad(url, context, nextLoad)
