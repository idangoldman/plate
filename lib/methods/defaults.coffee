import PrototypeArray from "#root/methods/prototypes/array.js"
import PrototypeObject from "#root/methods/prototypes/object.js"
import PrototypeString from "#root/methods/prototypes/string.js"

export applyPrototypes = ->
  PrototypeArray.apply()
  PrototypeObject.apply()
  PrototypeString.apply()

  true

export removePrototypes = ->
  PrototypeArray.remove()
  PrototypeObject.remove()
  PrototypeString.remove()

  true
