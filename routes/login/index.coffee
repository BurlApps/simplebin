module.exports.index = (req, res, next)->
  res.render "login/index",
    title: "Login"
    js: req.coffee.renderTags "login"
    css: req.less.renderTags "login"

module.exports.login = (req, res, next)->
  req.models.User.find
    where:
      email: req.param "email"
      password: req.models.User.hash req.param "password"

  .then (user)->
    if user?
      req.session.user = user
      req.session.save()
      res.json success: true

    else
      res.json
        success: false
        message: "Invalid Credentials :("

  .catch (error)->
    res.json
      success: false
      message: "Invalid Credentials :("

module.exports.logout = (req, res, next)->
  req.session.user = null
  req.session.save()
  res.redirect "/"
