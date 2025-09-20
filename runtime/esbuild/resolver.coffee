import { STARTS_WITH_BASE_PATH } from "#library/utilities/regex"
import pathResolver from "#runtime/transformers/resolver"

export default -> {
  name: "resolver"
  setup: (build) ->
    build.onResolve({ filter: STARTS_WITH_BASE_PATH }, (args) -> {
      path: await pathResolver(args.path)
      namespace: "file"
    })
}
