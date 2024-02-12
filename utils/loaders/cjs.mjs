export async function load(url, context, nextLoad) {
  if (!url.endsWith(".js")) {
    return await nextLoad(url, context, nextLoad);
  }

  return await transform(url, context, nextLoad);
}

async function transform(url, context, nextLoad) {
  try {
    const nextResult = await nextLoad(url, { ...context, format: "module" });
    if (containsCJS(nextResult.source)) throw new Error("CommonJS");
    return nextResult;
  } catch (error) {
    if (
      (error?.message.includes("require") && error.includes("import")) ||
      error?.message.includes("CommonJS")
    ) {
      return { format: "commonjs" };
    }

    throw error;
  }
}

function containsCJS(source) {
  const src = "" + source;

  // A realistic version of this loader would use a parser like Acorn to check for actual `module.exports` syntax
  if (/exports[\[\.( ?=)]/.test(src)) {
    return true;
  }

  if (/require\(/.test(src) && !/createRequire\(/.test(src)) {
    return true;
  }
}
