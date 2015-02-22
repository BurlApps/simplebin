module.exports =
  core     : require './core'
  orm      : require './orm'
  error    : require './error'
  stripe   : require './stripe'
  init     : (ejs)->
    @core.helpers()
    @core.filters ejs
