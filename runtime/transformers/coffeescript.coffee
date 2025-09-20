import coffeescript from "coffeescript"

export default (source, filename) ->
  coffeescript.compile source.toString(), {
    bare: true
    filename: filename
    header: false
    inlineMap: false
    sourceMap: false
  }
