import TaskPipe from "~/tasks/pipes/task.coffee"

routes = PLATE_ENV.contentRoutes

class PrettyURLs extends TaskPipe
  @newInstance: (options = {}) =>
    new @ "pretty-urls-pipe", options

  transpile: ({ file }) ->
    fileRoute = @cleanFileRoute file.path

    data =
      layout: "not-found"
      permalink: "/404"

    for own pattern, details of routes
      patternRegex = @patternToRegex pattern

      if patternMatched = patternRegex.exec(fileRoute)
        data.layout = details.layout if details.layout
        data.permalink = @generateURL(details.permalink, patternMatched.groups)
        break

    Promise.resolve { data }

  patternToRegex: (pattern) ->
    STR_REGEX = pattern.split("/").map (part) ->
      if part.startsWith ":"
        name = part.slice(1).replace("*", "")
        "(?<#{name}>.+)"
      else if part is "*"
        ".*"
      else
        part
    .join "\\/"

    new RegExp "^#{STR_REGEX}$"

  generateURL: (permalink = "", params = {}) ->
    permalink
      .replace /:(\w+)/g, (match, param) => params[param]
      .replace "*", ""

  cleanFileRoute: (filePath) ->
    filePath
      .replace "#{PLATE_ROOT}/content", ""
      .replace /((\/content)?(\.[^.]+))$/i, ""

export default PrettyURLs.newInstance
