module.exports = (req, res, next)->
	# Set Server Root For Non Express Calls
	req.session.server = "#{req.protocol}://#{req.hostname}"

	if config.general.port != 80
	  req.session.server += ":#{config.general.port}"

	if not config.general.production or not config.random
		config.random = Math.floor (Math.random() * 1000000) + 1

	# Header Config
	res.header 'Server', config.general.company
	res.header 'Access-Control-Allow-Credentials', true
	res.header 'Access-Control-Allow-Origin', req.hostname
	res.header 'Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE'
	res.header 'Access-Control-Allow-Headers', 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Accept'

	#Locals
	res.locals.csrf = if req.csrfToken then req.csrfToken() else ""
	res.locals.host = req.session.server
	res.locals.title = ""
	res.locals.site_title = config.general.company
	res.locals.site_delimeter = config.general.delimeter
	res.locals.description = config.general.description.join ""
	res.locals.company = config.general.company
	res.locals.logo = config.general.logo
	res.locals.config = {}
	res.locals.icons = config.icons
	res.locals.user = req.session.user
	res.locals.title_first = true
	res.locals.random = "?rand=" + config.random
	res.locals.search = ""
	res.locals.logos =
		"logo" : "/img/logo.png"
		"graph": "/favicon/logo.png"
		"1000" : "/favicon/logo.png"
		"500"  : "/favicon/logo.png"
		"196"  : "/favicon/logo.png"
		"160"  : "/favicon/logo.png"
		"114"  : "/favicon/logo.png"
		"72"   : "/favicon/logo.png"
		"57"   : "/favicon/logo.png"
		"32"   : "/favicon/logo.png"

	# Redirect
	if "www" not in req.subdomains
		next()
	else
		res.redirect "#{req.protocol}://#{req.hostname.split(".").slice(1).join(".")}#{req.path}"
