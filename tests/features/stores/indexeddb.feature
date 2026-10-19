Feature: IndexedDB Storage

  Scenario: Setting and getting a value in indexeddb storage
    When I set "test-key" to "test-value" in indexeddb storage
    Then getting "test-key" from indexeddb storage should return "test-value"

  Scenario: Setting and getting an object in indexeddb storage
    When I set "test-obj" to object in indexeddb storage
    Then getting "test-obj" from indexeddb storage should return the object
