import { Given, When, Then } from "@cucumber/cucumber";
import { expect } from "chai";
import { LocalStore, CookieStore } from "../../../library/stores";
import { JSDOM } from "jsdom";

const dom = new JSDOM('<!DOCTYPE html><html><body></body></html>', { url: "http://localhost" });
(global as any).window = dom.window;
(global as any).document = dom.window.document;
(global as any).localStorage = dom.window.localStorage;
(global as any).sessionStorage = dom.window.sessionStorage;

When("I set {string} to {string} in local storage", function (key: string, value: string) {
  this.localStore = new LocalStore('local');
  this.localStore.set(key, value);
});

Then("getting {string} from local storage should return {string}", function (key: string, expectedValue: string) {
  const value = this.localStore.get(key);
  expect(value).to.equal(expectedValue);
});

When("I set {string} to object in local storage", function (key: string) {
  this.localStore = new LocalStore('local');
  this.testObj = { hello: "world" };
  this.localStore.set(key, this.testObj);
});

Then("getting {string} from local storage should return the object", function (key: string) {
  const value = this.localStore.get(key);
  expect(value).to.deep.equal(this.testObj);
});

When("I set {string} to {string} in cookie storage", function (key: string, value: string) {
  this.cookieStore = new CookieStore();
  this.cookieStore.set(key, value);
});

Then("getting {string} from cookie storage should return {string}", function (key: string, expectedValue: string) {
  const value = this.cookieStore.get(key);
  expect(value).to.equal(expectedValue);
});
