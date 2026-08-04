import { When, Then, BeforeAll } from "@cucumber/cucumber";
import { expect } from "chai";
import { indexedDB, IDBKeyRange } from "fake-indexeddb";
import { IndexedDBStorage } from "../../../library/stores";

// Set globals for JSDOM or fake environments
(globalThis as any).indexedDB = indexedDB;
(globalThis as any).IDBKeyRange = IDBKeyRange;

When("I set {string} to {string} in indexeddb storage", async function (key: string, value: string) {
  this.idbStore = new IndexedDBStorage();
  await this.idbStore.set(key, value);
});

Then("getting {string} from indexeddb storage should return {string}", async function (key: string, expectedValue: string) {
  const value = await this.idbStore.get(key);
  expect(value).to.equal(expectedValue);
});

When("I set {string} to object in indexeddb storage", async function (key: string) {
  this.idbStore = new IndexedDBStorage();
  this.testObj = { hello: "world" };
  await this.idbStore.set(key, this.testObj);
});

Then("getting {string} from indexeddb storage should return the object", async function (key: string) {
  const value = await this.idbStore.get(key);
  expect(value).to.deep.equal(this.testObj);
});
