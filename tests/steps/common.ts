import { Given, When, Then } from "@cucumber/cucumber";
import { expect } from "chai";
import expectedValueParser from "../support/expected-value-parser";

Given("the following inputs:", function (table) {
  this.input = {};

  for (const { name, value } of table.hashes()) {
    this.input[name] = expectedValueParser(value).value;
  }
});

When("{word} method is called on {word}", function (method: string, name: string) {
  try {
    this.result = this.input[name][method]();
    this.error = null;
  } catch (err) {
    this.error = err;
    this.result = null;
  }
});

When("{word} method is called on {word} with {expectedValue}", function (method: string, name: string, argument: { type: string, value: any }) {
  const { type, value } = argument;

  try {
    this.result = this.input[name][method](value);
    this.error = null;
  } catch (err) {
    this.error = err;
    this.result = null;
  }
});

Then("I should get {expectedValue} as the result", function (expected: { type: string, value: any }) {
  const { type, value } = expected;

  switch (type) {
    case "boolean":
      expect(this.result).to.be.a('boolean', `Expected result to be boolean but got ${typeof this.result}`);
      expect(this.result).to.equal(value, `Expected boolean value to be ${value} but got ${this.result}, error: ${this.error?.message}`);
      break;

    case "null":
      expect(this.result).to.be.a("null", `Expected result to be null but got ${typeof this.result}`);
      expect(this.result).to.equal(value, `Expected boolean value to be ${value} but got ${this.result}, error: ${this.error?.message}`);
      break;

    case "undefined":
      expect(this.result).to.be.a("undefined", `Expected result to be undefined but got ${typeof this.result}`);
      expect(this.result).to.equal(value, `Expected boolean value to be ${value} but got ${this.result}, error: ${this.error?.message}`);
      break;

    case "number":
      expect(this.result).to.be.a('number', `Expected result to be number but got ${typeof this.result}`);
      expect(this.result).to.equal(value, `Expected boolean value to be ${value} but got ${this.result}, error: ${this.error?.message}`);
      break;

    case "string":
      expect(this.result).to.be.a('string', `Expected result to be string but got ${typeof this.result}`);
      expect(this.result).to.equal(value, `Expected boolean value to be ${value} but got ${this.result}, error: ${this.error?.message}`);
      break;

    case "array":
      expect(this.result).to.be.an('array', `Expected result to be array but got ${typeof this.result}`);
      expect(this.result).to.not.be.an('object', `Expected result to be array but got object`);
      expect(this.result).to.deep.equal(value, `Expected boolean value to be ${value} but got ${this.result}, error: ${this.error?.message}`);
      break;

    case "object":
      expect(this.result).to.be.an('object', `Expected result to be object but got ${typeof this.result}`);
      expect(this.result).to.not.be.an('array', `Expected result to be object but got array`);
      expect(this.result).to.deep.equal(value, `Expected boolean value to be ${value} but got ${this.result}, error: ${this.error?.message}`);
      break;

    default:
      throw new Error(`Unsupported expected type: ${type}`);
  }
});
