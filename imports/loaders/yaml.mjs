import { readFile } from "node:fs/promises"
import { transformKeysFromSnakeToCamel } from "@/tools/methods.mjs"
import yaml from "js-yaml"

const extensionsRegex = /\.ya?ml$/

export async function load(url, context, nextLoad) {
  if (extensionsRegex.test(url)) {
    const rawSource = await readFile(new URL(url), "utf8")
    let defaultExport = yaml.load(rawSource.toString());
        defaultExport = transformKeysFromSnakeToCamel(defaultExport);
        defaultExport = JSON.stringify(defaultExport, null, 2);

    return {
      format: "module",
      shortCircuit: true,
      source: `export default ${defaultExport};`,
    }
  }

  return nextLoad(url, context, nextLoad)
}
