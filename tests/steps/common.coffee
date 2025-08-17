import { Given, Then } from "@cucumber/cucumber"
import { expect } from "chai"
import { NUMBER_CONTENT, ARRAY_CONTENT, OBJECT_CONTENT } from "#root/helpers/regex.js"

Given "the following inputs:", (table) ->
  @input = {}

  for { name, value } in table.hashes()
    @input[name] = JSON.parse value

Then "I should get {expectedValue} as the result", (expected) ->
  { type, value } = expected

  switch type
    when "boolean"
      expect(@result).to.be.a 'boolean', "Expected result to be boolean but got #{typeof @result}"
      expect(@result).to.equal value

    when "null"
      expect(@result).to.be.a "null", "Expected result to be null but got #{typeof @result}"
      expect(@result).to.equal value

    when "undefined"
      expect(@result).to.be.a "undefined", "Expected result to be undefined but got #{typeof @result}"
      expect(@result).to.equal value

    when "number"
      expect(@result).to.be.a 'number', "Expected result to be number but got #{typeof @result}"
      expect(@result).to.equal value

    when "string"
      expect(@result).to.be.a 'string', "Expected result to be string but got #{typeof @result}"
      expect(@result).to.equal value

    when "array"
      expect(@result).to.be.an 'array', "Expected result to be array but got #{typeof @result}"
      expect(@result).to.not.be.an 'object', "Expected result to be array but got object"
      expect(@result).to.deep.equal value

    when "object"
      expect(@result).to.be.an 'object', "Expected result to be object but got #{typeof @result}"
      expect(@result).to.not.be.an 'array', "Expected result to be object but got array"
      expect(@result).to.deep.equal value

    else
      throw new Error("Unsupported expected type: #{type}")
