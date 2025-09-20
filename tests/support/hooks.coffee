import { After, BeforeAll, AfterAll } from "@cucumber/cucumber"

import Prototypes from "#library/prototypes/defaults"

BeforeAll ->
  Prototypes.initialize()

AfterAll ->
  Prototypes.destroy()

After ->
  @restoreEnvironmentState()
