import { Given, When, Then } from "@cucumber/cucumber"
import { expect } from "chai"
import Functions from "#root/prototypes/functions.js"

Given "the Functions prototype is applied", ->
  Functions.apply()

Given "I have a function that calculates a value", ->
  @successFunction = (a, b) -> a + b

Given "I have a function that throws an error", ->
  @failingFunction = ->
    throw new Error("Deliberate test error")

Given "I have an asynchronous function that returns a promise", ->
  @asyncFunction = (value) ->
    new Promise (resolve) ->
      setTimeout(->
        resolve(value * 2)
      , 50)

When "I call the function using the {string} method", (methodName) ->
  try
    if methodName is "safely"
      @result = @successFunction?[methodName]?(5, 3)
      @errorResult = @failingFunction?[methodName]?()
    else
      @result = @successFunction?[methodName]?(5, 3)

      try
        @errorResult = @failingFunction?[methodName]?()
      catch error
        @caughtError = error
  catch error
    @error = error

When "I call the async function using the {string} method", (methodName) ->
  @asyncResult = @asyncFunction?[methodName]?(10)

Then "I should receive an array with [null, result]", ->
  expect(@result).to.be.an("array")
  expect(@result[0]).to.be.null
  expect(@result[1]).to.equal(8)

Then "I should receive an array with [error, null]", ->
  expect(@errorResult).to.be.an("array")
  expect(@errorResult[0]).to.be.an("error")
  expect(@errorResult[0].message).to.include("Deliberate test error")
  expect(@errorResult[1]).to.be.null

Then "I should receive only the result", ->
  expect(@result).to.equal(8)

Then "I should receive null", ->
  expect(@errorResult).to.be.null

Then "I should receive the result", ->
  expect(@result).to.equal(8)

Then "the error should be thrown", ->
  expect(@caughtError).to.be.an("error")
  expect(@caughtError.message).to.include("Deliberate test error")

Then "I should receive true", ->
  expect(@result).to.be.true

Then "I should receive false", ->
  expect(@errorResult).to.be.false

Then "I should receive a promise that resolves to [null, result]", ->
  result = await @asyncResult
  expect(result).to.be.an("array")
  expect(result[0]).to.be.null
  expect(result[1]).to.equal(20)
