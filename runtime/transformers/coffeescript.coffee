import coffeescript from "coffeescript"

export default (source, filename) ->
  try
    contents = coffeescript.compile(source.toString(), {
      bare: true
      filename: filename
      header: false
      inlineMap: false
      sourceMap: false
    })

    return {contents}

  catch error
    return {
      errors: [{
        text: error.message
        location:
          file: error.filename
          line: error.location?.first_line
          column: error.location?.first_column
          length: Math.max(1, (error.location?.last_column || 0) - (error.location?.first_column || 0))
          lineText: error.code
      }]
    }
