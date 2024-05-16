import { transformCoffee, extensionsCoffee } from "@/imports/transformers/coffee.mjs";
import { readFile } from "node:fs/promises";

export default function coffeePlugin() {
  return {
    name: "coffeescript",
    setup(build) {
      build.onLoad({ filter: extensionsCoffee }, async ({ path }) => {
        const source = await readFile(path, "utf8");
        const transformedSource = await transformCoffee(source, path);

        return {
          contents: transformedSource,
          loader: "js"
        };
      });
    }
  };
}
