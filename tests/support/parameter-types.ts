import { defineParameterType } from "@cucumber/cucumber";
import expectedValueParser from "./expected-value-parser";

// Parameter type for expected values (boolean, null, undefined, number, string, array, object)
defineParameterType({
  name: "expectedValue",
  regexp: /((?:"[^"]*"|true|false|null|undefined|-?\d+(?:\.\d+)?|\[.*?\]|\{.*?\}))/,
  transformer: expectedValueParser
});

// Environment-specific parameter
defineParameterType({
  name: "envVar",
  regexp: /\$([A-Z_][A-Z0-9_]*)/,
  transformer: (varName: string) => {
    if (varName in process.env) {
      return process.env[varName];
    } else {
      throw new Error(`Environment variable ${varName} is not defined`);
    }
  }
});
