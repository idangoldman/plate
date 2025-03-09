import coffeescript from "coffeescript"

export default (source, filename) ->
  coffeescript.compile source.toString(), {
    filename: filename
    inlineMap: true
  }
