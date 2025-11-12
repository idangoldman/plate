import { setWorldConstructor, World } from "@cucumber/cucumber"

setWorldConstructor class PlateWorld extends World
  constructor: (options) ->
    super(options)

    # Initialize test state
    @error = undefined
    @expected = undefined
    @input = undefined
    @result = undefined
