import { Given, When, Then } from "@cucumber/cucumber"
import { expect } from "chai"
import Arrays from "#root/prototypes/arrays.js"
import Hooks from "#root/patterns/hooks.js"

import { ARRAY_CONTENT, OBJECT_CONTENT } from "#root/helpers/regex.js"

Given "an array {string}", (input) ->
  @input = JSON.parse input

When "call the {string} method on the array", (methodName) ->
  @result = @input[methodName]()

When "call the {string} method with {string} on the array", (methodName, arg) ->
  @result = @input[methodName](JSON.parse arg)

Then "return {string} as the result", (expected) ->
  switch true
    when expected is "undefined"
      expect(@result).to.be.undefined

    when expected is "true"
      expect(@result).to.be.true

    when expected is "false"
      expect(@result).to.be.false

    when ARRAY_CONTENT.test(expected)
      expect(@result).to.deep.equal(JSON.parse(expected))

    when OBJECT_CONTENT.test(expected)
      expect(@result).to.deep.equal(JSON.parse(expected))

    else
      expect(@result).to.equal(parseInt(expected))

# We'll create a class to test our Array hooks
class TestArrayHooks extends Arrays
  @extends "Array"

  @around ["first", "last"], (fn, args...) ->
    if @isEmpty() then undefined else fn.apply(@, args)

  first: -> @[0]
  last: -> @[@length - 1]
  excludes: (element) -> not @includes(element)

Given "the Array prototype with hooks is applied", ->
  # Apply the array prototype
  TestArrayHooks.apply()

Given "I have an array {string}", (arrayStr) ->
  @array = JSON.parse(arrayStr)

Given "I have an empty array", ->
  @array = []

When "I call the {string} method", (method) ->
  @result = @array[method]()

When "I call the {string} method with {string}", (method, valueStr) ->
  value = JSON.parse(valueStr)
  @result = @array[method](value)

When "I check the hooks applied to {string}", (methodName) ->
  # Actually test the method to see if hooks take effect
  @methodName = methodName
  @result = @array[methodName]()

  # Create a non-empty array to compare behavior
  @nonEmptyArray = [1]
  @nonEmptyResult = @nonEmptyArray[methodName]()

Then "the array hook should handle empty arrays", ->
  # The hooks should cause empty array methods to return undefined
  expect(@result).to.be.undefined

  # While the same method on non-empty arrays should return a value
  # (either first or last element)
  expect(@nonEmptyResult).to.equal(1)
