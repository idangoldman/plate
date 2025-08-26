# Native Prototypes
import Arrays from "#root/prototypes/arrays.js"
import Objects from "#root/prototypes/objects.js"
import Strings from "#root/prototypes/strings.js"

# Method Prototypes
import IsMethods from "#root/prototypes/methods/is.js"
import CaseConversionMethods from "#root/prototypes/methods/case-conversion.js"
import ToMethods from "#root/prototypes/methods/to.js"

export initialize = ->
  Arrays.apply()
  Objects.apply()
  Strings.apply()

  IsMethods.apply()
  ToMethods.apply()
  CaseConversionMethods.apply()

  true

export destroy = ->
  Arrays.remove()
  Objects.remove()
  Strings.remove()

  IsMethods.remove()
  ToMethods.apply()
  CaseConversionMethods.remove()

  true

export default {
  initialize
  destroy
}
