module.exports = (app, routes)->
	app.get '/login', routes.auth.loggedIn, routes.login.index
	app.get '/logout', routes.login.logout
	app.post '/login', routes.login.login
