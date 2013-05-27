#
# drone.js: API Client for the haibu Drone API.
#
# (C) 2012, Nodejitsu Inc.
#
#

Client = require("request-json").JsonClient



module.exports = class Drone


   ## function Drone (options)
   ## @options {Object} Options to use for this instance.
   ## Constructor function for the Client to the Haibu server.
   constructor: (options) ->
        options.token = "unknown"
        @options = options || {};
      
        if (typeof this.options.get != 'function') 
            @options.get = (key) ->
                return this[key]
    
        @config = 
            host: options.host || 'localhost',
            port: options.port || 9002

        @client = new Client "http://localhost:9002/"


   ## function get (name, callback)
   ## @name {string} name of the application to get from the Haibu server.
   ## @callback {function} Continuation to pass control back to when complete.
   ## Gets the data about all the drones for the app with the specified `name`
   ## on the remote Haibu server.

    get: (name, callback) ->
        @client.setToken @options.get("token")
        @client.get 'drone/' + name, callback


   ## function running (callback)
   ## @callback {function} Continuation to pass control back to when complete.
   ## Gets the data about all the drones on the hive.

    running: (callback) ->
        @client.setToken @options.get("token")
        @client.get 'drones/running', callback


   ## function start (app, callback)
   ## @app {Object} Application to start on the Haibu server.
   ## @callback {function} Continuation to pass control back to when complete.
   ## Starts the the app with the specified `app.name` on the remote Haibu server.

    start: (app, callback) ->
        data = start: app 
        @client.setToken @options.get("token")
        @client.post 'drones/' + app.name + '/start', data, callback

   ## function stop (name, callback)
   ## @name {string} Name of the application to stop on the Haibu server.
   ## @callback {function} Continuation to pass control back to when complete.
   ## Stops the application with the specified `name` on the remote Haibu server.

    stop: (name, callback) ->
        data = 
            stop: 
                name: name
        @client.setToken @options.get("token")
        @client.post 'drones/' + name + '/stop', data, callback


   ## function restart (name, callback)
   ## @name {string} Name of the application to restart on the Haibu server.
   ## @callback {function} Continuation to pass control back to when complete.
   ## Restarts the application with the specified :id on the remote Haibu server.

    restart: (name, callback) ->
        data =
            restart: 
                name: name
        @client.setToken @options.get("token")
        @client.post 'drones/' + name + '/restart', data, callback


    ## function brunch (app, callback)
    ## @app {String} Application to build brunch
    ## @callback {function} Continuation to pass control back to when complete.
    ## Build brunch the application with specified :id on the remote Haibu server

    brunch: (name, callback) ->
        data = brunch: app
        @client.setToken @options.get("token")
        @client.post 'drones/' + app.name + '/brunch', data, callback


    ## function ligthUpdate (app, callback)
    ## @app {String} Application to update
    ## @callback {function} Continuation to pass control back to when complete.
    ## Update application with specified :id thanks to a git pull

    lightUpdate: (name, callback) ->
        data = update: app
        @client.setToken @options.get("token")
        @client.post 'drones/' + app.name + '/light-update', data, callback


   ## function clean (app, callback)
   ## @app {Object} Application to clean on the Haibu server.
   ## @callback {function} Continuation to pass control back to when complete.
   ## Attempts to clean the specified `app` from the Haibu server targeted by this instance.

    clean: (app, callback) ->
        data = app
        @client.setToken @options.get("token")
        @client.post 'drones/' + app.name + '/clean', data, callback


   ## function cleanAll (app, callback)
   ## @callback {function} Continuation to pass control back to when complete.
   ## Attempts to clean the all applications from the Haibu server targeted by this instance.

    cleanAll: (callback) ->
        @client.setToken @options.get("token")
        @client.post 'drones/cleanall', {}, callback