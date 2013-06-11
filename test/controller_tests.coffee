should = require('chai').Should()
ControllerClient = require("../main").ControllerClient

client = new ControllerClient()

app =
    "name": "notes"
    "user": "notes"
    "domain": "localhost"
    "repository":
        "type": "git"
        "url": "https://github.com/mycozycloud/cozy-notes.git"
    "scripts":
        "start": "server.coffee"

## Requirement : controller should be started

describe "Common requests", ->
	describe "start", ->
        it "When I send start request to controller", (done) ->
            @timeout(240000)
            client.start app, (error, response, body) =>
                response.statusCode.should.be.equal 200
                @body = body
                @error = error
                done()

        it "Then I get no error", ->
            should.equal @error, null

        it "And body has field drone.", ->
            should.exist @body.drone

    describe "get", ->
        it "When I send get request to controller", (done) ->
            client.get "notes", (error, response, body) =>
                response.statusCode.should.be.equal 200
                @body = body
                @error = error
                done()

        it "Then I get no error", ->
            should.equal @error, null

        it "And request send apps notes", ->
            should.exist @body.app
            should.exist @body.app.name
            @body.app.name.should.be.equal "notes"

    describe "running", ->
        it "When I send running request to controller", (done) ->
            client.running (error, response, body) =>
                response.statusCode.should.be.equal 200
                @body = body
                @error = error
                done()

        it "Then I get no error", ->
            should.equal @error, null

        it "And request send apps", ->
        	@body[0].name.should.be.exist

    describe "restart", ->
        it "When I send restart request to controller", (done) ->
            client.restart "notes", (error, response, body) =>
                response.statusCode.should.be.equal 200
                @body = body
                @error = error
                done()

        it "Then I get no error", ->
            should.equal @error, null

        it "And request send apps", ->
            should.exist @body.drones

    describe "brunch", ->
        it "When I send brunch request to controller", (done) ->
            @timeout(240000)
            client.brunch app, (error, response, body) =>
                response.statusCode.should.be.equal 200
                @body = body
                @error = error
                done()

        it "Then I get no error", ->
            should.equal @error, null

        it "And request send apps", ->
            should.exist @body.brunch
            @body.brunch.should.be.equal true

    describe "light-update", ->
        it "When I send light-update request to controller", (done) ->
            @timeout(240000)
            client.lightUpdate app, (error, response, body) =>
                response.statusCode.should.be.equal 200
                @body = body
                @error = error
                done()

        it "Then I get no error", ->
            should.equal @error, null

        it "And request send apps", ->
            should.exist @body.update
            @body.update.should.be.equal true

    describe "stop", ->
        it "When I send stop request to controller", (done) ->
            client.stop "notes", (error, response, body) =>
                response.statusCode.should.be.equal 200
                @body = body
                @error = error
                done()

        it "Then I get no error", ->
            should.equal @error, null

    describe "clean", ->
        it "When I send clean request to controller", (done) ->
            client.clean app, (error, response, body) =>
                response.statusCode.should.be.equal 200
                @body = body
                @error = error
                done()

        it "Then I get no error", ->
            should.equal @error, null

    describe "cleanAll", ->
        it "When I send clean all request to controller", (done) ->
            client.cleanAll (error, response, body) =>
                response.statusCode.should.be.equal 200
                @body = body
                @error = error
                done()

        it "Then I get no error", ->
            should.equal @error, null



