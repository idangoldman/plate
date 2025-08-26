import { readFile } from "node:fs/promises"
import YAML from "yaml"

import { methods } from "#root/prototypes/methods/case-conversion.js"

export default transformYaml = (filePath, keyCase = "") ->
  source = await readFile(filePath, "utf8")
  transformedContent = YAML.parse source.toString()

  unless keyCase.isEmpty()
    transformedContent = methods.toCaseKeys.bind(transformedContent)(keyCase)

  transformedContent = JSON.stringify transformedContent, null, 2

  "export default #{transformedContent};"
