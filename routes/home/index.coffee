module.exports = (req, res, next)->
	res.render "home/index",
		title: false
		js: req.coffee.renderTags "home", "login"
		css: req.less.renderTags "home", "login"
