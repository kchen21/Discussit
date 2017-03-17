# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(first_name: 'Guest', last_name: 'K331', email: 'guest@discussit.com', username: 'Guest', password: '123456') # id: 1
User.create!(first_name: 'Rintaro', last_name: 'Okabe', email: 'hououinkyouma@discussit.com', username: 'Hououin_Kyouma', password: '123456') # id: 2
User.create!(first_name: 'Itaru', last_name: 'Hasida', email: 'barreltitor@discussit.com', username: 'Barrel_Titor', password: '123456') # id: 3
User.create!(first_name: 'Kurisu', last_name: 'Makise', email: 'kurigohanandkamehameha@discussit.com', username: 'KuriGohan_and_Kamehameha', password: '123456') # id: 4
User.create!(first_name: 'Suzuha', last_name: 'Amane', email: 'johntitor@discussit.com', username: 'John_Titor', password: '123456') # id: 5

Subforum.create!(title: 'Jokes', description: 'Laughter is the best medicine', moderator_id: 2) # id: 1

Post.create!(title: 'Clean Jokes', body: 'Dirty jokes are not allowed! Keep it work-safe!', subforum_id: 1, author_id: 2) # id: 1

Comment.create!(body: 'I have an EpiPen. My friend gave it to me when he was dying. It seemed very important to him that I have it.', author_id: 2, post_id: 1) # id: 1
Comment.create!(body: 'I bought the world\'s worst thesaurus yesterday. Not only is it terrible, it\'s terrible.', author_id: 3, post_id: 1) # id: 2
Comment.create!(body: 'An infinite number of mathematicians walk into a bar. The first says, "I\'ll have a beer." The second says, "I\'ll have half a beer." The third says, "I\'ll have a quarter of a beer." And so on. The bartender pours two beers and says, "You guys need to know your limits."', author_id: 4, post_id: 1) # id: 3
Comment.create!(body: 'I think I just learned something about math...', author_id: 2, post_id: 1, parent_comment_id: 3) # id: 4
Comment.create!(body: 'I have the heart of a lion and a lifetime ban from the Bronx Zoo.', author_id: 5, post_id: 1) # id: 5
Comment.create!(body: 'I just read a book about Stockholm Syndrome. It was pretty bad at first, but, by the end, I liked it.', author_id: 3, post_id: 1) # id: 6
Comment.create!(body: 'A blind man walks into a bar. And a table. And a chair.', author_id: 5, post_id: 1) # id: 7
Comment.create!(body: 'A man walks into a bar. Then another man walks into it. The third man ducks.', author_id: 2, post_id: 1, parent_comment_id: 7) # id: 8
Comment.create!(body: 'Why did Star Wars episodes 4, 5, and 6 come before 1, 2, and 3? Because in charge of scheduling, Yoda was.', author_id: 4, post_id: 1)
