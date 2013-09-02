ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase

  include Shoulda::Matchers::ActiveRecord
  extend Shoulda::Matchers::ActiveRecord
  include Shoulda::Matchers::ActiveModel
  extend Shoulda::Matchers::ActiveModel

  def be_during_game
    @controller.stubs(:during_game?).returns(true)
  end

  def be_before_game
    @controller.stubs(:before_game?).returns(true)
  end
end
