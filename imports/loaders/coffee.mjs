import { transformCoffee, extensionsCoffee } from "../transformers/coffee.mjs";

export async function load(url, context, nextLoad) {
  if (extensionsCoffee.test(url)) {
    const format = "module";
    const { source } = await nextLoad(url, { ...context, format });
    const transformedSource = await transformCoffee(source, url);

    return {
      format,
      shortCircuit: true,
      source: transformedSource,
    };
  }

  return nextLoad(url, context, nextLoad);
}
