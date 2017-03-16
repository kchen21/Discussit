# Discussit

[Discussit live][heroku]

[heroku]: http://discussitonline.herokuapp.com

Discussit is a simple forum for discussion built using Ruby on Rails. It uses a PostgreSQL database to store data.

## Features and Implementation

## Auth

Discussit features custom user authentication. When an account is created, an `id`, `first_name`, `last_name`, `email`, `username`, `password_digest`, and `session_token` are stored in the database. Then, when the user logs in, his/her `session_token` gets reset, and the session token of the current session (`session[:session_token]`) is assigned to it.

The BCrypt gem has been used to create a `password_digest` that is stored instead of the password itself. When a user logs in, BCrypt handles password verification.

## Subforums, Posts, and Comments

Discussit is a forum for discussion made up of subforums, posts, and comments. When a user logs in, he/she will be brought to the subforums index page. The subforums index page contains links to each subforum, and a link to create a new subforum.

Upon visiting a subforum, a user can find the link to edit its title and description, and a list of all posts that the subforum contains along with a link to create a new post.

When a user clicks on a post, he/she will be able to see all the comments that he/she and others have made in response to it. Users can respond to each other's comments after clicking on them to view them, and responses to comments are shown as nested comments on the post's page. If the user wants to respond to the post itself, he/she can click on the link to write a new comment.

While obvious, it is worth noting that users can't edit posts and comments that are not their own. However, a subforum's creator (i.e. moderator) can delete a post within it regardless of who it belongs to.

The creating, reading, updating, and deleting of the database's subforum, post, and comment information is all handled using RESTful routes. One major optimization to note is that N+1 queries for comments and their respective authors have been eliminated using a single GET request of all comments and eager loading. The Post model contains the following method, which returns a hash of all comments, grouped by parent:

```ruby
def comments_grouped_by_parent
  comments_grouped_by_parent = Hash.new { |hash, key| hash[key]= [] }

  self.comments.includes(:author).each do |comment|
    comments_grouped_by_parent[comment.parent_comment_id] << comment
  end

  comments_grouped_by_parent
end
```

In the Posts show page view, the hash is used for constant time lookup of comment information, instead of a recursive approach filled with N+1 database queries to find the responses to a post and each of its comments and sub-comments.

## Voting

Users can vote on posts or comments. Since a vote can belong to a post or a comment, I created a simple polymorphic association, which I added to a concern so that it can run at class definition time within the Post and Comment models.
