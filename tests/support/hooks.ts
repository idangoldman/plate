// Importing the globals module both applies the prototype methods and brings
// their ambient types into scope. Replaces the old `applyAll()` call plus the
// implicit `library/global.d.ts` pickup.
import "../../library/globals";

import { AfterAll, BeforeAll } from "@cucumber/cucumber";

BeforeAll(() => {
  // Prototypes are already applied by the import above.
});

AfterAll(() => {
  // Add teardown logic if required
});
