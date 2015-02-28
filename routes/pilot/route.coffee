module.exports = (app, routes)->
  app.get '/pilot', routes.pilot.index
  app.post '/pilot', routes.pilot.register
