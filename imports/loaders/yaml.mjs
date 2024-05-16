import { transformYaml, extensionsYaml } from "../transformers/yaml.mjs";

export async function load(url, context, nextLoad) {
  if (extensionsYaml.test(url)) {
    const transformedSource = await transformYaml(new URL(url).pathname);

    return {
      format: "module",
      shortCircuit: true,
      source: transformedSource,
    };
  }

  return nextLoad(url, context, nextLoad);
}
