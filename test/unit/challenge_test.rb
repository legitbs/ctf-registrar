require 'test_helper'

class ChallengeTest < ActiveSupport::TestCase
  context 'a Challenge' do
    setup do
      @challenge = FactoryGirl.build :challenge
    end

    should belong_to :category

    should 'validate answers' do
      assert @challenge.correct_answer? 'password'
      assert !@challenge.correct_answer?('password1')
    end
  end
end
