import { register } from "node:module";

register("./resolver.mjs", import.meta.url);
register("./cjs.mjs", import.meta.url);
register("./yaml.mjs", import.meta.url);
register("./coffee.mjs", import.meta.url);
