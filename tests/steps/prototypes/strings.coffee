import { Given, When, Then } from "@cucumber/cucumber"
import { expect } from "chai"

import capitalize from "#root/helpers/capitalize.js"

Given "I have a string {string}", (input) ->
  @input = input

When "I convert it to {string} case", (caseType) ->
  @result = @input["to#{capitalize caseType}Case"]()

Then "I should get {string}", (expected) ->
  expect(@result).to.equal(expected)
