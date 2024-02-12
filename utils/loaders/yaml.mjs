import { readFile } from "node:fs/promises";
import yaml from "js-yaml";

const extensionsRegex = /\.(yml|yaml)$/;

export async function load(url, context, nextLoad) {
  if (extensionsRegex.test(url)) {
    const rawSource = await readFile(new URL(url), "utf8");
    const data = yaml.load(rawSource.toString());
    const json = JSON.stringify(data);
    const defaultExportName = "yamlExport";

    const moduleExports = Object.keys(data)
      .map((key) => `export const ${key} = ${defaultExportName}['${key}'];`)
      .join("\n");

    const sourceExport = [
      `const ${defaultExportName} = ${json};`,
      `export default ${defaultExportName};`,
      moduleExports,
    ].join("\n");

    return {
      format: "module",
      shortCircuit: true,
      source: sourceExport,
    };
  }

  return nextLoad(url, context, nextLoad);
}
