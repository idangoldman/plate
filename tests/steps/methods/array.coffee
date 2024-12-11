import { Given, When, Then } from "@cucumber/cucumber"
import { expect } from "chai"

import { ARRAY_CONTENT, OBJECT_CONTENT } from "#root/helpers/regex.js"

Given "an array {string}", (input) ->
  @input = JSON.parse input

When "call the {string} method on the array", (methodName) ->
  @result = @input[methodName]()

When "call the {string} method with {string} on the array", (methodName, arg) ->
  @result = @input[methodName](JSON.parse arg)

Then "return {string} as the result", (expected) ->
  switch expected
    when "undefined"
      expect(@result).to.be.undefined
    when "true"
      expect(@result).to.be.true
    when "false"
      expect(@result).to.be.false
    when ARRAY_CONTENT.test(expected)
      expect(@result).to.deep.equal(JSON.parse(expected))
    when OBJECT_CONTENT.test(expected)
      expect(@result).to.deep.equal(JSON.parse(expected))
    else
      expect(@result).to.equal(parseInt(expected))
