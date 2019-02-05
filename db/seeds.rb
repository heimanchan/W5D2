# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[User, Sub, Post, Comment].each(&:destroy_all)

ActiveRecord::Base.transaction do 
  dave = User.create!(username: "dave", password: "password")
  drew = User.create!(username: "drew", password: "password")

  ruby = Sub.create!(title: "Ruby", description: "Ruby Programming Language", moderator: drew)
  html = Sub.create!(title: "HTML", description: "Hypertext Markup Language", moderator: dave)
  world_news = Sub.create!(title: "World News", description: "News of the world", moderator: drew)

  oop = Post.create!(title: "OOP", url: "ruby.com", content: "Everything is an object!", author: drew, subs: [ruby, html])
  world_hunger = Post.create!(title: "World Hunger Solved", url: "cnn.com", content: "Give everyone beer!", author: drew, subs: [html, world_news])
  peace = Post.create!(title: "The world is in peace", url: "cnn.com", content: "By giving everyone a beer!", author: dave, subs: [html, world_news])

  comment1 = Comment.create!(content: "I love ruby!", author: drew, post: oop)
  comment2 = Comment.create!(content: "I love beer", author: dave, post: world_hunger)
  comment3 = Comment.create!(content: "I make beer!", author: drew, post: peace)
end