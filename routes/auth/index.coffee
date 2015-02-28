module.exports.restricted = (req, res, next)->
  if not req.session.user?
    res.redirect "/login"
  else
    next()

module.exports.loggedIn = (req, res, next)->
  if req.session.user?
    res.redirect "/account"
  else
    next()
