import Arrays from "#root/prototypes/arrays.js"
import Objects from "#root/prototypes/objects.js"
import Functions from "#root/prototypes/functions.js"
import Strings from "#root/prototypes/strings.js"
import IsMethods from "#root/prototypes/methods/is.js"
import ToMethods from "#root/prototypes/methods/to.js"

export initialize = ->
  Arrays.apply()
  Functions.apply()
  Objects.apply()
  Strings.apply()
  IsMethods.apply()
  ToMethods.apply()

  true

export destroy = ->
  Arrays.remove()
  Functions.remove()
  Objects.remove()
  Strings.remove()
  IsMethods.remove()
  ToMethods.remove()

  true

export default {
  initialize
  destroy
}
