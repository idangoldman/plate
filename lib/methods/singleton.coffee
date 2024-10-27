class Singleton
  @instance = null

  @getInstance: ->
    @instance ?= new this()
    @instance

  constructor: ->
    unless @constructor.instance?
      @constructor.instance = this

    return @constructor.instance
