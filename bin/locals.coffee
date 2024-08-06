import yargs from "yargs"
import { hideBin } from "yargs/helpers"

argv = yargs(hideBin(process.argv))
  .usage("Usage: plate locals --input <input> --output <output>")
  .option("input",
    alias: ["i", "input"]
    describe: "Path to one, multiple, or glob of dictionary files."
    required: true
    type: ["string", "array"]
  )
  .option("output",
    alias: ["o", "output"]
    describe: "Path to a folder where the lexicon(s) files will be generated in."
    required: true
    type: "string"
  ).argv

{ input, output } = argv

console.log "Locals:", input, output

process.exit(0)
