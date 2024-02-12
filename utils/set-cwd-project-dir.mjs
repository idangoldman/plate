import fs from "node:fs";
import path from "node:path";
import os from "os";

const HOME_DIR = os.homedir();

try {
  const projectRootDir = findProjectRootDir(process.cwd());
  process.chdir(projectRootDir);
  console.log(`Changed directory to: ${process.cwd()}`);
} catch (err) {
  console.error(`Error: ${err.message}`);
}

function findProjectRootDir(currentDir) {
  const parentDir = path.dirname(currentDir);

  if (currentDir === HOME_DIR || currentDir === parentDir) {
    throw new Error("No package.json found in any parent directory.");
  }

  if (fs.existsSync(path.join(currentDir, "package.json"))) {
    return path.resolve(currentDir);
  }

  return findProjectRootDir(parentDir);
}
