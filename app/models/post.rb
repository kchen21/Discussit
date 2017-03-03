# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  url         :string
#  body        :text             not null
#  subforum_id :integer          not null
#  author_id   :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Post < ApplicationRecord
  include Votable

  validates :title, :body, :subforum, :author, presence: true
  validates :title, uniqueness: true

  belongs_to :subforum

  belongs_to(
    :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User
  )

  has_many :comments

  def comments_grouped_by_parent
    comments_grouped_by_parent = Hash.new { |hash, key| hash[key]= [] }

    self.comments.includes(:author).each do |comment|
      comments_grouped_by_parent[comment.parent_comment_id] << comment
    end

    comments_grouped_by_parent
  end
end
