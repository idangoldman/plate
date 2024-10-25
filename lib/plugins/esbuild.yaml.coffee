import { YAML_EXTENSION } from "#root/helpers/regex.js"
import transformYaml from "#root/transformers/yaml.js"

export default ->
  name: "yaml"
  setup: (build) ->
    build.onLoad({ filter: YAML_EXTENSION }, (args) ->
      transformedSource = await transformYaml(args.path, args.importAssertions?.keysCase or 'camel')

      return {
        contents: transformedSource
        loader: "js"
      }
    )
