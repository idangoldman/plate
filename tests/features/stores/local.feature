Feature: Local Storage

  Scenario: Setting and getting a value in local storage
    When I set "test-key" to "test-value" in local storage
    Then getting "test-key" from local storage should return "test-value"

  Scenario: Setting and getting an object in local storage
    When I set "test-obj" to object in local storage
    Then getting "test-obj" from local storage should return the object

  Scenario: Setting and getting a value in cookie storage
    When I set "test-cookie" to "cookie-value" in cookie storage
    Then getting "test-cookie" from cookie storage should return "cookie-value"
