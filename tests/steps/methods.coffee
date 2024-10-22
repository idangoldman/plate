import { Given, When, Then } from "@cucumber/cucumber"
import { expect } from "chai"
import "#root/methods/defaults.js"

Given "I have imported the {string} prototype methods", (className) ->
  expect(className).to.be.oneOf(["String", "Object", "Array"])

# String Case Conversion Steps
Given "I have a string {string}", (input) ->
  @input = input

When "I convert it to {string} case", (caseType) ->
  @result = @input["to#{caseType.charAt(0).toUpperCase() + caseType.slice(1)}Case"]()

Then "I should get {string}", (expected) ->
  expect(@result).to.equal(expected)

# Object Case Conversion Steps
Given "I have an object", (jsonString) ->
  @input = JSON.parse(jsonString)

When "I convert all keys to {string}", (caseType) ->
  @result = JSON.parse(JSON.stringify(@input))["to#{caseType}CaseKeys"]()

Then "I should get an object", (jsonString) ->
  expectedObject = JSON.parse(jsonString)
  expect(@result).to.deep.equal(expectedObject)

# Array Method Steps
Given "I have an array {string}", (input) ->
  @input = eval(input) # Note: eval used for test data only

When "I call the {string} method", (methodName) ->
  @result = @input[methodName]()

Then "I should get {string}", (expected) ->
  switch expected
    when "undefined"
      expect(@result).to.be.undefined
    when /^".*"$/
      expect(@result).to.equal(expected.replace(/"/g, ""))
    else
      expect(@result).to.equal(parseInt(expected))
