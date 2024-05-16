import { transformYaml, extensionsYaml } from "@/imports/transformers/yaml.mjs";

export default function yamlPlugin() {
  return {
    name: "yaml",
    setup(build) {
      build.onLoad({ filter: extensionsYaml }, async (args) => {
        const transformedSource = await transformYaml(args.path);

        return {
          contents: transformedSource,
          loader: "js",
        };
      });
    },
  };
}
