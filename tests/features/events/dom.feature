@events
@dom-events
Feature: DOM Events Pattern
  As a developer
  I want DOM events integrated with the base events pattern
  So that I can handle DOM interactions consistently

  Background:
    Given I have a DOM element with selector "#test-button"
    And I have a DOM events instance for that element

  @dom-binding
  Scenario: Basic DOM event binding
    When I bind "click" event to the element
    And I trigger a "click" event on the element
    Then the event callback should be executed

  @dom-once
  Scenario: One-time DOM event binding
    When I bind "click" event once to the element
    And I trigger "click" event twice on the element
    Then the callback should be executed exactly once

  @dom-unbinding
  Scenario: DOM event unbinding
    Given I have bound "click" event to the element
    When I unbind the "click" event
    And I trigger a "click" event on the element
    Then the callback should not be executed

  @dom-cleanup
  Scenario: DOM events cleanup
    Given I have bound multiple events to the element
    When I destroy the DOM events instance
    Then all DOM listeners should be removed
    And the events store should be cleared
