require 'csv'

class Achievement < ActiveRecord::Base
  belongs_to :trophy
  has_many :awards

  attr_accessible *%i{ name condition description image trophy }

  def self.seed
    CSV.foreach(Rails.root.join('db', 'seeds', 'cheevos.csv')) do |r|
      phase, name, condition, flavor, thumbnail, trophy = r

      next unless phase == 'Quals'

      cheevo = Achievement.where(name: name).first_or_create
      trophy = Trophy.where(name: trophy).first_or_create
      cheevo.update_attributes(
                               condition: condition,
                               description: flavor,
                               image: thumbnail,
                               trophy: trophy
                               )
    end
  end
end
