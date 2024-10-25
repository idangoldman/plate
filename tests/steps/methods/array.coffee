import { Given, When, Then } from "@cucumber/cucumber"
import { expect } from "chai"

Given "an array {string}", (input) ->
  @input = JSON.parse input

When "call the {string} method on the array", (methodName) ->
  @result = @input[methodName]()

Then "return {string} as the result", (expected) ->
  switch expected
    when "undefined"
      expect(@result).to.be.undefined
    else
      expect(@result).to.equal(parseInt(expected))
