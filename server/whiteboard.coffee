fs = require 'fs'

express = require 'express'
app = express.createServer()

# serve JS files
app.get '/:jsfile.js', (req, res) ->
	fs.readFile "./javascripts/#{req.params.jsfile}.js", (err, data) ->
		if err
			res.send 'not found', 404
		else
			res.header 'Content-Type', 'text/javascript'
			res.send data

app.get '/', (req, res) ->
	fs.readFile '../client/whiteboard.html', (err, html) ->
		res.contentType 'text/html'
		res.send html
		res.end

app.listen 3000

everyone = require('now').initialize app

everyone.now.distribute_draw = (x, y) ->
	everyone.now.receive_draw x, y

everyone.now.distribute_identify = (name) ->
	everyone.now.receive_identify name