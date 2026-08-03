import { Given, When, Then } from "@cucumber/cucumber";
import { expect } from "chai";
import { JSDOM } from "jsdom";
import Element from "../../../library/dom/element";

// We need to set up jsdom for document/window
const dom = new JSDOM('<!DOCTYPE html><html><body></body></html>');
(global as any).window = dom.window;
(global as any).document = dom.window.document;
(global as any).HTMLElement = dom.window.HTMLElement;

Given("a DOM element with id {string} exists", function (id: string) {
  const el = document.createElement("div");
  el.id = id;
  document.body.appendChild(el);
  this.domElement = el;
});

When("I create an Element instance with selector {string}", function (selector: string) {
  try {
    this.elementInstance = new Element(selector);
    this.error = null;
  } catch (err) {
    this.error = err;
    this.elementInstance = null;
  }
});

Then("the Element raw property should be the DOM element", function () {
  expect(this.elementInstance.raw).to.equal(this.domElement);
});

Then("the Element toString property should be {string}", function (expectedString: string) {
  expect(this.elementInstance.toString).to.equal(expectedString);
});

Then("it should throw an error {string}", function (errorMessage: string) {
  expect(this.error).to.not.be.null;
  expect(this.error.message).to.equal(errorMessage);
});
