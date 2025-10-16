import { YAML_EXTENSION } from "#library/utilities/regex.coffee"
import transformYaml from "#runtime/transformers/yaml.coffee"

export load = (url, context, nextLoad) ->
  unless YAML_EXTENSION.test(url)
    return nextLoad(url, context)

  transformedSource = await transformYaml new URL(url).pathname, context.importAttributes?.keyCase

  return {
    format: "module"
    shortCircuit: true
    source: transformedSource
  }
