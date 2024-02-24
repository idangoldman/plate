import { register } from "node:module";

register("./cjs.mjs", import.meta.url);
register("./coffee.mjs", import.meta.url);
register("./yaml.mjs", import.meta.url);
