import { Given, When, Then } from "@cucumber/cucumber";
import { expect } from "chai";
import toCaseKeys from "../../../library/objects/functions/to-case-keys"; // fallback if object prototype not applied correctly yet

Given("I have an object", function (jsonString: string) {
  this.input = JSON.parse(jsonString);
});

When("I convert all keys of the object to {word} format", function (caseType: string) {
  // Wait, in CoffeeScript it was `toCaseKeys`, which means we might need to map PascalCase to `pascal` for caseType
  let caseParam = caseType;
  if (caseType.endsWith('Case')) {
    caseParam = caseType.replace(/Case$/, '').toLowerCase();
  }

  if (typeof this.input.toCaseKeys === 'function') {
    this.result = this.input.toCaseKeys(caseParam);
  } else {
    this.result = toCaseKeys(this.input, caseParam);
  }
});

Then("Result should be an object with keys", function (jsonString: string) {
  const expectedObject = JSON.parse(jsonString);
  expect(this.result).to.deep.equal(expectedObject);
});
