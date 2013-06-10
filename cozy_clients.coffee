Drone = exports.Client = require('./controller-client/client')

exports.controllerClient = (options) ->
  return new Drone(options)