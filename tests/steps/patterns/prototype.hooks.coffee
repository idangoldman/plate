import { Given, When, Then } from "@cucumber/cucumber"
import { expect } from "chai"
import Prototypes from "#root/patterns/prototypes.js"
import Hooks from "#root/patterns/hooks.js"

# Test class with class-level hooks
class TestClassWithHooks extends Prototypes
  @extends "Object"

  # Execution log for testing hook order
  @executionLog = []

  # Class-level hooks
  @before ["firstMethod", "secondMethod"], ->
    TestClassWithHooks.executionLog.push("before-hook-executed")

  @after ["firstMethod", "secondMethod"], (result) ->
    TestClassWithHooks.executionLog.push("after-hook-executed")
    "#{result}-after"

  @around ["firstMethod", "secondMethod"], (original, args...) ->
    TestClassWithHooks.executionLog.push("around-hook-start")
    result = original.apply(@, args)
    TestClassWithHooks.executionLog.push("around-hook-end")
    "#{result}-around"

  @around "validateMethod", (original, value) ->
    if !value or value.length is 0
      TestClassWithHooks.executionLog.push("validation-failed")
      "Invalid"
    else
      TestClassWithHooks.executionLog.push("validation-passed")
      original.call(@, value)

  # Class methods
  firstMethod: (arg) -> "first-#{arg}"
  secondMethod: (arg) -> "second-#{arg}"
  validateMethod: (value) -> "Valid-#{value}"

# Test class with multiple hooks
class TestClassWithMultipleHooks extends Prototypes
  @extends "Object"

  # Execution log
  @executionLog = []

  # Multiple hooks on same method
  @before "compositMethod", ->
    TestClassWithMultipleHooks.executionLog.push("before-1")

  @before "compositMethod", ->
    TestClassWithMultipleHooks.executionLog.push("before-2")

  @around "compositMethod", (original) ->
    TestClassWithMultipleHooks.executionLog.push("around-start")
    result = original.call(@)
    TestClassWithMultipleHooks.executionLog.push("around-end")
    "#{result}-around"

  @after "compositMethod", (result) ->
    TestClassWithMultipleHooks.executionLog.push("after-1")
    "#{result}-after1"

  @after "compositMethod", (result) ->
    TestClassWithMultipleHooks.executionLog.push("after-2")
    "#{result}-after2"

  # Method
  compositMethod: -> "original"

Given "a prototype class with class-level hooks is defined", ->
  # Reset execution logs
  TestClassWithHooks.executionLog = []
  TestClassWithMultipleHooks.executionLog = []

  # Apply the prototypes
  TestClassWithHooks.apply()
  TestClassWithMultipleHooks.apply()

When "I instantiate the class", ->
  @instance = {}  # We don't actually need to instantiate since we're extending Object

When "I instantiate the class with multiple hooks", ->
  @multiHookInstance = {}

When "I call the method {string} with argument {string}", (methodName, arg) ->
  TestClassWithHooks.executionLog = []
  @result = @instance[methodName](arg)

When "I call the method {string} with invalid argument {string}", (methodName, arg) ->
  TestClassWithHooks.executionLog = []
  @result = @instance[methodName](arg)

When "I call the method {string} with valid argument {string}", (methodName, arg) ->
  TestClassWithHooks.executionLog = []
  @result = @instance[methodName](arg)

When "I call the method {string}", (methodName) ->
  TestClassWithMultipleHooks.executionLog = []
  @multiHookResult = @multiHookInstance[methodName]()

Then "the before hook should execute", ->
  expect(TestClassWithHooks.executionLog).to.include("before-hook-executed")

Then "the before hook should execute again", ->
  expect(TestClassWithHooks.executionLog).to.include("before-hook-executed")

Then "the method should return the expected result", ->
  if @result.includes("first")
    expect(@result).to.include("first-test")
  else
    expect(@result).to.include("second-test")

  # The result should also have after and around hook modifications
  expect(@result).to.include("-after")
  expect(@result).to.include("-around")

Then "the after hook should execute", ->
  expect(TestClassWithHooks.executionLog).to.include("after-hook-executed")

Then "the after hook should execute again", ->
  expect(TestClassWithHooks.executionLog).to.include("after-hook-executed")

Then "the method should return the result modified by the after hook", ->
  expect(@result).to.match(/(first|second)-test-.*-after/)

Then "the around hook should execute before and after the method", ->
  expect(TestClassWithHooks.executionLog).to.include("around-hook-start")
  expect(TestClassWithHooks.executionLog).to.include("around-hook-end")

Then "the around hook should execute before and after the method again", ->
  expect(TestClassWithHooks.executionLog).to.include("around-hook-start")
  expect(TestClassWithHooks.executionLog).to.include("around-hook-end")

Then "the method should return the result modified by the around hook", ->
  expect(@result).to.match(/(first|second)-test-.*-around/)

Then "the around hook should prevent the method execution", ->
  expect(TestClassWithHooks.executionLog).to.include("validation-failed")
  expect(TestClassWithHooks.executionLog).not.to.include("validation-passed")

Then "the around hook should allow the method execution", ->
  expect(TestClassWithHooks.executionLog).to.include("validation-passed")
  expect(TestClassWithHooks.executionLog).not.to.include("validation-failed")

Then "the method should return {string}", (expected) ->
  expect(@result).to.equal(expected)

Then "the method should return the processed result", ->
  expect(@result).to.equal("Valid-valid")

Then "all class-level hooks should execute in the correct order", ->
  expectedOrder = [
    "before-1",
    "before-2",
    "around-start",
    "around-end",
    "after-1",
    "after-2"
  ]

  # Check if elements appear in the correct relative order
  for i in [0...expectedOrder.length-1]
    currentIndex = TestClassWithMultipleHooks.executionLog.indexOf(expectedOrder[i])
    nextIndex = TestClassWithMultipleHooks.executionLog.indexOf(expectedOrder[i+1])
    expect(currentIndex).to.be.lessThan(nextIndex,
      "Hook #{expectedOrder[i]} should execute before #{expectedOrder[i+1]}")

Then "the method should return the result processed by all hooks", ->
  expect(@multiHookResult).to.equal("original-around-after1-after2")
