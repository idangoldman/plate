import { spawn } from 'node:child_process'
import { dirname, join } from 'node:path'
import { fileURLToPath } from 'node:url'

findPackageRoot = (packageName = '@idangoldman/plate') ->
  try
    currentDir = process.cwd()
    packageJsonPath = join(currentDir, 'package.json')
    packageJson = await import(packageJsonPath, { with: { type: 'json' } })

    if packageJson.default?.name is packageName
      return currentDir
  catch
    console.warn "#{packageName} is not in #{currentDir}"

  try
    packageJsonUrl = await import.meta.resolve("#{packageName}/package.json")
    packageJsonPath = fileURLToPath(packageJsonUrl)
    return dirname(packageJsonPath)
  catch error
    throw new Error("Could not resolve #{packageName} package: #{error.message}")

main = ->
  process.env.PLATE_ENV = process.env.PLATE_ENV or 'development'
  process.env.PLATE_PKG_PATH = await findPackageRoot()
  process.env.PLATE_PRJ_PATH = process.cwd()

  cliArguments = process.argv.slice(2)

  # If the first argument is 'pkg', switch to package context
  if cliArguments.length > 0 && cliArguments[0] is 'pkg'
    process.env.PLATE_PRJ_PATH = process.env.PLATE_PKG_PATH
    cliArguments = cliArguments.slice(1)

  # Default to 'help' if no task is provided, and separate task name from its arguments
  [ taskName, ...taskArgs ] = if cliArguments.length > 0 then cliArguments else ['help']

  cliOptions = ['-t', "#{process.env.PLATE_PKG_PATH}/tasks", taskName]

  if taskArgs.length > 0
    cliOptions.push('--', ...taskArgs)

  taskProcess = spawn('task', cliOptions, {
    stdio: 'inherit'
    env: process.env
  })

  taskProcess.on 'exit', (code) ->
    process.exit(code ? 0)

  taskProcess.on 'error', (error) ->
    console.error('Error executing task:', error.message)
    process.exit(1)

main().catch (error) ->
  console.error('CLI error:', error.message)
  process.exit(1)
