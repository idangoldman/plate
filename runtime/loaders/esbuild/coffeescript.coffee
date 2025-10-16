import { COFFEE_EXTENSION } from "#library/utilities/regex.coffee"
import coffeescriptTransformer from "#runtime/transformers/coffeescript.coffee"

export default ->
  name: "plate-coffeescript-plugin"
  setup: (build) ->
    build.onLoad { filter: COFFEE_EXTENSION }, (args) ->
      source = await readFile args.path, "utf8"

      # Rewrite import paths inside CoffeeScript files
      try
        modifiedSource = source.replace /import\s+((?:[\w*\s{},]*)\s+from\s+)?['"](#(library|runtime|tests)\/[^'"]+?)(\.coffee|\.yaml|\.yml)?['"]/g, (match, importPart, importPath, folder, extension) ->
          if folder?
            newPath = importPath.replace folder, "root/#{folder}"

          if extension?
            newPath += '.js'

          "import #{importPart or ''}'#{newPath}'"

      catch error
        return {
          errors: [{
            text: error.message
            location:
              file: args.path
          }]
        }

      # Transpile CoffeeScript to JavaScript
      result = await coffeescriptTransformer modifiedSource, args.path

      if result.errors
        return {
          errors: result.errors
        }

      return {
        contents: result.contents
        loader: "js"
      }
