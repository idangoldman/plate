# Native Prototypes
import Arrays from "#root/prototypes/arrays.js"
# import Functions from "#root/prototypes/functions.js"
import Objects from "#root/prototypes/objects.js"
import Strings from "#root/prototypes/strings.js"

# Method Prototypes
import IsMethods from "#root/prototypes/methods/is.js"
import NameCasingMethods from "#root/prototypes/methods/name-casing.js"
# import ToMethods from "#root/prototypes/methods/to.js"

export initialize = ->
  Arrays.apply()
  # Functions.apply()
  Objects.apply()
  Strings.apply()

  IsMethods.apply()
  NameCasingMethods.apply()
  # ToMethods.apply()

  true

export destroy = ->
  Arrays.remove()
  # Functions.remove()
  Objects.remove()
  Strings.remove()

  IsMethods.remove()
  NameCasingMethods.remove()
  # ToMethods.apply()

  true

export default {
  initialize
  destroy
}
