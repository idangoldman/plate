import { YAML_EXTENSION } from "#root/helpers/regex.js"
import transformYaml from "#root/transformers/yaml.js"

export load = (url, context, nextLoad) ->
  unless YAML_EXTENSION.test(url)
    return nextLoad(url, context)

  keysCase = context.importAttributes?.keysCase or 'camel'

  transformedSource = await transformYaml new URL(url).pathname, keysCase

  return {
    format: "module"
    shortCircuit: true
    source: transformedSource
  }
