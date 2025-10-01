# Native Prototypes
import Arrays from "#library/prototypes/arrays"
import Objects from "#library/prototypes/objects"
import Strings from "#library/prototypes/strings"

# Method Prototypes
import IsMethods from "#library/prototypes/methods/is"
import CaseConversionMethods from "#library/prototypes/methods/case-conversion"
import ToMethods from "#library/prototypes/methods/to"

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
