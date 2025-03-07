export default isNativeMethod = (fn) ->
  unless fn? then false else fn.toString().includes "[native code]"
