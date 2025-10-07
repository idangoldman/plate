# Native Prototypes
import Arrays from "#library/prototypes/arrays.coffee"
import Objects from "#library/prototypes/objects.coffee"
import Strings from "#library/prototypes/strings.coffee"

# Method Prototypes
import IsMethods from "#library/prototypes/methods/is.coffee"
import CaseConversionMethods from "#library/prototypes/methods/case-conversion.coffee"
import ToMethods from "#library/prototypes/methods/to.coffee"

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
  ToMethods.remove()
  CaseConversionMethods.remove()

  true

export default {
  initialize
  destroy
}
