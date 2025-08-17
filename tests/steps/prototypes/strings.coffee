import { Given, When } from "@cucumber/cucumber"
import { expect } from "chai"

import capitalize from "#root/helpers/capitalize.js"

Given "I have a string {word}", (input) ->
  @input = input

When "I convert it to {word} case", (caseType) ->
  @result = @input["to#{capitalize caseType}Case"]()

When "I call the capitalize method on it", ->
  @result = @input.capitalize()
