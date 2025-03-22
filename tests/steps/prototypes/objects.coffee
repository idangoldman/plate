import { Given, When, Then } from "@cucumber/cucumber"
import { expect } from "chai"

Given "I have an object", (jsonString) ->
  @input = JSON.parse(jsonString)

When "I convert all keys of the object to {word} format", (caseType) ->
  @result = @input["to#{caseType}"]()

Then "I should get an object", (jsonString) ->
  expectedObject = JSON.parse(jsonString)
  expect(@result).to.deep.equal(expectedObject)
