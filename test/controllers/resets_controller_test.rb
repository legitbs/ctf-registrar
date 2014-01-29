require 'test_helper'

class ResetsControllerTest < ActionController::TestCase
  context 'when logged out' do
    context 'without a reset url' do
      should 'show the start reset form'
      should 'send a reset url'
    end
    context 'with a reset url' do
      should 'show the reset password form'
      should 'reset the password'
    end
  end
  context 'when logged in' do
    should 'list tokens'
    should 'disavow tokens'
  end
end
