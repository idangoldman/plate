import { After, BeforeAll, AfterAll } from "@cucumber/cucumber"

import { applyPrototypes, removePrototypes } from "#root/methods/defaults.js"

After ->
  @restoreEnvironmentState()
  @resetState()

BeforeAll ->
  applyPrototypes()

AfterAll ->
  removePrototypes()
