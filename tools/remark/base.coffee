import { visit } from "unist-util-visit"

class BaseRemarkPlugin
  constructor: () ->
    if @process is BaseRemarkPlugin::process
      throw new Error("Child classes must implement the process method.")

  process: ({ node, index, parent, file, options }) ->
    throw new Error("process method must be implemented by subclasses.")

  use: (options) => (tree, file) =>
    visit tree, (node, index, parent) =>
      if @hasType node.type
        @process
          file: file,
          index: index,
          node: node,
          options: options,
          parent: parent
      return
    return

  hasType: (nodeType) ->
    @type = [ @type ] unless Array.isArray @type
    @type.includes nodeType

export default BaseRemarkPlugin
