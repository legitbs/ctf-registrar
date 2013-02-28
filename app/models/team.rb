class Team < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :password

  has_secure_password

  validates :name, presence: true, uniqueness: true, length: {minimum: 4, maximum: 60}
end
