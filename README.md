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
client.cleanAll (err, res, result) ->
    console.log result
```

## What is Cozy?

![Cozy Logo](https://raw.github.com/mycozycloud/cozy-setup/gh-pages/assets/images/happycloud.png)

[Cozy](http://cozy.io) is a platform that brings all your web services in the
same private space.  With it, your web apps and your devices can share data
easily, providing you
with a new experience. You can install Cozy on your own hardware where no one
profiles you. You install only the applications you want. You can build your
own one too.

## Community 

You can reach the Cozy community via various support:

* IRC #cozycloud on irc.freenode.net
* Post on our [Forum](https://groups.google.com/forum/?fromgroups#!forum/cozy-cloud)
* Post issues on the [Github repos](https://github.com/mycozycloud/)
* Via [Twitter](http://twitter.com/mycozycloud)
