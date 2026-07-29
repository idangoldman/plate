import { Given, When } from "@cucumber/cucumber"
import { expect } from "chai" # expect is not used here, but often in Then steps

# Common Given step for string operations
Given "the string {string}", (inputStr) ->
  if inputStr == "undefined"
    @subjectString = ""
  else
    @subjectString = inputStr

# For single method calls like "capitalize"
When "I call the {string} method on the string", (methodName) ->
  if typeof @subjectString[methodName] isnt "function"
    throw new Error("Method '#{methodName}' does not exist on string '#{@subjectString}'")
  @result = @subjectString[methodName]()

# For "times" method
When "I multiply the string by {string}", (nValue) -> # Changed step pattern
  # @subjectString is already set by the Given step.
  n_arg = nValue # Pass the raw string from the feature file. Let `times` method parse it.
  if nValue == "undefined" # check for literal string "undefined"
    n_arg = undefined
  else if nValue == "NaN"
    n_arg = NaN
  # No need to parseInt here, method does it.
  @result = @subjectString.times(n_arg)
