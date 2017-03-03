# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  body              :text             not null
#  author_id         :integer          not null
#  post_id           :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  parent_comment_id :integer
#

class Comment < ApplicationRecord
  include Votable

  validates :body, :author, :post, presence:true

  belongs_to(
    :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User
  )

  belongs_to :post

  has_one(
    :subforum,
    through: :post,
    source: :subforum
  )

  has_many(
    :child_comments,
    primary_key: :id,
    foreign_key: :parent_comment_id,
    class_name: :Comment
  )

  belongs_to(
    :parent_comment,
    primary_key: :id,
    foreign_key: :parent_comment_id,
    class_name: :Comment
  )

  def create_preview
    if self.body.length > 100
      return self.body[0..99] + "..."
    else
      return self.body
    end
  end
end
