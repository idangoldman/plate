# Native Prototypes
import Arrays from "~/prototypes/arrays.coffee"
import Objects from "~/prototypes/objects.coffee"
import Strings from "~/prototypes/strings.coffee"

# Method Prototypes
import IsMethods from "~/prototypes/methods/is.coffee"
import CaseConversionMethods from "~/prototypes/methods/case-conversion.coffee"
import ToMethods from "~/prototypes/methods/to.coffee"

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
