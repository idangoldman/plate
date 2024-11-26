export printLog = (messages...) ->
  console.log "##############################"
  console.log "##############################"
  console.log message for message in messages
  console.log "##############################"
  console.log "##############################"

export print = (messages...) ->
  console.log message for message in messages

export default printLog
