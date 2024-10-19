import { Given, When, Then } from "@cucumber/cucumber"
import assert from "node:assert"
import pathResolver from "#root/transformers/resolver.js"

# import sinon from "sinon"
# sinon.stub(access)

Given "the environment variables are set as follows:", (dataTable) ->
  # envVars = dataTable.rowsHash()
  # Object.assign process.env, envVars

Given "the file {string} {word}", (filePath, existence) ->
  # if existence is "exists"
  #   access.withArgs(filePath, sinon.match.any).resolves()
  # else
  #   access
  #     .withArgs(filePath, sinon.match.any)
  #     .rejects(new Error("File does not exist"))

When "I resolve the path {string}", (specifier) ->
  # @resolvedPath = await pathResolver(specifier)

Then "the resolved path should be {string}", (expectedPath) ->
  # assert.equal @resolvedPath, expectedPath
