Drone = exports.Client = require('./controller-client/client')

exports.controllerClient = (options) ->
  return drone: new Drone(options)