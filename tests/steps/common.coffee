import { Given, Then } from "@cucumber/cucumber"
import { expect } from "chai"
import { NUMBER_CONTENT, ARRAY_CONTENT, OBJECT_CONTENT } from "#root/helpers/regex.js"

Given "the following inputs:", (table) ->
  @input = {}

  for { name, value } in table.hashes()
    @input[name] = JSON.parse(value)

Then "I should get {string} as the result", (expected) ->
  switch true
    when expected is "undefined"
      expect(@result).to.be.undefined

    when expected is "true"
      expect(@result).to.be.true

    when expected is "false"
      expect(@result).to.be.false

    when NUMBER_CONTENT.test(expected)
      expect(@result).to.equal(parseInt(expected))

    when ARRAY_CONTENT.test(expected)
      expect(@result).to.deep.equal(JSON.parse(expected))

    when OBJECT_CONTENT.test(expected)
      expect(@result).to.deep.equal(JSON.parse(expected))

    else
      expect(@result).to.equal(expected)
