import { YAML_EXTENSION } from "#library/utilities/regex"
import transformYaml from "#runtime/transformers/yaml"

export default -> {
  name: "yaml"
  setup: (build) ->
    build.onLoad({ filter: YAML_EXTENSION }, (args) ->
      transformedSource = await transformYaml(args.path, args.importAttributes?.keyCase)

      return {
        contents: transformedSource
        loader: "js"
      }
    )
}
