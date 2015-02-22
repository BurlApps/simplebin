module.exports = (app, routes)->
	app.get '/register', routes.register.index
	app.post '/register', routes.register.register
