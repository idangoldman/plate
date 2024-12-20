import { setWorldConstructor } from "@cucumber/cucumber"

setWorldConstructor class ResolverWorld
  constructor: ->
    @originalEnv = {}
    @resetState()

  resetState: ->
    @error = undefined
    @expected = undefined
    @input = undefined

  saveEnvironmentState: ->
    @originalEnv.PLATE_PRJ_PATH = process.env.PLATE_PRJ_PATH
    @originalEnv.PLATE_PKG_PATH = process.env.PLATE_PKG_PATH

  restoreEnvironmentState: ->
    if @originalEnv.PLATE_PRJ_PATH?
      process.env.PLATE_PRJ_PATH = @originalEnv.PLATE_PRJ_PATH
    else
      delete process.env.PLATE_PRJ_PATH

    if @originalEnv.PLATE_PKG_PATH?
      process.env.PLATE_PKG_PATH = @originalEnv.PLATE_PKG_PATH
    else
      delete process.env.PLATE_PKG_PATH
