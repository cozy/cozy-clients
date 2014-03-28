# Description

Collection of clients to access to Cozy APIs.

## Install 

Add the lib to you dependencies

    npm install cozy-clients --save

## Cozy Controller Client

Commands available in the controller client:

```coffeescript
ControllerClient = require("cozy-clients").ControllerClient

# Token to access to controller located in /etc/cozy/controller.token
client = new ControllerClient
    token: token


# Get infos about given app.
client.get 'calendar', (err, res, appInfos) ->
    console.log appInfos


# Return list of running applications.
client.running 'calendar', (err, res, apps) ->
    console.log apps

# Start (and install it not installed) given application.
# It returns application information (running port, pid, etc.)
client.start 'calendar', (err, res, appInfos) ->
    console.log appInfos

# Stop given application.
# It returns application information (running port, pid, etc.)
client.stop 'calendar', (err, res, appInfos) ->
    console.log appInfos

# Stop then start application.
# It returns application information (running port, pid, etc.)
client.restart 'calendar', (err, res, appInfos) ->
    console.log appInfos

# Update given application (git pull + npm install).
# It returns application information (running port, pid, etc.)
client.lightUpdate 'calendar', (err, res, appInfos) ->
    console.log appInfos

# Remove given application
client.clean 'calendar', (err, res, result) ->
    console.log result

# Remove all applications
client.cleanAll 'calendar', (err, res, result) ->
    console.log result
```

# About Cozy

Cozy is the personal server for everyone. It allows you to install your every
day web applications easily on your server, a single place you control. This
means you can manage efficiently your data while protecting your privacy
without technical skills.

More informations and hosting services on:
http://cozycloud.cc

