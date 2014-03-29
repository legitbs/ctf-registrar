Then 'my team should have the "$cheevo_name" achievement' do |cheevo_name|
  assert page.has_content?("Achievement Unlocked!")
  assert page.has_content?(cheevo_name)
end
