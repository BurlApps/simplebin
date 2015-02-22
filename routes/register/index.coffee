module.exports.index = (req, res, next)->
	res.render "register/index",
		title: "Register"
		js: req.coffee.renderTags "register"
		css: req.less.renderTags "register"

module.exports.register = (req, res, next)->
  req.models.User.create
    name: req.param "name"
    email: req.param "email"
    address: req.param "address"
  .then (user)->
    return user.addCard req.param("card"),
      month: parseInt(req.param("expiration").split("/")[0])
      year: parseInt(req.param("expiration").split("/")[1])
    , req.param "cvc"
  .then ->
    res.json success: true
