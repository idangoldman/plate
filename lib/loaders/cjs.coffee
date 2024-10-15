import { COMMON_JS_CONTENT } from "#root/helpers/regex.js"

export load = (url, context, nextLoad) ->
  unless url.endsWith(".js")
    return await nextLoad(url, context, nextLoad)

  await transform(url, context, nextLoad)

transform = (url, context, nextLoad) ->
  try
    nextResult = await nextLoad url, { ...context, format: "module" }

    if containsCJS(nextResult.source)
      throw new Error("CommonJS")

    nextResult

  catch error
    if error.message == "CommonJS"
      return { format: "commonjs" }
    # emitImportAssertionWarning
    else if error.message.includes("emitImportAssertionWarning")
      console.log 123, context
    #   return await nextLoad(url, context, nextLoad)
    throw error

containsCJS = (source) ->
  src = "" + source

  # A realistic version of this loader would use a parser like Acorn to check for actual `module.exports` syntax
  return true if COMMON_JS_CONTENT.test(src)
