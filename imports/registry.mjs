import { register } from "node:module";

import "./globals.mjs";

register("./loaders/resolver.mjs", import.meta.url);
register("./loaders/cjs.mjs", import.meta.url);
register("./loaders/yaml.mjs", import.meta.url);
register("./loaders/coffee.mjs", import.meta.url);
