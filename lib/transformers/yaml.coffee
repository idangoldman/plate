import { readFile } from "node:fs/promises"
import YAML from "yaml"

import { methods } from "#root/prototypes/methods/case-converter.js"

export default transformYaml = (filePath, keyCase = "camel") ->
  source = await readFile(filePath, "utf8")

  transformedContent = YAML.parse source.toString()
  transformedContent = methods.toCaseKeys(keyCase).bind transformedContent
  transformedContent = JSON.stringify transformedContent, null, 2

  "export default #{transformedContent};"
