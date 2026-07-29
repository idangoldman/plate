export default {
  default: {
    requireModule: ['ts-node/register'],
    require: ['tests/support/**/*.ts', 'tests/steps/**/*.ts'],
    format: ['progress-bar'],
    paths: ['tests/features/**/*.feature']
  }
}
