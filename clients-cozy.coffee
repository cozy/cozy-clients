Drone = exports.Client = require('./client-controller/drone')

exports.createClientController = (options) ->
  return drone: new Drone(options)