Feature: DOM Element Wrapper

  Scenario: Creating an element with a valid selector
    Given a DOM element with id "test-element" exists
    When I create an Element instance with selector "#test-element"
    Then the Element raw property should be the DOM element
    And the Element toString property should be "#test-element"

  Scenario: Creating an element with an invalid selector
    When I create an Element instance with selector "#non-existent"
    Then it should throw an error "No HTML element was found with \"#non-existent\" selector"

  Scenario: Creating an element with no selector
    When I create an Element instance with selector ""
    Then it should throw an error "No query selector passed"
