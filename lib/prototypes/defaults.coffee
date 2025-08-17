# Native Prototypes
import Arrays from "#root/prototypes/arrays.js"
# import Functions from "#root/prototypes/functions.js"
import Objects from "#root/prototypes/objects.js"
import Strings from "#root/prototypes/strings.js"

# Method Prototypes
import IsMethods from "#root/prototypes/methods/is.js"
import CaseConverterMethods from "#root/prototypes/methods/case-converter.js"
import ToMethods from "#root/prototypes/methods/to.js"

export initialize = ->
  Arrays.apply()
  # Functions.apply()
  Objects.apply()
  Strings.apply()

  IsMethods.apply()
  CaseConverterMethods.apply()
  ToMethods.apply()

  true

export destroy = ->
  Arrays.remove()
  # Functions.remove()
  Objects.remove()
  Strings.remove()

  IsMethods.remove()
  CaseConverterMethods.remove()
  ToMethods.apply()

  true

export default {
  initialize
  destroy
}
