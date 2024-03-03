import {Given, When, Then} from "@cucumber/cucumber"
import { expect } from "chai"

input = null
result = null
caught = null

Given "I have the string {string}", (string) ->
  input = string
  result = null
  caught = null

When "I convert it to {word} case", (caseType) ->
  try
    switch caseType
      when "camel" then result = input.toCamelCase()
      when "snake" then result = input.toSnakeCase()
      when "kebab" then result = input.toKebabCase()
      when "pascal" then result = input.toPascalCase()
      when "constant" then result = input.toConstantCase()
      when "dot" then result = input.toDotCase()
      when "path" then result = input.toPathCase()
      when "sentence" then result = input.toSentenceCase()
      when "title" then result = input.toTitleCase()
      else throw new Error "Case type #{caseType} is not supported"
  catch error
    caught = error

When "I attempt to convert it to {string} case", (caseType) ->
  # This step is intentionally left blank for clarity in the feature file
  # It's covered by the previous step's error handling

Then "the result should be {string}", (expectedResult) ->
  expect(result).to.equal expectedResult

Then "I should receive an error message {string}", (expectedError) ->
  expect(caught?.message).to.equal expectedError
