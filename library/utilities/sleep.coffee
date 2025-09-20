# usage: `sleep 1000` for 1 second sleep
export default sleep = (milliseconds) ->
  startTime = new Date().getTime()

  loop
    elapsedTime = new Date().getTime() - startTime

    if elapsedTime > milliseconds
      break

    continue

# usage: `await snooze 1000` for 1 second sleep
export snooze = (milliseconds) ->
  new Promise (resolve) ->
    setTimeout resolve, milliseconds

# usage: `await element_load '.selector'` for 10 seconds
export element_load = (selector, timeout = 10000) ->
  new Promise (resolve, reject) ->
    startTime = new Date().getTime()

    loop
      element = document.querySelector selector

      if element
        resolve element
        break

      elapsedTime = new Date().getTime() - startTime

      if elapsedTime > timeout
        reject new Error "Timeout: Element not found"

      continue
