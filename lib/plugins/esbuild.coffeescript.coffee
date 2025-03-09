import { COFFEE_EXTENSION } from "#root/helpers/regex.js"
import { readFile } from "node:fs/promises"
import transformCoffee from "#root/transformers/coffeescript.js"

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
