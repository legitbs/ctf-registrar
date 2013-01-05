require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  context 'a Team' do
    setup do
      @team = FactoryGirl.build :team
    end

    should belong_to :user
    should ensure_length_of :tag
    should validate_presence_of :tag
    should validate_presence_of :name
    should validate_uniqueness_of :tag
    should validate_presence_of :name

    should 'securely store passwords' do
      @team.password = 'asdf'
      @team.save

      assert @team.authenticate 'asdf'
    end
  end
end
