posts = require './posts'

exports.registerOn = (app) ->
  app.get '/', posts.list
  app.get '/tags/:tag', posts.list
  app.get '/posts/:slug', posts.details