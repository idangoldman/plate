import BaseRemarkPlugin from "@/tools/remark/base.coffee"

# HTML_COMMENT_REGEX = new RegExp "<!--\s*(?<comment>.+)\s*-->", "gm"
HTML_COMMENT_REGEX = new RegExp "<!--\s*(?<comment>\S+.*?)\s*-->", "gm"

class ExcerptRemarkPlugin extends BaseRemarkPlugin
  type: "html"
  excerpt: ""
  excerptIndex: -1
  identifiers: [
    "EXCERPT",
    "INTRO",
    "READMORE"
    "SUMMARY",
    "TLDR",
  ]

  process: ({ node, index, parent, file }) ->
    if @excerptIndex is -1 && @hasExcerpt node.value
      @excerptIndex = index
      # console.log parent.children.splice(index, 1)

  hasExcerpt: (value) ->
    console.log value, [...value.matchAll(HTML_COMMENT_REGEX)]
    try
      comment = [...value.matchAll(HTML_COMMENT_REGEX)]
      console.log comment[0].groups.comment

      if @identifiers.includes comment.toUpperCase()
        @excerpt = comment
        return true

      throw new Error "No match"
    catch error
      return false


export default new ExcerptRemarkPlugin().use
