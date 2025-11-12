import { After, BeforeAll, AfterAll } from "@cucumber/cucumber"

import Prototypes from "~/prototypes/defaults.coffee"

BeforeAll ->
  Prototypes.initialize()

AfterAll ->
  Prototypes.destroy()

After ->
  @restoreEnvironmentState()
