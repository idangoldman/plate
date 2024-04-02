import coffeescript from "coffeescript";

const extensionsRegex = /\.(coffee|litcoffee|coffee\.md)$/;

export async function load(url, context, nextLoad) {
  if (extensionsRegex.test(url)) {
    const format = "module";
    const { source: rawSource } = await nextLoad(url, { ...context, format });
    const transformedSource = coffeescript.compile(rawSource.toString(), {
      filename: url,
      inlineMap: true
    });

    return {
      format,
      shortCircuit: true,
      source: transformedSource,
    };
  }

  return nextLoad(url, context, nextLoad);
}
