class Membership
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :password, :team

  def initialize(attributes = {})
    return if attributes.blank?

    @attrs = attributes.stringify_keys
    self.name = @attrs['name']
    self.password = @attrs['password']

    try_join
  end

  def persisted?
    false
  end

  private
  def try_join
    @candidate ||= Team.find_by_name name
    return if @candidate.nil?

    return unless @candidate.authenticate password

    self.team = @candidate
  end
end
