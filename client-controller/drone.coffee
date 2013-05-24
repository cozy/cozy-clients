#
# drone.js: API Client for the haibu Drone API.
#
# (C) 2012, Nodejitsu Inc.
#
#

request = require 'request'
Client = require './client'
token = "unknown"



module.exports = class Drone extends Client


   ## function Drone (options)
   ## @options {Object} Options to use for this instance.
   ## Constructor function for the Client to the Haibu server.
   construction: (options) ->
        super options


   ## function get (name, callback)
   ## @name {string} name of the application to get from the Haibu server.
   ## @callback {function} Continuation to pass control back to when complete.
   ## Gets the data about all the drones for the app with the specified `name`
   ## on the remote Haibu server.

    get: (name, callback) ->
        this._request
            path: '/drones/' + name
            headers: 
                'x-auth-token': this.options.get("token")
          
        , callback, (res, result) ->
            callback null, result

 

   ## function running (callback)
   ## @callback {function} Continuation to pass control back to when complete.
   ## Gets the data about all the drones on the hive.

    running: (callback) ->
        this._request
            path: '/drones/running'
            headers: 
                'x-auth-token': this.options.get("token")

        , callback, (res, result) ->
            callback null, result


   ## function start (app, callback)
   ## @app {Object} Application to start on the Haibu server.
   ## @callback {function} Continuation to pass control back to when complete.
   ## Starts the the app with the specified `app.name` on the remote Haibu server.

    start: (app, callback) ->
        this._request
            method: 'POST'
            path: '/drones/' + app.name + '/start'
            headers: 
                'x-auth-token': this.options.get("token")
            body: 
                start: app 

        , callback, (res, result) ->
            callback null, result


   ## function stop (name, callback)
   ## @name {string} Name of the application to stop on the Haibu server.
   ## @callback {function} Continuation to pass control back to when complete.
   ## Stops the application with the specified `name` on the remote Haibu server.

    stop: (name, callback) ->
        this._request
            method: 'POST'
            path: '/drones/' + name + '/stop'
            headers: 
                'x-auth-token': this.options.get("token")
            body: 
                stop: 
                    name: name

        , callback, (res, result) ->
            callback res, result


   ## function restart (name, callback)
   ## @name {string} Name of the application to restart on the Haibu server.
   ## @callback {function} Continuation to pass control back to when complete.
   ## Restarts the application with the specified :id on the remote Haibu server.

    restart: (name, callback) ->
        this._request
            method: 'POST'
            path: '/drones/' + name + '/restart'
            headers: 
                'x-auth-token': this.options.get("token")
            body: 
                restart: 
                    name: name

        , callback, (res, result) ->
            callback null, result.drones


    ## function brunch (app, callback)
    ## @app {String} Application to build brunch
    ## @callback {function} Continuation to pass control back to when complete.
    ## Build brunch the application with specified :id on the remote Haibu server

    brunch: (app, callback) ->
        this._request
            method: 'POST'
            path: '/drones/' + app.name + '/brunch'
            headers: 
                'x-auth-token': this.options.get("token")
            body: 
                brunch: app

        , callback, (res, result) ->
            callback null, result.drones


    ## function ligthUpdate (app, callback)
    ## @app {String} Application to update
    ## @callback {function} Continuation to pass control back to when complete.
    ## Update application with specified :id thanks to a git pull

    lightUpdate: (app, callback) ->
        this._request
            method: 'POST'
            path: '/drones/' + app.name + '/light-update'
            headers: 
                'x-auth-token': this.options.get("token")
            body: 
                update: app

        , callback, (res, result) ->
            callback null, result.drones 


   ## function clean (app, callback)
   ## @app {Object} Application to clean on the Haibu server.
   ## @callback {function} Continuation to pass control back to when complete.
   ## Attempts to clean the specified `app` from the Haibu server targeted by this instance.

    clean: (app, callback) ->
        @._request
            method: 'POST'
            path: '/drones/' + app.name + '/clean'
            headers:
                'x-auth-token': this.options.get("token")
            body: app

        , callback, (res, result) ->
            callback null, result


   ## function cleanAll (app, callback)
   ## @callback {function} Continuation to pass control back to when complete.
   ## Attempts to clean the all applications from the Haibu server targeted by this instance.

    cleanAll: (callback) ->
        this._request
            method: 'POST'
            path: '/drones/cleanall'
            headers: 
                'x-auth-token': this.options.get("token")
              
            , callback, (res) ->
                callback