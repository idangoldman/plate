import { Given, When, Then } from "@cucumber/cucumber"
import { expect } from "chai"

import capitalize from "#root/helpers/capitalize.js"

# String Case Conversion Steps
Given "I have a string {string}", (input) ->
  @input = input

When "I convert it to {string} case", (caseType) ->
  @result = @input["to#{capitalize caseType}Case"]()

Then "I should get {string}", (expected) ->
  expect(@result).to.equal(expected)

# Object Case Conversion Steps
Given "I have an object", (jsonString) ->
  @input = JSON.parse(jsonString)

When "I convert all keys to {string}", (caseType) ->
  @result = @input.toCaseKeys caseType

Then "I should get an object", (jsonString) ->
  expectedObject = JSON.parse(jsonString)
  expect(@result).to.deep.equal(expectedObject)
