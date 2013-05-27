Drone = exports.Client = require('./controller-client/drone')

exports.controllerClient = (options) ->
  return drone: new Drone(options)