import { pathResolver, pathStartsWith } from "@/imports/transformers/resolver.mjs";

export default function resolverPlugin() {
  return {
    name: "resolver",
    setup(build) {
      build.onResolve({ filter: pathStartsWith }, async (args) => {
        const resolvedPath = await pathResolver(args.path);
        return { path: resolvedPath, namespace: "file" };
      });
    },
  };
}
