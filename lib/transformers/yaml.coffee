import { readFile } from "node:fs/promises"
import YAML from "yaml"

import { toCaseKeys } from "#root/methods/object.js"

export default transformYaml = (filePath, keysCase = "camel") ->
  source = await readFile(filePath, "utf8")

  transformedContent = YAML.parse source.toString()
  transformedContent = toCaseKeys transformedContent, keysCase
  transformedContent = JSON.stringify transformedContent, null, 2

  "export default #{transformedContent};"
