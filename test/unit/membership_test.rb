require 'test_helper'

class MembershipTest < ActiveSupport::TestCase
  context 'with a Team' do
    setup do
      @team = FactoryGirl.create :team
    end

    should 'join a team with a name and password' do
      @membership = Membership.new name: @team.name, password: 'kenny'

      assert_equal @team, @membership.team
    end
  end
end
