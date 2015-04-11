class User < ActiveRecord::Base
  belongs_to :team
  has_one :owned_team, class_name: 'Team'
  has_many :fallback_tokens
  has_many :resets
  has_many :awards

  has_secure_password

  validates :username, :email, presence: true, uniqueness: true
  validates(:email, confirmation: true,
    email_format: { message: "should look like an email address" })
  validate :owned_team_and_team_must_match

  def owner?
    participant? && (owned_team == team)
  end

  def participant?
    team && team.is_a?(Team) && team.persisted?
  end

  def self.search(text)
    where  "to_tsvector('english', username || ' ' || email) @@ to_tsquery('english', ?)", text
  end

  private
  def owned_team_and_team_must_match
    return unless participant?
    return if owned_team.nil?
    return if owned_team == team
    errors.add :owned_team, "must be the same as the participant team"
  end
end
