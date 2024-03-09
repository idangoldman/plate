import BaseRemarkPlugin from "@/tools/remark/base.coffee"
import YAML from "yaml"

class FrontmatterRemarkPlugin extends BaseRemarkPlugin
  type: "yaml"

  process: ({node, index, parent, file}) ->
    parent.children.splice(index, 1)
    file["frontmatter"] = YAML.parse(node.value) || {}

export default new FrontmatterRemarkPlugin().use
