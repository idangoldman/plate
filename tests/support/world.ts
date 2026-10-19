import { setWorldConstructor, World, IWorldOptions } from "@cucumber/cucumber";

export class PlateWorld extends World {
  public error: any;
  public expected: any;
  public input: any;
  public result: any;

  constructor(options: IWorldOptions) {
    super(options);
    this.error = undefined;
    this.expected = undefined;
    this.input = undefined;
    this.result = undefined;
  }
}

setWorldConstructor(PlateWorld);
