module.exports =
  core     : require './core'
  orm      : require './orm'
  error    : require './error'
  init     : (ejs)->
    @core.helpers()
    @core.filters ejs
