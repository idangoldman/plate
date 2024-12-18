import { After, BeforeAll, AfterAll } from "@cucumber/cucumber"

import Prototypes from "#root/prototypes/defaults.js"

After ->
  @restoreEnvironmentState()
  @resetState()

BeforeAll ->
  Prototypes.initialize()

AfterAll ->
  Prototypes.destory()
