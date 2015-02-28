module.exports = (app, routes)->
	app.get '/register', routes.auth.loggedIn, routes.register.index
	app.post '/register', routes.register.register
