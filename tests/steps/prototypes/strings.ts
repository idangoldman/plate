import { Given, When } from "@cucumber/cucumber";
import capitalize from "../../../library/strings/functions/capitalize";

Given("I have a {string} string", function (input: string) {
  this.input = input;
});

When("I convert it to {word} case", function (caseType: string) {
  this.result = this.input[`to${capitalize(caseType)}Case`]();
});

When("capitalize method applied to it", function () {
  this.result = this.input.capitalize();
});
