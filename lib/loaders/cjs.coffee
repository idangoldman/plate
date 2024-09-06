import { COMMON_JS_CONTENT } from "#root/helpers/regex.js"

export load = async (url, context, nextLoad) ->
  return await nextLoad(url, context, nextLoad) unless url.endsWith(".js")

  await transform(url, context, nextLoad)

transform = async (url, context, nextLoad) ->
  try
    nextResult = await nextLoad(url, { ...context, format: "module" })
    throw new Error("CommonJS") if containsCJS(nextResult.source)
    nextResult
  catch error
    if (error?.message.includes("require") and error.includes("import")) or error?.message.includes("CommonJS")
      return { format: "commonjs" }

    throw error

containsCJS = (source) ->
  src = "" + source

  # A realistic version of this loader would use a parser like Acorn to check for actual `module.exports` syntax
  return true if COMMON_JS_CONTENT.test(src)
