class Membership
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :tag, :password, :team

  def initialize(attributes = {})
    return if attributes.blank?

    @attrs = attributes.stringify_keys
    self.tag = @attrs['tag']
    self.password = @attrs['password']

    try_join
  end

  def persisted?
    false
  end

  private
  def try_join
    @candidate ||= Team.find_by_tag tag
    return if @candidate.nil?

    return unless @candidate.authenticate password

    self.team = @candidate
  end
end
