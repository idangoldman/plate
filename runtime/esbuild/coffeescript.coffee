import { readFile } from "node:fs/promises"

import { COFFEE_EXTENSION } from "#library/utilities/regex"
import transformCoffee from "#runtime/transformers/coffeescript"

export default -> {
  name: "coffeescript"
  setup: (build) ->
    build.onLoad({ filter: COFFEE_EXTENSION }, ({ path }) ->
      source = await readFile(path, "utf8")
      transformedSource = await transformCoffee(source, path)

      return {
        contents: transformedSource
        loader: "js"
      }
    )
}
