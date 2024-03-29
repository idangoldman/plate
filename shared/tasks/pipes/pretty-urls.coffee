import path from "node:path"

import TaskPipe from "~/tasks/pipes/task.coffee"

globs = PLATE_ENV.globs
routes = PLATE_ENV.contentRoutes

class PrettyURLs extends TaskPipe
  @newInstance: (options = {}) =>
    new @ "pretty-urls-pipe", options

  transpile: ({ file }) ->
    defaultData =
      layout: "default"
      permalink: path.join PLATE_ROOT, globs.content.dest, file.path

    Promise.resolve
      data: @getRouteData file.path, defaultData

  getRouteData: (filePath, data) ->
    route = @cleanRoute filePath

    for own pattern, details of routes
      patternRegex = @patternToRegex pattern

      if patternMatched = patternRegex.exec(route)
        data.layout = details.layout
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
