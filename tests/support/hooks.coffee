import { After, BeforeAll, AfterAll } from "@cucumber/cucumber"

import Prototypes from "#root/patterns/prototypes.js"

After ->
  @restoreEnvironmentState()
  @resetState()

BeforeAll ->
  Prototypes.initilize()

AfterAll ->
  Prototypes.destory()
