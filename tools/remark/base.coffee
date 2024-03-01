import { visit } from "unist-util-visit"

class BaseRemarkPlugin
  constructor: (@type = "") ->
    if @process is BaseRemarkPlugin::process
      throw new Error("Child classes must implement the process method.")

    return @constructor.plugin

  process: ({node, index, parent, file}) ->
    throw new Error("process method must be implemented by subclasses.")

  plugin: ->
    (tree, file) =>
      visit tree, (node, index, parent) =>
        if @hasType node.type
          file.data = {} unless file.data
          @process(node: node, index: index, parent: parent, file: file)
        return

  hasType: (nodeType) ->
    @type = [ @type ] unless Array.isArray @type
    @type.includes nodeType

export default BaseRemarkPlugin
