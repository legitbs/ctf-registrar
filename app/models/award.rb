class Award < ActiveRecord::Base
  belongs_to :achievement
  belongs_to :team
  belongs_to :user

  validates :achievement, uniqueness: { scope: :team }, presence: true
end
