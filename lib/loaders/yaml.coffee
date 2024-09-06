import { transformYaml } from "#root/transformers/yaml.js"
import { YAML_EXTENSION } from "#root/tools/regex.js"

export load = async (url, context, nextLoad) ->
  if YAML_EXTENSION.test(url)
    transformedSource = await transformYaml(new URL(url).pathname)

    return {
      format: "module"
      shortCircuit: true
      source: transformedSource
    }

  nextLoad(url, context, nextLoad)
