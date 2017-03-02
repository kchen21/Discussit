# == Schema Information
#
# Table name: subforums
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  description  :text
#  moderator_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Subforum < ApplicationRecord
  validates :title, :moderator, presence: true
  validates :title, uniqueness: true

  belongs_to(
    :moderator,
    primary_key: :id,
    foreign_key: :moderator_id,
    class_name: :User
  )

  has_many :posts
end
