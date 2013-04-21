class Challenge < ActiveRecord::Base
  belongs_to :category
  attr_accessible :answer_digest, :clue, :name, :points
end
