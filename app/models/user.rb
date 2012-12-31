class User < ActiveRecord::Base
  belongs_to :team
  attr_accessible :password_digest, :username
end
