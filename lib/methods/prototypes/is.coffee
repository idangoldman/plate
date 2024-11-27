import BasePrototype from "#root/methods/prototypes/base.js"

export default class IsPrototype extends BasePrototype
  @extends "Object", "String", "Array", "Number", "Date", "RegExp", "Function", "Promise", "Set", "Map"

  isArray:     -> Array.isArray(@)
  isBoolean:   -> typeof @ == "boolean"
  isDate:      -> @ instanceof Date
  isError:     -> @ instanceof Error
  isFunction:  -> typeof @ == "function"
  isMap:       -> @ instanceof Map
  isNull:      -> @ == null
  isNumber:    -> typeof @ == "number"
  isObject:    -> typeof @ == "object"
  isPromise:   -> @ instanceof Promise
  isRegExp:    -> @ instanceof RegExp
  isSet:       -> @ instanceof Set
  isString:    -> typeof @ == "string"
  isSymbol:    -> typeof @ == "symbol"
  isUndefined: -> @ == undefined

export methods = IsPrototype.methods()
