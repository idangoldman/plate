const { Given, When, Then } = require("@cucumber/cucumber");
const { expect } = require("chai");
const { pathResolver } = require("../../pathResolver.mjs");
const { access } = require("node:fs/promises");

const sinon = require("sinon");

// Mock the fs/promises access function
sinon.stub(access);

Given("the environment variables are set as follows:", function (dataTable) {
  const envVars = dataTable.rowsHash();
  Object.assign(process.env, envVars);
});

Given("the file {string} {word}", function (filePath, existence) {
  if (existence === "exists") {
    access.withArgs(filePath, sinon.match.any).resolves();
  } else {
    access
      .withArgs(filePath, sinon.match.any)
      .rejects(new Error("File does not exist"));
  }
});

When("I resolve the path {string}", async function (specifier) {
  this.resolvedPath = await pathResolver(specifier);
});

Then("the resolved path should be {string}", function (expectedPath) {
  expect(this.resolvedPath).to.equal(expectedPath);
});
