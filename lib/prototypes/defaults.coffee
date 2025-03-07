import Arrays from "#root/prototypes/arrays.js"
import Objects from "#root/prototypes/objects.js"
import Strings from "#root/prototypes/strings.js"
import IsMethods from "#root/prototypes/methods/is.js"

export initialize = ->
  Arrays.apply()
  Objects.apply()
  Strings.apply()
  IsMethods.apply()

  true

export destroy = ->
  Arrays.remove()
  Objects.remove()
  Strings.remove()
  IsMethods.remove()

  true

export default {
  initialize
  destroy
}
