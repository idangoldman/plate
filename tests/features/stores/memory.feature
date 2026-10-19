Feature: Memory Storage

  Scenario: Setting and getting a value in memory storage
    When I set "test-key" to "test-value" in memory storage
    Then getting "test-key" from memory storage should return "test-value"

  Scenario: Setting and getting an object in memory storage
    When I set "test-obj" to object in memory storage
    Then getting "test-obj" from memory storage should return the object
