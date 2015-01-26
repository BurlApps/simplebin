# Configure For AWS RDS
orm           = config.orm
orm.port      = process.env.RDS_PORT or orm.port
orm.host      = process.env.RDS_HOSTNAME or orm.host
orm.username  = process.env.RDS_USERNAME or orm.username
orm.password  = process.env.RDS_PASSWORD or orm.password

# Create Sequelize Instance
fs        = require "fs"
Sequelize = require "sequelize"
sequelize = new Sequelize orm.database, orm.username, orm.password, orm
models    = {}

# Import Models
for directory in fs.readdirSync "#{__dirname}"
  path = "#{__dirname}/#{directory}"

  if fs.statSync(path).isDirectory()
    for file in fs.readdirSync path
      model = sequelize.import "#{path}/#{file}"
      models[model.name] = model

# Create Associations
for name, model of models
  if "associate" in model
    model.associate database

# Sync with Database
sequelize.sync()

# Initalize
module.exports.sequelize  = sequelize
module.exports.Sequelize  = Sequelize
module.exports.models     = models
module.exports.express    = (req, res, next)->
  req.models    = models
  req.sequelize = sequelize
  req.Sequelize = Sequelize
  next()
