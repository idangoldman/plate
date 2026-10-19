import { When, Then } from "@cucumber/cucumber";
import { expect } from "chai";
import { MemoryStore } from "../../../library/stores";

When("I set {string} to {string} in memory storage", function (key: string, value: string) {
  this.memoryStore = new MemoryStore();
  this.memoryStore.set(key, value);
});

Then("getting {string} from memory storage should return {string}", function (key: string, expectedValue: string) {
  const value = this.memoryStore.get(key);
  expect(value).to.equal(expectedValue);
});

When("I set {string} to object in memory storage", function (key: string) {
  this.memoryStore = new MemoryStore();
  this.testObj = { hello: "world" };
  this.memoryStore.set(key, this.testObj);
});

Then("getting {string} from memory storage should return the object", function (key: string) {
  const value = this.memoryStore.get(key);
  expect(value).to.deep.equal(this.testObj);
});
