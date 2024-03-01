import { visit } from "unist-util-visit"
import { remark } from "remark"
import rehypeStringify from "rehype-stringify"
import remarkFrontmatter from "remark-frontmatter"
import remarkParse from "remark-parse"
import remarkRehype from "remark-rehype"

import TaskPipe from "~/tasks/pipes/task.coffee"
import AssetsFullUrlRemarkPlugin from "@/tools/remark/assets-full-url.coffee"
import FrontmatterRemarkPlugin from "@/tools/remark/frontmatter.coffee"
import ExcerptRemarkPlugin from "@/tools/remark/excerpt.coffee"

class MarkdownPipe extends TaskPipe
  @newInstance: (options = {}) =>
    new @ "markdown-pipe", options

  transpile: ({ file, contents }) ->
    processedFile = remark()
        .use remarkFrontmatter
        .use remarkParse
        .use FrontmatterRemarkPlugin
        .use AssetsFullUrlRemarkPlugin, { permalink: file.data.permalink }
        .use ExcerptRemarkPlugin
        # .use () => (tree, file) =>
        #   visit tree, (node, index, parent) =>
        #     console.log node
        #   return
        .use remarkRehype
        .use rehypeStringify
      .processSync contents

    # console.log processedFile

    Promise.resolve data:
      assets: processedFile.assets || []
      frontmatter: processedFile.frontmatter || {}
      html: processedFile.value

export default MarkdownPipe.newInstance
