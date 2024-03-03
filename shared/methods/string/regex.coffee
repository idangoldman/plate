IS_REGEX =
  isBinary: /^[01]+$/
  isDate: /^[0-9\#\*\-\+]+$/
  isEmail: /^([\w-\\.\\+]+@([\w-]+\.)+[a-zA-Z]{2,})?$/
  isHexColor: /^#?([a-f0-9]{6}|[a-f0-9]{3})$/i
  isHTMLTag: /<\/?[a-z][\s\S]*>/i
  isIntlPhone: /^\+[1-9]{1}[0-9]{3,14}$/
  isIPv4: /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/
  isIPv6: /^([0-9a-fA-F]{1,4}:){7}([0-9a-fA-F]{1,4})$/
  isISODate: /^\d{4}-\d{2}-\d{2}$/
  isJSON: /^\{(?:[^{}]|{(?:[^{}]|{[^{}]*})*})*\}$/
  isMACAddress: /^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$/
  isPercentage: /^(\d{1,3}(\.\d{1,2})?|100(\.00?)?)%$/
  isSlug: /^[a-z0-9]+(?:-[a-z0-9]+)*$/
  isStrongPassword: /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{10,}$/
  isTime12Hour: /^(1[0-2]|0?[1-9]):[0-5][0-9]([AaPp][Mm])$/
  isTime24Hour: /^([01]?[0-9]|2[0-3]):[0-5][0-9](:[0-5][0-9])?$/
  isUnixPath: /^(\/\w+)+$/
  isUrl: /https?:\/\/w{0,3}\w*?\.(\w*?\.)?\w{2,3}\S*|www\.(\w*?\.)?\w*?\.\w{2,3}\S*|(\w*?\.)?\w*?\.\w{2,3}[\/\?]\S*/gm
  isUsername: /^[a-z][a-z0-9_-]{2,15}$/i
  isUUID: /^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$/
  isWindowsPath: /^[a-zA-Z]:\\(?:\w+\\)*\w*\.\w+$/
  isExtension = /(.[^.]*)$/
.freeze()

Object.keys(IS_REGEX).forEach (name) ->
  String.prototype[name] = () ->
    IS_REGEX[name].test this
