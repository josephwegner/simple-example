global.configs = require './configs'
global.mongoose = require 'mongoose'
api = require 'simple-api'
fs = require 'fs'
url = require 'url'
request = require 'request'

v0 = null
kickoffTries = 0

kickoff = () ->
	kickoffTries++

	mongoose.connect configs.mongoURL, (err) ->
		if not err
			#Create API Server
			v0 = new api
				prefix: ["api", "v0"]
				host: configs.host
				port: configs.port
				logLevel: 5

			#Load Controllers
			v0.Controller "tasks", require "#{__dirname}/api/v0/controllers/tasks.coffee"


			#Mock simple-api model format
			require "#{__dirname}/api/v0/models/tasks.coffee"

			console.log "#{configs.name} now running at #{configs.host}:#{configs.port}"
		else if err & kickoffTries < 5
			console.log "Mongoose didn't work.  That's a bummer.  Let's try it again in half a second"
			setTimeout () ->
				kickoff()
			, 500
		else if err
			console.log "Mongo server seems to really be down.  We tried 5 times.  Tough luck."



kickoff()


