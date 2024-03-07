import { inspect } from "unist-util-inspect"
import { remark } from "remark"
import { visit } from "unist-util-visit"
import rehypeStringify from "rehype-stringify"
import remarkFrontmatter from "remark-frontmatter"
import remarkParse from "remark-parse"
import remarkRehype from "remark-rehype"

import AssetsFullUrlRemarkPlugin from "@/tools/remark/assets-full-url.coffee"
import ExcerptRemarkPlugin from "@/tools/remark/excerpt.coffee"
import FrontmatterRemarkPlugin from "@/tools/remark/frontmatter.coffee"
import TaskPipe from "~/tasks/pipes/task.coffee"

class MarkdownPipe extends TaskPipe
  @newInstance: (options = {}) =>
    new @ "markdown-pipe", options

  transpile: ({ file, contents }) ->
    processedFile = remark()
        .use remarkParse
        .use remarkFrontmatter
        .use FrontmatterRemarkPlugin
        .use AssetsFullUrlRemarkPlugin, { permalink: file.data.permalink }
        .use remarkRehype, { allowDangerousHtml: true }
        .use ExcerptRemarkPlugin
        # .use () => (tree, file) =>
        #   console.log inspect tree
        #   visit tree, (node, index, parent) =>
        #     console.log node
        #     console.log inspect tree
        #   return
        .use rehypeStringify
      .processSync contents

    # console.log processedFile

    Promise.resolve
      contents: processedFile.value
      data:
        assets: processedFile.assets || []
        frontmatter: processedFile.frontmatter || {}
        html: processedFile.value

export default MarkdownPipe.newInstance
