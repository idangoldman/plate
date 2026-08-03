Feature: DOM Events Adapter

  Scenario: Attaching and triggering an event via the adapter
    Given a DOM element with id "event-element" exists
    And I create an Element instance with selector "#event-element"
    When I attach an event "click" using the Events adapter
    And I trigger a "click" event on the DOM element
    Then the callback should have been called
