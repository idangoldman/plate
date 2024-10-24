import {Given, When, Then} from "@cucumber/cucumber"
import assert from "node:assert/strict"
import pathResolver from "#root/transformers/resolver.js"

Given "the environment variables are set to:", (dataTable) ->
  @saveEnvironmentState()

  envVars = dataTable.rowsHash()
  process.env[key] = value for key, value of envVars

Given "the environment variables are not set", ->
  @saveEnvironmentState()

  delete process.env.PLATE_PRJ_PATH
  delete process.env.PLATE_PKG_PATH

When "I resolve the path specifier {string}", (input) ->
  try
    @result = pathResolver input
    @error = null
  catch err
    @error = err
    @result = null

Then "the result should be {string}", (expected) ->
  assert.equal @error, null, "Expected no error to be thrown"
  assert.equal @result, expected, "Path resolution did not match expected result"

Then "it should throw an error containing {string}", (errorMessage) ->
  assert @error?, "Expected an error to be thrown"
  assert @error.message.includes(errorMessage), "Error message '#{@error.message}' does not contain '#{errorMessage}'"
