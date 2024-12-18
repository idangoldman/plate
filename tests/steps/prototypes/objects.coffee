import { Given, When, Then } from "@cucumber/cucumber"
import { expect } from "chai"

Given "I have an object", (jsonString) ->
  @input = JSON.parse(jsonString)

When "I convert all keys to {string}", (caseType) ->
  @result = @input.toCaseKeys caseType

Then "I should get an object", (jsonString) ->
  expectedObject = JSON.parse(jsonString)
  expect(@result).to.deep.equal(expectedObject)
