require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context 'a User' do
    setup do
      @user = FactoryGirl.build :user
    end

    should 'securely store passwords' do
      @user.password = 'asdf'
      @user.save

      assert @user.authenticate 'asdf'
    end
  end
end
