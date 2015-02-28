module.exports = (app, routes)->
	app.get '/account', routes.auth.restricted, routes.account.index
	#app.post '/account', routes.auth.restricted, routes.account.update
