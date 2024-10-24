import {After} from "@cucumber/cucumber"

After ->
  @restoreEnvironmentState()
  @resetState()
