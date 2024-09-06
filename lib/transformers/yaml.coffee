import { fromSnakeToCamel } from "#root/helpers/mappings.js"
import { readFile } from "node:fs/promises"
import YAML from "yaml"

export default async (filePath) ->
  source = await readFile(filePath, "utf8")

  transformedContent = YAML.parse source.toString()
  transformedContent = fromSnakeToCamel(transformedContent)
  transformedContent = JSON.stringify transformedContent, null, 2

  "export default #{transformedContent};"
