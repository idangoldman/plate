export default {
  default: {
    import: ['./tests/support/**/*.ts', './tests/steps/**/*.ts'],
    format: ['progress-bar'],
    paths: ['./tests/features/**/*.feature']
  }
}
