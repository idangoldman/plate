import BaseRemarkPlugin from "@/tools/remark/base.coffee"
import { h } from "hastscript"

HTML_COMMENT_REGEX = new RegExp "<!--\\s*(?<comment>\\S+.*?)\\s*-->", "gm"
HTML_HEADING_TAGNAME_REGEX = new RegExp "^h[1-6])$", "gm"

class ExcerptRemarkPlugin extends BaseRemarkPlugin
  type: "html"
  identifiers: [
    "EXCERPT"
    "INTRO"
    "READMORE"
    "SUMMARY"
    "TLDR"
  ]

  process: ({ node, index, parent, file, options }) ->
    if @hasExcerpt node.value
      startIndex = @findStartIndex index, parent.children
      sectionNodes = parent.children.slice startIndex, index
      sectionClassName = "excerpt--#{@slugify @getExcerpt(node.value)}"

      excerptNode = h "section", { className: sectionClassName }, sectionNodes
      parent.children.splice startIndex, index - startIndex, excerptNode

  getExcerpt: (value) ->
    try
      foundIdentifier = value.matchAll(HTML_COMMENT_REGEX).next().value.groups.comment

      if @identifiers.includes foundIdentifier.toUpperCase()
        return foundIdentifier

      throw new Error
    catch error
      return undefined

  hasExcerpt: (value) ->
    @getExcerpt(value) isnt undefined

  findStartIndex: (index, siblings) ->
    for siblingIndex in [(endIndex - 1)..0] by -1
      sibling = siblings[siblingIndex]

      if sibling.type is "html" or HTML_HEADING_TAGNAME_REGEX.test(sibling.tagName) or siblingIndex is 0
        startIndex = siblingIndex
        break

    startIndex

  slugify: (value) ->
    value.toLowerCase()
      .replace /\s+/g, "-"
      .replace /[^a-z0-9-]/ig, ""
      .replace /-+/g, "-"
      .replace /^-|-$/g, ""

export default new ExcerptRemarkPlugin().use
