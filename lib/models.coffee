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
  date: Date
  tags: [String]

exports.Tag = mongoose.model('Tag', Tag)
exports.Post = mongoose.model('Post', Post)
