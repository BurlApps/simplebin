module.exports.index = (req, res, next)->
  module.exports.index = (req, res, next)->
  res.render "account/index",
		title: "Account"
		js: req.coffee.renderTags "account"
		css: req.less.renderTags "account"
