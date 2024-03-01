import BaseRemarkPlugin from "@/tools/remark/base.coffee"
import yaml from "js-yaml"

class FrontmatterRemarkPlugin extends BaseRemarkPlugin
  type: "yaml"

  process: ({node, index, parent, file}) ->
    parent.children.splice(index, 1)
    file["frontmatter"] = yaml.load(node.value) || {}

export default new FrontmatterRemarkPlugin().use
