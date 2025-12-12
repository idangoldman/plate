import * as methods from "~/library/arrays/functions.coffee"

class Arrays extends Array

for name, method of methods
  Arrays::[name] = (args...) -> method(@, args...)

export default Arrays
