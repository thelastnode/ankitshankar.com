async = require 'async'
url = require 'url'

models = require '../lib/models'

exports.list = (req, res, next) ->
  limit = 10

  if req.query.skip
    req.query.skip = +req.query.skip

  async.parallel([
    (cb) ->
      q = models.Post.find()
      q = q.limit limit
      if req.query.skip
        q = q.skip req.query.skip

      if req.params.tag
        q = q.where('tags', req.params.tag)

      q.run(cb)
    (cb) ->
      models.Post.find().count().run(cb)
  ], (err, results) ->
    if err
      return next(err)

    posts = results[0]
    total = results[1]

    has_newer = req.query.skip and req.query.skip > 0 and total > 0
    has_older = ((req.query.skip || 0) + posts.length) < total

    newer = (req.query.skip || 0) - limit
    older = (req.query.skip || 0) + limit

    norm_url = url.parse(req.url)

    res.render 'list',
      title: 'Ankit Shankar'
      posts: posts
      newer_page: has_newer and "#{norm_url.pathname}?skip=#{newer}"
      older_page: has_older and "#{norm_url.pathname}?skip=#{older}"
  )

exports.details = (req, res, next) ->
  res.send 404