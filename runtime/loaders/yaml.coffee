import { YAML_EXTENSION } from "#library/utilities/regex"
import transformYaml from "#runtime/transformers/yaml"

export load = (url, context, nextLoad) ->
  unless YAML_EXTENSION.test(url)
    return nextLoad(url, context)

  transformedSource = await transformYaml new URL(url).pathname, context.importAttributes?.keyCase

  return {
    format: "module"
    shortCircuit: true
    source: transformedSource
  }
