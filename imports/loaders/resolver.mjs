import { pathResolver } from "../transformers/resolver.mjs"

export async function resolve(specifier, context, nextResolve) {
  const resolvedPath = await pathResolver(specifier);
  return nextResolve(resolvedPath, context, nextResolve);
}
