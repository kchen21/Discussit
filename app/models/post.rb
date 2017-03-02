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
end
