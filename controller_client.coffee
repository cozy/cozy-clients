Client = require("request-json").JsonClient

module.exports = class ControllerClient

    # @options {Object} Options to use for this instance.
    # Constructor function for the Client to the Cozy Controller server.
    constructor: (options) ->
        @options = options || {}

        @config =
            host: @options.host || 'localhost'
            port: @options.port || 9002

        @client = new Client "http://#{@config.host}:#{@config.port}/"
        @client.setToken @options.token if @options.token?
        @client.options =
            timeout: 3600 * 1000


    # function get (name, callback)
    # @name {string} name of the application to get from the Cozy Controller
    # server.
    # @callback {function} Continuation to pass control back to when complete.
    # Gets the data about all the drones for the app with the specified `name`
    # on the remote Controller server.
    get: (name, callback) ->
        @client.get "drones/#{name}", callback


    # function running (callback)
    # @callback {function} Continuation to pass control back to when complete.
    # Gets the data about all the drones on the hive.
    running: (callback) ->
        @client.get 'drones/running', callback


    # function start (app, callback)
    # @app {Object} Application to start on the Cozy Controller server.
    # @callback {function} Continuation to pass control back to when complete.
    # Starts the the app with the specified `app.name` on the remote Cozy
    # Controller server.
    start: (app, callback) ->
        data = start: app
        @client.post "drones/#{app.name}/start", data, callback


    # function stop (name, callback)
    # @name {string} Name of the application to stop on the Cozy Controller
    # server.
    # @callback {function} Continuation to pass control back to when complete.
    # Stops the application with the specified `name` on the remote Cozy
    # Controller server.
    stop: (name, callback) ->
        data =
            stop:
                name: name
        @client.post "drones/#{name}/stop", data, callback


    # function restart (name, callback)
    # @name {string} Name of the application to restart on the Cozy Controller
    # server.
    # @callback {function} Continuation to pass control back to when complete.
    # Restarts the application with the specified :id on the remote Cozy
    # Controller server.
    restart: (name, callback) ->
        data =
            restart:
                name: name
        @client.post "drones/#{name}/restart", data, callback


    # function brunch (app, callback)
    # @app {String} Application to build brunch
    # @callback {function} Continuation to pass control back to when complete.
    # Build brunch the application with specified :id on the remote Cozy
    # Controller server
    brunch: (app, callback) ->
        data = brunch: app
        @client.post "drones/#{app.name}/brunch", data, callback


    # function changeBranch (app, branch, callback)
    # @app {String} Application to change branch
    # @branch {String} new branch
    # @callback {function} Continuation to pass control back to when complete.
    # Change application branch
    changeBranch: (app, branch, callback) ->
        data = manifest: app
        @client.post "apps/" + app.name + "/change-branch/" + branch, data, callback


    # function ligthUpdate (app, callback)
    # @app {String} Application to update
    # @callback {function} Continuation to pass control back to when complete.
    # Update application with specified :id on the remote Cozy Controller
    # thanks to a git pull
    lightUpdate: (app, callback) ->
        data = update: app
        @client.post "drones/#{app.name}/light-update", data, callback


    # function updateStack (callback)
    # @callback {function} Continuation to pass control back to when complete.
    # Update stack application
    updateStack: (callback) ->
        @client.post "apps/update-stack", {}, callback


    # function restartController (callback)
    # @callback {function} Continuation to pass control back to when complete.
    # Restart controller
    restartController: (callback) ->
        @client.post "apps/restart-controller", {}, callback



    # function clean (app, callback)
    # @app {Object} Application to clean on the Cozy Controller server.
    # @callback {function} Continuation to pass control back to when complete.
    # Attempts to clean the specified `app` from the Cozy Controller server
    # targeted by this instance.
    clean: (app, callback) ->
        data = app
        @client.post "drones/#{app.name}/clean", data, callback


    # function cleanAll (app, callback)
    # @callback {function} Continuation to pass control back to when complete.
    # Attempts to clean the all applications from the Cozy Controller server
    # targeted by this instance.
    cleanAll: (callback) ->
        @client.post 'drones/cleanall', {}, callback
