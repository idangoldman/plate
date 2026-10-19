import { When, Then } from "@cucumber/cucumber";
import { expect } from "chai";

When("I check the type of {string}", function (name: string) {
  this.result = {
    isArray: this.input[name].isArray(),
    isObject: this.input[name].isObject(),
    isString: this.input[name].isString()
  };
});

When("I check if {string} is empty", function (name: string) {
  this.result = this.input[name].isEmpty();
});

Then("it should be one of:", function (table: any) {
  const expected = table.rowsHash();

  for (const key of Object.keys(expected)) {
    const value = expected[key];
    expect(this.result[key]).to.equal(value === "true");
  }
});

Then("it should be {string}", function (expected: string) {
  expect(this.result).to.equal(expected === "true");
});
