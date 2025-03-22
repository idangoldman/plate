import { Given, When, Then } from "@cucumber/cucumber"
import { expect } from "chai"

Given "the following values:", (table) ->
  @values = {}

  for { name, value } in table.hashes()
    @values[name] = JSON.parse(value)

When "I check the type of {string}", (name) ->
  @result = {
    isArray: @values[name].isArray(),
    isObject: @values[name].isObject(),
    isString: @values[name].isString()
  }

When "I check if {string} is empty", (name) ->
  @result = @values[name].isEmpty()

Then "it should be one of:", (table) ->
  expected = table.rowsHash()

  for key, value of expected
    expect(@result[key]).to.equal(value is "true")

Then "it should be {string}", (expected) ->
  expect(@result).to.equal(expected is "true")
