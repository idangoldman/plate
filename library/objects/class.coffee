import * as methods from "~/library/objects/functions.coffee"

class Objects extends Object

for name, method of methods
  Objects::[name] = (args...) -> method(@, args...)

export default Objects
