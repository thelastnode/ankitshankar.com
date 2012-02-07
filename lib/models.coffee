mongoose = require 'mongoose'

Schema = mongoose.Schema
ObjectId = Schema.ObjectId

Tag = new Schema
  name:
    type: String
    unique: true

Post = new Schema
  title: String
  body: String
  tags: [{
    type: String
    ref: 'Tag'
  }]

exports.Tag = mongoose.model('Tag', Tag)
exports.Post = mongoose.model('Post', Post)
