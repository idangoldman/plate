import { BaseRemarkPlugin } from "@/tools/remark/base.coffee"
import yaml from "js-yaml"

class AssetsFullUrlRemarkPlugin extends BaseRemarkPlugin
  type = ["image"]

  process: ({node, index, parent, file}) ->
    node.url = @generateFullURL node.url, file.data.permalink

    file.data["assets"] = [] unless file.data["assets"]
    file.data["assets"].push node.url

  generateFullURL: (relativePath, permalink) ->
    return relativePath if relativePath.startsWith("http")

    imageBaseURL = "http://#{PLATE_ENV.server.hostname}/#{permalink}"
    new URL(relativePath, imageBaseURL).href.replace("http://", "//")

export default new AssetsFullUrlRemarkPlugin()
