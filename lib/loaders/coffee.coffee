import { COFFEE_EXTENSION } from "#root/helpers/regex.js"
import transformCoffee from "#root/transformers/coffee.js"

export load = (url, context, nextLoad) ->
  if COFFEE_EXTENSION.test url
    format = "module"

    { source } = await nextLoad url, { ...context, format }

    transformedSource = await transformCoffee source, url

    return
      format: format
      shortCircuit: true
      source: transformedSource

  nextLoad(url, context, nextLoad)
