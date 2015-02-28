module.exports.index = (req, res, next)->
  res.render "pilot/index",
		title: "Pilot"
		js: req.coffee.renderTags "pilot"
		css: req.less.renderTags "pilot"

module.exports.register = (req, res, next)->
  req.models.User.create
    pilot: true
    email: req.param "email"
    address: req.param "address"
    day: if req.param("day") is "" then null else req.param "day"

  .then (user)->
    return user.addCard req.param("card"),
      month: parseInt req.param("expiration").split("/")[0]
      year: parseInt req.param("expiration").split("/")[1]
    , req.param "cvc"

  .then ->
    res.json success: true

  .catch (error)->
    if error.errors?
      error = error.errors[0].message
    else
      error = error.message

    res.json
      success: false
      message: error
