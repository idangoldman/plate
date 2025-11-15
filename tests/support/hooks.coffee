import { After, BeforeAll, AfterAll } from "@cucumber/cucumber"

import Prototypes from "~/library/prototypes/defaults.coffee"

BeforeAll ->
  Prototypes.initialize()

AfterAll ->
  Prototypes.destroy()
