require 'test_helper'

class ResetTest < ActiveSupport::TestCase
  context 'a User' do
    should 'be able to create a reset token'
    should 'be able to disavow a reset token'
  end

  context 'a Reset' do
    setup do
      @reset = create :reset
    end
    should 'have a token' do
      assert @reset.token
      assert_instance_of String, @reset.token
      assert_match /^1100\w{48}/, @reset.token
    end
    should 'be findable by reset token' do
      token = @reset.token
      found_reset = Reset.find_by_token token
      assert_equal @reset, found_reset
    end
    
    should 'change a password' do
      user = @reset.user
      token = @reset.token
      
      assert user.authenticate 'new york'
      assert Reset.change_password! token, 'seattle', 'seattle'

      user.reload
      assert user.authenticate 'seattle'
    end
    
    should 'expire' do
      @reset.created_at = 
        @reset.updated_at = 
        (Reset::EXPIRATION + 1.day).ago
      @reset.save

      assert_raises RuntimeError do
        @reset.change_password! 'asdf', 'asdf'
      end
      assert @reset.user.authenticate 'new york'
    end
  end
end
