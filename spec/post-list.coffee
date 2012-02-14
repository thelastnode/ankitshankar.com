assert = require 'assert'
Browser = require 'zombie'
vows = require 'vows'

conf = require '../conf'
conf.mongo_uri = 'mongodb://localhost/test'

models = require '../lib/models'
app = require '../app'

vows.describe('Post List').addBatch({
  'When looking at 25 posts':
    topic: () ->
      cb = @callback
      models.Post.remove((err) ->
        [1..25].map (i) -> new models.Post(
          title: "Post #{i}"
          body: "Some text for post #{i}"
          date: new Date()
          tags: ['test']
        ).save((err) ->
          Browser.visit('http://localhost:3000/', cb) if i == 25
        )
      )
      return

    teardown: () ->
      models.Post.remove()

    'there should be an older post button': (err, browser) ->
      assert.ok(browser?.query('.older'))
    'there shouldn\'t be a newer post button': (err, browser) ->
      assert.ok(browser?.query)
      assert.isUndefined(browser?.query('.newer'))
    'there should be 10 posts': (err, browser, status) ->
      assert.lengthOf(browser?.queryAll('.post'), 10)

    'after clicking older':
      topic: (browser) ->
        browser.clickLink('.older', @callback)
        return

      'there should be an older post button': (err, browser, status) ->
        assert.ok(browser?.query('.older'))
      'there should be a newer post button': (err, browser, status) ->
        assert.ok(browser?.query('.newer'))
      'there should be 10 posts': (err, browser, status) ->
        assert.lengthOf(browser?.queryAll('.post'), 10)

      'after clicking older':
        topic: (browser, status) ->
          browser.clickLink('.older', @callback)
          return

        'there shouldn\'t be an older post button': (err, browser, status) ->
          assert.ok(browser?.query)
          assert.isUndefined(browser.query('.older'))
        'there should be a newer post button': (err, browser, status) ->
          assert.ok(browser?.query('.newer'))
        'there should be 5 posts': (err, browser, status) ->
          assert.lengthOf(browser?.queryAll('.post'), 5)
}).export(module)