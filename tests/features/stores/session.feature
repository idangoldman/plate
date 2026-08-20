Feature: Session Storage

  Scenario: Setting and getting a value in session storage
    When I set "test-session-key" to "test-session-value" in session storage
    Then getting "test-session-key" from session storage should return "test-session-value"

  Scenario: Setting and getting an object in session storage
    When I set "test-session-obj" to object in session storage
    Then getting "test-session-obj" from session storage should return the object
