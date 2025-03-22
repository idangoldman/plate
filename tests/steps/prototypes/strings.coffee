import { Given, When, Then } from "@cucumber/cucumber"
import { expect } from "chai"

import capitalize from "#root/helpers/capitalize.js"

Given "I have a string {string}", (input) ->
  @input = input

When "I convert it to {string} case", (caseType) ->
  @result = @input["to#{capitalize caseType}Case"]()

When "I call the capitalize method on it", ->
  @result = @input.capitalize()

Then "I should get {string} string", (expected) ->
  if expected is "undefined"
    expect(@result).to.be.undefined
  else if expected is "true"
    expect(@result).to.be.true
  else if expected is "false"
    expect(@result).to.be.false
  else
    if /^\d+\.\d+$/.test(expected)
      expected = parseInt(expected)

    expect(@result).to.equal(expected)
