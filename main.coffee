ControllerClient = require('./controller_client/')

exports.controllerClient = (options) ->
  return new ControllerClient(options)
