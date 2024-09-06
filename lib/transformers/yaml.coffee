import { readFile } from "node:fs/promises"
import YAML from "yaml"
# import { transformKeysFromSnakeToCamel } from "@/imports/helpers.mjs"

export transformYaml = async (filePath) ->
  source = await readFile(filePath, "utf8")

  transformedContent = YAML.parse source.toString()
  # transformedContent = transformKeysFromSnakeToCamel(transformedContent)
  transformedContent = JSON.stringify transformedContent, null, 2

  "export default #{transformedContent};"
