export default isNativeMethod = (fn) ->
  try
    Function.prototype.toString.call(fn).includes "[native code]"
  catch error
    false
