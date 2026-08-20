import { Given, When, Then } from "@cucumber/cucumber";
import { expect } from "chai";
import { SessionStore } from "../../../library/stores";
import { JSDOM } from "jsdom";

const dom = new JSDOM('<!DOCTYPE html><html><body></body></html>', { url: "http://localhost" });
(global as any).window = dom.window;
(global as any).document = dom.window.document;
(global as any).sessionStorage = dom.window.sessionStorage;

When("I set {string} to {string} in session storage", function (key: string, value: string) {
  this.sessionStore = new SessionStore();
  this.sessionStore.set(key, value);
});

Then("getting {string} from session storage should return {string}", function (key: string, expectedValue: string) {
  const value = this.sessionStore.get(key);
  expect(value).to.equal(expectedValue);
});

When("I set {string} to object in session storage", function (key: string) {
  this.sessionStore = new SessionStore();
  this.testSessionObj = { sessionHello: "sessionWorld" };
  this.sessionStore.set(key, this.testSessionObj);
});

Then("getting {string} from session storage should return the object", function (key: string) {
  const value = this.sessionStore.get(key);
  expect(value).to.deep.equal(this.testSessionObj);
});
