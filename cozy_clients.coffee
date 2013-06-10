ControllerClient = require('./controller-client/client')

exports.controllerClient = (options) ->
  return new ControllerClient(options)