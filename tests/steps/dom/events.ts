import { Given, When, Then } from "@cucumber/cucumber";
import { expect } from "chai";
import Element from "../../../library/dom/element";
import Events from "../../../library/dom/events";

When("I attach an event {string} using the Events adapter", function (eventName: string) {
  this.eventsAdapter = new Events(this.elementInstance);
  this.callbackCalled = false;
  this.eventsAdapter.on(eventName, () => {
    this.callbackCalled = true;
  });
});

When("I trigger a {string} event on the DOM element", function (eventName: string) {
  const event = new (window as any).Event(eventName);
  this.domElement.dispatchEvent(event);
});

Then("the callback should have been called", function () {
  expect(this.callbackCalled).to.be.true;
});
