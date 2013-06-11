fs = require 'fs'
{exec} = require 'child_process'

task 'tests', 'run tests through mocha', ->
    console.log "Run tests with Mocha..."
    command = "mocha --reporter spec "
    command += "--require should --compilers coffee:coffee-script --colors"
    exec command, (err, stdout, stderr) ->
        if err
            console.log "Running mocha caught exception: \n" + err
        console.log stdout

task "xunit", "", ->
    process.env.TZ = "Europe/Paris"
    command = "mocha "
    command += " --require should --compilers coffee:coffee-script -R xunit "
    command += "> xunit.xml"
    exec command, (err, stdout, stderr) ->
        console.log stdout

task "build", "", ->
    console.log "Compile main file..."
    command = "coffee -c *.coffee"
    exec command, (err, stdout, stderr) ->
        if err
            console.log "Running coffee compiler caught exception: \n" + err
        else
            console.log "Compilation succeeded."
        console.log stdout
