import { remark } from "remark"
import { visit } from "unist-util-visit"

import rehypeStringify from "rehype-stringify";
import remarkFrontmatter from "remark-frontmatter";
import remarkParse from "remark-parse";
import remarkRehype from "remark-rehype";
import yaml from "js-yaml";

import PluginError from "plugin-error"
import TaskPipe from "./task.coffee"

class MarkdownPipe extends TaskPipe
  @newInstance: (options = {}) =>
    new @ "markdown-pipe", options

  transpile: (filePath, contents, options = {}) ->
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

      # file.data = processedFile.frontmatter;
      # filePath = filePath.replace(/\.md$/, ".html")
    catch error
      throw new PluginError "markdown-pipe", "Transpilation failed: #{error.message}", { showStack: true }

    return { filePath, contents }

export default MarkdownPipe.newInstance
