import path from "node:path"

import TaskPipe from "~/tasks/pipes/task.coffee"

routes = PLATE_ENV.contentRoutes
globs = PLATE_ENV.globs.content

class PrettyURLs extends TaskPipe
  @newInstance: (options = {}) =>
    new @ "pretty-urls-pipe", options

  transpile: ({ file }) ->
    filePath = @cleanRoute file.path

    defaultData =
      layout: "not-found"
      permalink: "/404"
      tmpPath: path.join globs.dest, file.path

    Promise.resolve
      data: @getRouteData filePath, defaultData

  getRouteData: (route, data) ->
    for own pattern, details of routes
      patternRegex = @patternToRegex pattern

      if patternMatched = patternRegex.exec(route)
        data.layout = details.layout if details.layout
        data.permalink = @generateURL(details.permalink, patternMatched.groups)
        break
    data

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

  cleanRoute: (filePath) ->
    "/#{path.parse(filePath).dir}"

export default PrettyURLs.newInstance
