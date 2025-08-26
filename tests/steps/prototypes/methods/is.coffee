import { When, Then } from "@cucumber/cucumber"
import { expect } from "chai"

When "I check the type of {string}", (name) ->
  @result = {
    isArray: @input[name].isArray(),
    isObject: @input[name].isObject(),
    isString: @input[name].isString()
  }

When "I check if {string} is empty", (name) ->
  @result = @input[name].isEmpty()

Then "it should be one of:", (table) ->
  expected = table.rowsHash()

  for key, value of expected
    expect(@result[key]).to.equal(value is "true")

Then "it should be {string}", (expected) ->
  expect(@result).to.equal(expected is "true")
