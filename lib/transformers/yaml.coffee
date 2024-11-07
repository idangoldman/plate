import { readFile } from "node:fs/promises"
import YAML from "yaml"

import { methods } from "#root/methods/prototypes/object.js"

export default transformYaml = (filePath, keysCase = "camel") ->
  source = await readFile(filePath, "utf8")

  transformedContent = YAML.parse source.toString()
  transformedContent = methods.toCaseKeys(keysCase).bind transformedContent
  transformedContent = JSON.stringify transformedContent, null, 2

  "export default #{transformedContent};"
