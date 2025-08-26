import { After, BeforeAll, AfterAll } from "@cucumber/cucumber"

import Prototypes from "#root/prototypes/defaults.js"

BeforeAll ->
  Prototypes.initialize()

AfterAll ->
  Prototypes.destroy()

After ->
  @restoreEnvironmentState()
