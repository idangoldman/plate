import { Given, When, Then } from "@cucumber/cucumber";
import { expect } from "chai";

Given("I have an object", function (jsonString: string) {
  this.input = JSON.parse(jsonString);
});

When("I convert all keys of the object to {word} format", function (caseType: string) {
  this.result = this.input[`to${caseType}`]();
});

Then("Result should be an object with keys", function (jsonString: string) {
  const expectedObject = JSON.parse(jsonString);
  expect(this.result).to.deep.equal(expectedObject);
});
