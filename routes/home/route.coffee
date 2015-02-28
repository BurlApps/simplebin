module.exports = (app, routes)->
	app.get '/', routes.auth.loggedIn, routes.home.index
