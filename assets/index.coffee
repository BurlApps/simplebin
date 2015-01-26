# Import NPM Module
piler = require "piler"
fs    = require "fs"

# Initialize Piler
pilers =
  coffee : piler.createJSManager urlRoot: "/js/"
  less   : piler.createCSSManager urlRoot: "/css/"

module.exports.init = (app, srv)->
  for type, piler of pilers
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
          else if file.indexOf(type) != -1
            if directory is "global"
              piler.addFile filePath
            else
              piler.addFile directory, filePath

module.exports.express = (req, res, next)->
  req.coffee = pilers.coffee;
  req.less = pilers.less;
  next();
