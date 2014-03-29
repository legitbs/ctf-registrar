Then 'my team should have the "$cheevo_name" achievement' do |cheevo_name|
  assert @user.reload.team.achievements.where(name: cheevo_name).first
end
