import { readFile } from "node:fs/promises";
import yaml from "js-yaml";

const extensionsRegex = /\.(yml|yaml)$/;

export async function load(url, context, nextLoad) {
  if (extensionsRegex.test(url)) {
    const rawSource = await readFile(new URL(url), "utf8");
    const data = yaml.load(rawSource.toString());
    const defaultExport = JSON.stringify(data, null, 2);

    return {
      format: "module",
      shortCircuit: true,
      source: `export default ${defaultExport};`,
    };
  }

  return nextLoad(url, context, nextLoad);
}
