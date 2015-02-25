module.exports.index = (req, res, next)->
  userName = req.param "name"

  if userName
    res.locals.config = userName: userName

  res.render "register/index",
    title: "Register"
    js: req.coffee.renderTags "register"
    css: req.less.renderTags "register"

module.exports.register = (req, res, next)->
  req.models.User.create
    name: req.param "name"
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
    res.json
      success: false
      message: error.errors[0].message
