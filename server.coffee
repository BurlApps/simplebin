# Import NPM Modules
express             = require "express"
slashes             = require "connect-slashes"
ejs                 = require "ejs"
app                 = express()
srv                 = require("http").createServer(app)
session             = require('express-session')
RedisStore          = require('connect-redis')(session)

# Import Local Modules
routes              = require "./routes"
locals              = require "./routes/locals"
assets              = require "./assets"

# Global Variables
GLOBAL.isProduction = process.env.NODE_ENV is "production"
GLOBAL.async        = require "async"
GLOBAL.Promise      = require "bluebird"
GLOBAL.config       = require "./config"
GLOBAL.lib          = require "./lib"

# Initialize Lib
lib.init.bind(lib, ejs)()

# HTML Engine
app.engine "html", ejs.renderFile

# Express Config
app.set "views", "#{__dirname}/views"
app.set "view engine", "html"
app.set "view options", layout: true
app.set "view cache", true
app.set "x-powered-by", false

# Express Settings
app.use require('morgan')('dev')
app.use require('compression')()
app.use require('body-parser').json()
app.use require('body-parser').urlencoded extended: true
app.use require('method-override') "X-HTTP-Method-Override"
app.use require('cookie-parser')()
app.use session
	resave: false
	saveUninitialized: false
	name: config.cookies.session.key,
	secret: config.cookies.session.secret
	unset: "destroy"
	store: new RedisStore()

# Piler Assests
assets.init app, srv
app.use assets.express

# Direct Assests
app.use "/favicon", require('serve-static') "#{__dirname}/assets/favicons"
app.use "/fonts", require('serve-static') "#{__dirname}/assets/fonts"
app.use "/img", require('serve-static') "#{__dirname}/assets/images"

# External Addons
app.use slashes true

# Initialize Orm
app.use lib.orm.express

# Setup Locals
app.use locals

# Setup Routes
app.use routes.route

# Activate Routes
routes.init app

# Start Listening to Port
srv.listen process.env.PORT or config.general.port
