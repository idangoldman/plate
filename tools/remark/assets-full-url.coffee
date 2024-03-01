import BaseRemarkPlugin from "@/tools/remark/base.coffee"
import { URL } from "node:url"
import yaml from "js-yaml"

class AssetsFullUrlRemarkPlugin extends BaseRemarkPlugin
  type: ["image"]

  process: ({ node, file, options }) ->
    # If the URL is already a full URL, don't do anything
    return if node.url.startsWith("http")

    # Generate the new URL
    newURL = @generateURL node.url, options.permalink

    # Add the new URL to the assets list
    file["assets"] = [] unless file["assets"]
    file["assets"].push [node.url, newURL.pathname]

    # Update the node URL
    node.url = newURL.href

  generateURL: (relativePath, permalink) ->
    relativePath = "#{permalink}/#{relativePath}"
    imageBaseURL = "http://#{PLATE_ENV.server.hostname}/"

    new URL(relativePath, imageBaseURL)

export default new AssetsFullUrlRemarkPlugin().use

