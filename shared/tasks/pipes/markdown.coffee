import { remark } from "remark"
import { visit } from "unist-util-visit"

import rehypeStringify from "rehype-stringify";
import remarkFrontmatter from "remark-frontmatter";
import remarkParse from "remark-parse";
import remarkRehype from "remark-rehype";
import yaml from "js-yaml";

import PluginError from "plugin-error"
import TaskPipe from "~/tasks/pipes/task.coffee"

class MarkdownPipe extends TaskPipe
  @newInstance: (options = {}) =>
    new @ "markdown-pipe", options

  transpile: (file, contents, options = {}) ->
    try
      processedFile = remark()
        .use remarkFrontmatter
        .use () => (tree, treeFile) =>
          visit tree, "yaml", (node, index, parent) =>
            parent.children.splice(index, 1)
            treeFile.frontmatter = yaml.load(node.value)
        .use remarkParse
        .use remarkRehype
        .use rehypeStringify
        .processSync contents
      console.log processedFile.value

      return
        data:
          frontmatter: processedFile.frontmatter
          html: processedFile.value

    catch error
      @pipeError file.path, error.message
      return { file, contents }


export default MarkdownPipe.newInstance
