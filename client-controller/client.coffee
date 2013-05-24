##
## client.js: Client for the haibu API
##
## (C) 2012, Nodejitsu Inc.
##
##
 
request = require 'request'
base64 = require('utile').base64


## function Client (options)
## @options {Object} Options to use for this instance.
## Constructor function for the Client to the haibu API.

module.exports= class Client 

    constructor: (options) ->
        this.options = options || {};
      
        if (typeof this.options.get != 'function') 
            this.options.get = (key) ->
                return this[key]
    
        this.config = 
            host: options.host || 'localhost',
            port: options.port || 9002


        @failCodes = 
            400: 'Bad Request'
            401: 'Not authorized'
            403: 'Forbidden'
            404: 'Item not found'
            500: 'Internal Server Error'

        @successCodes = 
            200: 'OK'
            201: 'Created'

    Function::define = (prop, desc) ->
        Object.defineProperty this.prototype, prop, desc

   ## @remoteUri {string}
   ## Full URI for the remote Haibu server this client
   ## is configured to request against.

    @define 'remoteUri',
        get: ->
            return 'http://' + this.config.host + ':' + this.config.port


   ## @private _request (method, uri, [body], callback, success)
   ## @options {Object} Outgoing request options.
   ## @callback {function} Continuation to short-circuit to if request is unsuccessful.
   ## @success {function} Continuation to call if the request is successful
   ##cCore method for making requests against the haibu Drone API. Flexible with respect
   ## to continuation passing given success and callback.

    _request: (options, callback, success) ->
        self = this;
    
        if typeof options == 'string'
            options = path: options 
    
        options.method  = options.method || 'GET'
        options.uri     = this.remoteUri + options.path
        options.headers = options.headers || {}
        options.headers['content-type'] = options.headers['content-type'] || 'application/json'
        options.timeout = 8 * 60 * 1000
          
        if options.headers['content-type'] == 'application/json' && options.body 
            options.body = JSON.stringify(options.body)

        return request options, (err, response, body) ->
            if err
                return callback(err)

            statusCode = response.statusCode.toString()
            result = ""
            error = ""
              
            try 
                result = JSON.parse(body)
            catch err
            # Ignore Errors
          
            if Object.keys(self.failCodes).indexOf(statusCode) != -1
                error = new Error('haibu Error (' + statusCode + '): ' + self.failCodes[statusCode])
                error.result = result
                error.status = statusCode
                callback error

             success response, result
