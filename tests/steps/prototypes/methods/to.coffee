import { When, Then } from "@cucumber/cucumber"
import { expect } from "chai"

When "I chain {string} and {string} methods on the {string} value", (method1, method2, valueName) ->
  @result = @input[valueName][method1]()[method2]()

When "I call the {string} method on the {string} value", (methodName, valueName) ->
  try
    @result = @input[valueName]?[methodName]?()
    @error = null
  catch err
    @error = err
    @result = null

Then "the result should contain key-value pairs for nested structure", ->
  # For nested objects converted to arrays, we expect key-value pair arrays
  expect(@result).to.be.an('array')
  expect(@result.length).to.be.greaterThan(0)

  # Each element should be a key-value pair for object properties
  for item in @result
    expect(item).to.be.an('array')
    expect(item.length).to.equal(2)

Then "it should handle the conversion safely", ->
  # Should not throw an error, might return default values
  expect(@error).to.be.null
  expect(@result).to.not.be.undefined
