import { transformYaml } from "#root/transformers/yaml.js"
import { YAML_EXTENSION } from "#root/helpers/regex.js"

export default ->
  name: "yaml"
  setup: (build) ->
    build.onLoad({ filter: YAML_EXTENSION }, async (args) ->
      transformedSource = await transformYaml(args.path)

      return {
        contents: transformedSource
        loader: "js"
      }
    )