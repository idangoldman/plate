import { COFFEE_EXTENSION } from "#root/helpers/regex.js"
import { readFile } from "node:fs/promises"
import transformCoffee from "#root/transformers/coffee.js"

export default ->
  name: "coffeescript"
  setup: (build) ->
    build.onLoad({ filter: COFFEE_EXTENSION }, async ({ path }) ->
      source = await readFile(path, "utf8")
      transformedSource = await transformCoffee(source, path)

      return {
        contents: transformedSource
        loader: "js"
      }
    )
