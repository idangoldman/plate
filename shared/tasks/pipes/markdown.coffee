import { remark } from "remark"
import { visit } from "unist-util-visit"
import rehypeStringify from "rehype-stringify"
import remarkFrontmatter from "remark-frontmatter"
import remarkParse from "remark-parse"
import remarkRehype from "remark-rehype"
import TaskPipe from "~/tasks/pipes/task.coffee"
import yaml from "js-yaml"

class MarkdownPipe extends TaskPipe
  @newInstance: (options = {}) =>
    new @ "markdown-pipe", options

  transpile: (file, contents, options = {}) ->
    try
      processedFile = remark()
        .use remarkFrontmatter
        # TODO: Remark frontmatter plugin
        # INFO: Remove the frontmatter from the tree and add it to the file object
        .use () => (tree, treeFile) =>
          visit tree, "yaml", (node, index, parent) =>
            parent.children.splice(index, 1)
            treeFile.frontmatter = yaml.load(node.value)
        .use remarkParse
        .use remarkRehype
        .use rehypeStringify
        .processSync contents

      Promise.resolve data:
        frontmatter: processedFile.frontmatter
        html: processedFile.value

    catch error
      @pipeError file.path, error.message
      { file }


export default MarkdownPipe.newInstance
