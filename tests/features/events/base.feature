@patterns
@events
Feature: Base Events Pattern
  As Ruth, the framework architect
  I want a solid base events pattern
  So that other event types can inherit consistent behavior

  Background:
    Given Sarah used an events pattern instance with the following event list:
      | category | events           |
      | user     | login, logout    |
      | data     | save, load       |

  @base-events
  Scenario: Event subscription and emission
    When Sarah subscribes to "login" event with callback
      And Sarah emits "login" event with data ["sarah_admin"]
    Then the callback should be called with ["sarah_admin"]

  @namespaced-events
  Scenario: Namespaced event handling
    Given Sarah has a namespaced events instance with "auth" namespace
    When Sarah subscribes to "login" event with callback
      And Sarah emits "login" event with data ["sarah_admin"]
    Then the callback should be called with ["sarah_admin"]
      And the internal event name should be "auth:login"

  @once-events
  Scenario: One-time event subscription
    When Sarah subscribes once to "logout" event with callback
      And Sarah emits "logout" event
      And Sarah emits "logout" event again
    Then the callback should be called exactly once

  @event-validation
  Scenario: Invalid event name validation
    When Sarah tries to subscribe to "invalid_event" event
    Then it should throw a warning containing "No events were found with names: invalid_event"

  @invalid-operations-errors
  Scenario: Invalid operations are handled gracefully
    When Sarah tries to emit a non-existent event
    Then it should handle gracefully without crashing
      And an appropriate warning should be logged

  @callback-errors
  Scenario: Callback errors don't stop other callbacks
    Given Sarah has two callbacks for "test" event
      And the first callback throws an error
    When Sarah emits "test" event
    Then the second callback should still execute
      And the error should be logged

  @memory-leaks-errors
  Scenario: Preventing memory leaks
    Given I have subscribed to many events
    When I call clear() on the events instance
    Then all event listeners should be removed
      And the events store should be empty
