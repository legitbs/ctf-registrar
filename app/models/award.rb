class Award < ActiveRecord::Base
  belongs_to :achievement
  belongs_to :team
  belongs_to :user

  attr_accessible *%i{ achievement team user comment }

  validates :achievement, uniqueness: { scope: :team }, presence: true
end
