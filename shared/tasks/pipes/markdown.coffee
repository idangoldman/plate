import { remark } from "remark"
import { URL } from "node:url"
import { visit } from "unist-util-visit"
import rehypeStringify from "rehype-stringify"
import remarkFrontmatter from "remark-frontmatter"
import remarkParse from "remark-parse"
import remarkRehype from "remark-rehype"
import TaskPipe from "~/tasks/pipes/task.coffee"

import FrontmatterRemarkPlugin from "@/tools/remark/frontmatter.coffee"
import AssetsFullUrlRemarkPlugin from "@/tools/remark/assets-full-url.coffee"

class MarkdownPipe extends TaskPipe
  @newInstance: (options = {}) =>
    new @ "markdown-pipe", options

  transpile: (file, contents, options = {}) ->
    processedFile = remark()
        .use remarkFrontmatter
        .use FrontmatterRemarkPlugin
        .use AssetsFullUrlRemarkPlugin
        .use remarkParse
        .use remarkRehype
        .use rehypeStringify
      .processSync file

    Promise.resolve data:
      assets: processedFile.data?.assets || []
      frontmatter: processedFile.data?.frontmatter || {}
      html: processedFile.value

export default MarkdownPipe.newInstance
