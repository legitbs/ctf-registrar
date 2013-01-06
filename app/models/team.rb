class Team < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :password, :tag

  has_secure_password

  validates :name, presence: true, uniqueness: true, length: {minimum: 4}
  validates :tag, presence: true, uniqueness: true, length: {minimum: 2, maximum: 4}
end
