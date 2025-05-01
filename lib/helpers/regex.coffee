### Content types ###
export ARRAY_CONTENT            = new RegExp "^\\s*\\[.*\\]\\s*$"
export COMMON_JS_CONTENT        = new RegExp "exports[\\[\\.( ?=)]|module\\.exports|require\\(|createRequire\\(", "i"
export OBJECT_CONTENT           = new RegExp "^\\s*\\{.*\\}\\s*$"
export STRING_CONTENT           = new RegExp '^\\s*\\".*\\"\\s*$'
export NUMBER_CONTENT           = new RegExp "^\\d+([\\.,\\d])*$"

### File extensions ###
export COFFEE_EXTENSION         = new RegExp "\\.(coffee|litcoffee|coffee\\.md)$", "i"
export YAML_EXTENSION           = new RegExp "\\.ya?ml$", "i"

### Path Starters ###
export STARTS_WITH_BASE_PATH    = new RegExp "^([~|@]\\/)"
export STARTS_WITH_PACKAGE_PATH = new RegExp "^~\\/"
export STARTS_WITH_PROJECT_PATH = new RegExp "^@\\/"

### Placeholders ###
export PATTERN_PLACEHOLDERS     = new RegExp "(?<pattern>\\{\\{\\s*(?<placeholder>[a-z0-9-_\\.]+?)\\s*\\}\\})", "gmi"
export PLACEHOLDERS             = new RegExp "\\{\\{\\s*(?<placeholder>[a-z0-9-_\\.]+?)\\s*\\}\\}", "gmi"

### Case ###
export CASE_SEPARATORS          = new RegExp "([A-Z]{1}[a-z]+)|[_\\-\\.]", "g"
export CASE_WHITESPACE          = new RegExp "\\s+", "g"
