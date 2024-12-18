import Arrays from "#root/prototypes/arrays.js"
import Objects from "#root/prototypes/objects.js"
import Functions from "#root/prototypes/functions.js"
import Strings from "#root/prototypes/strings.js"
import Iss from "#root/prototypes/methods/is.js"
import Tos from "#root/prototypes/methods/to.js"

export initialize = ->
  Arrays.apply()
  Functions.apply()
  Objects.apply()
  Strings.apply()
  Iss.apply()
  Tos.apply()

  true

export destroy = ->
  Arrays.remove()
  Functions.remove()
  Objects.remove()
  Strings.remove()
  Iss.remove()
  Tos.remove()

  true

export default {
  initialize
  destroy
}
