import BaseRemarkPlugin from "@/tools/remark/base.coffee"
import { h } from "hastscript"

HTML_COMMENT_REGEX = new RegExp "<!--\\s*(?<comment>\\S+.*?)\\s*-->", "gm"
HTML_HEADING_REGEX = new RegExp "^h[1-6]$", "gm"

class ExcerptRemarkPlugin extends BaseRemarkPlugin
  type: "raw"
  excerpt: undefined
  identifiers: [
    "EXCERPT"
    "INTRO"
    "READMORE"
    "SUMMARY"
    "TLDR"
  ]

  process: ({ node, index, parent, file, options }) ->
    @excerpt = @getExcerpt node.value

    if @excerpt
      endIndex = index
      startIndex = @findStartIndex endIndex, parent.children
      sectionNodes = parent.children.slice startIndex, endIndex

      excerptNode = h "section", { class: @getExcerpCssClass() }, sectionNodes
      parent.children.splice startIndex, endIndex + 1 - startIndex, excerptNode

  getExcerpt: (value) ->
    try
      foundIdentifier = value.matchAll(HTML_COMMENT_REGEX).next().value.groups.comment

      if @identifiers.includes foundIdentifier.toUpperCase()
        return foundIdentifier

      throw new Error
    catch error
      return undefined

  findStartIndex: (endIndex, siblings) ->
    for siblingIndex in [(endIndex - 1)..0] by -1
      sibling = siblings[siblingIndex]

      if HTML_HEADING_REGEX.test sibling.tagName or siblingIndex is 0
        startIndex = siblingIndex
        break

    startIndex

  getExcerpCssClass: ->
    slugified = @excerpt
      .toLowerCase()
      .replace /\s+/g, "-"
      .replace /[^a-z0-9-]/ig, ""
      .replace /-+/g, "-"
      .replace /^-|-$/g, ""

    "excerpt--#{slugified}"

export default new ExcerptRemarkPlugin().use
