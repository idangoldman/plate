import { readFile } from "node:fs/promises"
import YAML from "yaml"

import { methods } from "#library/prototypes/methods/case-conversion.coffee"

export default transformYaml = (filePath, keyCase = "") ->
  source = await readFile(filePath, "utf8")
  transformedContent = YAML.parse source.toString(), { merge: true }

  unless keyCase.isEmpty()
    transformedContent = methods.toCaseKeys.bind(transformedContent)(keyCase)

  transformedContent = JSON.stringify transformedContent, null, 2

  "export default #{transformedContent};"
