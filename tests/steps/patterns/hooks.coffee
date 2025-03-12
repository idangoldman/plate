import { Given, When, Then } from "@cucumber/cucumber"
import { expect } from "chai"
import Hooks from "#root/patterns/hooks.js"

Given "a simple test object with methods", ->
  @hookExecutions = []
  @testObject =
    greet: (name) -> "Hello, #{name}"
    farewell: (name) -> "Goodbye, #{name}"

When "I add a {string} hook to the {string} method", (hookType, methodName) ->
  switch hookType
    when "before"
      Hooks.before @testObject, methodName, ->
        @hookExecutions.push "before-#{methodName}"
    when "after"
      Hooks.after @testObject, methodName, (result) ->
        @hookExecutions.push "after-#{methodName}"
        result
    when "around"
      Hooks.around @testObject, methodName, (original, args...) ->
        @hookExecutions.push "around-start-#{methodName}"
        result = original(args...)
        @hookExecutions.push "around-end-#{methodName}"
        result

  # Apply the hook to the method
  @testObject[methodName] = Hooks.wrapMethod(@testObject, methodName, @testObject[methodName])

When "I add an {string} hook to the {string} method that modifies the result", (hookType, methodName) ->
  switch hookType
    when "after"
      Hooks.after @testObject, methodName, (result) ->
        @hookExecutions.push "after-#{methodName}"
        "#{result}!!!"

  # Apply the hook to the method
  @testObject[methodName] = Hooks.wrapMethod(@testObject, methodName, @testObject[methodName])

When "I add an {string} hook to the {string} method that executes code before and after", (hookType, methodName) ->
  Hooks.around @testObject, methodName, (original, args...) ->
    @hookExecutions.push "around-start-#{methodName}"
    result = original(args...)
    @hookExecutions.push "around-end-#{methodName}"
    result.toUpperCase()

  # Apply the hook to the method
  @testObject[methodName] = Hooks.wrapMethod(@testObject, methodName, @testObject[methodName])

When "I add a {string} hook to both {string} and {string} methods", (hookType, method1, method2) ->
  Hooks.before @testObject, [method1, method2], ->
    @hookExecutions.push "before-shared"

  # Apply the hooks to both methods
  @testObject[method1] = Hooks.wrapMethod(@testObject, method1, @testObject[method1])
  @testObject[method2] = Hooks.wrapMethod(@testObject, method2, @testObject[method2])

When "I call the {string} method with {string}", (methodName, arg) ->
  @hookExecutions = [] unless @hookExecutions
  @result = @testObject[methodName](arg)

Then "the {string} hook should be executed", (hookType) ->
  switch hookType
    when "before"
      expect(@hookExecutions).to.include("before-greet")
    when "after"
      expect(@hookExecutions).to.include("after-greet")
    when "around"
      expect(@hookExecutions).to.include("around-start-greet")
      expect(@hookExecutions).to.include("around-end-greet")

Then "the method should return {string}", (expected) ->
  expect(@result).to.equal(expected)

Then "all hooks should be executed in the correct order", ->
  expectedOrder = [
    "before-greet",
    "around-start-greet",
    "around-end-greet",
    "after-greet"
  ]

  # Check if elements appear in the correct relative order
  for i in [0...expectedOrder.length-1]
    currentIndex = @hookExecutions.indexOf(expectedOrder[i])
    nextIndex = @hookExecutions.indexOf(expectedOrder[i+1])
    expect(currentIndex).to.be.lessThan(nextIndex,
      "Hook #{expectedOrder[i]} should execute before #{expectedOrder[i+1]}")

Then "the {string} hook should be executed for both methods", (hookType) ->
  expect(@hookExecutions).to.include("before-shared")
