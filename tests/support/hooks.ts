import { BeforeAll, AfterAll } from "@cucumber/cucumber";
import { applyAll } from "../../library/index";

BeforeAll(() => {
  applyAll();
});

AfterAll(() => {
  // Add teardown logic if required
});
