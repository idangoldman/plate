import { YAML_EXTENSION } from "#root/helpers/regex.js"
import transformYaml from "#root/transformers/yaml.js"

export load = (url, context, nextLoad) ->
  if YAML_EXTENSION.test(url)
    transformedSource = await transformYaml(new URL(url).pathname)

    return {
      format: "module"
      shortCircuit: true
      source: transformedSource
    }

  nextLoad(url, context, nextLoad)
