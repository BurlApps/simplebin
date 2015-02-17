# Import NPM Module
piler = require "piler"
fs    = require "fs"

# Initialize Piler
pilers =
  coffee:
    piler: piler.createJSManager urlRoot: "/js/"
    formats: ["coffee", "js"]
  less:
    piler: piler.createCSSManager urlRoot: "/css/"
    formats: ["less", "css"]

module.exports.init = (app, srv)->
  for type, object of pilers
    piler = object.piler
    formats = object.formats
    piler.bind app, srv

    for directory in fs.readdirSync "#{__dirname}/#{type}"
      path = "#{__dirname}/#{type}/#{directory}"

      if fs.statSync(path).isDirectory()
        for file in fs.readdirSync path
          filePath = "#{path}/#{file}"

          if file is "external.txt"
            for link in fs.readFileSync(filePath, "utf-8").split "\n"
              if link
                if directory is "global"
                  piler.addUrl link
                else
                  piler.addUrl directory link
          else
            for format in formats
              if file.indexOf(format) != -1
                if directory is "global"
                  piler.addFile filePath
                else
                  piler.addFile directory, filePath

module.exports.express = (req, res, next)->
  req.coffee = pilers.coffee.piler;
  req.less = pilers.less.piler;
  next();
