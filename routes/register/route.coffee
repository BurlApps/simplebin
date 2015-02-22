module.exports = (app, routes)->
	app.get '/', routes.register.index
	app.post '/register', routes.register.register
