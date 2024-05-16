import { readFile } from "node:fs/promises";
import YAML from "yaml";
// import { transformKeysFromSnakeToCamel } from "@/imports/helpers.mjs";

export const extensionsYaml = /\.ya?ml$/;

export async function transformYaml(filePath) {
  const source = await readFile(filePath, "utf8");

  let transformedContent = YAML.parse(source.toString());
  // transformedContent = transformKeysFromSnakeToCamel(transformedContent);
  transformedContent = JSON.stringify(transformedContent, null, 2);

  return `export default ${transformedContent};`;
}
