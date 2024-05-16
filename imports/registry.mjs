import { register } from "node:module";

// Importing global variables
import "./globals.mjs";

// Registering loaders
register(`${PLATE_PKG}/imports/loaders/resolver.mjs`, import.meta.url);
register(`${PLATE_PKG}/imports/loaders/cjs.mjs`, import.meta.url);
register(`${PLATE_PKG}/imports/loaders/yaml.mjs`, import.meta.url);
register(`${PLATE_PKG}/imports/loaders/coffee.mjs`, import.meta.url);

// Setting up environment variables
(async () => await import(`${PLATE_PKG}/imports/environment.mjs`))();
