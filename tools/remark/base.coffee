import visit from "unist-util-visit"

class BaseRemarkPlugin
  type = undefined
  constructor: ->
    if @process is BaseRemarkPlugin::process
      throw new Error("Child classes must implement the process method.")

  process: ({node, index, parent, file}) ->
    throw new Error("process method must be implemented by subclasses.")

  getPlugin: ->
    (tree, file) =>
      visit tree, (node, index, parent) =>
        if @isCorrectType node.type
          file.data = {} unless file.data
          @process(node: node, index: index, parent: parent, file: file)
        return

  isCorrectType: (nodeType) ->
    @type = [ @type ] unless Array.isArray @type
    @type.includes nodeType

export default BaseRemarkPlugin
