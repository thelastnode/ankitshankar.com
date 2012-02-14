mongoose = require 'mongoose'

Schema = mongoose.Schema
ObjectId = Schema.ObjectId

Post = new Schema
  title: String
  body: String
  date: Date
  tags: [String]

exports.Post = mongoose.model('Post', Post)
