import { Given, When, Then } from "@cucumber/cucumber"
import { expect } from "chai"
import expectedValueParser from "#root/tests/support/expected-value-parser.js"

Given "the following inputs:", (table) ->
  @input = {}

  for { name, value } in table.hashes()
    @input[name] = expectedValueParser(value).value

When "{word} method is called on {word}", (method, name) ->
  try
    @result = @input[name][method]()
    @error = null
  catch err
    @error = err
    @result = null

When "{word} method is called on {word} with {int}", (method, name, argument) ->
  try
    @result = @input[name][method](argument)
    @error = null
  catch err
    @error = err
    @result = null


Then "I should get {expectedValue} as the result", (expected) ->
  { type, value } = expected

  switch type
    when "boolean"
      expect(@result).to.be.a 'boolean', "Expected result to be boolean but got #{typeof @result}"
      expect(@result).to.equal value, "Expected boolean value to be #{value} but got #{@result}, error: #{@error?.message}"

    when "null"
      expect(@result).to.be.a "null", "Expected result to be null but got #{typeof @result}"
      expect(@result).to.equal value, "Expected boolean value to be #{value} but got #{@result}, error: #{@error?.message}"

    when "undefined"
      expect(@result).to.be.a "undefined", "Expected result to be undefined but got #{typeof @result}"
      expect(@result).to.equal value, "Expected boolean value to be #{value} but got #{@result}, error: #{@error?.message}"

    when "number"
      expect(@result).to.be.a 'number', "Expected result to be number but got #{typeof @result}"
      expect(@result).to.equal value, "Expected boolean value to be #{value} but got #{@result}, error: #{@error?.message}"

    when "string"
      expect(@result).to.be.a 'string', "Expected result to be string but got #{typeof @result}"
      expect(@result).to.equal value, "Expected boolean value to be #{value} but got #{@result}, error: #{@error?.message}"

    when "array"
      expect(@result).to.be.an 'array', "Expected result to be array but got #{typeof @result}"
      expect(@result).to.not.be.an 'object', "Expected result to be array but got object"
      expect(@result).to.deep.equal value, "Expected boolean value to be #{value} but got #{@result}, error: #{@error?.message}"

    when "object"
      expect(@result).to.be.an 'object', "Expected result to be object but got #{typeof @result}"
      expect(@result).to.not.be.an 'array', "Expected result to be object but got array"
      expect(@result).to.deep.equal value, "Expected boolean value to be #{value} but got #{@result}, error: #{@error?.message}"

    else
      throw new Error("Unsupported expected type: #{type}")
