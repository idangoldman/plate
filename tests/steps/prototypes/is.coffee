import { Given, When, Then } from "@cucumber/cucumber"
import { expect } from "chai"

import { ARRAY_CONTENT, OBJECT_CONTENT, STRING_CONTENT } from "#root/helpers/regex.js"
Given "an instance of {string}", (input) ->
  try
    switch input
      when STRING_CONTENT.test(input)
        @input = input
      else
        @input = JSON.parse input
  catch error
    @input = eval input

When "check all prototype methods", () ->
  console.log @input
  @result = Object.getOwnPropertyNames(@input.__proto__)
  expect(@result).to.include.members(["isArray", "isObject", "isString"])

When "call the isEmpty method on the instance", () ->
  @result = @input.isEmpty()

Then "return {string} boolean as the result", (expected) ->
  switch expected
    when "true"
      expect(@result).to.be.true
    when "false"
      expect(@result).to.be.false
    else
      throw new Error("Invalid expected value: #{expected}")

Then "the results should be isArray: {string}, isObject: {string}, and isString: {string}", (isArray, isObject, isString) ->
  expect(@input.isArray()).to.equal(isArray == "true")
  expect(@input.isObject()).to.equal(isObject == "true")
  expect(@input.isString()).to.equal(isString == "true")
