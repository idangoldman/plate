import { When, Then } from "@cucumber/cucumber"

When "I call the {string} method on the {string} array", (methodName, arrayName) ->
  @result = @input[arrayName][methodName]()

When "I call the {string} method on the {string} array with value {string}", (methodName, arrayName, arg) ->
  @result = @input[arrayName][methodName](JSON.parse arg)
