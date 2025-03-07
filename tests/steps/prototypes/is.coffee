import { Given, When, Then } from "@cucumber/cucumber"
import { expect } from "chai"

Given "I have the following values:", (dataTable) ->
  @testValues = {}

  for row in dataTable.hashes()
    name = row.name

    if row.specialType
      switch row.specialType
        when "null"
          @testValues[name] = null
        when "undefined"
          @testValues[name] = undefined
        when "new Map()"
          @testValues[name] = new Map()
        when "new Set()"
          @testValues[name] = new Set()
        when "Object.create(null)"
          @testValues[name] = Object.create(null)
    else if row.value
      try
        @testValues[name] = JSON.parse(row.value)
      catch error
        if row.value.startsWith('"') && row.value.endsWith('"')
          @testValues[name] = row.value.slice(1, -1)
        else
          @testValues[name] = row.value

When "I check their types", ->
  @results = {}

  for name, value of @testValues
    @results[name] =
      isArray: value?.isArray?() || false
      isObject: value?.isObject?() || false
      isString: value?.isString?() || false
      isEmpty: value?.isEmpty?() || false

Then "the results should be:", (dataTable) ->
  for row in dataTable.hashes()
    name = row.name

    expectedResults =
      isArray: row.isArray == 'true'
      isObject: row.isObject == 'true'
      isString: row.isString == 'true'
      isEmpty: row.isEmpty == 'true'

    actualResults = @results[name]
    expect(actualResults).to.deep.equal(expectedResults,
      "Results for '#{name}' don't match expected values")
