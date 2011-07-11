# Modules
express = require 'express'
util = require 'util'
dnode = require 'dnode'
EventEmitter = require('events').EventEmitter

# Initializerz
app = express.createServer()
emitter = new EventEmitter


# Setup Template Engine
app.register '.coffee', require('coffeekup')
app.set 'view engine', 'coffee'

# Setup Static Files
app.use express.static(__dirname + '/public')

browserify = require 'browserify';
app.use browserify(
    require : [
        'dnode',
        jquery : 'jquery-browserify'
    ],
    entry : __dirname + '/client.coffee'
);

# App Routes
app.get '/', (request, response) ->
  response.render 'index'

# Listen
app.listen 3000

# On prévient que le serveur écoute
console.log '  ** Express server started and listening on port 3000'
console.log '   * Accesible via http://localhost:3000/'

clients = {}

chat_server = (client, con) ->
	events_names = ['joined', 'said', 'parted']
	
	con.on 'ready', =>
		console.log('  ** New client connected with nickname : ' + client.name)
		emitter.on name, client[name] for name in events_names
		emitter.emit 'joined', client.name
		clients[client.name] = client
		
	con.on 'end', ->
		emitter.removeListener(name, client[name]) for name in events_names
		emitter.emit('parted', client.name);
		delete clients[client.name];

	this.say = (msg) ->
  		emitter.emit('said', client.name, msg);

  this.names = (cb) ->
  	cb Object.keys(clients)

	this

# Lancement du serveur DNode
dnode(chat_server).listen(app)

console.log '  ** Dnode server started, listening to Express server'



