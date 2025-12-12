import * as methods from "~/library/strings/functions.coffee"

class Strings extends String

for name, method of methods
  Strings::[name] = (args...) -> method(@, args...)

export default Strings
