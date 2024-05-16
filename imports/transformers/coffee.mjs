import coffeescript from "coffeescript";

export const extensionsCoffee = /\.(coffee|litcoffee|coffee\.md)$/;

export function transformCoffee(source, filename) {
  return coffeescript.compile(source.toString(), {
    filename,
    inlineMap: true,
  });
};
