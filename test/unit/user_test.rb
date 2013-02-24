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

    should 'not accept ugly emails' do
      @user.email = "bkerley+<html>@brycekerley.net"
      refute @user.save
      assert_not_empty @user.errors
    end
  end
end
