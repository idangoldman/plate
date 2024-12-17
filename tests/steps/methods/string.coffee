import { Given, When, Then } from "@cucumber/cucumber"
import { expect } from "chai"

Given "I have a string {string}", (input) ->
  @input = input

When "I convert it to {string} case", (caseType) ->
  @result = @input["to#{caseType.capitalize()}Case"]()

Then "I should get {string}", (expected) ->
  expect(@result).to.equal(expected)
