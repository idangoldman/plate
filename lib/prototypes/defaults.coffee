import Arrays from "#root/prototypes/arrays.js"
import Objects from "#root/prototypes/objects.js"
import Strings from "#root/prototypes/strings.js"
import IsMethods from "#root/prototypes/methods/is.js"
import NameCasingMethods from "#root/prototypes/methods/name-casing.js"

export initialize = ->
  Arrays.apply()
  Objects.apply()
  Strings.apply()
  IsMethods.apply()
  NameCasingMethods.apply()

  true

export destroy = ->
  Arrays.remove()
  Objects.remove()
  Strings.remove()
  IsMethods.remove()
  NameCasingMethods.remove()

  true

export default {
  initialize
  destroy
}
