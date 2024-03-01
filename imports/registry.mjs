import { register } from "node:module";

// Importing global variables
import "./globals.mjs";

// Registering loaders
register("./loaders/resolver.mjs", import.meta.url);
register("./loaders/cjs.mjs", import.meta.url);
register("./loaders/yaml.mjs", import.meta.url);
register("./loaders/coffee.mjs", import.meta.url);

// Setting up environment variables
(async () => await import("./environment.mjs"))();
